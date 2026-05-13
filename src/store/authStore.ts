import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Session, User } from "@supabase/supabase-js";

/**
 * 인증 상태.
 * - Supabase 모드: supabase.auth 가 진실의 원천. 이 스토어는 캐시.
 * - 로컬 데모 모드: 이 스토어가 진실의 원천.
 */
interface AuthState {
  email: string | null;
  userId: string | null;
  signedIn: boolean;
  /** Supabase 세션 부트스트랩이 끝났는지 */
  ready: boolean;

  setSession: (session: Session | null) => void;
  setLocalSession: (email: string) => void;
  signOutLocal: () => void;
  setReady: (ready: boolean) => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      email: null,
      userId: null,
      signedIn: false,
      ready: false,

      setSession: (session) => {
        if (session?.user) {
          const u: User = session.user;
          set({
            email: u.email ?? null,
            userId: u.id,
            signedIn: true,
            ready: true,
          });
        } else {
          set({ email: null, userId: null, signedIn: false, ready: true });
        }
      },

      setLocalSession: (email) =>
        set({
          email,
          userId: `local-${email}`,
          signedIn: true,
          ready: true,
        }),

      signOutLocal: () =>
        set({ email: null, userId: null, signedIn: false, ready: true }),

      setReady: (ready) => set({ ready }),
    }),
    {
      name: "jlpt-rpg-auth",
      // ready 는 매 부트마다 다시 계산하므로 영속화에서 제외
      partialize: (s) => ({
        email: s.email,
        userId: s.userId,
        signedIn: s.signedIn,
      }),
    },
  ),
);
