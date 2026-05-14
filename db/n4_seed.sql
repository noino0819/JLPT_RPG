-- ============================================================
-- JLPT N4 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N4-단어장)
-- ============================================================
-- 실행 시 기존 N4 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 337단어/표현 (288개 어휘 + 유의어 페어 49쌍 / 의미·한자어원·예문 2개씩)
-- ============================================================

delete from public.words
where deck_id in (
  select id from public.decks
  where is_official and jlpt_level = 'N4'
);

do $$
declare
  d_n4 uuid;
  w   uuid;
begin
  select id into d_n4
  from public.decks
  where is_official and jlpt_level = 'N4'
  limit 1;

  -- 1. 経験
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '経験', 'けいけん', '경험', '経(지날 경): 실(糸)이 길게 이어진 경로
験(증험할 험): 말(馬)을 시험해 봄', '명사', 1, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '海外で働いた経験があります。', '해외에서 일한 경험이 있습니다.', 1),
    (w, 'いろいろな経験を積みたい。', '다양한 경험을 쌓고 싶다.', 2);

  -- 2. 間違える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '間違える', 'まちがえる', '틀리다, 잘못 알다', '間(사이 간): 문(門) 사이로 햇빛(日)이 들어옴\n違(어긋날 위): 어긋나서 다름\n+ える(타동사화)', '동사', 2, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を間違えてしまいました。', '이름을 잘못 알았습니다.', 1),
    (w, '答えを間違えた。', '답을 틀렸다.', 2);

  -- 3. 簡単
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '簡単', 'かんたん', '간단함', '簡(대쪽 간): 대나무(竹)에 적은 글, 간략함\n単(홑 단): 하나뿐임', 'な형용사', 3, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題は簡単です。', '이 문제는 간단합니다.', 1),
    (w, '簡単な日本語で話してください。', '간단한 일본어로 말해 주세요.', 2);

  -- 1001. 開ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '開ける', 'あける', '(문을) 열다', '開(열 개): 문(門) 안의 빗장(一)을 두 손(廾)으로 들어 올려 여는 모양', '동사', 1001, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアを開けてください。', '문을 열어 주세요.', 1),
    (w, '窓を開けて空気を入れた。', '창문을 열어 공기를 들였다.', 2);

  -- 1002. 味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '味', 'あじ', '맛', '味(맛 미): 입(口)으로 미세한(未) 차이를 느낀다는 뜻에서 ‘맛’', '명사', 1002, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このスープは味がいい。', '이 수프는 맛이 좋다.', 1),
    (w, '料理の味を見てください。', '요리의 맛을 봐 주세요.', 2);

  -- 1003. 頭
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '頭', 'あたま', '머리', '頭(머리 두): 콩(豆)처럼 둥근 머리(頁)의 모양에서 유래', '명사', 1003, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭が痛いです。', '머리가 아파요.', 1),
    (w, '頭をよく使って考える。', '머리를 잘 써서 생각하다.', 2);

  -- 1004. 暑い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '暑い', 'あつい', '덥다', '暑(더울 서): 해(日)가 사람(者) 위에 있어 뜨겁다는 뜻', 'い형용사', 1004, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はとても暑いです。', '오늘은 매우 덥습니다.', 1),
    (w, '夏は暑くて大変だ。', '여름은 더워서 힘들다.', 2);

  -- 1005. 歩く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '歩く', 'あるく', '걷다', '歩(걸음 보): 두 발(止)을 번갈아 내딛는 모양', '동사', 1005, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝公園を歩きます。', '매일 아침 공원을 걷습니다.', 1),
    (w, '駅まで歩いて行く。', '역까지 걸어서 간다.', 2);

  -- 1006. 安心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '安心', 'あんしん', '안심', '安(편안 안): 집(宀) 안에 여자(女)가 있어 평안함
心(마음 심): 심장의 모양에서 마음을 의미', '명사', 1006, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無事に着いたと聞いて安心した。', '무사히 도착했다고 들어 안심했다.', 1),
    (w, '家族が元気で安心です。', '가족이 건강해서 안심입니다.', 2);

  -- 1007. 以外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '以外', 'いがい', '이외', '以(써 이): 도구를 들고 일을 한다는 뜻에서 ‘~로써’
外(바깥 외): 저녁(夕)에 점(卜)을 치는 일이 바깥에서 이루어짐', '명사', 1007, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私以外はみんな来ました。', '나 이외에는 모두 왔습니다.', 1),
    (w, '英語以外の言葉も勉強したい。', '영어 이외의 언어도 공부하고 싶다.', 2);

  -- 1008. 池
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '池', 'いけ', '연못', '池(못 지): 물(氵)이 머무르는(也) 곳, 작은 못', '명사', 1008, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園の池に魚がいる。', '공원의 연못에 물고기가 있다.', 1),
    (w, '池の周りを散歩した。', '연못 주변을 산책했다.', 2);

  -- 1009. 医者
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '医者', 'いしゃ', '의사', '医(의원 의): 화살(矢)을 상자(匚)에 담아 상처를 치료
者(놈 자): 사람을 가리키는 어미', '명사', 1009, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者に診てもらった。', '의사에게 진찰받았다.', 1),
    (w, '将来は医者になりたい。', '장래에 의사가 되고 싶다.', 2);

  -- 1010. 急ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '急ぐ', 'いそぐ', '서두르다', '急(급할 급): 손(彐)으로 마음(心)을 잡는다는 뜻에서 ‘급함’', '동사', 1010, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間がないので急いでください。', '시간이 없으니 서둘러 주세요.', 1),
    (w, '急いで駅へ向かった。', '서둘러 역으로 향했다.', 2);

  -- 1011. 妹
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '妹', 'いもうと', '여동생', '妹(누이 매): 여자(女)에 끝(未)을 붙여 ‘아랫 누이’', '명사', 1011, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妹は中学生です。', '여동생은 중학생입니다.', 1),
    (w, '妹と一緒に遊んだ。', '여동생과 함께 놀았다.', 2);

  -- 1012. 色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '色', 'いろ', '색', '色(빛 색): 사람(人)과 사람(巴)이 만나는 빛깔, 또는 안색', '명사', 1012, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '好きな色は青です。', '좋아하는 색은 파랑입니다.', 1),
    (w, 'この服は色がきれいだ。', '이 옷은 색이 예쁘다.', 2);

  -- 1013. 歌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '歌', 'うた', '노래', '歌(노래 가): 입을 크게 벌려(欠) 노래(哥)함', '명사', 1013, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の歌が好きです。', '일본 노래를 좋아합니다.', 1),
    (w, 'みんなで歌を歌った。', '모두 함께 노래를 불렀다.', 2);

  -- 1014. 海
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '海', 'うみ', '바다', '海(바다 해): 물(氵)이 모여 모든 것을 품는(每) 큰 곳', '명사', 1014, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏は海で泳ぎたい。', '여름에는 바다에서 헤엄치고 싶다.', 1),
    (w, '海の景色がきれいだ。', '바다 경치가 아름답다.', 2);

  -- 1015. 運動
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '運動', 'うんどう', '운동', '運(움직일 운): 군(軍)을 옮기듯 천천히 움직임(辶)
動(움직일 동): 무거운 것(重)에 힘(力)을 주어 움직임', '명사', 1015, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康のために運動します。', '건강을 위해 운동합니다.', 1),
    (w, '毎日少し運動しましょう。', '매일 조금 운동합시다.', 2);

  -- 1016. 英語
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '英語', 'えいご', '영어', '英(꽃부리 영): 풀(艹) 가운데(央) 꽃, 뛰어남
語(말씀 어): 말(言)을 주고받음(吾)', '명사', 1016, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '英語を勉強しています。', '영어를 공부하고 있습니다.', 1),
    (w, '彼女は英語が上手です。', '그녀는 영어를 잘합니다.', 2);

  -- 1017. 多い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '多い', 'おおい', '많다', '多(많을 다): 저녁(夕)이 거듭되어 ‘많음’을 나타냄', 'い형용사', 1017, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京は人が多いです。', '도쿄는 사람이 많습니다.', 1),
    (w, '今日は宿題が多い。', '오늘은 숙제가 많다.', 2);

  -- 1018. 送る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '送る', 'おくる', '보내다', '送(보낼 송): 뒤에 따라가며(辶) 함께 보냄(关)', '동사', 1018, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちに手紙を送った。', '친구에게 편지를 보냈다.', 1),
    (w, '駅まで彼女を送ります。', '역까지 그녀를 바래다 줍니다.', 2);

  -- 1019. 重い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '重い', 'おもい', '무겁다', '重(무거울 중): 사람(亻)이 짐(東)을 짊어진 모양', 'い형용사', 1019, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この荷物はとても重い。', '이 짐은 매우 무겁다.', 1),
    (w, '心が重い気がする。', '마음이 무거운 느낌이 든다.', 2);

  -- 1020. 終わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '終わる', 'おわる', '끝나다', '終(마칠 종): 실(糸)을 매듭짓듯이 끝(冬)을 짓다', '동사', 1020, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '授業が3時に終わる。', '수업이 3시에 끝나다.', 1),
    (w, '仕事が終わったら帰ります。', '일이 끝나면 돌아가겠습니다.', 2);

  -- 1021. 音楽
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '音楽', 'おんがく', '음악', '音(소리 음): 입에 말이 들어 있는 모양, 소리
楽(즐길 락): 나무 위 큰북·작은북의 모양, 음악', '명사', 1021, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聞くのが好きです。', '음악을 듣는 것을 좋아합니다.', 1),
    (w, '彼は音楽の先生だ。', '그는 음악 선생님이다.', 2);

  -- 1022. 返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '返す', 'かえす', '돌려주다', '返(돌이킬 반): 거꾸로(反) 돌아감(辶)', '동사', 1022, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '借りた本を返した。', '빌린 책을 돌려주었다.', 1),
    (w, '明日までにお金を返します。', '내일까지 돈을 돌려드리겠습니다.', 2);

  -- 1023. 帰る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '帰る', 'かえる', '돌아가(오)다', '帰(돌아갈 귀): 빗자루(帚)를 잡고 집으로 돌아감', '동사', 1023, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう家に帰ります。', '이제 집에 돌아갑니다.', 1),
    (w, '日本へいつ帰りますか。', '일본으로 언제 돌아갑니까?', 2);

  -- 1024. 貸す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '貸す', 'かす', '빌려주다', '貸(빌릴 대): 재화(貝)를 대신(代) 내어 줌', '동사', 1024, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちにペンを貸した。', '친구에게 펜을 빌려주었다.', 1),
    (w, 'ノートを貸してください。', '노트를 빌려주세요.', 2);

  -- 1025. 風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '風', 'かぜ', '바람', '風(바람 풍): 돛(凡) 안에 벌레(虫)가 움직이듯 공기가 흐름', '명사', 1025, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は風が強いです。', '오늘은 바람이 강합니다.', 1),
    (w, '春の風はやさしい。', '봄바람은 부드럽다.', 2);

  -- 1026. 家族
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '家族', 'かぞく', '가족', '家(집 가): 집(宀) 안의 돼지(豕), 가축이 있는 거처
族(겨레 족): 깃발(方) 아래 화살(矢)이 모인 무리', '명사', 1026, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族と旅行に行きます。', '가족과 여행을 갑니다.', 1),
    (w, '私の家族は4人です。', '우리 가족은 4명입니다.', 2);

  -- 1027. 通う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '通う', 'かよう', '다니다, 통학하다', '通(통할 통): 길(辶)이 막힘없이 통함(甬)', '동사', 1027, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日学校に通っています。', '매일 학교에 다니고 있습니다.', 1),
    (w, '電車で会社に通う。', '전철로 회사에 다닌다.', 2);

  -- 1028. 体
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '体', 'からだ', '몸', '体(몸 체): 사람(亻)의 본바탕(本)을 의미', '명사', 1028, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体に気をつけてください。', '몸 조심하세요.', 1),
    (w, '運動して体を強くする。', '운동해서 몸을 튼튼하게 하다.', 2);

  -- 1029. 借りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '借りる', 'かりる', '빌리다', '借(빌릴 차): 사람(亻)이 묵은 것(昔)을 빌려 옴', '동사', 1029, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館で本を借りた。', '도서관에서 책을 빌렸다.', 1),
    (w, '友だちに傘を借りる。', '친구에게 우산을 빌리다.', 2);

  -- 1030. 考える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '考える', 'かんがえる', '생각하다', '考(상고할 고): 늙은(耂) 사람이 깊이 생각함', '동사', 1030, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よく考えてから決めましょう。', '잘 생각하고 나서 결정합시다.', 1),
    (w, '将来の夢について考える。', '장래의 꿈에 대해 생각하다.', 2);

  -- 1031. 気分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '気分', 'きぶん', '기분', '気(기운 기): 쌀(米)을 찐 김(气), 기운
分(나눌 분): 칼(刀)로 나눔(八)', '명사', 1031, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は気分がいい。', '오늘은 기분이 좋다.', 1),
    (w, '気分が悪いので休みます。', '기분이 안 좋아서 쉽니다.', 2);

  -- 1032. 着物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '着物', 'きもの', '옷, 일본의 전통 의상', '着(붙을 착): 양(羊)이 눈(目)에 띄게 입혀짐
物(물건 물): 소(牛)와 같은 사물(勿)', '명사', 1032, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の着物はきれいです。', '일본의 기모노는 아름답습니다.', 1),
    (w, '祭りで着物を着た。', '축제에서 기모노를 입었다.', 2);

  -- 1033. 急に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '急に', 'きゅうに', '갑자기', '急(급할 급): 손으로 마음을 잡듯 ‘급함’', '부사', 1033, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空が急に暗くなった。', '하늘이 갑자기 어두워졌다.', 1),
    (w, '彼は急に立ち上がった。', '그는 갑자기 일어섰다.', 2);

  -- 1034. 教室
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '教室', 'きょうしつ', '교실', '教(가르칠 교): 노인이 아이를 가르치는 모양
室(집 실): 집(宀) 안에 이름(至)이 새겨진 방', '명사', 1034, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教室で勉強しています。', '교실에서 공부하고 있습니다.', 1),
    (w, 'この教室は明るいです。', '이 교실은 밝습니다.', 2);

  -- 1035. 去年
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '去年', 'きょねん', '작년', '去(갈 거): 사람이 떠나가는 모양
年(해 년): 사람이 곡식을 짊어진 모양, 한 해의 수확', '명사', 1035, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年日本へ行きました。', '작년에 일본에 갔습니다.', 1),
    (w, '去年から日本語を始めた。', '작년부터 일본어를 시작했다.', 2);

  -- 1036. 着る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '着る', 'きる', '(옷을) 입다', '着(붙을 착): 옷이 몸에 붙는다는 뜻', '동사', 1036, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コートを着て出かけた。', '코트를 입고 나갔다.', 1),
    (w, '寒いので服を着ます。', '추워서 옷을 입습니다.', 2);

  -- 1037. 銀行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '銀行', 'ぎんこう', '은행', '銀(은 은): 쇠(金) 중 빛나는(艮) 흰 금속, 은
行(다닐 행): 사거리에서 다님, 가게를 의미', '명사', 1037, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行でお金を下ろした。', '은행에서 돈을 찾았다.', 1),
    (w, '銀行は9時に開きます。', '은행은 9시에 엽니다.', 2);

  -- 1038. 近所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '近所', 'きんじょ', '근처, 부근', '近(가까울 근): 가까이(辶) 도끼(斤)가 있을 정도
所(바 소): 집의 한 구역(戸)이 있는 곳', '명사', 1038, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '近所のスーパーで買い物した。', '근처 슈퍼에서 장을 봤다.', 1),
    (w, '近所に新しい店ができた。', '근처에 새 가게가 생겼다.', 2);

  -- 1039. 黒い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '黒い', 'くろい', '검다', '黒(검을 흑): 굴뚝(囪) 아래 불(炎)에 그을린 색', 'い형용사', 1039, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '黒い猫が好きです。', '검은 고양이를 좋아합니다.', 1),
    (w, '空が黒い雲でいっぱいだ。', '하늘이 검은 구름으로 가득 차다.', 2);

  -- 1040. 計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '計画', 'けいかく', '계획', '計(셈할 계): 말(言)로 열(十)까지 헤아림
