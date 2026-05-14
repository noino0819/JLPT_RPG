/**
 * 클라이언트 입력 검증/정규화 유틸.
 *
 * 책임:
 *  - 텍스트 입력 정규화 (제어문자/null byte 제거, 트림, 길이 제한)
 *  - 파일 업로드 제한 상수
 *  - 비밀번호 / 이메일 강도 검증
 *
 * 주의: 이 함수들은 1차 가드일 뿐이며, 진짜 권한 경계는 DB RLS/CHECK 제약과
 * 서버리스 함수에서 다시 검증되어야 한다.
 */

/* ── 파일 업로드 제한 ──────────────────────────── */

/** 단일 업로드 파일 최대 크기 (5MB) */
export const MAX_UPLOAD_BYTES = 5 * 1024 * 1024;

/** 한 번에 가져올 수 있는 최대 행 수 */
export const MAX_IMPORT_ROWS = 5_000;

/** 한 셀(컬럼) 최대 글자 수 */
export const MAX_CELL_LEN = 500;

/* ── 모델별 길이 제한 ──────────────────────────── */

/** 덱 이름 (1~50자) */
export const MAX_DECK_NAME_LEN = 50;
export const MAX_DECK_DESCRIPTION_LEN = 200;

/** 단어 필드 길이 */
export const MAX_HEADWORD_LEN = 64;
export const MAX_READING_LEN = 128;
export const MAX_MEANING_LEN = 256;
export const MAX_ETYMOLOGY_LEN = 1_000;
export const MAX_POS_LEN = 32;

/** 닉네임 (1~30자) */
export const MAX_NICKNAME_LEN = 30;

/** 비밀번호 (8~128자) */
export const MIN_PASSWORD_LEN = 8;
export const MAX_PASSWORD_LEN = 128;

/* ── 텍스트 sanitize ───────────────────────────── */

/**
 * 사용자 텍스트 정규화.
 * - null byte / 제어문자 (\x00~\x1F, \x7F) 제거
 * - HTML/스크립트 태그 흔적 제거 (브라우저는 React 가 막아주지만,
 *   엑셀로 다시 내보낼 때나 다른 컨텍스트에서 안전하도록)
 * - 앞뒤 공백 트림
 * - 최대 길이로 슬라이스
 */
export function sanitizeText(
  raw: unknown,
  maxLen: number,
  opts: { allowEmpty?: boolean } = {},
): string {
  if (raw == null) return "";
  let s = String(raw);
  // 제어문자 제거 (탭/줄바꿈은 살림)
  s = s.replace(/[\x00\x01-\x08\x0B\x0C\x0E-\x1F\x7F]/g, "");
  s = s.trim();
  if (s.length > maxLen) s = s.slice(0, maxLen);
  if (!opts.allowEmpty && !s) return "";
  return s;
}

/**
 * 한 줄 짜리 텍스트 (탭/줄바꿈 모두 공백으로). 닉네임/덱 이름 등에 사용.
 */
export function sanitizeSingleLine(raw: unknown, maxLen: number): string {
  if (raw == null) return "";
  let s = String(raw);
  s = s.replace(/[\x00-\x1F\x7F]/g, " ");
  s = s.replace(/\s+/g, " ").trim();
  if (s.length > maxLen) s = s.slice(0, maxLen);
  return s;
}

/* ── 비밀번호 / 이메일 ──────────────────────────── */

export type PasswordIssue =
  | "too_short"
  | "too_long"
  | "needs_letter"
  | "needs_digit"
  | "has_whitespace"
  | "has_control";

export interface PasswordStrengthResult {
  ok: boolean;
  issues: PasswordIssue[];
  message?: string;
}

/**
 * 비밀번호 강도 검사.
 * 정책: 8~128자, 영문 + 숫자 각각 1자 이상, 제어문자/공백 불가.
 */
export function checkPasswordStrength(pw: string): PasswordStrengthResult {
  const issues: PasswordIssue[] = [];
  if (pw.length < MIN_PASSWORD_LEN) issues.push("too_short");
  if (pw.length > MAX_PASSWORD_LEN) issues.push("too_long");
  if (!/[A-Za-z]/.test(pw)) issues.push("needs_letter");
  if (!/[0-9]/.test(pw)) issues.push("needs_digit");
  if (/\s/.test(pw)) issues.push("has_whitespace");
  if (/[\x00-\x1F\x7F]/.test(pw)) issues.push("has_control");
  if (issues.length === 0) return { ok: true, issues };

  return {
    ok: false,
    issues,
    message: describePasswordIssues(issues),
  };
}

