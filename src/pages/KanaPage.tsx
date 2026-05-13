import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import {
  KANA_GROUP_LABEL,
  KANA_SCRIPT_LABEL,
  getKana,
  getKanaGrid,
  type KanaChar,
  type KanaGroup,
  type KanaScript,
} from "../data/kana";
import {
  kanaMasteryLevel,
  useKanaProgressStore,
} from "../store/kanaProgressStore";
import { useProfileStore } from "../store/profileStore";
import { playClick, playDefeat } from "../lib/sfx";

type Mode = "table" | "flashcard" | "quiz";

// 카나 수련장 — 히라가나/가타카나 학습 페이지.
// - 표 뷰: 五十音図를 한눈에 보고 셀별 숙련도를 확인
// - 플래시카드: 카드 뒤집기로 발음 외우기
// - 퀴즈: 4지선다로 발음 맞추기
export default function KanaPage() {
  const [script, setScript] = useState<KanaScript>("hira");
  const [group, setGroup] = useState<KanaGroup>("seion");
  const [mode, setMode] = useState<Mode>("table");

  const charsInScope = useMemo(
    () => getKana(script, group),
    [script, group],
  );

  return (
    <div className="flex h-full flex-col gap-3">
      <header className="flex items-center justify-between gap-2">
        <div className="min-w-0">
          <h2 className="pixel-text font-pixel text-xl text-parchment-100">
            🏯 카나 수련장
          </h2>
          <div className="font-pixel text-[10px] text-parchment-300">
            仮名修練場 · 五十音 道場
          </div>
        </div>
        <Link to="/" className="btn-ghost shrink-0 !px-3 !py-1.5 !text-[10px]">
          ✕ 나가기
        </Link>
      </header>

      {/* 문자 체계 (히라가나 / 가타카나) 선택 */}
      <SegmentSelector
        value={script}
        onChange={(v) => setScript(v as KanaScript)}
        options={[
          {
            value: "hira",
            label: `${KANA_SCRIPT_LABEL.hira.emoji} ${KANA_SCRIPT_LABEL.hira.jp}`,
            sub: KANA_SCRIPT_LABEL.hira.ko,
          },
          {
            value: "kata",
            label: `${KANA_SCRIPT_LABEL.kata.emoji} ${KANA_SCRIPT_LABEL.kata.jp}`,
            sub: KANA_SCRIPT_LABEL.kata.ko,
          },
        ]}
      />

      {/* 그룹 (청음 / 탁음 / 요음) 선택 */}
      <SegmentSelector
        value={group}
        onChange={(v) => setGroup(v as KanaGroup)}
        options={[
          {
            value: "seion",
            label: KANA_GROUP_LABEL.seion.jp,
            sub: KANA_GROUP_LABEL.seion.ko,
          },
          {
            value: "dakuten",
            label: KANA_GROUP_LABEL.dakuten.jp,
            sub: KANA_GROUP_LABEL.dakuten.ko,
          },
          {
            value: "youon",
            label: KANA_GROUP_LABEL.youon.jp,
            sub: KANA_GROUP_LABEL.youon.ko,
          },
        ]}
        size="sm"
      />

      {/* 모드 선택 */}
      <div className="grid grid-cols-3 gap-1.5">
        <ModeButton
          active={mode === "table"}
          onClick={() => setMode("table")}
          icon="📖"
          label="표"
        />
        <ModeButton
          active={mode === "flashcard"}
          onClick={() => setMode("flashcard")}
          icon="🎴"
          label="플래시카드"
        />
        <ModeButton
          active={mode === "quiz"}
          onClick={() => setMode("quiz")}
          icon="⚔"
          label="퀴즈"
        />
      </div>

      {/* 모드별 본문 */}
      <div className="min-h-0 flex-1 overflow-y-auto">
        {mode === "table" && <KanaTable script={script} group={group} />}
        {mode === "flashcard" && (
          <KanaFlashcard chars={charsInScope} script={script} />
        )}
        {mode === "quiz" && <KanaQuiz chars={charsInScope} script={script} />}
      </div>
    </div>
  );
}

// ───────── 공용 컴포넌트 ─────────

interface SegmentOption {
  value: string;
  label: string;
  sub?: string;
}

