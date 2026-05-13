import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import type {
  CharacterId,
  DeckLevel,
  Mastery,
  Settings,
} from "../types";

/* ── DB Schema 타입 (참고/캐스팅용) ───────────────── */

export interface DbProfile {
  id: string;
  nickname: string | null;
  selected_character: CharacterId;
  settings: Settings;
  created_at: string;
}

export interface DbDeck {
  id: string;
  owner_id: string | null;
  name: string;
  jlpt_level: DeckLevel;
  is_official: boolean;
  is_public: boolean;
  description: string | null;
  created_at: string;
}

export interface DbWord {
  id: string;
  deck_id: string;
  headword: string | null;
  reading: string;
  meaning: string;
  etymology: string | null;
  part_of_speech: string | null;
  order_index: number;
  tags: string[];
  created_at: string;
}

export interface DbExample {
  id: string;
  word_id: string;
  jp_sentence: string;
  kr_translation: string;
  furigana: string | null;
  order_index: number;
}

export interface DbWordProgress {
  user_id: string;
  word_id: string;
  mastery: Mastery;
  flagged: boolean;
  last_seen_at: string | null;
  mastered_at: string | null;
}

/* ── Client ─────────────────────────────────────────── */

const url = import.meta.env.VITE_SUPABASE_URL;
const anon = import.meta.env.VITE_SUPABASE_ANON_KEY;

/**
 * 환경변수가 모두 있으면 Supabase 클라이언트를 생성합니다.
 * 없으면 null 을 반환하여 로컬-스토리지 모드로 동작합니다.
 *
 * 타입 안정성은 호출부에서 DbXxx 인터페이스로 명시 캐스팅합니다.
 */
export const supabase: SupabaseClient | null =
  url && anon ? createClient(url, anon) : null;

export const isSupabaseEnabled = supabase !== null;

/* ── 페이지네이션 헬퍼 ────────────────────────────────
 * Supabase(PostgREST) 의 select 는 기본 limit 이 1,000 rows 다.
 * 단어/예문 시드가 1,000 개를 넘어가면 일부 덱이 잘려 나가므로,
 * .range() 로 페이지를 끊어 모두 가져온다.
 */
const PAGE_SIZE = 1000;

/**
 * 페이지를 끊어가며 모든 row 를 누적해서 반환한다.
 *
 * @example
 *   const { data, error } = await fetchAllPaginated<DbWord>((from, to) =>
 *     client.from("words").select("*").range(from, to),
 *   );
 */
export async function fetchAllPaginated<T>(
  pageQuery: (from: number, to: number) => PromiseLike<{
    data: T[] | null;
    error: { message: string } | null;
  }>,
): Promise<{ data: T[]; error: { message: string } | null }> {
  const all: T[] = [];
  let from = 0;
  // 무한 루프 방지를 위한 안전 상한 (최대 100,000 rows)
  for (let i = 0; i < 100; i++) {
    const to = from + PAGE_SIZE - 1;
    const { data, error } = await pageQuery(from, to);
    if (error) return { data: all, error };
    const rows = data ?? [];
    all.push(...rows);
    if (rows.length < PAGE_SIZE) break;
    from += PAGE_SIZE;
  }
  return { data: all, error: null };
}
