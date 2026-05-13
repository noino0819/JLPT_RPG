import type { JlptLevel } from "../types";

export interface BossMeta {
  level: JlptLevel;
  name: string;
  nameJp: string;
  title: string;
  description: string;
  /** 메인 강조색 (Tailwind text-*) — HP 바 등에 사용 */
  hpColor: string;
  /** 위험 단계(저 HP) 강조색 */
  hpDangerColor: string;
  /** 보스 별 처치 대사 (승리 시 표시) */
  victoryQuote: string;
}

/**
 * 던전별 보스 메타. 보스 HP 는 페이지에서 마스터한 단어 수에 비례해 동적으로 결정.
 * 여기엔 "캐릭터성"만 정의 (이름, 색상, 대사 등).
 */
export const BOSSES: Record<JlptLevel, BossMeta> = {
  N5: {
    level: "N5",
    name: "슬라임 군주",
    nameJp: "スライム王",
    title: "始まりの森の守護者",
    description: "겉보기엔 귀엽지만 단어를 잊으면 다시 분열한다.",
    hpColor: "bg-forest-500",
    hpDangerColor: "bg-volcano-500",
    victoryQuote: "푸 ... 분열할 단어가 없다 ...",
  },
  N4: {
    level: "N4",
    name: "박쥐 군주",
    nameJp: "蝙蝠の王",
    title: "洞窟の支配者",
    description: "어둠 속에서 잊혀진 단어의 비명을 듣는다.",
    hpColor: "bg-cave-500",
    hpDangerColor: "bg-volcano-500",
    victoryQuote: "키이이이이 ...... 빛이여 ......",
  },
  N3: {
    level: "N3",
    name: "석상 골렘",
    nameJp: "石像のゴーレム",
    title: "古代遺跡の守り手",
    description: "각 단어가 새겨진 룬을 부숴야 비로소 잠든다.",
    hpColor: "bg-ruin-500",
    hpDangerColor: "bg-volcano-500",
    victoryQuote: "자, 잠 ... 든다 ......",
  },
  N2: {
    level: "N2",
    name: "용암 드래곤",
    nameJp: "溶岩のドラゴン",
    title: "火山の主",
    description: "포효 한 번에 외운 단어를 다시 시험한다.",
    hpColor: "bg-volcano-500",
    hpDangerColor: "bg-volcano-700",
    victoryQuote: "그르르 ... 인정 ... 한다 ...",
  },
  N1: {
    level: "N1",
    name: "마왕",
    nameJp: "魔王",
    title: "天空の神殿の主",
    description: "JLPT 의 정점. 진정 외운 단어만이 통한다.",
    hpColor: "bg-sky-500",
    hpDangerColor: "bg-volcano-500",
    victoryQuote: "후 ... 후후 ... 훌륭하구나, 인간이여 ...",
  },
};

/**
 * 보스 HP 산정.
 * - 마스터한 단어 수가 그대로 HP 가 되면 너무 길어지므로 cap.
 * - 단어가 너무 적으면 의미가 없으므로 최소 HP 보장.
 */
export const BOSS_MIN_WORDS = 5; // 이 미만이면 도전 자체를 잠금
export const BOSS_HP_MIN = 5;
export const BOSS_HP_MAX = 30;

export function computeBossHp(masteredCount: number): number {
  if (masteredCount <= BOSS_HP_MIN) return BOSS_HP_MIN;
  if (masteredCount >= BOSS_HP_MAX) return BOSS_HP_MAX;
  return masteredCount;
}
