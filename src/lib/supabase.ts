import { createClient, type SupabaseClient } from "@supabase/supabase-js";

const url = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const anon = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

/**
 * Supabase 클라이언트.
 * 환경변수가 없으면 null 을 반환하여 로컬-스토리지 모드로 동작합니다.
 *
 * 활성화하려면 `.env.local` 에 다음을 추가하세요:
 *   VITE_SUPABASE_URL=https://xxx.supabase.co
 *   VITE_SUPABASE_ANON_KEY=eyJhbGc...
 */
export const supabase: SupabaseClient | null =
  url && anon ? createClient(url, anon) : null;

export const isSupabaseEnabled = supabase !== null;
