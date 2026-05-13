import { useEffect, useRef, useState, type CSSProperties } from "react";
import type { JlptLevel } from "../types";

export type MonsterState = "idle" | "hurt" | "dying" | "dead";

interface Props {
  level: JlptLevel;
  size?: number;
  state?: MonsterState;
  /** 등장 시 위에서 떨어지는 인트로 애니메이션 */
  entrance?: boolean;
}

/**
 * 보스 픽셀 몬스터 (16x16). 던전 테마에 따라 5종.
 *  - idle    : 천천히 흔들흔들 (animate-bobSlow)
 *  - hurt    : 붉게 깜빡 + 좌우 흔들기 (animate-monsterHurt)
 *  - dying   : 사망 직전 — 깜빡깜빡하며 산산조각 직전
 *  - dead    : 모두 떨어져나가 흩어짐 (영혼 승천 + shatter)
 *
 * 사망 모션은 보스가 산산조각으로 흩어지면서 영혼이 위로 떠오르는 식으로 연출.
 * 부모는 state 만 바꿔주면 된다.
 */
export default function PixelMonster({
  level,
  size = 96,
  state = "idle",
  entrance = false,
}: Props) {
  const sprite = SPRITES[level];
  const palette = PALETTES[level];
  const px = size / 16;

  // 사망 모션은 산산조각용 dx/dy 를 사전 계산 (랜덤성 고정)
  const shatterRef = useRef<Array<{ dx: number; dy: number; rot: number }>>(
    [],
  );
  if (shatterRef.current.length === 0) {
    for (let i = 0; i < 256; i += 1) {
      const angle = Math.random() * Math.PI * 2;
      const dist = 60 + Math.random() * 80;
      shatterRef.current.push({
        dx: Math.cos(angle) * dist,
        dy: Math.sin(angle) * dist - 20,
        rot: (Math.random() - 0.5) * 720,
      });
    }
  }

  // dying → dead 트리거 후, 셔터 시작 시점을 단일 키로 동기화
  const [shatterKey, setShatterKey] = useState(0);
  useEffect(() => {
    if (state === "dead") {
      setShatterKey((k) => k + 1);
    }
  }, [state]);

  const containerAnim =
    state === "hurt"
      ? "animate-monsterHurt"
      : state === "dying"
        ? "animate-monsterDying"
        : entrance
          ? "animate-bossEntrance"
          : "animate-bobSlow";

  const cellSty = (col: number, row: number, color: string) => {
    const base: CSSProperties = {
      left: col * px,
      top: row * px,
      width: px,
      height: px,
      background: color,
      position: "absolute",
    };
    return base;
  };

  return (
    <div
      className="relative"
      style={{ width: size, height: size }}
      aria-label={`보스 ${level}`}
    >
      {/* 바닥 그림자 (사망 시 함께 페이드) */}
      <span
        className={`pointer-events-none absolute left-1/2 -translate-x-1/2 rounded-full bg-black/40 blur-[2px] transition-opacity ${
          state === "dead" ? "opacity-0" : "opacity-70"
        }`}
        style={{
          width: size * 0.7,
          height: Math.max(4, px * 1.2),
          bottom: -px * 0.8,
        }}
      />

      {/* 죽은 상태일 때만 영혼 승천 이펙트 */}
      {state === "dead" && (
        <SoulRise size={size} key={`soul-${shatterKey}`} />
      )}

      <div
        className={`relative h-full w-full ${
          state === "dead" ? "" : containerAnim
        }`}
      >
        {/* 살아있을 때: 평소대로 도트 렌더 */}
        {state !== "dead" && (
          <div className="relative h-full w-full">
            {sprite.map((row, r) =>
              row.split("").map((ch, c) => {
                const color = palette[ch];
                if (!color) return null;
                return (
                  <span key={`${r}-${c}`} style={cellSty(c, r, color)} />
                );
              }),
            )}
            {/* hurt 시 붉은 오버레이 (도트 위에 깜빡) */}
            {state === "hurt" && (
              <div className="pointer-events-none absolute inset-0 animate-hurtFlash bg-red-500/55 mix-blend-overlay" />
            )}
          </div>
        )}

        {/* 죽었을 때: 모든 픽셀이 산산조각으로 흩어짐 */}
        {state === "dead" && (
          <div className="relative h-full w-full" key={shatterKey}>
            {sprite.map((row, r) =>
              row.split("").map((ch, c) => {
                const color = palette[ch];
                if (!color) return null;
                const idx = r * 16 + c;
                const sh = shatterRef.current[idx % shatterRef.current.length];
                const css: CSSProperties = {
                  ...cellSty(c, r, color),
                  // CSS 변수로 keyframe 에 방향 전달
                  ["--dx" as never]: `${sh.dx.toFixed(1)}px`,
                  ["--dy" as never]: `${sh.dy.toFixed(1)}px`,
                  ["--rot" as never]: `${sh.rot.toFixed(0)}deg`,
                  animationDelay: `${(((r + c) % 5) * 0.02).toFixed(2)}s`,
                };
                return (
                  <span
                    key={`d-${r}-${c}`}
                    className="animate-monsterShatter"
                    style={css}
                  />
                );
              }),
            )}
          </div>
        )}
      </div>
    </div>
  );
}

