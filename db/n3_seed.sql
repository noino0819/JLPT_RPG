-- ============================================================
-- JLPT N3 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N3-단어장)
-- ============================================================
-- 실행 시 기존 N3 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 867단어 (450개 PDF 어휘 + 283개 문법 항목 + 67쌍 유의 표현 → 134개 양쪽 단어 entry)
-- 각 유의 표현은 자체 한자 어원·예문 2개를 갖고, 관계는 word_relations 양방향 synonym
-- ============================================================

delete from public.words
where deck_id in (
  select id from public.decks
  where is_official and jlpt_level = 'N3'
);

do $$
declare
  d_n3 uuid;
  w   uuid;
  w1  uuid;
  w2  uuid;
begin
  select id into d_n3
  from public.decks
  where is_official and jlpt_level = 'N3'
  limit 1;

  -- 1. 岩
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '岩', 'いわ', '바위, 암석', '岩(바위 암): 山(산) + 石(돌) → 산에 있는 큰 돌
부수 "山"이 단단함을 상징', '명사', 1, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の中に大きな岩がある。', '강 안에 큰 바위가 있다.', 1),
    (w, '岩の上に座って海を見た。', '바위 위에 앉아서 바다를 봤다.', 2);

  -- 2. 件
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '件', 'けん', '건, 사안', '件(사건 건): 亻(사람 인) + 牛(소 우) → 사람이 다루는 일
일의 단위를 세는 접미사로 발전', '명사·접미사', 2, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の件で電話しました。', '회의 건으로 전화했습니다.', 1),
    (w, '相談したい件があります。', '상담하고 싶은 건이 있습니다.', 2);

  -- 3. 通勤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '通勤', 'つうきん', '통근, 출퇴근', '通(통할 통): 辶(쉬엄쉬엄 갈 착) + 甬(길용) → 길을 지나다
勤(부지런할 근): 力(힘)을 다해 일하다', '명사', 3, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車で通勤しています。', '전철로 통근하고 있습니다.', 1),
    (w, '通勤時間は一時間です。', '통근 시간은 한 시간입니다.', 2);

  -- 4. 努力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '努力', 'どりょく', '노력', '努(힘쓸 노): 奴(종 노) + 力(힘 력) → 종처럼 힘을 쏟다
力(힘 력): 근육이나 쟁기의 모양에서 유래', '명사', 4, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日努力を続けています。', '매일 노력을 계속하고 있습니다.', 1),
    (w, '努力すれば必ず成功する。', '노력하면 반드시 성공한다.', 2);

  -- 5. 発見
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '発見', 'はっけん', '발견', '発(필 발): 활(弓)을 쏘듯 밖으로 내보내다
見(볼 견): 目(눈) + 儿(사람) → 사람이 눈으로 보다', '명사', 5, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい星を発見した。', '새 별을 발견했다.', 1),
    (w, '本の中で面白い発見があった。', '책 안에서 재밌는 발견이 있었다.', 2);

  -- 6. 得意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '得意', 'とくい', '자신 있음, 잘함', '得(얻을 득): 彳(걸을 척) + 貝(조개 패) → 길에서 재물을 얻다
意(뜻 의): 音(소리) + 心(마음) → 마음의 소리, 뜻', 'な형용사', 6, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理が得意です。', '요리를 잘합니다.', 1),
    (w, '彼は数学が得意だ。', '그는 수학을 잘한다.', 2);

  -- 7. 表す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '表す', 'あらわす', '나타내다, 표현하다', '表(겉 표): 衣(옷 의) + 毛(털 모) → 옷의 겉 모양을 드러냄
바깥으로 의미를 드러내다', '동사', 7, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気持ちを言葉で表す。', '마음을 말로 나타내다.', 1),
    (w, '感謝の気持ちを表したい。', '감사의 마음을 표현하고 싶다.', 2);

  -- 8. 包む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '包む', 'つつむ', '포장하다, 감싸다', '包(쌀 포): 勹(쌀 포) + 巳(아이가 자궁에 있는 모양) → 감싸다
무엇을 둘러 싸는 동작', '동사', 8, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼントをきれいに包む。', '선물을 예쁘게 포장하다.', 1),
    (w, 'お弁当をふろしきで包んだ。', '도시락을 보자기로 감쌌다.', 2);

  -- 9. 息
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '息', 'いき', '숨, 호흡', '息(쉴 식): 自(코 자) + 心(마음 심) → 코로 마음의 숨을 쉬다
생명의 호흡을 의미', '명사', 9, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走った後で息が苦しい。', '뛴 후라 숨이 차다.', 1),
    (w, '深く息を吸ってください。', '깊이 숨을 들이쉬세요.', 2);

  -- 10. 空席
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '空席', 'くうせき', '공석, 빈자리', '空(빌 공): 穴(구멍 혈) + 工(만들 공) → 비어있는 구멍
席(자리 석): 广(집) + 巾(천) → 천을 깐 자리', '명사', 10, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車に空席が一つあった。', '전철에 빈자리가 하나 있었다.', 1),
    (w, '会議室には空席がない。', '회의실에는 빈자리가 없다.', 2);

  -- 11. 失業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '失業', 'しつぎょう', '실업, 직업을 잃음', '失(잃을 실): 손(手)에서 물건이 떨어지는 모양
業(업 업): 일이나 직업의 뜻', '명사', 11, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不景気で失業者が増えた。', '불경기로 실업자가 늘었다.', 1),
    (w, '彼は半年間失業中だ。', '그는 반 년간 실업 상태다.', 2);

  -- 12. 夫婦
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '夫婦', 'ふうふ', '부부', '夫(지아비 부): 大(큰 사람) + 一(비녀) → 어른 남자
婦(아내 부): 女(여자) + 帚(빗자루) → 집안일 하는 여자', '명사', 12, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '隣の夫婦はとても仲がいい。', '옆집 부부는 매우 사이가 좋다.', 1),
    (w, '若い夫婦が引っ越してきた。', '젊은 부부가 이사 왔다.', 2);

  -- 13. 移す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '移す', 'うつす', '옮기다, 이동시키다', '移(옮길 이): 禾(벗 화) + 多(많을 다) → 벗단을 여러번 옮기다
타동사로 사물을 옮김', '동사', 13, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本棚を部屋の隅に移した。', '책장을 방 구석으로 옮겼다.', 1),
    (w, '会議を上の階に移しましょう。', '회의를 위층으로 옮깁시다.', 2);

  -- 14. 組む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '組む', 'くむ', '짜다, 맞추다', '組(끌 조): 糸(실 사) + 且(또 차) → 실을 서로 엺어 짜다
조직이나 팁을 만드는 동작', '동사', 14, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二人でチームを組む。', '둘이서 팁을 짜다.', 1),
    (w, '足を組んで座る。', '다리를 꼬고 앉다.', 2);

  -- 15. 順番
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '順番', 'じゅんばん', '순서, 순번, 차례', '順(순할 순): 川(강 천) + 頁(머리 혈) → 강이 흐르듯 자연스러운 순서
番(차례 번): 採(캤 채) + 田(밭 전) → 밭을 구분한 순서', '명사', 15, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '順番を守って並んでください。', '순서를 지켜서 줄서주세요.', 1),
    (w, '順番に名前を呼ぶ。', '순서대로 이름을 부른다.', 2);

  -- 16. 苦労
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '苦労', 'くろう', '고생, 고로', '苦(쓸 고): 艶(풀 초) + 古(옮 고) → 이 죽은 풀이 쓴맛
労(일할 로): 火(불 화) + 力(힘 력) → 불 옆에서 힘들이다', '명사', 16, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦労したおかげで成功した。', '고생한 덕분에 성공했다.', 1),
    (w, '長年の苦労が報われた。', '오랜 고생이 보상받았다.', 2);

  -- 17. 応募
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '応募', 'おうぼ', '응모, 지원', '応(응할 응): 广(집) + 心(마음) → 집안에서 마음으로 응하다
募(모을 모): 莫(없을 막) + 力(힘 력) → 힘을 모으다', '명사', 17, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'アルバイトに応募した。', '아르바이트에 지원했다.', 1),
    (w, 'コンテストへの応募者が多い。', '콘테스트 응모자가 많다.', 2);

  -- 18. 首都
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '首都', 'しゅと', '수도, 도읍지', '首(머리 수): 얼굴과 머리카락 모양 → 으뛸이 되는 머리
都(도읍 도): 者(놈 자) + 邑(고을 읍) → 사람이 모인 고을', '명사', 18, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京は日本の首都です。', '도쿄는 일본의 수도입니다.', 1),
    (w, '首都で大きな事故が起きた。', '수도에서 큰 사고가 났다.', 2);

  -- 19. 単語
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '単語', 'たんご', '단어', '単(홀 단): 口(입) 그림 두 개 + 甽(밭 전) → 하나의 단위
語(말씀 어): 言(말 언) + 吾(나 오) → 내가 하는 말', '명사', 19, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日単語を十個覚える。', '매일 단어를 10개 외운다.', 1),
    (w, 'この単語の意味がわからない。', '이 단어의 뜻을 모르겠다.', 2);

  -- 20. 地球
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '地球', 'ちきゅう', '지구', '地(땅 지): 土(흙 토) + 也(어조사 야) → 흙이 평평하게 펼쳐진 땅
球(공 구): 玉(구슬 옥) + 求(구할 구) → 둥근 구슬 모양', '명사', 20, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地球を守るためにゴミを出さない。', '지구를 지키기 위해 쓰레기를 버리지 않는다.', 1),
    (w, '地球は丸い。', '지구는 둥글다.', 2);

  -- 21. 発表
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '発表', 'はっぴょう', '발표, 공개 발표', '発(필 발): 활을 쏘듯 밖으로 내보내다
表(겉 표): 衣(옷 의) + 毛(털 모) → 겉으로 의미를 드러내다', '명사', 21, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスで調べたことを発表した。', '반에서 조사한 것을 발표했다.', 1),
    (w, '受賞者の名前が発表された。', '수상자의 이름이 발표되었다.', 2);

  -- 22. 遅れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '遅れる', 'おくれる', '늦다, 늦어지다', '遅(늦을 지): 辶(갈 착) + 犠(코뿔소 서) → 소는 느린 걸음
자동사로 시간이 지체되는 상태', '동사', 22, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が遅れて会議に間に合わなかった。', '전철이 늦어서 회의에 늦었다.', 1),
    (w, '起きるのが遅れて遅刻した。', '일어나는 것이 늦어 지각했다.', 2);

  -- 23. 協力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '協力', 'きょうりょく', '협력, 함께 힘쓸', '協(화합할 협): 十(열 십) + 力(힘 력) 세 개 → 여러 사람의 힘을 합칬
力(힘 력): 근육이나 쟁기 모양', '명사', 23, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご協力ありがとうございます。', '협력해 주셔서 감사합니다.', 1),
    (w, '互いに協力して問題を解決しよう。', '서로 협력해서 문제를 해결하자.', 2);

  -- 24. 疑問
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '疑問', 'ぎもん', '의문, 의심', '疑(의심할 의): 匕(비수 비) + 矢(화살 시) + 疋(어깧장 소) + 疋를 손으로 잡은 모양
問(물을 문): 口(입) + 門(문) → 문에서 입으로 묻다', '명사', 24, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何か疑問がありますか。', '뭐가 의문이 있습니까?', 1),
    (w, '疑問を持って調べることが大事だ。', '의문을 가지고 조사하는 것이 중요하다.', 2);

  -- 25. 過去
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '過去', 'かこ', '과거, 지난 때', '過(지날 과): 辶(갈 착) + 咿(끌 와) → 지나가다
去(갈 거): 土(흙) + 厶(사사로운 사) → 흥에서 멀리 떠나다', '명사', 25, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去にこだわらず未来を見よう。', '과거에 연연하지 말고 미래를 보자.', 1),
    (w, '過去の間違いを反省した。', '과거의 잘못을 반성했다.', 2);

  -- 26. 到着
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '到着', 'とうちゃく', '도착', '到(이를 도): 至(이를 지) + 刂(칼 도) → 최종 지점에 이르다
着(붙을 착): 羊(양 양) + 目(눈 목) → 양을 주시하다 → 닿다', '명사', 26, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飛行機の到着が遅れた。', '비행기 도착이 늦어졌다.', 1),
    (w, 'ホテルに到着したら電話してね。', '호텔에 도착하면 전화해.', 2);

  -- 27. 折る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '折る', 'おる', '접다, 구부리다', '折(껏을 절): 手(손 수) + 斤(도끼 근) → 손으로 도끼질하듯 껏다
타동사로 물건을 구부리는 동작', '동사', 27, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '紙を半分に折る。', '종이를 반으로 접다.', 1),
    (w, '足を折って入院した。', '다리를 부러뜨려 입원했다.', 2);

  -- 28. 情報
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '情報', 'じょうほう', '정보', '情(뜻 정): 心(마음 심) + 青(푸를 청) → 마음의 맑은 상태, 감정
報(걬을 보): 幸(다행 행) + 服(복종할 복) → 소식을 되돌려주다', '명사', 28, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インターネットで情報を集める。', '인터넷으로 정보를 모으다.', 1),
    (w, '最新の情報を伝えます。', '최신 정보를 전해드립니다.', 2);

  -- 29. 値段
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '値段', 'ねだん', '가격, 값', '値(값 치): 亻(사람 인) + 直(곱을 직) → 사람이 곱게 책정한 값
段(조각 단): 殳(찠 수) + 兇(언덕 안) → 계단처럼 나눴 가격 단계', '명사', 29, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この靴の値段はいくらですか。', '이 구두의 가격은 얼마입니까?', 1),
    (w, '値段が高すぎて買えない。', '가격이 너무 비싸서 살 수 없다.', 2);

  -- 30. 深い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '深い', 'ふかい', '깊다', '深(깊을 심): 氵(물 수) + 穴(구멍 혈) + 火(불) → 물이 구멍을 깊이 들어감
い형용사 어미 → 깊은 상태', 'い형용사', 30, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この湖はとても深い。', '이 호수는 매우 깊다.', 1),
    (w, '彼との友情は深い。', '그와의 우정은 깊다.', 2);

  -- 31. 返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '返す', 'かえす', '돌려주다, 반납하다', '返(돌아올 반): 辶(갈 착) + 反(돌이킬 반) → 원래 자리로 돌아가다
타동사로 먼저 가졌던 것을 돌려주는 동작', '동사', 31, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '個りた本を図書館に返した。', '빌린 책을 도서관에 반납했다.', 1),
    (w, 'もらった有金を返すことにした。', '받은 돈을 돌려주기로 했다.', 2);

  -- 32. 表面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '表面', 'ひょうめん', '표면, 겉', '表(겉 표): 衣(옷 의) + 毛(털 모) → 옷의 겉 모양
面(냭 면): 首(머리 수)에서 얼굴 부분 → 사물의 냭', '명사', 32, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鉄の表面が錆びている。', '철의 표면이 녹슬었다.', 1),
    (w, '月の表面にはクレーターがある。', '달의 표면에는 크레이터가 있다.', 2);

  -- 33. 汗
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '汗', 'あせ', '땅, 익', '汗(땅 한): 氵(물 수) + 干(방패 간) → 신체에서 나오는 물
피부에서 나오는 수분', '명사', 33, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走ったら汗がいっぱい出た。', '뛰었더니 땅이 잘뤁 나왔다.', 1),
    (w, '夏は汗をかきやすい。', '여름은 땅을 흘리기 쉽다.', 2);

  -- 34. 配る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '配る', 'くばる', '나누어 주다, 배포하다', '配(나눌 배): 酉(닭 유) + 己(몸 기) → 술독을 곁들에 배치하다
타동사로 여러 사람에게 분배', '동사', 34, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プリントをクラスのみんなに配った。', '프린트를 반 전체에게 나누어 줬다.', 1),
    (w, 'チラシを驅に配っている。', '전단지를 역에서 나눠주고 있다.', 2);

  -- 35. 完成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '完成', 'かんせい', '완성', '完(완전할 완): 宀(집 면) + 元(으뜹 원) → 집이 완벽하게 완전함
成(이룰 성): 戊(창 무) + 丁(장정 정) → 무기로 일을 이루다', '명사', 35, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '論文がやっと完成した。', '논문이 마침내 완성되었다.', 1),
    (w, 'この模型は未だ完成していない。', '이 모형은 아직 완성되지 않았다.', 2);

  -- 36. 島
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '島', 'しま', '섬', '島(섬 도): 山(산) + 鳥(새 조) → 새가 쉬어가는 바다의 산
바다 가운데 손아오른 육지', '명사', 36, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏休みに南の島へ行きたい。', '여름 휴가에 남에 있는 섬으로 가고 싶다.', 1),
    (w, 'その島には人が住んでいない。', '그 섬에는 사람이 살고 있지 않다.', 2);

  -- 37. 困る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '困る', 'こまる', '곤란하다, 난처하다', '困(곤할 곤): 囗(이위 위) + 木(나무 목) → 울타리 안의 나무, 갇힌 상태
머리를 쓸 수 없는 상황', '동사', 37, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に答えられず困った。', '질문에 답하지 못해 곤란했다.', 1),
    (w, 'お金がなくて困っている。', '돈이 없어서 곤란하다.', 2);

  -- 38. 平日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '平日', 'へいじつ', '평일, 평날', '平(평평할 평): 于(어조사 우) + 八(여덟 팔) → 결이 고르고 평평함
日(날 일): 해의 모양', '명사', 38, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平日は仕事で忙しい。', '평일에는 일로 바쁨다.', 1),
    (w, 'このレストランは平日だけ開いている。', '이 식당은 평일에만 엽다.', 2);

  -- 39. 卒業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '卒業', 'そつぎょう', '졸업', '卒(마칠 졸): 衣(옷 의) + 十(열 십) → 일의 마침
業(업 업): 일이나 학업의 뜻', '명사', 39, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年大学を卒業します。', '올해 대학을 졸업합니다.', 1),
    (w, '卒業式に家族が来た。', '졸업식에 가족이 왔다.', 2);

  -- 40. 固い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '固い', 'かたい', '딱딱하다, 단단하다', '固(굳을 고): 囗(에워쌉 위) + 古(옮 고) → 오래도록 둘러싸여 단단함
물체의 단단한 상태', 'い형용사', 40, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このパンは固い。', '이 빵은 딱딱하다.', 1),
    (w, '彼は意志が固い。', '그는 의지가 단단하다.', 2);

  -- 41. 短い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '短い', 'みじかい', '짧다', '短(짧을 단): 矢(화살 시) + 豆(콩 두) → 짧은 화살과 공
길이나 시간이 짧은 상태', 'い형용사', 41, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このスカートは短い。', '이 치마는 짧다.', 1),
    (w, '休みが短い。', '휴가가 짧다.', 2);

  -- 42. 他人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '他人', 'たにん', '타인, 남', '他(다를 타): 亻(사람 인) + 也(이글 야) → 다른 사람
人(사람 인): 서있는 사람의 모양', '명사', 42, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人のことを言うな。', '남의 일을 말하지 마라.', 1),
    (w, '他人の話をよく聞こう。', '다른 사람의 이야기를 잘 듣자.', 2);

  -- 43. 示す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '示す', 'しめす', '나타내다, 가리키다', '示(보일 시): 二(두 이) + 小(작을 소) → 제단 위의 제물, 그것을 보이다
타동사로 상대에게 드러내다', '동사', 43, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'グラフでデータを示した。', '그래프로 데이터를 나타냈다.', 1),
    (w, '道を示してもらった。', '길을 가르쳐 받았다.', 2);

  -- 44. 外科
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '外科', 'げか', '외과', '外(바깥 외): 夕(저녁 석) + 卜(점 복) → 저녁에 점을 치는 곳 → 바깥
科(과목 과): 禾(벗 화) + 斗(말 두) → 공부를 말로 나눌', '명사', 44, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外科の医者に見てもらった。', '외과 의사에게 진료받았다.', 1),
    (w, '外科手術を受けた。', '외과 수술을 받았다.', 2);

  -- 45. 笑顔
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '笑顔', 'えがお', '웃는 얼굴, 미소', '笑(웃을 소): 竹(대 죽) + 夭(요솠한 요) → 대나무가 휠는 모양
顔(냭 안): 顆(머리 혈) + 彡(터럭 삼) → 얼굴의 모습', '명사', 45, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつも笑顔で迎えてくれる。', '언제나 미소로 맞아준다.', 1),
    (w, '赤ちゃんの笑顔が可愛い。', '아기의 웃는 얼굴이 귀엽다.', 2);

  -- 46. 以降
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '以降', 'いこう', '이후', '以(써 이): 亻(사람 인) + 㕒 → 어떤 시점을 기준으로
降(내릴 강): 阜(언덕 부) + 梱(천천히 걸을 서) → 언덕을 서서히 내려오다', '명사', 46, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '午後五時以降は会議がある。', '오후 5시 이후에는 회의가 있다.', 1),
    (w, '明日以降、会議は中止します。', '내일 이후 회의는 중지합니다.', 2);

  -- 47. 横断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '横断', 'おうだん', '횡단, 가로지름', '横(가로 횡): 木(나무 목) + 黄(누린 황) → 가로롭게 녹은 나무
断(끊을 단): 絲(이을 계) + 斤(도끼 근) → 도끼로 실을 끊다', '명사', 47, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '信号を守って道を横断しましょう。', '신호를 지켜 길을 횡단합시다.', 1),
    (w, '横断歩道で渡る。', '횡단보도로 건너다.', 2);

  -- 48. 合図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '合図', 'あいず', '신호, 악속', '合(합할 합): 人(사람 인) + 一(한 일) + 口(입) → 여러 사람이 입을 모아는 모양
図(그림 도): 囗(에워쌉) + 圖(그림) → 테두리 안의 그림', '명사', 48, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合図を送ってください。', '신호를 보내 주세요.', 1),
    (w, '合図とともに走り出した。', '신호와 함께 뛰기 시작했다.', 2);

  -- 49. 苦しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '苦しい', 'くるしい', '괴롭다, 힘들다', '苦(쓸 고): 艶(풀 초) + 古(옮 고) → 쓴맛, 괴로움
しい형용사로 육체·정신적 괴로움을 표현', 'い형용사', 49, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生活が苦しい。', '생활이 힘들다.', 1),
    (w, '息が苦しくなった。', '숨이 가쾰졌다.', 2);

  -- 50. 出張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '出張', 'しゅっちょう', '출장', '出(날 출): 아래에서 위로 나오는 모양
張(베풀 장): 弓(활 궁) + 長(길 장) → 활을 길게 잡아당김 → 넓게 펼치다', '명사', 50, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来週、東京へ出張します。', '다음 주에 도쿄로 출장입니다.', 1),
    (w, 'オーストラリア出張が多い。', '호주 출장이 잔다.', 2);

  -- 51. 席
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '席', 'せき', '자리, 좌석', '席(자리 석): 广(집) + 巾(수건 건) → 집 안에 수건을 깐아 둘 자리
앚아 쓸 수 있는 공간', '명사', 51, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここの席は空いていますか。', '이 자리는 비어 있습니까?', 1),
    (w, '自分の席にもどりました。', '자기 자리로 돌아왔다.', 2);

  -- 52. 根
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '根', 'ね', '뿌리, 근본', '根(뿌리 근): 木(나무 목) + 艮(그칠 간) → 나무를 지탱하는 부분
식물의 뿌리, 또는 사물의 근본', '명사', 52, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '木の根が深く伸びている。', '나무의 뿌리가 깊게 뻗어 있다.', 1),
    (w, '問題の根はどこにあるのか。', '문제의 근본은 어디에 있는가.', 2);

  -- 53. 事情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '事情', 'じじょう', '사정, 상황', '事(일 사): 일을 하는 손을 그린 글자
情(뜻 정): 心(마음) + 青(푸르다) → 마음의 상태, 감정', '명사', 53, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事情を説明してください。', '사정을 설명해 주세요.', 1),
    (w, '個人的な事情で休みます。', '개인적인 사정으로 쉬겠습니다.', 2);

  -- 54. 通知
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '通知', 'つうち', '통지, 알림', '通(통할 통): 辶(갈 착) + 甬(길 용) → 길이 통하다
知(알 지): 矢(화살 시) + 口(입 구) → 화살이 날아가듯 와닿는 말', '명사', 54, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メールで通知します。', '메일로 통지합니다.', 1),
    (w, '合格通知が届いた。', '합격 통지가 도착했다.', 2);

  -- 55. 選手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '選手', 'せんしゅ', '선수', '選(가릴 선): 辶(갈 착) + 巽(뒀뒀할 손) → 올바르게 골라내다
手(손 수): 다섯 손가락을 펼친 모양', '명사', 55, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカー選手になりたい。', '축구 선수가 되고 싶다.', 1),
    (w, '代表選手に選ばれた。', '대표 선수로 뽑혔다.', 2);

  -- 56. 実力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '実力', 'じつりょく', '실력', '実(열매 실): 宀(집) + 貝(조개) + 入(들 입) → 집안에 재물이 가득 차있는 모양
力(힘 력): 힘의 근원', '명사', 56, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実力で勝負を決める。', '실력으로 승부를 결정한다.', 1),
    (w, '彼の実力は本物だ。', '그의 실력은 진짜다.', 2);

  -- 57. 生える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '生える', 'はえる', '나다, 돋아나다', '生(날 생): 싹이 흥을 밀고 나오는 모양
자동사로 식물·이가 돋아남', '동사', 57, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広い庭に草が生えた。', '넓은 마당에 풀이 돋았다.', 1),
    (w, '赤ちゃんに歯が生えた。', '아기에게 이가 났다.', 2);

  -- 58. 各地
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '各地', 'かくち', '각지, 여러 곳', '各(각각 각): 夕(다륷 차) + 口(입) → 각각의 입·의견
地(땅 지): 土(흙) + 也(이글 야) → 지역·장소', '명사', 58, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本各地を旅したい。', '일본 각지를 여행하고 싶다.', 1),
    (w, '各地でイベントが開かれる。', '각지에서 이벤트가 열린다.', 2);

  -- 59. 貯金
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '貯金', 'ちょきん', '저금', '貯(쌓을 저): 貝(조개 패) + 宁(주정 녕) → 재물을 곡간에 쌓아둡
金(쇠 금): 주금소의 모양 → 금속', '명사', 59, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎月三万円貯金している。', '매달 3만엔을 저금하고 있다.', 1),
    (w, '貯金がようやく十万円に達した。', '저금이 결국 10만 엔에 달했다.', 2);

  -- 60. 留守
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '留守', 'るす', '부재, 집에 없음', '留(머물 류): 卯(머물·필머리 류의 올롬자) + 田(밭) → 머문르다
守(지킬 수): 宀(집) + 寸(마디) → 집을 완급히 지키다', '명사', 60, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話したが留守だった。', '전화했는데 부재중이었다.', 1),
    (w, '留守番電話に伝言を残した。', '자동응답에 메시지를 남겼다.', 2);

  -- 61. 浅い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '浅い', 'あさい', '얇다', '浅(얇을 천): 氵(물) + 搏(해칠 잔) → 물이 적고 얇은 상태
い형용사로 깊이가 적음', 'い형용사', 61, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このプールは浅い。', '이 수영장은 얇다.', 1),
    (w, '知識が浅いと同じだ。', '지식이 얇다고 어디서 들었다.', 2);

  -- 62. 文章
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '文章', 'ぶんしょう', '문장, 글', '文(글월 문): 사람의 몸에 문달을 그린 모양→글자
章(글 장): 立(설 립) + 早(이를 조) → 글이 명확하게 서있다', '명사', 62, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この文章は読みやすい。', '이 글은 읽기 쉽다.', 1),
    (w, '長い文章を書かなきゃならない。', '긴 문장을 써야만 한다.', 2);

  -- 63. 改札
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '改札', 'かいさつ', '개찰, 개찰구', '改(고칠 개): 己(몸·자기) + 攵(칠 복) → 자기 자신을 고치다
札(편지 찰): 木(나무) + 乙(새 을) → 김어서 글을 어랜 나무쪽', '명사', 63, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '改札を出てすぐ右です。', '개찰구를 나와서 바로 오른쪽입니다.', 1),
    (w, '改札機にカードをタッチする。', '개찰기에 카드를 태그한다.', 2);

  -- 64. 笑う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '笑う', 'わらう', '웃다', '笑(웃을 소): 竹(대 죽) + 夭(요솠한 요) → 대나무가 휠는 모양과 웃음을 연상
자동사로 웃는 동작', '동사', 64, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談を言ってみんなを笑わせた。', '농담을 해서 모두를 웃겼다.', 1),
    (w, '笑った顔が可愛い。', '웃는 얼굴이 귀엽다.', 2);

  -- 65. 商業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '商業', 'しょうぎょう', '상업, 장사', '商(장사 상): 言(말 언) + 內(안 내) → 입으로 말하며 교환한 것
業(업 업): 일이나 직업의 뜻', '명사', 65, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学で商業を勉強した。', '대학에서 상업을 공부했다.', 1),
    (w, 'この地域は商業が盛んだ。', '이 지역은 상업이 활발하다.', 2);

  -- 66. 覚える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '覚える', 'おぼえる', '외우다, 기억하다', '覚(깨달을 각): 學(배울 학)의 일부 + 見(볼 견) → 배워서 극연 알아차림
타동사로 머리에 입력하다', '동사', 66, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '漢字をこつこつ覚える。', '한자를 꾸준히 외운다.', 1),
    (w, '名前を覚えておいてください。', '이름을 기억해 두세요.', 2);

  -- 67. 広告
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '広告', 'こうこく', '광고', '広(넓을 광): 广(집) + 黄(누립) → 집이 넓고 틀이 그닅
告(고할 고): 牛(소 우) + 口(입 구) → 희생물을 바치며 고하다', '명사', 67, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビで広告を見た。', '텔레비전에서 광고를 봤다.', 1),
    (w, '商品の広告を作った。', '상품의 광고를 만들었다.', 2);

  -- 68. 相手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '相手', 'あいて', '상대, 상대방', '相(서로 상): 木(나무) + 目(눈) → 나무를 눈으로 서로 보다
手(손 수): 손의 모양', '명사', 68, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話す相手がいない。', '이야기할 상대가 없다.', 1),
    (w, 'この試合の相手は強い。', '이 시합의 상대는 강하다.', 2);

  -- 69. 大会
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '大会', 'たいかい', '대회', '大(큰 대): 사람이 팔을 크게 벌린 모양
会(모일 회): 业(대야·넘친) + 曰(가로다·쁜) → 그릇 안에 사람이 모임', '명사', 69, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'マラソン大会に出てみたい。', '마라톤 대회에 나가보고 싶다.', 1),
    (w, '大会で会った友人と仑ず、息が抹める。', '대회에서 만난 친구와 그 당시 만난 것 같다.', 2);

  -- 70. 割れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '割れる', 'われる', '깨지다, 나뉘어지다', '割(나눌 할): 害(해칠 해) + 刂(칼 도) → 칼로 잘라내다
자동사로 물건이 깨지거나 분리', '동사', 70, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コップが割れてしまった。', '컵이 깨져 버렸다.', 1),
    (w, '意見が二つに割れた。', '의견이 둘로 나뉘었다.', 2);

  -- 71. 集中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '集中', 'しゅうちゅう', '집중', '集(모일 집): 隹(새 추) + 木(나무) → 새가 나무에 모이다
中(가운데 중): 구역의 한복판을 관통한 모양', '명사', 71, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強に集中したい。', '공부에 집중하고 싶다.', 1),
    (w, '仕事に集中できない。', '일에 집중할 수 없다.', 2);

  -- 72. 食器
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '食器', 'しょっき', '식기', '食(밥 식): 人(사람 인) + 良(좋을 량) → 사람이 좋은 것을 먹음
器(그릇 기): 口(입) 4개 + 犬(개 견) → 그릇 4개와 개가 도다니는 모양', '명사', 72, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食器を洗う。', '식기를 씨싹.', 1),
    (w, '食器棚に並べる。', '식기가 있는 자리에 보관한다.', 2);

  -- 73. 横
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '横', 'よこ', '옆, 가로', '横(가로 횡): 木(나무) + 黄(누린 황) → 가로로 녹이는 나무
옆 단면 또는 수평 방향', '명사', 73, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の横に座る。', '그의 옆에 앉다.', 1),
    (w, '軽乗りと軽に見て横に並んだ。', '차와 차는 워키와 차도로 나란히 있다.', 2);

  -- 74. 自然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自然', 'しぜん', '자연', '自(스스로 자): 코를 그린 모양→ 자기 자신
然(그럴 연): 犬(개 견) + 灬(불 화) + 肉(고기 육) → 고기를 불에 익은 상태', '명사', 74, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自然の中で過ごしたい。', '자연 속에서 지내고 싶다.', 1),
    (w, 'この公園は自然が豊かだ。', '이 공원은 자연이 풍부하다.', 2);

  -- 75. 替える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '替える', 'かえる', '교체하다, 바꾸다', '替(바꿀 체): 曰(가로다) + 二(일 이) → 두 개를 서로 바꾸다
타동사로 새로운 것으로 전환', '동사', 75, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電池を新しいのに替えた。', '건전지를 새 것으로 교체했다.', 1),
    (w, 'シーツを替える。', '시트를 교체한다.', 2);

  -- 76. 応用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '応用', 'おうよう', '응용', '応(응할 응): 广(집) + 心(마음) → 이에 맞게 대응
用(쓸 용): 卜(점) + 中(가운데) → 점쳐서 따른 쓰임의 도구', '명사', 76, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '理論を応用して問題を解く。', '이론을 응용해서 문제를 푸다.', 1),
    (w, '応用問題は難しい。', '응용문제는 어렵다.', 2);

  -- 77. 一般的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '一般的', 'いっぱんてき', '일반적인, 보편적인', '一般(일반): 一(하나로 하나) + 般(갈바 반: 단단한 종류)→ 같은 종류
的(과녁 적): 白(흧 백) + 勺(숨긴 포)→ 높이 건 외괄을 끌어내는 구리 어미', 'な형용사', 77, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは一般的な意見だ。', '이것은 일반적인 의견이다.', 1),
    (w, '一般的に言うと、そうは思わない。', '일반적으로 말하면 그렇게는 생각하지 않는다.', 2);

  -- 78. 検査
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '検査', 'けんさ', '검사', '検(철할 검): 木(나무) + 僉(다 첨)→ 여러개를 검토하다
査(조사할 사): 木(나무) + 且(또 차)→ 곧장을 자세히 살핌', '명사', 78, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体の検査を受けた。', '몸의 검사를 받았다.', 1),
    (w, '検査の結果は明日出る。', '검사 결과는 내일 나온다.', 2);

  -- 79. 厚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '厚い', 'あつい', '두껍다', '厚(두터울 후): 厂(머릿돌 한) + 日(해) + 子(아이)→ 재물이 두터움
い형용사로 물체가 두꺼운 상태', 'い형용사', 79, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は厚い。', '이 책은 두꺽다.', 1),
    (w, '厚いコートを着た。', '두꺼운 코트를 입었다.', 2);

  -- 80. 呼吸
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '呼吸', 'こきゅう', '호흡', '呼(부를 호): 口(입) + 乎(어조사 호)→ 수하고 내쉬다
吸(마실 흡): 口(입) + 及(미칠 급)→ 입으로 빨아들이다', '명사', 80, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '深呼吸して落ち着こう。', '심호흡해서 진정하자.', 1),
    (w, '呼吸が乱れている。', '호흡이 거칠다.', 2);

  -- 81. 美しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '美しい', 'うつくしい', '아름답다', '美(아름다울 미): 羊(양) + 大(큰 대)→ 살진 컰 양이 아름답다
しい형용사로 외관·의미의 아름다움', 'い형용사', 81, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女の話し方は美しい。', '그녀의 말투는 아름답다.', 1),
    (w, 'この景色は美しい。', '이 경치는 아름답다.', 2);

  -- 82. 創造
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '創造', 'そうぞう', '창조', '創(비롯 창): 倉(공광 창) + 刂(칼)→ 칼로 새롭게 만들다
造(지을 조): 辶(갈 착) + 告(고할 고)→ 행하여 만들어내다', '명사', 82, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '芸術は創造の世界だ。', '예술은 창조의 세계다.', 1),
    (w, '新しい価値を創造する。', '새로운 가치를 창조한다.', 2);

  -- 83. 汚れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '汚れる', 'よごれる', '더러워지다', '汚(더러울 오): 氵(물) + 于(어조사 우)→ 물이 고여 뗌들어짐
자동사로 표면에 오염이 멉음', '동사', 83, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '服がインクで汚れた。', '옷이 잉크로 더러워졌다.', 1),
    (w, '靴が泥で汚れている。', '구두가 진흑으로 더러워져 있다.', 2);

  -- 84. 朝食
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '朝食', 'ちょうしょく', '조식, 아침 식사', '朝(아침 조): 艸(풀) + 日(해)→ 풀으로 세뚸 때 해가 뛰는 모양
食(밥 식): 人(사람) + 良(좋을 량)→ 좋은 것을 먹다', '명사', 84, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝食はパンとコーヒーだ。', '조식은 빵과 커피이다.', 1),
    (w, 'ホテルで朝食を高めた。', '호텔에서 조식을 먹었다.', 2);

  -- 85. 首
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '首', 'くび', '목', '首(머리 수): 머리카락과 얼굴 모양→ 몸의 상쪽 중심인 목·머리
그률의 입 부분을 특정해 목의 뜻이 됨', '명사', 85, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '首が痛い。', '목이 아프다.', 1),
    (w, 'マフラーを首に巻いた。', '만키프를 목에 감았다.', 2);

  -- 86. 経営学
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '経営学', 'けいえいがく', '경영학', '経営(경영): 経(지날 경) + 営(경영할 영)→ 계획해서 관리하다
学(배울 학): 另(헐어질 키) + 子(아이)→ 아이가 배움', '명사', 86, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学で経営学を専攻している。', '대학에서 경영학을 전공하고 있다.', 1),
    (w, '経営学の本を読んだ。', '경영학 책을 읽었다.', 2);

  -- 87. 分類
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '分類', 'ぶんるい', '분류', '分(나눌 분): 八(여덟 팔) + 刂(칼)→ 칼로 나눔
類(무리 류): 米(쌌 미) + 犬(개) + 頁(머리 혈)→ 같은 부류로 모이다', '명사', 87, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本をジャンルで分類した。', '책을 장르별로 분류했다.', 1),
    (w, 'ゴミの分類は難しい。', '쓰레기 분류는 어렵다.', 2);

  -- 88. 干す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '干す', 'ほす', '널어 말리다, 잔을 비우다', '干(방패 간): 그 간 그림→ 주돌이로 치는 도구, 건조시키다
