import { Link } from "react-router-dom";
import DungeonCard from "../components/DungeonCard";
import { JLPT_LEVELS } from "../data/dungeons";
import { dungeonStats, totalKills } from "../lib/stats";
import { useProgressStore } from "../store/progressStore";
import { useProfileStore } from "../store/profileStore";
import { useDecksStore } from "../store/decksStore";
import PixelCharacter from "../components/PixelCharacter";
import PixelPet from "../components/PixelPet";
import { getRankProgress } from "../data/ranks";
import { TITLES_BY_ID } from "../data/titles";
import { BADGES_BY_ID } from "../data/badges";
import { FRAMES_BY_ID } from "../data/frames";

export default function HomePage() {
  // 진행 상태/덱이 변할 때 리렌더
  useProgressStore((s) => s.byWord);
  useDecksStore((s) => s.words);
  const { nickname, selected_character, equipped } = useProfileStore();
  const stats = dungeonStats();
  const kills = totalKills();
  const { current, next, pct, remaining } = getRankProgress(kills);

  const title = equipped.title ? TITLES_BY_ID[equipped.title] : null;
  const frame = equipped.frame
    ? FRAMES_BY_ID[equipped.frame]
    : FRAMES_BY_ID.frame_default;
  const equippedBadges = equipped.badges
    .map((id) => BADGES_BY_ID[id])
    .filter(Boolean);

  return (
    // 한 화면에 최대한 다 들어가도록 컴팩트한 레이아웃을 유지한다.
    <div className="flex h-full flex-col gap-3">
      {/* 환영 + 등급 배지를 하나의 컴팩트 히어로로 통합 */}
      <section className="panel relative overflow-hidden">
        <div className="absolute inset-0 scanline opacity-20" />
        <div className="relative flex items-center gap-3">
          <div
            className={`relative grid h-16 w-16 shrink-0 place-items-center ${
              frame ? frame.className : ""
            }`}
          >
            <PixelCharacter
              id={selected_character}
              costumeId={equipped.costume[selected_character]}
              size={56}
            />
            {equipped.pet && (
              <div className="absolute -bottom-2 -right-3">
                <PixelPet petId={equipped.pet} size={28} />
              </div>
            )}
          </div>
          <div className="min-w-0 flex-1">
            <div className="flex items-center justify-between gap-2">
              <div className="min-w-0">
                {title && (
                  <div
                    className={`font-pixel text-[10px] tracking-widest ${title.color}`}
                  >
                    {title.textJp} · {title.textKo}
                  </div>
                )}
                <h2 className="pixel-text font-pixel text-lg text-parchment-100 truncate">
                  {nickname}
                </h2>
              </div>
              <div className="shrink-0 text-right">
                <span className={`pixel-text font-pixel text-sm ${current.color}`}>
                  {current.nameJp}
                </span>
                <span className="ml-1 font-pixel text-[10px] text-parchment-300">
                  ⚔ {kills}
                </span>
              </div>
            </div>
            <div className="mt-1 h-2 w-full border-2 border-black bg-dungeon-300">
              <div
                className="h-full bg-rune-500 transition-all"
                style={{ width: `${pct}%` }}
              />
            </div>
            <div className="mt-0.5 flex items-center justify-between text-[10px] text-parchment-300">
              <div className="flex flex-wrap items-center gap-1">
                {equippedBadges.length > 0 ? (
                  equippedBadges.map((b) => (
                    <span
                      key={b.id}
                      className={`badge-pixel ${b.tone} !px-1 !py-0`}
                      title={`${b.nameJp} · ${b.name}`}
                    >
                      {b.icon}
                    </span>
                  ))
                ) : (
                  <span>오늘은 어느 던전을 정복할까?</span>
                )}
              </div>
              {next ? (
                <span className={next.color}>
                  다음: {next.nameJp} ({remaining}↓)
                </span>
              ) : (
                <span className="text-parchment-300">🏆 최고 등급</span>
              )}
            </div>
          </div>
        </div>
      </section>

      {/* 카나 수련장 — 던전(어휘) 전에 거치는 기초 훈련소 */}
      <Link
        to="/kana"
        className="group relative block overflow-hidden border-2 border-black bg-gradient-to-r from-parchment-700/40 via-parchment-500/30 to-parchment-400/30 p-2.5 transition hover:-translate-y-0.5"
        style={{ boxShadow: "0 4px 0 0 rgba(0,0,0,0.7)" }}
      >
        <div className="absolute inset-0 scanline opacity-30" />
        <div className="relative flex items-center gap-3">
          <div className="grid h-12 w-12 shrink-0 place-items-center border-2 border-black bg-parchment-100">
            <span className="pixel-text-jp text-2xl font-bold leading-none text-parchment-900">
              あア
            </span>
          </div>
          <div className="min-w-0 flex-1">
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-200/80">
              수련장 · 修練場
            </div>
            <div className="pixel-text font-pixel text-base text-parchment-100">
              히라가나 · 가타카나
            </div>
            <div className="text-[11px] text-parchment-200/90">
              五十音 도장에서 기초를 닦자
            </div>
          </div>
          <span className="shrink-0 font-pixel text-2xl text-parchment-100 transition group-hover:translate-x-1">
            ›
          </span>
        </div>
      </Link>

      {/* 던전 섹션 - 영역 전체를 채우고 카드 자체는 컴팩트하게 */}
      <section className="flex min-h-0 flex-1 flex-col">
        <div className="mb-2 flex items-center justify-between">
          <h3 className="pixel-text font-pixel text-sm uppercase tracking-widest text-parchment-100">
            🗺️ 던전
          </h3>
          <div className="flex items-center gap-1.5">
            <Link to="/review" className="badge-pixel hover:bg-dungeon-100">
              🔖 다시보기
            </Link>
            <Link to="/mydeck" className="badge-pixel hover:bg-dungeon-100">
              📜 단어장
            </Link>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-2">
          {JLPT_LEVELS.map((lv) => (
            <DungeonCard key={lv} level={lv} stat={stats[lv]} />
          ))}
        </div>
      </section>
    </div>
  );
}
