-- ============================================================
-- 칸지 던전 (JLPT RPG 단어장) - Supabase 스키마
-- Supabase SQL Editor에 통째로 붙여넣고 한 번에 실행하세요
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
  created_at timestamptz not null default now()
);

-- auth.users 생성 시 profiles 자동 삽입 (이메일·OAuth 모두 적용)
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

-- profiles: 본인 것만
create policy "profiles_select_own"
  on public.profiles for select using (auth.uid() = id);
create policy "profiles_update_own"
  on public.profiles for update using (auth.uid() = id);

-- decks: 공식이거나 본인 것 read, 본인 것만 write (공식 덱 사칭 불가)
create policy "decks_select"
  on public.decks for select
  using (is_official or owner_id = auth.uid());
create policy "decks_insert_own"
  on public.decks for insert
  with check (owner_id = auth.uid() and is_official = false);
create policy "decks_update_own"
  on public.decks for update using (owner_id = auth.uid());
create policy "decks_delete_own"
  on public.decks for delete using (owner_id = auth.uid());

-- words: 접근 가능한 덱의 단어만 read, 본인 덱 단어만 write
create policy "words_select"
  on public.words for select
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id
      and (d.is_official or d.owner_id = auth.uid())
  ));
create policy "words_modify_own"
  on public.words for all
  using (exists (
    select 1 from public.decks d
    where d.id = deck_id and d.owner_id = auth.uid()
  ));

-- examples: 단어와 동일 규칙
create policy "examples_select"
  on public.examples for select
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and (d.is_official or d.owner_id = auth.uid())
  ));
create policy "examples_modify_own"
  on public.examples for all
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id and d.owner_id = auth.uid()
  ));

-- word_progress: 본인 것만
create policy "progress_own"
  on public.word_progress for all
  using (user_id = auth.uid());


-- ============================================================
-- 공식 JLPT 덱 5개 시드
-- ============================================================
insert into public.decks (name, jlpt_level, is_official, description) values
  ('JLPT N5', 'N5', true, '시작의 숲'),
  ('JLPT N4', 'N4', true, '동굴'),
  ('JLPT N3', 'N3', true, '고대 유적'),
  ('JLPT N2', 'N2', true, '화산'),
  ('JLPT N1', 'N1', true, '천공의 신전');


-- ============================================================
-- 샘플 단어 시드 (N3 덱) - 동작 확인용
-- 실제 단어 데이터는 별도로 INSERT 또는 CSV import 로 추가
-- ============================================================
do $$
declare
  n3_deck uuid;
  w_id    uuid;
begin
  select id into n3_deck
    from public.decks
    where jlpt_level = 'N3' and is_official
    limit 1;

  -- 1. 首都
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (n3_deck, '首都', 'しゅと', '수도',
    '首(머리 수): 몸의 으뜸인 머리 모양 → 중심
都(도읍 도): 많은 사람(者)이 모인 마을(邑)',
    '명사', 1)
  returning id into w_id;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w_id, '東京は日本の首都です。', '도쿄는 일본의 수도이다.');

  -- 2. 地球
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (n3_deck, '地球', 'ちきゅう', '지구',
    '地(땅 지): 흙(土)이 평평하게(也) 깔린 곳
球(공 구): 둥근 구슬(玉) 같은 모양',
    '명사', 2);

  -- 3. 息 (히라가나-only 케이스 데모)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (n3_deck, '息', 'いき', '숨',
    '自(코 자) + 心(마음 심): 코로 숨을 쉬며 마음을 안정시킴',
    '명사', 3);

  -- 4. 遅れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (n3_deck, '遅れる', 'おくれる', '늦다',
    '遅(늦을 지): 뿔이 난 짐승이 천천히 가는 모양 → 지체되다',
    '동사', 4);

  -- 5. 努力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (n3_deck, '努力', 'どりょく', '노력',
    '努(힘쓸 노): 종(奴)이 힘(力)을 다해 애쓰다
力(힘 력): 근육이나 쟁기의 모양',
    '명사', 5);
end $$;
