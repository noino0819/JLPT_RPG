import { useMemo, useState } from "react";
import { getWordsByLevel } from "../data/words";
import { usePlayerStore } from "../store/playerStore";

export default function StudyPage() {
  const { currentJlptLevel, gainExp, markWordLearned } = usePlayerStore();
  const words = useMemo(
    () => getWordsByLevel(currentJlptLevel),
    [currentJlptLevel],
  );

  const [index, setIndex] = useState(0);
  const [showAnswer, setShowAnswer] = useState(false);
  const [toast, setToast] = useState<string | null>(null);

  if (words.length === 0) {
    return (
      <div className="card text-center">
        아직 {currentJlptLevel} 레벨 단어가 준비되지 않았습니다.
      </div>
    );
  }

  const word = words[index];

  const handleKnown = () => {
    markWordLearned(word.id);
    gainExp(5);
    setToast("✨ +5 EXP! 단어를 습득했어요");
    next();
  };

  const handleUnknown = () => {
    setToast("📌 다시 한번 외워볼까요?");
    next();
  };

  const next = () => {
    setShowAnswer(false);
    setIndex((i) => (i + 1) % words.length);
    setTimeout(() => setToast(null), 1500);
  };

  return (
    <div className="space-y-6">
      <header className="flex items-center justify-between">
        <h2 className="text-2xl font-bold">📖 단어 수련 ({currentJlptLevel})</h2>
        <span className="badge">
          {index + 1} / {words.length}
        </span>
      </header>

      <div
        className="card animate-pop cursor-pointer select-none text-center"
        onClick={() => setShowAnswer((s) => !s)}
      >
        <div className="mb-3 text-xs uppercase tracking-widest text-slate-400">
          {word.partOfSpeech} · {word.jlpt}
        </div>
        <div className="text-5xl font-black text-slate-100 sm:text-6xl">
          {word.kanji}
        </div>
        <div className="mt-3 text-lg text-sakura-300">{word.kana}</div>

        {showAnswer ? (
          <div className="mt-6 space-y-3">
            <div className="text-xl font-bold text-emerald-300">
              {word.meaningKo}
            </div>
            {word.example && (
              <div className="rounded-xl bg-slate-950/60 p-4 text-left">
                <div className="text-slate-100">{word.example.jp}</div>
                <div className="mt-1 text-sm text-slate-400">
                  {word.example.ko}
                </div>
              </div>
            )}
          </div>
        ) : (
          <p className="mt-6 text-sm text-slate-500">카드를 눌러 뜻을 확인</p>
        )}
      </div>

      <div className="grid grid-cols-2 gap-3">
        <button onClick={handleUnknown} className="btn-ghost">
          🤔 모르겠다
        </button>
        <button onClick={handleKnown} className="btn-primary">
          ✅ 외웠다 (+5 EXP)
        </button>
      </div>

      {toast && (
        <div className="fixed bottom-24 left-1/2 -translate-x-1/2 animate-pop rounded-full bg-slate-100 px-4 py-2 text-sm font-bold text-slate-900 shadow-lg">
          {toast}
        </div>
      )}
    </div>
  );
}