function SegmentSelector({
  value,
  onChange,
  options,
  size = "md",
}: {
  value: string;
  onChange: (v: string) => void;
  options: SegmentOption[];
  size?: "sm" | "md";
}) {
  return (
    <div
      className={`grid gap-1.5`}
      style={{ gridTemplateColumns: `repeat(${options.length}, minmax(0, 1fr))` }}
    >
      {options.map((opt) => {
        const active = opt.value === value;
        const pad = size === "sm" ? "px-2 py-1.5" : "px-3 py-2";
        return (
          <button
            key={opt.value}
            onClick={() => onChange(opt.value)}
            className={`flex flex-col items-center justify-center gap-0.5 border-2 ${pad} font-pixel transition active:translate-y-[1px] ${
              active
                ? "border-rune-500 bg-rune-500/15 text-parchment-100"
                : "border-black bg-dungeon-50 text-parchment-200 hover:bg-dungeon-100"
            }`}
          >
            <span
              className={`pixel-text-jp ${size === "sm" ? "text-sm" : "text-base"}`}
            >
              {opt.label}
            </span>
            {opt.sub && (
              <span className="text-[10px] text-parchment-300">{opt.sub}</span>
            )}
          </button>
        );
      })}
    </div>
  );
}

function ModeButton({
  active,
  onClick,
  icon,
  label,
}: {
  active: boolean;
  onClick: () => void;
  icon: string;
  label: string;
}) {
  return (
    <button
      onClick={onClick}
      className={`flex items-center justify-center gap-1 border-2 px-2 py-1.5 font-pixel text-[11px] uppercase transition active:translate-y-[1px] ${
        active
          ? "border-parchment-300 bg-parchment-400/20 text-parchment-100"
          : "border-black bg-dungeon-50 text-parchment-300 hover:bg-dungeon-100"
      }`}
    >
      <span className="text-base">{icon}</span>
      {label}
    </button>
  );
}

// ───────── 1) 표 뷰 ─────────

