import { Link } from "react-router-dom";
import { DUNGEONS } from "../data/dungeons";
import type { JlptLevel } from "../types";
import type { DungeonStat } from "../lib/stats";

interface Props {
  level: JlptLevel;
  stat: DungeonStat;
}

export default function DungeonCard({ level, stat }: Props) {
  const d = DUNGEONS[level];
  const pct = stat.total === 0 ? 0 : Math.round((stat.mastered / stat.total) * 100);

  return (
    <Link
      to={`/study/${level}`}
      className={`group relative block overflow-hidden border-2 border-black bg-gradient-to-br p-4 transition hover:-translate-y-0.5 ${d.theme.bg}`}
      style={{ boxShadow: "0 4px 0 0 rgba(0,0,0,0.7)" }}
    >
      <div className="absolute inset-0 scanline opacity-30" />
      <div className="relative flex items-start justify-between">
        <div>
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-200/80">
            {level}
          </div>
          <div className={`pixel-text font-pixel text-2xl ${d.theme.text}`}>
            {d.nameJp}
          </div>
          <div className="text-sm text-parchment-100">{d.name}</div>
        </div>
        <div className="text-4xl">{d.emoji}</div>
      </div>

      <div className="relative mt-4">
        <div className="flex items-center justify-between text-xs">
          <span className="font-pixel text-parchment-200">
            ⚔ {stat.mastered}
          </span>
          <span className="text-parchment-200/80">
            {stat.mastered}/{stat.total} ({pct}%)
          </span>
        </div>
        <div className="mt-1 h-2 w-full border-2 border-black bg-dungeon-300/70">
          <div
            className={`h-full ${d.theme.accent} transition-all`}
            style={{ width: `${pct}%` }}
          />
        </div>
        <div className="mt-2 flex gap-2 text-[10px] text-parchment-200/80">
          <span>✓ {stat.probably}</span>
          <span>🔖 {stat.flagged}</span>
        </div>
      </div>
    </Link>
  );
}
