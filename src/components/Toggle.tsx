import { useProfileStore } from "../store/profileStore";
import { playToggle } from "../lib/sfx";

// 공용 토글 스위치 컴포넌트
// - 설정 페이지와 학습 페이지(정복 완료 화면)에서 공용으로 사용
// - 픽셀 테마(검정 보더 + 룬 컬러)에 맞춘 스위치 UI
// - 사운드 토글이 켜져 있으면 누를 때마다 on/off 사운드를 자동 재생
//   (사운드 자체를 끄는 토글의 경우, "끄기" 시점엔 사운드가 아직 켜진 상태이므로
//    off 효과음이 한 번 들리고 정적이 된다 — 자연스러운 UX)
interface ToggleProps {
  on: boolean;
  onChange: (v: boolean) => void;
  ariaLabel?: string;
}

export default function Toggle({ on, onChange, ariaLabel }: ToggleProps) {
  const soundOn = useProfileStore((s) => s.settings.effects.sound);

  const handleClick = () => {
    if (soundOn) playToggle(!on);
    onChange(!on);
  };

  return (
    <button
      type="button"
      onClick={handleClick}
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