타동사로 수분을 제거', '동사', 88, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '洗濯物を干した。', '빨래를 널어 말렸다.', 1),
    (w, 'グラスを干した。', '잔을 비웠다.', 2);

  -- 89. 血液型
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '血液型', 'けつえきがた', '혈액형', '血液(혈액): 血(피 혈) + 液(액체 액)→ 신체 안의 액체
型(틀 형): 型·모형→ 형식·타입', '명사', 89, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の血液型はA型だ。', '내 혈액형은 A형이다.', 1),
    (w, '血液型は性格と関係ない。', '혈액형은 성격과 상관없다.', 2);

  -- 90. 湖
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '湖', 'みずうみ', '호수', '湖(호수 호): 氵(물) + 古(옮 고) + 月(달)→ 오래된 물이 고인 곳
うみ(바다)와 달리 물이 고여있는 대욱지', '명사', 90, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '湖の周りを散歩した。', '호수 주변을 산책했다.', 1),
    (w, 'この湖に魚がたくさんいる。', '이 호수에 물고기가 잔다.', 2);

  -- 91. 変化
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '変化', 'へんか', '변화', '変(변할 변): 言(말씀) + 攵(츠)→ 말해서 바꾸다
化(보할 화): 人(사람) + 匕(비수 비)→ 사람이 바뀌다', '명사', 91, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームに変化があった。', '팁에 변화가 있었다.', 1),
    (w, '気温の変化に注意してください。', '기온의 변화에 주의하세요.', 2);

  -- 92. 伝える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '伝える', 'つたえる', '전달하다', '伝(전할 전): 亻(사람) + 專(돌릴 전)→ 사람이 돌려 전하다
타동사로 메시지·기술을 전수함', '동사', 92, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よろしく伝えてください。', '잘 전해주세요.', 1),
    (w, '気持ちを言葉で伝える。', '마음을 말로 전한다.', 2);

  -- 93. 荷物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '荷物', 'にもつ', '짐, 화물', '荷(짐 하): 艹(풀) + 何(어챌 하)→ 어떻게 짐을 옮길까
物(물건 물): 牛(소) + 勿(말 물)→ 여러가지 실체', '명사', 93, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物を送りました。', '짐을 부치습니다.', 1),
    (w, '重い荷物を上げた。', '무거운 짐을 들었다.', 2);

  -- 94. 平均
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '平均', 'へいきん', '평균', '平(평평할 평): 결이 고르고 평평함
均(고를 균): 土(흙) + 勻(고를 균)→ 흕을 고르게 다듬', '명사', 94, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスの平均点は七十点だ。', '반의 평균점은 70점이다.', 1),
    (w, '平均して三十個だ。', '평균으로 30개이다.', 2);

  -- 95. 支給
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '支給', 'しきゅう', '지급', '支(지탱할 지): 又(또 우) + 十(열)→ 손으로 지탱하다
給(줄 급): 糸(실) + 合(합할 합)→ 실을 어울려 담다', '명사', 95, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '給与が支給された。', '월급이 지급되었다.', 1),
    (w, '交通費を支給します。', '교통비를 지급합니다.', 2);

  -- 96. 丸い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '丸い', 'まるい', '둥글다', '丸(둥근 환): 包(쓸 포) + 丶(점)→ 싸이고 둥근
い형용사로 형상이 둥근 상태', 'い형용사', 96, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丸いテーブルを買った。', '둥근 테이블을 샀다.', 1),
    (w, '地球は丸い。', '지구는 둥글다.', 2);

  -- 97. 個人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '個人', 'こじん', '개인', '個(낭개 개): 亻(사람) + 固(굳을 고)→ 단단한 하나의 사람
人(사람 인): 서있는 사람의 옥의', '명사', 97, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '個人的な意見です。', '개인적인 의견입니다.', 1),
    (w, '個人情報は保護されている。', '개인정보는 보호되고 있다.', 2);

  -- 98. 方向
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '方向', 'ほうこう', '방향', '方(모 방): 쌝기를 구했던 대는 모양→ 모서리, 방향
向(향할 향): 宀(집) + 口(입)→ 집이 향한 쪽', '명사', 98, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風の方向が変わった。', '바람의 방향이 바뀌었다.', 1),
    (w, '進むべき方向がわからない。', '나아갈 방향을 모르겠다.', 2);

  -- 99. 申し込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '申し込み', 'もうしこみ', '신청', '申(폌 신): 번개가 치는 모양→ 펼쳐서 말하다
込(담김 입): 辶(갈 착) + 入(들 입)→ 안으로 들어가다', '명사', 99, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンサートの申し込みをした。', '콘서트의 신청을 했다.', 1),
    (w, '申し込みは明日までだ。', '신청은 내일까지다.', 2);

  -- 100. はかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'はかる', '재다, 측정하다', '計る(수치를 계산)·量る(무게를 잼)·測る(길이를 잼) 등의 표기
소리가 같지만 대상에 따라 한자가 달라지는 동사', '동사', 100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体重をはかる。', '체중을 잰다.', 1),
    (w, '長さをはかってみた。', '길이를 측정해 보았다.', 2);

  -- 101. 独立
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '独立', 'どくりつ', '독립', '独(홀로 독): 犭(개) + 蜀(나라이름)→ 홀로 가는 개
立(설 립): 사람이 땅 위에 서있는 모양', '명사', 101, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年で二十歳、もう独立した。', '올해로 20세, 벌써 독립했다.', 1),
    (w, '会社を辞めて独立する。', '회사를 그만두고 독립한다.', 2);

  -- 102. 折れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '折れる', 'おれる', '부러지다, 꺾이다', '折: 手(손) + 斤(도끼)→ 손으로 꺾다
자동사형 れる이 붙은 경우', '동사', 102, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '足の骨が折れた。', '다리 뻘가 부러졌다.', 1),
    (w, 'ボールペンが折れた。', '볼펜이 부러졌다.', 2);

  -- 103. 観客
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '観客', 'かんきゃく', '관객', '観(볼 관): 雚(좆진 관) + 見(볼 견)→ 자세히 보다
客(손 객): 宀(집) + 各(각각)→ 집에 온 방문객', '명사', 103, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '観客が拍手した。', '관객이 박수를 터트렸다.', 1),
    (w, '観客の多い試合だった。', '관객이 많은 경기였다.', 2);

  -- 104. 払う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '払う', 'はらう', '지불하다', '払(벋을 분): 手(손) + 弗(아닐 불)→ 손으로 다 떼어내다
돈을 끝으로 지불하는 의미', '동사', 104, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カードで払う。', '카드로 지불한다.', 1),
    (w, '授業料を払った。', '수업료를 보냈다.', 2);

  -- 105. 加える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '加える', 'くわえる', '추가하다, 더하다', '加(더할 가): 力(힘) + 口(입)→ 힘을 더하다
타동사로 이미 있는 것에 더함', '동사', 105, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スープに塩を加えた。', '수프에 소금을 넣었다.', 1),
    (w, 'メンバーを一人加える。', '멤버를 한 명 높리고.', 2);

  -- 106. 訓練
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '訓練', 'くんれん', '훈련', '訓(가르칠 훈): 言(말) + 川(강)→ 말이 강처럼 이어져 가르치다
練(익혀 련): 糸(실) + 柬(가릴 간)→ 실을 골라내 단련하다', '명사', 106, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳しい訓練をうけた。', '엄격한 훈련을 받았다.', 1),
    (w, '新人訓練が始まった。', '신입 훈련이 시작되었다.', 2);

  -- 107. 豆
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '豆', 'まめ', '콩', '豆(콩 두): 뚚껍이 달린 제기의 모양→ 이후 콩을 뜻하게 됨
콩과 좋은 입자르는 콩과의 원재료', '명사', 107, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豆を畫いた。', '콩을 심었다.', 1),
    (w, '豆を使った料理が好きだ。', '콩을 쓴 요리를 좋아한다.', 2);

  -- 108. 共通
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '共通', 'きょうつう', '공통', '共(함께 공): 양손으로 함께 들어올리는 모양
通(통할 통): 辶(갈 착) + 甬(길 용)→ 길이 통하다', '명사', 108, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '共通の趣味がある。', '공통의 취미가 있다.', 1),
    (w, '互いに共通の点を見つける。', '서로 공통점을 찾는다.', 2);

  -- 109. 税金
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '税金', 'ぜいきん', '세금', '税(세금 세): 禾(벗) + 兌(고늿합 태)→ 수확물에 받는 국세
金(쇠 금): 귀금속의 모양→ 돈', '명사', 109, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '税金を払う。', '세금을 낸다.', 1),
    (w, '税金が高い。', '세금이 높다.', 2);

  -- 110. 汚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '汚い', 'きたない', '더럽다', '汚(더러울 오): 氵(물) + 于(어조사)→ 고인 더러운 물
い형용사로 외관이나 내용이 지저분함', 'い형용사', 110, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手が汚いから洗いなさい。', '손이 더러우니 씨어라.', 1),
    (w, '汚い言葉を使わない。', '더러운 말을 쓰지 않는다.', 2);

  -- 111. 商品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '商品', 'しょうひん', '상품, 물건', '商(장사 상): 言(말)…→ 말로 파는 것
品(물건 품): 口(입) 3개→ 여러 개가 모인 물건', '명사', 111, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この商品は人気だ。', '이 상품은 인기다.', 1),
    (w, '新商品が発売された。', '신상품이 출시되었다.', 2);

  -- 112. 冷える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '冷える', 'ひえる', '차가워지다, 식다', '冷(찌 랙): 冫(얼음) + 令(아릉다 령)→ 얼음처럼 시림
자동사형 온도가 낮아짐', '동사', 112, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スープが冷えてしまった。', '수프가 식어 버렸다.', 1),
    (w, '体が冷えた。', '몸이 차가워졌다.', 2);

  -- 113. 早退
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '早退', 'そうたい', '조퇴', '早(일육 조): 日(해) + 十(열)→ 해가 일짐 뜰
退(물러날 퇴): 辶(갈 착) + 艮(그칠 간)→ 가다가 멈춰 돌아옴', '명사', 113, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は体調が悪くて早退した。', '오늘은 컴디션이 안 좋아서 조퇴했다.', 1),
    (w, '早退して医者に行った。', '조퇴하고 병원에 갔다.', 2);

  -- 114. 下線
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '下線', 'かせん', '밑줄', '下(아래 하): 기준선 아래에 붙은 표시
線(줄 선): 糸(실) + 泉(샘 천) → 길게 이어진 줄', '명사', 114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な語に下線を引いた。', '중요한 단어에 밑줄을 그었다.', 1),
    (w, '下線部を読んでください。', '밑줄 부분을 읽어주세요.', 2);

  -- 115. 転ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '転ぶ', 'ころぶ', '구르다, 넘어지다', '転(구를 전): 車(수레) + 専(오로지 전) → 수레가 구르듯 돌다
자동사로 회전하며 쓰러짐', '동사', 115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道で転んでケガをした。', '길에서 넘어져 다쳤다.', 1),
    (w, '走ったら転ぶよ。', '뛰면 넘어져.', 2);

  -- 116. 主要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '主要', 'しゅよう', '주요', '主(주인 주): 灯(등잔)의 불꽃→ 중심을 차지하는 것
要(요긴할 요): 覀(답답할 서) + 女(여자)→ 신체의 중을 여며 주요한 곳', '명사', 116, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '主要な原因は三つある。', '주요한 원인은 세 가지다.', 1),
    (w, 'この街の主要な道路だ。', '이 도시의 주요 도로다.', 2);

  -- 117. 直接
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '直接', 'ちょくせつ', '직접', '直(곧을 직): 十(열) + 目(눈) + 丂(숨을 은)→ 여러 눈으로 보면 숨골 없이 곧음
接(이을 접): 手(손) + 妄(첩 첩)→ 손으로 이어붙임', '명사', 117, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長に直接電話した。', '사장에게 직접 전화했다.', 1),
    (w, '直接会って話そう。', '직접 만나서 이야기하자.', 2);

  -- 118. 燃える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '燃える', 'もえる', '타다', '燃(타오르 연): 火(불) + 然(그런)→ 고기가 불에 탄
자동사형 える이 붙은 형태', '동사', 118, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '森が燃えている。', '숲이 타고 있다.', 1),
    (w, 'ごみが燃えて火事になった。', '쓰레기가 타서 화재가 났다.', 2);

  -- 119. 位置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '位置', 'いち', '위치', '位(자리 위): 亻(사람) + 立(설 립)→ 사람이 서 있는 곳
置(둘 치): 网(그물) + 直(곱을 직)→ 곱게 높다', '명사', 119, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ソファの位置を変えた。', '소파의 위치를 바꿔었다.', 1),
    (w, '頭の位置を下げる。', '머리 위치를 낮춘다.', 2);

  -- 120. 計算
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '計算', 'けいさん', '계산', '計(계산 계): 言(말) + 十(열)→ 열까지 세어 계산
算(셌 산): 竹(대) + 具(갖출 구)→ 주산으로 세다', '명사', 120, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買い物の計算をした。', '장보기 계산을 했다.', 1),
    (w, '暗算で計算する。', '암산으로 계산한다.', 2);

  -- 121. 回す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '回す', 'まわす', '돌리다', '回(돌 회): 소용돌이가 돌아가는 모양
타동사로 무엇을 회전시키다', '동사', 121, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ハンドルを回してドアを開ける。', '손잡이를 돌려서 문을 연다.', 1),
    (w, '朝に体を回す体操をしている。', '아침에 몸을 돌리는 체조를 하고 있다.', 2);

  -- 122. 禁煙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '禁煙', 'きんえん', '금연', '禁(금할 금): 林(수풍) + 示(볼 시)→ 보이지 않게 하다→ 금지하다
煙(연기 연): 火(불) + 坛(막힐 인)→ 불에서 나오는 연기', '명사', 122, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここは禁煙です。', '여기는 금연입니다.', 1),
    (w, '健康のために禁煙した。', '건강을 위해 금연했다.', 2);

  -- 123. 結ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '結ぶ', 'むすぶ', '잇다, 묶다', '結(맺을 결): 糸(실) + 吉(길할 길)→ 실로 한데 묶다
타동사로 녠견하여 이움', '동사', 123, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴ひもを結ぶ。', '신발끈을 매다.', 1),
    (w, '条約を結ぶ。', '조약을 체결한다.', 2);

  -- 124. 手術
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '手術', 'しゅじゅつ', '수술', '手(손 수): 손의 모양
術(재주 술): 行(다닐 행) + 术(찰기장 출)→ 다니면서 익힌 기술', '명사', 124, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日手術を受けた。', '어제 수술을 받았다.', 1),
    (w, '手術は成功した。', '수술은 성공했다.', 2);

  -- 125. 正常
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '正常', 'せいじょう', '정상', '正(바를 정): 一(한) + 止(멈춤 지)→ 올바르는 곳에서 멈추다
常(더러울 상): 尚(오히려 상) + 巾(수건)→ 일상에서 항상 쓰는 것', 'な형용사', 125, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'システムは正常に動いている。', '시스템은 정상적으로 움직이고 있다.', 1),
    (w, '体温は正常です。', '체온은 정상입니다.', 2);

  -- 126. 血液
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '血液', 'けつえき', '혈액', '血(피 혈): タ그릇 안의 피 닫건을 그린 모양
液(액체 액): 氵(물) + 夜(밤)→ 밤에도 흔러내는 액체', '명사', 126, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '血液を採取した。', '혈액을 채취했다.', 1),
    (w, '血液検査を受けた。', '혈액검사를 받았다.', 2);

  -- 127. 追う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '追う', 'おう', '뒤쯧다', '追(따를 추): 辶(갈 착) + 阜(언덕 부)→ 언덕을 올라가면서 뒤따르다
타동사로 뭐를 쪽아가다', '동사', 127, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬が猫を追っている。', '개가 고양이를 뒤쮫고 있다.', 1),
    (w, '犯人を警察が追う。', '범인을 경찰이 추격한다.', 2);

  -- 128. 降りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '降りる', 'おりる', '내리다', '降(내릴 강): 阜(언덕) + 梱(천천히 걸을 강)→ 언덕을 천천히 내려오다
자동사형 りる이 붙음', '동사', 128, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'バスを次の駅で降りる。', '버스를 다음 정류장에서 내린다.', 1),
    (w, '二階から降りる。', '2층에서 내려오다.', 2);

  -- 129. 身長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '身長', 'しんちょう', '신장, 키', '身(몸 신): 임신한 여자의 모양 → 사람의 몸
長(길 장): 머리카락이 긴 노인의 모양 → 길다', '명사', 129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は身長が高い。', '그는 키가 크다.', 1),
    (w, '身長を測りました。', '키를 쟀습니다.', 2);

  -- 130. 物語
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '物語', 'ものがたり', '이야기', '物(물건 물): 牛(소) + 勿(말 물)→ 여러가지 사물
語(말씀 어): 言(말) + 吾(나)→ 내가 하는 말', '명사', 130, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '興味深い物語を読んだ。', '흥미로운 이야기를 읽었다.', 1),
    (w, '長い物語だった。', '긴 이야기였다.', 2);

  -- 131. 成績
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '成績', 'せいせき', '성적', '成(이룰 성): 戊(창) + 丁(못)→ 도구로 일을 이루다
績(결과 적): 糸(실) + 責(쌓일 적)→ 실이 쌓여 이루는 결과', '명사', 131, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今学期の成績が渡された。', '이번 학기 성적이 발표되었다.', 1),
    (w, '成績がよくなった。', '성적이 나아졌다.', 2);

  -- 132. 楽器
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '楽器', 'がっき', '악기', '楽(노래 악): 그린듯 입을 벌린 안에 자마시를다 → 음악
器(그릇 기): 口(입) 4개 + 犬(개)→ 여러 그릇·도구', '명사', 132, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノは楽器だ。', '피아노는 악기다.', 1),
    (w, '何か楽器を弾ける？', '뭔가 악기를 연주할 수 있어?', 2);

  -- 133. 専門家
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '専門家', 'せんもんか', '전문가', '専門(전문): 専(오직 전) + 門(문)→ 한 분야의 문
家(집 가): 宀(집) + 豕(돼지)→ 전문적으로 다루는 사람', '명사', 133, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '専門家の意見を聞いた。', '전문가 의견을 들었다.', 1),
    (w, '彼は野鳥の専門家だ。', '그는 야생조류 전문가다.', 2);

  -- 134. 制服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '制服', 'せいふく', '제복, 교복', '制(만들 제): 未(아니) + 刂(칼)→ 칼로 깎아 만들다
服(옷 복): 月(몸) + 又(손)→ 손으로 몸에 두르다', '명사', 134, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高校の制服を着ている。', '고등학교 교복을 입고 있다.', 1),
    (w, '警察官の制服だ。', '경찰관의 제복이다.', 2);

  -- 135. 内側
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '内側', 'うちがわ', '안쪽', '内(안 내): 冂(경계) + 入(들 입)→ 안으로 들어감
側(곁 측): 亻(사람) + 則(법칙)→ 사람의 곁', '명사', 135, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアの内側に鍵がある。', '문 안쪽에 열쇠가 있다.', 1),
    (w, '内側を見ないでください。', '안쪽을 보지 마세요.', 2);

  -- 136. 過ごす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '過ごす', 'すごす', '지내다, 보내다', '過(지날 과): 辶(갈 착) + 咼(에서 와)→ 시간이 지나다
타동사형: 시간을 보내다', '동사', 136, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '楽しい週末を過ごした。', '즐거운 주말을 보냈다.', 1),
    (w, 'アメリカで五年を過ごした。', '미국에서 5년을 지냈다.', 2);

  -- 137. 案内
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '案内', 'あんない', '안내', '案(책상 안): 安(편안) + 木(나무)→ 책상·계획·안
内(안 내): 안으로 들어감', '명사', 137, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それでは案内します。', '그럼 안내해드리겠습니다.', 1),
    (w, '案内図をもらった。', '안내도를 받았다.', 2);

  -- 138. 解決
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '解決', 'かいけつ', '해결', '解(풀 해): 角(뿔) + 刂(칼) + 牛(소)→ 칼로 소의 뿔을 갈라내다
決(결단할 결): 氵(물) + 夬(터질 쾌)→ 물이 터져 흐르게 하다', '명사', 138, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題がやっと解決した。', '문제가 마침내 해결되었다.', 1),
    (w, '話し合いで解決しよう。', '대화로 해결하자.', 2);

  -- 139. 気温
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '気温', 'きおん', '기온', '気(기운 기): 아지랑이는 연기 모양→ 공기
温(따뜻할 온): 氵(물) + 昷(따뜻할 온)→ 따뜻한 물', '명사', 139, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気温が上がった。', '기온이 올랐다.', 1),
    (w, '今日の最低気温は五度だ。', '오늘 최저 기온은 5도다.', 2);

  -- 140. 健康
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '健康', 'けんこう', '건강', '健(굳셀 건): 亻(사람) + 建(세울 건)→ 당당히 서있는 사람
康(편안할 강): 广(집) + 隶(쌀)→ 집에 곡식이 풍족함', '명사', 140, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康に気をつけている。', '건강에 조심하고 있다.', 1),
    (w, '健康診断を受けた。', '건강검진을 받았다.', 2);

  -- 141. 大量
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '大量', 'たいりょう', '대량', '大(큰 대): 사람이 팔을 크게 벌린 모양
量(헤아릴 량): 里(마을) + 旦(아침)→ 헤아릴 만큼 많음', '명사', 141, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大量の雨が降った。', '많은 비가 내렸다.', 1),
    (w, '大量に購入した。', '대량으로 구입했다.', 2);

  -- 142. 痛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '痛い', 'いたい', '아프다', '痛(아플 통): 疒(병) + 甬(길 용)→ 계속 이어지는 병·통증
い형용사로 고통을 느낌', 'い형용사', 142, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭が痛い。', '머리가 아프다.', 1),
    (w, '足をドアにぶつけて痛い。', '발을 문에 부딪혀 아프다.', 2);

  -- 143. 現在
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '現在', 'げんざい', '현재', '現(나타날 현): 玉(옥) + 見(볼 견)→ 옥이 눈에 드러남
在(있을 재): 才(재능) + 土(흙)→ 땅에 뿌리내림', '명사', 143, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現在の状況を説明してください。', '현재 상황을 설명해주세요.', 1),
    (w, '現在、会議中だ。', '현재 회의 중이다.', 2);

  -- 144. 自由
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自由', 'じゆう', '자유', '自(스스로 자): 코의 모양→ 자기 자신
由(말미암을 유): 술병 모양→ 원인, 의존', '명사', 144, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人間は自由だ。', '인간은 자유롭다.', 1),
    (w, '自由に選んでいいよ。', '자유롭게 골라도 돼.', 2);

  -- 145. 法律
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '法律', 'ほうりつ', '법률', '法(법 법): 氵(물) + 去(갈 거)→ 물이 흐르는 원칙
律(법 률): 彳(걸을 척) + 聿(붓 율)→ 곧고루 적은 규칙', '명사', 145, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '法律に従う必要がある。', '법률을 따를 필요가 있다.', 1),
    (w, '新しい法律ができた。', '새로운 법률이 생겼다.', 2);

  -- 146. 観光
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '観光', 'かんこう', '관광', '観(볼 관): 자세히 볼
光(빛 광): 빛·풍경', '명사', 146, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都へ観光に行った。', '교토로 관광을 갔다.', 1),
    (w, '観光地として有名だ。', '관광지로 유명하다.', 2);

  -- 147. 券
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '券', 'けん', '권, 티켓', '券: 증권·티켓
입장권·승차권 등 증명 종이', '명사·접미사', 147, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入場券を買った。', '입장권을 샀다.', 1),
    (w, '車乗券を見せてください。', '승차권을 보여주세요.', 2);

  -- 148. 涙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '涙', 'なみだ', '눈물', '涙(눈물 루): 물이 이어 흐름
눈에서 나오는 액체', '명사', 148, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感動して涙が出た。', '감동해서 눈물이 나왔다.', 1),
    (w, '彼女は涙を拭いた。', '그녀는 눈물을 닦았다.', 2);

  -- 149. 守る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '守る', 'まもる', '지키다', '守(지킬 수): 宀(집) + 寸(마디)→ 집을 지켜냄
타동사: 약속·규칙 준수', '동사', 149, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束を守ってください。', '약속을 지켜주세요.', 1),
    (w, '人を守る。', '사람을 지킨다.', 2);

  -- 150. 週刊誌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '週刊誌', 'しゅうかんし', '주간지', '週刊(주간): 일주일마다 새김
誌(기록할 지): 기록한 책·잡지', '명사', 150, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '週刊誌を買って電車で読んだ。', '주간지를 사서 전철에서 읽었다.', 1),
    (w, '週刊誌の記事だ。', '주간지의 기사다.', 2);

  -- 151. 相談
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '相談', 'そうだん', '상담', '相(서로 상): 서로 주고받음
談(말씀 담): 따뜻하게 이야기함', '명사', 151, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に相談した。', '친구에게 상담했다.', 1),
    (w, '何でも相談に乗る。', '무엇이든 상담에 응한다.', 2);

  -- 152. 自信
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自信', 'じしん', '자신감', '自(스스로 자): 자기 자신
信(믿을 신): 사람의 말을 믿음', '명사', 152, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自信を持って話しなさい。', '자신감을 가지고 이야기해라.', 1),
    (w, 'それをやる自信がない。', '그것을 할 자신이 없다.', 2);

  -- 153. 温める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '温める', 'あたためる', '따뜻하게 하다', '温(따뜻할 온): 따뜻한 물
타동사형 める이 붙음', '동사', 153, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スープを温めた。', '수프를 다시 데웠다.', 1),
    (w, '部屋を温めてください。', '방을 따뜻하게 해주세요.', 2);

  -- 154. 原料
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '原料', 'げんりょう', '원료', '原(근원 원): 근원·기원
料(헤아릴 료): 재료·비용', '명사', 154, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パンの原料は小麦粉だ。', '빵의 원료는 밀가루다.', 1),
    (w, '原料の質が重要だ。', '원료의 품질이 중요하다.', 2);

  -- 155. 帰宅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '帰宅', 'きたく', '귀가', '帰(돌아올 귀): 여자가 집으로 돌아감
宅(집 택): 집·거처', '명사', 155, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜中に帰宅した。', '새벽에 귀가했다.', 1),
    (w, '仕事が遅いので帰宅も遅い。', '일이 늦어서 귀가도 늦다.', 2);

  -- 156. 育てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '育てる', 'そだてる', '키우다', '育(길롬 육): 아기를 길러내다
타동사형 てる이 붙음', '동사', 156, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供を三人育てた。', '아이를 세 명 키웠다.', 1),
    (w, '花を育てるのが趣味だ。', '꽃을 키우는 게 취미다.', 2);

  -- 157. 記録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '記録', 'きろく', '기록', '記(기록 기): 말을 남김
録(새길 록): 쇠에 새김', '명사', 157, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界記録を出した。', '세계 기록을 세웠다.', 1),
    (w, '記録しておいてください。', '기록해 두세요.', 2);

  -- 158. 歯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '歯', 'は', '이, 치아', '歯(이 치): 치아가 드러난 입의 모양
상하 치아의 모양', '명사', 158, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歯が痛い。', '이가 아프다.', 1),
    (w, '歯を磨いてから寝る。', '이를 닦고 자는다.', 2);

  -- 159. 復習
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '復習', 'ふくしゅう', '복습', '復(돌아올 복): 다시 돌아감
習(익혀 습): 연습·익힘', '명사', 159, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学んだことを毎日復習する。', '배운 것을 매일 복습한다.', 1),
    (w, '復習テストがある。', '복습 테스트가 있다.', 2);

  -- 160. 信じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '信じる', 'しんじる', '믿다', '信(믿을 신): 사람의 말을 믿음
타동사형 じる이 붙음', '동사', 160, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あなたを信じている。', '당신을 믿고 있다.', 1),
    (w, 'その話は信じられない。', '그 이야기는 믿을 수 없다.', 2);

  -- 161. 遅い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '遅い', 'おそい', '느리다, 늦다', '遅(늦을 지): 소가 느리게 감
い형용사로 속도·시간이 늦음', 'い형용사', 161, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スピードが遅い。', '속도가 느리다.', 1),
    (w, '今日は帰ってくるのが遅い。', '오늘은 돌아오는 게 늦다.', 2);

  -- 162. 容器
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '容器', 'ようき', '용기, 그릇', '容(담을 용): 집안에 담아둡
器(그릇 기): 그릇·도구', '명사', 162, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スープを容器に入れた。', '수프를 그릇에 담았다.', 1),
    (w, '買ったばかりの容器を使う。', '새로 산 그릇을 쓴다.', 2);

  -- 163. 疲れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '疲れる', 'つかれる', '피로하다, 지치다', '疲(곤할 피): 병으로 쓰러짐
자동사형 れる이 붙음', '동사', 163, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はとても疲れた。', '오늘은 매우 피곤하다.', 1),
    (w, '仕事で疲れてしまった。', '일로 지쳐 버렸다.', 2);

  -- 164. 重ねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '重ねる', 'かさねる', '거듭하다, 겹치다', '重(무거울 중): 한 모양이 아래에 쌓임
타동사형 ねる이 붙음', '동사', 164, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を二冊重ねた。', '책을 두 권 쌓았다.', 1),
    (w, '歴史を重ねる。', '역사를 거듭한다.', 2);

  -- 165. 残業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '残業', 'ざんぎょう', '잔업', '残(남을 잔): 남은 것
業(업 업): 일·직업', '명사', 165, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は残業が多い。', '오늘은 잔업이 많다.', 1),
    (w, '残業代をもらった。', '잔업 수당을 받았다.', 2);

  -- 166. 倍
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '倍', 'ばい', '배', '倍(곱절 배): 亻(사람) + 呶(침 부)→ 사람을 등지고 때린다→ 어기서 배로 늘림
수량의 곱을 나타냄', '명사·접미사', 166, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年収が二倍になった。', '연봉이 2배가 되었다.', 1),
    (w, '代金を三倍払う。', '대금을 3배 지불한다.', 2);

  -- 167. 停電
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '停電', 'ていでん', '정전', '停(머물 정): 났촤거리가 멈춤
電(번개 전): 하늘의 전기', '명사', 167, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風で停電した。', '태풍으로 정전되었다.', 1),
    (w, '停電中はエアコンが使えない。', '정전 중에는 에어컨을 쓸 수 없다.', 2);

  -- 168. 独身
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '独身', 'どくしん', '독신', '独(홀로 독): 홀로 감
身(몸 신): 사람의 몸', '명사', 168, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他の始めて姓も独身だ。', '형은 아직 독신이다.', 1),
    (w, '独身生活を楽しんでいる。', '독신 생활을 즐기고 있다.', 2);

  -- 169. 貸す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '貸す', 'かす', '빌려주다', '貸(빌려줄 대): 돈을 대을 때 쓴 그릇
타동사로 남에게 먼저 내주다', '동사', 169, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を貸してくれた。', '책을 빌려줬다.', 1),
    (w, '友達にお金を貸した。', '친구에게 돈을 빌려줬다.', 2);

  -- 170. 逃げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '逃げる', 'に｛げる', '도망치다', '逃(달아날 도): 멀리 갈
자동사형 げる이 붙음', '동사', 170, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犯人が逃げた。', '범인이 도망쳼다.', 1),
    (w, '現実から逃げるな。', '현실에서 도망치지 마.', 2);

  -- 171. 消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '消す', 'けす', '끄다, 지우다', '消(사라질 소): 흐어 없어짐
타동사로 불기·자국을 제거', '동사', 171, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気を消した。', '전기를 꾔다.', 1),
    (w, '黒板の字を消した。', '칠판의 글자를 지웠다.', 2);

  -- 172. 欠席
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '欠席', 'けっせき', '결석', '欠(흡 흡): 사람이 입을 벌리고 대고 머른 모양→ 이 빠진 것→ 빠짐
席(자리 석): 자리', '명사', 172, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議に欠席した。', '회의에 결석했다.', 1),
    (w, '病気で授業を欠席した。', '아파서 수업을 결석했다.', 2);

  -- 173. 細かい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '細かい', 'こまかい', '자세하다, 쟘다', '細(가늘 세): 실·머리카락→ 세밀함
い형용사로 세밀하고 자세함', 'い형용사', 173, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '細かい説明が必要だ。', '자세한 설명이 필요하다.', 1),
    (w, '細かいごみを拾う。', '쟘더기를 주워주다.', 2);

  -- 174. 若い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '若い', 'わかい', '젊다', '若(같을 약): 디니파르게 하는 모양→ 어린 사람
い형용사로 연령이 적음', 'い형용사', 174, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若いうちに勉強しよう。', '젊을 때 공부하자.', 1),
    (w, '若い人に人気がある。', '젊은 사람에게 인기가 있다.', 2);

  -- 175. 複数
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '複数', 'ふくすう', '복수, 여러 개', '複(겹칠 복): 衤(옷 의) + 复(돌아올 복) → 겹겹이 → 하나가 아닌 여러 개
数(셈 수): 수량을 세다', '명사', 175, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '複数の意見がある。', '여러 개의 의견이 있다.', 1),
    (w, '複数回答可。', '복수 응답 가능.', 2);

  -- 176. 減少
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '減少', 'げんしょう', '감소', '減(덜 감): 물이 줄어듦
少(적을 소): 적은 양', '명사', 176, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人口が減少している。', '인구가 감소하고 있다.', 1),
    (w, '売り上げが減少した。', '매출이 감소했다.', 2);

  -- 177. 駐車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '駐車', 'ちゅうしゃ', '주차', '駐(머물 주): 한곳에 머문
車(수레 차): 차량', '명사', 177, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここは駐車禁止だ。', '여기는 주차금지다.', 1),
    (w, '駐車場を探す。', '주차장을 찾는다.', 2);

  -- 178. 移る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '移る', 'うつる', '옮기다', '移(옮길 이): 벙 다발 옮김
자동사형 る이 붙음', '동사', 178, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい部屋に移った。', '새 방으로 옮겼다.', 1),
    (w, '風邪が妹に移った。', '감기가 여동생에게 옮겨갔다.', 2);

  -- 179. 温泉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '温泉', 'おんせん', '온천', '温(따뜻할 온): 따뜻함
泉(샘 천): 샘·원천', '명사', 179, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '温泉に行きたい。', '온천에 가고 싶다.', 1),
    (w, '両親と温泉旅行に行った。', '부모님과 온천여행을 갔다.', 2);

  -- 180. 雑誌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '雑誌', 'ざっし', '잡지', '雑(섞일 잡): 여러 가지가 섞임
誌(기록할 지): 기록한 책 → 정기적으로 발간되는 책', '명사', 180, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雑誌を読んだ。', '잡지를 읽었다.', 1),
    (w, 'ファッション雑誌を買った。', '패션 잡지를 샀다.', 2);

  -- 181. 恋しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '恋しい', 'こいしい', '그립다', '恋(그릴 련): 그린 마음
しい형용사로 헤어진 대상이 보고싶음', 'い형용사', 181, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '故郷が恋しい。', '고향이 그립다.', 1),
    (w, '子供の頃が恋しい。', '어린 시절이 그립다.', 2);

  -- 182. 仮定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '仮定', 'かてい', '가정', '仮(거짓 가): 임시·임탁
定(정할 정): 확정', '명사', 182, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そう仮定してみよう。', '그렇게 가정해보자.', 1),
    (w, '仮定の話だが、人生を考える。', '가정의 이야기지만 인생을 생각한다.', 2);

  -- 183. 正解
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '正解', 'せいかい', '정답', '正(바를 정): 올바름
解(풀 해): 풀이', '명사', 183, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '正解を選んでください。', '정답을 골라주세요.', 1),
    (w, 'それが正解だ。', '그것이 정답이다.', 2);

  -- 184. 関心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '関心', 'かんしん', '관심', '関(뺗장 관): 연관·연결
心(마음 심): 마음', '명사', 184, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽に関心がある。', '음악에 관심이 있다.', 1),
    (w, 'その件には関心がない。', '그 건에는 관심이 없다.', 2);

  -- 185. 投げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '投げる', 'なげる', '던지다', '投(던질 투): 손으로 던져 넘김
타동사형 げる이 붙음', '동사', 185, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボールを投げる。', '공을 던진다.', 1),
    (w, 'ゴミをゴミ箱に投げた。', '쓰레기를 통에 던졌다.', 2);

  -- 186. 原因
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '原因', 'げんいん', '원인', '原(근원 원): 근원
因(인할 인): 원인', '명사', 186, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故の原因を調べる。', '사고의 원인을 조사한다.', 1),
    (w, '原因不明の病気だ。', '원인불명의 병이다.', 2);

  -- 187. 勤める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '勤める', 'つとめる', '근무하다', '勤(부지런할 근): 힘을 다해 일함
타동사형 める이 붙음', '동사', 187, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行に勤めている。', '은행에 근무하고 있다.', 1),
    (w, '友込の会社に勤めている。', '친구의 회사에서 근무하고 있다.', 2);

  -- 188. 規則
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '規則', 'きそく', '규칙', '規(법 규): 먹설을 그린 틀·규절
則(법칙 칙): 법·법칙', '명사', 188, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規則を守ってください。', '규칙을 지켜주세요.', 1),
    (w, '会社の規則が厳しい。', '회사 규칙이 엄격하다.', 2);

  -- 189. 借りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '借りる', 'かりる', '빌리다', '借(빌릴 차): 쇄를 빌리다
타동사형 りる이 붙음', '동사', 189, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館で本を借りた。', '도서관에서 책을 빌렸다.', 1),
    (w, '車を借りたい。', '차를 빌리고 싶다.', 2);

  -- 190. 欠点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '欠点', 'けってん', '결점', '欠(흡 흡): 부족·빠짐
点(점 점): 부분·점', '명사', 190, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の欠点は能力だ。', '그의 결점은 고집이다.', 1),
    (w, '欠点を認める。', '결점을 인정한다.', 2);

  -- 191. 緑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '緑', 'みどり', '초록, 녹색', '緑(푸를 록): 실을 염색한 녹색·자연의 색
슍 색입니다 녹색', '명사', 191, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シャツは緑色だ。', '셔츠는 조색이다.', 1),
    (w, '公園は緑が多い。', '공원은 초록이 많다.', 2);

  -- 192. 願う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '願う', 'ねがう', '바라다', '願(원할 원): 머리를 수그려고 빅
타동사형으로 어떤 일을 희망함', '동사', 192, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界平和を願う。', '세계 평화를 원한다.', 1),
    (w, 'よろしく願います。', '잘 부탁드립니다.', 2);

  -- 193. 焼く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '焼く', 'やく', '굽다', '焼(타우다 소): 불에 타다
타동사로 음식을 익힌', '동사', 193, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケーキを焼いた。', '케이크를 구웠다.', 1),
    (w, '肉を焼くのが上手だ。', '고기를 굽는 게 잘한다.', 2);

  -- 194. 乗車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '乗車', 'じょうしゃ', '승차', '乗(탈 승): 옥라타다
