import { useEffect, useState } from "react";
import type { Word } from "../types";

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

  useEffect(() => {
    setFlipped(false);
  }, [word.id]);

  useEffect(() => {
    onFlipChange?.(flipped);
  }, [flipped, onFlipChange]);

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
        <div className="flip-face panel-parchment scanline flex cursor-pointer flex-col items-center justify-center gap-2 p-4 sm:p-6">
          {word.part_of_speech && (
            <span className="badge-pixel !bg-parchment-300 !text-parchment-900">
              {word.part_of_speech}
            </span>
          )}

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

          <div className="mt-auto pt-3 font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
            ▲ 탭해서 뒤집기
          </div>
        </div>

        {/* BACK — 어원/예문이 가능하면 스크롤 없이 한 화면에 보이도록
            패딩과 섹션 간격을 최소화한다. */}
        <div className="flip-face flip-back panel-parchment scanline flex cursor-pointer flex-col gap-2 overflow-y-auto p-3 sm:p-4">
          <div className="flex items-baseline justify-between">
            <div className="pixel-text-jp text-xl font-bold text-parchment-900 sm:text-2xl">
              {word.headword ?? word.reading}
            </div>
            <div className="pixel-text-jp text-sm text-parchment-700 sm:text-base">
              {word.reading}
            </div>
          </div>

          <div className="border-y-2 border-parchment-700/30 py-1.5">
            <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
              뜻
            </div>
            <div className="text-xl font-bold leading-tight text-parchment-900 sm:text-2xl">
              {word.meaning}
            </div>
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
                    <div className="pixel-text-jp text-sm leading-tight text-parchment-900 sm:text-base">
                      {ex.jp_sentence}
                    </div>
                    <div className="text-[11px] leading-tight text-parchment-700 sm:text-xs">
                      {ex.kr_translation}
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          )}

          <div className="mt-auto pt-1 text-right font-pixel text-[10px] uppercase tracking-widest text-parchment-700">
            ▼ 탭해서 앞으로
          </div>
        </div>
      </div>
    </div>
  );
}
