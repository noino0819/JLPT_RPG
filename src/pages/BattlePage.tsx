import { useEffect, useMemo, useState } from "react";
import { getEnemiesByLevel, type Enemy } from "../data/enemies";
import { getWordsByLevel, type Word } from "../data/words";
import { usePlayerStore } from "../store/playerStore";

interface Quiz {
  word: Word;
  options: string[];
  answer: string;
}

function shuffle<T>(arr: T[]): T[] {
  return [...arr].sort(() => Math.random() - 0.5);
}

function buildQuiz(words: Word[]): Quiz {
  const word = words[Math.floor(Math.random() * words.length)];
  const distractors = shuffle(
    words.filter((w) => w.id !== word.id).map((w) => w.meaningKo),
  ).slice(0, 3);
  const options = shuffle([word.meaningKo, ...distractors]);
  return { word, options, answer: word.meaningKo };
}

export default function BattlePage() {
  const {
    currentJlptLevel,
    hp,
    maxHp,
    attack,
    takeDamage,
    heal,
    gainExp,
    addGold,
  } = usePlayerStore();

  const enemies = useMemo(
    () => getEnemiesByLevel(currentJlptLevel),
    [currentJlptLevel],
  );
  const words = useMemo(
    () => getWordsByLevel(currentJlptLevel),
    [currentJlptLevel],
  );

  const [enemy, setEnemy] = useState<Enemy | null>(null);
  const [enemyHp, setEnemyHp] = useState(0);
  const [quiz, setQuiz] = useState<Quiz | null>(null);
  const [log, setLog] = useState<string[]>([]);
  const [shake, setShake] = useState(false);
  const [pickedOption, setPickedOption] = useState<string | null>(null);

  useEffect(() => {
    spawn();
  }, [currentJlptLevel]);

  const spawn = () => {
    if (enemies.length === 0 || words.length < 4) return;
    const next = enemies[Math.floor(Math.random() * enemies.length)];
    setEnemy(next);
    setEnemyHp(next.hp);
    setQuiz(buildQuiz(words));
    setPickedOption(null);
    setLog([`${next.emoji} ${next.name}이(가) 나타났다!`]);
  };

  const pushLog = (line: string) =>
    setLog((l) => [line, ...l].slice(0, 6));

  const handlePick = (opt: string) => {
    if (!enemy || !quiz || pickedOption || hp <= 0) return;
    setPickedOption(opt);

    if (opt === quiz.answer) {
      const dmg = attack + Math.floor(Math.random() * 3);
      const newHp = Math.max(0, enemyHp - dmg);
      setEnemyHp(newHp);
      pushLog(`✅ 정답! ${enemy.name}에게 ${dmg}의 피해`);

      if (newHp === 0) {
        pushLog(
          `🏆 ${enemy.name} 처치! +${enemy.expReward} EXP / +${enemy.goldReward} G`,
        );
        gainExp(enemy.expReward);
        addGold(enemy.goldReward);
        setTimeout(spawn, 900);
        return;
      }
    } else {
      setShake(true);
      setTimeout(() => setShake(false), 400);
      const dmg = enemy.attack + Math.floor(Math.random() * 2);
      takeDamage(dmg);
      pushLog(`❌ 오답... ${enemy.name}의 반격 (-${dmg} HP)`);
    }

    setTimeout(() => {
      if (words.length >= 4) setQuiz(buildQuiz(words));
      setPickedOption(null);
    }, 700);
  };

  const handleRest = () => {
    heal(Math.round(maxHp * 0.4));
    pushLog("💤 잠시 숨을 고른다... HP 회복");
  };

  if (!enemy || !quiz) {
    return (
      <div className="card text-center">
        {currentJlptLevel} 레벨용 적 또는 단어 데이터가 부족합니다.
      </div>
    );
  }

  const enemyHpPct = Math.max(0, Math.round((enemyHp / enemy.hp) * 100));
  const playerHpPct = Math.max(0, Math.round((hp / maxHp) * 100));
  const dead = hp <= 0;

  return (
    <div className="space-y-6">
      <div className={`card text-center ${shake ? "animate-shake" : ""}`}>
        <div className="text-xs uppercase tracking-widest text-slate-400">
          {enemy.jlpt} · 적
        </div>
        <div className="my-3 text-7xl">{enemy.emoji}</div>
        <div className="text-xl font-black">{enemy.name}</div>
        <div className="mx-auto mt-3 h-2 w-2/3 overflow-hidden rounded-full bg-slate-800">
          <div
            className="h-full bg-rose-400 transition-all"
            style={{ width: `${enemyHpPct}%` }}
          />
        </div>
        <div className="mt-1 text-xs text-slate-400">
          HP {enemyHp} / {enemy.hp}
        </div>
      </div>

      <div className="card">
        <div className="text-xs uppercase tracking-widest text-slate-400">
          {quiz.word.partOfSpeech}의 뜻은?
        </div>
        <div className="mt-2 text-center text-4xl font-black">
          {quiz.word.kanji}
        </div>
        <div className="mt-1 text-center text-sakura-300">
          {quiz.word.kana}
        </div>

        <div className="mt-5 grid grid-cols-1 gap-2 sm:grid-cols-2">
          {quiz.options.map((opt) => {
            const isPicked = pickedOption === opt;
            const isCorrect = pickedOption && opt === quiz.answer;
            const wrong = isPicked && opt !== quiz.answer;
            return (
              <button
                key={opt}
                onClick={() => handlePick(opt)}
                disabled={!!pickedOption || dead}
                className={`rounded-xl border px-4 py-3 text-left font-semibold transition disabled:cursor-not-allowed ${
                  isCorrect
                    ? "border-emerald-400 bg-emerald-500/15 text-emerald-200"
                    : wrong
                      ? "border-rose-400 bg-rose-500/15 text-rose-200"
                      : "border-slate-800 bg-slate-900/60 text-slate-100 hover:border-slate-600"
                }`}
              >
                {opt}
              </button>
            );
          })}
        </div>
      </div>

      <div className="card">
        <div className="flex items-center justify-between text-sm">
          <span className="font-bold">내 HP</span>
          <span className="text-slate-400">
            {hp} / {maxHp}
          </span>
        </div>
        <div className="mt-2 h-2 w-full overflow-hidden rounded-full bg-slate-800">
          <div
            className="h-full bg-emerald-400 transition-all"
            style={{ width: `${playerHpPct}%` }}
          />
        </div>

        <div className="mt-4 flex flex-wrap gap-2">
          <button onClick={handleRest} className="btn-ghost">
            💤 휴식
          </button>
          <button onClick={spawn} className="btn-ghost">
            🔄 다른 적
          </button>
          {dead && (
            <span className="rounded-xl bg-rose-500/20 px-4 py-2 font-bold text-rose-200">
              패배... 휴식으로 회복하세요
            </span>
          )}
        </div>
      </div>

      <div className="card">
        <h4 className="text-sm font-bold text-slate-300">전투 로그</h4>
        <ul className="mt-2 space-y-1 text-sm text-slate-400">
          {log.map((line, i) => (
            <li key={i}>· {line}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
