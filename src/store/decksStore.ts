import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Deck, Example, Word } from "../types";
import {
  MAX_DECK_DESCRIPTION_LEN,
  MAX_DECK_NAME_LEN,
  MAX_ETYMOLOGY_LEN,
  MAX_HEADWORD_LEN,
  MAX_IMPORT_ROWS,
  MAX_MEANING_LEN,
  MAX_POS_LEN,
  MAX_READING_LEN,
  sanitizeSingleLine,
  sanitizeText,
} from "../lib/validation";

/**
 * 통합 데이터 스토어.
 * - 항상 `decks`/`words` 평면 배열로 보유 (공식 + 커스텀 모두 포함)
 * - ID는 항상 UUID(`crypto.randomUUID()` 또는 Supabase 가 발급한 값)
 * - mutations 는 동기 (즉시 로컬 반영), 동기화는 useDecksSync 가 담당
 */
interface DecksState {
  decks: Deck[];
  words: Word[];
  loaded: boolean;

  /** sync hook 또는 boot 단계에서 사용. 전체 교체. */
  hydrate: (decks: Deck[], words: Word[]) => void;
  setLoaded: (v: boolean) => void;

  /** 헬퍼 selectors */
  allDecks: () => Deck[];
  allWords: () => Word[];
  wordsByDeck: (deckId: string) => Word[];

  /** mutations (custom decks/words 만 변경) */
  createDeck: (
    name: string,
    description?: string,
    ownerId?: string,
  ) => Deck;
  deleteDeck: (deckId: string) => void;
  renameDeck: (deckId: string, name: string) => void;
  addWord: (
    deckId: string,
    word: {
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
      examples?: Example[];
    },
  ) => Word;
  bulkAddWords: (
    deckId: string,
    items: Array<{
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
    }>,
  ) => number;
  deleteWord: (wordId: string) => void;
}

const uuid = () =>
  typeof crypto !== "undefined" && crypto.randomUUID
    ? crypto.randomUUID()
    : `local-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 10)}`;

export const useDecksStore = create<DecksState>()(
  persist(
    (set, get) => ({
      decks: [],
      words: [],
      loaded: false,

      hydrate: (decks, words) => set({ decks, words, loaded: true }),
      setLoaded: (v) => set({ loaded: v }),

      allDecks: () => get().decks,
      allWords: () => get().words,
      wordsByDeck: (deckId) =>
        get().words.filter((w) => w.deck_id === deckId),

      createDeck: (name, description, ownerId) => {
        // 외부에서 호출하더라도 절대 신뢰하지 않고 sanitize 한다.
        const safeName =
          sanitizeSingleLine(name, MAX_DECK_NAME_LEN) || "이름 없는 단어장";
        const safeDescription = description
          ? sanitizeText(description, MAX_DECK_DESCRIPTION_LEN)
          : undefined;
        const deck: Deck = {
          id: uuid(),
          owner_id: ownerId ?? "local",
          name: safeName,
          jlpt_level: "custom",
          is_official: false,
          description: safeDescription || undefined,
        };
        set((s) => ({ decks: [...s.decks, deck] }));
        return deck;
      },

      deleteDeck: (deckId) =>
        set((s) => ({
          decks: s.decks.filter((d) => d.id !== deckId),
          words: s.words.filter((w) => w.deck_id !== deckId),
        })),

      renameDeck: (deckId, name) => {
        const safeName =
          sanitizeSingleLine(name, MAX_DECK_NAME_LEN) || "이름 없는 단어장";
        set((s) => ({
          decks: s.decks.map((d) =>
            d.id === deckId ? { ...d, name: safeName } : d,
          ),
        }));
      },

      addWord: (deckId, w) => {
        const reading = sanitizeText(w.reading, MAX_READING_LEN);
        const meaning = sanitizeText(w.meaning, MAX_MEANING_LEN);
        if (!reading || !meaning) {
          // 빈 단어는 추가하지 않음. 그래도 호출부의 타입 만족을 위해 빈 word 반환.
          return {
            id: uuid(),
            deck_id: deckId,
            headword: null,
            reading: "",
            meaning: "",
            order_index: 0,
            tags: [],
            examples: [],
          };
        }
        const headword = w.headword ? sanitizeText(w.headword, MAX_HEADWORD_LEN) : "";
        const etymology = w.etymology ? sanitizeText(w.etymology, MAX_ETYMOLOGY_LEN) : "";
        const pos = w.part_of_speech ? sanitizeText(w.part_of_speech, MAX_POS_LEN) : "";

        const existing = get().wordsByDeck(deckId).length;
        const word: Word = {
          id: uuid(),
          deck_id: deckId,
          headword: headword || null,
          reading,
          meaning,
          etymology: etymology || undefined,
          part_of_speech: pos || undefined,
          order_index: existing + 1,
          tags: [],
          examples: w.examples ?? [],
        };
        set((s) => ({ words: [...s.words, word] }));
        return word;
      },

      bulkAddWords: (deckId, items) => {
        const start = get().wordsByDeck(deckId).length;
        const limited = items.slice(0, MAX_IMPORT_ROWS);
        const created: Word[] = [];
        for (let i = 0; i < limited.length; i++) {
          const it = limited[i];
          const reading = sanitizeText(it.reading, MAX_READING_LEN);
          const meaning = sanitizeText(it.meaning, MAX_MEANING_LEN);
          if (!reading || !meaning) continue;
          const headword = it.headword
            ? sanitizeText(it.headword, MAX_HEADWORD_LEN)
            : "";
          const etymology = it.etymology
            ? sanitizeText(it.etymology, MAX_ETYMOLOGY_LEN)
            : "";
          const pos = it.part_of_speech
            ? sanitizeText(it.part_of_speech, MAX_POS_LEN)
            : "";
          created.push({
            id: uuid(),
            deck_id: deckId,
            headword: headword || null,
            reading,
            meaning,
            etymology: etymology || undefined,
            part_of_speech: pos || undefined,
            order_index: start + created.length + 1,
            tags: [],
            examples: [],
          });
        }
        set((s) => ({ words: [...s.words, ...created] }));
        return created.length;
      },

      deleteWord: (wordId) =>
        set((s) => ({ words: s.words.filter((w) => w.id !== wordId) })),
    }),
    {
      name: "jlpt-rpg-decks",
      // `loaded` 는 매 부트마다 다시 계산해야 한다.
      // (localStorage 에 stale 한 시드 ID (`local-w-X`) 가 남아 있는데
      // loaded=true 인 채로 보이면, useDecksSync 가 Supabase 에서
      // 새 UUID 를 받아오기 전에 사용자가 stale 카드를 클릭해
      // word_progress FK 제약 위반을 일으킨다.)
      partialize: (s) => ({ decks: s.decks, words: s.words }),
    },
  ),
);
