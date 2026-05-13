import { useEffect, useRef } from "react";
import {
  isSupabaseEnabled,
  supabase,
  type DbProfile,
} from "../lib/supabase";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { DEFAULT_EQUIPPED, DEFAULT_SETTINGS } from "../types";

/**
 * 프로필(닉네임/캐릭터/설정) ↔ Supabase 동기화.
 *
 * 1. 로그인 시: profiles 행을 가져와 로컬 스토어에 반영.
 *    행이 없으면 (트리거 미작동 등) upsert 로 만든다.
 * 2. 로컬 스토어 변경 시: profiles 행을 update.
 */
export function useProfileSync() {
  const userId = useAuthStore((s) => s.userId);
  const signedIn = useAuthStore((s) => s.signedIn);
  const ready = useAuthStore((s) => s.ready);

  const initialLoadDoneRef = useRef(false);
  const lastSyncedRef = useRef<{
    nickname: string;
    selected_character: string;
    settings: string;
    equipped: string;
  } | null>(null);

  /* 초기 로드 */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId || !ready) {
      initialLoadDoneRef.current = false;
      lastSyncedRef.current = null;
      return;
    }

    let cancelled = false;
    const client = supabase;

    (async () => {
      const { data, error } = await client
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .maybeSingle();

      if (cancelled) return;

      if (error) {
        console.error("[supabase] failed to load profile:", error);
        initialLoadDoneRef.current = true;
        return;
      }

      const row = data as DbProfile | null;

      if (!row) {
        // 트리거 미작동 보호: 즉석에서 생성
        const local = useProfileStore.getState();
        const { error: insertErr } = await client.from("profiles").upsert({
          id: userId,
          nickname: local.nickname,
          selected_character: local.selected_character,
          settings: local.settings,
          equipped: local.equipped,
        });
        if (insertErr) {
          console.error("[supabase] profile bootstrap failed:", insertErr);
        }
        initialLoadDoneRef.current = true;
        return;
      }

      const settings = { ...DEFAULT_SETTINGS, ...(row.settings ?? {}) };
      const rawEquipped: Partial<typeof DEFAULT_EQUIPPED> = row.equipped ?? {};
      const equipped = {
        ...DEFAULT_EQUIPPED,
        ...rawEquipped,
        costume: {
          ...DEFAULT_EQUIPPED.costume,
          ...(rawEquipped.costume ?? {}),
        },
        badges: rawEquipped.badges ?? DEFAULT_EQUIPPED.badges,
      };
      useProfileStore.setState({
        nickname: row.nickname ?? "見習い",
        selected_character: row.selected_character ?? "warrior",
        settings,
        equipped,
      });
      lastSyncedRef.current = {
        nickname: row.nickname ?? "見習い",
        selected_character: row.selected_character ?? "warrior",
        settings: JSON.stringify(settings),
        equipped: JSON.stringify(equipped),
      };
      initialLoadDoneRef.current = true;
    })();

    return () => {
      cancelled = true;
    };
  }, [userId, signedIn, ready]);

  /* 변경 감지 → update */
  useEffect(() => {
    if (!isSupabaseEnabled || !supabase || !signedIn || !userId) return;
    const client = supabase;

    const unsubscribe = useProfileStore.subscribe((state) => {
      if (!initialLoadDoneRef.current) return;

      const cur = {
        nickname: state.nickname,
        selected_character: state.selected_character,
        settings: JSON.stringify(state.settings),
        equipped: JSON.stringify(state.equipped),
      };
      const prev = lastSyncedRef.current;
      if (
        prev &&
        prev.nickname === cur.nickname &&
        prev.selected_character === cur.selected_character &&
        prev.settings === cur.settings &&
        prev.equipped === cur.equipped
      ) {
        return;
      }

      client
        .from("profiles")
        .update({
          nickname: state.nickname,
          selected_character: state.selected_character,
          settings: state.settings,
          equipped: state.equipped,
        })
        .eq("id", userId)
        .then(({ error }) => {
          if (error) {
            console.error("[supabase] update profile failed:", error);
          } else {
            lastSyncedRef.current = cur;
          }
        });
    });

    return () => unsubscribe();
  }, [userId, signedIn]);
}