画(그을 획): 밭의 경계를 그어 구분', '명사', 1040, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏休みの計画を立てた。', '여름방학 계획을 세웠다.', 1),
    (w, '計画通りに進んでいる。', '계획대로 진행되고 있다.', 2);

  -- 1041. 研究
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '研究', 'けんきゅう', '연구', '研(갈 연): 돌(石)을 갈아 평평하게(开) 함
究(궁구할 구): 구멍(穴) 끝까지(九) 파고듦', '명사', 1041, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は科学を研究しています。', '그는 과학을 연구하고 있습니다.', 1),
    (w, '研究の結果が出た。', '연구 결과가 나왔다.', 2);

  -- 1042. 公園
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '公園', 'こうえん', '공원', '公(공평할 공): 사사로움(厶)을 나눔(八), 공평함
園(동산 원): 둥글게 둘러싼(囗) 옷자락 같은 정원', '명사', 1042, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもたちが公園で遊ぶ。', '아이들이 공원에서 논다.', 1),
    (w, '公園の桜がきれいだ。', '공원의 벚꽃이 예쁘다.', 2);

  -- 1043. 工場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '工場', 'こうじょう', '공장', '工(장인 공): 자(尺)와 같은 도구의 모양
場(마당 장): 햇빛(昜) 비치는 흙(土) 위 마당', '명사', 1043, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は工場で働いています。', '아버지는 공장에서 일하고 있습니다.', 1),
    (w, '車を作る工場を見学した。', '자동차를 만드는 공장을 견학했다.', 2);

  -- 1044. 声
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '声', 'こえ', '목소리', '声(소리 성): 악기 소리(声)에서 사람의 음성으로', '명사', 1044, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きな声で話してください。', '큰 목소리로 말해 주세요.', 1),
    (w, '彼女の声はやさしい。', '그녀의 목소리는 부드럽다.', 2);

  -- 1045. 今度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '今度', 'こんど', '지난번, 이번, 다음번', '今(이제 금): 막 일이 일어난 모양, ‘지금’
度(법도 도): 손(又)으로 길이를 잼, 정도·횟수', '명사', 1045, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度の週末に会いましょう。', '이번 주말에 만납시다.', 1),
    (w, '今度は私が払います。', '다음번은 제가 내겠습니다.', 2);

  -- 1046. 魚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '魚', 'さかな', '생선, 물고기', '魚(물고기 어): 머리·몸통·꼬리를 갖춘 물고기 모양', '명사', 1046, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '魚を食べるのが好きです。', '생선을 먹는 것을 좋아합니다.', 1),
    (w, '川で魚を釣った。', '강에서 물고기를 낚았다.', 2);

  -- 1047. 産業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '産業', 'さんぎょう', '산업', '産(낳을 산): 서서(立) 무엇을 만들어 내는(生) 모양
業(업 업): 칠판(丵) 같은 큰 일거리', '명사', 1047, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の自動車産業は有名だ。', '일본의 자동차 산업은 유명하다.', 1),
    (w, 'IT産業が成長している。', 'IT 산업이 성장하고 있다.', 2);

  -- 1048. 仕事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '仕事', 'しごと', '일, 업무', '仕(섬길 사): 사람(亻)이 선비(士)처럼 섬김
事(일 사): 깃발과 손, 의식·일을 처리함', '명사', 1048, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が忙しいです。', '일이 바쁩니다.', 1),
    (w, '新しい仕事を始めた。', '새로운 일을 시작했다.', 2);

  -- 1049. 質問
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '質問', 'しつもん', '질문', '質(바탕 질): 도끼(斤) 두 개 위 재화(貝), 본바탕
問(물을 문): 문(門) 앞에서 입(口)으로 물음', '명사', 1049, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に質問してもいいですか。', '선생님에게 질문해도 됩니까?', 1),
    (w, '質問があれば言ってください。', '질문이 있으면 말해 주세요.', 2);

  -- 1050. 自転車
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '自転車', 'じてんしゃ', '자전거', '自(스스로 자): 코의 모양, 자기 자신
転(구를 전): 수레(車)가 굴러감(専)
車(수레 차): 두 바퀴 사이의 굴대 모양', '명사', 1050, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自転車で学校へ行きます。', '자전거로 학교에 갑니다.', 1),
    (w, '新しい自転車を買った。', '새 자전거를 샀다.', 2);

  -- 1051. 品物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '品物', 'しなもの', '물건', '品(물건 품): 입(口)이 셋, 여러 가지 물건의 등급
物(물건 물): 소(牛)와 같은 사물(勿)', '명사', 1051, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店の品物は安い。', '이 가게의 물건은 싸다.', 1),
    (w, '高い品物には気をつけて。', '비싼 물건에는 조심해.', 2);

  -- 1052. 死ぬ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '死ぬ', 'しぬ', '죽다', '死(죽을 사): 부서진 뼈(歹) 옆에 앉은 사람(匕)', '동사', 1052, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '祖父は去年死にました。', '할아버지는 작년에 돌아가셨습니다.', 1),
    (w, '虫が死んでいる。', '벌레가 죽어 있다.', 2);

  -- 1053. 自分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '自分', 'じぶん', '자기, 자신', '自(스스로 자): 코의 모양, 자기 자신
分(나눌 분): 칼(刀)로 나눔(八)', '명사', 1053, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分のことは自分でする。', '자기 일은 자기가 한다.', 1),
    (w, '自分の意見を言ってください。', '자신의 의견을 말해 주세요.', 2);

  -- 1054. 写真家
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '写真家', 'しゃしんか', '사진가', '写(베낄 사): 집(冖) 안에서 신(舃)을 베껴 그림
真(참 진): 솥(鼎) 위에 사람(匕)이 똑바로 섬, 진실
家(집 가): 집(宀) 안의 돼지(豕)', '명사', 1054, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は有名な写真家です。', '그는 유명한 사진가입니다.', 1),
    (w, '写真家になりたい。', '사진가가 되고 싶다.', 2);

  -- 1055. 住所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '住所', 'じゅうしょ', '주소', '住(살 주): 사람(亻)이 한 곳에 머무름(主)
所(바 소): 집(戸)의 도끼(斤)가 놓인 자리', '명사', 1055, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここに住所を書いてください。', '여기에 주소를 적어 주세요.', 1),
    (w, '住所が変わりました。', '주소가 바뀌었습니다.', 2);

  -- 1056. 出発
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '出発', 'しゅっぱつ', '출발', '出(날 출): 발(止)이 굴(凵)에서 나오는 모양
発(필 발): 활(弓)을 쏘아 화살이 날아감(癶)', '명사', 1056, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'バスは8時に出発します。', '버스는 8시에 출발합니다.', 1),
    (w, '出発の時間に遅れた。', '출발 시간에 늦었다.', 2);

  -- 1057. 食堂
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '食堂', 'しょくどう', '식당', '食(밥 식): 뚜껑(亼)이 있는 그릇(皀)에 담긴 음식
堂(집 당): 흙(土) 위에 우뚝(尚) 세워진 큰 집', '명사', 1057, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昼ごはんは食堂で食べる。', '점심은 식당에서 먹는다.', 1),
    (w, '駅前の食堂は安い。', '역 앞 식당은 싸다.', 2);

  -- 1058. 食料品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '食料品', 'しょくりょうひん', '식료품', '食(밥 식): 그릇에 담긴 음식
料(헤아릴 료): 쌀(米)을 말(斗)로 헤아림
品(물건 품): 입(口) 셋, 여러 물건', '명사', 1058, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スーパーで食料品を買う。', '슈퍼에서 식료품을 산다.', 1),
    (w, '食料品が高くなった。', '식료품이 비싸졌다.', 2);

  -- 1059. 知る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '知る', 'しる', '알다', '知(알 지): 화살(矢)처럼 빠르게 입(口)으로 답함, ‘앎’', '동사', 1059, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の名前を知っていますか。', '그의 이름을 알고 있습니까?', 1),
    (w, 'その話は新聞で知った。', '그 이야기는 신문에서 알았다.', 2);

  -- 1060. 人口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '人口', 'じんこう', '인구', '人(사람 인): 사람이 서 있는 옆모습
口(입 구): 입의 모양, 사람의 수를 셀 때 단위로 사용', '명사', 1060, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京は人口が多い。', '도쿄는 인구가 많다.', 1),
    (w, 'この町の人口は少ない。', '이 마을의 인구는 적다.', 2);

  -- 1061. 親切
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '親切', 'しんせつ', '친절함', '親(친할 친): 나무(木) 곁에 서서(立) 가까이 봄(見)
切(끊을 절): 일곱(七)을 칼(刀)로 자름, 절실함', 'な형용사', 1061, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '店の人はとても親切でした。', '가게 사람은 매우 친절했습니다.', 1),
    (w, '親切に教えてくれた。', '친절하게 가르쳐 주었다.', 2);

  -- 1062. 進む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '進む', 'すすむ', '나아가다, 진보하다', '進(나아갈 진): 새(隹)가 앞으로 날아가듯 나아감(辶)', '동사', 1062, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '前へ進んでください。', '앞으로 나아가 주세요.', 1),
    (w, '工事が順調に進んでいる。', '공사가 순조롭게 진행되고 있다.', 2);

  -- 1063. 住む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '住む', 'すむ', '살다, 주거하다', '住(살 주): 사람(亻)이 한 곳(主)에 머무름', '동사', 1063, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京に住んでいます。', '도쿄에 살고 있습니다.', 1),
    (w, 'どこに住みたいですか。', '어디에 살고 싶습니까?', 2);

  -- 1064. 西洋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '西洋', 'せいよう', '서양', '西(서녘 서): 새가 둥지에 깃든 모양, 해가 지는 쪽
洋(큰바다 양): 양(羊)처럼 큰 물(氵), 큰 바다·서양', '명사', 1064, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '西洋の文化に興味がある。', '서양 문화에 관심이 있다.', 1),
    (w, '西洋料理を食べた。', '서양 요리를 먹었다.', 2);

  -- 1065. 世界
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '世界', 'せかい', '세계', '世(세상 세): 잎이 자라 30년이 흐른 모양, 세대
界(지경 계): 밭(田)의 사이(介), 경계', '명사', 1065, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界には色々な国がある。', '세계에는 다양한 나라가 있다.', 1),
    (w, '世界中を旅行したい。', '세계를 두루 여행하고 싶다.', 2);

  -- 1066. 説明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '説明', 'せつめい', '설명', '説(말씀 설): 말(言)로 풀어(兌) 알기 쉽게 함
明(밝을 명): 해(日)와 달(月)이 함께 있어 밝음', '명사', 1066, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '使い方を説明します。', '사용법을 설명하겠습니다.', 1),
    (w, '先生の説明はわかりやすい。', '선생님의 설명은 이해하기 쉽다.', 2);

  -- 1067. 世話
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '世話', 'せわ', '돌봄, 폐, 신세', '世(세상 세): 30년의 시간
話(말씀 화): 말(言)을 혀(舌)로 주고받음', '명사', 1067, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもの世話をする。', '아이를 돌본다.', 1),
    (w, 'お世話になりました。', '신세 많이 졌습니다.', 2);

  -- 1068. 祖母
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '祖母', 'そぼ', '조모, 할머니', '祖(할아비 조): 신주(且)를 모시는 제단(示), 조상
母(어미 모): 가슴에 점을 찍어 어머니를 표현', '명사', 1068, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '祖母は元気です。', '할머니는 건강합니다.', 1),
    (w, '祖母の家へ遊びに行く。', '할머니 댁에 놀러 간다.', 2);

  -- 1069. 空
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '空', 'そら', '하늘', '空(빌 공): 구멍(穴)처럼 텅 빈 공간, 하늘', '명사', 1069, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日の空はとてもきれいだ。', '오늘 하늘은 매우 아름답다.', 1),
    (w, '空に星がたくさん見える。', '하늘에 별이 많이 보인다.', 2);

  -- 1070. 台所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '台所', 'だいどころ', '부엌', '台(돈대 대): 받침대 모양, 무대·자리
所(바 소): 한 구역의 자리', '명사', 1070, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母は台所で料理している。', '어머니는 부엌에서 요리하고 있다.', 1),
    (w, '台所がきれいだ。', '부엌이 깨끗하다.', 2);

  -- 1071. 建物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '建物', 'たてもの', '건물', '建(세울 건): 붓(聿)을 세워 길게 늘이는 모양
物(물건 물): 사물', '명사', 1071, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの白い建物は学校です。', '저 하얀 건물은 학교입니다.', 1),
    (w, '古い建物が好きです。', '오래된 건물을 좋아합니다.', 2);

  -- 1072. 楽しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '楽しい', 'たのしい', '즐겁다', '楽(즐거울 락): 큰북·작은북의 모양, 음악과 즐거움', 'い형용사', 1072, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日は本当に楽しかった。', '어제는 정말 즐거웠다.', 1),
    (w, '友だちと話すのは楽しい。', '친구와 이야기하는 것은 즐겁다.', 2);

  -- 1073. 足りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '足りる', 'たりる', '족하다, 충분하다', '足(발 족): 무릎과 발의 모양, 충분함의 뜻도 가짐', '동사', 1073, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お金が足りない。', '돈이 모자라다.', 1),
    (w, '時間が足りればいいのですが。', '시간이 충분하면 좋겠습니다만.', 2);

  -- 1074. 力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '力', 'ちから', '힘', '力(힘 력): 팔에 힘줄이 솟은 모양 또는 쟁기', '명사', 1074, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '力を合わせて頑張ろう。', '힘을 합쳐 힘냅시다.', 1),
    (w, 'もう力が出ない。', '이제 힘이 나지 않는다.', 2);

  -- 1075. 茶色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '茶色', 'ちゃいろ', '갈색', '茶(차 차): 풀(艹) 안에서 사람(人)이 마시는 차나무
色(빛 색): 사람들이 만나 만드는 빛, 색', '명사', 1075, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '茶色のかばんを買った。', '갈색 가방을 샀다.', 1),
    (w, '彼の目は茶色です。', '그의 눈은 갈색입니다.', 2);

  -- 1076. 注意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '注意', 'ちゅうい', '주의', '注(부을 주): 물(氵)을 한 곳(主)에 따름, 집중
意(뜻 의): 마음(心)에서 우러나는 소리(音)', '명사', 1076, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車に注意してください。', '차를 주의하세요.', 1),
    (w, '注意して読んでください。', '주의해서 읽어 주세요.', 2);

  -- 1077. 地理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '地理', 'ちり', '지리', '地(땅 지): 흙(土)이 평평하게(也) 깔린 곳
理(다스릴 리): 옥(玉)을 마을(里)처럼 잘 다듬음', '명사', 1077, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の地理を勉強する。', '일본의 지리를 공부하다.', 1),
    (w, '地理が苦手です。', '지리는 잘 못합니다.', 2);

  -- 1078. 使う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '使う', 'つかう', '사용하다', '使(부릴 사): 사람(亻)이 일을 시키는(吏) 모양', '동사', 1078, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パソコンを使って仕事する。', '컴퓨터를 사용해 일한다.', 1),
    (w, 'お金を上手に使いたい。', '돈을 잘 쓰고 싶다.', 2);

  -- 1079. 着く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '着く', 'つく', '도착하다', '着(붙을 착): 어떤 장소에 몸이 붙음, 도착', '동사', 1079, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅に着いたら電話します。', '역에 도착하면 전화하겠습니다.', 1),
    (w, '荷物が無事に着いた。', '짐이 무사히 도착했다.', 2);

  -- 1080. 強い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '強い', 'つよい', '강하다, 세다', '強(강할 강): 활(弓) 같은 힘이 거센 벌레(虫)에서 ‘강함’', 'い형용사', 1080, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はとても強い人だ。', '그는 매우 강한 사람이다.', 1),
    (w, '今日は風が強い。', '오늘은 바람이 세다.', 2);

  -- 1081. 手紙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '手紙', 'てがみ', '편지', '手(손 수): 손가락 다섯의 모양
