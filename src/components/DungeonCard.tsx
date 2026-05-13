import { Link } from "react-router-dom";
import { DUNGEONS } from "../data/dungeons";
import { BOSS_MIN_WORDS } from "../data/bosses";
import type { JlptLevel } from "../types";
import type { DungeonStat } from "../lib/stats";
import PixelDungeon from "./PixelDungeon";
import PixelMonster from "./PixelMonster";

interface Props {
  level: JlptLevel;
  stat: DungeonStat;
}

export default function DungeonCard({ level, stat }: Props) {
  const d = DUNGEONS[level];
  const pct =
    stat.total === 0 ? 0 : Math.round((stat.mastered / stat.total) * 100);

  // 마스터한 단어가 BOSS_MIN_WORDS 개 이상이면 보스 도전 가능
  const bossUnlocked = stat.mastered >= BOSS_MIN_WORDS;
  const bossNeed = Math.max(0, BOSS_MIN_WORDS - stat.mastered);

  return (
    <div
      className={`group relative overflow-hidden border-2 border-black bg-gradient-to-br p-2.5 ${d.theme.bg}`}
      style={{ boxShadow: "0 4px 0 0 rgba(0,0,0,0.7)" }}
    >
      <div className="absolute inset-0 scanline opacity-30" />

      {/* 던전 입장 (메인) */}
      <Link to={`/study/${level}`} className="relative block">
        <div className="flex items-start justify-between gap-2">
          <div className="min-w-0">
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-200/80">
              {level}
            </div>
            <div
              className={`pixel-text font-pixel text-lg leading-tight ${d.theme.text}`}
            >
              {d.nameJp}
            </div>
            <div className="text-xs text-parchment-100">{d.name}</div>
          </div>
          <div className="shrink-0 transition group-hover:-translate-y-0.5">
            <PixelDungeon level={level} size={40} />
          </div>
        </div>

        <div className="mt-2">
          <div className="flex items-center justify-between text-[10px]">
            <span className="font-pixel text-parchment-200">
              ⚔ {stat.mastered}
            </span>
            <span className="text-parchment-200/80">
              {stat.mastered}/{stat.total} ({pct}%)
            </span>
          </div>
          <div className="mt-1 h-1.5 w-full border-2 border-black bg-dungeon-300/70">
            <div
              className={`h-full ${d.theme.accent} transition-all`}
              style={{ width: `${pct}%` }}
            />
          </div>
          <div className="mt-1 flex gap-2 text-[10px] text-parchment-200/80">
            <span>✓ {stat.probably}</span>
            <span>🔖 {stat.flagged}</span>
          </div>
        </div>
      </Link>

      {/* 보스 도전 영역 — 별도의 클릭 영역으로 분리. */}
      <div className="relative mt-2 border-t-2 border-black/40 pt-2">
        {bossUnlocked ? (
          <Link
            to={`/boss/${level}`}
            className="flex items-center justify-between gap-2 border-2 border-black bg-dungeon-50/70 px-2 py-1.5 transition hover:-translate-y-0.5 hover:bg-dungeon-100"
            style={{ boxShadow: "0 3px 0 0 rgba(0,0,0,0.6)" }}
            aria-label={`${d.nameJp} 보스 도전`}
          >
            <div className="flex items-center gap-2">
              <PixelMonster level={level} size={28} />
              <div className="min-w-0">
                <div className="font-pixel text-[10px] tracking-widest text-volcano-400">
                  ⚔ BOSS
                </div>
                <div className="font-pixel text-[10px] text-parchment-100">
                  보스 도전
                </div>
              </div>
            </div>
            <span className="font-pixel text-[10px] text-parchment-300">
              ▶
            </span>
          </Link>
        ) : (
          <div
            className="flex items-center justify-between gap-2 border-2 border-dashed border-black/60 bg-dungeon-50/30 px-2 py-1.5 opacity-70"
            aria-label="보스 잠금"
            title={`${BOSS_MIN_WORDS}개 마스터 시 도전 가능`}
          >
            <div className="flex items-center gap-2">
              <div className="grid h-7 w-7 place-items-center text-base">
                🔒
              </div>
              <div className="min-w-0">
                <div className="font-pixel text-[10px] tracking-widest text-parchment-300">
                  BOSS
                </div>
                <div className="font-pixel text-[10px] text-parchment-200">
                  {bossNeed}↓ 마스터 필요
                </div>
              </div>
            </div>
            <span className="font-pixel text-[10px] text-parchment-300">
              {stat.mastered}/{BOSS_MIN_WORDS}
            </span>
          </div>
        )}
      </div>
    </div>
  );
}
