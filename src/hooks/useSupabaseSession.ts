import { useEffect } from "react";
import { isSupabaseEnabled, supabase } from "../lib/supabase";
import { useAuthStore } from "../store/authStore";

/**
 * 앱 진입 시 1회 호출.
 * - Supabase 모드: 현재 세션을 가져오고, onAuthStateChange 구독
 * - 로컬 모드: 영속화된 상태 그대로 ready 처리
 */
export function useSupabaseSession() {
  useEffect(() => {
    const setSession = useAuthStore.getState().setSession;
    const setReady = useAuthStore.getState().setReady;

    if (!isSupabaseEnabled || !supabase) {
      setReady(true);
      return;
    }

    let mounted = true;

    supabase.auth.getSession().then(({ data }) => {
      if (!mounted) return;
      setSession(data.session);
    });

    const { data: sub } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session);
    });

    return () => {
      mounted = false;
      sub.subscription.unsubscribe();
    };
  }, []);
}
