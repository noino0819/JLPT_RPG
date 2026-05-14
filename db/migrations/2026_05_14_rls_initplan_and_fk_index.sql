-- ============================================================
-- 성능 + 안정성: RLS auth.uid() 재평가 최적화 + FK 인덱스
-- ============================================================
-- 발견된 이슈 (Supabase advisor):
--   1) auth_rls_initplan: 정책마다 `auth.uid()` 가 row 단위로 재호출.
--      `(select auth.uid())` 로 감싸면 PostgreSQL initplan 으로 1회만 평가.
--      대량 INSERT/SELECT 에서 N배 차이.
--   2) unindexed_foreign_keys: word_progress.word_id FK 가 인덱스 부재.
--      카드 삭제 / cascade 시 풀스캔 발생 가능.
--
-- 적용:
--   Supabase SQL Editor 에서 한 번 실행 (멱등).
-- ============================================================

-- ===== profiles =====
drop policy if exists "profiles_select_own"   on public.profiles;
drop policy if exists "profiles_update_own"   on public.profiles;
drop policy if exists "profiles_insert_self"  on public.profiles;

create policy "profiles_select_own"
  on public.profiles for select using ((select auth.uid()) = id);
create policy "profiles_insert_self"
  on public.profiles for insert with check ((select auth.uid()) = id);
create policy "profiles_update_own"
  on public.profiles for update
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

-- ===== decks =====
drop policy if exists "decks_select"       on public.decks;
drop policy if exists "decks_insert_own"   on public.decks;
drop policy if exists "decks_update_own"   on public.decks;
drop policy if exists "decks_delete_own"   on public.decks;

create policy "decks_select"
  on public.decks for select
  using (is_official or owner_id = (select auth.uid()));
create policy "decks_insert_own"
  on public.decks for insert
  with check (owner_id = (select auth.uid()) and is_official = false);
create policy "decks_update_own"
  on public.decks for update
  using (owner_id = (select auth.uid()) and is_official = false)
  with check (owner_id = (select auth.uid()) and is_official = false);
create policy "decks_delete_own"
  on public.decks for delete
  using (owner_id = (select auth.uid()) and is_official = false);

-- ===== words =====
drop policy if exists "words_select"      on public.words;
drop policy if exists "words_insert_own"  on public.words;
drop policy if exists "words_update_own"  on public.words;
drop policy if exists "words_delete_own"  on public.words;

create policy "words_select"
  on public.words for select
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and (d.is_official or d.owner_id = (select auth.uid()))
  ));
create policy "words_insert_own"
  on public.words for insert
  with check (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));
create policy "words_update_own"
  on public.words for update
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ))
  with check (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));
create policy "words_delete_own"
  on public.words for delete
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));

-- ===== examples =====
drop policy if exists "examples_select"      on public.examples;
drop policy if exists "examples_insert_own"  on public.examples;
drop policy if exists "examples_update_own"  on public.examples;
drop policy if exists "examples_delete_own"  on public.examples;

create policy "examples_select"
  on public.examples for select
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and (d.is_official or d.owner_id = (select auth.uid()))
  ));
create policy "examples_insert_own"
  on public.examples for insert
  with check (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));
create policy "examples_update_own"
  on public.examples for update
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ))
  with check (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));
create policy "examples_delete_own"
  on public.examples for delete
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));

-- ===== word_progress =====
drop policy if exists "progress_select_own"  on public.word_progress;
drop policy if exists "progress_insert_own"  on public.word_progress;
drop policy if exists "progress_update_own"  on public.word_progress;
drop policy if exists "progress_delete_own"  on public.word_progress;

create policy "progress_select_own"
  on public.word_progress for select
  using (user_id = (select auth.uid()));
create policy "progress_insert_own"
  on public.word_progress for insert
  with check (user_id = (select auth.uid()));
create policy "progress_update_own"
  on public.word_progress for update
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
create policy "progress_delete_own"
  on public.word_progress for delete
  using (user_id = (select auth.uid()));

-- ===== FK 인덱스 보강 =====
create index if not exists progress_word_idx on public.word_progress(word_id);
