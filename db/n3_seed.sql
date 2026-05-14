-- ============================================================
-- JLPT N3 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N3-단어장)
-- ============================================================
-- 실행 시 기존 N3 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 672단어 (672개는 의미·한자어원·예문 2개씩 / 0개는 PDF 추출 기본정보)
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '地球', 'ちきゅう', '지구', '地(땅 지): 土(흙 토) + 也(이글 야) → 흙이 평평하게 깔린 곣
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'はかる', '쟬다, 측정하다', '計る(値などを計算)·量る(重さを量る)·測る(長さを測う) 등의 표기
소리가 같고 하나의 명사처럼 쓰이는 동사', '동사', 100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体重をはかる。', '체중을 쟬다.', 1),
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
線(줄 선): 糸(실) + 泉(샘 천)→ 고고하게 이어진 줄', '명사', 114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な語に下線を引いた。', '중요한 단어에 밑줄을 그었다.', 1),
    (w, '下線部を読んでください。', '밑줄 부분을 읽어주세요.', 2);

  -- 115. 転ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '転ぶ', 'ころぶ', '구르다, 넘어지다', '転(굴러 전): 車(수레) + 專(돌 전)→ 수레가 돌다
자동사로 회전하면서 넘어짐', '동사', 115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道で転んでケガした。', '길에서 넘어져 다쳐다.', 1),
    (w, '走ったら転ぶよ。', '뛰면 넘어진다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '身長', 'しんちょう', '신장, 키', '身(몸 신): 임신한 여자의 즘 모양→ 사람의 몸
長(길 장): 머리카락이 긴 노인의 모양→ 길다', '명사', 129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は身長が高い。', '그는 키가 크다.', 1),
    (w, '身長を測りました。', '키를 쟬었습니다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '複数', 'ふくすう', '복수, 여러 개', '複(걹 복): 걹겹으로→ 하나가 아닌 여러개
数(셌 수): 수량', '명사', 175, array[]::text[]) returning id into w;
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '雑誌', 'ざっし', '잡지', '雑(섮일 잡): 여러가지가 섮임
誌(기록할 지): 기록한 책', '명사', 180, array[]::text[]) returning id into w;
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '感じる', 'かんじる', '느끼다', '感(느낀 감): 마음으로 느끌
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しまう', '치우다, 안에 넣다', '同じう(同じる·閃う)와 연관→ 결말짓다
타동사로 정리해 넣음', '동사', 214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電子レンジを引き出しにしまった。', '전자레인지를 서랍에 넣었다.', 1),
    (w, '学生の本を手の上にしまった。', '학생의 책을 선반에 치웠다.', 2);

  -- 215. 最新
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '最新', 'さいしん', '최신', '最(가장 최): 가장·제일
新(새 신): 새로움', '명사', 215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最新ニュースを見た。', '최신 뉴스를 봤다.', 1),
    (w, '最新の技術を導入した。', '최신 기술을 도입했다.', 2);

  -- 216. しばる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しばる', '묶다', '縛る」(묶을 박)의 표기→ 줄·끈으로 돌려 묶다
타동사', '동사', 216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '骪をリボンでしばる。', '머리를 리본으로 묶는다.', 1),
    (w, '荷物をしばって車に載せる。', '짐을 묶어서 차에 싣는다.', 2);

  -- 217. キャンセル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'キャンセル', '취소', '영어 cancel의 외래어
예약·계약을 취소하는 행위', '명사', 217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約をキャンセルした。', '예약을 취소했다.', 1),
    (w, 'キャンセル料がかかる。', '취소 수수료가 쟈어난다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あわ', '거품', '공기를 포함한 거품 물질
접미사 わ 포함', '명사', 223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビールにあわがたっぷりある。', '맥주에 거품이 쟔르다.', 1),
    (w, '石鸼のあわを見た。', '비누거품을 봤다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '扱う', 'あつかう', '다루다, 취급하다', '扱(다룰 급): 손으로 잔일하게 취급함
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しばらく', '잠시, 한동안', '柴らくの漢字表記·久しくとも 쓰임
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '不満', 'ふまん', '불만', '不(아닐 부): 아닐
満(차을 만): 채움', '명사', 233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体手に不満がある。', '대우에 불만이 있다.', 1),
    (w, '不満を口に出せない。', '불만을 입밖으로 낼 수 없다.', 2);

  -- 234. ぶらぶら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぶらぶら', '어슬렁어슬렁', '의태어→ 천천히 걷는 모양
목적없이 걷거나 대기', '부사', 234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園をぶらぶら歩いた。', '공원을 어슬렁거렸다.', 1),
    (w, '人は仕事もせずぶらぶらしている。', '그는 일도 안 하고 빈둥거린다.', 2);

  -- 235. 申込書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '申込書', 'もうしこみしょ', '신청서', '申込み(신청)→ 의사를 전달
書(글 서): 문서', '명사', 235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '申込書を提出した。', '신청서를 제출했다.', 1),
    (w, '申込書を記入してください。', '신청서를 작성해 주세요.', 2);

  -- 236. 複雑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '複雑', 'ふくざつ', '복잡함', '複(걹 복): 걹겹·여러 개
雑(섮일 잡): 섮임', 'な형용사', 236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題は複雑だ。', '이 문제는 복잡하다.', 1),
    (w, '複雑な手続きが必要だ。', '복잡한 절차가 필요하다.', 2);

  -- 237. 流れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '流れる', 'ながれる', '흐르다', '流(흐를 류): 물이 흐르는 모양
자동사형 れる이 붙음', '동사', 237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の水が流れる。', '강의 물이 흐른다.', 1),
    (w, '涙が流れてしまった。', '눈물이 흐러버렸다.', 2);

  -- 238. 産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '産', 'さん', '산', '産(낳을 산): 자식을 낳음→ 생산되는 곳
접미사로 생산지를 나타냄', '접미사', 238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これはアメリカ産のしんごだ。', '이것은 미국산 사과다.', 1),
    (w, '国産の所を買う。', '국산 소고기를 산다.', 2);

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
    (w, 'のどがからからだ。', '목이 바짝바짝하다.', 1),
    (w, 'お皿がからからに乾いた。', '접시가 편짝 마르고 있다.', 2);

  -- 243. ためる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ためる', '모으다, 담다', '溜めるの 표기→ 한 곣에 고이다
타동사로 축적·저축', '동사', 243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金をためている。', '돈을 모으고 있다.', 1),
    (w, 'ポイントをためて交換した。', '포인트를 모아 교환했다.', 2);

  -- 244. かかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かかる', '걸리다', '掛かる·掛かるの 교결·연속·필요 등 다양한 의미
자동사로 시간·비용·연결 등을 나타냄', '동사', 244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一時間かかる。', '한 시간 걸린다.', 1),
    (w, 'この仕事にはお金がかかる。', '이 일에는 돈이 재어난다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '冗談', 'じょうだん', '농담', '冗(넘칠 잉): 남차는·잡다한
談(말씀 담): 대화', '명사', 247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談だと思ってた。', '농담이라고 생각했다.', 1),
    (w, '彼は冗談が上手だ。', '그는 농담을 잘한다.', 2);

  -- 248. さっそく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'さっそく', '즉시, 곧', '早速の 표기→ 빠르고 손쉬롭게
부사로 주저함 없이', '부사', 248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さっそく試してみた。', '즉시 시도해 보았다.', 1),
    (w, '連絡を受けてさっそく出かけた。', '연락을 받고 곧 나갔다.', 2);

  -- 249. カーブ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'カーブ', '곱선, 커브', '영어 curve의 외래어
김은 선·우회전·도로의 구비 구간', '명사', 249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーブを曲がった。', '커브를 돔았다.', 1),
    (w, 'ボールがカーブしてストライクだ。', '공이 갈라서 스트라이크다.', 2);

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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '影響', 'えいきょう', '영향', '影(그림자 영): 그림자·흐적
響(울릴 향): 소리가 울림', '명사', 252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天気の影響で試合が中止だ。', '날씨의 영향으로 경기가 중지다.', 1),
    (w, '広告の影響は大きい。', '광고의 영향은 크다.', 2);

  -- 253. しっかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しっかり', '단단히, 확실히', '確りの 표기→ 구체적·확실하게
부사로 단단하고 철저히', '부사', 253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しっかり勉強しなさい。', '제대로 공부해라.', 1),
    (w, 'しっかりと手を握った。', '꿈° 손을 잡았다.', 2);

  -- 254. ながれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ながれ', '흐름', '流れの 표기→ 물이나 색틀이 흐르는 모양
명사형', '명사', 254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の流れが速い。', '강의 흐름이 빠르다.', 1),
    (w, '話の流れを掴む。', '이야기의 흐름을 파악한다.', 2);

  -- 255. 外食
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '外食', 'がいしょく', '외식', '外(바깥 외): 집 밖
食(밥 식): 식사', '명사', 255, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今夕は外食にしよう。', '오늘 저녁은 외식하자.', 1),
    (w, '外食が多いと太る。', '외식이 지장으면 살이 진다.', 2);

  -- 256. 差
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '差', 'さ', '차이, 안른함', '差(어긇날 차): 결이 고르지 않음→ 차이
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '別れる', 'わかれる', '헤어지다', '別(나눌 별): 다르게 나눌
자동사형 れる이 붙음', '동사', 259, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '恐人と別れた。', '사귀명과 헤어졌다.', 1),
    (w, '友達と駅で別れた。', '친구와 역에서 헤어졌다.', 2);

  -- 260. 起きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '起きる', 'おきる', '일어나다, 발생하다', '起(일어날 기): 누워 있다 서면으로
자동사로 취침·사건 발생', '동사', 260, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝七時に起きた。', '아침 7시에 일어났다.', 1),
    (w, '大事件が起きた。', '큰 사건이 발생했다.', 2);

  -- 261. 応援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '応援', 'おうえん', '응원', '応(응할 응): 대응·응답
援(도울 원): 도와줌', '명사', 261, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応援してくれてありがとう。', '응원해줘서 고마워.', 1),
    (w, 'チームを応援した。', '팁을 응원했다.', 2);

  -- 262. のばす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'のばす', '연장하다, 연기하다', '延ばす·伸ばす의 표기→ 길게 하다·늦추다
타동사', '동사', 262, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '期限を一週間のばした。', '기한을 일주일 연장했다.', 1),
    (w, '骪をのばす。', '머리를 길게 기른다.', 2);

  -- 263. ふる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふる', '흔들다', '振る·震る의 표기→ 흔괴이고 움직임
타동사로 물건을 좌우로 흔들다', '동사', 263, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をふって振りかえた。', '손을 흔들어 돌아봤다.', 1),
    (w, 'スカートをふってダンスを踊った。', '치마를 흔들며 춤을 춰다.', 2);

  -- 264. カバー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'カバー', '커버, 덮개', '영어 cover의 외래어
덮개·책자쯤·대신함', '명사', 264, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本にカバーをかけた。', '책에 커버를 썰워제결했다.', 1),
    (w, '仄事をカバーしてもらった。', '일을 대신 해주었다.', 2);

  -- 265. 想像
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '想像', 'そうぞう', '상상', '想(생각할 상): 마음에 그리다
像(모양 상): 머리속 그림', '명사', 265, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来を想像してみる。', '미래를 상상해본다.', 1),
    (w, '想像もできない。', '상상도 할 수 없다.', 2);

  -- 266. むく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'むく', '벗기다', '剥くの 표기→ 껍질을 벗기다
타동사', '동사', 266, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごの皮をむいた。', '사과 껍질을 벗겼다.', 1),
    (w, '咳の皮をむく。', '귄의 껍질을 벗긴다.', 2);

  -- 267. かれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かれる', '시들다', '枯れるの 표기→ 식물이 쓰러짐
자동사', '동사', 267, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花がかれてしまった。', '꽃이 시들어 버렸다.', 1),
    (w, '水をやらないと植物はかれる。', '물을 주지 않으면 식물이 시들어.', 2);

  -- 268. がっかりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'がっかりする', '낙심하다', 'だっかり·がっかり의 의성어 파생
기대에 못미쳐 실망함', '동사', 268, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'でとうしてがっかりした。', '떨어져서 낙심했다.', 1),
    (w, '負けてがっかりする。', '져서 실망한다.', 2);

  -- 269. ヒント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ヒント', '힌트', '영어 hint의 외래어
암시·단서', '명사', 269, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ヒントをください。', '힌트를 주세요.', 1),
    (w, 'もう一つヒントを出しよう。', '한 개 더 힌트를 줄껐.', 2);

  -- 270. なつかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なつかしい', '그립다', '懷かしいの 표기→ 과거가 그린 상태
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しつこい', '끈질기다', '집요하고 질긴 일어→ 지박스럽게
い형용사', 'い형용사', 272, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しつこい勧誘に困る。', '끈질긴 권유에 곤란하다.', 1),
    (w, '咳がしつこい。', '기침이 지박스럽다.', 2);

  -- 273. 自動的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自動的', 'じどうてき', '자동적', '自動(자동): 스스로 움직임
的(과녁 적): 구리 어미', 'な형용사', 273, array[]::text[]) returning id into w;
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

  -- 277. 計算
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '計算', 'けいさん', '계산', '計(셌 계): 수를 셌
算(셌 산): 계산', '명사', 277, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計算が間違っていた。', '계산이 틀렸다.', 1),
    (w, '電卓で計算した。', '계산기로 계산했다.', 2);

  -- 278. 急ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '急ぐ', 'いそぐ', '서두르다', '急(급할 급): 빠르고 급함
자동사로 행동을 빨리 함', '동사', 278, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高造に急ぐ。', '학교에 서두른다.', 1),
    (w, '急がないと遅てしまう。', '서두르지 않으면 늦는다.', 2);

  -- 279. ガラス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ガラス', '유리', '네덜란드어 glas의 외래어
