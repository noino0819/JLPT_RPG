// 일본어 카나(히라가나/가타카나) 데이터셋.
// - script: 어떤 문자 체계인지 (hira / kata)
// - group: 청음(seion) / 탁음·반탁음(dakuten) / 요음(youon)
// - row: 행(あ・か・さ…) 라벨 — 그리드 정렬용
// - romaji 는 헵번식 (chi, tsu, fu, shi, ji 등 보편형) 을 따른다.

export type KanaScript = "hira" | "kata";
export type KanaGroup = "seion" | "dakuten" | "youon";

export interface KanaChar {
  id: string; // `${script}:${romaji}` (요음은 합성 키)
  script: KanaScript;
  group: KanaGroup;
  row: string; // あ / か / さ / た / な / は / ま / や / ら / わ / が / ざ / だ / ば / ぱ / きゃ / ...
  char: string; // ひ / カ ...
  romaji: string;
}

// ───────── 청음 (基本字 / 五十音図) ─────────
// 각 row 안에서 순서대로 5개의 모음 a/i/u/e/o 를 채운다.
// null 은 그 모음 자리가 비어있다는 의미 (やぎゃ 행, わ 행).
const SEION_TABLE: Array<{
  row: string;
  hira: Array<[string, string] | null>;
  kata: Array<[string, string] | null>;
}> = [
  {
    row: "あ",
    hira: [["あ", "a"], ["い", "i"], ["う", "u"], ["え", "e"], ["お", "o"]],
    kata: [["ア", "a"], ["イ", "i"], ["ウ", "u"], ["エ", "e"], ["オ", "o"]],
  },
  {
    row: "か",
    hira: [["か", "ka"], ["き", "ki"], ["く", "ku"], ["け", "ke"], ["こ", "ko"]],
    kata: [["カ", "ka"], ["キ", "ki"], ["ク", "ku"], ["ケ", "ke"], ["コ", "ko"]],
  },
  {
    row: "さ",
    hira: [["さ", "sa"], ["し", "shi"], ["す", "su"], ["せ", "se"], ["そ", "so"]],
    kata: [["サ", "sa"], ["シ", "shi"], ["ス", "su"], ["セ", "se"], ["ソ", "so"]],
  },
  {
    row: "た",
    hira: [["た", "ta"], ["ち", "chi"], ["つ", "tsu"], ["て", "te"], ["と", "to"]],
    kata: [["タ", "ta"], ["チ", "chi"], ["ツ", "tsu"], ["テ", "te"], ["ト", "to"]],
  },
  {
    row: "な",
    hira: [["な", "na"], ["に", "ni"], ["ぬ", "nu"], ["ね", "ne"], ["の", "no"]],
    kata: [["ナ", "na"], ["ニ", "ni"], ["ヌ", "nu"], ["ネ", "ne"], ["ノ", "no"]],
  },
  {
    row: "は",
    hira: [["は", "ha"], ["ひ", "hi"], ["ふ", "fu"], ["へ", "he"], ["ほ", "ho"]],
    kata: [["ハ", "ha"], ["ヒ", "hi"], ["フ", "fu"], ["ヘ", "he"], ["ホ", "ho"]],
  },
  {
    row: "ま",
    hira: [["ま", "ma"], ["み", "mi"], ["む", "mu"], ["め", "me"], ["も", "mo"]],
    kata: [["マ", "ma"], ["ミ", "mi"], ["ム", "mu"], ["メ", "me"], ["モ", "mo"]],
  },
  {
    row: "や",
    hira: [["や", "ya"], null, ["ゆ", "yu"], null, ["よ", "yo"]],
    kata: [["ヤ", "ya"], null, ["ユ", "yu"], null, ["ヨ", "yo"]],
  },
  {
    row: "ら",
    hira: [["ら", "ra"], ["り", "ri"], ["る", "ru"], ["れ", "re"], ["ろ", "ro"]],
    kata: [["ラ", "ra"], ["リ", "ri"], ["ル", "ru"], ["レ", "re"], ["ロ", "ro"]],
  },
  {
    row: "わ",
    hira: [["わ", "wa"], null, null, null, ["を", "wo"]],
    kata: [["ワ", "wa"], null, null, null, ["ヲ", "wo"]],
  },
  {
    row: "ん",
    hira: [["ん", "n"], null, null, null, null],
    kata: [["ン", "n"], null, null, null, null],
  },
];

