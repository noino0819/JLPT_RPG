import { Link, useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";

export default function SettingsPage() {
  const navigate = useNavigate();
  const { email, signOut } = useAuthStore();
  const { nickname, setNickname, settings, updateSettings, toggleEffect } =
    useProfileStore();
  const resetProgress = useProgressStore((s) => s.reset);
  const resetProfile = useProfileStore((s) => s.reset);

  return (
    <div className="space-y-5">
      <header>
        <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
          ⚙ 설정
        </h2>
      </header>

      <Section title="단어 노출">
        <Row label="순서">
          <div className="flex gap-2">
            {(["random", "sequential"] as const).map((o) => (
              <button
                key={o}
                onClick={() => updateSettings({ order: o })}
                className={`border-2 px-3 py-1 font-pixel text-xs ${
                  settings.order === o
                    ? "border-rune-500 bg-rune-500/15 text-rune-400"
                    : "border-black bg-dungeon-50 text-parchment-200"
                }`}
              >
                {o === "random" ? "랜덤" : "순서대로"}
              </button>
            ))}
          </div>
        </Row>

        <Row label="외운 단어 제외">
          <Toggle
            on={settings.exclude_memorized}
            onChange={(v) => updateSettings({ exclude_memorized: v })}
          />
        </Row>

        <Slider
          label={`"외운 것 같아요" 재등장 주기 (1~20)`}
          min={1}
          max={20}
          value={settings.probably_repeat_every}
          onChange={(v) => updateSettings({ probably_repeat_every: v })}
          suffix="장에 1번"
        />

        <Slider
          label={`"다시 보기" 가중치 (1~10)`}
          min={1}
          max={10}
          value={settings.review_mix_weight}
          onChange={(v) => updateSettings({ review_mix_weight: v })}
          suffix="배"
        />
      </Section>

      <Section title="이펙트">
        <Row label="공격 이펙트">
          <Toggle
            on={settings.effects.attack}
            onChange={() => toggleEffect("attack")}
          />
        </Row>
        <Row label="카드 흔들림">
          <Toggle
            on={settings.effects.card_shake}
            onChange={() => toggleEffect("card_shake")}
          />
        </Row>
        <Row label="사운드 (예정)">
          <Toggle
            on={settings.effects.sound}
            onChange={() => toggleEffect("sound")}
          />
        </Row>
      </Section>

      <Section title="프로필">
        <label className="block">
          <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            닉네임
          </span>
          <input
            value={nickname}
            onChange={(e) => setNickname(e.target.value)}
            className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
          />
        </label>
        <Link to="/character" className="btn-primary mt-3 w-full">
          🧝 캐릭터 변경
        </Link>
      </Section>

      <Section title="계정">
        <div className="text-sm text-parchment-200">
          이메일: {email ?? "(데모 모드)"}
        </div>
        <button
          onClick={() => {
            signOut();
            navigate("/login");
          }}
          className="btn-ghost mt-3 w-full"
        >
          로그아웃
        </button>
      </Section>

      <Section title="위험 영역">
        <button
          onClick={() => {
            if (
              confirm(
                "모든 학습 진행 상태를 초기화할까요? (외운 단어, 다시 보기 모두 삭제)",
              )
            ) {
              resetProgress();
            }
          }}
          className="btn-danger w-full"
        >
          🗑 학습 진행 초기화
        </button>
        <button
          onClick={() => {
            if (
              confirm(
                "프로필(닉네임/캐릭터/설정)을 초기값으로 되돌릴까요?",
              )
            ) {
              resetProfile();
            }
          }}
          className="btn-danger mt-2 w-full"
        >
          🗑 프로필 초기화
        </button>
      </Section>
    </div>
  );
}

function Section({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section className="panel space-y-3">
      <h3 className="pixel-text font-pixel text-sm uppercase tracking-widest text-parchment-100">
        {title}
      </h3>
      {children}
    </section>
  );
}

function Row({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) {
  return (
    <div className="flex items-center justify-between gap-4">
      <span className="text-sm text-parchment-200">{label}</span>
      {children}
    </div>
  );
}

function Toggle({
  on,
  onChange,
}: {
  on: boolean;
  onChange: (v: boolean) => void;
}) {
  return (
    <button
      onClick={() => onChange(!on)}
      className={`relative h-7 w-12 border-2 border-black ${
        on ? "bg-rune-500" : "bg-dungeon-50"
      }`}
      aria-pressed={on}
    >
      <span
        className={`absolute top-[2px] block h-4 w-4 border-2 border-black bg-parchment-100 transition-all ${
          on ? "left-[26px]" : "left-[2px]"
        }`}
      />
    </button>
  );
}

function Slider({
  label,
  min,
  max,
  value,
  onChange,
  suffix,
}: {
  label: string;
  min: number;
  max: number;
  value: number;
  onChange: (v: number) => void;
  suffix?: string;
}) {
  return (
    <div>
      <div className="flex items-center justify-between text-sm text-parchment-200">
        <span>{label}</span>
        <span className="font-pixel text-rune-400">
          {value}
          {suffix ? ` ${suffix}` : ""}
        </span>
      </div>
      <input
        type="range"
        min={min}
        max={max}
        value={value}
        onChange={(e) => onChange(Number(e.target.value))}
        className="mt-1 w-full accent-rune-500"
      />
    </div>
  );
}
