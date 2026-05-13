import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { isSupabaseEnabled } from "../lib/supabase";

export default function LoginPage() {
  const navigate = useNavigate();
  const { signIn } = useAuthStore();
  const { setNickname } = useProfileStore();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [mode, setMode] = useState<"login" | "signup">("login");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) return;
    signIn(email);
    if (mode === "signup") {
      setNickname(email.split("@")[0]);
    }
    navigate("/character");
  };

  const handleNaver = () => {
    alert(
      "네이버 OAuth는 Vercel Serverless Function 콜백 연동 후 활성화됩니다.\n현재는 로컬 데모로 진입합니다.",
    );
    signIn("guest@naver.com");
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
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
              placeholder="••••••••"
            />
          </label>

          <button type="submit" className="btn-primary w-full">
            ▶ {mode === "login" ? "모험 재개" : "모험 시작"}
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
              ⚠ 데모 모드 (로컬 저장). Supabase 환경변수 추가 시 실제 인증
              연동.
            </p>
          )}
        </form>
      </div>
    </div>
  );
}
