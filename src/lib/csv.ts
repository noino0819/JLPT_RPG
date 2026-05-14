import Papa from "papaparse";
import {
  MAX_IMPORT_ROWS,
  sanitizeImportedRow,
  type ImportedRow,
} from "./validation";

export type CsvWord = ImportedRow;

/**
 * CSV 포맷: 한자, 읽기, 뜻, 어원, 품사
 * - 헤더 라인은 선택 (첫 줄에 "한자" 가 포함되면 헤더로 간주)
 * - 한자가 비어있으면 headword = null (히라가나-only 단어)
 *
 * 보안:
 *  - 행 수 MAX_IMPORT_ROWS 로 제한 (DoS / DB 폭주 방지)
 *  - 각 셀은 sanitizeImportedRow 로 정규화 (제어문자/길이 제한)
 *  - reading 또는 meaning 이 비면 스킵
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
    first.includes("한자") ||
    first.includes("kanji") ||
    first.includes("headword");
  const dataRows = isHeader ? rows.slice(1) : rows;

  const words: CsvWord[] = [];
  for (const row of dataRows) {
    if (words.length >= MAX_IMPORT_ROWS) break;
    const [a, b, c, d, e] = row.map((v) => (v ?? "").toString());
    const sanitized = sanitizeImportedRow({
      headword: a,
      reading: b,
      meaning: c,
      etymology: d,
      part_of_speech: e,
    });
    if (!sanitized) continue;
    words.push(sanitized);
  }
  return words;
}
