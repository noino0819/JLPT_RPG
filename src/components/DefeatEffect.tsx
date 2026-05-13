import { useEffect, useState, type CSSProperties } from "react";
import type { CharacterId } from "../types";

interface Props {
  characterId: CharacterId;
  /** 트리거가 변경될 때마다 한 번의 처치 이펙트 재생 */
  trigger: number;
}

/**
 * 단어를 마스터(처치) 했을 때 카드 위에 큰 처치 이펙트를 잠깐 보여줌.
 * - 직업별로 파편/별/링/영혼 등 패턴이 다름
 * - 1.1 초 후 자동 종료
 */
export default function DefeatEffect({ characterId, trigger }: Props) {
  const [active, setActive] = useState(0);

  useEffect(() => {
    if (trigger === 0) return;
    setActive(trigger);
    const t = setTimeout(() => setActive(0), 1100);
    return () => clearTimeout(t);
  }, [trigger]);

  if (!active) return null;

  return (
    <div
      key={active}
      className="pointer-events-none absolute inset-0 z-20 overflow-hidden"
    >
      <FlashOverlay color={FLASH_COLOR[characterId]} />
      <CenterText
        label={LABEL[characterId]}
        color={LABEL_COLOR[characterId]}
      />
      {characterId === "warrior" && <WarriorBurst />}
      {characterId === "mage" && <MageBurst />}
      {characterId === "archer" && <ArcherBurst />}
      {characterId === "summoner" && <SummonerBurst />}
    </div>
  );
}

const LABEL: Record<CharacterId, string> = {
  warrior: "처치!",
  mage: "소멸!",
  archer: "명중!",
  // 정령 소환사 — 정령들이 적을 강타하는 의미로 "강타!"
  summoner: "강타!",
};

const LABEL_COLOR: Record<CharacterId, string> = {
  warrior: "#ffd966",
  mage: "#cba8ff",
  archer: "#7cd66a",
  summoner: "#ffe066",
};

const FLASH_COLOR: Record<CharacterId, string> = {
  warrior: "rgba(255, 138, 76, 0.7)",
  mage: "rgba(123, 76, 240, 0.6)",
  archer: "rgba(124, 214, 106, 0.55)",
  summoner: "rgba(255, 224, 102, 0.6)",
};

function FlashOverlay({ color }: { color: string }) {
  return (
    <div
      className="absolute inset-0 animate-flashOverlay"
      style={{ background: color }}
    />
  );
}

function CenterText({ label, color }: { label: string; color: string }) {
  return (
    <div className="absolute inset-0 flex items-center justify-center">
      <div
        className="pixel-text animate-defeatPop font-pixel text-4xl sm:text-5xl"
        style={{
          color,
          textShadow:
            "2px 2px 0 rgba(0,0,0,0.8), 4px 4px 0 rgba(0,0,0,0.4), 0 0 16px " +
            color,
        }}
      >
        {label}
      </div>
    </div>
  );
}

// 카드 중앙 기준으로 (dx, dy) 만큼 흩어지는 파편/별/영혼 한 조각
interface ShardStyle {
  bg: string;
  size: number;
  rounded?: boolean;
}
function Shards({
  count,
  spread,
  style,
  anim = "animate-shatter",
  duration = 0.9,
}: {
  count: number;
  spread: number;
  style: ShardStyle;
  anim?: string;
  duration?: number;
}) {
  return (
    <div className="absolute left-1/2 top-1/2 h-0 w-0 -translate-x-1/2 -translate-y-1/2">
      {Array.from({ length: count }).map((_, i) => {
        const angle = (i / count) * Math.PI * 2 + (Math.random() - 0.5) * 0.4;
        const dist = spread * (0.7 + Math.random() * 0.6);
        const dx = Math.cos(angle) * dist;
        const dy = Math.sin(angle) * dist;
        const css: CSSProperties = {
          width: style.size,
          height: style.size,
          background: style.bg,
          borderRadius: style.rounded ? "50%" : "0",
          // CSS 변수로 keyframe 에 방향 전달
          ["--dx" as never]: `${dx.toFixed(1)}px`,
          ["--dy" as never]: `${dy.toFixed(1)}px`,
          animationDuration: `${(duration * (0.8 + Math.random() * 0.5)).toFixed(2)}s`,
        };
        return <span key={i} className={`absolute block ${anim}`} style={css} />;
      })}
    </div>
  );
}

// 전사: 다중 슬래시 + 금속 파편
function WarriorBurst() {
  return (
    <>
      <div className="absolute inset-0">
        <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
          <div className="animate-slash">
            <svg width="160" height="160" viewBox="0 0 160 160">
              <line
                x1="10"
                y1="150"
                x2="150"
                y2="10"
                stroke="#fff"
                strokeWidth="8"
                strokeLinecap="square"
              />
              <line
                x1="22"
                y1="138"
                x2="138"
                y2="22"
                stroke="rgba(255,255,255,0.55)"
                strokeWidth="3"
              />
            </svg>
          </div>
        </div>
        <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
          <div className="animate-slashAlt">
            <svg width="160" height="160" viewBox="0 0 160 160">
              <line
                x1="150"
                y1="150"
                x2="10"
                y2="10"
                stroke="#ffd966"
                strokeWidth="6"
                strokeLinecap="square"
              />
            </svg>
          </div>
        </div>
      </div>
      <Shards
        count={14}
        spread={90}
        style={{ bg: "#f0c97c", size: 6 }}
      />
      <Shards
        count={10}
        spread={70}
        style={{ bg: "#e8e8f0", size: 4 }}
      />
    </>
  );
}

