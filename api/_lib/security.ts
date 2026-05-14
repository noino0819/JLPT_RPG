import type { VercelRequest, VercelResponse } from "@vercel/node";
import crypto from "node:crypto";

/**
 * 서버리스 함수 공용 보안 유틸.
 *
 * 핵심 책임:
 *  - 신뢰할 수 있는 origin 추출 (Host Header Injection / Open Redirect 방지)
 *  - 타이밍 공격에 안전한 문자열 비교
 *  - 안전한 쿠키 빌더 (HttpOnly, Secure, SameSite, Path)
 *  - HTTP 메서드 가드
 */

/**
 * 허용된 호스트 화이트리스트.
 * 운영/스테이징/로컬을 모두 커버하되, 외부 도메인이 X-Forwarded-Host 로
 * 들어와도 절대 사용되지 않도록 한다.
 *
 * SITE_URL 환경변수가 있으면 그 origin 이 무조건 1순위.
 * Vercel preview 배포는 `*.vercel.app` 패턴으로 허용한다.
 */
const STATIC_ALLOWED_HOSTS = new Set<string>([
  "jlpt-rpg.vercel.app",
  "localhost",
  "127.0.0.1",
]);

const VERCEL_PREVIEW_PATTERN = /^[a-z0-9-]+\.vercel\.app$/i;

function isAllowedHost(host: string): boolean {
  // 포트가 붙어 있을 수 있어 분리해서 비교 (localhost:3000 등)
  const bareHost = host.toLowerCase().split(":")[0];
  if (STATIC_ALLOWED_HOSTS.has(bareHost)) return true;
  if (VERCEL_PREVIEW_PATTERN.test(bareHost)) return true;
  return false;
}

/**
 * 요청에서 안전한 origin (scheme://host[:port]) 을 추출한다.
 *
 * 우선순위:
 *   1) SITE_URL 환경변수 (운영 배포에서는 이 값을 반드시 세팅 권장)
 *   2) 화이트리스트 통과한 x-forwarded-host (Vercel proxy 가 세팅)
 *   3) 화이트리스트 통과한 host 헤더
 *
 * 모든 검증에 실패하면 null 을 반환한다. 호출부는 이때 400/500 으로
 * 끊거나 안전한 기본 origin 으로 대체해야 한다.
 */
export function getSafeOrigin(req: VercelRequest): string | null {
  const siteUrl = process.env.SITE_URL;
  if (siteUrl) {
    try {
      const u = new URL(siteUrl);
      return `${u.protocol}//${u.host}`;
    } catch {
      // SITE_URL 이 잘못 세팅된 경우는 무시하고 다음 후보로
    }
  }

  const xfHost = (req.headers["x-forwarded-host"] as string | undefined)?.trim();
  const host = (req.headers.host as string | undefined)?.trim();
  const proto =
    ((req.headers["x-forwarded-proto"] as string | undefined) || "").split(
      ",",
    )[0]?.trim() ||
    (req.socket &&
    (req.socket as unknown as { encrypted?: boolean }).encrypted
      ? "https"
      : "http");

  // x-forwarded-host 는 콤마로 여러 값이 들어올 수 있다. 첫 값만 사용.
  const candidates: string[] = [];
  if (xfHost) candidates.push(xfHost.split(",")[0].trim());
  if (host) candidates.push(host);

  for (const candidate of candidates) {
    if (isAllowedHost(candidate)) {
      return `${proto}://${candidate}`;
    }
  }

  return null;
}

/**
 * 운영 환경에서는 SITE_URL 이 없으면 위험하므로 안전한 fallback 으로
 * 운영 도메인을 강제 사용한다. 로컬 개발(http://localhost)일 때만 host 기반 origin 허용.
 */
export function getOriginOrDefault(req: VercelRequest): string {
  const safe = getSafeOrigin(req);
  if (safe) return safe;
  // 마지막 안전망. 절대로 외부 도메인은 들어오지 못한다.
  return "https://jlpt-rpg.vercel.app";
}

/**
 * 사용자 입력을 URL 쿼리스트링 값으로 안전하게 넣기 위한 공백/제어문자 정리.
 * 너무 길거나 의도되지 않은 문자가 들어오면 표준 메시지로 대체된다.
 */
