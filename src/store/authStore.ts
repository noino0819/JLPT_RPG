import { create } from "zustand";
import { persist } from "zustand/middleware";

/**
 * 로컬 임시 인증 스토어.
 * Supabase 가 활성화되면 이 스토어를 supabase.auth 로 대체합니다.
 */
interface AuthState {
  email: string | null;
  signedIn: boolean;
  signIn: (email: string) => void;
  signOut: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      email: null,
      signedIn: false,
      signIn: (email) => set({ email, signedIn: true }),
      signOut: () => set({ email: null, signedIn: false }),
    }),
    { name: "jlpt-rpg-auth" },
  ),
);