紙(종이 지): 실(糸)처럼 얇게 만든(氏) 종이', '명사', 1081, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちに手紙を書いた。', '친구에게 편지를 썼다.', 1),
    (w, 'おばあさんから手紙が来た。', '할머니에게서 편지가 왔다.', 2);

  -- 1082. 通る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '通る', 'とおる', '통과하다, 지나다', '通(통할 통): 길(辶)이 막힘없이 통함(甬)', '동사', 1082, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道は車がよく通る。', '이 길은 차가 자주 지난다.', 1),
    (w, '試験に通って嬉しい。', '시험에 합격해서 기쁘다.', 2);

  -- 1083. 特に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '特に', 'とくに', '특히', '特(특별할 특): 소(牛) 가운데 절(寺)에 바칠 만한 큰 소, 특별함', '부사', 1083, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '特に問題はありません。', '특별히 문제는 없습니다.', 1),
    (w, '夏は特に暑い。', '여름은 특히 덥다.', 2);

  -- 1084. 特別
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '特別', 'とくべつ', '특별', '特(특별할 특): 큰 소, 특별함
別(다를 별): 칼(刂)로 뼈와 살을 가르는 모양, 구별', 'な형용사', 1084, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は特別な日です。', '오늘은 특별한 날입니다.', 1),
    (w, '特別な料理を作った。', '특별한 요리를 만들었다.', 2);

  -- 1085. 図書館
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '図書館', 'としょかん', '도서관', '図(그림 도): 둘러싼(囗) 곳 안의 그림
書(글 서): 붓(聿)으로 그릇(曰) 위에 글을 씀
館(집 관): 음식(食)을 차린 큰 집(官)', '명사', 1085, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館で勉強します。', '도서관에서 공부합니다.', 1),
    (w, '図書館は静かです。', '도서관은 조용합니다.', 2);

  -- 1086. 止まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '止まる', 'とまる', '멈추다', '止(그칠 지): 발의 모양, 발이 멈춤', '동사', 1086, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が駅に止まった。', '전철이 역에 멈췄다.', 1),
    (w, '時計が止まっている。', '시계가 멈춰 있다.', 2);

  -- 1087. 鳥
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '鳥', 'とり', '새', '鳥(새 조): 새의 모양', '명사', 1087, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空に鳥が飛んでいる。', '하늘에 새가 날고 있다.', 1),
    (w, '小さい鳥がかわいい。', '작은 새가 귀엽다.', 2);

  -- 1088. 夏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '夏', 'なつ', '여름', '夏(여름 하): 머리(頁)와 발(夂)을 가진 사람이 춤추는 모양', '명사', 1088, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏は海へ行きたい。', '여름에는 바다에 가고 싶다.', 1),
    (w, '日本の夏は蒸し暑い。', '일본의 여름은 무덥다.', 2);

  -- 1089. 運ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '運ぶ', 'はこぶ', '옮기다', '運(움직일 운): 군대를 옮기듯 움직임', '동사', 1089, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '机を二階に運んだ。', '책상을 2층으로 옮겼다.', 1),
    (w, '荷物を車で運びます。', '짐을 차로 옮깁니다.', 2);

  -- 1090. 走る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '走る', 'はしる', '달리다', '走(달릴 주): 사람(夭)이 발(止)을 흔들며 달림', '동사', 1090, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝公園を走ります。', '매일 아침 공원을 달립니다.', 1),
    (w, '電車が速く走っている。', '전철이 빠르게 달리고 있다.', 2);

  -- 1091. 働く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '働く', 'はたらく', '일하다', '働(일할 동): 사람(亻)이 움직여(動) 일함', '동사', 1091, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は銀行で働いています。', '아버지는 은행에서 일합니다.', 1),
    (w, '一日中働いて疲れた。', '하루 종일 일해서 피곤하다.', 2);

  -- 1092. 早い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '早い', 'はやい', '이르다, 빠르다', '早(이를 조): 해(日)가 떠오르는 시각이 빠름(十)', 'い형용사', 1092, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝が早いのは大変だ。', '아침이 이른 것은 힘들다.', 1),
    (w, '時間が経つのが早い。', '시간이 가는 것이 빠르다.', 2);

  -- 1093. 早く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '早く', 'はやく', '일찍, 빨리', '早(이를 조): 해가 일찍 뜨는 모양', '부사', 1093, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く起きてください。', '일찍 일어나 주세요.', 1),
    (w, 'もっと早く歩こう。', '더 빨리 걷자.', 2);

  -- 1094. 春
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '春', 'はる', '봄', '春(봄 춘): 풀(艹)과 햇빛(日)이 어우러진 봄의 모양', '명사', 1094, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春になると花が咲く。', '봄이 되면 꽃이 핀다.', 1),
    (w, '春は気持ちがいい。', '봄은 기분이 좋다.', 2);

  -- 1095. 病院
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '病院', 'びょういん', '병원', '病(병 병): 침상(疒)에 누운 병자(丙)
院(집 원): 언덕(阝) 위 큰 집(完)', '명사', 1095, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '熱があるので病院へ行く。', '열이 나서 병원에 간다.', 1),
    (w, '近くに大きな病院がある。', '근처에 큰 병원이 있다.', 2);

  -- 1096. 広い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '広い', 'ひろい', '넓다', '広(넓을 광): 집(广)이 넓게 펼쳐짐', 'い형용사', 1096, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この部屋は広いです。', '이 방은 넓습니다.', 1),
    (w, '広い公園で遊びたい。', '넓은 공원에서 놀고 싶다.', 2);

  -- 1097. 服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '服', 'ふく', '옷', '服(옷 복): 몸(月)에 따라 입는(卩) 의복', '명사', 1097, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい服を買った。', '새 옷을 샀다.', 1),
    (w, '今日は服が汚れた。', '오늘은 옷이 더러워졌다.', 2);

  -- 1098. 不便
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '不便', 'ふべん', '불편함', '不(아닐 부): 부정의 표시
便(편할 편): 사람(亻)이 다시(更) 좋게 고쳐 편함', 'な형용사', 1098, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この町は交通が不便だ。', '이 마을은 교통이 불편하다.', 1),
    (w, '不便な所に住んでいる。', '불편한 곳에 살고 있다.', 2);

  -- 1099. 古い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '古い', 'ふるい', '오래되다, 낡다', '古(옛 고): 열(十) 사람의 입(口)으로 전해진 옛 일', 'い형용사', 1099, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本はとても古い。', '이 책은 매우 오래되었다.', 1),
    (w, '古い友だちに会った。', '오랜 친구를 만났다.', 2);

  -- 1100. 勉強
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '勉強', 'べんきょう', '공부', '勉(힘쓸 면): 사람이 분발하여(免) 힘(力)을 다함
強(강할 강): 활처럼 강한 의지', '명사', 1100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日日本語を勉強する。', '매일 일본어를 공부한다.', 1),
    (w, '勉強が好きです。', '공부를 좋아합니다.', 2);

  -- 1101. 毎朝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '毎朝', 'まいあさ', '매일 아침', '毎(매양 매): 어머니가 머리를 묶은 모양, 늘
朝(아침 조): 해(日)가 풀(屮) 사이에 떠오르고 달(月)이 지는 시각', '명사', 1101, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝コーヒーを飲みます。', '매일 아침 커피를 마십니다.', 1),
    (w, '毎朝6時に起きる。', '매일 아침 6시에 일어난다.', 2);

  -- 1102. 町
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '町', 'まち', '도회, 거리, 번화가', '町(밭두둑 정): 밭(田)과 못(丁)이 있는 마을', '명사', 1102, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この町は静かです。', '이 마을은 조용합니다.', 1),
    (w, '町を歩くのが好きだ。', '거리를 걷는 것을 좋아한다.', 2);

  -- 1103. 待つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '待つ', 'まつ', '기다리다', '待(기다릴 대): 길(彳)에서 절(寺)을 지키며 기다림', '동사', 1103, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で友だちを待った。', '역에서 친구를 기다렸다.', 1),
    (w, '少し待ってください。', '잠깐 기다려 주세요.', 2);

  -- 1104. 店
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '店', 'みせ', '가게', '店(가게 점): 집(广) 안에 자리잡은(占) 상점', '명사', 1104, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの店はいつも人が多い。', '저 가게는 항상 사람이 많다.', 1),
    (w, '新しい店ができた。', '새 가게가 생겼다.', 2);

  -- 1105. 野菜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '野菜', 'やさい', '야채', '野(들 야): 마을(里) 밖의 너른(予) 들
菜(나물 채): 풀(艹) 가운데 손으로 캐는(采) 나물', '명사', 1105, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '野菜をたくさん食べます。', '야채를 많이 먹습니다.', 1),
    (w, '新鮮な野菜が好きだ。', '신선한 야채를 좋아한다.', 2);

  -- 1106. 安い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '安い', 'やすい', '싸다', '安(편안 안): 집(宀) 안 여자(女)에서 편안·평안', 'い형용사', 1106, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店は安くておいしい。', '이 가게는 싸고 맛있다.', 1),
    (w, '安い物を買いました。', '싼 물건을 샀습니다.', 2);

  -- 1107. 夕方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '夕方', 'ゆうがた', '저녁', '夕(저녁 석): 달이 반쯤 떠오른 모양
方(모 방): 농기구의 모양, 방향·시각', '명사', 1107, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夕方になると涼しくなる。', '저녁이 되면 시원해진다.', 1),
    (w, '夕方友だちと会う約束だ。', '저녁에 친구와 만날 약속이다.', 2);

  -- 1108. 有名
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '有名', 'ゆうめい', '유명함', '有(있을 유): 손(又)에 고기(月)를 들고 있음, 가짐
名(이름 명): 저녁(夕)에 입(口)으로 부르는 이름', 'な형용사', 1108, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は有名な歌手です。', '그는 유명한 가수입니다.', 1),
    (w, 'この町は有名な観光地だ。', '이 마을은 유명한 관광지이다.', 2);

  -- 1109. 用意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '用意', 'ようい', '준비, 대비, 주의', '用(쓸 용): 통(用)의 모양, 사용함
意(뜻 의): 마음에서 우러나는 소리, 뜻', '명사', 1109, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行の用意ができた。', '여행 준비가 끝났다.', 1),
    (w, '昼ごはんを用意します。', '점심을 준비하겠습니다.', 2);

  -- 1110. 洋服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '洋服', 'ようふく', '양복, 서양식 옷', '洋(큰바다 양): 큰 바다, 서양
服(옷 복): 몸에 입는 옷', '명사', 1110, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '洋服を着て出かけた。', '양복을 입고 나갔다.', 1),
    (w, '新しい洋服を買いたい。', '새 양복을 사고 싶다.', 2);

  -- 1111. 夜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '夜', 'よる', '밤', '夜(밤 야): 사람(亻) 옆에 달(月)이 뜬 시각', '명사', 1111, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜は星がきれいだ。', '밤에는 별이 아름답다.', 1),
    (w, '夜遅くまで勉強した。', '밤늦게까지 공부했다.', 2);

  -- 1112. 弱い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '弱い', 'よわい', '약하다', '弱(약할 약): 활(弓) 두 개에 깃털(羽), 부드럽고 약함', 'い형용사', 1112, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私はお酒に弱い。', '나는 술에 약하다.', 1),
    (w, '体が弱くてよく休む。', '몸이 약해서 자주 쉰다.', 2);

  -- 1113. 料理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '料理', 'りょうり', '요리', '料(헤아릴 료): 쌀(米)을 말(斗)로 헤아림
理(다스릴 리): 옥(玉)을 잘 다듬음, 처리', '명사', 1113, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母の料理はおいしい。', '어머니의 요리는 맛있다.', 1),
    (w, '日本料理を習いたい。', '일본 요리를 배우고 싶다.', 2);

  -- 1114. 旅館
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '旅館', 'りょかん', '여관', '旅(나그네 려): 깃발(方) 아래 사람들이 따라감
館(집 관): 음식을 차린 큰 집', '명사', 1114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都の旅館に泊まった。', '교토의 여관에 묵었다.', 1),
    (w, '古い旅館は趣がある。', '오래된 여관은 운치가 있다.', 2);

  -- 1115. 旅行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '旅行', 'りょこう', '여행', '旅(나그네 려): 깃발 아래 따라가는 무리
行(다닐 행): 사거리에서 다님', '명사', 1115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏休みに旅行へ行く。', '여름방학에 여행을 간다.', 1),
    (w, '一人で旅行するのが好きだ。', '혼자 여행하는 것을 좋아한다.', 2);

  -- 1116. 悪い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '悪い', 'わるい', '나쁘다, 안 좋다', '悪(악할 악): 표정이 추악함(亞)에서 ‘나쁨’', 'い형용사', 1116, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は天気が悪い。', '오늘은 날씨가 나쁘다.', 1),
    (w, 'うそをつくのは悪いことだ。', '거짓말을 하는 것은 나쁜 일이다.', 2);

  -- 1117. 会う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '会う', 'あう', '만나다', '会(모일 회): 뚜껑(亼)을 덮어 사람이 모임', '동사', 1117, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で友だちに会った。', '역에서 친구를 만났다.', 1),
    (w, '先生に会って話します。', '선생님을 만나서 이야기합니다.', 2);

  -- 1118. 青い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '青い', 'あおい', '파랗다', '青(푸를 청): 새싹(生)이 우물(井) 가에 푸르게 자람', 'い형용사', 1118, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空が青くてきれいだ。', '하늘이 파래서 아름답다.', 1),
    (w, '青い海を見たい。', '파란 바다를 보고 싶다.', 2);

  -- 1119. 赤い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '赤い', 'あかい', '빨갛다, 붉다', '赤(붉을 적): 큰 불(火)이 위(土)로 솟는 색, 붉음', 'い형용사', 1119, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は赤い服が好きだ。', '그녀는 빨간 옷을 좋아한다.', 1),
    (w, '赤いりんごを買った。', '빨간 사과를 샀다.', 2);

  -- 1120. 明るい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '明るい', 'あかるい', '밝다', '明(밝을 명): 해(日)와 달(月)이 함께 비춰 밝음', 'い형용사', 1120, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この部屋は明るい。', '이 방은 밝다.', 1),
    (w, '彼女は明るい性格だ。', '그녀는 밝은 성격이다.', 2);

  -- 1121. 秋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '秋', 'あき', '가을', '秋(가을 추): 벼(禾)가 익는 불(火) 같은 햇빛의 계절', '명사', 1121, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '秋は涼しくて気持ちいい。', '가을은 시원해서 기분이 좋다.', 1),
    (w, '秋に紅葉を見に行く。', '가을에 단풍을 보러 간다.', 2);

  -- 1122. 新しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '新しい', 'あたらしい', '새롭다', '新(새 신): 도끼(斤)로 나무(木)를 쳐 새로 만듦, 새것', 'い형용사', 1122, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいかばんを買った。', '새 가방을 샀다.', 1),
    (w, '新しい仕事を始める。', '새로운 일을 시작한다.', 2);

  -- 1123. 集まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '集まる', 'あつまる', '모이다', '集(모을 집): 새(隹)가 나무(木) 위에 모여 앉은 모양', '동사', 1123, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちが家に集まった。', '친구들이 집에 모였다.', 1),
    (w, '広場に人が集まっている。', '광장에 사람들이 모여 있다.', 2);

  -- 1124. 姉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '姉', 'あね', '언니, 누나', '姉(맏누이 자): 여자(女) 가운데 시장(市) 같은 큰 자리, 손위 누이', '명사', 1124, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '姉は会社員です。', '언니는 회사원입니다.', 1),
    (w, '姉と買い物に行った。', '언니와 쇼핑을 갔다.', 2);

  -- 1125. 洗う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '洗う', 'あらう', '씻다', '洗(씻을 세): 물(氵)로 먼저(先) 깨끗이 함', '동사', 1125, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手をきれいに洗った。', '손을 깨끗이 씻었다.', 1),
    (w, 'お皿を洗ってください。', '접시를 씻어 주세요.', 2);

  -- 1126. 言う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '言う', 'いう', '말하다', '言(말씀 언): 입(口) 위에 신(辛)이 있어 말이 나옴', '동사', 1126, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当のことを言ってください。', '진실을 말해 주세요.', 1),
    (w, '彼は何も言わなかった。', '그는 아무 말도 하지 않았다.', 2);

  -- 1127. 犬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '犬', 'いぬ', '개', '犬(개 견): 개의 옆모습', '명사', 1127, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うちには犬が二匹います。', '우리 집에는 개가 두 마리 있습니다.', 1),
    (w, '犬の散歩に行く。', '개 산책을 간다.', 2);

  -- 1128. 売る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '売る', 'うる', '팔다', '売(팔 매): 선비(士)가 그릇(冖)에 담은 재화(儿)를 팖', '동사', 1128, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店ではパンを売っている。', '이 가게에서는 빵을 팔고 있다.', 1),
    (w, '古い車を売りました。', '오래된 차를 팔았습니다.', 2);

  -- 1129. 駅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '駅', 'えき', '역', '駅(역참 역): 말(馬)이 자주(尺) 머무는 역참', '명사', 1129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで歩いて10分です。', '역까지 걸어서 10분입니다.', 1),
    (w, '駅の前で待ち合わせる。', '역 앞에서 만나기로 하다.', 2);

  -- 1130. 起きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '起きる', 'おきる', '일어나다', '起(일어날 기): 달리는(走) 자세에서 자기(己) 몸을 일으킴', '동사', 1130, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝7時に起きます。', '매일 아침 7시에 일어납니다.', 1),
    (w, '事故が起きた。', '사고가 일어났다.', 2);

  -- 1131. 教える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '教える', 'おしえる', '가르치다', '教(가르칠 교): 노인(耂)이 아이를 친(攵) 나가며 가르침', '동사', 1131, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語を教えてください。', '일본어를 가르쳐 주세요.', 1),
    (w, '父は数学を教えています。', '아버지는 수학을 가르치고 있습니다.', 2);

  -- 1132. 弟
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '弟', 'おとうと', '남동생', '弟(아우 제): 가죽 끈이 차례로 감긴 모양, 아우', '명사', 1132, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟は高校生です。', '남동생은 고등학생입니다.', 1),
    (w, '弟と一緒に出かけた。', '남동생과 함께 외출했다.', 2);

  -- 1133. 同じ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '同じ', 'おなじ', '같음, 동일함', '同(한가지 동): 뚜껑(冂) 아래 여러 입(口)이 같은 말을 함', '명사', 1133, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私と同じ年です。', '나와 같은 나이입니다.', 1),
    (w, '同じ学校に通っている。', '같은 학교에 다니고 있다.', 2);

  -- 1134. 思い出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '思い出す', 'おもいだす', '생각해내다', '思(생각 사): 머리(田)와 마음(心)으로 생각함
