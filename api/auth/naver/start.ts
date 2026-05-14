import type { VercelRequest, VercelResponse } from "@vercel/node";
import crypto from "node:crypto";
import {
  buildCookie,
  getOriginOrDefault,
  rejectIfMethodNotAllowed,
} from "../../_lib/security";

/**
 * 네이버 OAuth 시작점.
 * - CSRF 보호용 state 토큰을 발급해 HttpOnly 쿠키에 저장
 * - 네이버 인가 페이지로 302 리다이렉트
 *
 * 보안 요점:
 *  - GET 만 허용 (CSRF 토큰 발급은 안전 메서드여야 함)
 *  - host 헤더를 그대로 신뢰하지 않고 화이트리스트 기반 origin 추출
 *    (Host Header Injection → callback url 위조 차단)
 *  - state 는 32바이트 랜덤(=hex 64자) 으로 충분히 길게
 *  - 쿠키는 HttpOnly + SameSite=Lax + (https 일 때) Secure
 *
 * 환경변수: NAVER_CLIENT_ID
 */
export default function handler(req: VercelRequest, res: VercelResponse) {
  if (rejectIfMethodNotAllowed(req, res, ["GET"])) return;

  const clientId = process.env.NAVER_CLIENT_ID;
  if (!clientId) {
    res.status(500).send("NAVER_CLIENT_ID 가 설정되지 않았습니다");
    return;
  }

  const origin = getOriginOrDefault(req);
  const callbackUrl = `${origin}/api/auth/naver/callback`;

  // 32바이트(=hex 64자) - 충분한 엔트로피로 추측 불가
  const state = crypto.randomBytes(32).toString("hex");

  const isHttps = origin.startsWith("https://");
  res.setHeader(
    "Set-Cookie",
    buildCookie("naver_oauth_state", state, {
      maxAge: 600,
      httpOnly: true,
      isHttps,
      sameSite: "Lax",
    }),
  );

  // 인덱싱/캐시 방지: 인증 시작 URL 은 절대로 캐싱되어선 안 된다.
  res.setHeader("Cache-Control", "no-store");
  res.setHeader("Pragma", "no-cache");
  res.setHeader("Referrer-Policy", "no-referrer");

  const url = new URL("https://nid.naver.com/oauth2.0/authorize");
  url.searchParams.set("response_type", "code");
  url.searchParams.set("client_id", clientId);
  url.searchParams.set("redirect_uri", callbackUrl);
  url.searchParams.set("state", state);

  res.redirect(302, url.toString());
}
