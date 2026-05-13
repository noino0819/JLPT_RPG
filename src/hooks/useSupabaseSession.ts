import { useEffect } from "react";
import { isSupabaseEnabled, supabase } from "../lib/supabase";
import { useAuthStore } from "../store/authStore";

/**
 * 앱 진입 시 1회 호출.
 * - Supabase 모드: 현재 세션을 가져오고, onAuthStateChange 구독
 * - 로컬 모드: 영속화된 상태 그대로 ready 처리
 *
 * 안전장치:
 *  - getSession() 이 reject 되어도 ready=true 보장
 *  - PWA(iOS standalone WebView 등) 에서 세션 부트스트랩이 lock 등으로
 *    멈추는 경우를 대비해 5초 타임아웃 후 강제로 ready=true
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
    let settled = false;

    const markSettled = () => {
      settled = true;
    };

    // 5초 안에 어떤 응답도 못 받으면 강제로 로그인 화면으로 빠질 수 있게 ready 만 켠다
    const timeoutId = window.setTimeout(() => {
      if (!mounted || settled) return;
      console.warn("[useSupabaseSession] getSession timeout, forcing ready");
      setReady(true);
    }, 5000);

    supabase.auth
      .getSession()
      .then(({ data }) => {
        if (!mounted) return;
        markSettled();
        setSession(data.session);
      })
      .catch((err) => {
        if (!mounted) return;
        markSettled();
        console.error("[useSupabaseSession] getSession failed:", err);
        setSession(null);
      });

    const { data: sub } = supabase.auth.onAuthStateChange((_event, session) => {
      markSettled();
      setSession(session);
    });

    return () => {
      mounted = false;
      window.clearTimeout(timeoutId);
      sub.subscription.unsubscribe();
    };
  }, []);
}
