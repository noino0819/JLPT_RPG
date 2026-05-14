import { useEffect, useState } from "react";
import type { RelatedWord, Word, WordRelationType } from "../types";
import { useProfileStore } from "../store/profileStore";
import { isTtsAvailable, speakJa, stopTts } from "../lib/tts";

// 관계 타입별 표시 라벨/기호 (UI 상수)
const RELATION_LABELS: Record<WordRelationType, { label: string; symbol: string }> = {
  synonym: { label: "유의 표현", symbol: "≒" },
  antonym: { label: "반의 표현", symbol: "↔" },
  idiom_variant: { label: "관용 변형", symbol: "≈" },
  context_pair: { label: "문맥 페어", symbol: "↔" },
};

interface Props {
  word: Word;
  shaking?: boolean;
  onFlipChange?: (flipped: boolean) => void;
  /**
   * true 이면 부모 높이를 가득 채움 (학습 화면 - 스크롤 방지).
   * false 이면 기존 고정 높이 유지.
   */
  fillHeight?: boolean;
}

/**
 * 양피지 컨셉 단어 카드.
 * 앞면: 한자(또는 히라가나) + 읽기
 * 뒷면: 뜻 + 어원 + 예문
 * 클릭으로 3D 플립.
 */
export default function WordCard({
  word,
  shaking,
  onFlipChange,
  fillHeight = false,
}: Props) {
  const [flipped, setFlipped] = useState(false);
  const tts = useProfileStore((s) => s.settings.tts);
  const ttsOn = tts.enabled && isTtsAvailable();

  useEffect(() => {
    setFlipped(false);
    // 카드가 바뀌면 진행 중이던 발화는 중단(다른 단어가 끼어들지 않도록).
    stopTts();
  }, [word.id]);

  // 자동 재생: 새 단어가 등장할 때 앞면(읽기 또는 한자)을 읽어준다.
  useEffect(() => {
    if (!ttsOn || !tts.autoplay) return;
    const text = word.reading || word.headword || "";
    if (text) speakJa(text, { rate: tts.rate });
    return () => stopTts();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [word.id, ttsOn, tts.autoplay, tts.rate]);

  useEffect(() => {
    onFlipChange?.(flipped);
  }, [flipped, onFlipChange]);

  const speak = (text: string | null | undefined) => {
    if (!ttsOn || !text) return;
    speakJa(text, { rate: tts.rate });
  };

  const isHiraganaOnly = !word.headword;

  // fillHeight=true 일 때 부모(flex 컨테이너)의 남은 공간을 그대로 채운다.
  // 작은 화면에서 스크롤이 생기지 않도록 별도의 min-h 는 두지 않는다.
  const innerSize = fillHeight ? "h-full min-h-0" : "h-[360px] sm:h-[420px]";

  return (
    <div
      className={`flip-perspective relative w-full ${
        fillHeight ? "h-full" : ""
      }`}
    >
      <div
        className={`flip-inner relative w-full ${innerSize} ${
          flipped ? "flipped" : ""
        } ${shaking ? "animate-cardShake" : ""}`}
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
        {/* 단어 본문은 카드의 정확한 가운데에 위치시키고,
            "탭해서 뒤집기" 힌트는 카드 하단에 고정한다.
            (이전엔 힌트의 mt-auto 가 위쪽 공간을 흡수해 단어가 위로 붙어 보였음) */}
        <div className="flip-face panel-parchment scanline relative flex cursor-pointer flex-col p-4 sm:p-6">
          {ttsOn && (
            <SpeakerButton
              ariaLabel="단어 발음 듣기"
              onClick={() => speak(word.reading || word.headword)}
              className="absolute right-2 top-2"
            />
          )}
          <div className="flex flex-1 flex-col items-center justify-center gap-2">
            <div className="flex flex-wrap items-center justify-center gap-1.5">
              {word.part_of_speech && (
                <span className="badge-pixel !bg-parchment-300 !text-parchment-900">
                  {word.part_of_speech}
                </span>
              )}
              {/* 짝 단어가 있을 때 카드 앞면에 「≒ 페어」 배지로 사실만 노출.
                  실제 짝 단어는 스포일러가 되므로 뒷면에서 공개. */}
              {word.related?.some((r) => r.relation_type === "synonym") && (
                <span className="badge-pixel !bg-parchment-200 !text-parchment-800">
                  ≒ 페어
                </span>
              )}
              {word.related?.some((r) => r.relation_type === "antonym") && (
                <span className="badge-pixel !bg-parchment-200 !text-parchment-800">
                  ↔ 반의
                </span>
              )}
            </div>

            {isHiraganaOnly ? (
              <div className="pixel-text-jp text-6xl font-bold text-parchment-900 sm:text-7xl">
                {word.reading}
              </div>
            ) : (
              <>
                <div className="pixel-text-jp text-6xl font-bold leading-none text-parchment-900 sm:text-8xl">
                  {word.headword}
                </div>
                <div className="pixel-text-jp mt-2 text-2xl text-parchment-700 sm:text-3xl">
                  {word.reading}
                </div>
              </>
            )}
          </div>

          <div className="shrink-0 pt-3 text-center font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
            ▲ 탭해서 뒤집기
          </div>
        </div>

        {/* BACK — 어원/예문이 가능하면 스크롤 없이 한 화면에 보이도록
            패딩과 섹션 간격을 최소화한다. */}
        <div className="flip-face flip-back panel-parchment scanline flex cursor-pointer flex-col gap-2 overflow-y-auto p-3 sm:p-4">
          <div className="flex items-baseline justify-between gap-2">
            <div className="pixel-text-jp text-xl font-bold text-parchment-900 sm:text-2xl">
              {word.headword ?? word.reading}
            </div>
            <div className="flex items-center gap-2">
              <div className="pixel-text-jp text-sm text-parchment-700 sm:text-base">
                {word.reading}
              </div>
              {ttsOn && (
                <SpeakerButton
                  ariaLabel="단어 발음 듣기"
                  onClick={() => speak(word.reading || word.headword)}
                />
              )}
            </div>
          </div>

          {/* 페어 표현 한 줄 강조 — 단어 헤드 바로 아래에 짝 단어를 즉시 보여줘
              「이 표현은 어떤 표현과 ≒ 인지」 카드를 뒤집자마자 한눈에 인식. */}
          {word.related && word.related.length > 0 && (
            <PairHeadline related={word.related} ttsOn={ttsOn} onSpeak={speak} />
          )}

          <div className="border-y-2 border-parchment-700/30 py-1.5">
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              뜻
            </div>
            <div className="text-xl font-bold leading-tight text-parchment-900 sm:text-2xl">
              {word.meaning}
            </div>
            {/* 페어 뜻도 같이 노출 — 의미 페어 인식을 즉각화 */}
            {word.related && word.related.length > 0 && (
              <ul className="mt-1 space-y-0.5">
                {word.related.map((r) => {
                  const meta = RELATION_LABELS[r.relation_type];
                  return (
                    <li
                      key={r.word.id}
                      className="text-[13px] leading-snug text-parchment-700 sm:text-sm"
                    >
                      <span className="font-pixel text-parchment-700">
                        {meta.symbol}
                      </span>{" "}
                      {r.word.meaning}
                    </li>
                  );
                })}
              </ul>
            )}
          </div>

          {word.etymology && (
            <div>
              <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
                한자 어원
              </div>
              <div className="whitespace-pre-line pt-0.5 text-[13px] leading-snug text-parchment-800">
                {word.etymology}
              </div>
            </div>
          )}

          {word.examples.length > 0 && (
            <div>
              <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
                예문
              </div>
              <ul className="mt-1 space-y-1.5">
                {word.examples.map((ex) => (
                  <li
                    key={ex.id}
                    className="rounded-none border-2 border-parchment-700/30 bg-parchment-50 px-2 py-1.5"
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="pixel-text-jp text-sm leading-tight text-parchment-900 sm:text-base">
                        {ex.jp_sentence}
                      </div>
                      {ttsOn && (
                        <SpeakerButton
                          ariaLabel="예문 읽어주기"
                          onClick={() => speak(ex.jp_sentence)}
                          size="sm"
                        />
                      )}
                    </div>
                    <div className="text-[11px] leading-tight text-parchment-700 sm:text-xs">
                      {ex.kr_translation}
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {word.related && word.related.length > 0 && (
            <RelatedSection
              related={word.related}
              ttsOn={ttsOn}
              onSpeak={speak}
            />
          )}

          <div className="mt-auto shrink-0 pt-3 text-center font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
            ▼ 탭해서 앞으로
          </div>
        </div>
      </div>
    </div>
  );
}

/**
 * 단어 헤드 바로 아래에 짝 표현을 한 줄로 강조 표시.
 * 「明るくしてください ≒ 電気をつけてください」 식으로 페어 관계를 즉시 인식 가능.
 * 여러 관계가 있으면 줄 단위로 나열.
 */
function PairHeadline({
  related,
  ttsOn,
  onSpeak,
}: {
  related: RelatedWord[];
  ttsOn: boolean;
  onSpeak: (t: string | null | undefined) => void;
}) {
  return (
    <ul className="-mt-0.5 space-y-1">
      {related.map((r) => {
        const meta = RELATION_LABELS[r.relation_type];
        const rw = r.word;
        const jp = rw.headword ?? rw.reading;
        return (
          <li key={rw.id} className="flex items-baseline justify-between gap-2">
            <div className="flex flex-wrap items-baseline gap-x-1.5">
              <span className="font-pixel text-base text-parchment-700">
                {meta.symbol}
              </span>
              <span className="pixel-text-jp text-lg font-bold leading-tight text-parchment-900 sm:text-xl">
                {jp}
              </span>
              {rw.headword && (
                <span className="pixel-text-jp text-xs text-parchment-700 sm:text-sm">
                  {rw.reading}
                </span>
              )}
            </div>
            {ttsOn && (
              <SpeakerButton
                ariaLabel="짝 표현 읽어주기"
                onClick={() => onSpeak(rw.reading || rw.headword)}
                size="sm"
              />
            )}
          </li>
        );
      })}
    </ul>
  );
}

/**
 * 단어 카드 뒷면의 「유의 표현/반의 표현」 섹션.
 * 관계 종류별로 그룹화하고, 각 표현마다 한자 어원·예문 2개·읽기 듣기 버튼까지 노출.
 */
function RelatedSection({
  related,
  ttsOn,
  onSpeak,
}: {
  related: RelatedWord[];
  ttsOn: boolean;
  onSpeak: (t: string | null | undefined) => void;
}) {
  // 관계 type 별로 묶어 표시 (synonym 만 있어도, 차후 antonym 추가 시 같이 보임)
  const grouped = new Map<WordRelationType, RelatedWord[]>();
  for (const r of related) {
    const list = grouped.get(r.relation_type) ?? [];
    list.push(r);
    grouped.set(r.relation_type, list);
  }

  return (
    <div className="space-y-2">
      {Array.from(grouped.entries()).map(([type, items]) => {
        const meta = RELATION_LABELS[type];
        return (
          <div key={type}>
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              {meta.symbol} {meta.label}
            </div>
            <ul className="mt-1 space-y-1.5">
              {items.map((r) => {
                const rw = r.word;
                const jp = rw.headword ?? rw.reading;
                return (
                  <li
                    key={rw.id}
                    className="rounded-none border-2 border-parchment-700/30 bg-parchment-50/70 px-2 py-1.5"
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="min-w-0 flex-1">
                        <div className="flex flex-wrap items-baseline gap-x-2">
                          <span className="pixel-text-jp text-base font-bold leading-tight text-parchment-900 sm:text-lg">
                            {jp}
                          </span>
                          {rw.headword && (
                            <span className="pixel-text-jp text-xs text-parchment-700">
                              {rw.reading}
                            </span>
                          )}
                        </div>
                        <div className="text-[12px] leading-snug text-parchment-800 sm:text-sm">
                          {rw.meaning}
                        </div>
                      </div>
                      {ttsOn && (
                        <SpeakerButton
                          ariaLabel="유의 표현 읽어주기"
                          onClick={() => onSpeak(rw.reading || rw.headword)}
                          size="sm"
                        />
                      )}
                    </div>

                    {rw.etymology && (
                      <div className="mt-1 whitespace-pre-line text-[11px] leading-snug text-parchment-700 sm:text-[12px]">
                        <span className="font-pixel text-[9px] uppercase tracking-widest text-parchment-700">
                          한자 어원
                        </span>{" "}
                        {rw.etymology}
                      </div>
                    )}

                    {r.explanation && (
                      <div className="mt-1 text-[11px] leading-snug text-parchment-600 sm:text-[12px]">
                        <span className="font-pixel text-[9px] uppercase tracking-widest text-parchment-700">
                          관계
                        </span>{" "}
                        {r.explanation}
                      </div>
                    )}

                    {rw.examples && rw.examples.length > 0 && (
                      <ul className="mt-1 space-y-1">
                        {rw.examples.map((ex) => (
                          <li
                            key={ex.id}
                            className="border-l-2 border-parchment-700/30 pl-1.5"
                          >
                            <div className="flex items-start justify-between gap-2">
                              <div className="pixel-text-jp text-[12px] leading-tight text-parchment-900 sm:text-sm">
                                {ex.jp_sentence}
                              </div>
                              {ttsOn && (
                                <SpeakerButton
                                  ariaLabel="예문 읽어주기"
                                  onClick={() => onSpeak(ex.jp_sentence)}
                                  size="sm"
                                />
                              )}
                            </div>
                            <div className="text-[10px] leading-tight text-parchment-600 sm:text-[11px]">
                              {ex.kr_translation}
                            </div>
                          </li>
                        ))}
                      </ul>
                    )}
                  </li>
                );
              })}
            </ul>
          </div>
        );
      })}
    </div>
  );
}

/**
 * 카드 안에서 쓰이는 🔊 버튼.
 * 카드 자체에 onClick(=뒤집기) 가 걸려 있으므로 반드시 stopPropagation.
 */
function SpeakerButton({
  ariaLabel,
  onClick,
  className = "",
  size = "md",
}: {
  ariaLabel: string;
  onClick: () => void;
  className?: string;
  size?: "sm" | "md";
}) {
  const pad = size === "sm" ? "px-1.5 py-0.5 text-[11px]" : "px-2 py-1 text-xs";
  return (
    <button
      type="button"
      aria-label={ariaLabel}
      title={ariaLabel}
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
      className={`shrink-0 border-2 border-parchment-700/40 bg-parchment-100 font-pixel text-parchment-900 hover:bg-parchment-200 active:translate-y-[1px] ${pad} ${className}`}
    >
      🔊
    </button>
  );
}
