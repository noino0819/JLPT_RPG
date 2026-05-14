import { useEffect } from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import { useAuthStore } from "./store/authStore";
import { useSupabaseSession } from "./hooks/useSupabaseSession";
import { useProgressSync } from "./hooks/useProgressSync";
import { useProfileSync } from "./hooks/useProfileSync";
import { useDecksSync } from "./hooks/useDecksSync";
import { useProfileStore } from "./store/profileStore";
import { applyJpFont } from "./lib/jpFonts";
import LoginPage from "./pages/LoginPage";
import HomePage from "./pages/HomePage";
import WardrobePage from "./pages/WardrobePage";
import StudyPage from "./pages/StudyPage";
import ReviewPage from "./pages/ReviewPage";
import MyDeckPage from "./pages/MyDeckPage";
import KanaPage from "./pages/KanaPage";
import SettingsPage from "./pages/SettingsPage";
import BossPage from "./pages/BossPage";
import PixelSword from "./components/PixelSword";
import UnlockToast from "./components/UnlockToast";
import ConfirmModal from "./components/ConfirmModal";

export default function App() {
  useSupabaseSession();
  useProfileSync();
  useProgressSync();
  useDecksSync();

  // 사용자가 설정에서 고른 일본어 픽셀 폰트를 :root --jp-font-family 로 적용.
  // 변경 즉시 화면 전체의 .pixel-text-jp 가 새 폰트로 갱신되며,
  // 외부 Google Fonts stylesheet 도 한 번만 lazily 주입된다.
  const jpFont = useProfileStore((s) => s.settings.jp_font);
  useEffect(() => {
    applyJpFont(jpFont);
  }, [jpFont]);

  const signedIn = useAuthStore((s) => s.signedIn);
  const ready = useAuthStore((s) => s.ready);

  if (!ready) {
    return (
      <div className="grid min-h-screen place-items-center bg-dungeon-300">
        <div className="text-center">
          <div className="animate-bob inline-block">
            <PixelSword size={64} glow />
          </div>
          <div className="mt-3 font-pixel text-xs text-parchment-300">
            세션 확인 중...
          </div>
        </div>
      </div>
    );
  }

  return (
    <>
      <Routes>
        <Route
          path="/login"
          element={signedIn ? <Navigate to="/" replace /> : <LoginPage />}
        />

        {signedIn ? (
          <Route element={<LayoutWithToast />}>
            <Route index element={<HomePage />} />
            {/* /character 는 호환을 위해 /wardrobe 로 합쳤음 */}
            <Route
              path="/character"
              element={<Navigate to="/wardrobe" replace />}
            />
            <Route path="/wardrobe" element={<WardrobePage />} />
            <Route path="/study/:level" element={<StudyPage />} />
            <Route path="/study/deck/:deckId" element={<StudyPage />} />
            <Route path="/boss/:level" element={<BossPage />} />
            <Route path="/review" element={<ReviewPage />} />
            <Route path="/mydeck" element={<MyDeckPage />} />
            <Route path="/kana" element={<KanaPage />} />
            <Route path="/settings" element={<SettingsPage />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Route>
        ) : (
          <Route path="*" element={<Navigate to="/login" replace />} />
        )}
      </Routes>
      {/* 전역 확인/알림 모달은 라우트와 무관하게 항상 마운트 (로그인 페이지에서도 동작) */}
      <ConfirmModal />
    </>
  );
}

// Layout 위에 UnlockToast 를 얹어서 어떤 페이지에 있든 새 해금 알림이 뜨도록.
function LayoutWithToast() {
  return (
    <>
      <Layout />
      <UnlockToast />
    </>
  );
}
