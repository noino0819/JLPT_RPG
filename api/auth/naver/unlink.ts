import type { VercelRequest, VercelResponse } from "@vercel/node";
import { createClient } from "@supabase/supabase-js";
import {
  rejectIfMethodNotAllowed,
  setApiResponseHeaders,
} from "../../_lib/security";

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
 * ─────────────────────────────────────────────────────────────
 * ⚠ 보안 위협 & 보강 포인트
 * ─────────────────────────────────────────────────────────────
 * 콜백 URL 만 알면 누구나 임의의 service_id/user_id 로 POST 를 던질 수 있고,
 * 그 경우 우리는 매칭되는 Supabase 계정을 삭제하게 된다. 즉, 콜백 URL 노출 +
 * 피해자의 naver_id 유추만으로 계정 탈취/삭제가 가능했다.
 *
 * 보강:
 *  1) access_token 을 네이버 API(/v1/nid/me) 로 검증한다. 토큰이 유효하고,
 *     그 토큰의 소유자가 user_id 와 동일할 때만 삭제를 진행한다.
 *     - 만료 토큰은 401 을 반환하므로 access_token 검증 실패 시 reject.
 *  2) (보조) service_id 가 우리 NAVER_CLIENT_ID 와 일치하는지 확인.
 *  3) NAVER_UNLINK_REQUIRE_TOKEN 환경변수가 "false" 일 때만 토큰 검증을 끌 수 있다.
 *     (네이버 정책 변경/문서와 실제 동작이 안 맞는 경우의 비상 스위치)
 *
 * 환경변수:
 *  - NAVER_CLIENT_ID
 *  - SUPABASE_URL              (또는 VITE_SUPABASE_URL fallback)
 *  - SUPABASE_SERVICE_ROLE_KEY
 *  - NAVER_UNLINK_REQUIRE_TOKEN  (선택, 기본 "true")
 */
export default async function handler(
  req: VercelRequest,
  res: VercelResponse,
) {
  setApiResponseHeaders(res);
  if (rejectIfMethodNotAllowed(req, res, ["POST"])) return;

  try {
    const params = parseBody(req);
    const userId = sanitizeId(params["user_id"]);
    const serviceId = sanitizeId(params["service_id"]);
    const accessToken = sanitizeToken(params["access_token"]);

    console.log("[naver/unlink] received", {
      hasUserId: Boolean(userId),
      hasServiceId: Boolean(serviceId),
      hasAccessToken: Boolean(accessToken),
    });

    const NAVER_CLIENT_ID = process.env.NAVER_CLIENT_ID;
    const SUPABASE_URL =
      process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const REQUIRE_TOKEN =
      (process.env.NAVER_UNLINK_REQUIRE_TOKEN ?? "true").toLowerCase() !==
      "false";

    if (!NAVER_CLIENT_ID || !SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      console.error("[naver/unlink] 서버 환경변수 누락");
      res.status(200).json({ result: "missing_env" });
      return;
    }

    // 1차 가드: service_id 일치
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

    // 2차 가드 (핵심): access_token 을 네이버 API 로 검증
    // 토큰의 실제 소유자가 user_id 와 같을 때만 삭제 진행.
    if (REQUIRE_TOKEN) {
      if (!accessToken) {
        console.warn("[naver/unlink] access_token 누락 - 거부");
        res.status(200).json({ result: "missing_access_token" });
        return;
      }
      const verified = await verifyNaverToken(accessToken);
      if (!verified) {
        console.warn("[naver/unlink] access_token 검증 실패 - 거부", {
          user_id: userId,
        });
        res.status(200).json({ result: "invalid_token" });
        return;
      }
      if (verified.id !== userId) {
        console.warn("[naver/unlink] 토큰의 user_id 와 요청 user_id 불일치", {
          tokenUserId: verified.id,
          requestedUserId: userId,
        });
        res.status(200).json({ result: "user_id_mismatch" });
        return;
      }
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
      res.status(200).json({ result: "delete_failed" });
      return;
    }

    console.log("[naver/unlink] 사용자 삭제 완료", {
      supabase_user_id: target.id,
      naver_id: userId,
    });

    res.status(200).json({ result: "ok" });
  } catch (e) {
    console.error("[naver/unlink] fatal:", e);
    res.status(200).json({ result: "error" });
  }
}

/**
 * 외부 입력 sanitize.
 * - 네이버 user_id / service_id 는 영숫자(_-) 조합. 60자 이내.
 */
function sanitizeId(raw: unknown): string | undefined {
  if (typeof raw !== "string") return undefined;
  const trimmed = raw.trim();
  if (!trimmed) return undefined;
  if (trimmed.length > 64) return undefined;
  if (!/^[A-Za-z0-9_-]+$/.test(trimmed)) return undefined;
  return trimmed;
}

/**
 * access_token sanitize.
 * - 네이버 access_token 은 영숫자 + 일부 기호. 300자 이내로 제한.
 */
function sanitizeToken(raw: unknown): string | undefined {
  if (typeof raw !== "string") return undefined;
  const trimmed = raw.trim();
  if (!trimmed) return undefined;
  if (trimmed.length > 512) return undefined;
  if (!/^[A-Za-z0-9_.\-+/=]+$/.test(trimmed)) return undefined;
  return trimmed;
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

/**
 * 네이버 access_token 으로 /v1/nid/me 호출 → 토큰 유효성과 소유자 id 확인.
 * - 토큰이 유효하지 않으면 resultcode 가 "00" 이 아니거나 HTTP 401.
 * - 만료 토큰이면 검증 실패로 간주(=공격자/지연 재시도 방지).
 */
async function verifyNaverToken(
  accessToken: string,
): Promise<{ id: string } | null> {
  try {
    const ctrl = new AbortController();
    const timer = setTimeout(() => ctrl.abort(), 8_000);
    let response: Response;
    try {
      response = await fetch("https://openapi.naver.com/v1/nid/me", {
        headers: { Authorization: `Bearer ${accessToken}` },
        signal: ctrl.signal,
      });
    } finally {
      clearTimeout(timer);
    }
    if (!response.ok) return null;
    const json = (await response.json()) as {
      resultcode?: string;
      response?: { id?: string };
    };
    if (json.resultcode !== "00") return null;
    const id = json.response?.id;
    if (!id || typeof id !== "string") return null;
    return { id };
  } catch (e) {
    console.error("[naver/unlink] verifyNaverToken error:", e);
    return null;
  }
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