車(수레 차): 차', '명사', 194, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここは乗車位置だ。', '여기는 승차 위치다.', 1),
    (w, '乗車の際はチケットを見せてください。', '승차 시에는 티켓을 보여주세요.', 2);

  -- 195. 波
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '波', 'なみ', '파도', '波(물결 파): 물이 일이키는 물결
바다의 파도', '명사', 195, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '波が高い。', '파도가 높다.', 1),
    (w, '波の音を聞くとリラックスする。', '파도 소리를 듣으면 편안해진다.', 2);

  -- 196. 速い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '速い', 'はやい', '빠르다', '速(빠를 속): 쉬엄 쉬엄 빠르게 감
い형용사로 속도가 릹은 상태', 'い형용사', 196, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走るのが速い。', '달리기가 빠르다.', 1),
    (w, '咳と同じくらいに速い。', '빛과 같이 빠르다.', 2);

  -- 197. 満足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '満足', 'まんぞく', '만족', '満(차을 만): 그릇이 가득·충만
足(발 족): 충분함', '명사', 197, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その結果に満足した。', '그 결과에 만족했다.', 1),
    (w, '今の生活に満足している。', '지금의 생활에 만족하고 있다.', 2);

  -- 198. 輸出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '輸出', 'ゆしゅつ', '수출', '輸(옮길 수): 수레로 옮김
出(날 출): 밖으로 나감', '명사', 198, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自動車を海外に輸出する。', '자동차를 해외에 수출한다.', 1),
    (w, '輸出量が増えた。', '수출량이 증가했다.', 2);

  -- 199. 眠る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '眠る', 'ねむる', '자다, 잠들다', '眠(잠울 면): 눈이 감겼음
자동사형 る이 붙음', '동사', 199, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤ちゃんがよく眠っている。', '아기가 잘 자고 있다.', 1),
    (w, '昨夜はあまり眠れなかった。', '어제밤은 잘 자지 못했다.', 2);

  -- 200. 頭痛
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '頭痛', 'ずつう', '두통', '頭(머리 두): 머리
痛(아플 통): 아푼', '명사', 200, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭痛がひどい。', '두통이 심하다.', 1),
    (w, '頭痛薬を飲んだ。', '두통약을 먹었다.', 2);

  -- 201. 葉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '葉', 'は', '잎, 이파리', '葉(잎 엽): 수풍·잎
나무의 잎사귀', '명사', 201, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '秋になると葉が赤くなる。', '가을이 되면 잎이 빨게지다.', 1),
    (w, '一枚の葉が落ちた。', '잎 한 장이 떨어졌다.', 2);

  -- 202. 期待
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '期待', 'きたい', '기대', '期(기약 기): 일정한 시기·약속
待(기다릴 대): 기다림', '명사', 202, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あなたの成功を期待している。', '당신의 성공을 기대하고 있다.', 1),
    (w, '期待に応えた。', '기대에 부응했다.', 2);

  -- 203. 預ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '預ける', 'あずける', '맡기다', '預(맡길 예): 머리를 다른 이에게 맡김
타동사형 ける이 붙음', '동사', 203, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物を預けた。', '짐을 맡겼다.', 1),
    (w, '銀行にお金を預ける。', '은행에 돈을 맡긴다.', 2);

  -- 204. 経由
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '経由', 'けいゆ', '경유', '経(지날 경): 지나감
由(말미암을 유): 경로·원인', '명사', 204, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そウル経由でパリにいく。', '서울 경유로 파리에 간다.', 1),
    (w, '友人を経由して連絡した。', '친구를 통해 연락했다.', 2);

  -- 205. 秒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '秒', 'びょう', '초', '秒(초 병): 잘게 나눌 시간 단위
시간의 가장 작은 단위', '명사', 205, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一分は六十秒だ。', '1분은 60초다.', 1),
    (w, '十秒だけ待って。', '10초만 기다려줘.', 2);

  -- 206. 飛ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '飛ぶ', 'とぶ', '날다', '飛(날 비): 새가 날개를 펼치고 날아오르는 모양
자동사로 공중을 이동', '동사', 206, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鳥が空を飛んでいる。', '새가 하늘을 날고 있다.', 1),
    (w, '飛行機で飛んで行く。', '비행기로 날아서 간다.', 2);

  -- 207. 坂道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '坂道', 'さかみち', '언덕길', '坂(언덕 판): 경사가 있는 길
道(길 도): 길', '명사', 207, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '坂道を上るのは疑れる。', '언덕길을 올라가는 건 힘들다.', 1),
    (w, '坂道で転んだ。', '언덕길에서 넘어졌다.', 2);

  -- 208. 違う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '違う', 'ちがう', '다르다, 틀리다', '違(어길 위): 어긋나게 감
자동사로 같지 않음', '동사', 208, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が違う。', '의견이 다르다.', 1),
    (w, 'それは違うよ。', '그건 틀려.', 2);

  -- 209. 関係
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '関係', 'かんけい', '관계', '関(뺗장 관): 연결·관련
係(매달 계): 이어지다', '명사', 209, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人との関係がうまくいかない。', '남과의 관계가 잘되지 않는다.', 1),
    (w, '関係者以外立ち入り禁止。', '관계자 이외 출입금지.', 2);

  -- 210. 教師
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '教師', 'きょうし', '교사', '教(가르칠 교): 가르치다
師(스승 사): 스승·전문가', '명사', 210, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小学校の教師だ。', '초등학교 교사다.', 1),
    (w, '英語教師を探している。', '영어 교사를 찾고 있다.', 2);

  -- 211. カタログ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'カタログ', '카탈로그', '영어 catalogue의 외래어
상품이나 자료를 소개한 책자', '명사', 211, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品カタログをもらった。', '상품 카탈로그를 받았다.', 1),
    (w, '新しいカタログが出た。', '새로운 카탈로그가 나왔다.', 2);

  -- 212. 感じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '感じる', 'かんじる', '느끼다', '感(느낄 감): 마음으로 느끼다
타동사형 じる이 붙음', '동사', 212, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さを感じる。', '추위를 느낀다.', 1),
    (w, '雰囲気で何かを感じる。', '분위기에서 무언가 느낀다.', 2);

  -- 213. 家賃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '家賃', 'やちん', '집세', '家(집 가): 집
賃(품삯 임): 임대주고받음', '명사', 213, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家賃が高い。', '집세가 비싸다.', 1),
    (w, '毎月家賃を振り込む。', '매달 집세를 입금한다.', 2);

  -- 214. しまう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しまう', '치우다, 안에 넣다', '仕舞う의 표기 → 정리하여 끝맺다·집어넣다
타동사로 물건을 정리해 넣음', '동사', 214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食器を棚にしまった。', '식기를 선반에 정리했다.', 1),
    (w, '本を本棚にしまった。', '책을 책장에 정리해 넣었다.', 2);

  -- 215. 最新
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '最新', 'さいしん', '최신', '最(가장 최): 가장·제일
新(새 신): 새로움', '명사', 215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最新ニュースを見た。', '최신 뉴스를 봤다.', 1),
    (w, '最新の技術を導入した。', '최신 기술을 도입했다.', 2);

  -- 216. しばる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しばる', '묶다', '縛る(묶을 박)의 표기 → 줄·끈으로 둘러 묶다
타동사', '동사', 216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '髪をリボンでしばる。', '머리를 리본으로 묶는다.', 1),
    (w, '荷物をしばって車に載せる。', '짐을 묶어서 차에 싣는다.', 2);

  -- 217. キャンセル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'キャンセル', '취소', '영어 cancel의 외래어
예약·계약을 취소하는 행위', '명사', 217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約をキャンセルした。', '예약을 취소했다.', 1),
    (w, 'キャンセル料がかかる。', '취소 수수료가 든다.', 2);

  -- 218. 向き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '向き', 'むき', '향, 쪽', '向(향할 향): 집이 향한 쪽
むき: 向く(향하다)의 명사형', '명사·접미사', 218, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '南向きの部屋だ。', '남향 방이다.', 1),
    (w, 'この本は子供向きだ。', '이 책은 아이 용이다.', 2);

  -- 219. 感動
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '感動', 'かんどう', '감동', '感(느낀 감): 세게 느낌
動(움직일 동): 마음이 움직임', '명사', 219, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その映画は感動的だった。', '그 영화는 감동적이었다.', 1),
    (w, '達人の演奏に感動した。', '명인의 연주에 감동했다.', 2);

  -- 220. うっかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'うっかり', '깜빡, 무심코', '의성어→ 주의없이 일을 하는 모양
실수림의 양상을 묘사', '부사', 220, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うっかり忘れてしまった。', '깜빡 잊어 버렸다.', 1),
    (w, 'うっかり間違えた。', '무심코 틀렸다.', 2);

  -- 221. りっぱな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'りっぱな', '훌륭한', '立派（멋진）の意味→ 훌륭·멋진
な형용사', 'な형용사', 221, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りっぱな家に住んでいる。', '훌륭한 집에 살고 있다.', 1),
    (w, 'りっぱな人になりたい。', '훌륭한 사람이 되고 싶다.', 2);

  -- 222. 早めに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '早めに', 'はやめに', '일찍감치', '早める(더 일찍 하다)의 부사형
원래 시각보다 더 이르게', '부사', 222, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早めに家を出た。', '일찍감치 집을 나왔다.', 1),
    (w, '早めに休むとよい。', '일찍 쉬는 게 좋다.', 2);

  -- 223. あわ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あわ', '거품', '泡(あわ): 거품을 가리키는 일본 고유어
액체 표면에 생기는 작은 기포', '명사', 223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビールにあわがたっぷりある。', '맥주에 거품이 가득하다.', 1),
    (w, '石鹸のあわを見た。', '비누 거품을 봤다.', 2);

  -- 224. ノック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ノック', '노크', '영어 knock의 외래어
문을 두드리는 행위', '명사', 224, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアをノックした。', '문을 노크했다.', 1),
    (w, 'ノックしてから入ってください。', '노크하고 들어오세요.', 2);

  -- 225. 半日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '半日', 'はんにち', '반나절', '半(반 반): 절반
日(날 일): 하루', '명사', 225, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '半日だけ会議だ。', '반나절만 회의다.', 1),
    (w, '半日休みをもらった。', '반나절 휴가를 받았다.', 2);

  -- 226. 扱う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '扱う', 'あつかう', '다루다, 취급하다', '扱(다룰 급): 손으로 조심스럽게 다룸
타동사로 일·물건을 취급', '동사', 226, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この商品は丁寧に扱ってください。', '이 상품은 조심스레 다루세요.', 1),
    (w, 'クレームはこちらで扱います。', '클레임은 이쪽에서 처리합니다.', 2);

  -- 227. 全
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '全', 'ぜん', '전~', '全(온전할 전): 온전·모두
접두사로 전체를 의미', '접두사', 227, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全人口の三割だ。', '전 인구의 30%다.', 1),
    (w, '全クラスで一番だ。', '전 반에서 제일이다.', 2);

  -- 228. 希望
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '希望', 'きぼう', '희망', '希(바랄 희): 드문·바람
望(바랄 망): 멀리서 바라봄', '명사', 228, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来への希望を持て。', '미래에 대한 희망을 가져.', 1),
    (w, '希望するコースを選んだ。', '희망하는 코스를 골랐다.', 2);

  -- 229. 迷う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '迷う', 'まよう', '헤매다, 망설이다', '迷(미혹할 미): 길을 잃음
자동사로 결정하지 못함', '동사', 229, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道に迷った。', '길을 잃었다.', 1),
    (w, 'どちらにしようか迷う。', '어느 쪽으로 할지 망설인다.', 2);

  -- 230. しばらく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しばらく', '잠시, 한동안', '暫くの漢字表記 → 잠깐, 짧지 않은 시간
일정 시간 동안 이어지는 상태', '부사', 230, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しばらくお待ちください。', '잠시 기다려주세요.', 1),
    (w, 'しばらく会っていない。', '한동안 만나지 못했다.', 2);

  -- 231. 体力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '体力', 'たいりょく', '체력', '体(몸 체): 신체
力(힘 력): 힘', '명사', 231, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体力をつける。', '체력을 기른다.', 1),
    (w, '体力がないと長距離は走れない。', '체력이 없으면 장거리를 못 달린다.', 2);

  -- 232. どきどき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どきどき', '두근두근', '의성어→ 심장이 빠르게 뛰는 소리
긴장·설레임의 양상을 묘사', '부사', 232, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験の前でどきどきしている。', '시험 앞에서 두근거리고 있다.', 1),
    (w, 'ステージに上がってどきどきした。', '무대에 올라서 두근거렸다.', 2);

  -- 233. 不満
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '不満', 'ふまん', '불만', '不(아닐 부): 부정
満(찰 만): 채움 → 마음이 가득 차지 않음', '명사', 233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '待遇に不満がある。', '대우에 불만이 있다.', 1),
    (w, '不満を口に出せない。', '불만을 입 밖으로 낼 수 없다.', 2);

  -- 234. ぶらぶら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぶらぶら', '어슬렁어슬렁', '의태어→ 천천히 걷는 모양
목적없이 걷거나 대기', '부사', 234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園をぶらぶら歩いた。', '공원을 어슬렁어슬렁 걸었다.', 1),
    (w, '彼は仕事もせずぶらぶらしている。', '그는 일도 안 하고 빈둥거린다.', 2);

  -- 235. 申込書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '申込書', 'もうしこみしょ', '신청서', '申込み(신청)→ 의사를 전달
書(글 서): 문서', '명사', 235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '申込書を提出した。', '신청서를 제출했다.', 1),
    (w, '申込書を記入してください。', '신청서를 작성해 주세요.', 2);

  -- 236. 複雑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '複雑', 'ふくざつ', '복잡함', '複(겹칠 복): 겹겹·여러 개
雑(섞일 잡): 뒤섞임', 'な형용사', 236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題は複雑だ。', '이 문제는 복잡하다.', 1),
    (w, '複雑な手続きが必要だ。', '복잡한 절차가 필요하다.', 2);

  -- 237. 流れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '流れる', 'ながれる', '흐르다', '流(흐를 류): 물이 흐르는 모양
자동사형 れる이 붙음', '동사', 237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の水が流れる。', '강의 물이 흐른다.', 1),
    (w, '涙が流れてしまった。', '눈물이 흘러버렸다.', 2);

  -- 238. 産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '産', 'さん', '산', '産(낳을 산): 자식을 낳음→ 생산되는 곳
접미사로 생산지를 나타냄', '접미사', 238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これはアメリカ産のりんごだ。', '이것은 미국산 사과다.', 1),
    (w, '国産の牛肉を買う。', '국산 소고기를 산다.', 2);

  -- 239. インタビュー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'インタビュー', '인터뷰', '영어 interview의 외래어
질문·답변 형식의 대담', '명사', 239, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選手にインタビューをした。', '선수와 인터뷰를 했다.', 1),
    (w, 'インタビュー中だ。', '인터뷰 중이다.', 2);

  -- 240. 主張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '主張', 'しゅちょう', '주장', '主(주인 주): 중심·주인
張(베풀 장): 고집함', '명사', 240, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分の意見を主張した。', '자신의 의견을 주장했다.', 1),
    (w, 'その主張は正しい。', '그 주장은 올바르다.', 2);

  -- 241. 整理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '整理', 'せいり', '정리', '整(가지런할 정): 가지런히 함
理(다스릴 리): 다스림', '명사', 241, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋を整理した。', '방을 정리했다.', 1),
    (w, '資料を整理しておいてください。', '자료를 정리해 두세요.', 2);

  -- 242. からから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'からから', '바싹바싹', '의태어→ 수분이 없이 매우 건조한 상태
목이 아주 마른 상태', '부사', 242, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'のどがからからだ。', '목이 바싹바싹하다.', 1),
    (w, 'お皿がからからに乾いた。', '접시가 바싹 말랐다.', 2);

  -- 243. ためる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ためる', '모으다, 담다', '溜めるの 표기 → 한 곳에 고이게 하다
타동사로 축적·저축', '동사', 243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金をためている。', '돈을 모으고 있다.', 1),
    (w, 'ポイントをためて交換した。', '포인트를 모아 교환했다.', 2);

  -- 244. かかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かかる', '걸리다', '掛かるの 표기 → 매달리다·필요로 하다 등 다양한 의미
자동사로 시간·비용·연결 등을 나타냄', '동사', 244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一時間かかる。', '한 시간 걸린다.', 1),
    (w, 'この仕事にはお金がかかる。', '이 일에는 돈이 든다.', 2);

  -- 245. 清潔
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '清潔', 'せいけつ', '청결함', '清(맑을 청): 맑다→ 깨끗함
潔(깨끗할 결): 깨끗함', 'な형용사', 245, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '清潔なシーツを使う。', '청결한 시트를 쓴다.', 1),
    (w, 'トイレを清潔に保つ。', '화장실을 청결하게 유지한다.', 2);

  -- 246. あわせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あわせる', '합치다, 맞추다', '合わせるの 표기→ 둘 이상을 같게 하다
타동사', '동사', 246, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をあわせて祈る。', '손을 맞잡고 기도한다.', 1),
    (w, '全員にあわせて会議を始める。', '전원에 맞춰서 회의를 시작한다.', 2);

  -- 247. 冗談
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '冗談', 'じょうだん', '농담', '冗(쓸데없을 용): 쓸데없는·잡다한
談(말씀 담): 대화', '명사', 247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談だと思っていた。', '농담이라고 생각했다.', 1),
    (w, '彼は冗談が上手だ。', '그는 농담을 잘한다.', 2);

  -- 248. さっそく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'さっそく', '즉시, 곧', '早速の 표기 → 早(빠를 조) + 速(빠를 속) → 곧바로
부사로 주저함 없이', '부사', 248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さっそく試してみた。', '즉시 시도해 보았다.', 1),
    (w, '連絡を受けてさっそく出かけた。', '연락을 받고 곧 나갔다.', 2);

  -- 249. カーブ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'カーブ', '곡선, 커브', '영어 curve의 외래어
굽은 선·도로의 굽은 구간', '명사', 249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーブを曲がった。', '커브를 돌았다.', 1),
    (w, 'ボールがカーブしてストライクになった。', '공이 휘어서 스트라이크가 되었다.', 2);

  -- 250. 両替
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '両替', 'りょうがえ', '환전', '両(두 량): 두 개
替(바꿀 체): 교환', '명사', 250, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行でドルを両替した。', '은행에서 달러를 환전했다.', 1),
    (w, '両替手数料が高い。', '환전 수수료가 비싸다.', 2);

  -- 251. 前後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '前後', 'ぜんご', '전후, 앞뒤', '前(앞 전): 앞
後(뒤 후): 뒤', '명사', 251, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '五時前後に電話します。', '5시 전후에 전화합니다.', 1),
    (w, '前後を見て道を渡る。', '앞뒤를 보고 길을 건너다.', 2);

  -- 252. 影響
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '影響', 'えいきょう', '영향', '影(그림자 영): 그림자·흔적
響(울릴 향): 소리가 울림', '명사', 252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天気の影響で試合が中止だ。', '날씨의 영향으로 경기가 중지다.', 1),
    (w, '広告の影響は大きい。', '광고의 영향은 크다.', 2);

  -- 253. しっかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しっかり', '단단히, 확실히', '確りの 표기→ 구체적·확실하게
부사로 단단하고 철저히', '부사', 253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しっかり勉強しなさい。', '제대로 공부해라.', 1),
    (w, 'しっかりと手を握った。', '단단히 손을 잡았다.', 2);

  -- 254. ながれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ながれ', '흐름', '流れの 표기 → 물이나 시간이 흐르는 모양
명사형', '명사', 254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の流れが速い。', '강의 흐름이 빠르다.', 1),
    (w, '話の流れを掴む。', '이야기의 흐름을 파악한다.', 2);

  -- 255. 外食
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '外食', 'がいしょく', '외식', '外(바깥 외): 집 밖
食(밥 식): 식사', '명사', 255, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今夜は外食にしよう。', '오늘 저녁은 외식하자.', 1),
    (w, '外食が多いと太る。', '외식이 잦으면 살이 찐다.', 2);

  -- 256. 差
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '差', 'さ', '차이, 다름', '差(어긋날 차): 가지런하지 않음 → 차이
수량·정도의 차이', '명사', 256, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年の差は三歳だ。', '나이 차이는 3세다.', 1),
    (w, '実力の差がある。', '실력 차이가 있다.', 2);

  -- 257. セット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'セット', '세트', '영어 set의 외래어
한 묶음·조합', '명사', 257, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ディナーセットを注文した。', '디너 세트를 주문했다.', 1),
    (w, 'セットメニューがお得だ。', '세트 메뉴가 이득이다.', 2);

  -- 258. 意志
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '意志', 'いし', '의지', '意(뜻 의): 마음속 뜻
志(뜻 지): 뜻·포부', '명사', 258, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強い意志を持っている。', '강한 의지를 가지고 있다.', 1),
    (w, '意志が弱い。', '의지가 약하다.', 2);

  -- 259. 別れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '別れる', 'わかれる', '헤어지다', '別(나눌 별): 따로 나누다
자동사형 れる이 붙음', '동사', 259, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '恋人と別れた。', '애인과 헤어졌다.', 1),
    (w, '友達と駅で別れた。', '친구와 역에서 헤어졌다.', 2);

  -- 260. 起きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '起きる', 'おきる', '일어나다, 발생하다', '起(일어날 기): 누워 있다가 일어섬
자동사로 기상·사건 발생', '동사', 260, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝七時に起きた。', '아침 7시에 일어났다.', 1),
    (w, '大事件が起きた。', '큰 사건이 발생했다.', 2);

  -- 261. 応援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '応援', 'おうえん', '응원', '応(응할 응): 대응·응답
援(도울 원): 도와줌', '명사', 261, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応援してくれてありがとう。', '응원해줘서 고마워.', 1),
    (w, 'チームを応援した。', '팀을 응원했다.', 2);

  -- 262. のばす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'のばす', '연장하다, 연기하다', '延ばす·伸ばす의 표기 → 길게 하다·늦추다
타동사', '동사', 262, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '期限を一週間のばした。', '기한을 일주일 연장했다.', 1),
    (w, '髪をのばす。', '머리를 길게 기른다.', 2);

  -- 263. ふる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふる', '흔들다', '振るの 표기 → 좌우로 흔들어 움직임
타동사로 물건을 좌우로 흔들다', '동사', 263, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をふって挨拶した。', '손을 흔들며 인사했다.', 1),
    (w, '塩を少しふってください。', '소금을 조금 뿌려 주세요.', 2);

  -- 264. カバー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'カバー', '커버, 덮개', '영어 cover의 외래어
덮개·책표지·대신 메움', '명사', 264, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本にカバーをかけた。', '책에 커버를 씌웠다.', 1),
    (w, '彼の仕事をカバーしてあげた。', '그의 일을 대신해 주었다.', 2);

  -- 265. 想像
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '想像', 'そうぞう', '상상', '想(생각할 상): 마음에 그리다
像(모양 상): 머리속 그림', '명사', 265, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来を想像してみる。', '미래를 상상해본다.', 1),
    (w, '想像もできない。', '상상도 할 수 없다.', 2);

  -- 266. むく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'むく', '벗기다', '剥くの 표기 → 껍질을 벗기다
타동사', '동사', 266, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごの皮をむいた。', '사과 껍질을 벗겼다.', 1),
    (w, 'みかんの皮をむく。', '귤 껍질을 벗긴다.', 2);

  -- 267. かれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かれる', '시들다', '枯れるの 표기→ 식물이 쓰러짐
자동사', '동사', 267, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花がかれてしまった。', '꽃이 시들어 버렸다.', 1),
    (w, '水をやらないと植物はかれる。', '물을 주지 않으면 식물이 시들어.', 2);

  -- 268. がっかりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'がっかりする', '낙심하다, 실망하다', 'がっかり의 의태어에 する 결합
기대에 못 미쳐 실망함', '동사', 268, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験に落ちてがっかりした。', '시험에 떨어져서 낙심했다.', 1),
    (w, '試合に負けてがっかりする。', '시합에 져서 실망한다.', 2);

  -- 269. ヒント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ヒント', '힌트', '영어 hint의 외래어
암시·단서', '명사', 269, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ヒントをください。', '힌트를 주세요.', 1),
    (w, 'もう一つヒントを出そう。', '한 개 더 힌트를 주자.', 2);

  -- 270. なつかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なつかしい', '그립다', '懐かしいの 표기 → 과거가 그리운 상태
い형용사', 'い형용사', 270, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の頃がなつかしい。', '어린 시절이 그립다.', 1),
    (w, '故郷がなつかしくなった。', '고향이 그리워졌다.', 2);

  -- 271. 代金
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '代金', 'だいきん', '대금', '代(대신할 대): 대신
金(쇠 금): 돈', '명사', 271, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タクシー代金を払う。', '택시 대금을 지불한다.', 1),
    (w, '代金引換えで買った。', '대금 상환으로 구입했다.', 2);

  -- 272. しつこい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しつこい', '끈질기다, 집요하다', '執こい 어원 → 집요하고 끈덕짐
い형용사', 'い형용사', 272, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しつこい勧誘に困る。', '끈질긴 권유에 곤란하다.', 1),
    (w, '咳がしつこくて治らない。', '기침이 끈질겨서 낫지 않는다.', 2);

  -- 273. 自動的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自動的', 'じどうてき', '자동적', '自動(자동): 스스로 움직임
的(과녁 적): ~다움을 나타내는 접미사', 'な형용사', 273, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このドアは自動的に開く。', '이 문은 자동으로 열린다.', 1),
    (w, '自動的に更新される。', '자동적으로 갱신된다.', 2);

  -- 274. 片方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '片方', 'かたほう', '한쪽', '片(조각 편): 한쪽 조각
方(모 방): 방향·쪽', '명사', 274, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴下の片方がない。', '양말 한쪽이 없다.', 1),
    (w, '片方の耳が聞こえない。', '한쪽 귀가 안 들린다.', 2);

  -- 275. かわく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かわく', '마르다', '乾くの 표기→ 수분이 없어짐
자동사', '동사', 275, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '洗濯物がかわいた。', '빨래가 마른다.', 1),
    (w, 'のどがかわいた。', '목이 마르다.', 2);

  -- 276. 増える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '増える', 'ふえる', '늘다, 증가하다', '増(더할 증): 더하여 커짐
자동사형 える이 붙음', '동사', 276, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人口が増えている。', '인구가 늘고 있다.', 1),
    (w, '体重が増えた。', '체중이 늘었다.', 2);

  -- 278. 急ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '急ぐ', 'いそぐ', '서두르다', '急(급할 급): 빠르고 급함
자동사로 행동을 빨리 함', '동사', 278, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校に急いだ。', '학교로 서둘러 갔다.', 1),
    (w, '急がないと遅れてしまう。', '서두르지 않으면 늦어 버린다.', 2);

  -- 279. ガラス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ガラス', '유리', '네덜란드어 glas의 외래어
투명하고 단단한 소재', '명사', 279, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ガラスのコップを使う。', '유리컵을 쓴다.', 1),
    (w, '窓のガラスが割れた。', '창문 유리가 깨졌다.', 2);

  -- 280. 倒れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '倒れる', 'たおれる', '쓰러지다', '倒(넘어질 도): 넘어짐
자동사형 れる이 붙음', '동사', 280, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風で木が倒れた。', '바람으로 나무가 쓰러졌다.', 1),
    (w, '病気で倒れて入院した。', '병으로 쓰러져서 입원했다.', 2);

  -- 281. 比較
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '比較', 'ひかく', '비교', '比(견주 비): 둘을 나란히 놓음
較(견줄 교): 견줘봄', '명사', 281, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人と比較しないで。', '다른 사람과 비교하지 마.', 1),
    (w, '価格を比較して買う。', '가격을 비교해서 산다.', 2);

  -- 282. ぴったり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぴったり', '딱, 꼭', '의태어 → 빈틈없이 맞는 상태
완벽히 일치하는 모양', '부사', 282, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この服はぴったりだ。', '이 옷은 딱 맞는다.', 1),
    (w, '昼食にぴったり間に合った。', '점심에 딱 맞춰 도착했다.', 2);

  -- 283. 必死
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '必死', 'ひっし', '필사적', '必(반드시 필): 반드시
死(죽을 사): 죽음', 'な형용사', 283, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必死で勉強した。', '필사적으로 공부했다.', 1),
    (w, '必死に走って間に合った。', '필사적으로 달려서 시간에 맞췄다.', 2);

  -- 284. ぼんやり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぼんやり', '멍하니, 흐릿하게', '의태어 → 의식이나 시야가 흐릿한 상태
주의력을 잃은 모양', '부사', 284, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼんやりして電車を見送った。', '멍하니 있다가 전철을 놓쳤다.', 1),
    (w, 'ぼんやりした表情だった。', '멍한 표정이었다.', 2);

  -- 286. パーセント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'パーセント', '퍼센트', '영어 percent의 외래어
백분율', '명사', 286, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '五パーセント割引きだ。', '5퍼센트 할인이다.', 1),
    (w, '賛成は七十パーセントだった。', '찬성은 70퍼센트였다.', 2);

  -- 287. 不安
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '不安', 'ふあん', '불안', '不(아닐 부): 아닐
安(편안 안): 편안함', 'な형용사', 287, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来が不安だ。', '미래가 불안하다.', 1),
    (w, '不安で眠れない。', '불안해서 잠을 잘 수 없다.', 2);

  -- 290. 数
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '数', 'かず', '수', '数(셈 수): 수를 헤아림
수량의 양', '명사', 290, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '数を数えてみた。', '수를 세어 봤다.', 1),
    (w, '参加者の数が多い。', '참가자 수가 많다.', 2);

  -- 292. ハンドル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ハンドル', '핸들', '영어 handle의 외래어
자동차의 운전대', '명사', 292, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ハンドルを右に切った。', '핸들을 오른쪽으로 꺾었다.', 1),
    (w, 'ハンドルをしっかり握って。', '핸들을 단단히 잡아.', 2);

  -- 294. ふくむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふくむ', '포함하다', '含むの 표기→ 안에 가지고 있음
타동사', '동사', 294, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '税金を含む。', '세금을 포함한다.', 1),
    (w, '送料も含まれている。', '배송비도 포함되어 있다.', 2);

  -- 296. のる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'のる', '타다', '乗るの 표기→ 교통수단에 올라타다
자동사', '동사', 296, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車に乗った。', '전철에 탔다.', 1),
    (w, 'バスに乗り遅れた。', '버스를 놓쳤다.', 2);

  -- 298. 違反
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '違反', 'いはん', '위반', '違(어긋날 위): 정해진 방향에서 벗어남
反(돌이킬 반): 돌이키다', '명사', 298, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スピード違反だ。', '속도 위반이다.', 1),
    (w, '交通規則違反をした。', '교통규칙 위반을 했다.', 2);

  -- 299. かつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かつ', '이기다', '勝つの 표기→ 경쟁에서 이김
자동사', '동사', 299, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合に勝った。', '경기에서 이겼다.', 1),
    (w, '応援していたチームが勝った。', '응원하던 팀이 이겼다.', 2);

  -- 300. 反対
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '反対', 'はんたい', '반대', '反(돌이킬 반): 되돌림
対(대할 대): 말·대응', '명사', 300, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この提案に反対だ。', '이 제안에 반대다.', 1),
    (w, '反対の意見もある。', '반대 의견도 있다.', 2);

  -- 301. 進む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '進む', 'すすむ', '나아가다, 진행하다', '進(나아갈 진): 앞으로 감
자동사', '동사', 301, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が順調に進んでいる。', '일이 순조롭게 진행되고 있다.', 1),
    (w, '計画を進めよう。', '계획을 진행하자.', 2);

  -- 302. 急行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '急行', 'きゅうこう', '급행', '急(급할 급): 빠르게
行(갈 행): 감', '명사', 302, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急行列車に乗る。', '급행열차를 탄다.', 1),
    (w, '次の急行は三時だ。', '다음 급행은 3시다.', 2);

  -- 303. うらやましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'うらやましい', '부럽다', '羨ましいの 표기→ 상대방을 부러워함
い형용사', 'い형용사', 303, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君がうらやましい。', '네가 부럽다.', 1),
    (w, 'うらやましい話だ。', '부러운 이야기다.', 2);

  -- 304. 残念
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '残念', 'ざんねん', '아쉬움, 유감', '残(남을 잔): 남아 있음
念(생각 녁): 생각', 'な형용사', 304, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合に負けて残念だ。', '경기에 져서 아쉽다.', 1),
    (w, '残念ながら欠席します。', '아쉽지만 불참합니다.', 2);

  -- 305. つもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つもり', '작정, 의도', '積もりの 표기 → 쌓아온 마음
의도·예정을 나타냄', '명사', 305, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日行くつもりだ。', '내일 갈 작정이다.', 1),
    (w, '買うつもりはない。', '살 의도는 없다.', 2);

  -- 306. なお
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なお', '또한, 여전히', '尚の 표기→ 아직도·더욱
접속사·부사', '접속사', 306, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なお、詳しくはホームページをご覧ください。', '또한 자세한 내용은 홈페이지를 참고하세요.', 1),
    (w, '雨がなお降っている。', '비가 여전히 내리고 있다.', 2);

  -- 308. 上下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '上下', 'じょうげ', '상하', '上(윗 상): 위
下(아래 하): 아래', '명사', 308, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上下関係が厳しい。', '상하관계가 엄격하다.', 1),
    (w, '上下をよく見ればわかる。', '위아래를 잘 보면 안다.', 2);

  -- 310. アナウンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'アナウンス', '안내방송', '영어 announce의 외래어
공식 알림', '명사', 310, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅でアナウンスが聞こえた。', '역에서 안내방송이 들렸다.', 1),
    (w, '出発アナウンスが流れた。', '출발 안내방송이 흘러나왔다.', 2);

  -- 311. 取り消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '取り消す', 'とりけす', '취소하다', '取(가질 취): 가지다
消(사라질 소): 없애다', '동사', 311, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約を取り消した。', '예약을 취소했다.', 1),
    (w, '注文を取り消してください。', '주문을 취소해 주세요.', 2);

  -- 312. 個性
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '個性', 'こせい', '개성', '個(낱개 개): 하나하나
性(성품 성): 성질', '명사', 312, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それぞれに個性がある。', '제각각 개성이 있다.', 1),
    (w, '個性を生かそう。', '개성을 살리자.', 2);

  -- 313. 演劇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '演劇', 'えんげき', '연극', '演(펼 연): 무대에서 펼쳐 보임
劇(심할 극): 극적인 이야기', '명사', 313, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '演劇を見に行った。', '연극을 보러 갔다.', 1),
    (w, '演劇部に入った。', '연극부에 들어갔다.', 2);

  -- 314. ぜひ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぜひ', '꼭, 부디', '是非の 표기 → 옳고 그름을 따지지 않고 반드시
강조 부사', '부사', 314, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜひ遊びに来てください。', '꼭 놀러 와 주세요.', 1),
    (w, 'ぜひ会いたい。', '꼭 만나고 싶다.', 2);

  -- 315. なくす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なくす', '잃다', '無くす·亡くす의 표기→ 없애다·잃어버리다
타동사', '동사', 315, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布をなくしてしまった。', '지갑을 잃어버렸다.', 1),
    (w, '自信をなくした。', '자신감을 잃었다.', 2);

  -- 316. 重要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '重要', 'じゅうよう', '중요', '重(무거울 중): 무게 있음
要(요구할 요): 중한 것', 'な형용사', 316, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な会議がある。', '중요한 회의가 있다.', 1),
    (w, '重要な案件だ。', '중요한 안건이다.', 2);

  -- 317. 通る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '通る', 'とおる', '지나가다', '通(통할 통): 관통해 지나감
자동사', '동사', 317, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が道を通る。', '차가 길을 지나간다.', 1),
    (w, '試験に通った。', '시험에 합격했다.', 2);

  -- 318. けが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'けが', '부상, 상처', '怪我の 표기 → 이상하게 당함 → 상처
명사', '명사', 318, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校でけがをした。', '학교에서 다쳤다.', 1),
    (w, '転んでけがをした。', '넘어져서 다쳤다.', 2);

  -- 319. なぐさめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なぐさめる', '위로하다', '慰めるの 표기→ 마음을 편안하게 함
타동사', '동사', 319, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達をなぐさめた。', '친구를 위로했다.', 1),
    (w, 'やさしい言葉でなぐさめる。', '따뜻한 말로 위로한다.', 2);

  -- 320. プログラム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'プログラム', '프로그램', '영어 program의 외래어
계획표·소프트웨어 코드', '명사', 320, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビプログラムを見る。', 'TV 프로그램을 본다.', 1),
    (w, 'プログラムを作る。', '프로그램을 만든다.', 2);

  -- 321. 落ちる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '落ちる', 'おちる', '떨어지다', '落(떨어질 락): 아래로 내려감
자동사', '동사', 321, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コップが棚から落ちた。', '컵이 선반에서 떨어졌다.', 1),
    (w, '試験に落ちた。', '시험에 떨어졌다.', 2);

  -- 322. ホテル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ホテル', '호텔', '영어 hotel의 외래어
숙박 시설', '명사', 322, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ホテルに泊まる。', '호텔에서 잔다.', 1),
    (w, 'ホテルを予約した。', '호텔을 예약했다.', 2);

  -- 323. 高度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '高度', 'こうど', '고도', '高(높을 고): 높음
度(법도 도): 정도', '명사', 323, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飛行機は高度を下げた。', '비행기는 고도를 낮췄다.', 1),
    (w, '高度な技術だ。', '고도의 기술이다.', 2);

  -- 324. たいてい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'たいてい', '대체로, 대개', '大抵の 표기→ 대략·평소
부사', '부사', 324, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たいてい六時に起きる。', '대개 6시에 일어난다.', 1),
    (w, 'たいていの人は知っている。', '대체로 사람들은 알고 있다.', 2);

  -- 326. 命
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '命', 'いのち', '생명, 목숨', '命(목숨 명): 입으로 명을 내림 → 숨을 쉬며 살아있음
살아있게 하는 원천', '명사', 326, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '命は一つしかない。', '생명은 하나뿐이다.', 1),
    (w, '命を大切にしよう。', '생명을 소중히 하자.', 2);

  -- 327. 集まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '集まる', 'あつまる', '모이다', '集(모일 집): 새들이 나무에 모임
자동사', '동사', 327, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広場に人が集まった。', '광장에 사람이 모였다.', 1),
    (w, '神社の前に集まってください。', '신사 앞으로 모여 주세요.', 2);

  -- 328. 授業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '授業', 'じゅぎょう', '수업', '授(줄 수): 가르침
業(일 업): 일·학업', '명사', 328, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '授業を受ける。', '수업을 받는다.', 1),
    (w, '授業中は集中しよう。', '수업 중에는 집중하자.', 2);

  -- 330. アクセサリー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'アクセサリー', '액세서리', '영어 accessory의 외래어
