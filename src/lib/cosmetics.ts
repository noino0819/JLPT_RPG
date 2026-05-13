import { useEffect, useRef } from "react";
import type { CosmeticBase, JlptLevel, UnlockCondition } from "../types";
import { COSTUMES } from "../data/cosmetics";
import { PETS } from "../data/pets";
import { TITLES } from "../data/titles";
import { BADGES } from "../data/badges";
import { FRAMES } from "../data/frames";
import { dungeonStats, totalKills } from "./stats";
import { useProgressStore } from "../store/progressStore";
import { useUnlockToastStore } from "../store/unlockToastStore";

// 모든 카탈로그를 평탄화한 통합 리스트.
// id 충돌이 없도록 카탈로그별로 prefix 를 쓰고 있다.
export const ALL_COSMETICS: CosmeticBase[] = [
  ...COSTUMES,
  ...PETS,
  ...TITLES,
  ...BADGES,
  ...FRAMES,
];

export const COSMETIC_BY_ID: Record<string, CosmeticBase> = Object.fromEntries(
  ALL_COSMETICS.map((c) => [c.id, c]),
);

// 던전별 처치 수 / 누적 처치 수를 받아 조건 평가
export function meetsCondition(
  cond: UnlockCondition,
  totalKillCount: number,
  dungeonKills: Record<JlptLevel, number>,
): boolean {
  if (cond.kind === "rank") return totalKillCount >= cond.min;
  if (cond.kind === "dungeon") {
    const k = dungeonKills[cond.level] ?? 0;
    return k >= cond.min;
  }
  return false;
}

export interface UnlockSnapshot {
  unlocked: Set<string>;
  totalKills: number;
  dungeonKills: Record<JlptLevel, number>;
}

// 현재 진행 상태를 읽어 모든 카탈로그 항목의 해금 여부를 계산한다.
export function computeUnlocked(): UnlockSnapshot {
  const stats = dungeonStats();
  const total = totalKills();
  const dungeon: Record<JlptLevel, number> = {
    N5: stats.N5.mastered,
    N4: stats.N4.mastered,
    N3: stats.N3.mastered,
    N2: stats.N2.mastered,
    N1: stats.N1.mastered,
  };
  const unlocked = new Set<string>();
  for (const item of ALL_COSMETICS) {
    if (meetsCondition(item.condition, total, dungeon)) {
      unlocked.add(item.id);
    }
  }
  return { unlocked, totalKills: total, dungeonKills: dungeon };
}

// 사람이 읽을 수 있는 조건 텍스트 (예: "⚔ 200 필요", "N3 100마리 처치")
export function describeCondition(cond: UnlockCondition): string {
  if (cond.kind === "rank") return `⚔ ${cond.min} 필요`;
  return `${cond.level} 던전 ${cond.min}마리`;
}

/**
 * 처치 수 변화 → 새로 해금된 아이템이 있으면 토스트 큐에 추가.
 *
 * progressStore.byWord 자체를 dependency 로 보면 너무 자주 트리거되므로,
 * "현재 totalKills" 가 변할 때만 재계산한다.
 */
export function useUnlockWatcher() {
  const byWord = useProgressStore((s) => s.byWord);
  const enqueue = useUnlockToastStore((s) => s.enqueue);
  const lastKillsRef = useRef<number | null>(null);
  const knownUnlockedRef = useRef<Set<string> | null>(null);

  useEffect(() => {
    const snapshot = computeUnlocked();

    // 첫 렌더(앱 진입 시) 에는 알림을 띄우지 않는다.
    if (knownUnlockedRef.current === null) {
      knownUnlockedRef.current = snapshot.unlocked;
      lastKillsRef.current = snapshot.totalKills;
      return;
    }

    // 처치 수가 줄었거나 변화 없으면 새 해금 가능성도 없다.
    if (
      lastKillsRef.current !== null &&
      snapshot.totalKills <= lastKillsRef.current
    ) {
      lastKillsRef.current = snapshot.totalKills;
      knownUnlockedRef.current = snapshot.unlocked;
      return;
    }

    const newlyUnlocked: string[] = [];
    for (const id of snapshot.unlocked) {
      if (!knownUnlockedRef.current.has(id)) newlyUnlocked.push(id);
    }
    if (newlyUnlocked.length > 0) {
      for (const id of newlyUnlocked) {
        const item = COSMETIC_BY_ID[id];
        if (item) enqueue(item);
      }
    }
    knownUnlockedRef.current = snapshot.unlocked;
    lastKillsRef.current = snapshot.totalKills;
  // byWord 가 바뀔 때만 재계산
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [byWord]);
}
