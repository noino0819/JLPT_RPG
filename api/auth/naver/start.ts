import type { VercelRequest, VercelResponse } from "@vercel/node";
import crypto from "node:crypto";

/**
 * 네이버 OAuth 시작점.
 * - CSRF 보호용 state 토큰을 발급해 HttpOnly 쿠키에 저장
 * - 네이버 인가 페이지로 302 리다이렉트
 *
 * 환경변수: NAVER_CLIENT_ID
 */
export default function handler(req: VercelRequest, res: VercelResponse) {
  const clientId = process.env.NAVER_CLIENT_ID;
  if (!clientId) {
    res.status(500).send("NAVER_CLIENT_ID 가 설정되지 않았습니다");
    return;
  }

  const origin = getOrigin(req);
  const callbackUrl = `${origin}/api/auth/naver/callback`;
  const state = crypto.randomBytes(16).toString("hex");

  const isHttps = origin.startsWith("https://");
  res.setHeader(
    "Set-Cookie",
    [
      `naver_oauth_state=${state}`,
      "Path=/",
      "Max-Age=600",
      "HttpOnly",
      isHttps ? "Secure" : "",
      "SameSite=Lax",
    ]
      .filter(Boolean)
      .join("; "),
  );

  const url = new URL("https://nid.naver.com/oauth2.0/authorize");
  url.searchParams.set("response_type", "code");
  url.searchParams.set("client_id", clientId);
  url.searchParams.set("redirect_uri", callbackUrl);
  url.searchParams.set("state", state);

  res.redirect(302, url.toString());
}

function getOrigin(req: VercelRequest): string {
  const proto =
    (req.headers["x-forwarded-proto"] as string | undefined) ||
    (req.socket && (req.socket as unknown as { encrypted?: boolean }).encrypted
      ? "https"
      : "http");
  const host =
    (req.headers["x-forwarded-host"] as string | undefined) ||
    (req.headers.host as string);
  return `${proto}://${host}`;
}
