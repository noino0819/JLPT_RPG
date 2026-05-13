import { Link, NavLink, Outlet } from "react-router-dom";
import { useProfileStore } from "../store/profileStore";
import { totalKills } from "../lib/stats";
import { useProgressStore } from "../store/progressStore";
import { isSupabaseEnabled } from "../lib/supabase";
import RankBadge from "./RankBadge";
import PixelSword from "./PixelSword";
import { TITLES_BY_ID } from "../data/titles";
import { BADGES_BY_ID } from "../data/badges";

export default function Layout() {
  // 진행 상태가 변할 때마다 헤더가 업데이트되도록 구독
  useProgressStore((s) => s.byWord);
  const { nickname, equipped } = useProfileStore();
  const kills = totalKills();
  const title = equipped.title ? TITLES_BY_ID[equipped.title] : null;
  const firstBadge = equipped.badges[0]
    ? BADGES_BY_ID[equipped.badges[0]]
    : null;

  return (
    // 뷰포트 전체 높이를 정확히 차지하는 flex 컨테이너.
    // header/nav 는 shrink-0, main 만 남는 공간을 차지하면서 자체 스크롤.
    // 이렇게 해야 학습 페이지처럼 "스크롤 없이 정확히 채우는" 화면을 만들 수 있다.
    <div className="flex h-dvh flex-col overflow-hidden">
      <header className="shrink-0 border-b-2 border-black bg-dungeon-200/95 backdrop-blur">
        <div className="mx-auto flex max-w-3xl items-center justify-between gap-3 px-4 py-3">
          <Link to="/" className="flex items-center gap-2">
            <PixelSword size={28} />
            <div>
              <div className="pixel-text font-pixel text-base text-parchment-100">
                JLPT <span className="text-rune-400">RPG</span>
              </div>
              <div className="font-pixel text-[10px] text-parchment-300">
                漢字ダンジョン
              </div>
            </div>
          </Link>

          <div className="flex items-center gap-2">
            <SyncDot />
            <RankBadge killCount={kills} compact />
            {firstBadge && (
              <span
                className={`badge-pixel ${firstBadge.tone} !px-1 !py-0`}
                title={`${firstBadge.nameJp} · ${firstBadge.name}`}
              >
                {firstBadge.icon}
              </span>
            )}
            <span className="hidden min-w-0 font-pixel text-xs text-parchment-200 sm:inline">
              {title && (
                <span className={`mr-1 ${title.color}`}>
                  {title.textJp}
                </span>
              )}
              · {nickname}
            </span>
            <Link
              to="/settings"
              className="border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-xs text-parchment-100 hover:bg-dungeon-100"
              aria-label="설정"
            >
              ⚙
            </Link>
          </div>
        </div>
      </header>

      <main className="mx-auto w-full max-w-3xl flex-1 min-h-0 overflow-y-auto px-4 py-5">
        <Outlet />
      </main>

      <nav className="shrink-0 border-t-2 border-black bg-dungeon-200/95 backdrop-blur">
        <div className="mx-auto flex max-w-3xl items-center justify-around gap-1 px-2 py-1">
          <NavTab to="/" label="던전" icon="🏯" />
          <NavTab to="/kana" label="카나" icon="あ" jpIcon />
          <NavTab to="/review" label="다시보기" icon="🔖" />
          <NavTab to="/mydeck" label="단어장" icon="📜" />
          <NavTab to="/wardrobe" label="옷장" icon="🧝" />
        </div>
      </nav>
    </div>
  );
}

function SyncDot() {
  // 사용자에겐 단순히 "온라인 동기화" / "오프라인 모드" 로만 노출
  return (
    <span
      title={isSupabaseEnabled ? "온라인 동기화 중" : "오프라인 모드"}
      className={`inline-block h-2.5 w-2.5 rounded-full border border-black ${
        isSupabaseEnabled ? "bg-emerald-400" : "bg-parchment-300/50"
      }`}
    />
  );
}

function NavTab({
  to,
  label,
  icon,
  jpIcon = false,
}: {
  to: string;
  label: string;
  icon: string;
  /** true 이면 일본어 픽셀 폰트로 아이콘을 렌더 (카나 탭 등) */
  jpIcon?: boolean;
}) {
  return (
    <NavLink
      to={to}
      end={to === "/"}
      className={({ isActive }) =>
        `flex flex-1 flex-col items-center gap-0.5 border-2 px-2 py-2 font-pixel text-[10px] uppercase transition ${
          isActive
            ? "border-rune-500 bg-rune-500/10 text-rune-400"
            : "border-transparent text-parchment-200 hover:text-parchment-100"
        }`
      }
    >
      <span className={`text-lg ${jpIcon ? "pixel-text-jp leading-none" : ""}`}>
        {icon}
      </span>
      {label}
    </NavLink>
  );
}
