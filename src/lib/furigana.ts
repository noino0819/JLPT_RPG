// ──────────────────────────────────────────────────────────────────
// 후리가나(振り仮名) 매칭 유틸리티.
//
// headword(한자/히라가나 혼합) 와 reading(전체 히라가나) 을 받아
// 한자 블록 → 그 한자 블록의 발음 으로 매칭한 세그먼트 배열을 만든다.
// UI 측에서는 이 세그먼트를 <ruby>+<rt> 로 그려 한자 바로 아래에 발음을
// 표시한다.
//
// 알고리즘 요지
// 1) headword 를 「한자 런」 / 「비한자 런(히라가나·가타카나·기타)」 으로 분리.
// 2) 비한자 런은 reading 안에 그대로 등장해야 한다고 가정하고
//    위치를 단서로 한자 런의 발음 구간을 추정.
// 3) 매칭이 깨지면(어긋난 reading 등) null 을 반환하여 호출 측에서
//    기존 「headword + reading 별행 표시」 로 폴백하도록 한다.
// ──────────────────────────────────────────────────────────────────

export interface FuriganaSegment {
  /** 표시할 본문 (headword 의 부분 문자열) */
  text: string;
  /** 한자 런이면 그 한자에 대응하는 히라가나 발음. 비한자 런이면 undefined. */
  ruby?: string;
}

// 한자(CJK 통합 한자 + 확장 A) + 반복 기호(々).
// 후리가나 매칭에 한해서는 々 도 한자 런의 일부로 다룬다 (人々 → ひとびと 처럼
// 발음이 앞 글자 발음의 변형이지만, 연속된 한자 블록으로 봐야 자연스러움).
function isKanjiChar(ch: string): boolean {
  const code = ch.codePointAt(0) ?? 0;
  if (code === 0x3005) return true; // 々
  if (code >= 0x4e00 && code <= 0x9fff) return true;
  if (code >= 0x3400 && code <= 0x4dbf) return true;
  return false;
}

/**
 * headword 를 「연속된 한자」 / 「그 외(히라가나·가타카나·기타)」 런으로 쪼갠다.
 */
function splitRuns(headword: string): Array<{ kind: "kanji" | "other"; text: string }> {
  if (!headword) return [];
  const runs: Array<{ kind: "kanji" | "other"; text: string }> = [];
  // 코드 포인트 단위로 순회하기 위해 spread 사용 (서러게이트 페어 안전).
  const chars = Array.from(headword);
  let kind: "kanji" | "other" = isKanjiChar(chars[0]) ? "kanji" : "other";
  let buf = chars[0];
  for (let i = 1; i < chars.length; i++) {
    const c = chars[i];
    const k: "kanji" | "other" = isKanjiChar(c) ? "kanji" : "other";
    if (k === kind) {
      buf += c;
    } else {
      runs.push({ kind, text: buf });
      kind = k;
      buf = c;
    }
  }
  runs.push({ kind, text: buf });
  return runs;
}

/**
 * headword 와 reading 을 매칭하여 ruby 세그먼트 배열을 만든다.
 *
 * - 한자 없음 → 한 덩어리 그대로 반환 (ruby 미표기).
 * - 매칭 실패(reading 이 어긋남) → null 반환. 호출 측에서 폴백 처리할 것.
 */
export function buildFurigana(
  headword: string | null | undefined,
  reading: string | null | undefined,
): FuriganaSegment[] | null {
  if (!headword) return null;
  const runs = splitRuns(headword);
  if (runs.length === 0) return null;

  // 한자가 전혀 없으면 ruby 가 필요 없다 (그대로 표기).
  if (!runs.some((r) => r.kind === "kanji")) {
    return [{ text: headword }];
  }

  // 한자가 있는데 reading 이 비어 있으면 매칭 불가 → 폴백.
  if (!reading) return null;

  const out: FuriganaSegment[] = [];
  let pos = 0;
  for (let i = 0; i < runs.length; i++) {
    const run = runs[i];
    if (run.kind === "other") {
      // 비한자 런은 reading 의 현재 위치에서 그대로 등장해야 한다.
      if (!reading.startsWith(run.text, pos)) {
        return null; // 어긋남 → 폴백
      }
      out.push({ text: run.text });
      pos += run.text.length;
      continue;
    }

    // 한자 런: 다음 비한자 런의 시작 위치까지가 이 한자 런의 발음.
    const next = runs.slice(i + 1).find((r) => r.kind === "other");
    if (!next) {
      // 마지막이 한자 런으로 끝남 → 남은 reading 전부.
      const ruby = reading.slice(pos);
      if (!ruby) return null;
      out.push({ text: run.text, ruby });
      pos = reading.length;
    } else {
      const idx = reading.indexOf(next.text, pos);
      if (idx === -1 || idx === pos) {
        // 발음 구간이 비거나 다음 비한자 런을 찾지 못함 → 폴백.
        return null;
      }
      out.push({ text: run.text, ruby: reading.slice(pos, idx) });
      pos = idx;
    }
  }

  // reading 에 남는 글자가 있다면 매칭이 어긋난 것 → 폴백.
  if (pos !== reading.length) return null;

  return out;
}

/**
 * 한자가 단 한 글자라도 포함되어 있는지 (UI 분기용).
 */
export function hasKanji(text: string | null | undefined): boolean {
  if (!text) return false;
  for (const ch of text) {
    if (isKanjiChar(ch)) return true;
  }
  return false;
}
