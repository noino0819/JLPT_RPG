import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Mastery, WordProgress } from "../types";

interface ProgressState {
  byWord: Record<string, WordProgress>;
  setMastery: (wordId: string, mastery: Mastery) => void;
  toggleFlag: (wordId: string) => void;
  touch: (wordId: string) => void;
  /** 죽은 참조(예: 삭제된 단어 / 시드 재실행 후 stale UUID) 정리용 */
  removeWords: (wordIds: string[]) => void;
  reset: () => void;
}

export const useProgressStore = create<ProgressState>()(
  persist(
    (set) => ({
      byWord: {},
      setMastery: (wordId, mastery) =>
        set((s) => {
          const existing = s.byWord[wordId];
          const next: WordProgress = {
            word_id: wordId,
            mastery,
            flagged: existing?.flagged ?? false,
            last_seen_at: new Date().toISOString(),
            mastered_at:
              mastery === "mastered"
                ? new Date().toISOString()
                : existing?.mastered_at,
          };
          return { byWord: { ...s.byWord, [wordId]: next } };
        }),
      toggleFlag: (wordId) =>
        set((s) => {
          const existing = s.byWord[wordId];
          const next: WordProgress = {
            word_id: wordId,
            mastery: existing?.mastery ?? "none",
            flagged: !(existing?.flagged ?? false),
            last_seen_at: new Date().toISOString(),
            mastered_at: existing?.mastered_at,
          };
          return { byWord: { ...s.byWord, [wordId]: next } };
        }),
      touch: (wordId) =>
        set((s) => {
          const existing = s.byWord[wordId];
          const next: WordProgress = {
            word_id: wordId,
            mastery: existing?.mastery ?? "none",
            flagged: existing?.flagged ?? false,
            last_seen_at: new Date().toISOString(),
            mastered_at: existing?.mastered_at,
          };
          return { byWord: { ...s.byWord, [wordId]: next } };
        }),
      removeWords: (wordIds) =>
        set((s) => {
          if (wordIds.length === 0) return s;
          const next = { ...s.byWord };
          let changed = false;
          for (const id of wordIds) {
            if (id in next) {
              delete next[id];
              changed = true;
            }
          }
          return changed ? { byWord: next } : s;
        }),
      reset: () => set({ byWord: {} }),
    }),
    { name: "jlpt-rpg-progress" },
  ),
);
