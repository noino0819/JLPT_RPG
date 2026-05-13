import { NavLink, Outlet } from "react-router-dom";
import { usePlayerStore } from "../store/playerStore";

const navItems = [
  { to: "/", label: "홈", icon: "🏯" },
  { to: "/study", label: "단어 수련", icon: "📖" },
  { to: "/battle", label: "전투", icon: "⚔️" },
  { to: "/status", label: "상태", icon: "🧭" },
];

export default function Layout() {
  const { name, level, exp, expToNext, hp, maxHp } = usePlayerStore();

  return (
    <div className="flex min-h-screen flex-col bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950">
      <header className="border-b border-slate-800/80 bg-slate-950/70 backdrop-blur">
        <div className="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
          <div className="flex items-center gap-3">
            <span className="text-2xl">🗾</span>
            <div>
              <h1 className="text-lg font-black tracking-wide">
                JLPT <span className="text-sakura-400">RPG</span>
              </h1>
              <p className="text-xs text-slate-400">日本語 모험을 떠나자</p>
            </div>
          </div>
          <div className="hidden items-center gap-4 sm:flex">
            <PlayerBadge
              name={name}
              level={level}
              exp={exp}
              expToNext={expToNext}
              hp={hp}
              maxHp={maxHp}
            />
          </div>
        </div>
      </header>

      <main className="mx-auto w-full max-w-5xl flex-1 px-6 py-8">
        <Outlet />
      </main>

      <nav className="sticky bottom-0 border-t border-slate-800/80 bg-slate-950/90 backdrop-blur">
        <div className="mx-auto flex max-w-5xl items-center justify-around px-2 py-2">
          {navItems.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              end={item.to === "/"}
              className={({ isActive }) =>
                `flex flex-1 flex-col items-center gap-1 rounded-xl px-3 py-2 text-xs font-semibold transition ${
                  isActive
                    ? "bg-sakura-500/15 text-sakura-300"
                    : "text-slate-400 hover:text-slate-100"
                }`
              }
            >
              <span className="text-lg">{item.icon}</span>
              {item.label}
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  );
}

function PlayerBadge({
  name,
  level,
  exp,
  expToNext,
  hp,
  maxHp,
}: {
  name: string;
  level: number;
  exp: number;
  expToNext: number;
  hp: number;
  maxHp: number;
}) {
  const expPct = Math.min(100, Math.round((exp / expToNext) * 100));
  const hpPct = Math.min(100, Math.round((hp / maxHp) * 100));

  return (
    <div className="flex items-center gap-3 rounded-xl border border-slate-800 bg-slate-900/60 px-4 py-2">
      <div className="grid h-10 w-10 place-items-center rounded-full bg-sakura-500/20 text-lg">
        🦊
      </div>
      <div className="min-w-[180px]">
        <div className="flex items-center justify-between text-xs text-slate-300">
          <span className="font-bold text-slate-100">{name}</span>
          <span className="text-sakura-300">Lv.{level}</span>
        </div>
        <div className="mt-1 h-1.5 w-full overflow-hidden rounded-full bg-slate-800">
          <div
            className="h-full bg-emerald-400"
            style={{ width: `${hpPct}%` }}
          />
        </div>
        <div className="mt-1 h-1.5 w-full overflow-hidden rounded-full bg-slate-800">
          <div
            className="h-full bg-sakura-400"
            style={{ width: `${expPct}%` }}
          />
        </div>
      </div>
    </div>
  );
}
