import { useEffect, useState } from "react";
import { CHARACTERS } from "../data/characters";
import type { CharacterId } from "../types";

interface Props {
  characterId: CharacterId;
  /** 트리거가 변경될 때마다 새 이펙트 발사 */
  trigger: number;
}

/** 카드 위에 캐릭터별 차별화된 공격 이펙트를 잠깐 보여줌 */
export default function AttackEffect({ characterId, trigger }: Props) {
  const [active, setActive] = useState(0);
  const meta = CHARACTERS[characterId];

  useEffect(() => {
    if (trigger === 0) return;
    setActive(trigger);
    const t = setTimeout(() => setActive(0), 700);
    return () => clearTimeout(t);
  }, [trigger]);

  if (!active) return null;

  return (
    <div
      key={active}
      className="pointer-events-none absolute inset-0 overflow-hidden"
    >
      {meta.effect === "slash" && <Slash />}
      {meta.effect === "particles" && <Particles />}
      {meta.effect === "arrow" && <Arrow />}
      {meta.effect === "ring" && <Ring />}
    </div>
  );
}

function Slash() {
  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
      <div className="animate-slash">
        <svg width="120" height="120" viewBox="0 0 120 120">
          <line
            x1="10"
            y1="110"
            x2="110"
            y2="10"
            stroke="white"
            strokeWidth="6"
            strokeLinecap="square"
          />
          <line
            x1="20"
            y1="100"
            x2="100"
            y2="20"
            stroke="rgba(255,255,255,0.6)"
            strokeWidth="2"
            strokeLinecap="square"
          />
        </svg>
      </div>
    </div>
  );
}

function Particles() {
  const dots = Array.from({ length: 16 });
  return (
    <div className="absolute left-1/2 top-1/2 h-0 w-0 -translate-x-1/2 -translate-y-1/2">
      {dots.map((_, i) => {
        const angle = (i / dots.length) * Math.PI * 2;
        const dist = 40 + Math.random() * 30;
        const dx = Math.cos(angle) * dist;
        const dy = Math.sin(angle) * dist;
        return (
          <span
            key={i}
            className="absolute block h-2 w-2 animate-floatUp bg-sky-400"
            style={{
              transform: `translate(${dx}px, ${dy}px)`,
              animationDuration: `${0.5 + Math.random() * 0.4}s`,
            }}
          />
        );
      })}
    </div>
  );
}

function Arrow() {
  return (
    <div className="absolute left-2 top-1/2 -translate-y-1/2">
      <div className="animate-arrow">
        <svg width="80" height="20" viewBox="0 0 80 20">
          <line
            x1="0"
            y1="10"
            x2="68"
            y2="10"
            stroke="#7cd66a"
            strokeWidth="3"
          />
          <polygon points="68,4 80,10 68,16" fill="#7cd66a" />
        </svg>
      </div>
    </div>
  );
}

function Ring() {
  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
      <div className="animate-ring">
        <div
          className="rounded-full border-4 border-parchment-300"
          style={{
            width: 80,
            height: 80,
            boxShadow:
              "0 0 0 2px rgba(207,147,66,0.5), 0 0 24px rgba(240,201,124,0.5)",
          }}
        />
      </div>
    </div>
  );
}
