import Papa from "papaparse";

export interface CsvWord {
  headword: string | null;
  reading: string;
  meaning: string;
  etymology?: string;
  part_of_speech?: string;
}

/**
 * CSV 포맷: 한자, 읽기, 뜻, 어원, 품사
 * - 헤더 라인은 선택 (첫 줄에 "한자" 가 포함되면 헤더로 간주)
 * - 한자가 비어있으면 headword = null (히라가나-only 단어)
 */
export function parseCsv(text: string): CsvWord[] {
  const result = Papa.parse<string[]>(text.trim(), {
    skipEmptyLines: true,
  });

  if (result.errors.length) {
    console.warn("CSV parse warnings:", result.errors);
  }

  const rows = result.data as string[][];
  if (rows.length === 0) return [];

  const first = rows[0].map((c) => c?.trim() ?? "");
  const isHeader =
    first.includes("한자") || first.includes("kanji") || first.includes("headword");
  const dataRows = isHeader ? rows.slice(1) : rows;

  const words: CsvWord[] = [];
  for (const row of dataRows) {
    const [a, b, c, d, e] = row.map((v) => (v ?? "").trim());
    const reading = b;
    const meaning = c;
    if (!reading || !meaning) continue;
    words.push({
      headword: a || null,
      reading,
      meaning,
      etymology: d || undefined,
      part_of_speech: e || undefined,
    });
  }
  return words;
}
