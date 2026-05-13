import { Navigate, Route, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import { useAuthStore } from "./store/authStore";
import LoginPage from "./pages/LoginPage";
import HomePage from "./pages/HomePage";
import CharacterPage from "./pages/CharacterPage";
import StudyPage from "./pages/StudyPage";
import ReviewPage from "./pages/ReviewPage";
import MyDeckPage from "./pages/MyDeckPage";
import SettingsPage from "./pages/SettingsPage";

export default function App() {
  const signedIn = useAuthStore((s) => s.signedIn);

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