장식품·부속품', '명사', 330, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '可愛いアクセサリーを買った。', '귀여운 액세서리를 샀다.', 1),
    (w, 'アクセサリーをつけている。', '액세서리를 착용하고 있다.', 2);

  -- 331. 数字
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '数字', 'すうじ', '숫자', '数(셈 수): 수
字(글자 자): 글자', '명사', 331, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '数字を読み違えた。', '숫자를 잘못 읽었다.', 1),
    (w, '数字を入力してください。', '숫자를 입력해 주세요.', 2);

  -- 332. 国内
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '国内', 'こくない', '국내', '国(나라 국): 나라
内(안 내): 안·안쪽', '명사', 332, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '国内旅行が人気だ。', '국내 여행이 인기다.', 1),
    (w, '国内で購入できる。', '국내에서 구입할 수 있다.', 2);

  -- 333. 人気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '人気', 'にんき', '인기', '人(사람 인): 사람
気(기운 기): 기운', '명사', 333, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この歌手は人気がある。', '이 가수는 인기가 있다.', 1),
    (w, '人気メニューを頼んだ。', '인기 메뉴를 주문했다.', 2);

  -- 334. でかける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'でかける', '외출하다, 나가다', '出掛けるの 표기→ 밖으로 나가다
자동사', '동사', 334, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝早く出かけた。', '아침 일찍 나갔다.', 1),
    (w, '買い物に出かける。', '장을 보러 나간다.', 2);

  -- 336. もったいない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'もったいない', '아깝다', '勿体ないの 표기 → 본래의 가치가 없어짐
い형용사', 'い형용사', 336, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '捨てるのはもったいない。', '버리기에는 아깝다.', 1),
    (w, '時間がもったいない。', '시간이 아깝다.', 2);

  -- 337. 計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '計画', 'けいかく', '계획', '計(셈 계): 수를 헤아림
画(그을 획): 그림·계획', '명사', 337, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行の計画を立てた。', '여행 계획을 세웠다.', 1),
    (w, '計画通りに進んだ。', '계획대로 진행되었다.', 2);

  -- 338. もちろん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'もちろん', '물론', '勿論の 표기→ 논할 필요가 없이 당연함
부사', '부사', 338, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もちろん参加します。', '물론 참석합니다.', 1),
    (w, 'もちろん、それは友達のためだ。', '물론 그건 친구를 위해서다.', 2);

  -- 339. ペット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ペット', '애완동물', '영어 pet의 외래어
집에서 기르는 동물', '명사', 339, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬をペットとして飼っている。', '개를 애완동물로 키우고 있다.', 1),
    (w, 'ペットも入場可能だ。', '애완동물도 입장 가능이다.', 2);

  -- 340. 急に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '急に', 'きゅうに', '갑자기', '急(급할 급): 빠르고 다급함
부사·형용사처럼 쓰임', '부사', 340, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急に雨が降り始めた。', '갑자기 비가 내리기 시작했다.', 1),
    (w, '急に思い出した。', '갑자기 생각났다.', 2);

  -- 341. 機会
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '機会', 'きかい', '기회', '機(틀 기): 적절한 시기·계기
会(모일 회): 만남', '명사', 341, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いい機会だ。', '좋은 기회다.', 1),
    (w, '機会を逃すと勿体ない。', '기회를 놓치면 아깝다.', 2);

  -- 342. ふだん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふだん', '평소', '普段の 표기 → 일상적·평범한 때
부사', '부사', 342, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふだん、電車で出勤している。', '평소에 전철로 출근한다.', 1),
    (w, 'ふだんの仕事は忙しい。', '평소 업무는 바쁘다.', 2);

  -- 343. 教育
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '教育', 'きょういく', '교육', '教(가르칠 교): 가르침
育(기를 육): 기름', '명사', 343, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の教育に熱心だ。', '자녀 교육에 열심이다.', 1),
    (w, '教育を受ける権利がある。', '교육받을 권리가 있다.', 2);

  -- 344. ふえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふえる', '늘다, 증가하다', '増えるの 표기 → 수량이 늘어남
자동사', '동사', 344, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '孫が三人にふえた。', '손자가 세 명으로 늘었다.', 1),
    (w, '体重がふえて困っている。', '체중이 늘어 고민이다.', 2);

  -- 345. 訪問
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '訪問', 'ほうもん', '방문', '訪(찾을 방): 찾아감
問(물을 문): 물어봄', '명사', 345, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達を訪問した。', '친구를 방문했다.', 1),
    (w, '企業訪問の予定だ。', '기업 방문 예정이다.', 2);

  -- 348. たとえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'たとえば', '예를 들면', '例えばの 표기→ 예를 들면
접속사', '접속사', 348, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たとえば、こんな感じだ。', '예를 들면 이런 느낌이다.', 1),
    (w, 'たとえば梨やりんごも好きだ。', '예를 들면 배나 사과도 좋아한다.', 2);

  -- 349. テクニック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'テクニック', '테크닉', '영어 technique의 외래어
기술·방법', '명사', 349, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このテクニックは難しい。', '이 테크닉은 어렵다.', 1),
    (w, 'テクニックを身につける。', '기술을 익힌다.', 2);

  -- 350. 注目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '注目', 'ちゅうもく', '주목', '注(부을 주): 담아넣음→ 집중
目(눈 목): 눈·시선', '명사', 350, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人々の注目を浴びた。', '사람들의 주목을 받았다.', 1),
    (w, '他者の動きに注目している。', '타자의 움직임에 주목하고 있다.', 2);

  -- 351. 安全
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '安全', 'あんぜん', '안전', '安(편안 안): 편안함
全(온전할 전): 완전함', 'な형용사', 351, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安全に道を渡る。', '안전하게 길을 건너다.', 1),
    (w, '安全ベルトをしめる。', '안전벨트를 매다.', 2);

  -- 352. 利用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '利用', 'りよう', '이용', '利(이로울 리): 이익
用(쓸 용): 쓰다', '명사', 352, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サービスを利用する。', '서비스를 이용한다.', 1),
    (w, 'このカードはどこでも利用できる。', '이 카드는 어디서나 이용할 수 있다.', 2);

  -- 353. 過ぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '過ぎる', 'すぎる', '지나다, 넘다', '過(지날 과): 지나감
자동사', '동사', 353, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '期限が過ぎた。', '기한이 지났다.', 1),
    (w, 'もう三時を過ぎた。', '벌써 3시를 넘겼다.', 2);

  -- 354. 知り合い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '知り合い', 'しりあい', '아는 사람', '知(알 지): 알다
合う(합할 합): 서로 만나 어울림', '명사', 354, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社で知り合いになった。', '회사에서 아는 사이가 되었다.', 1),
    (w, '彼は知り合いが多い。', '그는 아는 사람이 많다.', 2);

  -- 355. 確実
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '確実', 'かくじつ', '확실', '確(굳을 확): 단단함·확고함
実(열매 실): 열매·진실', 'な형용사', 355, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確実な証拠がある。', '확실한 증거가 있다.', 1),
    (w, '確実な方法を選んだ。', '확실한 방법을 골랐다.', 2);

  -- 356. 文化
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '文化', 'ぶんか', '문화', '文(글월 문): 글·문장
化(될 화): 변화', '명사', 356, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他国の文化を学ぶ。', '외국 문화를 배운다.', 1),
    (w, '日本文化に興味がある。', '일본 문화에 흥미가 있다.', 2);

  -- 357. もしも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'もしも', '만약', '若しもの 표기→ 가정을 강조
부사', '부사', 357, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もしも雨が降ったらどうしよう。', '만약 비가 오면 어떻게 하지?', 1),
    (w, 'もしもの時に備える。', '만일의 경우에 대비한다.', 2);

  -- 358. ボランティア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ボランティア', '자원봉사', '영어 volunteer의 외래어
무보수로 활동하는 일', '명사', 358, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボランティア活動に参加した。', '자원봉사 활동에 참여했다.', 1),
    (w, 'ボランティアを募集している。', '자원봉사를 모집하고 있다.', 2);

  -- 359. 都合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '都合', 'つごう', '형편, 사정', '都(도읍 도): 모두
合(합할 합): 맞음→ 상황', '명사', 359, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '都合が悪い。', '형편이 안 좋다.', 1),
    (w, '都合のいい時に連絡して。', '편한 시간에 연락해줘.', 2);

  -- 360. 残る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '残る', 'のこる', '남다', '残(남을 잔): 남아있음
자동사', '동사', 360, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タスクが残っている。', '아직 업무가 남아 있다.', 1),
    (w, 'ケーキが一つ残った。', '케이크가 하나 남았다.', 2);

  -- 362. ストレス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ストレス', '스트레스', '영어 stress의 외래어
심리·신체에 가해지는 압박', '명사', 362, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事のストレスが多い。', '일의 스트레스가 많다.', 1),
    (w, 'ストレスを解消する。', '스트레스를 해소한다.', 2);

  -- 363. お礼
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, 'お礼', 'おれい', '사례', '礼(예도 례): 예절
접두사 お가 붙어 공손한 표현', '명사', 363, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お礼をしたい。', '사례를 하고 싶다.', 1),
    (w, 'お礼にケーキを贈った。', '사례로 케이크를 선물했다.', 2);

  -- 364. つく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つく', '붙다', '付くの 표기→ 다른 것에 닿아 감
자동사', '동사', 364, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シャツにシミがついた。', '셔츠에 얼룩이 묻었다.', 1),
    (w, '電気がついた。', '전기가 켜졌다.', 2);

  -- 366. 修理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '修理', 'しゅうり', '수리', '修(닦을 수): 고치다
理(다스릴 리): 다스림', '명사', 366, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車を修理に出した。', '차를 수리에 맡겼다.', 1),
    (w, '修理代が高い。', '수리비가 비싸다.', 2);

  -- 367. はずす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'はずす', '떼다, 풀다', '外すの 표기 → 밖으로 빼다·벗겨내다
타동사', '동사', 367, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '眼鏡をはずした。', '안경을 벗었다.', 1),
    (w, 'ボタンをはずす。', '단추를 푼다.', 2);

  -- 369. つらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つらい', '괴롭다, 힘들다', '辛いの 표기 → 마음·몸이 괴로움
い형용사', 'い형용사', 369, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '別れがつらい。', '이별이 괴롭다.', 1),
    (w, 'つらい思い出だ。', '괴로운 기억이다.', 2);

  -- 370. ガイド
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ガイド', '가이드', '영어 guide의 외래어
안내자·안내서', '명사', 370, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '観光ガイドをお願いする。', '관광 가이드를 부탁한다.', 1),
    (w, 'ガイドブックを読んだ。', '가이드북을 읽었다.', 2);

  -- 371. 説明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '説明', 'せつめい', '설명', '説(말씀 설): 말로 알림
明(밝을 명): 밝히 드러낼', '명사', 371, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その説明はわかりやすい。', '그 설명은 알기 쉽다.', 1),
    (w, '使い方を説明した。', '사용법을 설명했다.', 2);

  -- 372. 偶然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '偶然', 'ぐうぜん', '우연', '偶(짝 우): 짝·우연히 만남
然(그럴 연): 그러함', '명사', 372, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '偶然友達に会った。', '우연히 친구를 만났다.', 1),
    (w, '偶然にも空席があった。', '우연히도 빈자리가 있었다.', 2);

  -- 373. 必要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '必要', 'ひつよう', '필요', '必(반드시 필): 반드시·꼭
要(요구할 요): 구함', 'な형용사', 373, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必要な物を買う。', '필요한 것을 산다.', 1),
    (w, 'もう何も必要ない。', '이제 아무것도 필요없다.', 2);

  -- 374. 真っ赤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '真っ赤', 'まっか', '새빨갛다', '真(참 진): 완전한
赤(붉을 적): 붉은색', 'な형용사', 374, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真っ赤なりんごだ。', '새빨간 사과다.', 1),
    (w, '怒って顔が真っ赤だ。', '화가 나서 얼굴이 새빨갛다.', 2);

  -- 375. ようやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ようやく', '결국, 마침내', '漸くの 표기 → 시간이 지나 비로소
부사', '부사', 375, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ようやく完成した。', '마침내 완성했다.', 1),
    (w, 'ようやく雨が止んだ。', '결국 비가 그쳤다.', 2);

  -- 376. 役立つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '役立つ', 'やくだつ', '도움이 되다', '役(부릴 역): 쓰임·역할
立つ: 서다→ 쓸모가 있음', '동사', 376, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は役に立つ。', '이 책은 도움이 된다.', 1),
    (w, '社会の役に立ちたい。', '사회에 도움이 되고 싶다.', 2);

  -- 377. クラブ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'クラブ', '클럽, 동아리', '영어 club의 외래어
동호·회원제 모임', '명사', 377, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テニスクラブに入った。', '테니스 동아리에 들어갔다.', 1),
    (w, 'クラブでダンスを踊った。', '클럽에서 춤을 췄다.', 2);

  -- 379. 中止
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '中止', 'ちゅうし', '중지', '中(가운데 중): 중간
止(그칠 지): 멈춤', '명사', 379, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨で試合が中止になった。', '비로 경기가 중지되었다.', 1),
    (w, '会議を中止した。', '회의를 중단했다.', 2);

  -- 380. なる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なる', '되다', '成るの 표기→ 이루어지다·결과가 되다
자동사', '동사', 380, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人は医師になった。', '그는 의사가 되었다.', 1),
    (w, '気温が高くなった。', '기온이 높아졌다.', 2);

  -- 381. クッキー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'クッキー', '쿠키', '영어 cookie의 외래어
구운 과자', '명사', 381, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クッキーを焼いた。', '쿠키를 구웠다.', 1),
    (w, 'このクッキーは美味しい。', '이 쿠키는 맛있다.', 2);

  -- 383. 入力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '入力', 'にゅうりょく', '입력', '入(들 입): 들어감
力(힘 력): 힘', '명사', 383, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'データを入力した。', '데이터를 입력했다.', 1),
    (w, '入力ミスがあった。', '입력 오류가 있었다.', 2);

  -- 384. 濃度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '濃度', 'のうど', '농도', '濃(짙을 농): 짙음
度(법도 도): 정도', '명사', 384, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スープの濃度を調べる。', '수프의 농도를 조사한다.', 1),
    (w, '高い濃度の液体だ。', '높은 농도의 액체다.', 2);

  -- 385. パンフレット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'パンフレット', '팬플릿', '영어 pamphlet의 외래어
소책자', '명사', 385, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パンフレットをもらった。', '팬플릿을 받았다.', 1),
    (w, 'パンフレットを読んで見て。', '팬플릿을 읽어봐.', 2);

  -- 386. ばかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ばかり', '이르고, 마다', '許り·炭りの 표기→ 근접이나 한정 의미
조사', '조사', 386, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忙しいばかりだ。', '이제 좀 한가해졌다.', 1),
    (w, 'そればかりではない。', '그것뿐만이 아니다.', 2);

  -- 387. 退院
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '退院', 'たいいん', '퇴원', '退(물러날 퇴): 떠남
院(집 원): 쪻·병원', '명사', 387, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今週退院する。', '이번 주에 퇴원한다.', 1),
    (w, '退院后も安静にしたい。', '퇴원 후에도 안정하자.', 2);

  -- 388. パスポート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'パスポート', '여권', '영어 passport의 외래어
국적·신원을 증명하는 문서', '명사', 388, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パスポートを見せてください。', '여권을 보여주세요.', 1),
    (w, 'パスポートの期限が切れた。', '여권 기한이 끝났다.', 2);

  -- 389. のんびり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'のんびり', '한가롭게', '의태어→ 서두르지 않고 느글한 모양
부사', '부사', 389, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休日はのんびり過ごしたい。', '주말은 한가롭게 보내고 싶다.', 1),
    (w, 'この町はのんびりしている。', '이 동네는 한가롭다.', 2);

  -- 390. 表現
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '表現', 'ひょうげん', '표현', '表(겨럴 표): 계주 드러냄
現(나타날 현): 나타남', '명사', 390, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見を表現する。', '의견을 표현한다.', 1),
    (w, '言葉での表現が難しい。', '말로 표현하기 어렵다.', 2);

  -- 391. 全然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '全然', 'ぜんぜん', '전혀', '全(온전할 전): 완전함
然(그럴 연): 그러함', '부사', 391, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全然わからない。', '전혀 모르겠다.', 1),
    (w, '全然問題ない。', '전혀 문제없다.', 2);

  -- 392. インフルエンザ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'インフルエンザ', '인플루엔자', '영어 influenza의 외래어
독감', '명사', 392, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インフルエンザにかかった。', '인플루엔자에 걸렸다.', 1),
    (w, 'インフルエンザが流行している。', '독감이 유행하고 있다.', 2);

  -- 393. ぴかぴか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぴかぴか', '반짝반짝', '의태어→ 빛이 빛난이 빛을 발산함
아주 깨끗한 상태', '부사', 393, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴をぴかぴかに磨いた。', '구두를 반짝반짝하게 닦았다.', 1),
    (w, '星がぴかぴか輝いている。', '별이 반짝반짝 빛납니다.', 2);

  -- 394. 目標
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '目標', 'もくひょう', '목표', '目(눈 목): 목표·주목
標(표·표식 표): 표식', '명사', 394, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目標を高く設けよう。', '목표를 높게 세우자.', 1),
    (w, '目標を達成した。', '목표를 달성했다.', 2);

  -- 395. 目的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '目的', 'もくてき', '목적', '目(눈 목): 특정 지점
的(과녁 적): 구리 어미', '명사', 395, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目的を明確にしてください。', '목적을 명확히 해주세요.', 1),
    (w, '目的地に到着した。', '목적지에 도착했다.', 2);

  -- 396. 必ず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '必ず', 'かならず', '반드시', '必(반드시 필): 반드시
ず(である): 고정·부사화', '부사', 396, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必ず読んでください。', '반드시 읽어주세요.', 1),
    (w, '必ず連絡します。', '반드시 연락드리겠습니다.', 2);

  -- 397. 同時
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '同時', 'どうじ', '동시', '同(한가지 동): 같이
時(때 시): 때', '명사', 397, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同時に話さないで。', '동시에 말하지 마.', 1),
    (w, '同時進行で作業した。', '동시 진행으로 작업했다.', 2);

  -- 398. ぐっすり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぐっすり', '푹', '의태어→ 깊이 잠든 상태
완전히 잠든 모양', '부사', 398, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぐっすり寝た。', '푹 잔다.', 1),
    (w, 'ぐっすりと寝ている。', '푹 자고 있다.', 2);

  -- 399. 普段
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '普段', 'ふだん', '평소, 임소', '普(넓을 보): 두루·먹·단계
段(조각 단): 단계', '명사', 399, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '普段は都心で勤務している。', '평소에는 서울에서 근무한다.', 1),
    (w, '普段にやることをやろう。', '평소 하에 하는 것을 하자.', 2);

  -- 400. クレーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'クレーム', '클레임', '영어 claim의 외래어
항의·불만 제기', '명사', 400, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クレームを取り上げた。', '클레임을 접수했다.', 1),
    (w, 'クレームを出した。', '클레임을 제기했다.', 2);

  -- 401. 想像力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '想像力', 'そうぞうりょく', '상상력', '想像(상상): 그려보는 능력
力(힘 력): 힘·능력', '명사', 401, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供は想像力が豊かだ。', '아이는 상상력이 풍부하다.', 1),
    (w, '想像力を育てよう。', '상상력을 기르자.', 2);

  -- 402. つきあう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つきあう', '사귀다, 동행하다', '付き合うの 표기→ 다른 사람와 함께함
자동사', '동사', 402, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達とつきあう。', '친구와 어울린다.', 1),
    (w, '彼とつきあって三年になる。', '그와 사귄 지 3년이 된다.', 2);

  -- 403. 寢坊
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '寢坊', 'ねぼう', '늦잠', '寢(잘 침): 자다
坊(동네 방): 별명·언어 접미사', '명사', 403, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寢坊して遅刻した。', '늦잠 자서 지각했다.', 1),
    (w, '寢坊しないように気をつけて。', '늦잠 자지 않도록 조심해용.', 2);

  -- 404. 表
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '表', 'おもて', '갉, 표면', '表(격을 표): 밖으로 대합·갉
보이는 쪽', '명사', 404, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コインの表と裏。', '동전의 앞면과 뒷면.', 1),
    (w, '表に出る。', '곧으로 나온다.', 2);

  -- 405. 表
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '表', 'ひょう', '표, 도표', '表(격을 표): 표·도표
정리된 그림', '명사', 405, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'グラフを表にした。', '그래프를 표로 만들었다.', 1),
    (w, 'この表を見て下さい。', '이 표를 봐주세요.', 2);

  -- 406. 中身
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '中身', 'なかみ', '내용물', '中(가운데 중): 안·안쪽
身(몸 신): 몸·주제', '명사', 406, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '袋の中身を見せて。', '가방의 내용물을 보여줘.', 1),
    (w, '話の中身がない。', '이야기의 알맹이 없다.', 2);

  -- 407. 不便
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '不便', 'ふべん', '불편', '不(아닐 부): 아닐
便(편할 편): 편함', 'な형용사', 407, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車がないと不便だ。', '전철이 없으면 불편하다.', 1),
    (w, '不便な场所に住んでいる。', '불편한 장소에 살고 있다.', 2);

  -- 408. ぐっと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぐっと', '단번에, 꾸꾸', '의태어→ 힘을 주어 단속하게
일으로 강하게', '부사', 408, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぐっと口を閉めた。', '꾹 입을 다물었다.', 1),
    (w, '記録がぐっと伸びた。', '기록이 단숭 닝는다.', 2);

  -- 409. 親しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '親しい', 'したしい', '친하다', '親(컵하할 친): 가지가까쇄 지낸
しい 형용사형', 'い형용사', 409, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親しい友達と選話した。', '친한 친구와 통화했다.', 1),
    (w, '親しくなった。', '친해졌다.', 2);

  -- 410. アドバイス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'アドバイス', '조언, 충고', '영어 advice의 외래어
충고·조언', '명사', 410, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にアドバイスをもらった。', '선생님한테 조언을 받았다.', 1),
    (w, 'よいアドバイスだと思う。', '좋은 조언이라고 생각한다.', 2);

  -- 411. 一致
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '一致', 'いっち', '일치', '一(한 일): 하나
致(이르르다 치): 닿음', '명사', 411, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が一致した。', '의견이 일치했다.', 1),
    (w, 'データが一致しない。', '데이터가 일치하지 않는다.', 2);

  -- 412. 退屈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '退屈', 'たいくつ', '지루함', '退(물러날 퇴): 달아난
屈(굴할 굴): 굴함', 'な형용사', 412, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '退屈だった。', '지루했다.', 1),
    (w, '退屈しのいでいる。', '지루해하고 있다.', 2);

  -- 414. 当然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '当然', 'とうぜん', '당연', '当(마당할 당): 마땏함·맞음
然(그럴 연): 그러함', '부사', 414, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '当然のことだ。', '당연한 일이다.', 1),
    (w, '当然わかる。', '당연 뜨«앞다.', 2);

  -- 415. 工夫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '工夫', 'くふう', '궁리, 아이디어', '工(장인 공): 장인·재주
夫(지아비 부): 널리 알려짐', '명사', 415, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうしてようと工夫した。', '이렇게 하자고 궁리했다.', 1),
    (w, '工夫を出して仕事した。', '궁리를 짜내어 일했다.', 2);

  -- 416. 研究
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '研究', 'けんきゅう', '연구', '研(갈 연): 갈고 닦음
究(다할 구): 극에 달함', '명사', 416, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケースを研究している。', '암을 연구하고 있다.', 1),
    (w, '研究チームに参加した。', '연구팁에 참여했다.', 2);

  -- 417. ぶつかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぶつかる', '부딪치다', '衝かるの 표기→ 희 세게 서로 맞닿
자동사', '동사', 417, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電柱にぶつかった。', '전셔대에 부딪혔다.', 1),
    (w, '他人と意見がぶつかる。', '타인과 의견이 충돌한다.', 2);

  -- 418. メッセージ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'メッセージ', '메시지', '영어 message의 외래어
전달하는 내용', '명사', 418, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メッセージを受け取った。', '메시지를 받았다.', 1),
    (w, '倊重なメッセージを伝えたい。', '소중한 메시지를 전하고 싶다.', 2);

  -- 419. 直す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '直す', 'なおす', '고치다', '直(곳을 직): 곧이 하다
타동사', '동사', 419, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車を直した。', '차를 고쳐다.', 1),
    (w, '間違いを直す。', '잘못을 고친다.', 2);

  -- 420. 食料
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '食料', 'しょくりょう', '식료', '食(밥 식): 음식
料(헤아릴 료): 재료', '명사', 420, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食料品を買う。', '식료품을 산다.', 1),
    (w, '食料价格が上がった。', '식료 가격이 올랐다.', 2);

  -- 421. 代わり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '代わり', 'かわり', '대신', '代(대신할 대): 대신
わり 명사형', '명사', 421, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わたりの代わりに行ってください。', '나 대신 가주세요.', 1),
    (w, 'これの代わりはない。', '이게의 대신은 없다.', 2);

  -- 422. 缶詰
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '缶詰', 'かんづめ', '통조림', '缶(동이 임): 금속용기
詰(먹힘 질): 채움', '명사', 422, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ツナの缶詰を買う。', '참치 통조림을 산다.', 1),
    (w, 'スープを缶詰で作った。', '수프를 통조림으로 만들었다.', 2);

  -- 423. メールアドレス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'メールアドレス', '이메일주소', '영어 mail address의 외래어
전자메일 주소', '명사', 423, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メールアドレスを教えてください。', '이메일주소를 알려주세요.', 1),
    (w, 'メールアドレスが間違っている。', '이메일주소가 틀렸다.', 2);

  -- 426. 経験
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '経験', 'けいけん', '경험', '経(지날 경): 지나다
験(검사할 험): 조사함', '명사', 426, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豊富な経験がある。', '풍부한 경험이 있다.', 1),
    (w, '初めての経験だった。', '첫 경험이었다.', 2);

  -- 427. 中央
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '中央', 'ちゅうおう', '중앙', '中(가운데 중): 중간
央(가운데 앙): 중심', '명사', 427, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '町の中央にある公園だ。', '도시 중앙에 있는 공원이다.', 1),
    (w, '中央テーブルに座った。', '가운데 테이블에 앚자.', 2);

  -- 429. 増加
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '増加', 'ぞうか', '증가', '増(더할 증): 더해짐
加(더할 가): 더함', '명사', 429, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通事故が増加した。', '교통사고가 증가했다.', 1),
    (w, '販売が増加した。', '판매가 증가했다.', 2);

  -- 430. パン屋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, 'パン屋', 'パンや', '빵집', 'パン(포르투갈어 pao): 빵
屋(집 옥): 가게·집', '명사', 430, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パン屋でパンを買う。', '빵집에서 빵을 산다.', 1),
    (w, '騅前のパン屋は人気だ。', '역 앞 빵집은 인기다.', 2);

  -- 431. 性格
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '性格', 'せいかく', '성격', '性(성품 성): 성질
格(격식 격): 틀·격식', '명사', 431, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明るい性格だ。', '밝은 성격이다.', 1),
    (w, '他とは性格が違う。', '그와 성격이 다르다.', 2);

  -- 433. 印象
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '印象', 'いんしょう', '인상', '印(도장 인): 눈에 새김
象(모양 상): 모양', '명사', 433, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '印象に残る人だ。', '인상에 남는 사람이다.', 1),
    (w, '第一印象が良い。', '첫인상이 좋다.', 2);

  -- 435. 火事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '火事', 'かじ', '화재', '火(불 화): 불
事(일 사): 사건·일', '명사', 435, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '近ぐで火事が起きた。', '근처에서 화재가 났다.', 1),
    (w, '火事に気をつけよう。', '화재에 조심하자.', 2);

  -- 436. 経済
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '経済', 'けいざい', '경제', '経(지날 경): 지나감·다스림
済(건널 제): 건너감·도움', '명사', 436, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今の経済状況は悪い。', '지금 경제 상황은 나쁜다.', 1),
    (w, '経済学に興味がある。', '경제학에 흥미가 있다.', 2);

  -- 437. 都市
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '都市', 'とし', '도시', '都(도읍 도): 도읍
市(저자 시): 장', '명사', 437, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '都市生活は便利だ。', '도시 생활은 편리하다.', 1),
    (w, '都市都は渋滞している。', '도심은 붐비고 있다.', 2);

  -- 438. たまる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'たまる', '모이다, 쌓이다', '溜まる·足まるの 표기→ 쌓이거나 고임
자동사', '동사', 438, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスがたまっている。', '스트레스가 쌓여있다.', 1),
    (w, 'たまっていたためを出した。', '모아둔 저금을 꺼냈다.', 2);

  -- 440. 季節
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '季節', 'きせつ', '계절', '季(계절 계): 분르게 나눌
節(마디 절): 마디·구분', '명사', 440, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本は四つの季節がある。', '일본은 사계절이 있다.', 1),
    (w, '季節の変わり目だ。', '계절의 환절기다.', 2);

  -- 441. 移動
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '移動', 'いどう', '이동', '移(옮길 이): 옮김
動(움직일 동): 움직임', '명사', 441, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車で移動した。', '전철로 이동했다.', 1),
    (w, '移動中に電話した。', '이동 중에 전화했다.', 2);

  -- 442. 普通
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '普通', 'ふつう', '보통', '普(넓을 보): 두루
通(통할 통): 통함', '부사', 442, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '普通の生活をしている。', '평범한 생활을 하고 있다.', 1),
    (w, '普通は黔で出勤する。', '보통 전철로 출근한다.', 2);

  -- 443. 結婚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '結婚', 'けっこん', '결혼', '結(맺을 결): 맺음
婚(혼인 혼): 혼인', '명사', 443, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人と結婚した。', '그와 결혼했다.', 1),
    (w, '結婚記念日を祝う。', '결혼기념일을 축하한다.', 2);

  -- 444. 警察
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '警察', 'けいさつ', '경찰', '警(깨울칠 경): 경계·경보
察(살필 찰): 살퍼', '명사', 444, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '警察を呼ぶ。', '경찰을 부른다.', 1),
    (w, '警察に許した。', '경찰에 신고했다.', 2);

  -- 445. 閉める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '閉める', 'しめる', '닫다', '閉(닫을 폐): 잠그다
