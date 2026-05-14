-- ============================================================
-- 칸지 던전 (JLPT RPG) — Supabase 스키마 + RLS + 공식 덱 5개
-- ============================================================
-- 적용 순서:
--   1) 이 파일 (db/schema.sql)             — 테이블·RLS·트리거·공식 덱 5개
--   2) db/n5_seed.sql  (N5 단어/예문 시드)
--   3) db/n4_seed.sql  (N4)
--   4) db/n3_seed.sql  (N3)
--   5) db/n2_seed.sql  (N2)
--      ※ N1 시드는 추후 추가 예정
-- 모두 멱등(여러 번 실행 가능)하며 각각 별도 SQL Editor 탭에서 실행하면 됩니다.
-- Postgres 15+ (Supabase 기본) 가정
-- ============================================================


-- ─────────── 1. profiles ───────────
-- auth.users 에 1:1 로 붙는 프로필
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text,
  selected_character text not null default 'warrior'
    check (selected_character in ('warrior','mage','archer','summoner')),
  settings jsonb not null default '{
    "order": "random",
    "exclude_memorized": true,
    "probably_repeat_every": 8,
    "review_mix_weight": 3,
    "effects": {"attack": true, "card_shake": true, "sound": false}
  }'::jsonb,
  -- 꾸밈 시스템: 캐릭터별 코스튬 + 펫/칭호/뱃지/프레임 장착 정보
  -- 해금 목록은 word_progress 에서 derive 하므로 별도 저장하지 않음.
  equipped jsonb not null default '{
    "costume": {
      "warrior": "warrior_default",
      "mage": "mage_default",
      "archer": "archer_default",
      "summoner": "summoner_default"
    },
    "pet": null,
    "title": null,
    "badges": [],
    "frame": "frame_default"
  }'::jsonb,
  created_at timestamptz not null default now()
);

-- 기존 배포 환경을 위한 멱등 마이그레이션 (없으면 컬럼 추가)
alter table public.profiles
  add column if not exists equipped jsonb not null default '{
    "costume": {
      "warrior": "warrior_default",
      "mage": "mage_default",
      "archer": "archer_default",
      "summoner": "summoner_default"
    },
    "pet": null,
    "title": null,
    "badges": [],
    "frame": "frame_default"
  }'::jsonb;

-- auth.users 생성 시 profiles 자동 삽입 (이메일·OAuth 모두 적용)
-- 트리거 전용 함수이므로 anon/authenticated 의 RPC 노출은 차단한다.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, nickname)
  values (
    new.id,
    coalesce(
      new.raw_user_meta_data->>'nickname',
      new.raw_user_meta_data->>'name',
      split_part(new.email, '@', 1)
    )
  );
  return new;
end;
$$;

revoke all on function public.handle_new_user() from anon, authenticated, public;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();


-- ─────────── 2. decks ───────────
-- 공식 JLPT 덱(owner_id null) + 유저 커스텀 덱
create table public.decks (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid references public.profiles(id) on delete cascade,
  name text not null,
  jlpt_level text not null check (jlpt_level in ('N5','N4','N3','N2','N1','custom')),
  is_official boolean not null default false,
  is_public boolean not null default false,
  description text,
  created_at timestamptz not null default now()
);

create index decks_owner_idx on public.decks(owner_id);
create index decks_level_idx on public.decks(jlpt_level);


-- ─────────── 3. words ───────────
create table public.words (
  id uuid primary key default gen_random_uuid(),
  deck_id uuid not null references public.decks(id) on delete cascade,
  headword text,                       -- null 허용: 히라가나-only 단어
  reading text not null,            -- 히라가나/카타카나
  meaning text not null,            -- 한국어 뜻
  etymology text,                   -- 한자 어원 / 분리 설명
  part_of_speech text,              -- 명사/동사/형용사…
  order_index int not null default 0,
  tags text[] not null default array[]::text[],
  created_at timestamptz not null default now()
);

create index words_deck_idx on public.words(deck_id);
create index words_deck_order_idx on public.words(deck_id, order_index);


-- ─────────── 4. examples ───────────
create table public.examples (
  id uuid primary key default gen_random_uuid(),
  word_id uuid not null references public.words(id) on delete cascade,
  jp_sentence text not null,
  kr_translation text not null,
  furigana text,                    -- 선택 (후리가나 표시용)
  order_index int not null default 0
);

