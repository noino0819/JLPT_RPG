-- ============================================================
-- 보안 강화: 사용자 텍스트 길이 / 포맷 CHECK 제약 추가
-- ============================================================
-- 목적:
--   RLS 가 권한 경계를 막아주지만, 권한 있는 사용자가 자기 덱에
--   매우 긴 텍스트(수십 KB)를 insert 하는 것은 막지 못한다.
--   DB 단에서 명시적 길이/포맷 CHECK 를 걸어 application-layer 우회를 차단.
--
-- 적용:
--   Supabase SQL Editor 에서 한 번 실행. 멱등(DO 블록) 처리.
--
-- 주의:
--   기존 row 가 제약을 위반하면 ALTER 가 실패한다.
--   본 시드는 모든 공식 단어가 제한 안에 들어오는 사이즈로 작성되어 있어
--   기본 적용 가능. 운영 데이터가 있다면 먼저 위반 여부를 SELECT 로 점검 후 실행.
-- ============================================================

-- Postgres 는 `ADD CONSTRAINT IF NOT EXISTS` 를 지원하지 않아
-- 정보 스키마를 확인 후 추가하는 헬퍼를 사용한다.
create or replace function pg_temp.add_check_if_missing(
  p_table text,
  p_name text,
  p_expr text
) returns void
language plpgsql
as $$
begin
  if not exists (
    select 1
    from pg_constraint c
    join pg_class t on t.oid = c.conrelid
    join pg_namespace n on n.oid = t.relnamespace
    where n.nspname = 'public'
      and t.relname = p_table
      and c.conname = p_name
  ) then
    execute format('alter table public.%I add constraint %I check (%s)',
                   p_table, p_name, p_expr);
  end if;
end;
$$;

-- ─────────── profiles ───────────
select pg_temp.add_check_if_missing(
  'profiles',
  'profiles_nickname_len_chk',
  'nickname is null or char_length(nickname) between 1 and 30'
);

-- ─────────── decks ───────────
select pg_temp.add_check_if_missing(
  'decks',
  'decks_name_len_chk',
  'char_length(name) between 1 and 50'
);
select pg_temp.add_check_if_missing(
  'decks',
  'decks_description_len_chk',
  'description is null or char_length(description) <= 200'
);

-- ─────────── words ───────────
select pg_temp.add_check_if_missing(
  'words',
  'words_headword_len_chk',
  'headword is null or char_length(headword) between 1 and 64'
);
select pg_temp.add_check_if_missing(
  'words',
  'words_reading_len_chk',
  'char_length(reading) between 1 and 128'
);
select pg_temp.add_check_if_missing(
  'words',
  'words_meaning_len_chk',
  'char_length(meaning) between 1 and 256'
);
select pg_temp.add_check_if_missing(
  'words',
  'words_etymology_len_chk',
  'etymology is null or char_length(etymology) <= 1000'
);
select pg_temp.add_check_if_missing(
  'words',
  'words_pos_len_chk',
  'part_of_speech is null or char_length(part_of_speech) <= 32'
);

-- ─────────── examples ───────────
select pg_temp.add_check_if_missing(
  'examples',
  'examples_jp_len_chk',
  'char_length(jp_sentence) between 1 and 500'
);
select pg_temp.add_check_if_missing(
  'examples',
  'examples_kr_len_chk',
  'char_length(kr_translation) between 1 and 500'
);
select pg_temp.add_check_if_missing(
  'examples',
  'examples_furigana_len_chk',
  'furigana is null or char_length(furigana) <= 1000'
);

-- ─────────── 덱당 단어 수 제한 (DoS 방지) ───────────
-- 단일 덱에 너무 많은 단어를 넣어 메모리/UI 를 망가뜨리는 것을
-- DB 단에서 1차 제한. 개인용 단어장 기준 10,000 개면 충분.
create or replace function public.assert_word_count_under_limit()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  count_in_deck int;
begin
  if (TG_OP = 'INSERT') then
    select count(*) into count_in_deck
    from public.words w
    where w.deck_id = new.deck_id;
    if count_in_deck >= 10000 then
      raise exception 'word limit exceeded for deck %', new.deck_id
        using errcode = 'check_violation';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists trg_words_count_limit on public.words;
create trigger trg_words_count_limit
  before insert on public.words
  for each row execute function public.assert_word_count_under_limit();
