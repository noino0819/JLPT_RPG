import type { CharacterId } from "../types";

export interface CharacterMeta {
  id: CharacterId;
  name: string;
  nameJp: string;
  emoji: string;
  weapon: string;
  effect: "slash" | "particles" | "arrow" | "ring";
  effectColor: string; // tailwind text-* color for the effect
  bodyColor: string; // tailwind bg-* color for the body
}

export const CHARACTERS: Record<CharacterId, CharacterMeta> = {
  warrior: {
    id: "warrior",
    name: "전사",
    nameJp: "戦士",
    emoji: "⚔️",
    weapon: "🗡️",
    effect: "slash",
    effectColor: "text-parchment-100",
    bodyColor: "bg-volcano-500",
  },
  mage: {
    id: "mage",
    name: "마법사",
    nameJp: "魔法使い",
    emoji: "🔮",
    weapon: "🪄",
    effect: "particles",
    effectColor: "text-sky-400",
    bodyColor: "bg-sky-500",
  },
  archer: {
    id: "archer",
    name: "궁수",
    nameJp: "弓手",
    emoji: "🏹",
    weapon: "🏹",
    effect: "arrow",
    effectColor: "text-forest-400",
    bodyColor: "bg-forest-500",
  },
  summoner: {
    id: "summoner",
    name: "소환사",
    nameJp: "召喚士",
    emoji: "🌟",
    weapon: "🔔",
    effect: "ring",
    // 정령을 부리는 직업 — 따뜻한 황금빛으로 테마 통일
    effectColor: "text-ruin-400",
    bodyColor: "bg-ruin-400",
  },
};

export const CHARACTER_LIST: CharacterMeta[] = Object.values(CHARACTERS);