// 마법사: 별 + 마법 파편 + 보라 글로우
function MageBurst() {
  return (
    <>
      <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
        <div
          className="animate-ring rounded-full"
          style={{
            width: 100,
            height: 100,
            border: "4px solid #cba8ff",
            boxShadow:
              "0 0 0 2px rgba(122,76,240,0.5), 0 0 32px rgba(203,168,255,0.7)",
          }}
        />
      </div>
      <Stars count={8} color="#cba8ff" />
      <Shards
        count={18}
        spread={100}
        style={{ bg: "#7a4cf0", size: 5 }}
      />
      <Shards
        count={10}
        spread={70}
        style={{ bg: "#fdf8ec", size: 3, rounded: true }}
      />
    </>
  );
}

// 궁수: 다중 화살 + 녹색 잎/스파크
function ArcherBurst() {
  const arrows = [
    { dy: -10, delay: 0 },
    { dy: 12, delay: 0.06 },
    { dy: -28, delay: 0.12 },
  ];
  return (
    <>
      {arrows.map((a, i) => (
        <div
          key={i}
          className="absolute left-0 top-1/2 -translate-y-1/2"
          style={{ marginTop: a.dy }}
        >
          <div
            className="animate-arrow"
            style={{ animationDelay: `${a.delay}s` }}
          >
            <svg width="120" height="20" viewBox="0 0 120 20">
              <line
                x1="0"
                y1="10"
                x2="100"
                y2="10"
                stroke="#7cd66a"
                strokeWidth="3"
              />
              <polygon points="100,3 116,10 100,17" fill="#7cd66a" />
            </svg>
          </div>
        </div>
      ))}
      <Shards
        count={12}
        spread={90}
        style={{ bg: "#7cd66a", size: 5 }}
      />
      <Shards
        count={8}
        spread={60}
        style={{ bg: "#cf9342", size: 4 }}
      />
    </>
  );
}

// 소환사: 황금 소환진 + 사방에서 몰려와 적을 강타하는 정령들
function SummonerBurst() {
  return (
    <>
      <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
        <div
          className="animate-ring rounded-full"
          style={{
            width: 110,
            height: 110,
            border: "4px solid #ffd84a",
            boxShadow:
              "0 0 0 2px rgba(255,217,74,0.55), 0 0 36px rgba(255,224,102,0.7)",
          }}
        />
      </div>
      <Stars count={8} color="#ffe066" />
      <Spirits count={11} />
      {/* 정령 부대가 적을 강타하는 임팩트 — 사방에서 모여드는 골드 파편 */}
      <Shards
        count={14}
        spread={95}
        style={{ bg: "#ffe066", size: 5, rounded: true }}
      />
      <Shards
        count={8}
        spread={70}
        style={{ bg: "#ffd84a", size: 4 }}
      />
    </>
  );
}

function Spirits({ count }: { count: number }) {
  return (
    <div className="absolute left-1/2 top-1/2 h-0 w-0 -translate-x-1/2 -translate-y-1/2">
      {Array.from({ length: count }).map((_, i) => {
        const dx = (i - count / 2) * 14 + (Math.random() - 0.5) * 16;
        const size = 9 + Math.random() * 6;
        const css: CSSProperties = {
          width: size,
          height: size,
          background:
            "radial-gradient(circle, #fff5c2 0%, #ffe066 50%, transparent 80%)",
          borderRadius: "50%",
          boxShadow: "0 0 8px rgba(255,224,102,0.7)",
          ["--dx" as never]: `${dx.toFixed(1)}px`,
          animationDuration: `${(0.9 + Math.random() * 0.4).toFixed(2)}s`,
          animationDelay: `${(Math.random() * 0.2).toFixed(2)}s`,
        };
        return (
          <span
            key={i}
            className="absolute block animate-spiritDrift"
            style={css}
          />
        );
      })}
    </div>
  );
}

function Stars({ count, color }: { count: number; color: string }) {
  return (
    <div className="absolute left-1/2 top-1/2 h-0 w-0 -translate-x-1/2 -translate-y-1/2">
      {Array.from({ length: count }).map((_, i) => {
        const angle = (i / count) * Math.PI * 2;
        const dist = 55 + Math.random() * 30;
        const dx = Math.cos(angle) * dist;
        const dy = Math.sin(angle) * dist;
        return (
          <span
            key={i}
            className="absolute block animate-sparkle"
            style={{
              transform: `translate(${dx.toFixed(1)}px, ${dy.toFixed(1)}px)`,
              animationDelay: `${(Math.random() * 0.15).toFixed(2)}s`,
            }}
          >
            <Star color={color} />
          </span>
        );
      })}
    </div>
  );
}

function Star({ color }: { color: string }) {
  return (
    <svg width="14" height="14" viewBox="0 0 14 14">
      <polygon
        points="7,0 9,5 14,5 10,8 11,14 7,11 3,14 4,8 0,5 5,5"
        fill={color}
        stroke="rgba(0,0,0,0.5)"
        strokeWidth="0.5"
      />
    </svg>
  );
}
