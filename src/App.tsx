import { Navigate, Route, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import { useAuthStore } from "./store/authStore";
import { useSupabaseSession } from "./hooks/useSupabaseSession";
import { useProgressSync } from "./hooks/useProgressSync";
import { useProfileSync } from "./hooks/useProfileSync";
import LoginPage from "./pages/LoginPage";
import HomePage from "./pages/HomePage";
import CharacterPage from "./pages/CharacterPage";
import StudyPage from "./pages/StudyPage";
import ReviewPage from "./pages/ReviewPage";
import MyDeckPage from "./pages/MyDeckPage";
import SettingsPage from "./pages/SettingsPage";
import PixelSword from "./components/PixelSword";

export default function App() {
  useSupabaseSession();
  useProfileSync();
  useProgressSync();

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
    <Routes>
      <Route
        path="/login"
        element={signedIn ? <Navigate to="/" replace /> : <LoginPage />}
      />

      {signedIn ? (
        <Route element={<Layout />}>
          <Route index element={<HomePage />} />
          <Route path="/character" element={<CharacterPage />} />
          <Route path="/study/:level" element={<StudyPage />} />
          <Route path="/study/deck/:deckId" element={<StudyPage />} />
          <Route path="/review" element={<ReviewPage />} />
          <Route path="/mydeck" element={<MyDeckPage />} />
          <Route path="/settings" element={<SettingsPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Route>
      ) : (
        <Route path="*" element={<Navigate to="/login" replace />} />
      )}
    </Routes>
  );
}
