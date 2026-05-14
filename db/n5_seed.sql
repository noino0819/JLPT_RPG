-- ============================================================
-- JLPT N5 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N5-단어장)
-- ============================================================
-- 실행 시 기존 N5 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 382단어/표현 (모두 의미·한자어원/구조·예문 2개씩 포함)
--   #1~82   : 한자 읽기 (단일 단어)
--   #83~98  : 한자 표기 (단일 단어)
--   #99~248 : 문맥 규정 (단일 단어)
--   #249~254: 문맥 규정 관용구 (お風呂に入る / 風邪をひく / シャワーを浴びる / 新聞を読む / どうぞよろしく / 勉強がしたい)
--   #255~382: 유의어 페어 64쌍 → 양쪽 모두 자체 단어 entry (각 한자 어원·예문 2개 보유)
--             표현 간 「≒」 관계는 word_relations 테이블에 양방향 synonym 으로 등록
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
  w1  uuid;
  w2  uuid;
begin
  select id into d_n5
  from public.decks
  where is_official and jlpt_level = 'N5'
  limit 1;

  -- 1. 会う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '会う', 'あう', '만나다', '会(만날 회): 人(사람 인)이 모이는 모양 → 사람들이 한곳에 모여 만남', '동사', 1, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で友だちに会う。', '역에서 친구를 만나다.', 1),
    (w, '昨日先生に会いました。', '어제 선생님을 만났습니다.', 2);

  -- 2. 赤い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '赤い', 'あかい', '빨갛다, 붉다', '赤(붉을 적): 大(큰 사람)이 火(불) 위에 있는 모양 → 불빛에 비친 붉은색', 'い형용사', 2, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤い花がさいた。', '빨간 꽃이 피었다.', 1),
    (w, '彼女は赤いかばんを買った。', '그녀는 빨간 가방을 샀다.', 2);

  -- 3. 朝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '朝', 'あさ', '아침', '朝(아침 조): 풀(艹) 사이로 해(日)가 떠오르는 모양 → 동틀 무렵', '명사', 3, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝ごはんを食べる。', '아침밥을 먹다.', 1),
    (w, '朝6時に起きる。', '아침 6시에 일어난다.', 2);

  -- 4. 後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '後', 'あと', '뒤, 나중', '後(뒤 후): 彳(걸음) + 幺(작음) + 夂(천천히) → 뒤늦게 천천히 따라감', '명사', 4, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べた後で散歩する。', '먹은 후에 산책한다.', 1),
    (w, '私の後ろに立ってください。', '제 뒤에 서 주세요.', 2);

  -- 5. 雨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '雨', 'あめ', '비', '雨(비 우): 하늘에서 물방울이 떨어지는 모양을 본뜬 글자', '명사', 5, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨がふっています。', '비가 내리고 있습니다.', 1),
    (w, '雨の日は家で本を読む。', '비 오는 날은 집에서 책을 읽는다.', 2);

  -- 6. 言う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '言う', 'いう', '말하다', '言(말씀 언): 입(口)에서 소리가 나가는 모양 → 말을 하다', '동사', 6, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度言ってください。', '한 번 더 말해 주세요.', 1),
    (w, '何と言いましたか。', '뭐라고 말했어요?', 2);

  -- 7. 入り口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '入り口', 'いりぐち', '입구', '入(들 입): 안으로 들어가는 모양\n口(입 구): 사람의 입 모양 → 들어가는 통로', '명사', 7, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入り口はあちらです。', '입구는 저쪽입니다.', 1),
    (w, '駅の入り口で待っています。', '역 입구에서 기다리고 있어요.', 2);

  -- 8. 上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '上', 'うえ', '위', '上(윗 상): 기준선 위에 점을 찍은 모양 → 위쪽', '명사', 8, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本はつくえの上にあります。', '책은 책상 위에 있습니다.', 1),
    (w, '山の上に雪がある。', '산 위에 눈이 있다.', 2);

  -- 9. 生まれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '生まれる', 'うまれる', '태어나다', '生(날 생): 풀이 흙(土)을 뚫고 자라나는 모양 → 새로운 생명이 태어남', '동사', 9, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は東京で生まれました。', '저는 도쿄에서 태어났습니다.', 1),
    (w, '弟は1月に生まれた。', '남동생은 1월에 태어났다.', 2);

  -- 10. 駅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '駅', 'えき', '역', '駅(역 역): 馬(말) + 尺(자) → 옛날 말을 갈아타던 정거장', '명사', 10, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩きます。', '역까지 걸어갑니다.', 1),
    (w, 'この駅で電車をおります。', '이 역에서 전철을 내립니다.', 2);

  -- 11. 大きい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大きい', 'おおきい', '크다', '大(큰 대): 사람이 두 팔과 다리를 벌리고 선 모양 → 크다', 'い형용사', 11, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きい犬がいる。', '큰 개가 있다.', 1),
    (w, 'この部屋は大きいです。', '이 방은 큽니다.', 2);

  -- 12. お金
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, 'お金', 'おかね', '돈', '金(쇠 금): 흙(土) 속의 광물 알갱이를 본뜬 모양 → 금속, 화폐', '명사', 12, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金がぜんぜんありません。', '돈이 전혀 없어요.', 1),
    (w, 'このかばんはお金をはらいました。', '이 가방은 돈을 지불했습니다.', 2);

  -- 13. 男の子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '男の子', 'おとこのこ', '남자아이', '男(사내 남): 田(밭) + 力(힘) → 밭에서 힘쓰는 사람\n子(아들 자): 어린아이의 모양', '명사', 13, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '男の子が三人います。', '남자아이가 세 명 있어요.', 1),
    (w, 'あの男の子は私の弟です。', '저 남자아이는 제 남동생입니다.', 2);

  -- 14. 女の子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '女の子', 'おんなのこ', '여자아이', '女(여자 녀): 무릎 꿇고 앉은 여인의 모양\n子(아들 자): 어린아이의 모양', '명사', 14, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい女の子がないている。', '작은 여자아이가 울고 있다.', 1),
    (w, 'クラスに女の子が十人います。', '반에 여자아이가 열 명 있어요.', 2);

  -- 15. 外国
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '外国', 'がいこく', '외국', '外(바깥 외): 夕(저녁) + 卜(점) → 점치러 밖에 나감 → 바깥\n国(나라 국): 囗(둘레) + 玉(보배) → 영토 안의 나라', '명사', 15, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外国へ行きたいです。', '외국에 가고 싶습니다.', 1),
    (w, '兄は外国ではたらいています。', '형은 외국에서 일하고 있어요.', 2);

  -- 16. 買う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '買う', 'かう', '사다, 구입하다', '買(살 매): 网(그물) + 貝(조개=돈) → 그물로 돈을 모아 물건을 사다', '동사', 16, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スーパーでくだものを買う。', '슈퍼에서 과일을 사다.', 1),
    (w, '新しいくつを買いました。', '새 신발을 샀어요.', 2);

  -- 17. 学校
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '学校', 'がっこう', '학교', '学(배울 학): 子(아이)가 지붕 아래에서 배움\n校(학교 교): 木(나무) + 交(엇갈림) → 나무가 엇갈린 울타리, 학사', '명사', 17, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日学校へ行きます。', '매일 학교에 갑니다.', 1),
    (w, '学校はうちのちかくにある。', '학교는 집 근처에 있다.', 2);

  -- 18. 火曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '火曜日', 'かようび', '화요일', '火(불 화): 타오르는 불꽃 모양\n曜(빛날 요): 日(해) + 翟(꿩 깃) → 빛나는 별\n日(날 일): 해의 모양', '명사', 18, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '火曜日にテストがあります。', '화요일에 시험이 있어요.', 1),
    (w, '火曜日は休みです。', '화요일은 쉬는 날입니다.', 2);

  -- 19. 川
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '川', 'かわ', '강, 냇물', '川(내 천): 물이 굽이쳐 흐르는 모양을 본뜬 글자', '명사', 19, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川で魚をつる。', '강에서 물고기를 낚다.', 1),
    (w, 'この川はとても長いです。', '이 강은 매우 깁니다.', 2);

  -- 20. 木
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '木', 'き', '나무', '木(나무 목): 가지와 뿌리가 뻗은 나무 모양', '명사', 20, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園に大きい木がある。', '공원에 큰 나무가 있다.', 1),
    (w, '木の上に鳥がいます。', '나무 위에 새가 있어요.', 2);

  -- 21. 聞く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '聞く', 'きく', '듣다', '聞(들을 문): 門(문) + 耳(귀) → 문 사이로 귀를 기울여 듣다', '동사', 21, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聞くのが好きです。', '음악 듣는 것을 좋아합니다.', 1),
    (w, '先生に聞いてください。', '선생님께 여쭤보세요.', 2);

  -- 22. 北
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '北', 'きた', '북(쪽)', '北(북녘 북): 두 사람이 서로 등을 진 모양 → 등을 돌린 방향=북쪽', '명사', 22, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '北の国はさむいです。', '북쪽 나라는 춥습니다.', 1),
    (w, '駅は北のほうにある。', '역은 북쪽에 있다.', 2);

  -- 23. 銀行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '銀行', 'ぎんこう', '은행', '銀(은 은): 金(쇠) + 艮(어긋날 간) → 빛나는 흰 금속\n行(다닐 행): 사거리의 모양 → 거래가 오가는 곳', '명사', 23, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行でお金をだす。', '은행에서 돈을 찾다.', 1),
    (w, '銀行は9時にあきます。', '은행은 9시에 엽니다.', 2);

  -- 24. 金曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '金曜日', 'きんようび', '금요일', '金(쇠 금): 흙 속의 금속 알갱이\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 24, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金曜日の夜、えいがを見ます。', '금요일 밤에 영화를 봅니다.', 1),
    (w, '金曜日にあいましょう。', '금요일에 만나요.', 2);

  -- 25. 国
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '国', 'くに', '나라', '国(나라 국): 囗(둘레=영토) + 玉(임금의 옥) → 다스리는 영토', '명사', 25, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お国はどちらですか。', '고향(나라)은 어디입니까?', 1),
    (w, '私の国は四つの島でできている。', '우리나라는 네 개의 섬으로 이루어져 있다.', 2);

  -- 26. 車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '車', 'くるま', '자동차', '車(수레 거/차): 수레의 바퀴와 축을 위에서 본 모양', '명사', 26, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車で会社へ行く。', '차로 회사에 간다.', 1),
    (w, '新しい車を買いました。', '새 차를 샀습니다.', 2);

  -- 27. 午後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '午後', 'ごご', '오후', '午(낮 오): 절구공이의 모양 → 정오\n後(뒤 후): 뒤늦게 따라감 → 정오 뒤=오후', '명사', 27, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '午後3時に会いましょう。', '오후 3시에 만납시다.', 1),
    (w, '午後はひまです。', '오후는 한가합니다.', 2);

  -- 28. 今月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '今月', 'こんげつ', '이번 달', '今(이제 금): 입을 벌려 무엇인가 머금은 모양 → 지금\n月(달 월): 초승달 모양', '명사', 28, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月はいそがしいです。', '이번 달은 바빠요.', 1),
    (w, '今月の20日にあいましょう。', '이번 달 20일에 만나요.', 2);

  -- 29. 魚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '魚', 'さかな', '생선, 물고기', '魚(물고기 어): 머리(⺈), 몸통(田), 꼬리(灬)를 가진 물고기 모양', '명사', 29, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '魚をやいて食べる。', '생선을 구워 먹는다.', 1),
    (w, '川に魚がたくさんいます。', '강에 물고기가 많이 있어요.', 2);

  -- 30. 四月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '四月', 'しがつ', '4월', '四(넉 사): 코로 숨이 갈라져 나오는 모양 → 넷\n月(달 월): 초승달 모양 → 달', '명사', 30, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '四月から学校がはじまる。', '4월부터 학교가 시작된다.', 1),
    (w, '四月はさくらがきれいです。', '4월은 벚꽃이 예쁩니다.', 2);

  -- 31. 下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '下', 'した', '아래, 밑', '下(아래 하): 기준선 아래에 점을 찍은 모양 → 아래쪽', '명사', 31, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '机の下に犬がいる。', '책상 아래에 개가 있다.', 1),
    (w, '木の下で休みました。', '나무 아래에서 쉬었습니다.', 2);

  -- 32. 七月
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '七月', 'しちがつ', '7월', '七(일곱 칠): 가로획 + 세로획이 굽은 모양 → 일곱\n月(달 월): 초승달 모양', '명사', 32, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '七月はあついです。', '7월은 덥습니다.', 1),
    (w, '七月にうみへ行く。', '7월에 바다에 간다.', 2);

  -- 33. 七時
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '七時', 'しちじ', '7시', '七(일곱 칠): 일곱 → 시간을 셀 때 사용\n時(때 시): 日(해) + 寺(절) → 해의 움직임으로 측정한 시각', '명사', 33, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝七時に起きます。', '아침 7시에 일어납니다.', 1),
    (w, '七時に駅で会いましょう。', '7시에 역에서 만나요.', 2);

  -- 34. 白い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '白い', 'しろい', '희다, 하얗다', '白(흰 백): 햇빛이 비치는 모양 → 환하고 흰색', 'い형용사', 34, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '白いシャツをきている。', '하얀 셔츠를 입고 있다.', 1),
    (w, '雪はとても白い。', '눈은 아주 하얗다.', 2);

  -- 35. 千円
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '千円', 'せんえん', '1000엔', '千(일천 천): 사람(人)이 많이 모인 모양 → 천\n円(둥글 원): 둥근 동전 모양 → 일본 화폐 단위', '명사', 35, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは千円です。', '이것은 1000엔입니다.', 1),
    (w, '千円でかいものをした。', '1000엔으로 쇼핑을 했다.', 2);

  -- 36. 先生
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '先生', 'せんせい', '선생님', '先(먼저 선): 발(止)이 사람(儿) 위에 있는 모양 → 앞장섬\n生(날 생): 풀이 자라는 모양 → 살아있음 → 먼저 산 사람=선생', '명사', 36, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語の先生はやさしいです。', '일본어 선생님은 친절합니다.', 1),
    (w, '先生に質問しました。', '선생님께 질문했습니다.', 2);

  -- 37. 外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '外', 'そと', '밖', '外(바깥 외): 夕(저녁) + 卜(점) → 저녁 점은 집 밖에서 → 바깥', '명사', 37, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外でこどもがあそんでいる。', '밖에서 아이가 놀고 있다.', 1),
    (w, '外はさむいですよ。', '밖은 추워요.', 2);

  -- 38. 空
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '空', 'そら', '하늘', '空(빌 공/하늘): 穴(구멍) + 工(만들다) → 비어있는 큰 공간 → 하늘', '명사', 38, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空が青いですね。', '하늘이 파랗네요.', 1),
    (w, '空にとりがとんでいる。', '하늘에 새가 날고 있다.', 2);

  -- 39. 大学
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大学', 'だいがく', '대학', '大(큰 대): 사람이 팔다리를 벌린 모양\n学(배울 학): 子(아이)가 지붕 아래에서 배움 → 큰 배움터', '명사', 39, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学で日本語をべんきょうする。', '대학에서 일본어를 공부한다.', 1),
    (w, '兄は大学生です。', '형은 대학생입니다.', 2);

  -- 40. 高い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '高い', 'たかい', '비싸다, 높다, (키가) 크다', '高(높을 고): 누각이 높이 솟은 모양', 'い형용사', 40, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんは高いです。', '이 가방은 비싸요.', 1),
    (w, '兄は高い山にのぼった。', '형은 높은 산에 올랐다.', 2);

  -- 41. 出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '出す', 'だす', '내다, 제출하다', '出(날 출): 발이 동굴 밖으로 나가는 모양 → 밖으로 내다', '동사', 41, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'レポートを先生に出した。', '리포트를 선생님께 제출했다.', 1),
    (w, 'かばんから本を出してください。', '가방에서 책을 꺼내 주세요.', 2);

  -- 42. 食べる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '食べる', 'たべる', '먹다', '食(밥 식): 그릇에 쌀밥을 담아 뚜껑을 덮은 모양 → 음식', '동사', 42, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごを食べる。', '사과를 먹는다.', 1),
    (w, '昨日すしを食べました。', '어제 초밥을 먹었어요.', 2);

  -- 43. 小さい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '小さい', 'ちいさい', '(크기가) 작다', '小(작을 소): 작은 물건 세 개를 점으로 표현 → 작다', 'い형용사', 43, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい子どもがいる。', '작은 아이가 있다.', 1),
    (w, 'このシャツは小さいです。', '이 셔츠는 작아요.', 2);

  -- 44. 父
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '父', 'ちち', '아빠, 아버지', '父(아비 부): 손에 도구를 든 모양 → 가장이 일하는 모습', '명사', 44, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は会社員です。', '아버지는 회사원입니다.', 1),
    (w, '父といっしょに釣りに行った。', '아버지와 함께 낚시를 갔다.', 2);

  -- 45. 手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '手', 'て', '손', '手(손 수): 다섯 손가락을 펼친 손 모양', '명사', 45, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をあらってください。', '손을 씻어 주세요.', 1),
    (w, '右手をあげてください。', '오른손을 들어 주세요.', 2);

  -- 46. 手紙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '手紙', 'てがみ', '편지', '手(손 수): 손 모양\n紙(종이 지): 糸(실) + 氏(밑판) → 손으로 쓴 종이=편지', '명사', 46, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちに手紙を書く。', '친구에게 편지를 쓴다.', 1),
    (w, '母から手紙がきた。', '엄마로부터 편지가 왔다.', 2);

  -- 47. 出る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '出る', 'でる', '나가(오)다', '出(날 출): 발이 동굴 밖으로 나가는 모양 → 나가다', '동사', 47, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '7時に家を出ます。', '7시에 집을 나섭니다.', 1),
    (w, 'バスは10分後に出る。', '버스는 10분 후에 출발한다.', 2);

  -- 48. 天気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '天気', 'てんき', '날씨', '天(하늘 천): 사람(大) 위의 큰 하늘\n気(기운 기): 김이 피어오르는 모양 → 하늘의 상태', '명사', 48, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は天気がいいです。', '오늘은 날씨가 좋아요.', 1),
    (w, 'あしたの天気はあめです。', '내일 날씨는 비입니다.', 2);

  -- 49. 電気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '電気', 'でんき', '전기', '電(번개 전): 雨(비) + 申(번개 모양) → 번개\n気(기운 기): 김이 피어오르는 모양 → 번개의 기=전기', '명사', 49, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気をつけてください。', '불(전기)을 켜 주세요.', 1),
    (w, '部屋の電気が消えた。', '방의 불이 꺼졌다.', 2);

  -- 50. 電話
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '電話', 'でんわ', '전화', '電(번개 전): 번개의 모양\n話(말씀 화): 言(말) + 舌(혀) → 전기로 말을 전함=전화', '명사', 50, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母に電話します。', '어머니께 전화합니다.', 1),
    (w, 'あとで電話してください。', '나중에 전화해 주세요.', 2);

  -- 51. 十日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '十日', 'とおか', '10일', '十(열 십): 가로획 + 세로획 → 동서남북이 다 모인 수=열\n日(날 일): 해의 모양 → 날짜', '명사', 51, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月の十日に会いましょう。', '이번 달 10일에 만나요.', 1),
    (w, '十日かかりました。', '10일 걸렸습니다.', 2);

  -- 52. 友だち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '友だち', 'ともだち', '친구', '友(벗 우): 손(又) 두 개가 나란히 → 서로 손잡는 사이=벗', '명사', 52, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちと映画を見た。', '친구와 영화를 봤다.', 1),
    (w, '日本人の友だちができました。', '일본인 친구가 생겼습니다.', 2);

  -- 53. 土曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '土曜日', 'どようび', '토요일', '土(흙 토): 흙 위에 풀이 돋는 모양\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 53, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '土曜日にデパートへ行きます。', '토요일에 백화점에 갑니다.', 1),
    (w, '今週の土曜日はひまです。', '이번 주 토요일은 한가합니다.', 2);

  -- 54. 中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '中', 'なか', '안, 속', '中(가운데 중): 깃발의 가운데를 표시한 모양 → 가운데, 안', '명사', 54, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かばんの中に本があります。', '가방 안에 책이 있어요.', 1),
    (w, '部屋の中にはだれもいない。', '방 안에는 아무도 없다.', 2);

  -- 55. 長い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '長い', 'ながい', '길다', '長(길 장): 긴 머리카락이 흩날리는 노인의 모양 → 길다', 'い형용사', 55, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長い手紙を書いた。', '긴 편지를 썼다.', 1),
    (w, '彼女のかみはとても長いです。', '그녀의 머리카락은 매우 길어요.', 2);

  -- 56. 何人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '何人', 'なんにん', '몇 명', '何(어찌 하): 사람(亻)이 짐(可)을 진 모양 → 무엇\n人(사람 인): 두 다리로 선 사람의 모양', '명사', 56, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスは何人ですか。', '반은 몇 명입니까?', 1),
    (w, '家族は何人いますか。', '가족은 몇 명입니까?', 2);

  -- 57. 西
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '西', 'にし', '서(쪽)', '西(서녘 서): 새가 둥지에 깃든 모양 → 해가 지는 쪽=서쪽', '명사', 57, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '西の空が赤いです。', '서쪽 하늘이 붉습니다.', 1),
    (w, 'うちは駅の西にある。', '우리집은 역의 서쪽에 있다.', 2);

  -- 58. 飲む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '飲む', 'のむ', '마시다, 삼키다', '飲(마실 음): 食(음식) + 欠(입을 벌림) → 입을 벌려 마시다', '동사', 58, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水を飲みます。', '물을 마십니다.', 1),
    (w, 'コーヒーを飲みながら話す。', '커피를 마시면서 이야기한다.', 2);

  -- 59. 入る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '入る', 'はいる', '들어가(오)다', '入(들 입): 좁은 입구로 들어가는 모양', '동사', 59, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋に入ってください。', '방에 들어와 주세요.', 1),
    (w, 'おふろに入ります。', '목욕탕에 들어갑니다.', 2);

  -- 60. 花
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '花', 'はな', '꽃', '花(꽃 화): 艹(풀) + 化(변화) → 풀이 모양을 바꾸어 핀 것=꽃', '명사', 60, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花がたくさんさいています。', '꽃이 많이 피어 있습니다.', 1),
    (w, '母に花をあげた。', '엄마에게 꽃을 드렸다.', 2);

  -- 61. 母
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '母', 'はは', '엄마', '母(어미 모): 어머니가 아이에게 젖을 먹이는 모양', '명사', 61, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母は元気です。', '어머니는 건강합니다.', 1),
    (w, '母に電話した。', '어머니께 전화했다.', 2);

  -- 62. 半分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '半分', 'はんぶん', '반, 절반', '半(반 반): 八(나누다) + 牛(소) → 소를 둘로 나눔=반\n分(나눌 분): 八(나누다) + 刀(칼) → 칼로 나눔', '명사', 62, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごを半分にきる。', '사과를 반으로 자르다.', 1),
    (w, '半分だけ食べました。', '반만 먹었어요.', 2);

  -- 63. 左
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '左', 'ひだり', '왼쪽', '左(왼 좌): 왼손(ナ) + 工(도구) → 도구를 잡는 왼손 → 왼쪽', '명사', 63, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '左にまがってください。', '왼쪽으로 도세요.', 1),
    (w, '左の手で書く。', '왼손으로 쓴다.', 2);

  -- 64. 人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '人', 'ひと', '사람', '人(사람 인): 두 다리로 선 사람의 옆모양', '명사', 64, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの人はだれですか。', '저 사람은 누구입니까?', 1),
    (w, 'みちに人がたくさんいる。', '길에 사람이 많이 있다.', 2);

  -- 65. 古い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '古い', 'ふるい', '오래되다, 낡다', '古(옛 고): 十(많은) + 口(말) → 오랫동안 입에서 입으로 전해진 옛것', 'い형용사', 65, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは古い本です。', '이것은 오래된 책입니다.', 1),
    (w, '父の車はとても古い。', '아버지의 차는 매우 낡았다.', 2);

  -- 66. 本
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '本', 'ほん', '책', '本(근본 본): 木(나무)의 뿌리에 점(一)을 찍어 중요한 부분을 가리킴 → 책의 본', '명사', 66, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を読みます。', '책을 읽습니다.', 1),
    (w, '日本語の本を買った。', '일본어 책을 샀다.', 2);

  -- 67. 毎日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '毎日', 'まいにち', '매일', '毎(매양 매): 母(어머니)에서 변형 → 늘 같은\n日(날 일): 해의 모양 → 날마다', '명사', 67, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日学校へ行きます。', '매일 학교에 갑니다.', 1),
    (w, '毎日日本語をべんきょうする。', '매일 일본어를 공부한다.', 2);

  -- 68. 前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '前', 'まえ', '앞, 전', '前(앞 전): 발(止) + 배(舟) → 배가 앞으로 나아감 → 앞', '명사', 68, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅の前で待ってください。', '역 앞에서 기다려 주세요.', 1),
    (w, '食事の前に手をあらう。', '식사 전에 손을 씻는다.', 2);

  -- 69. 右
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '右', 'みぎ', '오른쪽', '右(오른 우): 오른손(ナ) + 口(입) → 음식을 먹는 손=오른쪽', '명사', 69, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '右にまがってください。', '오른쪽으로 도세요.', 1),
    (w, '右の手で書きます。', '오른손으로 씁니다.', 2);

  -- 70. 水
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '水', 'みず', '물', '水(물 수): 흐르는 물줄기와 물방울의 모양', '명사', 70, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水をのみます。', '물을 마십니다.', 1),
    (w, 'つめたい水がほしい。', '차가운 물이 마시고 싶다.', 2);

  -- 71. 店
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '店', 'みせ', '가게', '店(가게 점): 广(집) + 占(자리잡다) → 자리를 잡고 물건을 파는 집', '명사', 71, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの店はやすいです。', '저 가게는 쌉니다.', 1),
    (w, '駅のちかくに店がたくさんある。', '역 근처에 가게가 많이 있다.', 2);

  -- 72. 見せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '見せる', 'みせる', '보이다, 보여 주다', '見(볼 견): 目(눈) + 儿(사람) → 사람이 눈으로 봄', '동사', 72, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を見せてください。', '사진을 보여 주세요.', 1),
    (w, '友だちに本を見せた。', '친구에게 책을 보여 줬다.', 2);

  -- 73. 道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '道', 'みち', '길', '道(길 도): 辶(쉬엄쉬엄 갈 착) + 首(머리) → 사람이 머리를 들고 가는 길', '명사', 73, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道はせまいです。', '이 길은 좁습니다.', 1),
    (w, '道がわからない。', '길을 모르겠다.', 2);

  -- 74. 耳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '耳', 'みみ', '귀', '耳(귀 이): 사람의 귀 모양을 본뜬 글자', '명사', 74, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '耳がいたいです。', '귀가 아파요.', 1),
    (w, '犬の耳は大きい。', '개의 귀는 크다.', 2);

  -- 75. 見る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '見る', 'みる', '보다', '見(볼 견): 目(눈) + 儿(사람) → 사람이 눈으로 봄', '동사', 75, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビを見ます。', '텔레비전을 봅니다.', 1),
    (w, '昨日いい映画を見た。', '어제 좋은 영화를 봤다.', 2);

  -- 76. 木曜日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '木曜日', 'もくようび', '목요일', '木(나무 목): 나무 모양\n曜(빛날 요): 빛나는 별\n日(날 일): 해의 모양', '명사', 76, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '木曜日にじゅぎょうがある。', '목요일에 수업이 있다.', 1),
    (w, '木曜日の夜あいましょう。', '목요일 밤에 만나요.', 2);

  -- 77. 安い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '安い', 'やすい', '(값이) 싸다', '安(편안할 안): 宀(집) + 女(여자) → 여자가 집에 있어 편안함, 값이 부담 없음', 'い형용사', 77, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店はやさいが安い。', '이 가게는 야채가 싸다.', 1),
    (w, '安いくつを買いました。', '싼 신발을 샀습니다.', 2);

  -- 78. 休む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '休む', 'やすむ', '쉬다', '休(쉴 휴): 亻(사람) + 木(나무) → 사람이 나무에 기대어 쉬는 모양', '동사', 78, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は会社を休む。', '오늘은 회사를 쉰다.', 1),
    (w, '少し休んでください。', '잠시 쉬세요.', 2);

  -- 79. 山
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '山', 'やま', '산', '山(뫼 산): 세 봉우리가 솟은 산의 모양', '명사', 79, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日曜日に山にのぼる。', '일요일에 산에 오른다.', 1),
    (w, '山がきれいですね。', '산이 예쁘네요.', 2);

  -- 80. 有名
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '有名', 'ゆうめい', '유명함', '有(있을 유): 손(ナ) + 月(고기) → 손에 들 고기가 있음=가짐\n名(이름 명): 夕(저녁) + 口(입) → 어두워 이름을 불러 알림', 'な형용사', 80, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店は有名です。', '이 가게는 유명해요.', 1),
    (w, '彼は有名な歌手だ。', '그는 유명한 가수다.', 2);

  -- 81. 読む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '読む', 'よむ', '읽다', '読(읽을 독): 言(말) + 売(팔다) → 말로 풀어 펼침=읽음', '동사', 81, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新聞を読みます。', '신문을 읽습니다.', 1),
    (w, 'まだその本を読んでいない。', '아직 그 책을 읽지 않았다.', 2);

  -- 82. 来週
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '来週', 'らいしゅう', '다음 주', '来(올 래): 보리이삭이 익은 모양 → 옴\n週(주일 주): 辶(가다) + 周(둘레) → 한 바퀴=일주일', '명사', 82, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来週テストがあります。', '다음 주에 시험이 있어요.', 1),
    (w, '来週京都へ行きます。', '다음 주에 교토에 갑니다.', 2);

  -- 83. 足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '足', 'あし', '발, 다리', '足(발 족): 무릎 아래의 다리 모양', '명사', 83, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '足がいたいです。', '발이 아파요.', 1),
    (w, '長く歩いて足がつかれた。', '오래 걸어서 다리가 피곤해졌다.', 2);

  -- 84. 新しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '新しい', 'あたらしい', '새롭다', '新(새 신): 立(설) + 木(나무) + 斤(도끼) → 도끼로 새로 베어낸 나무=새것', 'い형용사', 84, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいかばんを買った。', '새 가방을 샀다.', 1),
    (w, '新しい先生はやさしい。', '새 선생님은 친절하다.', 2);

  -- 85. 行く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '行く', 'いく', '가다', '行(다닐 행): 사거리의 모양 → 길을 다님', '동사', 85, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校へ行きます。', '학교에 갑니다.', 1),
    (w, 'バスで行きました。', '버스로 갔습니다.', 2);

  -- 86. 多い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '多い', 'おおい', '많다', '多(많을 다): 夕(저녁) 두 개를 겹친 모양 → 날이 거듭됨=많음', 'い형용사', 86, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この公園は人が多い。', '이 공원은 사람이 많다.', 1),
    (w, '今日はしごとが多いです。', '오늘은 일이 많아요.', 2);

  -- 87. 男
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '男', 'おとこ', '남자', '男(사내 남): 田(밭) + 力(힘) → 밭에서 힘쓰는 사람', '명사', 87, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの男の人はだれですか。', '저 남자는 누구입니까?', 1),
    (w, '男の声がきこえる。', '남자의 목소리가 들린다.', 2);

  -- 88. 会社
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '会社', 'かいしゃ', '회사', '会(만날 회): 사람들이 모이는 모양\n社(모일 사): 示(보일) + 土(흙) → 사람들이 모인 단체', '명사', 88, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は会社へ行きます。', '아버지는 회사에 갑니다.', 1),
    (w, '会社は東京にあります。', '회사는 도쿄에 있어요.', 2);

  -- 89. 書く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '書く', 'かく', '쓰다, 적다', '書(쓸 서): 聿(붓) + 曰(말함) → 붓으로 말을 적음', '동사', 89, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を書いてください。', '이름을 써 주세요.', 1),
    (w, 'ノートに漢字を書く。', '노트에 한자를 쓴다.', 2);

  -- 90. 来る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '来る', 'くる', '오다', '来(올 래): 익은 보리이삭이 늘어진 모양 → (수확물이) 옴', '동사', 90, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'バスがきました。', '버스가 왔습니다.', 1),
    (w, 'あした、うちに来てください。', '내일 우리집에 오세요.', 2);

  -- 91. 子ども
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '子ども', 'こども', '아이, 어린이', '子(아들 자): 어린아이의 모양 → 아이', '명사', 91, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもが公園であそんでいる。', '아이들이 공원에서 놀고 있다.', 1),
    (w, '子どもは三人います。', '아이는 세 명 있어요.', 2);

  -- 92. 今週
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '今週', 'こんしゅう', '이번 주', '今(이제 금): 머금은 모양 → 지금\n週(주일 주): 한 바퀴=일주일', '명사', 92, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今週はいそがしい。', '이번 주는 바쁘다.', 1),
    (w, '今週の土曜日にあいましょう。', '이번 주 토요일에 만나요.', 2);

  -- 93. 時間
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '時間', 'じかん', '시간', '時(때 시): 日(해) + 寺(절) → 해의 움직임으로 측정한 시각\n間(사이 간): 門(문) + 日(해) → 문틈으로 비치는 햇빛=사이', '명사', 93, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間がありません。', '시간이 없어요.', 1),
    (w, '一時間まちました。', '한 시간 기다렸어요.', 2);

  -- 94. 電車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '電車', 'でんしゃ', '전철', '電(번개 전): 雨(비) + 申(번개) → 번개=전기\n車(수레 차): 수레의 모양 → 전기로 가는 차=전철', '명사', 94, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車で会社へ行きます。', '전철로 회사에 갑니다.', 1),
    (w, '電車がおくれている。', '전철이 늦어지고 있다.', 2);

  -- 95. 名前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '名前', 'なまえ', '이름', '名(이름 명): 夕(저녁) + 口(입) → 어두워 이름을 불러 알림\n前(앞 전): 발(止) + 배(舟) → 앞', '명사', 95, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お名前は何ですか。', '이름이 무엇입니까?', 1),
    (w, 'ここに名前を書いてください。', '여기에 이름을 적어 주세요.', 2);

  -- 96. 東
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '東', 'ひがし', '동(쪽)', '東(동녘 동): 木(나무) 사이로 해(日)가 떠오르는 모양 → 해 뜨는 쪽', '명사', 96, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東の空が明るくなった。', '동쪽 하늘이 밝아졌다.', 1),
    (w, 'うちは駅の東にある。', '우리집은 역의 동쪽에 있다.', 2);

  -- 97. 南
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '南', 'みなみ', '남(쪽)', '南(남녘 남): 따뜻한 풀이 자라는 천막의 모양 → 햇볕이 따뜻한 남쪽', '명사', 97, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '南の国はあたたかいです。', '남쪽 나라는 따뜻합니다.', 1),
    (w, '南がわのまどがあかるい。', '남쪽 창이 밝다.', 2);

  -- 98. 六日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '六日', 'むいか', '6일', '六(여섯 륙): 돔처럼 생긴 집의 모양에서 차용 → 여섯\n日(날 일): 해 → 날짜', '명사', 98, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月の六日に会いましょう。', '이번 달 6일에 만나요.', 1),
    (w, '六日かかりました。', '6일 걸렸습니다.', 2);

  -- 99. 明日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '明日', 'あした', '내일', '明(밝을 명): 日(해) + 月(달) → 밝음\n日(날 일): 해의 모양 → 다음 밝은 날=내일', '명사', 99, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日テストがあります。', '내일 시험이 있어요.', 1),
    (w, '明日は日曜日です。', '내일은 일요일입니다.', 2);

  -- 100. 遊ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '遊ぶ', 'あそぶ', '놀다', '遊(놀 유): 辶(가다) + 㫃(깃발) → 깃발을 휘날리며 다님=놀다', '동사', 100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園で子どもたちが遊んでいる。', '공원에서 아이들이 놀고 있다.', 1),
    (w, '日曜日に友だちと遊びました。', '일요일에 친구와 놀았어요.', 2);

  -- 101. 暖かい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '暖かい', 'あたたかい', '따뜻하다', '暖(따뜻할 난): 日(해) + 爰(부드러움) → 햇빛이 부드럽게 비춤=따뜻함', 'い형용사', 101, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はあたたかいです。', '오늘은 따뜻해요.', 1),
    (w, '春はあたたかくなる。', '봄은 따뜻해진다.', 2);

  -- 102. 兄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '兄', 'あに', '오빠, 형', '兄(맏 형): 口(입) + 儿(사람) → 입으로 동생을 가르치는 사람=형', '명사', 102, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄は会社員です。', '형은 회사원입니다.', 1),
    (w, '兄と映画を見ました。', '형과 영화를 봤어요.', 2);

  -- 103. アパート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'アパート', '아파트', '영어 apartment의 외래어, 공동 주택을 뜻함', '명사', 103, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅のちかくのアパートに住んでいる。', '역 근처 아파트에 살고 있다.', 1),
    (w, 'アパートは三階です。', '아파트는 3층이에요.', 2);

  -- 104. 一台
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '一台', 'いちだい', '한 대(자전거·차)', '一(한 일): 가로획 하나=하나\n台(대 대): 위에 올려놓는 받침대 → 차량의 단위', '명사', 104, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が一台あります。', '차가 한 대 있어요.', 1),
    (w, 'じてんしゃを一台買った。', '자전거를 한 대 샀다.', 2);

  -- 105. 一度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '一度', 'いちど', '한 번', '一(한 일): 하나\n度(법도 도/단위): 손으로 측정하는 횟수', '명사', 105, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度言ってください。', '한 번 더 말해 주세요.', 1),
    (w, '日本へ一度行きました。', '일본에 한 번 갔습니다.', 2);

  -- 106. 五つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '五つ', 'いつつ', '다섯, 다섯 개', '五(다섯 오): 위아래 가로획 사이에 X(엇갈림) → 다섯', '명사', 106, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごが五つあります。', '사과가 다섯 개 있어요.', 1),
    (w, 'むすめは五つになりました。', '딸은 다섯 살이 되었어요.', 2);

  -- 107. 犬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '犬', 'いぬ', '개', '犬(개 견): 옆모습의 개 모양', '명사', 107, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい犬をかっています。', '작은 개를 키우고 있어요.', 1),
    (w, '犬が公園を走っている。', '개가 공원을 달리고 있다.', 2);

  -- 108. 入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '入れる', 'いれる', '넣다', '入(들 입): 안으로 들어가는 모양 → 넣다', '동사', 108, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かばんに本を入れる。', '가방에 책을 넣는다.', 1),
    (w, 'コーヒーにさとうを入れた。', '커피에 설탕을 넣었다.', 2);

  -- 109. いろいろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'いろいろ', '여러 가지임', '色(색 색)+々(반복), 「여러 색을 디 가지·다양함」', 'な형용사', 109, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いろいろなくにを見たい。', '여러 나라를 보고 싶다.', 1),
    (w, 'お店にいろいろなくだものがある。', '가게에 여러 가지 과일이 있다.', 2);

  -- 110. 薄い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '薄い', 'うすい', '얇다', '薄(엷을 박): 艹(풀) + 溥(얇다) → 풀잎처럼 얇음', 'い형용사', 110, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うすい本を読みました。', '얇은 책을 읽었어요.', 1),
    (w, 'このシャツはうすいです。', '이 셔츠는 얇아요.', 2);

  -- 111. 選ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '選ぶ', 'えらぶ', '고르다, 선택하다', '選(가릴 선): 辶(가다) + 巽(가지런히 함) → 길에서 가려 뽑음', '동사', 111, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '好きな色をえらんでください。', '좋아하는 색을 골라 주세요.', 1),
    (w, '本を一さつえらんだ。', '책을 한 권 골랐다.', 2);

  -- 112. 危ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '危ない', 'あぶない', '위험하다', '危(위태할 위): 사람이 벼랑 끝에 선 모양 → 위태로움', 'い형용사', 112, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あぶないからちかづかないで。', '위험하니까 가까이 오지 마세요.', 1),
    (w, 'ここはあぶないみちです。', '여기는 위험한 길이에요.', 2);

  -- 113. 甘い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '甘い', 'あまい', '달다', '甘(달 감): 입(口) 안에 단 음식이 있는 모양 → 달다', 'い형용사', 113, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキはあまいです。', '이 케이크는 달아요.', 1),
    (w, 'あまい飲みものが好きです。', '단 음료를 좋아해요.', 2);

  -- 114. 洗う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '洗う', 'あらう', '씻다', '洗(씻을 세): 氵(물) + 先(먼저) → 물에 발을 먼저 씻음', '동사', 114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をよくあらってください。', '손을 잘 씻어 주세요.', 1),
    (w, 'ようふくをあらった。', '옷을 빨았다.', 2);

  -- 115. 歩く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '歩く', 'あるく', '걷다', '歩(걸음 보): 발(止) 두 개를 위아래로 → 걷다', '동사', 115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩いて行く。', '역까지 걸어간다.', 1),
    (w, '公園を一時間あるいた。', '공원을 한 시간 걸었다.', 2);

  -- 116. いくら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'いくら', '얼마(값)', 'いく(몇)+ら(수량 접미), 「얼마」의 의문사', '명사·부사', 116, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これはいくらですか。', '이것은 얼마예요?', 1),
    (w, 'いくら高くても買います。', '아무리 비싸도 사겠어요.', 2);

  -- 117. 忙しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '忙しい', 'いそがしい', '바쁘다', '忙(바쁠 망): 忄(마음) + 亡(없을 망) → 마음의 여유가 없음=바쁨', 'い형용사', 117, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はとてもいそがしいです。', '오늘은 매우 바빠요.', 1),
    (w, 'しごとがいそがしくて休めない。', '일이 바빠서 쉴 수 없다.', 2);

  -- 118. 痛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '痛い', 'いたい', '아프다', '痛(아플 통): 疒(병) + 甬(통할 통) → 몸을 통과하는 아픔', 'い형용사', 118, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がいたいです。', '머리가 아파요.', 1),
    (w, '足がいたくて歩けない。', '발이 아파서 걸을 수 없다.', 2);

  -- 119. エレベーター
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'エレベーター', '엘리베이터', '영어 elevator의 외래어', '명사', 119, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'エレベーターで五階まで行く。', '엘리베이터로 5층까지 간다.', 1),
    (w, 'エレベーターはあちらです。', '엘리베이터는 저쪽입니다.', 2);

  -- 120. おいしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'おいしい', '맛있다', 'お이しい(美味): お(접두)+いし(品·팬, 좋은 것)+い, 「맛있다」', 'い형용사', 120, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキはとてもおいしいです。', '이 케이크는 정말 맛있어요.', 1),
    (w, '母のりょうりはおいしい。', '어머니의 요리는 맛있다.', 2);

  -- 121. 大勢
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大勢', 'おおぜい', '많이(사람)', '大(큰 대): 큰\n勢(기세 세): 執(잡을) + 力(힘) → 사람이 많이 모여 만드는 기세', '명사', 121, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅に人が大勢いる。', '역에 사람이 많이 있다.', 1),
    (w, '大勢の前で話すのはきんちょうする。', '많은 사람 앞에서 말하는 건 긴장된다.', 2);

  -- 122. 起きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '起きる', 'おきる', '일어나다', '起(일어날 기): 走(달릴 주) + 己(자기) → 자기가 일어나 달림', '동사', 122, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝六時に起きます。', '매일 아침 6시에 일어납니다.', 1),
    (w, '今日は早く起きました。', '오늘은 일찍 일어났어요.', 2);

  -- 123. 置く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '置く', 'おく', '놓다, 두다', '置(둘 치): 罒(그물) + 直(곧을) → 그물을 곧게 놓음', '동사', 123, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つくえの上に本を置いた。', '책상 위에 책을 놓았다.', 1),
    (w, 'かばんはここに置いてください。', '가방은 여기에 두세요.', 2);

  -- 124. おじさん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'おじさん', '아저씨, 삼촌', '叔父さん: 叔父(아버지의 동생 ·천·술)+さん(경칭), 「아저씨·삼촌」', '명사', 124, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おじさんは医者です。', '삼촌은 의사예요.', 1),
    (w, 'あのおじさんはやさしいです。', '저 아저씨는 친절해요.', 2);

  -- 125. 押す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '押す', 'おす', '누르다, 밀다', '押(누를 압): 扌(손) + 甲(껍질) → 손으로 단단한 것을 누름', '동사', 125, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このボタンを押してください。', '이 버튼을 눌러 주세요.', 1),
    (w, 'ドアを押して入ります。', '문을 밀고 들어갑니다.', 2);

  -- 126. 角
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '角', 'かど', '모퉁이', '角(뿔 각): 동물의 뿔 모양 → 길이 꺾이는 모서리', '명사', 126, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つぎの角を右にまがってください。', '다음 모퉁이에서 오른쪽으로 도세요.', 1),
    (w, '角に小さい店がある。', '모퉁이에 작은 가게가 있다.', 2);

  -- 127. かぶる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'かぶる', '(모자를) 쓰다', '被る(이불 피)+る, 「머리에 딝어쓰다」', '동사', 127, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼうしをかぶってください。', '모자를 써 주세요.', 1),
    (w, 'あついから帽子をかぶった。', '더우니까 모자를 썼다.', 2);

  -- 128. 辛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '辛い', 'からい', '맵다', '辛(매울 신): 죄인을 새기는 칼 모양 → 자극적이고 매움', 'い형용사', 128, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このカレーはからいです。', '이 카레는 매워요.', 1),
    (w, 'からい食べものが好きです。', '매운 음식을 좋아해요.', 2);

  -- 129. ギター
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ギター', '기타(악기)', '영어 guitar의 외래어', '명사', 129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ギターを少しひけます。', '기타를 조금 칠 수 있어요.', 1),
    (w, '兄はギターがじょうずです。', '형은 기타를 잘 쳐요.', 2);

  -- 130. 汚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '汚い', 'きたない', '더럽다, 지저분하다', '汚(더러울 오): 氵(물) + 亏(굽음) → 흐린 물이 고임=더러움', 'い형용사', 130, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋がきたないです。', '방이 더러워요.', 1),
    (w, 'きたない手であめを食べないで。', '더러운 손으로 사탕을 먹지 마.', 2);

  -- 131. 切手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '切手', 'きって', '우표', '切(끊을 절): 七(자르다) + 刀(칼) → 잘라냄\n手(손 수): 손 → 손으로 잘라 붙이는 작은 종이=우표', '명사', 131, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手紙にきってをはった。', '편지에 우표를 붙였다.', 1),
    (w, 'ゆうびんきょくできってを買う。', '우체국에서 우표를 산다.', 2);

  -- 132. 切符
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '切符', 'きっぷ', '표, 티켓', '切(끊을 절): 잘라냄\n符(부호 부): 竹(대나무) + 付(붙이다) → 자른 표=티켓', '명사', 132, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車のきっぷを買った。', '전철 표를 샀다.', 1),
    (w, 'きっぷはどこで買いますか。', '표는 어디서 사요?', 2);

  -- 133. 切る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '切る', 'きる', '자르다', '切(끊을 절): 七(자르는 모양) + 刀(칼) → 칼로 자르다', '동사', 133, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ナイフでパンを切る。', '칼로 빵을 자른다.', 1),
    (w, 'かみを短く切りました。', '머리를 짧게 잘랐어요.', 2);

  -- 134. 暗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '暗い', 'くらい', '어둡다', '暗(어두울 암): 日(해) + 音(소리) → 해가 가려져 어두움', 'い형용사', 134, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋がくらいです。', '방이 어두워요.', 1),
    (w, 'よるはみちがくらい。', '밤은 길이 어둡다.', 2);

  -- 135. おととし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'おととし', '재작년', '一昨年(おととし): 一昨年은 재작년, おと(다음 이전)+とし(해)', '명사', 135, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おととし日本へ行きました。', '재작년에 일본에 갔어요.', 1),
    (w, 'おととしから日本語を勉強している。', '재작년부터 일본어를 공부하고 있다.', 2);

  -- 136. 大人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大人', 'おとな', '어른', '大(큰 대): 큰\n人(사람 인): 사람 → 큰 사람=어른', '명사', 136, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おとなのきっぷを二まいください。', '어른 표 두 장 주세요.', 1),
    (w, 'もう、おとなになりました。', '이제 어른이 되었어요.', 2);

  -- 137. 覚える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '覚える', 'おぼえる', '기억하다, 암기하다', '覚(깨달을 각): 学(배움) + 見(봄) → 배워서 알게 됨', '동사', 137, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前をおぼえました。', '이름을 외웠어요.', 1),
    (w, '漢字をたくさんおぼえる。', '한자를 많이 암기한다.', 2);

  -- 138. 重い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '重い', 'おもい', '무겁다', '重(무거울 중): 사람이 짐을 등에 진 모양 → 무거움', 'い형용사', 138, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんはおもいです。', '이 가방은 무거워요.', 1),
    (w, '本がおもくて持てない。', '책이 무거워서 들 수 없다.', 2);

  -- 139. 面白い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '面白い', 'おもしろい', '재미있다', '面(낯 면): 얼굴의 윤곽\n白(흰 백): 환함 → 얼굴이 환해질 만큼 재미있음', 'い형용사', 139, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本はおもしろいです。', '이 책은 재미있어요.', 1),
    (w, '昨日のえいがはおもしろかった。', '어제 영화는 재미있었다.', 2);

  -- 140. 泳ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '泳ぐ', 'およぐ', '헤엄치다', '泳(헤엄칠 영): 氵(물) + 永(길게 흐름) → 물에서 길게 헤엄침', '동사', 140, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うみでおよぎたい。', '바다에서 수영하고 싶다.', 1),
    (w, 'プールで毎日およぎます。', '수영장에서 매일 헤엄칩니다.', 2);

  -- 141. 降りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '降りる', 'おりる', '내리다', '降(내릴 강): 阝(언덕) + 夅(내려옴) → 언덕에서 내려옴', '동사', 141, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つぎの駅でおります。', '다음 역에서 내려요.', 1),
    (w, 'バスからおりた。', '버스에서 내렸다.', 2);

  -- 142. 返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '返す', 'かえす', '되돌려주다', '返(돌아올 반): 辶(가다) + 反(반대) → 반대로 돌려보냄', '동사', 142, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を図書館にかえした。', '책을 도서관에 돌려줬다.', 1),
    (w, 'あした、お金をかえします。', '내일 돈을 돌려드릴게요.', 2);

  -- 143. かかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'かかる', '(시간·비용이) 들다, 걸리다', '掛かる(걸 권)+る, 「시간·비용이 걸리다」', '동사', 143, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで十分かかります。', '역까지 10분 걸려요.', 1),
    (w, '修理にお金がかかった。', '수리에 돈이 들었다.', 2);

  -- 144. かける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'かける', '(안경을) 쓰다, 걸다', '掛ける(걸 권)+る의 타동사, 「걸다·쓰다·걸다」', '동사', 144, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めがねをかけてください。', '안경을 써 주세요.', 1),
    (w, '電話をかけました。', '전화를 걸었어요.', 2);

  -- 145. 風邪
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '風邪', 'かぜ', '감기', '風(바람 풍): 안에 벌레가 생긴 바람 → 사기\n邪(간사할 사): 사악함 → 나쁜 바람을 맞아 든 병=감기', '명사', 145, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぜをひきました。', '감기에 걸렸어요.', 1),
    (w, 'かぜでがっこうを休んだ。', '감기로 학교를 쉬었다.', 2);

  -- 146. 家族
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '家族', 'かぞく', '가족', '家(집 가): 宀(집) + 豕(돼지) → 가축이 있는 집\n族(겨레 족): 㫃(깃발) + 矢(화살) → 같은 깃발 아래 모인 무리', '명사', 146, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぞくは四人です。', '가족은 4명이에요.', 1),
    (w, 'かぞくとりょこうに行きました。', '가족과 여행을 갔어요.', 2);

  -- 147. 消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '消す', 'けす', '(불·전기를) 끄다', '消(꺼질 소): 氵(물) + 肖(작아짐) → 물로 작아져 사라짐', '동사', 147, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気をけしてください。', '불을 꺼 주세요.', 1),
    (w, 'テレビをけして勉強する。', '텔레비전을 끄고 공부한다.', 2);

  -- 148. 結構
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '結構', 'けっこう', '충분함, 이제 됐음', '結(맺을 결): 糸(실) + 吉(좋음) → 실로 좋게 묶음\n構(얽을 구): 木(나무) + 冓(엮다) → 잘 짜여 충분함', 'な형용사·부사', 148, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もうけっこうです。', '이제 됐습니다.', 1),
    (w, 'けっこうおいしいですね。', '꽤 맛있네요.', 2);

  -- 149. 結婚する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '結婚する', 'けっこんする', '결혼하다', '結(맺을 결): 糸(실)을 묶음\n婚(혼인할 혼): 女(여자) + 昏(저녁) → 저녁에 맞는 여자=혼인', '동사', 149, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄は来年けっこんします。', '형은 내년에 결혼해요.', 1),
    (w, 'けっこんして十年になる。', '결혼한 지 10년이 된다.', 2);

  -- 150. 元気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '元気', 'げんき', '건강함', '元(으뜸 원): 사람의 머리=근원\n気(기운 기): 김이 피어오름 → 근원의 기운=건강', 'な형용사', 150, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おげんきですか。', '잘 지내세요?', 1),
    (w, '父はとても元気です。', '아버지는 매우 건강해요.', 2);

  -- 151. 公園
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '公園', 'こうえん', '공원', '公(공평할 공): 八(나누다) + 厶(사사로움) → 사사로움이 없이 공평\n園(동산 원): 囗(둘레) + 袁(긴 옷) → 울타리 안의 정원', '명사', 151, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園であそびます。', '공원에서 놉니다.', 1),
    (w, '公園のちかくに住んでいる。', '공원 근처에 살고 있다.', 2);

  -- 152. 紅茶
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '紅茶', 'こうちゃ', '홍차', '紅(붉을 홍): 糸(실) + 工(만들다) → 붉게 물들인 실=붉음\n茶(차 차): 艹(풀) + 余(나머지) → 차 잎으로 만든 음료', '명사', 152, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうちゃをのみます。', '홍차를 마십니다.', 1),
    (w, '朝はいつもこうちゃを飲む。', '아침에는 항상 홍차를 마신다.', 2);

  -- 153. ごちそうさま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ごちそうさま', '잘 먹었습니다', '御驰走様(ごちそうさま): 驰走(달리고 일함)+様, 「음식을 준비해 주셔서 감사합니다」', '표현', 153, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ごちそうさまでした。', '잘 먹었습니다.', 1),
    (w, 'おいしかった、ごちそうさま。', '맛있었어요, 잘 먹었어요.', 2);

  -- 154. こちら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'こちら', '이쪽, 이 분, 이 사람', 'こ(이)+ちら(방향 접미), 「이쪽」 경어 대명사', '대명사', 154, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらへどうぞ。', '이쪽으로 오세요.', 1),
    (w, 'こちらは田中さんです。', '이분은 다나카 씨예요.', 2);

  -- 155. こちらこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'こちらこそ', '저야말로', 'こちら(이쪽)+こそ(강조 조사), 「저야말로」', '표현', 155, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらこそ、ありがとうございます。', '저야말로 감사합니다.', 1),
    (w, 'こちらこそ、よろしくお願いします。', '저야말로 잘 부탁드립니다.', 2);

  -- 156. さす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'さす', '(우산을) 쓰다, 받다', '差す(차 차)+す, 「우산을 펴서 내밀다」', '동사', 156, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あめなのでかさをさす。', '비가 와서 우산을 쓴다.', 1),
    (w, 'かさをさして歩く。', '우산을 쓰고 걷다.', 2);

  -- 157. 三回
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '三回', 'さんかい', '3회, 세 번', '三(석 삼): 가로획 세 개 → 셋\n回(돌 회): 빙빙 도는 모양 → 횟수', '명사', 157, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一週間に三回うんどうします。', '일주일에 세 번 운동합니다.', 1),
    (w, 'もう三回読みました。', '벌써 세 번 읽었어요.', 2);

  -- 158. 三冊
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '三冊', 'さんさつ', '세 권(책)', '三(석 삼): 셋\n冊(책 책): 죽간을 끈으로 묶은 모양 → 책', '명사', 158, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を三冊買いました。', '책을 세 권 샀어요.', 1),
    (w, 'まんがを三冊読みました。', '만화를 세 권 읽었어요.', 2);

  -- 159. 辞書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '辞書', 'じしょ', '사전', '辞(말씀 사): 말의 풀이\n書(쓸 서): 붓으로 쓴 책 → 말을 풀이한 책=사전', '명사', 159, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'じしょで漢字をしらべる。', '사전으로 한자를 찾는다.', 1),
    (w, 'あたらしいじしょを買った。', '새 사전을 샀다.', 2);

  -- 160. 静かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '静かに', 'しずかに', '조용히', '静(고요할 정): 青(푸름) + 争(다툼) → 다툼 없이 고요함', '부사', 160, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しずかにしてください。', '조용히 해 주세요.', 1),
    (w, 'しずかにドアをしめた。', '조용히 문을 닫았다.', 2);

  -- 161. 質問する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '質問する', 'しつもんする', '질문하다', '質(바탕 질): 斤(도끼) + 貝(조개) → 본질을 물음\n問(물을 문): 門(문) + 口(입) → 문 밖에서 물음', '동사', 161, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にしつもんします。', '선생님께 질문합니다.', 1),
    (w, 'なにかしつもんはありますか。', '뭔가 질문 있어요?', 2);

  -- 162. 閉める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '閉める', 'しめる', '(문을) 닫다', '閉(닫을 폐): 門(문) + 才(빗장) → 문에 빗장을 걸어 닫음', '동사', 162, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まどをしめてください。', '창문을 닫아 주세요.', 1),
    (w, 'お店は10時にしまります。', '가게는 10시에 닫아요.', 2);

  -- 163. 写真
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '写真', 'しゃしん', '사진', '写(베낄 사): 그대로 옮김\n真(참 진): 본래 모습 → 본래 모습을 그대로 옮긴 것=사진', '명사', 163, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しゃしんをとります。', '사진을 찍어요.', 1),
    (w, '家族のしゃしんをみせてください。', '가족 사진을 보여 주세요.', 2);

  -- 164. 上手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '上手', 'じょうず', '능숙함, 잘함', '上(윗 상): 위, 더 좋음\n手(손 수): 손 → 손재주가 좋음=잘함', 'な형용사', 164, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語がじょうずですね。', '일본어를 잘하시네요.', 1),
    (w, 'あねは料理がじょうずです。', '언니는 요리를 잘해요.', 2);

  -- 165. 丈夫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '丈夫', 'じょうぶ', '튼튼함', '丈(어른 장): 키 큰 사람\n夫(지아비 부): 어른 남자 → 단단하고 튼튼함', 'な형용사', 165, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このかばんはじょうぶです。', '이 가방은 튼튼해요.', 1),
    (w, '父はとてもじょうぶです。', '아버지는 매우 튼튼해요.', 2);

  -- 166. 吸う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '吸う', 'すう', '(담배를) 피우다, 들이마시다', '吸(마실 흡): 口(입) + 及(미침) → 입으로 안까지 빨아들임', '동사', 166, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タバコをすってはいけません。', '담배를 피우면 안 돼요.', 1),
    (w, '深く息をすってください。', '깊이 숨을 들이마셔 주세요.', 2);

  -- 167. スカート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'スカート', '스커트, 치마', '영어 skirt의 외래어', '명사', 167, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長いスカートをはく。', '긴 치마를 입다.', 1),
    (w, '赤いスカートを買った。', '빨간 치마를 샀다.', 2);

  -- 168. 好き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '好き', 'すき', '좋아함', '好(좋을 호): 女(여자) + 子(아이) → 여자가 아이를 안고 있음 → 좋음', 'な형용사', 168, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごが好きです。', '사과를 좋아해요.', 1),
    (w, '音楽が大好きです。', '음악을 정말 좋아해요.', 2);

  -- 169. スキー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'スキー', '스키', '영어 ski의 외래어', '명사', 169, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふゆはスキーをします。', '겨울에는 스키를 탑니다.', 1),
    (w, 'スキーがじょうずです。', '스키를 잘 타요.', 2);

  -- 170. すぐに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'すぐに', '곧, 바로', '直(す)ぐ에 「계속」의 に(조사), 「곧·즉시」', '부사', 170, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐに行きます。', '바로 갈게요.', 1),
    (w, 'すぐに返事をください。', '바로 답장해 주세요.', 2);

  -- 171. ストーブ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ストーブ', '스토브, 난로', '영어 stove의 외래어, 난로', '명사', 171, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふゆはストーブをつけます。', '겨울에는 난로를 켭니다.', 1),
    (w, 'ストーブのそばはあたたかい。', '난로 옆은 따뜻하다.', 2);

  -- 172. セーター
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'セーター', '스웨터', '영어 sweater의 외래어', '명사', 172, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あついからセーターをぬいだ。', '더워서 스웨터를 벗었다.', 1),
    (w, '母が新しいセーターを買ってくれた。', '어머니가 새 스웨터를 사 주셨다.', 2);

  -- 173. そば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'そば', '옆, 곁', '側(겯 측)/傍(겯 방), 「옆·겯」', '명사', 173, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅のそばに住んでいる。', '역 옆에 살고 있다.', 1),
    (w, '私のそばに来てください。', '제 옆에 와 주세요.', 2);

  -- 174. それでは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'それでは', '그럼', 'それ(그것)+で(조사)+は(조사), 「그럼·그렇다면」', '표현·접속사', 174, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それでは、はじめましょう。', '그럼 시작합시다.', 1),
    (w, 'それでは、また明日。', '그럼 또 내일 봐요.', 2);

  -- 175. 大丈夫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大丈夫', 'だいじょうぶ', '괜찮음', '大(큰 대): 큼\n丈(어른 장): 어른\n夫(지아비 부): 남자 → 큰 어른=든든하고 안전함', 'な형용사', 175, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だいじょうぶですか。', '괜찮아요?', 1),
    (w, 'もうだいじょうぶです。', '이제 괜찮아요.', 2);

  -- 176. 大切
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大切', 'たいせつ', '중요함, 소중함', '大(큰 대): 큰\n切(끊을 절): 절실함 → 매우 절실하고 중요함', 'な형용사', 176, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族はたいせつです。', '가족은 소중합니다.', 1),
    (w, '時間をたいせつにしてください。', '시간을 소중히 해 주세요.', 2);

  -- 177. 大抵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大抵', 'たいてい', '대체로, 대개', '大(큰 대): 큰\n抵(닿을 저): 大体의 의미 변형 → 대략적으로', '부사', 177, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たいてい朝六時に起きます。', '대개 아침 6시에 일어나요.', 1),
    (w, '土曜日はたいていうちにいる。', '토요일은 대개 집에 있다.', 2);

  -- 178. 大変
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '大変', 'たいへん', '힘듦, 큰일임', '大(큰 대): 큰\n変(변할 변): 큰 변고 → 매우 어려운 일', 'な형용사·부사', 178, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しごとがたいへんです。', '일이 힘들어요.', 1),
    (w, 'たいへんおいしいです。', '아주 맛있어요.', 2);

  -- 179. たくさん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'たくさん', '많이', '沁山(たくさん): 沁(스뱀 입)+山(메 산), 「산이 스머들 만큼 많음」', '부사·명사', 179, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たくさんの本があります。', '많은 책이 있어요.', 1),
    (w, 'たくさん食べてください。', '많이 드세요.', 2);

  -- 180. 楽しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '楽しい', 'たのしい', '즐겁다', '楽(즐거울 락): 木(나무) 위의 악기 모양 → 음악으로 즐거움', 'い형용사', 180, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パーティーはたのしかったです。', '파티는 즐거웠어요.', 1),
    (w, '友だちと話すのはたのしい。', '친구와 이야기하는 것은 즐겁다.', 2);

  -- 181. 多分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '多分', 'たぶん', '아마', '多(많을 다): 많음\n分(나눌 분): 부분 → 많은 부분에서 그러할 것=아마', '부사', 181, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たぶんあめがふります。', '아마 비가 올 거예요.', 1),
    (w, 'たぶん来ないとおもう。', '아마 안 올 것 같아.', 2);

  -- 182. だんだん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'だんだん', '점점, 점차', '段々(단단): 段(계단 단)의 반복, 「단계적으로·점점」', '부사', 182, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だんだんさむくなってきた。', '점점 추워지고 있다.', 1),
    (w, '日本語がだんだんわかるようになった。', '일본어를 점점 알아듣게 되었다.', 2);

  -- 183. 近い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '近い', 'ちかい', '가깝다', '近(가까울 근): 辶(가다) + 斤(도끼) → 도끼가 닿는 거리=가까움', 'い형용사', 183, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅はちかいです。', '역은 가까워요.', 1),
    (w, 'うちは学校にちかい。', '집은 학교에 가깝다.', 2);

  -- 184. 違います
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '違います', 'ちがいます', '아닙니다, 틀립니다', '違(어긋날 위): 辶(가다) + 韋(에워쌈) → 길이 어긋남=다름', '동사', 184, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいえ、ちがいます。', '아니요, 아닙니다.', 1),
    (w, '答えがちがいました。', '답이 틀렸어요.', 2);

  -- 185. 地図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '地図', 'ちず', '지도', '地(땅 지): 흙(土)이 펼쳐진 곳\n図(그림 도): 그려서 나타냄 → 땅을 그린 그림=지도', '명사', 185, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちずを見ながらあるく。', '지도를 보며 걷는다.', 1),
    (w, 'これは東京のちずです。', '이것은 도쿄의 지도예요.', 2);

  -- 186. ちょうど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ちょうど', '정각, 정확히', '丁度(ちょうど): 丁(의성어)+度(정도 도), 「딱 맞게·정확히」', '부사', 186, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちょうど三時です。', '정각 3시예요.', 1),
    (w, 'ちょうどいいおおきさです。', '딱 좋은 크기예요.', 2);

  -- 187. 疲れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '疲れる', 'つかれる', '피곤하다, 지치다', '疲(피로할 피): 疒(병) + 皮(가죽) → 몸이 약해져 지침', '동사', 187, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はつかれました。', '오늘은 피곤해요.', 1),
    (w, '長く歩いてつかれた。', '오래 걸어서 지쳤다.', 2);

  -- 188. 付く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '付く', 'つく', '(전기가) 켜지다, 붙다', '付(붙을 부): 亻(사람) + 寸(손) → 손으로 무엇을 붙임', '동사', 188, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気がつきました。', '불이 켜졌어요.', 1),
    (w, 'シャツによごれがついた。', '셔츠에 얼룩이 묻었다.', 2);

  -- 189. 冷たい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '冷たい', 'つめたい', '차갑다', '冷(찰 랭): 冫(얼음) + 令(명령) → 얼음처럼 차가움', 'い형용사', 189, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つめたい水をください。', '차가운 물 주세요.', 1),
    (w, '彼の手はつめたい。', '그의 손은 차갑다.', 2);

  -- 190. 強い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '強い', 'つよい', '강하다, 세다', '強(강할 강): 弓(활) + 厶 + 虫(벌레) → 단단하고 강함', 'い형용사', 190, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かぜがつよいですね。', '바람이 세네요.', 1),
    (w, '兄はつよいです。', '형은 힘이 세요.', 2);

  -- 191. デパート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'デパート', '백화점', 'デパートメントストア(department store)의 줄임말', '명사', 191, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デパートでかいものをする。', '백화점에서 쇼핑을 한다.', 1),
    (w, 'デパートは八階まであります。', '백화점은 8층까지 있어요.', 2);

  -- 192. でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'でも', '하지만, 그렇지만', 'で(조사)+も(조사), 「であっても(~이라 해도)」의 준말로 「하지만」', '접속사', 192, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いそがしいです。でも、行きます。', '바빠요. 그래도 갈게요.', 1),
    (w, 'おいしいです。でも、たかいです。', '맛있어요. 하지만 비싸요.', 2);

  -- 193. どういたしまして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'どういたしまして', '천만에요', 'どう(어떻게)+致しまして(したの겸양어), 「제가 뭐를 한게 있나요」→「천만에요」', '표현', 193, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいえ、どういたしまして。', '아니요, 천만에요.', 1),
    (w, 'どういたしまして、また来てください。', '천만에요, 또 오세요.', 2);

  -- 194. 遠い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '遠い', 'とおい', '멀다', '遠(멀 원): 辶(가다) + 袁(긴 옷자락) → 옷자락이 길게 끌리듯 먼 거리', 'い형용사', 194, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅はとおいです。', '역은 멀어요.', 1),
    (w, 'とおいくにから来ました。', '먼 나라에서 왔어요.', 2);

  -- 195. 時々
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '時々', 'ときどき', '때때로', '時(때 시) + 々(반복) → 때와 때 → 가끔, 때때로', '부사', 195, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ときどき母に電話します。', '때때로 어머니께 전화해요.', 1),
    (w, '日本語をときどき勉強する。', '일본어를 가끔 공부한다.', 2);

  -- 196. どちら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'どちら', '어느 쪽, 어느 분', 'ど(어느)+ちら(방향 접미), 「어느 쪽」 경어 대명사', '대명사', 196, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お国はどちらですか。', '고향은 어디입니까?', 1),
    (w, 'どちらがいいですか。', '어느 쪽이 좋아요?', 2);

  -- 197. 飛ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '飛ぶ', 'とぶ', '날다', '飛(날 비): 새가 날개를 펴고 나는 모양', '동사', 197, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鳥が空をとんでいる。', '새가 하늘을 날고 있다.', 1),
    (w, '飛行機がとびました。', '비행기가 날아갔어요.', 2);

  -- 198. 止まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '止まる', 'とまる', '멈추다', '止(그칠 지): 발의 모양 → 발이 멈춘 상태', '동사', 198, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が駅にとまる。', '전철이 역에 멈춘다.', 1),
    (w, '時計がとまっている。', '시계가 멈춰 있다.', 2);

  -- 199. 取る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '取る', 'とる', '집다, 잡다, 취하다', '取(가질 취): 耳(귀) + 又(손) → 손으로 귀를 잡음 → 잡다', '동사', 199, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しおをとってください。', '소금을 집어 주세요.', 1),
    (w, 'メモを取ります。', '메모를 합니다.', 2);

  -- 200. 撮る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '撮る', 'とる', '(사진·영화를) 찍다', '撮(취할 촬): 扌(손) + 最(가장) → 손으로 가장 좋은 순간을 잡음=찍다', '동사', 200, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を一まいとってください。', '사진을 한 장 찍어 주세요.', 1),
    (w, '映画をとっています。', '영화를 찍고 있어요.', 2);

  -- 201. ナイフ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ナイフ', '나이프, 칼', '영어 knife의 외래어', '명사', 201, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ナイフでパンを切る。', '나이프로 빵을 자른다.', 1),
    (w, 'ナイフとフォークを使います。', '나이프와 포크를 사용해요.', 2);

  -- 202. 習う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '習う', 'ならう', '배우다, 익히다', '習(익힐 습): 羽(깃털) + 白(스스로) → 새가 자주 날갯짓을 익힘=배우다', '동사', 202, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語をならっています。', '일본어를 배우고 있어요.', 1),
    (w, '先生に漢字をならった。', '선생님께 한자를 배웠다.', 2);

  -- 203. 並べる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '並べる', 'ならべる', '나란히 놓다, 진열하다', '並(나란할 병): 사람(立) 두 명이 나란히 선 모양 → 가지런히 놓다', '동사', 203, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テーブルに料理をならべる。', '테이블에 요리를 늘어놓는다.', 1),
    (w, '本を本だなにならべました。', '책을 책장에 진열했어요.', 2);

  -- 204. 何個
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '何個', 'なんこ', '몇 개', '何(어찌 하): 무엇\n個(낱 개): 사물의 단위 → 몇 개', '명사', 204, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごはなんこありますか。', '사과는 몇 개 있어요?', 1),
    (w, 'いすはなんこいりますか。', '의자는 몇 개 필요해요?', 2);

  -- 205. 二階
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二階', 'にかい', '2층', '二(두 이): 둘\n階(섬돌 계): 阝(언덕) + 皆(모두) → 층계 → 2층', '명사', 205, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'へやは二階にあります。', '방은 2층에 있어요.', 1),
    (w, '二階でべんきょうします。', '2층에서 공부합니다.', 2);

  -- 206. にキロ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'にキロ', '2킬로미터/2킬로그램', '二(이)+キロ(그리스어 접두 kilo, 천), 「2키로」', '명사', 206, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで二キロあります。', '역까지 2킬로미터 있어요.', 1),
    (w, 'りんごを二キロ買いました。', '사과를 2킬로 샀어요.', 2);

  -- 207. 二冊
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二冊', 'にさつ', '두 권(잡지)', '二(두 이): 둘\n冊(책 책): 죽간 묶음 → 책 두 권', '명사', 207, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ざっしを二さつ買いました。', '잡지를 두 권 샀어요.', 1),
    (w, '本を二さつ読んだ。', '책을 두 권 읽었다.', 2);

  -- 208. 二台
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二台', 'にだい', '두 대(자전거·차)', '二(두 이): 둘\n台(대 대): 받침대 → 차량의 단위', '명사', 208, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が二だいあります。', '차가 두 대 있어요.', 1),
    (w, 'じてんしゃを二だい買いました。', '자전거를 두 대 샀어요.', 2);

  -- 209. 二匹
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二匹', 'にひき', '두 마리(작은 동물)', '二(두 이): 둘\n匹(짝 필): 작은 동물의 단위 → 두 마리', '명사', 209, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ねこが二ひきいます。', '고양이가 두 마리 있어요.', 1),
    (w, '魚を二ひきつりました。', '물고기를 두 마리 낚았어요.', 2);

  -- 210. 登る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '登る', 'のぼる', '(산을) 오르다', '登(오를 등): 두 발(癶)이 그릇(豆) 위로 오름 → 위로 오름', '동사', 210, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山にのぼります。', '산에 오릅니다.', 1),
    (w, '日曜日に山をのぼった。', '일요일에 산을 올랐다.', 2);

  -- 211. 飲み物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '飲み物', 'のみもの', '마실 것', '飲(마실 음): 입을 벌려 마심\n物(만물 물): 물건 → 마실 것', '명사', 211, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'のみものは何にしますか。', '음료는 뭐로 하시겠어요?', 1),
    (w, 'つめたいのみものがほしい。', '차가운 음료가 마시고 싶다.', 2);

  -- 212. 乗る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '乗る', 'のる', '(차·비행기를) 타다', '乗(탈 승): 사람(大)이 나무(木) 위에 올라탄 모양', '동사', 212, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'バスにのって行きます。', '버스를 타고 갑니다.', 1),
    (w, '電車にのりました。', '전철을 탔어요.', 2);

  -- 213. パーティー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'パーティー', '파티', '영어 party의 외래어', '명사', 213, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はパーティーがあります。', '오늘은 파티가 있어요.', 1),
    (w, 'パーティーはたのしかったです。', '파티는 즐거웠어요.', 2);

  -- 214. はく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'はく', '(바지·신발·양말을) 입다, 신다', '履く(밟을 리)+く, 「하의·신발을 입다」', '동사', 214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ズボンをはきます。', '바지를 입습니다.', 1),
    (w, '新しいくつをはいた。', '새 신발을 신었다.', 2);

  -- 215. 橋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '橋', 'はし', '다리, 교량', '橋(다리 교): 木(나무) + 喬(높음) → 높이 걸친 나무다리', '명사', 215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はしをわたります。', '다리를 건넙니다.', 1),
    (w, 'この川にはしがあります。', '이 강에 다리가 있어요.', 2);

  -- 216. 初めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '初めて', 'はじめて', '처음으로', '初(처음 초): 衣(옷) + 刀(칼) → 처음 옷을 마름질함=처음', '부사', 216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はじめて日本へ行きます。', '처음으로 일본에 갑니다.', 1),
    (w, 'はじめておすしを食べた。', '처음으로 초밥을 먹었다.', 2);

  -- 217. 二十歳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二十歳', 'はたち', '20세, 스무 살', '二十(이십): 스물\n歳(해 세): 한 살의 단위 → 스무 살', '명사', 217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'むすめは今年はたちです。', '딸은 올해 스무 살이에요.', 1),
    (w, 'はたちでだいがくに入った。', '스무 살에 대학에 들어갔다.', 2);

  -- 218. 八十円
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '八十円', 'はちじゅうえん', '80엔', '八(여덟 팔): 여덟\n十(열 십): 열\n円(둥글 원): 일본 화폐 단위', '명사', 218, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは八十円です。', '이것은 80엔이에요.', 1),
    (w, 'きってを八十円分ください。', '우표를 80엔어치 주세요.', 2);

  -- 219. 貼る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '貼る', 'はる', '붙이다', '貼(붙일 첩): 貝(돈) + 占(차지함) → 종이를 붙이는 동작', '동사', 219, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手紙にきってをはる。', '편지에 우표를 붙인다.', 1),
    (w, 'かべにポスターをはった。', '벽에 포스터를 붙였다.', 2);

  -- 220. ピアノ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ピアノ', '피아노', '이탈리아어 piano의 외래어', '명사', 220, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いもうとはピアノがじょうずです。', '여동생은 피아노를 잘 쳐요.', 1),
    (w, '毎日ピアノを練習する。', '매일 피아노를 연습한다.', 2);

  -- 221. 暇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '暇', 'ひま', '한가함, 틈, 여가', '暇(겨를 가): 日(해) + 叚(빌릴 가) → 햇빛을 빌릴 만한 여유=한가함', 'な형용사·명사', 221, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はひまです。', '오늘은 한가해요.', 1),
    (w, 'ひまな時に本を読みます。', '한가할 때 책을 읽어요.', 2);

  -- 222. プール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'プール', '풀, 수영장', '영어 pool의 외래어, 수영장', '명사', 222, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プールでおよぎたい。', '수영장에서 헤엄치고 싶다.', 1),
    (w, '夏はよくプールへ行く。', '여름에는 자주 수영장에 간다.', 2);

  -- 223. 吹く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '吹く', 'ふく', '(바람이) 불다', '吹(불 취): 口(입) + 欠(입을 벌림) → 입으로 불어냄', '동사', 223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つよいかぜがふいている。', '강한 바람이 불고 있다.', 1),
    (w, '今日はかぜがふきません。', '오늘은 바람이 불지 않아요.', 2);

  -- 224. 二日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '二日', 'ふつか', '2일, 이틀', '二(두 이): 둘\n日(날 일): 해 → 둘째 날, 또는 이틀', '명사', 224, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月のふつかにあいましょう。', '이번 달 2일에 만나요.', 1),
    (w, 'ふつかかかりました。', '이틀 걸렸어요.', 2);

  -- 225. ページ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ページ', '페이지, 쪽', '영어 page의 외래어, 쪽', '명사', 225, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '十ページを開いてください。', '10페이지를 펴 주세요.', 1),
    (w, 'この本は二百ページあります。', '이 책은 200페이지예요.', 2);

  -- 226. 便利
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '便利', 'べんり', '편리함', '便(편할 편): 亻(사람) + 更(고침) → 사람에게 편함\n利(이로울 리): 禾(벼) + 刂(칼) → 벼를 베는 칼이 잘 듦=쓸모 있음', 'な형용사', 226, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このまちはべんりです。', '이 동네는 편리해요.', 1),
    (w, 'スマホはとてもべんりだ。', '스마트폰은 매우 편리하다.', 2);

  -- 227. 帽子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '帽子', 'ぼうし', '모자', '帽(모자 모): 巾(천) + 冒(덮음) → 머리를 덮는 천\n子(아들 자): 작은 물건의 접미사', '명사', 227, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼうしをかぶっている。', '모자를 쓰고 있다.', 1),
    (w, '赤いぼうしを買いました。', '빨간 모자를 샀어요.', 2);

  -- 228. ほしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ほしい', '갖고 싶다, 원하다', '欲しい(ほしい): 欲(하고자 할 욕)+しい(형용사 어미), 「갖고 싶다」', 'い형용사', 228, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい車がほしい。', '새 차가 갖고 싶다.', 1),
    (w, '何がほしいですか。', '뭐가 갖고 싶어요?', 2);

  -- 229. 細い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '細い', 'ほそい', '가늘다', '細(가늘 세): 糸(실) + 田(밭) → 가늘게 자아낸 실', 'い형용사', 229, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ほそい道をあるく。', '좁은 길을 걷는다.', 1),
    (w, '彼女のゆびはほそい。', '그녀의 손가락은 가늘다.', 2);

  -- 230. 本屋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '本屋', 'ほんや', '책방, 서점', '本(근본 본): 책\n屋(집 옥): 건물 → 책을 파는 가게', '명사', 230, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅のとなりに本屋があります。', '역 옆에 서점이 있어요.', 1),
    (w, '本屋でまんがを買った。', '서점에서 만화를 샀다.', 2);

  -- 231. 毎週
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '毎週', 'まいしゅう', '매주', '毎(매양 매): 늘 같음\n週(주일 주): 한 주일 → 매주', '명사', 231, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎週日曜日にうんどうします。', '매주 일요일에 운동합니다.', 1),
    (w, '毎週母に電話する。', '매주 어머니께 전화한다.', 2);

  -- 232. 曲がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '曲がる', 'まがる', '돌다, (방향을) 틀다', '曲(굽을 곡): 굽은 막대 모양 → 길이 굽음', '동사', 232, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つぎの角を右にまがってください。', '다음 모퉁이에서 오른쪽으로 도세요.', 1),
    (w, '道がまがっています。', '길이 굽어 있어요.', 2);

  -- 233. また
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'また', '또, 다시', '又(또 우)에서 온 부사, 「또·다시」', '부사', 233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'また明日。', '또 내일 봐.', 1),
    (w, 'また日本へ行きたいです。', '또 일본에 가고 싶어요.', 2);

  -- 234. まっすぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'まっすぐ', '똑바로, 곧장', '真(윕 진)+すぐ(곧), 「곧장·똑바로」', '부사', 234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まっすぐ行ってください。', '똑바로 가세요.', 1),
    (w, '学校からまっすぐうちへ帰る。', '학교에서 곧장 집으로 돌아간다.', 2);

  -- 235. 窓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '窓', 'まど', '창문', '窓(창 창): 穴(구멍) + 心(마음) → 빛이 들어오는 마음의 구멍=창', '명사', 235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まどをあけてください。', '창문을 열어 주세요.', 1),
    (w, 'まどから山が見える。', '창문에서 산이 보인다.', 2);

  -- 236. 磨く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '磨く', 'みがく', '(이를) 닦다, 갈다', '磨(갈 마): 麻(삼) + 石(돌) → 삼처럼 잘게 갈고 닦음', '동사', 236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝はをみがきます。', '매일 아침 이를 닦습니다.', 1),
    (w, 'くつをきれいにみがいた。', '신발을 깨끗하게 닦았다.', 2);

  -- 237. もっと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'もっと', '좀 더, 더', 'もっと는 「굙장히」 의미의 부사, 「좀 더」로 발전', '부사', 237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと食べてください。', '좀 더 드세요.', 1),
    (w, 'もっと勉強したいです。', '더 공부하고 싶어요.', 2);

  -- 238. 野菜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '野菜', 'やさい', '야채', '野(들 야): 里(마을) + 予(주다) → 들에서 자란 것\n菜(나물 채): 艹(풀) + 采(캐다) → 채소', '명사', 238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やさいをたくさん食べる。', '야채를 많이 먹는다.', 1),
    (w, 'スーパーでやさいを買った。', '슈퍼에서 야채를 샀다.', 2);

  -- 239. 夕べ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '夕べ', 'ゆうべ', '어젯밤, 저녁', '夕(저녁 석): 초승달이 보이는 모양 → 저녁', '명사', 239, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ゆうべおそくまで勉強した。', '어젯밤 늦게까지 공부했다.', 1),
    (w, 'ゆうべは早く寝ました。', '어젯밤은 일찍 잤어요.', 2);

  -- 240. ゆっくり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ゆっくり', '천천히, 푹', '의태어 ゆっくり, 여유롭고 느린 모양', '부사', 240, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ゆっくり話してください。', '천천히 말해 주세요.', 1),
    (w, '今日はゆっくり休みます。', '오늘은 푹 쉬어요.', 2);

  -- 241. 八日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '八日', 'ようか', '8일, 여드레', '八(여덟 팔): 여덟\n日(날 일): 해 → 8일째 또는 여드레', '명사', 241, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月のようかに会いましょう。', '이번 달 8일에 만나요.', 1),
    (w, 'ようかかかりました。', '여드레 걸렸어요.', 2);

  -- 242. ラジオ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'ラジオ', '라디오', '영어 radio의 외래어', '명사', 242, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝はラジオを聞きます。', '아침에는 라디오를 듣습니다.', 1),
    (w, 'ラジオでニュースを聞いた。', '라디오에서 뉴스를 들었다.', 2);

  -- 243. 立派
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '立派', 'りっぱ', '훌륭함', '立(설 립): 똑바로 섬\n派(갈래 파): 흐름의 갈래 → 당당히 선 모습=훌륭함', 'な형용사', 243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りっぱな家ですね。', '훌륭한 집이네요.', 1),
    (w, '父はりっぱな人です。', '아버지는 훌륭한 분이에요.', 2);

  -- 244. 料理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '料理', 'りょうり', '요리', '料(헤아릴 료): 米(쌀) + 斗(말) → 식재료를 헤아림\n理(다스릴 리): 玉(옥) + 里(마을) → 잘 정리함 → 요리', '명사', 244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本のりょうりが好きです。', '일본 요리를 좋아해요.', 1),
    (w, '母はりょうりがじょうずだ。', '어머니는 요리를 잘하신다.', 2);

  -- 245. 若い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '若い', 'わかい', '젊다', '若(같을 약/젊을 약): 艹(풀) + 右(손) → 풀처럼 어리고 푸르름=젊음', 'い형용사', 245, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父はわかく見えます。', '아버지는 젊어 보여요.', 1),
    (w, '彼はまだわかいです。', '그는 아직 젊어요.', 2);

  -- 246. 忘れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '忘れる', 'わすれる', '잊다', '忘(잊을 망): 亡(없을 망) + 心(마음) → 마음에서 사라짐=잊음', '동사', 246, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前をわすれました。', '이름을 잊어버렸어요.', 1),
    (w, 'かさを電車にわすれた。', '우산을 전철에 두고 내렸다.', 2);

  -- 247. 渡す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '渡す', 'わたす', '건네다, 전달하다', '渡(건널 도): 氵(물) + 度(건너감) → 물건너 건네줌', '동사', 247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちに本をわたした。', '친구에게 책을 건넸다.', 1),
    (w, 'これを先生にわたしてください。', '이것을 선생님께 전해 주세요.', 2);

  -- 248. 渡る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '渡る', 'わたる', '건너다', '渡(건널 도): 氵(물) + 度(건너감) → 물을 건너감', '동사', 248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はしをわたります。', '다리를 건넙니다.', 1),
    (w, '道をわたるときは気をつけて。', '길을 건널 때는 조심해.', 2);

  -- ============================================================
  -- 문맥 규정 관용구 (#249~254): PDF 문맥 규정 섹션의 6개 구·관용 표현
  -- 단어 추출이 아닌 「표현 그대로」 외울 수 있도록 통째로 저장
  -- ============================================================

  -- 249. お風呂に入る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, 'お風呂に入る', 'おふろにはいる', '목욕하다', 'お風呂(욕조) + に + 入る(들어가다)\n욕조에 들어간다는 행위가 곧 목욕', '관용구', 249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎晩おふろに入ります。', '매일 밤 목욕합니다.', 1),
    (w, '子どもがおふろに入っている。', '아이가 목욕하고 있다.', 2);

  -- 250. 風邪をひく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '風邪をひく', 'かぜをひく', '감기에 걸리다', '風邪(감기) + を + 引く(끌어들이다)\n바람(병)을 몸으로 끌어들임=감기에 걸림', '관용구', 250, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒くてかぜをひきました。', '추워서 감기에 걸렸습니다.', 1),
    (w, 'かぜをひかないように気をつけて。', '감기에 걸리지 않도록 조심해.', 2);

  -- 251. シャワーを浴びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, 'シャワーを浴びる', 'シャワーをあびる', '샤워하다', 'シャワー(샤워) + を + 浴びる(끼얹다)\n물을 몸에 끼얹는 행위', '관용구', 251, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝シャワーを浴びます。', '아침에 샤워합니다.', 1),
    (w, '運動の後シャワーを浴びた。', '운동 후 샤워했다.', 2);

  -- 252. 新聞を読む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '新聞を読む', 'しんぶんをよむ', '신문을 읽다', '新聞(신문) + を + 読む(읽다)\n매일 발행되는 활자 매체로 정보를 얻는 행위', '관용구', 252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝しんぶんを読みます。', '매일 아침 신문을 읽습니다.', 1),
    (w, '父はいつもしんぶんを読んでいる。', '아버지는 항상 신문을 읽고 계신다.', 2);

  -- 253. どうぞよろしく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, NULL, 'どうぞよろしく', '잘 부탁합니다', 'どうぞ(부디) + よろしく(잘 ~해 주세요)\n첫 인사·부탁 시 쓰는 정형 표현', '관용구', 253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はじめまして、どうぞよろしく。', '처음 뵙겠습니다, 잘 부탁합니다.', 1),
    (w, 'これからどうぞよろしくお願いします。', '앞으로 잘 부탁드립니다.', 2);

  -- 254. 勉強がしたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n5, '勉強がしたい', 'べんきょうがしたい', '공부를 하고 싶다', '勉強(공부) + が + したい(~하고 싶다)\n학습 의욕을 나타내는 정형 표현', '관용구', 254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語のべんきょうがしたいです。', '일본어 공부를 하고 싶어요.', 1),
    (w, 'もっとべんきょうがしたい。', '더 공부하고 싶다.', 2);
  -- ============================================================
  -- 유의어 페어 (#255~382): PDF 「≒」 64쌍을 양쪽 모두 자체 단어 entry 로 등록
  -- 각 표현 은 자체 한자 어원/구조 설명 + 예문 2개 보유
  -- 두 표현 사이의 관계는 word_relations 에 synonym 으로 양방향 등록
  -- ============================================================

  -- 페어 1: 明るくしてください ≒ 電気をつけてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '明るくしてください', 'あかるくしてください', '밝게 해 주세요', '明(밝을 명): 日(해)+月(달)이 함께 빛남 → 밝다. 「い형용사 어간+くする」=~게 하다, 「~てください」=정중한 요청', '유의 표현', 255, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '部屋を明るくしてください。', '방을 밝게 해 주세요.', 1),
    (w1, '画面をもう少し明るくしてください。', '화면을 조금만 더 밝게 해 주세요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '電気をつけてください', 'でんきをつけてください', '전기를 켜 주세요', '電(번개 전): 雨(비)+电(펼친 모양) → 전기/번개. 「~をつける」=~을 켜다 + 「~てください」', '유의 표현', 256, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋に入って電気をつけた。', '방에 들어가서 전기를 켰다.', 1),
    (w2, '暗いから電気をつけてください。', '어두우니까 전기를 켜 주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '방을 밝게 하는 가장 흔한 방법이 전기를 켜는 것이므로 동일 의미', 1),
    (w2, w1, 'synonym', '방을 밝게 하는 가장 흔한 방법이 전기를 켜는 것이므로 동일 의미', 1);

  -- 페어 2: あまり寒くありません ≒ 少し寒いです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'あまり寒くありません', 'あまりさむくありません', '그다지 춥지 않습니다', 'あまり~ない=「그다지 ~하지 않다」(정도가 적음). 寒(찰 한): 사람이 풀 속에 떨고 있는 모습', '유의 표현', 257, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '今日はあまりさむくありません。', '오늘은 그다지 춥지 않습니다.', 1),
    (w1, '部屋はあまりさむくありません。', '방은 그다지 춥지 않습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '少し寒いです', 'すこしさむいです', '조금 춥습니다', '少(적을 소): 작은 점들이 흩어진 모습 → 조금. 寒(찰 한): 추울 寒. 정도 부사 「少し」+い형용사', '유의 표현', 258, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '少しさむいですね。', '조금 춥네요.', 1),
    (w2, '今朝は少しさむかった。', '오늘 아침은 조금 추웠다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '「あまり~ない」(그다지 ~않다)는 정도가 적음 → 「少し~」(조금 ~)와 의미가 통함', 1),
    (w2, w1, 'synonym', '「あまり~ない」(그다지 ~않다)는 정도가 적음 → 「少し~」(조금 ~)와 의미가 통함', 1);

  -- 페어 3: いい天気だ ≒ 晴れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'いい天気だ', 'いいてんきだ', '좋은 날씨이다', '天(하늘 천)+気(기운 기) → 하늘의 기운=날씨. いい(좋다, 良い의 구어형) 수식', '유의 표현', 259, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '今日はいい天気だ。', '오늘은 좋은 날씨다.', 1),
    (w1, '明日もいい天気だといいな。', '내일도 좋은 날씨이면 좋겠다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '晴れる', 'はれる', '개다, 맑다', '晴(맑을 청): 日(해)+青(푸를 청) → 푸른 하늘에 해가 비치는 모습. 자동사 1그룹', '유의 표현', 260, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '雨がやんで晴れた。', '비가 그치고 갰다.', 1),
    (w2, '明日は晴れるでしょう。', '내일은 맑을 것입니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '좋은 날씨란 비가 그치고 맑게 갠 상태', 1),
    (w2, w1, 'synonym', '좋은 날씨란 비가 그치고 맑게 갠 상태', 1);

  -- 페어 4: 家を出る ≒ 出かける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '家を出る', 'いえをでる', '집을 나서다', '家(집 가): 宀(지붕)+豕(돼지) → 가축을 기르던 집. 出(날 출): 발(止)이 문지방을 넘는 모습', '유의 표현', 261, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '8時に家を出る。', '8시에 집을 나선다.', 1),
    (w1, '朝早く家を出ました。', '아침 일찍 집을 나섰습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '出かける', 'でかける', '외출하다', '出(날 출)+かける(걸치다/시작하다) → 나가기 시작함=외출. 복합 자동사', '유의 표현', 262, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '父はもう出かけました。', '아버지는 이미 외출하셨어요.', 1),
    (w2, '友だちと買い物に出かける。', '친구와 쇼핑하러 외출한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '집 밖으로 나가는 행위가 곧 외출', 1),
    (w2, w1, 'synonym', '집 밖으로 나가는 행위가 곧 외출', 1);

  -- 페어 5: いただきます ≒ ご飯を食べます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'いただきます', '잘 먹겠습니다', '頂く(받다)의 정중형 → 「(은혜를 받아) 먹겠습니다」. 식사 시작 인사', '유의 표현', 263, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'では、いただきます。', '그럼, 잘 먹겠습니다.', 1),
    (w1, '手を合わせて「いただきます」と言う。', '손을 모으고 "잘 먹겠습니다"라고 한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ご飯を食べます', 'ごはんをたべます', '밥을 먹습니다', '飯(밥 반): 食(먹을 식)+反(돌이킬 반) → 먹는 것. 「ご飯を食べる」=식사하다의 기본 표현', '유의 표현', 264, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '7時にごはんを食べます。', '7시에 밥을 먹습니다.', 1),
    (w2, '家族とごはんを食べた。', '가족과 밥을 먹었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '식사 시작 인사 「いただきます」는 곧 식사를 시작한다는 의미', 1),
    (w2, w1, 'synonym', '식사 시작 인사 「いただきます」는 곧 식사를 시작한다는 의미', 1);

  -- 페어 6: 入り口はあちらです ≒ あちらから入ってください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '入り口はあちらです', 'いりぐちはあちらです', '입구는 저쪽입니다', '入(들 입): 안으로 들어가는 모습. 口(입 구): 입·구멍. 「入り口」=들어가는 구멍=입구', '유의 표현', 265, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '入り口はあちらです。', '입구는 저쪽입니다.', 1),
    (w1, 'お店の入り口はあちらです。', '가게 입구는 저쪽입니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'あちらから入ってください', 'あちらからはいってください', '저쪽에서 들어가 주세요', 'あちら(저쪽, 원칭) + から(에서) + 入る(들어가다). 방향 안내 + 정중한 요청', '유의 표현', 266, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'あちらから入ってください。', '저쪽에서 들어가 주세요.', 1),
    (w2, 'すみません、あちらから入ってください。', '죄송합니다, 저쪽에서 들어가 주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '입구 위치를 알려주는 표현은 곧 그 방향에서 들어오라는 안내', 1),
    (w2, w1, 'synonym', '입구 위치를 알려주는 표현은 곧 그 방향에서 들어오라는 안내', 1);

  -- 페어 7: おじは65歳です ≒ 母の兄は65歳です
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'おじは65歳です', 'おじはろくじゅうごさいです', '삼촌은 65세입니다', 'おじ(伯父/叔父): 부모의 남자 형제(아저씨·삼촌). 歳(해 세): 나이', '유의 표현', 267, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おじは65歳です。', '삼촌은 65세입니다.', 1),
    (w1, 'うちのおじは元気です。', '우리 삼촌은 건강하십니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '母の兄は65歳です', 'ははのあにはろくじゅうごさいです', '엄마의 오빠는 65세입니다', '母(어머니 모): 두 점은 가슴 → 어머니. 兄(맏 형): 입(口)을 크게 벌린 사람=형/오빠', '유의 표현', 268, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '母の兄は65歳です。', '엄마의 오빠는 65세입니다.', 1),
    (w2, '母の兄は田舎に住んでいる。', '엄마의 오빠는 시골에 살고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'おじ는 부모의 남자 형제이므로 「엄마의 오빠」도 おじ에 해당', 1),
    (w2, w1, 'synonym', 'おじ는 부모의 남자 형제이므로 「엄마의 오빠」도 おじ에 해당', 1);

  -- 페어 8: お手洗い ≒ トイレ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'お手洗い', 'おてあらい', '화장실(손 씻는 곳)', 'お+手(손 수)+洗い(씻을 세) → 「손 씻는 곳」이라는 일본식 완곡 표현', '유의 표현', 269, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'お手洗いはどこですか。', '화장실은 어디예요?', 1),
    (w1, 'お手洗いをお借りしてもいいですか。', '화장실 좀 써도 될까요?', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'トイレ', '화장실(외래어)', '영어 toilet 의 카타카나 표기. 일상적/구어적 표현', '유의 표현', 270, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'トイレに行ってきます。', '화장실에 다녀올게요.', 1),
    (w2, 'トイレはあちらです。', '화장실은 저쪽이에요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '둘 다 화장실. 「お手洗い」는 일본식 정중 표현, 「トイレ」는 외래어 구어 표현', 1),
    (w2, w1, 'synonym', '둘 다 화장실. 「お手洗い」는 일본식 정중 표현, 「トイレ」는 외래어 구어 표현', 1);

  -- 페어 9: おととい ≒ 二日前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'おととい', '그저께', '「をととひ(遠つ日)」→ 「먼 날」에서 유래. 어제(きのう)의 前(전)날', '유의 표현', 271, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おとといは雨でした。', '그저께는 비가 왔습니다.', 1),
    (w1, 'おとといから熱があります。', '그저께부터 열이 있어요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '二日前', 'ふつかまえ', '이틀 전', '二(두 이)+日(날 일)+前(앞 전) → 두 날 앞. 二日 의 특수 읽기 「ふつか」 주의', '유의 표현', 272, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ふつか前に友だちに会った。', '이틀 전에 친구를 만났다.', 1),
    (w2, 'ふつか前から雨が降っている。', '이틀 전부터 비가 내리고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '오늘 기준 2일 전의 날=おととい=ふつか前', 1),
    (w2, w1, 'synonym', '오늘 기준 2일 전의 날=おととい=ふつか前', 1);

  -- 페어 10: おととし生まれた ≒ 二年前に生まれた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'おととし生まれた', 'おととしうまれた', '재작년에 태어났다', 'おととし(一昨年)=작년의 작년. 生(날 생): 풀이 땅 위로 솟는 모습 → 태어남', '유의 표현', 273, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おととし弟が生まれた。', '재작년에 남동생이 태어났다.', 1),
    (w1, 'おととしうちの子が生まれた。', '재작년에 우리 아이가 태어났다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '二年前に生まれた', 'にねんまえにうまれた', '2년 전에 태어났다', '二(두 이)+年(해 년)+前(앞 전) → 2년 앞. 「~に生まれる」=~에 태어나다', '유의 표현', 274, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '二年前にうまれた。', '2년 전에 태어났다.', 1),
    (w2, '二年前に弟が生まれた。', '2년 전에 남동생이 태어났다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'おととし(재작년)=작년의 작년=2년 전', 1),
    (w2, w1, 'synonym', 'おととし(재작년)=작년의 작년=2년 전', 1);

  -- 페어 11: おばさん ≒ お母さんの妹さん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'おばさん', '이모/고모(부모의 자매)', 'お+ば(伯母/叔母)+さん. 부모의 여자 형제. 친근한 호칭', '유의 표현', 275, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おばさんが来ます。', '이모가 옵니다.', 1),
    (w1, 'おばさんから手紙が届いた。', '이모로부터 편지가 도착했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'お母さんの妹さん', 'おかあさんのいもうとさん', '어머니의 여동생', '母(어머니 모)+妹(누이 매): 女(여자)+未(아직)=아직 어린 여자=여동생', '유의 표현', 276, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'お母さんの妹さんはやさしい。', '어머니의 여동생은 자상하시다.', 1),
    (w2, 'お母さんの妹さんに会った。', '어머니의 여동생을 만났다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'おばさん은 부모의 자매. 「엄마의 여동생」도 おばさん에 해당', 1),
    (w2, w1, 'synonym', 'おばさん은 부모의 자매. 「엄마의 여동생」도 おばさん에 해당', 1);

  -- 페어 12: おやすみなさい ≒ 今から寝ます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'おやすみなさい', '안녕히 주무세요', 'お+休み(쉼)+なさい(명령 정중형) → 「쉬세요」=잘 자라는 인사', '유의 표현', 277, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'お父さん、おやすみなさい。', '아버지, 안녕히 주무세요.', 1),
    (w1, '「おやすみなさい」と言って部屋に入った。', '"안녕히 주무세요"라고 말하고 방에 들어갔다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '今から寝ます', 'いまからねます', '지금부터 잡니다', '今(이제 금): 사람이 입을 닫는 모습=지금. 寝(잘 침): 집(宀) 안에 사람이 누운 모습', '유의 표현', 278, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '今から寝ます。', '지금부터 잡니다.', 1),
    (w2, '疲れたから今から寝ます。', '피곤하니까 지금부터 자겠습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '잠자기 전 인사 「おやすみなさい」는 곧 잠을 자겠다는 의미', 1),
    (w2, w1, 'synonym', '잠자기 전 인사 「おやすみなさい」는 곧 잠을 자겠다는 의미', 1);

  -- 페어 13: 貸してください ≒ 借りたいです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '貸してください', 'かしてください', '빌려 주세요', '貸(빌릴 대): 代(대신)+貝(돈) → 돈을 대신 내어줌=빌려줌. 「~てください」=정중한 요청', '유의 표현', 279, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '本を貸してください。', '책을 빌려 주세요.', 1),
    (w1, 'ペンを貸してください。', '펜을 빌려 주세요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '借りたいです', 'かりたいです', '빌리고 싶습니다', '借(빌릴 차): 人+昔(옛) → 잠시 가져다 씀=빌림. 「~たい」=~하고 싶다', '유의 표현', 280, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '本を借りたいです。', '책을 빌리고 싶어요.', 1),
    (w2, 'お金を借りたい。', '돈을 빌리고 싶다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '貸す(빌려주다)와 借りる(빌리다)는 주체에 따른 방향만 다름. 「빌려달라」=「빌리고 싶다」', 1),
    (w2, w1, 'synonym', '貸す(빌려주다)와 借りる(빌리다)는 주체에 따른 방향만 다름. 「빌려달라」=「빌리고 싶다」', 1);

  -- 페어 14: 家内 ≒ 奥さん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '家内', 'かない', '집사람, 아내(자기 아내의 겸손어)', '家(집)+内(안) → 집 안의 사람. 자기 아내를 가리키는 겸손한 표현', '유의 표현', 281, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '家内と買い物に行く。', '아내와 쇼핑하러 갑니다.', 1),
    (w1, '家内はパートで働いています。', '아내는 파트타임으로 일하고 있어요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '奥さん', 'おくさん', '부인, 사모님(타인의 아내 정중어)', '奥(안쪽 오): 집의 가장 안쪽=주부. +さん(존칭) → 남의 아내를 정중히 부르는 말', '유의 표현', 282, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '奥さんはきれいですね。', '부인은 예쁘시네요.', 1),
    (w2, '田中さんの奥さんに会った。', '다나카씨의 부인을 만났다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '家内는 자기 아내 겸손어, 奥さん은 남의 아내 정중어 → 같은 「아내」를 다른 시점에서 부른 말', 1),
    (w2, w1, 'synonym', '家内는 자기 아내 겸손어, 奥さん은 남의 아내 정중어 → 같은 「아내」를 다른 시점에서 부른 말', 1);

  -- 페어 15: 嫌いです ≒ 好きではありません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '嫌いです', 'きらいです', '싫습니다', '嫌(싫어할 혐): 女(여)+兼(겸할 겸) → 마음에 거슬림. な형용사 정중형 「~です」', '유의 표현', 283, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'にんじんが嫌いです。', '당근을 싫어합니다.', 1),
    (w1, '虫が嫌いです。', '벌레가 싫어요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '好きではありません', 'すきではありません', '좋아하지 않습니다', '好(좋을 호): 女(여)+子(자) → 어머니가 아이를 좋아함. な형용사 부정형 「~ではありません」', '유의 표현', 284, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'にんじんは好きではありません。', '당근은 좋아하지 않습니다.', 1),
    (w2, '魚は好きではありません。', '생선은 좋아하지 않아요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '嫌い(싫음)=好きではない(좋아하지 않음). 한쪽 긍정의 부정=다른 쪽 긍정', 1),
    (w2, w1, 'synonym', '嫌い(싫음)=好きではない(좋아하지 않음). 한쪽 긍정의 부정=다른 쪽 긍정', 1);

  -- 페어 16: きれいです ≒ 汚くないです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'きれいです', '깨끗합니다, 예쁩니다', '綺麗(きれい): 비단(綺)처럼 곱고 아름다움. な형용사 정중형', '유의 표현', 285, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '部屋がきれいです。', '방이 깨끗합니다.', 1),
    (w1, '花がきれいですね。', '꽃이 예쁘네요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '汚くないです', 'きたなくないです', '더럽지 않습니다', '汚(더러울 오): 水(물)+亐(굽음) → 더러운 물. い형용사 부정형 「~くないです」', '유의 표현', 286, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'この部屋はきたなくないです。', '이 방은 더럽지 않습니다.', 1),
    (w2, '手はきたなくないです。', '손은 더럽지 않아요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'きれい(깨끗)=汚くない(더럽지 않음). 의미상 같음', 1),
    (w2, w1, 'synonym', 'きれい(깨끗)=汚くない(더럽지 않음). 의미상 같음', 1);

  -- 페어 17: 銀行 ≒ ここでお金を出します
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '銀行', 'ぎんこう', '은행', '銀(은 은)+行(다닐 행) → 은(돈)을 다루는 곳. 일본의 은행 명칭 한자어', '유의 표현', 287, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '銀行で働いている。', '은행에서 일하고 있다.', 1),
    (w1, '銀行はあちらにあります。', '은행은 저쪽에 있습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ここでお金を出します', 'ここでおかねをだします', '이곳에서 돈을 인출합니다', '出(날 출): 발이 문 밖으로 나가는 모양 → 내다. 「お金を出す」=돈을 내다/인출하다', '유의 표현', 288, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ここでお金を出します。', '이곳에서 돈을 인출합니다.', 1),
    (w2, 'ATMでお金を出しました。', 'ATM에서 돈을 인출했습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '은행에서 하는 대표적인 일이 돈을 인출하는 것', 1),
    (w2, w1, 'synonym', '은행에서 하는 대표적인 일이 돈을 인출하는 것', 1);

  -- 페어 18: 果物 ≒ りんごやバナナなど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '果物', 'くだもの', '과일', '果(열매 과)+物(물건 물) → 열매. 일본 고유어 「くだもの」를 한자로 표기', '유의 표현', 289, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '果物が好きです。', '과일을 좋아합니다.', 1),
    (w1, 'デザートに果物を食べる。', '디저트로 과일을 먹는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'りんごやバナナなど', 'りんごやバナナなど', '사과나 바나나 등', 'りんご(사과)+や(나열)+バナナ(외래어, banana)+など(~등). 구체적 예시 나열', '유의 표현', 290, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'りんごやバナナをよく食べる。', '사과나 바나나를 자주 먹는다.', 1),
    (w2, 'りんごやバナナなどを買った。', '사과나 바나나 등을 샀다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '과일이라는 상위 개념을 구체적 예시(사과·바나나)로 풀어 쓴 표현', 1),
    (w2, w1, 'synonym', '과일이라는 상위 개념을 구체적 예시(사과·바나나)로 풀어 쓴 표현', 1);

  -- 페어 19: 果物を食べる ≒ みかんを食べる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '果物を食べる', 'くだものをたべる', '과일을 먹다', '果(열매)+物(물건) → 과일. 食(먹을 식)+べる(동사 어미). 1그룹 동사', '유의 표현', 291, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '食事の後に果物を食べる。', '식사 후에 과일을 먹는다.', 1),
    (w1, '毎日果物を食べています。', '매일 과일을 먹고 있습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'みかんを食べる', 'みかんをたべる', '귤을 먹다', 'みかん(蜜柑): 일본의 대표적 겨울 과일. 한자 「蜜柑」=달콤한 감귤', '유의 표현', 292, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '冬にみかんを食べる。', '겨울에 귤을 먹는다.', 1),
    (w2, '毎朝みかんを食べます。', '매일 아침 귤을 먹습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'みかん(귤)도 과일의 한 종류이므로 「果物を食べる」의 구체적 사례', 1),
    (w2, w1, 'synonym', 'みかん(귤)도 과일의 한 종류이므로 「果物を食べる」의 구체적 사례', 1);

  -- 페어 20: 警官 ≒ お巡りさん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '警官', 'けいかん', '경관', '警(경계할 경)+官(벼슬 관) → 경계 임무를 수행하는 관리. 격식 있는 한자어', '유의 표현', 293, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '警官に道を聞いた。', '경관에게 길을 물었다.', 1),
    (w1, '警官が事故を調べている。', '경관이 사고를 조사하고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'お巡りさん', 'おまわりさん', '순경(친근한 호칭)', 'お+巡る(돌다)+さん → 「동네를 순찰하는 분」. 친근한 일상 표현', '유의 표현', 294, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'お巡りさんが来ました。', '순경이 왔어요.', 1),
    (w2, '近所のお巡りさんは親切だ。', '동네 순경은 친절하다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '둘 다 경찰관. 警官은 격식 한자어, お巡りさん은 친근한 호칭', 1),
    (w2, w1, 'synonym', '둘 다 경찰관. 警官은 격식 한자어, お巡りさん은 친근한 호칭', 1);

  -- 페어 21: 玄関 ≒ 家の入り口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '玄関', 'げんかん', '현관', '玄(검을 현)+関(빗장 관) → 옛 선종 사찰의 깊은 입구에서 유래. 집의 정식 입구', '유의 표현', 295, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '玄関でくつをぬぐ。', '현관에서 신발을 벗는다.', 1),
    (w1, '玄関に花を置く。', '현관에 꽃을 둔다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '家の入り口', 'いえのいりぐち', '집 입구', '家(집 가)+の+入り口(들어가는 구멍=입구). 「家+の+~」 소유격 구조', '유의 표현', 296, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '家の入り口に花がある。', '집 입구에 꽃이 있다.', 1),
    (w2, '家の入り口で待っています。', '집 입구에서 기다리고 있어요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '현관=집의 입구', 1),
    (w2, w1, 'synonym', '현관=집의 입구', 1);

  -- 페어 22: 公園を散歩しました ≒ 公園を歩きました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '公園を散歩しました', 'こうえんをさんぽしました', '공원을 산책했습니다', '散(흩을 산)+歩(걸을 보) → 천천히 흩어지듯 걷기=산책. 「~を散歩する」', '유의 표현', 297, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '公園を散歩しました。', '공원을 산책했습니다.', 1),
    (w1, '朝、公園を散歩しました。', '아침에 공원을 산책했습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '公園を歩きました', 'こうえんをあるきました', '공원을 걸었습니다', '歩(걸을 보): 발(止)이 앞뒤로 움직이는 모양. 「~を歩く」=~을 걷다', '유의 표현', 298, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '公園を歩きました。', '공원을 걸었습니다.', 1),
    (w2, '犬と公園を歩いた。', '강아지와 공원을 걸었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '산책=천천히 걷는 행위', 1),
    (w2, w1, 'synonym', '산책=천천히 걷는 행위', 1);

  -- 페어 23: 午前中 ≒ 朝から昼まで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '午前中', 'ごぜんちゅう', '오전 내내, 오전 중', '午(낮 오)+前(앞)+中(가운데) → 정오 전의 시간 안', '유의 표현', 299, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '午前中は会議があります。', '오전 내내 회의가 있습니다.', 1),
    (w1, '午前中に電話します。', '오전 중에 전화하겠습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '朝から昼まで', 'あさからひるまで', '아침부터 점심까지', '朝(아침)+から(에서)+昼(낮)+まで(까지). 시간 범위 표현', '유의 표현', 300, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '朝から昼まで勉強した。', '아침부터 점심까지 공부했다.', 1),
    (w2, '朝から昼まで仕事をした。', '아침부터 점심까지 일했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '午前은 정오 전 시간대=아침부터 점심(정오)까지', 1),
    (w2, w1, 'synonym', '午前은 정오 전 시간대=아침부터 점심(정오)까지', 1);

  -- 페어 24: 午前も午後も ≒ 朝から夕方まで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '午前も午後も', 'ごぜんもごごも', '오전도 오후도', '午前(오전)+も(도)+午後(오후)+も(도). 「Aも+Bも」=A도 B도 (둘 다)', '유의 표현', 301, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '午前も午後も忙しい。', '오전도 오후도 바쁘다.', 1),
    (w1, '午前も午後も会議だ。', '오전도 오후도 회의다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '朝から夕方まで', 'あさからゆうがたまで', '아침부터 저녁까지', '朝(아침)+から(에서)+夕方(저녁)+まで(까지). 하루 종일에 가까운 시간 범위', '유의 표현', 302, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '朝から夕方まで働いた。', '아침부터 저녁까지 일했다.', 1),
    (w2, '朝から夕方まで雨が降った。', '아침부터 저녁까지 비가 내렸다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '午前(아침~정오)+午後(정오~저녁)=朝부터 夕方까지', 1),
    (w2, w1, 'synonym', '午前(아침~정오)+午後(정오~저녁)=朝부터 夕方까지', 1);

  -- 페어 25: コピーを頼む ≒ コピーしてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'コピーを頼む', 'コピーをたのむ', '복사를 부탁하다', 'コピー(영어 copy 외래어)+を+頼む(부탁할 뢰). 의뢰 표현', '유의 표현', 303, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '上司にコピーを頼まれた。', '상사에게 복사를 부탁받았다.', 1),
    (w1, '部下にコピーを頼んだ。', '부하에게 복사를 부탁했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'コピーしてください', 'コピーしてください', '복사해 주세요', 'コピーする(복사하다)+「~てください」=정중한 요청 표현', '유의 표현', 304, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'これをコピーしてください。', '이것을 복사해 주세요.', 1),
    (w2, '書類をコピーしてください。', '서류를 복사해 주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '頼む(부탁하다)와 「~してください」(~해 주세요)는 같은 의뢰 표현', 1),
    (w2, w1, 'synonym', '頼む(부탁하다)와 「~してください」(~해 주세요)는 같은 의뢰 표현', 1);

  -- 페어 26: 仕事を休みます ≒ 仕事をしません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '仕事を休みます', 'しごとをやすみます', '일을 쉽니다', '仕事(일)+を+休む(쉴 휴): 사람(亻)이 나무(木)에 기대 쉬는 모습. 1그룹 동사', '유의 표현', 305, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '明日は仕事を休みます。', '내일은 일을 쉽니다.', 1),
    (w1, '風邪で仕事を休みました。', '감기 때문에 일을 쉬었습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '仕事をしません', 'しごとをしません', '일을 하지 않습니다', '仕事+を+する(하다)의 정중 부정형 「しません」', '유의 표현', 306, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '今日は仕事をしません。', '오늘은 일을 하지 않습니다.', 1),
    (w2, '日曜日は仕事をしません。', '일요일은 일을 하지 않습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '일을 쉰다=일을 하지 않는다', 1),
    (w2, w1, 'synonym', '일을 쉰다=일을 하지 않는다', 1);

  -- 페어 27: 辞書を引きました ≒ 言葉の意味が分かりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '辞書を引きました', 'じしょをひきました', '사전을 찾았습니다', '辞(말씀 사)+書(글 서) → 말을 모은 책=사전. 「辞書を引く」=사전을 펼쳐 찾다(관용)', '유의 표현', 307, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '辞書を引きました。', '사전을 찾았습니다.', 1),
    (w1, '分からない言葉は辞書を引きます。', '모르는 단어는 사전을 찾습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '言葉の意味が分かりました', 'ことばのいみがわかりました', '말의 의미를 알았습니다', '言(말씀 언)+葉(잎 엽) → 말. 意(뜻)+味(맛) → 뜻. 分かる(이해되다)', '유의 표현', 308, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '言葉の意味が分かりました。', '단어의 의미를 알았습니다.', 1),
    (w2, 'この言葉の意味が分かりません。', '이 말의 의미를 모르겠습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '사전을 찾는 이유=단어의 의미를 알기 위함', 1),
    (w2, w1, 'synonym', '사전을 찾는 이유=단어의 의미를 알기 위함', 1);

  -- 페어 28: 食堂が休みです ≒ 食堂が閉まっています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '食堂が休みです', 'しょくどうがやすみです', '식당이 쉽니다', '食(먹을 식)+堂(집 당) → 음식을 먹는 집. 「~が休みです」=영업하지 않음', '유의 표현', 309, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '月曜日は食堂が休みです。', '월요일은 식당이 쉽니다.', 1),
    (w1, '今日は食堂が休みです。', '오늘은 식당이 쉽니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '食堂が閉まっています', 'しょくどうがしまっています', '식당이 닫혀 있습니다', '閉(닫을 폐): 門(문)+才(빗장) → 빗장으로 문을 닫음. 자동사 「閉まる」 결과 상태', '유의 표현', 310, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '食堂が閉まっています。', '식당이 닫혀 있습니다.', 1),
    (w2, '夜になって食堂が閉まっています。', '밤이 되어 식당이 닫혀 있습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '식당이 쉰다=영업하지 않고 문이 닫혀 있음', 1),
    (w2, w1, 'synonym', '식당이 쉰다=영업하지 않고 문이 닫혀 있음', 1);

  -- 페어 29: ストーブ ≒ 部屋を暖かくする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'ストーブ', '난로, 스토브', '영어 stove(난로)의 카타카나 외래어. 방을 데우는 난방 기구', '유의 표현', 311, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ストーブをつける。', '스토브를 켠다.', 1),
    (w1, '冬はストーブが必要だ。', '겨울에는 스토브가 필요하다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '部屋を暖かくする', 'へやをあたたかくする', '방을 따뜻하게 하다', '暖(따뜻할 난): 日(해)+爰(끌어당김) → 햇볕이 끌어오는 온기. 「~くする」=~게 하다', '유의 표현', 312, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ストーブで部屋を暖かくする。', '스토브로 방을 따뜻하게 한다.', 1),
    (w2, '寒いから部屋を暖かくしてください。', '추우니까 방을 따뜻하게 해 주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '스토브의 기능=방을 따뜻하게 함', 1),
    (w2, w1, 'synonym', '스토브의 기능=방을 따뜻하게 함', 1);

  -- 페어 30: 背が高い ≒ 大きい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '背が高い', 'せがたかい', '키가 크다', '背(등 배): 신체의 등=키. 高(높을 고)+い(형용사). 「(주어)+が+형용사」', '유의 표현', 313, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '兄は背が高い。', '형은 키가 크다.', 1),
    (w1, 'バスケ選手は背が高い。', '농구 선수는 키가 크다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '大きい', 'おおきい', '크다', '大(큰 대): 사람이 팔다리를 벌린 모습 → 크다. い형용사 기본형', '유의 표현', 314, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '大きい人だ。', '큰 사람이다.', 1),
    (w2, 'この犬は大きいですね。', '이 강아지는 크네요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '「背が高い」(키가 크다)는 「(체격이) 크다」와 같은 의미', 1),
    (w2, w1, 'synonym', '「背が高い」(키가 크다)는 「(체격이) 크다」와 같은 의미', 1);

  -- 페어 31: せっけん ≒ 何かを洗う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'せっけん', '비누', '石鹸(せっけん): 石(돌)+鹸(잿물) → 광물 잿물에서 만든 세정제', '유의 표현', 315, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'せっけんで手をあらう。', '비누로 손을 씻는다.', 1),
    (w1, 'いい香りのせっけんを使う。', '좋은 향의 비누를 쓴다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '何かを洗う', 'なにかをあらう', '무언가를 씻다', '何(어찌 하)+か(불확정) → 무언가. 洗(씻을 세): 水(물)+先(앞서) → 물로 씻음', '유의 표현', 316, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '何かを洗うときに使う。', '무언가를 씻을 때 사용한다.', 1),
    (w2, '汚れた手で何かを洗う。', '더러워진 손으로 무언가를 씻는다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '비누는 손·옷·몸 등 무언가를 씻기 위한 도구', 1),
    (w2, w1, 'synonym', '비누는 손·옷·몸 등 무언가를 씻기 위한 도구', 1);

  -- 페어 32: 洗濯する ≒ 洋服を洗う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '洗濯する', 'せんたくする', '세탁하다', '洗(씻을 세)+濯(빨 탁) → 물로 빨아 씻음. する 동사', '유의 표현', 317, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '毎週洗濯します。', '매주 세탁합니다.', 1),
    (w1, '休みの日に洗濯する。', '쉬는 날에 세탁한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '洋服を洗う', 'ようふくをあらう', '옷을 빨다', '洋(서양)+服(옷) → 양복/서양식 옷=현대 일반 옷. 洗う(씻다)', '유의 표현', 318, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '洋服を洗いました。', '옷을 빨았습니다.', 1),
    (w2, '汚れた洋服を洗う。', '더러워진 옷을 빤다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '세탁=옷을 빠는 행위', 1),
    (w2, w1, 'synonym', '세탁=옷을 빠는 행위', 1);

  -- 페어 33: 掃除をする ≒ きれいにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '掃除をする', 'そうじをする', '청소를 하다', '掃(쓸 소)+除(없앨 제) → 먼지를 쓸어 없앰. 「~をする」 동작 표현', '유의 표현', 319, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '部屋の掃除をする。', '방 청소를 한다.', 1),
    (w1, '毎朝部屋の掃除をします。', '매일 아침 방 청소를 합니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'きれいにする', 'きれいにする', '깨끗하게 하다', 'きれい(綺麗, 깨끗함, な형용사)+「に+する」=~게 하다. 사역 변형 패턴', '유의 표현', 320, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋をきれいにする。', '방을 깨끗하게 한다.', 1),
    (w2, '机をきれいにしました。', '책상을 깨끗하게 했습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '청소의 목적=더러운 곳을 깨끗하게 함', 1),
    (w2, w1, 'synonym', '청소의 목적=더러운 곳을 깨끗하게 함', 1);

  -- 페어 34: 台所 ≒ ご飯を作るところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '台所', 'だいどころ', '부엌', '台(돈대 대)+所(곳 소) → 음식을 놓는 곳. 일본 가정의 조리 공간', '유의 표현', 321, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '母は台所にいる。', '어머니는 부엌에 계신다.', 1),
    (w1, '台所がきれいですね。', '부엌이 깨끗하네요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ご飯を作るところ', 'ごはんをつくるところ', '밥을 만드는 곳', '作(지을 작): 사람(亻)이 잠시(乍) 손을 댐 → 만들기. ところ(所)=장소', '유의 표현', 322, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ご飯を作るところは台所だ。', '밥을 만드는 곳은 부엌이다.', 1),
    (w2, 'ご飯を作るところはきれいだ。', '밥을 만드는 곳은 깨끗하다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '부엌의 주된 용도=음식을 만드는 것', 1),
    (w2, w1, 'synonym', '부엌의 주된 용도=음식을 만드는 것', 1);

  -- 페어 35: 誕生日は7月5日です ≒ 7月5日に生まれました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '誕生日は7月5日です', 'たんじょうびはしちがついつかです', '생일은 7월 5일입니다', '誕(태어날 탄)+生(날 생)+日(날 일) → 태어난 날=생일. 5日의 특수 읽기「いつか」주의', '유의 표현', 323, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '私の誕生日は7月5日です。', '제 생일은 7월 5일입니다.', 1),
    (w1, '彼の誕生日は7月5日です。', '그의 생일은 7월 5일입니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '7月5日に生まれました', 'しちがついつかにうまれました', '7월 5일에 태어났습니다', '生まれる(태어나다): 生의 자동사형. 「~に生まれる」=~에 태어나다', '유의 표현', 324, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '7月5日に生まれました。', '7월 5일에 태어났습니다.', 1),
    (w2, '私は7月5日に生まれました。', '저는 7월 5일에 태어났습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '생일=태어난 날이므로 같은 의미', 1),
    (w2, w1, 'synonym', '생일=태어난 날이므로 같은 의미', 1);

  -- 페어 36: 勤める ≒ 働く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '勤める', 'つとめる', '근무하다(특정 회사 소속)', '勤(부지런할 근): 力(힘)+堇(끈기) → 끈기 있게 힘쓰다. 「~に勤める」', '유의 표현', 325, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '銀行に勤めています。', '은행에 근무하고 있습니다.', 1),
    (w1, '会社に勤めて5年になります。', '회사에 근무한 지 5년이 됩니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '働く', 'はたらく', '일하다(일반)', '働(움직일 동): 人(사람)+動(움직임) → 사람이 움직임=일함. 일본 고유 한자', '유의 표현', 326, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '父は工場で働いている。', '아버지는 공장에서 일하고 있다.', 1),
    (w2, '毎日働いています。', '매일 일하고 있습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '勤める는 특정 회사 소속 근무, 働く는 일반적 일하기 → 둘 다 「일하다」', 1),
    (w2, w1, 'synonym', '勤める는 특정 회사 소속 근무, 働く는 일반적 일하기 → 둘 다 「일하다」', 1);

  -- 페어 37: つまらない ≒ 面白くありません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'つまらない', '시시하다, 재미없다', '詰まる(차다)+ない(부정) → 「내용이 차 있지 않다」=시시함. い형용사', '유의 표현', 327, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'この本はつまらない。', '이 책은 시시하다.', 1),
    (w1, 'つまらない話はやめよう。', '시시한 이야기는 그만두자.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '面白くありません', 'おもしろくありません', '재미있지 않습니다', '面(낯 면)+白(흰 백) → 「얼굴이 환해질 만큼 흥미로움」=재미. い형용사 정중 부정형', '유의 표현', 328, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '映画は面白くありませんでした。', '영화는 재미있지 않았습니다.', 1),
    (w2, 'この番組は面白くありません。', '이 프로그램은 재미있지 않습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'つまらない=面白くない (완전 동의)', 1),
    (w2, w1, 'synonym', 'つまらない=面白くない (완전 동의)', 1);

  -- 페어 38: テーブルに並べる ≒ テーブルに置く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'テーブルに並べる', 'テーブルにならべる', '테이블에 늘어놓다', 'テーブル(table 외래어)+に+並(나란히 병)+べる. 「~に並べる」=~에 나란히 놓다', '유의 표현', 329, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '料理をテーブルに並べる。', '요리를 테이블에 늘어놓는다.', 1),
    (w1, '本をテーブルに並べた。', '책을 테이블에 늘어놓았다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'テーブルに置く', 'テーブルにおく', '테이블에 놓다', '置(둘 치): 그물(网)+直(곧음) → 잡은 것을 곧 놓아둠. 「~に置く」=~에 놓다', '유의 표현', 330, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'お皿をテーブルに置く。', '접시를 테이블에 놓는다.', 1),
    (w2, 'コップをテーブルに置いた。', '컵을 테이블에 놓았다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '並べる(나란히 놓다)와 置く(놓다)는 같은 동작. 並べる는 정렬의 의미가 강함', 1),
    (w2, w1, 'synonym', '並べる(나란히 놓다)와 置く(놓다)는 같은 동작. 並べる는 정렬의 의미가 강함', 1);

  -- 페어 39: 出かける ≒ 家にいない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '出かける', 'でかける', '외출하다', '出(날 출)+かける(걸치다/시작하다) → 나가기 시작함. 1그룹 자동사', '유의 표현', 331, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '父は出かけました。', '아버지는 외출했어요.', 1),
    (w1, '友だちと買い物に出かけた。', '친구와 쇼핑하러 외출했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '家にいない', 'いえにいない', '집에 없다', '家(집)+に(에)+いる(있다)의 부정형「いない」. 사람·동물 존재 동사「いる」', '유의 표현', 332, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '父は今家にいません。', '아버지는 지금 집에 안 계세요.', 1),
    (w2, '今は家にいません。', '지금은 집에 없습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '외출했다=집에 없다', 1),
    (w2, w1, 'synonym', '외출했다=집에 없다', 1);

  -- 페어 40: テニスが好きです ≒ テニスがしたいです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'テニスが好きです', 'テニスがすきです', '테니스를 좋아합니다', 'テニス(tennis 외래어)+が+好(좋을 호)き(な형용사). 「Aが好き」=A를 좋아함', '유의 표현', 333, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'テニスが好きです。', '테니스를 좋아합니다.', 1),
    (w1, '私はテニスが大好きです。', '저는 테니스를 정말 좋아합니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'テニスがしたいです', 'テニスがしたいです', '테니스를 하고 싶습니다', 'テニス+が+する의 「~たい」(하고 싶다)형. 희망 표현', '유의 표현', 334, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'テニスがしたいです。', '테니스를 하고 싶어요.', 1),
    (w2, '今すぐテニスがしたい。', '지금 당장 테니스를 하고 싶다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '좋아하는 활동=하고 싶음', 1),
    (w2, w1, 'synonym', '좋아하는 활동=하고 싶음', 1);

  -- 페어 41: 天気がいい ≒ 晴れている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '天気がいい', 'てんきがいい', '날씨가 좋다', '天(하늘)+気(기운) → 날씨. いい(좋다, 良い의 구어). 「~がいい」', '유의 표현', 335, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '今日は天気がいい。', '오늘은 날씨가 좋다.', 1),
    (w1, '天気がいいから散歩しよう。', '날씨가 좋으니 산책하자.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '晴れている', 'はれている', '개어 있다, 맑다', '晴れる(개다)+ている(상태 지속). 비가 그치고 맑은 상태', '유의 표현', 336, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '朝から晴れている。', '아침부터 맑다.', 1),
    (w2, '空が晴れているね。', '하늘이 맑네.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '좋은 날씨=맑고 갠 상태', 1),
    (w2, w1, 'synonym', '좋은 날씨=맑고 갠 상태', 1);

  -- 페어 42: 電気を消す ≒ 部屋を暗くする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '電気を消す', 'でんきをけす', '전기를 끄다', '消(꺼질 소): 水(물)+肖(작아짐) → 불이 작아져 꺼짐. 「~を消す」', '유의 표현', 337, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '寝る前に電気を消す。', '자기 전에 전기를 끈다.', 1),
    (w1, '電気を消してください。', '전기를 꺼 주세요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '部屋を暗くする', 'へやをくらくする', '방을 어둡게 하다', '暗(어두울 암): 日(해)+音(소리) → 해가 없는 곳. 「~くする」=~게 하다', '유의 표현', 338, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋を暗くしてください。', '방을 어둡게 해 주세요.', 1),
    (w2, '寝るときに部屋を暗くする。', '잘 때 방을 어둡게 한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '전기를 끄면 방이 어두워짐', 1),
    (w2, w1, 'synonym', '전기를 끄면 방이 어두워짐', 1);

  -- 페어 43: ドアは開いています ≒ ドアは閉まっていません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ドアは開いています', 'ドアはあいています', '문은 열려 있습니다', 'ドア(door 외래어)+は+開く(열리다)+ている. 자동사 결과 상태', '유의 표현', 339, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ドアは開いています。', '문은 열려 있습니다.', 1),
    (w1, '入り口のドアは開いています。', '입구의 문은 열려 있습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ドアは閉まっていません', 'ドアはしまっていません', '문은 닫혀 있지 않습니다', '閉(닫을 폐)まる(자동사)+ている의 부정형. 이중 의미: 닫혀 있지 않음', '유의 표현', 340, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ドアは閉まっていません。', '문은 닫혀 있지 않습니다.', 1),
    (w2, 'まだドアは閉まっていません。', '아직 문은 닫혀 있지 않습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '열려 있다=닫혀 있지 않다 (이중부정)', 1),
    (w2, w1, 'synonym', '열려 있다=닫혀 있지 않다 (이중부정)', 1);

  -- 페어 44: 図書館に行きました ≒ 本を借りました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '図書館に行きました', 'としょかんにいきました', '도서관에 갔습니다', '図(그림 도)+書(글 서)+館(집 관) → 도서관. 「~に行く」', '유의 표현', 341, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '昨日図書館に行きました。', '어제 도서관에 갔습니다.', 1),
    (w1, '勉強しに図書館に行った。', '공부하러 도서관에 갔다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '本を借りました', 'ほんをかりました', '책을 빌렸습니다', '本(책)+を+借(빌릴 차)りる. 「~を借りる」=~을 빌리다', '유의 표현', 342, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '図書館で本を借りました。', '도서관에서 책을 빌렸습니다.', 1),
    (w2, '友だちから本を借りた。', '친구에게서 책을 빌렸다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '도서관에 가는 주된 목적=책을 빌리는 것', 1),
    (w2, w1, 'synonym', '도서관에 가는 주된 목적=책을 빌리는 것', 1);

  -- 페어 45: なぜ ≒ どうして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'なぜ', '왜(격식)', '何故(なぜ): 何(무엇)+故(까닭) → 어떤 까닭으로. 다소 격식적', '유의 표현', 343, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'なぜ来なかったの？', '왜 안 왔어?', 1),
    (w1, 'なぜそう思いますか。', '왜 그렇게 생각합니까?', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'どうして', '왜(일상)', '「どう(어떻게)+して(하여)」 → 어떻게 해서. 구어/일상적', '유의 표현', 344, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'どうして来なかったの？', '왜 안 왔어?', 1),
    (w2, 'どうして泣いているの？', '왜 울고 있어?', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '둘 다 이유를 묻는 의문사. なぜ는 격식, どうして는 일상적', 1),
    (w2, w1, 'synonym', '둘 다 이유를 묻는 의문사. なぜ는 격식, どうして는 일상적', 1);

  -- 페어 46: にぎやかです ≒ 人がおおぜいいます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'にぎやかです', '떠들썩합니다, 번화합니다', '賑やか(にぎやか): 사람이 많고 활기찬 모습. な형용사', '유의 표현', 345, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'お祭りはにぎやかです。', '축제는 떠들썩합니다.', 1),
    (w1, '町はいつもにぎやかです。', '동네는 늘 떠들썩합니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '人がおおぜいいます', 'ひとがおおぜいいます', '사람이 많이 있습니다', '人(사람)+大勢(おおぜい, 많은 무리)+いる(있다). 사람·동물 존재 동사', '유의 표현', 346, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '駅は人がおおぜいいます。', '역은 사람이 많이 있습니다.', 1),
    (w2, '公園に人がおおぜいいた。', '공원에 사람이 많이 있었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '사람이 많이 모인 곳=떠들썩한 분위기', 1),
    (w2, w1, 'synonym', '사람이 많이 모인 곳=떠들썩한 분위기', 1);

  -- 페어 47: 日本語を習う ≒ 日本語を勉強している
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '日本語を習う', 'にほんごをならう', '일본어를 배우다', '習(익힐 습): 羽(깃)+白(흰) → 새가 날기를 익힘. 「~を習う」=~을 배우다', '유의 표현', 347, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '日本語を習っています。', '일본어를 배우고 있습니다.', 1),
    (w1, '日本語を一から習います。', '일본어를 처음부터 배웁니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '日本語を勉強している', 'にほんごをべんきょうしている', '일본어를 공부하고 있다', '勉(힘쓸 면)+強(강함) → 힘써 노력함=공부. 「~ている」 진행', '유의 표현', 348, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '毎日日本語を勉強している。', '매일 일본어를 공부하고 있다.', 1),
    (w2, '今日本語を勉強しています。', '지금 일본어를 공부하고 있습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '習う(배우다)와 勉強する(공부하다)는 학습 과정의 동일 동작', 1),
    (w2, w1, 'synonym', '習う(배우다)와 勉強する(공부하다)는 학습 과정의 동일 동작', 1);

  -- 페어 48: 初めて行きます ≒ まだ行っていません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '初めて行きます', 'はじめていきます', '처음 갑니다', '初(처음 초)+めて(부사화) → 처음으로. 「初めて+동사」', '유의 표현', 349, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '京都に初めて行きます。', '교토에 처음 갑니다.', 1),
    (w1, '初めて行く場所はわくわくする。', '처음 가는 곳은 설렌다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'まだ行っていません', 'まだいっていません', '아직 가지 않았습니다', 'まだ(아직)+行く+ていない(완료의 부정). 「과거에 한 적이 없음」 표현', '유의 표현', 350, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'そこにはまだ行っていません。', '거기에는 아직 가지 않았습니다.', 1),
    (w2, '美術館にまだ行っていません。', '미술관에 아직 가지 않았습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '처음 간다=이전에는 간 적이 없다', 1),
    (w2, w1, 'synonym', '처음 간다=이전에는 간 적이 없다', 1);

  -- 페어 49: 暇でした ≒ 忙しくなかったです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '暇でした', 'ひまでした', '한가했습니다', '暇(겨를 가): 日(해)+叚(빌릴) → 일에서 잠시 빌린 시간=여유. な형용사 과거 정중', '유의 표현', 351, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '昨日は暇でした。', '어제는 한가했습니다.', 1),
    (w1, '日曜日は暇でした。', '일요일은 한가했습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '忙しくなかったです', 'いそがしくなかったです', '바쁘지 않았습니다', '忙(바쁠 망): 心(마음)+亡(잃다) → 마음이 정신없음. い형용사 과거 부정 정중', '유의 표현', 352, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '昨日は忙しくなかったです。', '어제는 바쁘지 않았습니다.', 1),
    (w2, '今週は忙しくなかった。', '이번 주는 바쁘지 않았다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '暇(한가)=忙しくない(바쁘지 않음)', 1),
    (w2, w1, 'synonym', '暇(한가)=忙しくない(바쁘지 않음)', 1);

  -- 페어 50: 下手です ≒ 上手ではありません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '下手です', 'へたです', '서툽니다', '下(아래 하)+手(손 수) → 손이 아래=서툼. な형용사 정중형', '유의 표현', 353, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '歌が下手です。', '노래가 서툽니다.', 1),
    (w1, '料理が下手です。', '요리가 서툽니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '上手ではありません', 'じょうずではありません', '능숙하지 않습니다', '上(위)+手(손) → 손이 위=능숙함. な형용사 부정 정중형 「~ではありません」', '유의 표현', 354, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '歌が上手ではありません。', '노래가 능숙하지 않습니다.', 1),
    (w2, '日本語が上手ではありません。', '일본어가 능숙하지 않습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '下手(서툼)=上手ではない(능숙하지 않음)', 1),
    (w2, w1, 'synonym', '下手(서툼)=上手ではない(능숙하지 않음)', 1);

  -- 페어 51: ボールペン ≒ これで手紙を書きます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'ボールペン', '볼펜', '영어 ball+pen 외래어. 볼이 굴러 잉크가 나오는 펜', '유의 표현', 355, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '黒いボールペンをください。', '검은 볼펜 주세요.', 1),
    (w1, '新しいボールペンを買った。', '새 볼펜을 샀다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'これで手紙を書きます', 'これでてがみをかきます', '이것으로 편지를 씁니다', '手(손)+紙(종이) → 손으로 쓴 종이=편지. 「~で(수단)+書く(쓰다)」', '유의 표현', 356, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'これで手紙を書きます。', '이것으로 편지를 씁니다.', 1),
    (w2, 'ボールペンで手紙を書いた。', '볼펜으로 편지를 썼다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '볼펜의 용도=필기·편지 쓰기', 1),
    (w2, w1, 'synonym', '볼펜의 용도=필기·편지 쓰기', 1);

  -- 페어 52: まずい ≒ おいしくない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, NULL, 'まずい', '맛없다', '不味い(まずい): 맛이 없는 상태. い형용사', '유의 표현', 357, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'この料理はまずい。', '이 요리는 맛없다.', 1),
    (w1, 'まずい食べ物は嫌だ。', '맛없는 음식은 싫다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'おいしくない', 'おいしくない', '맛있지 않다', '美味しい(おいしい): 「맛이 좋다」의 い형용사. 부정형 「~くない」', '유의 표현', 358, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'これはおいしくない。', '이것은 맛있지 않다.', 1),
    (w2, 'スープがおいしくない。', '수프가 맛있지 않다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'まずい=おいしくない (완전 동의)', 1),
    (w2, w1, 'synonym', 'まずい=おいしくない (완전 동의)', 1);

  -- 페어 53: 難しくありません ≒ 易しいです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '難しくありません', 'むずかしくありません', '어렵지 않습니다', '難(어려울 난): 새(隹)를 잡기 어려움. い형용사 부정 정중형', '유의 표현', 359, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'この問題は難しくありません。', '이 문제는 어렵지 않습니다.', 1),
    (w1, '日本語は難しくありません。', '일본어는 어렵지 않습니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '易しいです', 'やさしいです', '쉽습니다', '易(쉬울 이): 도마뱀(蜥蜴) 모양 → 변하기 쉬움. い형용사 정중형', '유의 표현', 360, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'この問題は易しいです。', '이 문제는 쉽습니다.', 1),
    (w2, '易しい本から読む。', '쉬운 책부터 읽는다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '難しくない(어렵지 않음)=易しい(쉬움)', 1),
    (w2, w1, 'synonym', '難しくない(어렵지 않음)=易しい(쉬움)', 1);

  -- 페어 54: 難しくなかったです ≒ 簡単でした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '難しくなかったです', 'むずかしくなかったです', '어렵지 않았습니다', 'い형용사 「難しい」의 과거 부정 정중형 「~くなかったです」', '유의 표현', 361, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '試験は難しくなかったです。', '시험은 어렵지 않았습니다.', 1),
    (w1, '昨日のクイズは難しくなかった。', '어제 퀴즈는 어렵지 않았다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '簡単でした', 'かんたんでした', '간단했습니다', '簡(대쪽 간)+単(홑 단) → 간략함. な형용사 과거 정중형', '유의 표현', 362, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '試験は簡単でした。', '시험은 간단했습니다.', 1),
    (w2, '昨日の宿題は簡単でした。', '어제 숙제는 간단했습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '難しくなかった(어렵지 않았다)=簡単だった(간단했다)', 1),
    (w2, w1, 'synonym', '難しくなかった(어렵지 않았다)=簡単だった(간단했다)', 1);

  -- 페어 55: もうすぐ終わります ≒ まだ終わっていません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'もうすぐ終わります', 'もうすぐおわります', '이제 곧 끝납니다', 'もうすぐ(곧)+終(끝낼 종)わる(자동사). 가까운 미래 표현', '유의 표현', 363, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '映画はもうすぐ終わります。', '영화는 이제 곧 끝납니다.', 1),
    (w1, '授業はもうすぐ終わります。', '수업은 이제 곧 끝납니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'まだ終わっていません', 'まだおわっていません', '아직 끝나지 않았습니다', 'まだ(아직)+終わる+ていない(상태의 부정). 「현재 진행 중」 함의', '유의 표현', 364, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '仕事はまだ終わっていません。', '일은 아직 끝나지 않았습니다.', 1),
    (w2, '宿題はまだ終わっていません。', '숙제는 아직 끝나지 않았습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '곧 끝난다=지금은 아직 끝나지 않음', 1),
    (w2, w1, 'synonym', '곧 끝난다=지금은 아직 끝나지 않음', 1);

  -- 페어 56: 野菜や果物を売っている ≒ ここは八百屋です
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '野菜や果物を売っている', 'やさいやくだものをうっている', '야채나 과일을 팔고 있다', '野(들 야)+菜(나물 채) → 야채. 売(팔 매)る+ている(진행)', '유의 표현', 365, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '野菜や果物を売っています。', '야채나 과일을 팔고 있습니다.', 1),
    (w1, 'お店で野菜や果物を売っている。', '가게에서 야채나 과일을 팔고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'ここは八百屋です', 'ここはやおやです', '이곳은 야채가게입니다', '八百屋(やおや): 八百(800가지=많은)+屋(가게) → 야채·과일을 파는 작은 가게. 특수 읽기', '유의 표현', 366, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ここは八百屋です。', '이곳은 야채가게입니다.', 1),
    (w2, '近所の八百屋で買った。', '동네 야채가게에서 샀다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '야채와 과일을 파는 가게=八百屋', 1),
    (w2, w1, 'synonym', '야채와 과일을 파는 가게=八百屋', 1);

  -- 페어 57: 郵便局 ≒ 切手などを売っています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '郵便局', 'ゆうびんきょく', '우체국', '郵(우편 우)+便(편할 편)+局(판 국) → 우편 업무를 보는 곳', '유의 표현', 367, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '郵便局で手紙を出す。', '우체국에서 편지를 보낸다.', 1),
    (w1, '郵便局に荷物を届けた。', '우체국에 짐을 가져갔다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '切手などを売っています', 'きってなどをうっています', '우표 등을 팔고 있습니다', '切手(きって): 切る(자르다)+手(손)에서 「(요금 지불을) 자르는 표」=우표. など(등)', '유의 표현', 368, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ここでは切手などを売っています。', '여기서는 우표 등을 팔고 있습니다.', 1),
    (w2, '郵便局で切手などを買う。', '우체국에서 우표 등을 산다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '우체국에서 우표 판매·우편 업무를 함', 1),
    (w2, w1, 'synonym', '우체국에서 우표 판매·우편 업무를 함', 1);

  -- 페어 58: 夕べ ≒ 昨日の夜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '夕べ', 'ゆうべ', '어젯밤', '夕(저녁 석)+べ(시간 접미사) → 「어제의 저녁/밤」. 명사적 부사', '유의 표현', 369, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '夕べは雨でした。', '어젯밤은 비가 왔습니다.', 1),
    (w1, '夕べはよく眠れなかった。', '어젯밤은 잘 못 잤다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '昨日の夜', 'きのうのよる', '어젯밤(글자 그대로)', '昨(어제 작)+日(날)+の+夜(밤 야). 분석적 표현', '유의 표현', 370, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '昨日の夜は雨でした。', '어젯밤은 비가 왔습니다.', 1),
    (w2, '昨日の夜は早く寝た。', '어젯밤은 일찍 잤다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '夕べ=昨日の夜 (어제의 밤)', 1),
    (w2, w1, 'synonym', '夕べ=昨日の夜 (어제의 밤)', 1);

  -- 페어 59: 有名だ ≒ みんな知っている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '有名だ', 'ゆうめいだ', '유명하다', '有(있을 유)+名(이름 명) → 이름이 있음=유명함. な형용사', '유의 표현', 371, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'この歌手は有名だ。', '이 가수는 유명하다.', 1),
    (w1, 'あの店は有名だ。', '저 가게는 유명하다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'みんな知っている', 'みんなしっている', '모두 알고 있다', '皆(みんな, 모두)+知る+ている(상태). 「많은 사람의 인지」 상태', '유의 표현', 372, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'みんな彼を知っている。', '모두가 그를 알고 있다.', 1),
    (w2, 'みんな知っているニュースだ。', '모두가 알고 있는 뉴스다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '유명하다=많은 사람이 알고 있다', 1),
    (w2, w1, 'synonym', '유명하다=많은 사람이 알고 있다', 1);

  -- 페어 60: 留学生です ≒ 勉強をしに来ました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '留学生です', 'りゅうがくせいです', '유학생입니다', '留(머무를 류)+学(배울 학)+生(사람) → 머물러 배우는 사람=유학생', '유의 표현', 373, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '私は留学生です。', '저는 유학생입니다.', 1),
    (w1, '彼は中国からの留学生です。', '그는 중국에서 온 유학생입니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '勉強をしに来ました', 'べんきょうをしにきました', '공부를 하러 왔습니다', '「~に来る」=~하러 오다 (목적 표현). 동사 ます형+に+来る', '유의 표현', 374, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '日本へ勉強をしに来ました。', '일본에 공부를 하러 왔습니다.', 1),
    (w2, '東京に勉強をしに来た。', '도쿄에 공부를 하러 왔다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '유학생=공부를 목적으로 온 학생', 1),
    (w2, w1, 'synonym', '유학생=공부를 목적으로 온 학생', 1);

  -- 페어 61: 両親は出かけています ≒ 父も母も家にいません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '両親は出かけています', 'りょうしんはでかけています', '부모님은 외출했습니다', '両(둘 양)+親(친할 친) → 두 분 부모. 出かける+ている(결과 상태)', '유의 표현', 375, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '両親は出かけています。', '부모님은 외출했습니다.', 1),
    (w1, '土曜日は両親が出かけている。', '토요일은 부모님이 외출해 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '父も母も家にいません', 'ちちもははもいえにいません', '아빠도 엄마도 집에 없습니다', '父(아비 부)+も+母(어미 모)+も → 둘 다. いる(있다)의 정중 부정형', '유의 표현', 376, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '父も母も家にいません。', '아빠도 엄마도 집에 없습니다.', 1),
    (w2, '父も母も家にいない日が多い。', '아빠도 엄마도 집에 없는 날이 많다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '両親=父+母. 외출=집에 없음', 1),
    (w2, w1, 'synonym', '両親=父+母. 외출=집에 없음', 1);

  -- 페어 62: 冷蔵庫 ≒ 牛乳を入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '冷蔵庫', 'れいぞうこ', '냉장고', '冷(찰 냉)+蔵(감출 장)+庫(곳간 고) → 차게 보관하는 창고', '유의 표현', 377, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '冷蔵庫を開ける。', '냉장고를 연다.', 1),
    (w1, '冷蔵庫にビールがある。', '냉장고에 맥주가 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, '牛乳を入れる', 'ぎゅうにゅうをいれる', '우유를 넣다', '牛(소 우)+乳(젖 유) → 소의 젖=우유. 入れる(넣다, 타동사)', '유의 표현', 378, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '牛乳を冷蔵庫に入れる。', '우유를 냉장고에 넣는다.', 1),
    (w2, 'コーヒーに牛乳を入れる。', '커피에 우유를 넣는다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '냉장고의 용도=우유 같은 식품을 차게 보관', 1),
    (w2, w1, 'synonym', '냉장고의 용도=우유 같은 식품을 차게 보관', 1);

  -- 페어 63: AはBと結婚する ≒ BはAの奥さんになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'AはBと結婚する', 'AはBとけっこんする', 'A는 B와 결혼한다', '結(맺을 결)+婚(혼인 혼) → 혼인을 맺음. 「Aは+Bと+結婚する」', '유의 표현', 379, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '田中さんは山田さんと結婚する。', '다나카씨는 야마다씨와 결혼한다.', 1),
    (w1, '兄は来年結婚する。', '형은 내년에 결혼한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'BはAの奥さんになる', 'BはAのおくさんになる', 'B는 A의 부인이 되다', '奥(안쪽)+さん(존칭). 「~になる」=~이 되다 (변화 결과)', '유의 표현', 380, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '山田さんは田中さんの奥さんになる。', '야마다씨는 다나카씨의 부인이 된다.', 1),
    (w2, '彼女は彼の奥さんになった。', '그녀는 그의 부인이 되었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '결혼하면 (전통적으로) 여자는 남자의 「奥さん」이 됨', 1),
    (w2, w1, 'synonym', '결혼하면 (전통적으로) 여자는 남자의 「奥さん」이 됨', 1);

  -- 페어 64: AはBに漢字を習いました ≒ BはAに漢字を教えました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'AはBに漢字を習いました', 'AはBにかんじをならいました', 'A는 B에게 한자를 배웠습니다', '習う(배우다): 학습자 시점의 동사. 「~に習う」=~로부터 배우다', '유의 표현', 381, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '田中さんに漢字を習いました。', '다나카씨에게 한자를 배웠습니다.', 1),
    (w1, '友だちに日本語を習った。', '친구에게 일본어를 배웠다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n5, 'BはAに漢字を教えました', 'BはAにかんじをおしえました', 'B는 A에게 한자를 가르쳤습니다', '教(가르칠 교)える: 지도자 시점의 동사. 「~に教える」=~에게 가르치다', '유의 표현', 382, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '田中さんは私に漢字を教えました。', '다나카씨는 저에게 한자를 가르쳤습니다.', 1),
    (w2, '先生は生徒に漢字を教える。', '선생님은 학생에게 한자를 가르친다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'A가 B에게 배웠다=B가 A에게 가르쳤다 (시점·주어 전환)', 1),
    (w2, w1, 'synonym', 'A가 B에게 배웠다=B가 A에게 가르쳤다 (시점·주어 전환)', 1);


end $$;