투명한 가끜운 소재', '명사', 279, array[]::text[]) returning id into w;
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
    (w, '他人と比較しないでいて。', '다른 사람과 비교하지 마.', 1),
    (w, '价格を比較して買う。', '가격을 비교해서 사개°°며.', 2);

  -- 282. ぴったり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぴったり', '딱', '의태어→ 틈°더함 없이 맞는 상태
완벽히 일치하는 모양', '부사', 282, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この服はぴったりだ。', '이 옷은 딱 잊는다.', 1),
    (w, '中起にぴったり間に合った。', '점심에 딱 맞춰서 도착했다.', 2);

  -- 283. 必死
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '必死', 'ひっし', '필사적', '必(반드시 필): 반드시
死(죽을 사): 죽음', 'な형용사', 283, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必死で勉強した。', '필사적으로 공부했다.', 1),
    (w, '必死に走って間に合った。', '필사적으로 달려서 간다.', 2);

  -- 284. ぼんやり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぼんやり', '멍하게', '의태어→ 의식이 뜹한 상태
주의력을 잏은 모양', '부사', 284, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼんやりして車を見した。', '멍하게 있다가 차를 놓쳤다.', 1),
    (w, 'ぼんやりした表情だった。', '멍한 표정이었다.', 2);

  -- 285. はかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'はかる', '재다, 측정하다', '量る·測る·計るの 표기→ 수치를 측정
타동사', '동사', 285, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体温をはかった。', '체온을 재었다.', 1),
    (w, '長さをはかる。', '길이를 측정한다.', 2);

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
    (w, '不安で眠れない。', '불안해서 잠을 못 움다.', 2);

  -- 288. 横
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '横', 'よこ', '옆, 가로', '横(가로 획): 옆으로 늈 모양
수평 방향', '명사', 288, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '横にずれている。', '옆으로 비껸젹 있다.', 1),
    (w, '記横の中到に並んだ。', '자의 옆자리에 서있다.', 2);

  -- 289. 結ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '結ぶ', 'むすぶ', '묶다', '結(맺을 결): 끝을 한데 모음
타동사', '동사', 289, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リボンを結んだ。', '리본을 맳았다.', 1),
    (w, 'ひもをしっかり結ぶ。', '끌을 단단히 맳는다.', 2);

  -- 290. 数
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '数', 'かず', '수', '数(셌 수): 수을 셌
의미 수의 양', '명사', 290, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '数を数えてみた。', '수를 세어 봤다.', 1),
    (w, '参加者の数が多い。', '참가자 수가 많다.', 2);

  -- 291. キャンセル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'キャンセル', '취소', '영어 cancel의 외래어
예약·관계를 취소함', '명사', 291, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約をキャンセルした。', '예약을 취소했다.', 1),
    (w, '静始記もキャンセルされた。', '공연도 취소되었다.', 2);

  -- 292. ハンドル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ハンドル', '핸들', '영어 handle의 외래어
자동차의 운전대', '명사', 292, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ハンドルを右に切った。', '핸들을 오른쪽으로 꾬롤다.', 1),
    (w, 'ハンドルをしっかり採って。', '핸들을 단단히 잡아.', 2);

  -- 293. 集中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '集中', 'しゅうちゅう', '집중', '集(모일 집): 한데 모임
中(가운데 중): 중심', '명사', 293, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強に集中している。', '공부에 집중하고 있다.', 1),
    (w, '集中力が上がった。', '집중력이 올랐다.', 2);

  -- 294. ふくむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふくむ', '포함하다', '含むの 표기→ 안에 가지고 있음
타동사', '동사', 294, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '税金を含む。', '세금을 포함한다.', 1),
    (w, '送料も含まれている。', '배송비도 포함되어 있다.', 2);

  -- 295. 直接
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '直接', 'ちょくせつ', '직접', '直(곳을 직): 곷음
接(이을 접): 이음', '명사', 295, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '直接会って話したい。', '직접 만나서 이야기하고 싶다.', 1),
    (w, '直接扱うのが安全だ。', '직접 취급하는 게 안전하다.', 2);

  -- 296. のる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'のる', '타다', '乗るの 표기→ 교통수단에 올라타다
자동사', '동사', 296, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車に乗った。', '전철에 탔다.', 1),
    (w, 'バスに乗り遅れた。', '버스를 놓쳐다.', 2);

  -- 297. 平均
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '平均', 'へいきん', '평균', '平(평평할 평): 평평함
均(고른 균): 고르게함', '명사', 297, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平均点は八十点だ。', '평균점은 80점이다.', 1),
    (w, '一年間の平均気温を測る。', '일년간 평균 기온을 측정한다.', 2);

  -- 298. 違反
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '違反', 'いはん', '위반', '違(어김날 위): 않는 방향→ 어김
反(돌이킬 반): 돌이키다', '명사', 298, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スピード違反だ。', '속도 위반이다.', 1),
    (w, '交通規則違反をした。', '교통규칙 위반을 했다.', 2);

  -- 299. かつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'かつ', '이기다', '勝つの 표기→ 경쟁에서 이김
자동사', '동사', 299, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合に勝った。', '경기에서 이겼다.', 1),
    (w, '試験にポイトのチームが勝った。', '경기에서 내가 움직이는 팁이 이겼다.', 2);

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
    (w, '試合に負けて残念だ。', '경기에 져서 아쉬움을 남겄다.', 1),
    (w, '残念ながら欠席します。', '아쉬움겹지만 불참합니다.', 2);

  -- 305. つもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つもり', '작정, 이도', '積もりの 표기→ 쌓아온 마음
의도·예정을 나타냄', '명사', 305, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日行くつもりだ。', '내일 갈 작정이다.', 1),
    (w, '買うつもりはない。', '살 이도는 없다.', 2);

  -- 306. なお
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なお', '또한, 여전히', '尚の 표기→ 아직도·더욱
접속사·부사', '접속사', 306, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なお、详しくはホームページをご覧ください。', '또한 자세한 내용은 홈페이지를 참고하세요.', 1),
    (w, '雨がなお降っている。', '비가 여전히 내리고 있다.', 2);

  -- 307. 順番
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '順番', 'じゅんばん', '순서', '順(순할 순): 순서대로
番(차례 번): 차례', '명사', 307, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '順番を守って並んでください。', '순서를 지켜 서주세요.', 1),
    (w, '順番が回ってきた。', '순서가 여기에 왔다.', 2);

  -- 308. 上下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '上下', 'じょうげ', '상하', '上(윗 상): 위
下(아래 하): 아래', '명사', 308, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上下関係が厳しい。', '상하관계가 엄격하다.', 1),
    (w, '上下を見てればわかる。', '위아래를 보면 이해한다.', 2);

  -- 309. 加える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '加える', 'くわえる', '더하다, 추가하다', '加(더할 가): 힘을 더함
타동사', '동사', 309, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '砜糖を加えてください。', '설탕을 더해주세요.', 1),
    (w, 'メンバーを一人加える。', '멤버를 한 사람 추가한다.', 2);

  -- 310. アナウンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'アナウンス', '안내방송', '영어 announce의 외래어
공식 알림', '명사', 310, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅でアナウンスが聬こえた。', '역에서 안내방송이 들렸다.', 1),
    (w, '出発アナウンスが出た。', '출발 안내방송이 나왔다.', 2);

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
    (w, '個性を生かそう。', '개성을 살림하자.', 2);

  -- 313. 演劇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '演劇', 'えんげき', '연극', '演(폼 연): 느뜰게 펼치다
劇(심할 극): 극적', '명사', 313, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '演劇を見に行った。', '연극을 보러 갔다.', 1),
    (w, '演劇部に入った。', '연극부에 들어갔다.', 2);

  -- 314. ぜひ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ぜひ', '꿆, 꼭', '是非の 표기→ 올움·그릅을 가림 없이
강조 부사', '부사', 314, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜひ遇びに来てください。', '꿆 높이러 와주세요.', 1),
    (w, 'ぜひ酒合いたい。', '꼭 만나고 싶다.', 2);

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
    (w, '重要な代言だ。', '중요한 안건이다.', 2);

  -- 317. 通る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '通る', 'とおる', '지나가다', '通(통할 통): 관통해서 경과움
자동사', '동사', 317, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が道を通る。', '차가 길을 지나간다.', 1),
    (w, '試験に通った。', '시험에 합격했다.', 2);

  -- 318. けが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'けが', '부상', '怪我の 표기→ 이상하게 당함→ 상처
명사', '명사', 318, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高造でけがをした。', '학교에서 다쳐다.', 1),
    (w, '転んでけがをした。', '넘어져서 다쳐다.', 2);

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
숨박 시설', '명사', 322, array[]::text[]) returning id into w;
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

  -- 325. ノック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ノック', '노크', '영어 knock의 외래어
문을 두드리며 소리를 내는 일', '명사', 325, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアをノックした。', '문을 노크했다.', 1),
    (w, '三回ノックしても返事がない。', '세 번 노크해도 대답이 없다.', 2);

  -- 326. 命
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '命', 'いのち', '생명, 목숨', '命(목숨 명): 입으로 명을 내림→ 숨을 쓠
살아있게 하는 원천', '명사', 326, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '命は一つしかない。', '생명은 하나뿐이다.', 1),
    (w, '命を大切にしよう。', '생명을 소중히 하자.', 2);

  -- 327. 集まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '集まる', 'あつまる', '모이다', '集(모일 집): 새들이 나무에 모임
자동사', '동사', 327, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広場に人が集まった。', '광장에 사람이 모였다.', 1),
    (w, '銖隃の前に集まってください。', '조상 앞에 모여 주세요.', 2);

  -- 328. 授業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '授業', 'じゅぎょう', '수업', '授(줄 수): 가르침
業(일 업): 일·학업', '명사', 328, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '授業を受ける。', '수업을 받는다.', 1),
    (w, '授業中は集中してよう。', '수업 중에는 집중하자.', 2);

  -- 329. 違う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '違う', 'ちがう', '다르다, 틀리다', '違(어김날 위): 쟈못 갈→ 다름
자동사', '동사', 329, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えが違う。', '생각이 다르다.', 1),
    (w, 'この答えは違う。', '이 답은 틀렸다.', 2);

  -- 330. アクセサリー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'アクセサリー', '액세서리', '영어 accessory의 외래어
장식품·부속품', '명사', 330, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '可愛いアクセサリーを買った。', '귀엽은 액세서리를 샀다.', 1),
    (w, 'アクセサリーをつけている。', '액세서리를 착용하고 있다.', 2);

  -- 331. 数字
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '数字', 'すうじ', '숫자', '数(셌 수): 수
字(글자 자): 글자', '명사', 331, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '数字を読み達えた。', '숫자를 잘못 읽었다.', 1),
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
    (w, '人気メニューを頫んだ。', '인기 메뉴를 주문했다.', 2);

  -- 334. でかける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'でかける', '외출하다, 나가다', '出掛けるの 표기→ 밖으로 나가다
자동사', '동사', 334, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝早く出かけた。', '아침 일직 나갔다.', 1),
    (w, '買い物に出かける。', '장을 보러 나간다.', 2);

  -- 335. 単語
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '単語', 'たんご', '단어', '単(홀 단): 하나·홀로
語(말씀 어): 말', '명사', 335, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '単語を覚える。', '단어를 외운다.', 1),
    (w, 'この単語の意味を調べる。', '이 단어의 뜻을 찾아본다.', 2);

  -- 336. もったいない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'もったいない', '아깝다', '勿体ないの 표기→ 그 본얰의 가치가 없어짐
い형용사', 'い형용사', 336, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '捨てるのはもったいない。', '버리기에는 아깝다.', 1),
    (w, '時間がもったいない。', '시간이 아깝다.', 2);

  -- 337. 計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '計画', 'けいかく', '계획', '計(셌 계): 소도를 셌
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
    (w, 'ペット勄も可だ。', '애완동물 출입 가능이다.', 2);

  -- 340. 急に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '急に', 'きゅうに', '갑자기', '急(급할 급): 활마처럼 홝·대단히
부사·형용사처럼 쓰임', '부사', 340, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急に雨が降り始めた。', '갑자기 비가 내리기 시작했다.', 1),
    (w, '急に思い出した。', '갑자기 생각났다.', 2);

  -- 341. 機会
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '機会', 'きかい', '기회', '機(틀 기): 이접해 종조이
会(모일 회): 만남', '명사', 341, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いい機会だ。', '좋은 기회다.', 1),
    (w, '機会を逃すと勿体ない。', '기회를 놓치면 아깝다.', 2);

  -- 342. ふだん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふだん', '평소', '普段の 표기→ 한 단계·평범함→ 평소
부사', '부사', 342, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ふだん、電車で出勤している。', '평소에 전철로 출근한다.', 1),
    (w, 'ふだんの仕事は多しい。', '평소 업무는 바쁘다.', 2);

  -- 343. 教育
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '教育', 'きょういく', '교육', '教(가르칠 교): 가르침
育(기를 육): 기름', '명사', 343, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の教育に熟心だ。', '자녀 교육에 열심이다.', 1),
    (w, '教育を受ける権利がある。', '교육받을 권리가 있다.', 2);

  -- 344. ふえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ふえる', '늘다, 쿨이게하다', '増えるの 다른 표기→ 아이가 늘게 함
自えるの 가능형 れる', '동사', 344, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '孫が三人にふえた。', '손자가 세 명으로 늘었다.', 1),
    (w, '体重がふえて困っている。', '체중이 늘어 고민이다.', 2);

  -- 345. 訪問
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '訪問', 'ほうもん', '방문', '訪(찾을 방): 찾아감
問(물을 문): 물으며 봤음', '명사', 345, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達を訪問した。', '친구를 방문했다.', 1),
    (w, '企業訪問の予定だ。', '기업 방문 예정이다.', 2);

  -- 346. 期待
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '期待', 'きたい', '기대', '期(기약할 기): 때·기다림
待(기다릴 대): 기다림', '명사', 346, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きな期待を持っている。', '큰 기대를 가지고 있다.', 1),
    (w, '期待に応えたい。', '기대에 부응하고 싶다.', 2);

  -- 347. 過去
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '過去', 'かこ', '과거', '過(지날 과): 지나감
去(갈 거): 감', '명사', 347, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去を慵わない。', '과거를 뜨례안는다.', 1),
    (w, '過去に学ぶものがある。', '과거에서 배우는 것이 있다.', 2);

  -- 348. たとえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'たとえば', '예를 들면', '例えばの 표기→ 예를 들면
