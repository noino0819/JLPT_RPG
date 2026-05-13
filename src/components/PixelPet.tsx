import { useEffect, useState } from "react";
import { PETS_BY_ID } from "../data/pets";

interface Props {
  petId: string;
  /** 픽셀 크기 (한 칸이 size/16 px). */
  size?: number;
  /** bobbing 애니메이션 위상 차이 (캐릭터와 어긋나게). */
  delayMs?: number;
  /** true 인 동안 attack 프레임을 빠르게 재생. */
  attacking?: boolean;
}

/**
 * 캐릭터 옆에 따라다니는 작은 16x16 픽셀 펫.
 *
 * idle 상태  : idleFrames 를 일정 간격(420ms)으로 순환 재생해 호흡/깜빡임 등
 *              미세한 모션을 만든다. 동시에 animate-bob 으로 위아래로 떠다닌다.
 * attack 상태: attacking=true 인 동안 attackFrames 를 빠르게(130ms) 재생하고,
 *              마지막 프레임을 잠시 유지해 임팩트를 강조한다. 캐릭터와 동시에
 *              움직이도록 PixelCharacter 와 같은 attackSwing 트랜스폼을 적용한다.
 */
export default function PixelPet({
  petId,
  size = 32,
  delayMs = 200,
  attacking = false,
}: Props) {
  const pet = PETS_BY_ID[petId];

  // ─── 프레임 인덱스 관리 ───
  const [idleFrame, setIdleFrame] = useState(0);
  const [attackFrame, setAttackFrame] = useState(0);

  // idle 프레임 — 호흡/깜빡임/꼬리흔들림. 캐릭터와 위상이 달라 자연스럽게 보이도록
  // delayMs 만큼 첫 전환을 지연시킨다.
  useEffect(() => {
    if (!pet || attacking) return;
    const total = pet.idleFrames.length;
    if (total <= 1) return;
    let interval: ReturnType<typeof setInterval> | undefined;
    const startTimer = setTimeout(() => {
      interval = setInterval(() => {
        setIdleFrame((f) => (f + 1) % total);
      }, 420);
    }, delayMs);
    return () => {
      clearTimeout(startTimer);
      if (interval) clearInterval(interval);
    };
  }, [pet, attacking, delayMs]);

  // attack 프레임 — windup → release 빠르게 재생 후 마지막 프레임 유지
  useEffect(() => {
    if (!pet) return;
    if (!attacking) {
      setAttackFrame(0);
      return;
    }
    const total = pet.attackFrames.length;
    setAttackFrame(0);
    if (total <= 1) return;
    let i = 0;
    const interval = setInterval(() => {
      i = Math.min(i + 1, total - 1);
      setAttackFrame(i);
    }, 130);
    return () => clearInterval(interval);
  }, [pet, attacking]);

  if (!pet) return null;

  const frames = attacking ? pet.attackFrames : pet.idleFrames;
  const frameIndex = attacking ? attackFrame : idleFrame;
  const sprite = frames[frameIndex] ?? frames[0];

  const px = size / 16;
  const sty = (col: number, row: number, color: string) => ({
    left: col * px,
    top: row * px,
    width: px,
    height: px,
    background: color,
    position: "absolute" as const,
  });

  return (
    <div
      className={`relative ${attacking ? "animate-attackSwing" : "animate-bob"}`}
      style={{
        width: size,
        height: size,
        animationDelay: attacking ? undefined : `${delayMs}ms`,
      }}
      title={`${pet.nameJp} · ${pet.name}`}
    >
      {sprite.map((row, r) =>
        row.split("").map((ch, c) => {
          const color = pet.palette[ch];
          if (!color) return null;
          return <span key={`${r}-${c}`} style={sty(c, r, color)} />;
        }),
      )}
    </div>
  );
}

if (import.meta.env.DEV) {
  for (const [id, pet] of Object.entries(PETS_BY_ID)) {
    const check = (state: "idle" | "attack", frames: string[][]) => {
      frames.forEach((sprite, fi) => {
        if (sprite.length !== 16) {
          console.warn(
            `[PixelPet] pet ${id} ${state}[${fi}] 행 개수=${sprite.length} (16 이어야 함)`,
          );
        }
        sprite.forEach((row, ri) => {
          if (row.length !== 16) {
            console.warn(
              `[PixelPet] pet ${id} ${state}[${fi}] row ${ri} 길이=${row.length} (16 이어야 함): "${row}"`,
            );
          }
        });
      });
    };
    check("idle", pet.idleFrames);
    check("attack", pet.attackFrames);
  }
}
