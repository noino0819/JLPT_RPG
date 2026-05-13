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

/**
 * 소환사 — 적의 위치에 황금 소환진(링)이 잠깐 떠오르고,
 * 좌측에서 소환된 정령(황금 오브 + 작은 눈)이 빠르게 날아와 적에게 부딪힌다.
 * "정령을 소환해서 정령이 대신 싸운다" 는 컨셉을 시각적으로 강조.
 */
function Ring() {
  return (
    <>
      <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
        <div className="animate-ring">
          <div
            className="rounded-full"
            style={{
              width: 90,
              height: 90,
              border: "4px solid #ffd84a",
              boxShadow:
                "0 0 0 2px rgba(255,224,102,0.6), 0 0 28px rgba(240,201,124,0.7)",
            }}
          />
        </div>
      </div>
      <SummonedSpiritFlight />
    </>
  );
}

function SummonedSpiritFlight() {
  // 좌측에서 우측으로 빠르게 날아드는 황금 정령. 약간 시간차로 두 마리.
  const spirits = [
    { dy: -8, delay: "0s" },
    { dy: 10, delay: "0.08s" },
  ];
  return (
    <>
      {spirits.map((s, i) => (
        <div
          key={i}
          className="absolute left-1 top-1/2 -translate-y-1/2"
          style={{ marginTop: s.dy }}
        >
          <div className="animate-arrow" style={{ animationDelay: s.delay }}>
            <SpiritOrb />
          </div>
        </div>
      ))}
    </>
  );
}

function SpiritOrb() {
  // 작은 황금 영체 — 빛나는 코어 + 외곽 흔들리는 후광 느낌의 단순 도트 오브
  return (
    <div className="relative" style={{ width: 28, height: 18 }}>
      <span
        className="absolute inset-0 rounded-full"
        style={{
          background:
            "radial-gradient(circle at 40% 40%, #fff5c2 0%, #ffe066 45%, rgba(207,147,66,0.0) 80%)",
          boxShadow: "0 0 12px rgba(255,224,102,0.85)",
        }}
      />
      {/* 정령의 작은 눈 두 개 (귀여움 가미) */}
      <span
        className="absolute"
        style={{
          left: 9,
          top: 6,
          width: 2,
          height: 3,
          background: "#1a0e10",
        }}
      />
      <span
        className="absolute"
        style={{
          left: 14,
          top: 6,
          width: 2,
          height: 3,
          background: "#1a0e10",
        }}
      />
    </div>
  );
}
