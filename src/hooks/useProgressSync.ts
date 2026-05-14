import { useEffect, useRef } from "react";
import {
  fetchAllPaginated,
  isSupabaseEnabled,
  supabase,
  type DbWordProgress,
} from "../lib/supabase";
import { useAuthStore } from "../store/authStore";
import { useDecksStore } from "../store/decksStore";
import { useProgressStore } from "../store/progressStore";
import type { WordProgress } from "../types";

// Postgres UUID v1-v5 형식. Supabase words.id 는 항상 이 형식이다.
// 로컬 시드의 `local-w-X` 같은 가짜 ID 를 걸러내기 위한 안전망.
const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

// 정리/동기화 진단 로그는 개발자용이므로 운영 환경에선 출력하지 않는다.
// (사용자가 콘솔을 열었을 때 정상 동작에서 경고가 보이지 않도록.)
const devLog = (...args: unknown[]) => {
  if (import.meta.env.DEV) console.debug(...args);
};

/**
 * 진행 상태 ↔ Supabase 동기화.
 *
 * 1. 로그인 시: word_progress 를 한 번 풀로 가져와 로컬 스토어를 덮어씀.
 * 2. 이후 로컬 스토어가 변할 때마다 변경된 row 만 골라 upsert.
 *
 * 로컬-온리 모드에서는 아무 일도 하지 않습니다.
 */
