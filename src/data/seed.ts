import type { Deck, Word } from "../types";

/**
 * 로컬 모드(데모) 전용 시드.
 * - Supabase 모드일 때는 사용되지 않습니다 (DB 에서 로드).
 * - ID 는 결정론적 문자열로, word_progress 와 매칭이 필요한 작업에는
 *   사용할 수 없습니다 (로컬 모드는 별도 스토어에서만 동작).
 */
export const OFFICIAL_DECKS: Deck[] = [
  {
    id: "local-deck-n5",
    owner_id: null,
    name: "JLPT N5",
    jlpt_level: "N5",
    is_official: true,
    description: "시작의 숲",
  },
  {
    id: "local-deck-n4",
    owner_id: null,
    name: "JLPT N4",
    jlpt_level: "N4",
    is_official: true,
    description: "동굴",
  },
  {
    id: "local-deck-n3",
    owner_id: null,
    name: "JLPT N3",
    jlpt_level: "N3",
    is_official: true,
    description: "고대 유적",
  },
  {
    id: "local-deck-n2",
    owner_id: null,
    name: "JLPT N2",
    jlpt_level: "N2",
    is_official: true,
    description: "화산",
  },
  {
    id: "local-deck-n1",
    owner_id: null,
    name: "JLPT N1",
    jlpt_level: "N1",
    is_official: true,
    description: "천공의 신전",
  },
];

let counter = 0;
const w = (
  deck_id: string,
  headword: string | null,
  reading: string,
  meaning: string,
  part_of_speech: string,
  etymology?: string,
  examples?: { jp: string; ko: string }[],
): Word => {
  const id = `local-w-${counter++}`;
  return {
    id,
    deck_id,
    headword,
    reading,
    meaning,
    part_of_speech,
    etymology,
    order_index: counter,
    tags: [],
    examples: (examples ?? []).map((ex, i) => ({
      id: `${id}-ex-${i}`,
      word_id: id,
      jp_sentence: ex.jp,
      kr_translation: ex.ko,
      order_index: i,
    })),
  };
};

export const OFFICIAL_WORDS: Word[] = [
  // N5
  w("local-deck-n5", "学生", "がくせい", "학생", "명사", undefined, [
    { jp: "私は学生です。", ko: "저는 학생입니다." },
  ]),
  w("local-deck-n5", "食べる", "たべる", "먹다", "동사", undefined, [
    { jp: "朝ごはんを食べる。", ko: "아침밥을 먹다." },
  ]),
  w("local-deck-n5", "大きい", "おおきい", "크다", "い형용사"),
  w("local-deck-n5", "水", "みず", "물", "명사"),
  w("local-deck-n5", "行く", "いく", "가다", "동사", undefined, [
    { jp: "学校へ行く。", ko: "학교에 가다." },
  ]),
  w("local-deck-n5", "本", "ほん", "책", "명사"),
  w("local-deck-n5", null, "ありがとう", "고맙다, 감사", "표현"),
  w("local-deck-n5", "今日", "きょう", "오늘", "명사"),

  // N4
  w(
    "local-deck-n4",
    "経験",
    "けいけん",
    "경험",
    "명사",
    "経(지날 경): 실(糸)이 길게 이어진 경로\n験(증험할 험): 말(馬)을 시험해 봄",
  ),
  w("local-deck-n4", "間違える", "まちがえる", "틀리다, 잘못 알다", "동사"),
  w("local-deck-n4", "簡単", "かんたん", "간단함", "な형용사"),
  w("local-deck-n4", "教える", "おしえる", "가르치다", "동사"),
  w("local-deck-n4", "急ぐ", "いそぐ", "서두르다", "동사"),

  // N3
  w(
    "local-deck-n3",
    "首都",
    "しゅと",
    "수도",
    "명사",
    "首(머리 수): 몸의 으뜸인 머리 모양 → 중심\n都(도읍 도): 많은 사람(者)이 모인 마을(邑)",
    [{ jp: "東京は日本の首都です。", ko: "도쿄는 일본의 수도이다." }],
  ),
  w(
    "local-deck-n3",
    "地球",
    "ちきゅう",
    "지구",
    "명사",
    "地(땅 지): 흙(土)이 평평하게(也) 깔린 곳\n球(공 구): 둥근 구슬(玉) 같은 모양",
  ),
  w(
    "local-deck-n3",
    "息",
    "いき",
    "숨",
    "명사",
    "自(코 자) + 心(마음 심): 코로 숨을 쉬며 마음을 안정시킴",
  ),
  w(
    "local-deck-n3",
    "遅れる",
    "おくれる",
    "늦다",
    "동사",
    "遅(늦을 지): 뿔이 난 짐승이 천천히 가는 모양 → 지체되다",
    [{ jp: "電車が遅れる。", ko: "전철이 늦다." }],
  ),
  w(
    "local-deck-n3",
    "努力",
    "どりょく",
    "노력",
    "명사",
    "努(힘쓸 노): 종(奴)이 힘(力)을 다해 애쓰다\n力(힘 력): 근육이나 쟁기의 모양",
  ),
  w("local-deck-n3", "解決", "かいけつ", "해결", "명사"),
  w(
    "local-deck-n3",
    "頑張る",
    "がんばる",
    "분발하다, 힘내다",
    "동사",
    undefined,
    [{ jp: "最後まで頑張ります。", ko: "끝까지 분발하겠습니다." }],
  ),

  // N2
  w("local-deck-n2", "影響", "えいきょう", "영향", "명사"),
  w("local-deck-n2", "懐かしい", "なつかしい", "그립다", "い형용사"),
  w("local-deck-n2", "我慢", "がまん", "참음, 인내", "명사"),
  w("local-deck-n2", "贅沢", "ぜいたく", "사치", "な형용사"),

  // N1
  w("local-deck-n1", "曖昧", "あいまい", "애매함", "な형용사"),
  w(
    "local-deck-n1",
    "踏襲",
    "とうしゅう",
    "답습",
    "명사",
    "踏(밟을 답) + 襲(엄습할 습): 이전의 것을 그대로 따라 밟음",
  ),
  w("local-deck-n1", "緻密", "ちみつ", "치밀함", "な형용사"),
];
