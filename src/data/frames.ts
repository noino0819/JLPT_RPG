import type { CosmeticBase } from "../types";

// 프로필 프레임 = 캐릭터 둘레의 border + glow.
// className 만으로 구성해 어디든 끼워 넣을 수 있다.
export interface FrameItem extends CosmeticBase {
  kind: "frame";
  // 프레임 컨테이너에 적용될 tailwind class (border, ring, shadow 등)
  className: string;
}

export const FRAMES: FrameItem[] = [
  {
    id: "frame_default",
    kind: "frame",
    name: "기본 액자",
    nameJp: "基本",
    className: "border-2 border-black bg-dungeon-50/40",
    condition: { kind: "rank", min: 0 },
  },
  {
    id: "frame_bronze",
    kind: "frame",
    name: "청동 액자",
    nameJp: "青銅",
    description: "모험가 등급 도달 시 해금",
    className:
      "border-2 border-cave-500 bg-cave-500/10 shadow-[0_0_0_2px_rgba(140,90,40,0.4)]",
    condition: { kind: "rank", min: 50 },
  },
  {
    id: "frame_silver",
    kind: "frame",
    name: "은 액자",
    nameJp: "銀",
    description: "베테랑 등급 도달 시 해금",
    className:
      "border-2 border-parchment-200 bg-parchment-200/10 shadow-[0_0_0_2px_rgba(220,220,220,0.4)]",
    condition: { kind: "rank", min: 200 },
  },
  {
    id: "frame_gold",
    kind: "frame",
    name: "황금 액자",
    nameJp: "黄金",
    description: "정예 등급 도달 시 해금",
    className:
      "border-2 border-rune-500 bg-rune-500/10 shadow-[0_0_0_2px_rgba(255,180,40,0.5)]",
    condition: { kind: "rank", min: 500 },
  },
  {
    id: "frame_legend",
    kind: "frame",
    name: "전설 액자",
    nameJp: "伝説",
    description: "전설 등급 도달 시 해금",
    className:
      "border-2 border-volcano-400 bg-gradient-to-br from-rune-500/20 to-volcano-500/20 shadow-[0_0_0_3px_rgba(220,80,60,0.5)] animate-pulse",
    condition: { kind: "rank", min: 1000 },
  },
];

export const FRAMES_BY_ID: Record<string, FrameItem> = Object.fromEntries(
  FRAMES.map((f) => [f.id, f]),
);
