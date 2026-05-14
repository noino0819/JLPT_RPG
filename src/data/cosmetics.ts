import type { CharacterId, CosmeticBase } from "../types";

// 코스튬 = 캐릭터별 팔레트 오버라이드.
// PixelCharacter 의 베이스 PALETTES 를 그대로 쓰되 일부 키만 덮어써서
// "같은 sprite, 다른 색" 으로 직업별 버전 차이를 만든다.
export type CostumePalette = Record<string, string>;

export interface CostumeItem extends CosmeticBase {
  kind: "costume";
  characterId: CharacterId;
  // 베이스 팔레트 위에 덮어쓸 키 (없으면 베이스 사용)
  paletteOverride: CostumePalette;
}

// 4 직업 × 4 코스튬 = 16 종.
// 기본은 즉시 해금, 나머지는 등급/던전 도달 시 해금.
export const COSTUMES: CostumeItem[] = [
  // ─── 전사 ───
  {
    id: "warrior_default",
    kind: "costume",
    characterId: "warrior",
    name: "기본 갑주",
    nameJp: "鋼の鎧",
    condition: { kind: "rank", min: 0 },
    paletteOverride: {},
  },
  {
    id: "warrior_gold",
    kind: "costume",
    characterId: "warrior",
    name: "황금 갑주",
    nameJp: "黄金の鎧",
    description: "베테랑 등급 도달 시 해금",
    condition: { kind: "rank", min: 200 },
    paletteOverride: {
      h: "#f0c97c",
      H: "#a87a2a",
      c: "#f0c97c",
      C: "#a87a2a",
      g: "#fff5c2",
      m: "#fff5c2",
    },
  },
  {
    id: "warrior_dark",
    kind: "costume",
    characterId: "warrior",
    name: "암흑 기사",
    nameJp: "暗黒の騎士",
    description: "동굴 던전 100마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N4", min: 100 },
    paletteOverride: {
      h: "#22202b",
      H: "#0a0610",
      c: "#3a1f3a",
      C: "#1a0e1a",
      g: "#9b59b6",
      m: "#7f4090",
    },
  },
  {
    id: "warrior_frost",
    kind: "costume",
    characterId: "warrior",
    name: "빙결 기사",
    nameJp: "氷結の騎士",
    description: "천공의 신전 50마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N1", min: 50 },
    paletteOverride: {
      h: "#cfe9ff",
      H: "#5a8cb5",
      c: "#7cc5e8",
      C: "#2b5e80",
      g: "#fff",
      m: "#dff5ff",
    },
  },

  // ─── 마법사 ───
  {
    id: "mage_default",
    kind: "costume",
    characterId: "mage",
    name: "보랏빛 로브",
    nameJp: "紫のローブ",
    condition: { kind: "rank", min: 0 },
    paletteOverride: {},
  },
  {
    id: "mage_crimson",
    kind: "costume",
    characterId: "mage",
    name: "홍염 로브",
    nameJp: "紅炎のローブ",
    description: "베테랑 등급 도달 시 해금",
    condition: { kind: "rank", min: 200 },
    paletteOverride: {
      h: "#a02029",
      H: "#5c0c14",
      c: "#d83a3a",
      C: "#7a1408",
      G: "#ffd166",
    },
  },
  {
    id: "mage_abyss",
    kind: "costume",
    characterId: "mage",
    name: "심해 로브",
    nameJp: "深海のローブ",
    description: "동굴 던전 100마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N4", min: 100 },
    paletteOverride: {
      h: "#0a3252",
      H: "#041524",
      c: "#1565a0",
      C: "#072d4f",
      G: "#7be3ff",
    },
  },
  {
    id: "mage_galaxy",
    kind: "costume",
    characterId: "mage",
    name: "은하 로브",
    nameJp: "銀河のローブ",
    description: "천공의 신전 50마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N1", min: 50 },
    paletteOverride: {
      h: "#221037",
      H: "#0a0212",
      c: "#3b1d80",
      C: "#1a0a3a",
      S: "#fff5b1",
      G: "#ffe066",
    },
  },

  // ─── 궁수 ───
  {
    id: "archer_default",
    kind: "costume",
    characterId: "archer",
    name: "숲지기 의상",
    nameJp: "森番の衣",
    condition: { kind: "rank", min: 0 },
    paletteOverride: {},
  },
  {
    id: "archer_emerald",
    kind: "costume",
    characterId: "archer",
    name: "에메랄드 의상",
    nameJp: "翠玉の衣",
    description: "베테랑 등급 도달 시 해금",
    condition: { kind: "rank", min: 200 },
    paletteOverride: {
      h: "#0d6e4f",
      H: "#053b27",
      c: "#1ea372",
      C: "#0d6e4f",
      m: "#7be3a8",
    },
  },
  {
    id: "archer_shadow",
    kind: "costume",
    characterId: "archer",
    name: "그림자 사냥꾼",
    nameJp: "影の狩人",
    description: "동굴 던전 100마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N4", min: 100 },
    paletteOverride: {
      h: "#1a1428",
      H: "#0a0610",
      c: "#2a1c40",
      C: "#0f0a18",
      m: "#9b59b6",
      S: "#7be3ff",
    },
  },
  {
    id: "archer_celestial",
    kind: "costume",
    characterId: "archer",
    name: "천공의 사수",
    nameJp: "天空の射手",
    description: "천공의 신전 50마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N1", min: 50 },
    paletteOverride: {
      h: "#dfe9ff",
      H: "#7a8fb8",
      c: "#fff5c2",
      C: "#c69b3e",
      S: "#fff",
      m: "#fff5c2",
    },
  },

  // ─── 소환사 (드루이드) ───
  {
    id: "summoner_default",
    kind: "costume",
    characterId: "summoner",
    name: "황금 잎의 가운",
    nameJp: "黄金葉のローブ",
    condition: { kind: "rank", min: 0 },
    paletteOverride: {},
  },
  {
    id: "summoner_crystal",
    kind: "costume",
    characterId: "summoner",
    name: "수정 망토",
    nameJp: "水晶のマント",
    description: "베테랑 등급 도달 시 해금",
    condition: { kind: "rank", min: 200 },
    paletteOverride: {
      h: "#1a3852",
      H: "#0a1a2a",
      c: "#2a5680",
      C: "#0f243a",
      e: "#dffaff",
      G: "#dffaff",
      g: "#7be3ff",
      L: "#7be3ff", // 수정 컨셉: 잎사귀를 청록 결정으로 대체
    },
  },
  {
    id: "summoner_blood",
    kind: "costume",
    characterId: "summoner",
    name: "혈맹의 망토",
    nameJp: "血盟のマント",
    description: "동굴 던전 100마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N4", min: 100 },
    paletteOverride: {
      h: "#3a0c12",
      H: "#1a0408",
      c: "#7a1408",
      C: "#3a0810",
      e: "#ff5a5a",
      g: "#ffb86b",
      G: "#ff8a8a",
      L: "#a02029", // 혈맹 컨셉: 시든 핏빛 잎사귀
    },
  },
  {
    id: "summoner_phantom",
    kind: "costume",
    characterId: "summoner",
    name: "환령의 망토",
    nameJp: "幻霊のマント",
    description: "천공의 신전 50마리 처치 시 해금",
    condition: { kind: "dungeon", level: "N1", min: 50 },
    paletteOverride: {
      h: "#e0d8ff",
      H: "#9b91d8",
      c: "#c2b8e8",
      C: "#7068a0",
      e: "#fff",
      G: "#fff",
      g: "#fff5c2",
      L: "#e0d8ff", // 환령 컨셉: 창백한 환영 잎사귀
    },
  },
];

export const COSTUMES_BY_ID: Record<string, CostumeItem> = Object.fromEntries(
  COSTUMES.map((c) => [c.id, c]),
);

export function costumesForCharacter(id: CharacterId): CostumeItem[] {
  return COSTUMES.filter((c) => c.characterId === id);
}
