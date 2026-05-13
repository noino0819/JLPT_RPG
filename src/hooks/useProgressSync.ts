import { useEffect, useRef } from "react";
import {
  isSupabaseEnabled,
  supabase,
  type DbWordProgress,
} from "../lib/supabase";
import { useAuthStore } from "../store/authStore";
import { useProgressStore } from "../store/progressStore";
import type { WordProgress } from "../types";

// Postgres UUID v1-v5 형식. Supabase words.id 는 항상 이 형식이다.
// 로컬 시드의 `local-w-X` 같은 가짜 ID 를 걸러내기 위한 안전망.
const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

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
      const { data, error } = await client
        .from("word_progress")
        .select("*")
        .eq("user_id", userId);

      if (cancelled) return;

      if (error) {
        console.error("[supabase] failed to load word_progress:", error);
        initialLoadDoneRef.current = true;
        return;
      }

      const rows = (data ?? []) as DbWordProgress[];
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
    })();

    return () => {
      cancelled = true;
    };
  }, [userId, signedIn, ready]);

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

      // UUID 가 아닌 word_id (예: 로컬 시드 `local-w-X`) 는 DB 에 존재할 수
      // 없으므로 FK 위반을 막기 위해 업서트 대상에서 제외한다.
      const validChanged = changed.filter((p) => UUID_RE.test(p.word_id));
      const skipped = changed.length - validChanged.length;
      if (skipped > 0) {
        console.warn(
          `[supabase] word_progress 동기화에서 ${skipped}개의 비-UUID word_id 를 건너뜀 (로컬 시드 잔여 데이터로 추정).`,
        );
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
