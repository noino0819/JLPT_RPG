import type { VercelRequest, VercelResponse } from "@vercel/node";
import { createClient } from "@supabase/supabase-js";
import {
  buildCookie,
  getOriginOrDefault,
  parseCookieHeader,
  rejectIfMethodNotAllowed,
  safeEqual,
  sanitizeErrorMessage,
  setApiResponseHeaders,
} from "../../_lib/security.js";

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
 *
 * 보안 요점:
 *  - GET 만 허용
 *  - 안전한 origin 추출 (Host Header Injection 차단)
 *  - state 는 timing-safe 비교
 *  - 외부 OAuth 에러 메시지는 sanitize 후 길이 제한
 *  - 매직 링크 verify 결과 Location 이 우리 origin 일 때만 사용 (Open Redirect 차단)
 *
 * 흐름:
 *  1. state 검증 (CSRF)
 *  2. authorization code → access token 교환
 *  3. 네이버 프로필(이메일) 조회
 *  4. Supabase Admin: 사용자 생성(또는 무시) + 매직링크 발급
 *  5. 서버가 매직링크를 직접 호출(Supabase verify)해 최종 Location 헤더만 추출
 *  6. 우리 도메인 + #access_token=...&refresh_token=... 한 번의 302 로 응답
 *
 * 환경변수:
 *  - NAVER_CLIENT_ID
 *  - NAVER_CLIENT_SECRET
 *  - SUPABASE_URL                (또는 VITE_SUPABASE_URL 도 fallback)
 *  - SUPABASE_SERVICE_ROLE_KEY
 *  - SITE_URL                    (운영시 반드시 권장)
 */
export default async function handler(
  req: VercelRequest,
  res: VercelResponse,
) {
  setApiResponseHeaders(res);
  if (rejectIfMethodNotAllowed(req, res, ["GET"])) return;

  const origin = getOriginOrDefault(req);
  const isHttps = origin.startsWith("https://");

  try {
    const { code, state, error, error_description } = req.query as Record<
      string,
      string | undefined
    >;

    if (error) {
      return redirectToLogin(
        res,
        origin,
        sanitizeErrorMessage(error_description || error),
      );
    }
    if (
      !code ||
      !state ||
      typeof code !== "string" ||
      typeof state !== "string"
    ) {
      return redirectToLogin(res, origin, "잘못된 인증 요청입니다");
    }

    const cookieState = parseCookieHeader(req.headers.cookie)[
      "naver_oauth_state"
    ];
    if (!cookieState || !safeEqual(cookieState, state)) {
      return redirectToLogin(res, origin, "인증 세션이 만료되었습니다 (CSRF)");
    }

    const NAVER_CLIENT_ID = process.env.NAVER_CLIENT_ID;
    const NAVER_CLIENT_SECRET = process.env.NAVER_CLIENT_SECRET;
    const SUPABASE_URL =
      process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (
      !NAVER_CLIENT_ID ||
      !NAVER_CLIENT_SECRET ||
      !SUPABASE_URL ||
      !SUPABASE_SERVICE_ROLE_KEY
    ) {
      // 운영 환경 미설정 - 사용자에겐 자세한 정보 노출하지 않음
      console.error("[naver/callback] 서버 환경변수 누락");
      return redirectToLogin(res, origin, "서버 설정 오류가 발생했습니다");
    }

    // state 쿠키는 검증 즉시 삭제 (재사용 차단)
    res.setHeader(
      "Set-Cookie",
      buildCookie("naver_oauth_state", "", {
        maxAge: 0,
        httpOnly: true,
        isHttps,
        sameSite: "Lax",
      }),
    );

    // 1) code → access_token
    const tokenUrl = new URL("https://nid.naver.com/oauth2.0/token");
    tokenUrl.searchParams.set("grant_type", "authorization_code");
    tokenUrl.searchParams.set("client_id", NAVER_CLIENT_ID);
    tokenUrl.searchParams.set("client_secret", NAVER_CLIENT_SECRET);
    tokenUrl.searchParams.set("code", code);
    tokenUrl.searchParams.set("state", state);

    const tokenRes = await fetchWithTimeout(tokenUrl.toString(), {}, 10_000);
    if (!tokenRes.ok) {
      console.error("[naver/callback] token endpoint HTTP", tokenRes.status);
      return redirectToLogin(res, origin, "네이버 토큰 교환에 실패했습니다");
    }
    const token = (await tokenRes.json()) as NaverTokenResponse;
    if (!token.access_token) {
      console.error("[naver/callback] token error:", token.error);
      return redirectToLogin(res, origin, "네이버 토큰 교환에 실패했습니다");
    }

    // 2) 프로필 조회
    const profileRes = await fetchWithTimeout(
      "https://openapi.naver.com/v1/nid/me",
      {
        headers: { Authorization: `Bearer ${token.access_token}` },
      },
      10_000,
    );
    if (!profileRes.ok) {
      console.error("[naver/callback] profile HTTP", profileRes.status);
      return redirectToLogin(res, origin, "네이버 프로필 조회에 실패했습니다");
    }
    const profile = (await profileRes.json()) as NaverProfileResponse;

    if (profile.resultcode !== "00" || !profile.response) {
      console.error("[naver/callback] profile resultcode:", profile.resultcode);
      return redirectToLogin(res, origin, "네이버 프로필 조회에 실패했습니다");
    }

    const naverEmail = profile.response.email;
    if (!naverEmail || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(naverEmail)) {
      return redirectToLogin(
        res,
        origin,
        "네이버 이메일 제공 동의가 필요합니다",
      );
    }

    const naverId = profile.response.id;
    if (!naverId) {
      return redirectToLogin(res, origin, "네이버 사용자 식별값이 없습니다");
    }

    const rawDisplayName =
      profile.response.nickname ||
      profile.response.name ||
      naverEmail.split("@")[0];
    // 닉네임 sanitize: 제어문자 제거 + 길이 제한
    const displayName = rawDisplayName
      .replace(/[\x00-\x1F\x7F]/g, "")
      .trim()
      .slice(0, 40) || "모험가";

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
      return redirectToLogin(res, origin, "사용자 생성에 실패했습니다");
    }

    // 5) 매직 링크 발급 (redirectTo 는 항상 우리 origin)
    const { data: linkData, error: linkErr } =
      await admin.auth.admin.generateLink({
        type: "magiclink",
        email: naverEmail,
        options: {
          redirectTo: `${origin}/`,
        },
      });

    if (linkErr || !linkData?.properties?.action_link) {
      console.error("generateLink error:", linkErr);
      return redirectToLogin(res, origin, "매직링크 발급에 실패했습니다");
    }

    // 6) 매직링크를 서버가 직접 호출해 최종 Location 헤더(우리 도메인 + fragment) 추출
    const finalUrl = await resolveMagicLink(
      linkData.properties.action_link,
      origin,
    );
    if (!finalUrl) {
      // 안전망: verify 가 우리 도메인으로 떨어지지 않으면 직접 사용자에게 매직링크 이메일 안내
      console.error("[naver/callback] magic link verify 실패");
      return redirectToLogin(
        res,
        origin,
        "세션 발급에 실패했습니다. 다시 시도해 주세요",
      );
    }

    res.redirect(302, finalUrl);
  } catch (e) {
    console.error("naver callback fatal:", e);
    redirectToLogin(res, origin, "알 수 없는 오류가 발생했습니다");
  }
}

