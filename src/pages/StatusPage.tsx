import { usePlayerStore } from "../store/playerStore";
import { WORDS } from "../data/words";

export default function StatusPage() {
  const player = usePlayerStore();
  const learned = WORDS.filter((w) =>
    player.learnedWordIds.includes(w.id),
  );

  return (
    <div className="space-y-6">
      <section className="card">
        <h2 className="text-2xl font-bold">🧭 모험가 상태</h2>
        <div className="mt-4 grid grid-cols-2 gap-4 sm:grid-cols-4">
          <Stat label="이름" value={player.name} />
          <Stat label="레벨" value={`Lv.${player.level}`} />
          <Stat label="HP" value={`${player.hp} / ${player.maxHp}`} />
          <Stat label="공격력" value={`${player.attack}`} />
          <Stat
            label="EXP"
            value={`${player.exp} / ${player.expToNext}`}
          />
          <Stat label="골드" value={`🪙 ${player.gold}`} />
          <Stat label="현재 JLPT" value={player.currentJlptLevel} />
          <Stat
            label="외운 단어"
            value={`${player.learnedWordIds.length} / ${WORDS.length}`}
          />
        </div>

        <div className="mt-6 flex gap-2">
          <button onClick={() => player.heal(player.maxHp)} className="btn-ghost">
            🧪 완전 회복
          </button>
          <button
            onClick={() => {
              if (confirm("모든 진행 상황을 초기화할까요?")) player.reset();
            }}
            className="btn-ghost"
          >
            🗑️ 진행 초기화
          </button>
        </div>
      </section>

      <section className="card">
        <h3 className="text-lg font-bold">📚 학습한 단어 ({learned.length})</h3>
        {learned.length === 0 ? (
          <p className="mt-2 text-sm text-slate-400">
            아직 학습한 단어가 없어요. 단어 수련에서 외워보세요!
          </p>
        ) : (
          <ul className="mt-3 grid gap-2 sm:grid-cols-2">
            {learned.map((w) => (
              <li
                key={w.id}
                className="rounded-xl border border-slate-800 bg-slate-950/50 p-3"
              >
                <div className="flex items-center justify-between">
                  <div className="text-lg font-bold">{w.kanji}</div>
                  <span className="badge">{w.jlpt}</span>
                </div>
                <div className="text-sm text-sakura-300">{w.kana}</div>
                <div className="text-sm text-slate-300">{w.meaningKo}</div>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}

function Stat({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950/40 p-3">
      <div className="text-xs text-slate-400">{label}</div>
      <div className="mt-1 font-bold">{value}</div>
    </div>
  );
}