타동사', '동사', 445, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアを閉めた。', '문을 닫았다.', 1),
    (w, '店を閉める時間だ。', '가게를 닫을 시간이다.', 2);

  -- 446. 紹介
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '紹介', 'しょうかい', '소개', '紹(이을 소): 이음
介(끼일 개): 사이에 끼감', '명사', 446, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達を紹介してくれた。', '친구를 소개해줬다.', 1),
    (w, '自己紹介をした。', '자기소개를 했다.', 2);

  -- 447. 平和
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '平和', 'へいわ', '평화', '平(평평할 평): 평평함
和(화할 화): 조화롭고 다정함', '명사', 447, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界平和を願う。', '세계 평화를 원한다.', 1),
    (w, '平和に暮らしたい。', '평화롭게 살고 싶다.', 2);

  -- 448. 約束
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '約束', 'やくそく', '약속', '約(묶을 약): 묶음·약속
束(묶을 속): 묶음', '명사', 448, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束を守ってください。', '약속을 지켜주세요.', 1),
    (w, '約束を破ってしまった。', '약속을 어겨버렸다.', 2);

  -- 451. ～におうじて (~에 맞추어, ~에 대응하여)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～におうじて', '~에 맞추어, ~에 대응하여', '応(응할 응)+じる→「~에 응해」. 명사+に応じて. 대상에 따라 대응/변화한다는 의미', '문법-형식판단', 451, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '能力に応じて仕事を分ける。', '능력에 맞추어 일을 나눈다.', 1),
    (w, '季節に応じて服装を変えます。', '계절에 맞추어 복장을 바꿉니다.', 2);

  -- 452. ～って(＝と) (~라고)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～って(＝と)', '~라고 <구어체 인용>', '회화체에서 인용/내용을 나타내는 と의 변형. 「~と言った/思った」를 「~って言った」', '문법-형식판단', 452, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来ないって言ったよ。', '그는 안 온다고 말했어.', 1),
    (w, '田中さんって人を知ってる？', '다나카 씨라는 사람 알아?', 2);

  -- 453. ～ように (~하도록)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ように', '~하도록', '様(모양 양)에서 온 ように. 동사 사전형/ない형+ように. 목적·기원·지시 표현', '문법-형식판단', 453, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞こえるように大きい声で話してください。', '들리도록 큰 소리로 말해 주세요.', 1),
    (w, '忘れないようにメモした。', '잊지 않도록 메모했다.', 2);

  -- 454. ～ようになる (~하게 되다 <변화>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ようになる', '~하게 되다 <변화>', '동사 사전형/가능형+ようになる. 시간이 흘러 능력·습관·상태가 변화함을 표현', '문법-형식판단', 454, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語が話せるようになった。', '일본어를 말할 수 있게 되었다.', 1),
    (w, '毎朝走るようになりました。', '매일 아침 달리게 되었습니다.', 2);

  -- 455. ～ばいい (~하면 된다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ばいい', '~하면 된다', '동사 가정형(ば)+いい. 해결책·충고·소망의 제시', '문법-형식판단', 455, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩けばいい。', '역까지 걸으면 된다.', 1),
    (w, '雨が降らなければいいんですが。', '비가 안 오면 좋겠는데요.', 2);

  -- 456. とうとう (드디어)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'とうとう', '드디어, 마침내', '到頭(とうとう)에서 유래. 긴 과정 끝에 도달한 결과를 강조하는 부사', '문법-형식판단', 456, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とうとう試験に合格した。', '드디어 시험에 합격했다.', 1),
    (w, '彼はとうとう来なかった。', '그는 결국 오지 않았다.', 2);

  -- 457. ～てほしい (~했으면 좋겠다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てほしい', '~했으면 좋겠다', '동사 て형+ほしい(원하다). 상대에게 행동을 바라는 요구·희망', '문법-형식판단', 457, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の話を聞いてほしい。', '내 이야기를 들어줬으면 좋겠어.', 1),
    (w, '早く元気になってほしい。', '빨리 건강해졌으면 좋겠어.', 2);

  -- 458. ～ことになっている (~하기로 되어 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ことになっている', '~하기로 되어 있다', '동사 사전형+ことになっている. 규칙·관습·예정의 결정 사항', '문법-형식판단', 458, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は9時から始まることになっている。', '회의는 9시부터 시작하기로 되어 있다.', 1),
    (w, '日本では靴を脱ぐことになっている。', '일본에서는 신발을 벗기로 되어 있다.', 2);

  -- 459. ～にする (~으로 하다 <결정>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にする', '~으로 하다 <결정>', '명사+にする. 선택지 중 선택·결정을 나타냄', '문법-형식판단', 459, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飲み物はコーヒーにします。', '음료는 커피로 하겠습니다.', 1),
    (w, '今日の昼ごはんはラーメンにしよう。', '오늘 점심은 라멘으로 하자.', 2);

  -- 460. ～(さ)せないでください (~하게 하지 마세요)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せないでください', '~하게 하지 마세요', '사역형(~させる)+ない+でください. 시키지 말아 달라는 부탁', '문법-형식판단', 460, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に夜遅くまで勉強させないでください。', '아이에게 밤늦게까지 공부하게 하지 마세요.', 1),
    (w, 'これ以上彼女を泣かせないでください。', '더 이상 그녀를 울게 하지 마세요.', 2);

  -- 461. お～いたす (~하다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'お～いたす', '~하다 <겸양>', 'お+동사ます형+いたす(致す, する의 겸양). 자신의 행동을 낮춰 표현', '문법-형식판단', 461, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私がお手伝いいたします。', '제가 도와드리겠습니다.', 1),
    (w, '明日お電話いたします。', '내일 전화드리겠습니다.', 2);

  -- 462. ～はずがない (~할 리가 없다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～はずがない', '~할 리가 없다', '筈(はず, 마땅한 도리)+ない. 가능성을 강하게 부정', '문법-형식판단', 462, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が嘘をつくはずがない。', '그가 거짓말할 리가 없다.', 1),
    (w, 'こんな簡単な問題ができないはずがない。', '이런 간단한 문제를 못 풀 리가 없다.', 2);

  -- 463. ～させるつもりだ (~시킬 작정이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～させるつもりだ', '~시킬 작정이다', '사역형(~させる)+つもりだ(작정). 타인에게 행동을 시킬 의도', '문법-형식판단', 463, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に英語を習わせるつもりです。', '아이에게 영어를 배우게 할 작정입니다.', 1),
    (w, '弟に部屋を掃除させるつもりだ。', '동생에게 방을 청소하게 할 작정이다.', 2);

  -- 464. いつのまにか (어느새)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'いつのまにか', '어느새', 'いつ(언제)+の(の)+間(ま, 사이)+にか. 모르는 사이에 변화가 일어남', '문법-형식판단', 464, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつのまにか夜になった。', '어느새 밤이 되었다.', 1),
    (w, 'いつのまにか子供が寝ていた。', '어느새 아이가 자고 있었다.', 2);

  -- 465. ござる (있다 <정중>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ござる', '있다 <정중>', 'ある의 정중어. 「~でございます/ございます」 형태로 격식 있는 자리에서 사용', '문법-형식판단', 465, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらにございます。', '이쪽에 있습니다.', 1),
    (w, '何かご質問がございますか。', '무언가 질문이 있으십니까?', 2);

  -- 466. ～すぎる (지나치게 ~하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～すぎる', '지나치게 ~하다', '過(지날 과)에서 온 すぎる(과하다). 동사ます형/형용사 어간+すぎる. 정도가 과함', '문법-형식판단', 466, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べすぎてお腹が痛い。', '너무 많이 먹어서 배가 아프다.', 1),
    (w, 'この問題は難しすぎる。', '이 문제는 너무 어렵다.', 2);

  -- 467. ～ために (~때문에 <원인>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ために', '~때문에 <원인>', '為(위할 위)+に. 명사+の+ために, 동사 사전형/た형+ために. 원인·이유', '문법-형식판단', 467, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ったために試合が中止になった。', '비가 와서 시합이 중지되었다.', 1),
    (w, '事故のために電車が遅れている。', '사고 때문에 전철이 지연되고 있다.', 2);

  -- 468. ～ないうちに (~하기 전에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ないうちに', '~하기 전에', '동사 ない형+うち(내, 동안)+に. 어떤 상태가 되지 않은 사이에', '문법-형식판단', 468, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降らないうちに帰ろう。', '비가 오기 전에 돌아가자.', 1),
    (w, '忘れないうちにメモしておく。', '잊기 전에 메모해 둔다.', 2);

  -- 469. ～だろうけど (~하겠지만)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だろうけど', '~하겠지만', 'だろう(추측)+けど(역접). 추측한 내용이지만 다른 면이 있음을 표현', '문법-형식판단', 469, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来るだろうけど、遅れるかもしれない。', '그는 오겠지만 늦을지도 모른다.', 1),
    (w, '高いだろうけど、買う価値はある。', '비싸겠지만 살 가치는 있다.', 2);

  -- 470. ～たびに (~할 때마다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たびに', '~할 때마다', '度(たび, 횟수)+に. 동사 사전형/명사+の+たびに. 반복되는 상황', '문법-형식판단', 470, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会うたびに彼は変わっていく。', '만날 때마다 그는 변해 간다.', 1),
    (w, '旅行のたびに写真を撮る。', '여행할 때마다 사진을 찍는다.', 2);

  -- 471. あいだ (~하는 동안)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '間', 'あいだ', '~하는 동안 (시간/공간 사이)', '間(사이 간): 門(문)+日(해)→문 사이로 들어오는 햇빛=틈, 사이. 시간 범위', '문법-형식판단', 471, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休みの間に本を読んだ。', '쉬는 동안에 책을 읽었다.', 1),
    (w, 'AとBの間に席がある。', 'A와 B 사이에 자리가 있다.', 2);

  -- 472. ～かどうか/～について (~인지 어떤지 / ~에 대하여)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～かどうか/～について', '~인지 어떤지 / ~에 대하여', 'か+どうか: 의문 선택지 / ~について: ~에 관해(주제)', '문법-형식판단', 472, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当かどうか分からない。', '진짜인지 어떤지 모르겠다.', 1),
    (w, '日本の文化について話します。', '일본 문화에 대해서 이야기합니다.', 2);

  -- 473. いまにも～そうだ (금세라도 ~할 것 같다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'いまにも～そうだ', '금세라도 ~할 것 같다', '今(이제)+にも(에도)+そうだ(양태). 어떤 일이 곧 일어날 것 같은 모습', '문법-형식판단', 473, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いまにも雨が降りそうだ。', '금세라도 비가 올 것 같다.', 1),
    (w, '彼女はいまにも泣きそうだった。', '그녀는 금세라도 울 것 같았다.', 2);

  -- 474. ～てあげる (~해 주다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てあげる', '~해 주다 (내가 남에게)', '동사 て형+あげる(주다). 화자가 타인에게 베푸는 행위', '문법-형식판단', 474, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に本を貸してあげた。', '친구에게 책을 빌려주었다.', 1),
    (w, '弟の宿題を手伝ってあげる。', '동생 숙제를 도와준다.', 2);

  -- 475. いつか (언젠가)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'いつか', '언젠가', 'いつ(언제)+か(불확정). 미래의 어떤 시점, 또는 과거의 모호한 시점', '문법-형식판단', 475, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつか日本に行ってみたい。', '언젠가 일본에 가 보고 싶다.', 1),
    (w, 'その話はいつか聞いたことがある。', '그 이야기는 언젠가 들은 적이 있다.', 2);

  -- 476. ～たらどうでしょう (~하면 어떨까요?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たらどうでしょう', '~하면 어떨까요? <제안>', '동사 た형+ら(가정)+どうでしょう(어떤가요). 정중한 제안·권유', '문법-형식판단', 476, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休んだらどうでしょう。', '조금 쉬면 어떨까요?', 1),
    (w, '先生に相談したらどうでしょう。', '선생님께 상담하면 어떨까요?', 2);

  -- 477. ～そうだ (~할 것 같다 <양태>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～そうだ', '~할 것 같다 <양태/외관>', '동사ます형/형용사 어간+そうだ. 보고 느낀 외관·상황 추측', '문법-형식판단', 477, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキはおいしそうだ。', '이 케이크는 맛있어 보인다.', 1),
    (w, '彼は今にも倒れそうだ。', '그는 금세라도 쓰러질 것 같다.', 2);

  -- 478. ～なら (~라면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なら', '~라면 <가정/주제>', 'なり(이다)의 가정형. 명사/동사 보통형+なら. 주제 가정', '문법-형식판단', 478, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あなたなら大丈夫だ。', '당신이라면 괜찮을 거다.', 1),
    (w, '日本に行くなら東京がいい。', '일본에 간다면 도쿄가 좋다.', 2);

  -- 479. ～な (~하지 마 <금지명령>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～な', '~하지 마 <금지명령>', '동사 사전형+な. 강한 금지 명령(남성 회화체)', '문법-형식판단', 479, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここに来るな。', '여기에 오지 마.', 1),
    (w, 'うそをつくな。', '거짓말하지 마.', 2);

  -- 480. お目にかかる (만나뵙다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'お目にかかる', 'おめにかかる', '만나뵙다 <겸양>', '目(눈)+に+かかる(걸리다)→「당신의 눈에 띄다」. 会う의 겸양어', '문법-형식판단', 480, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長にお目にかかりたいです。', '사장님을 만나뵙고 싶습니다.', 1),
    (w, '昨日先生にお目にかかりました。', '어제 선생님을 만나뵈었습니다.', 2);

  -- 481. ～って(＝というのは) (~은, ~라는 것은)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～って(＝というのは)', '~은, ~라는 것은 <주제>', 'というのは의 회화체 축약. 화제·주제 제시', '문법-형식판단', 481, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強って大変だね。', '공부란 힘드네.', 1),
    (w, '友達って大切なものだ。', '친구라는 건 소중한 것이다.', 2);

  -- 482. うかがう (찾아뵙다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '伺う', 'うかがう', '찾아뵙다/여쭙다 <겸양>', '伺(엿볼 사). 訪ねる(방문)·聞く(묻다)의 겸양어', '문법-형식판단', 482, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日お宅へ伺います。', '내일 댁으로 찾아뵙겠습니다.', 1),
    (w, '少し伺ってもよろしいですか。', '잠깐 여쭤봐도 괜찮을까요?', 2);

  -- 483. ～ようなら (~할 것 같으면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ようなら', '~할 것 같으면', '様(모양)+なら(라면). 그런 상태/상황이 예상되면', '문법-형식판단', 483, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るようなら出発を遅らせます。', '비가 올 것 같으면 출발을 늦추겠습니다.', 1),
    (w, '間に合わないようなら連絡してください。', '늦을 것 같으면 연락해 주세요.', 2);

  -- 484. ～など (~등 <나열>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～など', '~등 <나열>', '等(など, 등). 명사 뒤에 붙어 예시·나열·완곡', '문법-형식판단', 484, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リンゴやバナナなどの果物が好きだ。', '사과나 바나나 등의 과일을 좋아한다.', 1),
    (w, '映画やドラマなどを見ます。', '영화나 드라마 등을 봅니다.', 2);

  -- 485. ～させてください (~하게 해 주세요)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～させてください', '~하게 해 주세요 <허락 요청>', '사역형+てください. 자신의 행동에 대한 정중한 허락 요청', '문법-형식판단', 485, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休ませてください。', '잠시 쉬게 해 주세요.', 1),
    (w, '私に発表させてください。', '저에게 발표하게 해 주세요.', 2);

  -- 486. ～だけでよければ (~만으로 좋다면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけでよければ', '~만으로 좋다면', 'だけで(만으로)+よければ(좋다면, いいの가정형). 한정된 조건 제시', '문법-형식판단', 486, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少しだけでよければ手伝いますよ。', '조금만이라도 좋다면 도와드릴게요.', 1),
    (w, '簡単な料理だけでよければ作ります。', '간단한 요리만이라도 좋다면 만들겠습니다.', 2);

  -- 487. ～のことで (~에 관한 일로)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のことで', '~에 관한 일로', '명사+の+こと(일)+で. ~에 관한 용건/문제를 다룰 때', '문법-형식판단', 487, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題のことで先生に質問した。', '숙제에 관한 일로 선생님께 질문했다.', 1),
    (w, '仕事のことで悩んでいる。', '일에 관한 일로 고민하고 있다.', 2);

  -- 488. ～ほしがる (~을 원하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ほしがる', '~을 원하다 (제3자)', '欲しい(원하다)+がる. 제3자의 욕구·감정을 객관적으로 서술', '문법-형식판단', 488, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供がおもちゃをほしがっている。', '아이가 장난감을 원하고 있다.', 1),
    (w, '弟は新しい自転車をほしがる。', '동생은 새 자전거를 원한다.', 2);

  -- 489. ～までには (~까지는)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～までには', '~까지는 <기한>', 'まで(까지)+に(시점)+は(강조). 어떤 시점까지의 마감을 강조', '문법-형식판단', 489, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '5時までには家に帰ります。', '5시까지는 집에 돌아가겠습니다.', 1),
    (w, '来週までにはレポートを出してください。', '다음 주까지는 리포트를 내 주세요.', 2);

  -- 490. ～形をしている (~모습을 하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～形をしている', 'かたちをしている', '~모습을 하다, ~형태를 하다', '形(모양 형)+を+している. 외관·모양을 묘사', '문법-형식판단', 490, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このパンは星の形をしている。', '이 빵은 별 모양을 하고 있다.', 1),
    (w, '不思議な形をしている雲だ。', '신기한 모양을 하고 있는 구름이다.', 2);

  -- 491. ～たところだ (막 ~한 참이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たところだ', '막 ~한 참이다', '동사 た형+ところ(곳/때)+だ. 동작이 방금 막 끝남', '문법-형식판단', 491, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、家に着いたところだ。', '지금 막 집에 도착한 참이다.', 1),
    (w, 'ご飯を食べたところです。', '막 밥을 먹은 참입니다.', 2);

  -- 492. ～ような (~와 같은)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ような', '~와 같은 <비유/예시>', '様(모양)+な. 명사 수식. 비유·예시·유사함을 나타냄', '문법-형식판단', 492, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雪のような白い肌。', '눈처럼 흰 피부.', 1),
    (w, '夢のような話だ。', '꿈같은 이야기다.', 2);

  -- 493. ～そうもない (~할 것 같지도 않다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～そうもない', '~할 것 같지도 않다', '동사ます형+そうもない. 양태 추측의 강한 부정', '문법-형식판단', 493, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨は止みそうもない。', '비는 멈출 것 같지도 않다.', 1),
    (w, 'この仕事は今日終わりそうもない。', '이 일은 오늘 끝날 것 같지도 않다.', 2);

  -- 494. ～なんか (~같은 것)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なんか', '~같은 것, ~따위', 'など(등)의 회화체. 예시·완곡·경멸의 어감', '문법-형식판단', 494, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画なんかどう？', '영화 같은 거 어때?', 1),
    (w, '彼の話なんか信じない。', '그의 이야기 따위 안 믿어.', 2);

  -- 495. ～だけで (~만으로)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけで', '~만으로, ~한 것만으로도', 'だけ(뿐)+で(수단/이유). 한정 수단 또는 그만으로도 충분', '문법-형식판단', 495, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見ているだけで楽しい。', '보고 있는 것만으로도 즐겁다.', 1),
    (w, 'これだけで足ります。', '이것만으로 충분합니다.', 2);

  -- 496. ～として (~로서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～として', '~로서 <자격/입장>', '명사+として. 자격·입장·역할을 나타냄', '문법-형식판단', 496, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者として働いている。', '의사로서 일하고 있다.', 1),
    (w, '友達として忠告する。', '친구로서 충고한다.', 2);

  -- 497. ～にくらべて (~과 비교해서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にくらべて', '~과 비교해서', '比べる(비교하다)+て. 명사+にくらべて. 대상 간 비교', '문법-형식판단', 497, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年にくらべて今年は寒い。', '작년에 비해 올해는 춥다.', 1),
    (w, '兄にくらべて弟は背が高い。', '형에 비해 동생이 키가 크다.', 2);

  -- 498. さしあげる (드리다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '差し上げる', 'さしあげる', '드리다 <겸양>', '差し(내밀어)+上げる(올리다)→올려 드림. あげる의 겸양어', '문법-형식판단', 498, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にプレゼントを差し上げました。', '선생님께 선물을 드렸습니다.', 1),
    (w, '何かお手伝いを差し上げましょうか。', '뭔가 도와드릴까요?', 2);

  -- 499. ～にとって (~에게 있어서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にとって', '~에게 있어서, ~의 입장에서', '取る(취하다)에서 온 とる의 て형. 명사+にとって. 입장·관점', '문법-형식판단', 499, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私にとって家族が一番大切だ。', '나에게 있어서 가족이 제일 소중하다.', 1),
    (w, '学生にとって試験は大変だ。', '학생에게 있어서 시험은 힘들다.', 2);

  -- 500. こんなに (이렇게)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'こんなに', '이렇게, 이렇게나', 'こんな(이런)+に(부사화). 정도·상태의 부각', '문법-형식판단', 500, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんなにおいしいケーキは初めてだ。', '이렇게 맛있는 케이크는 처음이다.', 1),
    (w, 'こんなに疲れたのは久しぶりだ。', '이렇게 피곤한 건 오랜만이다.', 2);

  -- 501. ～られる (~할 수 있다 <가능>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～られる', '~할 수 있다 <가능>', '동사 미연형+られる(2그룹)/れる(1그룹). 가능·수동·존경 다의', '문법-형식판단', 501, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝早く起きられる。', '아침 일찍 일어날 수 있다.', 1),
    (w, '一人で来られますか。', '혼자서 올 수 있습니까?', 2);

  -- 502. ～するところだ (~하려는 참이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～するところだ', '막 ~하려는 참이다', '동사 사전형+ところだ. 동작이 막 시작되려는 시점', '문법-형식판단', 502, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、出かけるところです。', '지금 막 나가려는 참입니다.', 1),
    (w, 'ちょうど食べるところだった。', '마침 먹으려던 참이었다.', 2);

  -- 503. どうしたらいいのか (어떻게 하면 좋을지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どうしたらいいのか', '어떻게 하면 좋을지', 'どう+する+たら(가정)+いい(좋다)+のか. 망설임·고민 표현', '문법-형식판단', 503, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしたらいいのか分からない。', '어떻게 하면 좋을지 모르겠다.', 1),
    (w, '彼にどうしたらいいのか聞いた。', '그에게 어떻게 하면 좋을지 물었다.', 2);

  -- 504. ご覧になる (보시다 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'ご覧になる', 'ごらんになる', '보시다 <존경>', 'ご(존경 접두)+覧(볼 람)+になる. 見る의 존경어', '문법-형식판단', 504, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらをご覧になってください。', '이쪽을 봐 주십시오.', 1),
    (w, '先生はこの本をご覧になりましたか。', '선생님은 이 책을 보셨습니까?', 2);

  -- 505. ～かもしれない (~할지도 모른다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～かもしれない', '~할지도 모른다', 'か+も+しれない(知れない, 알 수 없다). 낮은 확률의 추측', '문법-형식판단', 505, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は雨かもしれない。', '내일은 비가 올지도 모른다.', 1),
    (w, '彼は来ないかもしれない。', '그는 안 올지도 모른다.', 2);

  -- 506. ～としても (~라고 할지라도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～としても', '~라고 할지라도, ~한다 해도', 'として(로서)+も(도). 가정·양보의 역접', '문법-형식판단', 506, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ったとしても出かけます。', '비가 온다 해도 외출하겠습니다.', 1),
    (w, '安いとしても買わない。', '싸다고 해도 안 산다.', 2);

  -- 507. ～なくて (~하지 않아서 <원인>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なくて', '~하지 않아서 <원인>', '동사 ない형+くて. 원인·이유의 부정형', '문법-형식판단', 507, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が来なくて遅刻した。', '전철이 안 와서 지각했다.', 1),
    (w, '答えが分からなくて困った。', '답을 몰라서 곤란했다.', 2);

  -- 508. ～前に (~하기 전에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～前に', 'まえに', '~하기 전에', '前(앞 전)+に. 동사 사전형/명사+の+前に. 시간적 선행', '문법-형식판단', 508, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寝る前に歯を磨く。', '자기 전에 이를 닦는다.', 1),
    (w, '食事の前に手を洗います。', '식사 전에 손을 씻습니다.', 2);

  -- 509. まだ～ている (아직 ~하고 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'まだ～ている', '아직 ~하고 있다', 'まだ(아직)+동사 て형+いる. 진행 중인 상태의 지속', '문법-형식판단', 509, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はまだ寝ている。', '그는 아직 자고 있다.', 1),
    (w, '雨がまだ降っている。', '비가 아직 내리고 있다.', 2);

  -- 510. ～ていただく (~해 받다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ていただく', '~해 받다 <겸양>', '동사 て형+いただく(もらう의 겸양). 윗사람의 행위를 받음', '문법-형식판단', 510, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に教えていただきました。', '선생님께 가르침을 받았습니다.', 1),
    (w, '少々お待ちいただけますか。', '잠시 기다려 주시겠습니까?', 2);

  -- 511. ～てもらえませんか (~해 주시겠습니까?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てもらえませんか', '~해 주시겠습니까? <정중 요청>', '동사 て형+もらえる(가능)+ませんか. 정중한 부탁', '문법-형식판단', 511, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を撮ってもらえませんか。', '사진을 찍어 주시겠습니까?', 1),
    (w, 'ドアを開けてもらえませんか。', '문을 열어 주시겠습니까?', 2);

  -- 512. ～だろうと思う (~할 것이라 생각하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だろうと思う', '~할 것이라 생각하다', 'だろう(추측)+と(인용)+思う(생각하다). 자신의 추측을 진술', '문법-형식판단', 512, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は雨が降るだろうと思う。', '내일은 비가 올 것이라 생각한다.', 1),
    (w, '彼は来ないだろうと思います。', '그는 오지 않을 것이라 생각합니다.', 2);

  -- 513. ～ば～ほど (~하면 할수록)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ば～ほど', '~하면 할수록', '동사 가정형(ば)+같은 동사 사전형+ほど(만큼). 정도의 비례 증감', '문법-형식판단', 513, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強すればするほど成績が上がる。', '공부하면 할수록 성적이 오른다.', 1),
    (w, '考えれば考えるほど分からなくなる。', '생각하면 할수록 모르겠다.', 2);

  -- 514. ～たり～たり (~하기도 하고 ~하기도 하고)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たり～たり', '~하기도 하고 ~하기도 하고', '동사 た형+り를 두 번 반복. 여러 행위의 나열·예시', '문법-형식판단', 514, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '週末は本を読んだり映画を見たりする。', '주말에는 책을 읽거나 영화를 보거나 한다.', 1),
    (w, '泣いたり笑ったりした。', '울기도 하고 웃기도 했다.', 2);

  -- 515. たしかに (분명히, 확실하게)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '確かに', 'たしかに', '분명히, 확실하게', '確(굳을 확)か+に. 명확하게·틀림없이의 부사', '문법-형식판단', 515, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確かに昨日彼を見た。', '분명히 어제 그를 봤다.', 1),
    (w, '確かにそうですね。', '확실히 그러네요.', 2);

  -- 516. ～だけ (~뿐)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけ', '~뿐, ~만 <한정>', '명사·동사 사전형+だけ. 범위·한정', '문법-형식판단', 516, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人だけ来ました。', '한 사람만 왔습니다.', 1),
    (w, '見るだけで楽しい。', '보는 것만으로도 즐겁다.', 2);

  -- 517. ～ためにも (~하기 위해서도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ためにも', '~하기 위해서도', '為(위할 위)+に+も(도). 목적을 강조하는 표현', '문법-형식판단', 517, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康のためにも運動が必要だ。', '건강을 위해서도 운동이 필요하다.', 1),
    (w, '将来のためにも勉強しよう。', '장래를 위해서도 공부하자.', 2);

  -- 518. ～でも (~라도 <예시>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でも', '~라도 <예시>', '명사+でも. 가벼운 예시·제안', '문법-형식판단', 518, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お茶でも飲みませんか。', '차라도 마시지 않겠습니까?', 1),
    (w, '散歩でもしましょう。', '산책이라도 합시다.', 2);

  -- 519. ＡにＢにＣ (A에 B에 C <첨가, 나열>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ＡにＢにＣ', 'A에 B에 C <첨가, 나열>', '명사+に의 반복으로 항목을 차례로 첨가/나열', '문법-형식판단', 519, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父に母に兄、家族みんなが来た。', '아빠에 엄마에 형, 가족 모두가 왔다.', 1),
    (w, '本にノートにペン、全部持ってきた。', '책에 노트에 펜, 전부 가져왔다.', 2);

  -- 520. ～にまで (~에까지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にまで', '~에까지 (예상 외 범위)', 'に+まで(까지). 보통은 미치지 않을 곳까지 미침을 강조', '문법-형식판단', 520, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達にまで嘘をついた。', '친구에게까지 거짓말을 했다.', 1),
    (w, '会社にまで連絡が来た。', '회사에까지 연락이 왔다.', 2);

  -- 521. ～を中心に (~을 중심으로)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～を中心に', 'ちゅうしんに', '~을 중심으로', '中(가운데 중)+心(마음 심). 명사+を+中心に. 중심적 위치/주제', '문법-형식판단', 521, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京を中心に活動している。', '도쿄를 중심으로 활동하고 있다.', 1),
    (w, '若者を中心に流行している。', '젊은이들을 중심으로 유행하고 있다.', 2);

  -- 522. ～たばかりだ (막 ~한 참이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たばかりだ', '막 ~한 참이다', '동사 た형+ばかりだ(뿐이다). 동작 직후의 시점', '문법-형식판단', 522, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、起きたばかりだ。', '지금 막 일어난 참이다.', 1),
    (w, 'この本は買ったばかりです。', '이 책은 막 산 참입니다.', 2);

  -- 523. ～はずだ ((틀림없이) ~할 것이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～はずだ', '(틀림없이) ~할 것이다', '筈(はず, 도리)+だ. 근거 있는 강한 추측·당연한 예상', '문법-형식판단', 523, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は今日来るはずだ。', '그는 오늘 올 것이다.', 1),
    (w, '答えはここにあるはずです。', '답은 여기에 있을 것입니다.', 2);

  -- 524. ～という (~라는 <인용, 설명>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～という', '~라는 <인용/설명>', 'と(인용)+いう(말하다). 명사+という+명사. 명칭·내용 설명', '문법-형식판단', 524, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中という人を知っていますか。', '다나카라는 사람을 아십니까?', 1),
    (w, '富士山という有名な山がある。', '후지산이라는 유명한 산이 있다.', 2);

  -- 525. ～のだから (~한 것이니까)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のだから', '~한 것이니까 <강한 이유>', 'のだ(설명)+から(이유). 명확한 근거 제시', '문법-형식판단', 525, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束したのだから守るべきだ。', '약속한 것이니까 지켜야 한다.', 1),
    (w, '勉強したのだから合格できる。', '공부했으니까 합격할 수 있다.', 2);

  -- 526. 近くに (근처에, 가까이에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '近くに', 'ちかくに', '근처에, 가까이에', '近(가까울 근)+く(형용사 부사화)+に. 장소 부근', '문법-형식판단', 526, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家の近くに公園がある。', '집 근처에 공원이 있다.', 1),
    (w, '駅の近くに住んでいます。', '역 근처에 살고 있습니다.', 2);

  -- 527. ～てもいいんじゃない (~해도 좋지 않을까?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てもいいんじゃない', '~해도 좋지 않을까?', '동사 て형+も+いい+のではない(회화 축약). 가벼운 제안', '문법-형식판단', 527, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休んでもいいんじゃない。', '조금 쉬어도 좋지 않을까?', 1),
    (w, '電話してもいいんじゃない。', '전화해도 되지 않을까?', 2);

  -- 528. ～てくる (~해 오다 <이동의 방향>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくる', '~해 오다 <방향/변화>', '동사 て형+来る. 방향(화자 쪽)·과거에서 현재까지의 변화', '문법-형식판단', 528, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ってきた。', '비가 내리기 시작했다.', 1),
    (w, '友達を連れてくる。', '친구를 데리고 오다.', 2);

  -- 529. ～たら (~했더니 <발견>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たら', '~했더니 <발견>', '동사 た형+ら. 동작 후 새로운 발견·결과', '문법-형식판단', 529, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '窓を開けたら鳥がいた。', '창문을 열었더니 새가 있었다.', 1),
    (w, '家に帰ったら手紙が来ていた。', '집에 갔더니 편지가 와 있었다.', 2);

  -- 530. ～(さ)せていただけませんか (~하게 해 주실 수 없겠습니까?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せていただけませんか', '~하게 해 주실 수 없겠습니까? <최정중 요청>', '사역형+ていただける(가능 겸양)+ませんか. 매우 정중한 허락 요청', '문법-형식판단', 530, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休ませていただけませんか。', '잠시 쉬게 해 주실 수 없겠습니까?', 1),
    (w, '質問させていただけませんか。', '질문하게 해 주실 수 없겠습니까?', 2);

  -- 531. ～てもおかしくない (~해도 이상하지 않다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てもおかしくない', '~해도 이상하지 않다', '동사 て형+も+おかしくない(이상하지 않다). 충분히 가능함', '문법-형식판단', 531, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう来てもおかしくない時間だ。', '이미 와도 이상하지 않은 시간이다.', 1),
    (w, '彼が怒ってもおかしくない。', '그가 화내도 이상하지 않다.', 2);

  -- 532. あの (저~)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あの', '저~ <원거리 지시>', '연체사. 화자·청자 모두에게서 먼 대상/공유된 기억의 대상', '문법-형식판단', 532, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの建物は何ですか。', '저 건물은 무엇입니까?', 1),
    (w, 'あの時のことを覚えています。', '그때의 일을 기억하고 있습니다.', 2);

  -- 533. ～ないといけない (~하지 않으면 안 된다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ないといけない', '~하지 않으면 안 된다 <의무>', '동사 ない형+と(조건)+いけない. 의무·필요성', '문법-형식판단', 533, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題をしないといけない。', '숙제를 안 하면 안 된다.', 1),
    (w, '早く帰らないといけません。', '빨리 돌아가지 않으면 안 됩니다.', 2);

  -- 534. ～と比べて (~과 비교해서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～と比べて', 'とくらべて', '~과 비교해서', '比(견줄 비)べる+て. 명사+と比べて. 대조 표현', '문법-형식판단', 534, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日と比べて今日は暑い。', '어제와 비교해서 오늘은 덥다.', 1),
    (w, '前と比べて元気になった。', '전과 비교해서 건강해졌다.', 2);

  -- 535. ～がる (~해 하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～がる', '~해 하다 (제3자 감정 표현)', '형용사 어간+がる. 1·2인칭의 감정/욕구를 3인칭으로 객관화', '문법-형식판단', 535, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が寒がっている。', '아이가 추워하고 있다.', 1),
    (w, '弟は犬を怖がる。', '동생은 개를 무서워한다.', 2);

  -- 536. ～には (~하려면 <목적>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～には', '~하려면 <목적>', '동사 사전형+には. 어떤 목적 달성에 필요한 조건', '문법-형식판단', 536, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅へ行くにはどうしたらいいですか。', '역에 가려면 어떻게 하면 됩니까?', 1),
    (w, '上手になるには練習が必要だ。', '잘하려면 연습이 필요하다.', 2);

  -- 537. 必ず (반드시)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '必ず', 'かならず', '반드시, 꼭', '必(반드시 필): 心(마음)을 묶음. 빠짐없이·꼭의 부사', '문법-형식판단', 537, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必ず連絡してください。', '반드시 연락해 주세요.', 1),
    (w, '彼は必ず時間を守る。', '그는 꼭 시간을 지킨다.', 2);

  -- 538. ～(さ)せてあげる (~하게 해 주다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せてあげる', '~하게 해 주다 <허락 베풂>', '사역형+てあげる. 상대가 원하는 행위를 허락해 줌', '문법-형식판단', 538, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に好きなことをやらせてあげる。', '아이에게 좋아하는 일을 하게 해 준다.', 1),
    (w, '弟に車を運転させてあげた。', '동생에게 차를 운전하게 해 주었다.', 2);

  -- 539. ～にくい (~하기 어렵다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にくい', '~하기 어렵다', '동사ます형+にくい(難い). 동작의 난이도', '문법-형식판단', 539, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この字は読みにくい。', '이 글자는 읽기 어렵다.', 1),
    (w, '彼の話は分かりにくい。', '그의 이야기는 이해하기 어렵다.', 2);

  -- 540. ～への (~로의)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～への', '~로의, ~에 대한', 'へ(방향)+の(연체). 방향·대상으로의 관계', '문법-형식판단', 540, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本への旅行を計画している。', '일본으로의 여행을 계획하고 있다.', 1),
    (w, '友達への手紙を書いた。', '친구에게의 편지를 썼다.', 2);

  -- 541. あんなに～のに (그렇게나 ~데도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あんなに～のに', '그렇게나 ~데도', 'あんなに(그렇게)+~のに(역접). 강한 대조·실망', '문법-형식판단', 541, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あんなに勉強したのに落ちた。', '그렇게나 공부했는데도 떨어졌다.', 1),
    (w, 'あんなに頼んだのに来なかった。', '그렇게나 부탁했는데도 안 왔다.', 2);

  -- 542. ～なくなってから (~하지 않게 되고 나서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なくなってから', '~하지 않게 되고 나서', '동사 ない형+くなる(상태 변화)+てから. 변화 후 시점', '문법-형식판단', 542, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タバコを吸わなくなってから3年だ。', '담배를 끊고 나서 3년이 됐다.', 1),
    (w, '走らなくなってから太った。', '달리지 않게 되고 나서 살이 쪘다.', 2);

  -- 543. ～を (~을, ~를)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～を', '~을, ~를 <목적격>', '목적격 조사. 타동사의 직접 목적어 표시', '문법-형식판단', 543, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を読む。', '책을 읽다.', 1),
    (w, 'ご飯を食べる。', '밥을 먹다.', 2);

  -- 544. ～たら<조건> (~하면 <조건>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たら', '~하면 <조건/가정>', '동사 た형+ら. 조건절(만약 ~한다면)', '문법-형식판단', 544, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金があったら旅行したい。', '돈이 있다면 여행하고 싶다.', 1),
    (w, '雨が降ったら中止です。', '비가 오면 중지입니다.', 2);

  -- 545. どこからでも (어디서든)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どこからでも', '어디서든', 'どこ(어디)+から(에서)+でも(라도). 모든 출발 지점 포괄', '문법-형식판단', 545, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どこからでも見える。', '어디서든 보인다.', 1),
    (w, 'どこからでも応募できる。', '어디서든 응모할 수 있다.', 2);

  -- 546. ～によって<구별> (~에 따라서 <차이, 구별>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～によって', '~에 따라서 <차이, 구별>', 'に+依る+て. 명사+によって. 상황·조건에 따른 차이', '문법-형식판단', 546, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人によって考え方が違う。', '사람에 따라 생각이 다르다.', 1),
    (w, '国によって文化が異なる。', '나라에 따라 문화가 다르다.', 2);

  -- 547. ～らしい (~답다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～らしい', '~답다 <전형성>', '명사+らしい. 본래의 성질·전형적 모습', '문법-형식판단', 547, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は男らしい人だ。', '그는 남자다운 사람이다.', 1),
    (w, '春らしい天気になった。', '봄다운 날씨가 되었다.', 2);

  -- 548. ～ためなら (~을 위해서라면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ためなら', '~을 위해서라면', '為(위할 위)+に+なら(라면). 강한 목적 의지', '문법-형식판단', 548, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢のためなら何でもできる。', '꿈을 위해서라면 무엇이든 할 수 있다.', 1),
    (w, '子供のためなら頑張れる。', '아이를 위해서라면 노력할 수 있다.', 2);

  -- 549. ～ないように (~하지 않도록)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ないように', '~하지 않도록 <목적>', '동사 ない형+ように. 부정의 목적·주의', '문법-형식판단', 549, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅刻しないように早く出ました。', '지각하지 않도록 일찍 나왔습니다.', 1),
    (w, '風邪をひかないように気をつける。', '감기에 걸리지 않도록 조심한다.', 2);

  -- 550. ああ (저렇게)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ああ', '저렇게 <원거리 상태>', 'こう/そう/ああ/どう 시리즈의 원거리. 화자·청자에게서 먼 양태', '문법-형식판단', 550, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ああいう人は珍しい。', '저런 사람은 드물다.', 1),
    (w, 'ああすればよかった。', '저렇게 했으면 좋았을 텐데.', 2);

  -- 551. ～ろ (~해 <명령>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ろ', '~해 <명령형>', '2그룹 동사 어간+ろ. 강한 직접 명령', '문법-형식판단', 551, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く起きろ。', '빨리 일어나.', 1),
    (w, 'もっと食べろ。', '더 먹어.', 2);

  -- 552. ご～いたす (~합니다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ご～いたす', '~합니다 <겸양>', 'ご(존경 접두)+한어 명사/동사+いたす. 한자어 동사의 겸양 표현', '문법-형식판단', 552, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご案内いたします。', '안내해 드리겠습니다.', 1),
    (w, 'ご説明いたします。', '설명해 드리겠습니다.', 2);

  -- 553. ～でなくてもよければ (~아니라도 좋다면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でなくてもよければ', '~아니라도 좋다면', 'で(이다)+ない+て+も+よければ(가정). 양보 조건 제시', '문법-형식판단', 553, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新品でなくてもよければあります。', '새것이 아니어도 좋다면 있습니다.', 1),
    (w, '日本人でなくてもよければ参加できる。', '일본인이 아니어도 좋다면 참가할 수 있다.', 2);

  -- 554. ご存じだ (아시다, 알고 계시다 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'ご存じだ', 'ごぞんじだ', '아시다, 알고 계시다 <존경>', 'ご(존경)+存(있을 존)じる+だ. 知る의 존경어', '문법-형식판단', 554, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本をご存じですか。', '이 책을 아십니까?', 1),
    (w, '田中先生をご存じですか。', '다나카 선생님을 아십니까?', 2);

  -- 555. ～か (~할지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～か', '~할지 <간접 의문>', '동사/형용사+か. 간접 의문절 표지', '문법-형식판단', 555, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何を食べるか決めましょう。', '무엇을 먹을지 정합시다.', 1),
    (w, '誰が来るか分からない。', '누가 올지 모르겠다.', 2);

  -- 556. ～たりする (~하기도 한다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たりする', '~하기도 한다 (예시)', '동사 た형+り+する. 여러 행동 중 예시 하나만 들기', '문법-형식판단', 556, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時々映画を見たりする。', '가끔 영화를 보기도 한다.', 1),
    (w, '一人で泣いたりする。', '혼자서 울기도 한다.', 2);

  -- 557. ～でございます (~입니다 <정중>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でございます', '~입니다 <최정중>', 'です의 최정중 형태. 명사+でございます. 격식 자리·접객', '문법-형식판단', 557, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '受付はこちらでございます。', '접수는 이쪽입니다.', 1),
    (w, '私が担当者でございます。', '제가 담당자입니다.', 2);

  -- 558. ～される (억지로 ~하게 되다 <사역수동>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～される', '억지로 ~하게 되다 <사역수동 축약>', '사역(さ)せる+受け身(られる)→される. 강제로 시켜져서 함', '문법-형식판단', 558, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無理に酒を飲まされた。', '억지로 술을 마시게 되었다.', 1),
    (w, '長時間待たされた。', '오랜 시간 기다리게 되었다.', 2);

  -- 559. ～に比べて (~과 비교해서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～に比べて', 'にくらべて', '~과 비교해서', '比(견줄 비)べる+て. 명사+に比べて. 한자어형 표현', '문법-형식판단', 559, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨年に比べて売上が増えた。', '작년에 비해 매출이 늘었다.', 1),
    (w, '前に比べて静かだ。', '전에 비해 조용하다.', 2);

  -- 560. ～んじゃなくて (~한 것이 아니라)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～んじゃなくて', '~한 것이 아니라', 'のではなくて의 회화체 축약. 정정·강조', '문법-형식판단', 560, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嫌いなんじゃなくて、苦手なんだ。', '싫은 게 아니라, 잘 못해.', 1),
    (w, '行きたくないんじゃなくて、忙しいんです。', '가고 싶지 않은 게 아니라 바쁩니다.', 2);

  -- 561. ～でも何でも (~이든 무엇이든)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でも何でも', '~이든 무엇이든', 'でも(라도)+何(아무것)+でも. 모든 종류 포괄', '문법-형식판단', 561, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーでも何でも飲みます。', '커피든 뭐든 마십니다.', 1),
    (w, 'お金でも何でもあげる。', '돈이든 뭐든 줄게.', 2);

  -- 562. もちろん (물론)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '勿論', 'もちろん', '물론, 당연히', '勿(말 물)+論(논할 론)→「논할 것도 없이」. 당연한 사실', '문법-형식판단', 562, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もちろん行きます。', '물론 갑니다.', 1),
    (w, 'もちろん知っています。', '물론 알고 있습니다.', 2);

  -- 563. もう～ない (이미 ~하지 않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'もう～ない', '이미 ~하지 않는다, 더 이상 ~하지 않는다', 'もう(이제/이미)+ない. 상태 종료·중단', '문법-형식판단', 563, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もうタバコは吸わない。', '이제 담배는 안 피운다.', 1),
    (w, 'もう泣かないでください。', '이제 울지 마세요.', 2);

  -- 564. ～ぐらい (~정도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ぐらい', '~정도, ~쯤', '位(자리 위)から. くらい와 동일. 대략의 양·정도', '문법-형식판단', 564, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一時間ぐらい待った。', '한 시간 정도 기다렸다.', 1),
    (w, '十人ぐらい来ました。', '열 명 정도 왔습니다.', 2);

  -- 565. ～をしている (~를 하고 있다 <상태>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～をしている', '~를 하고 있다 <상태/직업/모습>', '명사+を+する+ている. 지속적 상태나 외관·직업', '문법-형식판단', 565, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は青い目をしている。', '그는 파란 눈을 하고 있다.', 1),
    (w, '父は医者をしています。', '아버지는 의사를 하고 있습니다.', 2);

  -- 566. 次第に (점차, 점점)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '次第に', 'しだいに', '점차, 점점', '次(다음 차)+第(차례 제)+に. 「순서대로 천천히」', '문법-형식판단', 566, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天気が次第に良くなった。', '날씨가 점차 좋아졌다.', 1),
    (w, '次第に寒くなる。', '점점 추워진다.', 2);

  -- 567. ～ずつしかない (~씩밖에 없다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ずつしかない', '~씩밖에 없다', 'ずつ(씩)+しか(밖에)+ない(없다). 적은 양 강조', '문법-형식판단', 567, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人一つずつしかない。', '한 사람당 하나씩밖에 없다.', 1),
    (w, '少しずつしかもらえない。', '조금씩밖에 받을 수 없다.', 2);

  -- 568. ～には<대상> (~에게는)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～には', '~에게는 <대상 강조>', 'に(에/에게)+は(주제). 대상 한정 강조', '문법-형식판단', 568, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私には難しい問題だ。', '나에게는 어려운 문제다.', 1),
    (w, '子供には分からない。', '아이에게는 모른다.', 2);

  -- 569. ～(よ)うとする (~하려고 하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(よ)うとする', '~하려고 하다 <의지/시도>', '의지형(よう)+とする. 동작을 하려는 의도/순간', '문법-형식판단', 569, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけようとしたら雨が降った。', '나가려고 했더니 비가 왔다.', 1),
    (w, '電車に乗ろうとした。', '전철을 타려고 했다.', 2);

  -- 570. ～になら (~에게라면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～になら', '~에게라면', 'に(에게)+なら(라면). 대상 가정', '문법-형식판단', 570, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼になら話せる。', '그에게라면 말할 수 있다.', 1),
    (w, '先生になら頼める。', '선생님에게라면 부탁할 수 있다.', 2);

  -- 571. ～たまま (~한 채)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たまま', '~한 채, ~한 상태로', '동사 た형+まま(상태). 동작 후 상태 유지', '문법-형식판단', 571, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴を履いたまま部屋に入った。', '신발을 신은 채 방에 들어갔다.', 1),
    (w, '電気をつけたまま寝た。', '불을 켠 채 잤다.', 2);

  -- 572. ～せいで (~탓에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～せいで', '~탓에 <부정적 원인>', '所為(せい, 탓)+で. 부정적 결과의 원인 책임', '문법-형식판단', 572, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨のせいで試合が中止になった。', '비 탓에 시합이 중지되었다.', 1),
    (w, '彼のせいで遅刻した。', '그 탓에 지각했다.', 2);

  -- 573. ～つもりだ (~할 작정이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～つもりだ', '~할 작정이다, ~할 생각이다', '積もり(작정)+だ. 동사 사전형+つもりだ. 의지/계획', '문법-형식판단', 573, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来年日本に行くつもりだ。', '내년에 일본에 갈 작정이다.', 1),
    (w, '今日は早く帰るつもりです。', '오늘은 일찍 돌아갈 생각입니다.', 2);

  -- 574. ～うちに (~하는 사이에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～うちに', '~하는 사이에, ~동안에', '동사 て+いる+うちに. 그 상태가 지속되는 동안', '문법-형식판단', 574, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話しているうちに友達になった。', '이야기하는 사이에 친구가 되었다.', 1),
    (w, '若いうちに勉強しよう。', '젊을 때 공부하자.', 2);

  -- 575. いらっしゃる (계시다 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'いらっしゃる', '계시다, 오시다, 가시다 <존경>', '入(いら)+する의 변형. いる/くる/いく의 존경어', '문법-형식판단', 575, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生は教室にいらっしゃいます。', '선생님은 교실에 계십니다.', 1),
    (w, '明日いらっしゃいますか。', '내일 오십니까?', 2);

  -- 576. ～たこともある (~한 적도 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たこともある', '~한 적도 있다', '동사 た형+こと(일)+も+ある. 과거 경험(가능성)', '문법-형식판단', 576, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本へ行ったこともある。', '일본에 간 적도 있다.', 1),
    (w, '泣いたこともあるんです。', '운 적도 있습니다.', 2);

  -- 577. どれだけ～か (얼마나 ~한지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どれだけ～か', '얼마나 ~한지', 'どれ(어느)+だけ(만큼)+か(의문). 정도/양의 감탄·의문', '문법-형식판단', 577, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どれだけ大変だったか分かりません。', '얼마나 힘들었는지 모르겠다.', 1),
    (w, 'どれだけ嬉しかったか。', '얼마나 기뻤는지.', 2);

  -- 578. 誰からも (누구로부터든)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '誰からも', 'だれからも', '누구로부터든, 누구에게서도', '誰(누구)+から(에서)+も(도). 모든 사람 포괄/부정 강조', '문법-형식판단', 578, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰からも好かれている。', '누구에게나 사랑받고 있다.', 1),
    (w, '誰からも連絡がない。', '누구로부터도 연락이 없다.', 2);

  -- 579. ～により (~에 의해서 <원인>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～により', '~에 의해서 <원인/근거>', 'に+依る(よる)→より. 문어체. 원인·근거', '문법-형식판단', 579, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風により電車が止まった。', '태풍으로 인해 전철이 멈췄다.', 1),
    (w, '法律により禁止されている。', '법률에 의해 금지되어 있다.', 2);

  -- 580. ～(さ)せてください (~하게 해 주세요)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せてください', '~하게 해 주세요 <허락 요청>', '사역형+てください. 자신의 행위에 대한 허락 요청', '문법-형식판단', 580, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう少し考えさせてください。', '조금 더 생각하게 해 주세요.', 1),
    (w, 'これを使わせてください。', '이걸 쓰게 해 주세요.', 2);

  -- 581. ～のか (~인 것인지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のか', '~인 것인지', 'の(설명)+か(의문). 깊이 있는 의문/탐색', '문법-형식판단', 581, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何が原因なのか分からない。', '무엇이 원인인지 모르겠다.', 1),
    (w, 'なぜ来ないのか聞いた。', '왜 오지 않는 건지 물었다.', 2);

  -- 582. ～って(＝という) (~라는)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～って(＝という)', '~라는 <명칭/회화체>', 'という의 회화체 축약. 명사+って+명사', '문법-형식판단', 582, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中って人を知ってる？', '다나카라는 사람 알아?', 1),
    (w, '愛って何だろう。', '사랑이란 뭘까.', 2);

  -- 583. ～はじめる (~하기 시작하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～はじめる', '~하기 시작하다', '동사ます형+始(시작할 시)める. 동작 개시', '문법-형식판단', 583, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降りはじめた。', '비가 내리기 시작했다.', 1),
    (w, 'ピアノを習いはじめた。', '피아노를 배우기 시작했다.', 2);

  -- 584. ～になるまで (~가 될 때까지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～になるまで', '~가 될 때까지', '명사+に+なる(되다)+まで(까지). 상태 도달까지의 기간', '문법-형식판단', 584, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜になるまで遊んだ。', '밤이 될 때까지 놀았다.', 1),
    (w, '大人になるまでは家族と暮らす。', '어른이 될 때까지는 가족과 산다.', 2);

  -- 585. ついに (끝내, 마침내)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '遂に', 'ついに', '끝내, 마침내', '遂(이룰 수). 오랜 과정 후의 결과·종착', '문법-형식판단', 585, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ついに夢が叶った。', '마침내 꿈이 이루어졌다.', 1),
    (w, '彼はついに来なかった。', '그는 끝내 오지 않았다.', 2);

  -- 586. ～てくれ (~해 줘)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくれ', '~해 줘 <명령형 부탁>', '동사 て형+くれ(くれる의 명령형). 거친 명령식 부탁', '문법-형식판단', 586, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し待ってくれ。', '잠깐 기다려 줘.', 1),
    (w, '本を貸してくれ。', '책을 빌려 줘.', 2);

  -- 587. ～ほかに (~외에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ほかに', '~외에, ~말고도', '他(다를 타)+に. 명사/사전형+ほかに. 그것 이외에', '문법-형식판단', 587, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これ以外にほかに何かありますか。', '이것 외에 다른 게 있습니까?', 1),
    (w, '私のほかに誰も知らない。', '나 외에 아무도 모른다.', 2);

  -- 588. ～のだったら (~하는 것이라면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のだったら', '~하는 것이라면', 'のだ+の(가정)+ったら. 명확한 사실의 가정', '문법-형식판단', 588, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くのだったら早く出よう。', '갈 거라면 빨리 나가자.', 1),
    (w, '嫌いなのだったら食べなくていい。', '싫은 거라면 안 먹어도 돼.', 2);

  -- 589. ～ぐらい/～しか～ない (~정도 / ~밖에 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ぐらい/～しか～ない', '~정도 / ~밖에 ~않는다', 'ぐらい(정도)와 しか～ない(밖에 없다) 결합. 적은 양 강조', '문법-형식판단', 589, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '千円ぐらいしか持っていない。', '천 엔 정도밖에 없다.', 1),
    (w, '少しぐらいしか食べない。', '조금 정도밖에 안 먹는다.', 2);

  -- 590. ～てしまう/そうだ (~해 버리다 / ~할 것 같다 <양태>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てしまう/そうだ', '~해 버리다 / ~할 것 같다 <양태>', 'てしまう(완료/유감)와 そうだ(양태) 결합 또는 별개', '문법-형식판단', 590, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣いてしまいそうだ。', '울어 버릴 것 같다.', 1),
    (w, '忘れてしまった。', '잊어 버렸다.', 2);

  -- 591. ～なおす (다시 ~하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なおす', '다시 ~하다, 고쳐 ~하다', '동사ます형+直(곧을 직)す. 재시도·수정', '문법-형식판단', 591, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度書きなおします。', '다시 한 번 다시 쓰겠습니다.', 1),
    (w, '考えなおしてください。', '다시 생각해 주세요.', 2);

  -- 592. ～しか (~밖에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～しか', '~밖에 (부정과 함께)', '~しか+ない. 한정·결핍 강조', '문법-형식판단', 592, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私しか知らない。', '나밖에 모른다.', 1),
    (w, '一つしか残っていない。', '하나밖에 남지 않았다.', 2);

  -- 593. ～てくれる (~해 주다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくれる', '~해 주다 (남이 나에게)', '동사 て형+くれる. 타인이 화자에게 베푸는 행위', '문법-형식판단', 593, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達が手伝ってくれた。', '친구가 도와주었다.', 1),
    (w, '母が弁当を作ってくれる。', '엄마가 도시락을 만들어 준다.', 2);

  -- 594. ～だけだ (~뿐이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけだ', '~뿐이다, ~할 뿐이다', 'だけ(만)+だ. 유일·한정 강조', '문법-형식판단', 594, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は手伝うだけだ。', '나는 도울 뿐이다.', 1),
    (w, '彼を信じるだけです。', '그를 믿을 뿐입니다.', 2);

  -- 595. ～してもよさそうだ (~해도 괜찮을 것 같다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～してもよさそうだ', '~해도 괜찮을 것 같다', 'て+も+よい+そうだ(양태). 외관상 허용·문제 없어 보임', '문법-형식판단', 595, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは食べてもよさそうだ。', '이건 먹어도 괜찮을 것 같다.', 1),
    (w, 'もう帰ってもよさそうだ。', '이제 돌아가도 괜찮을 것 같다.', 2);

  -- 596. そう (그렇게)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'そう', '그렇게 <중거리 상태>', 'こう/そう/ああ 시리즈. 청자에 가까운/공유된 양태', '문법-형식판단', 596, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そうしてください。', '그렇게 해 주세요.', 1),
    (w, 'そう思います。', '그렇게 생각합니다.', 2);

  -- 597. ～(さ)せていただきます (~하겠습니다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せていただきます', '~하겠습니다 <겸양>', '사역형+ていただく(겸양)+ます. 자신의 행위를 정중히 선언', '문법-형식판단', 597, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休ませていただきます。', '잠시 쉬겠습니다.', 1),
    (w, '発表させていただきます。', '발표하겠습니다.', 2);

  -- 598. ～やすい (~하기 쉽다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～やすい', '~하기 쉽다', '동사ます형+易(쉬울 이)い. 행위의 용이함', '문법-형식판단', 598, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は読みやすい。', '이 책은 읽기 쉽다.', 1),
    (w, '先生の説明は分かりやすい。', '선생님 설명은 알기 쉽다.', 2);

  -- 599. どうしても～たい (무슨 일이 있어도 ~하고 싶다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どうしても～たい', '무슨 일이 있어도 ~하고 싶다', 'どうしても(아무리 해도)+たい(원함). 강한 욕구', '문법-형식판단', 599, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしても会いたい。', '무슨 일이 있어도 만나고 싶다.', 1),
    (w, 'どうしても見たい映画だ。', '꼭 보고 싶은 영화다.', 2);

  -- 600. 申す (말하다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '申す', 'もうす', '말하다 <겸양>', '申(거듭할 신). 言う(말하다)의 겸양어', '문법-형식판단', 600, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は田中と申します。', '저는 다나카라고 합니다.', 1),
    (w, 'お礼を申し上げます。', '감사 말씀드립니다.', 2);

  -- 601. ～ておく (~해 두다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ておく', '~해 두다 <준비>', '동사 て형+置(둘 치)く. 미리 준비/방치', '문법-형식판단', 601, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の前に資料を読んでおく。', '회의 전에 자료를 읽어 둔다.', 1),
    (w, '冷蔵庫に入れておきました。', '냉장고에 넣어 두었습니다.', 2);

  -- 602. 少しも～ない (조금도 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '少しも～ない', 'すこしも～ない', '조금도 ~않는다', '少し(조금)+も(도)+ない. 전면 부정 강조', '문법-형식판단', 602, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少しも分からない。', '조금도 모르겠다.', 1),
    (w, '少しもお酒が飲めない。', '조금도 술을 못 마신다.', 2);

  -- 603. おっしゃる (말씀하시다 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'おっしゃる', '말씀하시다 <존경>', '仰(우러를 앙)る. 言う(말하다)의 존경어', '문법-형식판단', 603, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生が何かおっしゃいました。', '선생님이 뭔가 말씀하셨습니다.', 1),
    (w, 'お名前は何とおっしゃいますか。', '성함은 어떻게 되십니까?', 2);

  -- 604. ～ば (~하면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ば', '~하면 <가정>', '동사 가정형 어미. 일반적 조건/가정', '문법-형식판단', 604, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春になれば花が咲く。', '봄이 되면 꽃이 핀다.', 1),
    (w, '時間があれば行きたい。', '시간이 있으면 가고 싶다.', 2);

  -- 605. ～としたら (~한다고 하면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～としたら', '~한다고 하면 <가정>', 'とする(라고 하다)+たら. 가정의 상황 설정', '문법-형식판단', 605, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宝くじが当たったとしたら何を買う？', '복권이 당첨된다면 뭘 사겠어?', 1),
    (w, '彼が来ないとしたら困る。', '그가 안 온다고 하면 곤란하다.', 2);

  -- 606. お～ください (~해 주십시오 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'お～ください', '~해 주십시오 <존경>', 'お+동사ます형+ください. 정중한 부탁 명령', '문법-형식판단', 606, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらにお座りください。', '이쪽에 앉아 주십시오.', 1),
    (w, '少々お待ちください。', '잠시 기다려 주십시오.', 2);

  -- 607. ～たくても (~하고 싶어도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たくても', '~하고 싶어도', 'たい+くても(역접). 욕구가 있지만 불가능', '문법-형식판단', 607, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行きたくても行けない。', '가고 싶어도 갈 수 없다.', 1),
    (w, '会いたくても会えない人。', '만나고 싶어도 만날 수 없는 사람.', 2);

  -- 608. ～に対して (~에 대해서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～に対して', 'にたいして', '~에 대해서, ~를 상대로', '対(대할 대)+する→対して. 대상·상대 표시', '문법-형식판단', 608, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に対して失礼だ。', '선생님에 대해 실례다.', 1),
    (w, 'この問題に対して意見を述べる。', '이 문제에 대해 의견을 말한다.', 2);

  -- 609. ～ても不思議ではない (~해도 이상하지 않다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～ても不思議ではない', 'ふしぎではない', '~해도 이상하지 않다', '不(아닐 부)+思議(이상함)+ない. 충분히 일어날 만하다', '문법-형식판단', 609, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来なくても不思議ではない。', '그가 안 와도 이상하지 않다.', 1),
    (w, '雨が降っても不思議ではない。', '비가 와도 이상하지 않다.', 2);

  -- 610. ～ことができる (~할 수 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ことができる', '~할 수 있다 <가능>', '동사 사전형+こと(일)+ができる. 능력/가능성', '문법-형식판단', 610, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語を話すことができる。', '일본어를 말할 수 있다.', 1),
    (w, '泳ぐことができますか。', '수영할 수 있습니까?', 2);

  -- 611. ～れる/られる (~하게 되다 <수동>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～れる/られる', '~하게 되다 <수동>', '동사 미연형+れる(1그룹)/られる(2그룹). 수동 표현', '문법-형식판단', 611, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に褒められた。', '선생님께 칭찬받았다.', 1),
    (w, '雨に降られた。', '비를 맞았다.', 2);

  -- 612. ～ないと (~하지 않으면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ないと', '~하지 않으면', '동사 ない형+と(조건). 「하지 않으면 안 된다」의 회화 축약', '문법-형식판단', 612, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く行かないと遅刻する。', '빨리 안 가면 지각한다.', 1),
    (w, '勉強しないと試験に落ちる。', '공부 안 하면 시험에 떨어진다.', 2);

  -- 613. ～ましょうか (~할까요?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ましょうか', '~할까요? <제안/도움>', 'ます+よう+か. 정중한 제안 또는 도움 의향', '문법-형식판단', 613, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一緒に行きましょうか。', '같이 갈까요?', 1),
    (w, 'お手伝いしましょうか。', '도와 드릴까요?', 2);

  -- 614. ～ばかり (~뿐)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ばかり', '~뿐, ~만 <한정·반복>', '명사/사전형+ばかり. 한정·과다·항상', '문법-형식판단', 614, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '甘いものばかり食べる。', '단것만 먹는다.', 1),
    (w, '泣いてばかりいる。', '울고만 있다.', 2);

  -- 615. ～に従って (~에 따라)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～に従って', 'にしたがって', '~에 따라 <변화/규칙>', '従(따를 종)う+て. 명사/동사+に従って. 비례적 변화/지시 준수', '문법-형식판단', 615, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年を取るに従って体力が落ちる。', '나이를 먹음에 따라 체력이 떨어진다.', 1),
    (w, '指示に従ってください。', '지시에 따라 주세요.', 2);

  -- 616. ～たがる (~하고 싶어 하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たがる', '~하고 싶어 하다 (제3자)', 'たい+がる. 3인칭의 욕구를 객관 묘사', '문법-형식판단', 616, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供がアイスを食べたがっている。', '아이가 아이스크림을 먹고 싶어 한다.', 1),
    (w, '彼は早く帰りたがる。', '그는 빨리 가고 싶어 한다.', 2);

  -- 617. ～そうにない (~할 것 같지 않다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～そうにない', '~할 것 같지 않다', '동사ます형+そう+に+ない. 양태 추측의 부정', '문법-형식판단', 617, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨は止みそうにない。', '비는 그칠 것 같지 않다.', 1),
    (w, '今日は終わりそうにない。', '오늘은 끝날 것 같지 않다.', 2);

  -- 618. ～だけでも (~만이라도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけでも', '~만이라도, ~만으로도', 'だけ(만)+でも(라도). 최소한의 양보·기대', '문법-형식판단', 618, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '声だけでも聞きたい。', '목소리만이라도 듣고 싶다.', 1),
    (w, '少しだけでも食べてください。', '조금만이라도 드세요.', 2);

  -- 619. ～てから (~하고 나서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てから', '~하고 나서', '동사 て형+から(부터). 동작의 순서/기점', '문법-형식판단', 619, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご飯を食べてから出かけた。', '밥을 먹고 나서 나갔다.', 1),
    (w, '宿題をしてから遊びます。', '숙제를 하고 나서 놉니다.', 2);

  -- 620. ～てしまいたい (~해 버리고 싶다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てしまいたい', '~해 버리고 싶다', 'てしまう+たい. 완료 동작에 대한 강한 욕구', '문법-형식판단', 620, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全部食べてしまいたい。', '전부 먹어 버리고 싶다.', 1),
    (w, '早く終わらせてしまいたい。', '빨리 끝내 버리고 싶다.', 2);

  -- 621. ようやく (마침내)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ようやく', '마침내, 간신히', '漸く(점차)에서 유래. 오랜 끝에 도달', '문법-형식판단', 621, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ようやく宿題が終わった。', '마침내 숙제가 끝났다.', 1),
    (w, 'ようやく春が来た。', '드디어 봄이 왔다.', 2);

  -- 622. ～てしまう (~해 버리다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てしまう', '~해 버리다 <완료/유감>', '동사 て형+しまう(끝나다). 완료 또는 후회·유감', '문법-형식판단', 622, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布をなくしてしまった。', '지갑을 잃어버렸다.', 1),
    (w, 'ケーキを全部食べてしまった。', '케이크를 전부 먹어 버렸다.', 2);

  -- 623. なんて～だろう (얼마나 ~란 말인가)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'なんて～だろう', '얼마나 ~란 말인가 <감탄>', 'なんて(어쩜)+だろう(추측). 감탄·감정의 강조', '문법-형식판단', 623, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんてきれいだろう。', '얼마나 예쁜지!', 1),
    (w, 'なんて優しい人だろう。', '얼마나 친절한 사람인가!', 2);

  -- 624. ～ため (~때문에)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ため', '~때문에, ~를 위해서', '為(위할 위). 명사+の/사전형+ため. 원인 또는 목적', '문법-형식판단', 624, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風のため学校は休みだ。', '태풍 때문에 학교는 휴일이다.', 1),
    (w, '健康のため運動する。', '건강을 위해 운동한다.', 2);

  -- 625. あと＋시간표현 (앞으로 (남은 시간))
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あと＋時間表現', '앞으로 (남은 시간)', '後(あと, 뒤/남은)+시간. 남은 시간/횟수', '문법-형식판단', 625, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あと5分で終わります。', '앞으로 5분이면 끝납니다.', 1),
    (w, 'あと1日で休みだ。', '앞으로 하루면 휴일이다.', 2);

  -- 626. ～てみる (~해 보다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てみる', '~해 보다 <시도>', '동사 て형+見る(보다). 시험·시도', '문법-형식판단', 626, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度食べてみてください。', '한 번 먹어 봐 주세요.', 1),
    (w, 'やってみたら面白かった。', '해 봤더니 재밌었다.', 2);

  -- 627. いただく (받다 <겸손>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '頂く', 'いただく', '받다 <겸양>, 먹다·마시다 <겸양>', '頂(정수리 정)く. 머리 위로 받음. もらう/食べる/飲む의 겸양어', '문법-형식판단', 627, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼントをいただきました。', '선물을 받았습니다.', 1),
    (w, 'お茶をいただきます。', '차를 마시겠습니다.', 2);

  -- 628. ～でいらっしゃいます (~입니다 <정중>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でいらっしゃいます', '~입니다 <정중>', 'で+いらっしゃる(いる의 존경)+ます. です의 정중·존경형', '문법-형식판단', 628, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中先生でいらっしゃいますか。', '다나카 선생님이십니까?', 1),
    (w, '社長でいらっしゃいます。', '사장님이십니다.', 2);

  -- 629. ～しか～ない (~밖에 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～しか～ない', '~밖에 ~않는다', 'しか(밖에)+ない(없다). 한정·소량 강조', '문법-형식판단', 629, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人しか来なかった。', '한 명밖에 안 왔다.', 1),
    (w, '少ししか食べなかった。', '조금밖에 안 먹었다.', 2);

  -- ────────── 문장 완성 (51개, 630~680) ──────────

  -- 630. ～ても (~해도 <역접>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ても', '~해도 <역접>', '동사 て형+も(도). 가정·역접의 양보', '문법-문장완성', 630, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っても行きます。', '비가 와도 갑니다.', 1),
    (w, '頑張っても無理だ。', '노력해도 무리다.', 2);

  -- 631. ～というような (~라는 것 같은)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～というような', '~라는 것 같은, ~와 같은', 'という(라는)+ような(같은). 유사·예시 표현', '문법-문장완성', 631, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が嘘をつくというような話は信じない。', '그가 거짓말한다는 이야기는 안 믿는다.', 1),
    (w, '簡単に終わるというような仕事ではない。', '간단히 끝난다는 그런 일이 아니다.', 2);

  -- 632. ～ことで (~것 때문에 <원인>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ことで', '~것 때문에 <원인>', '명사절+ことで. 「~한 일/것이 원인이 되어」', '문법-문장완성', 632, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さなことで悩んでいる。', '작은 일로 고민하고 있다.', 1),
    (w, '失敗したことで成長した。', '실패한 것 때문에 성장했다.', 2);

  -- 633. ～てもらう (~해 받다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てもらう', '~해 받다 (상대로부터)', '동사 て형+貰(받을 모)う. 화자가 타인의 행위를 받음', '문법-문장완성', 633, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に本を貸してもらった。', '친구에게서 책을 빌렸다.', 1),
    (w, '先生に教えてもらいます。', '선생님께 가르침을 받습니다.', 2);

  -- 634. ～だって (~라도 <회화체>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だって', '~라도, ~조차 <회화체>', 'でも의 회화체 변형. 강조·양보', '문법-문장완성', 634, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供だって分かる。', '아이라도 안다.', 1),
    (w, '私だってできるよ。', '나도 할 수 있어.', 2);

  -- 635. ちっとも～ない (조금도 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ちっとも～ない', '조금도 ~않는다', 'ちっと(조금)+も+ない. 전면 부정 강조(회화체)', '문법-문장완성', 635, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちっとも面白くない。', '조금도 재미없다.', 1),
    (w, 'ちっとも進まない。', '조금도 진행이 안 된다.', 2);

  -- 636. どんなに～ことか (얼마나 ~한 일인지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どんなに～ことか', '얼마나 ~한 일인지 <감탄/강조>', 'どんなに(얼마나)+こと+か. 정도의 감탄적 강조', '문법-문장완성', 636, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんなに嬉しかったことか。', '얼마나 기뻤는지!', 1),
    (w, 'どんなに苦労したことか。', '얼마나 고생했는지.', 2);

  -- 637. やらせてやる (시켜 주다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'やらせてやる', '시켜 주다, 하게 해 주다', 'やる의 사역+てやる(아래에게). 아랫사람에게 허락·시킴', '문법-문장완성', 637, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供にやりたいことをやらせてやろう。', '아이에게 하고 싶은 것을 시켜 주자.', 1),
    (w, '弟に好きなだけやらせてやった。', '동생에게 마음껏 시켜 주었다.', 2);

  -- 638. ～によって<수동> (~에 의해서 <수동의 동작 주체>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～によって', '~에 의해서 <수동의 동작 주체>', 'に+よる+て. 수동문에서 동작의 주체를 표시', '문법-문장완성', 638, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は彼によって書かれた。', '이 책은 그에 의해 쓰여졌다.', 1),
    (w, '電気はエジソンによって発明された。', '전기는 에디슨에 의해 발명되었다.', 2);

  -- 639. ～にする<선택> (~로 하다 <선택>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にする', '~로 하다 <선택/결정>', '명사+にする. 여러 옵션 중 선택', '문법-문장완성', 639, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーにします。', '커피로 하겠습니다.', 1),
    (w, '今日は休みにしよう。', '오늘은 휴식으로 하자.', 2);

  -- 640. ～ほど～ない (~만큼 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ほど～ない', '~만큼 ~않는다 <비교>', '명사+ほど(만큼)+ない. 비교의 부정', '문법-문장완성', 640, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は昨日ほど寒くない。', '오늘은 어제만큼 춥지 않다.', 1),
    (w, '彼ほど親切な人はいない。', '그만큼 친절한 사람은 없다.', 2);

  -- 641. ～おかげだ (~덕분이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～おかげだ', '~덕분이다 <긍정 이유>', 'お陰(かげ, 그늘=비호). 긍정적 결과의 원인', '문법-문장완성', 641, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格できたのは先生のおかげだ。', '합격할 수 있었던 것은 선생님 덕분이다.', 1),
    (w, '友達のおかげで楽しかった。', '친구 덕분에 즐거웠다.', 2);

  -- 642. 多分 (아마)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '多分', 'たぶん', '아마, 대개', '多(많을 다)+分(나눌 분)→「분량이 많이」→「대개」. 가능성 추측', '문법-문장완성', 642, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多分明日来るでしょう。', '아마 내일 올 거예요.', 1),
    (w, '多分大丈夫だ。', '아마 괜찮을 거다.', 2);

  -- 643. ～するまで (~할 때까지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～するまで', '~할 때까지', '동사 사전형+まで(까지). 동작의 한계 시점', '문법-문장완성', 643, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が止むまで待ちます。', '비가 그칠 때까지 기다립니다.', 1),
    (w, '彼が来るまで待っていた。', '그가 올 때까지 기다리고 있었다.', 2);

  -- 644. ～方がいい (~하는 편이 좋다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～方がいい', 'ほうがいい', '~하는 편이 좋다 <충고>', '方(편 방)+が+いい. 동사 た형/사전형+方がいい. 권유·충고', '문법-문장완성', 644, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く寝た方がいい。', '일찍 자는 편이 좋다.', 1),
    (w, '薬を飲んだ方がいいよ。', '약을 먹는 편이 좋아.', 2);

  -- 645. ～について/～(さ)せられる (~에 대하여 / 하게 된다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～について/～(さ)せられる', '~에 대하여 / 하게 된다 <사역수동>', 'について(주제)+사역수동(억지로 하게 됨). 두 표현 결합', '문법-문장완성', 645, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その問題について考えさせられた。', '그 문제에 대해 생각하게 되었다.', 1),
    (w, '事故について話を聞かされた。', '사고에 대해 이야기를 듣게 되었다.', 2);

  -- 646. ～だけでなく (~뿐만 아니라)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけでなく', '~뿐만 아니라', 'だけ(만)+で+なく(아니라). 첨가·확장', '문법-문장완성', 646, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は勉強だけでなくスポーツも得意だ。', '그는 공부뿐만 아니라 스포츠도 잘한다.', 1),
    (w, '東京だけでなく大阪にも行った。', '도쿄뿐만 아니라 오사카에도 갔다.', 2);

  -- 647. ～の一つに (~중의 하나로)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～の一つに', 'のひとつに', '~중의 하나로', '一(한 일)+つ(개)+に. 집합 중의 한 요소 지칭', '문법-문장완성', 647, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の趣味の一つに読書がある。', '내 취미 중 하나로 독서가 있다.', 1),
    (w, '世界遺産の一つに数えられる。', '세계유산 중의 하나로 꼽힌다.', 2);

  -- 648. 言われると (말을 들으면 <수동>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '言われると', 'いわれると', '말을 들으면 <수동>', '言う(말하다)의 수동+と(가정). 그런 말을 듣고 보면', '문법-문장완성', 648, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そう言われると確かに変だ。', '그런 말을 들으니 확실히 이상하다.', 1),
    (w, '怒られると悲しくなる。', '혼나면 슬퍼진다.', 2);

  -- 649. ～たことがある (~한 적이 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たことがある', '~한 적이 있다 <경험>', '동사 た형+こと+が+ある. 과거 경험', '문법-문장완성', 649, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本に行ったことがある。', '일본에 간 적이 있다.', 1),
    (w, 'この映画を見たことがあります。', '이 영화를 본 적이 있습니다.', 2);

  -- 650. ～まで (~까지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～まで', '~까지 <한계점>', '명사/동사+まで. 시간·장소·정도의 끝', '문법-문장완성', 650, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '5時まで働きます。', '5시까지 일합니다.', 1),
    (w, '駅まで歩いた。', '역까지 걸었다.', 2);

  -- 651. お～になる (~하시다 <존경>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'お～になる', '~하시다 <존경>', 'お+동사ます형+になる. 동사의 일반 존경 형식', '문법-문장완성', 651, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生がお話しになりました。', '선생님이 말씀하셨습니다.', 1),
    (w, 'お読みになりますか。', '읽으시겠습니까?', 2);

  -- 652. ～よりも (~보다도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～よりも', '~보다도 <비교 강조>', 'より(보다)+も(도). 비교의 강조', '문법-문장완성', 652, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼よりも私の方が背が高い。', '그보다도 내가 키가 크다.', 1),
    (w, '何よりも家族が大切だ。', '무엇보다도 가족이 소중하다.', 2);

  -- 653. 最も (가장, 제일)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '最も', 'もっとも', '가장, 제일', '最(가장 최)+も. 최상급의 부사', '문법-문장완성', 653, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '富士山は日本で最も高い山だ。', '후지산은 일본에서 가장 높은 산이다.', 1),
    (w, '最も大切なのは健康だ。', '가장 중요한 것은 건강이다.', 2);

  -- 654. ～だけは (~만은)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～だけは', '~만은 <한정 강조>', 'だけ(만)+は(주제). 다른 것은 몰라도 그것만은', '문법-문장완성', 654, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これだけは譲れない。', '이것만은 양보할 수 없다.', 1),
    (w, '勉強だけはきちんとしなさい。', '공부만은 제대로 해라.', 2);

  -- 655. ～てやる (~해 주다 윗→아래)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てやる', '~해 주다 (윗사람→아랫사람/거친 표현)', '동사 て형+やる. 아랫사람·동식물에게 베푸는 행위', '문법-문장완성', 655, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟に勉強を教えてやる。', '동생에게 공부를 가르쳐 준다.', 1),
    (w, '犬に水をやってください。', '강아지에게 물을 주세요.', 2);

  -- 656. ～と (~하면 <조건>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～と', '~하면 <자동·필연 조건>', '동사 사전형+と. 항상 그렇게 되는 자연·필연 조건', '문법-문장완성', 656, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春になると花が咲く。', '봄이 되면 꽃이 핀다.', 1),
    (w, '駅を出ると右に銀行がある。', '역을 나오면 오른쪽에 은행이 있다.', 2);

  -- 657. ～なくてはいけない (~하지 않으면 안 된다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なくてはいけない', '~하지 않으면 안 된다 <의무>', 'ない+くて+は+いけない. 강한 의무·필요성', '문법-문장완성', 657, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題をしなくてはいけない。', '숙제를 하지 않으면 안 된다.', 1),
    (w, '早く帰らなくてはいけません。', '빨리 돌아가지 않으면 안 됩니다.', 2);

  -- 658. ～で<범위> (~중에서 <범위 한정>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～で', '~중에서 <범위의 한정>', '명사+で. 그 범위/집합 안에서의 비교 기준', '문법-문장완성', 658, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスで一番背が高い。', '반에서 제일 키가 크다.', 1),
    (w, '日本で一番有名な山。', '일본에서 제일 유명한 산.', 2);

  -- 659. 音がする (소리가 나다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '音がする', 'おとがする', '소리가 나다', '音(소리 음)+が+する(나다). 감각의 발생', '문법-문장완성', 659, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '変な音がする。', '이상한 소리가 난다.', 1),
    (w, '外で音がした。', '밖에서 소리가 났다.', 2);

  -- 660. ～のに (~인데도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のに', '~인데도 <역접>', '명사+な+のに / 동사+のに. 의외·불만의 역접', '문법-문장완성', 660, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強したのに失敗した。', '공부했는데도 실패했다.', 1),
    (w, '夏なのに寒い。', '여름인데도 춥다.', 2);

  -- 661. ～の<연체수식> (연체수식절의 の)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～の', '연체수식절의 の <수식>', '연체수식절에서 が 대신 の 사용 가능(소속/주격)', '문법-문장완성', 661, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の作った料理。', '내가 만든 요리.', 1),
    (w, '父の買った車。', '아빠가 산 차.', 2);

  -- 662. ぴったり (꼭, 딱)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ぴったり', '꼭, 딱(꼭 들어맞거나 잘 어울림)', '의태어. 완벽한 일치·적합', '문법-문장완성', 662, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この服はぴったりだ。', '이 옷은 딱 맞다.', 1),
    (w, '時間ぴったりに来た。', '시간에 딱 맞춰 왔다.', 2);

  -- 663. だれも～ない (아무도 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'だれも～ない', '아무도 ~않는다', '誰(누구)+も+ない. 전면 부정의 주어', '문법-문장완성', 663, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰も来なかった。', '아무도 안 왔다.', 1),
    (w, '誰も知らない秘密。', '아무도 모르는 비밀.', 2);

  -- 664. ～ながら (~하면서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ながら', '~하면서 <동시동작>', '동사ます형+ながら. 동시에 일어나는 두 동작', '문법-문장완성', 664, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聞きながら勉強する。', '음악을 들으면서 공부한다.', 1),
    (w, '歩きながら話した。', '걸으면서 이야기했다.', 2);

  -- 665. ～ことから (~것으로부터)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ことから', '~것으로부터 <근거>', 'こと(일)+から(부터). 판단의 근거', '문법-문장완성', 665, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の話し方が分かることから日本人だと分かる。', '그의 말투를 보면 일본인임을 알 수 있다.', 1),
    (w, '雨が降っていたことから道が濡れている。', '비가 왔던 것으로부터 길이 젖어 있다.', 2);

  -- 666. ～そうだ<전문> (~라고 한다 <전문>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～そうだ', '~라고 한다 <전문>', '동사 보통형+そうだ. 들은 정보를 전달', '문법-문장완성', 666, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は雨が降るそうだ。', '내일은 비가 온다고 한다.', 1),
    (w, '彼は来ないそうです。', '그는 안 온다고 합니다.', 2);

  -- 667. あまりに (너무나)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あまりに', '너무나, 지나치게', '余(남을 여)りに. 정도가 과한 부사', '문법-문장완성', 667, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あまりに寒くて震えた。', '너무 추워서 떨었다.', 1),
    (w, 'あまりに疲れて寝てしまった。', '너무 피곤해서 자 버렸다.', 2);

  -- 668. どうしてかというと～からだ (어째서인가 하면 ~때문이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どうしてかというと～からだ', '어째서인가 하면 ~때문이다', 'どうして(어째서)+か+というと+からだ. 이유 설명 구조', '문법-문장완성', 668, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしてかというと、雨が降ったからだ。', '왜냐하면 비가 왔기 때문이다.', 1),
    (w, 'どうしてかというと、忙しかったからです。', '왜냐하면 바빴기 때문입니다.', 2);

  -- 669. ～で<함께> (~이 함께 <범위>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～で', '~이 함께 <범위의 한정>', '명사+で. 단체로/그 인원으로의 의미', '문법-문장완성', 669, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族で旅行に行った。', '가족이 함께 여행을 갔다.', 1),
    (w, 'みんなで歌を歌った。', '다 함께 노래를 불렀다.', 2);

  -- 670. これまでに (지금까지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'これまでに', '지금까지', 'これ(이것)+まで(까지)+に. 과거 ~ 현재의 누적', '문법-문장완성', 670, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これまでに何度も訪れた。', '지금까지 몇 번이나 방문했다.', 1),
    (w, 'これまでに見たことがない。', '지금까지 본 적이 없다.', 2);

  -- 671. ～でも/なかなか～ない (~라도 / 좀처럼 ~않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でも/なかなか～ない', '~라도 / 좀처럼 ~않는다', 'でも(라도)+なかなか(좀처럼)+ない. 양보 후 좀처럼 ~하지 못함', '문법-문장완성', 671, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張ってもなかなかうまくいかない。', '노력해도 좀처럼 잘 안 된다.', 1),
    (w, '練習してもなかなか上手にならない。', '연습해도 좀처럼 잘 안 늘다.', 2);

  -- 672. ～のを (~것을)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のを', '~것을, ~한 것을', 'の(명사화)+を(목적격). 동사 활동을 목적어로 만듦', '문법-문장완성', 672, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るのを待った。', '그가 오는 것을 기다렸다.', 1),
    (w, '雨が降るのを見ていた。', '비가 내리는 것을 보고 있었다.', 2);

  -- 673. ～にしかできない (~만이 할 수 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～にしかできない', '~만이 할 수 있다', 'に+しか(밖에)+できない. 그 사람/장소만 가능한 일', '문법-문장완성', 673, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼にしかできない仕事だ。', '그밖에 할 수 없는 일이다.', 1),
    (w, '私にしかできないことを探す。', '나만이 할 수 있는 것을 찾는다.', 2);

  -- 674. ～までで (~까지면, ~까지라도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～までで', '~까지면, ~까지라도', 'まで(까지)+で. 그 시점/장소에서 끝남', '문법-문장완성', 674, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日までで完了します。', '오늘까지면 완료합니다.', 1),
    (w, 'ここまでで終わりにしましょう。', '여기까지로 끝냅시다.', 2);

  -- 675. ～てほしい<요청> (~해 주었으면 한다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てほしい', '~해 주었으면 한다 <강한 희망>', '동사 て형+ほしい. 상대의 행동 강하게 희망', '문법-문장완성', 675, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く来てほしい。', '빨리 와 주었으면 한다.', 1),
    (w, '本当のことを話してほしい。', '진실을 말해 주었으면 한다.', 2);

  -- 676. どうしても～できない (아무리 해도 ~할 수 없다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どうしても～できない', '아무리 해도 ~할 수 없다', 'どうしても(아무리)+できない. 가능성의 강한 부정', '문법-문장완성', 676, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしても忘れられない。', '아무리 해도 잊을 수 없다.', 1),
    (w, 'どうしても理解できない。', '도저히 이해할 수 없다.', 2);

  -- 677. ～てくれない (~해 주지 않는다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくれない', '~해 주지 않는다, ~해 주지 않겠어?', '동사 て형+くれない. 부정/불만 또는 정중한 부탁', '문법-문장완성', 677, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰も助けてくれない。', '아무도 도와주지 않는다.', 1),
    (w, '一緒に来てくれない？', '같이 와 주지 않을래?', 2);

  -- 678. さらに (게다가, 더욱이)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '更に', 'さらに', '게다가, 더욱이', '更(다시 갱)+に. 추가·강도 증가', '문법-문장완성', 678, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降って、さらに風も強い。', '비가 오고 게다가 바람도 강하다.', 1),
    (w, 'さらに勉強が必要だ。', '더욱이 공부가 필요하다.', 2);

  -- 679. ～というわけだ (~인 것이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～というわけだ', '~인 것이다 <설명·결론>', 'という(라는)+わけ(이유)+だ. 결론적 설명', '문법-문장완성', 679, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、彼は来ないというわけだ。', '결국 그는 안 온다는 것이다.', 1),
    (w, '雨だから中止になったというわけです。', '비 때문에 중지가 된 것입니다.', 2);

  -- 680. それには (그렇게 하기 위해서는)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'それには', '그렇게 하기 위해서는', 'それ(그것)+には(에는). 목적 달성의 조건 제시', '문법-문장완성', 680, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢を叶えたい。それには努力が必要だ。', '꿈을 이루고 싶다. 그러기 위해서는 노력이 필요하다.', 1),
    (w, '健康になりたい。それには運動だ。', '건강해지고 싶다. 그러기 위해서는 운동이다.', 2);

  -- ────────── 문맥 이해 (53개, 681~733) ──────────

  -- 681. ところが～のだ (그렇지만 ~것이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ところが～のだ', '그렇지만 ~것이다', 'ところが(역접)+のだ(설명). 의외의 사실 강조', '문법-문맥이해', 681, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ところが彼は来なかったのだ。', '그런데 그는 오지 않았던 것이다.', 1),
    (w, 'ところが結果は失敗だったのだ。', '그런데 결과는 실패였던 것이다.', 2);

  -- 682. つまり (즉, 결국)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'つまり', '즉, 결국', '詰(찰 힐)まる(꽉 차다)에서 유래. 요약·결론', '문법-문맥이해', 682, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、君は反対なのだ。', '즉 너는 반대한다는 것이다.', 1),
    (w, 'つまり時間がないということだ。', '결국 시간이 없다는 것이다.', 2);

  -- 683. ですから (그러므로)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ですから', '그러므로, 그렇기 때문에', 'だから의 정중형. 원인·결과 연결', '문법-문맥이해', 683, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨です。ですから家にいます。', '비가 옵니다. 그러므로 집에 있겠습니다.', 1),
    (w, '忙しい。ですから手伝えない。', '바쁘다. 그러므로 도와줄 수 없다.', 2);

  -- 684. ～と言っている (~라고 말하고 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～と言っている', '~라고 말하고 있다', '인용 と+言う+ている. 제3자 발화 인용', '문법-문맥이해', 684, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来ないと言っている。', '그는 안 온다고 말하고 있다.', 1),
    (w, '雨が降ると言っています。', '비가 온다고 합니다.', 2);

  -- 685. ～のだ (~인 것이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のだ', '~인 것이다 <설명/단정>', 'の+だ. 이유 설명·강조·발견의 명사화', '문법-문맥이해', 685, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は休みなのだ。', '오늘은 휴일이다.', 1),
    (w, 'だから疲れているのだ。', '그래서 피곤한 것이다.', 2);

  -- 686. この (이)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'この', '이~ <근거리 지시>', '연체사. 화자에게 가까운 명사를 가리킴', '문법-문맥이해', 686, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は面白い。', '이 책은 재미있다.', 1),
    (w, 'この問題は難しい。', '이 문제는 어렵다.', 2);

  -- 687. ～というのは (~라는 것은)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～というのは', '~라는 것은 <주제 제시>', 'という+のは. 정의/설명을 위한 주제 제시', '문법-문맥이해', 687, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛というのは難しいものだ。', '사랑이라는 것은 어려운 것이다.', 1),
    (w, '友達というのは大切な存在だ。', '친구라는 것은 소중한 존재다.', 2);

  -- 688. ～ようにする (~하도록 하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ようにする', '~하도록 하다 <의식적 노력>', '동사 사전형+ようにする. 습관·노력을 의식적으로 만듦', '문법-문맥이해', 688, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日運動するようにしている。', '매일 운동하도록 하고 있다.', 1),
    (w, '早く寝るようにしてください。', '일찍 자도록 하세요.', 2);

  -- 689. ～てくる<변화> (~하기 시작하다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくる', '~하기 시작하다, ~해 오다 <변화>', '동사 て형+くる. 점진적 변화의 시작', '문법-문맥이해', 689, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒くなってきた。', '추워지기 시작했다.', 1),
    (w, '彼の気持ちが変わってきた。', '그의 마음이 변해 왔다.', 2);

  -- 690. ～なるのでしょうか (~인 걸까요?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～なるのでしょうか', '~인 걸까요? <정중 의문>', 'なる(되다)+のでしょうか. 정중한 추측·의문', '문법-문맥이해', 690, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これからどうなるのでしょうか。', '앞으로 어떻게 되는 걸까요?', 1),
    (w, '結果はどうなるのでしょうか。', '결과는 어떻게 될까요?', 2);

  -- 691. なぜなのか (왜 그런지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'なぜなのか', '왜 그런지', 'なぜ(왜)+なのか. 이유에 대한 의문', '문법-문맥이해', 691, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なぜなのか分からない。', '왜 그런지 모르겠다.', 1),
    (w, 'なぜなのか教えてください。', '왜 그런지 알려 주세요.', 2);

  -- 692. 同じ～ (같은~)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '同じ～', 'おなじ', '같은~', '同(같을 동)じ. 명사 수식. 동일성 표현', '문법-문맥이해', 692, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同じ学校に通っている。', '같은 학교에 다니고 있다.', 1),
    (w, '同じ意見です。', '같은 의견입니다.', 2);

  -- 693. こういう (이러한)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'こういう', '이러한, 이런', 'こう(이렇게)+いう(이라는). 종류·성질 지시', '문법-문맥이해', 693, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こういう場合はどうしますか。', '이런 경우는 어떻게 하시겠어요?', 1),
    (w, 'こういう人は信頼できる。', '이런 사람은 신뢰할 수 있다.', 2);

  -- 694. ～からだ (~때문이다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～からだ', '~때문이다 <이유>', 'から(부터/때문)+だ. 이유의 단정', '문법-문맥이해', 694, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗したのは準備不足だったからだ。', '실패한 것은 준비 부족이었기 때문이다.', 1),
    (w, '彼が来ないのは忙しいからです。', '그가 안 오는 것은 바쁘기 때문입니다.', 2);

  -- 695. それから (그리고)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'それから', '그리고, 그 다음에', 'それ(그것)+から(부터). 시간/순서의 연결', '문법-문맥이해', 695, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝食を食べた。それから学校へ行った。', '아침을 먹었다. 그리고 학교에 갔다.', 1),
    (w, 'それから何をしましたか。', '그리고 무엇을 했습니까?', 2);

  -- 696. そこで (그래서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'そこで', '그래서, 그러자', '명사 そこ(거기)+で. 그 상황을 받아 행동 도출', '문법-문맥이해', 696, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れた。そこで一休みした。', '피곤했다. 그래서 잠시 쉬었다.', 1),
    (w, '困った。そこで先生に相談した。', '곤란했다. 그래서 선생님께 상담했다.', 2);

  -- 697. ～のだと思う (~한 것이라고 생각한다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のだと思う', '~한 것이라고 생각한다', 'のだ(설명)+と思う(생각하다). 추측·해석을 진술', '문법-문맥이해', 697, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は知っているのだと思う。', '그는 알고 있는 것이라고 생각한다.', 1),
    (w, '怒っているのだと思います。', '화내고 있는 것이라고 생각합니다.', 2);

  -- 698. それとも (그렇지 않으면)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'それとも', '그렇지 않으면, 아니면', 'それ(그것)+とも. 선택지 제시', '문법-문맥이해', 698, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーですか、それともお茶ですか。', '커피입니까, 아니면 차입니까?', 1),
    (w, '行く、それとも行かない？', '갈래, 아니면 안 갈래?', 2);

  -- 699. 知りました (알았습니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '知りました', 'しりました', '알았습니다, 알게 되었습니다', '知る(알다)의 정중 과거형. 새로운 정보를 안 상태', '문법-문맥이해', 699, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その話を初めて知りました。', '그 이야기를 처음 알았습니다.', 1),
    (w, '昨日その事実を知りました。', '어제 그 사실을 알았습니다.', 2);

  -- 700. しかし (그러나)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'しかし', '그러나, 하지만', '문어체적 역접 접속사', '문법-문맥이해', 700, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だ。しかし出かける。', '비가 온다. 그러나 나간다.', 1),
    (w, '頑張った。しかし失敗した。', '노력했다. 그러나 실패했다.', 2);

  -- 701. その～ (그~)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'その～', '그~ <중거리 지시>', '연체사. 청자에게 가까운/방금 화제로 나온 명사', '문법-문맥이해', 701, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その本を貸してください。', '그 책을 빌려 주세요.', 1),
    (w, 'その話は知りません。', '그 이야기는 모릅니다.', 2);

  -- 702. ～のだそうだ (~인 것이라고 한다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～のだそうだ', '~인 것이라고 한다 <전문>', 'のだ(설명)+そうだ(전문). 들은 정보를 정중히 전달', '문법-문맥이해', 702, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は病気なのだそうだ。', '그는 병인 것이라고 한다.', 1),
    (w, '明日休みなのだそうです。', '내일 휴일인 것이라고 합니다.', 2);

  -- 703. 気がつく (알아차리다, 깨닫다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '気がつく', 'きがつく', '알아차리다, 깨닫다', '気(기운 기)+が+つく(붙다). 의식·주의가 달림', '문법-문맥이해', 703, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違いに気がついた。', '실수를 알아차렸다.', 1),
    (w, '彼の優しさに気がついた。', '그의 다정함을 깨달았다.', 2);

  -- 704. 思った (생각했다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '思った', 'おもった', '생각했다', '思う(생각하다)의 과거형. 주관적 판단·인상', '문법-문맥이해', 704, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいアイデアだと思った。', '좋은 아이디어라고 생각했다.', 1),
    (w, '無理だと思ったが、できた。', '무리라고 생각했지만 됐다.', 2);

  -- 705. ～と言われる (~라는 말을 듣다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～と言われる', '~라는 말을 듣다 <수동>', '인용 と+言う의 수동형. 평가·소문을 받음', '문법-문맥이해', 705, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父に似ていると言われる。', '아빠를 닮았다는 말을 듣는다.', 1),
    (w, '優しいとよく言われる。', '친절하다는 말을 자주 듣는다.', 2);

  -- 706. それ (그것)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'それ', '그것 <중거리 지시 대명사>', '대명사. 청자에게 가까운/방금 언급한 대상', '문법-문맥이해', 706, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは何ですか。', '그것은 무엇입니까?', 1),
    (w, 'それを取ってください。', '그것을 집어 주세요.', 2);

  -- 707. ～ができる (~을 할 수 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ができる', '~을 할 수 있다 <가능>', '명사+ができる. 능력·가능성', '문법-문맥이해', 707, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語ができる。', '일본어를 할 수 있다.', 1),
    (w, '料理ができますか。', '요리할 수 있습니까?', 2);

  -- 708. ～てくださる (~해 주시다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくださる', '~해 주시다 <존경>', '동사 て형+くださる(くれる의 존경). 윗사람의 베풂', '문법-문맥이해', 708, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生が教えてくださった。', '선생님이 가르쳐 주셨다.', 1),
    (w, '本を貸してくださいました。', '책을 빌려 주셨습니다.', 2);

  -- 709. ～てあげたい (~해 주고 싶다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てあげたい', '~해 주고 싶다', '동사 て형+あげる+たい. 상대에게 베풀고 싶은 욕구', '문법-문맥이해', 709, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に本を読んであげたい。', '아이에게 책을 읽어 주고 싶다.', 1),
    (w, '友達を助けてあげたい。', '친구를 도와주고 싶다.', 2);

  -- 710. そういう (그러한)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'そういう', '그러한, 그런', 'そう(그렇게)+いう. 종류·성질 지시', '문법-문맥이해', 710, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう人もいる。', '그런 사람도 있다.', 1),
    (w, 'そういう話は聞いたことがある。', '그런 이야기는 들은 적이 있다.', 2);

  -- 711. でも<접속> (그렇지만 <접속사>)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'でも', '그렇지만, 하지만 <접속사>', '회화체 역접 접속사. しかし의 캐주얼 버전', '문법-문맥이해', 711, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れた。でもまだやる。', '피곤하다. 하지만 아직 한다.', 1),
    (w, '安い。でも質はいい。', '싸다. 그런데 품질은 좋다.', 2);

  -- 712. ところが (그렇지만)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ところが', '그렇지만, 그런데 (의외)', '所(곳)+が. 예상과 다른 사실의 역접', '문법-문맥이해', 712, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝つと思った。ところが負けた。', '이길 거라 생각했다. 그런데 졌다.', 1),
    (w, 'ところが結果は逆だった。', '그렇지만 결과는 반대였다.', 2);

  -- 713. お世話になりました (신세 많이 졌습니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'お世話になりました', 'おせわになりました', '신세 많이 졌습니다', 'お+世(세상 세)+話(말씀 화). 신세를 받음의 정중 표현', '문법-문맥이해', 713, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大変お世話になりました。', '대단히 신세 많이 졌습니다.', 1),
    (w, '昨年はお世話になりました。', '작년에는 신세 졌습니다.', 2);

  -- 714. ～てくださいませんか (~해 주시지 않겠습니까?)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～てくださいませんか', '~해 주시지 않겠습니까? <정중 요청>', '동사 て형+くださる+ませんか. 매우 정중한 부탁', '문법-문맥이해', 714, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少しお待ちくださいませんか。', '잠시 기다려 주시지 않겠습니까?', 1),
    (w, 'ドアを閉めてくださいませんか。', '문을 닫아 주시지 않겠습니까?', 2);

  -- 715. ～でした (~이었습니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～でした', '~이었습니다', 'です의 과거형. 명사 술어의 정중 과거', '문법-문맥이해', 715, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日は雨でした。', '어제는 비였습니다.', 1),
    (w, '彼は学生でした。', '그는 학생이었습니다.', 2);

  -- 716. ～ている (~하고 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ている', '~하고 있다 <진행/상태>', '동사 て형+いる. 진행 또는 결과 지속', '문법-문맥이해', 716, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、勉強している。', '지금 공부하고 있다.', 1),
    (w, 'ドアが開いている。', '문이 열려 있다.', 2);

  -- 717. ～みたいだ (~한 것 같다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～みたいだ', '~한 것 같다 <추측·비유>', '見たい(보고 싶다)에서 유래. 회화체 추측·유사', '문법-문맥이해', 717, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っているみたいだ。', '비가 오고 있는 것 같다.', 1),
    (w, '彼は子供みたいだ。', '그는 어린아이 같다.', 2);

  -- 718. すると (그러자, 그랬더니)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'すると', '그러자, 그랬더니', 'する+と(가정/조건). 앞 일에 이어 일어난 결과', '문법-문맥이해', 718, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアを開けた。すると犬が走り出た。', '문을 열었다. 그러자 개가 뛰어나왔다.', 1),
    (w, '電話した。すると返事が来た。', '전화했다. 그러자 답이 왔다.', 2);

  -- 719. ～ようと思っている (~하려고 생각하고 있다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～ようと思っている', '~하려고 생각하고 있다', '의지형(よう)+と+思っている. 지속적 의지·계획', '문법-문맥이해', 719, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本へ留学しようと思っている。', '일본에 유학하려고 생각하고 있다.', 1),
    (w, '車を買おうと思っています。', '차를 사려고 생각하고 있습니다.', 2);

  -- 720. そのころ (그 무렵)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'そのころ', '그 무렵, 그 당시', 'その(그)+頃(ころ, 때/무렵). 시간 부근 지시', '문법-문맥이해', 720, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そのころはまだ学生だった。', '그 무렵에는 아직 학생이었다.', 1),
    (w, 'そのころから日本語を始めた。', '그 무렵부터 일본어를 시작했다.', 2);

  -- 721. ～も (~도)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～も', '~도 <첨가>', '명사+も. 동일성·첨가·강조', '문법-문맥이해', 721, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私も行きます。', '저도 갑니다.', 1),
    (w, '本も雑誌も買った。', '책도 잡지도 샀다.', 2);

  -- 722. 気がする (느낌이 들다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '気がする', 'きがする', '느낌이 들다, 기분이 든다', '気(기운 기)+が+する(나다). 주관적 인상·예감', '문법-문맥이해', 722, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何か忘れている気がする。', '뭔가 잊고 있는 느낌이 든다.', 1),
    (w, '雨が降りそうな気がする。', '비가 올 것 같은 느낌이 든다.', 2);

  -- 723. こんなこと (이런 것)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'こんなこと', '이런 것, 이런 일', 'こんな(이런)+こと(일). 근거리 사건 지칭', '문법-문맥이해', 723, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんなこと初めてだ。', '이런 일은 처음이다.', 1),
    (w, 'こんなこと言わなければよかった。', '이런 말 안 했으면 좋았을 텐데.', 2);

  -- 724. 言いました (말했습니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '言いました', 'いいました', '말했습니다', '言う(말하다)의 정중 과거형', '문법-문맥이해', 724, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来ないと言いました。', '그는 안 온다고 말했습니다.', 1),
    (w, 'ありがとうと言いました。', '고맙다고 말했습니다.', 2);

  -- 725. ～の方が (~쪽이)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '～の方が', 'のほうが', '~쪽이 <비교>', '方(방향/편)+が. 비교에서 한쪽 강조', '문법-문맥이해', 725, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こっちの方がいいです。', '이쪽이 낫습니다.', 1),
    (w, '私の方が背が高い。', '내가 키가 더 크다.', 2);

  -- 726. けれども (그렇지만)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'けれども', '그렇지만, 하지만', '문어/정중체 역접 접속사', '문법-문맥이해', 726, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れた。けれども頑張る。', '피곤하다. 그렇지만 노력한다.', 1),
    (w, '安い。けれどもいい商品だ。', '싸다. 그렇지만 좋은 상품이다.', 2);

  -- 727. 広がって (넓어져서)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '広がって', 'ひろがって', '넓어져서, 퍼져서', '広(넓을 광)がる+て. 범위/규모의 확대', '문법-문맥이해', 727, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '噂が広がっていく。', '소문이 퍼져 간다.', 1),
    (w, '景色が広がって見えた。', '경치가 넓게 펼쳐져 보였다.', 2);

  -- 728. ～かどうか (~인지 어떤지)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～かどうか', '~인지 어떤지', 'か+どうか. 불확실한 양자택일', '문법-문맥이해', 728, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くかどうか分からない。', '갈지 안 갈지 모르겠다.', 1),
    (w, '正しいかどうか確認する。', '맞는지 어떤지 확인한다.', 2);

  -- 729. ～たことがない (~한 적이 없다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～たことがない', '~한 적이 없다 <경험 부정>', '동사 た형+ことがない. 과거 경험의 부정', '문법-문맥이해', 729, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本に行ったことがない。', '일본에 간 적이 없다.', 1),
    (w, '寿司を食べたことがない。', '초밥을 먹은 적이 없다.', 2);

  -- 730. ～(さ)せる (~시키다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, '～(さ)せる', '~시키다, ~하게 하다 <사역>', '동사 미연형+せる(1그룹)/させる(2그룹). 사역 표현', '문법-문맥이해', 730, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に勉強させる。', '아이에게 공부시킨다.', 1),
    (w, '弟を泣かせた。', '동생을 울게 했다.', 2);

  -- 731. それでも (그렇지만)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'それでも', '그렇지만, 그래도', 'それ(그것)+で(이고)+も(도). 그럼에도 불구하고', '문법-문맥이해', 731, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だ。それでも出かけた。', '비가 온다. 그래도 나갔다.', 1),
    (w, '失敗した。それでも諦めない。', '실패했다. 그래도 포기하지 않는다.', 2);

  -- 732. 思っていたからです (생각하고 있었기 때문입니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '思っていたからです', 'おもっていたからです', '생각하고 있었기 때문입니다', '思う+ている(상태)+た(과거)+から(이유)+です. 과거의 지속적 인식이 이유', '문법-문맥이해', 732, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来ないと思っていたからです。', '그가 안 올 거라고 생각하고 있었기 때문입니다.', 1),
    (w, 'できると思っていたからです。', '할 수 있다고 생각하고 있었기 때문입니다.', 2);

  -- 733. 行ってみることにしました (가 보기로 했습니다)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '行ってみることにしました', 'いってみることにしました', '가 보기로 했습니다', '行く+てみる(시도)+ことにする(결정)+ました. 시도 의지의 결정', '문법-문맥이해', 733, array['grammar','jlpt_n3']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度行ってみることにしました。', '한 번 가 보기로 했습니다.', 1),
    (w, '新しい店に行ってみることにしました。', '새 가게에 가 보기로 했습니다.', 2);

  -- ============================================================
  -- 유의어 페어 (#734~867): N3 PDF 유의어 섹션 67쌍을 양쪽 모두 자체 단어 entry 로 등록
  -- 각 표현 은 자체 한자 어원/구조 + 예문 2개 보유
  -- 관계는 word_relations 의 양방향 synonym
  -- ============================================================

  -- 페어 1: きつい ≒ 大変だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'きつい', '힘들다, 빡세다', '굳이 한자 없음. い형용사. 「(체력·일이) 빡빡하다」 일상 표현', '유의 표현', 734, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '今日の仕事はきつい。', '오늘 일은 힘들다.', 1),
    (w1, 'きつい運動でつかれた。', '힘든 운동으로 지쳤다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '大変だ', 'たいへんだ', '큰일이다, 힘들다', '大(큰 대)+変(변할 변) → 큰 변고=큰일/힘듦. な형용사', '유의 표현', 735, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '毎日が大変だ。', '매일이 힘들다.', 1),
    (w2, '一人で大変な仕事をした。', '혼자서 힘든 일을 했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'きつい(빡빡함)=大変だ(힘듦) - 일상/한자어 페어', 1),
    (w2, w1, 'synonym', 'きつい(빡빡함)=大変だ(힘듦) - 일상/한자어 페어', 1);

  -- 페어 2: くたびれる ≒ つかれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'くたびれる', '지치다, 녹초가 되다', '구어적 표현. 「くたっとなる」(축 늘어지다) + びれる. 1그룹 동사', '유의 표현', 736, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '一日中歩いてくたびれた。', '하루 종일 걸어서 지쳤다.', 1),
    (w1, '残業でくたびれている。', '야근으로 지쳐 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '疲れる', 'つかれる', '피로하다, 피곤하다', '疲(피곤할 피): 疒(병)+皮(껍질) → 몸이 병난 듯. 2그룹 동사', '유의 표현', 737, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '今日はとても疲れた。', '오늘은 매우 피곤했다.', 1),
    (w2, '残業で疲れている。', '야근으로 피곤하다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'くたびれる(구어)=疲れる(표준) - 같은 「지친 상태」', 1),
    (w2, w1, 'synonym', 'くたびれる(구어)=疲れる(표준) - 같은 「지친 상태」', 1);

  -- 페어 3: 明ける ≒ おわる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '明ける', 'あける', '날이 새다, (기간이) 끝나다', '明(밝을 명): 日+月 → 해와 달의 빛=밝음. 자동사', '유의 표현', 738, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '夜が明けた。', '날이 밝았다.', 1),
    (w1, '休みが明けて学校が始まる。', '방학이 끝나고 학교가 시작된다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '終わる', 'おわる', '끝나다', '終(마칠 종): 糸(실)+冬(겨울) → 실이 마무리됨. 1그룹 자동사', '유의 표현', 739, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '会議が終わった。', '회의가 끝났다.', 1),
    (w2, '休みが終わって学校が始まる。', '방학이 끝나고 학교가 시작된다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '明ける(기간이 끝나 새 국면)=終わる(끝남)', 1),
    (w2, w1, 'synonym', '明ける(기간이 끝나 새 국면)=終わる(끝남)', 1);

  -- 페어 4: 混雑している ≒ 客がたくさんいる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '混雑している', 'こんざつしている', '혼잡하다', '混(섞을 혼)+雑(섞일 잡) → 여럿이 뒤섞임. する 동사+ている', '유의 표현', 740, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '駅は混雑している。', '역은 혼잡하다.', 1),
    (w1, 'お店が混雑していて入れなかった。', '가게가 혼잡해서 들어가지 못했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '客がたくさんいる', 'きゃくがたくさんいる', '손님이 많이 있다', '客(손 객)+が+たくさん(많이)+いる(있다). 사람 존재 동사', '유의 표현', 741, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'あの店は客がたくさんいる。', '저 가게는 손님이 많이 있다.', 1),
    (w2, '客がたくさんいて忙しい。', '손님이 많이 있어서 바쁘다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '混雑(혼잡)=손님/사람이 많이 있음', 1),
    (w2, w1, 'synonym', '混雑(혼잡)=손님/사람이 많이 있음', 1);

  -- 페어 5: わかりやすい ≒ 単純だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'わかりやすい', '알기 쉽다, 이해하기 쉽다', '分かる(이해되다)+「~やすい」=~하기 쉽다. い형용사', '유의 표현', 742, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '先生の説明はわかりやすい。', '선생님의 설명은 알기 쉽다.', 1),
    (w1, 'この本はわかりやすい。', '이 책은 이해하기 쉽다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '単純だ', 'たんじゅんだ', '단순하다', '単(홑 단)+純(순수 순) → 섞이지 않고 간단함. な형용사', '유의 표현', 743, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '答えは単純だ。', '답은 단순하다.', 1),
    (w2, '単純な構造でわかりやすい。', '단순한 구조라 알기 쉽다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'わかりやすい(이해하기 쉬움)=単純(간단함)', 1),
    (w2, w1, 'synonym', 'わかりやすい(이해하기 쉬움)=単純(간단함)', 1);

  -- 페어 6: まご ≒ 娘の息子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '孫', 'まご', '손자, 손주', '孫(손자 손): 子(아들)+系(이음) → 자식의 자식', '유의 표현', 744, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '孫が生まれた。', '손주가 태어났다.', 1),
    (w1, '孫と公園で遊んだ。', '손주와 공원에서 놀았다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '娘の息子', 'むすめのむすこ', '딸의 아들', '娘(여자 낭, 딸)+の+息子(아들). 분석적 표현', '유의 표현', 745, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '娘の息子は5歳だ。', '딸의 아들은 5살이다.', 1),
    (w2, '娘の息子と一緒に住んでいる。', '딸의 아들과 같이 살고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '孫=자식의 자식 → 娘(딸)의 息子(아들)이면 손자', 1),
    (w2, w1, 'synonym', '孫=자식의 자식 → 娘(딸)의 息子(아들)이면 손자', 1);

  -- 페어 7: たまる ≒ たくさん残る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'たまる', '쌓이다, 모이다', '溜まる(たまる): 액체·물건·일이 한 곳에 모임. 자동사', '유의 표현', 746, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '仕事がたまっている。', '일이 쌓여 있다.', 1),
    (w1, 'お金が少しずつたまった。', '돈이 조금씩 모였다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'たくさん残る', 'たくさんのこる', '많이 남다', '残(남을 잔): 歹(뼈)+戔(겹침) → 남음. 「たくさん+残る」', '유의 표현', 747, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '料理がたくさん残った。', '요리가 많이 남았다.', 1),
    (w2, '仕事がたくさん残っている。', '일이 많이 남아 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'たまる(쌓임)=たくさん残る(많이 남음)', 1),
    (w2, w1, 'synonym', 'たまる(쌓임)=たくさん残る(많이 남음)', 1);

  -- 페어 8: 短気だ ≒ すぐ怒る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '短気だ', 'たんきだ', '성미가 급하다', '短(짧을 단)+気(기 기) → 기(인내)가 짧음. な형용사', '유의 표현', 748, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '彼は短気だ。', '그는 성미가 급하다.', 1),
    (w1, '短気な人は損をする。', '성미 급한 사람은 손해를 본다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'すぐ怒る', 'すぐおこる', '바로 화를 내다', 'すぐ(바로/곧)+怒(노할 노)る. 「조건 자극 → 즉시 화남」', '유의 표현', 749, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '彼はすぐ怒る。', '그는 바로 화를 낸다.', 1),
    (w2, '小さなことですぐ怒る人だ。', '작은 일에도 바로 화내는 사람이다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '短気(성미 급함)=すぐ怒る(바로 화냄)', 1),
    (w2, w1, 'synonym', '短気(성미 급함)=すぐ怒る(바로 화냄)', 1);

  -- 페어 9: 暗記する ≒ 覚える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '暗記する', 'あんきする', '암기하다', '暗(어두울 암)+記(기록할 기) → 글을 보지 않고 외움. する 동사', '유의 표현', 750, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '単語を暗記する。', '단어를 암기한다.', 1),
    (w1, '答えを暗記してテストに臨んだ。', '답을 암기하고 시험에 임했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '覚える', 'おぼえる', '외우다, 기억하다', '覚(깨달을 각): 잠에서 깸 → 인식·기억. 2그룹 동사', '유의 표현', 751, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '名前を覚える。', '이름을 외운다.', 1),
    (w2, '昨日のことをよく覚えている。', '어제 일을 잘 기억하고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '暗記する(암기)=覚える(외움)', 1),
    (w2, w1, 'synonym', '暗記する(암기)=覚える(외움)', 1);

  -- 페어 10: きまり ≒ 規則
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'きまり', '규칙, 정해진 것', '決まり: 決まる(정해지다)의 명사형. 일상적 표현', '유의 표현', 752, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '学校のきまりを守る。', '학교 규칙을 지킨다.', 1),
    (w1, 'きまりは大切だ。', '규칙은 중요하다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '規則', 'きそく', '규칙', '規(법 규)+則(법칙 칙) → 정한 법. 격식 있는 한자어', '유의 표현', 753, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '会社の規則を守る。', '회사 규칙을 지킨다.', 1),
    (w2, '規則違反は許されない。', '규칙 위반은 용서되지 않는다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'きまり(일상)=規則(한자어)', 1),
    (w2, w1, 'synonym', 'きまり(일상)=規則(한자어)', 1);

  -- 페어 11: 通勤する ≒ 仕事に行く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '通勤する', 'つうきんする', '통근하다', '通(통할 통)+勤(근무 근) → 근무지에 다님. する 동사', '유의 표현', 754, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '電車で通勤する。', '전철로 통근한다.', 1),
    (w1, '毎日1時間通勤している。', '매일 1시간 통근하고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '仕事に行く', 'しごとにいく', '일하러 가다', '仕事(일)+に(목적)+行く(가다). 「~に行く」 목적 표현', '유의 표현', 755, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '朝、仕事に行く。', '아침에 일하러 간다.', 1),
    (w2, '電車で仕事に行きます。', '전철로 일하러 갑니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '通勤する(한자어)=仕事に行く(풀어 쓴 표현)', 1),
    (w2, w1, 'synonym', '通勤する(한자어)=仕事に行く(풀어 쓴 표현)', 1);

  -- 페어 12: おそろしい ≒ こわい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'おそろしい', '무섭다, 두렵다', '恐ろしい(おそろしい): 恐(두려울 공)+しい. い형용사 (다소 격식)', '유의 표현', 756, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おそろしい話を聞いた。', '무서운 이야기를 들었다.', 1),
    (w1, '夜の山はおそろしい。', '밤의 산은 무섭다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'こわい', '무섭다', '怖い(こわい): 일상적 표현. い형용사', '유의 표현', 757, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'お化けがこわい。', '귀신이 무섭다.', 1),
    (w2, 'こわい夢を見た。', '무서운 꿈을 꿨다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'おそろしい(격식)=こわい(일상)', 1),
    (w2, w1, 'synonym', 'おそろしい(격식)=こわい(일상)', 1);

  -- 페어 13: わけ ≒ 理由
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'わけ', '이유, 까닭', '訳(わけ): 「말의 의미·이유」. 일상적 표현', '유의 표현', 758, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'そのわけを教えて。', '그 이유를 알려줘.', 1),
    (w1, '遅れたわけを話す。', '늦은 이유를 말한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '理由', 'りゆう', '이유', '理(이치 리)+由(말미암을 유) → 일이 일어난 까닭. 한자어', '유의 표현', 759, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '欠席の理由を書く。', '결석 이유를 적는다.', 1),
    (w2, '理由を聞かせてください。', '이유를 들려주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'わけ(일상)=理由(한자어)', 1),
    (w2, w1, 'synonym', 'わけ(일상)=理由(한자어)', 1);

  -- 페어 14: 減る ≒ 少なくなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '減る', 'へる', '줄어들다', '減(덜 감): 水(물)+咸(다 함) → 양이 빠짐. 자동사', '유의 표현', 760, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '人口が減っている。', '인구가 줄어들고 있다.', 1),
    (w1, '体重が3キロ減った。', '체중이 3kg 줄었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '少なくなる', 'すくなくなる', '적어지다', '少(적을 소)ない+「くなる」=~게 되다. 변화 표현', '유의 표현', 761, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '子どもが少なくなる。', '아이가 적어진다.', 1),
    (w2, '貯金が少なくなった。', '저축이 적어졌다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '減る(줄다)=少なくなる(적어짐)', 1),
    (w2, w1, 'synonym', '減る(줄다)=少なくなる(적어짐)', 1);

  -- 페어 15: やり直す ≒ もう一度やる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'やり直す', 'やりなおす', '다시 하다', 'やる(하다)+直(곧을 직)す=고치다 → 다시 함. 복합동사', '유의 표현', 762, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'もう一度やり直す。', '다시 한 번 한다.', 1),
    (w1, '間違えたのでやり直した。', '틀렸으니 다시 했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'もう一度やる', 'もういちどやる', '한 번 더 하다', 'もう(더)+一度(한 번)+やる(하다). 재시도 표현', '유의 표현', 763, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'もう一度やってみる。', '한 번 더 해 본다.', 1),
    (w2, 'もう一度やる気力がない。', '한 번 더 할 기력이 없다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'やり直す=もう一度やる', 1),
    (w2, w1, 'synonym', 'やり直す=もう一度やる', 1);

  -- 페어 16: 欠点 ≒ 悪いところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '欠点', 'けってん', '결점, 단점', '欠(이지러질 결)+点(점 점) → 모자라는 점. 한자어', '유의 표현', 764, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '彼の欠点はせっかちなところだ。', '그의 결점은 성급한 점이다.', 1),
    (w1, '誰にでも欠点がある。', '누구에게나 단점이 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '悪いところ', 'わるいところ', '나쁜 점', '悪(악할 악)い+ところ(곳/점). 분석적 표현', '유의 표현', 765, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '彼の悪いところを直す。', '그의 나쁜 점을 고친다.', 1),
    (w2, '自分の悪いところを知る。', '자신의 나쁜 점을 안다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '欠点(한자어)=悪いところ(풀어 쓴 표현)', 1),
    (w2, w1, 'synonym', '欠点(한자어)=悪いところ(풀어 쓴 표현)', 1);

  -- 페어 17: 翌年 ≒ 次の年
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '翌年', 'よくとし', '이듬해', '翌(다음날 익)+年(해 년) → 다음 해. 한자어', '유의 표현', 766, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '翌年に転職した。', '이듬해에 이직했다.', 1),
    (w1, '翌年から新しい仕事を始めた。', '이듬해부터 새 일을 시작했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '次の年', 'つぎのとし', '다음 해', '次(다음 차)+の+年(해). 분석적 표현', '유의 표현', 767, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '次の年に結婚した。', '다음 해에 결혼했다.', 1),
    (w2, '次の年は忙しかった。', '다음 해는 바빴다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '翌年(한자어)=次の年(풀어 쓴 표현)', 1),
    (w2, w1, 'synonym', '翌年(한자어)=次の年(풀어 쓴 표현)', 1);

  -- 페어 18: スケジュール ≒ 予定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'スケジュール', '스케줄, 일정', '영어 schedule 외래어. 일상적 표현', '유의 표현', 768, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '今週のスケジュールを確認する。', '이번 주 스케줄을 확인한다.', 1),
    (w1, 'スケジュールが詰まっている。', '스케줄이 꽉 차 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '予定', 'よてい', '예정', '予(미리 예)+定(정할 정) → 미리 정함. 한자어', '유의 표현', 769, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '明日の予定を立てる。', '내일의 예정을 세운다.', 1),
    (w2, '予定通り進める。', '예정대로 진행한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'スケジュール(외래어)=予定(한자어)', 1),
    (w2, w1, 'synonym', 'スケジュール(외래어)=予定(한자어)', 1);

  -- 페어 19: らくな ≒ かんたんな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'らくな', '편한, 수월한', '楽(らく): 「수고가 적음」. な형용사', '유의 표현', 770, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'らくな仕事を選ぶ。', '편한 일을 고른다.', 1),
    (w1, 'らくな姿勢で座る。', '편한 자세로 앉는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'かんたんな', '간단한', '簡(대쪽 간)+単(홑 단) → 간략함. な형용사', '유의 표현', 771, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'かんたんな問題だ。', '간단한 문제다.', 1),
    (w2, 'かんたんな料理を作る。', '간단한 요리를 만든다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'らく(편함)=かんたん(간단함) - 부담이 적음', 1),
    (w2, w1, 'synonym', 'らく(편함)=かんたん(간단함) - 부담이 적음', 1);

  -- 페어 20: さっき ≒ 少し前に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'さっき', '아까, 조금 전에', '先っき(さっき): 先(앞)+っき → 조금 전. 구어 부사', '유의 표현', 772, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'さっき電話があった。', '아까 전화가 왔다.', 1),
    (w1, 'さっきまでここにいた。', '조금 전까지 여기에 있었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '少し前に', 'すこしまえに', '조금 전에', '少(적을 소)し+前(앞 전)+に. 분석적 시점 표현', '유의 표현', 773, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '少し前に出かけた。', '조금 전에 외출했다.', 1),
    (w2, '少し前に会いました。', '조금 전에 만났습니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'さっき(구어)=少し前に(분석적)', 1),
    (w2, w1, 'synonym', 'さっき(구어)=少し前に(분석적)', 1);

  -- 페어 21: 共通点 ≒ 同じところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '共通点', 'きょうつうてん', '공통점', '共(함께 공)+通(통할 통)+点(점) → 모두에게 통하는 점', '유의 표현', 774, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '二人の共通点を探す。', '두 사람의 공통점을 찾는다.', 1),
    (w1, '共通点が多い友人だ。', '공통점이 많은 친구다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '同じところ', 'おなじところ', '같은 점', '同(같을 동)じ+ところ(점). 분석적 표현', '유의 표현', 775, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '私と彼の同じところを話した。', '나와 그의 같은 점을 이야기했다.', 1),
    (w2, '同じところがたくさんある。', '같은 점이 많이 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '共通点(한자어)=同じところ(풀어 쓴 표현)', 1),
    (w2, w1, 'synonym', '共通点(한자어)=同じところ(풀어 쓴 표현)', 1);

  -- 페어 22: 整理する ≒ 片付ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '整理する', 'せいりする', '정리하다', '整(가지런할 정)+理(다스릴 리) → 가지런히 다스림. する 동사', '유의 표현', 776, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '机を整理する。', '책상을 정리한다.', 1),
    (w1, '資料を整理した。', '자료를 정리했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '片付ける', 'かたづける', '치우다, 정리하다', '片(조각 편)+付(붙을 부) → 한쪽으로 모음. 2그룹', '유의 표현', 777, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋を片付ける。', '방을 치운다.', 1),
    (w2, '食器を片付けた。', '식기를 정리했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '整理する(한자어)=片付ける(고유어)', 1),
    (w2, w1, 'synonym', '整理する(한자어)=片付ける(고유어)', 1);

  -- 페어 23: ぜったいに ≒ かならず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '絶対に', 'ぜったいに', '절대로', '絶(끊을 절)+対(대할 대) → 비교 대상이 없음. 「~に」 부사', '유의 표현', 778, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ぜったいに勝つ。', '절대로 이긴다.', 1),
    (w1, 'ぜったいに来てください。', '절대로 와 주세요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '必ず', 'かならず', '반드시', '必(반드시 필) → 꼭. 「~ず」 부사형', '유의 표현', 779, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'かならず来てください。', '반드시 와 주세요.', 1),
    (w2, 'かならず約束を守る。', '반드시 약속을 지킨다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '絶対に(절대)=必ず(반드시) - 강한 단정', 1),
    (w2, w1, 'synonym', '絶対に(절대)=必ず(반드시) - 강한 단정', 1);

  -- 페어 24: ないしょにする ≒ だれにも話さない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'ないしょにする', 'ないしょにする', '비밀로 하다', '内緒(ないしょ): 内(안)+緒(시작) → 안쪽 일=비밀. 「~にする」', '유의 표현', 780, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'この話はないしょにする。', '이 이야기는 비밀로 한다.', 1),
    (w1, '家族にもないしょにしている。', '가족에게도 비밀로 하고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'だれにも話さない', 'だれにもはなさない', '누구에게도 이야기하지 않는다', '誰(누구)+にも(에게도)+話す의 부정형. 강조 부정', '유의 표현', 781, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'だれにも話さないで。', '아무에게도 말하지 마.', 1),
    (w2, 'この秘密はだれにも話さない。', '이 비밀은 누구에게도 말하지 않는다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'ないしょにする=だれにも話さない (비밀 유지)', 1),
    (w2, w1, 'synonym', 'ないしょにする=だれにも話さない (비밀 유지)', 1);

  -- 페어 25: 気に入っている ≒ すきだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '気に入っている', 'きにいっている', '마음에 들어하다', '気(마음)+に+入る(들다)+ている(상태). 관용 표현', '유의 표현', 782, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'このかばんが気に入っている。', '이 가방이 마음에 든다.', 1),
    (w1, '彼は新しい仕事を気に入っている。', '그는 새 일을 마음에 들어 한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'すきだ', 'すきだ', '좋아하다', '好(좋을 호)き: 「좋아함」. な형용사', '유의 표현', 783, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'りんごが好きだ。', '사과를 좋아한다.', 1),
    (w2, '彼は音楽が好きだ。', '그는 음악을 좋아한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '気に入っている(마음에 듦)=好きだ(좋아함)', 1),
    (w2, w1, 'synonym', '気に入っている(마음에 듦)=好きだ(좋아함)', 1);

  -- 페어 26: やめる ≒ あきらめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'やめる', '그만두다, 멈추다', '止める(やめる): 행동·습관·일을 중단. 2그룹', '유의 표현', 784, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'タバコをやめる。', '담배를 끊다.', 1),
    (w1, '会社をやめた。', '회사를 그만뒀다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '諦める', 'あきらめる', '포기하다, 단념하다', '諦(살필 체) → 진실을 밝혀 단념함. 2그룹', '유의 표현', 785, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '夢をあきらめた。', '꿈을 포기했다.', 1),
    (w2, '無理だからあきらめる。', '무리라서 포기한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'やめる(중단)=あきらめる(단념) - 행동/의지 포기', 1),
    (w2, w1, 'synonym', 'やめる(중단)=あきらめる(단념) - 행동/의지 포기', 1);

  -- 페어 27: 年中 ≒ いつも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '年中', 'ねんじゅう', '일 년 내내, 늘', '年(해 년)+中(가운데 중) → 한 해 안. 부사적 명사', '유의 표현', 786, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '年中無休のお店だ。', '연중무휴인 가게다.', 1),
    (w1, '彼は年中忙しい。', '그는 일 년 내내 바쁘다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'いつも', '항상, 늘', '何時も(いつも): 어떤 때든. 부사', '유의 표현', 787, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'いつも元気だ。', '항상 건강하다.', 1),
    (w2, 'いつも忙しい。', '항상 바쁘다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '年中(한자어)=いつも(고유어) - 늘/항상', 1),
    (w2, w1, 'synonym', '年中(한자어)=いつも(고유어) - 늘/항상', 1);

  -- 페어 28: うばう ≒ 取る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'うばう', '빼앗다', '奪う(うばう): 强奪(강탈)에서 → 무리하게 빼앗음. 1그룹', '유의 표현', 788, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'お金をうばわれた。', '돈을 빼앗겼다.', 1),
    (w1, '心をうばう美しさだ。', '마음을 빼앗는 아름다움이다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '取る', 'とる', '잡다, 빼앗다, 가지다', '取(가질 취): 손(又)이 귀(耳)를 잡음. 1그룹', '유의 표현', 789, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '本を取る。', '책을 잡는다.', 1),
    (w2, '財布を取られた。', '지갑을 빼앗겼다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'うばう(빼앗음)=取る(가짐/빼앗음)', 1),
    (w2, w1, 'synonym', 'うばう(빼앗음)=取る(가짐/빼앗음)', 1);

  -- 페어 29: そっと ≒ 静かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'そっと', '살짝, 가만히', '의태어. 「소리·움직임을 최소로」. 부사', '유의 표현', 790, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ドアをそっと開ける。', '문을 살짝 연다.', 1),
    (w1, '赤ちゃんをそっと抱いた。', '아기를 가만히 안았다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '静かに', 'しずかに', '조용히', '静(고요할 정)か+「に」 부사형. な형용사 부사화', '유의 표현', 791, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '静かに話す。', '조용히 말한다.', 1),
    (w2, '図書館で静かにする。', '도서관에서 조용히 한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'そっと(살짝)=静かに(조용히)', 1),
    (w2, w1, 'synonym', 'そっと(살짝)=静かに(조용히)', 1);

  -- 페어 30: まぶしい ≒ 明るすぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'まぶしい', '눈부시다', '眩しい(まぶしい): 눈이 부심. い형용사', '유의 표현', 792, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '太陽がまぶしい。', '태양이 눈부시다.', 1),
    (w1, 'ライトがまぶしくて見えない。', '조명이 눈부셔서 보이지 않는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '明るすぎる', 'あかるすぎる', '너무 밝다', '明るい+「~すぎる」=지나치게 ~하다. 정도 초과', '유의 표현', 793, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋が明るすぎる。', '방이 너무 밝다.', 1),
    (w2, 'この画面は明るすぎる。', '이 화면은 너무 밝다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'まぶしい(눈부심)=明るすぎる(지나치게 밝음)', 1),
    (w2, w1, 'synonym', 'まぶしい(눈부심)=明るすぎる(지나치게 밝음)', 1);

  -- 페어 31: サイズ ≒ 大きさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'サイズ', '사이즈, 크기', '영어 size 외래어. 일상적', '유의 표현', 794, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '靴のサイズを測る。', '신발 사이즈를 잰다.', 1),
    (w1, 'Mサイズをください。', 'M 사이즈 주세요.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '大きさ', 'おおきさ', '크기', '大きい(크다)+さ(명사화) → 정도/크기', '유의 표현', 795, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '部屋の大きさを測る。', '방의 크기를 잰다.', 1),
    (w2, 'カバンの大きさを比べる。', '가방 크기를 비교한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'サイズ(외래어)=大きさ(고유어)', 1),
    (w2, w1, 'synonym', 'サイズ(외래어)=大きさ(고유어)', 1);

  -- 페어 32: 注文する ≒ 頼む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '注文する', 'ちゅうもんする', '주문하다', '注(부을 주)+文(글 문) → 글로 부탁=주문. する 동사', '유의 표현', 796, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ラーメンを注文する。', '라면을 주문한다.', 1),
    (w1, 'ネットで本を注文した。', '인터넷으로 책을 주문했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '頼む', 'たのむ', '부탁하다, 주문하다', '頼(부탁 뢰): 의지하고 부탁함. 1그룹', '유의 표현', 797, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '友だちに頼む。', '친구에게 부탁한다.', 1),
    (w2, 'コーヒーを頼んだ。', '커피를 주문했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '注文する(한자어, 가게)=頼む(고유어, 일반 부탁/주문)', 1),
    (w2, w1, 'synonym', '注文する(한자어, 가게)=頼む(고유어, 일반 부탁/주문)', 1);

  -- 페어 33: たしかめる ≒ チェックする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '確かめる', 'たしかめる', '확인하다', '確(굳을 확)か+める → 확실히 하다. 2그룹', '유의 표현', 798, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '答えを確かめる。', '답을 확인한다.', 1),
    (w1, '予定を確かめた。', '예정을 확인했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'チェックする', '체크하다, 확인하다', '영어 check+する. 외래어 동사', '유의 표현', 799, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'メールをチェックする。', '메일을 체크한다.', 1),
    (w2, 'リストをチェックした。', '리스트를 체크했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '確かめる(고유어)=チェックする(외래어)', 1),
    (w2, w1, 'synonym', '確かめる(고유어)=チェックする(외래어)', 1);

  -- 페어 34: このごろ ≒ さいきん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'このごろ', '요즈음', 'この+頃(ごろ, 무렵) → 지금 즈음. 부사적 명사', '유의 표현', 800, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'このごろ忙しい。', '요즘 바쁘다.', 1),
    (w1, 'このごろよく雨が降る。', '요즘 자주 비가 내린다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '最近', 'さいきん', '최근, 요즘', '最(가장 최)+近(가까울 근) → 가장 가까운 시점. 한자어', '유의 표현', 801, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '最近忙しい。', '최근 바쁘다.', 1),
    (w2, '最近よく勉強している。', '최근 자주 공부하고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'このごろ(일상)=最近(한자어)', 1),
    (w2, w1, 'synonym', 'このごろ(일상)=最近(한자어)', 1);

  -- 페어 35: しゃべる ≒ 話す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'しゃべる', '수다 떨다, 말하다', '喋る(しゃべる): 가볍게 말함. 구어 1그룹', '유의 표현', 802, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '友だちとしゃべる。', '친구와 수다 떤다.', 1),
    (w1, 'ずっとしゃべっていた。', '계속 수다 떨고 있었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '話す', 'はなす', '이야기하다', '話(말씀 화): 言(말)+舌(혀) → 말함. 1그룹', '유의 표현', 803, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '日本語で話す。', '일본어로 말한다.', 1),
    (w2, '先生と話した。', '선생님과 이야기했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'しゃべる(구어)=話す(표준)', 1),
    (w2, w1, 'synonym', 'しゃべる(구어)=話す(표준)', 1);

  -- 페어 36: キッチン ≒ 台所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'キッチン', '키친, 부엌', '영어 kitchen 외래어', '유의 표현', 804, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'キッチンで料理する。', '키친에서 요리한다.', 1),
    (w1, '新しいキッチンを買った。', '새 키친(부엌 가구)을 샀다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '台所', 'だいどころ', '부엌', '台(돈대 대)+所(곳 소) → 음식 놓는 곳', '유의 표현', 805, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '母は台所にいる。', '어머니는 부엌에 있다.', 1),
    (w2, '台所を掃除する。', '부엌을 청소한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'キッチン(외래어)=台所(고유어)', 1),
    (w2, w1, 'synonym', 'キッチン(외래어)=台所(고유어)', 1);

  -- 페어 37: 位置 ≒ 場所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '位置', 'いち', '위치', '位(자리 위)+置(둘 치) → 놓인 자리. 한자어', '유의 표현', 806, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '机の位置を変える。', '책상의 위치를 바꾼다.', 1),
    (w1, '店の位置がわからない。', '가게의 위치를 모르겠다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '場所', 'ばしょ', '장소', '場(마당 장)+所(곳 소) → 어떤 곳. 한자어', '유의 표현', 807, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '会う場所を決める。', '만날 장소를 정한다.', 1),
    (w2, 'いい場所を見つけた。', '좋은 장소를 발견했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '位置(놓인 자리)=場所(장소)', 1),
    (w2, w1, 'synonym', '位置(놓인 자리)=場所(장소)', 1);

  -- 페어 38: 売り切れる ≒ 全部売れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '売り切れる', 'うりきれる', '매진되다, 다 팔리다', '売る(팔다)+切れる(끝나다) → 다 팔려 끝남. 2그룹', '유의 표현', 808, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'チケットが売り切れた。', '티켓이 매진됐다.', 1),
    (w1, 'すぐに売り切れる人気商品。', '곧 매진되는 인기 상품.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '全部売れる', 'ぜんぶうれる', '전부 팔리다', '全部(전부)+売れる(팔리다). 자동사', '유의 표현', 809, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '商品が全部売れた。', '상품이 전부 팔렸다.', 1),
    (w2, '今日も全部売れた。', '오늘도 전부 팔렸다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '売り切れる(매진)=全部売れる(전부 팔림)', 1),
    (w2, w1, 'synonym', '売り切れる(매진)=全部売れる(전부 팔림)', 1);

  -- 페어 39: 回収する ≒ あつめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '回収する', 'かいしゅうする', '회수하다', '回(돌 회)+収(거둘 수) → 돌려받음. する 동사', '유의 표현', 810, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'アンケートを回収する。', '설문지를 회수한다.', 1),
    (w1, 'ゴミを回収した。', '쓰레기를 회수했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '集める', 'あつめる', '모으다', '集(모일 집): 새(隹)들이 나무(木) 위에 모임. 2그룹', '유의 표현', 811, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '切手を集める。', '우표를 모은다.', 1),
    (w2, 'お金を集めて募金した。', '돈을 모아 모금했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '回収する(회수)=集める(모음)', 1),
    (w2, w1, 'synonym', '回収する(회수)=集める(모음)', 1);

  -- 페어 40: おかしな ≒ 変な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'おかしな', '이상한, 우스운', '可笑しい(おかしい)의 연체형. な형용사적 사용', '유의 표현', 812, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'おかしな話を聞いた。', '이상한 이야기를 들었다.', 1),
    (w1, 'おかしな夢を見た。', '이상한 꿈을 꿨다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '変な', 'へんな', '이상한', '変(변할 변) → 평소와 다름. な형용사', '유의 표현', 813, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '変な音がする。', '이상한 소리가 난다.', 1),
    (w2, '変な人だ。', '이상한 사람이다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'おかしな(우스운/이상한)=変な(이상한)', 1),
    (w2, w1, 'synonym', 'おかしな(우스운/이상한)=変な(이상한)', 1);

  -- 페어 41: 経つ ≒ 過ぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '経つ', 'たつ', '(시간이) 지나다, 경과하다', '経(지날 경): 시간/세월이 흐름. 1그룹 자동사', '유의 표현', 814, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '10年が経った。', '10년이 지났다.', 1),
    (w1, '時間が経つのは早い。', '시간이 지나는 것은 빠르다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '過ぎる', 'すぎる', '지나다, 통과하다', '過(지날 과): 시간·장소·정도가 지나감. 2그룹', '유의 표현', 815, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '5時を過ぎた。', '5시가 지났다.', 1),
    (w2, '駅を過ぎたら左へ。', '역을 지나면 왼쪽으로.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '経つ(경과)=過ぎる(지나감)', 1),
    (w2, w1, 'synonym', '経つ(경과)=過ぎる(지나감)', 1);

  -- 페어 42: あわてて ≒ 急いだようすで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あわてて', '허둥대며, 황급하게', '慌てる(あわてる)의 て형 부사 용법', '유의 표현', 816, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'あわてて家を出た。', '허둥대며 집을 나섰다.', 1),
    (w1, 'あわてて電話に出る。', '황급하게 전화를 받는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '急いだようすで', 'いそいだようすで', '서두르는 모습으로', '急ぐ(서두르다)+ようす(모습)+で. 분석적 표현', '유의 표현', 817, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '急いだようすで歩いている。', '서두르는 모습으로 걷고 있다.', 1),
    (w2, '急いだようすで部屋に入った。', '서두르는 모습으로 방에 들어갔다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'あわてて(허둥대며)=急いだようすで(서두르는 모습으로)', 1),
    (w2, w1, 'synonym', 'あわてて(허둥대며)=急いだようすで(서두르는 모습으로)', 1);

  -- 페어 43: カーブしている ≒ 曲がっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'カーブしている', '굽어 있다, 곡선이다', '영어 curve+する+ている(상태). 외래어 동사', '유의 표현', 818, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '道がカーブしている。', '길이 굽어 있다.', 1),
    (w1, '線路が大きくカーブしている。', '선로가 크게 굽어 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '曲がっている', 'まがっている', '굽어 있다', '曲(굽을 곡)+がる(자동사)+ている. 결과 상태', '유의 표현', 819, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '道が曲がっている。', '길이 굽어 있다.', 1),
    (w2, '釘が曲がっている。', '못이 굽어 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'カーブしている(외래어)=曲がっている(고유어)', 1),
    (w2, w1, 'synonym', 'カーブしている(외래어)=曲がっている(고유어)', 1);

  -- 페어 44: 案 ≒ アイデア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '案', 'あん', '안, 방안', '案(생각 안): 떠올린 생각/제안', '유의 표현', 820, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'いい案がある。', '좋은 안이 있다.', 1),
    (w1, '会議で案を出す。', '회의에서 안을 낸다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'アイデア', '아이디어', '영어 idea 외래어', '유의 표현', 821, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'いいアイデアが浮かんだ。', '좋은 아이디어가 떠올랐다.', 1),
    (w2, 'アイデアを共有する。', '아이디어를 공유한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '案(한자어)=アイデア(외래어)', 1),
    (w2, w1, 'synonym', '案(한자어)=アイデア(외래어)', 1);

  -- 페어 45: 約 ≒ だいたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '約', 'やく', '약, 대략', '約(맺을 약): 「대략」 부사. 수량 앞에 붙음', '유의 표현', 822, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '約100人が参加した。', '약 100명이 참가했다.', 1),
    (w1, '駅から約5分です。', '역에서 약 5분입니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'だいたい', '대략, 대체로', '大体(だいたい): 大(큰)+体(몸/대강). 부사', '유의 표현', 823, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'だいたい100人くらい。', '대략 100명 정도.', 1),
    (w2, 'だいたい分かった。', '대체로 알았다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '約(한자어)=だいたい(고유어)', 1),
    (w2, w1, 'synonym', '約(한자어)=だいたい(고유어)', 1);

  -- 페어 46: 指導する ≒ 教える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '指導する', 'しどうする', '지도하다', '指(가리킬 지)+導(이끌 도) → 방향을 가리켜 이끎. する 동사', '유의 표현', 824, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '学生を指導する。', '학생을 지도한다.', 1),
    (w1, '熱心に指導してくれた。', '열심히 지도해 주었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '教える', 'おしえる', '가르치다', '教(가르칠 교): 子(아이)+爻(본받기) → 가르침. 2그룹', '유의 표현', 825, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '日本語を教える。', '일본어를 가르친다.', 1),
    (w2, '道を教えてください。', '길을 가르쳐 주세요.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '指導する(한자어)=教える(고유어)', 1),
    (w2, w1, 'synonym', '指導する(한자어)=教える(고유어)', 1);

  -- 페어 47: すべて ≒ 全部
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'すべて', '모두, 전부', '全て(すべて): 「전체」. 부사·명사', '유의 표현', 826, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'すべてを話す。', '모두 이야기한다.', 1),
    (w1, 'すべて忘れた。', '전부 잊었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '全部', 'ぜんぶ', '전부, 모두', '全(온전 전)+部(부 부) → 모든 부분', '유의 표현', 827, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '全部食べる。', '전부 먹는다.', 1),
    (w2, '全部覚えた。', '전부 외웠다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'すべて(고유어)=全部(한자어)', 1),
    (w2, w1, 'synonym', 'すべて(고유어)=全部(한자어)', 1);

  -- 페어 48: 手段 ≒ やり方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '手段', 'しゅだん', '수단, 방법', '手(손 수)+段(층계 단) → 일을 처리하는 단계/방법. 한자어', '유의 표현', 828, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '交通手段を考える。', '교통수단을 생각한다.', 1),
    (w1, '解決の手段を探す。', '해결의 수단을 찾는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'やり方', 'やりかた', '방식, 방법', 'やる(하다)+方(방법). 일상적 표현', '유의 표현', 829, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'やり方を教える。', '방법을 가르친다.', 1),
    (w2, '新しいやり方を試す。', '새 방식을 시도한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '手段(한자어)=やり方(고유어)', 1),
    (w2, w1, 'synonym', '手段(한자어)=やり方(고유어)', 1);

  -- 페어 49: 配達する ≒ 届ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '配達する', 'はいたつする', '배달하다', '配(나눌 배)+達(이를 달) → 나눠 전달. する 동사', '유의 표현', 830, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '荷物を配達する。', '짐을 배달한다.', 1),
    (w1, '新聞を配達している。', '신문을 배달하고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '届ける', 'とどける', '전달하다, 신고하다', '届(이를 계): 도착하게 함. 2그룹 타동사', '유의 표현', 831, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '手紙を届ける。', '편지를 전달한다.', 1),
    (w2, 'プレゼントを家まで届けた。', '선물을 집까지 전달했다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '配達する(전문 한자어)=届ける(고유어)', 1),
    (w2, w1, 'synonym', '配達する(전문 한자어)=届ける(고유어)', 1);

  -- 페어 50: 黙って ≒ 何も言わずに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '黙って', 'だまって', '아무 말 없이', '黙(잠잠 묵)る(잠잠하다)의 て형. 부사적 용법', '유의 표현', 832, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '黙って聞いていた。', '아무 말 없이 듣고 있었다.', 1),
    (w1, '黙ってうなずいた。', '말없이 끄덕였다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '何も言わずに', 'なにもいわずに', '아무 말 없이', '何も(아무것도)+言わずに(말하지 않고). 분석적', '유의 표현', 833, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '何も言わずに帰った。', '아무 말 없이 돌아갔다.', 1),
    (w2, '何も言わずに席を立った。', '아무 말 없이 자리에서 일어났다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '黙って(잠잠히)=何も言わずに(아무 말 없이)', 1),
    (w2, w1, 'synonym', '黙って(잠잠히)=何も言わずに(아무 말 없이)', 1);

  -- 페어 51: 次第に ≒ 少しずつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '次第に', 'しだいに', '점차, 점점', '次(다음 차)+第(차례 제) → 차례차례. 부사', '유의 표현', 834, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '次第に寒くなる。', '점차 추워진다.', 1),
    (w1, '次第に明るくなった。', '점점 밝아졌다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '少しずつ', 'すこしずつ', '조금씩', '少し(조금)+ずつ(씩). 점진적 분량', '유의 표현', 835, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '少しずつ進める。', '조금씩 진행한다.', 1),
    (w2, '貯金が少しずつ増えた。', '저축이 조금씩 늘었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '次第に(점차)=少しずつ(조금씩)', 1),
    (w2, w1, 'synonym', '次第に(점차)=少しずつ(조금씩)', 1);

  -- 페어 52: 得意な ≒ 上手にできる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '得意な', 'とくいな', '잘하는, 자신 있는', '得(얻을 득)+意(뜻 의) → 뜻을 이룸=잘함. な형용사', '유의 표현', 836, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '料理が得意だ。', '요리를 잘한다.', 1),
    (w1, '得意な科目は数学だ。', '잘하는 과목은 수학이다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '上手にできる', 'じょうずにできる', '능숙하게 할 수 있다', '上手(능숙)+に+できる(할 수 있다). 가능 표현', '유의 표현', 837, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '料理が上手にできる。', '요리를 능숙하게 할 수 있다.', 1),
    (w2, '日本語が上手にできる。', '일본어를 능숙하게 할 수 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '得意(잘함)=上手にできる(능숙하게 할 수 있음)', 1),
    (w2, w1, 'synonym', '得意(잘함)=上手にできる(능숙하게 할 수 있음)', 1);

  -- 페어 53: 疑う ≒ 本当ではないと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '疑う', 'うたがう', '의심하다', '疑(의심 의): 머뭇거리는 사람의 모습. 1그룹', '유의 표현', 838, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '彼の話を疑う。', '그의 이야기를 의심한다.', 1),
    (w1, '事実を疑った。', '사실을 의심했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '本当ではないと思う', 'ほんとうではないとおもう', '사실이 아니라고 생각하다', '本当(사실)+ではない(부정)+と思う(라고 생각하다)', '유의 표현', 839, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'その話は本当ではないと思う。', '그 이야기는 사실이 아니라고 생각한다.', 1),
    (w2, '彼の言うことは本当ではないと思う。', '그가 말하는 것은 사실이 아니라고 생각한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '疑う(의심)=本当ではないと思う(사실 아니라 여김)', 1),
    (w2, w1, 'synonym', '疑う(의심)=本当ではないと思う(사실 아니라 여김)', 1);

  -- 페어 54: 機会 ≒ チャンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '機会', 'きかい', '기회', '機(틀 기)+会(모일 회) → 좋은 때가 모임. 한자어', '유의 표현', 840, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'いい機会だ。', '좋은 기회다.', 1),
    (w1, '機会があれば会いましょう。', '기회가 있으면 만납시다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'チャンス', '찬스, 기회', '영어 chance 외래어', '유의 표현', 841, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '大きなチャンスをつかむ。', '큰 기회를 잡는다.', 1),
    (w2, 'チャンスを逃した。', '기회를 놓쳤다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '機会(한자어)=チャンス(외래어)', 1),
    (w2, w1, 'synonym', '機会(한자어)=チャンス(외래어)', 1);

  -- 페어 55: 相変わらず ≒ 前と同じで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '相変わらず', 'あいかわらず', '여전히, 변함없이', '相(서로 상)+変わらず(변하지 않고) → 여전히. 부사', '유의 표현', 842, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '相変わらず元気ですね。', '여전히 건강하시네요.', 1),
    (w1, '相変わらず忙しい毎日だ。', '변함없이 바쁜 매일이다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '前と同じで', 'まえとおなじで', '예전과 같이', '前(앞 전)+と(과)+同じ(같음)+で. 비교 표현', '유의 표현', 843, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '前と同じで忙しい。', '예전과 같이 바쁘다.', 1),
    (w2, '彼は前と同じで優しい。', '그는 예전과 같이 다정하다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '相変わらず(여전히)=前と同じで(예전과 같이)', 1),
    (w2, w1, 'synonym', '相変わらず(여전히)=前と同じで(예전과 같이)', 1);

  -- 페어 56: 不安だ ≒ 心配だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '不安だ', 'ふあんだ', '불안하다', '不(아닐 불)+安(편안할 안) → 편안하지 않음. な형용사', '유의 표현', 844, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '将来が不安だ。', '장래가 불안하다.', 1),
    (w1, '不安な気持ちでいっぱいだ。', '불안한 기분으로 가득하다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '心配だ', 'しんぱいだ', '걱정이 되다', '心(마음)+配(나눔) → 마음이 흩어짐. な형용사', '유의 표현', 845, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '子どもが心配だ。', '아이가 걱정이다.', 1),
    (w2, '試験の結果が心配だ。', '시험 결과가 걱정이다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '不安(편하지 않음)=心配(걱정)', 1),
    (w2, w1, 'synonym', '不安(편하지 않음)=心配(걱정)', 1);

  -- 페어 57: 学ぶ ≒ 勉強する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '学ぶ', 'まなぶ', '배우다', '学(배울 학): 어린이가 글을 익히는 모습. 1그룹', '유의 표현', 846, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '歴史を学ぶ。', '역사를 배운다.', 1),
    (w1, '日本語を学んでいる。', '일본어를 배우고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '勉強する', 'べんきょうする', '공부하다', '勉(힘쓸 면)+強(강함) → 힘써 노력. する 동사', '유의 표현', 847, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '毎日勉強する。', '매일 공부한다.', 1),
    (w2, '日本語を勉強している。', '일본어를 공부하고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '学ぶ(고유어 배움)=勉強する(한자어 공부)', 1),
    (w2, w1, 'synonym', '学ぶ(고유어 배움)=勉強する(한자어 공부)', 1);

  -- 페어 58: まったく ≒ ぜんぜん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'まったく', '전혀, 완전히', '全く(まったく): 全(전체)+く. 강한 부정 강조 부사', '유의 표현', 848, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'まったく分からない。', '전혀 모르겠다.', 1),
    (w1, 'まったく違う。', '완전히 다르다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'ぜんぜん', '전혀, 전혀 ~않다', '全然(ぜんぜん): 全+然. 강한 부정 부사', '유의 표현', 849, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ぜんぜん分からない。', '전혀 모르겠다.', 1),
    (w2, 'ぜんぜん大丈夫だ。', '전혀 괜찮다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'まったく=ぜんぜん (강한 부정 강조)', 1),
    (w2, w1, 'synonym', 'まったく=ぜんぜん (강한 부정 강조)', 1);

  -- 페어 59: 延期する ≒ 後の別の日にやる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '延期する', 'えんきする', '연기하다', '延(늘일 연)+期(기한 기) → 기한을 늦춤. する 동사', '유의 표현', 850, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '会議を延期する。', '회의를 연기한다.', 1),
    (w1, '試合が雨で延期された。', '시합이 비로 연기됐다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '後の別の日にやる', 'あとのべつのひにやる', '나중에 다른 날에 하다', '後(나중)+別(다른)+日+に+やる. 분석적 표현', '유의 표현', 851, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '今日はやめて、後の別の日にやる。', '오늘은 그만두고 나중에 다른 날에 한다.', 1),
    (w2, '都合が悪いから後の別の日にやる。', '사정이 안 좋아서 나중에 다른 날에 한다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '延期する(연기)=後の別の日にやる(다른 날에 함)', 1),
    (w2, w1, 'synonym', '延期する(연기)=後の別の日にやる(다른 날에 함)', 1);

  -- 페어 60: かがやく ≒ 光る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'かがやく', '빛나다, 반짝이다', '輝く(かがやく): 강하게 빛남. 1그룹', '유의 표현', 852, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '星がかがやく。', '별이 빛난다.', 1),
    (w1, '彼女の笑顔がかがやいている。', '그녀의 미소가 빛나고 있다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '光る', 'ひかる', '빛나다', '光(빛 광): 사람 위의 빛. 1그룹 자동사', '유의 표현', 853, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '星が光る。', '별이 빛난다.', 1),
    (w2, 'ダイヤが光っている。', '다이아몬드가 빛나고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'かがやく(강한 빛)=光る(빛남)', 1),
    (w2, w1, 'synonym', 'かがやく(강한 빛)=光る(빛남)', 1);

  -- 페어 61: がっかりする ≒ 残念だと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'がっかりする', '낙심하다, 실망하다', 'がっかり(의태어)+する. 기대가 무너짐', '유의 표현', 854, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '試験に落ちてがっかりした。', '시험에 떨어져 낙심했다.', 1),
    (w1, '結果にがっかりする。', '결과에 실망한다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '残念だと思う', 'ざんねんだとおもう', '유감스럽다고 생각하다', '残(남을 잔)+念(생각) → 아쉬움이 남음. 「~と思う」', '유의 표현', 855, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '中止になって残念だと思う。', '중지돼서 유감스럽다.', 1),
    (w2, '行けなくて残念だと思う。', '갈 수 없어서 유감스럽다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'がっかりする(실망)=残念だと思う(유감)', 1),
    (w2, w1, 'synonym', 'がっかりする(실망)=残念だと思う(유감)', 1);

  -- 페어 62: 当然 ≒ もちろん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '当然', 'とうぜん', '당연히', '当(마땅 당)+然(그러할 연) → 마땅히 그러함. 부사', '유의 표현', 856, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '当然のことだ。', '당연한 일이다.', 1),
    (w1, '当然彼は怒るだろう。', '당연히 그는 화낼 것이다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'もちろん', '물론', '勿論(もちろん): 굳이 논할 필요 없음. 부사', '유의 표현', 857, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'もちろん行きます。', '물론 갑니다.', 1),
    (w2, 'もちろん知っている。', '물론 알고 있다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '当然(당연)=もちろん(물론)', 1),
    (w2, w1, 'synonym', '当然(당연)=もちろん(물론)', 1);

  -- 페어 63: あまる ≒ 多すぎて残る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '余る', 'あまる', '남다', '余(남을 여): 음식·시간 등이 남음. 1그룹 자동사', '유의 표현', 858, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ご飯が余った。', '밥이 남았다.', 1),
    (w1, '時間が余ったので散歩した。', '시간이 남아서 산책했다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '多すぎて残る', 'おおすぎてのこる', '너무 많아서 남다', '多い+すぎる(지나치게)+残る. 분석적 표현', '유의 표현', 859, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '料理が多すぎて残る。', '요리가 너무 많아서 남는다.', 1),
    (w2, '量が多すぎて残った。', '양이 너무 많아서 남았다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '余る(남음)=多すぎて残る(많아서 남음)', 1),
    (w2, w1, 'synonym', '余る(남음)=多すぎて残る(많아서 남음)', 1);

  -- 페어 64: 横断禁止です ≒ 渡ってはいけないです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '横断禁止です', 'おうだんきんしです', '횡단금지입니다', '横(가로)+断(끊을 단) → 가로지름. 禁止(금지). 표지판 표현', '유의 표현', 860, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'ここは横断禁止です。', '여기는 횡단금지입니다.', 1),
    (w1, '道路は横断禁止です。', '도로는 횡단금지입니다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '渡ってはいけないです', 'わたってはいけないです', '건너서는 안 됩니다', '渡る(건너다)+「~てはいけない」=~해서는 안 된다. 금지 표현', '유의 표현', 861, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'ここを渡ってはいけないです。', '여기를 건너서는 안 됩니다.', 1),
    (w2, '危険ですから渡ってはいけないです。', '위험하니까 건너서는 안 됩니다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '横断禁止(표지판)=渡ってはいけない(설명 표현)', 1),
    (w2, w1, 'synonym', '横断禁止(표지판)=渡ってはいけない(설명 표현)', 1);

  -- 페어 65: あらゆる ≒ すべての
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'あらゆる', '모든, 온갖', '有らゆる(あらゆる): 「있는 모든」. 연체사', '유의 표현', 862, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'あらゆる方法を試した。', '모든 방법을 시도했다.', 1),
    (w1, 'あらゆる人を助ける。', '온갖 사람을 돕는다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, 'すべての', 'すべての', '모든', '全て+の(연체) → 모든. 연체수식', '유의 표현', 863, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, 'すべての人に感謝する。', '모든 사람에게 감사한다.', 1),
    (w2, 'すべての問題を解いた。', '모든 문제를 풀었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'あらゆる(온갖)=すべての(모든)', 1),
    (w2, w1, 'synonym', 'あらゆる(온갖)=すべての(모든)', 1);

  -- 페어 66: どなる ≒ 大声で怒る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, NULL, 'どなる', '호통치다, 고함지르다', '怒鳴る(どなる): 怒(노)+鳴(울다) → 화내며 큰 소리. 1그룹', '유의 표현', 864, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, '父にどなられた。', '아버지에게 호통을 들었다.', 1),
    (w1, '大きな声でどなる。', '큰 목소리로 호통친다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '大声で怒る', 'おおごえでおこる', '큰 소리로 화내다', '大声(큰 소리)+で(수단)+怒る(화내다)', '유의 표현', 865, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '彼は大声で怒った。', '그는 큰 소리로 화를 냈다.', 1),
    (w2, '大声で怒ると怖い。', '큰 소리로 화내면 무섭다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', 'どなる(호통)=大声で怒る(큰 소리로 화냄)', 1),
    (w2, w1, 'synonym', 'どなる(호통)=大声で怒る(큰 소리로 화냄)', 1);

  -- 페어 67: 협력する ≒ 手伝う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '協力する', 'きょうりょくする', '협력하다', '協(화할 협)+力(힘) → 힘을 합침. する 동사', '유의 표현', 866, array['synonym_pair']::text[]) returning id into w1;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w1, 'みんなで協力する。', '모두 협력한다.', 1),
    (w1, '彼が協力してくれた。', '그가 협력해 주었다.', 2);
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n3, '手伝う', 'てつだう', '돕다, 거들다', '手(손 수)+伝(전할 전) → 손을 더해 도움. 1그룹', '유의 표현', 867, array['synonym_pair']::text[]) returning id into w2;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w2, '母を手伝う。', '어머니를 돕는다.', 1),
    (w2, '仕事を手伝ってくれた。', '일을 도와주었다.', 2);
  insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
    (w1, w2, 'synonym', '協力する(힘을 합침)=手伝う(거들어 줌)', 1),
    (w2, w1, 'synonym', '協力する(힘을 합침)=手伝う(거들어 줌)', 1);

end $$;
