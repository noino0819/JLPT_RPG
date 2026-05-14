import { readSheet } from "read-excel-file/browser";
import writeXlsxFile from "write-excel-file/browser";
import type { CsvWord } from "./csv";
import { MAX_IMPORT_ROWS, sanitizeImportedRow } from "./validation";

/**
 * 엑셀(.xlsx) 단어장 파싱/템플릿 생성 유틸.
 *
 * 컬럼 순서: 한자, 읽기, 뜻, 어원, 품사
 * - 첫 줄에 헤더("한자" / "kanji" / "headword" 등)가 있으면 헤더로 간주하고 건너뜀
 * - 한자(headword)가 비어있으면 히라가나-only 단어로 처리 (headword = null)
 *
 * 보안:
 *  - 행 수 MAX_IMPORT_ROWS 로 제한 (Excel Zip Bomb / DoS 방지)
 *  - 각 셀은 sanitizeImportedRow 로 정규화 (제어문자/길이 제한)
 */

const HEADER_KEYWORDS = ["한자", "kanji", "headword", "단어", "word"];

/**
 * 엑셀 파일을 파싱해 CsvWord 배열로 변환한다.
 * 첫 번째 시트만 사용한다.
 */
export async function parseExcel(file: File | Blob): Promise<CsvWord[]> {
  const rows = await readSheet(file);
  if (rows.length === 0) return [];

  const first = rows[0].map((c: unknown) =>
    String(c ?? "").trim().toLowerCase(),
  );
  const isHeader = first.some((c: string) =>
    HEADER_KEYWORDS.some((k) => c.includes(k.toLowerCase())),
  );
  const dataRows = isHeader ? rows.slice(1) : rows;

  const words: CsvWord[] = [];
  for (const row of dataRows) {
    if (words.length >= MAX_IMPORT_ROWS) break;
    const cells = row.map((v: unknown) =>
      v == null ? "" : String(v),
    );
    const [a, b, c, d, e] = cells;
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

/**
 * 예시 단어장 엑셀 파일을 생성/다운로드한다.
 * 헤더 1행 + 샘플 3행이 포함된다.
 */
export async function downloadExcelTemplate(
  fileName = "단어장_예시.xlsx",
): Promise<void> {
  const header = [
    { value: "한자", fontWeight: "bold" as const, backgroundColor: "#E8E0CC" },
    { value: "읽기", fontWeight: "bold" as const, backgroundColor: "#E8E0CC" },
    { value: "뜻", fontWeight: "bold" as const, backgroundColor: "#E8E0CC" },
    {
      value: "어원 (선택)",
      fontWeight: "bold" as const,
      backgroundColor: "#E8E0CC",
    },
    {
      value: "품사 (선택)",
      fontWeight: "bold" as const,
      backgroundColor: "#E8E0CC",
    },
  ];

  const samples: Array<[string, string, string, string, string]> = [
    ["首都", "しゅと", "수도", "首(머리 수) + 都(도읍 도): 머리가 되는 도읍", "명사"],
    ["勉強", "べんきょう", "공부", "勉(힘쓸 면) + 強(굳셀 강)", "명사/する동사"],
    ["", "ありがとう", "고마워(요)", "", "감탄사"],
  ];

  const data: any[] = [
    header,
    ...samples.map((row) =>
      row.map((value) => ({ type: String, value })),
    ),
  ];

  await writeXlsxFile(data, {
    sheet: "단어장",
    columns: [
      { width: 16 },
      { width: 18 },
      { width: 20 },
      { width: 40 },
      { width: 16 },
    ],
  }).toFile(fileName);
}