function KanaTable({
  script,
  group,
}: {
  script: KanaScript;
  group: KanaGroup;
}) {
  const grid = useMemo(() => getKanaGrid(script, group), [script, group]);
  const byChar = useKanaProgressStore((s) => s.byChar);

  // 전체 진행도 통계
  const flat = grid.flatMap((row) =>
    row.cells.filter((c): c is KanaChar => c !== null),
  );
  const totals = {
    total: flat.length,
    mastered: flat.filter((c) => kanaMasteryLevel(byChar[c.id]) >= 2).length,
    seen: flat.filter((c) => (byChar[c.id]?.mastered ?? 0) > 0).length,
  };

  const headers =
    group === "youon" ? ["や", "ゆ", "よ"] : ["a", "i", "u", "e", "o"];

  return (
    <div className="space-y-3">
      <div className="panel-parchment !p-3">
        <div className="mb-2 flex items-center justify-between font-pixel text-[10px] text-parchment-700">
          <span>학습 현황</span>
          <span>
            {totals.mastered}/{totals.total} 통달 · {totals.seen} 노출
          </span>
        </div>
        <div className="h-2 w-full border-2 border-parchment-700/40 bg-parchment-50">
          <div
            className="h-full bg-rune-500 transition-all"
            style={{
              width: `${
                totals.total > 0
                  ? Math.round((totals.mastered / totals.total) * 100)
                  : 0
              }%`,
            }}
          />
        </div>
      </div>

      <div className="panel-parchment overflow-x-auto !p-2 sm:!p-3">
        <table className="w-full table-fixed border-collapse">
          <thead>
            <tr>
              <th className="w-10 font-pixel text-[10px] text-parchment-700"></th>
              {headers.map((h) => (
                <th
                  key={h}
                  className="font-pixel text-[10px] uppercase text-parchment-700"
                >
                  {h}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {grid.map((row) => (
              <tr key={row.row}>
                <td className="pixel-text-jp text-center text-sm font-bold text-parchment-700">
                  {row.row}
                </td>
                {row.cells.map((cell, i) => (
                  <td key={i} className="p-0.5">
                    {cell ? (
                      <KanaTableCell char={cell} stat={byChar[cell.id]} />
                    ) : (
                      <div className="aspect-square w-full" />
                    )}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <p className="text-center font-pixel text-[10px] text-parchment-300">
        💡 셀의 색은 숙련도. 위 모드에서 플래시카드/퀴즈로 외워보세요.
      </p>
    </div>
  );
}

function KanaTableCell({
  char,
  stat,
}: {
  char: KanaChar;
  stat?: import("../store/kanaProgressStore").KanaStat;
}) {
  const level = kanaMasteryLevel(stat);
  const tone =
    level === 3
      ? "bg-rune-500/30 border-rune-500 text-parchment-900"
      : level === 2
        ? "bg-parchment-300 border-parchment-700 text-parchment-900"
        : level === 1
          ? "bg-parchment-100 border-parchment-700/60 text-parchment-900"
          : "bg-parchment-50 border-parchment-700/30 text-parchment-800";

  return (
    <div
      className={`group relative flex aspect-square w-full flex-col items-center justify-center border-2 ${tone} transition`}
      title={`${char.char} = ${char.romaji}`}
    >
      <div className="pixel-text-jp text-xl font-bold leading-none sm:text-2xl">
        {char.char}
      </div>
      <div className="font-pixel text-[9px] uppercase opacity-70">
        {char.romaji}
      </div>
      {level >= 3 && (
        <div className="absolute right-0.5 top-0.5 text-[8px]">⭐</div>
      )}
    </div>
  );
}

// ───────── 2) 플래시카드 ─────────

function KanaFlashcard({
  chars,
  script,
}: {
  chars: KanaChar[];
  script: KanaScript;
}) {
  const [shuffled, setShuffled] = useState(() => shuffle(chars));
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const markMastered = useKanaProgressStore((s) => s.markMastered);
  const touch = useKanaProgressStore((s) => s.touch);
  const settings = useProfileStore((s) => s.settings);
  const selectedCharacter = useProfileStore((s) => s.selected_character);

  // script/group 이 바뀌면 새 풀로 재셔플.
  useEffect(() => {
    setShuffled(shuffle(chars));
    setIndex(0);
    setFlipped(false);
  }, [chars]);

  const current = shuffled[index];

  if (!current) {
    return (
      <div className="panel text-center">
        <div className="text-4xl">🏆</div>
        <p className="mt-2 text-parchment-100">학습할 글자가 없습니다.</p>
      </div>
    );
  }

  const goNext = (action: "known" | "skip") => {
    if (action === "known") {
      markMastered(current.id);
      if (settings.effects.sound) playDefeat(selectedCharacter);
    } else {
      touch(current.id);
      if (settings.effects.sound) playClick();
    }
    if (index + 1 >= shuffled.length) {
      setShuffled(shuffle(chars));
      setIndex(0);
    } else {
      setIndex((i) => i + 1);
    }
    setFlipped(false);
  };

  return (
    <div className="flex h-full flex-col gap-2">
      <div className="flex items-center justify-between font-pixel text-[10px] text-parchment-300">
        <span>
          {index + 1} / {shuffled.length}
        </span>
        <span>{KANA_SCRIPT_LABEL[script].jp}</span>
      </div>

      <div className="flip-perspective relative w-full" style={{ height: 280 }}>
        <div
          className={`flip-inner relative h-full w-full cursor-pointer ${
            flipped ? "flipped" : ""
          }`}
          onClick={() => setFlipped((f) => !f)}
          role="button"
          tabIndex={0}
          onKeyDown={(e) => {
            if (e.key === " " || e.key === "Enter") {
              e.preventDefault();
              setFlipped((f) => !f);
            }
          }}
        >
          {/* FRONT */}
          <div className="flip-face panel-parchment scanline flex flex-col items-center justify-center gap-2 p-4">
            <div className="pixel-text-jp text-[120px] font-bold leading-none text-parchment-900 sm:text-[140px]">
              {current.char}
            </div>
            <div className="mt-auto font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              ▲ 탭해서 발음 확인
            </div>
          </div>

          {/* BACK */}
          <div className="flip-face flip-back panel-parchment scanline flex flex-col items-center justify-center gap-3 p-4">
            <div className="pixel-text-jp text-7xl font-bold text-parchment-900">
              {current.char}
            </div>
            <div className="font-pixel text-3xl uppercase tracking-wider text-rune-600">
              {current.romaji}
            </div>
            <div className="font-pixel text-[10px] text-parchment-700">
              「{current.row}」행
            </div>
            <div className="mt-auto font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              ▼ 탭해서 글자로
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-1.5">
        <button
          onClick={() => goNext("known")}
          className="btn-gold !py-2.5"
        >
          👑 외웠음
        </button>
        <button
          onClick={() => goNext("skip")}
          className="btn-ghost !py-2.5"
        >
          → 다음
        </button>
      </div>
    </div>
  );
}

// ───────── 3) 퀴즈 ─────────

function KanaQuiz({
  chars,
  script,
}: {
  chars: KanaChar[];
  script: KanaScript;
}) {
  // 출제 큐 (셔플된 chars). 한 바퀴 돌고 나면 자동 재셔플.
  const [queue, setQueue] = useState(() => shuffle(chars));
  const [index, setIndex] = useState(0);
  const [picked, setPicked] = useState<string | null>(null);
  const [streak, setStreak] = useState(0);
  const [bestStreak, setBestStreak] = useState(0);
  const markMastered = useKanaProgressStore((s) => s.markMastered);
  const markWrong = useKanaProgressStore((s) => s.markWrong);
  const settings = useProfileStore((s) => s.settings);
  const selectedCharacter = useProfileStore((s) => s.selected_character);

  useEffect(() => {
    setQueue(shuffle(chars));
    setIndex(0);
    setPicked(null);
    setStreak(0);
  }, [chars]);

  const current = queue[index];

  // 4지선다 옵션 (정답 1개 + 동일 풀 내 오답 3개).
  const options = useMemo(() => {
    if (!current) return [] as string[];
    const pool = chars
      .filter((c) => c.romaji !== current.romaji)
      .map((c) => c.romaji);
    // 중복 제거
    const uniq = Array.from(new Set(pool));
    const wrong = shuffle(uniq).slice(0, 3);
    return shuffle([current.romaji, ...wrong]);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [current?.id]);

  if (!current) {
    return (
      <div className="panel text-center">
        <div className="text-4xl">🏆</div>
        <p className="mt-2 text-parchment-100">출제할 글자가 없습니다.</p>
      </div>
    );
  }

  const handlePick = (romaji: string) => {
    if (picked) return;
    setPicked(romaji);
    const correct = romaji === current.romaji;
    if (correct) {
      markMastered(current.id);
      setStreak((s) => {
        const next = s + 1;
        setBestStreak((b) => Math.max(b, next));
        return next;
      });
      if (settings.effects.sound) playDefeat(selectedCharacter);
    } else {
      markWrong(current.id);
      setStreak(0);
      if (settings.effects.sound) playClick();
    }
    // 다음 카드로 이동
    setTimeout(() => {
      setPicked(null);
      if (index + 1 >= queue.length) {
        setQueue(shuffle(chars));
        setIndex(0);
      } else {
        setIndex((i) => i + 1);
      }
    }, 650);
  };

  return (
    <div className="flex h-full flex-col gap-3">
      <div className="flex items-center justify-between font-pixel text-[10px] text-parchment-300">
        <span>
          {index + 1} / {queue.length} · {KANA_SCRIPT_LABEL[script].jp}
        </span>
        <span className="flex items-center gap-2">
          <span className="text-parchment-200">🔥 {streak}</span>
          <span>최고 {bestStreak}</span>
        </span>
      </div>

      <div className="panel-parchment flex flex-col items-center justify-center gap-2 !p-6">
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
          이 글자의 발음은?
        </div>
        <div className="pixel-text-jp text-[110px] font-bold leading-none text-parchment-900 sm:text-[130px]">
          {current.char}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-2">
        {options.map((opt) => {
          const isCorrect = opt === current.romaji;
          const isPicked = picked === opt;
          let tone =
            "border-black bg-dungeon-50 text-parchment-100 hover:bg-dungeon-100";
          if (picked) {
            if (isCorrect) {
              tone = "border-rune-500 bg-rune-500/30 text-parchment-100";
            } else if (isPicked) {
              tone = "border-volcano-500 bg-volcano-500/30 text-parchment-100";
            } else {
              tone = "border-black bg-dungeon-50 text-parchment-300 opacity-60";
            }
          }
          return (
            <button
              key={opt}
              onClick={() => handlePick(opt)}
              disabled={!!picked}
              className={`border-2 px-3 py-3 font-pixel text-base uppercase transition active:translate-y-[1px] ${tone}`}
            >
              {opt}
            </button>
          );
        })}
      </div>

      {picked && (
        <div className="text-center font-pixel text-xs text-parchment-200">
          {picked === current.romaji ? (
            <span className="text-rune-400">⚔ 정답! +1 처치</span>
          ) : (
            <span className="text-volcano-400">
              💥 오답 — 정답은 "{current.romaji}"
            </span>
          )}
        </div>
      )}
    </div>
  );
}

// ───────── 유틸 ─────────

function shuffle<T>(arr: T[]): T[] {
  const a = arr.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}
