export type JlptLevel = "N5" | "N4" | "N3" | "N2" | "N1";
export type DeckLevel = JlptLevel | "custom";

export type CharacterId = "warrior" | "mage" | "archer" | "summoner";

export type Mastery = "none" | "probably" | "mastered";

export type OrderMode = "random" | "sequential";

// 단어 카드/카나에 사용되는 일본어 픽셀·레트로 폰트 식별자.
// 실제 글꼴 정의/CSS 패밀리/Google Fonts URL 은 src/lib/jpFonts.ts 참고.
export type JpFontId =
  | "dotgothic16"
  | "train_one"
  | "stick"
  | "reggae_one"
  | "yusei_magic"
  | "hachi_maru_pop";

export interface Settings {
  order: OrderMode;
  exclude_memorized: boolean;
  probably_repeat_every: number; // every N words include 1 probably
  review_mix_weight: number; // weight multiplier for flagged words
  show_character: boolean; // 학습 화면 캐릭터 표시 여부
  // 일본어 단어/카나 표시에 사용할 픽셀 폰트
  jp_font: JpFontId;
  effects: {
    attack: boolean;
    card_shake: boolean;
    sound: boolean;
  };
  // 일본어 음성 읽기(Web Speech API) 설정
  tts: {
    enabled: boolean; // 🔊 버튼 노출 여부
    autoplay: boolean; // 카드가 새로 등장할 때 자동 재생
    rate: number; // 발화 속도(0.5 ~ 1.5)
  };
}

export const DEFAULT_SETTINGS: Settings = {
  order: "random",
  exclude_memorized: true,
  probably_repeat_every: 8,
  review_mix_weight: 3,
  show_character: true,
  jp_font: "dotgothic16",
  effects: { attack: true, card_shake: true, sound: true },
  tts: { enabled: true, autoplay: false, rate: 0.95 },
};

export interface Profile {
  id: string;
  nickname: string;
  selected_character: CharacterId;
  settings: Settings;
  equipped: EquippedCosmetics;
}

// ───────── 꾸밈 시스템 (Cosmetics) ─────────

export type CosmeticKind = "costume" | "pet" | "title" | "badge" | "frame";

// 해금 조건: 누적 처치 수 또는 특정 던전 처치 수
export type UnlockCondition =
  | { kind: "rank"; min: number }
  | { kind: "dungeon"; level: JlptLevel; min: number };

export interface CosmeticBase {
  id: string;
  kind: CosmeticKind;
  name: string;
  nameJp?: string;
  description?: string;
  condition: UnlockCondition;
}

export interface EquippedCosmetics {
  // 캐릭터별로 코스튬을 따로 저장 (전사일 때 / 마법사일 때 다른 코스튬)
  costume: Record<CharacterId, string>;
  pet: string | null;
  title: string | null;
  badges: string[];
  frame: string | null;
}

export const DEFAULT_EQUIPPED: EquippedCosmetics = {
  costume: {
    warrior: "warrior_default",
    mage: "mage_default",
    archer: "archer_default",
    summoner: "summoner_default",
  },
  pet: null,
  title: null,
  badges: [],
  frame: "frame_default",
};

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
