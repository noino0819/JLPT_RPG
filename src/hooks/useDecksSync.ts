import { useEffect, useRef } from "react";
import {
  fetchAllPaginated,
  isSupabaseEnabled,
  supabase,
  type DbDeck,
  type DbExample,
  type DbWord,
  type DbWordRelation,
} from "../lib/supabase";
import { useAuthStore } from "../store/authStore";
import { useDecksStore } from "../store/decksStore";
import { OFFICIAL_DECKS, OFFICIAL_WORDS } from "../data/seed";
import type { Deck, Example, RelatedWord, Word } from "../types";

/**
 * 덱/단어 ↔ Supabase 동기화.
 *
 * 동작:
 * 1. 로컬 모드: 시드(OFFICIAL_DECKS/WORDS)와 영속화된 커스텀을 머지하여 hydrate.
 * 2. Supabase 모드: 로그인 시 DB 에서 덱/단어/예문 풀로드 후 hydrate.
 *    이후 store 변경을 감지해 추가/삭제된 커스텀 row 만 골라 동기화.
 */
export function useDecksSync() {
  const userId = useAuthStore((s) => s.userId);
  const signedIn = useAuthStore((s) => s.signedIn);
  const ready = useAuthStore((s) => s.ready);

  const initialLoadDoneRef = useRef(false);
  const lastDeckIdsRef = useRef<Set<string>>(new Set());
  const lastWordIdsRef = useRef<Set<string>>(new Set());

  /* 1. Hydrate */
  useEffect(() => {
    if (!ready) return;

    initialLoadDoneRef.current = false;

    if (!isSupabaseEnabled || !supabase) {
      // 로컬 모드: 시드 + 영속화된 커스텀 머지
      const persisted = useDecksStore.getState();
      const customDecks = persisted.decks.filter((d) => !d.is_official);
      const customDeckIds = new Set(customDecks.map((d) => d.id));
      const customWords = persisted.words.filter((w) =>
        customDeckIds.has(w.deck_id),
      );

      useDecksStore.getState().hydrate(
        [...OFFICIAL_DECKS, ...customDecks],
        [...OFFICIAL_WORDS, ...customWords],
      );

      lastDeckIdsRef.current = new Set(
        customDecks.map((d) => d.id),
      );
      lastWordIdsRef.current = new Set(customWords.map((w) => w.id));
      initialLoadDoneRef.current = true;
      return;
    }

    if (!signedIn || !userId) {
      // 로그인 전엔 비움
      useDecksStore.getState().hydrate([], []);
      return;
    }

    let cancelled = false;
    const client = supabase;

    // Supabase 데이터가 도착할 때까지 StudyPage 등에서 로딩 화면을 표시한다.
    // (persist 로 복원된 stale 시드 단어(`local-w-X`) 를 사용자가 클릭하지
    // 못하도록 막아 word_progress FK 위반을 예방.)
    useDecksStore.getState().setLoaded(false);

    (async () => {
      // PostgREST 기본 limit 이 1,000 rows 이므로 .range() 로 페이지네이션.
      // (words/examples 합쳐 약 7,000 rows 가 있어서 limit 에 걸리면
      //  N3 같은 일부 덱이 통째로 누락된 채 hydrate 되는 버그가 발생.)
      const [decksRes, wordsRes, examplesRes, relationsRes] = await Promise.all([
        client.from("decks").select("*"),
        fetchAllPaginated<DbWord>((from, to) =>
          client.from("words").select("*").range(from, to),
        ),
        fetchAllPaginated<DbExample>((from, to) =>
          client.from("examples").select("*").range(from, to),
        ),
        fetchAllPaginated<DbWordRelation>((from, to) =>
          client.from("word_relations").select("*").range(from, to),
        ),
      ]);

      if (cancelled) return;

      if (
        decksRes.error ||
        wordsRes.error ||
        examplesRes.error ||
        relationsRes.error
      ) {
        console.error(
          "[supabase] failed to load decks/words/examples/relations:",
          decksRes.error ||
            wordsRes.error ||
            examplesRes.error ||
            relationsRes.error,
        );
        // fetch 실패 시 persist 로 복원된 stale 단어를 그대로 노출하면
        // 사용자가 죽은 word_id 를 학습해 word_progress FK 위반(23503) 이
        // 발생한다. 빈 상태로 hydrate 해서 StudyPage 등이 "단어 없음" 화면을
        // 보이도록 한다 (재시도는 다음 라우팅/새로고침에서).
        useDecksStore.getState().hydrate([], []);
        return;
      }

      const dbDecks = (decksRes.data ?? []) as DbDeck[];
      const dbWords = wordsRes.data;
      const dbExamples = examplesRes.data;
      const dbRelations = relationsRes.data;

      const examplesByWord = new Map<string, Example[]>();
      for (const ex of dbExamples) {
        const list = examplesByWord.get(ex.word_id) ?? [];
        list.push({
          id: ex.id,
          word_id: ex.word_id,
          jp_sentence: ex.jp_sentence,
          kr_translation: ex.kr_translation,
          furigana: ex.furigana ?? undefined,
          order_index: ex.order_index,
        });
        examplesByWord.set(ex.word_id, list);
      }

      // 단어 id 로 빠르게 찾기 위한 인덱스
      const wordById = new Map<string, DbWord>();
      for (const w of dbWords) wordById.set(w.id, w);

      // word_id → 관련 표현 목록 (해당 word 입장에서의 관계만 모음)
      const relationsByWord = new Map<string, RelatedWord[]>();
      for (const r of dbRelations) {
        const related = wordById.get(r.related_word_id);
        if (!related) continue; // 끊긴 참조 방어
        const list = relationsByWord.get(r.word_id) ?? [];
        list.push({
          relation_type: r.relation_type,
          explanation: r.explanation ?? undefined,
          word: {
            id: related.id,
            headword: related.headword,
            reading: related.reading,
            meaning: related.meaning,
            etymology: related.etymology ?? undefined,
            part_of_speech: related.part_of_speech ?? undefined,
            examples: (examplesByWord.get(related.id) ?? []).sort(
              (a, b) => a.order_index - b.order_index,
            ),
          },
        });
        relationsByWord.set(r.word_id, list);
      }

      const decks: Deck[] = dbDecks.map((d) => ({
        id: d.id,
        owner_id: d.owner_id,
        name: d.name,
        jlpt_level: d.jlpt_level,
        is_official: d.is_official,
        description: d.description ?? undefined,
      }));

      const words: Word[] = dbWords.map((w) => ({
        id: w.id,
        deck_id: w.deck_id,
        headword: w.headword,
        reading: w.reading,
        meaning: w.meaning,
        etymology: w.etymology ?? undefined,
        part_of_speech: w.part_of_speech ?? undefined,
        order_index: w.order_index,
        tags: w.tags ?? [],
        examples: (examplesByWord.get(w.id) ?? []).sort(
          (a, b) => a.order_index - b.order_index,
        ),
        related: relationsByWord.get(w.id),
      }));

      useDecksStore.getState().hydrate(decks, words);

      lastDeckIdsRef.current = new Set(
        decks.filter((d) => !d.is_official).map((d) => d.id),
      );
      lastWordIdsRef.current = new Set(
        words
          .filter((w) => {
            const deck = decks.find((d) => d.id === w.deck_id);
            return deck && !deck.is_official;
          })
          .map((w) => w.id),
      );
      initialLoadDoneRef.current = true;
    })();

    return () => {
      cancelled = true;
    };
  }, [ready, signedIn, userId]);

  /* 2. 변경 감지 → Supabase 로 동기화 (Supabase 모드 한정) */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId) return;
    const client = supabase;

    const unsubscribe = useDecksStore.subscribe((state) => {
      if (!initialLoadDoneRef.current) return;

      const officialDeckIds = new Set(
        state.decks.filter((d) => d.is_official).map((d) => d.id),
      );

      // 현재 커스텀 ID 집합
      const curDecks = state.decks.filter((d) => !d.is_official);
      const curDeckIds = new Set(curDecks.map((d) => d.id));
      const curWords = state.words.filter(
        (w) => !officialDeckIds.has(w.deck_id),
      );
      const curWordIds = new Set(curWords.map((w) => w.id));

      const prevDeckIds = lastDeckIdsRef.current;
      const prevWordIds = lastWordIdsRef.current;

      const newDecks = curDecks.filter((d) => !prevDeckIds.has(d.id));
      const deletedDeckIds = [...prevDeckIds].filter(
        (id) => !curDeckIds.has(id),
      );
      const newWords = curWords.filter((w) => !prevWordIds.has(w.id));
      const deletedWordIds = [...prevWordIds].filter(
        (id) => !curWordIds.has(id),
      );

      if (
        newDecks.length === 0 &&
        deletedDeckIds.length === 0 &&
        newWords.length === 0 &&
        deletedWordIds.length === 0
      ) {
        return;
      }

      (async () => {
        if (newDecks.length > 0) {
          const rows = newDecks.map((d) => ({
            id: d.id,
            owner_id: userId,
            name: d.name,
            jlpt_level: d.jlpt_level,
            is_official: false,
            is_public: false,
            description: d.description ?? null,
          }));
          const { error } = await client.from("decks").insert(rows);
          if (error) {
            console.error("[supabase] insert decks failed:", error);
            return;
          }
        }
        if (deletedDeckIds.length > 0) {
          const { error } = await client
            .from("decks")
            .delete()
            .in("id", deletedDeckIds);
          if (error) {
            console.error("[supabase] delete decks failed:", error);
            return;
          }
        }
        if (newWords.length > 0) {
          const rows = newWords.map((w) => ({
            id: w.id,
            deck_id: w.deck_id,
            headword: w.headword,
            reading: w.reading,
            meaning: w.meaning,
            etymology: w.etymology ?? null,
            part_of_speech: w.part_of_speech ?? null,
            order_index: w.order_index,
            tags: w.tags ?? [],
          }));
          const { error } = await client.from("words").insert(rows);
          if (error) {
            console.error("[supabase] insert words failed:", error);
            return;
          }
        }
        if (deletedWordIds.length > 0) {
          const { error } = await client
            .from("words")
            .delete()
            .in("id", deletedWordIds);
          if (error) {
            console.error("[supabase] delete words failed:", error);
            return;
          }
        }

        lastDeckIdsRef.current = curDeckIds;
        lastWordIdsRef.current = curWordIds;
      })();
    });

    return () => unsubscribe();
  }, [signedIn, userId]);
}
