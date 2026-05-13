import { useEffect, useMemo, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CHARACTER_LIST } from "../data/characters";
import { DUNGEONS } from "../data/dungeons";
import { buildStudyQueue } from "../lib/stats";
import { useDecksStore } from "../store/decksStore";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";
import type { CharacterId, JlptLevel, Mastery } from "../types";
import PixelCharacter from "../components/PixelCharacter";
import PixelPet from "../components/PixelPet";
import PixelDungeon from "../components/PixelDungeon";
import AttackEffect from "../components/AttackEffect";
import DefeatEffect from "../components/DefeatEffect";
import WordCard from "../components/WordCard";
import Toggle from "../components/Toggle";
import { playAttack, playDefeat, playFlag, playSkip } from "../lib/sfx";

interface Props {
  onlyFlagged?: boolean;
}

export default function StudyPage({ onlyFlagged = false }: Props) {
  const { level, deckId } = useParams<{
    level?: JlptLevel;
    deckId?: string;
  }>();
  const navigate = useNavigate();

  const { selected_character, setCharacter, settings, updateSettings, equipped } =
    useProfileStore();
  const { setMastery, toggleFlag, byWord, touch } = useProgressStore();
  // 스토어가 hydrate 될 때 리렌더되도록 직접 구독
  const decks = useDecksStore((s) => s.decks);
  const words = useDecksStore((s) => s.words);
  const loaded = useDecksStore((s) => s.loaded);

  const dungeon = level ? DUNGEONS[level] : null;
  const customDeck = deckId
    ? decks.find((d) => d.id === deckId) ?? null
    : null;

  const headerTitle = onlyFlagged
    ? "🔖 다시 보기"
    : dungeon
      ? `${dungeon.nameJp} (${level})`
      : customDeck
        ? `📜 ${customDeck.name}`
        : "학습";

  // 대상 단어 풀 결정
  const sourceWords = useMemo(() => {
    if (onlyFlagged) return words;
    if (deckId) {
      return words.filter((w) => w.deck_id === deckId);
    }
    if (level) {
      const deckIds = decks
        .filter((d) => d.jlpt_level === level)
        .map((d) => d.id);
      return words.filter((w) => deckIds.includes(w.deck_id));
    }
    return words;
  }, [level, deckId, onlyFlagged, decks, words]);

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

  // 시각 이펙트 + 플로팅 라벨만 담당. 사운드는 호출 측(handleAction)에서
  // 액션별로 직접 재생해 직업/상황별 사운드 매핑을 단순화한다.
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

    const soundOn = settings.effects.sound;

    switch (kind) {
      case "mastered":
        setMastery(word.id, "mastered" as Mastery);
        triggerAttack("⚔ +1 처치", { defeat: true });
        // 마무리 일격 — 직업별 처치 사운드
        if (soundOn) playDefeat(selected_character);
        break;
      case "probably":
        setMastery(word.id, "probably" as Mastery);
        triggerAttack("✓ 외운 것 같아요");
        // 가벼운 한 방 — 직업별 공격 사운드
        if (soundOn) playAttack(selected_character);
        break;
      case "flag": {
        // toggleFlag 호출 직전의 현재 상태를 기준으로 다음 상태(on/off)를 계산
        const nextOn = !(byWord[word.id]?.flagged ?? false);
        toggleFlag(word.id);
        triggerAttack(nextOn ? "🔖 보관함에 추가" : "🔖 보관함에서 제거");
        if (soundOn) playFlag(nextOn);
        break;
      }
      case "skip":
        touch(word.id);
        // 페이지 넘기는 듯한 가벼운 whoosh
        if (soundOn) playSkip();
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

  // 캐릭터 빠른 변경 (카드 위 캐릭터 클릭 시 모달로 표시)
  const [pickerOpen, setPickerOpen] = useState(false);

  if (!loaded) {
    return (
      <div className="grid h-[60vh] place-items-center">
        <div className="text-center">
          <div className="animate-bob text-4xl">⏳</div>
          <div className="mt-2 font-pixel text-xs text-parchment-300">
            단어 데이터 로딩 중...
          </div>
        </div>
      </div>
    );
  }

  if (!word) {
    // 정복 완료 화면에서 "외운 단어 제외" 설정을 직접 토글할 수 있게 한다.
    // 토글을 끄면 마스터한 단어까지 포함하여 학습 큐를 즉시 재구성한다.
    const showExcludeToggle = !onlyFlagged;
    const handleToggleExcludeMemorized = (next: boolean) => {
      updateSettings({ exclude_memorized: next });
      const newQueue = buildStudyQueue(sourceWords, {
        order: settings.order,
        excludeMastered: next,
        probablyEvery: settings.probably_repeat_every,
        reviewWeight: settings.review_mix_weight,
        progress: useProgressStore.getState().byWord,
        onlyFlagged,
      });
      setQueue(newQueue);
      setIndex(0);
    };

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
              : "이 던전은 이미 정복했어요!"}
          </p>

          {showExcludeToggle && (
            <div className="mt-4 flex items-center justify-between gap-3 border-2 border-black bg-dungeon-50/60 p-3">
              <div className="text-left">
                <div className="font-pixel text-xs text-parchment-100">
                  외운 단어 제외
                </div>
                <div className="mt-1 font-pixel text-[10px] text-parchment-300">
                  {settings.exclude_memorized
                    ? "끄면 처음부터 다시 복습할 수 있어요"
                    : "외운 단어도 함께 등장합니다"}
                </div>
              </div>
              <Toggle
                on={settings.exclude_memorized}
                onChange={handleToggleExcludeMemorized}
                ariaLabel="외운 단어 제외 토글"
              />
            </div>
          )}

          <button
            className={`${showExcludeToggle ? "btn-ghost mt-3" : "btn-primary mt-4"} w-full`}
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
      // Layout 의 <main> 이 이미 (헤더/네비를 제외한) 정확한 높이를 잡아주므로
      // 여기서는 그 안을 h-full 로 가득 채우기만 하면 된다.
      // overflow-hidden 으로 자식이 살짝 넘쳐도 스크롤이 절대 생기지 않도록 보장.
      // gap-1.5 로 카드 영역에 더 많은 공간을 확보한다.
      className={`flex h-full flex-col gap-1.5 overflow-hidden ${
        dungeon
          ? `-mx-4 -my-5 px-4 py-2 bg-gradient-to-b ${dungeon.theme.bg}`
          : ""
      }`}
    >
      <header className="flex shrink-0 items-center justify-between gap-2">
        <div className="flex min-w-0 items-center gap-2">
          {dungeon && level && (
            <PixelDungeon level={level} size={36} animate />
          )}
          <div className="min-w-0">
            <h2 className="pixel-text truncate font-pixel text-lg text-parchment-100">
              {headerTitle}
            </h2>
            <div className="font-pixel text-[10px] text-parchment-300">
              {index + 1} / {queue.length}
            </div>
          </div>
        </div>
        <Link to="/" className="btn-ghost shrink-0 !px-3 !py-1.5 !text-[10px]">
          ✕ 나가기
        </Link>
      </header>

      {/* 카드 영역: 단어 카드 전용. 캐릭터/펫과 절대 겹치지 않도록
          카드 안에는 떠 있는 요소(이펙트/플로트 텍스트)만 둔다. */}
      <div className="relative min-h-0 flex-1">
        <WordCard word={word} shaking={shaking} fillHeight />
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

      {/* 캐릭터/펫 전용 줄: 카드와 액션 버튼 사이에 자기 자리를 차지하여
          단어장과 절대 겹치지 않게 한다. 카드 영역을 최대한 보존하기 위해
          높이를 최소(약 44px)로 유지하고, 좌측 정렬로 캐릭터(앞) → 펫(뒤)
          순서로 배치해 동료가 따라오는 듯한 느낌을 준다. */}
      {settings.show_character && (
        <div className="flex h-11 shrink-0 items-end justify-start gap-1.5 px-1 drop-shadow-[2px_2px_0_rgba(0,0,0,0.6)]">
          <button
            type="button"
            onClick={() => setPickerOpen((o) => !o)}
            aria-label="캐릭터 변경"
            title="캐릭터 변경"
          >
            <PixelCharacter
              id={selected_character}
              costumeId={equipped.costume[selected_character]}
              attacking={attacking}
              size={40}
            />
          </button>
          {equipped.pet && (
            <PixelPet petId={equipped.pet} size={28} delayMs={350} />
          )}
        </div>
      )}

      <div className="shrink-0">
        {/* 단어가 바뀔 때 뱃지가 나타나거나 사라지면서 행 높이가 변해
            아래 버튼 그리드까지 위아래로 흔들리는("울렁거림") 현상을 방지하기 위해
            min-h 로 항상 같은 높이를 유지한다. */}
        <div className="mb-1 flex min-h-[24px] items-center justify-between">
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

        <div className="grid grid-cols-2 gap-1.5">
          <button
            onClick={() => handleAction("mastered")}
            className="btn-gold !py-2.5"
          >
            👑 완벽히 외움
          </button>
          <button
            onClick={() => handleAction("probably")}
            className="btn-primary !py-2.5"
          >
            ✓ 외운 것 같아요
          </button>
          <button
            onClick={() => handleAction("flag")}
            className={`btn-pixel !py-2.5 ${
              progress?.flagged
                ? "bg-volcano-500 text-white"
                : "bg-dungeon-50 text-parchment-100"
            }`}
          >
            🔖 다시 보기
          </button>
          <button
            onClick={() => handleAction("skip")}
            className="btn-ghost !py-2.5"
          >
            → 다음
          </button>
        </div>
      </div>

      {pickerOpen && (
        <div
          className="fixed inset-0 z-40 flex items-end justify-center bg-black/60 p-4 sm:items-center"
          onClick={() => setPickerOpen(false)}
        >
          <div
            onClick={(e) => e.stopPropagation()}
            className="panel w-full max-w-sm space-y-3"
          >
            <div className="flex items-center justify-between">
              <h3 className="pixel-text font-pixel text-sm text-parchment-100">
                캐릭터 변경
              </h3>
              <button
                onClick={() => setPickerOpen(false)}
                className="font-pixel text-xs text-parchment-300 hover:text-parchment-100"
                aria-label="닫기"
              >
                ✕
              </button>
            </div>
            <div className="grid grid-cols-4 gap-2">
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
                  <PixelCharacter
                    id={c.id}
                    costumeId={equipped.costume[c.id]}
                    size={40}
                  />
                  <span className="font-pixel text-[10px] text-parchment-100">
                    {c.nameJp}
                  </span>
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      {showInfo && <InfoModal onClose={() => setShowInfo(false)} />}
    </div>
  );
}

function InfoModal({ onClose }: { onClose: () => void }) {
  const { settings, updateSettings } = useProfileStore();
  const excludeOn = settings.exclude_memorized;

  return (
    <div
      className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 p-4"
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="panel-parchment w-full max-w-sm space-y-4 p-5"
      >
        <div className="flex items-center justify-between">
          <h3 className="pixel-text font-pixel text-lg text-parchment-900">
            기억 상태 안내
          </h3>
          <button
            onClick={onClose}
            className="font-pixel text-xs text-parchment-700 hover:text-parchment-900"
            aria-label="닫기"
          >
            ✕
          </button>
        </div>

        <ul className="space-y-3 text-sm leading-relaxed text-parchment-800">
          <li className="space-y-2">
            <div className="flex items-start gap-2">
              <span className="shrink-0 font-pixel text-base">👑</span>
              <div>
                <strong className="text-parchment-900">완벽히 외움</strong>{" "}
                — 처치 +1, 등급에 반영됩니다.
              </div>
            </div>
            <div className="ml-7 rounded border border-parchment-700/40 bg-parchment-50/70 p-2 text-xs">
              <p className="text-parchment-700">
                "외운 단어 제외"가{" "}
                <strong className="text-parchment-900">
                  {excludeOn
                    ? "켜져 있어 다시 등장하지 않아요"
                    : "꺼져 있어 외운 단어도 다시 나와요"}
                </strong>
                .
              </p>
              <button
                onClick={() =>
                  updateSettings({ exclude_memorized: !excludeOn })
                }
                className={`mt-2 inline-flex w-full items-center justify-center gap-1 rounded-none border border-black px-2 py-1.5 font-pixel text-[10px] tracking-normal transition active:translate-y-[1px] ${
                  excludeOn
                    ? "bg-volcano-500/90 text-white hover:bg-volcano-400"
                    : "bg-rune-500/90 text-white hover:bg-rune-400"
                }`}
              >
                {excludeOn ? "🔁 복습 모드로 전환" : "✓ 외운 단어 제외 켜기"}
              </button>
            </div>
          </li>

          <li className="flex items-start gap-2">
            <span className="shrink-0 font-pixel text-base">✓</span>
            <div>
              <strong className="text-parchment-900">외운 것 같아요</strong>{" "}
              — 처치는 안 되지만, 일정 주기로 슬쩍 다시 등장해요.
            </div>
          </li>

          <li className="flex items-start gap-2">
            <span className="shrink-0 font-pixel text-base">🔖</span>
            <div>
              <strong className="text-parchment-900">다시 보기</strong> —
              보관함에 토글. 일반 학습에서는 가중치만큼 더 자주 등장하고, 다시
              보기 모드에서 한 번에 모아 볼 수도 있습니다.
            </div>
          </li>

          <li className="flex items-start gap-2">
            <span className="shrink-0 font-pixel text-base">→</span>
            <div>
              <strong className="text-parchment-900">다음</strong> — 상태 변경
              없이 그냥 넘기기.
            </div>
          </li>
        </ul>

        <button onClick={onClose} className="btn-primary w-full !py-2">
          닫기
        </button>
      </div>
    </div>
  );
}
