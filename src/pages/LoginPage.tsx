import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { isSupabaseEnabled, supabase } from "../lib/supabase";
import PixelSword from "../components/PixelSword";

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
    if (!email || !password) return;
    setError(null);
    setInfo(null);
    setBusy(true);

    try {
      if (isSupabaseEnabled && supabase) {
        if (mode === "signup") {
          const { data, error } = await supabase.auth.signUp({
            email,
            password,
            options: {
              data: { nickname: email.split("@")[0] },
            },
          });
          if (error) throw error;

          // confirm email 옵션이 켜져 있으면 session 이 null
          if (!data.session) {
            setInfo(
              "회원가입 완료! 메일함의 인증 링크를 클릭한 뒤 다시 로그인해주세요.",
            );
            setMode("login");
            return;
          }
          // session 이 있으면 onAuthStateChange 가 처리 → 라우트 자동 전환
          navigate("/wardrobe");
        } else {
          const { error } = await supabase.auth.signInWithPassword({
            email,
            password,
          });
          if (error) throw error;
          // onAuthStateChange 가 라우트 전환을 담당
        }
      } else {
        // 로컬 데모 모드
        setLocalSession(email);
        if (mode === "signup") setNickname(email.split("@")[0]);
        navigate("/wardrobe");
      }
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "오류가 발생했습니다";
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
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
              placeholder="••••••••"
            />
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
