import { PETS_BY_ID } from "../data/pets";

interface Props {
  petId: string;
  size?: number;
  // bobbing 애니메이션 위상 차이 (캐릭터와 어긋나게)
  delayMs?: number;
}

/**
 * 캐릭터 옆에 따라다니는 작은 16x16 픽셀 펫.
 * PixelCharacter 와 같은 box-shadow 픽셀 방식. 펫은 살짝 떠다니듯 bob.
 * 미해금/장착 안 된 경우 호출하지 않으면 된다.
 */
export default function PixelPet({ petId, size = 32, delayMs = 200 }: Props) {
  const pet = PETS_BY_ID[petId];
  if (!pet) return null;

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
      className="relative animate-bob"
      style={{
        width: size,
        height: size,
        animationDelay: `${delayMs}ms`,
      }}
      title={`${pet.nameJp} · ${pet.name}`}
    >
      {pet.sprite.map((row, r) =>
        row.split("").map((ch, c) => {
          const color = pet.palette[ch];
          if (!color) return null;
          return <span key={`${r}-${c}`} style={sty(c, r, color)} />;
        }),
      )}
    </div>
  );
}

// 개발 모드: 모든 sprite 행이 정확히 16자 인지 검증
if (import.meta.env.DEV) {
  for (const [id, pet] of Object.entries(PETS_BY_ID)) {
    pet.sprite.forEach((row, i) => {
      if (row.length !== 16) {
        console.warn(
          `[PixelPet] pet ${id} row ${i} 길이=${row.length} (16 이어야 함): "${row}"`,
        );
      }
    });
  }
}
