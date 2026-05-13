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
 *  5. 서버가 매직링크를 직접 호출(Supabase verify)해 최종 Location 헤더만 추출
 *  6. 우리 도메인 + #access_token=...&refresh_token=... 한 번의 302 로 응답
 *
 * 5~6 단계가 중요한 이유:
 *  설치형 앱(PWA, standalone) 에서 매직링크 URL(*.supabase.co) 로 직접
 *  302 하면 OS 가 외부 브라우저로 빠져나가서 세션이 PWA 가 아닌 외부
 *  브라우저에 저장됨. 서버에서 verify 를 대신 처리해 외부 도메인 이동을
 *  제거하면 PWA 스코프 안에서 흐름이 끝남.
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

    // 6) 매직링크를 서버가 직접 호출해 최종 Location 헤더(우리 도메인 + fragment) 추출
    //    PWA standalone 모드에서 외부 supabase.co 도메인으로 빠져나가지 않게 하기 위함.
    const finalUrl = await resolveMagicLink(linkData.properties.action_link);
    if (!finalUrl) {
      // 안전망: verify 가 우리 도메인으로 떨어지지 않으면 기존 방식으로 fallback
      return res.redirect(302, linkData.properties.action_link);
    }

    res.redirect(302, finalUrl);
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

/**
 * Supabase 매직링크(action_link)는 보통
 *   https://<project>.supabase.co/auth/v1/verify?token=...&type=magiclink&redirect_to=...
 * 형태이며, GET 시 우리 redirect_to 로 302 + URL fragment(#access_token=...&refresh_token=...)
 * 를 내려준다. 서버가 직접 fetch 해서 Location 만 빼내고, 우리 도메인으로 떨어진 경우에만
 * 그 URL 을 반환한다 (오픈 리다이렉트 방지).
 */
async function resolveMagicLink(actionLink: string): Promise<string | null> {
  try {
    const verifyRes = await fetch(actionLink, { redirect: "manual" });
    const location = verifyRes.headers.get("location");
    if (!location) return null;

    // Supabase 가 우리 redirect_to 로 잘 반환했는지(= action_link 의 redirect_to 와
    // 동일 origin 인지) 검증. 절대 URL 또는 상대 URL 모두 처리.
    const expectedOrigin = (() => {
      try {
        const u = new URL(actionLink);
        const r = u.searchParams.get("redirect_to");
        return r ? new URL(r).origin : null;
      } catch {
        return null;
      }
    })();

    let absolute: URL;
    try {
      absolute = new URL(location, actionLink);
    } catch {
      return null;
    }

    if (expectedOrigin && absolute.origin !== expectedOrigin) {
      // 토큰 fragment 가 아직 안 붙은 중간 단계면 그냥 fallback 시키기 위해 null 반환
      return null;
    }

    return absolute.toString();
  } catch (err) {
    console.error("resolveMagicLink error:", err);
    return null;
  }
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
