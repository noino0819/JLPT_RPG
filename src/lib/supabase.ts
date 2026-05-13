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
