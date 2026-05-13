import { create } from "zustand";

// 전역 모달 큐.
// 네이티브 alert / confirm 대신 게임 분위기에 어울리는 픽셀 모달을 띄우기 위해 사용.
// showAlert / showConfirm 헬퍼가 큐에 항목을 넣고, ConfirmModal 컴포넌트가 head 를 렌더한다.

export type ModalKind = "alert" | "confirm";
export type ModalTone = "default" | "danger" | "success" | "warning";

export interface ModalConfig {
  id: number;
  kind: ModalKind;
  title: string;
  message: string;
  /** 강조 라인 (제목 위 작은 일본어 라벨 등) */
  eyebrow?: string;
  confirmLabel: string;
  cancelLabel?: string;
  tone: ModalTone;
  /** 모달이 닫힐 때 호출. confirm 의 경우 true=확인, false=취소. alert 은 항상 true */
  resolve: (value: boolean) => void;
}

interface ModalState {
  queue: ModalConfig[];
  push: (cfg: ModalConfig) => void;
  /** 현재 head 모달을 결과값과 함께 닫는다 */
  resolveHead: (value: boolean) => void;
}

let nextId = 1;
export const allocateModalId = () => nextId++;

export const useModalStore = create<ModalState>((set, get) => ({
  queue: [],
  push: (cfg) => set((s) => ({ queue: [...s.queue, cfg] })),
  resolveHead: (value) => {
    const head = get().queue[0];
    if (!head) return;
    head.resolve(value);
    set((s) => ({ queue: s.queue.slice(1) }));
  },
}));

// ---- Public helper API ----

export interface AlertOptions {
  title?: string;
  message: string;
  eyebrow?: string;
  confirmLabel?: string;
  tone?: ModalTone;
}

export interface ConfirmOptions extends AlertOptions {
  cancelLabel?: string;
}

/** 픽셀 스타일 알림 모달. resolve 시 항상 true. */
export function showAlert(opts: AlertOptions): Promise<void> {
  return new Promise((resolve) => {
    useModalStore.getState().push({
      id: allocateModalId(),
      kind: "alert",
      title: opts.title ?? "알림",
      message: opts.message,
      eyebrow: opts.eyebrow,
      confirmLabel: opts.confirmLabel ?? "확인",
      tone: opts.tone ?? "default",
      resolve: () => resolve(),
    });
  });
}

/** 픽셀 스타일 확인 모달. 확인=true / 취소=false 로 resolve. */
export function showConfirm(opts: ConfirmOptions): Promise<boolean> {
  return new Promise((resolve) => {
    useModalStore.getState().push({
      id: allocateModalId(),
      kind: "confirm",
      title: opts.title ?? "확인",
      message: opts.message,
      eyebrow: opts.eyebrow,
      confirmLabel: opts.confirmLabel ?? "확인",
      cancelLabel: opts.cancelLabel ?? "취소",
      tone: opts.tone ?? "default",
      resolve,
    });
  });
}
