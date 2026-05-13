import type { JlptLevel } from "../store/playerStore";

export interface Word {
  id: string;
  jlpt: JlptLevel;
  kanji: string;
  kana: string;
  meaningKo: string;
  partOfSpeech: "명사" | "동사" | "い형용사" | "な형용사" | "부사" | "표현";
  example?: { jp: string; ko: string };
}

export const WORDS: Word[] = [
  {
    id: "n5-1",
    jlpt: "N5",
    kanji: "学生",
    kana: "がくせい",
    meaningKo: "학생",
    partOfSpeech: "명사",
    example: {
      jp: "私は学生です。",
      ko: "저는 학생입니다.",
    },
  },
  {
    id: "n5-2",
    jlpt: "N5",
    kanji: "食べる",
    kana: "たべる",
    meaningKo: "먹다",
    partOfSpeech: "동사",
    example: {
      jp: "朝ごはんを食べる。",
      ko: "아침밥을 먹다.",
    },
  },
  {
    id: "n5-3",
    jlpt: "N5",
    kanji: "大きい",
    kana: "おおきい",
    meaningKo: "크다",
    partOfSpeech: "い형용사",
  },
  {
    id: "n5-4",
    jlpt: "N5",
    kanji: "水",
    kana: "みず",
    meaningKo: "물",
    partOfSpeech: "명사",
  },
  {
    id: "n5-5",
    jlpt: "N5",
    kanji: "行く",
    kana: "いく",
    meaningKo: "가다",
    partOfSpeech: "동사",
    example: {
      jp: "学校へ行く。",
      ko: "학교에 가다.",
    },
  },
  {
    id: "n4-1",
    jlpt: "N4",
    kanji: "経験",
    kana: "けいけん",
    meaningKo: "경험",
    partOfSpeech: "명사",
  },
  {
    id: "n4-2",
    jlpt: "N4",
    kanji: "間違える",
    kana: "まちがえる",
    meaningKo: "틀리다, 잘못 알다",
    partOfSpeech: "동사",
  },
  {
    id: "n4-3",
    jlpt: "N4",
    kanji: "簡単",
    kana: "かんたん",
    meaningKo: "간단함",
    partOfSpeech: "な형용사",
  },
  {
    id: "n3-1",
    jlpt: "N3",
    kanji: "解決",
    kana: "かいけつ",
    meaningKo: "해결",
    partOfSpeech: "명사",
  },
  {
    id: "n3-2",
    jlpt: "N3",
    kanji: "頑張る",
    kana: "がんばる",
    meaningKo: "분발하다, 힘내다",
    partOfSpeech: "동사",
    example: {
      jp: "最後まで頑張ります。",
      ko: "끝까지 분발하겠습니다.",
    },
  },
  {
    id: "n2-1",
    jlpt: "N2",
    kanji: "影響",
    kana: "えいきょう",
    meaningKo: "영향",
    partOfSpeech: "명사",
  },
  {
    id: "n2-2",
    jlpt: "N2",
    kanji: "懐かしい",
    kana: "なつかしい",
    meaningKo: "그립다",
    partOfSpeech: "い형용사",
  },
  {
    id: "n1-1",
    jlpt: "N1",
    kanji: "曖昧",
    kana: "あいまい",
    meaningKo: "애매함",
    partOfSpeech: "な형용사",
  },
  {
    id: "n1-2",
    jlpt: "N1",
    kanji: "踏襲",
    kana: "とうしゅう",
    meaningKo: "답습",
    partOfSpeech: "명사",
  },
];

export function getWordsByLevel(level: JlptLevel): Word[] {
  return WORDS.filter((w) => w.jlpt === level);
}