/** 보스 사망 시 위로 떠오르는 영혼 (희미한 빛) */
function SoulRise({ size }: { size: number }) {
  return (
    <div className="pointer-events-none absolute inset-0">
      {Array.from({ length: 8 }).map((_, i) => {
        const dx = (i - 4) * (size / 12) + (Math.random() - 0.5) * 8;
        const delay = Math.random() * 0.3;
        const dur = 1.4 + Math.random() * 0.5;
        const sz = Math.max(6, size / 16);
        const css: CSSProperties = {
          width: sz,
          height: sz,
          left: "50%",
          bottom: "30%",
          background:
            "radial-gradient(circle, #fff 0%, #cdeeff 40%, transparent 80%)",
          borderRadius: "50%",
          ["--dx" as never]: `${dx.toFixed(1)}px`,
          animationDelay: `${delay.toFixed(2)}s`,
          animationDuration: `${dur.toFixed(2)}s`,
        };
        return (
          <span
            key={i}
            className="absolute block animate-soulRise"
            style={css}
          />
        );
      })}
    </div>
  );
}

/**
 * 16x16 보스 sprite — 던전별 차별화.
 *  공통 시맨틱:
 *  . = 투명
 *  o = 짙은 외곽선
 *  e = 빛나는 눈 (강조)
 *  M = 입/이빨
 *  // 슬라임 (N5)
 *  s = 슬라임 본체 (밝음)
 *  S = 슬라임 본체 (어두운 그림자)
 *  C = 왕관 금색
 *  c = 왕관 보석
 *  // 박쥐 (N4)
 *  b = 박쥐 몸통/날개 본체
 *  B = 박쥐 그림자
 *  k = 송곳니 (밝은 흰색)
 *  // 골렘 (N3)
 *  g = 돌 밝은면
 *  G = 돌 어두운면
 *  R = 룬 글로우 (빨간/오렌지)
 *  // 드래곤 (N2)
 *  d = 비늘 밝은 적
 *  D = 비늘 어두운 적
 *  L = 용암/불꽃
 *  l = 용암 글로우
 *  // 마왕 (N1)
 *  h = 망토/몸통 (어두움)
 *  H = 망토 그림자
 *  K = 뿔/금색 장식
 *  P = 보라 글로우
 */
