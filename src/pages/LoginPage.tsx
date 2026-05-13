import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { isSupabaseEnabled, supabase } from "../lib/supabase";

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
          navigate("/character");
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
        navigate("/character");
      }
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "오류가 발생했습니다";
      setError(message);
    } finally {
      setBusy(false);
    }
  };

  const handleNaver = () => {
    alert(
      "네이버 OAuth는 Vercel Serverless Function 콜백 연동 후 활성화됩니다.\n현재는 로컬 데모로 진입합니다.",
    );
    setLocalSession("guest@naver.com");
    navigate("/character");
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-sky-900 via-dungeon-200 to-dungeon-300">
      <div className="mx-auto flex min-h-screen max-w-md flex-col items-center justify-center gap-6 px-4 py-10">
        <div className="text-center">
          <div className="text-6xl">🗡️</div>
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
            className="btn-pixel w-full bg-[#03c75a] text-white hover:bg-[#02b14f]"
          >
            🟢 네이버로 시작
          </button>

          {!isSupabaseEnabled && (
            <p className="font-pixel text-[10px] text-parchment-300">
              ⚠ 데모 모드 (로컬 저장). <code>.env.local</code> 에 Supabase
              환경변수 추가 시 실제 인증 연동.
            </p>
          )}
          {isSupabaseEnabled && (
            <p className="font-pixel text-[10px] text-rune-400">
              🟢 Supabase 연결됨 — 진행 상태가 서버에 저장됩니다
            </p>
          )}
        </form>
      </div>
    </div>
  );
}