접속사', '접속사', 348, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たとえば、こんな感じだ。', '예를 들어 이런 식이다.', 1),
    (w, 'たとえば梨やりんごも仃だ。', '예를 들면 배나 사과도 재밌다.', 2);

  -- 349. テクニック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'テクニック', '테크닉', '영어 technique의 외래어
기술·방법', '명사', 349, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このテクニックは高い。', '이 기술은 높다.', 1),
    (w, 'テクニックを身につける。', '기술을 못이다.', 2);

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
    (w, 'もう三時を過ぎた。', '벌써 3시를 넘겨다.', 2);

  -- 354. 知り合い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '知り合い', 'しりあい', '아는 사람', '知(알 지): 알다
合う(마눌 합): 어울림', '명사', 354, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社で知り合いになった。', '회사에서 아는 사이가 되었다.', 1),
    (w, '他人でも知り合いは多い。', '그도 아는 사람이 많다.', 2);

  -- 355. 確実
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '確実', 'かくじつ', '확실', '確(굳을 확): 틄틄함
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

  -- 361. 努力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '努力', 'どりょく', '노력', '努(힘쓸 노): 힘수 이용·애쓰다
力(힘 력): 힘', '명사', 361, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スタイルを努力している。', '주이도록 노력하고 있다.', 1),
    (w, '努力は裏切らない。', '노력은 배신하지 않는다.', 2);

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

  -- 365. うっかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'うっかり', '깜빡', '의태어→ 주의가 흔트러진 상태
부주의한 모양', '부사', 365, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うっかり忘れてしまった。', '깜빡 잊어버렸다.', 1),
    (w, 'うっかり見逃してしまった。', '깜빡 있다가 놓쳤다.', 2);

  -- 366. 修理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '修理', 'しゅうり', '수리', '修(닦을 수): 고치다
理(다스릴 리): 다스림', '명사', 366, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車を修理に出した。', '차를 수리에 맡겼다.', 1),
    (w, '修理代が高い。', '수리비가 비싸다.', 2);

  -- 367. はずす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'はずす', '떼다, 볼기다', '外すの 표기→ 밖으로 낙운다·벗겨내다
타동사', '동사', 367, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '眼鏡をはずした。', '안경을 볼겨냈다.', 1),
    (w, 'ボタンをはずす。', '단추를 푹다.', 2);

  -- 368. 苦労
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '苦労', 'くろう', '고생', '苦(쓸 고): 고고틀함
労(일할 로): 일함', '명사', 368, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご苦労さまでした。', '고생 많으셨습니다.', 1),
    (w, '苦労して育てた。', '고생해서 키웠다.', 2);

  -- 369. つらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つらい', '괴롭다', '辛いの 표기→ 마음·몸이 괴로움
い형용사', 'い형용사', 369, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がつらい。', '머리가 아프다.', 1),
    (w, 'つらい思い出だ。', '괴로운 기억이다.', 2);

  -- 370. ガイド
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ガイド', '가이드', '영어 guide의 외래어
안내자·안내서', '명사', 370, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '観光ガイドを願う。', '관광 가이드를 부탁한다.', 1),
    (w, 'ガイドブックを読んだ。', '가이드북을 읽었다.', 2);

  -- 371. 説明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '説明', 'せつめい', '설명', '説(말씀 설): 말로 알림
明(밝을 명): 밝히 드러낼', '명사', 371, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その説明はわかりやすい。', '그 설명은 알기 쉽다.', 1),
    (w, '使い方を説明した。', '사용법을 설명했다.', 2);

  -- 372. 偶然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '偶然', 'ぐうぜん', '우연', '偶(짝 우): 짝을 이롌
然(그럴 연): 그러함', '명사', 372, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '偶然友達に会った。', '우연히 친구를 만났다.', 1),
    (w, '偶然にも陣席があった。', '우연히도 자리가 남아 있었다.', 2);

  -- 373. 必要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '必要', 'ひつよう', '필요', '必(반드시 필): 반드시·꼭
要(요구할 요): 구함', 'な형용사', 373, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必要な物を買う。', '필요한 것을 산다.', 1),
    (w, 'もう何も必要ない。', '이제 아무것도 필요없다.', 2);

  -- 374. 真っ赤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '真っ赤', 'まっか', '새빨강', '真(참 진): 완전한
赤(붉을 적): 붉은 색', 'な형용사', 374, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真っ赤なリンゴだ。', '새빨강 사과다.', 1),
    (w, '息て顔が真っ赤だ。', '화가나서 얼굴이 새빨강이다.', 2);

  -- 375. ようやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ようやく', '결국, 마침내', 'やうやく·要やくの 표기→ 어제서야·곳
부사', '부사', 375, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ようやく完成した。', '마침내 완성했다.', 1),
    (w, 'ようやく雨が止んだ。', '결국 비가 닝결다.', 2);

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
    (w, 'クラブでダンスを踊った。', '클럽에서 춤을 춰다.', 2);

  -- 378. 検査
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '検査', 'けんさ', '검사', '検(검사할 검): 검사함
査(조사할 사): 조사함', '명사', 378, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '病院で検査を受けた。', '병원에서 검사를 받았다.', 1),
    (w, '詳しい検査が必要だ。', '자세한 검사가 필요하다.', 2);

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

  -- 382. 自然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自然', 'しぜん', '자연', '自(스스로 자): 스스로
然(그럴 연): 그러함', '명사', 382, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自然に囲まれている。', '자연에 둘러싸여 있다.', 1),
    (w, '自然を保護しよう。', '자연을 보호하자.', 2);

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

  -- 413. 細かい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '細かい', 'こまかい', '자세하다, 잘게', '細(가늘 세): 아주 작음
い형용사', 'い형용사', 413, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '細かい意説明だ。', '자세한 설명이다.', 1),
    (w, '細かくキャベツを切る。', '양배추를 가늘게 자른다.', 2);

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

  -- 424. 自由
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自由', 'じゆう', '자유', '自(스스로 자): 스스로
由(말미암을 유): 따르다·의존', 'な형용사', 424, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自由に選んでよい。', '자유롭게 골라도 된다.', 1),
    (w, '自由を感じる。', '자유를 느낀다.', 2);

  -- 425. 美しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '美しい', 'うつくしい', '아름답다', '美(아름다운 미): 아름답다
しい 형용사형', 'い형용사', 425, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '美しい風景だ。', '아름다운 풍경이다.', 1),
    (w, 'ドレス姿が美しい。', '드레스 차림이 아름답다.', 2);

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

  -- 428. 案内
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '案内', 'あんない', '안내', '案(책상 안): 계획·제안
内(안 내): 안·안쪽', '명사', 428, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '観光案内をした。', '관광 안내를 했다.', 1),
    (w, '案内してもらった。', '안내받았다.', 2);

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

  -- 432. 自信
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '自信', 'じしん', '자신감', '自(스스로 자): 스스로
信(믿을 신): 믿다', '명사', 432, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自信を持ってやろう。', '자신감을 가지고 하자.', 1),
    (w, '自信がない。', '자신감이 없다.', 2);

  -- 433. 印象
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '印象', 'いんしょう', '인상', '印(도장 인): 눈에 새김
象(모양 상): 모양', '명사', 433, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '印象に残る人だ。', '인상에 남는 사람이다.', 1),
    (w, '第一印象が良い。', '첫인상이 좋다.', 2);

  -- 434. 短い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '短い', 'みじかい', '짧다', '短(짧을 단): 길이가 짧음
い형용사', 'い형용사', 434, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '骪を短くした。', '머리를 짧게 잘랐다.', 1),
    (w, '短い休暇をもらった。', '짧은 휴가를 받았다.', 2);

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

  -- 439. 共通
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '共通', 'きょうつう', '공통', '共(함께 공): 함께
通(통할 통): 통함', '명사', 439, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '共通の趣味がある。', '공통 취미가 있다.', 1),
    (w, '共通語は英語だ。', '공용어는 영어다.', 2);

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

  -- 449. 関係
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '関係', 'かんけい', '관계', '関(빗장 관): 연결·관련
係(매달 계): 연결됨', '명사', 449, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達との関係が良い。', '친구와 관계가 좋다.', 1),
    (w, 'これと関係がある。', '그것과 관계가 있다.', 2);

  -- 450. 完成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '完成', 'かんせい', '완성', '完(완전할 완): 완전·끝남
