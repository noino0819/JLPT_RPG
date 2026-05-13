-- ============================================================
-- JLPT N5 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N5-단어장)
-- ============================================================
-- 실행 시 기존 N5 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- ============================================================

delete from public.words
where deck_id in (
  select id from public.decks
  where is_official and jlpt_level = 'N5'
);

do $$
declare
  d_n5 uuid;
  w   uuid;
begin
  select id into d_n5
  from public.decks
  where is_official and jlpt_level = 'N5'
  limit 1;

  -- ───────── 한자 읽기 (1 ~ 82) ─────────

  -- 1. 会う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '会う', 'あう', '만나다',
    '会(만날 회): 人(사람 인)이 모이는 모양 → 사람들이 한곳에 모여 만남', '동사', 1) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で友だちに会う。', '역에서 친구를 만나다.', 1),
    (w, '昨日先生に会いました。', '어제 선생님을 만났습니다.', 2);

  -- 2. 赤い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '赤い', 'あかい', '빨갛다, 붉다',
    '赤(붉을 적): 大(큰 사람)이 火(불) 위에 있는 모양 → 불빛에 비친 붉은색', 'い형용사', 2) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤い花がさいた。', '빨간 꽃이 피었다.', 1),
    (w, '彼女は赤いかばんを買った。', '그녀는 빨간 가방을 샀다.', 2);

  -- 3. 朝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '朝', 'あさ', '아침',
    '朝(아침 조): 풀(艹) 사이로 해(日)가 떠오르는 모양 → 동틀 무렵', '명사', 3) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝ごはんを食べる。', '아침밥을 먹다.', 1),
    (w, '朝6時に起きる。', '아침 6시에 일어난다.', 2);

  -- 4. 後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '後', 'あと', '뒤, 나중',
    '後(뒤 후): 彳(걸음) + 幺(작음) + 夂(천천히) → 뒤늦게 천천히 따라감', '명사', 4) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べた後で散歩する。', '먹은 후에 산책한다.', 1),
    (w, '私の後ろに立ってください。', '제 뒤에 서 주세요.', 2);

  -- 5. 雨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '雨', 'あめ', '비',
    '雨(비 우): 하늘에서 물방울이 떨어지는 모양을 본뜬 글자', '명사', 5) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨がふっています。', '비가 내리고 있습니다.', 1),
    (w, '雨の日は家で本を読む。', '비 오는 날은 집에서 책을 읽는다.', 2);

  -- 6. 言う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '言う', 'いう', '말하다',
    '言(말씀 언): 입(口)에서 소리가 나가는 모양 → 말을 하다', '동사', 6) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度言ってください。', '한 번 더 말해 주세요.', 1),
    (w, '何と言いましたか。', '뭐라고 말했어요?', 2);

  -- 7. 入り口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '入り口', 'いりぐち', '입구',
    '入(들 입): 안으로 들어가는 모양\n口(입 구): 사람의 입 모양 → 들어가는 통로', '명사', 7) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入り口はあちらです。', '입구는 저쪽입니다.', 1),
    (w, '駅の入り口で待っています。', '역 입구에서 기다리고 있어요.', 2);

  -- 8. 上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '上', 'うえ', '위',
    '上(윗 상): 기준선 위에 점을 찍은 모양 → 위쪽', '명사', 8) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本はつくえの上にあります。', '책은 책상 위에 있습니다.', 1),
    (w, '山の上に雪がある。', '산 위에 눈이 있다.', 2);

  -- 9. 生まれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '生まれる', 'うまれる', '태어나다',
    '生(날 생): 풀이 흙(土)을 뚫고 자라나는 모양 → 새로운 생명이 태어남', '동사', 9) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は東京で生まれました。', '저는 도쿄에서 태어났습니다.', 1),
    (w, '弟は1月に生まれた。', '남동생은 1월에 태어났다.', 2);

  -- 10. 駅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '駅', 'えき', '역',
    '駅(역 역): 馬(말) + 尺(자) → 옛날 말을 갈아타던 정거장', '명사', 10) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩きます。', '역까지 걸어갑니다.', 1),
    (w, 'この駅で電車をおります。', '이 역에서 전철을 내립니다.', 2);

  -- 11. 大きい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大きい', 'おおきい', '크다',
    '大(큰 대): 사람이 두 팔과 다리를 벌리고 선 모양 → 크다', 'い형용사', 11) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きい犬がいる。', '큰 개가 있다.', 1),
    (w, 'この部屋は大きいです。', '이 방은 큽니다.', 2);

  -- 12. お金
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, 'お金', 'おかね', '돈',
    '金(쇠 금): 흙(土) 속의 광물 알갱이를 본뜬 모양 → 금속, 화폐', '명사', 12) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金がぜんぜんありません。', '돈이 전혀 없어요.', 1),
    (w, 'このかばんはお金をはらいました。', '이 가방은 돈을 지불했습니다.', 2);

  -- 13. 男の子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '男の子', 'おとこのこ', '남자아이',
    '男(사내 남): 田(밭) + 力(힘) → 밭에서 힘쓰는 사람\n子(아들 자): 어린아이의 모양', '명사', 13) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '男の子が三人います。', '남자아이가 세 명 있어요.', 1),
    (w, 'あの男の子は私の弟です。', '저 남자아이는 제 남동생입니다.', 2);

  -- 14. 女の子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '女の子', 'おんなのこ', '여자아이',
    '女(여자 녀): 무릎 꿇고 앉은 여인의 모양\n子(아들 자): 어린아이의 모양', '명사', 14) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい女の子がないている。', '작은 여자아이가 울고 있다.', 1),
    (w, 'クラスに女の子が十人います。', '반에 여자아이가 열 명 있어요.', 2);

  -- 15. 外国
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '外国', 'がいこく', '외국',
    '外(바깥 외): 夕(저녁) + 卜(점) → 점치러 밖에 나감 → 바깥\n国(나라 국): 囗(둘레) + 玉(보배) → 영토 안의 나라', '명사', 15) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外国へ行きたいです。', '외국에 가고 싶습니다.', 1),
    (w, '兄は外国ではたらいています。', '형은 외국에서 일하고 있어요.', 2);

  -- 16. 買う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '買う', 'かう', '사다, 구입하다',
    '買(살 매): 网(그물) + 貝(조개=돈) → 그물로 돈을 모아 물건을 사다', '동사', 16) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スーパーでくだものを買う。', '슈퍼에서 과일을 사다.', 1),
    (w, '新しいくつを買いました。', '새 신발을 샀어요.', 2);

  -- 17. 学校
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '学校', 'がっこう', '학교',
    '学(배울 학): 子(아이)가 지붕 아래에서 배움\n校(학교 교): 木(나무) + 交(엇갈림) → 나무가 엇갈린 울타리, 학사', '명사', 17) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日学校へ行きます。', '매일 학교에 갑니다.', 1),
    (w, '学校はうちのちかくにある。', '학교는 집 근처에 있다.', 2);

  -- 18. 火曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '火曜日', 'かようび', '화요일',
    '火(불 화): 타오르는 불꽃 모양\n曜(빛날 요): 日(해) + 翟(꿩 깃) → 빛나는 별\n日(날 일): 해의 모양', '명사', 18) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '火曜日にテストがあります。', '화요일에 시험이 있어요.', 1),
    (w, '火曜日は休みです。', '화요일은 쉬는 날입니다.', 2);

  -- 19. 川
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '川', 'かわ', '강, 냇물',
    '川(내 천): 물이 굽이쳐 흐르는 모양을 본뜬 글자', '명사', 19) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川で魚をつる。', '강에서 물고기를 낚다.', 1),
    (w, 'この川はとても長いです。', '이 강은 매우 깁니다.', 2);

  -- 20. 木
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '木', 'き', '나무',
    '木(나무 목): 가지와 뿌리가 뻗은 나무 모양', '명사', 20) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園に大きい木がある。', '공원에 큰 나무가 있다.', 1),
    (w, '木の上に鳥がいます。', '나무 위에 새가 있어요.', 2);

  -- 21. 聞く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '聞く', 'きく', '듣다',
    '聞(들을 문): 門(문) + 耳(귀) → 문 사이로 귀를 기울여 듣다', '동사', 21) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聞くのが好きです。', '음악 듣는 것을 좋아합니다.', 1),
    (w, '先生に聞いてください。', '선생님께 여쭤보세요.', 2);

  -- 22. 北
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '北', 'きた', '북(쪽)',
    '北(북녘 북): 두 사람이 서로 등을 진 모양 → 등을 돌린 방향=북쪽', '명사', 22) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '北の国はさむいです。', '북쪽 나라는 춥습니다.', 1),
    (w, '駅は北のほうにある。', '역은 북쪽에 있다.', 2);

  -- 23. 銀行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '銀行', 'ぎんこう', '은행',
    '銀(은 은): 金(쇠) + 艮(어긋날 간) → 빛나는 흰 금속\n行(다닐 행): 사거리의 모양 → 거래가 오가는 곳', '명사', 23) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行でお金をだす。', '은행에서 돈을 찾다.', 1),
    (w, '銀行は9時にあきます。', '은행은 9시에 엽니다.', 2);

  -- 24. 金曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '金曜日', 'きんようび', '금요일',
    '金(쇠 금): 흙 속의 금속 알갱이\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 24) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金曜日の夜、えいがを見ます。', '금요일 밤에 영화를 봅니다.', 1),
    (w, '金曜日にあいましょう。', '금요일에 만나요.', 2);

  -- 25. 国
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '国', 'くに', '나라',
    '国(나라 국): 囗(둘레=영토) + 玉(임금의 옥) → 다스리는 영토', '명사', 25) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お国はどちらですか。', '고향(나라)은 어디입니까?', 1),
    (w, '私の国は四つの島でできている。', '우리나라는 네 개의 섬으로 이루어져 있다.', 2);

  -- 26. 車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '車', 'くるま', '자동차',
    '車(수레 거/차): 수레의 바퀴와 축을 위에서 본 모양', '명사', 26) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車で会社へ行く。', '차로 회사에 간다.', 1),
    (w, '新しい車を買いました。', '새 차를 샀습니다.', 2);

  -- 27. 午後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '午後', 'ごご', '오후',
    '午(낮 오): 절구공이의 모양 → 정오\n後(뒤 후): 뒤늦게 따라감 → 정오 뒤=오후', '명사', 27) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '午後3時に会いましょう。', '오후 3시에 만납시다.', 1),
    (w, '午後はひまです。', '오후는 한가합니다.', 2);

  -- 28. 今月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '今月', 'こんげつ', '이번 달',
    '今(이제 금): 입을 벌려 무엇인가 머금은 모양 → 지금\n月(달 월): 초승달 모양', '명사', 28) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月はいそがしいです。', '이번 달은 바빠요.', 1),
    (w, '今月の20日にあいましょう。', '이번 달 20일에 만나요.', 2);

  -- 29. 魚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '魚', 'さかな', '생선, 물고기',
    '魚(물고기 어): 머리(⺈), 몸통(田), 꼬리(灬)를 가진 물고기 모양', '명사', 29) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '魚をやいて食べる。', '생선을 구워 먹는다.', 1),
    (w, '川に魚がたくさんいます。', '강에 물고기가 많이 있어요.', 2);

  -- 30. 四月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '四月', 'しがつ', '4월',
    '四(넉 사): 코로 숨이 갈라져 나오는 모양 → 넷\n月(달 월): 초승달 모양 → 달', '명사', 30) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '四月から学校がはじまる。', '4월부터 학교가 시작된다.', 1),
    (w, '四月はさくらがきれいです。', '4월은 벚꽃이 예쁩니다.', 2);

  -- 31. 下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '下', 'した', '아래, 밑',
    '下(아래 하): 기준선 아래에 점을 찍은 모양 → 아래쪽', '명사', 31) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '机の下に犬がいる。', '책상 아래에 개가 있다.', 1),
    (w, '木の下で休みました。', '나무 아래에서 쉬었습니다.', 2);

  -- 32. 七月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '七月', 'しちがつ', '7월',
    '七(일곱 칠): 가로획 + 세로획이 굽은 모양 → 일곱\n月(달 월): 초승달 모양', '명사', 32) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '七月はあついです。', '7월은 덥습니다.', 1),
    (w, '七月にうみへ行く。', '7월에 바다에 간다.', 2);

  -- 33. 七時
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '七時', 'しちじ', '7시',
    '七(일곱 칠): 일곱 → 시간을 셀 때 사용\n時(때 시): 日(해) + 寺(절) → 해의 움직임으로 측정한 시각', '명사', 33) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝七時に起きます。', '아침 7시에 일어납니다.', 1),
    (w, '七時に駅で会いましょう。', '7시에 역에서 만나요.', 2);

  -- 34. 白い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '白い', 'しろい', '희다, 하얗다',
    '白(흰 백): 햇빛이 비치는 모양 → 환하고 흰색', 'い형용사', 34) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '白いシャツをきている。', '하얀 셔츠를 입고 있다.', 1),
    (w, '雪はとても白い。', '눈은 아주 하얗다.', 2);

  -- 35. 千円
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '千円', 'せんえん', '1000엔',
    '千(일천 천): 사람(人)이 많이 모인 모양 → 천\n円(둥글 원): 둥근 동전 모양 → 일본 화폐 단위', '명사', 35) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは千円です。', '이것은 1000엔입니다.', 1),
    (w, '千円でかいものをした。', '1000엔으로 쇼핑을 했다.', 2);

  -- 36. 先生
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '先生', 'せんせい', '선생님',
    '先(먼저 선): 발(止)이 사람(儿) 위에 있는 모양 → 앞장섬\n生(날 생): 풀이 자라는 모양 → 살아있음 → 먼저 산 사람=선생', '명사', 36) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語の先生はやさしいです。', '일본어 선생님은 친절합니다.', 1),
    (w, '先生に質問しました。', '선생님께 질문했습니다.', 2);

  -- 37. 外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '外', 'そと', '밖',
    '外(바깥 외): 夕(저녁) + 卜(점) → 저녁 점은 집 밖에서 → 바깥', '명사', 37) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外でこどもがあそんでいる。', '밖에서 아이가 놀고 있다.', 1),
    (w, '外はさむいですよ。', '밖은 추워요.', 2);

  -- 38. 空
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '空', 'そら', '하늘',
    '空(빌 공/하늘): 穴(구멍) + 工(만들다) → 비어있는 큰 공간 → 하늘', '명사', 38) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空が青いですね。', '하늘이 파랗네요.', 1),
    (w, '空にとりがとんでいる。', '하늘에 새가 날고 있다.', 2);

  -- 39. 大学
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大学', 'だいがく', '대학',
    '大(큰 대): 사람이 팔다리를 벌린 모양\n学(배울 학): 子(아이)가 지붕 아래에서 배움 → 큰 배움터', '명사', 39) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学で日本語をべんきょうする。', '대학에서 일본어를 공부한다.', 1),
    (w, '兄は大学生です。', '형은 대학생입니다.', 2);

  -- 40. 高い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '高い', 'たかい', '비싸다, 높다, (키가) 크다',
    '高(높을 고): 누각이 높이 솟은 모양', 'い형용사', 40) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんは高いです。', '이 가방은 비싸요.', 1),
    (w, '兄は高い山にのぼった。', '형은 높은 산에 올랐다.', 2);

  -- 41. 出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '出す', 'だす', '내다, 제출하다',
    '出(날 출): 발이 동굴 밖으로 나가는 모양 → 밖으로 내다', '동사', 41) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'レポートを先生に出した。', '리포트를 선생님께 제출했다.', 1),
    (w, 'かばんから本を出してください。', '가방에서 책을 꺼내 주세요.', 2);

  -- 42. 食べる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '食べる', 'たべる', '먹다',
    '食(밥 식): 그릇에 쌀밥을 담아 뚜껑을 덮은 모양 → 음식', '동사', 42) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごを食べる。', '사과를 먹는다.', 1),
    (w, '昨日すしを食べました。', '어제 초밥을 먹었어요.', 2);

  -- 43. 小さい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '小さい', 'ちいさい', '(크기가) 작다',
    '小(작을 소): 작은 물건 세 개를 점으로 표현 → 작다', 'い형용사', 43) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい子どもがいる。', '작은 아이가 있다.', 1),
    (w, 'このシャツは小さいです。', '이 셔츠는 작아요.', 2);

  -- 44. 父
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '父', 'ちち', '아빠, 아버지',
    '父(아비 부): 손에 도구를 든 모양 → 가장이 일하는 모습', '명사', 44) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は会社員です。', '아버지는 회사원입니다.', 1),
    (w, '父といっしょに釣りに行った。', '아버지와 함께 낚시를 갔다.', 2);

  -- 45. 手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '手', 'て', '손',
    '手(손 수): 다섯 손가락을 펼친 손 모양', '명사', 45) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をあらってください。', '손을 씻어 주세요.', 1),
    (w, '右手をあげてください。', '오른손을 들어 주세요.', 2);

  -- 46. 手紙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '手紙', 'てがみ', '편지',
    '手(손 수): 손 모양\n紙(종이 지): 糸(실) + 氏(밑판) → 손으로 쓴 종이=편지', '명사', 46) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちに手紙を書く。', '친구에게 편지를 쓴다.', 1),
    (w, '母から手紙がきた。', '엄마로부터 편지가 왔다.', 2);

  -- 47. 出る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '出る', 'でる', '나가(오)다',
    '出(날 출): 발이 동굴 밖으로 나가는 모양 → 나가다', '동사', 47) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '7時に家を出ます。', '7시에 집을 나섭니다.', 1),
    (w, 'バスは10分後に出る。', '버스는 10분 후에 출발한다.', 2);

  -- 48. 天気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '天気', 'てんき', '날씨',
    '天(하늘 천): 사람(大) 위의 큰 하늘\n気(기운 기): 김이 피어오르는 모양 → 하늘의 상태', '명사', 48) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は天気がいいです。', '오늘은 날씨가 좋아요.', 1),
    (w, 'あしたの天気はあめです。', '내일 날씨는 비입니다.', 2);

  -- 49. 電気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '電気', 'でんき', '전기',
    '電(번개 전): 雨(비) + 申(번개 모양) → 번개\n気(기운 기): 김이 피어오르는 모양 → 번개의 기=전기', '명사', 49) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気をつけてください。', '불(전기)을 켜 주세요.', 1),
    (w, '部屋の電気が消えた。', '방의 불이 꺼졌다.', 2);

  -- 50. 電話
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '電話', 'でんわ', '전화',
    '電(번개 전): 번개의 모양\n話(말씀 화): 言(말) + 舌(혀) → 전기로 말을 전함=전화', '명사', 50) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母に電話します。', '어머니께 전화합니다.', 1),
    (w, 'あとで電話してください。', '나중에 전화해 주세요.', 2);

  -- 51. 十日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '十日', 'とおか', '10일',
    '十(열 십): 가로획 + 세로획 → 동서남북이 다 모인 수=열\n日(날 일): 해의 모양 → 날짜', '명사', 51) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月の十日に会いましょう。', '이번 달 10일에 만나요.', 1),
    (w, '十日かかりました。', '10일 걸렸습니다.', 2);

  -- 52. 友だち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '友だち', 'ともだち', '친구',
    '友(벗 우): 손(又) 두 개가 나란히 → 서로 손잡는 사이=벗', '명사', 52) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちと映画を見た。', '친구와 영화를 봤다.', 1),
    (w, '日本人の友だちができました。', '일본인 친구가 생겼습니다.', 2);

  -- 53. 土曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '土曜日', 'どようび', '토요일',
    '土(흙 토): 흙 위에 풀이 돋는 모양\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 53) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '土曜日にデパートへ行きます。', '토요일에 백화점에 갑니다.', 1),
    (w, '今週の土曜日はひまです。', '이번 주 토요일은 한가합니다.', 2);

  -- 54. 中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '中', 'なか', '안, 속',
    '中(가운데 중): 깃발의 가운데를 표시한 모양 → 가운데, 안', '명사', 54) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かばんの中に本があります。', '가방 안에 책이 있어요.', 1),
    (w, '部屋の中にはだれもいない。', '방 안에는 아무도 없다.', 2);

  -- 55. 長い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '長い', 'ながい', '길다',
    '長(길 장): 긴 머리카락이 흩날리는 노인의 모양 → 길다', 'い형용사', 55) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長い手紙を書いた。', '긴 편지를 썼다.', 1),
    (w, '彼女のかみはとても長いです。', '그녀의 머리카락은 매우 길어요.', 2);

  -- 56. 何人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '何人', 'なんにん', '몇 명',
    '何(어찌 하): 사람(亻)이 짐(可)을 진 모양 → 무엇\n人(사람 인): 두 다리로 선 사람의 모양', '명사', 56) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスは何人ですか。', '반은 몇 명입니까?', 1),
    (w, '家族は何人いますか。', '가족은 몇 명입니까?', 2);

  -- 57. 西
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '西', 'にし', '서(쪽)',
    '西(서녘 서): 새가 둥지에 깃든 모양 → 해가 지는 쪽=서쪽', '명사', 57) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '西の空が赤いです。', '서쪽 하늘이 붉습니다.', 1),
    (w, 'うちは駅の西にある。', '우리집은 역의 서쪽에 있다.', 2);

  -- 58. 飲む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '飲む', 'のむ', '마시다, 삼키다',
    '飲(마실 음): 食(음식) + 欠(입을 벌림) → 입을 벌려 마시다', '동사', 58) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水を飲みます。', '물을 마십니다.', 1),
    (w, 'コーヒーを飲みながら話す。', '커피를 마시면서 이야기한다.', 2);

  -- 59. 入る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '入る', 'はいる', '들어가(오)다',
    '入(들 입): 좁은 입구로 들어가는 모양', '동사', 59) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋に入ってください。', '방에 들어와 주세요.', 1),
    (w, 'おふろに入ります。', '목욕탕에 들어갑니다.', 2);

  -- 60. 花
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '花', 'はな', '꽃',
    '花(꽃 화): 艹(풀) + 化(변화) → 풀이 모양을 바꾸어 핀 것=꽃', '명사', 60) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花がたくさんさいています。', '꽃이 많이 피어 있습니다.', 1),
    (w, '母に花をあげた。', '엄마에게 꽃을 드렸다.', 2);

  -- 61. 母
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '母', 'はは', '엄마',
    '母(어미 모): 어머니가 아이에게 젖을 먹이는 모양', '명사', 61) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母は元気です。', '어머니는 건강합니다.', 1),
    (w, '母に電話した。', '어머니께 전화했다.', 2);

  -- 62. 半分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '半分', 'はんぶん', '반, 절반',
    '半(반 반): 八(나누다) + 牛(소) → 소를 둘로 나눔=반\n分(나눌 분): 八(나누다) + 刀(칼) → 칼로 나눔', '명사', 62) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごを半分にきる。', '사과를 반으로 자르다.', 1),
    (w, '半分だけ食べました。', '반만 먹었어요.', 2);

  -- 63. 左
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '左', 'ひだり', '왼쪽',
    '左(왼 좌): 왼손(ナ) + 工(도구) → 도구를 잡는 왼손 → 왼쪽', '명사', 63) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '左にまがってください。', '왼쪽으로 도세요.', 1),
    (w, '左の手で書く。', '왼손으로 쓴다.', 2);

  -- 64. 人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '人', 'ひと', '사람',
    '人(사람 인): 두 다리로 선 사람의 옆모양', '명사', 64) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの人はだれですか。', '저 사람은 누구입니까?', 1),
    (w, 'みちに人がたくさんいる。', '길에 사람이 많이 있다.', 2);

  -- 65. 古い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '古い', 'ふるい', '오래되다, 낡다',
    '古(옛 고): 十(많은) + 口(말) → 오랫동안 입에서 입으로 전해진 옛것', 'い형용사', 65) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは古い本です。', '이것은 오래된 책입니다.', 1),
    (w, '父の車はとても古い。', '아버지의 차는 매우 낡았다.', 2);

  -- 66. 本
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '本', 'ほん', '책',
    '本(근본 본): 木(나무)의 뿌리에 점(一)을 찍어 중요한 부분을 가리킴 → 책의 본', '명사', 66) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を読みます。', '책을 읽습니다.', 1),
    (w, '日本語の本を買った。', '일본어 책을 샀다.', 2);

  -- 67. 毎日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '毎日', 'まいにち', '매일',
    '毎(매양 매): 母(어머니)에서 변형 → 늘 같은\n日(날 일): 해의 모양 → 날마다', '명사', 67) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日学校へ行きます。', '매일 학교에 갑니다.', 1),
    (w, '毎日日本語をべんきょうする。', '매일 일본어를 공부한다.', 2);

  -- 68. 前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '前', 'まえ', '앞, 전',
    '前(앞 전): 발(止) + 배(舟) → 배가 앞으로 나아감 → 앞', '명사', 68) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅の前で待ってください。', '역 앞에서 기다려 주세요.', 1),
    (w, '食事の前に手をあらう。', '식사 전에 손을 씻는다.', 2);

  -- 69. 右
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '右', 'みぎ', '오른쪽',
    '右(오른 우): 오른손(ナ) + 口(입) → 음식을 먹는 손=오른쪽', '명사', 69) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '右にまがってください。', '오른쪽으로 도세요.', 1),
    (w, '右の手で書きます。', '오른손으로 씁니다.', 2);

  -- 70. 水
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '水', 'みず', '물',
    '水(물 수): 흐르는 물줄기와 물방울의 모양', '명사', 70) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水をのみます。', '물을 마십니다.', 1),
    (w, 'つめたい水がほしい。', '차가운 물이 마시고 싶다.', 2);

  -- 71. 店
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '店', 'みせ', '가게',
    '店(가게 점): 广(집) + 占(자리잡다) → 자리를 잡고 물건을 파는 집', '명사', 71) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの店はやすいです。', '저 가게는 쌉니다.', 1),
    (w, '駅のちかくに店がたくさんある。', '역 근처에 가게가 많이 있다.', 2);

  -- 72. 見せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '見せる', 'みせる', '보이다, 보여 주다',
    '見(볼 견): 目(눈) + 儿(사람) → 사람이 눈으로 봄', '동사', 72) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を見せてください。', '사진을 보여 주세요.', 1),
    (w, '友だちに本を見せた。', '친구에게 책을 보여 줬다.', 2);

  -- 73. 道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '道', 'みち', '길',
    '道(길 도): 辶(쉬엄쉬엄 갈 착) + 首(머리) → 사람이 머리를 들고 가는 길', '명사', 73) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道はせまいです。', '이 길은 좁습니다.', 1),
    (w, '道がわからない。', '길을 모르겠다.', 2);

  -- 74. 耳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '耳', 'みみ', '귀',
    '耳(귀 이): 사람의 귀 모양을 본뜬 글자', '명사', 74) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '耳がいたいです。', '귀가 아파요.', 1),
    (w, '犬の耳は大きい。', '개의 귀는 크다.', 2);

  -- 75. 見る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '見る', 'みる', '보다',
    '見(볼 견): 目(눈) + 儿(사람) → 사람이 눈으로 봄', '동사', 75) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビを見ます。', '텔레비전을 봅니다.', 1),
    (w, '昨日いい映画を見た。', '어제 좋은 영화를 봤다.', 2);

  -- 76. 木曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '木曜日', 'もくようび', '목요일',
    '木(나무 목): 나무 모양\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 76) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '木曜日にじゅぎょうがある。', '목요일에 수업이 있다.', 1),
    (w, '木曜日の夜あいましょう。', '목요일 밤에 만나요.', 2);

  -- 77. 安い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '安い', 'やすい', '(값이) 싸다',
    '安(편안할 안): 宀(집) + 女(여자) → 여자가 집에 있어 편안함, 값이 부담 없음', 'い형용사', 77) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店はやさいが安い。', '이 가게는 야채가 싸다.', 1),
    (w, '安いくつを買いました。', '싼 신발을 샀습니다.', 2);

  -- 78. 休む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '休む', 'やすむ', '쉬다',
    '休(쉴 휴): 亻(사람) + 木(나무) → 사람이 나무에 기대어 쉬는 모양', '동사', 78) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は会社を休む。', '오늘은 회사를 쉰다.', 1),
    (w, '少し休んでください。', '잠시 쉬세요.', 2);

  -- 79. 山
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '山', 'やま', '산',
    '山(뫼 산): 세 봉우리가 솟은 산의 모양', '명사', 79) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日曜日に山にのぼる。', '일요일에 산에 오른다.', 1),
    (w, '山がきれいですね。', '산이 예쁘네요.', 2);

  -- 80. 有名
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '有名', 'ゆうめい', '유명함',
    '有(있을 유): 손(ナ) + 月(고기) → 손에 들 고기가 있음=가짐\n名(이름 명): 夕(저녁) + 口(입) → 어두워 이름을 불러 알림', 'な형용사', 80) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店は有名です。', '이 가게는 유명해요.', 1),
    (w, '彼は有名な歌手だ。', '그는 유명한 가수다.', 2);

  -- 81. 読む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '読む', 'よむ', '읽다',
    '読(읽을 독): 言(말) + 売(팔다) → 말로 풀어 펼침=읽음', '동사', 81) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新聞を読みます。', '신문을 읽습니다.', 1),
    (w, 'まだその本を読んでいない。', '아직 그 책을 읽지 않았다.', 2);

  -- 82. 来週
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '来週', 'らいしゅう', '다음 주',
    '来(올 래): 보리이삭이 익은 모양 → 옴\n週(주일 주): 辶(가다) + 周(둘레) → 한 바퀴=일주일', '명사', 82) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来週テストがあります。', '다음 주에 시험이 있어요.', 1),
    (w, '来週京都へ行きます。', '다음 주에 교토에 갑니다.', 2);

  -- ───────── 한자 표기 (83 ~ 98) ─────────

  -- 83. 足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '足', 'あし', '발, 다리',
    '足(발 족): 무릎 아래의 다리 모양', '명사', 83) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '足がいたいです。', '발이 아파요.', 1),
    (w, '長く歩いて足がつかれた。', '오래 걸어서 다리가 피곤해졌다.', 2);

  -- 84. 新しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '新しい', 'あたらしい', '새롭다',
    '新(새 신): 立(설) + 木(나무) + 斤(도끼) → 도끼로 새로 베어낸 나무=새것', 'い형용사', 84) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいかばんを買った。', '새 가방을 샀다.', 1),
    (w, '新しい先生はやさしい。', '새 선생님은 친절하다.', 2);

  -- 85. 行く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '行く', 'いく', '가다',
    '行(다닐 행): 사거리의 모양 → 길을 다님', '동사', 85) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校へ行きます。', '학교에 갑니다.', 1),
    (w, 'バスで行きました。', '버스로 갔습니다.', 2);

  -- 86. 多い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '多い', 'おおい', '많다',
    '多(많을 다): 夕(저녁) 두 개를 겹친 모양 → 날이 거듭됨=많음', 'い형용사', 86) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この公園は人が多い。', '이 공원은 사람이 많다.', 1),
    (w, '今日はしごとが多いです。', '오늘은 일이 많아요.', 2);

  -- 87. 男
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '男', 'おとこ', '남자',
    '男(사내 남): 田(밭) + 力(힘) → 밭에서 힘쓰는 사람', '명사', 87) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの男の人はだれですか。', '저 남자는 누구입니까?', 1),
    (w, '男の声がきこえる。', '남자의 목소리가 들린다.', 2);

  -- 88. 会社
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '会社', 'かいしゃ', '회사',
    '会(만날 회): 사람들이 모이는 모양\n社(모일 사): 示(보일) + 土(흙) → 사람들이 모인 단체', '명사', 88) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は会社へ行きます。', '아버지는 회사에 갑니다.', 1),
    (w, '会社は東京にあります。', '회사는 도쿄에 있어요.', 2);

  -- 89. 書く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '書く', 'かく', '쓰다, 적다',
    '書(쓸 서): 聿(붓) + 曰(말함) → 붓으로 말을 적음', '동사', 89) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を書いてください。', '이름을 써 주세요.', 1),
    (w, 'ノートに漢字を書く。', '노트에 한자를 쓴다.', 2);

  -- 90. 来る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '来る', 'くる', '오다',
    '来(올 래): 익은 보리이삭이 늘어진 모양 → (수확물이) 옴', '동사', 90) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'バスがきました。', '버스가 왔습니다.', 1),
    (w, 'あした、うちに来てください。', '내일 우리집에 오세요.', 2);

  -- 91. 子ども
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '子ども', 'こども', '아이, 어린이',
    '子(아들 자): 어린아이의 모양 → 아이', '명사', 91) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもが公園であそんでいる。', '아이들이 공원에서 놀고 있다.', 1),
    (w, '子どもは三人います。', '아이는 세 명 있어요.', 2);

  -- 92. 今週
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '今週', 'こんしゅう', '이번 주',
    '今(이제 금): 머금은 모양 → 지금\n週(주일 주): 한 바퀴=일주일', '명사', 92) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今週はいそがしい。', '이번 주는 바쁘다.', 1),
    (w, '今週の土曜日にあいましょう。', '이번 주 토요일에 만나요.', 2);

  -- 93. 時間
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '時間', 'じかん', '시간',
    '時(때 시): 日(해) + 寺(절) → 해의 움직임으로 측정한 시각\n間(사이 간): 門(문) + 日(해) → 문틈으로 비치는 햇빛=사이', '명사', 93) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間がありません。', '시간이 없어요.', 1),
    (w, '一時間まちました。', '한 시간 기다렸어요.', 2);

  -- 94. 電車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '電車', 'でんしゃ', '전철',
    '電(번개 전): 雨(비) + 申(번개) → 번개=전기\n車(수레 차): 수레의 모양 → 전기로 가는 차=전철', '명사', 94) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車で会社へ行きます。', '전철로 회사에 갑니다.', 1),
    (w, '電車がおくれている。', '전철이 늦어지고 있다.', 2);

  -- 95. 名前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '名前', 'なまえ', '이름',
    '名(이름 명): 夕(저녁) + 口(입) → 어두워 이름을 불러 알림\n前(앞 전): 발(止) + 배(舟) → 앞', '명사', 95) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お名前は何ですか。', '이름이 무엇입니까?', 1),
    (w, 'ここに名前を書いてください。', '여기에 이름을 적어 주세요.', 2);

  -- 96. 東
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '東', 'ひがし', '동(쪽)',
    '東(동녘 동): 木(나무) 사이로 해(日)가 떠오르는 모양 → 해 뜨는 쪽', '명사', 96) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東の空が明るくなった。', '동쪽 하늘이 밝아졌다.', 1),
    (w, 'うちは駅の東にある。', '우리집은 역의 동쪽에 있다.', 2);

  -- 97. 南
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '南', 'みなみ', '남(쪽)',
    '南(남녘 남): 따뜻한 풀이 자라는 천막의 모양 → 햇볕이 따뜻한 남쪽', '명사', 97) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '南の国はあたたかいです。', '남쪽 나라는 따뜻합니다.', 1),
    (w, '南がわのまどがあかるい。', '남쪽 창이 밝다.', 2);

  -- 98. 六日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '六日', 'むいか', '6일',
    '六(여섯 륙): 돔처럼 생긴 집의 모양에서 차용 → 여섯\n日(날 일): 해 → 날짜', '명사', 98) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月の六日に会いましょう。', '이번 달 6일에 만나요.', 1),
    (w, '六日かかりました。', '6일 걸렸습니다.', 2);

  -- ───────── 문맥 규정 (99 ~ 248) ─────────

  -- 99. 明日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '明日', 'あした', '내일',
    '明(밝을 명): 日(해) + 月(달) → 밝음\n日(날 일): 해의 모양 → 다음 밝은 날=내일', '명사', 99) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日テストがあります。', '내일 시험이 있어요.', 1),
    (w, '明日は日曜日です。', '내일은 일요일입니다.', 2);

  -- 100. 遊ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '遊ぶ', 'あそぶ', '놀다',
    '遊(놀 유): 辶(가다) + 㫃(깃발) → 깃발을 휘날리며 다님=놀다', '동사', 100) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園で子どもたちが遊んでいる。', '공원에서 아이들이 놀고 있다.', 1),
    (w, '日曜日に友だちと遊びました。', '일요일에 친구와 놀았어요.', 2);

  -- 101. 暖かい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '暖かい', 'あたたかい', '따뜻하다',
    '暖(따뜻할 난): 日(해) + 爰(부드러움) → 햇빛이 부드럽게 비춤=따뜻함', 'い형용사', 101) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はあたたかいです。', '오늘은 따뜻해요.', 1),
    (w, '春はあたたかくなる。', '봄은 따뜻해진다.', 2);

  -- 102. 兄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '兄', 'あに', '오빠, 형',
    '兄(맏 형): 口(입) + 儿(사람) → 입으로 동생을 가르치는 사람=형', '명사', 102) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄は会社員です。', '형은 회사원입니다.', 1),
    (w, '兄と映画を見ました。', '형과 영화를 봤어요.', 2);

  -- 103. アパート
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'アパート', '아파트', '명사', 103) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅のちかくのアパートに住んでいる。', '역 근처 아파트에 살고 있다.', 1),
    (w, 'アパートは三階です。', '아파트는 3층이에요.', 2);

  -- 104. 一台
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '一台', 'いちだい', '한 대(자전거·차)',
    '一(한 일): 가로획 하나=하나\n台(대 대): 위에 올려놓는 받침대 → 차량의 단위', '명사', 104) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が一台あります。', '차가 한 대 있어요.', 1),
    (w, 'じてんしゃを一台買った。', '자전거를 한 대 샀다.', 2);

  -- 105. 一度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '一度', 'いちど', '한 번',
    '一(한 일): 하나\n度(법도 도/단위): 손으로 측정하는 횟수', '명사', 105) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度言ってください。', '한 번 더 말해 주세요.', 1),
    (w, '日本へ一度行きました。', '일본에 한 번 갔습니다.', 2);

  -- 106. 五つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '五つ', 'いつつ', '다섯, 다섯 개',
    '五(다섯 오): 위아래 가로획 사이에 X(엇갈림) → 다섯', '명사', 106) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごが五つあります。', '사과가 다섯 개 있어요.', 1),
    (w, 'むすめは五つになりました。', '딸은 다섯 살이 되었어요.', 2);

  -- 107. 犬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '犬', 'いぬ', '개',
    '犬(개 견): 옆모습의 개 모양', '명사', 107) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい犬をかっています。', '작은 개를 키우고 있어요.', 1),
    (w, '犬が公園を走っている。', '개가 공원을 달리고 있다.', 2);

  -- 108. 入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '入れる', 'いれる', '넣다',
    '入(들 입): 안으로 들어가는 모양 → 넣다', '동사', 108) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かばんに本を入れる。', '가방에 책을 넣는다.', 1),
    (w, 'コーヒーにさとうを入れた。', '커피에 설탕을 넣었다.', 2);

  -- 109. いろいろ
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'いろいろ', '여러 가지임', 'な형용사', 109) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いろいろなくにを見たい。', '여러 나라를 보고 싶다.', 1),
    (w, 'お店にいろいろなくだものがある。', '가게에 여러 가지 과일이 있다.', 2);

  -- 110. 薄い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '薄い', 'うすい', '얇다',
    '薄(엷을 박): 艹(풀) + 溥(얇다) → 풀잎처럼 얇음', 'い형용사', 110) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うすい本を読みました。', '얇은 책을 읽었어요.', 1),
    (w, 'このシャツはうすいです。', '이 셔츠는 얇아요.', 2);

  -- 111. 選ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '選ぶ', 'えらぶ', '고르다, 선택하다',
    '選(가릴 선): 辶(가다) + 巽(가지런히 함) → 길에서 가려 뽑음', '동사', 111) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '好きな色をえらんでください。', '좋아하는 색을 골라 주세요.', 1),
    (w, '本を一さつえらんだ。', '책을 한 권 골랐다.', 2);

  -- 112. 危ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '危ない', 'あぶない', '위험하다',
    '危(위태할 위): 사람이 벼랑 끝에 선 모양 → 위태로움', 'い형용사', 112) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あぶないからちかづかないで。', '위험하니까 가까이 오지 마세요.', 1),
    (w, 'ここはあぶないみちです。', '여기는 위험한 길이에요.', 2);

  -- 113. 甘い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '甘い', 'あまい', '달다',
    '甘(달 감): 입(口) 안에 단 음식이 있는 모양 → 달다', 'い형용사', 113) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキはあまいです。', '이 케이크는 달아요.', 1),
    (w, 'あまい飲みものが好きです。', '단 음료를 좋아해요.', 2);

  -- 114. 洗う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '洗う', 'あらう', '씻다',
    '洗(씻을 세): 氵(물) + 先(먼저) → 물에 발을 먼저 씻음', '동사', 114) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をよくあらってください。', '손을 잘 씻어 주세요.', 1),
    (w, 'ようふくをあらった。', '옷을 빨았다.', 2);

  -- 115. 歩く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '歩く', 'あるく', '걷다',
    '歩(걸음 보): 발(止) 두 개를 위아래로 → 걷다', '동사', 115) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩いて行く。', '역까지 걸어간다.', 1),
    (w, '公園を一時間あるいた。', '공원을 한 시간 걸었다.', 2);

  -- 116. いくら
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'いくら', '얼마(값)', '명사·부사', 116) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これはいくらですか。', '이것은 얼마예요?', 1),
    (w, 'いくら高くても買います。', '아무리 비싸도 사겠어요.', 2);

  -- 117. 忙しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '忙しい', 'いそがしい', '바쁘다',
    '忙(바쁠 망): 忄(마음) + 亡(없을 망) → 마음의 여유가 없음=바쁨', 'い형용사', 117) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はとてもいそがしいです。', '오늘은 매우 바빠요.', 1),
    (w, 'しごとがいそがしくて休めない。', '일이 바빠서 쉴 수 없다.', 2);

  -- 118. 痛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '痛い', 'いたい', '아프다',
    '痛(아플 통): 疒(병) + 甬(통할 통) → 몸을 통과하는 아픔', 'い형용사', 118) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がいたいです。', '머리가 아파요.', 1),
    (w, '足がいたくて歩けない。', '발이 아파서 걸을 수 없다.', 2);

  -- 119. エレベーター
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'エレベーター', '엘리베이터', '명사', 119) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'エレベーターで五階まで行く。', '엘리베이터로 5층까지 간다.', 1),
    (w, 'エレベーターはあちらです。', '엘리베이터는 저쪽입니다.', 2);

  -- 120. おいしい
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'おいしい', '맛있다', 'い형용사', 120) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキはとてもおいしいです。', '이 케이크는 정말 맛있어요.', 1),
    (w, '母のりょうりはおいしい。', '어머니의 요리는 맛있다.', 2);

  -- 121. 大勢
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大勢', 'おおぜい', '많이(사람)',
    '大(큰 대): 큰\n勢(기세 세): 執(잡을) + 力(힘) → 사람이 많이 모여 만드는 기세', '명사', 121) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅に人が大勢いる。', '역에 사람이 많이 있다.', 1),
    (w, '大勢の前で話すのはきんちょうする。', '많은 사람 앞에서 말하는 건 긴장된다.', 2);

  -- 122. 起きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '起きる', 'おきる', '일어나다',
    '起(일어날 기): 走(달릴 주) + 己(자기) → 자기가 일어나 달림', '동사', 122) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝六時に起きます。', '매일 아침 6시에 일어납니다.', 1),
    (w, '今日は早く起きました。', '오늘은 일찍 일어났어요.', 2);

  -- 123. 置く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '置く', 'おく', '놓다, 두다',
    '置(둘 치): 罒(그물) + 直(곧을) → 그물을 곧게 놓음', '동사', 123) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つくえの上に本を置いた。', '책상 위에 책을 놓았다.', 1),
    (w, 'かばんはここに置いてください。', '가방은 여기에 두세요.', 2);

  -- 124. おじさん
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'おじさん', '아저씨, 삼촌', '명사', 124) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おじさんは医者です。', '삼촌은 의사예요.', 1),
    (w, 'あのおじさんはやさしいです。', '저 아저씨는 친절해요.', 2);

  -- 125. 押す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '押す', 'おす', '누르다, 밀다',
    '押(누를 압): 扌(손) + 甲(껍질) → 손으로 단단한 것을 누름', '동사', 125) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このボタンを押してください。', '이 버튼을 눌러 주세요.', 1),
    (w, 'ドアを押して入ります。', '문을 밀고 들어갑니다.', 2);

  -- 126. 角
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '角', 'かど', '모퉁이',
    '角(뿔 각): 동물의 뿔 모양 → 길이 꺾이는 모서리', '명사', 126) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つぎの角を右にまがってください。', '다음 모퉁이에서 오른쪽으로 도세요.', 1),
    (w, '角に小さい店がある。', '모퉁이에 작은 가게가 있다.', 2);

  -- 127. かぶる
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'かぶる', '(모자를) 쓰다', '동사', 127) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼうしをかぶってください。', '모자를 써 주세요.', 1),
    (w, 'あついから帽子をかぶった。', '더우니까 모자를 썼다.', 2);

  -- 128. 辛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '辛い', 'からい', '맵다',
    '辛(매울 신): 죄인을 새기는 칼 모양 → 자극적이고 매움', 'い형용사', 128) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このカレーはからいです。', '이 카레는 매워요.', 1),
    (w, 'からい食べものが好きです。', '매운 음식을 좋아해요.', 2);

  -- 129. ギター
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'ギター', '기타(악기)', '명사', 129) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ギターを少しひけます。', '기타를 조금 칠 수 있어요.', 1),
    (w, '兄はギターがじょうずです。', '형은 기타를 잘 쳐요.', 2);

  -- 130. 汚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '汚い', 'きたない', '더럽다, 지저분하다',
    '汚(더러울 오): 氵(물) + 亏(굽음) → 흐린 물이 고임=더러움', 'い형용사', 130) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋がきたないです。', '방이 더러워요.', 1),
    (w, 'きたない手であめを食べないで。', '더러운 손으로 사탕을 먹지 마.', 2);

  -- 131. 切手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '切手', 'きって', '우표',
    '切(끊을 절): 七(자르다) + 刀(칼) → 잘라냄\n手(손 수): 손 → 손으로 잘라 붙이는 작은 종이=우표', '명사', 131) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手紙にきってをはった。', '편지에 우표를 붙였다.', 1),
    (w, 'ゆうびんきょくできってを買う。', '우체국에서 우표를 산다.', 2);

  -- 132. 切符
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '切符', 'きっぷ', '표, 티켓',
    '切(끊을 절): 잘라냄\n符(부호 부): 竹(대나무) + 付(붙이다) → 자른 표=티켓', '명사', 132) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車のきっぷを買った。', '전철 표를 샀다.', 1),
    (w, 'きっぷはどこで買いますか。', '표는 어디서 사요?', 2);

  -- 133. 切る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '切る', 'きる', '자르다',
    '切(끊을 절): 七(자르는 모양) + 刀(칼) → 칼로 자르다', '동사', 133) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ナイフでパンを切る。', '칼로 빵을 자른다.', 1),
    (w, 'かみを短く切りました。', '머리를 짧게 잘랐어요.', 2);

  -- 134. 暗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '暗い', 'くらい', '어둡다',
    '暗(어두울 암): 日(해) + 音(소리) → 해가 가려져 어두움', 'い형용사', 134) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋がくらいです。', '방이 어두워요.', 1),
    (w, 'よるはみちがくらい。', '밤은 길이 어둡다.', 2);

  -- 135. おととし
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'おととし', '재작년', '명사', 135) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おととし日本へ行きました。', '재작년에 일본에 갔어요.', 1),
    (w, 'おととしから日本語を勉強している。', '재작년부터 일본어를 공부하고 있다.', 2);

  -- 136. 大人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大人', 'おとな', '어른',
    '大(큰 대): 큰\n人(사람 인): 사람 → 큰 사람=어른', '명사', 136) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おとなのきっぷを二まいください。', '어른 표 두 장 주세요.', 1),
    (w, 'もう、おとなになりました。', '이제 어른이 되었어요.', 2);

  -- 137. 覚える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '覚える', 'おぼえる', '기억하다, 암기하다',
    '覚(깨달을 각): 学(배움) + 見(봄) → 배워서 알게 됨', '동사', 137) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前をおぼえました。', '이름을 외웠어요.', 1),
    (w, '漢字をたくさんおぼえる。', '한자를 많이 암기한다.', 2);

  -- 138. 重い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '重い', 'おもい', '무겁다',
    '重(무거울 중): 사람이 짐을 등에 진 모양 → 무거움', 'い형용사', 138) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんはおもいです。', '이 가방은 무거워요.', 1),
    (w, '本がおもくて持てない。', '책이 무거워서 들 수 없다.', 2);

  -- 139. 面白い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '面白い', 'おもしろい', '재미있다',
    '面(낯 면): 얼굴의 윤곽\n白(흰 백): 환함 → 얼굴이 환해질 만큼 재미있음', 'い형용사', 139) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本はおもしろいです。', '이 책은 재미있어요.', 1),
    (w, '昨日のえいがはおもしろかった。', '어제 영화는 재미있었다.', 2);

  -- 140. 泳ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '泳ぐ', 'およぐ', '헤엄치다',
    '泳(헤엄칠 영): 氵(물) + 永(길게 흐름) → 물에서 길게 헤엄침', '동사', 140) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うみでおよぎたい。', '바다에서 수영하고 싶다.', 1),
    (w, 'プールで毎日およぎます。', '수영장에서 매일 헤엄칩니다.', 2);

  -- 141. 降りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '降りる', 'おりる', '내리다',
    '降(내릴 강): 阝(언덕) + 夅(내려옴) → 언덕에서 내려옴', '동사', 141) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つぎの駅でおります。', '다음 역에서 내려요.', 1),
    (w, 'バスからおりた。', '버스에서 내렸다.', 2);

  -- 142. 返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '返す', 'かえす', '되돌려주다',
    '返(돌아올 반): 辶(가다) + 反(반대) → 반대로 돌려보냄', '동사', 142) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を図書館にかえした。', '책을 도서관에 돌려줬다.', 1),
    (w, 'あした、お金をかえします。', '내일 돈을 돌려드릴게요.', 2);

  -- 143. かかる
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'かかる', '(시간·비용이) 들다, 걸리다', '동사', 143) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで十分かかります。', '역까지 10분 걸려요.', 1),
    (w, '修理にお金がかかった。', '수리에 돈이 들었다.', 2);

  -- 144. かける
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'かける', '(안경을) 쓰다, 걸다', '동사', 144) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めがねをかけてください。', '안경을 써 주세요.', 1),
    (w, '電話をかけました。', '전화를 걸었어요.', 2);

  -- 145. 風邪
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '風邪', 'かぜ', '감기',
    '風(바람 풍): 안에 벌레가 생긴 바람 → 사기\n邪(간사할 사): 사악함 → 나쁜 바람을 맞아 든 병=감기', '명사', 145) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぜをひきました。', '감기에 걸렸어요.', 1),
    (w, 'かぜでがっこうを休んだ。', '감기로 학교를 쉬었다.', 2);

  -- 146. 家族
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '家族', 'かぞく', '가족',
    '家(집 가): 宀(집) + 豕(돼지) → 가축이 있는 집\n族(겨레 족): 㫃(깃발) + 矢(화살) → 같은 깃발 아래 모인 무리', '명사', 146) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぞくは四人です。', '가족은 4명이에요.', 1),
    (w, 'かぞくとりょこうに行きました。', '가족과 여행을 갔어요.', 2);

  -- 147. 消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '消す', 'けす', '(불·전기를) 끄다',
    '消(꺼질 소): 氵(물) + 肖(작아짐) → 물로 작아져 사라짐', '동사', 147) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気をけしてください。', '불을 꺼 주세요.', 1),
    (w, 'テレビをけして勉強する。', '텔레비전을 끄고 공부한다.', 2);

  -- 148. 結構
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '結構', 'けっこう', '충분함, 이제 됐음',
    '結(맺을 결): 糸(실) + 吉(좋음) → 실로 좋게 묶음\n構(얽을 구): 木(나무) + 冓(엮다) → 잘 짜여 충분함', 'な형용사·부사', 148) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もうけっこうです。', '이제 됐습니다.', 1),
    (w, 'けっこうおいしいですね。', '꽤 맛있네요.', 2);

  -- 149. 結婚する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '結婚する', 'けっこんする', '결혼하다',
    '結(맺을 결): 糸(실)을 묶음\n婚(혼인할 혼): 女(여자) + 昏(저녁) → 저녁에 맞는 여자=혼인', '동사', 149) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄は来年けっこんします。', '형은 내년에 결혼해요.', 1),
    (w, 'けっこんして十年になる。', '결혼한 지 10년이 된다.', 2);

  -- 150. 元気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '元気', 'げんき', '건강함',
    '元(으뜸 원): 사람의 머리=근원\n気(기운 기): 김이 피어오름 → 근원의 기운=건강', 'な형용사', 150) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おげんきですか。', '잘 지내세요?', 1),
    (w, '父はとても元気です。', '아버지는 매우 건강해요.', 2);

  -- 151. 公園
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '公園', 'こうえん', '공원',
    '公(공평할 공): 八(나누다) + 厶(사사로움) → 사사로움이 없이 공평\n園(동산 원): 囗(둘레) + 袁(긴 옷) → 울타리 안의 정원', '명사', 151) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園であそびます。', '공원에서 놉니다.', 1),
    (w, '公園のちかくに住んでいる。', '공원 근처에 살고 있다.', 2);

  -- 152. 紅茶
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '紅茶', 'こうちゃ', '홍차',
    '紅(붉을 홍): 糸(실) + 工(만들다) → 붉게 물들인 실=붉음\n茶(차 차): 艹(풀) + 余(나머지) → 차 잎으로 만든 음료', '명사', 152) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうちゃをのみます。', '홍차를 마십니다.', 1),
    (w, '朝はいつもこうちゃを飲む。', '아침에는 항상 홍차를 마신다.', 2);

  -- 153. ごちそうさま
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'ごちそうさま', '잘 먹었습니다', '표현', 153) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ごちそうさまでした。', '잘 먹었습니다.', 1),
    (w, 'おいしかった、ごちそうさま。', '맛있었어요, 잘 먹었어요.', 2);

  -- 154. こちら
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'こちら', '이쪽, 이 분, 이 사람', '대명사', 154) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらへどうぞ。', '이쪽으로 오세요.', 1),
    (w, 'こちらは田中さんです。', '이분은 다나카 씨예요.', 2);

  -- 155. こちらこそ
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'こちらこそ', '저야말로', '표현', 155) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらこそ、ありがとうございます。', '저야말로 감사합니다.', 1),
    (w, 'こちらこそ、よろしくお願いします。', '저야말로 잘 부탁드립니다.', 2);

  -- 156. さす
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'さす', '(우산을) 쓰다, 받다', '동사', 156) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あめなのでかさをさす。', '비가 와서 우산을 쓴다.', 1),
    (w, 'かさをさして歩く。', '우산을 쓰고 걷다.', 2);

  -- 157. 三回
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '三回', 'さんかい', '3회, 세 번',
    '三(석 삼): 가로획 세 개 → 셋\n回(돌 회): 빙빙 도는 모양 → 횟수', '명사', 157) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一週間に三回うんどうします。', '일주일에 세 번 운동합니다.', 1),
    (w, 'もう三回読みました。', '벌써 세 번 읽었어요.', 2);

  -- 158. 三冊
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '三冊', 'さんさつ', '세 권(책)',
    '三(석 삼): 셋\n冊(책 책): 죽간을 끈으로 묶은 모양 → 책', '명사', 158) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を三冊買いました。', '책을 세 권 샀어요.', 1),
    (w, 'まんがを三冊読みました。', '만화를 세 권 읽었어요.', 2);

  -- 159. 辞書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '辞書', 'じしょ', '사전',
    '辞(말씀 사): 말의 풀이\n書(쓸 서): 붓으로 쓴 책 → 말을 풀이한 책=사전', '명사', 159) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'じしょで漢字をしらべる。', '사전으로 한자를 찾는다.', 1),
    (w, 'あたらしいじしょを買った。', '새 사전을 샀다.', 2);

  -- 160. 静かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '静かに', 'しずかに', '조용히',
    '静(고요할 정): 青(푸름) + 争(다툼) → 다툼 없이 고요함', '부사', 160) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しずかにしてください。', '조용히 해 주세요.', 1),
    (w, 'しずかにドアをしめた。', '조용히 문을 닫았다.', 2);

  -- 161. 質問する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '質問する', 'しつもんする', '질문하다',
    '質(바탕 질): 斤(도끼) + 貝(조개) → 본질을 물음\n問(물을 문): 門(문) + 口(입) → 문 밖에서 물음', '동사', 161) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にしつもんします。', '선생님께 질문합니다.', 1),
    (w, 'なにかしつもんはありますか。', '뭔가 질문 있어요?', 2);

  -- 162. 閉める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '閉める', 'しめる', '(문을) 닫다',
    '閉(닫을 폐): 門(문) + 才(빗장) → 문에 빗장을 걸어 닫음', '동사', 162) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まどをしめてください。', '창문을 닫아 주세요.', 1),
    (w, 'お店は10時にしまります。', '가게는 10시에 닫아요.', 2);

  -- 163. 写真
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '写真', 'しゃしん', '사진',
    '写(베낄 사): 그대로 옮김\n真(참 진): 본래 모습 → 본래 모습을 그대로 옮긴 것=사진', '명사', 163) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しゃしんをとります。', '사진을 찍어요.', 1),
    (w, '家族のしゃしんをみせてください。', '가족 사진을 보여 주세요.', 2);

  -- 164. 上手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '上手', 'じょうず', '능숙함, 잘함',
    '上(윗 상): 위, 더 좋음\n手(손 수): 손 → 손재주가 좋음=잘함', 'な형용사', 164) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語がじょうずですね。', '일본어를 잘하시네요.', 1),
    (w, 'あねは料理がじょうずです。', '언니는 요리를 잘해요.', 2);

  -- 165. 丈夫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '丈夫', 'じょうぶ', '튼튼함',
    '丈(어른 장): 키 큰 사람\n夫(지아비 부): 어른 남자 → 단단하고 튼튼함', 'な형용사', 165) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんはじょうぶです。', '이 가방은 튼튼해요.', 1),
    (w, '父はとてもじょうぶです。', '아버지는 매우 튼튼해요.', 2);

  -- 166. 吸う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '吸う', 'すう', '(담배를) 피우다, 들이마시다',
    '吸(마실 흡): 口(입) + 及(미침) → 입으로 안까지 빨아들임', '동사', 166) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タバコをすってはいけません。', '담배를 피우면 안 돼요.', 1),
    (w, '深く息をすってください。', '깊이 숨을 들이마셔 주세요.', 2);

  -- 167. スカート
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'スカート', '스커트, 치마', '명사', 167) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長いスカートをはく。', '긴 치마를 입다.', 1),
    (w, '赤いスカートを買った。', '빨간 치마를 샀다.', 2);

  -- 168. 好き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '好き', 'すき', '좋아함',
    '好(좋을 호): 女(여자) + 子(아이) → 여자가 아이를 안고 있음 → 좋음', 'な형용사', 168) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごが好きです。', '사과를 좋아해요.', 1),
    (w, '音楽が大好きです。', '음악을 정말 좋아해요.', 2);

  -- 169. スキー
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'スキー', '스키', '명사', 169) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふゆはスキーをします。', '겨울에는 스키를 탑니다.', 1),
    (w, 'スキーがじょうずです。', '스키를 잘 타요.', 2);

  -- 170. すぐに
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'すぐに', '곧, 바로', '부사', 170) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐに行きます。', '바로 갈게요.', 1),
    (w, 'すぐに返事をください。', '바로 답장해 주세요.', 2);

  -- 171. ストーブ
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'ストーブ', '스토브, 난로', '명사', 171) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふゆはストーブをつけます。', '겨울에는 난로를 켭니다.', 1),
    (w, 'ストーブのそばはあたたかい。', '난로 옆은 따뜻하다.', 2);

  -- 172. セーター
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'セーター', '스웨터', '명사', 172) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あついからセーターをぬいだ。', '더워서 스웨터를 벗었다.', 1),
    (w, '母が新しいセーターを買ってくれた。', '어머니가 새 스웨터를 사 주셨다.', 2);

  -- 173. そば
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'そば', '옆, 곁', '명사', 173) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅のそばに住んでいる。', '역 옆에 살고 있다.', 1),
    (w, '私のそばに来てください。', '제 옆에 와 주세요.', 2);

  -- 174. それでは
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'それでは', '그럼', '표현·접속사', 174) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それでは、はじめましょう。', '그럼 시작합시다.', 1),
    (w, 'それでは、また明日。', '그럼 또 내일 봐요.', 2);

  -- 175. 大丈夫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大丈夫', 'だいじょうぶ', '괜찮음',
    '大(큰 대): 큼\n丈(어른 장): 어른\n夫(지아비 부): 남자 → 큰 어른=든든하고 안전함', 'な형용사', 175) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だいじょうぶですか。', '괜찮아요?', 1),
    (w, 'もうだいじょうぶです。', '이제 괜찮아요.', 2);

  -- 176. 大切
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大切', 'たいせつ', '중요함, 소중함',
    '大(큰 대): 큰\n切(끊을 절): 절실함 → 매우 절실하고 중요함', 'な형용사', 176) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族はたいせつです。', '가족은 소중합니다.', 1),
    (w, '時間をたいせつにしてください。', '시간을 소중히 해 주세요.', 2);

  -- 177. 大抵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大抵', 'たいてい', '대체로, 대개',
    '大(큰 대): 큰\n抵(닿을 저): 大体의 의미 변형 → 대략적으로', '부사', 177) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たいてい朝六時に起きます。', '대개 아침 6시에 일어나요.', 1),
    (w, '土曜日はたいていうちにいる。', '토요일은 대개 집에 있다.', 2);

  -- 178. 大変
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '大変', 'たいへん', '힘듦, 큰일임',
    '大(큰 대): 큰\n変(변할 변): 큰 변고 → 매우 어려운 일', 'な형용사·부사', 178) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しごとがたいへんです。', '일이 힘들어요.', 1),
    (w, 'たいへんおいしいです。', '아주 맛있어요.', 2);

  -- 179. たくさん
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'たくさん', '많이', '부사·명사', 179) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たくさんの本があります。', '많은 책이 있어요.', 1),
    (w, 'たくさん食べてください。', '많이 드세요.', 2);

  -- 180. 楽しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '楽しい', 'たのしい', '즐겁다',
    '楽(즐거울 락): 木(나무) 위의 악기 모양 → 음악으로 즐거움', 'い형용사', 180) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パーティーはたのしかったです。', '파티는 즐거웠어요.', 1),
    (w, '友だちと話すのはたのしい。', '친구와 이야기하는 것은 즐겁다.', 2);

  -- 181. 多分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '多分', 'たぶん', '아마',
    '多(많을 다): 많음\n分(나눌 분): 부분 → 많은 부분에서 그러할 것=아마', '부사', 181) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たぶんあめがふります。', '아마 비가 올 거예요.', 1),
    (w, 'たぶん来ないとおもう。', '아마 안 올 것 같아.', 2);

  -- 182. だんだん
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'だんだん', '점점, 점차', '부사', 182) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だんだんさむくなってきた。', '점점 추워지고 있다.', 1),
    (w, '日本語がだんだんわかるようになった。', '일본어를 점점 알아듣게 되었다.', 2);

  -- 183. 近い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '近い', 'ちかい', '가깝다',
    '近(가까울 근): 辶(가다) + 斤(도끼) → 도끼가 닿는 거리=가까움', 'い형용사', 183) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅はちかいです。', '역은 가까워요.', 1),
    (w, 'うちは学校にちかい。', '집은 학교에 가깝다.', 2);

  -- 184. 違います
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '違います', 'ちがいます', '아닙니다, 틀립니다',
    '違(어긋날 위): 辶(가다) + 韋(에워쌈) → 길이 어긋남=다름', '동사', 184) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいえ、ちがいます。', '아니요, 아닙니다.', 1),
    (w, '答えがちがいました。', '답이 틀렸어요.', 2);

  -- 185. 地図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '地図', 'ちず', '지도',
    '地(땅 지): 흙(土)이 펼쳐진 곳\n図(그림 도): 그려서 나타냄 → 땅을 그린 그림=지도', '명사', 185) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちずを見ながらあるく。', '지도를 보며 걷는다.', 1),
    (w, 'これは東京のちずです。', '이것은 도쿄의 지도예요.', 2);

  -- 186. ちょうど
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'ちょうど', '정각, 정확히', '부사', 186) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちょうど三時です。', '정각 3시예요.', 1),
    (w, 'ちょうどいいおおきさです。', '딱 좋은 크기예요.', 2);

  -- 187. 疲れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '疲れる', 'つかれる', '피곤하다, 지치다',
    '疲(피로할 피): 疒(병) + 皮(가죽) → 몸이 약해져 지침', '동사', 187) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はつかれました。', '오늘은 피곤해요.', 1),
    (w, '長く歩いてつかれた。', '오래 걸어서 지쳤다.', 2);

  -- 188. 付く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '付く', 'つく', '(전기가) 켜지다, 붙다',
    '付(붙을 부): 亻(사람) + 寸(손) → 손으로 무엇을 붙임', '동사', 188) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気がつきました。', '불이 켜졌어요.', 1),
    (w, 'シャツによごれがついた。', '셔츠에 얼룩이 묻었다.', 2);

  -- 189. 冷たい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '冷たい', 'つめたい', '차갑다',
    '冷(찰 랭): 冫(얼음) + 令(명령) → 얼음처럼 차가움', 'い형용사', 189) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つめたい水をください。', '차가운 물 주세요.', 1),
    (w, '彼の手はつめたい。', '그의 손은 차갑다.', 2);

  -- 190. 強い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '強い', 'つよい', '강하다, 세다',
    '強(강할 강): 弓(활) + 厶 + 虫(벌레) → 단단하고 강함', 'い형용사', 190) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぜがつよいですね。', '바람이 세네요.', 1),
    (w, '兄はつよいです。', '형은 힘이 세요.', 2);

  -- 191. デパート
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'デパート', '백화점', '명사', 191) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デパートでかいものをする。', '백화점에서 쇼핑을 한다.', 1),
    (w, 'デパートは八階まであります。', '백화점은 8층까지 있어요.', 2);

  -- 192. でも
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'でも', '하지만, 그렇지만', '접속사', 192) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いそがしいです。でも、行きます。', '바빠요. 그래도 갈게요.', 1),
    (w, 'おいしいです。でも、たかいです。', '맛있어요. 하지만 비싸요.', 2);

  -- 193. どういたしまして
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'どういたしまして', '천만에요', '표현', 193) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいえ、どういたしまして。', '아니요, 천만에요.', 1),
    (w, 'どういたしまして、また来てください。', '천만에요, 또 오세요.', 2);

  -- 194. 遠い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '遠い', 'とおい', '멀다',
    '遠(멀 원): 辶(가다) + 袁(긴 옷자락) → 옷자락이 길게 끌리듯 먼 거리', 'い형용사', 194) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅はとおいです。', '역은 멀어요.', 1),
    (w, 'とおいくにから来ました。', '먼 나라에서 왔어요.', 2);

  -- 195. 時々
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '時々', 'ときどき', '때때로',
    '時(때 시) + 々(반복) → 때와 때 → 가끔, 때때로', '부사', 195) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ときどき母に電話します。', '때때로 어머니께 전화해요.', 1),
    (w, '日本語をときどき勉強する。', '일본어를 가끔 공부한다.', 2);

  -- 196. どちら
  insert into public.words (deck_id, headword, reading, meaning, part_of_speech, order_index)
  values (d_n5, NULL, 'どちら', '어느 쪽, 어느 분', '대명사', 196) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お国はどちらですか。', '고향은 어디입니까?', 1),
    (w, 'どちらがいいですか。', '어느 쪽이 좋아요?', 2);

  -- 197. 飛ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '飛ぶ', 'とぶ', '날다',
    '飛(날 비): 새가 날개를 펴고 나는 모양', '동사', 197) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鳥が空をとんでいる。', '새가 하늘을 날고 있다.', 1),
    (w, '飛行機がとびました。', '비행기가 날아갔어요.', 2);

  -- 198. 止まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '止まる', 'とまる', '멈추다',
    '止(그칠 지): 발의 모양 → 발이 멈춘 상태', '동사', 198) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が駅にとまる。', '전철이 역에 멈춘다.', 1),
    (w, '時計がとまっている。', '시계가 멈춰 있다.', 2);

  -- 199. 取る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '取る', 'とる', '집다, 잡다, 취하다',
    '取(가질 취): 耳(귀) + 又(손) → 손으로 귀를 잡음 → 잡다', '동사', 199) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しおをとってください。', '소금을 집어 주세요.', 1),
    (w, 'メモを取ります。', '메모를 합니다.', 2);

  -- 200. 撮る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index)
  values (d_n5, '撮る', 'とる', '(사진·영화를) 찍다',
    '撮(취할 촬): 扌(손) + 最(가장) → 손으로 가장 좋은 순간을 잡음=찍다', '동사', 200) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を一まいとってください。', '사진을 한 장 찍어 주세요.', 1),
    (w, '映画をとっています。', '영화를 찍고 있어요.', 2);

-- BATCH_PLACEHOLDER

end $$;
