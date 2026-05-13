import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { Deck, Word } from "../types";
import { OFFICIAL_DECKS, OFFICIAL_WORDS } from "../data/seed";

interface DecksState {
  customDecks: Deck[];
  customWords: Word[];

  allDecks: () => Deck[];
  allWords: () => Word[];
  wordsByDeck: (deckId: string) => Word[];

  createDeck: (name: string, description?: string) => Deck;
  deleteDeck: (deckId: string) => void;
  renameDeck: (deckId: string, name: string) => void;
  addWord: (
    deckId: string,
    word: Omit<Word, "id" | "deck_id" | "order_index" | "tags" | "examples"> & {
      examples?: Word["examples"];
    },
  ) => Word;
  bulkAddWords: (
    deckId: string,
    words: Array<{
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
    }>,
  ) => number;
  deleteWord: (wordId: string) => void;
}

const id = () =>
  `${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 8)}`;

export const useDecksStore = create<DecksState>()(
  persist(
    (set, get) => ({
      customDecks: [],
      customWords: [],

      allDecks: () => [...OFFICIAL_DECKS, ...get().customDecks],
      allWords: () => [...OFFICIAL_WORDS, ...get().customWords],
      wordsByDeck: (deckId) =>
        get().allWords().filter((w) => w.deck_id === deckId),

      createDeck: (name, description) => {
        const deck: Deck = {
          id: `deck-${id()}`,
          owner_id: "local",
          name,
          jlpt_level: "custom",
          is_official: false,
          description,
        };
        set((s) => ({ customDecks: [...s.customDecks, deck] }));
        return deck;
      },

      deleteDeck: (deckId) =>
        set((s) => ({
          customDecks: s.customDecks.filter((d) => d.id !== deckId),
          customWords: s.customWords.filter((w) => w.deck_id !== deckId),
        })),

      renameDeck: (deckId, name) =>
        set((s) => ({
          customDecks: s.customDecks.map((d) =>
            d.id === deckId ? { ...d, name } : d,
          ),
        })),

      addWord: (deckId, word) => {
        const existing = get().wordsByDeck(deckId).length;
        const wid = `w-${id()}`;
        const newWord: Word = {
          id: wid,
          deck_id: deckId,
          headword: word.headword,
          reading: word.reading,
          meaning: word.meaning,
          etymology: word.etymology,
          part_of_speech: word.part_of_speech,
          order_index: existing + 1,
          tags: [],
          examples: word.examples ?? [],
        };
        set((s) => ({ customWords: [...s.customWords, newWord] }));
        return newWord;
      },

      bulkAddWords: (deckId, words) => {
        const startIdx = get().wordsByDeck(deckId).length;
        const created: Word[] = words.map((w, i) => ({
          id: `w-${id()}-${i}`,
          deck_id: deckId,
          headword: w.headword,
          reading: w.reading,
          meaning: w.meaning,
          etymology: w.etymology,
          part_of_speech: w.part_of_speech,
          order_index: startIdx + i + 1,
          tags: [],
          examples: [],
        }));
        set((s) => ({ customWords: [...s.customWords, ...created] }));
        return created.length;
      },

      deleteWord: (wordId) =>
        set((s) => ({
          customWords: s.customWords.filter((w) => w.id !== wordId),
        })),
    }),
    { name: "jlpt-rpg-decks" },
  ),
);