出(날 출): 발이 굴에서 나옴, 떠오름', '동사', 1134, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔のことを思い出した。', '옛날 일을 생각해냈다.', 1),
    (w, '名前を思い出せない。', '이름을 떠올릴 수 없다.', 2);

  -- 1135. 買う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '買う', 'かう', '사다, 구입하다', '買(살 매): 그물(罒) 같은 망태에 재화(貝)를 담음', '동사', 1135, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本屋で雑誌を買った。', '서점에서 잡지를 샀다.', 1),
    (w, '新しい靴を買いたい。', '새 신발을 사고 싶다.', 2);

  -- 1136. 牛肉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '牛肉', 'ぎゅうにく', '쇠고기', '牛(소 우): 소의 머리·뿔 모양
肉(고기 육): 짐승의 살이 베인 모양', '명사', 1136, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夕飯は牛肉を焼く。', '저녁밥은 쇠고기를 굽는다.', 1),
    (w, '牛肉のカレーが好きだ。', '쇠고기 카레를 좋아한다.', 2);

  -- 1137. 暗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '暗い', 'くらい', '어둡다', '暗(어두울 암): 해(日)가 소리(音)만 들릴 정도로 가려져 어두움', 'い형용사', 1137, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋が暗いから電気をつけて。', '방이 어두우니까 불을 켜.', 1),
    (w, '夜の道は暗くて怖い。', '밤길은 어두워서 무섭다.', 2);

  -- 1138. 答える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '答える', 'こたえる', '대답하다', '答(대답할 답): 대(竹) 사이로 합치는(合) 모양, 응함', '동사', 1138, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に答えてください。', '질문에 답해 주세요.', 1),
    (w, '彼は元気よく答えた。', '그는 기운차게 대답했다.', 2);

  -- 1139. 小鳥
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '小鳥', 'ことり', '작은 새', '小(작을 소): 작은 점이 흩어진 모양
鳥(새 조): 새의 모양', '명사', 1139, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '庭に小鳥が来た。', '정원에 작은 새가 왔다.', 1),
    (w, '小鳥の声が聞こえる。', '작은 새의 소리가 들린다.', 2);

  -- 1140. 十分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '十分', 'じゅうぶん', '충분히', '十(열 십): 한 묶음을 의미
分(나눌 분): 칼로 나눔', '부사', 1140, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間は十分あります。', '시간은 충분히 있습니다.', 1),
    (w, '十分に休んでください。', '충분히 쉬세요.', 2);

  -- 1141. 台風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '台風', 'たいふう', '태풍', '台(돈대 대): 받침대
風(바람 풍): 큰 바람', '명사', 1141, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風が来るそうだ。', '태풍이 온다고 한다.', 1),
    (w, '台風で電車が止まった。', '태풍으로 전철이 멈췄다.', 2);

  -- 1142. おもちゃ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'おもちゃ', '장난감', '持つ(가지다)+ち(접미)+ゃ의 변화로 추정, 어린이가 가지고 노는 물건', '명사', 1142, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもがおもちゃで遊ぶ。', '아이가 장난감으로 논다.', 1),
    (w, '新しいおもちゃをもらった。', '새 장난감을 받았다.', 2);

  -- 1143. 正しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '正しい', 'ただしい', '바르다, 옳다', '正(바를 정): 한(一) 곳에 발(止)을 똑바로 둠', 'い형용사', 1143, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '正しい答えを書いてください。', '옳은 답을 적어 주세요.', 1),
    (w, '正しい姿勢で座る。', '바른 자세로 앉다.', 2);

  -- 1144. 建てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '建てる', 'たてる', '(건물을) 세우다, 짓다', '建(세울 건): 붓(聿)을 길게 세워(廴) 짓는 모양', '동사', 1144, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここに新しい家を建てた。', '여기에 새 집을 지었다.', 1),
    (w, 'ビルを建てる工事中だ。', '빌딩을 세우는 공사 중이다.', 2);

  -- 1145. 地図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '地図', 'ちず', '지도', '地(땅 지): 흙이 평평하게 깔린 곳
図(그림 도): 둘러싼 곳 안의 그림', '명사', 1145, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地図を見ながら歩いた。', '지도를 보면서 걸었다.', 1),
    (w, 'この町の地図がほしい。', '이 마을의 지도가 갖고 싶다.', 2);

  -- 1146. 作る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '作る', 'つくる', '만들다', '作(지을 작): 사람(亻)이 잠깐(乍) 사이에 무엇을 만듦', '동사', 1146, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケーキを作って食べた。', '케이크를 만들어 먹었다.', 1),
    (w, '計画を作りましょう。', '계획을 만들어 봅시다.', 2);

  -- 1147. 時計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '時計', 'とけい', '시계', '時(때 시): 해(日)가 절(寺)에 있는 모양, 시간
計(셈할 계): 말(言)로 셈함', '명사', 1147, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この時計は古いです。', '이 시계는 오래되었습니다.', 1),
    (w, '時計を見ると8時だ。', '시계를 보니 8시다.', 2);

  -- 1148. 習う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '習う', 'ならう', '익히다, 배우다', '習(익힐 습): 어린 새가 깃털(羽)을 펴고 흰(白) 하늘을 나는 연습', '동사', 1148, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノを習っています。', '피아노를 배우고 있습니다.', 1),
    (w, '日本語を3年習った。', '일본어를 3년 배웠다.', 2);

  -- 1149. 飲む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '飲む', 'のむ', '마시다, 삼키다', '飲(마실 음): 음식(食)을 입을 벌려(欠) 마심', '동사', 1149, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝コーヒーを飲む。', '매일 아침 커피를 마신다.', 1),
    (w, '薬を水で飲んだ。', '약을 물로 삼켰다.', 2);

  -- 1150. 始まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '始まる', 'はじまる', '시작되다', '始(처음 시): 여자(女) 가운데 새로(台) 시작됨', '동사', 1150, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画は7時に始まる。', '영화는 7시에 시작된다.', 1),
    (w, '新学期が始まった。', '새 학기가 시작되었다.', 2);

  -- 1151. 間に合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '間に合う', 'まにあう', '제시간에 맞추다', '間(사이 간): 문(門) 사이의 해(日), 틈
合(합할 합): 입(口)이 모여 합쳐짐', '동사', 1151, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走って電車に間に合った。', '뛰어서 전철에 시간을 맞췄다.', 1),
    (w, '締切に間に合いません。', '마감에 못 맞춥니다.', 2);

  -- 1152. 持つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '持つ', 'もつ', '가지다, 들다', '持(가질 지): 손(扌)으로 절(寺) 같은 것을 잡음', '동사', 1152, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物を持ってあげましょう。', '짐을 들어드리겠습니다.', 1),
    (w, '彼は車を持っている。', '그는 차를 가지고 있다.', 2);

  -- 1153. 夕飯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '夕飯', 'ゆうはん', '저녁 식사', '夕(저녁 석): 달이 반쯤 뜬 시각
飯(밥 반): 음식(食)이 차려진 모양(反)', '명사', 1153, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夕飯はカレーでした。', '저녁 식사는 카레였습니다.', 1),
    (w, '夕飯はみんなで食べる。', '저녁 식사는 모두 함께 먹는다.', 2);

  -- 1154. 用事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '用事', 'ようじ', '볼일, 용무', '用(쓸 용): 용도·쓰임
事(일 사): 일을 처리함', '명사', 1154, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は用事があります。', '오늘은 볼일이 있습니다.', 1),
    (w, '用事が済んだら連絡する。', '용무가 끝나면 연락한다.', 2);

  -- 1155. 別れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '別れる', 'わかれる', '헤어지다', '別(다를 별): 칼(刂)로 뼈와 살을 가르듯 갈라짐', '동사', 1155, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅前で友だちと別れた。', '역 앞에서 친구와 헤어졌다.', 1),
    (w, '彼女と別れて寂しい。', '그녀와 헤어져서 외롭다.', 2);

  -- 1156. アイディア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'アイディア', '아이디어', '영어 idea의 외래어, 발상·착상을 나타냄', '명사', 1156, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいアイディアが浮かんだ。', '좋은 아이디어가 떠올랐다.', 1),
    (w, 'みんなでアイディアを出し合う。', '모두 아이디어를 내놓는다.', 2);

  -- 1157. 謝る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '謝る', 'あやまる', '사과하다', '謝(사례할 사): 말(言)을 쏘아(射) 보내듯 사죄함', '동사', 1157, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅くなってすみませんと謝った。', '늦어서 죄송하다고 사과했다.', 1),
    (w, '彼はすぐに謝った。', '그는 바로 사과했다.', 2);

  -- 1158. アルバイト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'アルバイト', '아르바이트', '독일어 Arbeit(노동)에서 온 외래어, 일본에서는 부업·시간제 근무를 뜻함', '명사', 1158, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '週末はアルバイトをする。', '주말에는 아르바이트를 한다.', 1),
    (w, 'コンビニのアルバイトを始めた。', '편의점 아르바이트를 시작했다.', 2);

  -- 1159. 安全
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '安全', 'あんぜん', '안전함', '安(편안 안): 집 안의 여자, 평안
全(온전 전): 사람(入) 아래 옥(玉)이 흠 없이 온전함', 'な형용사', 1159, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安全な場所で待ちましょう。', '안전한 곳에서 기다립시다.', 1),
    (w, '子どもの安全が一番大切だ。', '아이의 안전이 가장 중요하다.', 2);

  -- 1160. 案内
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '案内', 'あんない', '안내', '案(책상 안): 책상(木) 앞에서 편안히(安) 살핌
内(안 내): 집(冂) 안에 들어감(入)', '명사', 1160, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで案内してください。', '역까지 안내해 주세요.', 1),
    (w, '町を案内してもらった。', '마을을 안내받았다.', 2);

  -- 1161. 以下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '以下', 'いか', '이하', '以(써 이): ~로써, 기준
下(아래 하): 한(一) 선 아래', '명사', 1161, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '5歳以下は無料です。', '5세 이하는 무료입니다.', 1),
    (w, '今月の売上は予想以下だった。', '이번 달 매출은 예상 이하였다.', 2);

  -- 1162. いくら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'いくら', '아무리', '「いくら、何～ても」 형태로 양보를 나타냄, 의문사 いくら(얼마)에서 파생', '부사', 1162, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いくら考えてもわからない。', '아무리 생각해도 모르겠다.', 1),
    (w, 'いくら呼んでも返事がない。', '아무리 불러도 대답이 없다.', 2);

  -- 1163. 一軒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '一軒', 'いっけん', '한 채, 한 동', '一(한 일): 가로 한 획, 하나
軒(처마 헌): 수레(車) 위 마른 풀(干), 처마·집 단위', '명사', 1163, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '町に一軒だけ古い家がある。', '마을에 한 채만 오래된 집이 있다.', 1),
    (w, '一軒ずつ訪ねて回った。', '한 집씩 방문해 돌았다.', 2);

  -- 1164. いってまいります
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'いってまいります', '다녀오겠습니다', '行く(가다)+参る(겸양어)+ます의 결합, 외출 시 정중한 인사', '표현', 1164, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社へいってまいります。', '회사에 다녀오겠습니다.', 1),
    (w, '出かけるとき、いってまいりますと言う。', '외출할 때 다녀오겠습니다라고 말한다.', 2);

  -- 1165. 植える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '植える', 'うえる', '(나무를) 심다', '植(심을 식): 나무(木)를 곧게(直) 세워 심음', '동사', 1165, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '庭に桜の木を植えた。', '마당에 벚나무를 심었다.', 1),
    (w, '春に花を植えました。', '봄에 꽃을 심었습니다.', 2);

  -- 1166. 打つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '打つ', 'うつ', '부딪치다', '打(칠 타): 손(扌)으로 못(丁)을 치는 모양', '동사', 1166, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転んで頭を打った。', '넘어져서 머리를 부딪쳤다.', 1),
    (w, 'ボールを強く打った。', '공을 세게 쳤다.', 2);

  -- 1167. 腕
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '腕', 'うで', '팔', '腕(팔 완): 몸(月) 가운데 굽은(宛) 부분, 팔', '명사', 1167, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '腕が痛くて重い物が持てない。', '팔이 아파서 무거운 것을 못 든다.', 1),
    (w, '彼は料理の腕がいい。', '그는 요리 솜씨가 좋다.', 2);

  -- 1168. お祝い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お祝い', 'おいわい', '축하 선물', '祝(빌 축): 신(示) 앞에서 입(口)을 벌려 빎', '명사', 1168, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入学のお祝いをもらった。', '입학 축하 선물을 받았다.', 1),
    (w, '友だちにお祝いを贈った。', '친구에게 축하 선물을 보냈다.', 2);

  -- 1169. 屋上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '屋上', 'おくじょう', '옥상', '屋(집 옥): 시신(尸)이 평안히(至) 머무는 집
上(위 상): 한 선 위', '명사', 1169, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビルの屋上から町が見える。', '빌딩 옥상에서 마을이 보인다.', 1),
    (w, '屋上で休みましょう。', '옥상에서 쉽시다.', 2);

  -- 1170. お釣り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お釣り', 'おつり', '거스름돈', '釣(낚시 조): 쇠(金) 갈고리(勺), 잔돈을 ‘낚아’ 받는 데서', '명사', 1170, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お釣りは要りません。', '거스름돈은 필요없습니다.', 1),
    (w, 'お釣りを忘れて帰った。', '거스름돈을 잊고 돌아갔다.', 2);

  -- 1171. お土産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お土産', 'おみやげ', '선물 (여행지 특산물 등)', '土(흙 토): 흙더미
産(낳을 산): 그 곳에서 나는 것', '명사', 1171, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都のお土産を買った。', '교토의 기념품을 샀다.', 1),
    (w, '友だちにお土産をあげた。', '친구에게 기념품을 주었다.', 2);

  -- 1172. おや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'おや', '어라!', '의외의 발견·놀람을 나타내는 감탄사, 「어라!」', '감탄사', 1172, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おや、雨が降ってきた。', '어라, 비가 내리기 시작했다.', 1),
    (w, 'おや、誰か来たようだ。', '어라, 누가 온 것 같다.', 2);

  -- 1173. 折れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '折れる', 'おれる', '꺾이다, 접히다', '折(꺾을 절): 손(扌)으로 도끼(斤)를 휘둘러 꺾음', '동사', 1173, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強い風で枝が折れた。', '강한 바람에 가지가 부러졌다.', 1),
    (w, '紙が折れてしまった。', '종이가 접혀 버렸다.', 2);

  -- 1174. 会場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '会場', 'かいじょう', '회장(장소)', '会(모일 회): 사람들이 모임
