import { Link } from "react-router-dom";
import { usePlayerStore } from "../store/playerStore";

const JLPT_LEVELS = ["N5", "N4", "N3", "N2", "N1"] as const;

export default function HomePage() {
  const { name, currentJlptLevel, setJlptLevel, learnedWordIds, gold } =
    usePlayerStore();

  return (
    <div className="space-y-8">
      <section className="card animate-pop">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <span className="badge mb-3">{currentJlptLevel} 모험가</span>
            <h2 className="text-3xl font-black sm:text-4xl">
              어서 와요, <span className="text-sakura-300">{name}</span>!
            </h2>
            <p className="mt-2 text-slate-400">
              일본어 단어를 외우며 몬스터를 쓰러뜨리고 레벨을 올려보세요.
            </p>
          </div>
          <div className="grid grid-cols-2 gap-3 text-center sm:flex">
            <Stat label="외운 단어" value={`${learnedWordIds.length}개`} />
            <Stat label="소지 골드" value={`🪙 ${gold}`} />
          </div>
        </div>

        <div className="mt-6 flex flex-wrap gap-3">
          <Link to="/study" className="btn-primary">
            📖 단어 수련 시작
          </Link>
          <Link to="/battle" className="btn-ghost">
            ⚔️ 전투 입장
          </Link>
        </div>
      </section>

      <section className="card">
        <h3 className="text-lg font-bold">JLPT 레벨 선택</h3>
        <p className="mt-1 text-sm text-slate-400">
          현재 도전 중인 시험 레벨을 선택하면 등장하는 단어와 적이 달라집니다.
        </p>
        <div className="mt-4 grid grid-cols-5 gap-2">
          {JLPT_LEVELS.map((lvl) => {
            const active = lvl === currentJlptLevel;
            return (
              <button
                key={lvl}
                onClick={() => setJlptLevel(lvl)}
                className={`rounded-xl border px-3 py-4 text-lg font-black transition ${
                  active
                    ? "border-sakura-400 bg-sakura-500/15 text-sakura-200 shadow-lg shadow-sakura-500/20"
                    : "border-slate-800 bg-slate-900/40 text-slate-300 hover:border-slate-600"
                }`}
              >
                {lvl}
              </button>
            );
          })}
        </div>
      </section>

      <section className="grid gap-4 sm:grid-cols-3">
        <Tip
          icon="📖"
          title="단어 수련"
          desc="플래시카드로 단어를 학습하고 EXP를 얻어요."
        />
        <Tip
          icon="⚔️"
          title="전투"
          desc="뜻을 맞히면 데미지! 틀리면 적의 공격을 받아요."
        />
        <Tip
          icon="🧭"
          title="상태"
          desc="내 레벨과 학습한 단어를 한눈에 확인해요."
        />
      </section>
    </div>
  );
}

function Stat({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-900/60 px-4 py-2">
      <div className="text-xs text-slate-400">{label}</div>
      <div className="text-lg font-bold text-slate-100">{value}</div>
    </div>
  );
}

function Tip({
  icon,
  title,
  desc,
}: {
  icon: string;
  title: string;
  desc: string;
}) {
  return (
    <div className="card">
      <div className="text-2xl">{icon}</div>
      <h4 className="mt-2 font-bold">{title}</h4>
      <p className="mt-1 text-sm text-slate-400">{desc}</p>
    </div>
  );
}
