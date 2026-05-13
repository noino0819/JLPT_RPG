import { create } from "zustand";
import { persist } from "zustand/middleware";

// 카나 학습 진행 상태.
// - mastered: 플래시카드 "외웠음" 카운트 (자기보고 → 1점/회)
// - quiz_correct: 퀴즈 정답 카운트 (4지선다라 찍어서 맞을 수 있어 0.6점/회)
// - wrong: 퀴즈 오답 카운트 (-0.6점/회)
// - last_seen_at: 가장 최근 노출 시각 (ISO)
// 진행도는 로컬에만 저장. (단어 학습과 달리 서버 동기화 X — 가볍게 유지)
export interface KanaStat {
  mastered: number;
  quiz_correct: number;
  wrong: number;
  last_seen_at?: string;
}

interface KanaProgressState {
  byChar: Record<string, KanaStat>;
  /** 플래시카드 "외웠음" — 자기보고이므로 1점 가중치 (3회 → 통달, 5회 → 마스터). */
  markMastered: (id: string) => void;
  /** 퀴즈 정답 — 찍어서 맞출 수 있으므로 0.6점 가중치 (5회 누적 → 통달). */
  markQuizCorrect: (id: string) => void;
  /** 틀린 카운트를 1 증가. */
  markWrong: (id: string) => void;
  /** 노출만 기록 (스킵 등). */
  touch: (id: string) => void;
  reset: () => void;
}

// 영속화된 과거 데이터에 새 필드(quiz_correct)가 없을 수 있고,
// 처음 보는 글자도 안전하게 0으로 초기화되어야 하므로 단일 헬퍼로 통일.
const normalizeStat = (s?: Partial<KanaStat>): KanaStat => ({
  mastered: s?.mastered ?? 0,
  quiz_correct: s?.quiz_correct ?? 0,
  wrong: s?.wrong ?? 0,
  last_seen_at: s?.last_seen_at,
});

export const useKanaProgressStore = create<KanaProgressState>()(
  persist(
    (set) => ({
      byChar: {},
      markMastered: (id) =>
        set((s) => {
          const prev = normalizeStat(s.byChar[id]);
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
      markQuizCorrect: (id) =>
        set((s) => {
          const prev = normalizeStat(s.byChar[id]);
          return {
            byChar: {
              ...s.byChar,
              [id]: {
                ...prev,
                quiz_correct: prev.quiz_correct + 1,
                last_seen_at: new Date().toISOString(),
              },
            },
          };
        }),
      markWrong: (id) =>
        set((s) => {
          const prev = normalizeStat(s.byChar[id]);
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
          const prev = normalizeStat(s.byChar[id]);
          return {
            byChar: {
              ...s.byChar,
              [id]: { ...prev, last_seen_at: new Date().toISOString() },
            },
          };
        }),
      reset: () => set({ byChar: {} }),
    }),
    {
      name: "jlpt-rpg-kana-progress",
      // 과거 버전(quiz_correct 필드 없음)에서 로드된 데이터를 안전하게 보정.
      migrate: (state) => {
        if (!state || typeof state !== "object") return state;
        const s = state as Partial<KanaProgressState>;
        if (!s.byChar) return state;
        const next: Record<string, KanaStat> = {};
        for (const [id, stat] of Object.entries(s.byChar)) {
          next[id] = normalizeStat(stat as Partial<KanaStat>);
        }
        return { ...s, byChar: next } as KanaProgressState;
      },
    },
  ),
);

// 마스터 정도(0~3 단계)를 계산하는 헬퍼.
// score = mastered(플래시카드) * 1 + quiz_correct * 0.6 - wrong * 0.6
// - 0: 한 번도 안 풀어봤거나 모름
// - 1: 점수 1~2 (가벼운 노출)
// - 2: 점수 3~4 (통달 — 퀴즈 5회 성공 또는 플래시 3회)
// - 3: 점수 5 이상 (마스터 ⭐ — 퀴즈 9회 성공 또는 플래시 5회)
//
// 퀴즈는 4지선다라 찍어서 맞출 수 있으므로 가중치를 0.6 으로 낮춰
// "완전 알았음" 처리에 최소 5회 반복이 필요하도록 했다.
export function kanaMasteryLevel(stat?: KanaStat): 0 | 1 | 2 | 3 {
  if (!stat) return 0;
  const quizCorrect = stat.quiz_correct ?? 0;
  const score = stat.mastered + quizCorrect * 0.6 - stat.wrong * 0.6;
  if (score >= 5) return 3;
  if (score >= 3) return 2;
  if (score >= 1) return 1;
  return 0;
}
