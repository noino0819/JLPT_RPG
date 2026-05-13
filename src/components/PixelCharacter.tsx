import { useEffect, useState } from "react";
import { CHARACTERS } from "../data/characters";
import { COSTUMES_BY_ID } from "../data/cosmetics";
import type { CharacterId } from "../types";

interface Props {
  id: CharacterId;
  attacking?: boolean;
  size?: number;
  showName?: boolean;
  // 옷장에서 장착한 코스튬 id. 없으면 기본 팔레트.
  costumeId?: string;
}

/**
 * Box-shadow 픽셀아트 + 다중 프레임 애니메이션.
 *
 * idle 상태   : 호흡/머리 흔들/깜빡임 등 정적 모션을 위해 idle 프레임을
 *               일정 간격(380ms)으로 순환 재생.
 * attack 상태 : `attacking` prop 이 true 인 동안 windup → swing → impact
 *               순서로 빠르게(110ms) 프레임을 재생해 무기를 휘두르는
 *               느낌을 표현. 동시에 기존 attackSwing transform 도 같이
 *               동작해 몸이 살짝 기울며 임팩트를 강조한다.
 *
 * 캐릭터마다 다른 16x16 sprite 와 팔레트를 사용해 직업별 특징
 * (헬멧/사도 고깔/후드/망토)이 한눈에 보이도록 차별화.
 */
export default function PixelCharacter({
  id,
  attacking = false,
  size = 72,
  showName = false,
  costumeId,
}: Props) {
  const c = CHARACTERS[id];
  const [idleFrame, setIdleFrame] = useState(0);
  const [attackFrame, setAttackFrame] = useState(0);

  // idle 프레임 순환 — 호흡/깜빡임 등 미세 모션
  useEffect(() => {
    if (attacking) return;
    const total = FRAMES[id].idle.length;
    if (total <= 1) return;
    const interval = setInterval(() => {
      setIdleFrame((f) => (f + 1) % total);
    }, 380);
    return () => clearInterval(interval);
  }, [id, attacking]);

  // attack 프레임 — windup → release 순서로 빠르게 재생 후 마지막 프레임 유지
  useEffect(() => {
    if (!attacking) {
      setAttackFrame(0);
      return;
    }
    const total = FRAMES[id].attack.length;
    setAttackFrame(0);
    if (total <= 1) return;
    let i = 0;
    const interval = setInterval(() => {
      i = Math.min(i + 1, total - 1);
      setAttackFrame(i);
    }, 110);
    return () => clearInterval(interval);
  }, [id, attacking]);

  const frames = FRAMES[id];
  const sprite = attacking
    ? (frames.attack[attackFrame] ?? frames.attack[0])
    : (frames.idle[idleFrame] ?? frames.idle[0]);

  return (
    <div className="flex flex-col items-center gap-1">
      <div
        className={`relative ${attacking ? "animate-attackSwing" : "animate-bob"}`}
        style={{ width: size, height: size }}
      >
        <CharacterSprite
          id={id}
          size={size}
          costumeId={costumeId}
          sprite={sprite}
        />
      </div>
      {showName && (
        <div className="font-pixel text-[10px] text-parchment-200">
          {c.nameJp} · {c.name}
        </div>
      )}
    </div>
  );
}