// ───────── 탁음·반탁음 (濁音·半濁音) ─────────
const DAKUTEN_TABLE: Array<{
  row: string;
  hira: Array<[string, string] | null>;
  kata: Array<[string, string] | null>;
}> = [
  {
    row: "が",
    hira: [["が", "ga"], ["ぎ", "gi"], ["ぐ", "gu"], ["げ", "ge"], ["ご", "go"]],
    kata: [["ガ", "ga"], ["ギ", "gi"], ["グ", "gu"], ["ゲ", "ge"], ["ゴ", "go"]],
  },
  {
    row: "ざ",
    hira: [["ざ", "za"], ["じ", "ji"], ["ず", "zu"], ["ぜ", "ze"], ["ぞ", "zo"]],
    kata: [["ザ", "za"], ["ジ", "ji"], ["ズ", "zu"], ["ゼ", "ze"], ["ゾ", "zo"]],
  },
  {
    row: "だ",
    hira: [["だ", "da"], ["ぢ", "ji"], ["づ", "zu"], ["で", "de"], ["ど", "do"]],
    kata: [["ダ", "da"], ["ヂ", "ji"], ["ヅ", "zu"], ["デ", "de"], ["ド", "do"]],
  },
  {
    row: "ば",
    hira: [["ば", "ba"], ["び", "bi"], ["ぶ", "bu"], ["べ", "be"], ["ぼ", "bo"]],
    kata: [["バ", "ba"], ["ビ", "bi"], ["ブ", "bu"], ["ベ", "be"], ["ボ", "bo"]],
  },
  {
    row: "ぱ",
    hira: [["ぱ", "pa"], ["ぴ", "pi"], ["ぷ", "pu"], ["ぺ", "pe"], ["ぽ", "po"]],
    kata: [["パ", "pa"], ["ピ", "pi"], ["プ", "pu"], ["ペ", "pe"], ["ポ", "po"]],
  },
];

// ───────── 요음 (拗音) — き/し/ち/に/ひ/み/り + ぎ/じ/び/ぴ × ゃ/ゅ/ょ ─────────
// "i단 + 작은 や/ゆ/よ" 결합으로 만들어지는 33개의 음.
const YOUON_BASE: Array<{ rowChar: string; rowKatakana: string; consonant: string }> = [
  // 청음 베이스
  { rowChar: "き", rowKatakana: "キ", consonant: "ky" },
  { rowChar: "し", rowKatakana: "シ", consonant: "sh" },
  { rowChar: "ち", rowKatakana: "チ", consonant: "ch" },
  { rowChar: "に", rowKatakana: "ニ", consonant: "ny" },
  { rowChar: "ひ", rowKatakana: "ヒ", consonant: "hy" },
  { rowChar: "み", rowKatakana: "ミ", consonant: "my" },
  { rowChar: "り", rowKatakana: "リ", consonant: "ry" },
  // 탁음·반탁음 베이스
  { rowChar: "ぎ", rowKatakana: "ギ", consonant: "gy" },
  { rowChar: "じ", rowKatakana: "ジ", consonant: "j" },
  { rowChar: "び", rowKatakana: "ビ", consonant: "by" },
  { rowChar: "ぴ", rowKatakana: "ピ", consonant: "py" },
];

// ゃ/ゅ/ょ 결합부 (작은 や/ゆ/よ)
const YOUON_TAILS: Array<{ hira: string; kata: string; vowel: string }> = [
  { hira: "ゃ", kata: "ャ", vowel: "a" },
  { hira: "ゅ", kata: "ュ", vowel: "u" },
  { hira: "ょ", kata: "ョ", vowel: "o" },
];

// 자음별 헵번식 표기 — sh/ch/j 처리.
function youonRomaji(consonant: string, vowel: string): string {
  // sh+a -> sha, sh+u -> shu, sh+o -> sho
  // ch+a -> cha, ch+u -> chu, ch+o -> cho
  // j+a -> ja, j+u -> ju, j+o -> jo
  if (consonant === "sh" || consonant === "ch") return `${consonant}${vowel}`;
  if (consonant === "j") return `j${vowel}`;
  return `${consonant}${vowel}`; // ky+a -> kya 등
}

function buildSeionList(): KanaChar[] {
  const out: KanaChar[] = [];
  for (const r of SEION_TABLE) {
    r.hira.forEach((cell) => {
      if (!cell) return;
      const [char, romaji] = cell;
      out.push({
        id: `hira:${romaji}`,
        script: "hira",
        group: "seion",
        row: r.row,
        char,
        romaji,
      });
    });
    r.kata.forEach((cell) => {
      if (!cell) return;
      const [char, romaji] = cell;
      out.push({
        id: `kata:${romaji}`,
        script: "kata",
        group: "seion",
        row: r.row,
        char,
        romaji,
      });
    });
  }
  return out;
}

