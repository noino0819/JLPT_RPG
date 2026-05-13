import { Link } from "react-router-dom";
import DungeonCard from "../components/DungeonCard";
import RankBadge from "../components/RankBadge";
import { JLPT_LEVELS } from "../data/dungeons";
import { dungeonStats, totalKills } from "../lib/stats";
import { useProgressStore } from "../store/progressStore";
import { useProfileStore } from "../store/profileStore";
import PixelCharacter from "../components/PixelCharacter";

export default function HomePage() {
  // 진행 상태가 변할 때 리렌더되도록 구독
  useProgressStore((s) => s.byWord);
  const { nickname, selected_character } = useProfileStore();
  const stats = dungeonStats();
  const kills = totalKills();

  return (
    <div className="space-y-5">
      <section className="panel relative overflow-hidden">
        <div className="absolute inset-0 scanline opacity-20" />
        <div className="relative flex items-center gap-4">
          <PixelCharacter id={selected_character} size={80} />
          <div>
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
              어서 오게, 모험가여
            </div>
            <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
              {nickname}
            </h2>
            <p className="text-sm text-parchment-300">
              오늘은 어느 던전을 정복할까?
            </p>
          </div>
        </div>
      </section>

      <RankBadge killCount={kills} />

      <section>
        <div className="mb-2 flex items-center justify-between">
          <h3 className="pixel-text font-pixel text-sm uppercase tracking-widest text-parchment-100">
            🗺️ 던전
          </h3>
          <Link
            to="/review"
            className="badge-pixel hover:bg-dungeon-100"
          >
            🔖 다시 보기
          </Link>
        </div>

        <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
          {JLPT_LEVELS.map((lv) => (
            <DungeonCard key={lv} level={lv} stat={stats[lv]} />
          ))}
        </div>
      </section>

      <section className="panel">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="pixel-text font-pixel text-sm uppercase tracking-widest text-parchment-100">
              📜 나만의 단어장
            </h3>
            <p className="mt-1 text-xs text-parchment-300">
              직접 만든 단어 + 처치 카운트는 등급에 합산됩니다.
            </p>
          </div>
          <Link to="/mydeck" className="btn-gold">
            열기
          </Link>
        </div>
      </section>
    </div>
  );
}