場(마당 장): 햇빛 비치는 마당', '명사', 1174, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会場はもう人でいっぱいだ。', '회장은 이미 사람들로 가득하다.', 1),
    (w, '会場までバスで行く。', '회장까지 버스로 간다.', 2);

  -- 1175. 鏡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '鏡', 'かがみ', '거울', '鏡(거울 경): 쇠(金)의 표면이 끝(竟)까지 비춤', '명사', 1175, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鏡で自分の顔を見た。', '거울로 자기 얼굴을 봤다.', 1),
    (w, 'この鏡は大きくて便利だ。', '이 거울은 커서 편리하다.', 2);

  -- 1176. 傘をさす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '傘をさす', 'かさをさす', '우산을 쓰다', '傘(우산 산): 사람들이 들어가는 우산의 모양', '표현', 1176, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ったので傘をさした。', '비가 와서 우산을 썼다.', 1),
    (w, '彼女は赤い傘をさしている。', '그녀는 빨간 우산을 쓰고 있다.', 2);

  -- 1177. 固い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '固い', 'かたい', '딱딱하다', '固(굳을 고): 둘러싼(囗) 안의 옛(古) 것이 굳어짐', 'い형용사', 1177, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このパンは固くて食べにくい。', '이 빵은 딱딱해서 먹기 힘들다.', 1),
    (w, '彼の意志は固い。', '그의 의지는 굳다.', 2);

  -- 1178. 壁
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '壁', 'かべ', '벽', '壁(벽 벽): 흙(土)으로 둘러친(辟) 막', '명사', 1178, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '壁に絵を掛けた。', '벽에 그림을 걸었다.', 1),
    (w, '白い壁が明るく見える。', '하얀 벽이 밝아 보인다.', 2);

  -- 1179. かまいません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'かまいません', '괜찮습니다', '構う(상관하다)의 부정형, 「상관없다」의 정중 표현', '표현', 1179, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し遅れてもかまいません。', '조금 늦어도 괜찮습니다.', 1),
    (w, '窓を開けてもかまいませんか。', '창문을 열어도 괜찮습니까?', 2);

  -- 1180. 噛む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '噛む', 'かむ', '씹다', '噛(씹을 교): 이(歯)가 산(山)을 갈듯 씹음', '동사', 1180, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よく噛んで食べてください。', '잘 씹어서 드세요.', 1),
    (w, '犬に手を噛まれた。', '개에게 손을 물렸다.', 2);

  -- 1181. 関係
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '関係', 'かんけい', '관계', '関(빗장 관): 문(門)에 빗장(关)이 걸린 모양
係(맬 계): 사람(亻)이 실(系)로 매어 놓음', '명사', 1181, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼との関係はとてもいい。', '그와의 관계는 매우 좋다.', 1),
    (w, '仕事と関係のない話だ。', '일과 관계없는 이야기이다.', 2);

  -- 1182. 機会
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '機会', 'きかい', '기회', '機(틀 기): 나무(木)로 만든 베틀, 중요한 시점
会(모일 회): 모임', '명사', 1182, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いい機会を逃した。', '좋은 기회를 놓쳤다.', 1),
    (w, '機会があれば日本へ行きたい。', '기회가 있으면 일본에 가고 싶다.', 2);

  -- 1183. 技術
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '技術', 'ぎじゅつ', '기술', '技(재주 기): 손(扌)으로 가지(支)처럼 재주를 부림
術(꾀 술): 거리(行) 안에서 차조(朮)로 점치는 기술', '명사', 1183, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は高い技術を持っている。', '그는 높은 기술을 가지고 있다.', 1),
    (w, '日本の技術は世界で有名だ。', '일본의 기술은 세계에서 유명하다.', 2);

  -- 1184. 競争
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '競争', 'きょうそう', '경쟁', '競(다툴 경): 두 사람이 다투며 말하는 모양
争(다툴 쟁): 손이 갈고리를 잡으려 다툼', '명사', 1184, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼と競争して走った。', '그와 경쟁하며 달렸다.', 1),
    (w, '会社の競争が激しい。', '회사들의 경쟁이 치열하다.', 2);

  -- 1185. 興味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '興味', 'きょうみ', '흥미, 관심', '興(일 흥): 함께(同) 들어 올림, 일어남
味(맛 미): 입으로 느끼는 맛', '명사', 1185, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の文化に興味がある。', '일본 문화에 관심이 있다.', 1),
    (w, '彼は音楽に興味を持っている。', '그는 음악에 흥미를 가지고 있다.', 2);

  -- 1186. 比べる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '比べる', 'くらべる', '비교하다', '比(견줄 비): 두 사람이 나란히 선 모양', '동사', 1186, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄と背を比べてみた。', '형과 키를 비교해 봤다.', 1),
    (w, '値段を比べて買う。', '가격을 비교해서 산다.', 2);

  -- 1187. ゲーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'ゲーム', '게임', '영어 game의 외래어, 놀이·시합', '명사', 1187, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもがゲームをしている。', '아이가 게임을 하고 있다.', 1),
    (w, '友だちと新しいゲームを買った。', '친구와 새 게임을 샀다.', 2);

  -- 1188. けんか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'けんか', '싸움', '喧(시끄러울 훤)+嘩(시끄러울 화), 양쪽이 시끄럽게 다툮', '명사', 1188, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄弟げんかをしてしまった。', '형제 싸움을 해 버렸다.', 1),
    (w, '小さなことでけんかになった。', '사소한 일로 싸움이 되었다.', 2);

  -- 1189. 郊外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '郊外', 'こうがい', '교외', '郊(들 교): 도성에서 사귀는(交) 마을(阝), 변두리
外(바깥 외): 저녁의 점, 바깥', '명사', 1189, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '郊外に住むのは静かでいい。', '교외에 사는 것은 조용해서 좋다.', 1),
    (w, '郊外の家は広い。', '교외의 집은 넓다.', 2);

  -- 1190. 細かい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '細かい', 'こまかい', '잘다, 세세하다', '細(가늘 세): 실(糸)이 가늘게 마디(田)지듯 가늚', 'い형용사', 1190, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '字が細かくて読めない。', '글씨가 작아서 읽을 수 없다.', 1),
    (w, '彼は細かいことが気になる。', '그는 사소한 것이 신경 쓰인다.', 2);

  -- 1191. 怖い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '怖い', 'こわい', '무섭다', '怖(두려울 포): 마음(忄)이 베(布)에 덮인 듯 두려움', 'い형용사', 1191, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜の道はちょっと怖い。', '밤길은 조금 무섭다.', 1),
    (w, '怖い映画はあまり見ない。', '무서운 영화는 잘 안 본다.', 2);

  -- 1192. 坂
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '坂', 'さか', '언덕', '坂(언덕 판): 흙(土)이 거꾸로(反) 솟아오른 비탈', '명사', 1192, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この坂はちょっときつい。', '이 언덕은 조금 가파르다.', 1),
    (w, '坂の上に学校がある。', '언덕 위에 학교가 있다.', 2);

  -- 1193. さっき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'さっき', '아까', '先(さき, 앞·먼저)에 촉음(っ)이 더해져 강조된 형태, 「조금 전」', '부사', 1193, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さっき電話があった。', '아까 전화가 왔었다.', 1),
    (w, 'さっきの話は本当ですか。', '아까 한 이야기는 사실입니까?', 2);

  -- 1194. 触る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '触る', 'さわる', '만지다', '触(닿을 촉): 뿔(角)이 벌레(虫)에 닿음', '동사', 1194, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冷たい水に触った。', '차가운 물에 닿았다.', 1),
    (w, '展示品に触らないでください。', '전시품에 손대지 마세요.', 2);

  -- 1195. 残念
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '残念', 'ざんねん', '유감스러움, 섭섭함', '残(남을 잔): 부서진 뼈(歹)가 두 번(戔) 남음
念(생각 념): 지금(今)의 마음(心)에 머무는 생각', 'な형용사', 1195, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けなくて残念です。', '갈 수 없어서 아쉽습니다.', 1),
    (w, '残念ですが、また今度。', '유감이지만 다음에.', 2);

  -- 1196. 失敗
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '失敗', 'しっぱい', '실패, 실수', '失(잃을 실): 손(手)에서 무엇이 떨어짐
敗(패할 패): 재화(貝)를 쳐서(攵) 무너뜨림', '명사', 1196, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何度も失敗を繰り返した。', '몇 번이나 실패를 반복했다.', 1),
    (w, '小さな失敗を気にしない。', '사소한 실수를 신경 쓰지 않는다.', 2);

  -- 1197. 失礼
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '失礼', 'しつれい', '실례임', '失(잃을 실): 손에서 떨어짐
礼(예도 례): 신(示) 앞에서 갖추는 예의(乚)', 'な형용사', 1197, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失礼ですが、お名前は。', '실례지만 성함은?', 1),
    (w, '失礼な質問をしてしまった。', '실례되는 질문을 해 버렸다.', 2);

  -- 1198. 邪魔
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '邪魔', 'じゃま', '거추장스러움', '邪(간사할 사): 어금니(牙) 같이 비틀린 마을(阝)
魔(마귀 마): 삼(麻)에 홀린 귀신(鬼)', 'な형용사', 1198, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強の邪魔をしないで。', '공부에 방해하지 마.', 1),
    (w, '邪魔な物を片づけた。', '거추장스러운 물건을 치웠다.', 2);

  -- 1199. 準備
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '準備', 'じゅんび', '준비', '準(준할 준): 물(氵) 새(隹)처럼 평평하게(十) 맞춤
備(갖출 비): 사람이 화살집을 갖추는 모양', '명사', 1199, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発の準備ができた。', '출발 준비가 끝났다.', 1),
    (w, '試験の準備をしている。', '시험 준비를 하고 있다.', 2);

  -- 1200. 招待
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '招待', 'しょうたい', '초대', '招(부를 초): 손(扌)으로 부름(召)
待(기다릴 대): 길에서 기다림', '명사', 1200, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚式に招待された。', '결혼식에 초대받았다.', 1),
    (w, '友だちを家に招待した。', '친구를 집에 초대했다.', 2);

  -- 1201. 成功
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '成功', 'せいこう', '성공', '成(이룰 성): 도끼(戊)로 일을 이룸
功(공 공): 장인(工)이 힘(力)을 다해 만든 공로', '명사', 1201, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実験は成功した。', '실험은 성공했다.', 1),
    (w, '彼は仕事で大成功を収めた。', '그는 일에서 큰 성공을 거뒀다.', 2);

  -- 1202. 生産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '生産', 'せいさん', '생산', '生(날 생): 풀이 흙에서 돋아남
産(낳을 산): 무엇을 낳음', '명사', 1202, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この工場で車を生産している。', '이 공장에서 자동차를 생산하고 있다.', 1),
    (w, '生産が増えた。', '생산이 늘었다.', 2);

  -- 1203. 先輩
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '先輩', 'せんぱい', '선배', '先(먼저 선): 발(止)이 사람(儿) 앞에 있음
輩(무리 배): 마차(車)가 줄지어(非) 가는 모양', '명사', 1203, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の先輩に相談した。', '회사의 선배에게 상담했다.', 1),
    (w, '先輩はとても優しい。', '선배는 매우 친절하다.', 2);

  -- 1204. 相談
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '相談', 'そうだん', '상담', '相(서로 상): 나무(木)와 눈(目)이 마주 봄
談(말씀 담): 말(言)이 불꽃(炎)처럼 활발함', '명사', 1204, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来について相談したい。', '장래에 대해 상담하고 싶다.', 1),
    (w, '先生に相談に行く。', '선생님과 상담하러 간다.', 2);

  -- 1205. それで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'それで', '그래서', 'それ(그것)+で(조사·이유), 앞 문장의 결과·이유 연결', '접속사', 1205, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降った。それで試合は中止だ。', '비가 내렸다. 그래서 시합은 중지다.', 1),
    (w, 'それで、結果はどうでしたか。', '그래서, 결과는 어땠습니까?', 2);

  -- 1206. それに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'それに', '게다가', 'それ(그것)+に(조사), 「게다가」 추가의 의미', '접속사', 1206, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安くて、それにおいしい。', '싸고, 게다가 맛있다.', 1),
    (w, '寒い、それに風も強い。', '춥다, 게다가 바람도 세다.', 2);

  -- 1207. だから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'だから', '그러니까, 그래서', 'だ(단정)+から(이유), 「~이기 때문에」가 줄어 「그래서」', '접속사', 1207, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は雨だ。だから家にいる。', '오늘은 비가 온다. 그러니까 집에 있다.', 1),
    (w, '時間がない、だから急いで。', '시간이 없다, 그러니까 서둘러.', 2);

  -- 1208. 確かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '確かに', 'たしかに', '분명히, 확실하게', '確(굳을 확): 돌(石)이 위로 솟듯 확실함(隺)', '부사', 1208, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確かに昨日会いました。', '분명히 어제 만났습니다.', 1),
    (w, '彼の話は確かに正しい。', '그의 말은 확실히 옳다.', 2);

  -- 1209. 足す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '足す', 'たす', '더하다', '足(발 족): 충분함의 뜻', '동사', 1209, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '砂糖を少し足してください。', '설탕을 조금 더해 주세요.', 1),
    (w, '2に3を足すと5になる。', '2에 3을 더하면 5가 된다.', 2);

  -- 1210. 出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '出す', 'だす', '내다, 제출하다', '出(날 출): 발이 굴 밖으로 나옴', '동사', 1210, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題を出してください。', '숙제를 제출하세요.', 1),
    (w, 'かばんから本を出した。', '가방에서 책을 꺼냈다.', 2);

  -- 1211. 暖房
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '暖房', 'だんぼう', '난방', '暖(따뜻할 난): 해(日) 빛이 따뜻함
房(방 방): 집(戸) 곁의 방', '명사', 1211, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒いので暖房をつけた。', '추워서 난방을 켰다.', 1),
    (w, '暖房が壊れた。', '난방이 고장 났다.', 2);

  -- 1212. チェック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'チェック', '체크, 점검', '영어 check의 외래어, 확인·점검', '명사', 1212, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '答えをチェックしてください。', '답을 확인해 주세요.', 1),
    (w, '荷物をチェックする。', '짐을 점검한다.', 2);

  -- 1213. チケット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'チケット', '티켓, 표', '영어 ticket의 외래어, 표·입장권', '명사', 1213, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画のチケットを買った。', '영화 티켓을 샀다.', 1),
    (w, 'チケットがないと入れない。', '티켓이 없으면 못 들어간다.', 2);

  -- 1214. 中止
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '中止', 'ちゅうし', '중지', '中(가운데 중): 사물의 가운데
止(그칠 지): 발이 멈춤', '명사', 1214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨で試合は中止になった。', '비로 시합은 중지되었다.', 1),
    (w, 'イベントが中止された。', '이벤트가 중지되었다.', 2);

  -- 1215. とうとう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'とうとう', '드디어', '의태어 とう의 반복으로 「마침내·드디어」를 표현', '부사', 1215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とうとう試験が終わった。', '드디어 시험이 끝났다.', 1),
    (w, '彼はとうとう来なかった。', '그는 끝내 오지 않았다.', 2);

  -- 1216. 直す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '直す', 'なおす', '고치다', '直(곧을 직): 눈(目)을 똑바로(十) 향함, 바르게', '동사', 1216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違いを直してください。', '틀린 곳을 고쳐 주세요.', 1),
    (w, '時計を直してもらった。', '시계를 수리받았다.', 2);

  -- 1217. 治る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '治る', 'なおる', '(병이) 낫다', '治(다스릴 치): 물(氵)을 새로(台) 다스림', '동사', 1217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風邪が早く治るといい。', '감기가 빨리 나았으면 좋겠다.', 1),
    (w, 'けがはもう治りました。', '상처는 이미 나았습니다.', 2);

  -- 1218. なるべく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'なるべく', '되도록, 가능한 한', '成る(이루어지다)+べく(가능형), 「가능한 한」', '부사', 1218, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なるべく早く来てください。', '가능한 한 빨리 와 주세요.', 1),
    (w, 'なるべく安いものを選ぶ。', '되도록 싼 것을 고른다.', 2);

  -- 1219. 苦い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '苦い', 'にがい', '(맛이) 쓰다', '苦(쓸 고): 풀(艹) 가운데 옛(古)부터 쓴맛', 'い형용사', 1219, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この薬は苦いです。', '이 약은 씁니다.', 1),
    (w, '苦い経験を忘れない。', '쓰라린 경험을 잊지 않는다.', 2);

  -- 1220. 日本製
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '日本製', 'にほんせい', '일본제(품)', '日(날 일): 해
本(근본 본): 나무 뿌리, 본바탕
製(지을 제): 옷(衣)을 만들어(制) 지음', '명사', 1220, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このカメラは日本製です。', '이 카메라는 일본제입니다.', 1),
    (w, '日本製の車は人気がある。', '일본제 차는 인기가 있다.', 2);

  -- 1221. 熱心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '熱心', 'ねっしん', '열심임', '熱(더울 열): 불(灬)에 익힌(埶) 듯 뜨거움
心(마음 심): 심장 모양', 'な형용사', 1221, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は仕事に熱心だ。', '그는 일에 열심이다.', 1),
    (w, '熱心に勉強している。', '열심히 공부하고 있다.', 2);

  -- 1222. 眠い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '眠い', 'ねむい', '졸리다', '眠(잘 면): 눈(目)이 백성(民)처럼 가만히 감김', 'い형용사', 1222, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日寝てないので眠い。', '어제 못 자서 졸리다.', 1),
    (w, '授業中に眠くなった。', '수업 중에 졸려졌다.', 2);

  -- 1223. 喉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '喉', 'のど', '목(구멍)', '喉(목구멍 후): 입(口)에 이어지는 임금(侯) 같은 통로', '명사', 1223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '喉が痛くて声が出ない。', '목이 아파서 소리가 나오지 않는다.', 1),
    (w, '水を飲んで喉を潤す。', '물을 마셔 목을 적신다.', 2);

  -- 1224. パートタイム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'パートタイム', '파트타임', '영어 part-time의 외래어', '명사', 1224, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母はパートタイムで働いている。', '어머니는 파트타임으로 일하고 있다.', 1),
    (w, 'パートタイムの仕事を探す。', '파트타임 일을 찾는다.', 2);

  -- 1225. 恥ずかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '恥ずかしい', 'はずかしい', '부끄럽다', '恥(부끄러울 치): 귀(耳)에 마음(心)이 붉어짐', 'い형용사', 1225, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人前で歌うのは恥ずかしい。', '사람들 앞에서 노래하는 것은 부끄럽다.', 1),
    (w, '失敗して恥ずかしかった。', '실수해서 부끄러웠다.', 2);

  -- 1226. パソコン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'パソコン', '컴퓨터', 'パーソナルコンピュータ(Personal Computer)의 줄임말', '명사', 1226, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パソコンで仕事をする。', '컴퓨터로 일을 한다.', 1),
    (w, '新しいパソコンが欲しい。', '새 컴퓨터가 갖고 싶다.', 2);

  -- 1227. 番組
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '番組', 'ばんぐみ', '(방송) 프로그램', '番(차례 번): 짐승의 발자국, 차례
組(짤 조): 실(糸)을 또(且) 짠 짜임새', '명사', 1227, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面白い番組を見た。', '재미있는 프로그램을 봤다.', 1),
    (w, '夜10時の番組が好きだ。', '밤 10시 프로그램을 좋아한다.', 2);

  -- 1228. 引き出し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '引き出し', 'ひきだし', '서랍', '引(끌 인): 활(弓)에 화살(丨)을 당김
