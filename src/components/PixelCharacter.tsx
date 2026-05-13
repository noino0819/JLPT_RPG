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
 * 가벼운 SVG 픽셀 도트 캐릭터.
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
  const px = size / 16; // 16x16 grid
  const sty = (col: number, row: number, color: string) => ({
    left: col * px,
    top: row * px,
    width: px,
    height: px,
    background: color,
    position: "absolute" as const,
  });

  const palette = PALETTES[id];

  return (
    <div className="relative h-full w-full">
      {SPRITE.map((row, r) =>
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
 * 16x16 sprite — '.' 투명, 키별 색상.
 *  o = outline (검정)
 *  s = skin
 *  h = hair / hat
 *  c = cloth (몸통)
 *  b = belt
 *  w = weapon shaft
 *  m = weapon metal/glow
 *  e = eye
 */
const SPRITE = [
  "................",
  "....oooooo......",
  "...ohhhhho......",
  "...ohhhhho......",
  "...osesseo......",
  "....oooooom.....",
  "..occcccoom.....",
  ".oc cccc oom....",
  ".occcccccm......",
  "..oc bb co......",
  "...ooo ooo......",
  "...os..so.......",
  "...os..so.......",
  "..oso..oso......",
  "..ooo..ooo......",
  "................",
];

type Palette = Record<string, string>;

const PALETTES: Record<CharacterId, Palette> = {
  warrior: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    h: "#7c5230",
    c: "#c34a2c",
    b: "#5a2a14",
    w: "#a08266",
    m: "#e8e8f0",
  },
  mage: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    h: "#3a1d80",
    c: "#7a4cf0",
    b: "#3a1d80",
    w: "#7c5230",
    m: "#cba8ff",
  },
  archer: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    h: "#21501f",
    c: "#3ea33a",
    b: "#21501f",
    w: "#7c5230",
    m: "#7cd66a",
  },
  summoner: {
    o: "#0a0610",
    s: "#f3c9a4",
    e: "#1a0e10",
    h: "#bd8434",
    c: "#e6c374",
    b: "#794c24",
    w: "#5b3919",
    m: "#fdf8ec",
  },
};
