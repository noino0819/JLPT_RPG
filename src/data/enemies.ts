import type { JlptLevel } from "../store/playerStore";

export interface Enemy {
  id: string;
  name: string;
  emoji: string;
  jlpt: JlptLevel;
  hp: number;
  attack: number;
  expReward: number;
  goldReward: number;
}

export const ENEMIES: Enemy[] = [
  {
    id: "slime-n5",
    name: "ひらがな슬라임",
    emoji: "🟢",
    jlpt: "N5",
    hp: 18,
    attack: 3,
    expReward: 8,
    goldReward: 5,
  },
  {
    id: "kanji-bat-n5",
    name: "초보 한자 박쥐",
    emoji: "🦇",
    jlpt: "N5",
    hp: 22,
    attack: 4,
    expReward: 10,
    goldReward: 7,
  },
  {
    id: "katana-n4",
    name: "단어 사무라이",
    emoji: "🥷",
    jlpt: "N4",
    hp: 35,
    attack: 6,
    expReward: 15,
    goldReward: 12,
  },
  {
    id: "tengu-n3",
    name: "문법 텐구",
    emoji: "👺",
    jlpt: "N3",
    hp: 50,
    attack: 9,
    expReward: 22,
    goldReward: 20,
  },
  {
    id: "oni-n2",
    name: "독해의 오니",
    emoji: "👹",
    jlpt: "N2",
    hp: 70,
    attack: 13,
    expReward: 35,
    goldReward: 30,
  },
  {
    id: "dragon-n1",
    name: "JLPT 드래곤",
    emoji: "🐉",
    jlpt: "N1",
    hp: 110,
    attack: 18,
    expReward: 60,
    goldReward: 50,
  },
];

export function getEnemiesByLevel(level: JlptLevel): Enemy[] {
  return ENEMIES.filter((e) => e.jlpt === level);
}
