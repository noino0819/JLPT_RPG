import type { CosmeticBase } from "../types";

// 뱃지 = 캐릭터 이름 옆 / 헤더에 붙는 작은 아이콘.
// 다중 장착 가능 (최대 3개 권장).
export interface BadgeItem extends CosmeticBase {
  kind: "badge";
  icon: string; // 이모지
  // tailwind 배경 색 class (badge-pixel 위에 덮어쓰기)
  tone: string;
}

export const BADGES: BadgeItem[] = [
  {
    id: "badge_first_kill",
    kind: "badge",
    name: "첫 처치",
    nameJp: "初討伐",
    icon: "⚔",
    tone: "!bg-rune-500/20 !text-rune-400",
    condition: { kind: "rank", min: 1 },
  },
  {
    id: "badge_100",
    kind: "badge",
    name: "백 처치",
    nameJp: "百討伐",
    icon: "💯",
    tone: "!bg-parchment-400/20 !text-parchment-200",
    condition: { kind: "rank", min: 100 },
  },
  {
    id: "badge_500",
    kind: "badge",
    name: "오백 처치",
    nameJp: "五百討伐",
    icon: "🏆",
    tone: "!bg-volcano-500/20 !text-volcano-400",
    condition: { kind: "rank", min: 500 },
  },
  {
    id: "badge_1000",
    kind: "badge",
    name: "천 처치",
    nameJp: "千討伐",
    icon: "👑",
    tone: "!bg-rune-500/30 !text-rune-300",
    condition: { kind: "rank", min: 1000 },
  },
  {
    id: "badge_n5_clear",
    kind: "badge",
    name: "숲의 정복자",
    nameJp: "森の征服者",
    icon: "🌲",
    tone: "!bg-forest-500/20 !text-forest-400",
    condition: { kind: "dungeon", level: "N5", min: 50 },
  },
  {
    id: "badge_n3_clear",
    kind: "badge",
    name: "유적의 정복자",
    nameJp: "遺跡の征服者",
    icon: "🏛️",
    tone: "!bg-ruin-500/20 !text-ruin-400",
    condition: { kind: "dungeon", level: "N3", min: 100 },
  },
  {
    id: "badge_n2_clear",
    kind: "badge",
    name: "화산의 정복자",
    nameJp: "火山の征服者",
    icon: "🌋",
    tone: "!bg-volcano-500/20 !text-volcano-400",
    condition: { kind: "dungeon", level: "N2", min: 50 },
  },
  {
    id: "badge_n1_clear",
    kind: "badge",
    name: "천공의 정복자",
    nameJp: "天空の征服者",
    icon: "🏯",
    tone: "!bg-sky-500/20 !text-sky-400",
    condition: { kind: "dungeon", level: "N1", min: 30 },
  },
];

export const BADGES_BY_ID: Record<string, BadgeItem> = Object.fromEntries(
  BADGES.map((b) => [b.id, b]),
);

// 동시에 장착 가능한 뱃지 수
export const MAX_EQUIPPED_BADGES = 3;
