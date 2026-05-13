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
//
// 레이아웃 원칙: 퀴즈/플래시카드에서 스크롤이 발생하지 않도록
// "기본(낮은 레벨)" 화면은 [헤더 + 모드 + 본문] 만 노출하고,
// 문자 체계(히라/카타) 와 그룹(청음/탁음/요음) 선택은 헤더의 한 줄 칩에서
// 모달("윗 레벨")로 진입해 변경하도록 분리했다.
export default function KanaPage() {
  const [script, setScript] = useState<KanaScript>("hira");
  const [group, setGroup] = useState<KanaGroup>("seion");
  const [mode, setMode] = useState<Mode>("table");
  const [optionsOpen, setOptionsOpen] = useState(false);

  const charsInScope = useMemo(
    () => getKana(script, group),
    [script, group],
  );

  // 표 모드에서만 자체 스크롤을 허용한다 (행이 많아 자연스럽게 스크롤이 필요).
  // 퀴즈/플래시카드는 한 화면에 모두 들어가야 하므로 overflow-hidden.
  const bodyOverflow =
    mode === "table" ? "overflow-y-auto" : "overflow-hidden";

  return (
    <div className="-my-5 -mx-4 flex h-[calc(100%+2.5rem)] flex-col gap-2 overflow-hidden px-4 pt-2 pb-1">
      <header className="flex shrink-0 items-center justify-between gap-2">
        <div className="flex min-w-0 items-center gap-2">
          <h2 className="pixel-text shrink-0 font-pixel text-base text-parchment-100">
            🏯 카나 수련장
          </h2>
          {/* 현재 선택 칩 — 탭하면 모달로 카나/그룹 변경 */}
          <button
            type="button"
            onClick={() => setOptionsOpen(true)}
            className="flex min-w-0 items-center gap-1 border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-[10px] text-parchment-100 hover:bg-dungeon-100"
            aria-label="카나/그룹 변경"
            title="카나/그룹 변경"
          >
            <span className="pixel-text-jp truncate">
              {KANA_SCRIPT_LABEL[script].jp} · {KANA_GROUP_LABEL[group].jp}
            </span>
            <span aria-hidden className="text-parchment-300">▾</span>
          </button>
        </div>
        <Link to="/" className="btn-ghost shrink-0 !px-3 !py-1.5 !text-[10px]">
          ✕ 나가기
        </Link>
      </header>

      {/* 모드 선택 — 페이지에 항상 보이는 1차 컨트롤 */}
      <div className="grid shrink-0 grid-cols-3 gap-1.5">
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

      {/* 모드별 본문 — 남은 공간을 모두 차지 */}
      <div className={`min-h-0 flex-1 ${bodyOverflow}`}>
        {mode === "table" && <KanaTable script={script} group={group} />}
        {mode === "flashcard" && (
          <KanaFlashcard chars={charsInScope} script={script} />
        )}
        {mode === "quiz" && <KanaQuiz chars={charsInScope} script={script} />}
      </div>

      {optionsOpen && (
        <KanaOptionsModal
          script={script}
          group={group}
          onChangeScript={setScript}
          onChangeGroup={setGroup}
          onClose={() => setOptionsOpen(false)}
        />
      )}
    </div>
  );
}

// ───────── 옵션 모달 ─────────