出(날 출): 빼냄', '명사', 1228, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '引き出しから本を出した。', '서랍에서 책을 꺼냈다.', 1),
    (w, '引き出しの中はきれいだ。', '서랍 안은 깨끗하다.', 2);

  -- 1229. 太る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '太る', 'ふとる', '뚱뚱해지다', '太(클 태): 큰(大) 점(丶), 매우 크다', '동사', 1229, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近少し太った。', '최근 조금 살이 쪘다.', 1),
    (w, '甘いものを食べると太る。', '단것을 먹으면 살이 찐다.', 2);

  -- 1230. 変
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '変', 'へん', '이상함, 변함', '変(변할 변): 또(亦) 손이 가서(夂) 모양이 바뀜', 'な형용사', 1230, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このスープは変な味がする。', '이 수프는 이상한 맛이 난다.', 1),
    (w, '彼の様子が変だ。', '그의 모습이 이상하다.', 2);

  -- 1231. さびしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'さびしい', '쓸쓸하다, 외롭다', '寂(고요할 적)+しい(형용사 어미), 「쓸쓸하다」', 'い형용사', 1231, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人で食事するのはさびしい。', '혼자 식사하는 것은 쓸쓸하다.', 1),
    (w, '友だちが帰ってさびしい。', '친구가 돌아가서 외롭다.', 2);

  -- 1232. 貿易
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '貿易', 'ぼうえき', '무역', '貿(바꿀 무): 토끼풀 같은(卯) 재화(貝)를 바꿈
易(바꿀 역): 도마뱀이 색을 바꾸는 모양', '명사', 1232, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本は外国と貿易をしている。', '일본은 외국과 무역을 하고 있다.', 1),
    (w, '貿易の仕事に興味がある。', '무역 일에 관심이 있다.', 2);

  -- 1233. 放送
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '放送', 'ほうそう', '방송', '放(놓을 방): 뿔(方)을 풀어 놓음(攵)
送(보낼 송): 따라가며 보냄', '명사', 1233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ニュースを放送する。', '뉴스를 방송한다.', 1),
    (w, '生放送で歌った。', '생방송에서 노래했다.', 2);

  -- 1234. 翻訳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '翻訳', 'ほんやく', '번역', '翻(나부낄 번): 깃털(羽)이 차례로(番) 뒤집힘
訳(통변할 역): 말(言)을 뒤집어(尺) 풀어 줌', '명사', 1234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本を翻訳しています。', '이 책을 번역하고 있습니다.', 1),
    (w, '翻訳の仕事は難しい。', '번역 일은 어렵다.', 2);

  -- 1235. または
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'または', '또는', '又(또 우)+は(조사), 「또는」 선택의 의미', '접속사', 1235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車またはバスで来てください。', '전철 또는 버스로 와 주세요.', 1),
    (w, '英語または日本語で書く。', '영어 또는 일본어로 쓴다.', 2);

  -- 1236. 見つかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '見つかる', 'みつかる', '발견되다', '見(볼 견): 눈(目)으로 봄
付(붙을 부): 손(寸)으로 사람(亻)에게 붙임', '동사', 1236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なくした鍵が見つかった。', '잃어버린 열쇠가 발견되었다.', 1),
    (w, 'いい仕事が見つからない。', '좋은 일이 잘 찾아지지 않는다.', 2);

  -- 1237. 珍しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '珍しい', 'めずらしい', '진귀하다, 드물다', '珍(보배 진): 옥(玉)이 무리(㐱) 가운데 빼어남', 'い형용사', 1237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京で雪が降るのは珍しい。', '도쿄에서 눈이 오는 것은 드물다.', 1),
    (w, '珍しい料理を食べた。', '진귀한 요리를 먹었다.', 2);

  -- 1238. 役に立つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '役に立つ', 'やくにたつ', '도움이 되다', '役(부릴 역): 길에서 일을 시킴
立(설 립): 사람이 땅에 섬', '표현', 1238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本はとても役に立つ。', '이 책은 매우 도움이 된다.', 1),
    (w, '辞書は勉強に役に立つ。', '사전은 공부에 도움이 된다.', 2);

  -- 1239. やっと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'やっと', '겨우, 간신히', '의태어, 어렵게 또는 마침내 도달함을 표현', '부사', 1239, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やっと宿題が終わった。', '겨우 숙제가 끝났다.', 1),
    (w, 'やっと意味が分かった。', '겨우 의미를 알았다.', 2);

  -- 1240. やっぱり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'やっぱり', '역시', 'やはり의 강조 회화체, 「역시」', '부사', 1240, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やっぱり彼は来なかった。', '역시 그는 오지 않았다.', 1),
    (w, 'やっぱりこれが一番おいしい。', '역시 이것이 제일 맛있다.', 2);

  -- 1241. やわらかい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'やわらかい', '부드럽다', '柔(부드러울 유)+らかい(형용사 어미), 「부드럽다」', 'い형용사', 1241, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このパンはやわらかい。', '이 빵은 부드럽다.', 1),
    (w, 'やわらかい声で話す。', '부드러운 목소리로 말한다.', 2);

  -- 1242. 予約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '予約', 'よやく', '예약', '予(미리 예): 미리 준비함
約(맺을 약): 실(糸)로 묶어(勺) 약속함', '명사', 1242, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ホテルを予約しました。', '호텔을 예약했습니다.', 1),
    (w, 'レストランの予約をする。', '식당을 예약한다.', 2);

  -- 1243. 寄る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '寄る', 'よる', '들르다', '寄(부칠 기): 집(宀) 기이한(奇) 곳에 의지함', '동사', 1243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰りにスーパーへ寄る。', '돌아가는 길에 슈퍼에 들른다.', 1),
    (w, '友だちの家に寄った。', '친구네 집에 들렀다.', 2);

  -- 1244. 利用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '利用', 'りよう', '이용', '利(이로울 리): 벼(禾)를 칼(刂)로 베어 이로움
用(쓸 용): 통의 모양, 사용함', '명사', 1244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館をよく利用する。', '도서관을 자주 이용한다.', 1),
    (w, 'インターネットを利用して調べる。', '인터넷을 이용해 조사한다.', 2);

  -- 1245. レジ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'レジ', '계산대, 레지스터', 'レジスター(register)의 줄임말', '명사', 1245, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'レジで支払いをした。', '계산대에서 결제했다.', 1),
    (w, 'レジに長い列ができた。', '계산대에 긴 줄이 생겼다.', 2);

  -- 1246. レポート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'レポート', '리포트', '영어 report의 외래어, 보고서', '명사', 1246, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日までにレポートを出す。', '내일까지 리포트를 낸다.', 1),
    (w, 'レポートを書くのに時間がかかった。', '리포트를 쓰는 데 시간이 걸렸다.', 2);

  -- 1247. 連絡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '連絡', 'れんらく', '연락', '連(잇닿을 련): 수레(車)가 잇따라 감
絡(이을 락): 실(糸)이 각각(各) 이어짐', '명사', 1247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何かあったら連絡してください。', '무슨 일이 있으면 연락해 주세요.', 1),
    (w, '友だちに連絡を取った。', '친구에게 연락을 취했다.', 2);

  -- 1248. 意見
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '意見', 'いけん', '의견', '意(뜻 의): 마음(心)에서 우러나는 소리(音)
見(볼 견): 눈(目)으로 봄', '명사', 1248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見を聞かせてください。', '의견을 들려 주세요.', 1),
    (w, '彼の意見に賛成だ。', '그의 의견에 찬성이다.', 2);

  -- 1249. いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'いたす', '하다 (겸양어)', '致す(いたす): 致(이를 치)+す, 「하다」의 겸양어', '동사', 1249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私がご案内いたします。', '제가 안내하겠습니다.', 1),
    (w, 'お電話いたしました。', '전화드렸습니다.', 2);

  -- 1250. いただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'いただく', '받다 (겸양어)', '頂く(いただく): 頂(정수리 정)+く, 「머리 위로 들다」에서 유래한 겸양어', '동사', 1250, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お土産をいただきました。', '선물을 받았습니다.', 1),
    (w, 'お先にいただきます。', '먼저 잘 먹겠습니다.', 2);

  -- 1251. うまい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'うまい', '(1) 맛있다, (2) 능숙하다', 'うま의 어감을 가진 형용사, 「맛있다」·「능숙하다」 둘 다 표현', 'い형용사', 1251, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店の料理はうまい。', '이 가게의 요리는 맛있다.', 1),
    (w, '彼は絵がうまい。', '그는 그림을 잘 그린다.', 2);

  -- 1252. おかげさまで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'おかげさまで', '덕분에', 'お陰(그늘)+様(존칭)+で, 「당신의 그늘 덕에」에서 유래한 인사', '표현', 1252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おかげさまで元気です。', '덕분에 잘 지냅니다.', 1),
    (w, 'おかげさまで合格しました。', '덕분에 합격했습니다.', 2);

  -- 1253. おとなしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'おとなしい', '얌전하다', '大人(やさしい)의 어감으로 「어른스럽다·잠잔하다」', 'い형용사', 1253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女はとてもおとなしい子だ。', '그녀는 매우 얌전한 아이다.', 1),
    (w, 'おとなしく座っている。', '얌전히 앉아 있다.', 2);

  -- 1254. 驚く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '驚く', 'おどろく', '놀라다', '驚(놀랄 경): 말(馬)이 공경(敬)하듯 갑자기 놀람', '동사', 1254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '突然の音に驚いた。', '갑작스러운 소리에 놀랐다.', 1),
    (w, '彼の話を聞いて驚いた。', '그의 이야기를 듣고 놀랐다.', 2);

  -- 1255. お礼
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お礼', 'おれい', '감사 인사', '礼(예도 례): 신(示) 앞에서 갖추는 예의', '명사', 1255, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にお礼を言った。', '선생님에게 감사 인사를 했다.', 1),
    (w, 'お礼の手紙を書いた。', '감사 편지를 썼다.', 2);

  -- 1256. かしこまりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'かしこまりました', '알겠습니다', '畑まる(かしこまる, 공손해하다)+ました, 「알겠습니다」의 정중한 표현', '표현', 1256, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はい、かしこまりました。', '네, 알겠습니다.', 1),
    (w, 'かしこまりました、すぐに用意します。', '알겠습니다, 바로 준비하겠습니다.', 2);

  -- 1257. 片付ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '片付ける', 'かたづける', '정리하다, 치우다', '片(조각 편): 나무를 쪼갠 모양
付(붙을 부): 손으로 사람에게 붙임', '동사', 1257, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋を片付けてください。', '방을 정리해 주세요.', 1),
    (w, '使った物を片付ける。', '사용한 물건을 치운다.', 2);

  -- 1258. きびしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'きびしい', '엄하다, 엄격하다', '厳(엄할 엄)+しい(형용사 어미), 「엄격하다」', 'い형용사', 1258, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父はとてもきびしい人だ。', '아버지는 매우 엄격한 사람이다.', 1),
    (w, '練習がきびしくて疲れる。', '연습이 엄해서 지친다.', 2);

  -- 1259. 原因
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '原因', 'げんいん', '원인', '原(근원 원): 언덕(厂) 아래 샘(泉)이 솟는 근원
因(인할 인): 둘러싼(囗) 안에 큰(大), 의지함·원인', '명사', 1259, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故の原因を調べる。', '사고의 원인을 조사한다.', 1),
    (w, '失敗の原因が分かった。', '실패의 원인을 알았다.', 2);

  -- 1260. 元気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '元気', 'げんき', '건강함', '元(으뜸 원): 사람의 머리, 으뜸
気(기운 기): 쌀을 찐 김, 기운', 'な형용사', 1260, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お元気ですか。', '잘 지내십니까?', 1),
    (w, '元気な子どもが多い。', '건강한 아이들이 많다.', 2);

  -- 1261. 故障
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '故障', 'こしょう', '고장', '故(연고 고): 옛(古)일을 친(攵) 까닭
障(막을 장): 언덕(阝) 위로 막힘(章)', '명사', 1261, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が故障してしまった。', '차가 고장 나 버렸다.', 1),
    (w, '機械の故障を直す。', '기계의 고장을 고친다.', 2);

  -- 1262. さしあげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'さしあげる', '드리다 (경어)', '差し上げる: 差す(내밀다)+上げる(올리다), 「드리다」의 경어', '동사', 1262, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にプレゼントをさしあげた。', '선생님께 선물을 드렸다.', 1),
    (w, 'お土産をさしあげます。', '선물을 드리겠습니다.', 2);

  -- 1263. 寒い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '寒い', 'さむい', '춥다', '寒(찰 한): 집(宀) 안 풀(茻) 더미와 얼음(冫), 추위', 'い형용사', 1263, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はとても寒いです。', '오늘은 매우 춥습니다.', 1),
    (w, '冬は寒くて出かけたくない。', '겨울은 추워서 외출하고 싶지 않다.', 2);

  -- 1264. 叱る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '叱る', 'しかる', '꾸짖다', '叱(꾸짖을 질): 입(口)으로 비수(匕)처럼 날카롭게 말함', '동사', 1264, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '母に叱られた。', '어머니에게 혼났다.', 1),
    (w, '子どもを優しく叱る。', '아이를 부드럽게 꾸짖는다.', 2);

  -- 1265. 支度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '支度', 'したく', '준비, 채비', '支(가를 지): 가지를 갈라 받침
度(법도 도): 손으로 길이를 잼', '명사', 1265, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かける支度をする。', '외출할 채비를 한다.', 1),
    (w, '夕食の支度を手伝う。', '저녁 식사 준비를 돕는다.', 2);

  -- 1266. しっかりしている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'しっかりしている', '착실하다, 다부지다', '의태어 しっかり(단단히)+している(~하고 있다), 「다부지다·착실하다」', '표현', 1266, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はしっかりしている人だ。', '그는 다부진 사람이다.', 1),
    (w, '若いのにしっかりしている。', '젊은데 착실하다.', 2);

  -- 1267. 閉める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '閉める', 'しめる', '(문 따위를) 닫다', '閉(닫을 폐): 문(門) 안에 빗장(才)을 가로지름', '동사', 1267, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒いので窓を閉めてください。', '추우니까 창문을 닫아 주세요.', 1),
    (w, '店を10時に閉めます。', '가게를 10시에 닫습니다.', 2);

  -- 1268. 捨てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '捨てる', 'すてる', '버리다', '捨(버릴 사): 손(扌)으로 집(舎) 밖에 놓아 버림', '동사', 1268, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ごみを捨てないでください。', '쓰레기를 버리지 마세요.', 1),
    (w, '古い服を捨てた。', '오래된 옷을 버렸다.', 2);

  -- 1269. 洗濯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '洗濯', 'せんたく', '세탁', '洗(씻을 세): 물로 먼저 깨끗이 함
濯(씻을 탁): 물(氵)로 새(隹) 깃을 빨아 깨끗이 함', '명사', 1269, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日曜日に洗濯をする。', '일요일에 세탁을 한다.', 1),
    (w, '雨の日は洗濯ができない。', '비 오는 날은 빨래를 못 한다.', 2);

  -- 1270. 育てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '育てる', 'そだてる', '기르다, 키우다', '育(기를 육): 갓 태어난 아이(子)를 살(月)로 감싸 기름', '동사', 1270, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花を大切に育てている。', '꽃을 소중히 기르고 있다.', 1),
    (w, '子どもを育てるのは大変だ。', '아이를 키우는 것은 힘들다.', 2);

  -- 1271. 大抵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '大抵', 'たいてい', '대체로', '大(큰 대): 사람이 팔다리를 벌린 모양