export function sanitizeErrorMessage(
  raw: string | undefined | null,
  fallback = "로그인 처리 중 오류가 발생했습니다",
): string {
  if (!raw) return fallback;
  // 제어문자 제거 + 길이 제한
  const cleaned = raw.replace(/[\x00-\x1F\x7F]/g, "").trim();
  if (!cleaned) return fallback;
  return cleaned.slice(0, 200);
}

/**
 * 타이밍 공격에 안전한 문자열 비교.
 * 길이가 다르면 즉시 false 를 반환하되, 길이까지 숨길 필요는 없다고 본다
 * (state 토큰은 항상 같은 길이로 발급되기 때문).
 */
export function safeEqual(a: string, b: string): boolean {
  if (typeof a !== "string" || typeof b !== "string") return false;
  if (a.length !== b.length) return false;
  try {
    return crypto.timingSafeEqual(Buffer.from(a), Buffer.from(b));
  } catch {
    return false;
  }
}

export interface CookieOptions {
  maxAge?: number;
  path?: string;
  httpOnly?: boolean;
  secure?: boolean;
  sameSite?: "Strict" | "Lax" | "None";
}

/**
 * Set-Cookie 헤더 문자열 빌더.
 * 안전 기본값: HttpOnly, SameSite=Lax, Path=/.
 *
 * https 가 아닌 환경(로컬 개발) 에서는 Secure 를 강제하지 않는다.
 * (그 외 모든 환경에서는 Secure 를 켜야 한다.)
 */
export function buildCookie(
  name: string,
  value: string,
  opts: CookieOptions & { isHttps: boolean },
): string {
  const parts: string[] = [`${name}=${value}`];
  parts.push(`Path=${opts.path ?? "/"}`);
  if (typeof opts.maxAge === "number") parts.push(`Max-Age=${opts.maxAge}`);
  if (opts.httpOnly !== false) parts.push("HttpOnly");
  if (opts.isHttps && opts.secure !== false) parts.push("Secure");
  parts.push(`SameSite=${opts.sameSite ?? "Lax"}`);
  return parts.join("; ");
}

/**
 * 단순 Cookie 헤더 파서.
 */
export function parseCookieHeader(
  cookieHeader: string | undefined | null,
): Record<string, string> {
  const result: Record<string, string> = {};
  if (!cookieHeader) return result;
  cookieHeader.split(";").forEach((part) => {
    const idx = part.indexOf("=");
    if (idx === -1) return;
    const k = part.slice(0, idx).trim();
    const v = part.slice(idx + 1).trim();
    if (k) {
      try {
        result[k] = decodeURIComponent(v);
      } catch {
        result[k] = v;
      }
    }
  });
  return result;
}

/**
 * HTTP 메서드 가드. 허용되지 않으면 405 + Allow 헤더로 응답한 뒤 true 를 반환.
 * 호출부는 true 일 때 즉시 return 해야 한다.
 *
 * OPTIONS 는 항상 거절한다 (CORS preflight 차단 — 우리 API 는 동일 origin 전용).
 */
export function rejectIfMethodNotAllowed(
  req: VercelRequest,
  res: VercelResponse,
  allowed: ReadonlyArray<string>,
): boolean {
  const method = (req.method || "GET").toUpperCase();
  if (method === "OPTIONS") {
    // CORS preflight: 명시적으로 거부. 동일 origin 외 다른 origin 차단.
    res.setHeader("Allow", allowed.join(", "));
    res.status(405).json({ error: "method_not_allowed" });
    return true;
  }
  if (!allowed.includes(method)) {
    res.setHeader("Allow", allowed.join(", "));
    res.status(405).json({ error: "method_not_allowed" });
    return true;
  }
  return false;
}

/**
 * 일반 API(자체 호출용) 의 보안 헤더 일괄 세팅.
 * Vercel 의 vercel.json headers 는 정적/SPA 라우트와 별개로 함수 응답에도
 * 적용되지만, 함수 본문에서도 한 번 더 명시해 둔다 (방어적 다중화).
 */
export function setApiResponseHeaders(res: VercelResponse): void {
  res.setHeader(
    "Cache-Control",
    "no-store, no-cache, must-revalidate, max-age=0",
  );
  res.setHeader("Pragma", "no-cache");
  res.setHeader("X-Content-Type-Options", "nosniff");
  res.setHeader("Referrer-Policy", "no-referrer");
}
