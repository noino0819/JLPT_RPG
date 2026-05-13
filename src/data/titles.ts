import type { CosmeticBase } from "../types";

// 칭호 = 닉네임 옆에 붙는 한·일 병기 별칭.
export interface TitleItem extends CosmeticBase {
  kind: "title";
  // 닉네임 위/옆에 표시될 텍스트 (병기 표시는 컴포넌트가 담당)
  textJp: string;
  textKo: string;
  // tailwind text color class
  color: string;
}

export const TITLES: TitleItem[] = [
  {
    id: "title_novice",
    kind: "title",
    name: "견습",
    nameJp: "見習い",
    textJp: "見習い",
    textKo: "견습",
    color: "text-parchment-300",
    condition: { kind: "rank", min: 0 },
  },
  {
    id: "title_first_blood",
    kind: "title",
    name: "첫 처치자",
    nameJp: "初討伐者",
    textJp: "初討伐",
    textKo: "첫 처치",
    color: "text-rune-400",
    condition: { kind: "rank", min: 1 },
  },
  {
    id: "title_forest_friend",
    kind: "title",
    name: "숲의 벗",
    nameJp: "森の友",
    textJp: "森の友",
    textKo: "숲의 벗",
    color: "text-forest-400",
    condition: { kind: "dungeon", level: "N5", min: 50 },
  },
  {
    id: "title_cave_explorer",
    kind: "title",
    name: "동굴 탐험가",
    nameJp: "洞窟の探検者",
    textJp: "洞窟の探検者",
    textKo: "동굴 탐험가",
    color: "text-cave-400",
    condition: { kind: "dungeon", level: "N4", min: 50 },
  },
  {
    id: "title_ruin_seeker",
    kind: "title",
    name: "유적의 탐구자",
    nameJp: "遺跡の探究者",
    textJp: "遺跡の探究者",
    textKo: "유적의 탐구자",
    color: "text-ruin-400",
    condition: { kind: "dungeon", level: "N3", min: 50 },
  },
  {
    id: "title_lava_walker",
    kind: "title",
    name: "용암 사용자",
    nameJp: "溶岩使い",
    textJp: "溶岩使い",
    textKo: "용암 사용자",
    color: "text-volcano-400",
    condition: { kind: "dungeon", level: "N2", min: 50 },
  },
  {
    id: "title_skybound",
    kind: "title",
    name: "천공의 자",
    nameJp: "天空の者",
    textJp: "天空の者",
    textKo: "천공의 자",
    color: "text-sky-400",
    condition: { kind: "dungeon", level: "N1", min: 30 },
  },
  {
    id: "title_legend",
    kind: "title",
    name: "전설",
    nameJp: "伝説",
    textJp: "伝説",
    textKo: "전설",
    color: "text-rune-400",
    condition: { kind: "rank", min: 1000 },
  },
];

export const TITLES_BY_ID: Record<string, TitleItem> = Object.fromEntries(
  TITLES.map((t) => [t.id, t]),
);