function CharacterSprite({
  id,
  size,
  costumeId,
  sprite,
}: {
  id: CharacterId;
  size: number;
  costumeId?: string;
  sprite: string[];
}) {
  const px = size / 16;
  const sty = (col: number, row: number, color: string) => ({
    left: col * px,
    top: row * px,
    width: px,
    height: px,
    background: color,
    position: "absolute" as const,
  });

  // 코스튬 = 베이스 팔레트 + override 키만 덮어쓰기.
  // 같은 캐릭터가 아닌 코스튬 id 가 들어오면 무시 (안전장치).
  const base = PALETTES[id];
  const costume = costumeId ? COSTUMES_BY_ID[costumeId] : undefined;
  const palette =
    costume && costume.characterId === id
      ? { ...base, ...costume.paletteOverride }
      : base;

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
const FRAMES: Record<
  CharacterId,
  { idle: string[][]; attack: string[][] }
> = {
  // 전사: 뿔 헬멧 + 갑옷, 공격 시 검을 머리 위로 들었다가 우측으로 휘두름
  warrior: {
    idle: [
      [
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
      // idle 보조 프레임 — 머리를 살짝 오른쪽으로 기울이고 눈을 감음 (호흡)
      [
        "................",
        ".....h.....h....",
        ".....hh...hh....",
        "....ohhhhhhho...",
        "...ohhhhhhhhho..",
        "...oHHHHHHHHHo..",
        "....ohsoosho....",
        "....ohsrMrsho...",
        ".....ossssoo....",
        "..mccccccccm....",
        "..ccgmmmgccc....",
        "..ccbbbbbbcc....",
        "..ccccccccc.....",
        "...cc...cc......",
        "...oo...oo......",
        "................",
      ],
    ],
    attack: [
      // windup — 검을 머리 위로 치켜듦
      [
        ".............m..",
        "....h.....h..m..",
        "....hh...hh..m..",
        "...ohhhhhhho.m..",
        "..ohhhhhhhhhomm.",
        "..oHHHHHHHHHom..",
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
      // swing — 검을 우측으로 강하게 휘두름
      [
        "................",
        "....h.....h.....",
        "....hh...hh.....",
        "...ohhhhhhho....",
        "..ohhhhhhhhho.m.",
        "..oHHHHHHHHHommm",
        "...ohseesho.....",
        "...ohsrMrsho....",
        "....ossssoo.....",
        "..mccccccccmmmmm",
        "..ccgmmmgccc....",
        "..ccbbbbbbcc....",
        "..ccccccccc.....",
        "...cc...cc......",
        "...oo...oo......",
        "................",
      ],
    ],
  },

  // 마법사: 별 고깔 + 보라 로브 + 지팡이, 공격 시 오브가 빛나며 마법 발사
  mage: {
    idle: [
      [
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
      // idle 보조 프레임 — 고깔이 살짝 오른쪽으로 흔들리고 눈을 깜빡임
      [
        "................",
        ".........S......",
        "........hSh.....",
        ".......hhhh.....",
        "......hhhhhh....",
        ".....hhhhhhhh...",
        "....hhhhhhhhhh..",
        "..HHHHHHHHHHHH..",
        "....ossoso......",
        "....osMrso..G...",
        "....osssso..G...",
        "...CcccccccC.G..",
        "..Cccgggccc.Gw..",
        "..Ccccccccc..w..",
        "..occcccccco.w..",
        "................",
      ],
    ],
    attack: [
      // windup — 오브가 충전되며 글로우가 점점 커짐
      [
        "................",
        "........S.......",
        ".......hSh......",
        "......hhhh......",
        ".....hhhhhh.....",
        "....hhhhhhhh....",
        "...hhhhhhhhhh...",
        "..HHHHHHHHHHHH..",
        "....osseso.GGG..",
        "....osMrso.GGGG.",
        "....osssso.GGGG.",
        "...CcccccccCGG..",
        "..Cccgggccc.Gw..",
        "..Ccccccccc..w..",
        "..occcccccco.w..",
        "................",
      ],
      // release — 마법 빔이 우측으로 발사
      [
        "................",
        "........S.......",
        ".......hSh......",
        "......hhhh......",
        ".....hhhhhh.....",
        "....hhhhhhhh....",
        "...hhhhhhhhhh...",
        "..HHHHHHHHHHHH..",
        "....osseso..GGGG",
        "....osMrso.GGGGG",
        "....osssso..GGGG",
        "...CcccccccC.G..",
        "..Cccgggccc.Gw..",
        "..Ccccccccc..w..",
        "..occcccccco.w..",
        "................",
      ],
    ],
  },

  // 궁수: 깃털 후드 + 가죽, 공격 시 활을 당겨 화살이 날아감
  archer: {
    idle: [
      [
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
      // idle 보조 — 눈 깜빡 + 활시위 살짝 떨림
      [
        "................",
        ".......hhS......",
        "......hhhhS.....",
        ".....hhhhhh.....",
        "....hhhhhhhh....",
        "...hHHHHHHHh....",
        "...hosossoh.....",
        "...hosrMrsh.....",
        "....ossssoo.....",
        "..bccccccccm....",
        "..ccbccccccm....",
        "..cccbcccccgw...",
        "..ccccbccccm....",
        "...cc.bb.ccm....",
        "...oo....oo.....",
        "................",
      ],
    ],
    attack: [
      // windup — 화살을 시위에 끼우고 우측으로 정조준
      [
        "................",
        ".......hhS......",
        "......hhhhS.....",
        ".....hhhhhh.....",
        "....hhhhhhhh....",
        "...hHHHHHHHh....",
        "...hoseesoh.....",
        "...hosrMrsh.....",
        "....ossssoo.....",
        "..bccccccccm....",
        "..ccbcccccc.m...",
        "..cccbcccccgwmmm",
        "..ccccbcccc.m...",
        "...cc.bb.cc.m...",
        "...oo....oo.....",
        "................",
      ],
      // release — 화살이 날아가고 시위가 튕겨 돌아옴
      [
        "................",
        ".......hhS......",
        "......hhhhS.....",
        ".....hhhhhh.....",
        "....hhhhhhhh....",
        "...hHHHHHHHh....",
        "...hoseesoh.....",
        "...hosrMrsh.....",
        "....ossssoo.....",
        "..bccccccccm....",
        "..ccbccccccm....",
        "..cccbcccccgw...",
        "..ccccbccccm....",
        "...cc.bb.ccm....",
        "...oo....oo.....",
        "................",
      ],
    ],
  },

  // 소환사: 어두운 망토 + 황금빛 정령 한쌍을 양쪽에 거느림.
  // 공격 시 정령들이 휘몰아치며 우측 적에게 쏟아짐.
  summoner: {
    idle: [
      [
        "................",
        "....hhhhhhh.....",
        "...hhhhhhhhh....",
        "..hhhhhhhhhhh...",
        "..hhHHHHHHHhh...",
        "..hHH.....HHh...",
        "..hH.eee.e.Hh...",
        "..hH.......Hh...",
        "..ohHHHHHHHho...",
        "G.CChhhhhhCC.G..",
        ".CcccccccccC.G..",
        "GCccccgccccCG...",
        ".CcCcccccCcC....",
        ".CCcccccccCC....",
        ".occcccccccco...",
        "................",
      ],
      // idle 보조 — 정령들이 살짝 위로 떠오르고 눈을 한 번 깜빡임
      [
        "................",
        "....hhhhhhh.....",
        "...hhhhhhhhh....",
        "..hhhhhhhhhhh...",
        "..hhHHHHHHHhh...",
        "G.hHH.....HHhG..",
        ".GhH.e.eee.HhG..",
        ".GhH.......HhG..",
        "..ohHHHHHHHho...",
        "..CChhhhhhCC....",
        ".CcccccccccC....",
        ".CcccCgccccC....",
        ".CcCcccccCcC....",
        ".CCcccccccCC....",
        ".occcccccccco...",
        "................",
      ],
    ],
    attack: [
      // windup — 양옆 정령들이 소환사 주변에 폭발적으로 응집 (소환진 형성)
      [
        "................",
        "GG..hhhhhhh.GG..",
        "GG.hhhhhhhhh.GG.",
        "G.hhhhhhhhhhh.GG",
        "..hhHHHHHHHhh..G",
        "G.hHH.....HHhG..",
        "GGhH.eee.e.HhGG.",
        "G.hH.......HhGG.",
        ".GohHHHHHHHhoGG.",
        "..CChhhhhhCC.GGG",
        ".CcccccccccC.GG.",
        ".Cccccgcccc..GG.",
        ".CcCcccccCcC....",
        ".CCcccccccCC....",
        ".occcccccccco...",
        "................",
      ],
      // release — 응집한 정령 무리가 우측 전방으로 일제히 쏟아져 적에게 돌격
      [
        "................",
        "....hhhhhhh.....",
        "...hhhhhhhhh.GGG",
        "..hhhhhhhhhhhGGG",
        "..hhHHHHHHHhhGGG",
        "..hHH.....HHhGGG",
        "..hH.eee.e.HhGGG",
        "..hH.......HhGGG",
        "..ohHHHHHHHhoGGG",
        "..CChhhhhhCC.GGG",
        ".CcccccccccC.GGG",
        ".Cccccgcccc..GGG",
        ".CcCcccccCcC.GG.",
        ".CCcccccccCC.G..",
        ".occcccccccco...",
        "................",
      ],
    ],
  },
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
  // 소환사: 어두운 망토 + 황금빛 정령. 따뜻한 옐로우/골드로 테마 통일.
  summoner: {
    o: "#0a0610",
    e: "#ffe066", // 정령의 빛이 깃든 황금 눈
    h: "#1a1428", // 망토 본색 (어둠)
    H: "#2a1f3a", // 망토 그림자 — 살짝 보라가 도는 차분한 어둠
    c: "#2a1450", // 안감
    C: "#0f0b17", // 망토 외곽
    g: "#ffd84a", // 망토 금장 트림
    G: "#ffe066", // 소환된 정령의 발광 (황금 빛)
  },
};

// 모든 sprite 행이 정확히 16자 인지 개발 모드에서 검증
if (import.meta.env.DEV) {
  for (const [id, framesByState] of Object.entries(FRAMES)) {
    (["idle", "attack"] as const).forEach((state) => {
      framesByState[state].forEach((sprite, fi) => {
        sprite.forEach((row, ri) => {
          if (row.length !== 16) {
            console.warn(
              `[PixelCharacter] ${id}.${state}[${fi}] row ${ri} 길이=${row.length} (16 이어야 함): "${row}"`,
            );
          }
        });
        if (sprite.length !== 16) {
          console.warn(
            `[PixelCharacter] ${id}.${state}[${fi}] 행 개수=${sprite.length} (16 이어야 함)`,
          );
        }
      });
    });
  }
}
