import { Link, useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";
import { isSupabaseEnabled, supabase } from "../lib/supabase";
import { playPreview } from "../lib/sfx";
import { hasJaVoice, isTtsAvailable, speakJa } from "../lib/tts";
import Toggle from "../components/Toggle";
import { showAlert, showConfirm } from "../store/modalStore";

export default function SettingsPage() {
  const navigate = useNavigate();
  const email = useAuthStore((s) => s.email);
  const signOutLocal = useAuthStore((s) => s.signOutLocal);
  const {
    nickname,
    setNickname,
    settings,
    updateSettings,
    toggleEffect,
    selected_character,
  } = useProfileStore();
  const resetProgress = useProgressStore((s) => s.reset);
  const resetProfile = useProfileStore((s) => s.reset);

  const handleSignOut = async () => {
    if (isSupabaseEnabled && supabase) {
      const { error } = await supabase.auth.signOut();
      if (error) {
        await showAlert({
          title: "로그아웃 실패",
          eyebrow: "ログアウト失敗",
          message: error.message,
          tone: "danger",
        });
        return;
      }
      // onAuthStateChange 가 setSession(null) 호출 → ready=true, signedIn=false
    } else {
      signOutLocal();
    }
    navigate("/login");
  };

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
        <Row label="캐릭터 표시">
          <Toggle
            on={settings.show_character}
            onChange={(v) => updateSettings({ show_character: v })}
          />
        </Row>
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
        <Row label="전투 사운드">
          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={() => playPreview(selected_character)}
              className="border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-[10px] text-parchment-100 hover:bg-dungeon-100"
              aria-label="사운드 미리듣기"
              title="현재 캐릭터의 공격 → 처치 사운드 미리듣기"
            >
              ▶ 듣기
            </button>
            <Toggle
              on={settings.effects.sound}
              onChange={() => {
                toggleEffect("sound");
                if (!settings.effects.sound) playPreview(selected_character);
              }}
            />
          </div>
        </Row>
        <p className="font-pixel text-[10px] leading-relaxed text-parchment-300">
          직업별 공격·처치 사운드와 보관함 토글, 해금 팡파레까지 모두 포함됩니다.
        </p>
      </Section>

      <Section title="음성 읽어주기">
        {!isTtsAvailable() ? (
          <p className="font-pixel text-[10px] leading-relaxed text-volcano-300">
            ⚠ 이 브라우저는 음성 합성(SpeechSynthesis)을 지원하지 않습니다.
          </p>
        ) : (
          <>
            <Row label="🔊 음성 버튼 표시">
              <Toggle
                on={settings.tts.enabled}
                onChange={(v) =>
                  updateSettings({ tts: { ...settings.tts, enabled: v } })
                }
              />
            </Row>
            <Row label="새 카드에서 자동 재생">
              <Toggle
                on={settings.tts.autoplay}
                onChange={(v) =>
                  updateSettings({ tts: { ...settings.tts, autoplay: v } })
                }
              />
            </Row>
            <Slider
              label="발음 속도"
              min={5}
              max={15}
              value={Math.round(settings.tts.rate * 10)}
              onChange={(v) =>
                updateSettings({ tts: { ...settings.tts, rate: v / 10 } })
              }
              suffix={`× (${settings.tts.rate.toFixed(1)})`}
            />
            <div className="flex flex-wrap items-center gap-2 pt-1">
              <button
                type="button"
                onClick={() =>
                  speakJa("勉強しましょう。", { rate: settings.tts.rate })
                }
                disabled={!settings.tts.enabled}
                className="border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-[10px] text-parchment-100 hover:bg-dungeon-100 disabled:opacity-50"
                aria-label="음성 미리듣기"
                title="勉強しましょう。 (공부합시다)"
              >
                ▶ 듣기 「勉強しましょう。」
              </button>
              <span className="font-pixel text-[10px] text-parchment-300">
                {hasJaVoice()
                  ? "✅ 일본어 음성 사용 가능"
                  : "⚠ 일본어 음성 미설치 — 영어/시스템 보이스로 대체될 수 있어요."}
              </span>
            </div>
            <p className="font-pixel text-[10px] leading-relaxed text-parchment-300">
              브라우저 내장 음성 합성 사용 — 추가 비용/네트워크 없이 작동.
              음성 품질은 OS(Mac · iOS · Android · Windows) 일본어 보이스에 따라
              달라요.
            </p>
          </>
        )}
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
        <Link to="/wardrobe" className="btn-primary mt-3 w-full">
          🧝 캐릭터 / 옷장
        </Link>
      </Section>

      <Section title="계정">
        <div className="flex items-center gap-2 text-sm text-parchment-200">
          <span
            className={`inline-block h-2.5 w-2.5 rounded-full border border-black ${
              isSupabaseEnabled ? "bg-emerald-400" : "bg-parchment-300/50"
            }`}
          />
          {isSupabaseEnabled ? "온라인 동기화 중" : "오프라인 모드"}
        </div>
        <div className="text-sm text-parchment-200">
          이메일: {email ?? "게스트"}
        </div>
        <button onClick={handleSignOut} className="btn-ghost mt-3 w-full">
          로그아웃
        </button>
      </Section>

      <Section title="위험 영역">
        <button
          onClick={async () => {
            const ok = await showConfirm({
              title: "학습 진행 초기화",
              eyebrow: "リセット警告",
              message:
                "모든 학습 진행 상태를 초기화할까요?\n외운 단어, 다시 보기 기록이 모두 삭제됩니다.",
              confirmLabel: "초기화",
              cancelLabel: "취소",
              tone: "danger",
            });
            if (ok) {
              resetProgress();
              await showAlert({
                title: "초기화 완료",
                eyebrow: "リセット完了",
                message: "학습 진행 상태가 모두 초기화되었습니다.",
                tone: "success",
              });
            }
          }}
          className="btn-danger w-full"
        >
          🗑 학습 진행 초기화
        </button>
        <button
          onClick={async () => {
            const ok = await showConfirm({
              title: "프로필 초기화",
              eyebrow: "プロフィール初期化",
              message:
                "프로필(닉네임/캐릭터/설정)을 초기값으로 되돌릴까요?",
              confirmLabel: "초기화",
              cancelLabel: "취소",
              tone: "danger",
            });
            if (ok) {
              resetProfile();
              await showAlert({
                title: "초기화 완료",
                eyebrow: "リセット完了",
                message: "프로필이 초기값으로 되돌아갔습니다.",
                tone: "success",
              });
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