抵(막을 저): 손으로 받쳐 막음, 거의', '부사', 1271, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休みの日は大抵家にいる。', '쉬는 날은 대개 집에 있다.', 1),
    (w, '大抵のことは自分でできる。', '대체로의 일은 스스로 할 수 있다.', 2);

  -- 1272. だめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'だめ', '안 됨, 불가능함', '駄目(다메): 駄(둔말 태)+目(눈 목), 「쓸모없는 눈」에서 「안 됨」', 'な형용사', 1272, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は忙しいのでだめだ。', '오늘은 바빠서 안 된다.', 1),
    (w, 'うそをついてはだめです。', '거짓말을 해서는 안 됩니다.', 2);

  -- 1273. 伝える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '伝える', 'つたえる', '전하다, 전달하다', '伝(전할 전): 사람(亻)이 오로지(専) 전달함', '동사', 1273, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'みんなによろしくと伝えてください。', '모두에게 안부를 전해 주세요.', 1),
    (w, '気持ちを言葉で伝える。', '마음을 말로 전한다.', 2);

  -- 1274. 適当
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '適当', 'てきとう', '적당함', '適(맞을 적): 길(辶)에 적합함(啇)
当(마땅 당): 작은 흙의 적당한 양', 'な형용사', 1274, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '適当な大きさに切る。', '적당한 크기로 자른다.', 1),
    (w, '適当な答えを書きました。', '적당한 답을 적었습니다.', 2);

  -- 1275. 途中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '途中', 'とちゅう', '도중', '途(길 도): 길(辶) 가운데 길게(余) 이어짐
中(가운데 중): 가운데', '명사', 1275, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校へ行く途中で会った。', '학교 가는 도중에 만났다.', 1),
    (w, '途中で電車を降りた。', '도중에 전철에서 내렸다.', 2);

  -- 1276. どんどん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'どんどん', '쑥쑥', '의성어 どん의 반복으로 순조롭게 진행되는 모양, 「슕슕·계속」', '부사', 1276, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語がどんどん上手になる。', '일본어가 쑥쑥 늘고 있다.', 1),
    (w, '子どもはどんどん大きくなる。', '아이는 쑥쑥 자란다.', 2);

  -- 1277. 似合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '似合う', 'にあう', '어울리다', '似(닮을 사): 사람(亻)이 비슷함(以)
合(합할 합): 입이 합쳐짐, 맞음', '동사', 1277, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その服はよく似合う。', '그 옷은 잘 어울린다.', 1),
    (w, '彼に赤色は似合わない。', '그에게 빨간색은 어울리지 않는다.', 2);

  -- 1278. 熱
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '熱', 'ねつ', '열', '熱(더울 열): 불 위에 익힌 듯 뜨거움', '명사', 1278, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '熱があるので休みます。', '열이 있어서 쉽니다.', 1),
    (w, '高い熱が下がらない。', '높은 열이 떨어지지 않는다.', 2);

  -- 1279. プレゼント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'プレゼント', '선물', '영어 present의 외래어, 선물', '명사', 1279, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誕生日のプレゼントをもらった。', '생일 선물을 받았다.', 1),
    (w, '友だちにプレゼントを贈った。', '친구에게 선물을 보냈다.', 2);

  -- 1280. 返事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '返事', 'へんじ', '대답', '返(돌이킬 반): 거꾸로 돌아옴
事(일 사): 일', '명사', 1280, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メールの返事を書く。', '메일의 답장을 쓴다.', 1),
    (w, '名前を呼ばれたら返事をしてください。', '이름이 불리면 대답해 주세요.', 2);

  -- 1281. 真面目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '真面目', 'まじめ', '진지함, 성실함', '真(참 진): 솥 위 사람이 똑바로 섬
