export interface Rank {
  min: number;
  name: string;
  nameJp: string;
  color: string; // tailwind class for accent
}

export const RANKS: Rank[] = [
  { min: 0, name: "견습 모험가", nameJp: "見習い", color: "text-parchment-300" },
  { min: 50, name: "모험가", nameJp: "冒険者", color: "text-rune-400" },
  { min: 200, name: "베테랑", nameJp: "ベテラン", color: "text-forest-400" },
  { min: 500, name: "정예", nameJp: "エリート", color: "text-volcano-400" },
  { min: 1000, name: "전설", nameJp: "伝説", color: "text-parchment-400" },
];

export function getRank(killCount: number): Rank {
  let current = RANKS[0];
  for (const r of RANKS) {
    if (killCount >= r.min) current = r;
  }
  return current;
}

export function getNextRank(killCount: number): Rank | null {
  for (const r of RANKS) {
    if (killCount < r.min) return r;
  }
  return null;
}

export function getRankProgress(killCount: number): {
  current: Rank;
  next: Rank | null;
  pct: number;
  remaining: number;
} {
  const current = getRank(killCount);
  const next = getNextRank(killCount);
  if (!next) return { current, next: null, pct: 100, remaining: 0 };
  const span = next.min - current.min;
  const done = killCount - current.min;
  return {
    current,
    next,
    pct: Math.min(100, Math.round((done / span) * 100)),
    remaining: next.min - killCount,
  };
}
