import { getRankProgress } from "../data/ranks";

interface Props {
  killCount: number;
  compact?: boolean;
}

export default function RankBadge({ killCount, compact }: Props) {
  const { current, next, pct, remaining } = getRankProgress(killCount);

  if (compact) {
    return (
      <div className="flex items-center gap-2">
        <span className={`font-pixel text-xs ${current.color}`}>
          {current.nameJp}
        </span>
        <span className="text-xs text-parchment-300">{current.name}</span>
      </div>
    );
  }

  return (
    <div className="panel space-y-2">
      <div className="flex items-end justify-between">
        <div>
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            현재 등급
          </div>
          <div className={`pixel-text font-pixel text-2xl ${current.color}`}>
            {current.nameJp}
          </div>
          <div className="text-sm text-parchment-200">{current.name}</div>
        </div>
        <div className="text-right">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            누적 처치
          </div>
          <div className="pixel-text font-pixel text-2xl text-parchment-100">
            ⚔ {killCount}
          </div>
        </div>
      </div>

      <div className="h-3 w-full border-2 border-black bg-dungeon-300">
        <div
          className="h-full bg-rune-500 transition-all"
          style={{ width: `${pct}%` }}
        />
      </div>
      {next ? (
        <div className="flex justify-between text-xs text-parchment-300">
          <span>{remaining}마리 남음</span>
          <span className={next.color}>
            다음: {next.nameJp} {next.name}
          </span>
        </div>
      ) : (
        <div className="text-center text-xs text-parchment-300">
          🏆 최고 등급에 도달했습니다!
        </div>
      )}
    </div>
  );
}
