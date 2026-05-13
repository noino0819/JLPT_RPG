import type { VercelRequest, VercelResponse } from "@vercel/node";
import { createClient } from "@supabase/supabase-js";

/**
 * 네이버 "연결 끊기" 콜백.
 *
 * 동작 시점:
 *  - 사용자가 "네이버 프로필 > 연결된 서비스 관리" 에서 본 앱 연결을 해제
 *  - 사용자가 네이버 회원 자체를 탈퇴
 *
 * 네이버 측 요청 명세 (https://developers.naver.com/docs/login/devcenter_search/):
 *  - HTTP Method: POST
 *  - Content-Type: application/x-www-form-urlencoded
 *  - 파라미터
 *    - access_token : 마지막으로 발급된 access token (만료되었을 수 있음)
 *    - user_id      : 네이버 회원 고유 식별값
 *    - service_id   : 본 앱의 Client ID
 *
 * 응답:
 *  - 네이버는 HTTP 200 OK 만 확인합니다. 본문 형식은 자유.
 *
 * 처리 정책:
 *  1) service_id 가 우리 NAVER_CLIENT_ID 와 일치하는지 확인 (위변조 1차 차단)
 *  2) user_metadata.naver_id == user_id 인 Supabase 사용자를 admin API 로 조회
 *  3) 일치 사용자가 있으면 admin.deleteUser 로 계정 삭제
 *     (회원 탈퇴 / 연결 해제 모두 같은 처리. 우리 서비스에서 별도 회원가입을
 *      따로 받지 않고 네이버 로그인만 사용하므로 안전하게 삭제합니다.)
 *  4) 어떤 결과든 200 OK 로 응답해 네이버 측 재시도 큐를 비웁니다.
 *
 * 환경변수:
 *  - NAVER_CLIENT_ID
 *  - SUPABASE_URL              (또는 VITE_SUPABASE_URL fallback)
 *  - SUPABASE_SERVICE_ROLE_KEY
 */
export default async function handler(
  req: VercelRequest,
  res: VercelResponse,
) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    res.status(405).json({ result: "method_not_allowed" });
    return;
  }

  try {
    const params = parseBody(req);
    const userId = params["user_id"];
    const serviceId = params["service_id"];
    const accessToken = params["access_token"];

    console.log("[naver/unlink] received", {
      hasUserId: Boolean(userId),
      hasServiceId: Boolean(serviceId),
      hasAccessToken: Boolean(accessToken),
    });

    const NAVER_CLIENT_ID = process.env.NAVER_CLIENT_ID;
    const SUPABASE_URL =
      process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!NAVER_CLIENT_ID || !SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      console.error("[naver/unlink] 서버 환경변수 누락");
      res.status(200).json({ result: "missing_env" });
      return;
    }

    if (!serviceId || serviceId !== NAVER_CLIENT_ID) {
      console.warn("[naver/unlink] service_id 불일치 또는 누락", { serviceId });
      res.status(200).json({ result: "invalid_service_id" });
      return;
    }

    if (!userId) {
      console.warn("[naver/unlink] user_id 누락");
      res.status(200).json({ result: "missing_user_id" });
      return;
    }

    const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false, autoRefreshToken: false },
    });

    const target = await findUserByNaverId(admin, userId);
    if (!target) {
      console.log("[naver/unlink] 매칭 사용자 없음 - 이미 정리됨", { userId });
      res.status(200).json({ result: "not_found" });
      return;
    }

    const { error: delErr } = await admin.auth.admin.deleteUser(target.id);
    if (delErr) {
      console.error("[naver/unlink] deleteUser 실패:", delErr);
      res.status(200).json({ result: "delete_failed", error: delErr.message });
      return;
    }

    console.log("[naver/unlink] 사용자 삭제 완료", {
      supabase_user_id: target.id,
      email: target.email,
      naver_id: userId,
    });

    res.status(200).json({ result: "ok" });
  } catch (e) {
    console.error("[naver/unlink] fatal:", e);
    res.status(200).json({
      result: "error",
      message: e instanceof Error ? e.message : "unknown",
    });
  }
}

/**
 * Vercel 은 application/x-www-form-urlencoded 도 자동 파싱해서 req.body 에 넣어주지만,
 * 환경/버전에 따라 문자열로 들어오는 경우가 있어 안전하게 모두 처리합니다.
 */
function parseBody(req: VercelRequest): Record<string, string> {
  const out: Record<string, string> = {};

  if (req.body && typeof req.body === "object" && !Array.isArray(req.body)) {
    for (const [k, v] of Object.entries(req.body)) {
      if (typeof v === "string") out[k] = v;
      else if (v != null) out[k] = String(v);
    }
    return out;
  }

  if (typeof req.body === "string" && req.body.length > 0) {
    const parsed = new URLSearchParams(req.body);
    parsed.forEach((v, k) => {
      out[k] = v;
    });
    return out;
  }

  if (req.query) {
    for (const [k, v] of Object.entries(req.query)) {
      if (typeof v === "string") out[k] = v;
      else if (Array.isArray(v) && v.length > 0) out[k] = v[0];
    }
  }
  return out;
}

interface MinimalAdminUser {
  id: string;
  email: string | null;
  user_metadata?: Record<string, unknown> | null;
}

/**
 * Supabase admin.listUsers 를 페이지별로 순회하면서
 * user_metadata.naver_id 가 일치하는 사용자를 찾습니다.
 *
 * 사용자가 많아지면 별도 인덱스 테이블(naver_id → user_id) 을 두는 것이 좋지만,
 * 현재 규모에서는 listUsers 페이지네이션으로 충분합니다.
 */
async function findUserByNaverId(
  admin: ReturnType<typeof createClient>,
  naverId: string,
  maxPages = 20,
): Promise<MinimalAdminUser | null> {
  const perPage = 200;
  for (let page = 1; page <= maxPages; page += 1) {
    const { data, error } = await admin.auth.admin.listUsers({
      page,
      perPage,
    });
    if (error) {
      console.error("[naver/unlink] listUsers 오류:", error);
      return null;
    }
    const users = data?.users ?? [];
    if (users.length === 0) return null;

    const hit = users.find((u) => {
      const meta = (u.user_metadata || {}) as Record<string, unknown>;
      return meta.naver_id === naverId && meta.provider === "naver";
    });
    if (hit) {
      return {
        id: hit.id,
        email: hit.email ?? null,
        user_metadata: hit.user_metadata as Record<string, unknown> | null,
      };
    }

    if (users.length < perPage) return null;
  }
  return null;
}
