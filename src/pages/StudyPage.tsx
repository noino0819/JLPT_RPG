import { useEffect, useMemo, useRef, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CHARACTER_LIST } from "../data/characters";
import { DUNGEONS } from "../data/dungeons";
import { buildStudyQueue } from "../lib/stats";
import { useDecksStore } from "../store/decksStore";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";
import type { CharacterId, JlptLevel, Mastery } from "../types";
import PixelCharacter from "../components/PixelCharacter";
import AttackEffect from "../components/AttackEffect";
import DefeatEffect from "../components/DefeatEffect";
import WordCard from "../components/WordCard";

interface Props {
  onlyFlagged?: boolean;
}

export default function StudyPage({ onlyFlagged = false }: Props) {
  const { level, deckId } = useParams<{
    level?: JlptLevel;
    deckId?: string;
  }>();
  const navigate = useNavigate();

  const { selected_character, setCharacter, settings } = useProfileStore();
  const { setMastery, toggleFlag, byWord, touch } = useProgressStore();
  const { allDecks, allWords } = useDecksStore();

  const dungeon = level ? DUNGEONS[level] : null;
  const customDeck = deckId
    ? allDecks().find((d) => d.id === deckId) ?? null
    : null;

  const headerTitle = onlyFlagged
    ? "🔖 다시 보기"
    : dungeon
      ? `${dungeon.emoji} ${dungeon.nameJp} (${level})`
      : customDeck
        ? `📜 ${customDeck.name}`
        : "학습";

  // 대상 단어 풀 결정
  const sourceWords = useMemo(() => {
    if (onlyFlagged) return allWords();
    if (deckId) {
      return allWords().filter((w) => w.deck_id === deckId);
    }
    if (level) {
      const deckIds = allDecks()
        .filter((d) => d.jlpt_level === level)
        .map((d) => d.id);
      return allWords().filter((w) => deckIds.includes(w.deck_id));
    }
    return allWords();
  }, [level, deckId, onlyFlagged, allDecks, allWords]);

  // 학습 큐 (마운트 시 1회 + 단어 진행 변할 때 재생성하지 않음 — 세션 기반)
  const [queue, setQueue] = useState(() =>
    buildStudyQueue(sourceWords, {
      order: settings.order,
      excludeMastered: settings.exclude_memorized,
      probablyEvery: settings.probably_repeat_every,
      reviewWeight: settings.review_mix_weight,
      progress: byWord,
      onlyFlagged,
    }),
  );
  const [index, setIndex] = useState(0);

  useEffect(() => {
    const newQueue = buildStudyQueue(sourceWords, {
      order: settings.order,
      excludeMastered: settings.exclude_memorized,
      probablyEvery: settings.probably_repeat_every,
      reviewWeight: settings.review_mix_weight,
      progress: byWord,
      onlyFlagged,
    });
    setQueue(newQueue);
    setIndex(0);
  // sourceWords 자체는 stable 하지 않으니 deck/level 기준으로 다시 빌드
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [level, deckId, onlyFlagged]);

  const word = queue[index];

  const [attackTrigger, setAttackTrigger] = useState(0);
  const [defeatTrigger, setDefeatTrigger] = useState(0);
  const [attacking, setAttacking] = useState(false);
  const [shaking, setShaking] = useState(false);
  const [floatText, setFloatText] = useState<string | null>(null);
  const [showInfo, setShowInfo] = useState(false);

  const triggerAttack = (label: string, opts?: { defeat?: boolean }) => {
    if (settings.effects.attack) {
      setAttacking(true);
      setAttackTrigger((t) => t + 1);
      setTimeout(() => setAttacking(false), 500);
      if (opts?.defeat) {
        setDefeatTrigger((t) => t + 1);
      }
    }
    if (settings.effects.card_shake) {
      setShaking(true);
      setTimeout(() => setShaking(false), 400);
    }
    setFloatText(label);
    setTimeout(() => setFloatText(null), 800);
  };

  const handleAction = (kind: "mastered" | "probably" | "flag" | "skip") => {
    if (!word) return;

    switch (kind) {
      case "mastered":
        setMastery(word.id, "mastered" as Mastery);
        triggerAttack("⚔ +1 처치", { defeat: true });
        break;
      case "probably":
        setMastery(word.id, "probably" as Mastery);
        triggerAttack("✓ 외운 것 같아요");
        break;
      case "flag":
        toggleFlag(word.id);
        triggerAttack("🔖 보관함 토글");
        break;
      case "skip":
        touch(word.id);
        break;
    }

    // 처치 이펙트가 충분히 보이도록 다음 카드 전환을 약간 늦춤
    const delay = kind === "mastered" ? 700 : 350;
    setTimeout(() => {
      if (index + 1 >= queue.length) {
        // 한 바퀴 끝 — 큐 재생성
        const newQueue = buildStudyQueue(sourceWords, {
          order: settings.order,
          excludeMastered: settings.exclude_memorized,
          probablyEvery: settings.probably_repeat_every,
          reviewWeight: settings.review_mix_weight,
          progress: useProgressStore.getState().byWord,
          onlyFlagged,
        });
        setQueue(newQueue);
        setIndex(0);
      } else {
        setIndex((i) => i + 1);
      }
    }, delay);
  };

  // 캐릭터 빠른 변경
  const charPickerRef = useRef<HTMLDivElement>(null);
  const [pickerOpen, setPickerOpen] = useState(false);

  if (!word) {
    return (
      <div className="space-y-4">
        <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
          {headerTitle}
        </h2>
        <div className="panel text-center">
          <div className="text-4xl">🏆</div>
          <p className="mt-2 text-parchment-100">
            {onlyFlagged
              ? "다시 볼 단어가 없습니다. 카드에서 🔖 를 눌러 추가해보세요!"
              : "이 던전은 이미 정복했어요! 설정에서 '외운 단어 제외'를 끄면 복습할 수 있어요."}
          </p>
          <button
            className="btn-primary mt-4"
            onClick={() => navigate("/")}
          >
            ▶ 다른 던전으로
          </button>
        </div>
      </div>
    );
  }

  const progress = byWord[word.id];

  return (
    <div
      className={`space-y-4 ${
        dungeon
          ? `min-h-[80vh] -mx-4 -my-5 px-4 py-5 bg-gradient-to-b ${dungeon.theme.bg}`
          : ""
      }`}
    >
      <header className="flex items-center justify-between">
        <div>
          <h2 className="pixel-text font-pixel text-xl text-parchment-100">
            {headerTitle}
          </h2>
          <div className="font-pixel text-[10px] text-parchment-300">
            {index + 1} / {queue.length}
          </div>
        </div>
        <Link to="/" className="btn-ghost !px-3 !py-2 !text-[10px]">
          ✕ 나가기
        </Link>
      </header>

      <div className="relative">
        <WordCard word={word} shaking={shaking} />
        <AttackEffect
          characterId={selected_character}
          trigger={attackTrigger}
        />
        <DefeatEffect
          characterId={selected_character}
          trigger={defeatTrigger}
        />
        {floatText && (
          <div className="pointer-events-none absolute left-1/2 top-12 z-30 -translate-x-1/2 animate-floatUp font-pixel text-base text-rune-400 drop-shadow">
            {floatText}
          </div>
        )}
      </div>

      <div>
        <div className="mb-1 flex items-center justify-between">
          <div className="flex items-center gap-2 font-pixel text-xs text-parchment-200">
            기억 상태
            <button
              onClick={() => setShowInfo(true)}
              aria-label="설명"
              className="rounded-full border border-parchment-300 px-1.5 text-[10px] text-parchment-300 hover:bg-dungeon-100"
            >
              ⓘ
            </button>
          </div>
          <div className="flex gap-2 text-[10px]">
            {progress?.mastery === "mastered" && (
              <span className="badge-pixel !bg-rune-500/20 !text-rune-400">
                마스터
              </span>
            )}
            {progress?.mastery === "probably" && (
              <span className="badge-pixel !bg-parchment-400/20 !text-parchment-300">
                가물가물
              </span>
            )}
            {progress?.flagged && (
              <span className="badge-pixel !bg-volcano-500/20 !text-volcano-400">
                🔖
              </span>
            )}
          </div>
        </div>

        <div className="grid grid-cols-2 gap-2">
          <button onClick={() => handleAction("mastered")} className="btn-gold !py-4">
            👑 완벽히 외움
          </button>
          <button onClick={() => handleAction("probably")} className="btn-primary !py-4">
            ✓ 외운 것 같아요
          </button>
          <button
            onClick={() => handleAction("flag")}
            className={`btn-pixel !py-4 ${
              progress?.flagged
                ? "bg-volcano-500 text-white"
                : "bg-dungeon-50 text-parchment-100"
            }`}
          >
            🔖 다시 보기
          </button>
          <button onClick={() => handleAction("skip")} className="btn-ghost !py-4">
            → 다음
          </button>
        </div>
      </div>

      <div className="flex items-end justify-between" ref={charPickerRef}>
        <div className="flex items-center gap-3">
          <PixelCharacter
            id={selected_character}
            attacking={attacking}
            size={64}
          />
          <button
            onClick={() => setPickerOpen((o) => !o)}
            className="border-2 border-black bg-dungeon-100 px-2 py-1 font-pixel text-[10px] text-parchment-100 hover:bg-dungeon-50"
          >
            캐릭터 변경
          </button>
        </div>
      </div>

      {pickerOpen && (
        <div className="panel grid grid-cols-4 gap-2">
          {CHARACTER_LIST.map((c) => (
            <button
              key={c.id}
              onClick={() => {
                setCharacter(c.id as CharacterId);
                setPickerOpen(false);
              }}
              className={`flex flex-col items-center gap-1 border-2 p-2 ${
                c.id === selected_character
                  ? "border-rune-500 bg-rune-500/15"
                  : "border-black bg-dungeon-50 hover:bg-dungeon-100"
              }`}
            >
              <PixelCharacter id={c.id} size={40} />
              <span className="font-pixel text-[10px] text-parchment-100">
                {c.nameJp}
              </span>
            </button>
          ))}
        </div>
      )}

      {showInfo && <InfoModal onClose={() => setShowInfo(false)} />}
    </div>
  );
}

function InfoModal({ onClose }: { onClose: () => void }) {
  return (
    <div
      className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 p-4"
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="panel-parchment max-w-sm space-y-3"
      >
        <h3 className="pixel-text font-pixel text-lg text-parchment-900">
          기억 상태 안내
        </h3>
        <ul className="space-y-2 text-sm">
          <li>
            <strong>👑 완벽히 외움</strong> — 처치 +1, 등급에 반영됩니다.
            <br />
            <span className="text-xs text-parchment-700">
              설정의 "외운 단어 제외" 가 켜져 있으면 다시 등장하지 않아요.
            </span>
          </li>
          <li>
            <strong>✓ 외운 것 같아요</strong> — 처치는 안 되지만, 일정 주기로
            슬쩍 다시 등장해요.
          </li>
          <li>
            <strong>🔖 다시 보기</strong> — 보관함에 토글. 일반 학습에서는 가중치만큼 더
            자주 등장하고, 다시 보기 모드에서 한 번에 모아 볼 수도 있습니다.
          </li>
          <li>
            <strong>→ 다음</strong> — 상태 변경 없이 그냥 넘기기.
          </li>
        </ul>
        <button onClick={onClose} className="btn-primary w-full">
          닫기
        </button>
      </div>
    </div>
  );
}