function buildDakutenList(): KanaChar[] {
  const out: KanaChar[] = [];
  for (const r of DAKUTEN_TABLE) {
    r.hira.forEach((cell) => {
      if (!cell) return;
      const [char, romaji] = cell;
      out.push({
        id: `hira:dakuten:${char}`,
        script: "hira",
        group: "dakuten",
        row: r.row,
        char,
        romaji,
      });
    });
    r.kata.forEach((cell) => {
      if (!cell) return;
      const [char, romaji] = cell;
      out.push({
        id: `kata:dakuten:${char}`,
        script: "kata",
        group: "dakuten",
        row: r.row,
        char,
        romaji,
      });
    });
  }
  return out;
}

function buildYouonList(): KanaChar[] {
  const out: KanaChar[] = [];
  for (const base of YOUON_BASE) {
    for (const tail of YOUON_TAILS) {
      const hiraChar = base.rowChar + tail.hira;
      const kataChar = base.rowKatakana + tail.kata;
      const romaji = youonRomaji(base.consonant, tail.vowel);
      // 요음은 같은 발음(예: しゃ ＝ ja 가 아닌 sha) 키 중복을 막기 위해
      // 문자 자체를 id 에 사용.
      out.push({
        id: `hira:youon:${hiraChar}`,
        script: "hira",
        group: "youon",
        row: base.rowChar,
        char: hiraChar,
        romaji,
      });
      out.push({
        id: `kata:youon:${kataChar}`,
        script: "kata",
        group: "youon",
        row: base.rowKatakana,
        char: kataChar,
        romaji,
      });
    }
  }
  return out;
}

export const KANA_ALL: KanaChar[] = [
  ...buildSeionList(),
  ...buildDakutenList(),
  ...buildYouonList(),
];

export function getKana(script: KanaScript, group: KanaGroup): KanaChar[] {
  return KANA_ALL.filter((k) => k.script === script && k.group === group);
}

// 5×n 그리드 표시용 — null 셀까지 보존해 자리 표시.
// 결과: row 라벨 → 길이 5 의 (KanaChar | null)[] 배열.
export function getKanaGrid(
  script: KanaScript,
  group: KanaGroup,
): Array<{ row: string; cells: Array<KanaChar | null> }> {
  if (group === "seion") {
    return SEION_TABLE.map((r) => {
      const list = script === "hira" ? r.hira : r.kata;
      const cells = list.map((cell) => {
        if (!cell) return null;
        return (
          KANA_ALL.find(
            (k) =>
              k.script === script &&
              k.group === "seion" &&
              k.char === cell[0],
          ) ?? null
        );
      });
      return { row: r.row, cells };
    });
  }
  if (group === "dakuten") {
    return DAKUTEN_TABLE.map((r) => {
      const list = script === "hira" ? r.hira : r.kata;
      const cells = list.map((cell) => {
        if (!cell) return null;
        return (
          KANA_ALL.find(
            (k) =>
              k.script === script &&
              k.group === "dakuten" &&
              k.char === cell[0],
          ) ?? null
        );
      });
      return { row: r.row, cells };
    });
  }
  // youon — 3 열 (ゃ/ゅ/ょ)
  return YOUON_BASE.map((base) => {
    const rowChar = script === "hira" ? base.rowChar : base.rowKatakana;
    const cells: Array<KanaChar | null> = YOUON_TAILS.map((tail) => {
      const target =
        (script === "hira" ? base.rowChar : base.rowKatakana) +
        (script === "hira" ? tail.hira : tail.kata);
      return (
        KANA_ALL.find(
          (k) => k.script === script && k.group === "youon" && k.char === target,
        ) ?? null
      );
    });
    return { row: rowChar, cells };
  });
}

export const KANA_GROUP_LABEL: Record<KanaGroup, { ko: string; jp: string }> = {
  seion: { ko: "청음", jp: "清音" },
  dakuten: { ko: "탁음·반탁음", jp: "濁音·半濁音" },
  youon: { ko: "요음", jp: "拗音" },
};

export const KANA_SCRIPT_LABEL: Record<
  KanaScript,
  { ko: string; jp: string; emoji: string }
> = {
  hira: { ko: "히라가나", jp: "ひらがな", emoji: "🌸" },
  kata: { ko: "가타카나", jp: "カタカナ", emoji: "⚔" },
};
