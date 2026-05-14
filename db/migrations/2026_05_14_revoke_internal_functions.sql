-- ============================================================
-- 보안 강화: SECURITY DEFINER 트리거 함수의 외부 RPC 노출 차단
-- ============================================================
-- 발견된 위협 (Supabase advisor):
--   public 스키마의 SECURITY DEFINER 함수는 PostgREST 의 /rest/v1/rpc/*
--   엔드포인트로 자동 노출된다. 트리거에서만 호출되는 내부 함수가 anon/
--   authenticated 역할로 직접 호출 가능했음.
--
-- 영향:
--   트리거 본문은 NEW 가 null 인 상태에선 정상 종료하므로 실제 위협은
--   적지만, 모의해킹 보고서/공격면 표면적 측면에서 노출은 줄이는 게 옳다.
--
-- 적용:
--   Supabase SQL Editor 에서 한 번 실행 (멱등).
--   트리거 자체는 그대로 작동한다 (소유자가 postgres 이므로).
-- ============================================================

revoke all on function public.handle_new_user() from anon, authenticated, public;
revoke all on function public.assert_deck_count_under_limit() from anon, authenticated, public;
revoke all on function public.assert_word_count_under_limit() from anon, authenticated, public;
