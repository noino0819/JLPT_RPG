-- ============================================================
-- 보안 강화: RLS 정책에 WITH CHECK 명시 + 권한 분리
-- ============================================================
-- 발견된 위협 (모의해킹 가정):
--   1) decks UPDATE 정책에 WITH CHECK 가 없어 본인 덱을
--      is_official=true 로 바꾸거나 owner_id 를 다른 사용자로
--      이전시켜 권한을 우회 가능했음.
--   2) words / examples 도 동일. UPDATE 시 deck_id 를 다른 사람
--      덱(또는 공식 덱)으로 이동시켜 무단 수정 가능했음.
--   3) word_progress 도 WITH CHECK 부재. user_id 가 본인이 아닌
--      row 를 만들 수는 없었지만 (USING 도 INSERT 에 적용됨),
--      명시성을 위해 분리.
--   4) profiles INSERT 정책 부재. 트리거가 작동하지 않는 경우
--      클라이언트에서 본인 행을 생성할 수 없어 fallback 실패.
--
-- 적용:
--   Supabase SQL Editor 에서 한 번 실행. 멱등(DROP IF EXISTS) 처리.
-- ============================================================

-- ─────────── profiles ───────────
drop policy if exists "profiles_select_own"   on public.profiles;
drop policy if exists "profiles_update_own"   on public.profiles;
drop policy if exists "profiles_insert_self"  on public.profiles;

create policy "profiles_select_own"
  on public.profiles for select using (auth.uid() = id);

create policy "profiles_insert_self"
  on public.profiles for insert with check (auth.uid() = id);

create policy "profiles_update_own"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- 명시적 DELETE 금지: cascade(auth.users 삭제) 로만 정리되어야 한다.
-- 사용자가 직접 자기 프로필을 비우는 경로는 막아 두 단계 인증/admin 으로만
-- 가능하게 강제. (필요 시 별도 정책으로 풀 수 있음.)

-- ─────────── decks ───────────
drop policy if exists "decks_select"       on public.decks;
drop policy if exists "decks_insert_own"   on public.decks;
drop policy if exists "decks_update_own"   on public.decks;
drop policy if exists "decks_delete_own"   on public.decks;

create policy "decks_select"
  on public.decks for select
  using (is_official or owner_id = auth.uid());

create policy "decks_insert_own"
  on public.decks for insert
  with check (owner_id = auth.uid() and is_official = false);

create policy "decks_update_own"
  on public.decks for update
  using (owner_id = auth.uid() and is_official = false)
  with check (owner_id = auth.uid() and is_official = false);

create policy "decks_delete_own"
  on public.decks for delete
  using (owner_id = auth.uid() and is_official = false);

-- ─────────── words ───────────
drop policy if exists "words_select"        on public.words;
drop policy if exists "words_modify_own"    on public.words;
drop policy if exists "words_insert_own"    on public.words;
drop policy if exists "words_update_own"    on public.words;
drop policy if exists "words_delete_own"    on public.words;

create policy "words_select"
  on public.words for select
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and (d.is_official or d.owner_id = auth.uid())
  ));

create policy "words_insert_own"
  on public.words for insert
  with check (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

create policy "words_update_own"
  on public.words for update
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ))
  with check (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

create policy "words_delete_own"
  on public.words for delete
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

-- ─────────── examples ───────────
drop policy if exists "examples_select"      on public.examples;
drop policy if exists "examples_modify_own"  on public.examples;
drop policy if exists "examples_insert_own"  on public.examples;
drop policy if exists "examples_update_own"  on public.examples;
drop policy if exists "examples_delete_own"  on public.examples;

create policy "examples_select"
  on public.examples for select
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and (d.is_official or d.owner_id = auth.uid())
  ));

create policy "examples_insert_own"
  on public.examples for insert
  with check (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

create policy "examples_update_own"
  on public.examples for update
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ))
  with check (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

create policy "examples_delete_own"
  on public.examples for delete
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = auth.uid()
      and d.is_official = false
  ));

-- ─────────── word_progress ───────────
drop policy if exists "progress_own"          on public.word_progress;
drop policy if exists "progress_select_own"   on public.word_progress;
drop policy if exists "progress_insert_own"   on public.word_progress;
drop policy if exists "progress_update_own"   on public.word_progress;
drop policy if exists "progress_delete_own"   on public.word_progress;

create policy "progress_select_own"
  on public.word_progress for select using (user_id = auth.uid());

create policy "progress_insert_own"
  on public.word_progress for insert with check (user_id = auth.uid());

create policy "progress_update_own"
  on public.word_progress for update
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "progress_delete_own"
  on public.word_progress for delete using (user_id = auth.uid());

-- ─────────── 사용자별 덱 수 상한 (저장공간 DoS 방지) ───────────
-- 한 사용자가 무한히 커스텀 덱을 만들어 DB 를 부풀리는 것을 막는다.
-- (UI 에선 사용자가 보통 5~10 개 정도만 사용하므로 100 개면 충분히 여유.)
create or replace function public.assert_deck_count_under_limit()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  count_for_user int;
begin
  if (TG_OP = 'INSERT') and new.owner_id is not null then
    select count(*) into count_for_user
    from public.decks d
    where d.owner_id = new.owner_id
      and d.is_official = false;
    if count_for_user >= 100 then
      raise exception 'deck limit exceeded for user %', new.owner_id
        using errcode = 'check_violation';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists trg_decks_count_limit on public.decks;
create trigger trg_decks_count_limit
  before insert on public.decks
  for each row execute function public.assert_deck_count_under_limit();
