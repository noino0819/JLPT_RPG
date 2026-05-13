import { useEffect, useMemo, useRef, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import AttackEffect from "../components/AttackEffect";
import PixelCharacter from "../components/PixelCharacter";
import PixelMonster, {
  type MonsterState,
} from "../components/PixelMonster";
import WordCard from "../components/WordCard";
import { BOSSES, BOSS_MIN_WORDS, computeBossHp } from "../data/bosses";
import { DUNGEONS } from "../data/dungeons";
import { useDecksStore } from "../store/decksStore";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";
import {
  playBossDeath,
  playBossHit,
  playBossRoar,
  playClick,
  playPlayerHurt,
} from "../lib/sfx";
import type { JlptLevel, Word } from "../types";

/**
 * 보스 던전 페이지 (얇은 wrapper).
 *
 * 마스터 단어 풀을 고정한 채 전투를 진행해야 하므로,
 * 실제 전투 로직(useState/HP 등)은 BossBattle 자식 컴포넌트로 분리한다.
 * 이렇게 해야 데이터 로딩 완료 / 진입 자격(BOSS_MIN_WORDS) 검증 후
 * "처음 한 번"의 초기값으로 보스 HP 와 단어 큐를 잠글 수 있다.
 */
export default function BossPage() {
  const { level } = useParams<{ level: JlptLevel }>();
  const decks = useDecksStore((s) => s.decks);
  const words = useDecksStore((s) => s.words);
  const loaded = useDecksStore((s) => s.loaded);
  const byWord = useProgressStore((s) => s.byWord);

  const dungeon = level ? DUNGEONS[level] : null;
  const boss = level ? BOSSES[level] : null;

  // 마스터한 단어들만 추출 (level 변경 또는 데이터 갱신 시만 재계산)
  const masteredWords = useMemo(() => {
    if (!level) return [] as Word[];
    const lvDeckIds = new Set(
      decks.filter((d) => d.jlpt_level === level).map((d) => d.id),
    );
    return words.filter(
      (w) => lvDeckIds.has(w.deck_id) && byWord[w.id]?.mastery === "mastered",
    );
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [level, decks, words]);

  if (!loaded) {
    return (
      <div className="grid h-[60vh] place-items-center">
        <div className="text-center">
          <div className="animate-bob text-4xl">⏳</div>
          <div className="mt-2 font-pixel text-xs text-parchment-300">
            전투 준비 중...
          </div>
        </div>
      </div>
    );
  }

  if (!level || !dungeon || !boss) {
    return (
      <div className="space-y-3">
        <div className="panel text-center">
          <p className="text-parchment-100">알 수 없는 보스 던전입니다.</p>
          <Link to="/" className="btn-primary mt-3 inline-block">
            돌아가기
          </Link>
        </div>
      </div>
    );
  }

  if (masteredWords.length < BOSS_MIN_WORDS) {
    return (
      <div className="space-y-3">
        <header className="flex items-center justify-between gap-2">
          <div className="flex items-center gap-2">
            <PixelMonster level={level} size={48} />
            <div>
              <div className="font-pixel text-[10px] text-parchment-300">
                {boss.title}
              </div>
              <h2 className="pixel-text font-pixel text-lg text-parchment-100">
                {boss.nameJp} ({boss.name})
              </h2>
            </div>
          </div>
          <Link to="/" className="btn-ghost !px-3 !py-1.5 !text-[10px]">
            ✕ 나가기
          </Link>
        </header>
        <div className="panel-parchment text-center !text-parchment-900">
          <div className="text-3xl">🛡️</div>
          <p className="mt-2 font-bold">아직은 보스에게 도전할 수 없어요.</p>
          <p className="mt-1 text-sm text-parchment-700">
            {dungeon.nameJp} 에서 마스터한 단어가 {BOSS_MIN_WORDS}개 이상이어야
            보스가 나타납니다.
            <br />
            현재 마스터: <strong>{masteredWords.length}</strong>개 / 필요{" "}
            {BOSS_MIN_WORDS}개
          </p>
          <Link
            to={`/study/${level}`}
            className="btn-primary mt-4 inline-block"
          >
            ▶ {dungeon.nameJp} 던전으로
          </Link>
        </div>
      </div>
    );
  }

  // 자식에 props 로 전달 — 자식 mount 시점에 한 번만 초기화 (key 로 retry 처리)
  return (
    <BossBattle
      key={`${level}-${masteredWords.length}`}
      level={level}
      masteredWords={masteredWords}
    />
  );
}

// ─────────────────────────────────────────────────────────────────────
// BossBattle: 실제 전투 컴포넌트
// ─────────────────────────────────────────────────────────────────────

interface BossBattleProps {
  level: JlptLevel;
  masteredWords: Word[];
}

function BossBattle({ level, masteredWords }: BossBattleProps) {
  const navigate = useNavigate();
  const dungeon = DUNGEONS[level];
  const boss = BOSSES[level];

  const setMastery = useProgressStore((s) => s.setMastery);
  const toggleFlag = useProgressStore((s) => s.toggleFlag);

  const { selected_character, settings, equipped } = useProfileStore();

  // 진입 시 한 번만 결정되는 값들
  const initialHp = useRef(computeBossHp(masteredWords.length)).current;
  const [hp, setHp] = useState(initialHp);
  const [queue, setQueue] = useState<Word[]>(() => shuffle([...masteredWords]));
  const [index, setIndex] = useState(0);

  // 전투 페이즈 — 'fighting' → 'dying' → 'won' / 'lost'
  // dying 동안엔 보스의 사망 모션을 충분히 보여주기 위해 배틀 씬에서 잠깐 머무름.
  type Phase = "fighting" | "dying" | "won" | "lost";
  const [phase, setPhase] = useState<Phase>("fighting");

  // 시각/사운드 효과 트리거
  const [attackTrigger, setAttackTrigger] = useState(0);
  const [shaking, setShaking] = useState(false);
  const [monsterState, setMonsterState] = useState<MonsterState>("idle");
  const [playerHurt, setPlayerHurt] = useState(false);
  const [vignetteKey, setVignetteKey] = useState(0);
  const [whiteFlash, setWhiteFlash] = useState(0);
  const [floatText, setFloatText] = useState<string | null>(null);

  // 마운트 시 보스 포효 (한 번만)
  useEffect(() => {
    if (settings.effects.sound) playBossRoar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // dying 중에도 카드는 그대로 보여 시각적 연속성을 유지 (버튼만 잠금)
  const currentWord = queue[index];

  const triggerHit = () => {
    if (settings.effects.attack) {
      setAttackTrigger((t) => t + 1);
    }
    if (settings.effects.card_shake) {
      setShaking(true);
      setTimeout(() => setShaking(false), 400);
    }
    if (settings.effects.sound) {
      playBossHit();
    }
    setMonsterState("hurt");
    setTimeout(
      () => setMonsterState((s) => (s === "hurt" ? "idle" : s)),
      520,
    );
  };

  const triggerCounter = () => {
    if (settings.effects.attack) {
      setPlayerHurt(true);
      setVignetteKey((v) => v + 1);
      setTimeout(() => setPlayerHurt(false), 420);
    }
    if (settings.effects.sound) {
      playPlayerHurt();
    }
  };

  const triggerWin = () => {
    setPhase("dying");
    setMonsterState("dying");
    if (settings.effects.sound) {
      playBossDeath();
    }
    // 1) 1초간 "dying" 깜빡 + 흔들림
    setTimeout(() => {
      setMonsterState("dead");
      setWhiteFlash((v) => v + 1);
    }, 1000);
    // 2) 화이트 플래시 후 결과 화면으로 (산산조각 + 영혼 승천 0.6초 더 보여주고 전환)
    setTimeout(() => {
      setPhase("won");
    }, 1700);
  };

  const showFloat = (label: string) => {
    setFloatText(label);
    setTimeout(() => setFloatText(null), 800);
  };

  const advance = () => {
    if (index + 1 >= queue.length) {
      // 큐 끝 — 보스 HP 가 남아 있으면 큐 재셔플 후 처음으로
      setQueue((q) => shuffle([...q]));
      setIndex(0);
    } else {
      setIndex((i) => i + 1);
    }
  };

  const guarded = () => phase !== "fighting";

  const handleHit = () => {
    if (guarded() || !currentWord) return;
    triggerHit();
    showFloat("⚔ -1 HP");
    const nextHp = Math.max(0, hp - 1);
    setHp(nextHp);
    if (nextHp === 0) {
      // 사망 트리거 — 배틀 씬에서 죽는 모션을 충분히 보여준 뒤 결과 화면으로
      setTimeout(() => triggerWin(), 350);
    } else {
      advance();
    }
  };

  const handleConfess = () => {
    if (guarded() || !currentWord) return;
    setMastery(currentWord.id, "probably");
    const wasFlagged =
      useProgressStore.getState().byWord[currentWord.id]?.flagged ?? false;
    if (!wasFlagged) {
      toggleFlag(currentWord.id);
    }
    triggerCounter();
    showFloat("🔖 단어 강등");
    const nextQueue = queue.filter((_, i) => i !== index);
    setQueue(nextQueue);
    if (nextQueue.length === 0) {
      // 단어가 모두 강등되어 보스를 처치하지 못한 상태 — 후퇴 (패배)
      setTimeout(() => setPhase("lost"), 400);
    } else {
      setIndex((i) => Math.min(i, nextQueue.length - 1));
    }
  };

  const handleSkip = () => {
    if (guarded() || !currentWord) return;
    if (settings.effects.sound) playClick();
    advance();
  };

  // ─── 결과 화면 ───
  if (phase === "won") {
    return (
      <VictoryScreen
        level={level}
        bossNameJp={boss.nameJp}
        bossName={boss.name}
        quote={boss.victoryQuote}
        onRetry={() => navigate(0)}
        onExit={() => navigate("/")}
        flashKey={whiteFlash}
      />
    );
  }

  if (phase === "lost") {
    return (
      <DefeatScreen
        level={level}
        bossNameJp={boss.nameJp}
        bossName={boss.name}
        onRetry={() => navigate(0)}
        onExit={() => navigate("/")}
      />
    );
  }

  const hpPct = (hp / initialHp) * 100;
  const lowHp = hpPct <= 25;
  const hpBarColor = lowHp ? boss.hpDangerColor : boss.hpColor;

  return (
    <div
      className={`flex h-full flex-col gap-2 overflow-hidden -mx-4 -my-5 px-4 py-2 bg-gradient-to-b ${dungeon.theme.bg}`}
    >
      {/* 상단: 보스 HP/이름 + 나가기 */}
      <header className="flex shrink-0 items-center justify-between gap-2">
        <div className="min-w-0 flex-1">
          <div className="flex items-baseline justify-between gap-2">
            <div className="min-w-0">
              <div className="font-pixel text-[9px] tracking-widest text-parchment-300">
                {boss.title}
              </div>
              <h2
                className={`pixel-text truncate font-pixel text-base ${dungeon.theme.text}`}
              >
                {boss.nameJp}{" "}
                <span className="text-parchment-200">· {boss.name}</span>
              </h2>
            </div>
            <div
              className={`shrink-0 font-pixel text-xs ${
                lowHp ? "animate-hpPulse text-volcano-400" : "text-parchment-100"
              }`}
            >
              HP {hp} / {initialHp}
            </div>
          </div>
          <div className="mt-1 h-3 w-full border-2 border-black bg-dungeon-300/80">
            <div
              className={`h-full transition-all ${hpBarColor}`}
              style={{ width: `${hpPct}%` }}
            />
          </div>
        </div>
        <Link
          to="/"
          className="btn-ghost shrink-0 !px-3 !py-1.5 !text-[10px]"
        >
          ✕ 나가기
        </Link>
      </header>

      {/* 보스 + 카드 영역 */}
      <div
        className={`relative min-h-0 flex-1 ${
          playerHurt ? "animate-playerHurt" : ""
        }`}
      >
        {/* 보스 (상단 중앙) */}
        <div className="pointer-events-none absolute left-1/2 top-1 z-10 -translate-x-1/2">
          <PixelMonster
            level={level}
            size={120}
            state={monsterState}
            entrance
          />
        </div>

        {/* 단어 카드 (보스 아래쪽) */}
        <div className="absolute inset-x-0 bottom-0 top-[120px]">
          {currentWord && (
            <WordCard word={currentWord} shaking={shaking} fillHeight />
          )}
        </div>

        {/* 공격 이펙트 (보스 위치 기준) */}
        <div className="pointer-events-none absolute left-1/2 top-1 -translate-x-1/2">
          <div className="relative h-[120px] w-[120px]">
            <AttackEffect
              characterId={selected_character}
              trigger={attackTrigger}
            />
          </div>
        </div>

        {/* 플레이어 캐릭터 (오른쪽 아래) */}
        {settings.show_character && (
          <div className="pointer-events-none absolute bottom-1 right-1 z-20 drop-shadow-[2px_2px_0_rgba(0,0,0,0.6)]">
            <PixelCharacter
              id={selected_character}
              costumeId={equipped.costume[selected_character]}
              size={44}
            />
          </div>
        )}

        {/* 데미지/상태 텍스트 */}
        {floatText && (
          <div className="pointer-events-none absolute left-1/2 top-20 z-30 -translate-x-1/2 animate-floatUp font-pixel text-base text-rune-400 drop-shadow">
            {floatText}
          </div>
        )}

        {/* 화면 가장자리 붉은 비네팅 (보스 반격 시) */}
        {vignetteKey > 0 && (
          <div
            key={vignetteKey}
            className="pointer-events-none absolute inset-0 z-30 animate-bloodVignette"
            style={{
              background:
                "radial-gradient(circle, transparent 40%, rgba(180,0,0,0.6) 100%)",
            }}
          />
        )}
      </div>

      {/* 하단 액션 */}
      <div className="shrink-0">
        <div
          className={`grid grid-cols-3 gap-1.5 transition-opacity ${
            phase !== "fighting" ? "pointer-events-none opacity-50" : ""
          }`}
        >
          <button
            onClick={handleHit}
            disabled={phase !== "fighting"}
            className="btn-gold !py-2.5 !text-xs"
            aria-label="처치"
          >
            👑 알아!
          </button>
          <button
            onClick={handleConfess}
            disabled={phase !== "fighting"}
            className="btn-pixel bg-volcano-500 text-white hover:bg-volcano-400 !py-2.5 !text-xs"
            aria-label="헷갈림"
          >
            🔖 헷갈려
          </button>
          <button
            onClick={handleSkip}
            disabled={phase !== "fighting"}
            className="btn-ghost !py-2.5 !text-xs"
          >
            → 패스
          </button>
        </div>
        <div className="mt-1 text-center font-pixel text-[10px] text-parchment-300">
          {phase === "dying"
            ? "★ 보스가 쓰러집니다..."
            : "⚔ HP를 모두 깎으면 보스가 쓰러집니다 · 카드를 눌러 뒤집기"}
        </div>
      </div>

      {/* 사망 직후 화이트 플래시 */}
      {whiteFlash > 0 && (
        <div
          key={`wf-${whiteFlash}`}
          className="pointer-events-none fixed inset-0 z-50 animate-whiteFlash bg-white"
        />
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────────
// 결과 화면
// ─────────────────────────────────────────────────────────────────────

function VictoryScreen({
  level,
  bossNameJp,
  bossName,
  quote,
  onRetry,
  onExit,
  flashKey,
}: {
  level: JlptLevel;
  bossNameJp: string;
  bossName: string;
  quote: string;
  onRetry: () => void;
  onExit: () => void;
  flashKey: number;
}) {
  return (
    <div className="flex h-full flex-col items-center justify-center gap-4">
      <div className="text-center">
        <div className="font-pixel text-xs tracking-widest text-rune-400">
          BOSS DEFEATED
        </div>
        <h2 className="pixel-text mt-1 font-pixel text-2xl text-parchment-100">
          🏆 보스 격파!
        </h2>
      </div>

      <div className="relative">
        <PixelMonster level={level} size={140} state="dead" />
      </div>

      <div className="panel-parchment max-w-sm text-center !text-parchment-900">
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
          {bossNameJp} · {bossName}
        </div>
        <p className="mt-1.5 italic">"{quote}"</p>
      </div>

      <div className="flex w-full max-w-sm gap-2">
        <button onClick={onRetry} className="btn-primary flex-1">
          ↻ 다시 도전
        </button>
        <button onClick={onExit} className="btn-ghost flex-1">
          ▶ 다른 던전으로
        </button>
      </div>

      {flashKey > 0 && (
        <div
          key={`vf-${flashKey}`}
          className="pointer-events-none fixed inset-0 z-50 animate-whiteFlash bg-white"
        />
      )}
    </div>
  );
}

function DefeatScreen({
  level,
  bossNameJp,
  bossName,
  onRetry,
  onExit,
}: {
  level: JlptLevel;
  bossNameJp: string;
  bossName: string;
  onRetry: () => void;
  onExit: () => void;
}) {
  return (
    <div className="flex h-full flex-col items-center justify-center gap-4">
      <div className="text-center">
        <div className="font-pixel text-xs tracking-widest text-volcano-400">
          RETREAT
        </div>
        <h2 className="pixel-text mt-1 font-pixel text-2xl text-parchment-100">
          후퇴 ...
        </h2>
      </div>

      <PixelMonster level={level} size={120} state="idle" />

      <div className="panel max-w-sm text-center">
        <p className="font-pixel text-sm text-parchment-100">
          단어들이 흔들렸어요.
        </p>
        <p className="mt-2 text-sm text-parchment-200">
          "헷갈려" 한 단어들은 <strong>가물가물</strong> 상태로 돌아갔습니다.
          학습에서 다시 외운 뒤 도전해보세요.
        </p>
        <p className="mt-2 font-pixel text-[10px] text-parchment-300">
          {bossNameJp} · {bossName}
        </p>
      </div>

      <div className="flex w-full max-w-sm gap-2">
        <button onClick={onRetry} className="btn-primary flex-1">
          ↻ 재도전
        </button>
        <button onClick={onExit} className="btn-ghost flex-1">
          ▶ 던전 목록으로
        </button>
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────────
// 유틸
// ─────────────────────────────────────────────────────────────────────

function shuffle<T>(arr: T[]): T[] {
  for (let i = arr.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}
