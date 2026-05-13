import { create } from "zustand";
import { persist } from "zustand/middleware";

export type JlptLevel = "N5" | "N4" | "N3" | "N2" | "N1";

interface PlayerState {
  name: string;
  level: number;
  exp: number;
  expToNext: number;
  hp: number;
  maxHp: number;
  attack: number;
  gold: number;
  currentJlptLevel: JlptLevel;
  learnedWordIds: string[];

  setName: (name: string) => void;
  setJlptLevel: (level: JlptLevel) => void;
  gainExp: (amount: number) => void;
  takeDamage: (amount: number) => void;
  heal: (amount: number) => void;
  addGold: (amount: number) => void;
  markWordLearned: (wordId: string) => void;
  reset: () => void;
}

const INITIAL: Omit<
  PlayerState,
  | "setName"
  | "setJlptLevel"
  | "gainExp"
  | "takeDamage"
  | "heal"
  | "addGold"
  | "markWordLearned"
  | "reset"
> = {
  name: "見習い (수련생)",
  level: 1,
  exp: 0,
  expToNext: 20,
  hp: 30,
  maxHp: 30,
  attack: 6,
  gold: 0,
  currentJlptLevel: "N5",
  learnedWordIds: [],
};

export const usePlayerStore = create<PlayerState>()(
  persist(
    (set, get) => ({
      ...INITIAL,
      setName: (name) => set({ name }),
      setJlptLevel: (currentJlptLevel) => set({ currentJlptLevel }),
      gainExp: (amount) => {
        let { exp, expToNext, level, maxHp, attack, hp } = get();
        exp += amount;
        while (exp >= expToNext) {
          exp -= expToNext;
          level += 1;
          expToNext = Math.round(expToNext * 1.4);
          maxHp += 8;
          attack += 2;
          hp = maxHp;
        }
        set({ exp, expToNext, level, maxHp, attack, hp });
      },
      takeDamage: (amount) =>
        set((s) => ({ hp: Math.max(0, s.hp - amount) })),
      heal: (amount) =>
        set((s) => ({ hp: Math.min(s.maxHp, s.hp + amount) })),
      addGold: (amount) => set((s) => ({ gold: s.gold + amount })),
      markWordLearned: (wordId) =>
        set((s) =>
          s.learnedWordIds.includes(wordId)
            ? s
            : { learnedWordIds: [...s.learnedWordIds, wordId] },
        ),
      reset: () => set({ ...INITIAL }),
    }),
    { name: "jlpt-rpg-player" },
  ),
);