export function useProgressSync() {
  const userId = useAuthStore((s) => s.userId);
  const signedIn = useAuthStore((s) => s.signedIn);
  const ready = useAuthStore((s) => s.ready);

  const lastSyncedRef = useRef<Record<string, WordProgress>>({});
  const initialLoadDoneRef = useRef(false);
  // decks/progress 두 fetch 가 끝나는 순서가 매번 다르므로 어느 쪽이 먼저
  // 끝나도 동일하게 stale 정리를 트리거하기 위해 effect 사이에 공유한다.
  const cleanupRef = useRef<() => void>(() => {});

  /* 1. 초기 로드 */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId || !ready) {
      initialLoadDoneRef.current = false;
      lastSyncedRef.current = {};
      return;
    }

    let cancelled = false;
    const client = supabase;

    (async () => {
      // 모든 단어를 학습한 사용자는 word_progress 가 2,000 건을 넘을 수 있어
      // PostgREST 기본 limit(1,000) 에 걸리지 않도록 .range() 로 페이지네이션.
      const { data, error } = await fetchAllPaginated<DbWordProgress>(
        (from, to) =>
          client
            .from("word_progress")
            .select("*")
            .eq("user_id", userId)
            .range(from, to),
      );

      if (cancelled) return;

      if (error) {
        console.error("[supabase] failed to load word_progress:", error);
        initialLoadDoneRef.current = true;
        return;
      }

      const rows = data;
      const byWord: Record<string, WordProgress> = {};
      for (const row of rows) {
        byWord[row.word_id] = {
          word_id: row.word_id,
          mastery: row.mastery,
          flagged: row.flagged,
          last_seen_at: row.last_seen_at ?? undefined,
          mastered_at: row.mastered_at ?? undefined,
        };
      }

      useProgressStore.setState({ byWord });
      lastSyncedRef.current = { ...byWord };
      initialLoadDoneRef.current = true;
      // decks 가 먼저 hydrate 된 경우 1-b effect 는 이미 한 번 cleanupOnce 를
      // 시도했지만 initialLoadDoneRef=false 라서 skip 했을 수 있다.
      // progress 가 늦게 끝난 경우엔 여기서 직접 한 번 더 트리거한다.
      cleanupRef.current();
    })();

    return () => {
      cancelled = true;
    };
  }, [userId, signedIn, ready]);

  /* 1-b. decks hydrate 완료 시점에 stale 진행도 자동 정리.
   *
   * 첫 동기화 트리거를 학습 클릭에만 의존하면, 사용자가 아무 단어도
   * 학습하지 않아도 매 부팅마다 "DB 에 없는 word_id N개를 정리합니다"
   * 경고가 반복될 수 있다. decks 가 hydrate 되는 즉시 한 번 청소해 두면
   * 메시지가 깔끔하게 1회로 끝난다.
   */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId) {
      cleanupRef.current = () => {};
      return;
    }

    const cleanupOnce = () => {
      if (!initialLoadDoneRef.current) return;
      const decksState = useDecksStore.getState();
      if (!decksState.loaded) return;
      const known = new Set(decksState.words.map((w) => w.id));
      if (known.size === 0) return;
      const byWord = useProgressStore.getState().byWord;
      const stale = Object.keys(byWord).filter(
        (id) => !UUID_RE.test(id) || !known.has(id),
      );
      if (stale.length === 0) return;
      devLog(
        `[supabase] word_progress: hydrate 후 stale word_id ${stale.length}개 자동 정리. ids=`,
        stale,
      );
      useProgressStore.getState().removeWords(stale);
      for (const id of stale) delete lastSyncedRef.current[id];
    };

    cleanupRef.current = cleanupOnce;

    // hydrate 가 이미 끝난 상태라면 즉시 한 번 실행.
    cleanupOnce();

    // 아직 안 끝났다면 decks 변경을 구독해 loaded=true 가 되는 순간 정리.
    const unsubscribe = useDecksStore.subscribe(() => cleanupOnce());
    return () => {
      cleanupRef.current = () => {};
      unsubscribe();
    };
  }, [userId, signedIn]);

  /* 2. 변경 감지 → upsert */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId) return;
    const client = supabase;

    const unsubscribe = useProgressStore.subscribe((state) => {
      if (!initialLoadDoneRef.current) return;

      const next = state.byWord;
      const prev = lastSyncedRef.current;
      const changed: WordProgress[] = [];

      for (const [wordId, progress] of Object.entries(next)) {
        const old = prev[wordId];
        if (
          !old ||
          old.mastery !== progress.mastery ||
          old.flagged !== progress.flagged ||
          old.last_seen_at !== progress.last_seen_at
        ) {
          changed.push(progress);
        }
      }

      if (changed.length === 0) return;

      // 1차 필터: UUID 가 아닌 word_id (예: 로컬 시드 `local-w-X`) 는 DB 에
      // 존재할 수 없으므로 업서트 대상에서 제외한다.
      const uuidOnly = changed.filter((p) => UUID_RE.test(p.word_id));
      const nonUuidCount = changed.length - uuidOnly.length;
      if (nonUuidCount > 0) {
        devLog(
          `[supabase] word_progress 동기화에서 ${nonUuidCount}개의 비-UUID word_id 를 건너뜀 (로컬 시드 잔여 데이터로 추정).`,
        );
      }

      // 2차 필터: 현재 hydrate 된 단어 집합과 대조해 죽은 참조를 차단.
      // 시드 재실행이나 단어 삭제로 인해 progressStore 에 stale 한 UUID 가
      // 남아 있으면 FK 제약 23503 이 발생하므로, 사전에 거르고 로컬에서도
      // 제거해 같은 에러가 매 변경마다 반복되지 않게 한다.
      // (decks 가 아직 hydrate 되지 않은 동안에는 false positive 방지를 위해
      //  정리를 건너뛴다.)
      const decksLoaded = useDecksStore.getState().loaded;
      const knownWordIds = decksLoaded
        ? new Set(useDecksStore.getState().words.map((w) => w.id))
        : null;

      let validChanged = uuidOnly;
      if (knownWordIds) {
        const stale: string[] = [];
        const fresh: WordProgress[] = [];
        for (const p of uuidOnly) {
          if (knownWordIds.has(p.word_id)) fresh.push(p);
          else stale.push(p.word_id);
        }
        if (stale.length > 0) {
          devLog(
            `[supabase] word_progress: DB 에 없는 word_id ${stale.length}개를 정리합니다 (이전 시드/삭제된 단어 잔여 데이터). ids=`,
            stale,
          );
          useProgressStore.getState().removeWords(stale);
          for (const id of stale) delete lastSyncedRef.current[id];
        }
        validChanged = fresh;
      }

      if (validChanged.length === 0) return;

      const rows: DbWordProgress[] = validChanged.map((p) => ({
        user_id: userId,
        word_id: p.word_id,
        mastery: p.mastery,
        flagged: p.flagged,
        last_seen_at: p.last_seen_at ?? null,
        mastered_at: p.mastered_at ?? null,
      }));

      client
        .from("word_progress")
        .upsert(rows, { onConflict: "user_id,word_id" })
        .then(({ error }) => {
          if (error) {
            // 23503 (FK 위반): 사전 필터링을 통과했지만 다른 디바이스에서
            // 단어가 삭제되었거나 시드 재실행과 겹친 race condition.
            // 현재 hydrate 된 단어 집합으로 byWord 전체를 다시 동기화하여
            // 죽은 참조를 모두 제거한다.
            if (error.code === "23503") {
              const known = new Set(
                useDecksStore.getState().words.map((w) => w.id),
              );
              if (known.size > 0) {
                const drop = Object.keys(
                  useProgressStore.getState().byWord,
                ).filter((id) => !known.has(id));
                if (drop.length > 0) {
                  devLog(
                    `[supabase] word_progress FK 위반 후 정리: ${drop.length}개의 죽은 word_id 제거.`,
                  );
                  useProgressStore.getState().removeWords(drop);
                  for (const id of drop) delete lastSyncedRef.current[id];
                  return;
                }
              }
            }
            console.error("[supabase] upsert word_progress failed:", error);
          } else {
            for (const p of validChanged) {
              lastSyncedRef.current[p.word_id] = p;
            }
          }
        });
    });

    return () => unsubscribe();
  }, [userId, signedIn]);
}