function KanaOptionsModal({
  script,
  group,
  onChangeScript,
  onChangeGroup,
  onClose,
}: {
  script: KanaScript;
  group: KanaGroup;
  onChangeScript: (v: KanaScript) => void;
  onChangeGroup: (v: KanaGroup) => void;
  onClose: () => void;
}) {
  return (
    <div
      className="fixed inset-0 z-40 flex items-end justify-center bg-black/60 p-4 sm:items-center"
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="panel w-full max-w-sm space-y-3"
      >
        <div className="flex items-center justify-between">
          <h3 className="pixel-text font-pixel text-sm text-parchment-100">
            카나/그룹 변경
          </h3>
          <button
            onClick={onClose}
            className="font-pixel text-xs text-parchment-300 hover:text-parchment-100"
            aria-label="닫기"
          >
            ✕
          </button>
        </div>

        <div className="space-y-2">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            문자 체계
          </div>
          <SegmentSelector
            value={script}
            onChange={(v) => onChangeScript(v as KanaScript)}
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
        </div>

        <div className="space-y-2">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            그룹
          </div>
          <SegmentSelector
            value={group}
            onChange={(v) => onChangeGroup(v as KanaGroup)}
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
        </div>

        <button onClick={onClose} className="btn-primary w-full !py-2">
          확인
        </button>
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
      <div className="flex shrink-0 items-center justify-between font-pixel text-[10px] text-parchment-300">
        <span>
          {index + 1} / {shuffled.length}
        </span>
        <span>{KANA_SCRIPT_LABEL[script].jp}</span>
      </div>

      {/* 카드는 남은 세로 공간을 모두 사용해 자동 크기 조절. 화면이 작아도
          스크롤 없이 들어가도록 글자 크기는 clamp 로 자동 축소한다. */}
      <div className="flip-perspective relative min-h-0 w-full flex-1">
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
          {/* FRONT — 글자를 카드 정중앙에 두기 위해 안내 텍스트는
              flex 레이아웃에서 빼서 absolute 로 하단에 띄운다.
              (mt-auto 를 쓰면 글자가 위쪽으로 쏠림) */}
          <div className="flip-face panel-parchment scanline relative flex flex-col items-center justify-center p-3">
            <div
              className="pixel-text-jp font-bold leading-none text-parchment-900"
              style={{ fontSize: "clamp(80px, 22vh, 140px)" }}
            >
              {current.char}
            </div>
            <div className="pointer-events-none absolute inset-x-0 bottom-2 text-center font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              ▲ 탭해서 발음 확인
            </div>
          </div>

          {/* BACK — 본문(글자/로마지/행 표기)은 진짜 가운데에 두고,
              하단 안내 텍스트는 마찬가지로 absolute 로 분리한다. */}
          <div className="flip-face flip-back panel-parchment scanline relative flex flex-col items-center justify-center gap-2 p-3">
            <div
              className="pixel-text-jp font-bold text-parchment-900"
              style={{ fontSize: "clamp(56px, 14vh, 88px)" }}
            >
              {current.char}
            </div>
            <div
              className="font-pixel uppercase tracking-wider text-rune-600"
              style={{ fontSize: "clamp(20px, 5vh, 30px)" }}
            >
              {current.romaji}
            </div>
            <div className="font-pixel text-[10px] text-parchment-700">
              「{current.row}」행
            </div>
            <div className="pointer-events-none absolute inset-x-0 bottom-2 text-center font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              ▼ 탭해서 글자로
            </div>
          </div>
        </div>
      </div>

      <div className="grid shrink-0 grid-cols-2 gap-1.5">
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
    <div className="flex h-full flex-col gap-2">
      <div className="flex shrink-0 items-center justify-between font-pixel text-[10px] text-parchment-300">
        <span>
          {index + 1} / {queue.length} · {KANA_SCRIPT_LABEL[script].jp}
        </span>
        <span className="flex items-center gap-2">
          <span className="text-parchment-200">🔥 {streak}</span>
          <span>최고 {bestStreak}</span>
        </span>
      </div>

      {/* 질문 패널은 남은 세로 공간을 모두 사용. 작은 화면에서도 글자가
          버튼/하단 결과 텍스트를 밀어내지 않도록 clamp 로 자동 축소한다. */}
      <div className="panel-parchment flex min-h-0 flex-1 flex-col items-center justify-center gap-1 !p-3">
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
          이 글자의 발음은?
        </div>
        <div
          className="pixel-text-jp font-bold leading-none text-parchment-900"
          style={{ fontSize: "clamp(72px, 20vh, 130px)" }}
        >
          {current.char}
        </div>
      </div>

      <div className="grid shrink-0 grid-cols-2 gap-1.5">
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
              className={`border-2 px-3 py-2 font-pixel text-base uppercase transition active:translate-y-[1px] ${tone}`}
            >
              {opt}
            </button>
          );
        })}
      </div>

      {/* 결과 텍스트는 표시 여부와 무관하게 같은 높이를 차지해
          정답/오답 시 버튼 그리드가 위로 밀리며 카드가 흔들리는 것을 막는다. */}
      <div className="flex h-4 shrink-0 items-center justify-center text-center font-pixel text-xs text-parchment-200">
        {picked &&
          (picked === current.romaji ? (
            <span className="text-rune-400">⚔ 정답! +1 처치</span>
          ) : (
            <span className="text-volcano-400">
              💥 오답 — 정답은 "{current.romaji}"
            </span>
          ))}
      </div>
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