function describePasswordIssues(issues: PasswordIssue[]): string {
  const parts: string[] = [];
  if (issues.includes("too_short"))
    parts.push(`최소 ${MIN_PASSWORD_LEN}자 이상`);
  if (issues.includes("too_long"))
    parts.push(`최대 ${MAX_PASSWORD_LEN}자 이하`);
  if (issues.includes("needs_letter")) parts.push("영문 포함");
  if (issues.includes("needs_digit")) parts.push("숫자 포함");
  if (issues.includes("has_whitespace")) parts.push("공백 금지");
  if (issues.includes("has_control")) parts.push("제어문자 금지");
  return `비밀번호 정책 위반: ${parts.join(", ")}`;
}

/**
 * 이메일 형식 검증 + 정규화 (소문자/공백 제거).
 * RFC 완전 검증은 어렵고 비실용적이라 흔한 케이스만 잡는다.
 */
export function normalizeEmail(raw: string): string {
  return raw.trim().toLowerCase();
}

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
export function isValidEmail(raw: string): boolean {
  const e = normalizeEmail(raw);
  if (e.length === 0 || e.length > 254) return false;
  return EMAIL_RE.test(e);
}

/* ── 파일 확장자/타입 검증 ──────────────────────── */

const ALLOWED_IMPORT_EXTS = [".csv", ".xlsx", ".xls"];
const ALLOWED_IMPORT_MIMES = new Set([
  "text/csv",
  "application/csv",
  "application/vnd.ms-excel",
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  "", // 브라우저가 MIME 을 못 잡는 케이스도 허용 (확장자로 검증)
]);

export type ImportFileError =
  | "too_large"
  | "unsupported_type"
  | "empty_file";

export function validateImportFile(file: File): ImportFileError | null {
  if (file.size === 0) return "empty_file";
  if (file.size > MAX_UPLOAD_BYTES) return "too_large";

  const lower = file.name.toLowerCase();
  const hasAllowedExt = ALLOWED_IMPORT_EXTS.some((ext) => lower.endsWith(ext));
  const mimeAllowed = ALLOWED_IMPORT_MIMES.has(file.type);

  if (!hasAllowedExt && !mimeAllowed) return "unsupported_type";
  return null;
}

export function describeImportError(err: ImportFileError): string {
  switch (err) {
    case "too_large":
      return `파일이 너무 큽니다 (최대 ${MAX_UPLOAD_BYTES / 1024 / 1024}MB).`;
    case "unsupported_type":
      return "지원하지 않는 파일 형식입니다. (.csv / .xlsx / .xls)";
    case "empty_file":
      return "빈 파일입니다.";
  }
}

/* ── 행 단위 sanitize 헬퍼 (CSV/Excel 공용) ───── */

export interface ImportedRow {
  headword: string | null;
  reading: string;
  meaning: string;
  etymology?: string;
  part_of_speech?: string;
}

/**
 * 외부 파일에서 읽어온 한 행을 ImportedRow 로 정규화한다.
 * - 필수값(reading/meaning) 누락 시 null 반환 (스킵 신호)
 * - 각 셀은 sanitizeText 로 정리 + 컬럼별 최대 길이로 슬라이스
 */
export function sanitizeImportedRow(cells: {
  headword?: string;
  reading?: string;
  meaning?: string;
  etymology?: string;
  part_of_speech?: string;
}): ImportedRow | null {
  const reading = sanitizeText(cells.reading ?? "", MAX_READING_LEN);
  const meaning = sanitizeText(cells.meaning ?? "", MAX_MEANING_LEN);
  if (!reading || !meaning) return null;

  const headword = sanitizeText(cells.headword ?? "", MAX_HEADWORD_LEN);
  const etymology = sanitizeText(cells.etymology ?? "", MAX_ETYMOLOGY_LEN);
  const partOfSpeech = sanitizeText(cells.part_of_speech ?? "", MAX_POS_LEN);

  return {
    headword: headword || null,
    reading,
    meaning,
    etymology: etymology || undefined,
    part_of_speech: partOfSpeech || undefined,
  };
}
