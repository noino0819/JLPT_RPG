// 공용 토글 스위치 컴포넌트
// - 설정 페이지와 학습 페이지(정복 완료 화면)에서 공용으로 사용
// - 픽셀 테마(검정 보더 + 룬 컬러)에 맞춘 스위치 UI
interface ToggleProps {
  on: boolean;
  onChange: (v: boolean) => void;
  ariaLabel?: string;
}

export default function Toggle({ on, onChange, ariaLabel }: ToggleProps) {
  return (
    <button
      type="button"
      onClick={() => onChange(!on)}
      className={`relative h-7 w-12 shrink-0 border-2 border-black ${
        on ? "bg-rune-500" : "bg-dungeon-50"
      }`}
      aria-pressed={on}
      aria-label={ariaLabel}
    >
      <span
        className={`absolute top-[2px] block h-4 w-4 border-2 border-black bg-parchment-100 transition-all ${
          on ? "left-[26px]" : "left-[2px]"
        }`}
      />
    </button>
  );
}
