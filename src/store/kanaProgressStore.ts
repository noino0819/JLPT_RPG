import { create } from "zustand";
import { persist } from "zustand/middleware";

// 카나 학습 진행 상태.
// - mastered: 완벽히 외움 카운트 (퀴즈/플래시카드 모두 합산)
// - wrong: 틀린 카운트 (퀴즈 전용)
// - last_seen_at: 가장 최근 노출 시각 (ISO)
// 진행도는 로컬에만 저장. (단어 학습과 달리 서버 동기화 X — 가볍게 유지)
export interface KanaStat {
  mastered: number;
  wrong: number;
  last_seen_at?: string;
}

interface KanaProgressState {
  byChar: Record<string, KanaStat>;
  /** 마스터 카운트를 1 증가. */
  markMastered: (id: string) => void;
  /** 틀린 카운트를 1 증가. */
  markWrong: (id: string) => void;
  /** 노출만 기록 (스킵 등). */
  touch: (id: string) => void;
  reset: () => void;
}

const emptyStat = (): KanaStat => ({ mastered: 0, wrong: 0 });

export const useKanaProgressStore = create<KanaProgressState>()(
  persist(
    (set) => ({
      byChar: {},
      markMastered: (id) =>
        set((s) => {
          const prev = s.byChar[id] ?? emptyStat();
          return {
            byChar: {
              ...s.byChar,
              [id]: {
                ...prev,
                mastered: prev.mastered + 1,
                last_seen_at: new Date().toISOString(),
              },
            },
          };
        }),
      markWrong: (id) =>
        set((s) => {
          const prev = s.byChar[id] ?? emptyStat();
          return {
            byChar: {
              ...s.byChar,
              [id]: {
                ...prev,
                wrong: prev.wrong + 1,
                last_seen_at: new Date().toISOString(),
              },
            },
          };
        }),
      touch: (id) =>
        set((s) => {
          const prev = s.byChar[id] ?? emptyStat();
          return {
            byChar: {
              ...s.byChar,
              [id]: { ...prev, last_seen_at: new Date().toISOString() },
            },
          };
        }),
      reset: () => set({ byChar: {} }),
    }),
    { name: "jlpt-rpg-kana-progress" },
  ),
);

// 마스터 정도(0~3 단계)를 계산하는 헬퍼.
// - 0: 한 번도 안 풀어봤거나 모름
// - 1: 1~2회 성공
// - 2: 3~4회 성공
// - 3: 5회 이상 성공 + 최근 오답이 적음
export function kanaMasteryLevel(stat?: KanaStat): 0 | 1 | 2 | 3 {
  if (!stat) return 0;
  const score = stat.mastered - stat.wrong * 0.6;
  if (score >= 5) return 3;
  if (score >= 3) return 2;
  if (score >= 1) return 1;
  return 0;
}
