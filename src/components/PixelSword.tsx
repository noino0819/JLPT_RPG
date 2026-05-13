interface Props {
  size?: number;
  className?: string;
  glow?: boolean;
}

/**
 * 16x16 픽셀 도트 칼 아이콘.
 * 헤더/로그인/로딩 화면 등에서 이모지(🗡️) 대신 사용.
 */
export default function PixelSword({ size = 32, className, glow }: Props) {
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
      className={`relative inline-block ${className ?? ""}`}
      style={{ width: size, height: size }}
      aria-hidden
    >
      <div className="relative h-full w-full">
        {SPRITE.map((row, r) =>
          row.split("").map((ch, c) => {
            const color = PALETTE[ch];
            if (!color) return null;
            return <span key={`${r}-${c}`} style={sty(c, r, color)} />;
          }),
        )}
      </div>
      {glow && (
        <div
          className="pointer-events-none absolute inset-0"
          style={{
            background:
              "radial-gradient(circle, rgba(123,227,255,0.35) 0%, transparent 60%)",
          }}
        />
      )}
    </div>
  );
}

// 16x16 도트 칼: 칼끝이 위, 손잡이는 아래.
//  o = outline (검정)
//  M = blade core (밝은 은색)
//  m = blade shadow (어두운 은색)
//  g = guard gold
//  G = guard gold highlight
//  h = handle wrap (가죽)
//  H = handle wrap highlight
//  j = pommel jewel (룬 블루)
//  J = jewel highlight
const SPRITE = [
  "................",
  ".......o........",
  "......oMo.......",
  "......oMo.......",
  "......omMo......",
  "......omMo......",
  "......omMo......",
  "......omMo......",
  "......omMo......",
  ".....oggGgo.....",
  "....ogGGGGgo....",
  "......ohHo......",
  "......ohHo......",
  ".....oJjjJo.....",
  "......ojJo......",
  ".......o........",
];

const PALETTE: Record<string, string> = {
  o: "#0a0610",
  M: "#f2f6ff",
  m: "#9aa4c2",
  g: "#bd8434",
  G: "#f0c97c",
  h: "#5a2a14",
  H: "#a06a44",
  j: "#33c4ff",
  J: "#cdeeff",
};
