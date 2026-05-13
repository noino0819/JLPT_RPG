import { useEffect, useRef } from "react";
import { useModalStore, type ModalTone } from "../store/modalStore";
import { useProfileStore } from "../store/profileStore";
import { playEnter, playSelect } from "../lib/sfx";

// 네이티브 alert / confirm 대체용 픽셀 스타일 모달.
// 큐의 head 를 렌더하고, 확인/취소 시 store.resolveHead 로 결과를 넘긴다.

const TONE_CLASS: Record<
  ModalTone,
  {
    border: string;
    eyebrow: string;
    icon: string;
    confirmBtn: string;
  }
> = {
  default: {
    border: "border-rune-500",
    eyebrow: "text-rune-400",
    icon: "📜",
    confirmBtn: "btn-primary",
  },
  danger: {
    border: "border-volcano-500",
    eyebrow: "text-volcano-400",
    icon: "⚠",
    confirmBtn: "btn-danger",
  },
  success: {
    border: "border-emerald-500",
    eyebrow: "text-emerald-400",
    icon: "✦",
    confirmBtn: "btn-primary",
  },
  warning: {
    border: "border-parchment-400",
    eyebrow: "text-parchment-300",
    icon: "!",
    confirmBtn: "btn-gold",
  },
};

export default function ConfirmModal() {
  const head = useModalStore((s) => s.queue[0]);
  const resolveHead = useModalStore((s) => s.resolveHead);
  const soundOn = useProfileStore((s) => s.settings.effects.sound);
  const confirmBtnRef = useRef<HTMLButtonElement>(null);

  // 모달이 새로 뜨면 확인 버튼에 포커스 → Enter 로 즉시 확인 가능
  useEffect(() => {
    if (head) confirmBtnRef.current?.focus();
  }, [head?.id]);

  // ESC 로 취소(혹은 alert 면 닫기), Enter 로 확인
  useEffect(() => {
    if (!head) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        e.preventDefault();
        if (soundOn) playSelect();
        resolveHead(head.kind === "alert");
      } else if (e.key === "Enter") {
        // input/textarea 내부에서의 Enter 는 무시
        const target = e.target as HTMLElement | null;
        if (
          target &&
          (target.tagName === "INPUT" || target.tagName === "TEXTAREA")
        )
          return;
        e.preventDefault();
        if (soundOn) playEnter();
        resolveHead(true);
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [head, resolveHead, soundOn]);

  if (!head) return null;

  const tone = TONE_CLASS[head.tone];

  const handleConfirm = () => {
    if (soundOn) playEnter();
    resolveHead(true);
  };
  const handleCancel = () => {
    if (soundOn) playSelect();
    resolveHead(false);
  };

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby={`modal-title-${head.id}`}
      className="fixed inset-0 z-[60] flex items-center justify-center px-4"
    >
      {/* 배경 딤. alert 은 클릭으로 닫고, confirm 은 취소 처리 */}
      <button
        type="button"
        aria-label="닫기"
        onClick={() => resolveHead(head.kind === "alert")}
        className="absolute inset-0 bg-black/70 backdrop-blur-sm"
      />

      <div
        className={`panel relative w-full max-w-sm border-4 ${tone.border} bg-dungeon-100/95 shadow-[0_8px_0_0_rgba(0,0,0,0.7)]`}
      >
        {/* 모서리 픽셀 데코 */}
        <span className={`absolute -top-2 -left-2 h-3 w-3 ${tone.border} border-4`} />
        <span className={`absolute -top-2 -right-2 h-3 w-3 ${tone.border} border-4`} />
        <span className={`absolute -bottom-2 -left-2 h-3 w-3 ${tone.border} border-4`} />
        <span className={`absolute -bottom-2 -right-2 h-3 w-3 ${tone.border} border-4`} />

        <div className="flex items-start gap-3">
          <span
            className={`shrink-0 select-none border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-xl ${tone.eyebrow}`}
            aria-hidden
          >
            {tone.icon}
          </span>
          <div className="min-w-0 flex-1">
            {head.eyebrow && (
              <div
                className={`pixel-text-jp text-[11px] uppercase tracking-widest ${tone.eyebrow}`}
              >
                {head.eyebrow}
              </div>
            )}
            <div
              id={`modal-title-${head.id}`}
              className="pixel-text font-pixel text-lg text-parchment-100"
            >
              {head.title}
            </div>
            <p className="mt-2 whitespace-pre-line text-sm leading-relaxed text-parchment-200">
              {head.message}
            </p>
          </div>
        </div>

        <div className="mt-5 flex gap-2">
          {head.kind === "confirm" && (
            <button
              type="button"
              onClick={handleCancel}
              className="btn-ghost flex-1"
            >
              {head.cancelLabel ?? "취소"}
            </button>
          )}
          <button
            ref={confirmBtnRef}
            type="button"
            onClick={handleConfirm}
            className={`${tone.confirmBtn} flex-1`}
          >
            {head.confirmLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