成(이룰 성): 이루어짐', '명사', 450, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品がついに完成した。', '작품이 마침내 완성되었다.', 1),
    (w, '完成はまだ遠い。', '완성은 아직 멀다.', 2);

  -- 451. ～ように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ように', '~ 하도록', '동사 사전형/ない형 + ように\n목적·명령·희망을 나타내는 표현', '문법', 451, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見えるように大きく書いて。', '보이도록 크게 써 주세요.', 1),
    (w, '遅れないように出発した。', '늦지 않도록 출발했다.', 2);

  -- 452. ～ようになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ようになる', '~ 하게 되다 <변화>', '동사 사전형 + ようになる\n능력·상황의 변화를 나타내는 표현', '문법', 452, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語が話せるようになった。', '일본어를 말할 수 있게 되었다.', 1),
    (w, '早起きするようになった。', '일직 일어나게 되었다.', 2);

  -- 453. ～ばいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ばいい', '~ 하면 된다', '동사 가정형(ば) + いい\n해결책 제안·충고 표현', '문법', 453, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと勉強すればいいよ。', '더 공부하면 돼.', 1),
    (w, 'そう言えばいい。', '그렇게 말하면 된다.', 2);

  -- 454. とうとう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'とうとう', '드디어', '한자 項項에서 온 부사\n마침내·드디어 결정적인 순간 강조', '문법', 454, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とうとう試験の日が来た。', '드디어 시험 날이 왔다.', 1),
    (w, 'とうとう完成した。', '드디어 완성했다.', 2);

  -- 455. ～てほしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てほしい', '~ 했으면 좋겠다', '동사 て형 + ほしい\n상대에게 바라는 요구·희망 표현', '문법', 455, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手伝ってほしい。', '도와줬으면 좋겠다.', 1),
    (w, 'そばにいてほしい。', '옆에 있어 줬으면 좋겠다.', 2);

  -- 456. ～にする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～にする', '~ 으로 하다 <결정>', '명사 + にする\n선택·결정을 나타낼', '문법', 456, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーにする。', '커피로 하겠다.', 1),
    (w, '今日は休みにした。', '오늘은 쉬기로 했다.', 2);

  -- 457. ～(さ)せないでください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(さ)せないでください', '~ 하게 하지 마세요', '사역형 + ないでください\n상대가 점 · 대상을 시키도록 막는 부탁', '문법', 457, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に無理をさせないでください。', '아이에게 무리하게 하지 마세요.', 1),
    (w, '心配させないでください。', '걱정시키지 마세요.', 2);

  -- 458. お～いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'お～いたす', '~ 하다 <겸손>', 'お + 동사マス형 + いたす\n겸양 표현(겸양어)', '문법', 458, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お伝えいたします。', '전해 드립니다.', 1),
    (w, 'お振り込みいたしました。', '입금 드린 결제를 마쳄습니다.', 2);

  -- 459. ～させるつもりだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～させるつもりだ', '~ 시킬 작정이다', '사역형 + つもりだ\n타인에게　행동을 시킬 의도 표현', '문법', 459, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に手伝わせるつもりだ。', '아이에게 돕게 할 작정이다.', 1),
    (w, '彼に説明させるつもりだ。', '그에게 설명시킬 작정이다.', 2);

  -- 460. いつのまにか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'いつのまにか', '어느새', 'いつ(언제) + のまにか\n느끼지 못하는 사이에 변화가 일어난 상황', '문법', 460, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつのまにか夜になっていた。', '어느새 밤이 되어 있었다.', 1),
    (w, 'いつのまにか雨が上がっていた。', '어느새 비가 그쳐 있었다.', 2);

  -- 461. ～ために
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ために', '~ 때문에 <원인>', '동사 사전형/명사+の + ために\n목적·원인·이유 표현', '문법', 461, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康のために運動する。', '건강을 위해 운동한다.', 1),
    (w, '雨のために試合が中止になった。', '비 때문에 시합이 중지되었다.', 2);

  -- 462. ～ないうちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ないうちに', '~ 하기 전에', '동사·い형용사 ない형 + うちに\n···하기 전에/···되지 않은 상태일 때 끍내다', '문법', 462, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降らないうちに帰ろう。', '비가 오기 전에 돌아가자.', 1),
    (w, '忘れないうちにメモした。', '잊기 전에 메모했다.', 2);

  -- 463. ～だろうけど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だろうけど', '~ 하겠지만', 'だろう(추측) + けど(대립)\n···하겠지만···　이라는 의미', '문법', 463, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忙しいだろうけど手伝って。', '바쁜겠지만 도와줘.', 1),
    (w, '雨だろうけど出かける。', '비가 올 것 같지만 외출한다.', 2);

  -- 464. ～たびに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たびに', '~ 할 때마다', '동사·명사+の + たびに\n···할 때마다 구조, 반복·동시성 표현', '문법', 464, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会うたびに話しかける。', '만날 때마다 말을 건다.', 1),
    (w, '試合のたびに緊張する。', '시합 때마다 긴장한다.', 2);

  -- 465. あいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あいだ', '~ 하는 동안', '間(あいだ): 사이·기간\n···하는 동안의 시간대 표현', '문법', 465, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学生のあいだはよく勉強した。', '학생인 동안은 열심히 공부했다.', 1),
    (w, '寝ているあいだに電話が鳴った。', '자는 동안 전화가 울렸다.', 2);

  -- 466. いまにも～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'いまにも～そうだ', '금세라도 ~할 것 같다', '今にも(금세라도) + そうだ(양태/상태 추측)\n일어날 개연성이 높은 상황을 나타냄', '문법', 466, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今にも雨が降りそうだ。', '금세라도 비가 올 것 같다.', 1),
    (w, '今にも泣きだそうだ。', '금세라도 울 것 같다.', 2);

  -- 467. ～てあげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てあげる', '~ 해 주다', '동사 て형 + あげる\n타인을 위해 행동해 주는 표현(은혜 제공)', '문법', 467, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟に本を読んであげた。', '동생에게 책을 읽어 줬다.', 1),
    (w, '薬を買ってあげる。', '약을 사 준다.', 2);

  -- 468. いつか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'いつか', '언젠가', 'いつ(언제) + か(불확정)\n언제인지 모르는 미래의 어느 시점', '문법', 468, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつか日本へ行きたい。', '언제가 일본에 가고 싶다.', 1),
    (w, 'いつか会う日を楽しみに。', '언젠가 만날 날을 기대한다.', 2);

  -- 469. ～たらどうでしょう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たらどうでしょう', '~ 하면 어떨까요?', '동사た라 + どうでしょう\n제안·권유 표현', '문법', 469, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休んだらどうでしょう。', '쉬면 어떻겠습니까?', 1),
    (w, '医者に見せたらどうでしょう。', '의사에게 보이면 어떨까요?', 2);

  -- 470. ～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～そうだ', '~ 할 것 같다', '동사マス형/いud615용사　語幹 + そうだ\n외관·상황을 보고 추측하는 표현', '문법', 470, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降りそうだ。', '비가 올 것 같다.', 1),
    (w, 'このケーキ、おいしそうだ。', '이 케이크, 맛있어 보인다.', 2);

  -- 471. ～なら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～なら', '~ 라면', '명사·동사·형용사 기본형 + なら\n가정·주제화 표현(···라면···에 관해서는)', '문법', 471, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日なら会える。', '오늘이라면 만날 수 있다.', 1),
    (w, '電車で行くなら騅しい。', '전철로 간다면 편리하다.', 2);

  -- 472. ～な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～な', '~ 하지 마', '동사 기본형 + な\n강한 금지·명령 표현', '문법', 472, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うるさくするな！', '시끄럽게 하지 마!', 1),
    (w, 'さわるな。', '만지지 마.', 2);

  -- 473. お目にかかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, 'お目にかかる', 'おめにかかる', '만나뵙다 <겸손>', 'お目 + にかかる\n会う(만나다)의 겸양어', '문법', 473, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初めてお目にかかります。', '처음 만나붙겠습니다.', 1),
    (w, '社長にお目にかかった。', '사장님을 만나봬어요.', 2);

  -- 474. うかがう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'うかがう', '찾아뵙다 <겸손>', '伺う: 자리를 먹심 찾아감\n訪る(찾아가다)·聞く(듣다)의 겸양어', '문법', 474, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何時にお宅へうかがいましょうか。', '몇 시에 댓으로 찾아봅을까용?', 1),
    (w, 'よろしければ明日うかがいます。', '괜찮으시면 내일 찾아뷸겠습니다.', 2);

  -- 475. ～ようなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ようなら', '~ 할 것 같으면', '동사·명사 よう형 + なら\n···할 것 같으면···의 경우에는', '문법', 475, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降りそうなら中止だ。', '비가 올 것 같으면 중지다.', 1),
    (w, '遅れるようなら連絡して。', '늦을 것 같으면 연락해.', 2);

  -- 476. ～など
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～など', '~ 등 <나열>', '명사·구 뒤 + など\n예시·열거·축소 표현', '문법', 476, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーや紅茶など。', '커피나 홍차 등.', 1),
    (w, 'テニスや野球などスポーツをした。', '테니스나 야구 등 스포츠를 했다.', 2);

  -- 477. ～させてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～させてください', '~ 하게 해 주세요', '사역형 + てください\n겸양적으로 허가를 구하는 표현', '문법', 477, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '説明させてください。', '설명하게 해 주세요.', 1),
    (w, '休みをとらせてください。', '휴가를 내게 해 주세요.', 2);

  -- 478. ～だけでよければ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけでよければ', '~ 만으로 좋다면', '명사/동사+だけ + よければ\n···만으로 충분하다면···', '문법', 478, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話を聞くだけでよければ、伝えます。', '이야기 듣기만 하면 되시면 전해드릴게요.', 1),
    (w, '見るだけでよければ手伝うよ。', '보는 것만으로 괜찮으시면 돕을게요.', 2);

  -- 479. ～のことで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のことで', '~ 에 관한 일로', '명사 + のことで\n···에 관한 건으로···　일로', '문법', 479, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度の会議のことでお話したい。', '이번 회의에 관한 건으로 이야기하고 싶다.', 1),
    (w, '学費のことで相談したい。', '학비 건으로 상의하고 싶다.', 2);

  -- 480. ～ほしがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ほしがる', '~ 을 원하다', 'い형용사 語幹+がる 구조\n···하고 싶어하다(타인의 희망 표현)', '문법', 480, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妹が人形をほしがっている。', '여동생이 인형을 갖고 싶어한다.', 1),
    (w, '子供がお菓子をほしがっている。', '아이가 과자를 원하고 있다.', 2);

  -- 481. ～までには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～までには', '~ 까지는', '명사·동사 기본형 + までには\n···까지의 기한·최대 시점', '문법', 481, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金要日までには提出してください。', '금요일까지는 제출해 주세요.', 1),
    (w, '帰るまでには連絡するよ。', '돌아올 때까지는 연락할게.', 2);

  -- 482. ～形をしている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '～形をしている', 'かたちをしている', '~ 모습을 하다', '形(かたち) + をしている\n외형·모양을 먹심 나타내는 표현', '문법', 482, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丸い形をしている。', '둥근 모양을 하고 있다.', 1),
    (w, 'ハートの形をしたケーキだ。', '하트 모양을 한 케이크다.', 2);

  -- 483. ～たところだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たところだ', '막 ~한 참이다', '동사 た형 + ところだ\n막 ···한 참이다(완료 직후)', '문법', 483, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今帰ってきたところだ。', '지금 막 돌아온 참이다.', 1),
    (w, 'コーヒーを飲んだところだ。', '커피를 막 마신 참이다.', 2);

  -- 484. ～ような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ような', '~ 와 같은', '명사·동사·형용사 + ような\n···와 같은(비유·예시)', '문법', 484, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '太陽のような人だ。', '태양과 같은 사람이다.', 1),
    (w, '夢のような体験だった。', '꿈과 같은 체험이었다.', 2);

  -- 485. ～なんか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～なんか', '~ 같은 것', 'などか의 구어·쪾은·겸원·겸양 표현\n···이나/견 소멸·머싅쥎·의외의의 난이　강조', '문법', 485, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スポーツなんか興味がない。', '스포츠 같은 건 관심이 없다.', 1),
    (w, '私なんか、どうせ騄口しよ。', '저 같은 사람은 어차피 서투르죠.', 2);

  -- 486. ～だけで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけで', '~ 만으로', '명사·동사 기본형 + だけで\n···만으로···만 해도 됨', '문법', 486, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけで、やりたくない。', '보는 것만으로 하고 싶지 않다.', 1),
    (w, '話を聞くだけで伝わってくる。', '이야기 듣는 것만으로 전해온다.', 2);

  -- 487. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～として', '~ 로서', '명사 + として\n···로서···(자격·입장)', '문법', 487, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代表として出席した。', '대표로서 참석했다.', 1),
    (w, '学生としての本分だ。', '학생으로서의 본분이다.', 2);

  -- 488. ～にくらべて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～にくらべて', '~ 과 비교해서', '명사 + にくらべて\n···와 비교해서···', '문법', 488, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年にくらべて雨が多い。', '작년에 비해 비가 많다.', 1),
    (w, '束京にくらべてソウルは多い。', '도쿄에 비해 서울은 싸다.', 2);

  -- 489. 差し上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '差し上げる', 'さしあげる', '드리다 <겸손>', '差し出す(내밀다) + 上げる(올리다)\n与える(주다)의 겸양어', '문법', 489, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にお取りを差し上げた。', '선생님께 이는돈을 드렸다.', 1),
    (w, '貴重な意見を差し上げます。', '귀중한 의견을 드립니다.', 2);

  -- 490. ～にとって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～にとって', '~ 에게 있어서', '명사 + にとって\n···에게 있어서(입장)', '문법', 490, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供にとって親はすべてだ。', '아이에게 있어서 부모는 전부다.', 1),
    (w, '私にとって大切な人だ。', '나에게 있어서 소중한 사람이다.', 2);

  -- 491. こんなに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'こんなに', '이렇게', 'こう(이　)+ンな(종류)+に\n정도·상태를 강조하는 부사···이렇게···', '문법', 491, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんなによい人はいない。', '이렇게 좋은 사람은 없다.', 0),
    (w, 'こんなに雨が降るとは。', '이렇게 비가 올 줄이야용.', 0);

  -- 492. ～するところだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～するところだ', '~ 하려는 참이다', '동사 사전형+ところだ\n···하려는 참이다(직전)', '문법', 492, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今出かけるところだ。', '지금 출발하려는 참이다.', 0),
    (w, '電話しようとするところだった。', '전화하려던 참이었다.', 0);

  -- 493. どうしたらいいのか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どうしたらいいのか', '어떻게 하면 좋을지', 'どうしたら(어떻게 하면)+いいのか(좋은가)\n해결책을 고민하는 표현', '문법', 493, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしたらいいのかわからない。', '어떻게 해야 할지 모르겠다.', 0),
    (w, 'この問題、どうしたらいいのか。', '이 문제, 어떻게 해야 좋을지?', 0);

  -- 494. ご覧になる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, 'ご覧になる', 'ごらんになる', '보시다 <존경>', 'ご + 覧(볼 람) + になる\n見る(보다)의 존경어', '문법', 494, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画面をご覧になる。', '화면을 보시세요.', 0),
    (w, 'この資料をご覧になる。', '이 자료를 보시도록 하시다.', 0);

  -- 495. ～かもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～かもしれない', '~ 할 지도 모른다', '동사·명사 기본형+かもしれない\n추측·가능성 표현', '문법', 495, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るかもしれない。', '비가 올지도 모른다.', 0),
    (w, '彼はもう帰るかもしれない。', '그는 이미 돌아갔을지도 모른다.', 0);

  -- 496. ～としても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～としても', '~ 라고 할지라도', '동사·명사 기본형+としても\n···라 고 가정해도(역접)', '문법', 496, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るとしても行く。', '비가 온다고 해도 간다.', 0),
    (w, '仕事だとしても選べる。', '일이라고 하더라도 고를 수 있다.', 0);

  -- 497. ～なくて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～なくて', '~ 하지 않아서 <원인>', '동사·いud615용사 ない형+て\n원인·이유의 부정···하지 않아서···', '문법', 497, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そばにいなくて寂しい。', '옆에 없어서 쓸쓸하다.', 0),
    (w, '電話が連絡されなくて仕事不便だ。', '전화가 연락되지 않아서 일을 못 한다.', 0);

  -- 498. ～前に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '～前に', 'まえに', '~ 하기 전에', '前(まえ)의 부사 용법\n···하기 전에(시간적 앞)', '문법', 498, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけるまえに電話した。', '나가기 전에 전화했다.', 0),
    (w, '寝るまえに歯を磨く。', '자기 전에 이를 닦는다.', 0);

  -- 499. ～ていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ていただく', '~ 해 받다 <겸손>', '동사 て형 + いただく\n···해 받다(겸양·은혜 받기)', '문법', 499, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見ていただいてよろしいでしょうか。', '봐 주시면 괜찮으시겠습니죒?', 0),
    (w, '読んでいただきたい。', '읽어 주셨으면 합니다.', 0);

  -- 500. ～てもらえませんか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てもらえませんか', '~ 해 주시겠습니까?', '동사 てud615 + もらえませんか\n···해 주시겠습니까욨(정중한 부탁)', '문법', 500, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手伝ってもらえませんか。', '도와주시겠습니꺴욨?', 0),
    (w, '詳しく説明してもらえませんか。', '자세히 설명해 주시겠습니꺴욨?', 0);

  -- 501. 思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '思う', 'おもう', '~ 할 것이라 생각하다', '思う(생각하다)+···\n동사·형용사 기본형+と思う 구조로 ···할 것으로 생각한다', '문법', 501, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は雨が降ると思う。', '내일은 비가 올 것이라 생각한다.', 0),
    (w, '彼は来ると思うよ。', '그는 올 거라고 생각해.', 0);

  -- 502. ～ば～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ば～ほど', '~ 하면 할수록', '동사·いud615용사 가정형(ば)+동사·いud615용사 기본형+ほど\n정도가 더해질수록 표현', '문법', 502, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えれば考えるほどわからない。', '생각하면 생각할수록 모르겠다.', 0),
    (w, '読めば読むほど面白い。', '읽으면 읽을수록 재미있다.', 0);

  -- 503. たしかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'たしかに', '분명히, 확실하게', '確かに: 確かな(분명한)의 부사형\n확실·동의 표현', '문법', 503, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たしかに自分がやった。', '확실하게 자신이 했다.', 0),
    (w, 'たしかにそうだと思う。', '분명 그렇다고 생각한다.', 0);

  -- 504. ～だけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけ', '~ 뿐', '명사·동사+だけ\n···만(한계·국한)', '문법', 504, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今だけだよ。', '지금 뿐이야.', 0),
    (w, '今日だけ、休む。', '오늘만 쉬겠다.', 0);

  -- 505. ～ためにも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ためにも', '~ 하기 위해서도', '명사/동사+ためにも\n목적의 강조 표현(···하기 위해서도)', '문법', 505, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供のためにも靠金する。', '아이를 위해서도 저금한다.', 0),
    (w, '健康のためにも運動しよう。', '건강을 위해서도 운동하자.', 0);

  -- 506. ～でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～でも', '~ 라도 <예시>', '명사+でも\n···이라도(예시)', '문법', 506, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そばでも食べよう。', '메박이라도 먹자.', 0),
    (w, 'コーヒーでも飲もうか。', '커피라도 마실까욨?', 0);

  -- 507. ～にまで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～にまで', '~ 에까지', '명사+にまで\n···에에까지(계속·공가소·아렋고 한계)', '문법', 507, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同僚にまで話がそれた。', '동료에게차 이야기가 새어 나갔다.', 0),
    (w, '今は世界中にまでされている。', '지금은 전 세계에까지 퍼져 있다.', 0);

  -- 508. 中心に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '中心に', 'ちゅうしんに', '~ 을 중심으로', '中心 + に\n···을 중심으로···　에 의해 운영됨', '문법', 508, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代表を中心に議論が進んだ。', '대표를 중심으로 논의가 진행되었다.', 0),
    (w, '青年を中心に人気だ。', '청년을 중심으로 인기다.', 0);

  -- 509. ～たばかりだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たばかりだ', '막 ~한 참이다', '동사 た형+ばかりだ\n···한　지 얼마 안 됨(완료 직후)', '문법', 509, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今起きたばかりだ。', '지금 막 일어난 참이다.', 0),
    (w, '連休が始まったばかりだ。', '연휴가 막 시작되었다.', 0);

  -- 510. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～はずだ', '( 틀림없이) ~할 것이다', '동사·형용사 기본형+はずだ\n틀림없이·의심 없이 ···할 것이다(확신적 추측)', '문법', 510, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は来るはずだ。', '내일은 올 것이다.', 0),
    (w, 'それはうまくいくはずだ。', '그건 잘 될 것이다.', 0);

  -- 511. ～という
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～という', '~ 라는 <인용, 설명>', 'と+言う 구조\n인용·명칭·설명 표현(···라는)', '문법', 511, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今雨が降ったというよ。', '방금 비가 왔대.', 0),
    (w, 'ススキというドラマだ。', '스스키라는 드라마다.', 0);

  -- 512. ～のだから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のだから', '~ 한 것이니까', 'のだ+から\n이유·근거를 강조하는 원인 표현', '문법', 512, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会ったのだから話せる。', '만난건 만나니까 말할 수 있다.', 0),
    (w, '見たのだから間違いない。', '봤으니까 틀림없다.', 0);

  -- 513. 近くに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '近くに', 'ちかくに', '근처에, 가까이에', '近い(가깝다)+に\n공간·거리의 근접을 나타냄', '문법', 513, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校の近くに公園がある。', '학교 근처에 공원이 있다.', 0),
    (w, 'もっと近くに来て。', '좀 더 가까이에 와.', 0);

  -- 514. ～てもいいんじゃない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てもいいんじゃない', '~ 해도 좋지 않을까?', 'てもいい+んじゃない\n···해도 괜찮을테　장권유(제안)', '문법', 514, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰ってもいいんじゃない。', '돌아가도 괜찮지 않을지?', 0),
    (w, 'もう休んでもいいんじゃない。', '이제 쉬어도 되지 않을지?', 0);

  -- 515. ～たら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たら', '~ 했더니 <발견>', 'たりだと・・・\n　た형 + ら　구조, 우연한 발견 표현', '문법', 515, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見たら出ていた。', '보았더니 나와 있었다.', 0),
    (w, 'ドアを開けたら誰もいなかった。', '문을 열었더니 아무도 없었다.', 0);

  -- 516. ～てもおかしくない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てもおかしくない', '~ 해도 이상하지 않다', 'ても+おかしくない\n···　해도 이상하지 않다(타당성)', '문법', 516, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝ってもおかしくない。', '이겨도 이상하지 않다.', 0),
    (w, '泣いてもおかしくないよ。', '울어도 이상하지 않아.', 0);

  -- 517. 比べて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '比べて', 'くらべて', '~ 과 비교해서', '比べる(비교하다)+て\n···과 비교해서···', '문법', 517, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年に比べて火染が多い。', '작년에 비해 온화하다.', 0),
    (w, '兄に比べて背が高い。', '형에 비해 키가 크다.', 0);

  -- 518. ～がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～がる', '~ 해 하다', 'いud615용사 語幹+がる\n···한 느낌·감정을 나타낼(제3자)', '문법', 518, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妹が参加したがっている。', '여동생이 참석하고 싶어한다.', 0),
    (w, '子供が寒がっている。', '아이가 추워한다.', 0);

  -- 519. ～には
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～には', '~ 하려면 <목적>', '동사　사전형+には\n목적 표현(···하기 위해서는)', '문법', 519, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くには鉄道が一番だ。', '가려면 철도가 최고다.', 0),
    (w, '勝つには努力が必要だ。', '이기려면 노력이 필요하다.', 0);

  -- 520. ～(さ)せてあげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(さ)せてあげる', '~ 하게 해 주다', '사역형+てあげる\n타인이　···하게 해주다(은혜)', '문법', 520, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に選ばせてあげる。', '아이에게 고르게 해 준다.', 0),
    (w, '弟にゲームをさせてあげた。', '동생에게 게임을 하게 해 줬다.', 0);

  -- 521. ～にくい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～にくい', '~ 하기 어렵다', '동사 マud615+にくい\n···하기 어렵다(난이도)', '문법', 521, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見わかりにくい話だ。', '이해하기 어려운 이야기다.', 0),
    (w, 'このペンは書きにくい。', '이 펀은 쓰기 어렵다.', 0);

  -- 522. ～への
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～への', '~ 로의', 'へ+の\n방향·대상을 수식하는 조사···　로의', '문법', 522, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来への不安がある。', '장래에 대한 불안이 있다.', 0),
    (w, '友達への手紙を書く。', '친구에게 보내는 편지를 쓴다.', 0);

  -- 523. あんなに～のに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あんなに～のに', '그렇게나 ~데도', 'あんなに(그렇게)+のに\n예상·기대와 차이 난다는 표현', '문법', 523, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あんなに亲切にしたのに。', '그렇게나 친절했는데.', 0),
    (w, 'あんなに勉強したのに不合格だった。', '그렇게나 공부했는데 도 불합격이었다.', 0);

  -- 524. ～を
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～を', '~ 을, ~를', '명사+を\n목적격 조사', '문법', 524, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーを飲む。', '커피를 마신다.', 0),
    (w, '本を読む。', '책을 읽는다.', 0);

  -- 525. どこからでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どこからでも', '어디서든', 'どこ(어디)+から(···부터)+でも(···라도)\n장소·조건에 상관 없이　엀디서든', '문법', 525, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この仕事はどこからでもできる。', '이 일은 어디서든 할 수 있다.', 0),
    (w, 'どこからでも説明してよ。', '어디서든 설명해도 괜찮아.', 0);

  -- 526. ～らしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～らしい', '~ 답다', '명사+らしい\n그답게·····의 특징을 잘 나타내는', '문법', 526, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学生らしい服装だ。', '학생답은 복장이다.', 0),
    (w, '男らしい態度を見せる。', '남자다운 태도를 보인다.', 0);

  -- 527. ～ためなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ためなら', '~ 을 위해서라면', '명사/동사+ためなら\n결의 강조 표현(···　을 위해서라면)', '문법', 527, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族のためなら何でもしよう。', '가족을 위해서라면 뭐든 해니하겠다.', 0),
    (w, '幼い妹のためなら。', '어린 여동생을 위해서라면.', 0);

  -- 528. ～ないように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ないように', '~ 하지 않도록', '동사 ないud615+ように\n그　　행위가 일어나지 않도록 하는　주의', '문법', 528, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忘れないようにメモした。', '잊지 않도록 메모했다.', 0),
    (w, '起きないように静かにして。', '일어나지 않도록 조용히 해.', 0);

  -- 529. ああ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ああ', '저렇게', 'ああ: 　지시 부사 　자·타자가 서로 멐···와 관련\n　　몋····그　　세 대상이 몀···그렇게 한 번···', '문법', 529, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ああやったらよかったのに。', '저렇게 했으면 좋았을 테데.', 0),
    (w, 'ああ言う人もいるんだ。', '저러게 말하는 사람도 있을 테　　명　명.', 0);

  -- 530. ～ろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ろ', '~ 해 <명령>', '동사 명령형 어미 ろ\n강한 명령·부탁', '문법', 530, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さっさと走れ！', '빨리 뛰어!', 0),
    (w, 'もっと読め。', '더 읽어.', 0);

  -- 531. ご～いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ご～いたす', '~ 합니다 <겸손>', 'ご + 동사マス형 + いたす\n겸양 표현(겸양어 패턴)', '문법', 531, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご招待いたします。', '압대해 드립니다.', 0),
    (w, 'ご連絡いたします。', '연락 드리겠습니다.', 0);

  -- 532. ～でなくてもよければ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～でなくてもよければ', '~ 아니라도 좋다면', 'でない+ても+よければ\n　···　이 아니어도 되셔주면', '문법', 532, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新品でなくてよければこれもあるよ。', '신품이 아니어도 되시면 이것도 있어요.', 0),
    (w, '古いテッダでなくてよければ、これもうんだよ。', '온실도 아니니며 아니어도 괜찮으시면 이것도 있죠.', 0);

  -- 533. 存じだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '存じだ', 'ぞんじだ', '아시다, 알고 계시다 <존경>', '存じる(知っている)의 존경형 · ご存じだ\n알고 계신다(존경어)', '문법', 533, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この人をご存じだですか。', '이 사람을 알고 계시게 있어요?', 0),
    (w, 'その件はご存じだと思います。', '그 건은 알고 계시리라 생각합니다.', 0);

  -- 534. ～か
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～か', '~ 할지', '　···+か(의문)\n···할지(간접의문)', '문법', 534, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何を買うか考えている。', '뭐를 살지 생각하고 있다.', 0),
    (w, '今送るかわからない。', '지금 보낼지 모르겠다.', 0);

  -- 535. ～たりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たりする', '~ 하기도 한다', 'たり+する\n수의 행위　중 하나 큅···하기도 하고 ···하기도 한다', '문법', 535, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歌ったり踊ったりした。', '노래도 부르고 춤도 췄다.', 0),
    (w, '休日は本を読んだり映画を見たりする。', '···일에는 책···　도 읽고 영화···도 본다.', 0);

  -- 536. 比べて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '比べて', 'くらべて', '~ 과 비교해서', '比べる(비교하다)+て\n···과 비교해서', '문법', 536, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '以前に比べてよくなった。', '이전에 비해 좋아졌다.', 0),
    (w, '去年に比べて人口が減った。', '작년에 비해 인구가 줄었다.', 0);

  -- 537. ～んじゃなくて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～んじゃなくて', '~ 한 것이 아니라', 'んだ+んじゃなくて\n···한 것이 아니라(설명)', '문법', 537, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見たんじゃなくて言っただけだ。', '본 것이 아니라 말한 것뿐이다.', 0),
    (w, 'ちがうんじゃなくて似ているだけだ。', '다른 것이 아니라 닮은 것뿐이다.', 0);

  -- 538. ～でも何でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '～でも何でも', 'なんでも', '~ 이든 무엇이든', '何でも(뭐든)\n종류·대상을 가리지 않고', '문법', 538, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんでも伝えてよ。', '뭐든 말해도 돼.', 0),
    (w, 'なんでも使える道具だ。', '머든 쓸 수 있는 도구다.', 0);

  -- 539. もう～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'もう～ない', '이미 ~하지 않는다', 'もう+···+ない\n이제　이상 ···하지　않는다', '문법', 539, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう泺かない。', '이제 울지 않는다.', 0),
    (w, 'もう酒は飲まない。', '이제 술은 마시지 않는다.', 0);

  -- 540. ～ぐらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ぐらい', '~ 정도', '명사+ぐらい\n···　정도(쪾·굼·)', '문법', 540, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーぐらい飲もうよ。', '커피 정도 마시자.', 0),
    (w, '三十分ぐらいかかる。', '30분 정도 걸린다.', 0);

  -- 541. 次第に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '次第に', 'しだいに', '점차, 점점', '次第(순서)+に\n조금식 조금식 진행되는 양상', '문법', 541, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '次第に暖かくなる。', '점차 따뜻해진다.', 0),
    (w, '次第に慎れてきた。', '점점 익숙해졌다.', 0);

  -- 542. ～(よ)うとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(よ)うとする', '~ 하려고 하다', '동사 意志ud615+とする\n···하려고 하다(의도·시도)', '문법', 542, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけようとした時、雨が降った。', '나가려고 했을 때 비가 왔다.', 0),
    (w, '話そうとしたが見めた。', '말하려 했지만 그만둡다.', 0);

  -- 543. ～になら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～になら', '~ 에게라면', '명사+に+なら\n···에게라면(대상 한정)', '문법', 543, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼になら任せる。', '그에게라면 맡길 수 있다.', 0),
    (w, '先生になら許してもらえる。', '선생님에게라면 허락받을 수 있다.', 0);

  -- 544. ～たまま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たまま', '~ 한 채', '동사 たud615 + まま\n···한 상태 그대로···', '문법', 544, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビをつけたまま寝てしまった。', 'TV를 켜둔 채 잠들어 버렸다.', 0),
    (w, '窓を開けたまま出かけた。', '창문을 열어둔 채 나갔다.', 0);

  -- 545. ～せいで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～せいで', '~ 탓에', 'せい(탓)+で\n···　탓에(부정적 원인)', '문법', 545, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨のせいで試合が中止になった。', '비 탓에 경기가 중단되었다.', 0),
    (w, '遅れたせいで上司に叱られた。', '늦은 탓에 상사에게 혼났다.', 0);

  -- 546. ～つもりだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～つもりだ', '~ 할 작정이다', '동사 사전형+つもりだ\n···　할 작정이다(의도)', '문법', 546, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日詰出すつもりだ。', '내일 제출할 작정이다.', 0),
    (w, '帰るつもりだ。', '돌아갈 작정이다.', 0);

  -- 547. ～うちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～うちに', '~ 하는 사이에', '동사 사전형+うちに\n···하는 동안에　(기간)', '문법', 547, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若いうちに勉強しよう。', '점을 때 공부하자.', 0),
    (w, '歌を聞いているうちに眠くなった。', '노래를 들는 사이에 졸리게 되었다.', 0);

  -- 548. いらっしゃる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'いらっしゃる', '계시다 <존경>', '居る(있다)·行く(가다)·来る(오다)의 존경어\nいらっしゃる', '문법', 548, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ようこそいらっしゃいました。', '잘 오셨습니다.', 0),
    (w, '先生はどちらにいらっしゃいますか。', '선생님은 어디에 계세요?', 0);

  -- 549. どれだけ～か
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どれだけ～か', '얼마나 ~한지', 'どれ+だけ+か\n　···　만괴 그 정도는　일어난　명 　명　명아', '문법', 549, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どれだけ公許されたか。', '얼마나 사랑받았는지.', 0),
    (w, 'どれだけ心配したかわかる？', '얼마나 걱정했는지 알아?', 0);

  -- 550. 誰からも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '誰からも', 'だれからも', '누구로부터든', '誰(누구)+から(···로부터)+も\n궜자를 가리지 않고 전···로부터도', '문법', 550, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰からも愛される人だ。', '누구에게서도 사랑받는 사람이다.', 0),
    (w, '誰からも信頼されている。', '누구에게서도 신뢰받아 잇다.', 0);

  -- 551. ～により
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～により', '~ 에 의해서 <원인>', '명사+に+より\n···에 의해(원인·수단)', '문법', 551, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨により試合中止。', '비로 인해 경기 중단.', 0),
    (w, '事故により遡延した。', '사고로 인해 지연되었다.', 0);

  -- 552. ～(さ)せてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(さ)せてください', '~ 하게 해 주세요', '사역형+てください\n···하게　 해 주세요(니　　허　가 구함)', '문법', 552, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休ませてください。', '잠시 쉬게 해 주세요.', 0),
    (w, '説明させてください。', '설명하게 해 주세요.', 0);

  -- 553. ～のか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のか', '~ 인 것인지', '···+のか\n강조적 의문(···　는 것인지)', '문법', 553, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どこで会うのかわからない。', '어디서 만나는 것인지 모르겠다.', 0),
    (w, 'どうして遅れたのか説明して。', '왜 늦은 것인지 설명해.', 0);

  -- 554. ～はじめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～はじめる', '~ 하기 시작하다', '동사マud615+始める\n···하기　　 시작하다(개시)', '문법', 554, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を読み始めた。', '책을 읽기 시작했다.', 0),
    (w, '雨が降り始めた。', '비가 내리기 시작했다.', 0);

  -- 555. ～になるまで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～になるまで', '~ 가 될 때까지', '···+に+なる+まで\n···　　이 될 때까지(종점)', '문법', 555, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜になるまで待とう。', '밤이 될 때까지 기다리자.', 0),
    (w, '上手になるまで練習しよう。', '능숙해질 때까지 연습하자.', 0);

  -- 556. ついに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ついに', '끝내, 마침내', '遡に: 마침내·드디어(결과 강조)', '문법', 556, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ついに多めを見た。', '마침내 꿈을 봤다.', 0),
    (w, 'ついに完成した。', '마침내 완성했다.', 0);

  -- 557. ～てくれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくれ', '~ 해 줘', '동사 て형+くれ\n···　해　줘(명령　)', '문법', 557, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手伝ってくれ。', '도와줘.', 0),
    (w, 'ちょっと見てくれ。', '잠깐 봐줘.', 0);

  -- 558. ～ほかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ほかに', '~ 외에', '他(ほか)+に\n　···　이외에···　더해(추가)', '문법', 558, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他にも何か買おう。', '그 외에도 뭐라도 사자.', 0),
    (w, '他にうんかわせる人はいない。', '다른 자와 이야기할 사람은 없다.', 0);

  -- 559. ～のだったら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のだったら', '~ 하는 것이라면', 'のだ+ったら\n···한　것이라면(근거 조건)', '문법', 559, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '使わないのだったら捨てよう。', '쓰지 않는 것이라면 버리자.', 0),
    (w, '行かないのだったら伝えて。', '안 가는 것이라면 앞으로 알려주.', 0);

  -- 560. ～しか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～しか', '~ 밖에', '···+しか\n···　밖에(한정·부정)', '문법', 560, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今千円しかない。', '지금 천엔밖에 없다.', 0),
    (w, 'これしかない。', '이것밖에 없다.', 0);

  -- 561. ～てくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくれる', '~ 해 주다', 'てud615+くれる\n···　해 주다(은혜)', '문법', 561, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達が手伝ってくれた。', '친구가 도와줬다.', 0),
    (w, '傅がお菓子を送ってくれた。', '그가 과자를 보내 줬다.', 0);

  -- 562. ～だけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけだ', '~ 뿐이다', 'だけ+だ\n···　 뿐이다(한정)', '문법', 562, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何も説明しないだけだ。', '아무 설명도 하지 않을 뿐이다.', 0),
    (w, 'もうそれだけだ。', '이제 그것 뿐이다.', 0);

  -- 563. そう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'そう', '그렇게', 'そう: 대실 이는 지시 부사 　그 양상', '문법', 563, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そう見えるよ。', '그렇게 보이네.', 0),
    (w, 'そう思うよ。', '그렇게 생각해.', 0);

  -- 564. ～(さ)せていただきます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(さ)せていただきます', '~ 하겠습니다 <겸손>', '사역형+ていただきます\n겸양(···해 받겠습니다)', '문법', 564, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませていただきます。', '쉬겠습니다.', 0),
    (w, '拝見させていただきます。', '삼겁게 봐 더린겠습니다.', 0);

  -- 565. ～やすい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～やすい', '~ 하기 쉽다', '　동사マスud615+やすい\n···　하기 쉬다(난이도)', '문법', 565, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は読みやすい。', '이 책은 읽기 쉬운　책이다.', 0),
    (w, 'ワードは使いやすい。', 'Word는 쓰기 쉬다.', 0);

  -- 566. 申す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '申す', 'もうす', '말하다 <겸손>', '言う(말하다)의 겸양·서미을 먹심 겸양···말씀', '문법', 566, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やめておくと申しておく。', '그만두겠다고 말씀해 둡니다.', 0),
    (w, '私は鈴木と申します。', '저는 스즈키라고 합니다.', 0);

  -- 567. ～ておく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ておく', '~ 해 두다', 'てud615+おく\n···　 해 두다(준비·유지)', '문법', 567, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日のために買っておく。', '내일을 위해 사 둔다.', 0),
    (w, '記録しておく。', '기록해 둔다.', 0);

  -- 568. 少しも～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '少しも～ない', 'すこしも～ない', '조금도 ~않는다', '少しも(조금도)+···+ない\n···조금도 ···하지 않는다(전면 부정)', '문법', 568, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少しも反省していない。', '조금도 반성하고 있지 않다.', 0),
    (w, '少しも態度が変わらない。', '조금도 태도가 변하지 않는다.', 0);

  -- 569. おっしゃる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'おっしゃる', '말씀하시다 <존경>', '言う(말하다)의 존경어\n仰しゃる·言われる···이 되어···', '문법', 569, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何とおっしゃいましたか。', '뭐라고 말씀하셨습니김¸용?', 0),
    (w, '先生がそうおっしゃった。', '선생님이 그렇게 말씀하셨다.', 0);

  -- 570. ～ば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ば', '~ 하면', '동사·いない　형용사 가정형 ば\n가정·명렌 표현(···하면)', '문법', 570, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安ければ買う。', '싸면 사겠다.', 0),
    (w, '必ず勝てるよ。', '다면 꼭 이길 수 있으면 해.', 0);

  -- 571. ～としたら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～としたら', '~ 한다고 하면', 'としたら: 가정을 나타냄. ···한다고 하면', '문법', 571, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くとしたら何時。', '간다고 하면 몇 시?', 0),
    (w, '選べるとしたら、こちらだ。', '고른다고 하면 이쪽이다.', 0);

  -- 572. お～ください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'お～ください', '~ 해 주십시오 <존경>', 'お + 동사マud615 + ください. 존경 명령', '문법', 572, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しばらくお待ちください。', '잠시 기다려 주십시오.', 0),
    (w, 'こちらへお乗りください。', '이쪽으로 타 주십시오.', 0);

  -- 573. ～たくても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たくても', '~ 하고 싶어도', '　동사たud615+ても. 강한 희망에도 조건 제약', '문법', 573, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買いたくても金がない。', '사고 싶어도 돈이 없다.', 0),
    (w, '行きたくても行けない。', '가고 싶어도 갈 수 없다.', 0);

  -- 574. 不思議ではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '不思議ではない', 'ふしぎではない', '~ 해도 이상하지 않다', '不思議(신기·이상함)+ではない. ···　해도 이상하지 않다(타당성)', '문법', 574, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝てるのも不思議ではない。', '이겼어도 이상하지 않다.', 0),
    (w, '態度が悚り夫るも不思議ではない。', '화가 나도 이상하지 않다.', 0);

  -- 575. ～ないと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ないと', '~ 하지 않으면', '　동사·い　형용사 ないud615+と. 조건·의무(···하지 않으면)', '문법', 575, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学勉しないと不合格だよ。', '공부하지 않으면 불합격이야.', 0),
    (w, '急がないと遅れるよ。', '서두르지 않으면 늦을　면 늦게·명·명·　.', 0);

  -- 576. ～ましょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ましょうか', '~ 할까요?', '동사 マしud615+んか。 제안·의향을 물음', '문법', 576, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一緒に行きましょうか。', '같이 갈까욨?', 0),
    (w, '小し休みましょうか。', '잠시 쉬쉜금욨?', 0);

  -- 577. 伴う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '伴う', 'ともなう', '~ 에 따라', '伴う(동반하다)+て. ···에 따라 같이 일어난···', '문법', 577, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '老齢に伴って記憶が衰える。', '노화에 따라 기억력이 쇠해는　.', 0),
    (w, '収入に伴って支出も増えた。', '수입에 따라 지출도 늘었다.', 0);

  -- 578. ～たがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～たがる', '~ 하고 싶어 하다', '동사 たいud615 の た+がる. 제3자가 ···　하고 싶어함', '문법', 578, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が手伝いたがっている。', '아이가 돕고 싶어한다.', 0),
    (w, '弟がゲームをしたがっている。', '동생이 게임을 하고 싶어한다.', 0);

  -- 579. ～だけでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけでも', '~ 만이라도', 'だけ+で+も. ···　만이라도(최소 한계)', '문법', 579, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけでも多鎖いよ。', '보는 것만이라도 난 좋아.', 0),
    (w, '一言だけでもよいよ。', '한마디만이라도 괜찮아.', 0);

  -- 580. ～てから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てから', '~ 하고 나서', '동사てud615+から. ···　 하고 나서(순서)', '문법', 580, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手を洗ってから食べよう。', '손을 씀고　 먹자.', 0),
    (w, 'コーヒーを飲んでから出かけた。', '커피를 마시고 나서 나갔다.', 0);

  -- 581. ～てしまいたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てしまいたい', '~ 해 버리고 싶다', 'てud615+しまう+たい. ···　　 완전히　···하고 싶다(완료 희망)', '문법', 581, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日中にやってしまいたい。', '오늘 안으로 다 해　버리고 싶다.', 0),
    (w, '忘れてしまいたい。', '잊어버리고 싶다.', 0);

  -- 582. ～てしまう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てしまう', '~ 해 버리다', 'てud615+しまう. 완료·유감·떨떨함', '문법', 582, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '完したダジェットを読んでしまった。', '소설을 다 읽어 버렸다.', 0),
    (w, '走って軽てしまった。', '뛰어가　넘어져　버렸다.', 0);

  -- 583. なんて～だろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なんて～だろう', '얼마나 ~란 말인가', 'なんて+···+だろう. 감탄·강조 표현', '문법', 583, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんて難しい質問だろう。', '얼마나 어려운 질문인가.', 0),
    (w, 'なんて領身だろう。', '얼마나 먋진가.', 0);

  -- 584. ～ため
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ため', '~ 때문에', 'ため(원인·이유). ···　 때문에', '문법', 584, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨のため中止になった。', '비 때문에 중지되었다.', 0),
    (w, '事故のため遡延になった。', '사고 때문에 지연되었다.', 0);

  -- 585. あと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あと', '＋ 시간 표현 앞으로', '　後(あと)+수자·시간. 앞으로 ···　　몇 ···　몇 ···', '문법', 585, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あと3分で出発だ。', '앞으로 3분 후 출발이다.', 0),
    (w, 'あと十年で退職だ。', '앞으로 10년이면 퇴직이다.', 0);

  -- 586. ～てみる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てみる', '~ 해 보다', 'てud615+見る. ···　 해 보다(시도)', '문법', 586, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このケーキを食べて見て。', '이 케이크 먹어봐.', 0),
    (w, 'その錦を読んで見たい。', '그 책을 읽어 보고 싶다.', 0);

  -- 587. いただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'いただく', '받다 <겸손>', 'もらう(받다)의 겸양어. 머리에 소중한 것을 올린다는 뜿', '문법', 587, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貴重なプレゼントをいただきました。', '귀중한 선물을 받았습니다.', 0),
    (w, 'よろしくいただきます。', '잘 부탁해 받겠습니다.', 0);

  -- 588. ～しか～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～しか～ない', '~ 밖에 ~않는다', 'しか+···+ない. ···밖에 없다(제한·부정)', '문법', 588, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今一人しかいない。', '지금 한 명밖에 없다.', 0),
    (w, '今千円しか持っていない。', '지금 천원밖에 안 가지고 있다.', 0);

  -- 589. ～ても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ても', '~ 해도 <역접>', '　동사てud615+も. 역접(···　하　　도)', '문법', 589, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っても出かける。', '비가 와도 나간다.', 0),
    (w, '面接しても不合格だった。', '면접을 봐도 불합격이었다.', 0);

  -- 590. ～というような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～というような', '~ 라는 것 같은', 'という+ような. ···　이라고 할 것 같은(설명)', '문법', 590, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やめるというような例だ。', '···　 그만둔다라는··· 예이다.', 0),
    (w, 'よいというような評価だ。', '좋다는 정을 든 의견이다.', 0);

  -- 591. ～ことで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ことで', '~ 것 때문에 <원인>', '　명사·동사 사전형+こと+で. ···　한 것　　 때문에', '문법', 591, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れたことで叱られた。', '늦은 것 때문에 혼났다.', 0),
    (w, '見たことで思い出した。', '본 것 때문에 떠올랐다.', 0);

  -- 592. ～てもらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てもらう', '~ 해 받다(상대로부터 받다)', 'てud615+もらう. ···　 해 받다(석외 행위)', '문법', 592, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に手伝ってもらった。', '친구에게 도움을 받았다.', 0),
    (w, '見てもらう。', '보게 해 부탁한다.', 0);

  -- 593. ～だって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だって', '~ 라도 <회화체>', 'だ+って. 어떻 구어체(···　이라도)', '문법', 593, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーだって飲めるよ。', '커피라도 마실 수 있어.', 0),
    (w, '妹だって会いたいよ。', '여동생이도 만나고 싶어.', 0);

  -- 594. ちっとも～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ちっとも～ない', '조금도 ~않는다', 'ちっとも+···+ない. 조금도 ···　 않는다(강한 부정)', '문법', 594, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ちっとも反省していない。', '조금도 반성하고 있지 않다.', 0),
    (w, 'ちっとも態度が変わらない。', '조금도 태도가 변하지 않는다.', 0);

  -- 595. どんなに～ことか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どんなに～ことか', '얼마나 ~한 일인지', '　どんなに+···용·+ことか. ···　 얼마나···　한 일인지(감탄)', '문법', 595, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんなにうれしいことか。', '얼마나 기쁜 일인가.', 0),
    (w, 'どんなに靠シいことか。', '얼마나 힘든 일인가.', 0);

  -- 596. やらせてやる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, 'やらせてやる', 'やらせてやる', '시켜 주다', '　사역형+て+やる. ···　 시켜 주다(석외와 허광)', '문법', 596, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に一人でやらせてやろう。', '아이에게 혼자 하게 시켜 주자.', 0),
    (w, '妹にやりたいようにやらせてやった。', '여동생이 하고 싶어 하는 대로 시켜 줬다.', 0);

  -- 597. ～ほど～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ほど～ない', '~ 만큼 ~않는다', '　···　의·　+ほど+···+ない. ···　　···　 정도는 아니다(비교)', '문법', 597, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思うほど恋しくはない。', '생각한 만큼 무서운지는 않다.', 0),
    (w, '恋げるほど重くない。', '들 정도로 무겁지　 않다.', 0);

  -- 598. ～おかげだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～おかげだ', '~ 덕분이다', '···+おかげ+だ. ···　 덕분이다(긍정적 원인)', '문법', 598, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あなたのおかげだよ。', '당신 덕분이에요.', 0),
    (w, '見たおかげで勝てた。', '보며 도와 덕에　 이겼다.', 0);

  -- 599. 多分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '多分', 'たぶん', '아마', '多分(아마도)의 한자 어원. 추측·가능성', '문법', 599, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たぶん彼は来るよ。', '아마 그는 올 거야.', 0),
    (w, 'たぶん雨が降るだろう。', '아마 비가 올 것이다.', 0);

  -- 600. ～するまで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～するまで', '~ 할 때까지', '···+する+まで. ···　 할 때까지(종점)', '문법', 600, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功するまで頗張る。', '성공할 때까지 힘내자.', 0),
    (w, '完成するまで休めない。', '완성될 때까지 쉬지 않겠다.', 0);

  -- 601. 方がいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '方がいい', 'ほうがいい', '~ 하는 편이 좋다', '方(쪽·방향)+が+いい. 조언·추천　(···하는 편이 좋다)', '문법', 601, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者に見せた方がいい。', '의사에게 보이는 편이 좋다.', 0),
    (w, '早めに休んだ方がいいよ。', '일짐 쉬는 편이 좋아.', 0);

  -- 602. ～だけでなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけでなく', '~ 뿐만 아니라', 'だけ+で+なく. ···　뿐만 아니라(추가)', '문법', 602, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけでなく読むもした。', '보기만 아니라 읽기도 했다.', 0),
    (w, '友達だけでなく家族も来た。', '친구뿐만 아니라 가족도 왔다.', 0);

  -- 603. 一つに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '一つに', 'ひとつに', '~ 중의 하나로', '一つ(하나)+に. ···　 중의 하나로', '문법', 603, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高職生の悩みの一つに進路がある。', '고등학생의 고민 중 하나로 진로가 있다.', 0),
    (w, '趣味の一つに読書だ。', '취미 중 하나로 독서다.', 0);

  -- 604. 言われると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '言われると', 'いわれると', '말을 들으면 <수동>', '言われる(말해지다)+と. ···이라고 들으면', '문법', 604, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古いと言われると反証したくなる。', '대다　하다고 들으면 반박하고 싶어진다.', 0),
    (w, 'だめだと言われると衰しい。', '안 된다고 들으면 슬프다.', 0);

  -- 605. ～まで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～まで', '~ 까지', '···+まで. ···　까지(범위·한계)', '문법', 605, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校まで走った。', '학교까지 뛰었다.', 0),
    (w, '昨日まで雨だった。', '어제까지 비였다.', 0);

  -- 606. お～になる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'お～になる', '~ 하시다 <존경>', 'お+동사マud615+になる. 존경 표현', '문법', 606, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生がお許しになる。', '선생님께서 웃으시다.', 0),
    (w, 'どちらをお選びになりますか。', '어느 것을 고르시겠습니까?', 0);

  -- 607. ～よりも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～よりも', '~ 보다도', '　より+も. ···　보다도(강조)', '문법', 607, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年は去年よりも暑い。', '올해는 작년보다도 더운　.', 0),
    (w, '見るよりも読む方がいい。', '보는 것보다도 읽는 편이 좋다.', 0);

  -- 608. 最も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '最も', 'もっとも', '가장, 제일', '最も(もっとも): 제일·가장(최상급)', '문법', 608, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっともうれしいだった。', '가장 기쯤다.', 0),
    (w, 'クラスでもっとも背が高い。', '클래스에서 제일 키가 크다.', 0);

  -- 609. ～だけは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～だけは', '~ 만은', 'だけ+は. ···만은(제한·강조)', '문법', 609, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それだけはしないよ。', '그것만은 하지 않아.', 0),
    (w, 'これだけは許して。', '이것만은 용서해 줘.', 0);

  -- 610. ～てやる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てやる', '~ 해 주다', 'てud615+やる. ···　 해 주다(몽쓰게 일곳 대상)', '문법', 610, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に本を読んでやる。', '아이에게 책을 읽어 준다.', 0),
    (w, '犬にエサをやる。', '개에게 먹이를 준다.', 0);

  -- 611. ～と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～と', '~ 하면', '　と. ···　하면(자　·조건·자연적 결과)', '문법', 611, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボタンを押すとドアが開く。', '버튼을 누르면 문이 열린다.', 0),
    (w, '春になると花が咲く。', '봄이 되면 꽃이 핌다.', 0);

  -- 612. ～で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～で', '~ 중에서 <범위의 한정>', '···+で. 장소·도구·범위　의 한정', '문법', 612, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスで一番うれしい。', '클래스에서 제일 기쯤다.', 0),
    (w, '日本で一番高い山だ。', '일본에서 제일 높은 산이다.', 0);

  -- 613. 音がする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '音がする', 'おとがする', '소리가 나다', '音(소리)+がする. 소리가 나다(공감각)', '문법', 613, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外で何か音がする。', '밖에서 뭐가 소리가 난다.', 0),
    (w, '太鼓の音がする。', '북 소리가 난다.', 0);

  -- 614. ～のに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のに', '~ 인데도', '　···+のに. ···인데도(역접)', '문법', 614, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強したのに不合格だった。', '공부했는데도 불합격이었다.', 0),
    (w, '雨なのに出かけた。', '비가 오는데도 나갔다.', 0);

  -- 615. ～の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～の', '연체수식절의 の', '　···+の. 연체수식절의 주격 표지', '문법', 615, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の作ったケーキだ。', '그가 만들어 챌 케이크다.', 0),
    (w, '私の読んだ本だ。', '내가 읽은 책이다.', 0);

  -- 616. だれも～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'だれも～ない', '아무도 ~않는다', '誰+も+···+ない. 아무도 ···　 않는다(전면 부정)', '문법', 616, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰も会議に来ない。', '아무도 회의에 오지 않는다.', 0),
    (w, '誰もわからない。', '아무도 모른다.', 0);

  -- 617. ～ながら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ながら', '~ 하면서', '동사マud615+ながら. 동시성(···하면서)', '문법', 617, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歩きながら話した。', '걷으면서 이야기했다.', 0),
    (w, '音楽を聞きながら勉強する。', '음악을 들으면서 공부한다.', 0);

  -- 618. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ことから', '~ 것으로부터', 'こと+から. ···　　근거·원인(···이므로)', '문법', 618, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安いことからに人気だ。', '슼다는 것으로적　 원인으로 인기다.', 0),
    (w, '広いことからとても使いやすい。', '넓다는 점으로 쓰기 편하다.', 0);

  -- 619. あまりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'あまりに', '너무나', '余り(あまり)+に. 도가 지나치게, 너무나(국장)', '문법', 619, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あまりにわたしい話だ。', '너무나 소쓘한 이야기다.', 0),
    (w, 'あまりにも咲くてコケてしまった。', '너무 달려서 몽하고 말았다.', 0);

  -- 620. どうしてかというと～からだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'どうしてかというと～からだ', '어째서인가 하면 ~때문이다', 'どうしてかと+言う+と+···+からだ. 원인　·이유 설명', '문법', 620, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしてかというと忙しいからだ。', '왜냐하면 바쁜 때문이다.', 0),
    (w, 'どうしてかというと雨が降ったからだ。', '왜냐하면 비가 왔기 때문이다.', 0);

  -- 621. これまでに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'これまでに', '지금까지', 'これ+まで+に. 지금까지·지금에 이르기까지', '문법', 621, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これまでに太とも見た。', '지금까지 많이 봤다.', 0),
    (w, 'これまでに關ポしておいた。', '지금까지에 끝내 둔 것이다.', 0);

  -- 622. ～のを
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のを', '~ 것을', '···+の+を. 명사·명사···　 명사 회의　 표지', '문법', 622, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学ぶのをやめた。', '배우는 것을 그만뛰었다.', 0),
    (w, '完したのを見た。', '끝난 것을 봤다.', 0);

  -- 623. ～までで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～までで', '~ 까지면, ~까지라도', '···+まで+で. ···까지로···까지면', '문법', 623, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここまでで休みましょう。', '여기까지에 쉬자.', 0),
    (w, '明日までで提出。', '내일까지면 제출.', 0);

  -- 624. ～てくれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくれない', '~ 해 주지 않는다', 'てud615+くれる+ない. ···　　　 해 주지 않는다', '문법', 624, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誡も手伝ってくれない。', '아무도 도와주지 않는다.', 0),
    (w, '見てくれない。', '봐 주지 않는다.', 0);

  -- 625. さらに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'さらに', '게다가, 더욱이', '更に(さらに): 그 위에 더, 더욱', '문법', 625, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さらに、買い足した。', '게다가 더 구입했다.', 0),
    (w, 'さらによい話がある。', '더욱 좋은 이야기가 있다.', 0);

  -- 626. ～というわけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～というわけだ', '~ 인 것이다', 'という+わけ+だ. ···　 그러마 이　　(설명·결론)', '문법', 626, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、出てこないというわけだ。', '즉, 나오지 않은 것이다.', 0),
    (w, '雨のせいで中止になったというわけだ。', '비 탓에 중지되었다는 것이다.', 0);

  -- 627. それには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'それには', '그렇게 하기 위해서는', 'それ+に+は. 그게 따르자면', '문법', 627, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝ちたい。それには努力が必要だ。', '이기고 싶다. 이게 되려면 노력이 필요하다.', 0),
    (w, '会いたい。それには出かけるよ。', '만나고 싶다. 그러면 나가자.', 0);

  -- 628. ところが～のだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ところが～のだ', '그렇지만 ~것이다', 'ところが+···+のだ. ···　 그렇지만 　그　···이다(결론)', '문법', 628, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テストできたと思った。ところが、不合格だったのだ。', '시험··· 잘 보았다 생각했다. 그러자 불합격이었던 것이다.', 0),
    (w, '勝てると見えた。ところが負けたのだ。', '이길 것으로 보였다. 그렇지만 진 것이다.', 0);

  -- 629. つまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'つまり', '즉, 결국', 'つまり: 즉, 결국, 한마디로 요약', '문법', 629, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、不可能だ。', '즉, 불가능하다.', 0),
    (w, 'つまり、よくやるということだ。', '결국, 잘 한다는 것이다.', 0);

  -- 630. ですから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ですから', '그러므로', 'です+から: 그러므로, 조은한 경우의···', '문법', 630, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨です。ですから中止です。', '비입니다. 그러므로 중지입니다.', 0),
    (w, '長いです。ですから叩いています。', '깁니다. 그러므로 피곤합니다.', 0);

  -- 631. ～のだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のだ', '~ 인 것이다', 'のだ　(···　이다)의 설명·강조·원인', '문법', 631, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見たのだよ。', '봤던 것이다.', 0),
    (w, '雨だから中止なのだ。', '비기 때문에 중지인 것이다.', 0);

  -- 632. ～というのは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～というのは', '~ 라는 것은', 'という+の+は. ···　　이라는 것은(정의)', '문법', 632, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '恋というのは難しい。', '사랑이라는 것은 어렵다.', 0),
    (w, '勉強というのは面白い。', '공부라는 것은 재미있다.', 0);

  -- 633. ～ようにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～ようにする', '~ 하도록 하다', 'ように+する. 의식적으로···　　　하도록 하다(습관·노력)', '문법', 633, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れないようにしてください。', '늦지 않도록 해 주세요.', 0),
    (w, '毎日運動するようにしている。', '매일 운동하도록 하고 있다.', 0);

  -- 634. ～てくる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくる', '~ 하기 시작하다', 'てud615+くる. 이전 상태에서 이　　 다가오는 다가온·수안　 변화', '문법', 634, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒くなってきた。', '추워지기 시작했다.', 0),
    (w, '雨が降ってきた。', '비가 오기 시작했다.', 0);

  -- 635. ～なるのでしょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～なるのでしょうか', '~ 인 걸까요?', '····+になる+の+でしょうか. 정중한 추측 의문', '문법', 635, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつ長さになるのでしょうか。', '언제기·명 있　···며···　　　 길이가··· 되는 것을명?', 0),
    (w, '折りたたみになるのでしょうか。', '접는 형태가 되는 것일까요?', 0);

  -- 636. なぜなのか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'なぜなのか', '왜 그런지', '何故(なぜ)+なのか. 정챌 궁금　　 풍기는 의문', '문법', 636, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なぜなのか説明しよ。', '왜 그런지 설명해.', 0),
    (w, 'なぜなのかわからない。', '왜 그런지 모르겠다.', 0);

  -- 637. 同じ～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '同じ～', 'おなじ～', '같은~', '同じ+명사. 동일·일치함', '문법', 637, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同じクラスだ。', '같은 클래스다.', 0),
    (w, '同じケーキを買った。', '같은 케이크를 사제　.', 0);

  -- 638. こういう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'こういう', '이러한', 'こ+ういう. 이런 종류의···　　이러한', '문법', 638, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こういう話はよく聴く。', '이런 이야기는 자주 든다.', 0),
    (w, 'こういう人は誰も思い、···　　　　　ともとりやい。', '이런 사람은 누구도 좋아한다.', 0);

  -- 639. ～からだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～からだ', '~ 때문이다', '···+から+だ. ···　　　 때문이다(이유)', '문법', 639, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れたのは雨が降ったからだ。', '늦은 것은 비가 왔기 때문이다.', 0),
    (w, '見ないのはもう興味がないからだ。', '보지 않는 것은 이제 관심이 없기 때문이다.', 0);

  -- 640. それから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'それから', '그리고', 'それ+から. 그다음으로　(순서·추가)', '문법', 640, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '起きて、それから朝ごはんを食べる。', '일어나서, 그다음 아침을 먹는다.', 0),
    (w, 'それから中で見た。', '그다음 한면 쪽에서 봤다.', 0);

  -- 641. そこで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'そこで', '그래서', 'そこ+で. 그래서　　그러므로(동기·원인)', '문법', 641, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よくとれない。そこで、休めた。', '잠을 잘 자지 못한다. 그래서 쉬었다.', 0),
    (w, '連休だ。そこで邊りに付かうとした。', '연휴이다. 그래서 여행을 가기로 했다.', 0);

  -- 642. 思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '思う', 'おもう', '~ 한 것이라고 생각한다', '思う+···. ···　 고 생각하다', '문법', 642, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そうだと思う。', '그렇다고 생각한다.', 0),
    (w, 'うまくいくと思う。', '잘 될　 거라고 생각한다.', 0);

  -- 643. それとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'それとも', '그렇지 않으면', 'それ+とも. 그렇지 않으면(둘 중 하나 선택)', '문법', 643, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒー、それとも紅茶。', '커피, 아니면 홍차?', 0),
    (w, '行くの、それともやめるの。', '갈건가, 그렇지 않으면 그만둘 거야?', 0);

  -- 644. 知りました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '知りました', 'しりました', '알았습니다', '知る(알다)의 과거형 정중체. 이해·수락　　　　　　의사', '문법', 644, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はい、知りました。', '네, 알겠습니다.', 0),
    (w, 'これから気をつけます。知りました。', '앞으로 주의하겠습니다. 알겠습니다.', 0);

  -- 645. しかし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'しかし', '그러나', 'しかし: 그러나·하지만(역접 접속)', '문법', 645, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だ。しかし中止しない。', '비다. 그러나 중지하지 않는다.', 0),
    (w, '態れている。しかし、順調だ。', '피곤하다. 그러나 순조롭다.', 0);

  -- 646. その～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'その～', '그~', 'その+명사. 이미 언급한 그　　　　　　　', '문법', 646, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その人は誰だろう。', '그 사람은 누구일까?', 0),
    (w, 'その件はもう代わった。', '그 건은 이제 끝났다.', 0);

  -- 647. ～のだそうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～のだそうだ', '~ 인 것이라고 한다', 'の+だ+そう+だ. ···　　이라고 한다(전언 의한 설명)', '문법', 647, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ったのだそうだ。', '비가 왔다고 한다.', 0),
    (w, '今連休なのだそうだ。', '지금 연휴이라고 한다.', 0);

  -- 648. 気が付く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '気が付く', 'きがつく', '알아차리다, 깨닫다', '気(い)+が+付く. 알아차리다·깨닫다', '문법', 648, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違いに気が付いた。', '실수를 알아차렸다.', 0),
    (w, '見ても気が付かなかった。', '봐도 알아차리지 못했다.', 0);

  -- 649. ～と言われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '～と言われる', 'いわれる', '~ 라는 말을 듣다', '言われる: 言う(말하다)의 수동형. ···　라는 말을 듣다', '문법', 649, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そう言われても難しい。', '그렇게 말을 들어도 어렵다.', 0),
    (w, '上司に叱られてやると言われた。', '상사에게 해보라고 하는 말을 들었다.', 0);

  -- 650. それ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'それ', '그것', 'それ: 그것(이미 언급한 사물)', '문법', 650, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それを下さい。', '그것을 주세요.', 0),
    (w, 'それは何だ。', '그것은 무엇인가?', 0);

  -- 651. ～てくださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくださる', '~ 해 주시다', 'てud615+下さる. ···　　해 주시다(존경 은혜)', '문법', 651, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生が説明して下さった。', '선생님께서 설명해 주셨다.', 0),
    (w, '送りもたして下さいました。', '마중도 해 주셨습니다.', 0);

  -- 652. ～てあげたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てあげたい', '~ 해 주고 싶다', 'てud615+あげ+たい. ···　 해 주고 싶다', '문법', 652, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に本を読んであげたい。', '아이에게 책을 읽어 주고 싶다.', 0),
    (w, '広めてあげたい。', '칭찬해 주고 싶다.', 0);

  -- 653. そういう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'そういう', '그러한', 'そう+いう. 그런 종류·그렇게···', '문법', 653, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう人もいるよ。', '그런 사람도 있어.', 0),
    (w, 'そういうことはしないように。', '그런 일은 하지 않도록.', 0);

  -- 654. でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'でも', '그렇지만 <접속사>', 'で+も. ···이더라도(접속·역접)', '문법', 654, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい。でも、頗張る。', '어렵다. 그렇지만 노력하겠다.', 0),
    (w, '犬だ。でも、表現が快い。', '개다. 하지만 영리하다.', 0);

  -- 655. ところが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'ところが', '그렇지만', 'ところ+が. 그러나···　　···의외의　　······일이 난　(강한 역접)', '문법', 655, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今起かしいと思った。ところが、面白い。', '재미없을 줄 생각했다. 하지만 재미있었다.', 0),
    (w, '必ず勝てる。ところが負けた。', '반드시 이긴다. 그러나 졌다.', 0);

  -- 656. 世話になりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '世話になりました', 'せわになりました', '신세 많이 졌습니다', '世話(돌봄)+になる의 과거형. 신세 많이 졌습니다', '문법', 656, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はお世話になりました。', '오늘은 신세 많이 졌습니다.', 0),
    (w, '在職中はお世話になりました。', '재직 중에 신세　 많이 졌습니다.', 0);

  -- 657. ～てくださいませんか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～てくださいませんか', '~ 해 주시지 않겠습니까?', 'てud615+ください+ませんか. 겸양적 요청', '문법', 657, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手伝ってくださいませんか。', '도와주시겠습니까?', 0),
    (w, '見せてくださいませんか。', '보여주시겠습니까?', 0);

  -- 658. ～でした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～でした', '~ 이었습니다', 'でした: です　의 과거형', '문법', 658, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '楽しい一日でした。', '즐거운 하루였습니다.', 0),
    (w, '雨でした。', '비였습니다.', 0);

  -- 659. ～みたいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～みたいだ', '~ 한 것 같다', '명사·동사·형용사+みたいだ. ···　　 같다(회화체 추측)', '문법', 659, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るみたいだ。', '비가 올 것 같다.', 0),
    (w, '子供みたいに笑う。', '아이체럼 웃는다.', 0);

  -- 660. すると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'すると', '그러자, 그랬더니', 'する+と. 그러자·그렇게 하니꺴(결과 표현)', '문법', 660, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボタンを押した。するとドアが開いた。', '버튼을 눌렀다. 그런 그러자 문이 열렸다.', 0),
    (w, '彼を呬んだ。すると振り返った。', '그를 불렀다. 그러자 돌아봤다.', 0);

  -- 661. そのころ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'そのころ', '그 무렵', 'その+頃(ころ). 그 무렵(과거 시점)', '문법', 661, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その頃は幸せだった。', '그 무렇 행복했다.', 0),
    (w, 'その頃は長魯がわそうだった。', '그 무렇 마을이 분주했다.', 0);

  -- 662. ～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～も', '~ 도', 'も: ···도(포함·첨가)', '문법', 662, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私も行く。', '나도 간다.', 0),
    (w, 'コーヒーもパンもよい。', '커피도 빵도 다 좋다.', 0);

  -- 663. 気がする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '気がする', 'きがする', '느낌이 들다', '気(い)+が+する. 그런 능낑·느낌이 든다', '문법', 663, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るような気がする。', '비가 올 것 같은 느낌이 든다.', 0),
    (w, 'どこかで会った気がする。', '어디서 만난 것 같은 느낌이 든다.', 0);

  -- 664. こんなこと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'こんなこと', '이런 것', 'こ+んな+こと. 이런 경우·행보', '문법', 664, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんなこともあるんだね。', '이런 일도 있는구나.', 0),
    (w, 'こんなことは初めてだ。', '이런 일은 처음이다.', 0);

  -- 665. 言いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '言いました', 'いいました', '말했습니다', '言う(말하다)의 과거マス　형', '문법', 665, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスで言いましたか。', '클래스에서 말했습니꺴?', 0),
    (w, 'そう言いました。', '그렇게 말했습니다.', 0);

  -- 666. ～の方が
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '～の方が', 'ほうが', '~ 쪽이', '方(ほう)+が. ···　이 좀 더···', '문법', 666, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらの方が靓しい。', '이적 이쪽이 더 시원하다.', 0),
    (w, '走る方が早い。', '뛰는 편이 빠르다.', 0);

  -- 667. けれども
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'けれども', '그렇지만', 'けれども: 그러지만(역접 접속·겸양체)', '문법', 667, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高価だ。けれどもクオリティーがいい。', '비싸다. 하지만 품질이 좋다.', 0),
    (w, '雨だ。けれども出かける。', '비가 온다. 그러어도 나간다.', 0);

  -- 668. 広がって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '広がって', 'ひろがって', '넓어져서', '広がる(넓어지다)+て. 넓어져서·퍼져서', '문법', 668, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が広がってしまった。', '이야기가 퍼지고 말았다.', 0),
    (w, '人気が広がってやゃもるよになった。', '인기가 넓어져 유명해졌다.', 0);

  -- 669. ～かどうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～かどうか', '~ 인지 어떤지', '···+か+どう+か. ···　 인지 어떤지(이면 의문)', '문법', 669, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功するかどうかわからない。', '성공하는지 모르겠다.', 0),
    (w, '選ぶかどうか考えている。', '고를지 어떨지 고민 중.', 0);

  -- 670. ～(さ)せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, '～(さ)せる', '~ 시키다, ~하게 하다', '사역　ud615 させる. ···을 시키다·강제 한다', '문법', 670, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟に金を付けさせた。', '동생에게　　 이를 닦쿦　　고　 돈을 붙이게 했다.', 0),
    (w, '子供に勉強させる。', '아이에게 공부를 시킨다.', 0);

  -- 671. それでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, NULL, 'それでも', '그렇지만', 'それ+で+も. ···　 그래도(역접·그도 불구)', '문법', 671, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反対された。それでも、進める。', '반대받았다. 그래도 추진한다.', 0),
    (w, '難しい。それでもやる。', '어렵다. 그래도 하겠다.', 0);

  -- 672. 行ってみることにしました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n3, '行ってみることにしました', 'いってみることにしました', '가 보기로 했습니다', '行ってみる(가 보다)+ことにする(하기로 하다)+ました. 결정 표현', '문법', 672, array['pdf_extracted','no_etymology','no_examples']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その店に行ってみることにしました。', '그 가게에 가 보기로 했습니다.', 0),
    (w, '明日行ってみることにしました。', '내일 가 보기로 했습니다.', 0);

end $$;
