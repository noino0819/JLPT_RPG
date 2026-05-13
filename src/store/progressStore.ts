import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Mastery, WordProgress } from "../types";

interface ProgressState {
  byWord: Record<string, WordProgress>;
  setMastery: (wordId: string, mastery: Mastery) => void;
  toggleFlag: (wordId: string) => void;
  touch: (wordId: string) => void;
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
      reset: () => set({ byWord: {} }),
    }),
    { name: "jlpt-rpg-progress" },
  ),
);
