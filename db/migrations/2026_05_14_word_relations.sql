-- ============================================================
-- word_relations 테이블 신설: 단어 간 유의/반의/관용 변형 관계
-- ============================================================
-- 도입 배경:
--   기존 N3/N5/N4 시드에서 유의 표현(≒)을 한 단어 row 에 통째로
--   meaning + etymology 필드에 압축해 넣었음. 이로 인해
--     1) etymology 가 「한자 어원」 본래 용도와 「유의 페어 설명」
--        두 가지로 혼용되어 의미가 모호.
--     2) 한 단어에 유의 표현이 여러 개일 때 표현 불가 (1:1 고정).
--     3) 페어의 양쪽 표현이 서로 다른 학습 단위인데도 한쪽만
--        단어로 등록되어 다른 쪽은 학습 대상이 못 됨.
--     4) UI 에서 한자 어원 / 유의 표현을 구분해 표시할 수 없음.
--
-- 새 구조:
--   - 페어의 양쪽 표현을 모두 `words` row 로 개별 등록 (자체 한자 어원
--     + 예문 2 개씩 보유).
--   - 표현 간 관계는 word_relations 테이블에서 1:N 으로 관리.
--   - relation_type 으로 유의 / 반의 / 관용 변형 / 문맥 페어 구분.
--   - explanation 에 「왜 이런 관계인지」 별도 설명 보존.
-- ============================================================

create table if not exists public.word_relations (
  id uuid primary key default gen_random_uuid(),
  word_id uuid not null references public.words(id) on delete cascade,
  related_word_id uuid not null references public.words(id) on delete cascade,
  relation_type text not null check (relation_type in (
    'synonym',        -- 유의 표현 (≒)
    'antonym',        -- 반의 표현 (↔)
    'idiom_variant',  -- 관용구의 변형
    'context_pair'    -- 문맥 페어 (예: 질문↔대답)
  )),
  explanation text,
  order_index int not null default 0,
  created_at timestamptz not null default now(),
  unique (word_id, related_word_id, relation_type),
  check (word_id <> related_word_id)
);

-- 양방향 조회 모두 빠르게
create index if not exists word_relations_word_idx
  on public.word_relations(word_id);
create index if not exists word_relations_related_idx
  on public.word_relations(related_word_id);
create index if not exists word_relations_type_idx
  on public.word_relations(relation_type);

-- RLS: words 와 동일 규칙 (접근 가능한 덱의 관계만 read, 본인 덱만 write)
alter table public.word_relations enable row level security;

drop policy if exists "word_relations_select" on public.word_relations;
drop policy if exists "word_relations_insert_own" on public.word_relations;
drop policy if exists "word_relations_update_own" on public.word_relations;
drop policy if exists "word_relations_delete_own" on public.word_relations;

create policy "word_relations_select"
  on public.word_relations for select
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and (d.is_official or d.owner_id = (select auth.uid()))
  ));

create policy "word_relations_insert_own"
  on public.word_relations for insert
  with check (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));

create policy "word_relations_update_own"
  on public.word_relations for update
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

create policy "word_relations_delete_own"
  on public.word_relations for delete
  using (exists (
    select 1 from public.words w
    join public.decks d on d.id = w.deck_id
    where w.id = word_id
      and d.owner_id = (select auth.uid())
      and d.is_official = false
  ));
