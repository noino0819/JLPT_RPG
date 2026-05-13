export type JlptLevel = "N5" | "N4" | "N3" | "N2" | "N1";
export type DeckLevel = JlptLevel | "custom";

export type CharacterId = "warrior" | "mage" | "archer" | "summoner";

export type Mastery = "none" | "probably" | "mastered";

export type OrderMode = "random" | "sequential";

export interface Settings {
  order: OrderMode;
  exclude_memorized: boolean;
  probably_repeat_every: number; // every N words include 1 probably
  review_mix_weight: number; // weight multiplier for flagged words
  show_character: boolean; // 학습 화면 캐릭터 표시 여부
  effects: {
    attack: boolean;
    card_shake: boolean;
    sound: boolean;
  };
}

export const DEFAULT_SETTINGS: Settings = {
  order: "random",
  exclude_memorized: true,
  probably_repeat_every: 8,
  review_mix_weight: 3,
  show_character: true,
  effects: { attack: true, card_shake: true, sound: false },
};

export interface Profile {
  id: string;
  nickname: string;
  selected_character: CharacterId;
  settings: Settings;
}

export interface Deck {
  id: string;
  owner_id: string | null;
  name: string;
  jlpt_level: DeckLevel;
  is_official: boolean;
  description?: string;
}

export interface Example {
  id: string;
  word_id: string;
  jp_sentence: string;
  kr_translation: string;
  furigana?: string;
  order_index: number;
}

export interface Word {
  id: string;
  deck_id: string;
  headword: string | null; // null = hiragana-only
  reading: string;
  meaning: string;
  etymology?: string;
  part_of_speech?: string;
  order_index: number;
  tags: string[];
  examples: Example[];
}

export interface WordProgress {
  word_id: string;
  mastery: Mastery;
  flagged: boolean;
  last_seen_at?: string;
  mastered_at?: string;
}

export interface DungeonStats {
  jlpt_level: DeckLevel;
  mastered_count: number;
  probably_count: number;
  flagged_count: number;
  total_seen: number;
}
