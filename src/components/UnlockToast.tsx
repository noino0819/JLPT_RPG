import { useEffect } from "react";
import { Link } from "react-router-dom";
import { useUnlockToastStore } from "../store/unlockToastStore";
import { useUnlockWatcher } from "../lib/cosmetics";

const KIND_LABEL_JP: Record<string, string> = {
  costume: "新装備",
  pet: "新ペット",
  title: "新称号",
  badge: "新勲章",
  frame: "新額縁",
};
const KIND_LABEL_KO: Record<string, string> = {
  costume: "코스튬",
  pet: "펫",
  title: "칭호",
  badge: "뱃지",
  frame: "액자",
};

const TOAST_DURATION_MS = 3500;

/**
 * 새 해금 알림.
 * - useUnlockWatcher 가 처치 수 변화 감지 → 큐에 enqueue
 * - 큐의 head 를 일정 시간 표시 후 dismiss → 다음 항목 노출
 * - 클릭 시 옷장으로 이동
 */
export default function UnlockToast() {
  useUnlockWatcher();
  const head = useUnlockToastStore((s) => s.queue[0]);
  const dismiss = useUnlockToastStore((s) => s.dismiss);

  useEffect(() => {
    if (!head) return;
    const t = setTimeout(() => dismiss(), TOAST_DURATION_MS);
    return () => clearTimeout(t);
  }, [head, dismiss]);

  if (!head) return null;

  const jp = KIND_LABEL_JP[head.kind] ?? "解禁";
  const ko = KIND_LABEL_KO[head.kind] ?? "장비";

  return (
    <div className="pointer-events-none fixed inset-x-0 top-3 z-50 flex justify-center px-3">
      <Link
        to="/wardrobe"
        onClick={() => dismiss()}
        className="pointer-events-auto flex max-w-md items-center gap-3 border-2 border-rune-500 bg-dungeon-100/95 px-3 py-2 shadow-[0_0_0_2px_rgba(255,180,40,0.4)] backdrop-blur transition hover:bg-dungeon-50"
      >
        <span className="animate-bob text-2xl">✨</span>
        <div className="min-w-0 flex-1 text-left">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-rune-400">
            {jp} 解禁! · 새 {ko} 해금
          </div>
          <div className="truncate font-pixel text-sm text-parchment-100">
            {head.nameJp ?? head.name} · {head.name}
          </div>
        </div>
        <span className="font-pixel text-[10px] text-parchment-300">→</span>
      </Link>
    </div>
  );
}
