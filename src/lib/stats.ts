import type { DeckLevel, Word, WordProgress } from "../types";
import { useDecksStore } from "../store/decksStore";
import { useProgressStore } from "../store/progressStore";

export interface DungeonStat {
  level: DeckLevel;
  mastered: number;
  probably: number;
  flagged: number;
  total: number;
}

export function dungeonStats(): Record<DeckLevel, DungeonStat> {
  const decks = useDecksStore.getState().allDecks();
  const words = useDecksStore.getState().allWords();
  const progress = useProgressStore.getState().byWord;

  const init = (lv: DeckLevel): DungeonStat => ({
    level: lv,
    mastered: 0,
    probably: 0,
    flagged: 0,
    total: 0,
  });

  const result: Record<string, DungeonStat> = {
    N5: init("N5"),
    N4: init("N4"),
    N3: init("N3"),
    N2: init("N2"),
    N1: init("N1"),
    custom: init("custom"),
  };

  const deckLevel: Record<string, DeckLevel> = {};
  for (const d of decks) deckLevel[d.id] = d.jlpt_level;

  for (const w of words) {
    const lv = deckLevel[w.deck_id];
    if (!lv) continue;
    const stat = result[lv];
    stat.total += 1;
    const p = progress[w.id];
    if (!p) continue;
    if (p.mastery === "mastered") stat.mastered += 1;
    if (p.mastery === "probably") stat.probably += 1;
    if (p.flagged) stat.flagged += 1;
  }
  return result as Record<DeckLevel, DungeonStat>;
}

export function totalKills(): number {
  const progress = useProgressStore.getState().byWord;
  return Object.values(progress).filter((p) => p.mastery === "mastered").length;
}

/** 학습 큐 빌더 — 설정과 진행 상태를 반영해 단어 순서를 생성 */
export function buildStudyQueue(
  words: Word[],
  opts: {
    order: "random" | "sequential";
    excludeMastered: boolean;
    probablyEvery: number;
    reviewWeight: number;
    progress: Record<string, WordProgress>;
    onlyFlagged?: boolean;
  },
): Word[] {
  const {
    order,
    excludeMastered,
    probablyEvery,
    reviewWeight,
    progress,
    onlyFlagged,
  } = opts;

  let pool = [...words];

  if (onlyFlagged) {
    pool = pool.filter((w) => progress[w.id]?.flagged);
    if (order === "random") shuffle(pool);
    return pool;
  }

  // 분리: 카테고리별
  const masteredArr: Word[] = [];
  const probablyArr: Word[] = [];
  const noneArr: Word[] = [];
  const flaggedArr: Word[] = [];

  for (const w of pool) {
    const p = progress[w.id];
    if (p?.flagged) flaggedArr.push(w);
    if (p?.mastery === "mastered") masteredArr.push(w);
    else if (p?.mastery === "probably") probablyArr.push(w);
    else noneArr.push(w);
  }

  // 기본 베이스 = none + (excludeMastered ? [] : mastered)
  const base: Word[] = [...noneArr];
  if (!excludeMastered) base.push(...masteredArr);

  if (order === "random") shuffle(base);

  // probablyEvery 마다 1장씩 probably 단어 끼워넣기
  if (probablyArr.length > 0) {
    const step = Math.max(1, probablyEvery);
    const probShuffled = order === "random" ? shuffle([...probablyArr]) : [...probablyArr];
    let pi = 0;
    const woven: Word[] = [];
    base.forEach((w, i) => {
      woven.push(w);
      if ((i + 1) % step === 0 && probShuffled.length) {
        woven.push(probShuffled[pi % probShuffled.length]);
        pi += 1;
      }
    });
    base.length = 0;
    base.push(...woven);
  }

  // flagged 가중치 적용 (review_mix_weight 만큼 더 자주 등장)
  if (flaggedArr.length > 0 && reviewWeight > 1) {
    const extras: Word[] = [];
    for (let i = 0; i < reviewWeight - 1; i += 1) {
      extras.push(...flaggedArr);
    }
    base.push(...extras);
    if (order === "random") shuffle(base);
  }

  return base;
}

function shuffle<T>(arr: T[]): T[] {
  for (let i = arr.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}
