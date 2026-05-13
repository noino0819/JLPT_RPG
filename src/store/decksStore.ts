import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Deck, Example, Word } from "../types";

/**
 * 통합 데이터 스토어.
 * - 항상 `decks`/`words` 평면 배열로 보유 (공식 + 커스텀 모두 포함)
 * - ID는 항상 UUID(`crypto.randomUUID()` 또는 Supabase 가 발급한 값)
 * - mutations 는 동기 (즉시 로컬 반영), 동기화는 useDecksSync 가 담당
 */
interface DecksState {
  decks: Deck[];
  words: Word[];
  loaded: boolean;

  /** sync hook 또는 boot 단계에서 사용. 전체 교체. */
  hydrate: (decks: Deck[], words: Word[]) => void;
  setLoaded: (v: boolean) => void;

  /** 헬퍼 selectors */
  allDecks: () => Deck[];
  allWords: () => Word[];
  wordsByDeck: (deckId: string) => Word[];

  /** mutations (custom decks/words 만 변경) */
  createDeck: (
    name: string,
    description?: string,
    ownerId?: string,
  ) => Deck;
  deleteDeck: (deckId: string) => void;
  renameDeck: (deckId: string, name: string) => void;
  addWord: (
    deckId: string,
    word: {
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
      examples?: Example[];
    },
  ) => Word;
  bulkAddWords: (
    deckId: string,
    items: Array<{
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
    }>,
  ) => number;
  deleteWord: (wordId: string) => void;
}

const uuid = () =>
  typeof crypto !== "undefined" && crypto.randomUUID
    ? crypto.randomUUID()
    : `local-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 10)}`;

export const useDecksStore = create<DecksState>()(
  persist(
    (set, get) => ({
      decks: [],
      words: [],
      loaded: false,

      hydrate: (decks, words) => set({ decks, words, loaded: true }),
      setLoaded: (v) => set({ loaded: v }),

      allDecks: () => get().decks,
      allWords: () => get().words,
      wordsByDeck: (deckId) =>
        get().words.filter((w) => w.deck_id === deckId),

      createDeck: (name, description, ownerId) => {
        const deck: Deck = {
          id: uuid(),
          owner_id: ownerId ?? "local",
          name,
          jlpt_level: "custom",
          is_official: false,
          description,
        };
        set((s) => ({ decks: [...s.decks, deck] }));
        return deck;
      },

      deleteDeck: (deckId) =>
        set((s) => ({
          decks: s.decks.filter((d) => d.id !== deckId),
          words: s.words.filter((w) => w.deck_id !== deckId),
        })),

      renameDeck: (deckId, name) =>
        set((s) => ({
          decks: s.decks.map((d) =>
            d.id === deckId ? { ...d, name } : d,
          ),
        })),

      addWord: (deckId, w) => {
        const existing = get().wordsByDeck(deckId).length;
        const word: Word = {
          id: uuid(),
          deck_id: deckId,
          headword: w.headword,
          reading: w.reading,
          meaning: w.meaning,
          etymology: w.etymology,
          part_of_speech: w.part_of_speech,
          order_index: existing + 1,
          tags: [],
          examples: w.examples ?? [],
        };
        set((s) => ({ words: [...s.words, word] }));
        return word;
      },

      bulkAddWords: (deckId, items) => {
        const start = get().wordsByDeck(deckId).length;
        const created: Word[] = items.map((it, i) => ({
          id: uuid(),
          deck_id: deckId,
          headword: it.headword,
          reading: it.reading,
          meaning: it.meaning,
          etymology: it.etymology,
          part_of_speech: it.part_of_speech,
          order_index: start + i + 1,
          tags: [],
          examples: [],
        }));
        set((s) => ({ words: [...s.words, ...created] }));
        return created.length;
      },

      deleteWord: (wordId) =>
        set((s) => ({ words: s.words.filter((w) => w.id !== wordId) })),
    }),
    { name: "jlpt-rpg-decks" },
  ),
);