create index examples_word_idx on public.examples(word_id);


-- ─────────── 5. word_progress ───────────
-- 유저별 × 단어별 학습 상태
create table public.word_progress (
  user_id uuid not null references public.profiles(id) on delete cascade,
  word_id uuid not null references public.words(id) on delete cascade,
  mastery text not null default 'none'
    check (mastery in ('none','probably','mastered')),
  flagged boolean not null default false,    -- "다시 보기"
  last_seen_at timestamptz,
  mastered_at timestamptz,
  primary key (user_id, word_id)
);

create index progress_mastery_idx on public.word_progress(user_id, mastery);
create index progress_flagged_idx on public.word_progress(user_id) where flagged;
-- FK 보강 (cascade 삭제 / words → word_progress JOIN 가속용)
create index progress_word_idx on public.word_progress(word_id);


-- ─────────── 6. 던전별 통계 뷰 ───────────
-- "N3 던전에서 47마리 처치" 같은 헤더 표시에 사용
-- security_invoker=on 으로 호출자의 RLS 적용 → 본인 통계만 보임
create view public.user_dungeon_stats
with (security_invoker = on) as
select
  wp.user_id,
  d.jlpt_level,
  count(*) filter (where wp.mastery = 'mastered')  as mastered_count,
  count(*) filter (where wp.mastery = 'probably')  as probably_count,
  count(*) filter (where wp.flagged)               as flagged_count,
  count(*)                                          as total_seen
from public.word_progress wp
join public.words w on w.id = wp.word_id
join public.decks d on d.id = w.deck_id
group by wp.user_id, d.jlpt_level;


-- ============================================================
-- RLS (Row Level Security)
-- ============================================================

alter table public.profiles       enable row level security;
alter table public.decks          enable row level security;
alter table public.words          enable row level security;
alter table public.examples       enable row level security;
alter table public.word_progress  enable row level security;

-- ──────────────────────────────────────────────────────────────
-- 정책 작성 규칙
-- ──────────────────────────────────────────────────────────────
-- 1) auth.uid() 는 `(select auth.uid())` 로 감싼다. PostgREST 가 row 마다
--    재호출하는 것을 막아 대량 쿼리에서 성능이 N배 좋아진다 (PG initplan).
-- 2) INSERT/UPDATE 는 WITH CHECK 까지 명시한다. USING 만 있으면 UPDATE 시
--    owner_id / is_official / deck_id 를 변조해 권한을 우회할 수 있다.
-- 3) FOR ALL 대신 select/insert/update/delete 4 개를 분리한다 (advisor 권장).
--
-- profiles: 본인 것만
-- ──────────────────────────────────────────────────────────────
create policy "profiles_select_own"
  on public.profiles for select using ((select auth.uid()) = id);
create policy "profiles_insert_self"
  on public.profiles for insert with check ((select auth.uid()) = id);
create policy "profiles_update_own"
  on public.profiles for update
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

-- ──────────────────────────────────────────────────────────────
-- decks: 공식이거나 본인 것 read, 본인 것만 write (공식 덱 사칭 불가)
-- ──────────────────────────────────────────────────────────────
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

-- ──────────────────────────────────────────────────────────────
-- words: 접근 가능한 덱의 단어만 read, 본인 덱 단어만 write
-- ──────────────────────────────────────────────────────────────
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

-- ──────────────────────────────────────────────────────────────
-- examples: 단어와 동일 규칙
-- ──────────────────────────────────────────────────────────────
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

-- ──────────────────────────────────────────────────────────────
-- word_progress: 본인 것만
-- ──────────────────────────────────────────────────────────────
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


-- ============================================================
-- 공식 JLPT 덱 5개 시드 (멱등 — 이미 있으면 무시)
-- ============================================================
insert into public.decks (name, jlpt_level, is_official, description)
select * from (values
  ('JLPT N5'::text, 'N5'::text, true, '시작의 숲'::text),
  ('JLPT N4',       'N4',       true, '동굴'),
  ('JLPT N3',       'N3',       true, '고대 유적'),
  ('JLPT N2',       'N2',       true, '화산'),
  ('JLPT N1',       'N1',       true, '천공의 신전')
) as v(name, jlpt_level, is_official, description)
where not exists (
  select 1 from public.decks d
  where d.is_official and d.jlpt_level = v.jlpt_level
);
