import type { VercelRequest, VercelResponse } from "@vercel/node";
import { createClient } from "@supabase/supabase-js";

interface NaverTokenResponse {
  access_token?: string;
  refresh_token?: string;
  token_type?: string;
  expires_in?: string;
  error?: string;
  error_description?: string;
}

interface NaverProfileResponse {
  resultcode: string;
  message: string;
  response?: {
    id: string;
    email?: string;
    name?: string;
    nickname?: string;
    profile_image?: string;
  };
}

/**
 * 네이버 OAuth 콜백.
 * 흐름:
 *  1. state 검증 (CSRF)
 *  2. authorization code → access token 교환
 *  3. 네이버 프로필(이메일) 조회
 *  4. Supabase Admin: 사용자 생성(또는 무시) + 매직링크 발급
 *  5. 매직링크 URL 로 302 → Supabase verify → 우리 사이트 루트로 자동 로그인
 *
 * 환경변수:
 *  - NAVER_CLIENT_ID
 *  - NAVER_CLIENT_SECRET
 *  - SUPABASE_URL                (또는 VITE_SUPABASE_URL 도 fallback)
 *  - SUPABASE_SERVICE_ROLE_KEY
 *  - SITE_URL                    (선택, 기본은 요청 origin)
 */
export default async function handler(
  req: VercelRequest,
  res: VercelResponse,
) {
  try {
    const { code, state, error, error_description } = req.query as Record<
      string,
      string | undefined
    >;

    if (error) {
      return redirectToLogin(
        res,
        getOrigin(req),
        error_description || error,
      );
    }
    if (!code || !state) {
      return redirectToLogin(res, getOrigin(req), "code/state 누락");
    }

    const cookieState = parseCookie(req.headers.cookie || "")[
      "naver_oauth_state"
    ];
    if (!cookieState || cookieState !== state) {
      return redirectToLogin(res, getOrigin(req), "잘못된 state (CSRF)");
    }

    const NAVER_CLIENT_ID = process.env.NAVER_CLIENT_ID;
    const NAVER_CLIENT_SECRET = process.env.NAVER_CLIENT_SECRET;
    const SUPABASE_URL =
      process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const SITE_URL = process.env.SITE_URL || getOrigin(req);

    if (
      !NAVER_CLIENT_ID ||
      !NAVER_CLIENT_SECRET ||
      !SUPABASE_URL ||
      !SUPABASE_SERVICE_ROLE_KEY
    ) {
      return redirectToLogin(
        res,
        getOrigin(req),
        "OAuth 환경변수가 서버에 설정되지 않았습니다",
      );
    }

    // 1) code → access_token
    const tokenUrl = new URL("https://nid.naver.com/oauth2.0/token");
    tokenUrl.searchParams.set("grant_type", "authorization_code");
    tokenUrl.searchParams.set("client_id", NAVER_CLIENT_ID);
    tokenUrl.searchParams.set("client_secret", NAVER_CLIENT_SECRET);
    tokenUrl.searchParams.set("code", code);
    tokenUrl.searchParams.set("state", state);

    const tokenRes = await fetch(tokenUrl.toString());
    const token = (await tokenRes.json()) as NaverTokenResponse;
    if (!token.access_token) {
      return redirectToLogin(
        res,
        getOrigin(req),
        `토큰 교환 실패: ${token.error_description || token.error || "unknown"}`,
      );
    }

    // 2) 프로필 조회
    const profileRes = await fetch("https://openapi.naver.com/v1/nid/me", {
      headers: { Authorization: `Bearer ${token.access_token}` },
    });
    const profile = (await profileRes.json()) as NaverProfileResponse;

    if (profile.resultcode !== "00" || !profile.response) {
      return redirectToLogin(
        res,
        getOrigin(req),
        `프로필 조회 실패: ${profile.message || "unknown"}`,
      );
    }

    const naverEmail = profile.response.email;
    if (!naverEmail) {
      return redirectToLogin(
        res,
        getOrigin(req),
        "네이버 이메일 제공 동의가 필요합니다",
      );
    }

    const naverId = profile.response.id;
    const displayName =
      profile.response.nickname ||
      profile.response.name ||
      naverEmail.split("@")[0];

    // 3) Supabase Admin 클라이언트
    const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false, autoRefreshToken: false },
    });

    // 4) 사용자 생성 (이미 있으면 무시)
    const { error: createErr } = await admin.auth.admin.createUser({
      email: naverEmail,
      email_confirm: true,
      user_metadata: {
        nickname: displayName,
        provider: "naver",
        naver_id: naverId,
      },
    });

    if (
      createErr &&
      !/already (registered|been registered|exists)/i.test(createErr.message)
    ) {
      console.error("createUser error:", createErr);
      return redirectToLogin(
        res,
        getOrigin(req),
        `사용자 생성 실패: ${createErr.message}`,
      );
    }

    // 5) 매직 링크 발급
    const { data: linkData, error: linkErr } =
      await admin.auth.admin.generateLink({
        type: "magiclink",
        email: naverEmail,
        options: {
          redirectTo: `${SITE_URL}/`,
        },
      });

    if (linkErr || !linkData?.properties?.action_link) {
      console.error("generateLink error:", linkErr);
      return redirectToLogin(
        res,
        getOrigin(req),
        `매직링크 발급 실패: ${linkErr?.message || "unknown"}`,
      );
    }

    // state 쿠키 만료
    res.setHeader(
      "Set-Cookie",
      [
        "naver_oauth_state=",
        "Path=/",
        "Max-Age=0",
        "HttpOnly",
        getOrigin(req).startsWith("https://") ? "Secure" : "",
        "SameSite=Lax",
      ]
        .filter(Boolean)
        .join("; "),
    );

    res.redirect(302, linkData.properties.action_link);
  } catch (e) {
    console.error("naver callback fatal:", e);
    redirectToLogin(
      res,
      getOrigin(req),
      e instanceof Error ? e.message : "알 수 없는 오류",
    );
  }
}

function redirectToLogin(
  res: VercelResponse,
  origin: string,
  message: string,
) {
  const url = new URL("/login", origin);
  url.searchParams.set("login_error", message);
  res.redirect(302, url.toString());
}

function parseCookie(cookieHeader: string): Record<string, string> {
  const result: Record<string, string> = {};
  cookieHeader.split(";").forEach((part) => {
    const idx = part.indexOf("=");
    if (idx === -1) return;
    const k = part.slice(0, idx).trim();
    const v = part.slice(idx + 1).trim();
    if (k) result[k] = decodeURIComponent(v);
  });
  return result;
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
