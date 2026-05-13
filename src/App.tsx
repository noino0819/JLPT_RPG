import { Route, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import HomePage from "./pages/HomePage";
import StudyPage from "./pages/StudyPage";
import BattlePage from "./pages/BattlePage";
import StatusPage from "./pages/StatusPage";

export default function App() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route index element={<HomePage />} />
        <Route path="/study" element={<StudyPage />} />
        <Route path="/battle" element={<BattlePage />} />
        <Route path="/status" element={<StatusPage />} />
      </Route>
    </Routes>
  );
}