function redirectToLogin(
  res: VercelResponse,
  origin: string,
  message: string,
) {
  const url = new URL("/login", origin);
  url.searchParams.set("login_error", sanitizeErrorMessage(message));
  res.redirect(302, url.toString());
}

/**
 * Supabase 매직링크(action_link)는
 *   https://<project>.supabase.co/auth/v1/verify?token=...&redirect_to=...
 * 형태이며, GET 시 우리 redirect_to 로 302 + URL fragment(#access_token=...) 를 내려준다.
 *
 * Open Redirect 방지를 위해:
 *   - action_link 의 redirect_to 가 우리 origin 인지
 *   - 최종 Location 의 origin 도 우리 origin 인지
 * 둘 다 검증한다.
 */
async function resolveMagicLink(
  actionLink: string,
  expectedOrigin: string,
): Promise<string | null> {
  try {
    // action_link 의 redirect_to 가 expectedOrigin 과 같은지 1차 확인
    const linkUrl = new URL(actionLink);
    const redirectTo = linkUrl.searchParams.get("redirect_to");
    if (!redirectTo) return null;
    let redirectOrigin: string;
    try {
      redirectOrigin = new URL(redirectTo).origin;
    } catch {
      return null;
    }
    if (redirectOrigin !== expectedOrigin) {
      return null;
    }

    const verifyRes = await fetchWithTimeout(
      actionLink,
      { redirect: "manual" },
      10_000,
    );
    const location = verifyRes.headers.get("location");
    if (!location) return null;

    let absolute: URL;
    try {
      absolute = new URL(location, actionLink);
    } catch {
      return null;
    }

    // 최종 Location 의 origin 도 검증
    if (absolute.origin !== expectedOrigin) {
      return null;
    }

    return absolute.toString();
  } catch (err) {
    console.error("resolveMagicLink error:", err);
    return null;
  }
}

/**
 * fetch + AbortController 타임아웃.
 * 외부 API(네이버, Supabase verify) 가 응답을 안 주면 함수 타임아웃(10s) 가까이
 * 끌고 가서 Lambda 비용/응답 지연을 키운다. 명시적 타임아웃으로 끊는다.
 */
async function fetchWithTimeout(
  input: string,
  init: RequestInit,
  timeoutMs: number,
): Promise<Response> {
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    return await fetch(input, { ...init, signal: ctrl.signal });
  } finally {
    clearTimeout(timer);
  }
}
