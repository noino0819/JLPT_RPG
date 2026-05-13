-- ============================================================
-- JLPT 공식 단어 시드 (N5 ~ N1)
-- ============================================================
-- 이 파일은 재실행 가능합니다. 실행하면 공식 덱에 속한 모든 단어를
-- 삭제(CASCADE 로 word_progress, examples 도 함께)한 뒤 새로 채웁니다.
-- 사용자가 직접 만든 커스텀 덱/단어는 영향받지 않습니다.
--
-- 사용법:
--   1) Supabase 대시보드 > SQL Editor
--   2) 이 파일 통째로 붙여넣고 Run
-- ============================================================

begin;

-- 공식 덱에 속한 단어를 모두 삭제 (FK CASCADE 로 examples, word_progress 동시 삭제)
delete from public.words
where deck_id in (select id from public.decks where is_official);

do $$
declare
  d_n5 uuid; d_n4 uuid; d_n3 uuid; d_n2 uuid; d_n1 uuid;
  w uuid;
begin
  select id into d_n5 from public.decks where jlpt_level='N5' and is_official limit 1;
  select id into d_n4 from public.decks where jlpt_level='N4' and is_official limit 1;
  select id into d_n3 from public.decks where jlpt_level='N3' and is_official limit 1;
  select id into d_n2 from public.decks where jlpt_level='N2' and is_official limit 1;
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- ───────── N5 (시작의 숲) ─────────
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '学生', 'がくせい', '학생', '명사', 1) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '私は学生です。', '저는 학생입니다.');

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '食べる', 'たべる', '먹다', '동사', 2) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '朝ごはんを食べる。', '아침밥을 먹다.');

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '大きい', 'おおきい', '크다', 'い형용사', 3);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '水', 'みず', '물', '명사', 4);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '行く', 'いく', '가다', '동사', 5) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '学校へ行く。', '학교에 가다.');

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '本', 'ほん', '책', '명사', 6);

  -- 히라가나-only 단어 (headword NULL)
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'ありがとう', '고맙다, 감사', '표현', 7);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, '今日', 'きょう', '오늘', '명사', 8);

  -- ───────── N4 (동굴) ─────────
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n4, '経験', 'けいけん', '경험',
    '経(지날 경): 실(糸)이 길게 이어진 경로
験(증험할 험): 말(馬)을 시험해 봄', '명사', 1);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n4, '間違える', 'まちがえる', '틀리다, 잘못 알다', '동사', 2);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n4, '簡単', 'かんたん', '간단함', 'な형용사', 3);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n4, '教える', 'おしえる', '가르치다', '동사', 4);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n4, '急ぐ', 'いそぐ', '서두르다', '동사', 5);

  -- ───────── N3 (고대 유적) ─────────
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n3, '首都', 'しゅと', '수도',
    '首(머리 수): 몸의 으뜸인 머리 모양 → 중심
都(도읍 도): 많은 사람(者)이 모인 마을(邑)', '명사', 1) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '東京は日本の首都です。', '도쿄는 일본의 수도이다.');

  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n3, '地球', 'ちきゅう', '지구',
    '地(땅 지): 흙(土)이 평평하게(也) 깔린 곳
球(공 구): 둥근 구슬(玉) 같은 모양', '명사', 2);

  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n3, '息', 'いき', '숨',
    '自(코 자) + 心(마음 심): 코로 숨을 쉬며 마음을 안정시킴', '명사', 3);

  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n3, '遅れる', 'おくれる', '늦다',
    '遅(늦을 지): 뿔이 난 짐승이 천천히 가는 모양 → 지체되다', '동사', 4) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '電車が遅れる。', '전철이 늦다.');

  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n3, '努力', 'どりょく', '노력',
    '努(힘쓸 노): 종(奴)이 힘(力)을 다해 애쓰다
力(힘 력): 근육이나 쟁기의 모양', '명사', 5);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n3, '解決', 'かいけつ', '해결', '명사', 6);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n3, '頑張る', 'がんばる', '분발하다, 힘내다', '동사', 7) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation)
  values (w, '最後まで頑張ります。', '끝까지 분발하겠습니다.');

  -- ───────── N2 (화산) ─────────
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n2, '影響', 'えいきょう', '영향', '명사', 1);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n2, '懐かしい', 'なつかしい', '그립다', 'い형용사', 2);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n2, '我慢', 'がまん', '참음, 인내', '명사', 3);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n2, '贅沢', 'ぜいたく', '사치', 'な형용사', 4);

  -- ───────── N1 (천공의 신전) ─────────
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n1, '曖昧', 'あいまい', '애매함', 'な형용사', 1);

  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n1, '踏襲', 'とうしゅう', '답습',
    '踏(밟을 답) + 襲(엄습할 습): 이전의 것을 그대로 따라 밟음', '명사', 2);

  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n1, '緻密', 'ちみつ', '치밀함', 'な형용사', 3);
end $$;

commit;
