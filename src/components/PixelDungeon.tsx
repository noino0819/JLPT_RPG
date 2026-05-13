import type { JlptLevel } from "../types";

interface Props {
  level: JlptLevel;
  size?: number;
  animate?: boolean;
}

/**
 * Box-shadow 픽셀아트로 그린 던전 아이콘.
 * - N5: 시작의 숲 (나무)
 * - N4: 동굴 (산 + 동굴 입구)
 * - N3: 고대 유적 (그리스풍 신전)
 * - N2: 화산 (분화구 + 용암)
 * - N1: 천공의 신전 (파고다)
 *
 * 캐릭터와 같은 16x16 그리드로 렌더링해서 시각적 일관성 유지.
 */
export default function PixelDungeon({
  level,
  size = 48,
  animate = false,
}: Props) {
  return (
    <div
      className={`relative ${animate ? "animate-bob" : ""}`}
      style={{ width: size, height: size }}
    >
      <DungeonSprite level={level} size={size} />
    </div>
  );
}

function DungeonSprite({ level, size }: { level: JlptLevel; size: number }) {
  const px = size / 16;
  const sty = (col: number, row: number, color: string) => ({
    left: col * px,
    top: row * px,
    width: px,
    height: px,
    background: color,
    position: "absolute" as const,
  });

  const palette = PALETTES[level];
  const sprite = SPRITES[level];

  return (
    <div className="relative h-full w-full">
      {sprite.map((row, r) =>
        row.split("").map((ch, c) => {
          const color = palette[ch];
          if (!color) return null;
          return <span key={`${r}-${c}`} style={sty(c, r, color)} />;
        }),
      )}
    </div>
  );
}

/**
 * 16x16 sprite 의 문자 정의 (던전별 공통 시맨틱).
 *  . = 투명
 *  o = 짙은 외곽선
 *  // 숲 (N5)
 *  f = 밝은 잎
 *  F = 어두운 잎 (그림자)
 *  t = 나무줄기
 *  T = 줄기 그림자
 *  g = 풀/지면
 *  // 동굴 (N4)
 *  s = 정상 눈/밝은 돌
 *  m = 중간 회색 바위
 *  M = 어두운 회색 바위
 *  h = 동굴 입구 외곽
 *  H = 동굴 내부 (어두운 보이드)
 *  // 유적 (N3)
 *  p = 밝은 석재 (기둥 하이라이트)
 *  P = 어두운 석재 (기둥 그림자)
 *  // 화산 (N2)
 *  V = 어두운 화산암
 *  L = 밝은 용암 (뜨거움)
 *  l = 노란 용암 (글로우)
 *  // 천공 신전 (N1)
 *  R = 지붕 기와 (보라/청)
 *  r = 지붕 하이라이트
 *  c = 신전 기둥/벽 (석재)
 *  C = 기둥 그림자
 *  w = 입구/문 (어두움)
 *  S = 금색 첨탑/장식
 *  G = 마법 글로우
 */
