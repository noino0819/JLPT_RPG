import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { isSupabaseEnabled, supabase } from "../lib/supabase";
import PixelSword from "../components/PixelSword";
import {
  MAX_PASSWORD_LEN,
  MIN_PASSWORD_LEN,
  checkPasswordStrength,
  isValidEmail,
  normalizeEmail,
} from "../lib/validation";

export default function LoginPage() {
  const navigate = useNavigate();
  const setLocalSession = useAuthStore((s) => s.setLocalSession);
  const { setNickname } = useProfileStore();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [mode, setMode] = useState<"login" | "signup">("login");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [info, setInfo] = useState<string | null>(null);

  // 네이버 OAuth 콜백에서 실패 시 ?login_error=... 로 돌아옴
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const loginError = params.get("login_error");
    if (loginError) {
      setError(`네이버 로그인 실패: ${loginError}`);
      params.delete("login_error");
      const next = window.location.pathname +
        (params.toString() ? `?${params.toString()}` : "");
      window.history.replaceState({}, "", next);
    }
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setInfo(null);

    const normalizedEmail = normalizeEmail(email);
    if (!isValidEmail(normalizedEmail)) {
      setError("이메일 형식이 올바르지 않습니다.");
      return;
    }
    if (!password) {
      setError("비밀번호를 입력해 주세요.");
      return;
    }
    // 회원가입에서만 강도 검사. 로그인은 기존 비밀번호로도 들어와야 하므로 길이만.
    if (mode === "signup") {
      const strength = checkPasswordStrength(password);
      if (!strength.ok) {
        setError(strength.message ?? "비밀번호 정책을 확인해 주세요.");
        return;
      }
    } else if (
      password.length < MIN_PASSWORD_LEN ||
      password.length > MAX_PASSWORD_LEN
    ) {
      setError("이메일 또는 비밀번호가 올바르지 않습니다.");
      return;
    }

    setBusy(true);

    try {
      if (isSupabaseEnabled && supabase) {
        if (mode === "signup") {
          const { data, error } = await supabase.auth.signUp({
            email: normalizedEmail,
            password,
            options: {
              data: { nickname: normalizedEmail.split("@")[0] },
            },
          });
          if (error) {
            // 사용자 열거(User enumeration) 방지:
            // "이미 등록된 이메일입니다" 같은 메시지는 공격자가 가입자
            // 목록을 탐색할 수 있게 해 준다. rate-limit/format 오류처럼
            // 클라이언트가 고칠 수 있는 에러만 가시화하고, 그 외는 일반화.
            const msg = error.message || "";
            const isClientFixable =
              /password|email format|invalid email|rate|weak/i.test(msg);
            if (isClientFixable) {
              setError(
                "회원가입 정보를 확인해 주세요 (이메일 형식/비밀번호 정책 등).",
              );
            } else {
              // 이미 가입 여부와 무관하게 동일한 안내 메시지 → enumeration 차단
              setInfo(
                "회원가입 요청이 접수되었습니다. 메일함의 인증 링크를 확인해 주세요.",
              );
              setMode("login");
            }
            return;
          }

          // confirm email 옵션이 켜져 있으면 session 이 null
          if (!data.session) {
            setInfo(
              "회원가입 요청이 접수되었습니다. 메일함의 인증 링크를 확인해 주세요.",
            );
            setMode("login");
            return;
          }
          // session 이 있으면 onAuthStateChange 가 처리 → 라우트 자동 전환
          navigate("/wardrobe");
        } else {
          const { error } = await supabase.auth.signInWithPassword({
            email: normalizedEmail,
            password,
          });
          if (error) {
            // 사용자 열거(User enumeration) 방지: 일반화된 메시지로 응답
            setError("이메일 또는 비밀번호가 올바르지 않습니다.");
            return;
          }
          // onAuthStateChange 가 라우트 전환을 담당
        }
      } else {
        // 로컬 데모 모드
        setLocalSession(normalizedEmail);
        if (mode === "signup") setNickname(normalizedEmail.split("@")[0]);
        navigate("/wardrobe");
      }
    } catch (err: unknown) {
      // 외부에서 받은 메시지는 그대로 보여주되, 너무 길거나 제어문자가 들어오지 않도록 자른다.
      const message =
        (err instanceof Error ? err.message : "오류가 발생했습니다")
          .replace(/[\x00-\x1F\x7F]/g, "")
          .slice(0, 200) || "오류가 발생했습니다";
      setError(message);
    } finally {
      setBusy(false);
    }
  };

  const handleNaver = () => {
    if (!isSupabaseEnabled) return;
    window.location.href = "/api/auth/naver/start";
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-sky-900 via-dungeon-200 to-dungeon-300">
      <div className="mx-auto flex min-h-screen max-w-md flex-col items-center justify-center gap-6 px-4 py-10">
        <div className="text-center">
          <div className="flex justify-center">
            <div className="animate-bob">
              <PixelSword size={96} glow />
            </div>
          </div>
          <h1 className="pixel-text mt-3 font-pixel text-3xl text-parchment-100">
            JLPT <span className="text-rune-400">RPG</span>
          </h1>
          <p className="mt-1 font-pixel text-xs text-parchment-300">
            漢字ダンジョン · 단어를 외우고 몬스터를 처치하라
          </p>
        </div>

        <form
          onSubmit={handleSubmit}
          className="panel w-full space-y-3"
        >
          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={() => setMode("login")}
              className={`flex-1 border-2 border-black px-3 py-2 font-pixel text-xs ${
                mode === "login"
                  ? "bg-rune-500 text-white"
                  : "bg-dungeon-50 text-parchment-200"
              }`}
            >
              로그인
            </button>
            <button
              type="button"
              onClick={() => setMode("signup")}
              className={`flex-1 border-2 border-black px-3 py-2 font-pixel text-xs ${
                mode === "signup"
                  ? "bg-rune-500 text-white"
                  : "bg-dungeon-50 text-parchment-200"
              }`}
            >
              회원가입
            </button>
          </div>

          <label className="block">
            <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
              이메일
            </span>
            <input
              type="email"
              required
              autoComplete="email"
              maxLength={254}
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
              placeholder="adventurer@dungeon.io"
            />
          </label>

          <label className="block">
            <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
              비밀번호
            </span>
            <input
              type="password"
              required
              minLength={MIN_PASSWORD_LEN}
              maxLength={MAX_PASSWORD_LEN}
              autoComplete={mode === "signup" ? "new-password" : "current-password"}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
              placeholder="••••••••"
            />
            {mode === "signup" && (
              <span className="mt-1 block font-pixel text-[10px] text-parchment-300">
                {MIN_PASSWORD_LEN}자 이상, 영문 + 숫자 포함
              </span>
            )}
          </label>

          {error && (
            <div className="border-2 border-volcano-500 bg-volcano-500/15 p-2 text-xs text-volcano-400">
              ⚠ {error}
            </div>
          )}
          {info && (
            <div className="border-2 border-rune-500 bg-rune-500/15 p-2 text-xs text-rune-400">
              ℹ {info}
            </div>
          )}

          <button
            type="submit"
            disabled={busy}
            className="btn-primary w-full disabled:opacity-50"
          >
            {busy
              ? "잠시만요..."
              : `▶ ${mode === "login" ? "모험 재개" : "모험 시작"}`}
          </button>

          <div className="flex items-center gap-2 text-center">
            <span className="h-px flex-1 bg-parchment-700/40" />
            <span className="font-pixel text-[10px] text-parchment-300">또는</span>
            <span className="h-px flex-1 bg-parchment-700/40" />
          </div>

          <button
            type="button"
            onClick={handleNaver}
            disabled={!isSupabaseEnabled}
            title={
              !isSupabaseEnabled
                ? "데모 모드에서는 네이버 로그인을 사용할 수 없습니다"
                : undefined
            }
            className="btn-pixel flex w-full items-center justify-center gap-2 bg-[#03c75a] text-white hover:bg-[#02b14f] disabled:cursor-not-allowed disabled:opacity-50"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              aria-hidden="true"
              className="h-4 w-4 shrink-0"
            >
              <rect width="20" height="20" fill="#03c75a" />
              <path
                d="M11.5 4.5h3v11h-3L8.5 11v4.5h-3v-11h3l3 4.5v-4.5z"
                fill="#ffffff"
              />
            </svg>
            <span>네이버로 시작</span>
          </button>

        </form>

        <p className="text-center font-pixel text-[10px] leading-relaxed text-parchment-300">
          이용 중 문의가 있다면{" "}
          <a
            href="mailto:noino0819@naver.com"
            className="text-rune-400 underline underline-offset-2 hover:text-rune-300"
          >
            noino0819@naver.com
          </a>
          {" "}으로 알려주세요.
        </p>
      </div>
    </div>
  );
}