面(낯 면): 얼굴
目(눈 목): 눈', 'な형용사', 1281, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は真面目な学生です。', '그는 성실한 학생입니다.', 1),
    (w, '真面目に話を聞いてください。', '진지하게 이야기를 들어 주세요.', 2);

  -- 1282. 迎える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '迎える', 'むかえる', '맞이하다', '迎(맞을 영): 우러러(卬) 마중을 나감(辶)', '동사', 1282, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で友だちを迎える。', '역에서 친구를 마중 나간다.', 1),
    (w, '新年を家族と迎えた。', '새해를 가족과 맞이했다.', 2);

  -- 1283. ゆっくりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, NULL, 'ゆっくりと', '천천히', '의태어 ゆっくり(천천히)+と(조사), 여유롭고 느린 모양', '부사', 1283, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ゆっくりと話してください。', '천천히 말해 주세요.', 1),
    (w, 'ゆっくりと食べた方がいい。', '천천히 먹는 편이 좋다.', 2);

  -- 1284. 喜ぶ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '喜ぶ', 'よろこぶ', '기뻐하다', '喜(기쁠 희): 북(壴)을 두드리며 입(口)으로 기뻐함', '동사', 1284, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼントをもらって喜んだ。', '선물을 받고 기뻐했다.', 1),
    (w, '彼は合格をとても喜んだ。', '그는 합격을 매우 기뻐했다.', 2);

  -- 1285. 沸かす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '沸かす', 'わかす', '(물을) 끓이다', '沸(끓을 비): 물(氵)이 솟아오름(弗)', '동사', 1285, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お湯を沸かしてお茶をいれる。', '물을 끓여 차를 우린다.', 1),
    (w, 'やかんでお湯を沸かす。', '주전자로 물을 끓인다.', 2);

  -- ============================================================
  -- 유의어 섹션 (49쌍): PDF에 ≒ 형태로 제시된 표현 페어를 그대로 암기 단위로 저장
  -- ============================================================

  -- 1286. あいさつしました ≒「おはようございます。」と言いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'あいさつしました', 'あいさつしました', '인사를 했습니다 ≒「おはようございます。」と言いました("안녕하세요."라고 말했습니다)', '≒「おはようございます。」と言いました\n인사를 한다는 행위는 곧 인사말을 말로 표현한 것', '유의 표현', 1286, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にあいさつしました。', '선생님께 인사를 했습니다.', 1),
    (w, '「おはようございます。」と言いました。', '"안녕하세요."라고 말했습니다.', 2);

  -- 1287. あしたはちょっと…… ≒ あしたはだめです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'あしたはちょっと……', 'あしたはちょっと', '내일은 좀…… ≒ あしたはだめです(내일은 안 됩니다)', '≒ あしたはだめです\n「ちょっと……」은 일본어 우회적 거절 표현으로 「だめ(안 됨)」과 동일', '유의 표현', 1287, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日はちょっと……。', '내일은 좀…….', 1),
    (w, '明日はだめです。', '내일은 안 됩니다.', 2);

  -- 1288. あの店はいつもすいています ≒ あの店はいつもお客が少ないです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'あの店はいつもすいています', 'あのみせはいつもすいています', '저 가게는 언제나 비어 있습니다 ≒ あの店はいつもお客が少ないです(저 가게는 늘 손님이 적습니다)', '≒ あの店はいつもお客が少ないです\nすいている(비어 있다)=客が少ない(손님이 적다)', '유의 표현', 1288, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの店はいつもすいています。', '저 가게는 언제나 비어 있습니다.', 1),
    (w, 'あの店はいつもお客が少ないです。', '저 가게는 늘 손님이 적습니다.', 2);

  -- 1289. 謝りました ≒「ごめんなさい。」と言いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '謝りました', 'あやまりました', '사과했습니다 ≒「ごめんなさい。」と言いました("미안합니다."라고 말했습니다)', '≒「ごめんなさい。」と言いました\n사과하는 행위는 곧 「미안합니다」 말을 한 것', '유의 표현', 1289, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちにあやまりました。', '친구에게 사과했습니다.', 1),
    (w, '「ごめんなさい。」と言いました。', '"미안합니다."라고 말했습니다.', 2);

  -- 1290. 一生懸命 ≒ 熱心に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '一生懸命', 'いっしょうけんめい', '열심히 ≒ 熱心に(열심히)', '≒ 熱心に\nいっしょうけんめい(목숨 걸고)=ねっしんに(열심히) - 강도 높은 노력을 나타냄', '유의 표현', 1290, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一生懸命勉強しました。', '열심히 공부했습니다.', 1),
    (w, '熱心に働いています。', '열심히 일하고 있습니다.', 2);

  -- 1291. うそです ≒ ほんとうではありません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'うそです', 'うそです', '거짓말입니다 ≒ ほんとうではありません(사실이 아닙니다)', '≒ ほんとうではありません\nうそ(거짓)=ほんとうではない(사실이 아님)', '유의 표현', 1291, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その話はうそです。', '그 이야기는 거짓말입니다.', 1),
    (w, 'それはほんとうではありません。', '그것은 사실이 아닙니다.', 2);

  -- 1292. お父さんに叱られました ≒ お父さんに怒られました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お父さんに叱られました', 'おとうさんにしかられました', '아버지에게 야단맞았습니다 ≒ お父さんに怒られました(아버지에게 혼났습니다)', '≒ お父さんに怒られました\n叱る(꾸짖다)=怒る(화내다) - 둘 다 윗사람이 야단치는 행위', '유의 표현', 1292, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お父さんに叱られました。', '아버지에게 야단맞았습니다.', 1),
    (w, 'お父さんに怒られました。', '아버지에게 혼났습니다.', 2);

  -- 1293. お礼を言いました ≒「ありがとうございます。」と言いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'お礼を言いました', 'おれいをいいました', '감사 인사를 했습니다 ≒「ありがとうございます。」と言いました("고맙습니다."라고 말했습니다)', '≒「ありがとうございます。」と言いました\nお礼(감사 인사)을 한다는 것=「ありがとうございます」 말을 한 것', '유의 표현', 1293, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生にお礼を言いました。', '선생님께 감사 인사를 했습니다.', 1),
    (w, '「ありがとうございます。」と言いました。', '"고맙습니다."라고 말했습니다.', 2);

  -- 1294. 買い物に誘いました ≒「いっしょに買い物に行きませんか」と言いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '買い物に誘いました', 'かいものにさそいました', '쇼핑하자고 권했습니다 ≒「いっしょに買い物に行きませんか」と言いました("같이 쇼핑 가지 않을래요?"라고 말했습니다)', '≒「いっしょに買い物に行きませんか」と言いました\n誘う(권하다)=「いっしょに〜ませんか」(같이 ~할래요?) 말로 권유', '유의 표현', 1294, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友だちを買い物に誘いました。', '친구를 쇼핑하자고 권했습니다.', 1),
    (w, '「いっしょに買い物に行きませんか」と言いました。', '"같이 쇼핑 가지 않을래요?"라고 말했습니다.', 2);

  -- 1295. かならず来ると思います ≒ きっと来ると思います
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'かならず来ると思います', 'かならずくるとおもいます', '꼭 올 거라고 생각합니다 ≒ きっと来ると思います(반드시 올 거라고 생각합니다)', '≒ きっと来ると思います\nかならず(꼭)=きっと(반드시) - 둘 다 강한 확신을 나타냄', '유의 표현', 1295, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かならず来ると思います。', '꼭 올 거라고 생각합니다.', 1),
    (w, 'きっと来ると思います。', '반드시 올 거라고 생각합니다.', 2);

  -- 1296. 危険です ≒ あぶないです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '危険です', 'きけんです', '위험합니다 ≒ あぶないです(위험합니다)', '≒ あぶないです\n危険(きけん, 한자어)=あぶない(고유어) - 한자어/고유어 페어', '유의 표현', 1296, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここは危険です。', '이곳은 위험합니다.', 1),
    (w, '道があぶないです。', '길이 위험합니다.', 2);

  -- 1297. きびしい時代はもう過ぎました ≒ 大変な時代でした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'きびしい時代はもう過ぎました', 'きびしいじだいはもうすぎました', '힘든 시대는 이제 지나갔습니다 ≒ 大変な時代でした(어려운 시대였습니다)', '≒ 大変な時代でした\nきびしい(엄혹한)=たいへんな(힘든) - 둘 다 어려운 시기 표현', '유의 표현', 1297, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'きびしい時代はもう過ぎました。', '힘든 시대는 이제 지나갔습니다.', 1),
    (w, '大変な時代でした。', '어려운 시대였습니다.', 2);

  -- 1298. 景色のいいところ ≒ きれいな山や森が見える公園
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '景色のいいところ', 'けしきのいいところ', '경치가 좋은 곳 ≒ きれいな山や森が見える公園(멋진 산이나 숲이 보이는 공원)', '≒ きれいな山や森が見える公園\n景色がいい(경치가 좋다)=きれいな自然(자연)が見える', '유의 표현', 1298, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'けしきのいいところに行きたい。', '경치 좋은 곳에 가고 싶다.', 1),
    (w, 'きれいな山や森が見える公園。', '멋진 산이나 숲이 보이는 공원.', 2);

  -- 1299. 講義に出席します ≒ 大学で先生の話を聞きます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '講義に出席します', 'こうぎにしゅっせきします', '강의에 출석합니다 ≒ 大学で先生の話を聞きます(대학에서 선생님의 이야기를 듣습니다)', '≒ 大学で先生の話を聞きます\n강의에 출석=대학에서 선생님 강의를 듣는 행위', '유의 표현', 1299, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '講義に出席します。', '강의에 출석합니다.', 1),
    (w, '大学で先生の話を聞きます。', '대학에서 선생님의 이야기를 듣습니다.', 2);

  -- 1300. 交通が便利です ≒ バスや地下鉄がたくさん走っています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '交通が便利です', 'こうつうがべんりです', '교통이 편리합니다 ≒ バスや地下鉄がたくさん走っています(버스나 지하철이 많이 달리고 있습니다)', '≒ バスや地下鉄がたくさん走っています\n교통이 편리함=대중교통이 풍부하게 운행되는 상태', '유의 표현', 1300, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この町は交通が便利です。', '이 동네는 교통이 편리합니다.', 1),
    (w, 'バスや地下鉄がたくさん走っています。', '버스나 지하철이 많이 달리고 있습니다.', 2);

  -- 1301. ここは滑りやすいのです ≒ ここは歩きにくいです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'ここは滑りやすいのです', 'ここはすべりやすいのです', '이곳은 미끄러지기 쉽습니다 ≒ ここは歩きにくいです(이곳은 걷기 불편합니다)', '≒ ここは歩きにくいです\n滑りやすい(미끄러지기 쉬움)=歩きにくい(걷기 어려움)', '유의 표현', 1301, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここはすべりやすいのです。', '이곳은 미끄러지기 쉽습니다.', 1),
    (w, 'ここはあるきにくいです。', '이곳은 걷기 불편합니다.', 2);

  -- 1302. このワインはヨーロッパ製です ≒ このワインはヨーロッパで作られています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'このワインはヨーロッパ製です', 'このワインはヨーロッパせいです', '이 와인은 유럽제입니다 ≒ このワインはヨーロッパで作られています(이 와인은 유럽에서 만들어지고 있습니다)', '≒ このワインはヨーロッパで作られています\n~製=~で作られた(~에서 만들어진)', '유의 표현', 1302, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このワインはヨーロッパ製です。', '이 와인은 유럽제입니다.', 1),
    (w, 'このワインはヨーロッパで作られています。', '이 와인은 유럽에서 만들어지고 있습니다.', 2);

  -- 1303. 財布を盗まれました ≒ 財布を取られました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '財布を盗まれました', 'さいふをぬすまれました', '지갑을 도둑맞았습니다 ≒ 財布を取られました(지갑을 날치기당했습니다)', '≒ 財布を取られました\n盗まれる(도둑맞다)=取られる(빼앗기다) - 둘 다 수동 형태', '유의 표현', 1303, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布をぬすまれました。', '지갑을 도둑맞았습니다.', 1),
    (w, '財布をとられました。', '지갑을 날치기당했습니다.', 2);

  -- 1304. サッカーが盛んになりました ≒ サッカーをする人が増えました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'サッカーが盛んになりました', 'サッカーがさかんになりました', '축구가 왕성해졌습니다 ≒ サッカーをする人が増えました(축구를 하는 사람이 늘었습니다)', '≒ サッカーをする人が増えました\n盛んになる(왕성해지다)=その活動をする人が増える', '유의 표현', 1304, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカーがさかんになりました。', '축구가 왕성해졌습니다.', 1),
    (w, 'サッカーをする人がふえました。', '축구를 하는 사람이 늘었습니다.', 2);

  -- 1305. 騒がないでください ≒ うるさくしないでください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '騒がないでください', 'さわがないでください', '떠들지 말아 주세요 ≒ うるさくしないでください(시끄럽게 하지 말아 주세요)', '≒ うるさくしないでください\n騒ぐ(떠들다)=うるさい(시끄러운) 상태로 만들다', '유의 표현', 1305, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さわがないでください。', '떠들지 말아 주세요.', 1),
    (w, 'うるさくしないでください。', '시끄럽게 하지 말아 주세요.', 2);

  -- 1306. 宿題は簡単でした ≒ 宿題はやさしかったです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '宿題は簡単でした', 'しゅくだいはかんたんでした', '숙제는 간단했습니다 ≒ 宿題はやさしかったです(숙제는 쉬웠습니다)', '≒ 宿題はやさしかったです\n簡単(かんたん, 한자어)=やさしい(고유어) - 둘 다 「쉬움」 표현', '유의 표현', 1306, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題はかんたんでした。', '숙제는 간단했습니다.', 1),
    (w, '宿題はやさしかったです。', '숙제는 쉬웠습니다.', 2);

  -- 1307. 将来の計画 ≒ これからの計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '将来の計画', 'しょうらいのけいかく', '장래 계획 ≒ これからの計画(앞으로의 계획)', '≒ これからの計画\n将来(しょうらい, 미래)=これから(앞으로) - 시점 표현', '유의 표현', 1307, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しょうらいの計画を立てる。', '장래 계획을 세운다.', 1),
    (w, 'これからの計画を話す。', '앞으로의 계획을 이야기한다.', 2);

  -- 1308. 食事にしましょう ≒ ご飯を食べましょう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '食事にしましょう', 'しょくじにしましょう', '식사를 합시다 ≒ ご飯を食べましょう(밥을 먹읍시다)', '≒ ご飯を食べましょう\n食事(식사)を取る=ご飯を食べる(밥을 먹다)', '유의 표현', 1308, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そろそろ食事にしましょう。', '슬슬 식사를 합시다.', 1),
    (w, '一緒にご飯を食べましょう。', '같이 밥을 먹읍시다.', 2);

  -- 1309. 字をていねいに書きなさい ≒ きれいに字を書きなさい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '字をていねいに書きなさい', 'じをていねいにかきなさい', '글씨를 정성스럽게 쓰세요 ≒ きれいに字を書きなさい(깨끗하게 글씨를 쓰세요)', '≒ きれいに字を書きなさい\nていねいに(정성스럽게)=きれいに(깨끗하게)', '유의 표현', 1309, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '字をていねいに書きなさい。', '글씨를 정성스럽게 쓰세요.', 1),
    (w, 'きれいに字を書きなさい。', '깨끗하게 글씨를 쓰세요.', 2);

  -- 1310. 先生のお宅にうかがいます ≒ 先生のお宅にまいります
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '先生のお宅にうかがいます', 'せんせいのおたくにうかがいます', '선생님 댁을 찾아뵙습니다 ≒ 先生のお宅にまいります(선생님 댁에 갑니다)', '≒ 先生のお宅にまいります\nうかがう(訪う의 겸양)=まいる(行く의 겸양) - 둘 다 겸양 표현', '유의 표현', 1310, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生のおたくにうかがいます。', '선생님 댁을 찾아뵙습니다.', 1),
    (w, '先生のおたくにまいります。', '선생님 댁에 갑니다.', 2);

  -- 1311. 退院する ≒ 病院から帰ってくる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '退院する', 'たいいんする', '퇴원하다 ≒ 病院から帰ってくる(병원에서 돌아오다)', '≒ 病院から帰ってくる\n退院=병원에서 나와 집으로 돌아오는 행위', '유의 표현', 1311, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来週たいいんします。', '다음 주 퇴원합니다.', 1),
    (w, '病院からかえってきます。', '병원에서 돌아옵니다.', 2);

  -- 1312. 田中さん以外は来ました ≒ 田中さんは来ませんでしたが、ほかの人は来ました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '田中さん以外は来ました', 'たなかさんいがいはきました', '다나카 씨 외에는 왔습니다 ≒ 田中さんは来ませんでしたが、ほかの人は来ました(다나카 씨는 오지 않았지만, 다른 사람은 왔습니다)', '≒ 田中さんは来ませんでしたが、ほかの人は来ました\n「~以外は来た」=「~は来ない+他は来た」 분리 표현', '유의 표현', 1312, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中さん以外は来ました。', '다나카 씨 외에는 왔습니다.', 1),
    (w, '田中さんは来ませんでしたが、ほかの人は来ました。', '다나카 씨는 오지 않았지만, 다른 사람은 왔습니다.', 2);

  -- 1313. 田中さんの代わりに私がパーティーに出ました ≒ 田中さんはパーティーに出ませんでした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '田中さんの代わりに私がパーティーに出ました', 'たなかさんのかわりにわたしがパーティーにでました', '다나카 씨 대신에 제가 파티에 나갔습니다 ≒ 田中さんはパーティーに出ませんでした(다나카 씨는 파티에 나오지 않았습니다)', '≒ 田中さんはパーティーに出ませんでした\nAの代わりにBが行く=Aは行かない+Bが行く', '유의 표현', 1313, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中さんのかわりに私がパーティーに出ました。', '다나카 씨 대신에 제가 파티에 나갔습니다.', 1),
    (w, '田中さんはパーティーに出ませんでした。', '다나카 씨는 파티에 나오지 않았습니다.', 2);

  -- 1314. 田中さんは留守です ≒ 田中さんは出かけています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '田中さんは留守です', 'たなかさんはるすです', '다나카 씨는 부재중입니다 ≒ 田中さんは出かけています(다나카 씨는 외출해 있습니다)', '≒ 田中さんは出かけています\n留守(るす, 부재중)=出かけている(외출 중)', '유의 표현', 1314, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中さんは留守です。', '다나카 씨는 부재중입니다.', 1),
    (w, '田中さんは出かけています。', '다나카 씨는 외출해 있습니다.', 2);

  -- 1315. 田中さんを訪ねました ≒ 田中さんの家に行きました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '田中さんを訪ねました', 'たなかさんをたずねました', '다나카 씨를 방문했습니다 ≒ 田中さんの家に行きました(다나카 씨 집에 갔습니다)', '≒ 田中さんの家に行きました\n訪ねる(찾아뵙다)=その人の家に行く(그 사람의 집에 가다)', '유의 표현', 1315, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中さんをたずねました。', '다나카 씨를 방문했습니다.', 1),
    (w, '田中さんの家に行きました。', '다나카 씨 집에 갔습니다.', 2);

  -- 1316. チェックしてください ≒ 調べてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'チェックしてください', 'チェックしてください', '체크해 주세요 ≒ 調べてください(확인해 주세요)', '≒ 調べてください\nチェック(check, 외래어)=調べる(고유 일본어 동사)', '유의 표현', 1316, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう一度チェックしてください。', '한 번 더 체크해 주세요.', 1),
    (w, 'もう一度しらべてください。', '한 번 더 확인해 주세요.', 2);

  -- 1317. 手が汚れています ≒ 手が汚いです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '手が汚れています', 'てがよごれています', '손이 더러워져 있습니다 ≒ 手が汚いです(손이 지저분합니다)', '≒ 手が汚いです\n汚れている(자동사 결과 상태)=汚い(い형용사 상태)', '유의 표현', 1317, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手がよごれています。', '손이 더러워져 있습니다.', 1),
    (w, '手がきたないです。', '손이 지저분합니다.', 2);

  -- 1318. 電車の中は混んでいます ≒ 電車の中には人がたくさんいます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '電車の中は混んでいます', 'でんしゃのなかはこんでいます', '전철 안은 붐빕니다 ≒ 電車の中には人がたくさんいます(전철 안에는 사람이 많이 있습니다)', '≒ 電車の中には人がたくさんいます\n混む(붐비다)=人がたくさんいる(사람이 많다)', '유의 표현', 1318, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝の電車の中はこんでいます。', '아침 전철 안은 붐빕니다.', 1),
    (w, '電車の中には人がたくさんいます。', '전철 안에는 사람이 많이 있습니다.', 2);

  -- 1319. 動物をいじめてはいけません ≒ 動物を大切にしてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '動物をいじめてはいけません', 'どうぶつをいじめてはいけません', '동물을 괴롭혀서는 안 됩니다 ≒ 動物を大切にしてください(동물을 소중히 해 주세요)', '≒ 動物を大切にしてください\nいじめてはいけない(괴롭히면 안 됨)=大切にすべき(소중히 해야 함) - 반대 측면의 같은 의도', '유의 표현', 1319, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '動物をいじめてはいけません。', '동물을 괴롭혀서는 안 됩니다.', 1),
    (w, '動物をたいせつにしてください。', '동물을 소중히 해 주세요.', 2);

  -- 1320. 乗り物が大好きです ≒ 飛行機や船が大好きです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '乗り物が大好きです', 'のりものがだいすきです', '탈것을 아주 좋아합니다 ≒ 飛行機や船が大好きです(비행기나 배를 아주 좋아합니다)', '≒ 飛行機や船が大好きです\n乗り物(상위 개념)=飛行機・船(구체적 예) - 일반↔구체 페어', '유의 표현', 1320, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '乗り物がだいすきです。', '탈것을 아주 좋아합니다.', 1),
    (w, '飛行機やふねがだいすきです。', '비행기나 배를 아주 좋아합니다.', 2);

  -- 1321. 日が暮れました ≒ 空が暗くなりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '日が暮れました', 'ひがくれました', '해가 졌습니다 ≒ 空が暗くなりました(하늘이 어두워졌습니다)', '≒ 空が暗くなりました\n日が暮れる(해가 지다)=空が暗くなる(하늘이 어두워지다)', '유의 표현', 1321, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日がくれました。', '해가 졌습니다.', 1),
    (w, '空がくらくなりました。', '하늘이 어두워졌습니다.', 2);

  -- 1322. ひさしぶりに田中さんに会いました ≒ 長い間田中さんに会っていませんでした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'ひさしぶりに田中さんに会いました', 'ひさしぶりにたなかさんにあいました', '오랜만에 다나카 씨를 만났습니다 ≒ 長い間田中さんに会っていませんでした(오랫동안 다나카 씨를 만나지 않았습니다)', '≒ 長い間田中さんに会っていませんでした\nひさしぶりに会う=長い間会っていない 끝에 만남', '유의 표현', 1322, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひさしぶりに田中さんに会いました。', '오랜만에 다나카 씨를 만났습니다.', 1),
    (w, '長いあいだ田中さんに会っていませんでした。', '오랫동안 다나카 씨를 만나지 않았습니다.', 2);

  -- 1323. びっくりしました ≒ 驚きました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'びっくりしました', 'びっくりしました', '깜짝 놀랐습니다 ≒ 驚きました(놀랐습니다)', '≒ 驚きました\nびっくりする(의성어 기원, 놀라다)=驚く(한자어 기원, 놀라다)', '유의 표현', 1323, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ニュースを聞いてびっくりしました。', '뉴스를 듣고 깜짝 놀랐습니다.', 1),
    (w, 'とてもおどろきました。', '매우 놀랐습니다.', 2);

  -- 1324. 病院に行きました ≒ 薬を取りに行きました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '病院に行きました', 'びょういんにいきました', '병원에 갔습니다 ≒ 薬を取りに行きました(약을 받으러 갔습니다)', '≒ 薬を取りに行きました\n병원에 가는 목적 중 하나=약을 받기 위함', '유의 표현', 1324, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日病院に行きました。', '어제 병원에 갔습니다.', 1),
    (w, '薬を取りに行きました。', '약을 받으러 갔습니다.', 2);

  -- 1325. まずこの仕事をしてください ≒ はじめにこの仕事をしてください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'まずこの仕事をしてください', 'まずこのしごとをしてください', '우선 이 일을 해 주세요 ≒ はじめにこの仕事をしてください(먼저 이 일을 해 주세요)', '≒ はじめにこの仕事をしてください\nまず(우선)=はじめに(먼저) - 순서 표현', '유의 표현', 1325, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まずこの仕事をしてください。', '우선 이 일을 해 주세요.', 1),
    (w, 'はじめにこの仕事をしてください。', '먼저 이 일을 해 주세요.', 2);

  -- 1326. 間違えやすい ≒ 間違える人が多い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '間違えやすい', 'まちがえやすい', '틀리기 쉽다 ≒ 間違える人が多い(틀리는 사람이 많다)', '≒ 間違える人が多い\n~やすい(쉬움)=その行為をする人が多い(그 행위를 하는 사람이 많음)', '유의 표현', 1326, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この漢字はまちがえやすい。', '이 한자는 틀리기 쉽다.', 1),
    (w, 'まちがえる人が多い。', '틀리는 사람이 많다.', 2);

  -- 1327. 娘の入学式がありました ≒ 娘が大学生になりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '娘の入学式がありました', 'むすめのにゅうがくしきがありました', '딸의 입학식이 있었습니다 ≒ 娘が大学生になりました(딸이 대학생이 되었습니다)', '≒ 娘が大学生になりました\n대학 입학식=대학생이 되는 시점', '유의 표현', 1327, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '娘のにゅうがくしきがありました。', '딸의 입학식이 있었습니다.', 1),
    (w, '娘が大学生になりました。', '딸이 대학생이 되었습니다.', 2);

  -- 1328. やせましたね ≒ 細くなりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, 'やせましたね', 'やせましたね', '살이 빠졌네요 ≒ 細くなりました(야위었네요)', '≒ 細くなりました\nやせる(살이 빠지다)=細くなる(가늘어지다)', '유의 표현', 1328, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やせましたね。', '살이 빠졌네요.', 1),
    (w, 'ほそくなりました。', '야위었네요.', 2);

  -- 1329. 山本さんの字は細かいです ≒ 山本さんの字は小さいです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '山本さんの字は細かいです', 'やまもとさんのじはこまかいです', '야마모토 씨의 글씨는 자잘합니다 ≒ 山本さんの字は小さいです(야마모토 씨의 글씨는 작습니다)', '≒ 山本さんの字は小さいです\n細かい(자잘함)=小さい(작음) - 글씨의 크기 표현', '유의 표현', 1329, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山本さんの字はこまかいです。', '야마모토 씨의 글씨는 자잘합니다.', 1),
    (w, '山本さんの字はちいさいです。', '야마모토 씨의 글씨는 작습니다.', 2);

  -- 1330. 留学の経験があります ≒ 留学をしたことがあります
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '留学の経験があります', 'りゅうがくのけいけんがあります', '유학 경험이 있습니다 ≒ 留学をしたことがあります(유학을 한 적이 있습니다)', '≒ 留学をしたことがあります\n~の経験がある(~의 경험이 있다)=~したことがある(~한 적이 있다)', '유의 표현', 1330, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りゅうがくの経験があります。', '유학 경험이 있습니다.', 1),
    (w, 'りゅうがくをしたことがあります。', '유학을 한 적이 있습니다.', 2);

  -- 1331. 私は課長の代わりに会議に行きました ≒ 課長は行きませんでした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '私は課長の代わりに会議に行きました', 'わたしはかちょうのかわりにかいぎにいきました', '나는 과장 대신에 회의에 갔습니다 ≒ 課長は行きませんでした(과장은 가지 않았습니다)', '≒ 課長は行きませんでした\n~の代わりに私が=本人(その人)は行かなかった', '유의 표현', 1331, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は課長のかわりに会議に行きました。', '저는 과장 대신에 회의에 갔습니다.', 1),
    (w, '課長は行きませんでした。', '과장은 가지 않았습니다.', 2);

  -- 1332. 1番の部屋、または2番の部屋 ≒ 1番の部屋か2番の部屋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '1番の部屋、または2番の部屋', 'いちばんのへや、またはにばんのへや', '1번 방 또는 2번 방 ≒ 1番の部屋か2番の部屋(1번 방이나 2번 방)', '≒ 1番の部屋か2番の部屋\nまたは(또는, 격식체)=~か~(~이나, 구어체) - 선택 표현', '유의 표현', 1332, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '1番の部屋、または2番の部屋を使ってください。', '1번 방 또는 2번 방을 사용해 주세요.', 1),
    (w, '1番の部屋か2番の部屋を選んでください。', '1번 방이나 2번 방을 선택해 주세요.', 2);

  -- 1333. 来るのは無理です ≒ 来られません
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '来るのは無理です', 'くるのはむりです', '오는 것은 무리입니다 ≒ 来られません(올 수 없습니다)', '≒ 来られません\n無理(불가능)=可能形의 부정(~られない) - 가능 불능 표현', '유의 표현', 1333, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来るのはむりです。', '오는 것은 무리입니다.', 1),
    (w, '来られません。', '올 수 없습니다.', 2);

  -- 1334. 時間に間に合いませんでした ≒ 時間に遅れました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n4, '時間に間に合いませんでした', 'じかんにまにあいませんでした', '시간에 맞추지 못했습니다 ≒ 時間に遅れました(시간에 늦었습니다)', '≒ 時間に遅れました\n間に合わない(맞추지 못함)=遅れる(늦다)', '유의 표현', 1334, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間にまにあいませんでした。', '시간에 맞추지 못했습니다.', 1),
    (w, '時間におくれました。', '시간에 늦었습니다.', 2);

end $$;
