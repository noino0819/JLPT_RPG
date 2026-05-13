import type { JlptLevel } from "../types";

export interface DungeonMeta {
  level: JlptLevel;
  name: string;
  nameJp: string;
  emoji: string;
  /** Tailwind 클래스 모음 */
  theme: {
    bg: string; // 배경 그라디언트
    accent: string; // 카드 강조 색
    text: string; // 강조 텍스트 색
    ring: string; // border-color
  };
}

export const DUNGEONS: Record<JlptLevel, DungeonMeta> = {
  N5: {
    level: "N5",
    name: "시작의 숲",
    nameJp: "始まりの森",
    emoji: "🌲",
    theme: {
      bg: "from-forest-900 via-dungeon-200 to-dungeon-300",
      accent: "bg-forest-500",
      text: "text-forest-400",
      ring: "border-forest-500",
    },
  },
  N4: {
    level: "N4",
    name: "동굴",
    nameJp: "洞窟",
    emoji: "⛰️",
    theme: {
      bg: "from-cave-900 via-dungeon-200 to-dungeon-300",
      accent: "bg-cave-500",
      text: "text-cave-400",
      ring: "border-cave-500",
    },
  },
  N3: {
    level: "N3",
    name: "고대 유적",
    nameJp: "古代遺跡",
    emoji: "🏛️",
    theme: {
      bg: "from-ruin-900 via-dungeon-200 to-dungeon-300",
      accent: "bg-ruin-500",
      text: "text-ruin-400",
      ring: "border-ruin-500",
    },
  },
  N2: {
    level: "N2",
    name: "화산",
    nameJp: "火山",
    emoji: "🌋",
    theme: {
      bg: "from-volcano-900 via-dungeon-200 to-dungeon-300",
      accent: "bg-volcano-500",
      text: "text-volcano-400",
      ring: "border-volcano-500",
    },
  },
  N1: {
    level: "N1",
    name: "천공의 신전",
    nameJp: "天空の神殿",
    emoji: "🏯",
    theme: {
      bg: "from-sky-900 via-dungeon-200 to-dungeon-300",
      accent: "bg-sky-500",
      text: "text-sky-400",
      ring: "border-sky-500",
    },
  },
};

export const JLPT_LEVELS: JlptLevel[] = ["N5", "N4", "N3", "N2", "N1"];
