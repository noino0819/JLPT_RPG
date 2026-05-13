import { CHARACTERS } from "../data/characters";
import type { CharacterId } from "../types";

interface Props {
  id: CharacterId;
  attacking?: boolean;
  size?: number;
  showName?: boolean;
}

/**
 * Box-shadow 픽셀아트 + idle bobbing + attack swing.
 * 캐릭터마다 다른 16x16 sprite 와 팔레트를 사용해
 * 직업별 특징(헬멧, 고깔모자, 후드, 망토)이 한눈에 보이도록 차별화.
 */
export default function PixelCharacter({
  id,
  attacking = false,
  size = 72,
  showName = false,
}: Props) {
  const c = CHARACTERS[id];

  return (
    <div className="flex flex-col items-center gap-1">
      <div
        className={`relative ${attacking ? "animate-attackSwing" : "animate-bob"}`}
        style={{ width: size, height: size }}
      >
        <CharacterSprite id={id} size={size} />
      </div>
      {showName && (
        <div className="font-pixel text-[10px] text-parchment-200">
          {c.nameJp} · {c.name}
        </div>
      )}
    </div>
  );
}

function CharacterSprite({ id, size }: { id: CharacterId; size: number }) {
  const px = size / 16;
  const sty = (col: number, row: number, color: string) => ({
    left: col * px,
    top: row * px,
    width: px,
    height: px,
    background: color,
    position: "absolute" as const,
  });

  const palette = PALETTES[id];
  const sprite = SPRITES[id];

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
 * 16x16 sprite 의 문자 정의 (직업별 공통 시맨틱).
 *  . = 투명
 *  o = 짙은 외곽선
 *  s = 피부
 *  e = 눈
 *  r = 볼터치 (블러시)
 *  M = 입 (작은 미소)
 *  h = 모자/헬멧/후드 주 색상
 *  H = 모자/헬멧 보조 색상 (그림자/띠)
 *  S = 모자 장식 (별/깃털 등)
 *  c = 옷 주 색상
 *  C = 옷 보조 색상 (망토/안감)
 *  b = 벨트/끈
 *  g = 금속/금속 장식
 *  m = 무기 금속 (silver/blade)
 *  w = 무기 손잡이 (나무)
 *  G = 마법/정령 글로우
 */
const SPRITES: Record<CharacterId, string[]> = {
  // 전사: 뿔 달린 헬멧 + 금장 갑옷 + 미소
  warrior: [
    "................",
    "....h.....h.....",
    "....hh...hh.....",
    "...ohhhhhhho....",
    "..ohhhhhhhhho...",
    "..oHHHHHHHHHo...",
    "...ohseesho.....",
    "...ohsrMrsho....",
    "....ossssoo.....",
    "..mccccccccm....",
    "..ccgmmmgccc....",
    "..ccbbbbbbcc....",
    "..ccccccccc.....",
    "...cc...cc......",
    "...oo...oo......",
    "................",
  ],
  // 마법사: 별 달린 고깔모자 + 보라 로브 + 지팡이(오른쪽)
  mage: [
    "................",
    "........S.......",
    ".......hSh......",
    "......hhhh......",
    ".....hhhhhh.....",
    "....hhhhhhhh....",
    "...hhhhhhhhhh...",
    "..HHHHHHHHHHHH..",
    "....osseso......",
    "....osMrso..G...",
    "....osssso..G...",
    "...CcccccccC.G..",
    "..Cccgggccc.Gw..",
    "..Ccccccccc..w..",
    "..occcccccco.w..",
    "................",
  ],
  // 궁수: 깃털 달린 후드 + 가죽끈(어깨) + 활(오른쪽)
  archer: [
    "................",
    ".......hhS......",
    "......hhhhS.....",
    ".....hhhhhh.....",
    "....hhhhhhhh....",
    "...hHHHHHHHh....",
    "...hosesseh.....",
    "...hosrMrsh.....",
    "....ossssoo.....",
    "..bccccccccm....",
    "..ccbcccccc.m...",
    "..cccbcccccgw...",
    "..ccccbcccc.m...",
    "...cc.bb.cc.m...",
    "...oo....oo.....",
    "................",
  ],
  // 소환사: 깊은 후드 + 빛나는 눈 + 망토 + 옆을 떠다니는 정령
  summoner: [
    "................",
    "....hhhhhhh.....",
    "...hhhhhhhhh....",
    "..hhhhhhhhhhh...",
    "..hhHHHHHHHhh...",
    "..hHH.....HHh...",
    "..hH.eee.e.Hh...",
    "..hH.......Hh...",
    "..ohHHHHHHHho...",
    "..CChhhhhhCC.G..",
    ".CcccccccccC.G..",
    ".Cccccgcccc..G..",
    ".CcCcccccCcC....",
    ".CCcccccccCC....",
    ".occcccccccco...",
    "................",
  ],
};

type Palette = Record<string, string>;

const PALETTES: Record<CharacterId, Palette> = {
  // 전사: 빨간 갑옷 + 은빛 헬멧 + 금장
  warrior: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    r: "#ff8a8a",
    M: "#1a0e10",
    h: "#a8adba",
    H: "#5a5d68",
    c: "#c34a2c",
    C: "#7a1e0a",
    b: "#5a2a14",
    g: "#f0c97c",
    m: "#e8e8f0",
  },
  // 마법사: 보라 고깔모자 + 별 + 빛나는 오브
  mage: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#cba8ff",
    r: "#ff8a8a",
    M: "#1a0e10",
    h: "#3a1d80",
    H: "#1a0e3f",
    S: "#fdf8ec",
    c: "#7a4cf0",
    C: "#3a1d80",
    g: "#f0c97c",
    w: "#7c5230",
    G: "#cba8ff",
  },
  // 궁수: 녹색 후드 + 깃털 + 가죽
  archer: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    r: "#ff8a8a",
    M: "#1a0e10",
    h: "#21501f",
    H: "#0f2410",
    S: "#cf9342",
    c: "#3ea33a",
    C: "#21501f",
    b: "#794c24",
    g: "#cf9342",
    m: "#7cd66a",
    w: "#794c24",
  },
  // 소환사: 어두운 후드 + 빛나는 청록 눈 + 정령
  summoner: {
    o: "#0a0610",
    e: "#7be3ff",
    h: "#1a1428",
    H: "#3a1d50",
    c: "#2a1450",
    C: "#0f0b17",
    g: "#33c4ff",
    G: "#7be3ff",
  },
};

// 모든 sprite 행이 정확히 16자 인지 개발 모드에서 검증
if (import.meta.env.DEV) {
  for (const [id, sprite] of Object.entries(SPRITES)) {
    sprite.forEach((row, i) => {
      if (row.length !== 16) {
        console.warn(
          `[PixelCharacter] sprite ${id} row ${i} 길이=${row.length} (16 이어야 함): "${row}"`,
        );
      }
    });
  }
}