const SPRITES: Record<JlptLevel, string[]> = {
  // 시작의 숲: 풍성한 침엽수 + 풀밭
  N5: [
    "................",
    "................",
    "......oooo......",
    ".....offffo.....",
    "....offfFffo....",
    "...offFffFffo...",
    "..offfFfFfFffo..",
    "...offFffFffo...",
    "....offfFffo....",
    ".....offffo.....",
    ".......oo.......",
    "......otto......",
    ".....oTttTo.....",
    ".....oTttTo.....",
    "...gggggggggg...",
    "................",
  ],
  // 동굴: 눈 덮인 산 + 가운데 동굴 입구
  N4: [
    "................",
    "................",
    ".......oo.......",
    "......osso......",
    ".....osmmso.....",
    "....osmmMmso....",
    "...osmMMmMmso...",
    "..osmMmMMmMmso..",
    ".osmMmMMmMmMmso.",
    ".osmMmhhhhmMmso.",
    "osmMmhHHHHhmMmso",
    "osmMMhHHHHhMMmso",
    "osmMMhHHHHhMMmso",
    "osmMMMMMMMMMMmso",
    "oooooooooooooooo",
    "................",
  ],
  // 고대 유적: 페디먼트 + 다섯 기둥 + 스타일로베이트
  N3: [
    "................",
    ".......oo.......",
    "......opPo......",
    ".....opPPPo.....",
    "....opPPPPPo....",
    "...opPPPPPPPo...",
    "..opPPPPPPPPPo..",
    "oooooooooooooooo",
    "oPP.PP.PP.PP.PPo",
    "oPP.pp.pp.pp.PPo",
    "oPP.pp.pp.pp.PPo",
    "oPP.pp.pp.pp.PPo",
    "oPP.pp.pp.pp.PPo",
    "oPP.PP.PP.PP.PPo",
    "oooooooooooooooo",
    "................",
  ],
  // 화산: 용암 튐 + 분화구 + 옆으로 흐르는 용암
  N2: [
    "................",
    "................",
    ".......l........",
    "......l.l.......",
    ".....l...l......",
    "....oLLLLLLo....",
    "...oVVLLLLVVo...",
    "..oVVVVLLVVVVo..",
    "..oVVlVVVVVVVo..",
    ".oVVVVlVVVVVlVo.",
    "oVVVlVVVVlVVVVlo",
    "oVVVVVlVVVVVVVVo",
    "oVlVVVVVVVlVVVVo",
    "oVVVVVVVVVVVVVVo",
    "oooooooooooooooo",
    "................",
  ],
  // 천공의 신전: 첨탑 + 3층 지붕 파고다
  N1: [
    "................",
    ".......oo.......",
    ".......SS.......",
    "......oSSo......",
    ".......SS.......",
    ".....oRrrRo.....",
    "......cwwc......",
    "....oRrrrrrRo...",
    ".....cwTTwc.....",
    "...oRrrrrrrrRo..",
    "....cwTTTTwc....",
    "....cwTwwTwc....",
    "..oRrrrrrrrrrRo.",
    "..cwTTTTTTTTwc..",
    "..oooooooooooo..",
    "................",
  ],
};

type Palette = Record<string, string>;

const PALETTES: Record<JlptLevel, Palette> = {
  // 시작의 숲: 채도 높은 녹색 + 갈색 줄기 + 풀밭
  N5: {
    o: "#0a1a0a",
    f: "#5dc94c",
    F: "#1f6a22",
    t: "#7c5230",
    T: "#4a2c14",
    g: "#3ea33a",
  },
  // 동굴: 회색조 산 + 흰 눈 + 어두운 동굴 입구
  N4: {
    o: "#0a0610",
    s: "#e6e8f0",
    m: "#7a7a86",
    M: "#3a3a44",
    h: "#1a121c",
    H: "#000000",
  },
  // 고대 유적: 베이지 석재 + 갈색 그림자
  N3: {
    o: "#1a0e10",
    p: "#e8d7a5",
    P: "#9a7a3a",
  },
  // 화산: 검은 바위 + 진한 용암 + 글로우
  N2: {
    o: "#0a0610",
    V: "#2a1820",
    L: "#ff4a18",
    l: "#ffc14a",
  },
  // 천공의 신전: 보라/청 기와 + 흰 석재 기둥 + 금색 첨탑
  N1: {
    o: "#0a0a30",
    R: "#3a2d80",
    r: "#7c6efc",
    c: "#f3e8d0",
    w: "#1a0e30",
    T: "#a06f3d",
    S: "#f0c97c",
  },
};

if (import.meta.env.DEV) {
  for (const [id, sprite] of Object.entries(SPRITES)) {
    sprite.forEach((row, i) => {
      if (row.length !== 16) {
        console.warn(
          `[PixelDungeon] sprite ${id} row ${i} 길이=${row.length} (16 이어야 함): "${row}"`,
        );
      }
    });
  }
}