const SPRITES: Record<JlptLevel, string[]> = {
  // N5 시작의 숲: 슬라임 군주 — 둥글둥글한 슬라임 + 왕관
  N5: [
    "................",
    "......C..C......",
    "......CccC......",
    ".....CCCCCC.....",
    "................",
    "....oosssoo.....",
    "...osssssssoo...",
    "..ossSSSSssso...",
    "..osseSSeSsso...",
    "..ossSSSSSSso..",
    "..osssSMMSsso..",
    "..oSSSSSSSSSo..",
    "...oSSSSSSSo...",
    "....oooooo.....",
    "................",
    "................",
  ],
  // N4 동굴: 박쥐 군주 — 거대한 날개 + 빨간 눈 + 송곳니
  N4: [
    "................",
    "..o..........o..",
    ".obo........obo.",
    ".obbo......obbo.",
    "obbBbo....obBbbo",
    "obBbbbo..obbbBbo",
    "obbbBbbooBbbbbbo",
    ".obBbobbbboBbbo.",
    "..ooobeeeeboooo.",
    "....obkMMkbo....",
    "....obkkkkbo....",
    "....obbBbbbo....",
    ".....obbbbo.....",
    "......oBbo......",
    ".......oo.......",
    "................",
  ],
  // N3 고대 유적: 석상 골렘 — 거대한 돌 어깨 + 룬 눈
  N3: [
    "................",
    "...ooooooooo....",
    "..oggggggggGo...",
    "..ogGgggggGGo...",
    "..oggReReGGGo...",
    "..oggggMggGGo...",
    "..ogGggGGGGGo...",
    ".oooooooooooo...",
    "ogGggggggggGGGo.",
    "ogGggGGGgggGGGo.",
    "ogGggGGGgggGGGo.",
    "ogGggGGGgggGGGo.",
    "ogGGGGGGGGGGGGo.",
    "oooo.....oooooo.",
    "...o.....o......",
    "................",
  ],
  // N2 화산: 용암 드래곤 — 거대 머리 + 빛나는 눈 + 화염 숨결
  N2: [
    "..............l.",
    "............l...",
    "...........l.l..",
    ".....ooo..lLLl..",
    "....odddo.lLLl..",
    "...odDdDdolLll..",
    "..odDdDdDolLLll.",
    "..odeMMMedolLLl.",
    "..odMMkMMdolLLl.",
    "..oDDdDdDDolLll.",
    "...oDdDdDdo.lll.",
    "....oDDdDDo..ll.",
    "....oDDDDDo..l..",
    "....ooDDDoo.....",
    ".....ooooo......",
    "................",
  ],
  // N1 천공의 신전: 마왕 — 큰 뿔 + 보라 글로우 망토 + 빛나는 눈
  N1: [
    "...K........K...",
    "...KK......KK...",
    "...oKo....oKo...",
    "....oKooooKo....",
    ".....oHhhhho....",
    ".....oheehHo....",
    ".....oHkMkHo....",
    "....oHHhHhHHo...",
    "...oHHhhhhhHHo..",
    "..oHPHHhhHHPHo..",
    ".oHHPPPHhPPPHHo.",
    "oHHHPPHhhHPPHHHo",
    "oHHHHPPhhPPHHHHo",
    ".oHHHPPPPPPHHHo.",
    "..oHHHHHHHHHHo..",
    "...oooooooooo...",
  ],
};

type Palette = Record<string, string>;

const PALETTES: Record<JlptLevel, Palette> = {
  // N5 슬라임 군주: 진한 녹색 + 금왕관
  N5: {
    o: "#0a1a0a",
    s: "#5dc94c",
    S: "#1f6a22",
    e: "#fdf8ec",
    M: "#0a1a0a",
    C: "#f0c97c",
    c: "#33c4ff",
  },
  // N4 박쥐 군주: 검보라 박쥐 + 빨간 눈 + 흰 송곳니
  N4: {
    o: "#0a0610",
    b: "#3a2a52",
    B: "#1a0e2c",
    e: "#ff3a3a",
    M: "#0a0610",
    k: "#fdf8ec",
  },
  // N3 골렘: 회색 돌 + 룬 빨강 눈 + 어두운 입
  N3: {
    o: "#0a0610",
    g: "#a89c80",
    G: "#5a4f3c",
    e: "#ffaa3a",
    M: "#0a0610",
    R: "#ff5a18",
  },
  // N2 드래곤: 빨강 비늘 + 노란 눈 + 용암 화염
  N2: {
    o: "#1a0608",
    d: "#e64518",
    D: "#7a1e0a",
    e: "#ffd966",
    M: "#0a0610",
    k: "#fdf8ec",
    L: "#ff8a4c",
    l: "#ffd966",
  },
  // N1 마왕: 검은 망토 + 보라 글로우 + 황금 뿔 + 빛나는 눈
  N1: {
    o: "#0a0610",
    h: "#1a0e2c",
    H: "#0a0610",
    e: "#cba8ff",
    M: "#0a0610",
    K: "#f0c97c",
    P: "#7a4cf0",
    k: "#fdf8ec",
  },
};

if (import.meta.env.DEV) {
  for (const [id, sprite] of Object.entries(SPRITES)) {
    sprite.forEach((row, i) => {
      if (row.length !== 16) {
        console.warn(
          `[PixelMonster] sprite ${id} row ${i} 길이=${row.length} (16 이어야 함): "${row}"`,
        );
      }
    });
  }
}
