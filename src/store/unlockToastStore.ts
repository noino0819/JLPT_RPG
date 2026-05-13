import { create } from "zustand";
import type { CosmeticBase } from "../types";

// 새 해금 알림 큐.
// useUnlockWatcher 가 처치 수 변화 감지 시 enqueue,
// UnlockToast 컴포넌트가 head 를 꺼내 일정 시간 표시 후 dismiss.
interface UnlockToastState {
  queue: CosmeticBase[];
  enqueue: (item: CosmeticBase) => void;
  dismiss: () => void;
  clear: () => void;
}

export const useUnlockToastStore = create<UnlockToastState>((set) => ({
  queue: [],
  enqueue: (item) =>
    set((s) => {
      // 동일 item id 가 이미 큐에 있으면 중복 추가 방지
      if (s.queue.some((q) => q.id === item.id)) return s;
      return { queue: [...s.queue, item] };
    }),
  dismiss: () =>
    set((s) => ({ queue: s.queue.length > 0 ? s.queue.slice(1) : s.queue })),
  clear: () => set({ queue: [] }),
}));
