-- ============================================================
-- JLPT N2 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N2-단어장)
-- ============================================================
-- 실행 시 기존 N2 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 1494단어 (PDF 어휘 906 + 「파이널 문법 체크북」 588 (형식판단 327 + 문장완성 141 + 문맥이해 120))
-- ============================================================

delete from public.words
where deck_id in (
  select id from public.decks
  where is_official and jlpt_level = 'N2'
);

do $$
declare
  d_n2 uuid;
  w   uuid;
begin
  select id into d_n2
  from public.decks
  where is_official and jlpt_level = 'N2'
  limit 1;

  -- 1. 相互
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '相互', 'そうご', '상호, 서로', '相(서로 상): 두 그루의 나무(木)가 마주 봄 / 互(서로 호): 새끼줄을 엇갈리게 짠 모양', '명사', 1, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両国は相互に協力する関係にある。', '양국은 상호 협력하는 관계에 있다.', 1),
    (w, '相互理解を深めることが大切だ。', '상호 이해를 깊이 하는 것이 중요하다.', 2);

  -- 2. 規模
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '規模', 'きぼ', '규모', '規(법 규): 컴퍼스로 그린 둥근 법칙 / 模(본뜰 모): 나무(木)로 만든 본보기', '명사', 2, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この工場は世界最大の規模を誇る。', '이 공장은 세계 최대의 규모를 자랑한다.', 1),
    (w, '事業の規模を拡大する計画だ。', '사업의 규모를 확대할 계획이다.', 2);

  -- 3. 辛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '辛い', 'からい', '맵다', '辛(매울 신): 죄인의 얼굴에 새기던 형벌 도구의 모양 → 매서움, 매움', 'い형용사', 3, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このカレーはとても辛い。', '이 카레는 매우 맵다.', 1),
    (w, '辛い料理が苦手だ。', '매운 요리를 잘 못 먹는다.', 2);

  -- 4. 触れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '触れる', 'ふれる', '닿다, 언급하다', '触(닿을 촉): 뿔(角) 달린 벌레가 무언가에 부딪히는 모양', '동사', 4, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の心の傷に触れてしまった。', '그의 마음의 상처를 건드리고 말았다.', 1),
    (w, '政治的な話題には触れない方がいい。', '정치적인 화제에는 언급하지 않는 게 좋다.', 2);

  -- 5. 景色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '景色', 'けしき', '경치', '景(볕 경): 햇빛(日)이 높이(京) 비치는 모양 / 色(빛 색): 사람의 얼굴빛에서 비롯된 글자', '명사', 5, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山頂からの景色が素晴らしかった。', '산 정상에서 본 경치가 훌륭했다.', 1),
    (w, '紅葉の景色を写真に収めた。', '단풍 경치를 사진에 담았다.', 2);

  -- 6. 尊重する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '尊重する', 'そんちょうする', '존중하다', '尊(높을 존): 술 단지(酋)를 손(寸)으로 받드는 모양 / 重(무거울 중): 사람이 짐을 진 모양', '동사', 6, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '相手の意見を尊重するべきだ。', '상대의 의견을 존중해야 한다.', 1),
    (w, '個人の自由を尊重する社会を目指す。', '개인의 자유를 존중하는 사회를 지향한다.', 2);

  -- 7. 備える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '備える', 'そなえる', '대비하다', '備(갖출 비): 화살통(用)에 화살을 갖추어 두는 모양', '동사', 7, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地震に備えて非常食を用意した。', '지진에 대비해 비상식량을 준비했다.', 1),
    (w, '老後に備えて貯金している。', '노후에 대비해 저축하고 있다.', 2);

  -- 8. 治療
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '治療', 'ちりょう', '치료', '治(다스릴 치): 물(氵)을 다스려 흐름을 바로잡음 / 療(병 고칠 료): 병(疒)을 횃불(尞)로 비추어 고침', '명사', 8, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '病院でけがの治療を受けた。', '병원에서 부상 치료를 받았다.', 1),
    (w, '早期の治療が回復への近道だ。', '조기 치료가 회복으로 가는 지름길이다.', 2);

  -- 9. 防災
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '防災', 'ぼうさい', '방재', '防(막을 방): 둑(阝)으로 물을 막아내는 모양 / 災(재앙 재): 불(火)과 물(巛)이 일으키는 재앙', '명사', 9, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎年九月に防災訓練を行う。', '매년 9월에 방재 훈련을 실시한다.', 1),
    (w, '防災グッズを家庭に常備しておく。', '방재용품을 가정에 늘 비치해 둔다.', 2);

  -- 10. 隣
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '隣', 'となり', '옆, 이웃', '隣(이웃 린): 마을(阝)이 도깨비불처럼 점점이 이어진 모양 → 가까이 있음', '명사', 10, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '隣の人にあいさつをした。', '옆 사람에게 인사를 했다.', 1),
    (w, '私の家の隣にカフェがある。', '우리 집 옆에 카페가 있다.', 2);

  -- 11. 敗れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '敗れる', 'やぶれる', '패배하다', '敗(패할 패): 조개(貝)를 두드려(攵) 깨뜨리는 모양 → 무너지다', '동사', 11, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決勝戦で強豪チームに敗れた。', '결승전에서 강호 팀에게 패배했다.', 1),
    (w, '接戦の末、惜しくも敗れた。', '접전 끝에 아쉽게 패배했다.', 2);

  -- 12. 地元
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '地元', 'じもと', '고장, 현지', '地(땅 지): 흙(土)이 펼쳐진 곳 / 元(으뜸 원): 사람의 머리, 근원을 뜻함', '명사', 12, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は地元のサッカーチームを応援している。', '그는 고향의 축구팀을 응원하고 있다.', 1),
    (w, '地元の食材を使った料理を出す店だ。', '현지 식재료를 사용한 요리를 내는 가게다.', 2);

  -- 13. 要求
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '要求', 'ようきゅう', '요구', '要(요긴할 요): 여인의 허리 모양에서 핵심을 뜻함 / 求(구할 구): 짐승 가죽을 구하는 모양', '명사', 13, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '労働者は賃上げを要求した。', '노동자들은 임금 인상을 요구했다.', 1),
    (w, '顧客の要求に応えるべく努力する。', '고객의 요구에 부응하고자 노력한다.', 2);

  -- 14. 密接な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '密接な', 'みっせつな', '밀접한', '密(빽빽할 밀): 산(山) 속에 빽빽이 우거진 모양 / 接(이을 접): 손(扌)으로 무언가를 잇는 모양', 'な형용사', 14, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済と政治は密接な関係にある。', '경제와 정치는 밀접한 관계에 있다.', 1),
    (w, '睡眠と健康には密接な関連がある。', '수면과 건강에는 밀접한 관련이 있다.', 2);

  -- 15. 祝う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '祝う', 'いわう', '축하하다', '祝(빌 축): 제단(示) 앞에서 사람(兄)이 비는 모양', '동사', 15, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人の結婚を心から祝った。', '친구의 결혼을 진심으로 축하했다.', 1),
    (w, '家族で誕生日を祝う予定だ。', '가족이 함께 생일을 축하할 예정이다.', 2);

  -- 16. 豊富な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '豊富な', 'ほうふな', '풍부한', '豊(풍성할 풍): 제기에 곡식이 풍성하게 담긴 모양 / 富(부유할 부): 집(宀)에 가득 찬 재물', 'な형용사', 16, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経験豊富な医師に診てもらった。', '경험이 풍부한 의사에게 진료받았다.', 1),
    (w, '資源が豊富な国は経済的に有利だ。', '자원이 풍부한 나라는 경제적으로 유리하다.', 2);

  -- 17. 調節
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '調節', 'ちょうせつ', '조절', '調(고를 조): 말(言)을 두루(周) 맞추다 / 節(마디 절): 대나무(竹)의 마디가 균형을 잡음', '명사', 17, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'エアコンの温度を調節した。', '에어컨 온도를 조절했다.', 1),
    (w, '生活リズムを調節するのが難しい。', '생활 리듬을 조절하기가 어렵다.', 2);

  -- 18. 補う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '補う', 'おぎなう', '보완하다, 보충하다', '補(기울 보): 옷(衤)의 떨어진 곳을 채워 깁는 모양', '동사', 18, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '睡眠不足を昼寝で補った。', '수면 부족을 낮잠으로 보충했다.', 1),
    (w, '彼女の弱点を仲間が補ってくれる。', '그녀의 약점을 동료들이 보완해 준다.', 2);

  -- 19. 至急
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '至急', 'しきゅう', '지급, 매우 급함', '至(이를 지): 화살(矢)이 땅에 닿은 모양 → 도달함 / 急(급할 급): 마음(心)이 다급한 모양', '명사', 19, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '至急の連絡が入った。', '매우 급한 연락이 들어왔다.', 1),
    (w, '至急、書類を提出してください。', '지급으로 서류를 제출해 주세요.', 2);

  -- 20. 率直な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '率直な', 'そっちょくな', '솔직한', '率(거느릴 솔): 그물로 무리를 끌어모음 / 直(곧을 직): 눈(目)이 똑바로 바라봄', 'な형용사', 20, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は率直な人柄で信頼されている。', '그는 솔직한 성격으로 신뢰받고 있다.', 1),
    (w, '率直な意見を聞かせてほしい。', '솔직한 의견을 들려주었으면 한다.', 2);

  -- 21. 装置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '装置', 'そうち', '장치', '装(꾸밀 장): 옷(衣)을 단단히(壮) 차려입음 / 置(둘 치): 그물(网)에 잡힌 것을 곧게 둠', '명사', 21, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最新の通信装置が導入された。', '최신 통신 장치가 도입되었다.', 1),
    (w, '安全装置が正しく作動した。', '안전 장치가 정상적으로 작동했다.', 2);

  -- 22. 抽象的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '抽象的な', 'ちゅうしょうてきな', '추상적인', '抽(뽑을 추): 손(扌)으로 빼냄 / 象(코끼리 상): 코끼리 모양 → 형상 / 的: ~한', 'な형용사', 22, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '抽象的な議論ばかりで結論が出ない。', '추상적인 논의만 하다가 결론이 나지 않는다.', 1),
    (w, '彼の絵は抽象的で解釈が難しい。', '그의 그림은 추상적이라 해석이 어렵다.', 2);

  -- 23. 占める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '占める', 'しめる', '차지하다, 점유하다', '占(점칠 점): 거북등을 보고(口) 점을 침 → 자리를 정함', '동사', 23, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '女性社員が全体の半数を占める。', '여성 직원이 전체의 절반을 차지한다.', 1),
    (w, '会議室の席を早めに占めた。', '회의실 자리를 일찍 차지했다.', 2);

  -- 24. 返却
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '返却', 'へんきゃく', '반납', '返(돌이킬 반): 길(辶)을 돌아옴(反) / 却(물리칠 각): 발걸음(去)을 멈추고 무릎을 꿇음', '명사', 24, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館に本を返却した。', '도서관에 책을 반납했다.', 1),
    (w, '借りた傘の返却を忘れていた。', '빌린 우산을 반납하는 걸 잊고 있었다.', 2);

  -- 25. 削除
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '削除', 'さくじょ', '삭제', '削(깎을 삭): 칼(刂)로 깎아냄 / 除(덜 제): 언덕(阝)을 덜어내는 모양', '명사', 25, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不要なファイルを削除した。', '불필요한 파일을 삭제했다.', 1),
    (w, '名簿から名前を削除してください。', '명단에서 이름을 삭제해 주세요.', 2);

  -- 26. 針
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '針', 'はり', '바늘', '針(바늘 침): 쇠(金)로 만든 가늘고 곧은 도구', '명사', 26, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時計の針が三時を指している。', '시곗바늘이 3시를 가리키고 있다.', 1),
    (w, '針に糸を通すのに苦労した。', '바늘에 실을 꿰는 데 고생했다.', 2);

  -- 27. 焦点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '焦点', 'しょうてん', '초점', '焦(탈 초): 새(隹)가 불(灬)에 그을림 → 한곳에 집중 / 点(점 점): 작은 점', '명사', 27, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の焦点がぼやけてしまった。', '이야기의 초점이 흐려져 버렸다.', 1),
    (w, '問題の焦点はコストにある。', '문제의 초점은 비용에 있다.', 2);

  -- 28. 撮影
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '撮影', 'さつえい', '촬영', '撮(찍을 촬): 손(扌)으로 가장 좋은 순간(最)을 잡음 / 影(그림자 영): 햇빛이 만든 형상', '명사', 28, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画の撮影が始まった。', '영화 촬영이 시작되었다.', 1),
    (w, 'ここでの撮影は禁止されている。', '이곳에서의 촬영은 금지되어 있다.', 2);

  -- 29. 略する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '略する', 'りゃくする', '생략하다, 줄이다', '略(간략할 략): 밭(田)을 다스려 핵심만 남김', '동사', 29, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あいさつを略して本題に入った。', '인사말을 생략하고 본론으로 들어갔다.', 1),
    (w, '国名を略して呼ぶことが多い。', '나라 이름을 줄여서 부르는 경우가 많다.', 2);

  -- 30. 破片
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '破片', 'はへん', '파편', '破(깨뜨릴 파): 돌(石)이 가죽(皮)처럼 갈라짐 / 片(조각 편): 나무를 쪼개 한쪽만 남긴 모양', '명사', 30, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '割れたガラスの破片に注意して。', '깨진 유리 파편을 조심해.', 1),
    (w, '花瓶の破片を片付けた。', '꽃병의 파편을 치웠다.', 2);

  -- 31. 世の中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '世の中', 'よのなか', '세상', '世(인간 세): 30년 단위 세대 / 中(가운데 중): 깃대를 가운데 꽂은 모양', '명사', 31, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世の中はそんなに甘くない。', '세상은 그렇게 만만치 않다.', 1),
    (w, '世の中の動きに敏感な人だ。', '세상의 흐름에 민감한 사람이다.', 2);

  -- 32. 清潔な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '清潔な', 'せいけつな', '청결한', '清(맑을 청): 푸른(青) 물(氵)처럼 깨끗함 / 潔(깨끗할 결): 물로 매듭(絜)을 풀어 깨끗하게 함', 'な형용사', 32, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '清潔なタオルを用意した。', '깨끗한 수건을 준비했다.', 1),
    (w, 'キッチンを清潔に保つことが大切だ。', '부엌을 청결하게 유지하는 것이 중요하다.', 2);

  -- 33. 勧誘
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勧誘', 'かんゆう', '권유', '勧(권할 권): 황새(雚)처럼 적극 권함 / 誘(꾈 유): 말(言)로 부드럽게(秀) 이끔', '명사', 33, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達からテニスサークルに勧誘された。', '친구로부터 테니스 동아리에 권유를 받았다.', 1),
    (w, '強引な勧誘は迷惑だ。', '강요하는 권유는 민폐다.', 2);

  -- 34. 隠す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '隠す', 'かくす', '숨기다', '隠(숨길 은): 언덕(阝) 뒤에 마음(心)을 감추는 모양', '동사', 34, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は本心を隠しているようだ。', '그는 본심을 숨기고 있는 듯하다.', 1),
    (w, 'プレゼントを引き出しに隠した。', '선물을 서랍에 숨겼다.', 2);

  -- 35. 改めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '改めて', 'あらためて', '다시', '改(고칠 개): 자기(己)를 매로 두드려(攵) 새롭게 함', '부사', 35, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '改めて自分の生き方を考えた。', '다시금 내 삶의 방식을 생각해 보았다.', 1),
    (w, '改めてご連絡いたします。', '다시 한번 연락드리겠습니다.', 2);

  -- 36. 姿勢
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '姿勢', 'しせい', '자세', '姿(모양 자): 다음(次)에 보이는 여자(女)의 모습 / 勢(형세 세): 묘목을 심어 자라는 힘', '명사', 36, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '正しい姿勢で椅子に座る。', '바른 자세로 의자에 앉는다.', 1),
    (w, '問題に取り組む姿勢が評価された。', '문제에 임하는 자세를 평가받았다.', 2);

  -- 37. 拡充
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '拡充', 'かくじゅう', '확충', '拡(넓힐 확): 손(扌)으로 넓게(広) 펼침 / 充(채울 충): 사람이 가득 차오름', '명사', 37, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '福祉サービスの拡充が求められている。', '복지 서비스 확충이 요구되고 있다.', 1),
    (w, '設備を拡充して生産能力を上げる。', '설비를 확충해 생산 능력을 높이다.', 2);

  -- 38. 積む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '積む', 'つむ', '쌓다', '積(쌓을 적): 벼(禾)를 모아 쌓음', '동사', 38, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経験を積んで成長する。', '경험을 쌓아 성장한다.', 1),
    (w, '倉庫に荷物を高く積んだ。', '창고에 짐을 높이 쌓았다.', 2);

  -- 39. 模範
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '模範', 'もはん', '모범', '模(본뜰 모): 나무(木)로 만든 본 / 範(법 범): 수레(車)를 본보기로 삼음', '명사', 39, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は社員の模範となる存在だ。', '그는 직원들의 모범이 되는 존재다.', 1),
    (w, '先輩として模範を示す必要がある。', '선배로서 모범을 보일 필요가 있다.', 2);

  -- 40. 逃亡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '逃亡', 'とうぼう', '도망', '逃(달아날 도): 길(辶)을 따라 빠져나감 / 亡(망할 망): 사람이 사라짐', '명사', 40, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犯人は海外へ逃亡した。', '범인은 해외로 도망갔다.', 1),
    (w, '彼は責任から逃亡しようとした。', '그는 책임에서 도망가려고 했다.', 2);

  -- 41. 大幅に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '大幅に', 'おおはばに', '대폭적으로', '大(클 대): 사람이 팔다리를 벌린 모양 / 幅(폭 폭): 천(巾)의 너비', '부사', 41, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格が大幅に下がった。', '가격이 대폭 내려갔다.', 1),
    (w, '計画を大幅に修正した。', '계획을 대폭 수정했다.', 2);

  -- 42. 極端な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '極端な', 'きょくたんな', '극단적인', '極(다할 극): 끝까지 다다른 모양 / 端(끝 단): 풀(立)의 끝부분', 'な형용사', 42, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の意見は極端な場合が多い。', '그의 의견은 극단적인 경우가 많다.', 1),
    (w, '極端なダイエットは健康を害する。', '극단적인 다이어트는 건강을 해친다.', 2);

  -- 43. 悔しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '悔しい', 'くやしい', '억울하다', '悔(뉘우칠 회): 마음(忄)에 매양(每) 후회가 남음', 'い형용사', 43, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合で負けて悔しい思いをした。', '시합에 져서 억울한 마음이 들었다.', 1),
    (w, 'あと一歩のところで失敗して悔しい。', '한 발짝 차이로 실패해서 분하다.', 2);

  -- 44. 戻す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '戻す', 'もどす', '되돌리다', '戻(돌아올 려): 문(戶) 안으로 큰(大) 것을 되돌리는 모양', '동사', 44, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を元の場所に戻した。', '책을 원래 자리로 되돌렸다.', 1),
    (w, '時計を一時間戻した。', '시계를 한 시간 되돌렸다.', 2);

  -- 45. 幼稚な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '幼稚な', 'ようちな', '유치한', '幼(어릴 유): 작은(幺) 힘(力) / 稚(어릴 치): 어린(隹) 벼(禾)', 'な형용사', 45, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の発言は幼稚に感じた。', '그의 발언은 유치하게 느껴졌다.', 1),
    (w, '幼稚な争いはやめよう。', '유치한 다툼은 그만두자.', 2);

  -- 46. 継続
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '継続', 'けいぞく', '계속', '継(이을 계): 실(糸)을 끊임없이 이음 / 続(이을 속): 실을 팔다(売) → 끊지 않음', '명사', 46, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日の運動を継続することが大切だ。', '매일의 운동을 지속하는 것이 중요하다.', 1),
    (w, 'プロジェクトは継続して進められる。', '프로젝트는 계속해서 진행된다.', 2);

  -- 47. 圧勝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '圧勝', 'あっしょう', '압승', '圧(누를 압): 흙(土)으로 강하게 누름 / 勝(이길 승): 힘(力)으로 이김', '명사', 47, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は選挙で圧勝した。', '그는 선거에서 압승했다.', 1),
    (w, '試合は10対0の圧勝に終わった。', '시합은 10대 0의 압승으로 끝났다.', 2);

  -- 48. 除く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '除く', 'のぞく', '제외하다, 제거하다', '除(덜 제): 언덕(阝)을 덜어내는 모양 → 제거함', '동사', 48, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日曜日を除いて毎日働く。', '일요일을 제외하고 매일 일한다.', 1),
    (w, '庭の雑草を除いた。', '정원의 잡초를 제거했다.', 2);

  -- 49. 傷む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '傷む', 'いたむ', '상하다, 손상되다', '傷(다칠 상): 사람(亻)이 화살(矢)에 다친 모양', '동사', 49, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏は食べ物が傷みやすい。', '여름에는 음식이 잘 상한다.', 1),
    (w, '靴が傷んできたので買い替える。', '신발이 망가져서 새로 산다.', 2);

  -- 50. 貿易
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '貿易', 'ぼうえき', '무역', '貿(바꿀 무): 재물(貝)을 바꾸어 거래 / 易(바꿀 역): 도마뱀이 색을 바꾸듯 변하는 거래', '명사', 50, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本は中国と貿易を行っている。', '일본은 중국과 무역을 하고 있다.', 1),
    (w, '貿易摩擦が両国の関係を悪化させた。', '무역 마찰이 양국 관계를 악화시켰다.', 2);

  -- 51. 省略
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '省略', 'しょうりゃく', '생략', '省(살필 성/덜 생): 작게(少) 살핌 / 略(간략할 략): 핵심만 남김', '명사', 51, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '形式的な手続きを省略した。', '형식적인 절차를 생략했다.', 1),
    (w, '時間がないので説明を省略します。', '시간이 없으니 설명을 생략하겠습니다.', 2);

  -- 52. 拒否
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '拒否', 'きょひ', '거부', '拒(막을 거): 손(扌)으로 큰 것을 막음 / 否(아닐 부): 입(口)으로 부정함', '명사', 52, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は提案を拒否した。', '그는 제안을 거부했다.', 1),
    (w, '支払いを拒否されてしまった。', '지불을 거부당하고 말았다.', 2);

  -- 53. 含める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '含める', 'ふくめる', '포함시키다', '含(머금을 함): 입(口)에 무언가를 머금음', '동사', 53, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '税金を含めた金額を表示する。', '세금을 포함한 금액을 표시한다.', 1),
    (w, '子供も含めて全員参加する。', '아이들도 포함해 전원이 참가한다.', 2);

  -- 54. 囲む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '囲む', 'かこむ', '둘러싸다, 에워싸다', '囲(에워쌀 위): 사방(囗)을 둘러싸 가둠', '동사', 54, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族でテーブルを囲んで食事した。', '가족이 식탁을 둘러싸고 식사했다.', 1),
    (w, '警察が建物を囲んだ。', '경찰이 건물을 에워쌌다.', 2);

  -- 55. 油断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '油断', 'ゆだん', '방심', '油(기름 유): 물(氵)처럼 흐르는 기름 / 断(끊을 단): 도끼(斤)로 자르듯 단호함이 끊김', '명사', 55, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最後まで油断してはいけない。', '끝까지 방심해서는 안 된다.', 1),
    (w, '一瞬の油断が大事故を招いた。', '순간의 방심이 큰 사고를 초래했다.', 2);

  -- 56. 損害
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '損害', 'そんがい', '손해', '損(덜 손): 손(扌)으로 줄임 / 害(해할 해): 집(宀) 안의 사물을 망침', '명사', 56, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風で大きな損害を受けた。', '태풍으로 큰 손해를 입었다.', 1),
    (w, '損害賠償を請求する。', '손해 배상을 청구한다.', 2);

  -- 57. 行事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '行事', 'ぎょうじ', '행사', '行(다닐 행): 네거리 모양 / 事(일 사): 깃대를 손에 든 모양 → 일', '명사', 57, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎年恒例の行事に参加した。', '매년 정례 행사에 참가했다.', 1),
    (w, '学校の行事で忙しい一週間だった。', '학교 행사로 바쁜 일주일이었다.', 2);

  -- 58. 現象
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '現象', 'げんしょう', '현상', '現(나타날 현): 옥(王)이 보이게 됨 / 象(코끼리 상): 형상', '명사', 58, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不思議な自然現象が観察された。', '불가사의한 자연 현상이 관찰되었다.', 1),
    (w, '都市部での人口集中は世界的な現象だ。', '도시부 인구 집중은 세계적인 현상이다.', 2);

  -- 59. 詳しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '詳しい', 'くわしい', '자세하다, 상세하다', '詳(자세할 상): 말(言)이 양(羊)처럼 부드럽고 자세함', 'い형용사', 59, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故の詳しい状況を教えてください。', '사고의 상세한 상황을 알려 주세요.', 1),
    (w, '彼は日本史に詳しい。', '그는 일본사에 정통하다.', 2);

  -- 60. 憎い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '憎い', 'にくい', '밉다', '憎(미울 증): 마음(忄)에 더해진(曾) 부정적 감정', 'い형용사', 60, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '裏切った相手が憎い。', '배신한 상대가 밉다.', 1),
    (w, '犯人が憎くてたまらない。', '범인이 미워서 견딜 수 없다.', 2);

  -- 61. 貴重な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '貴重な', 'きちょうな', '귀중한', '貴(귀할 귀): 귀한 재물(貝)을 두 손으로 받듦 / 重(무거울 중): 무겁고 소중함', 'な형용사', 61, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貴重な経験を積むことができた。', '귀중한 경험을 쌓을 수 있었다.', 1),
    (w, '貴重な時間を割いて協力してくれた。', '귀중한 시간을 내어 협력해 주었다.', 2);

  -- 62. 競う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '競う', 'きそう', '겨루다, 경쟁하다', '競(다툴 경): 두 사람이 나란히 서서 다투는 모양', '동사', 62, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選手たちは技を競い合った。', '선수들은 기술을 겨루었다.', 1),
    (w, '兄弟で成績を競っている。', '형제끼리 성적을 다투고 있다.', 2);

  -- 63. 怪しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '怪しい', 'あやしい', '수상하다', '怪(괴이할 괴): 흙(土)에서 나온 손(又) → 마음(忄)에 의심', 'い형용사', 63, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '怪しい男が家の前にいた。', '수상한 남자가 집 앞에 있었다.', 1),
    (w, '彼の話には怪しい点が多い。', '그의 이야기에는 수상한 점이 많다.', 2);

  -- 64. 批評
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '批評', 'ひひょう', '비평', '批(비평할 비): 손(扌)으로 비교(比)함 / 評(평할 평): 말(言)로 평평하게 평가', '명사', 64, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画の批評を新聞で読んだ。', '영화 비평을 신문에서 읽었다.', 1),
    (w, '厳しい批評にも耳を傾ける。', '엄한 비평에도 귀를 기울인다.', 2);

  -- 65. 容姿
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '容姿', 'ようし', '용모, 외모', '容(얼굴 용): 집(宀) 안에 담긴 모습 / 姿(모양 자): 사람의 모습', '명사', 65, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '容姿よりも内面を大切にしたい。', '용모보다 내면을 소중히 하고 싶다.', 1),
    (w, '彼女は整った容姿で人気がある。', '그녀는 단정한 용모로 인기가 있다.', 2);

  -- 66. 納める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '納める', 'おさめる', '납입하다, 납부하다', '納(들일 납): 안으로(內) 실(糸)을 들여놓음', '동사', 66, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎月家賃を納めている。', '매달 집세를 납부하고 있다.', 1),
    (w, '税金を期日までに納めた。', '세금을 기일 내에 납부했다.', 2);

  -- 67. 伴う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '伴う', 'ともなう', '따르다, 동반하다', '伴(짝 반): 사람(亻)이 반(半) 둘로 나뉘어 짝을 이룸', '동사', 67, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きな責任が伴う仕事だ。', '큰 책임이 따르는 일이다.', 1),
    (w, '彼女を伴って会場に向かった。', '그녀를 동반하고 회장으로 향했다.', 2);

  -- 68. 劣る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '劣る', 'おとる', '뒤떨어지다, 열등하다', '劣(못할 렬): 적은(少) 힘(力) → 열등함', '동사', 68, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '性能が他社の製品より劣る。', '성능이 타사 제품보다 떨어진다.', 1),
    (w, '経験では彼に劣らない。', '경험에서는 그에게 뒤지지 않는다.', 2);

  -- 69. 願望
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '願望', 'がんぼう', '소망, 바람', '願(원할 원): 머리(頁)에 늘 품고 있는 바람 / 望(바랄 망): 멀리(亡) 달(月)을 바라봄', '명사', 69, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '海外で働きたいという願望がある。', '해외에서 일하고 싶다는 소망이 있다.', 1),
    (w, '彼の願望はマイホームを持つことだ。', '그의 바람은 자기 집을 갖는 것이다.', 2);

  -- 70. 幼い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '幼い', 'おさない', '어리다', '幼(어릴 유): 작은(幺) 힘(力)', 'い형용사', 70, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幼い子供を持つ親は大変だ。', '어린 아이를 가진 부모는 힘들다.', 1),
    (w, '幼い頃の思い出が蘇った。', '어릴 적 추억이 되살아났다.', 2);

  -- 71. 握る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '握る', 'にぎる', '쥐다', '握(쥘 악): 손(扌)으로 단단히(屋) 잡음', '동사', 71, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しっかりと手を握り合った。', '꼭 손을 맞잡았다.', 1),
    (w, '成功の鍵は彼が握っている。', '성공의 열쇠는 그가 쥐고 있다.', 2);

  -- 72. 密閉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '密閉', 'みっぺい', '밀폐', '密(빽빽할 밀): 빈틈없이 / 閉(닫을 폐): 문(門)을 닫음', '명사', 72, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食材を密閉容器に入れて保存した。', '식재료를 밀폐 용기에 넣어 보관했다.', 1),
    (w, '部屋を密閉して殺虫剤をまいた。', '방을 밀폐하고 살충제를 뿌렸다.', 2);

  -- 73. 絞る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '絞る', 'しぼる', '짜다, 범위를 좁히다', '絞(목맬 교): 실(糸)을 교차(交)하여 단단히 짜냄', '동사', 73, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タオルを絞ってから干した。', '수건을 짜고 나서 널었다.', 1),
    (w, '候補者を三人に絞った。', '후보자를 세 명으로 좁혔다.', 2);

  -- 74. 垂直
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '垂直', 'すいちょく', '수직', '垂(드리울 수): 풀이 아래로 늘어진 모양 / 直(곧을 직): 똑바름', '명사', 74, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '柱を地面に垂直に立てた。', '기둥을 지면에 수직으로 세웠다.', 1),
    (w, 'ビルの壁は垂直になっている。', '빌딩 벽은 수직으로 되어 있다.', 2);

  -- 75. 乱れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乱れる', 'みだれる', '흐트러지다, 어지러워지다', '乱(어지러울 란): 실이 엉킨 모양', '동사', 75, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強風で髪が乱れた。', '강풍으로 머리가 흐트러졌다.', 1),
    (w, '生活リズムが乱れて体調を崩した。', '생활 리듬이 흐트러져 건강이 나빠졌다.', 2);

  -- 76. 柔軟な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '柔軟な', 'じゅうなんな', '유연한', '柔(부드러울 유): 창(矛) 같은 강한 것이 부드러워짐 / 軟(연할 연): 수레(車)가 부드럽게(欠) 움직임', 'な형용사', 76, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '柔軟な発想が新しい企画を生んだ。', '유연한 발상이 새 기획을 낳았다.', 1),
    (w, '柔軟に対応する姿勢が大事だ。', '유연하게 대응하는 자세가 중요하다.', 2);

  -- 77. 強火
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '強火', 'つよび', '센 불', '強(강할 강): 활(弓)이 강함 / 火(불 화): 불꽃 모양', '명사', 77, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強火で一気に焼き上げる。', '센 불에 단번에 구워 낸다.', 1),
    (w, '強火だと焦げやすいので注意。', '센 불이면 잘 타니 주의.', 2);

  -- 78. 抱える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '抱える', 'かかえる', '안다, 껴안다', '抱(안을 포): 손(扌)으로 감싸 안음(包)', '동사', 78, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たくさんの問題を抱えている。', '많은 문제를 떠안고 있다.', 1),
    (w, '大きな荷物を両手で抱えた。', '큰 짐을 양손으로 껴안았다.', 2);

  -- 79. 求人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '求人', 'きゅうじん', '구인', '求(구할 구): 짐승 가죽을 구함 / 人(사람 인): 사람을 구함', '명사', 79, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新聞の求人広告を見て応募した。', '신문의 구인 광고를 보고 응모했다.', 1),
    (w, '経験者の求人が増えている。', '경력자 구인이 늘고 있다.', 2);

  -- 80. 怖い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '怖い', 'こわい', '무섭다', '怖(두려워할 포): 마음(忄)이 베(布)처럼 떨림', 'い형용사', 80, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜道を一人で歩くのは怖い。', '밤길을 혼자 걷는 것은 무섭다.', 1),
    (w, '怖い夢を見て目が覚めた。', '무서운 꿈을 꿔서 잠에서 깼다.', 2);

  -- 81. 冷蔵庫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '冷蔵庫', 'れいぞうこ', '냉장고', '冷(찰 랭): 얼음(冫)처럼 차가움 / 蔵(감출 장): 풀(艹) 속에 감춤 / 庫(곳집 고): 차고', '명사', 81, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冷蔵庫から牛乳を取り出した。', '냉장고에서 우유를 꺼냈다.', 1),
    (w, '冷蔵庫の中はいつも整理しておく。', '냉장고 안은 늘 정리해 둔다.', 2);

  -- 82. 総額
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '総額', 'そうがく', '총액', '総(거느릴 총): 실(糸)을 모아 총괄 / 額(이마 액): 액수', '명사', 82, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行費用の総額は十万円だった。', '여행 경비 총액은 10만 엔이었다.', 1),
    (w, 'プロジェクトの総額を見直した。', '프로젝트의 총액을 재검토했다.', 2);

  -- 83. 湿る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '湿る', 'しめる', '습기 차다, 축축하다', '湿(젖을 습): 물(氵)에 풀이 젖은 모양', '동사', 83, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梅雨で布団が湿ってしまった。', '장마로 이불이 축축해져 버렸다.', 1),
    (w, '地面が湿っているので滑りやすい。', '지면이 축축해서 미끄럽다.', 2);

  -- 84. 抽選
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '抽選', 'ちゅうせん', '추첨', '抽(뽑을 추): 손(扌)으로 뽑음 / 選(가릴 선): 길에서 사람을 골라냄', '명사', 84, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンサートのチケットは抽選だ。', '콘서트 티켓은 추첨제다.', 1),
    (w, '抽選で旅行券が当たった。', '추첨으로 여행권에 당첨되었다.', 2);

  -- 85. 離れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '離れる', 'はなれる', '떨어지다, 거리가 멀어지다', '離(떠날 리): 새가 그물을 떠나는 모양', '동사', 85, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女から離れたくない。', '그녀에게서 떨어지고 싶지 않다.', 1),
    (w, '実家から離れて暮らしている。', '본가에서 떨어져 살고 있다.', 2);

  -- 86. 企画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '企画', 'きかく', '기획', '企(꾀할 기): 사람이 발돋움(止)을 함 / 画(그림 화): 밭에 경계선을 그음', '명사', 86, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新商品の企画を提案した。', '신상품 기획을 제안했다.', 1),
    (w, 'イベントの企画段階に入った。', '이벤트의 기획 단계에 들어갔다.', 2);

  -- 87. 再度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '再度', 'さいど', '두 번, 재차', '再(두 재): 다시 / 度(법도 도): 횟수', '부사', 87, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '再度確認のためお電話しました。', '재확인을 위해 전화드렸습니다.', 1),
    (w, '再度同じ質問をされた。', '재차 같은 질문을 받았다.', 2);

  -- 88. 和やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '和やかな', 'なごやかな', '부드럽다, 온화하다', '和(화할 화): 벼(禾)와 입(口)이 어우러짐 → 평온함', 'な형용사', 88, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '和やかな雰囲気で会議が進んだ。', '부드러운 분위기로 회의가 진행되었다.', 1),
    (w, '和やかな笑顔で迎えてくれた。', '온화한 미소로 맞이해 주었다.', 2);

  -- 89. 処理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '処理', 'しょり', '처리', '処(곳 처/처리할 처): 자리를 정함 / 理(다스릴 리): 옥(王)을 다스림', '명사', 89, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書類の処理に時間がかかった。', '서류 처리에 시간이 걸렸다.', 1),
    (w, '問題を迅速に処理する。', '문제를 신속하게 처리한다.', 2);

  -- 90. 憎む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '憎む', 'にくむ', '미워하다', '憎(미울 증): 마음(忄)에 부정 감정이 더해짐', '동사', 90, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人を憎むことは自分を傷つける。', '사람을 미워하는 것은 자신을 다치게 한다.', 1),
    (w, '彼は裏切り者を心から憎んだ。', '그는 배신자를 진심으로 미워했다.', 2);

  -- 91. 偶然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '偶然', 'ぐうぜん', '우연히', '偶(짝 우): 사람(亻)과 인형(禺)이 만남 / 然(그러할 연): 그러함', '부사', 91, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅で偶然友達に会った。', '역에서 우연히 친구를 만났다.', 1),
    (w, '偶然の出会いから恋が始まった。', '우연한 만남에서 사랑이 시작되었다.', 2);

  -- 92. 刺激
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '刺激', 'しげき', '자극', '刺(찌를 자): 가시로 찌름 / 激(부딪칠 격): 물(氵)이 부딪쳐 격해짐', '명사', 92, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい仕事から刺激を受けた。', '새로운 일에서 자극을 받았다.', 1),
    (w, '辛い食べ物は胃に刺激が強い。', '매운 음식은 위에 자극이 강하다.', 2);

  -- 93. 恥
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '恥', 'はじ', '부끄러움, 창피', '恥(부끄러울 치): 귀(耳)와 마음(心) → 부끄러움에 귀가 빨개짐', '명사', 93, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人前で転んで恥をかいた。', '사람들 앞에서 넘어져서 창피를 당했다.', 1),
    (w, '失敗しても恥と思わないでほしい。', '실패해도 부끄럽게 여기지 말았으면 한다.', 2);

  -- 94. 圧倒的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '圧倒的', 'あっとうてき', '압도적', '圧(누를 압): 강하게 누름 / 倒(넘어질 도): 사람을 넘어뜨림 / 的: ~한', '명사', 94, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の歌唱力は圧倒的だ。', '그의 가창력은 압도적이다.', 1),
    (w, '圧倒的な差で優勝した。', '압도적인 차이로 우승했다.', 2);

  -- 95. 等しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '等しい', 'ひとしい', '같다, 다름없다', '等(가지런할 등): 대나무(竹) 마디가 가지런함', 'い형용사', 95, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二つの三角形は面積が等しい。', '두 삼각형은 면적이 같다.', 1),
    (w, '彼の意見は私と等しい。', '그의 의견은 나와 같다.', 2);

  -- 96. 軽傷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '軽傷', 'けいしょう', '경상, 가벼운 부상', '軽(가벼울 경): 수레(車)가 가벼움 / 傷(다칠 상): 다친 모양', '명사', 96, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故では幸い軽傷で済んだ。', '사고에서는 다행히 경상으로 그쳤다.', 1),
    (w, '軽傷だが念のため病院に行く。', '경상이지만 만일을 위해 병원에 간다.', 2);

  -- 97. 負担
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '負担', 'ふたん', '부담', '負(질 부): 등에 짐을 짐 / 担(멜 담): 어깨에 멤', '명사', 97, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '治療費の負担が大きい。', '치료비 부담이 크다.', 1),
    (w, '経済的な負担を軽減したい。', '경제적 부담을 줄이고 싶다.', 2);

  -- 98. 映る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '映る', 'うつる', '비치다, 영상으로 나타나다', '映(비칠 영): 햇빛(日)이 가운데(央) 비침', '동사', 98, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '湖に山が映っている。', '호수에 산이 비치고 있다.', 1),
    (w, '画面に映像が映らない。', '화면에 영상이 나타나지 않는다.', 2);

  -- 99. 下旬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '下旬', 'げじゅん', '하순', '下(아래 하): 아래쪽 / 旬(열흘 순): 열흘 단위', '명사', 99, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '十月下旬に旅行を予定している。', '10월 하순에 여행을 예정하고 있다.', 1),
    (w, '下旬になると気温が下がる。', '하순이 되면 기온이 내려간다.', 2);

  -- 100. 倒す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '倒す', 'たおす', '쓰러뜨리다', '倒(넘어질 도): 사람(亻)이 거꾸로(到) 넘어짐', '동사', 100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強敵を見事に倒した。', '강적을 멋지게 쓰러뜨렸다.', 1),
    (w, '木を倒して薪にした。', '나무를 쓰러뜨려 장작으로 했다.', 2);

  -- 101. 険しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '険しい', 'けわしい', '험하다', '険(험할 험): 언덕(阝)이 모두(僉) 가파른 모양', 'い형용사', 101, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '険しい山道を歩くのは大変だ。', '험한 산길을 걷는 것은 힘들다.', 1),
    (w, '彼の表情は険しくなった。', '그의 표정은 험해졌다.', 2);

  -- 102. 比較的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '比較的', 'ひかくてき', '비교적', '比(견줄 비): 두 사람을 나란히 비교 / 較(견줄 교): 수레(車)를 견줌 / 的: ~한', '부사', 102, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は比較的暖かい。', '오늘은 비교적 따뜻하다.', 1),
    (w, 'この問題は比較的簡単だ。', '이 문제는 비교적 간단하다.', 2);

  -- 103. 下降
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '下降', 'かこう', '하강', '下(아래 하): 아래 / 降(내릴 강): 언덕(阝)에서 발이 내려옴', '명사', 103, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飛行機が下降を始めた。', '비행기가 하강을 시작했다.', 1),
    (w, '気温が急激に下降した。', '기온이 급격히 하강했다.', 2);

  -- 104. 著しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '著しい', 'いちじるしい', '현저하다, 두드러지다', '著(나타날 저): 풀(艹)을 모아 글로 드러냄', 'い형용사', 104, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近、彼の成長が著しい。', '최근 그의 성장이 두드러진다.', 1),
    (w, '医学の進歩は著しい。', '의학의 발전은 현저하다.', 2);

  -- 105. 声援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '声援', 'せいえん', '성원', '声(소리 성): 소리 / 援(도울 원): 손(扌)으로 끌어 도움', '명사', 105, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '観客の声援が選手を励ました。', '관객의 성원이 선수를 격려했다.', 1),
    (w, '大きな声援に応えて頑張った。', '큰 성원에 부응해 힘냈다.', 2);

  -- 106. 傾く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '傾く', 'かたむく', '기울다', '傾(기울 경): 사람이 비스듬히(頃) 서 있는 모양', '동사', 106, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夕日で長い影が西に傾いた。', '석양에 긴 그림자가 서쪽으로 기울었다.', 1),
    (w, '会社の経営が傾き始めた。', '회사 경영이 기울기 시작했다.', 2);

  -- 107. 情景
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '情景', 'じょうけい', '정경', '情(뜻 정): 마음(忄)의 푸른(青) 빛 → 감정 / 景(볕 경): 풍경', '명사', 107, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の頃の情景が思い出される。', '어린 시절의 정경이 떠오른다.', 1),
    (w, '別れの情景が今も心に残っている。', '이별의 정경이 지금도 마음에 남아 있다.', 2);

  -- 108. 乏しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乏しい', 'とぼしい', '부족하다', '乏(모자랄 핍): 발(止)이 거꾸로 → 모자람', 'い형용사', 108, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は経験に乏しい新人だ。', '그는 경험이 부족한 신입이다.', 1),
    (w, '資金が乏しくて事業が進まない。', '자금이 부족해 사업이 진행되지 않는다.', 2);

  -- 109. 介護
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '介護', 'かいご', '개호, 간병', '介(낄 개): 사람 사이에 끼어 도움 / 護(지킬 호): 새(隹)를 손(又)으로 지킴', '명사', 109, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高齢の母を介護している。', '연로한 어머니를 간병하고 있다.', 1),
    (w, '介護の仕事は体力が必要だ。', '간병 일은 체력이 필요하다.', 2);

  -- 110. 焦る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '焦る', 'あせる', '초조해하다, 안달하다', '焦(탈 초): 새(隹)가 불(灬)에 그을려 다급함', '동사', 110, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間がなくて焦ってしまった。', '시간이 없어서 초조해졌다.', 1),
    (w, '焦らずゆっくり進めよう。', '조급해하지 말고 천천히 진행하자.', 2);

  -- 111. 賛否
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '賛否', 'さんび', '찬부, 찬반', '賛(도울 찬): 두 손으로 도움 / 否(아닐 부): 입으로 부정', '명사', 111, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '議案に賛否両論がある。', '의안에 찬반양론이 있다.', 1),
    (w, '参加者の賛否を確認した。', '참가자의 찬반을 확인했다.', 2);

  -- 112. 記憶
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '記憶', 'きおく', '기억', '記(기록할 기): 말(言)을 자기(己) 안에 새김 / 憶(생각할 억): 마음(忄)에 둠', '명사', 112, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幼い頃の記憶がよみがえる。', '어린 시절의 기억이 되살아난다.', 1),
    (w, '彼は記憶力がとてもいい。', '그는 기억력이 매우 좋다.', 2);

  -- 113. 偉い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '偉い', 'えらい', '훌륭하다', '偉(클 위): 사람(亻)이 길게 둘러서서(韋) 우뚝함', 'い형용사', 113, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は偉い研究者として知られている。', '아버지는 훌륭한 연구자로 알려져 있다.', 1),
    (w, 'そんなに頑張って偉いね。', '그렇게 노력하다니 대단하구나.', 2);

  -- 114. 途端に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '途端に', 'とたんに', '갑자기', '途(길 도): 길 / 端(끝 단): 끝 / 〜한 끝의 순간', '부사', 114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアを開けた途端に犬が飛び出した。', '문을 연 순간 개가 뛰쳐나왔다.', 1),
    (w, '雨が降った途端に観光客が減った。', '비가 오자마자 관광객이 줄었다.', 2);

  -- 115. 務める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '務める', 'つとめる', '(임무를) 맡다, 노력하다', '務(힘쓸 무): 창(矛)을 들고 힘써 일함', '동사', 115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は議長を務めることになった。', '그는 의장을 맡게 되었다.', 1),
    (w, '司会を務めるのは初めてだ。', '사회를 맡는 것은 처음이다.', 2);

  -- 116. 素材
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '素材', 'そざい', '소재', '素(본디 소): 가공하지 않은 흰 실 / 材(재목 재): 나무 재료', '명사', 116, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高品質な素材を使った服だ。', '고급 소재를 사용한 옷이다.', 1),
    (w, '料理は素材選びが命だ。', '요리는 재료 고르기가 생명이다.', 2);

  -- 117. 警備
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '警備', 'けいび', '경비', '警(경계할 경): 말(言)로 경계함 / 備(갖출 비): 대비함', '명사', 117, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大統領の警備は厳重だ。', '대통령의 경비는 삼엄하다.', 1),
    (w, '夜間も警備員が巡回している。', '야간에도 경비원이 순찰한다.', 2);

  -- 118. 外れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '外れる', 'はずれる', '빠지다, 빗나가다', '外(바깥 외): 바깥 / 〜에서 떨어져 나옴', '동사', 118, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予想が外れて残念だ。', '예상이 빗나가서 아쉽다.', 1),
    (w, 'ボタンが外れているよ。', '단추가 풀어져 있어.', 2);

  -- 119. 世間
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '世間', 'せけん', '세간, 세상', '世(인간 세): 인간 사회 / 間(사이 간): 그 사이', '명사', 119, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世間の評判を気にする。', '세간의 평판을 신경 쓴다.', 1),
    (w, '彼は世間知らずだと言われた。', '그는 세상 물정을 모른다는 말을 들었다.', 2);

  -- 120. 勇ましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勇ましい', 'いさましい', '용감하다, 활발하다', '勇(날쌜 용): 힘(力)이 솟아오름', 'い형용사', 120, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勇ましい兵士たちが行進した。', '용감한 병사들이 행진했다.', 1),
    (w, '勇ましい音楽が流れている。', '활발한 음악이 흐르고 있다.', 2);

  -- 121. 運賃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '運賃', 'うんちん', '운임', '運(옮길 운): 짐을 옮김 / 賃(품삯 임): 노동의 대가', '명사', 121, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車の運賃が値上げされる。', '전철 운임이 인상된다.', 1),
    (w, 'タクシーの運賃が高くなった。', '택시 요금이 비싸졌다.', 2);

  -- 122. 握手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '握手', 'あくしゅ', '악수', '握(쥘 악): 손을 잡음 / 手(손 수): 손', '명사', 122, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合後、選手たちは握手を交わした。', '시합 후 선수들은 악수를 나눴다.', 1),
    (w, '初対面で固く握手をした。', '첫 만남에 굳게 악수를 나눴다.', 2);

  -- 123. 腕
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '腕', 'うで', '팔', '腕(팔 완): 사람 몸(月)의 굽이(宛)', '명사', 123, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は腕の力が強い。', '그는 팔 힘이 세다.', 1),
    (w, '料理の腕を上げたい。', '요리 솜씨를 늘리고 싶다.', 2);

  -- 124. 善良な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '善良な', 'ぜんりょうな', '선량한', '善(착할 선): 양(羊)의 입(口)에서 나오는 좋은 말 / 良(어질 량): 좋음', 'な형용사', 124, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は善良な性格の持ち主だ。', '그는 선량한 성격의 소유자다.', 1),
    (w, '善良な市民を守るのが警察の役目だ。', '선량한 시민을 지키는 것이 경찰의 임무다.', 2);

  -- 125. 平等
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '平等', 'びょうどう', '평등', '平(평평할 평): 평평함 / 等(가지런할 등): 가지런함', '명사', 125, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '男女平等の社会を目指す。', '남녀평등 사회를 지향한다.', 1),
    (w, '全員に平等にチャンスを与えたい。', '전원에게 평등하게 기회를 주고 싶다.', 2);

  -- 126. 詳細
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '詳細', 'しょうさい', '상세', '詳(자세할 상): 자세함 / 細(가늘 세): 가늘게 나눔', '명사', 126, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳細は後ほどお知らせします。', '상세 내용은 추후 알려 드리겠습니다.', 1),
    (w, '計画の詳細を確認した。', '계획의 상세 내용을 확인했다.', 2);

  -- 127. 分析
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '分析', 'ぶんせき', '분석', '分(나눌 분): 나눔 / 析(쪼갤 석): 도끼(斤)로 나무를 쪼갬', '명사', 127, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'データを詳しく分析する。', '데이터를 상세히 분석한다.', 1),
    (w, '原因を分析した結果が出た。', '원인을 분석한 결과가 나왔다.', 2);

  -- 128. 絡まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '絡まる', 'からまる', '얽히다', '絡(이을 락): 실(糸)이 얽혀 흐름(各)을 이룸', '동사', 128, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '糸が絡まってほどけない。', '실이 얽혀 풀리지 않는다.', 1),
    (w, '複雑な事情が絡まっている。', '복잡한 사정이 얽혀 있다.', 2);

  -- 129. 農薬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '農薬', 'のうやく', '농약', '農(농사 농): 밭일 / 薬(약 약): 풀(艹)로 만든 약', '명사', 129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '農薬を使わずに野菜を育てる。', '농약을 쓰지 않고 채소를 기른다.', 1),
    (w, '農薬の残留が問題視されている。', '농약 잔류가 문제시되고 있다.', 2);

  -- 130. 鮮やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '鮮やかな', 'あざやかな', '선명한', '鮮(고울 선): 생선(魚)과 양(羊)이 신선함', 'な형용사', 130, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鮮やかな赤色のドレスを着た。', '선명한 빨간색 드레스를 입었다.', 1),
    (w, '鮮やかな技で観客を魅了した。', '선명한 기술로 관객을 매료시켰다.', 2);

  -- 131. 優秀な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '優秀な', 'ゆうしゅうな', '우수한', '優(뛰어날 우): 사람이 뛰어남 / 秀(빼어날 수): 벼(禾)가 잘 자람', 'な형용사', 131, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '優秀な人材を集めたい。', '우수한 인재를 모으고 싶다.', 1),
    (w, '彼女は優秀な成績で卒業した。', '그녀는 우수한 성적으로 졸업했다.', 2);

  -- 132. 迷う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '迷う', 'まよう', '헤매다, 망설이다', '迷(미혹할 미): 길(辶)에서 헤맴(米)', '동사', 132, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道に迷って遅刻してしまった。', '길을 헤매다 지각하고 말았다.', 1),
    (w, '進路選択で迷っている。', '진로 선택으로 망설이고 있다.', 2);

  -- 133. 背骨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '背骨', 'せぼね', '등뼈, 척추', '背(등 배): 등 / 骨(뼈 골): 뼈', '명사', 133, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '背骨を伸ばして座る。', '등뼈를 펴고 앉는다.', 1),
    (w, '背骨が痛くて病院に行った。', '척추가 아파서 병원에 갔다.', 2);

  -- 134. 実践
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '実践', 'じっせん', '실천', '実(열매 실): 열매를 맺음 / 践(밟을 천): 발로 밟음 → 실행', '명사', 134, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学んだことを実践する。', '배운 것을 실천한다.', 1),
    (w, '計画を実践に移すのが大切だ。', '계획을 실천에 옮기는 것이 중요하다.', 2);

  -- 135. 衣装
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '衣装', 'いしょう', '의상', '衣(옷 의): 옷 / 装(꾸밀 장): 꾸밈', '명사', 135, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '舞台衣装を準備した。', '무대 의상을 준비했다.', 1),
    (w, '民族衣装を着て写真を撮った。', '민족 의상을 입고 사진을 찍었다.', 2);

  -- 136. 礼儀
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '礼儀', 'れいぎ', '예의', '礼(예도 례): 제단 앞의 예 / 儀(거동 의): 사람의 바른 거동', '명사', 136, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はとても礼儀正しい。', '그는 매우 예의 바르다.', 1),
    (w, '日本では礼儀が重んじられる。', '일본에서는 예의가 중시된다.', 2);

  -- 137. 開催
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '開催', 'かいさい', '개최', '開(열 개): 문을 열음 / 催(재촉할 최): 사람을 모아 재촉', '명사', 137, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来月、展示会が開催される。', '다음 달 전시회가 개최된다.', 1),
    (w, 'イベントの開催を発表した。', '이벤트의 개최를 발표했다.', 2);

  -- 138. 出世
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '出世', 'しゅっせ', '출세', '出(날 출): 나옴 / 世(인간 세): 세상에 나섬', '명사', 138, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は若くして出世した。', '그는 젊어서 출세했다.', 1),
    (w, '出世のために努力する。', '출세를 위해 노력한다.', 2);

  -- 139. 頼り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頼り', 'たより', '연고, 의지가 되는 것', '頼(의지할 뢰): 묶어(束) 의지함', '명사', 139, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君だけが頼りだ。', '너만이 의지가 된다.', 1),
    (w, '地図を頼りに歩いた。', '지도를 의지해 걸었다.', 2);

  -- 140. 伝統
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '伝統', 'でんとう', '전통', '伝(전할 전): 사람이 전함 / 統(거느릴 통): 실로 통합', '명사', 140, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の伝統文化を学ぶ。', '일본의 전통문화를 배운다.', 1),
    (w, '伝統を守り続けることが大切だ。', '전통을 지속해서 지키는 것이 중요하다.', 2);

  -- 141. 暮らす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '暮らす', 'くらす', '살다', '暮(저물 모): 해(日)가 풀(艹) 사이로 저묾 → 하루를 보냄', '동사', 141, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田舎で静かに暮らしたい。', '시골에서 조용히 살고 싶다.', 1),
    (w, '家族で楽しく暮らしている。', '가족과 즐겁게 살고 있다.', 2);

  -- 142. 象徴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '象徴', 'しょうちょう', '상징', '象(코끼리 상): 형상 / 徴(부를 징): 표시', '명사', 142, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鳩は平和の象徴だ。', '비둘기는 평화의 상징이다.', 1),
    (w, '桜は日本の象徴と言われる。', '벚꽃은 일본의 상징이라 불린다.', 2);

  -- 143. 与える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '与える', 'あたえる', '주다', '与(줄 여): 두 손으로 건네줌', '동사', 143, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供にお小遣いを与える。', '아이에게 용돈을 준다.', 1),
    (w, '彼の言葉が私に勇気を与えた。', '그의 말이 내게 용기를 주었다.', 2);

  -- 144. 激しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '激しい', 'はげしい', '심하다', '激(부딪칠 격): 물(氵)이 부딪쳐 격해짐', 'い형용사', 144, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨夜は激しい雨が降った。', '어젯밤은 심한 비가 내렸다.', 1),
    (w, '彼の性格は激しい一面がある。', '그의 성격은 격한 면이 있다.', 2);

  -- 145. 管理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '管理', 'かんり', '관리', '管(대롱 관): 대롱처럼 통제 / 理(다스릴 리): 다스림', '명사', 145, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロジェクトを管理する。', '프로젝트를 관리한다.', 1),
    (w, '時間管理が成功の鍵だ。', '시간 관리가 성공의 열쇠다.', 2);

  -- 146. 登録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '登録', 'とうろく', '등록', '登(오를 등): 단에 오름 / 録(기록할 록): 기록함', '명사', 146, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会員登録を済ませた。', '회원 등록을 마쳤다.', 1),
    (w, '車の登録手続きをした。', '차 등록 수속을 했다.', 2);

  -- 147. 福祉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '福祉', 'ふくし', '복지', '福(복 복): 복 / 祉(복 지): 복', '명사', 147, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '福祉施設でボランティアをする。', '복지 시설에서 자원봉사를 한다.', 1),
    (w, '高齢者福祉の充実が求められる。', '고령자 복지의 충실이 요구된다.', 2);

  -- 148. 誘う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '誘う', 'さそう', '권유하다, 유도하다', '誘(꾈 유): 말(言)로 부드럽게 이끔', '동사', 148, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人を映画に誘った。', '친구를 영화에 권했다.', 1),
    (w, '良い香りに誘われて店に入った。', '좋은 향기에 이끌려 가게에 들어갔다.', 2);

  -- 149. 討論
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '討論', 'とうろん', '토론', '討(칠 토): 말(言)로 따져 침 / 論(논할 론): 논함', '명사', 149, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '活発な討論が行われた。', '활발한 토론이 이루어졌다.', 1),
    (w, '学生たちが熱く討論した。', '학생들이 열띤 토론을 했다.', 2);

  -- 150. 変更
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '変更', 'へんこう', '변경', '変(변할 변): 변함 / 更(고칠 경): 고침', '명사', 150, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予定が変更になりました。', '예정이 변경되었습니다.', 1),
    (w, '契約内容を変更したい。', '계약 내용을 변경하고 싶다.', 2);

  -- 151. 属する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '属する', 'ぞくする', '속하다', '属(무리 속): 꼬리(尾)처럼 매여 무리에 속함', '동사', 151, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私はサッカー部に属している。', '나는 축구부에 속해 있다.', 1),
    (w, '彼は研究グループに属する。', '그는 연구 그룹에 속한다.', 2);

  -- 152. 導く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '導く', 'みちびく', '이끌다, 지도하다', '導(인도할 도): 길(辶)을 머리(首)로 인도함', '동사', 152, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生は生徒を正しい方向に導いた。', '선생님은 학생을 올바른 방향으로 이끌었다.', 1),
    (w, '彼の判断がチームを勝利に導いた。', '그의 판단이 팀을 승리로 이끌었다.', 2);

  -- 153. 訪れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '訪れる', 'おとずれる', '방문하다', '訪(찾을 방): 말(言)로 사방(方)을 찾음', '동사', 153, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生のお宅を訪れた。', '선생님 댁을 방문했다.', 1),
    (w, '春が静かに訪れた。', '봄이 조용히 찾아왔다.', 2);

  -- 154. 扱う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '扱う', 'あつかう', '다루다, 취급하다', '扱(다룰 급): 손(扌)으로 다룸', '동사', 154, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危険物を扱う仕事だ。', '위험물을 다루는 일이다.', 1),
    (w, 'お客様を丁寧に扱うべきだ。', '손님을 정중히 대해야 한다.', 2);

  -- 155. 収穫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '収穫', 'しゅうかく', '수확', '収(거둘 수): 거둠 / 穫(거둘 확): 곡식을 베어 거둠', '명사', 155, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '秋には米の収穫が始まる。', '가을에는 쌀 수확이 시작된다.', 1),
    (w, '会議では大きな収穫があった。', '회의에서는 큰 수확이 있었다.', 2);

  -- 156. 積極的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '積極的な', 'せっきょくてきな', '적극적인', '積(쌓을 적): 쌓음 / 極(다할 극): 끝까지 / 的: ~한', 'な형용사', 156, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '積極的に意見を述べた。', '적극적으로 의견을 말했다.', 1),
    (w, '積極的な姿勢が好印象を与えた。', '적극적인 자세가 좋은 인상을 주었다.', 2);

  -- 157. 勢い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勢い', 'いきおい', '기세', '勢(형세 세): 자라는 힘', '명사', 157, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若者は勢いがあって頼もしい。', '젊은이들은 기세가 있어 든든하다.', 1),
    (w, '話の勢いに流されてしまった。', '이야기의 기세에 휩쓸려 버렸다.', 2);

  -- 158. 抵抗
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '抵抗', 'ていこう', '저항', '抵(거스를 저): 손으로 저지함 / 抗(겨룰 항): 손으로 막음', '명사', 158, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軍は激しい抵抗を受けた。', '군은 격렬한 저항을 받았다.', 1),
    (w, '新しい技術への抵抗感がある。', '신기술에 대한 저항감이 있다.', 2);

  -- 159. 組織
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '組織', 'そしき', '조직', '組(짤 조): 실로 짜 모음 / 織(짤 직): 실로 짠 직물', '명사', 159, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の組織を改編した。', '회사 조직을 개편했다.', 1),
    (w, '犯罪組織が摘発された。', '범죄 조직이 적발되었다.', 2);

  -- 160. 肩
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '肩', 'かた', '어깨', '肩(어깨 견): 사람 몸(月)에 문(戶)처럼 붙은 부위', '명사', 160, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肩が凝って痛い。', '어깨가 결려 아프다.', 1),
    (w, '彼の肩を軽く叩いた。', '그의 어깨를 가볍게 두드렸다.', 2);

  -- 161. 至るところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '至るところ', 'いたるところ', '도처, 모든 장소', '至(이를 지): 도달함 / 〜한 곳', '부사', 161, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '桜が至るところに咲いている。', '벚꽃이 도처에 피어 있다.', 1),
    (w, '至るところで彼を見かけた。', '모든 장소에서 그를 보았다.', 2);

  -- 162. 削る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '削る', 'けずる', '깎다, 삭감하다', '削(깎을 삭): 칼로 깎음', '동사', 162, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鉛筆をナイフで削った。', '연필을 칼로 깎았다.', 1),
    (w, '経費を削る必要がある。', '경비를 삭감할 필요가 있다.', 2);

  -- 163. 真剣な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '真剣な', 'しんけんな', '진지한', '真(참 진): 진실 / 剣(칼 검): 칼 → 진검 승부의 진지함', 'な형용사', 163, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真剣な表情で話を聞いた。', '진지한 표정으로 이야기를 들었다.', 1),
    (w, '真剣に将来を考えている。', '진지하게 장래를 생각하고 있다.', 2);

  -- 164. 講義
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '講義', 'こうぎ', '강의', '講(외울 강): 말로 풀어 가르침 / 義(옳을 의): 옳은 도리', '명사', 164, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学で歴史の講義を受けた。', '대학에서 역사 강의를 들었다.', 1),
    (w, '教授の講義はとても面白い。', '교수의 강의는 매우 재미있다.', 2);

  -- 165. 努める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '努める', 'つとめる', '노력하다', '努(힘쓸 노): 종(奴)이 힘(力)써 일함', '동사', 165, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お客様の満足に努める。', '고객 만족에 노력한다.', 1),
    (w, '早期解決に努めたい。', '조기 해결에 힘쓰고 싶다.', 2);

  -- 166. 寄付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '寄付', 'きふ', '기부', '寄(부칠 기): 맡겨 보냄 / 付(부칠 부): 줌', '명사', 166, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '災害支援に寄付した。', '재해 지원에 기부했다.', 1),
    (w, '寄付金で学校が建てられた。', '기부금으로 학교가 세워졌다.', 2);

  -- 167. 果たす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '果たす', 'はたす', '완수하다', '果(열매 과): 열매를 맺어 끝맺음', '동사', 167, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束をきちんと果たした。', '약속을 제대로 이행했다.', 1),
    (w, '責任を果たすことが大切だ。', '책임을 다하는 것이 중요하다.', 2);

  -- 168. 即座に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '即座に', 'そくざに', '즉석에서, 그 자리에서', '即(곧 즉): 곧바로 / 座(자리 좌): 자리', '부사', 168, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に即座に答えた。', '질문에 즉석에서 답했다.', 1),
    (w, '即座に判断を下した。', '즉석에서 판단을 내렸다.', 2);

  -- 169. 招待
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '招待', 'しょうたい', '초대', '招(부를 초): 손짓으로 부름 / 待(기다릴 대): 기다림', '명사', 169, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚式に招待された。', '결혼식에 초대받았다.', 1),
    (w, '友人をパーティーに招待した。', '친구를 파티에 초대했다.', 2);

  -- 170. 責める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '責める', 'せめる', '책망하다, 나무라다', '責(꾸짖을 책): 가시(朿)로 따지듯 꾸짖음', '동사', 170, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去の失敗を責めても仕方ない。', '과거의 실패를 책망해도 소용없다.', 1),
    (w, '子供をひどく責めるのはよくない。', '아이를 심하게 나무라는 것은 좋지 않다.', 2);

  -- 171. 湿っぽい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '湿っぽい', 'しめっぽい', '눅눅하다, 습기 차다', '湿(젖을 습): 물에 젖음', 'い형용사', 171, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梅雨で部屋が湿っぽい。', '장마로 방이 눅눅하다.', 1),
    (w, '話が湿っぽくなってしまった。', '이야기가 우중충해져 버렸다.', 2);

  -- 172. 接続
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '接続', 'せつぞく', '접속', '接(이을 접): 이음 / 続(이을 속): 이음', '명사', 172, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インターネットに接続できない。', '인터넷에 접속할 수 없다.', 1),
    (w, '新しい接続方法を試した。', '새로운 접속 방법을 시도했다.', 2);

  -- 173. 援助
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '援助', 'えんじょ', '원조', '援(도울 원): 끌어 도움 / 助(도울 조): 도움', '명사', 173, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貧しい国に経済援助をする。', '가난한 나라에 경제 원조를 한다.', 1),
    (w, '彼の援助なしでは成功しなかった。', '그의 원조 없이는 성공하지 못했다.', 2);

  -- 174. 逆らう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '逆らう', 'さからう', '거스르다, 거역하다', '逆(거스를 역): 거꾸로 감', '동사', 174, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親の意見に逆らった。', '부모의 의견에 거역했다.', 1),
    (w, '時代の流れに逆らうのは難しい。', '시대의 흐름에 거스르는 것은 어렵다.', 2);

  -- 175. 破れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '破れる', 'やぶれる', '찢어지다, 파손되다', '破(깨뜨릴 파): 깨짐', '동사', 175, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シャツが破れてしまった。', '셔츠가 찢어지고 말았다.', 1),
    (w, '古い障子が破れている。', '낡은 장지가 찢어져 있다.', 2);

  -- 176. 批判
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '批判', 'ひはん', '비판', '批(비평할 비): 견주어 평함 / 判(판단할 판): 판단', '명사', 176, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政府の政策を批判した。', '정부의 정책을 비판했다.', 1),
    (w, '厳しい批判にさらされた。', '혹독한 비판을 받았다.', 2);

  -- 177. 面倒な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '面倒な', 'めんどうな', '귀찮은, 성가신', '面(낯 면): 얼굴 / 倒(넘어질 도): 넘어짐 → 얼굴을 가리고 싶을 만큼 귀찮음', 'な형용사', 177, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面倒な仕事を任された。', '성가신 일을 맡았다.', 1),
    (w, '面倒な手続きが嫌だ。', '귀찮은 절차가 싫다.', 2);

  -- 178. 拾う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '拾う', 'ひろう', '줍다', '拾(주울 습): 손으로 모음(合)', '동사', 178, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道に落ちている財布を拾った。', '길에 떨어진 지갑을 주웠다.', 1),
    (w, 'タクシーを拾って急いだ。', '택시를 잡아 서둘렀다.', 2);

  -- 179. 距離
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '距離', 'きょり', '거리', '距(상거할 거): 발걸음(足) 사이 / 離(떠날 리): 떨어짐', '명사', 179, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅までの距離は近い。', '역까지의 거리가 가깝다.', 1),
    (w, '彼との距離を感じる。', '그와의 거리를 느낀다.', 2);

  -- 180. 混乱
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '混乱', 'こんらん', '혼란', '混(섞을 혼): 섞임 / 乱(어지러울 란): 어지러움', '명사', 180, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故で交通が混乱した。', '사고로 교통이 혼란해졌다.', 1),
    (w, '情報が錯綜して混乱を招いた。', '정보가 뒤엉켜 혼란을 초래했다.', 2);

  -- 181. 驚く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '驚く', 'おどろく', '놀라다', '驚(놀랄 경): 말(馬)이 놀람', '동사', 181, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の急な訪問に驚いた。', '그의 갑작스러운 방문에 놀랐다.', 1),
    (w, '値段の高さに驚いた。', '가격이 비싼 데 놀랐다.', 2);

  -- 182. 順調な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '順調な', 'じゅんちょうな', '순조로운', '順(순할 순): 거스르지 않음 / 調(고를 조): 잘 어울림', 'な형용사', 182, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事は順調に進んでいる。', '일은 순조롭게 진행되고 있다.', 1),
    (w, '順調な滑り出しを見せた。', '순조로운 출발을 보였다.', 2);

  -- 183. 講師
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '講師', 'こうし', '강사', '講(외울 강): 강의함 / 師(스승 사): 스승', '명사', 183, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学の講師として働いている。', '대학 강사로 일하고 있다.', 1),
    (w, '講師の話はとても分かりやすい。', '강사의 이야기는 매우 알기 쉽다.', 2);

  -- 184. 争う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '争う', 'あらそう', '다투다', '争(다툴 쟁): 두 손이 무언가를 두고 다툼', '동사', 184, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '兄弟でおもちゃを争った。', '형제가 장난감을 두고 다투었다.', 1),
    (w, '彼らは優勝を争うライバルだ。', '그들은 우승을 다투는 라이벌이다.', 2);

  -- 185. 腹
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '腹', 'はら', '배(신체의 일부)', '腹(배 복): 사람 몸의 가운데', '명사', 185, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お腹がすいた。', '배가 고프다.', 1),
    (w, 'お腹を抱えて笑った。', '배를 잡고 웃었다.', 2);

  -- 186. 指摘
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '指摘', 'してき', '지적', '指(가리킬 지): 손가락으로 가리킴 / 摘(딸 적): 손으로 가려냄', '명사', 186, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に間違いを指摘された。', '선생님께 잘못을 지적받았다.', 1),
    (w, '的確な指摘に感心した。', '정확한 지적에 감탄했다.', 2);

  -- 187. 恵まれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '恵まれる', 'めぐまれる', '혜택 받다, 풍부하다', '恵(은혜 혜): 마음(心)에서 베풀어짐', '동사', 187, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は才能に恵まれている。', '그는 재능을 타고났다.', 1),
    (w, '良い天気に恵まれた一日だった。', '좋은 날씨를 누린 하루였다.', 2);

  -- 188. 簡潔な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '簡潔な', 'かんけつな', '간결한', '簡(대쪽 간): 간단 / 潔(깨끗할 결): 깔끔', 'な형용사', 188, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡潔な説明をお願いします。', '간결한 설명을 부탁드립니다.', 1),
    (w, '彼の文章は簡潔で読みやすい。', '그의 문장은 간결하고 읽기 쉽다.', 2);

  -- 189. 招く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '招く', 'まねく', '부르다, 초대하다', '招(부를 초): 손짓으로 부름', '동사', 189, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お客様を家に招いた。', '손님을 집에 초대했다.', 1),
    (w, '不注意な発言が誤解を招いた。', '부주의한 발언이 오해를 초래했다.', 2);

  -- 190. 参照
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '参照', 'さんしょう', '참조', '参(참여할 참): 모임에 끼임 / 照(비칠 조): 비추어 봄', '명사', 190, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳細はマニュアルを参照してください。', '상세는 매뉴얼을 참조해 주세요.', 1),
    (w, '過去のデータを参照する。', '과거 데이터를 참조한다.', 2);

  -- 191. 保証
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '保証', 'ほしょう', '보증', '保(보전할 보): 지킴 / 証(증거 증): 증명', '명사', 191, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '製品には一年の保証が付く。', '제품에는 1년 보증이 따라온다.', 1),
    (w, '成功は保証されていない。', '성공은 보장되어 있지 않다.', 2);

  -- 192. 焦げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '焦げる', 'こげる', '눋다, 타다', '焦(탈 초): 새가 불에 그을음', '동사', 192, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肉が焦げてしまった。', '고기가 타 버렸다.', 1),
    (w, 'うっかりして鍋を焦がした。', '깜빡해서 냄비를 태웠다.', 2);

  -- 193. 催し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '催し', 'もよおし', '행사, 모임', '催(재촉할 최): 사람을 모아 일을 일으킴', '명사', 193, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地域の催しに参加した。', '지역 행사에 참가했다.', 1),
    (w, '夏には花火の催しがある。', '여름에는 불꽃놀이 행사가 있다.', 2);

  -- 194. 症状
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '症状', 'しょうじょう', '증상', '症(증세 증): 병의 증세 / 状(형상 상): 모양', '명사', 194, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風邪の症状が出始めた。', '감기 증상이 나타나기 시작했다.', 1),
    (w, '症状を医師に説明した。', '증상을 의사에게 설명했다.', 2);

  -- 195. 硬貨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '硬貨', 'こうか', '동전, 주화', '硬(굳을 경): 단단함 / 貨(재화 화): 돈', '명사', 195, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布の中の硬貨を数えた。', '지갑 속 동전을 세었다.', 1),
    (w, '新しい硬貨が発行された。', '새 주화가 발행되었다.', 2);

  -- 196. 快く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '快く', 'こころよく', '흔쾌히', '快(쾌할 쾌): 마음(忄)이 시원함', '부사', 196, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は快く引き受けてくれた。', '그는 흔쾌히 맡아 주었다.', 1),
    (w, 'お願いを快く承諾した。', '부탁을 흔쾌히 승낙했다.', 2);

  -- 197. 製造
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '製造', 'せいぞう', '제조', '製(지을 제): 옷을 지음 / 造(지을 조): 만듦', '명사', 197, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この工場では車を製造している。', '이 공장에서는 차를 제조하고 있다.', 1),
    (w, '製造業の仕事に就いた。', '제조업 일에 취직했다.', 2);

  -- 198. 凍る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '凍る', 'こおる', '얼다', '凍(얼 동): 얼음(冫)이 얼음', '동사', 198, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さで池が凍った。', '추위로 연못이 얼었다.', 1),
    (w, '冷凍庫で水が凍る。', '냉동고에서 물이 언다.', 2);

  -- 199. 救う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '救う', 'すくう', '구조하다', '救(구원할 구): 도와 구함', '동사', 199, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '溺れている人を救った。', '물에 빠진 사람을 구했다.', 1),
    (w, '災害から多くの命を救う。', '재해로부터 많은 생명을 구한다.', 2);

  -- 200. 好調な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '好調な', 'こうちょうな', '호조인, 순조로운', '好(좋을 호): 좋음 / 調(고를 조): 어울림', 'な형용사', 200, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '売上は好調に推移している。', '매출은 호조로 추이하고 있다.', 1),
    (w, '彼は最近、好調な調子だ。', '그는 최근 컨디션이 좋다.', 2);

  -- 201. 永久
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '永久', 'えいきゅう', '영구(영원)', '永(길 영): 물길이 길게 흐름 / 久(오랠 구): 사람이 오래 머물러 있는 모양', '명사', 201, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の名は永久に語り継がれる。', '그의 이름은 영구히 전해질 것이다.', 1),
    (w, '永久に変わらない友情を誓った。', '영원히 변치 않을 우정을 맹세했다.', 2);

  -- 202. 在籍
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '在籍', 'ざいせき', '재적', '在(있을 재): 흙(土)에 남아 있음 / 籍(문서 적): 명부에 등록된 상태', '명사', 202, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はまだ会社に在籍している。', '그는 아직 회사에 재직하고 있다.', 1),
    (w, '大学に在籍中の学生だ。', '대학에 재학 중인 학생이다.', 2);

  -- 203. 従う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '従う', 'したがう', '따르다, 복종하다', '従(좇을 종): 두 사람이 앞뒤로 따라감', '동사', 203, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生の指示に従った。', '선생님의 지시에 따랐다.', 1),
    (w, '規則に従って行動する。', '규칙에 따라 행동한다.', 2);

  -- 204. 領収書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '領収書', 'りょうしゅうしょ', '영수증', '領(거느릴 령): 받음 / 収(거둘 수): 거둠 / 書(글 서): 문서', '명사', 204, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経費精算には領収書が必要だ。', '경비 정산에는 영수증이 필요하다.', 1),
    (w, '領収書を発行してください。', '영수증을 발행해 주세요.', 2);

  -- 205. 荒い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '荒い', 'あらい', '거칠다', '荒(거칠 황): 풀(艹)이 우거져 황량함', 'い형용사', 205, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の言葉遣いは荒い。', '그의 말투는 거칠다.', 1),
    (w, '波が荒くて泳げない。', '파도가 거칠어 수영할 수 없다.', 2);

  -- 206. 豊かな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '豊かな', 'ゆたかな', '풍부한, 부유한', '豊(풍성할 풍): 곡식이 풍성함', 'な형용사', 206, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は表現力が豊かだ。', '그는 표현력이 풍부하다.', 1),
    (w, '豊かな自然に囲まれた村だ。', '풍부한 자연에 둘러싸인 마을이다.', 2);

  -- 207. 養う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '養う', 'やしなう', '기르다, 부양하다', '養(기를 양): 양(羊)에게 먹이를 줌', '동사', 207, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '働いて家族を養っている。', '일해서 가족을 부양하고 있다.', 1),
    (w, '子供を養うのは責任が重い。', '아이를 기르는 것은 책임이 무겁다.', 2);

  -- 208. 省く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '省く', 'はぶく', '생략하다', '省(살필 성/덜 생): 작게 추림', '동사', 208, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無駄な手間を省きたい。', '쓸데없는 수고를 줄이고 싶다.', 1),
    (w, '細かい説明を省いて要点だけ話した。', '세세한 설명을 생략하고 요점만 말했다.', 2);

  -- 209. 迎える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '迎える', 'むかえる', '맞이하다', '迎(맞을 영): 길에서 사람을 맞아 들임', '동사', 209, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空港で家族を迎えた。', '공항에서 가족을 맞이했다.', 1),
    (w, '新年を家族と共に迎える。', '새해를 가족과 함께 맞이한다.', 2);

  -- 210. 系統
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '系統', 'けいとう', '계통', '系(이을 계): 끈으로 이음 / 統(거느릴 통): 실로 묶어 통합', '명사', 210, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '血液の系統を調べる。', '혈액 계통을 조사한다.', 1),
    (w, '新しい系統の薬が開発された。', '새 계통의 약이 개발되었다.', 2);

  -- 211. 束ねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '束ねる', 'たばねる', '묶다', '束(묶을 속): 나무를 끈으로 묶음', '동사', 211, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新聞を束ねて捨てる。', '신문을 묶어 버린다.', 1),
    (w, '髪をひとつに束ねた。', '머리를 하나로 묶었다.', 2);

  -- 212. 精算
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '精算', 'せいさん', '정산', '精(깨끗할 정): 정밀히 / 算(셈할 산): 계산', '명사', 212, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '月末に精算を行う。', '월말에 정산을 한다.', 1),
    (w, '出張費の精算を済ませた。', '출장비 정산을 마쳤다.', 2);

  -- 213. 趣味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '趣味', 'しゅみ', '취미', '趣(뜻 취): 향하는 마음 / 味(맛 미): 즐기는 맛', '명사', 213, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の趣味は読書だ。', '그의 취미는 독서다.', 1),
    (w, '新しい趣味を見つけたい。', '새로운 취미를 찾고 싶다.', 2);

  -- 214. 濃い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '濃い', 'こい', '짙다, 진하다', '濃(짙을 농): 물이 진하게 모임', 'い형용사', 214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーは濃い方が好きだ。', '커피는 진한 쪽이 좋다.', 1),
    (w, '霧が濃くて前が見えない。', '안개가 짙어 앞이 보이지 않는다.', 2);

  -- 215. 混じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '混じる', 'まじる', '섞이다', '混(섞을 혼): 물처럼 어울려 섞임', '동사', 215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語に英語が混じる。', '일본어에 영어가 섞인다.', 1),
    (w, 'いろんな国の人が混じっている。', '여러 나라 사람이 섞여 있다.', 2);

  -- 216. 損
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '損', 'そん', '손해', '損(덜 손): 손으로 줄임', '명사', 216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安いと思って買ったが損だった。', '싸다고 생각하고 샀는데 손해였다.', 1),
    (w, '急いで決めて損をした。', '서둘러 결정해 손해를 봤다.', 2);

  -- 217. 演技
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '演技', 'えんぎ', '연기', '演(펼 연): 길게 펼침 / 技(재주 기): 기예', '명사', 217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女の演技は迫真だった。', '그녀의 연기는 박진감이 있었다.', 1),
    (w, '俳優は素晴らしい演技を見せた。', '배우는 훌륭한 연기를 보여 주었다.', 2);

  -- 218. 違反
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '違反', 'いはん', '위반', '違(어긋날 위): 어긋남 / 反(돌이킬 반): 거스름', '명사', 218, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通違反で罰金を払った。', '교통 위반으로 벌금을 냈다.', 1),
    (w, '契約違反として訴えられた。', '계약 위반으로 고소되었다.', 2);

  -- 219. 陽気な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '陽気な', 'ようきな', '밝고 쾌활한, 명랑한', '陽(볕 양): 양지바른 / 気(기운 기): 기분', 'な형용사', 219, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は陽気な性格で人気がある。', '그는 명랑한 성격으로 인기가 있다.', 1),
    (w, '陽気な音楽が流れていた。', '경쾌한 음악이 흐르고 있었다.', 2);

  -- 220. 見逃す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '見逃す', 'みのがす', '놓치다', '見(볼 견): 봄 / 逃(달아날 도): 빠져나감', '동사', 220, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大事な場面を見逃した。', '중요한 장면을 놓쳤다.', 1),
    (w, '彼の小さな変化を見逃さなかった。', '그의 작은 변화를 놓치지 않았다.', 2);

  -- 221. 拡張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '拡張', 'かくちょう', '확장', '拡(넓힐 확): 넓힘 / 張(베풀 장): 펼침', '명사', 221, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事業を海外まで拡張する。', '사업을 해외까지 확장한다.', 1),
    (w, '道路の拡張工事が始まった。', '도로의 확장 공사가 시작되었다.', 2);

  -- 222. 帰省
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '帰省', 'きせい', '귀성', '帰(돌아갈 귀): 돌아감 / 省(살필 성): 살핌', '명사', 222, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏休みに帰省する予定だ。', '여름방학에 귀성할 예정이다.', 1),
    (w, '帰省ラッシュで道路が混む。', '귀성 행렬로 도로가 막힌다.', 2);

  -- 223. 縮める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '縮める', 'ちぢめる', '줄이다', '縮(줄일 축): 실(糸)이 짧게 줄어듦', '동사', 223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の時間を縮めた。', '회의 시간을 줄였다.', 1),
    (w, '距離を縮めて親しくなった。', '거리를 좁혀 친해졌다.', 2);

  -- 224. 異色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '異色', 'いしょく', '이색', '異(다를 이): 다름 / 色(빛 색): 색깔', '명사', 224, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '異色の経歴を持つ社員だ。', '이색 경력을 가진 직원이다.', 1),
    (w, '異色のコラボが話題を呼んだ。', '이색 콜라보가 화제를 모았다.', 2);

  -- 225. 返品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '返品', 'へいぴん', '반품', '返(돌이킬 반): 돌려보냄 / 品(물건 품): 물건', '명사', 225, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不良品を店に返品した。', '불량품을 가게에 반품했다.', 1),
    (w, '返品はレシートが必要です。', '반품은 영수증이 필요합니다.', 2);

  -- 226. 乱暴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乱暴', 'らんぼう', '난폭', '乱(어지러울 란): 어지러움 / 暴(사나울 폭): 사나움', '명사', 226, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '乱暴な言葉遣いはやめてほしい。', '난폭한 말투는 그만두기 바란다.', 1),
    (w, '彼の運転は乱暴で危ない。', '그의 운전은 난폭해서 위험하다.', 2);

  -- 227. 弱点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '弱点', 'じゃくてん', '약점', '弱(약할 약): 약함 / 点(점 점): 부분', '명사', 227, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の弱点を知っている。', '그의 약점을 알고 있다.', 1),
    (w, '弱点を克服する努力をした。', '약점을 극복하려는 노력을 했다.', 2);

  -- 228. 任せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '任せる', 'まかせる', '맡기다', '任(맡길 임): 사람에게 책임을 맡김', '동사', 228, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この件は君に任せる。', '이 건은 너에게 맡긴다.', 1),
    (w, '任された仕事を全力でやる。', '맡은 일을 전력으로 한다.', 2);

  -- 229. 順調
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '順調', 'じゅんちょう', '순조로움', '順(순할 순): 순함 / 調(고를 조): 어울림', '명사', 229, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全てが順調に進んでいる。', '모든 것이 순조롭게 진행되고 있다.', 1),
    (w, 'プロジェクトの順調を願っている。', '프로젝트의 순조로움을 빌고 있다.', 2);

  -- 230. 積もる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '積もる', 'つもる', '쌓이다', '積(쌓을 적): 쌓음', '동사', 230, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨夜から雪が積もった。', '어젯밤부터 눈이 쌓였다.', 1),
    (w, 'ストレスが積もって体に出た。', '스트레스가 쌓여 몸에 나타났다.', 2);

  -- 231. 登る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '登る', 'のぼる', '오르다', '登(오를 등): 단(豆) 위에 오름', '동사', 231, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山に登るのが趣味だ。', '산에 오르는 것이 취미다.', 1),
    (w, '階段を登って三階に行った。', '계단을 올라 3층에 갔다.', 2);

  -- 232. 住居
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '住居', 'じゅうきょ', '주거', '住(살 주): 사람이 머물러 삶 / 居(있을 거): 있음', '명사', 232, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい住居に引っ越した。', '새 주거지로 이사했다.', 1),
    (w, '彼の住居は駅から近い。', '그의 주거지는 역에서 가깝다.', 2);

  -- 233. 典型的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '典型的な', 'てんけいてきな', '전형적인', '典(법 전): 법전 / 型(거푸집 형): 본형 / 的: ~한', 'な형용사', 233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '典型的な日本料理を食べた。', '전형적인 일본 요리를 먹었다.', 1),
    (w, '彼は典型的なリーダーだ。', '그는 전형적인 리더다.', 2);

  -- 234. 欲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '欲', 'よく', '욕심', '欲(하고자할 욕): 마음에 빠진 갈망', '명사', 234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '欲を出すと失敗する。', '욕심을 내면 실패한다.', 1),
    (w, '人間には欲が必要な時もある。', '인간에게는 욕심이 필요할 때도 있다.', 2);

  -- 235. 俳優
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '俳優', 'はいゆう', '배우', '俳(배우 배): 광대 / 優(뛰어날 우): 뛰어남', '명사', 235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は人気俳優だ。', '그는 인기 배우다.', 1),
    (w, '俳優として活躍している。', '배우로 활약하고 있다.', 2);

  -- 236. 診断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '診断', 'しんだん', '진단', '診(진찰할 진): 진찰 / 断(끊을 단): 결단', '명사', 236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者の診断を受けた。', '의사의 진단을 받았다.', 1),
    (w, '早期診断が大切だ。', '조기 진단이 중요하다.', 2);

  -- 237. 布
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '布', 'ぬの', '천 (직물)', '布(베 포): 손으로 짠 천', '명사', 237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '布で机を拭いた。', '천으로 책상을 닦았다.', 1),
    (w, '柔らかい布で服を作る。', '부드러운 천으로 옷을 만든다.', 2);

  -- 238. 捨てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '捨てる', 'すてる', '버리다', '捨(버릴 사): 손으로 놓아 버림', '동사', 238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い服を捨てた。', '낡은 옷을 버렸다.', 1),
    (w, '夢を捨てたくない。', '꿈을 버리고 싶지 않다.', 2);

  -- 239. 機嫌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '機嫌', 'きげん', '기분', '機(틀 기): 변화의 기틀 / 嫌(싫어할 혐): 싫음 → 기분', '명사', 239, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は機嫌が悪そうだ。', '그는 기분이 나빠 보인다.', 1),
    (w, '子供の機嫌をとるのが上手だ。', '아이의 기분을 맞추는 데 능하다.', 2);

  -- 240. 損失
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '損失', 'そんしつ', '손실', '損(덜 손): 줄임 / 失(잃을 실): 잃음', '명사', 240, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社は大きな損失を出した。', '회사는 큰 손실을 냈다.', 1),
    (w, '損失を最小限に抑えたい。', '손실을 최소한으로 억제하고 싶다.', 2);

  -- 241. 研修
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '研修', 'けんしゅう', '연수', '研(갈 연): 갈고 닦음 / 修(닦을 수): 닦음', '명사', 241, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新人研修が始まった。', '신입 연수가 시작되었다.', 1),
    (w, '海外研修に参加した。', '해외 연수에 참가했다.', 2);

  -- 242. 耐える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '耐える', 'たえる', '견디다', '耐(견딜 내): 어려움을 참고 견딤', '동사', 242, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さに耐えて山頂に到達した。', '추위를 견뎌 산 정상에 도달했다.', 1),
    (w, 'プレッシャーに耐えるのは難しい。', '압박을 견디는 것은 어렵다.', 2);

  -- 243. 投票
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '投票', 'とうひょう', '투표', '投(던질 투): 던짐 / 票(쪽지 표): 표', '명사', 243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選挙で投票した。', '선거에서 투표했다.', 1),
    (w, '若者の投票率が低い。', '젊은이들의 투표율이 낮다.', 2);

  -- 244. 志望
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '志望', 'しぼう', '지망', '志(뜻 지): 마음의 뜻 / 望(바랄 망): 바람', '명사', 244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は医学部志望だ。', '그는 의학부 지망이다.', 1),
    (w, '第一志望に合格した。', '1지망에 합격했다.', 2);

  -- 245. 短編
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '短編', 'たんぺん', '단편', '短(짧을 단): 짧음 / 編(엮을 편): 엮음', '명사', 245, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '短編小説を読んだ。', '단편 소설을 읽었다.', 1),
    (w, '短編映画祭が開かれた。', '단편 영화제가 열렸다.', 2);

  -- 246. 散る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '散る', 'ちる', '떨어지다, 흩어지다', '散(흩을 산): 흩뿌려짐', '동사', 246, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '桜の花が散り始めた。', '벚꽃이 지기 시작했다.', 1),
    (w, '人々が散って静かになった。', '사람들이 흩어져 조용해졌다.', 2);

  -- 247. 柔らかい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '柔らかい', 'やわらかい', '부드럽다', '柔(부드러울 유): 창이 부드러워짐', 'い형용사', 247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '柔らかいパンが焼き上がった。', '부드러운 빵이 구워졌다.', 1),
    (w, '赤ちゃんの肌は柔らかい。', '아기의 피부는 부드럽다.', 2);

  -- 248. 疲労
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '疲労', 'ひろう', '피로', '疲(피곤할 피): 피곤함 / 労(일할 로): 노동', '명사', 248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲労がたまっている。', '피로가 쌓여 있다.', 1),
    (w, '十分な睡眠で疲労を取る。', '충분한 수면으로 피로를 푼다.', 2);

  -- 249. 避難
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '避難', 'ひなん', '피난', '避(피할 피): 피함 / 難(어려울 난): 어려움', '명사', 249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地震の際は安全な場所に避難する。', '지진 시에는 안전한 곳으로 피난한다.', 1),
    (w, '避難訓練に参加した。', '피난 훈련에 참가했다.', 2);

  -- 250. 敬う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '敬う', 'うやまう', '존경하다', '敬(공경 경): 공손히 함', '동사', 250, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生を敬う気持ちが大切だ。', '선생님을 존경하는 마음이 중요하다.', 1),
    (w, '彼は誰からも敬われている。', '그는 누구에게나 존경받는다.', 2);

  -- 251. 受講
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '受講', 'じゅこう', '수강', '受(받을 수): 받음 / 講(외울 강): 강의', '명사', 251, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'オンライン講座を受講した。', '온라인 강좌를 수강했다.', 1),
    (w, '受講生が増えている。', '수강생이 늘고 있다.', 2);

  -- 252. 厚かましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '厚かましい', 'あつかましい', '뻔뻔하다', '厚(두터울 후): 두꺼움 → 낯이 두꺼움', 'い형용사', 252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厚かましいお願いをして恐縮です。', '뻔뻔한 부탁을 드려 송구합니다.', 1),
    (w, '彼は厚かましい態度を取る。', '그는 뻔뻔한 태도를 취한다.', 2);

  -- 253. 諸問題
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '諸問題', 'しょもんだい', '여러 문제', '諸(모두 제): 여러 / 問題(문제): 문제', '명사', 253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山積する諸問題に取り組む。', '산적한 여러 문제에 임한다.', 1),
    (w, '諸問題の解決には時間がかかる。', '여러 문제의 해결에는 시간이 걸린다.', 2);

  -- 254. ２対１2
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '２対１2', '２たい１2', '2 대 1', '対(대할 대): 마주함 → 비율을 나타냄', '명사', 254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合は２対１で勝った。', '시합은 2 대 1로 이겼다.', 1),
    (w, '２対１の比率で混ぜる。', '2 대 1의 비율로 섞는다.', 2);

  -- 255. 商店街
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '商店街', 'しょうてんがい', '상점가, 상가', '商店(상점) + 街(거리 가)', '명사', 255, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商店街を散歩するのが好きだ。', '상점가를 산책하는 것을 좋아한다.', 1),
    (w, '古い商店街が再開発される。', '오래된 상점가가 재개발된다.', 2);

  -- 256. 再放送
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '再放送', 'さいほうそう', '재방송', '再(두 재) + 放送(방송)', '명사', 256, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見逃したドラマを再放送で見た。', '놓친 드라마를 재방송으로 봤다.', 1),
    (w, '再放送の予定が発表された。', '재방송 예정이 발표되었다.', 2);

  -- 257. 高収入
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '高収入', 'こうしゅうにゅう', '고수입', '高(높을 고) + 収入(수입)', '명사', 257, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高収入の仕事に転職した。', '고수입의 일로 전직했다.', 1),
    (w, '高収入を得るには努力が必要だ。', '고수입을 얻으려면 노력이 필요하다.', 2);

  -- 258. 予約制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '予約制', 'よやくせい', '예약제', '予約(예약) + 制(제도)', '명사', 258, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このレストランは予約制だ。', '이 레스토랑은 예약제다.', 1),
    (w, '完全予約制のサロンに行った。', '완전 예약제 살롱에 갔다.', 2);

  -- 259. 副社長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '副社長', 'ふくしゃちょう', '부사장', '副(버금 부) + 社長(사장)', '명사', 259, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は副社長に昇進した。', '그는 부사장으로 승진했다.', 1),
    (w, '副社長が会議を主催した。', '부사장이 회의를 주재했다.', 2);

  -- 260. 就職率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '就職率', 'しゅうしょくりつ', '취직률', '就職(취직) + 率(비율 률)', '명사', 260, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学の就職率が公表された。', '대학 취직률이 공개되었다.', 1),
    (w, '就職率が前年より上がった。', '취업률이 전년보다 올랐다.', 2);

  -- 261. 集中力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '集中力', 'しゅうちゅうりょく', '집중력', '集中(집중) + 力(힘 력)', '명사', 261, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は集中力が高い。', '그는 집중력이 높다.', 1),
    (w, '集中力を維持するのは難しい。', '집중력을 유지하는 것은 어렵다.', 2);

  -- 262. 旧制度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '旧制度', 'きゅうせいど', '구제도', '旧(옛 구) + 制度(제도)', '명사', 262, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旧制度の方が分かりやすかった。', '구제도가 더 이해하기 쉬웠다.', 1),
    (w, '旧制度から新制度に移行した。', '구제도에서 신제도로 이행했다.', 2);

  -- 263. 医学界
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '医学界', 'いがくかい', '의학계', '医学(의학) + 界(경계 계)', '명사', 263, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医学界に新しい発見があった。', '의학계에 새로운 발견이 있었다.', 1),
    (w, '彼は医学界の権威だ。', '그는 의학계의 권위자다.', 2);

  -- 264. 文学賞
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '文学賞', 'ぶんがくしょう', '문학상', '文学(문학) + 賞(상)', '명사', 264, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は文学賞を受賞した。', '그녀는 문학상을 수상했다.', 1),
    (w, '権威ある文学賞に選ばれた。', '권위 있는 문학상에 선정되었다.', 2);

  -- 265. 準優勝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '準優勝', 'じゅんゆうしょう', '준우승', '準(준할 준) + 優勝(우승)', '명사', 265, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大会で準優勝を果たした。', '대회에서 준우승을 거뒀다.', 1),
    (w, '惜しくも準優勝に終わった。', '아쉽게도 준우승에 그쳤다.', 2);

  -- 266. 悪条件
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '悪条件', 'あくじょうけん', '악조건', '悪(악할 악) + 条件(조건)', '명사', 266, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '悪条件の中で試合を行った。', '악조건 속에서 시합을 했다.', 1),
    (w, '悪条件にも関わらず成功した。', '악조건에도 불구하고 성공했다.', 2);

  -- 267. 現段階
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '現段階', 'げんだんかい', '현 단계', '現(나타날 현) + 段階(단계)', '명사', 267, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現段階では発表できない。', '현 단계에서는 발표할 수 없다.', 1),
    (w, '現段階でわかっていることを伝える。', '현 단계에서 알고 있는 것을 전한다.', 2);

  -- 268. クリーム状
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'クリーム状', 'クリームじょう', '크림 상태', 'クリーム + 状(모양 상)', '명사', 268, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '材料をクリーム状になるまで混ぜる。', '재료를 크림 상태가 될 때까지 섞는다.', 1),
    (w, 'クリーム状の薬を塗る。', '크림 상태의 약을 바른다.', 2);

  -- 269. 非公式
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '非公式', 'ひこうしき', '비공식', '非(아닐 비) + 公式(공식)', '명사', 269, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '非公式の会合に出席した。', '비공식 회합에 출석했다.', 1),
    (w, '非公式の発表があった。', '비공식 발표가 있었다.', 2);

  -- 270. 一日おき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一日おき', 'いちにちおき', '하루 걸러', '一日 + おき(걸러)', '명사', 270, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一日おきにジムに通っている。', '하루 걸러 헬스장에 다니고 있다.', 1),
    (w, '薬は一日おきに飲む。', '약은 하루 걸러 먹는다.', 2);

  -- 271. 総売上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '総売上', 'そううりあげ', '총매출', '総(거느릴 총) + 売上(매출)', '명사', 271, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今月の総売上が発表された。', '이달 총매출이 발표되었다.', 1),
    (w, '総売上が過去最高を記録した。', '총매출이 사상 최고를 기록했다.', 2);

  -- 272. 来シーズン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '来シーズン', 'らいシーズン', '다음 시즌', '来(올 래) + シーズン', '명사', 272, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来シーズンが楽しみだ。', '다음 시즌이 기대된다.', 1),
    (w, '来シーズンの計画を立てた。', '다음 시즌 계획을 세웠다.', 2);

  -- 273. ビジネスマン風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ビジネスマン風', 'ビジネスマンふう', '비즈니스맨풍', 'ビジネスマン + 風(풍)', '명사', 273, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビジネスマン風のスーツを着た。', '비즈니스맨풍의 정장을 입었다.', 1),
    (w, 'ビジネスマン風の人物が現れた。', '비즈니스맨풍의 인물이 나타났다.', 2);

  -- 274. 真夜中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '真夜中', 'まよなか', '한밤중', '真(참 진) + 夜中(밤중)', '명사', 274, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真夜中に電話が鳴った。', '한밤중에 전화가 울렸다.', 1),
    (w, '真夜中まで仕事をした。', '한밤중까지 일했다.', 2);

  -- 275. 仮採用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '仮採用', 'かりさいよう', '임시 채용', '仮(거짓 가) + 採用(채용)', '명사', 275, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仮採用期間は三ヶ月だ。', '임시 채용 기간은 3개월이다.', 1),
    (w, '仮採用から正社員になった。', '임시 채용에서 정사원이 되었다.', 2);

  -- 276. 投票率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '投票率', 'とうひょうりつ', '투표율', '投票 + 率(비율)', '명사', 276, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若者の投票率が低い。', '젊은이들의 투표율이 낮다.', 1),
    (w, '投票率が前回より上昇した。', '투표율이 지난번보다 상승했다.', 2);

  -- 277. 国際色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '国際色', 'こくさいしょく', '국제색', '国際(국제) + 色(빛/특색)', '명사', 277, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '国際色豊かなイベントだ。', '국제색이 풍부한 이벤트다.', 1),
    (w, '国際色のある街並みだ。', '국제색이 있는 거리 풍경이다.', 2);

  -- 278. アルファベット順
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'アルファベット順', 'アルファベットじゅん', '알파벳순', 'アルファベット + 順(차례 순)', '명사', 278, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名簿はアルファベット順に並んでいる。', '명단은 알파벳순으로 정렬되어 있다.', 1),
    (w, 'アルファベット順で発表する。', '알파벳순으로 발표한다.', 2);

  -- 279. 諸外国
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '諸外国', 'しょがいこく', '제 외국, 외국 여러 나라', '諸(여러 제) + 外国(외국)', '명사', 279, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '諸外国との関係を深めたい。', '여러 외국과의 관계를 깊이 하고 싶다.', 1),
    (w, '諸外国の文化を学ぶ。', '여러 외국의 문화를 배운다.', 2);

  -- 280. 半透明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '半透明', 'はんとうめい', '반투명', '半(반 반) + 透明(투명)', '명사', 280, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '半透明のガラスを使った。', '반투명 유리를 사용했다.', 1),
    (w, '半透明の袋に入れる。', '반투명 봉투에 담는다.', 2);

  -- 281. 低価格
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '低価格', 'ていかかく', '저가격', '低(낮을 저) + 価格(가격)', '명사', 281, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '低価格で高品質の商品だ。', '저가격에 고품질 상품이다.', 1),
    (w, '低価格戦略で売上を伸ばした。', '저가격 전략으로 매출을 늘렸다.', 2);

  -- 282. 日本流
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '日本流', 'にほんりゅう', '일본류, 일본식', '日本 + 流(흐를 류)', '명사', 282, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本流のおもてなしを学ぶ。', '일본식 환대를 배운다.', 1),
    (w, '日本流のやり方で進める。', '일본식 방식으로 진행한다.', 2);

  -- 283. 準決勝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '準決勝', 'じゅんけっしょう', '준결승', '準(준할 준) + 決勝(결승)', '명사', 283, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '準決勝で敗れてしまった。', '준결승에서 패하고 말았다.', 1),
    (w, '準決勝の試合は明日だ。', '준결승 시합은 내일이다.', 2);

  -- 284. 再提出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '再提出', 'さいていしゅつ', '재제출, 다시 제출함', '再(두 재) + 提出(제출)', '명사', 284, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書類の再提出を求められた。', '서류의 재제출을 요구받았다.', 1),
    (w, '訂正後に再提出した。', '정정 후에 재제출했다.', 2);

  -- 285. 親子連れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '親子連れ', 'おやこづれ', '부모 자식 동반', '親子(부모 자식) + 連れ(동반)', '명사', 285, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親子連れで公園を楽しんだ。', '부모 자식이 함께 공원을 즐겼다.', 1),
    (w, '親子連れの客が多い。', '부모 자식 동반 손님이 많다.', 2);

  -- 286. 東京駅発
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '東京駅発', 'とうきょうえきはつ', '도쿄 역 출발', '東京駅 + 発(필 발)', '명사', 286, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京駅発の新幹線に乗った。', '도쿄역발 신칸센을 탔다.', 1),
    (w, '東京駅発の便を確認した。', '도쿄역발 편을 확인했다.', 2);

  -- 287. 薄暗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '薄暗い', 'うすぐらい', '어둑어둑하다, 침침하다', '薄(엷을 박) + 暗(어두울 암)', 'い형용사', 287, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '薄暗い部屋で本を読んだ。', '어둑한 방에서 책을 읽었다.', 1),
    (w, '夕方になって薄暗くなった。', '저녁이 되어 어둑해졌다.', 2);

  -- 288. 音楽全般
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '音楽全般', 'おんがくぜんぱん', '음악 전반', '音楽(음악) + 全般(전반)', '명사', 288, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は音楽全般に詳しい。', '그는 음악 전반에 정통하다.', 1),
    (w, '音楽全般に興味を持っている。', '음악 전반에 관심을 가지고 있다.', 2);

  -- 289. 風邪気味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '風邪気味', 'かぜぎみ', '감기 기운', '風邪(감기) + 気味(기운)', '명사', 289, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風邪気味なので早く帰った。', '감기 기운이 있어서 일찍 돌아갔다.', 1),
    (w, '風邪気味で会議を欠席した。', '감기 기운으로 회의에 결석했다.', 2);

  -- 290. 最有力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '最有力', 'さいゆうりょく', '최유력, 가장 유력', '最(가장 최) + 有力(유력)', '명사', 290, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が最有力候補と見られている。', '그가 최유력 후보로 보인다.', 1),
    (w, '最有力の対抗馬が登場した。', '최유력 대항마가 등장했다.', 2);

  -- 291. 食器類
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '食器類', 'しょっきるい', '식기류', '食器(식기) + 類(무리 류)', '명사', 291, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食器類を棚に片付けた。', '식기류를 선반에 정리했다.', 1),
    (w, '新しい食器類を購入した。', '새로운 식기류를 구입했다.', 2);

  -- 292. 夏休み明け
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '夏休み明け', 'なつやすみあけ', '여름 방학 끝 무렵', '夏休み + 明け(밝아짐, 끝)', '명사', 292, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏休み明けは忙しい。', '여름방학 끝 무렵은 바쁘다.', 1),
    (w, '夏休み明けの初日に登校した。', '여름방학 끝 무렵 첫날에 등교했다.', 2);

  -- 293. 作品集
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '作品集', 'さくひんしゅう', '작품집', '作品 + 集(모을 집)', '명사', 293, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の作品集が出版された。', '그의 작품집이 출판되었다.', 1),
    (w, '写真の作品集を購入した。', '사진 작품집을 구입했다.', 2);

  -- 294. 危険性
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '危険性', 'きけんせい', '위험성', '危険 + 性(성질 성)', '명사', 294, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故の危険性が高い場所だ。', '사고 위험성이 높은 장소다.', 1),
    (w, '新薬の危険性を調査する。', '신약의 위험성을 조사한다.', 2);

  -- 295. 線路沿い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '線路沿い', 'せんろぞい', '선로가', '線路(선로) + 沿い(따라)', '명사', 295, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '線路沿いに桜が咲いている。', '선로를 따라 벚꽃이 피어 있다.', 1),
    (w, '線路沿いの家に住んでいる。', '선로변의 집에 살고 있다.', 2);

  -- 296. 未経験
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '未経験', 'みけいけん', '미경험', '未(아닐 미) + 経験(경험)', '명사', 296, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未経験者でも応募できる。', '미경험자라도 응모할 수 있다.', 1),
    (w, '未経験から始めた仕事だ。', '미경험에서 시작한 일이다.', 2);

  -- 297. 期限切れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '期限切れ', 'きげんぎれ', '기한 종료', '期限(기한) + 切れ(끊김)', '명사', 297, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '期限切れの食品を捨てた。', '기한이 지난 식품을 버렸다.', 1),
    (w, 'クーポンが期限切れになった。', '쿠폰이 기한 종료가 되었다.', 2);

  -- 298. 電車賃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '電車賃', 'でんしゃちん', '전철 요금', '電車(전철) + 賃(품삯 임)', '명사', 298, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車賃が値上がりした。', '전철 요금이 인상되었다.', 1),
    (w, '毎月の電車賃を計算した。', '매달 전철 요금을 계산했다.', 2);

  -- 299. 高性能
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '高性能', 'こうせいのう', '고성능', '高(높을 고) + 性能(성능)', '명사', 299, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高性能なパソコンを買った。', '고성능 컴퓨터를 샀다.', 1),
    (w, '高性能のカメラを愛用している。', '고성능 카메라를 애용하고 있다.', 2);

  -- 300. 祭りムード一色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '祭りムード一色', 'まつりムードいっしょく', '축제 분위기 일색', '祭り(축제) + ムード + 一色(일색)', '명사', 300, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '街は祭りムード一色だ。', '거리는 축제 분위기 일색이다.', 1),
    (w, '花火大会で祭りムード一色になった。', '불꽃놀이로 축제 분위기 일색이 되었다.', 2);

  -- 301. 応援団
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '応援団', 'おうえんだん', '응원단', '応援(응원) + 団(모일 단)', '명사', 301, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学校の応援団が試合で大活躍した。', '학교 응원단이 시합에서 크게 활약했다.', 1),
    (w, '応援団の声が会場に響いた。', '응원단의 목소리가 회장에 울렸다.', 2);

  -- 302. 無責任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '無責任', 'むせきにん', '무책임', '無(없을 무) + 責任(책임)', '명사', 302, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな無責任な発言はやめてほしい。', '그런 무책임한 발언은 그만뒀으면 한다.', 1),
    (w, '彼の無責任な態度に呆れた。', '그의 무책임한 태도에 어이가 없었다.', 2);

  -- 303. 悪影響
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '悪影響', 'あくえいきょう', '악영향', '悪(악할 악) + 影響(영향)', '명사', 303, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '睡眠不足は健康に悪影響を与える。', '수면 부족은 건강에 악영향을 준다.', 1),
    (w, '悪影響を最小限に抑えたい。', '악영향을 최소화하고 싶다.', 2);

  -- 304. 子供連れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '子供連れ', 'こどもづれ', '자녀 동반', '子供(아이) + 連れ(동반)', '명사', 304, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供連れで旅行を楽しんだ。', '아이를 동반하고 여행을 즐겼다.', 1),
    (w, '子供連れの家族で混雑している。', '자녀 동반 가족으로 붐빈다.', 2);

  -- 305. 成功率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '成功率', 'せいこうりつ', '성공률', '成功(성공) + 率(비율)', '명사', 305, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この手術の成功率は高い。', '이 수술의 성공률은 높다.', 1),
    (w, '成功率を上げる工夫が必要だ。', '성공률을 높이는 궁리가 필요하다.', 2);

  -- 306. 招待状
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '招待状', 'しょうたいじょう', '초대장', '招待(초대) + 状(편지 장)', '명사', 306, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚式の招待状が届いた。', '결혼식 초대장이 도착했다.', 1),
    (w, '招待状を発送する準備をした。', '초대장을 발송할 준비를 했다.', 2);

  -- 307. 現実離れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '現実離れ', 'げんじつばなれ', '현실을 벗어남', '現実(현실) + 離れ(떨어짐)', '명사', 307, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の発言は現実離れしている。', '그의 발언은 현실과 동떨어져 있다.', 1),
    (w, '現実離れした夢を語る。', '현실과 동떨어진 꿈을 말한다.', 2);

  -- 308. 真新しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '真新しい', 'まあたらしい', '완전히 새롭다', '真(참 진) + 新しい(새롭다)', 'い형용사', 308, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真新しい靴を履いて出かけた。', '완전히 새 구두를 신고 외출했다.', 1),
    (w, '真新しい本のにおいが好きだ。', '갓 나온 책 냄새를 좋아한다.', 2);

  -- 309. ヨーロッパ風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ヨーロッパ風', 'ヨーロッパふう', '유럽풍', 'ヨーロッパ + 風', '명사', 309, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ヨーロッパ風のカフェに行った。', '유럽풍 카페에 갔다.', 1),
    (w, 'ヨーロッパ風のデザインが流行している。', '유럽풍 디자인이 유행하고 있다.', 2);

  -- 310. 異文化
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '異文化', 'いぶんか', '이문화', '異(다를 이) + 文化(문화)', '명사', 310, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '異文化交流の機会が増えた。', '이문화 교류의 기회가 늘었다.', 1),
    (w, '異文化を理解することが大事だ。', '이문화를 이해하는 것이 중요하다.', 2);

  -- 311. 結婚観
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '結婚観', 'けっこんかん', '결혼관', '結婚(결혼) + 観(볼 관)', '명사', 311, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近の若者の結婚観は変化している。', '최근 젊은이들의 결혼관은 변화하고 있다.', 1),
    (w, '彼女の結婚観に共感した。', '그녀의 결혼관에 공감했다.', 2);

  -- 312. 年代順
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '年代順', 'ねんだいじゅん', '연대순', '年代(연대) + 順(차례)', '명사', 312, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真を年代順に並べた。', '사진을 연대순으로 정렬했다.', 1),
    (w, '資料は年代順に整理されている。', '자료는 연대순으로 정리되어 있다.', 2);

  -- 313. 高水準
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '高水準', 'こうすいじゅん', '고수준', '高 + 水準(수준)', '명사', 313, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高水準の教育を受ける。', '고수준의 교육을 받는다.', 1),
    (w, '高水準のサービスを提供する。', '고수준의 서비스를 제공한다.', 2);

  -- 314. 管理下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '管理下', 'かんりか', '관리하', '管理(관리) + 下(아래)', '명사', 314, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロジェクトは私の管理下にある。', '프로젝트는 내 관리하에 있다.', 1),
    (w, '厳しい管理下に置かれている。', '엄격한 관리하에 놓여 있다.', 2);

  -- 315. 日本式
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '日本式', 'にほんしき', '일본식', '日本 + 式(법 식)', '명사', 315, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本式の家に住みたい。', '일본식 집에 살고 싶다.', 1),
    (w, '日本式のビジネスマナーを学ぶ。', '일본식 비즈니스 매너를 배운다.', 2);

  -- 316. 再開発
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '再開発', 'さいかいはつ', '재개발', '再(두 재) + 開発(개발)', '명사', 316, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅前が再開発される。', '역 앞이 재개발된다.', 1),
    (w, '再開発で街が大きく変わった。', '재개발로 거리가 크게 변했다.', 2);

  -- 317. 未使用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '未使用', 'みしよう', '미사용', '未(아닐 미) + 使用(사용)', '명사', 317, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未使用の商品をオークションに出した。', '미사용 상품을 경매에 내놓았다.', 1),
    (w, '未使用のチケットを返金した。', '미사용 티켓을 환불했다.', 2);

  -- 318. 主成分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '主成分', 'しゅせいぶん', '주성분', '主(주인 주) + 成分(성분)', '명사', 318, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この薬の主成分は何ですか。', '이 약의 주성분은 무엇입니까?', 1),
    (w, '商品の主成分を確認する。', '상품의 주성분을 확인한다.', 2);

  -- 319. 勉強づけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勉強づけ', 'べんきょうづけ', '공부 몰입', '勉強(공부) + づけ(절임 → 몰입)', '명사', 319, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験前は勉強づけの毎日だ。', '시험 전에는 공부 몰입의 나날이다.', 1),
    (w, '子供を勉強づけにするのは良くない。', '아이를 공부 몰입으로 만드는 것은 좋지 않다.', 2);

  -- 320. 初年度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '初年度', 'しょねんど', '초년도', '初(처음 초) + 年度(연도)', '명사', 320, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初年度の売上が好調だ。', '초년도 매출이 호조다.', 1),
    (w, '初年度から黒字を達成した。', '초년도부터 흑자를 달성했다.', 2);

  -- 321. 前社長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '前社長', 'ぜんしゃちょう', '전 사장', '前(앞 전) + 社長(사장)', '명사', 321, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '前社長の方針を引き継いだ。', '전 사장의 방침을 이어받았다.', 1),
    (w, '前社長は引退した。', '전 사장은 은퇴했다.', 2);

  -- 322. 会員制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '会員制', 'かいいんせい', '회원제', '会員(회원) + 制(제도)', '명사', 322, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このジムは会員制だ。', '이 헬스장은 회원제다.', 1),
    (w, '会員制の限定イベントに参加した。', '회원제 한정 이벤트에 참가했다.', 2);

  -- 323. 家族連れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '家族連れ', 'かぞくづれ', '가족 동반', '家族(가족) + 連れ(동반)', '명사', 323, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遊園地は家族連れで賑わう。', '유원지는 가족 동반으로 북적인다.', 1),
    (w, '家族連れで温泉に行った。', '가족 동반으로 온천에 갔다.', 2);

  -- 324. 真後ろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '真後ろ', 'まうしろ', '바로 뒤', '真(참 진) + 後ろ(뒤)', '명사', 324, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真後ろから声をかけられた。', '바로 뒤에서 누군가 말을 걸었다.', 1),
    (w, '真後ろの席が空いていた。', '바로 뒤 좌석이 비어 있었다.', 2);

  -- 325. 住宅街
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '住宅街', 'じゅうたくがい', '주택가', '住宅(주택) + 街(거리)', '명사', 325, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '静かな住宅街に住んでいる。', '조용한 주택가에 살고 있다.', 1),
    (w, '住宅街に新しいカフェができた。', '주택가에 새 카페가 생겼다.', 2);

  -- 326. 不正確
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '不正確', 'ふせいかく', '부정확', '不(아닐 부) + 正確(정확)', '명사', 326, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不正確な情報が広まっている。', '부정확한 정보가 퍼지고 있다.', 1),
    (w, '不正確な計算結果を訂正した。', '부정확한 계산 결과를 정정했다.', 2);

  -- 327. 低カロリー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '低カロリー', 'ていカロリー', '저칼로리', '低 + カロリー', '명사', 327, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '低カロリーのお菓子を選んだ。', '저칼로리 과자를 골랐다.', 1),
    (w, '低カロリーの食事を心がけている。', '저칼로리 식사를 신경 쓰고 있다.', 2);

  -- 328. 会社員風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '会社員風', 'かいしゃいんふう', '회사원풍', '会社員 + 風', '명사', 328, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社員風の男性が話しかけてきた。', '회사원풍의 남성이 말을 걸어 왔다.', 1),
    (w, '会社員風のスーツを着る。', '회사원풍의 정장을 입는다.', 2);

  -- 329. スキー場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'スキー場', 'スキーじょう', '스키장', 'スキー + 場(장소)', '명사', 329, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冬休みにスキー場へ行った。', '겨울 방학에 스키장에 갔다.', 1),
    (w, 'スキー場が今シーズンも開業した。', '스키장이 이번 시즌도 개장했다.', 2);

  -- 330. 来学期
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '来学期', 'らいがっき', '다음 학기', '来(올 래) + 学期(학기)', '명사', 330, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来学期から留学生が増える。', '다음 학기부터 유학생이 늘어난다.', 1),
    (w, '来学期は新しい授業を受ける。', '다음 학기에는 새 수업을 듣는다.', 2);

  -- 331. 進学率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '進学率', 'しんがくりつ', '진학률', '進学(진학) + 率(비율)', '명사', 331, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高校の進学率が公表された。', '고등학교 진학률이 공개되었다.', 1),
    (w, '進学率の向上を目指す。', '진학률 향상을 목표로 한다.', 2);

  -- 332. 副大臣
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '副大臣', 'ふくだいじん', '부대신(차관)', '副(버금 부) + 大臣(대신)', '명사', 332, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は副大臣に任命された。', '그는 부대신으로 임명되었다.', 1),
    (w, '副大臣が記者会見を行った。', '부대신이 기자 회견을 했다.', 2);

  -- 333. 学年別
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '学年別', 'がくねんべつ', '학년별', '学年 + 別(나눌 별)', '명사', 333, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学年別にクラスを分けた。', '학년별로 반을 나눴다.', 1),
    (w, '学年別のイベントを開催する。', '학년별 이벤트를 개최한다.', 2);

  -- 334. 無計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '無計画', 'むけいかく', '무계획', '無(없을 무) + 計画(계획)', '명사', 334, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無計画な行動は危険だ。', '무계획한 행동은 위험하다.', 1),
    (w, '無計画に旅行に出かけた。', '무계획하게 여행을 떠났다.', 2);

  -- 335. 送信元
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '送信元', 'そうしんもと', '송신원', '送信(송신) + 元(근원)', '명사', 335, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メールの送信元を確認する。', '메일 송신원을 확인한다.', 1),
    (w, '不明な送信元のメールは開かない。', '불명의 송신원 메일은 열지 않는다.', 2);

  -- 336. 働き手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '働き手', 'はたらきて', '일 손', '働き(일) + 手(사람)', '명사', 336, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '農村では働き手が不足している。', '농촌에서는 일손이 부족하다.', 1),
    (w, '若い働き手を募集している。', '젊은 일손을 모집하고 있다.', 2);

  -- 337. メリカ流
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'メリカ流', 'メリカりゅう', '아메리카류, 미국식', 'アメリカ + 流(방식)', '명사', 337, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'アメリカ流のビジネスを学ぶ。', '미국식 비즈니스를 배운다.', 1),
    (w, 'アメリカ流の生活に慣れた。', '미국식 생활에 익숙해졌다.', 2);

  -- 338. 別れ際
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '別れ際', 'わかれぎわ', '헤어질 때', '別れ(이별) + 際(때)', '명사', 338, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '別れ際に握手を交わした。', '헤어질 때 악수를 나눴다.', 1),
    (w, '別れ際の言葉が心に残る。', '헤어질 때의 말이 마음에 남는다.', 2);

  -- 339. 前町長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '前町長', 'ぜんちょうちょう', '전 읍장', '前(앞 전) + 町長(읍장)', '명사', 339, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '前町長が引退の挨拶をした。', '전 읍장이 은퇴 인사를 했다.', 1),
    (w, '前町長の業績が高く評価された。', '전 읍장의 업적이 높이 평가되었다.', 2);

  -- 340. 頼みづらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頼みづらい', 'たのみづらい', '부탁하기 어렵다', '頼み + づらい(어렵다)', 'い형용사', 340, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先輩には頼みづらい話だ。', '선배에게는 부탁하기 어려운 이야기다.', 1),
    (w, '忙しそうで頼みづらい。', '바빠 보여서 부탁하기 어렵다.', 2);

  -- 341. 政治色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '政治色', 'せいじしょく', '정치색', '政治 + 色(특색)', '명사', 341, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政治色の強い発言は控えたい。', '정치색이 강한 발언은 자제하고 싶다.', 1),
    (w, '政治色を出さない番組だ。', '정치색을 드러내지 않는 프로그램이다.', 2);

  -- 342. 都会育ち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '都会育ち', 'とかいそだち', '도시에서 자람', '都会(도시) + 育ち(자람)', '명사', 342, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は都会育ちで田舎暮らしに憧れる。', '그는 도시에서 자라 시골 생활을 동경한다.', 1),
    (w, '都会育ちの彼女は虫が苦手だ。', '도시에서 자란 그녀는 벌레를 싫어한다.', 2);

  -- 343. 一仕事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一仕事', 'ひとしごと', '한 가지 일', '一(한 일) + 仕事(일)', '명사', 343, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かける前に一仕事終えた。', '외출 전에 한 가지 일을 마쳤다.', 1),
    (w, '朝から一仕事して疲れた。', '아침부터 한 일을 해서 피곤하다.', 2);

  -- 344. ボール状
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ボール状', 'ボールじょう', '볼형, 동그란 모양', 'ボール + 状(모양 상)', '명사', 344, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生地をボール状にして焼く。', '반죽을 볼형으로 만들어 굽는다.', 1),
    (w, '材料をボール状にこねる。', '재료를 동그랗게 반죽한다.', 2);

  -- 345. 別会場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '別会場', 'べつかいじょう', '다른 회장', '別(다를 별) + 会場(회장)', '명사', 345, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '別会場で説明会を開いた。', '다른 회장에서 설명회를 열었다.', 1),
    (w, '別会場へのご案内をする。', '다른 회장으로의 안내를 한다.', 2);

  -- 346. 現社長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '現社長', 'げんしゃちょう', '현재 사장', '現(나타날 현) + 社長(사장)', '명사', 346, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現社長は若くして就任した。', '현 사장은 젊은 나이에 취임했다.', 1),
    (w, '現社長の経営方針が支持された。', '현 사장의 경영 방침이 지지받았다.', 2);

  -- 347. 同意見
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '同意見', 'どういけん', '같은 의견', '同(같을 동) + 意見(의견)', '명사', 347, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私も彼と同意見だ。', '나도 그와 같은 의견이다.', 1),
    (w, '同意見の人を集めて議論する。', '같은 의견의 사람들을 모아 논의한다.', 2);

  -- 348. 食べ頃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '食べ頃', 'たべごろ', '먹기에 적당한 때, 제철', '食べ + 頃(때 경)', '명사', 348, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '桃が食べ頃を迎えた。', '복숭아가 먹기 좋은 때를 맞았다.', 1),
    (w, '冬は鍋が食べ頃の季節だ。', '겨울은 전골이 제철인 계절이다.', 2);

  -- 349. 仮登録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '仮登録', 'かりとうろく', '가등록, 임시 등록', '仮(거짓 가) + 登録(등록)', '명사', 349, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まずは仮登録だけ済ませた。', '우선 가등록만 마쳤다.', 1),
    (w, '仮登録から本登録へ移行する。', '가등록에서 본등록으로 이행한다.', 2);

  -- 350. 異分野
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '異分野', 'いぶんや', '다른 분야', '異(다를 이) + 分野(분야)', '명사', 350, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '異分野の人と交流が増えた。', '다른 분야 사람과의 교류가 늘었다.', 1),
    (w, '異分野からの転職を考えている。', '다른 분야로의 전직을 고려하고 있다.', 2);

  -- 351. 写真付き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '写真付き', 'しゃしんつき', '사진 첨부', '写真 + 付き(붙음)', '명사', 351, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '写真付きのメニューが分かりやすい。', '사진 첨부 메뉴가 알기 쉽다.', 1),
    (w, '写真付きの履歴書を提出した。', '사진 첨부 이력서를 제출했다.', 2);

  -- 352. 現制度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '現制度', 'げんせいど', '현재 제도', '現(나타날 현) + 制度(제도)', '명사', 352, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現制度の見直しを検討中だ。', '현 제도의 재검토를 검토 중이다.', 1),
    (w, '現制度では対応できない。', '현 제도로는 대응할 수 없다.', 2);

  -- 353. 用心深い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '用心深い', 'ようじんぶかい', '조심성이 많다', '用心(조심) + 深い(깊다)', 'い형용사', 353, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はとても用心深い性格だ。', '그는 매우 조심성이 많은 성격이다.', 1),
    (w, '用心深く周囲を見渡した。', '조심스럽게 주위를 살폈다.', 2);

  -- 354. 貴財団
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '貴財団', 'きざいだん', '귀재단', '貴(귀할 귀) + 財団(재단)', '명사', 354, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貴財団のご支援に感謝します。', '귀재단의 지원에 감사드립니다.', 1),
    (w, '貴財団の活動を尊敬しています。', '귀재단의 활동을 존경합니다.', 2);

  -- 355. 無回答
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '無回答', 'むかいとう', '무회답, 무응답', '無(없을 무) + 回答(회답)', '명사', 355, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'アンケートで無回答が多かった。', '설문에서 무응답이 많았다.', 1),
    (w, '無回答の項目はカウントしない。', '무응답 항목은 집계하지 않는다.', 2);

  -- 356. 日本風
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '日本風', 'にほんふう', '일본풍', '日本 + 風', '명사', 356, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本風の庭園を作った。', '일본풍의 정원을 만들었다.', 1),
    (w, '日本風のアレンジを加える。', '일본풍의 어레인지를 더한다.', 2);

  -- 357. 壁際
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '壁際', 'かべぎわ', '벽가, 벽 옆', '壁(벽) + 際(가)', '명사', 357, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '壁際に本棚を置いた。', '벽가에 책장을 두었다.', 1),
    (w, '壁際の席を予約した。', '벽 옆 자리를 예약했다.', 2);

  -- 358. 対抗心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '対抗心', 'たいこうしん', '대항심', '対抗(대항) + 心(마음)', '명사', 358, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼に強い対抗心を持っている。', '그에게 강한 대항심을 가지고 있다.', 1),
    (w, '対抗心がチームを成長させた。', '대항심이 팀을 성장시켰다.', 2);

  -- 359. 諸手続き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '諸手続き', 'しょてつづき', '여러 수속', '諸(여러 제) + 手続き(수속)', '명사', 359, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '引っ越しの諸手続きを終えた。', '이사의 여러 수속을 끝냈다.', 1),
    (w, '諸手続きが煩雑だ。', '여러 수속이 번잡하다.', 2);

  -- 360. 二人連れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '二人連れ', 'ふたりづれ', '두사람 일행', '二人 + 連れ(동반)', '명사', 360, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二人連れの女性が入店した。', '두 사람 일행 여성이 입점했다.', 1),
    (w, '二人連れの席を案内した。', '두 사람 일행의 자리를 안내했다.', 2);

  -- 361. 主原料
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '主原料', 'しゅげんりょう', '주원료', '主 + 原料(원료)', '명사', 361, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この製品の主原料は大豆だ。', '이 제품의 주원료는 콩이다.', 1),
    (w, '主原料の価格が高騰している。', '주원료의 가격이 급등하고 있다.', 2);

  -- 362. 読書離れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '読書離れ', 'どくしょばなれ', '독서 기피', '読書 + 離れ(떨어짐)', '명사', 362, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若者の読書離れが進んでいる。', '젊은이들의 독서 기피가 진행되고 있다.', 1),
    (w, '読書離れを食い止めたい。', '독서 기피를 막고 싶다.', 2);

  -- 363. 決定権
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '決定権', 'けっていけん', '결정권', '決定 + 権(권리 권)', '명사', 363, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最終的な決定権は社長にある。', '최종 결정권은 사장에게 있다.', 1),
    (w, '決定権を持つ人を呼ぶ。', '결정권을 가진 사람을 부른다.', 2);

  -- 364. 名選手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '名選手', 'めいせんしゅ', '명선수', '名(이름 명) + 選手(선수)', '명사', 364, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は伝説の名選手だ。', '그는 전설의 명선수다.', 1),
    (w, '名選手が引退を表明した。', '명선수가 은퇴를 표명했다.', 2);

  -- 365. 最接近
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '最接近', 'さいせっきん', '최접근', '最 + 接近(접근)', '명사', 365, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風が日本に最接近する。', '태풍이 일본에 최접근한다.', 1),
    (w, '最接近のタイミングを観測した。', '최접근 타이밍을 관측했다.', 2);

  -- 366. 私宛て
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '私宛て', 'わたしあて', '내 앞', '私 + 宛て(앞)', '명사', 366, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私宛ての荷物が届いた。', '내 앞으로 짐이 도착했다.', 1),
    (w, '私宛ての手紙を確認した。', '내 앞 편지를 확인했다.', 2);

  -- 367. のんびり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'のんびり', '한가로이', '의태어 (느긋한 모양)', '부사', 367, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '週末はのんびり過ごしたい。', '주말은 한가로이 보내고 싶다.', 1),
    (w, '温泉でのんびり休んだ。', '온천에서 한가로이 쉬었다.', 2);

  -- 368. 徐々に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '徐々に', 'じょじょに', '서서히', '徐(천천히 서): 천천히', '부사', 368, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気温が徐々に上がっている。', '기온이 서서히 올라가고 있다.', 1),
    (w, '徐々に体力が回復してきた。', '서서히 체력이 회복되고 있다.', 2);

  -- 369. マイペース
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'マイペース', '마이 페이스', '외래어 (자기만의 속도)', '명사', 369, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はマイペースで仕事を進める。', '그는 마이페이스로 일을 진행한다.', 1),
    (w, 'マイペースな性格は長所でもある。', '마이페이스인 성격은 장점이기도 하다.', 2);

  -- 370. 上昇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '上昇', 'じょうしょう', '상승', '上(위 상) + 昇(오를 승)', '명사', 370, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気温が上昇している。', '기온이 상승하고 있다.', 1),
    (w, '株価が上昇に転じた。', '주가가 상승으로 돌아섰다.', 2);

  -- 371. 評判
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '評判', 'ひょうばん', '평판', '評(평할 평) + 判(판단할 판)', '명사', 371, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この店は評判がいい。', '이 가게는 평판이 좋다.', 1),
    (w, '彼の評判は社内で高い。', '그의 평판은 사내에서 높다.', 2);

  -- 372. シーズン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'シーズン', '시즌', '외래어 (계절, 시기)', '명사', 372, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スキーシーズンが始まった。', '스키 시즌이 시작되었다.', 1),
    (w, 'シーズン中は混雑する。', '시즌 중에는 붐빈다.', 2);

  -- 373. 尽きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '尽きる', 'つきる', '다하다, 소진되다', '尽(다할 진): 모두 사용함', '동사', 373, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話題が尽きない楽しい時間だった。', '화제가 끊이지 않는 즐거운 시간이었다.', 1),
    (w, '力が尽きてしまった。', '힘이 다했다.', 2);

  -- 374. 温厚な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '温厚な', 'おんこうな', '온후한, 다정다감한', '温(따뜻할 온) + 厚(두터울 후)', 'な형용사', 374, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '温厚な人柄で慕われている。', '온후한 성격으로 사랑받고 있다.', 1),
    (w, '温厚な態度で対応する。', '온후한 태도로 대응한다.', 2);

  -- 375. 発揮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '発揮', 'はっき', '발휘', '発(필 발) + 揮(휘두를 휘)', '명사', 375, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実力を十分に発揮した。', '실력을 충분히 발휘했다.', 1),
    (w, '能力を発揮する場が必要だ。', '능력을 발휘할 무대가 필요하다.', 2);

  -- 376. 相次ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '相次ぐ', 'あいつぐ', '잇따르다, 이어지다', '相(서로 상) + 次ぐ(잇다)', '동사', 376, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が相次いで発生した。', '사고가 잇따라 발생했다.', 1),
    (w, '問題が相次ぎ対応に追われた。', '문제가 잇따라 대응에 쫓겼다.', 2);

  -- 377. あいまいな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あいまいな', '애매한', '의태어 (모호한 모양)', 'な형용사', 377, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あいまいな返事しかもらえなかった。', '애매한 대답밖에 받지 못했다.', 1),
    (w, 'あいまいな表現は誤解を招く。', '애매한 표현은 오해를 부른다.', 2);

  -- 378. 通じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '通じる', 'つうじる', '통하다', '通(통할 통): 길이 트임', '동사', 378, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼には英語が通じる。', '그에게는 영어가 통한다.', 1),
    (w, '心が通じ合う友人だ。', '마음이 통하는 친구다.', 2);

  -- 379. 有効
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '有効', 'ゆうこう', '유효', '有(있을 유) + 効(효과 효)', '명사', 379, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このパスポートは十年有効だ。', '이 여권은 10년 유효하다.', 1),
    (w, '時間を有効に使いたい。', '시간을 유효하게 쓰고 싶다.', 2);

  -- 380. 含む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '含む', 'ふくむ', '포함하다', '含(머금을 함): 입에 담음', '동사', 380, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '税を含む金額を表示する。', '세금을 포함한 금액을 표시한다.', 1),
    (w, '彼の発言は皮肉を含んでいる。', '그의 발언은 빈정거림을 담고 있다.', 2);

  -- 381. 解消
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '解消', 'かいしょう', '해소', '解(풀 해) + 消(사라질 소)', '명사', 381, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスを解消する方法を探す。', '스트레스를 해소할 방법을 찾는다.', 1),
    (w, '問題は完全に解消された。', '문제는 완전히 해소되었다.', 2);

  -- 382. ぶらぶら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぶらぶら', '어슬렁어슬렁', '의태어 (목적 없이 거니는 모양)', '부사', 382, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園をぶらぶら歩いた。', '공원을 어슬렁어슬렁 걸었다.', 1),
    (w, '週末はぶらぶら散歩する。', '주말에는 어슬렁어슬렁 산책한다.', 2);

  -- 383. 改善
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '改善', 'かいぜん', '개선', '改(고칠 개) + 善(착할 선)', '명사', 383, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境改善のために努力する。', '환경 개선을 위해 노력한다.', 1),
    (w, '業務プロセスを改善した。', '업무 프로세스를 개선했다.', 2);

  -- 384. 活気
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '活気', 'かっき', '활기', '活(살 활) + 気(기운 기)', '명사', 384, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '活気のある街が好きだ。', '활기 있는 거리를 좋아한다.', 1),
    (w, '彼女の登場で会場に活気が出た。', '그녀의 등장으로 회장에 활기가 돌았다.', 2);

  -- 385. 迫る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '迫る', 'せまる', '다가오다, 임박하다', '迫(닥칠 박): 가까이 다가옴', '동사', 385, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '締め切りが迫っている。', '마감이 임박해 있다.', 1),
    (w, '危険が刻々と迫る。', '위험이 시시각각 다가온다.', 2);

  -- 386. 詰まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '詰まる', 'つまる', '가득 차다, 막히다', '詰(꽂을 힐): 빽빽이 채움', '동사', 386, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '引き出しに服が詰まっている。', '서랍에 옷이 가득 차 있다.', 1),
    (w, '鼻が詰まって息苦しい。', '코가 막혀 숨이 답답하다.', 2);

  -- 387. 割と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '割と', 'わりと', '비교적', '割(나눌 할): 나누어 봤을 때 → 비교적', '부사', 387, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は割と暖かい。', '오늘은 비교적 따뜻하다.', 1),
    (w, '割とうまくいった。', '비교적 잘 풀렸다.', 2);

  -- 388. 反映
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '反映', 'はんえい', '반영', '反(돌이킬 반) + 映(비칠 영)', '명사', 388, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見を計画に反映させた。', '의견을 계획에 반영시켰다.', 1),
    (w, '時代の変化を反映している。', '시대의 변화를 반영하고 있다.', 2);

  -- 389. 視野
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '視野', 'しや', '시야', '視(볼 시) + 野(들 야)', '명사', 389, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広い視野で物事を考える。', '넓은 시야로 사물을 생각한다.', 1),
    (w, '経験が視野を広げた。', '경험이 시야를 넓혀 주었다.', 2);

  -- 390. ぼんやり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぼんやり', '희미하게, 멍하게', '의태어 (또렷하지 않은 모양)', '부사', 390, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼんやりと景色を眺めた。', '멍하니 풍경을 바라봤다.', 1),
    (w, 'ぼんやりして話を聞き逃した。', '멍하니 있다가 이야기를 놓쳤다.', 2);

  -- 391. さっぱり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'さっぱり', '전혀', '의태어 (말끔히, 전혀)', '부사', 391, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験の結果はさっぱりだった。', '시험 결과는 전혀 좋지 않았다.', 1),
    (w, '味がさっぱりしている。', '맛이 산뜻하다.', 2);

  -- 392. 強み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '強み', 'つよみ', '강점', '強(강할 강) + み(접미)', '명사', 392, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の強みは語学力だ。', '그의 강점은 어학력이다.', 1),
    (w, '強みを生かして仕事をする。', '강점을 살려 일을 한다.', 2);

  -- 393. 機能
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '機能', 'きのう', '기능', '機(틀 기) + 能(능할 능)', '명사', 393, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい機能が追加された。', '새로운 기능이 추가되었다.', 1),
    (w, 'この機械は多機能だ。', '이 기계는 다기능이다.', 2);

  -- 394. 散らかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '散らかる', 'ちらかる', '흩어지다, 어질러지다', '散(흩을 산): 흩어짐', '동사', 394, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋が散らかっている。', '방이 어질러져 있다.', 1),
    (w, '物が散らかったままだ。', '물건이 흩어진 채다.', 2);

  -- 395. 偏る/片寄る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '偏る/片寄る', 'かたよる/かたよる', '치우치다, 편중되다', '偏(치우칠 편): 한쪽으로 기움', '동사', 395, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '栄養が偏らないように食べる。', '영양이 치우치지 않도록 먹는다.', 1),
    (w, '意見が一方に偏っている。', '의견이 한쪽에 치우쳐 있다.', 2);

  -- 396. 辞退
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '辞退', 'じたい', '사퇴', '辞(말씀 사) + 退(물러날 퇴)', '명사', 396, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '賞の辞退を申し出た。', '상의 사퇴를 표명했다.', 1),
    (w, '出馬を辞退した。', '출마를 사퇴했다.', 2);

  -- 397. 着々と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '着々と', 'ちゃくちゃくと', '착착, 순조롭게', '着(붙을 착): 차곡차곡 진행', '부사', 397, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画は着々と進んでいる。', '계획은 착착 진행되고 있다.', 1),
    (w, '準備が着々と整っている。', '준비가 착착 진행되고 있다.', 2);

  -- 398. 得る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '得る', 'える', '얻다', '得(얻을 득): 손에 넣음', '동사', 398, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貴重な経験を得た。', '귀중한 경험을 얻었다.', 1),
    (w, '信頼を得るのは難しい。', '신뢰를 얻는 것은 어렵다.', 2);

  -- 399. いらいらする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いらいらする', '초조해하다', '의태어 (안절부절못하는 모양)', '동사', 399, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅刻するかもとイライラした。', '지각할까 봐 초조해졌다.', 1),
    (w, '待たされてイライラする。', '기다리게 되어 짜증이 난다.', 2);

  -- 400. ぐち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぐち', '푸념, 넋두리', '의성/의태어 → 불평', '명사', 400, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は仕事のぐちばかり言う。', '그는 일 푸념만 늘어놓는다.', 1),
    (w, '友達にぐちを聞いてもらった。', '친구에게 푸념을 들어 달라고 했다.', 2);

  -- 401. 改正
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '改正', 'かいせい', '개정', '改(고칠 개) + 正(바를 정)', '명사', 401, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '法律が改正された。', '법률이 개정되었다.', 1),
    (w, '規則の改正案を検討する。', '규칙 개정안을 검토한다.', 2);

  -- 402. 場面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '場面', 'ばめん', '장면', '場(마당 장) + 面(낯 면)', '명사', 402, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画の感動的な場面に泣いた。', '영화의 감동적인 장면에 울었다.', 1),
    (w, '大事な場面で実力を発揮する。', '중요한 장면에서 실력을 발휘한다.', 2);

  -- 403. 夢中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '夢中', 'むちゅう', '열중', '夢(꿈 몽) + 中(가운데 중) → 꿈속에 빠진 듯 몰두', '명사', 403, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供はゲームに夢中だ。', '아이는 게임에 열중해 있다.', 1),
    (w, '趣味に夢中になる時間が幸せだ。', '취미에 몰두하는 시간이 행복하다.', 2);

  -- 404. 成長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '成長', 'せいちょう', '성장', '成(이룰 성) + 長(길 장)', '명사', 404, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の成長は早い。', '아이의 성장은 빠르다.', 1),
    (w, '経済成長が著しい。', '경제 성장이 두드러진다.', 2);

  -- 405. ごろごろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ごろごろ', '데굴데굴, 뒹굴뒹굴', '의태어 (구르는 모양)', '부사', 405, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休日は家でごろごろしている。', '휴일에는 집에서 뒹굴거리고 있다.', 1),
    (w, '石が坂をごろごろ転がる。', '돌이 비탈을 데굴데굴 굴렀다.', 2);

  -- 406. 適度な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '適度な', 'てきどな', '적당한, 알맞은', '適(맞을 적) + 度(법도 도)', 'な형용사', 406, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '適度な運動は健康にいい。', '적당한 운동은 건강에 좋다.', 1),
    (w, '適度な距離感を保つ。', '적당한 거리감을 유지한다.', 2);

  -- 407. 呼び止める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '呼び止める', 'よびとめる', '불러 세우다', '呼び(부름) + 止める(멈추다)', '동사', 407, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '警官に呼び止められた。', '경찰관에게 불러 세워졌다.', 1),
    (w, '歩いている人を呼び止めて道を聞いた。', '걷고 있는 사람을 불러 세워 길을 물었다.', 2);

  -- 408. 中継
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '中継', 'ちゅうけい', '중계', '中(가운데 중) + 継(이을 계)', '명사', 408, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合がテレビで中継される。', '시합이 텔레비전으로 중계된다.', 1),
    (w, '生中継で現場の様子を伝えた。', '생중계로 현장 상황을 전했다.', 2);

  -- 409. 解散
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '解散', 'かいさん', '해산', '解(풀 해) + 散(흩을 산)', '명사', 409, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は予定より早く解散した。', '회의는 예정보다 일찍 해산했다.', 1),
    (w, 'グループの解散が発表された。', '그룹의 해산이 발표되었다.', 2);

  -- 410. ぜいたくな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぜいたくな', '사치스러운', '외래형 어휘 (사치)', 'な형용사', 410, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜいたくな食事を楽しんだ。', '사치스러운 식사를 즐겼다.', 1),
    (w, 'たまにはぜいたくな旅行もいい。', '가끔은 사치스러운 여행도 좋다.', 2);

  -- 411. スムーズに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'スムーズに', 'スムーズに', '부드럽게', '외래어 (smoothly)', '부사', 411, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議はスムーズに進行した。', '회의는 부드럽게 진행되었다.', 1),
    (w, '手続きをスムーズに済ませた。', '절차를 부드럽게 마쳤다.', 2);

  -- 412. 見当がつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '見当がつく', 'けんとうがつく', '짐작이 가다', '見当(짐작) + つく(붙다)', '관용구', 412, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犯人の見当がついた。', '범인이 짐작이 갔다.', 1),
    (w, 'だいたいの量の見当がつく。', '대략의 양이 짐작이 간다.', 2);

  -- 413. つらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'つらい', '괴롭다, 힘들다', '상태/감정 형용사', 'い형용사', 413, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失恋がつらかった。', '실연이 괴로웠다.', 1),
    (w, 'つらい時こそ笑顔でいたい。', '힘들 때일수록 웃고 싶다.', 2);

  -- 414. すっきり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'すっきり', '산뜻하게, 후련하게', '의태어 (개운한 모양)', '부사', 414, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お風呂に入ってすっきりした。', '목욕을 해서 개운해졌다.', 1),
    (w, '部屋を片付けて気分がすっきりした。', '방을 정리해서 기분이 후련해졌다.', 2);

  -- 415. 意欲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '意欲', 'いよく', '의욕', '意(뜻 의) + 欲(하고자할 욕)', '명사', 415, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は仕事への意欲が高い。', '그는 일에 대한 의욕이 높다.', 1),
    (w, '学習意欲を引き出す。', '학습 의욕을 끌어낸다.', 2);

  -- 416. 比例
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '比例', 'ひれい', '비례', '比(견줄 비) + 例(법식 례)', '명사', 416, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '努力と成果は比例する。', '노력과 성과는 비례한다.', 1),
    (w, '給料は経験年数に比例する。', '급여는 경험 연수에 비례한다.', 2);

  -- 417. 専念
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '専念', 'せんねん', '전념', '専(오로지 전) + 念(생각 념)', '명사', 417, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強に専念したい。', '공부에 전념하고 싶다.', 1),
    (w, '彼は研究に専念している。', '그는 연구에 전념하고 있다.', 2);

  -- 418. つまずく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'つまずく', '걸려 넘어지다, 좌절하다', '자동사 (넘어짐)', '동사', 418, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '階段でつまずいて転んだ。', '계단에서 걸려 넘어졌다.', 1),
    (w, '人生の最初の壁につまずいた。', '인생의 첫 벽에 좌절했다.', 2);

  -- 419. 格好
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '格好', 'かっこう', '모습, 모양', '格(격식 격) + 好(좋을 호)', '명사', 419, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の格好はおしゃれだ。', '그의 모습은 멋지다.', 1),
    (w, '動きやすい格好で出かけた。', '움직이기 편한 모양으로 외출했다.', 2);

  -- 420. あいにく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あいにく', '공교롭게도', '관용 부사', '부사', 420, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あいにく今日は雨だ。', '공교롭게도 오늘은 비가 온다.', 1),
    (w, 'あいにく予約はいっぱいです。', '공교롭게도 예약이 다 찼습니다.', 2);

  -- 421. 腹を立てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '腹を立てる', 'はらをたてる', '화를 내다', '腹(배) + 立てる(세우다)', '관용구', 421, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はちょっとしたことで腹を立てる。', '그는 사소한 일에 화를 낸다.', 1),
    (w, '友達の言葉に腹を立てた。', '친구의 말에 화를 냈다.', 2);

  -- 422. 思いきって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '思いきって', 'おもいきって', '과감하게', '思い(생각) + 切る(자름)', '부사', 422, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思いきって新しいことに挑戦した。', '과감하게 새로운 일에 도전했다.', 1),
    (w, '思いきって意見を言った。', '과감하게 의견을 말했다.', 2);

  -- 423. 導入
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '導入', 'どうにゅう', '도입', '導(인도할 도) + 入(들 입)', '명사', 423, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいシステムを導入した。', '새 시스템을 도입했다.', 1),
    (w, '最新技術の導入を決定した。', '최신 기술 도입을 결정했다.', 2);

  -- 424. 訂正
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '訂正', 'ていせい', '정정', '訂(바로잡을 정) + 正(바를 정)', '명사', 424, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '発言の訂正を求められた。', '발언의 정정을 요구받았다.', 1),
    (w, '誤りを訂正して提出した。', '오류를 정정해 제출했다.', 2);

  -- 425. やかましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'やかましい', '시끄럽다', '시끄러운 모양 형용사', 'い형용사', 425, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供がやかましくて寝られない。', '아이가 시끄러워 잘 수가 없다.', 1),
    (w, '近所の工事がやかましい。', '이웃의 공사가 시끄럽다.', 2);

  -- 426. 目指す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '目指す', 'めざす', '지향하다, 목표로 하다', '目(눈) + 指す(가리키다)', '동사', 426, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロを目指して練習する。', '프로를 목표로 연습한다.', 1),
    (w, '優勝を目指して頑張る。', '우승을 지향해 노력한다.', 2);

  -- 427. パンク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'パンク', '펑크', '외래어 (puncture)', '명사', 427, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タイヤがパンクしてしまった。', '타이어가 펑크나고 말았다.', 1),
    (w, 'パンク修理に時間がかかった。', '펑크 수리에 시간이 걸렸다.', 2);

  -- 428. 一気に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一気に', 'いっきに', '단숨에, 단번에', '一(하나) + 気(기운)', '부사', 428, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水を一気に飲み干した。', '물을 단숨에 들이켰다.', 1),
    (w, '問題を一気に解決した。', '문제를 단번에 해결했다.', 2);

  -- 429. あらかじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あらかじめ', '미리', '관용 부사', '부사', 429, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の資料はあらかじめ送ってください。', '회의 자료는 미리 보내 주세요.', 1),
    (w, 'あらかじめ準備しておいた。', '미리 준비해 두었다.', 2);

  -- 430. 蓄える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '蓄える', 'たくわえる', '저축하다, 비축하다', '蓄(쌓을 축): 모아 둠', '동사', 430, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '老後のためにお金を蓄えている。', '노후를 위해 돈을 모으고 있다.', 1),
    (w, '非常用の食料を蓄える。', '비상용 식량을 비축한다.', 2);

  -- 431. 体格
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '体格', 'たいかく', '체격', '体(몸 체) + 格(격식 격)', '명사', 431, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はがっしりした体格だ。', '그는 단단한 체격이다.', 1),
    (w, '体格に合った服を選ぶ。', '체격에 맞는 옷을 고른다.', 2);

  -- 432. リラックスする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'リラックスする', 'リラックスする', '긴장을 풀다', '외래어 (relax)', '동사', 432, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聴いてリラックスする。', '음악을 듣고 긴장을 푼다.', 1),
    (w, 'お風呂に入ってリラックスした。', '목욕을 해서 긴장을 풀었다.', 2);

  -- 433. 差し支える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '差し支える', 'さしつかえる', '지장이 있다', '差し(들이밀다) + 支える(지장이 됨)', '동사', 433, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日の予定に差し支える。', '내일 일정에 지장이 있다.', 1),
    (w, '差し支えなければお名前を教えてください。', '괜찮으시면 성함을 알려 주세요.', 2);

  -- 434. うとうと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'うとうと', '꾸벅꾸벅(조는 모양)', '의태어 (조는 모양)', '부사', 434, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車の中でうとうとした。', '전철 안에서 꾸벅꾸벅 졸았다.', 1),
    (w, '退屈な授業でうとうとしてしまった。', '지루한 수업에 꾸벅꾸벅 졸고 말았다.', 2);

  -- 435. 特色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '特色', 'とくしょく', '특색', '特(특별 특) + 色(빛 색)', '명사', 435, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地域の特色を生かした商品だ。', '지역의 특색을 살린 상품이다.', 1),
    (w, '彼の作品には独自の特色がある。', '그의 작품에는 독자적인 특색이 있다.', 2);

  -- 436. 予測
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '予測', 'よそく', '예측', '予(미리 예) + 測(헤아릴 측)', '명사', 436, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天気の予測は難しい。', '날씨의 예측은 어렵다.', 1),
    (w, '売上を予測して計画を立てる。', '매출을 예측하고 계획을 세운다.', 2);

  -- 437. びっしょり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'びっしょり', '흠뻑(완전히 젖은 모양)', '의태어 (흠뻑 젖은 모양)', '부사', 437, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨でびっしょり濡れた。', '비로 흠뻑 젖었다.', 1),
    (w, '汗びっしょりで運動した。', '땀으로 흠뻑 젖어 운동했다.', 2);

  -- 438. 濁る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '濁る', 'にごる', '흐려지다, 탁해지다', '濁(흐릴 탁): 물이 흐려짐', '동사', 438, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川の水が濁っている。', '강물이 탁해져 있다.', 1),
    (w, '空気が濁った都市は息苦しい。', '공기가 탁해진 도시는 답답하다.', 2);

  -- 439. 輝かしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '輝かしい', 'かがやかしい', '빛나다, 눈부시다', '輝(빛날 휘): 빛이 발함', 'い형용사', 439, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '輝かしい未来を信じている。', '눈부신 미래를 믿고 있다.', 1),
    (w, '彼女は輝かしい経歴の持ち主だ。', '그녀는 빛나는 경력의 소유자다.', 2);

  -- 440. 完了
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '完了', 'かんりょう', '완료', '完(완전할 완) + 了(마칠 료)', '명사', 440, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作業はすでに完了した。', '작업은 이미 완료되었다.', 1),
    (w, '支払いの完了を確認する。', '결제 완료를 확인한다.', 2);

  -- 441. 面する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '面する', 'めんする', '면하다, 마주 대하다', '面(낯 면): 얼굴을 향함', '동사', 441, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '海に面した部屋に泊まった。', '바다에 면한 방에 묵었다.', 1),
    (w, '問題に正面から面する。', '문제에 정면으로 마주한다.', 2);

  -- 442. バランス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'バランス', '밸런스, 균형', '외래어 (balance)', '명사', 442, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事と生活のバランスが大切だ。', '일과 생활의 균형이 중요하다.', 1),
    (w, '栄養のバランスを考える。', '영양의 균형을 생각한다.', 2);

  -- 443. 鋭い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '鋭い', 'するどい', '날카롭다, 예리하다', '鋭(날카로울 예): 끝이 뾰족함', 'い형용사', 443, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鋭いナイフで切る。', '날카로운 칼로 자른다.', 1),
    (w, '彼の指摘は鋭い。', '그의 지적은 예리하다.', 2);

  -- 444. たっぷり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'たっぷり', '듬뿍', '의태어 (가득한 모양)', '부사', 444, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クリームをたっぷり塗った。', '크림을 듬뿍 발랐다.', 1),
    (w, '時間がたっぷりある。', '시간이 듬뿍 있다.', 2);

  -- 445. デザイン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'デザイン', '디자인', '외래어 (design)', '명사', 445, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいデザインを考えた。', '새로운 디자인을 생각했다.', 1),
    (w, 'シンプルなデザインが好きだ。', '심플한 디자인을 좋아한다.', 2);

  -- 446. 相違
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '相違', 'そうい', '다름, 틀림', '相(서로 상) + 違(어긋날 위)', '명사', 446, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見に相違がある。', '의견에 차이가 있다.', 1),
    (w, '事実との相違を確認した。', '사실과의 차이를 확인했다.', 2);

  -- 447. 時間を潰す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '時間を潰す', 'じかんをつぶす', '시간을 때우다, 시간을 보내다', '時間 + 潰す(부수다, 소비하다)', '관용구', 447, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '待ち時間に本を読んで時間を潰した。', '대기 시간에 책을 읽으며 시간을 때웠다.', 1),
    (w, '駅前のカフェで時間を潰す。', '역 앞 카페에서 시간을 보낸다.', 2);

  -- 448. 安易な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '安易な', 'あんいな', '안이한', '安(편안할 안) + 易(쉬울 이)', 'な형용사', 448, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安易な決断は危険だ。', '안이한 결단은 위험하다.', 1),
    (w, '安易な考え方を改める。', '안이한 사고방식을 고친다.', 2);

  -- 449. 提供
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '提供', 'ていきょう', '제공', '提(끌 제) + 供(이바지할 공)', '명사', 449, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無料で情報を提供する。', '무료로 정보를 제공한다.', 1),
    (w, '最高のサービスを提供したい。', '최고의 서비스를 제공하고 싶다.', 2);

  -- 450. ぐったり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぐったり', '매우 지친 모습', '의태어 (축 늘어진 모양)', '부사', 450, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事でぐったり疲れた。', '일로 녹초가 되었다.', 1),
    (w, '犬が暑さでぐったりしている。', '개가 더위에 축 늘어져 있다.', 2);

  -- 451. ショック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ショック', '쇼크, 충격', '외래어 (shock)', '명사', 451, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ニュースを聞いてショックを受けた。', '뉴스를 듣고 충격을 받았다.', 1),
    (w, '失敗のショックから立ち直る。', '실패의 충격에서 회복한다.', 2);

  -- 452. 普及
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '普及', 'ふきゅう', '보급', '普(넓을 보) + 及(미칠 급)', '명사', 452, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インターネットが普及した。', '인터넷이 보급되었다.', 1),
    (w, '新技術の普及が進む。', '신기술의 보급이 진행된다.', 2);

  -- 453. じゃま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'じゃま', '방해', '관용 명사 (방해)', '명사', 453, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の話の途中でじゃまをした。', '그의 말 도중에 방해를 했다.', 1),
    (w, '勉強のじゃまをしないで。', '공부에 방해하지 마.', 2);

  -- 454. 引き止める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '引き止める', 'ひきとめる', '만류하다, 제지하다', '引き(끌어) + 止める(멈추다)', '동사', 454, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞めようとした彼を引き止めた。', '그만두려던 그를 만류했다.', 1),
    (w, 'お客様を強引に引き止めるのは失礼だ。', '손님을 강하게 만류하는 것은 실례다.', 2);

  -- 455. なだらかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'なだらかな', '완만한', '관용 형용사 (완만함)', 'な형용사', 455, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なだらかな丘を散歩した。', '완만한 언덕을 산책했다.', 1),
    (w, 'なだらかな坂道が続く。', '완만한 비탈길이 이어진다.', 2);

  -- 456. リーダー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'リーダー', '리더, 지도자', '외래어 (leader)', '명사', 456, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はチームのリーダーだ。', '그는 팀의 리더다.', 1),
    (w, '良いリーダーは部下を育てる。', '좋은 리더는 부하를 길러 낸다.', 2);

  -- 457. 活発な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '活発な', 'かっぱつな', '활발한', '活(살 활) + 発(필 발)', 'な형용사', 457, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は活発な性格だ。', '그녀는 활발한 성격이다.', 1),
    (w, '活発な議論が交わされた。', '활발한 논의가 오갔다.', 2);

  -- 458. 頼もしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頼もしい', 'たのもしい', '믿음직하다', '頼(의지할 뢰)', 'い형용사', 458, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は頼もしい仲間だ。', '그는 믿음직한 동료다.', 1),
    (w, '頼もしい後輩が入ってきた。', '믿음직한 후배가 들어왔다.', 2);

  -- 459. 割り込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '割り込む', 'わりこむ', '끼어들다', '割(나눌 할) + 込む(들어가다)', '동사', 459, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '列に割り込まないでください。', '줄에 끼어들지 마세요.', 1),
    (w, '話の途中に割り込んできた。', '이야기 도중에 끼어들었다.', 2);

  -- 460. おだやかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おだやかな', '온화한', '관용 형용사 (온화함)', 'な형용사', 460, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おだやかな天気が続く。', '온화한 날씨가 이어진다.', 1),
    (w, '彼女はおだやかな性格だ。', '그녀는 온화한 성격이다.', 2);

  -- 461. 確保
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '確保', 'かくほ', '확보', '確(굳을 확) + 保(보전할 보)', '명사', 461, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '席を確保した。', '자리를 확보했다.', 1),
    (w, '資金の確保が課題だ。', '자금 확보가 과제다.', 2);

  -- 462. アピール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'アピール', '어필, 호소', '외래어 (appeal)', '명사', 462, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分の長所をアピールした。', '자신의 장점을 어필했다.', 1),
    (w, '商品の魅力をアピールする。', '상품의 매력을 어필한다.', 2);

  -- 463. 悔やむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '悔やむ', 'くやむ', '분하게 여기다, 후회하다', '悔(뉘우칠 회)', '동사', 463, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去の選択を悔やんでいる。', '과거의 선택을 후회하고 있다.', 1),
    (w, '彼の死を心から悔やんだ。', '그의 죽음을 진심으로 애도했다.', 2);

  -- 464. 契機
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '契機', 'けいき', '계기', '契(맺을 계) + 機(기틀 기)', '명사', 464, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '留学が成長の契機になった。', '유학이 성장의 계기가 되었다.', 1),
    (w, '事件を契機に意識が変わった。', '사건을 계기로 의식이 바뀌었다.', 2);

  -- 465. ひそひそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ひそひそ', '소근소근', '의태어 (속삭이는 모양)', '부사', 465, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教室でひそひそ話をする。', '교실에서 소근소근 이야기를 한다.', 1),
    (w, '彼らはひそひそと相談している。', '그들은 소근소근 상의하고 있다.', 2);

  -- 466. 苦情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '苦情', 'くじょう', '불평, 클레임', '苦(괴로울 고) + 情(뜻 정)', '명사', 466, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お客様から苦情があった。', '손님으로부터 불평이 있었다.', 1),
    (w, '苦情に丁寧に対応する。', '클레임에 정중히 대응한다.', 2);

  -- 467. 名所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '名所', 'めいしょ', '명소', '名(이름 명) + 所(곳 소)', '명사', 467, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都には名所がたくさんある。', '교토에는 명소가 많이 있다.', 1),
    (w, '地元の名所を案内した。', '현지 명소를 안내했다.', 2);

  -- 468. ぎりぎり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぎりぎり', '아슬아슬', '의태어 (한계 모양)', '부사', 468, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '締め切りぎりぎりに提出した。', '마감 직전에 제출했다.', 1),
    (w, '時間ぎりぎりで間に合った。', '시간 아슬아슬하게 늦지 않았다.', 2);

  -- 469. 有利な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '有利な', 'ゆうりな', '유리한', '有(있을 유) + 利(이로울 리)', 'な형용사', 469, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼に有利な状況だ。', '그에게 유리한 상황이다.', 1),
    (w, '有利な条件で契約した。', '유리한 조건으로 계약했다.', 2);

  -- 470. 打ち消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '打ち消す', 'うちけす', '부정하다', '打ち(때림) + 消す(지움)', '동사', 470, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '噂を打ち消すコメントを出した。', '소문을 부정하는 코멘트를 냈다.', 1),
    (w, '彼は疑惑を打ち消した。', '그는 의혹을 부정했다.', 2);

  -- 471. そそっかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'そそっかしい', '경솔하다', '관용 형용사 (덤벙대는 모양)', 'い형용사', 471, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はそそっかしい性格だ。', '그는 덤벙대는 성격이다.', 1),
    (w, 'そそっかしくて忘れ物が多い。', '덤벙대서 분실물이 많다.', 2);

  -- 472. アレンジ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'アレンジ', '어레인지, 각색', '외래어 (arrange)', '명사', 472, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理を独自にアレンジした。', '요리를 독자적으로 어레인지했다.', 1),
    (w, '曲を新しくアレンジする。', '곡을 새롭게 편곡한다.', 2);

  -- 473. 独特
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '独特', 'どくとく', '독특', '独(홀로 독) + 特(특별 특)', '명사', 473, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '独特の味わいがある。', '독특한 맛이 있다.', 1),
    (w, '彼は独特の感性を持っている。', '그는 독특한 감성을 가지고 있다.', 2);

  -- 474. 欠かす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '欠かす', 'かかす', '빠뜨리다', '欠(이지러질 결): 부족하게 함', '동사', 474, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日の運動を欠かさない。', '매일의 운동을 거르지 않는다.', 1),
    (w, '毎朝のコーヒーは欠かせない。', '매일 아침 커피는 빠뜨릴 수 없다.', 2);

  -- 475. でたらめに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'でたらめに', '아무렇게나', 'でたらめ(엉터리)', '부사', 475, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'でたらめに答えてはいけない。', '아무렇게나 대답해서는 안 된다.', 1),
    (w, 'でたらめに数字を入れた。', '아무렇게나 숫자를 넣었다.', 2);

  -- 476. 達する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '達する', 'たっする', '도달하다, 이르다', '達(통달할 달): 다다름', '동사', 476, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目標金額に達した。', '목표 금액에 도달했다.', 1),
    (w, '彼は天才の域に達している。', '그는 천재의 경지에 달해 있다.', 2);

  -- 477. スペース
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'スペース', '스페이스, 공간', '외래어 (space)', '명사', 477, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋にスペースを作った。', '방에 공간을 만들었다.', 1),
    (w, '駐車スペースが足りない。', '주차 공간이 부족하다.', 2);

  -- 478. 点検
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '点検', 'てんけん', '점검', '点(점 점) + 検(검사할 검)', '명사', 478, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車の定期点検を受けた。', '차의 정기 점검을 받았다.', 1),
    (w, '安全点検を毎月行う。', '안전 점검을 매월 실시한다.', 2);

  -- 479. にっこり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'にっこり', '생긋, 방긋', '의태어 (방긋 웃는 모양)', '부사', 479, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女はにっこり微笑んだ。', '그녀는 방긋 미소 지었다.', 1),
    (w, '子供がにっこり笑った。', '아이가 생긋 웃었다.', 2);

  -- 480. 続出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '続出', 'ぞくしゅつ', '속출', '続(이을 속) + 出(날 출)', '명사', 480, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'けが人が続出した。', '부상자가 속출했다.', 1),
    (w, '苦情が続出している。', '불평이 속출하고 있다.', 2);

  -- 481. 飛び散る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '飛び散る', 'とびちる', '사방에 흩날리다', '飛び(날다) + 散る(흩어지다)', '동사', 481, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '花びらが風に飛び散る。', '꽃잎이 바람에 흩날린다.', 1),
    (w, '水しぶきが飛び散った。', '물보라가 사방에 튀었다.', 2);

  -- 482. 敏感
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '敏感', 'びんかん', '민감', '敏(민첩할 민) + 感(느낄 감)', '명사', 482, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は流行に敏感だ。', '그녀는 유행에 민감하다.', 1),
    (w, '肌が敏感で化粧品を選ぶ。', '피부가 민감해 화장품을 고른다.', 2);

  -- 483. プレッシャー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'プレッシャー', '프레셔, 압력', '외래어 (pressure)', '명사', 483, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験前はプレッシャーが大きい。', '시험 전에는 부담이 크다.', 1),
    (w, 'プレッシャーに負けないで頑張れ。', '압박에 지지 말고 힘내.', 2);

  -- 484. 不安定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '不安定', 'ふあんてい', '불안정', '不(아닐 부) + 安定(안정)', '명사', 484, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済が不安定な時期だ。', '경제가 불안정한 시기다.', 1),
    (w, '不安定な天気が続く。', '불안정한 날씨가 이어진다.', 2);

  -- 485. おとろえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おとろえる', '쇠퇴하다', '衰(쇠할 쇠)', '동사', 485, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体力が年々おとろえる。', '체력이 해마다 쇠퇴한다.', 1),
    (w, '王国が次第におとろえた。', '왕국이 점차 쇠퇴했다.', 2);

  -- 486. 分担
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '分担', 'ぶんたん', '분담', '分(나눌 분) + 担(멜 담)', '명사', 486, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家事を夫婦で分担する。', '집안일을 부부가 분담한다.', 1),
    (w, '責任を分担して取り組む。', '책임을 분담해 임한다.', 2);

  -- 487. ふさわしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ふさわしい', '어울리다', '관용 형용사 (적합함)', 'い형용사', 487, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼にふさわしい役だ。', '그에게 어울리는 역할이다.', 1),
    (w, '場にふさわしい服装を選ぶ。', '장소에 어울리는 복장을 고른다.', 2);

  -- 488. 本物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '本物', 'ほんもの', '진짜, 실물', '本(근본 본) + 物(물건 물)', '명사', 488, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは本物の絵画だ。', '이것은 진짜 그림이다.', 1),
    (w, '本物の宝石を初めて見た。', '진짜 보석을 처음 봤다.', 2);

  -- 489. あこがれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あこがれ', '동경, 그리움', '관용 명사 (동경)', '명사', 489, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '海外生活へのあこがれが強い。', '해외 생활에 대한 동경이 강하다.', 1),
    (w, '子供の頃のあこがれの職業だ。', '어릴 적 동경했던 직업이다.', 2);

  -- 490. 転勤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '転勤', 'てんきん', '전근', '転(구를 전) + 勤(일할 근)', '명사', 490, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父の転勤で引っ越す。', '아버지의 전근으로 이사한다.', 1),
    (w, '転勤が決まって忙しい。', '전근이 결정돼 바쁘다.', 2);

  -- 491. 栽培
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '栽培', 'さいばい', '재배', '栽(심을 재) + 培(북돋울 배)', '명사', 491, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '庭で野菜を栽培している。', '뜰에서 채소를 재배하고 있다.', 1),
    (w, 'イチゴ栽培に挑戦した。', '딸기 재배에 도전했다.', 2);

  -- 492. うなずく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'うなずく', '수긍하다, (고개를)끄덕이다', '관용 동사 (끄덕임)', '동사', 492, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の意見にうなずいた。', '그의 의견에 수긍했다.', 1),
    (w, '子供は静かにうなずいた。', '아이는 조용히 끄덕였다.', 2);

  -- 493. ごちゃごちゃ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ごちゃごちゃ', '어수선하게, 너저분하게', '의태어 (어수선한 모양)', '부사', 493, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋がごちゃごちゃしている。', '방이 너저분하다.', 1),
    (w, '話がごちゃごちゃして分かりにくい。', '이야기가 어수선해 알기 어렵다.', 2);

  -- 494. 評価
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '評価', 'ひょうか', '평가', '評(평할 평) + 価(값 가)', '명사', 494, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成果が高く評価された。', '성과가 높이 평가되었다.', 1),
    (w, '彼の能力を評価している。', '그의 능력을 평가하고 있다.', 2);

  -- 495. 尊重
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '尊重', 'そんちょう', '존중', '尊(높을 존) + 重(무거울 중)', '명사', 495, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お互いを尊重することが大切だ。', '서로를 존중하는 것이 중요하다.', 1),
    (w, '個人の選択を尊重したい。', '개인의 선택을 존중하고 싶다.', 2);

  -- 496. ターゲット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ターゲット', '타겟, 핵심 고객층', '외래어 (target)', '명사', 496, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品のターゲットは若者だ。', '상품의 타겟은 젊은이다.', 1),
    (w, '新しいターゲット層を開拓する。', '새 타겟층을 개척한다.', 2);

  -- 497. 気配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '気配', 'けはい', '기미, 분위기', '気(기운) + 配(나눌 배)', '명사', 497, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人の気配を感じた。', '사람의 기척을 느꼈다.', 1),
    (w, '春の気配がする。', '봄기운이 난다.', 2);

  -- 498. いいかげんな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いいかげんな', '무책임한', 'いいかげん (적당함)', 'な형용사', 498, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいかげんな仕事は許されない。', '무책임한 일은 용납되지 않는다.', 1),
    (w, 'いいかげんな返事は失礼だ。', '건성으로 하는 대답은 실례다.', 2);

  -- 499. タイミング
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'タイミング', '타이밍, 적절한 순간', '외래어 (timing)', '명사', 499, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タイミングが悪くて失敗した。', '타이밍이 나빠서 실패했다.', 1),
    (w, '絶妙なタイミングで決めた。', '절묘한 타이밍에 결정했다.', 2);

  -- 500. 気軽に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '気軽に', 'きがるに', '부담 없이', '気(기운) + 軽い(가벼움)', '부사', 500, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気軽にご相談ください。', '부담 없이 상담해 주세요.', 1),
    (w, '気軽に立ち寄れる店だ。', '부담 없이 들를 수 있는 가게다.', 2);

  -- 501. 添付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '添付', 'てんぷ', '첨부', '添(더할 첨) + 付(붙일 부)', '명사', 501, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料を添付してメールを送った。', '자료를 첨부해 메일을 보냈다.', 1),
    (w, '写真を添付してください。', '사진을 첨부해 주세요.', 2);

  -- 502. じろじろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'じろじろ', '빤히, 뚫어지게', '의태어 (응시하는 모양)', '부사', 502, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人をじろじろ見るのは失礼だ。', '사람을 빤히 보는 것은 실례다.', 1),
    (w, '子供がじろじろ見ていた。', '아이가 뚫어지게 보고 있었다.', 2);

  -- 503. 限界
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '限界', 'げんかい', '한계', '限(한계 한) + 界(경계 계)', '명사', 503, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体力の限界に達した。', '체력의 한계에 도달했다.', 1),
    (w, '限界を超えた挑戦をした。', '한계를 넘는 도전을 했다.', 2);

  -- 504. 固める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '固める', 'かためる', '굳히다', '固(굳을 고): 단단하게 함', '동사', 504, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決意を固めた。', '결의를 굳혔다.', 1),
    (w, '地盤を固める工事をした。', '지반을 다지는 공사를 했다.', 2);

  -- 505. 解約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '解約', 'かいやく', '해약', '解(풀 해) + 約(맺을 약)', '명사', 505, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '契約を解約した。', '계약을 해약했다.', 1),
    (w, '会員を解約する手続きをした。', '회원을 해약하는 절차를 했다.', 2);

  -- 506. ニーズ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ニーズ', '니즈, 요구', '외래어 (needs)', '명사', 506, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お客様のニーズに応える。', '고객의 니즈에 부응한다.', 1),
    (w, '時代のニーズが変化している。', '시대의 니즈가 변화하고 있다.', 2);

  -- 507. 開設
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '開設', 'かいせつ', '개설', '開(열 개) + 設(베풀 설)', '명사', 507, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい支店を開設した。', '새 지점을 개설했다.', 1),
    (w, 'アカウントの開設手続きをした。', '계정 개설 수속을 했다.', 2);

  -- 508. 雇う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '雇う', 'やとう', '고용하다', '雇(품 살 고): 사람을 부림', '동사', 508, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいスタッフを雇った。', '새 직원을 고용했다.', 1),
    (w, 'アルバイトを雇うことにした。', '아르바이트를 고용하기로 했다.', 2);

  -- 509. 思いきる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '思いきる', 'おもいきる', '결심하다', '思い + 切る(끊다)', '동사', 509, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転職を思いきった。', '전직을 결심했다.', 1),
    (w, '彼は思いきって発言した。', '그는 과감히 발언했다.', 2);

  -- 510. 交渉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '交渉', 'こうしょう', '교섭', '交(사귈 교) + 渉(건널 섭)', '명사', 510, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格について交渉した。', '가격에 대해 교섭했다.', 1),
    (w, '条件の交渉が長引いた。', '조건 교섭이 길어졌다.', 2);

  -- 511. クリア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'クリア', '클리어, 해결', '외래어 (clear)', '명사', 511, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい課題をクリアした。', '어려운 과제를 클리어했다.', 1),
    (w, '条件をクリアして合格した。', '조건을 충족해 합격했다.', 2);

  -- 512. 劇的に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '劇的に', 'げきてきに', '극적으로', '劇(심할 극) + 的', '부사', 512, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況が劇的に変わった。', '상황이 극적으로 변했다.', 1),
    (w, '劇的に成長を遂げた。', '극적으로 성장을 이뤘다.', 2);

  -- 513. 締め切る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '締め切る', 'しめきる', '마감하다', '締め + 切る(끊다)', '동사', 513, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応募を締め切った。', '응모를 마감했다.', 1),
    (w, '申し込みを締め切る日が近い。', '신청을 마감하는 날이 가깝다.', 2);

  -- 514. ぞろぞろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぞろぞろ', '졸졸', '의태어 (이어지는 모양)', '부사', 514, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供がぞろぞろ後をついてきた。', '아이가 졸졸 뒤를 따라왔다.', 1),
    (w, '人がぞろぞろ集まってきた。', '사람이 줄줄이 모여들었다.', 2);

  -- 515. 設備
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '設備', 'せつび', '설비', '設(베풀 설) + 備(갖출 비)', '명사', 515, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最新の設備が整っている。', '최신 설비가 갖춰져 있다.', 1),
    (w, '設備投資を増やした。', '설비 투자를 늘렸다.', 2);

  -- 516. 進出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '進出', 'しんしゅつ', '진출', '進(나아갈 진) + 出(날 출)', '명사', 516, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '海外市場に進出する。', '해외 시장에 진출한다.', 1),
    (w, '新分野への進出を計画する。', '신분야 진출을 계획한다.', 2);

  -- 517. まれな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'まれな', '드문, 희귀한', '관용 형용사 (드뭄)', 'な형용사', 517, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まれな病気と診断された。', '드문 병으로 진단되었다.', 1),
    (w, 'まれな経験ができた。', '희귀한 경험을 할 수 있었다.', 2);

  -- 518. ぎっしり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぎっしり', '가득', '의태어 (꽉 차는 모양)', '부사', 518, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スケジュールがぎっしり詰まっている。', '스케줄이 가득 차 있다.', 1),
    (w, '引き出しに本がぎっしり入っている。', '서랍에 책이 가득 들어 있다.', 2);

  -- 519. いだく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いだく', '품다', '抱(안을 포)', '동사', 519, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大きな夢をいだく。', '큰 꿈을 품는다.', 1),
    (w, '不安をいだいたまま発表した。', '불안을 품은 채 발표했다.', 2);

  -- 520. 誤解
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '誤解', 'ごかい', '오해', '誤(그릇될 오) + 解(풀 해)', '명사', 520, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の言葉を誤解した。', '그의 말을 오해했다.', 1),
    (w, '誤解を解くために話し合った。', '오해를 풀기 위해 이야기했다.', 2);

  -- 521. 節約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '節約', 'せつやく', '절약', '節(마디 절) + 約(맺을 약)', '명사', 521, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気代を節約する。', '전기료를 절약한다.', 1),
    (w, '時間を節約する工夫をする。', '시간을 절약하는 궁리를 한다.', 2);

  -- 522. 飛びつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '飛びつく', 'とびつく', '달려들다', '飛び + つく(붙다)', '동사', 522, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬が飼い主に飛びついた。', '개가 주인에게 달려들었다.', 1),
    (w, '彼はチャンスに飛びついた。', '그는 기회에 달려들었다.', 2);

  -- 523. こそこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'こそこそ', '살금살금, 소곤소곤', '의태어 (몰래)', '부사', 523, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こそこそ話をしている。', '소곤소곤 이야기하고 있다.', 1),
    (w, 'こそこそ部屋を出ていった。', '살금살금 방을 나갔다.', 2);

  -- 524. 話題
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '話題', 'わだい', '화제', '話(말씀 화) + 題(제목 제)', '명사', 524, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近の話題のニュースだ。', '최근 화제의 뉴스다.', 1),
    (w, '話題を変えて話そう。', '화제를 바꿔 이야기하자.', 2);

  -- 525. 後悔
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '後悔', 'こうかい', '후회', '後(뒤 후) + 悔(뉘우칠 회)', '명사', 525, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去の決断を後悔している。', '과거의 결단을 후회하고 있다.', 1),
    (w, '後悔のない人生を送りたい。', '후회 없는 인생을 살고 싶다.', 2);

  -- 526. リハーサル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'リハーサル', '리허설, 예행 연습', '외래어 (rehearsal)', '명사', 526, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンサートのリハーサルをした。', '콘서트 리허설을 했다.', 1),
    (w, '入念にリハーサルを重ねる。', '꼼꼼히 리허설을 거듭한다.', 2);

  -- 527. 特定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '特定', 'とくてい', '특정', '特(특별 특) + 定(정할 정)', '명사', 527, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '特定の人物に話を聞いた。', '특정 인물에게 이야기를 들었다.', 1),
    (w, '犯人を特定するのは難しい。', '범인을 특정하는 것은 어렵다.', 2);

  -- 528. かさかさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かさかさ', '바삭바삭, 꺼칠꺼칠', '의태어 (건조한 소리/촉감)', '부사', 528, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冬は手がかさかさになる。', '겨울에는 손이 까칠해진다.', 1),
    (w, '落ち葉がかさかさ音を立てる。', '낙엽이 바삭바삭 소리를 낸다.', 2);

  -- 529. まねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'まねる', '흉내내다, 모방하다', '真似(흉내)', '동사', 529, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供は親の行動をまねる。', '아이는 부모의 행동을 흉내 낸다.', 1),
    (w, '先生のやり方をまねた。', '선생님의 방식을 모방했다.', 2);

  -- 530. 盛り上がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '盛り上がる', 'もりあがる', '고조되다', '盛り + 上がる', '동사', 530, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会場の雰囲気が盛り上がった。', '회장 분위기가 고조됐다.', 1),
    (w, '話が盛り上がって時間を忘れた。', '이야기가 고조돼 시간을 잊었다.', 2);

  -- 531. もてなす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'もてなす', '대접하다', '관용 동사 (환대)', '동사', 531, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お客さまを心からもてなす。', '손님을 진심으로 대접한다.', 1),
    (w, '料理でもてなすのが日本の文化だ。', '요리로 대접하는 것이 일본 문화다.', 2);

  -- 532. 通過
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '通過', 'つうか', '통과', '通(통할 통) + 過(지날 과)', '명사', 532, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験に通過した。', '시험을 통과했다.', 1),
    (w, '検査の通過を確認した。', '검사 통과를 확인했다.', 2);

  -- 533. インパクト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'インパクト', '임팩트, 충격', '외래어 (impact)', '명사', 533, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強烈なインパクトを与えた。', '강렬한 임팩트를 주었다.', 1),
    (w, 'インパクトのある発表だった。', '임팩트 있는 발표였다.', 2);

  -- 534. 報道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '報道', 'ほうどう', '보도', '報(갚을 보) + 道(길 도)', '명사', 534, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が大きく報道された。', '사고가 크게 보도되었다.', 1),
    (w, '報道機関が取材に来た。', '보도기관이 취재하러 왔다.', 2);

  -- 535. 多大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '多大な', 'ただいな', '매우 큰', '多(많을 다) + 大(클 대)', 'な형용사', 535, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多大な影響を与えた。', '매우 큰 영향을 주었다.', 1),
    (w, '多大なご支援に感謝します。', '큰 지원에 감사드립니다.', 2);

  -- 536. 溶け込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '溶け込む', 'とけこむ', '녹아들다', '溶け + 込む', '동사', 536, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい環境に溶け込んだ。', '새 환경에 녹아들었다.', 1),
    (w, '彼はチームに自然に溶け込んでいる。', '그는 팀에 자연스럽게 녹아들어 있다.', 2);

  -- 537. 衰える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '衰える', 'おとろえる', '쇠퇴하다', '衰(쇠할 쇠)', '동사', 537, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '視力が衰えてきた。', '시력이 쇠퇴하기 시작했다.', 1),
    (w, '王朝の勢いが衰えた。', '왕조의 기세가 쇠퇴했다.', 2);

  -- 538. 思い込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '思い込む', 'おもいこむ', '마음먹다, 믿다', '思い + 込む', '동사', 538, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は自分が悪いと思い込んでいる。', '그는 자신이 잘못했다고 믿고 있다.', 1),
    (w, '成功を信じて思い込む。', '성공을 믿고 마음먹는다.', 2);

  -- 539. 口調
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '口調', 'くちょう', '어조, 말투', '口(입 구) + 調(고를 조)', '명사', 539, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の口調は厳しい。', '그의 말투는 엄격하다.', 1),
    (w, '優しい口調で話しかけた。', '부드러운 말투로 말을 걸었다.', 2);

  -- 540. 役目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '役目', 'やくめ', '임무', '役(부릴 역) + 目(눈 목)', '명사', 540, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '司会の役目を果たした。', '사회자의 임무를 수행했다.', 1),
    (w, '私の役目はチームをまとめることだ。', '나의 임무는 팀을 이끄는 것이다.', 2);

  -- 541. ずうずうしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ずうずうしい', '뻔뻔스럽다', '관용 형용사', 'い형용사', 541, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はずうずうしくお願いをする。', '그는 뻔뻔스럽게 부탁을 한다.', 1),
    (w, 'ずうずうしい態度に呆れた。', '뻔뻔스러운 태도에 어이가 없었다.', 2);

  -- 542. とりあえず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'とりあえず', '우선, 일단', '관용 부사', '부사', 542, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とりあえずビールを注文した。', '일단 맥주를 주문했다.', 1),
    (w, 'とりあえず連絡しておいた。', '우선 연락해 두었다.', 2);

  -- 543. 一応
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一応', 'いちおう', '우선, 일단', '一 + 応(응할 응)', '부사', 543, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一応確認しておく。', '일단 확인해 둔다.', 1),
    (w, '一応の準備は整った。', '어느 정도 준비는 됐다.', 2);

  -- 544. 譲る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '譲る', 'ゆずる', '양도하다', '譲(사양할 양)', '동사', 544, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先輩に席を譲った。', '선배에게 자리를 양보했다.', 1),
    (w, '車を友人に譲った。', '차를 친구에게 양도했다.', 2);

  -- 545. 売る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '売る', 'うる', '팔다', '売(팔 매)', '동사', 545, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い家具を売った。', '오래된 가구를 팔았다.', 1),
    (w, '商品を高い値段で売る。', '상품을 비싼 값에 판다.', 2);

  -- 546. 雑談
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '雑談', 'ざつだん', '잡담', '雑(섞일 잡) + 談(말씀 담)', '명사', 546, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同僚と雑談を楽しんだ。', '동료와 잡담을 즐겼다.', 1),
    (w, '雑談から良いアイデアが生まれた。', '잡담에서 좋은 아이디어가 나왔다.', 2);

  -- 547. おしゃべり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おしゃべり', '잡담, 수다', '관용 명사', '명사', 547, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達とおしゃべりするのが楽しい。', '친구와 수다 떠는 것이 즐겁다.', 1),
    (w, '彼女はおしゃべりが好きだ。', '그녀는 수다를 좋아한다.', 2);

  -- 548. 賢い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '賢い', 'かしこい', '똑똑하다', '賢(어질 현)', 'い형용사', 548, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は賢い子供だ。', '그는 똑똑한 아이다.', 1),
    (w, '賢い選択をした。', '현명한 선택을 했다.', 2);

  -- 549. 頭がいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頭がいい', 'あたまがいい', '머리가 좋다', '頭 + いい(좋다)', '관용구', 549, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は頭がいいので尊敬している。', '그는 머리가 좋아 존경한다.', 1),
    (w, '頭がいい人は学習が早い。', '머리가 좋은 사람은 학습이 빠르다.', 2);

  -- 550. 大げさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '大げさ', 'おおげさ', '과장', '大 + げさ', '명사', 550, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大げさに話すのは良くない。', '과장해서 말하는 것은 좋지 않다.', 1),
    (w, '大げさな表現は誤解を招く。', '과장된 표현은 오해를 부른다.', 2);

  -- 551. オーバー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'オーバー', '오버', '외래어 (over)', '명사', 551, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の反応はオーバーだ。', '그의 반응은 오버다.', 1),
    (w, 'オーバーな演技に笑った。', '오버된 연기에 웃었다.', 2);

  -- 552. 勝手な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勝手な', 'かってな', '제멋대로인', '勝手(자기 멋대로)', 'な형용사', 552, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝手な行動はやめてほしい。', '제멋대로의 행동은 그만뒀으면 한다.', 1),
    (w, '彼は勝手な発言をする。', '그는 제멋대로의 발언을 한다.', 2);

  -- 553. わがままな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'わがままな', '제멋대로인', '관용 형용사', 'な형용사', 553, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女はわがままな性格だ。', '그녀는 제멋대로의 성격이다.', 1),
    (w, 'わがままを言うのはやめなさい。', '제멋대로 굴지 마.', 2);

  -- 554. たびたび
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'たびたび', '종종', '관용 부사', '부사', 554, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たびたび彼を訪ねている。', '종종 그를 찾아간다.', 1),
    (w, 'たびたびお邪魔します。', '종종 폐를 끼칩니다.', 2);

  -- 555. 何度も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '何度も', 'なんども', '몇 번이고', '何度 + も', '부사', 555, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何度も練習を重ねた。', '몇 번이고 연습을 거듭했다.', 1),
    (w, '同じ間違いを何度もした。', '같은 실수를 몇 번이고 했다.', 2);

  -- 556. ぶかぶかだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぶかぶかだ', '헐렁헐렁하다(옷, 신발이 큰 모양)', '의태어', 'な형용사', 556, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴がぶかぶかで歩きにくい。', '신발이 헐렁헐렁해 걷기 힘들다.', 1),
    (w, 'そのコートはぶかぶかだ。', '그 코트는 헐렁헐렁하다.', 2);

  -- 557. とても大きい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'とても大きい', 'とてもおおきい', '매우 크다', 'とても + 大きい', '관용구', 557, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とても大きい木が並んでいる。', '매우 큰 나무가 늘어서 있다.', 1),
    (w, '彼はとても大きい家に住む。', '그는 매우 큰 집에 산다.', 2);

  -- 558. 見解
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '見解', 'けんかい', '견해', '見(볼 견) + 解(풀 해)', '명사', 558, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の見解は新鮮だ。', '그의 견해는 신선하다.', 1),
    (w, '専門家の見解を聞いた。', '전문가의 견해를 들었다.', 2);

  -- 559. 考え方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '考え方', 'かんがえかた', '생각, 사고방식', '考え + 方', '명사', 559, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の考え方に共感した。', '그의 사고방식에 공감했다.', 1),
    (w, '柔軟な考え方が必要だ。', '유연한 사고방식이 필요하다.', 2);

  -- 560. レンタルする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'レンタルする', 'レンタルする', '대여하다', '외래어 (rental)', '동사', 560, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車をレンタルした。', '차를 대여했다.', 1),
    (w, '衣装をレンタルする予定だ。', '의상을 대여할 예정이다.', 2);

  -- 561. 借りる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '借りる', 'かりる', '빌리다', '借(빌 차)', '동사', 561, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人から本を借りた。', '친구에게서 책을 빌렸다.', 1),
    (w, 'お金を借りるのは慎重に。', '돈을 빌리는 것은 신중히.', 2);

  -- 562. ブーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ブーム', '붐', '외래어 (boom)', '명사', 562, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康ブームが続いている。', '건강 붐이 이어지고 있다.', 1),
    (w, '新たなブームが起こった。', '새로운 붐이 일어났다.', 2);

  -- 563. 流行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '流行', 'りゅうこう', '유행', '流 + 行', '명사', 563, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年の流行ファッションをチェックした。', '올해의 유행 패션을 확인했다.', 1),
    (w, 'インフルエンザが流行している。', '독감이 유행하고 있다.', 2);

  -- 564. 慎重に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '慎重に', 'しんちょうに', '신중하게', '慎(삼갈 신) + 重(무거울 중)', '부사', 564, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '慎重に判断する必要がある。', '신중하게 판단할 필요가 있다.', 1),
    (w, '彼は慎重に運転する。', '그는 신중하게 운전한다.', 2);

  -- 565. 注意して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '注意して', 'ちゅういして', '주의하여', '注意 + して', '부사', 565, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '注意してご利用ください。', '주의해서 이용해 주세요.', 1),
    (w, '注意して交差点を渡る。', '주의해 교차로를 건넌다.', 2);

  -- 566. 縮む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '縮む', 'ちぢむ', '줄어들다, 축소되다', '縮(줄일 축)', '동사', 566, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'セーターが洗濯で縮んだ。', '스웨터가 세탁으로 줄어들었다.', 1),
    (w, '距離が縮んで親しくなった。', '거리가 좁혀져 친해졌다.', 2);

  -- 567. 小さくなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '小さくなる', 'ちいさくなる', '작아지다', '小さい + なる', '동사', 567, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の服がすぐ小さくなる。', '아이 옷이 금방 작아진다.', 1),
    (w, '部屋が小さくなった気がする。', '방이 작아진 것 같다.', 2);

  -- 568. ほぼ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ほぼ', '거의', '관용 부사', '부사', 568, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '準備はほぼ完了した。', '준비는 거의 완료됐다.', 1),
    (w, '参加者はほぼ全員来た。', '참가자는 거의 전원 왔다.', 2);

  -- 569. だいたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'だいたい', '대체로', '관용 부사', '부사', 569, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だいたい三十分かかる。', '대체로 30분 걸린다.', 1),
    (w, 'だいたいの内容は理解した。', '대체로의 내용은 이해했다.', 2);

  -- 570. 回復する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '回復する', 'かいふくする', '회복하다', '回(돌아올 회) + 復(돌아올 복)', '동사', 570, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は早く回復した。', '그는 빨리 회복했다.', 1),
    (w, '経済が徐々に回復している。', '경제가 서서히 회복되고 있다.', 2);

  -- 571. よくなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'よくなる', '좋아지다', 'よく + なる', '동사', 571, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天気がよくなった。', '날씨가 좋아졌다.', 1),
    (w, '彼女との関係がよくなった。', '그녀와의 관계가 좋아졌다.', 2);

  -- 572. くたくたになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'くたくたになる', '기진맥진하다, 녹초가 되다', '의태어 + なる', '관용구', 572, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事でくたくたになった。', '일로 녹초가 되었다.', 1),
    (w, '遊び疲れてくたくたになる。', '놀다 지쳐 녹초가 된다.', 2);

  -- 573. 疲れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '疲れる', 'つかれる', '지치다, 피곤하다', '疲(피곤할 피)', '동사', 573, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間の運転で疲れた。', '장시간 운전으로 피곤했다.', 1),
    (w, '最近、仕事で疲れている。', '최근 일로 지쳐 있다.', 2);

  -- 574. わずかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'わずかな', '얼마 안 되는', '관용 형용사', 'な형용사', 574, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わずかな差で勝った。', '약간의 차로 이겼다.', 1),
    (w, 'わずかな時間も大切だ。', '얼마 안 되는 시간도 소중하다.', 2);

  -- 575. 少し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '少し', 'すこし', '조금', '少 + し', '부사', 575, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休憩しよう。', '조금 쉬자.', 1),
    (w, '少しだけ味見した。', '조금만 맛을 봤다.', 2);

  -- 576. うつむく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'うつむく', '고개를 숙이다', '관용 동사', '동사', 576, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は恥ずかしそうにうつむいた。', '그녀는 부끄러운 듯 고개를 숙였다.', 1),
    (w, 'うつむいて泣いている。', '고개를 숙이고 울고 있다.', 2);

  -- 577. 下を向く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '下を向く', 'したをむく', '아래를 보다', '下 + 向く(향하다)', '관용구', 577, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '下を向いて歩かないで。', '아래를 보고 걷지 마.', 1),
    (w, '彼は下を向いて返事をした。', '그는 아래를 보고 대답했다.', 2);

  -- 578. いきなり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いきなり', '갑자기', '관용 부사', '부사', 578, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いきなり雨が降り出した。', '갑자기 비가 내리기 시작했다.', 1),
    (w, 'いきなり名前を呼ばれた。', '갑자기 이름을 불렸다.', 2);

  -- 579. 突然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '突然', 'とつぜん', '갑자기', '突(부딪칠 돌) + 然(그러할 연)', '부사', 579, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '突然の訪問に驚いた。', '갑작스러운 방문에 놀랐다.', 1),
    (w, '彼は突然辞めた。', '그는 갑자기 그만뒀다.', 2);

  -- 580. 直ちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '直ちに', 'ただちに', '즉시', '直 + ちに', '부사', 580, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '直ちに対応してください。', '즉시 대응해 주세요.', 1),
    (w, '直ちに会議を開いた。', '즉시 회의를 열었다.', 2);

  -- 581. すぐに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'すぐに', '바로', '관용 부사', '부사', 581, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐにお返事します。', '바로 답장 드리겠습니다.', 1),
    (w, 'すぐに来てください。', '바로 와 주세요.', 2);

  -- 582. 奇妙な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '奇妙な', 'きみょうな', '기묘한', '奇(기이할 기) + 妙(묘할 묘)', 'な형용사', 582, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '奇妙な物音がした。', '기묘한 소리가 났다.', 1),
    (w, '彼の奇妙な行動に注目が集まった。', '그의 기묘한 행동에 주목이 모였다.', 2);

  -- 583. 変な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '変な', 'へんな', '이상한', '変(변할 변)', 'な형용사', 583, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '変なにおいがする。', '이상한 냄새가 난다.', 1),
    (w, '変なことを言わないで。', '이상한 말 하지 마.', 2);

  -- 584. 仕上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '仕上げる', 'しあげる', '마무리하다, 완성하다', '仕 + 上げる', '동사', 584, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロジェクトを仕上げた。', '프로젝트를 완성했다.', 1),
    (w, '絵を丁寧に仕上げる。', '그림을 정성스럽게 마무리한다.', 2);

  -- 585. 完成させる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '完成させる', 'かんせいさせる', '완성시키다', '完成 + させる', '동사', 585, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を完成させた。', '작품을 완성시켰다.', 1),
    (w, '計画を完成させるのに時間がかかる。', '계획을 완성시키는 데 시간이 걸린다.', 2);

  -- 586. 日中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '日中', 'にっちゅう', '대낮, 한낮', '日 + 中', '명사', 586, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日中は暑くなる。', '낮에는 더워진다.', 1),
    (w, '日中の気温が三十度を超えた。', '낮 기온이 30도를 넘었다.', 2);

  -- 587. 昼間
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '昼間', 'ひるま', '대낮, 한낮', '昼 + 間', '명사', 587, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昼間は子供たちが公園で遊ぶ。', '낮에는 아이들이 공원에서 논다.', 1),
    (w, '昼間でも電気をつけている。', '낮에도 불을 켜 두고 있다.', 2);

  -- 588. 乾かない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乾かない', 'かわかない', '마르지 않다', '乾く(마르다) 부정', '동사', 588, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '洗濯物が乾かない。', '빨래가 마르지 않는다.', 1),
    (w, '梅雨はなかなか乾かない。', '장마철에는 좀처럼 마르지 않는다.', 2);

  -- 589. 追加する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '追加する', 'ついかする', '추가하다', '追加 + する', '동사', 589, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '注文を追加した。', '주문을 추가했다.', 1),
    (w, 'メンバーを追加することにした。', '멤버를 추가하기로 했다.', 2);

  -- 590. 足す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '足す', 'たす', '더하다', '足(발 족): 더함', '동사', 590, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '砂糖を一さじ足した。', '설탕을 한 숟가락 더했다.', 1),
    (w, '人数を足してみた。', '인원수를 더해 봤다.', 2);

  -- 591. 相当
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '相当', 'そうとう', '상당히', '相 + 当', '부사', 591, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は相当の力を持っている。', '그는 상당한 힘을 가지고 있다.', 1),
    (w, '相当時間がかかった。', '상당히 시간이 걸렸다.', 2);

  -- 592. かなり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かなり', '꽤, 상당히', '관용 부사', '부사', 592, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かなり遅くなりました。', '꽤 늦어졌습니다.', 1),
    (w, 'かなり難しい問題だ。', '꽤 어려운 문제다.', 2);

  -- 593. じっとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'じっとする', '가만히 있다', 'じっと + する', '관용구', 593, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'じっとして動かないで。', '가만히 있고 움직이지 마.', 1),
    (w, '彼はじっとしていられない性格だ。', '그는 가만히 있지 못하는 성격이다.', 2);

  -- 594. 動かない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '動かない', 'うごかない', '움직이지 않는다', '動く 부정', '동사', 594, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が動かない。', '차가 움직이지 않는다.', 1),
    (w, '彼は決心が動かない。', '그는 결심이 흔들리지 않는다.', 2);

  -- 595. 誤る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '誤る', 'あやまる', '틀리다, 실수하다', '誤(그릇될 오)', '동사', 595, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断を誤ってしまった。', '판단을 잘못해 버렸다.', 1),
    (w, '入力を誤って訂正した。', '입력을 잘못해 정정했다.', 2);

  -- 596. 正しくない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '正しくない', 'ただしくない', '옳지 않다, 맞지 않다', '正しい 부정', 'い형용사', 596, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の答えは正しくない。', '그의 답은 옳지 않다.', 1),
    (w, '正しくない情報が広まっている。', '옳지 않은 정보가 퍼지고 있다.', 2);

  -- 597. かさかさする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かさかさする', '거칠거칠하다,마르다', '의태어 + する', '동사', 597, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒くて肌がかさかさする。', '추워서 피부가 거칠어진다.', 1),
    (w, '唇がかさかさする。', '입술이 마른다.', 2);

  -- 598. 乾燥する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乾燥する', 'かんそうする', '건조하다', '乾(마를 건) + 燥(마를 조)', '동사', 598, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冬は空気が乾燥する。', '겨울은 공기가 건조하다.', 1),
    (w, '肌が乾燥しないように保湿する。', '피부가 건조해지지 않게 보습한다.', 2);

  -- 599. 済ます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '済ます', 'すます', '마치다, 끝내다', '済(건널 제)', '동사', 599, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '用事を済ましてから帰る。', '볼일을 마치고 나서 돌아간다.', 1),
    (w, 'お会計を済ませた。', '계산을 마쳤다.', 2);

  -- 600. 終える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '終える', 'おえる', '마치다, 끝내다', '終(마칠 종)', '동사', 600, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を早めに終えた。', '일을 일찍 마쳤다.', 1),
    (w, '大学を終えて就職した。', '대학을 마치고 취직했다.', 2);

  -- 601. はっきりしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'はっきりしない', '확실하지 않은', 'はっきり + しない', '관용구', 601, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故の原因がはっきりしない。', '사고의 원인이 확실하지 않다.', 1),
    (w, '返事がはっきりしないので困っている。', '대답이 확실하지 않아 곤란하다.', 2);

  -- 602. 思いがけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '思いがけない', 'おもいがけない', '뜻밖이다', '思い + 掛けない', 'い형용사', 602, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思いがけない出来事に驚いた。', '뜻밖의 일에 놀랐다.', 1),
    (w, '思いがけないプレゼントを受け取った。', '뜻밖의 선물을 받았다.', 2);

  -- 603. 意外だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '意外だ', 'いがいだ', '의외다', '意 + 外', 'な형용사', 603, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の発言は意外だった。', '그의 발언은 의외였다.', 1),
    (w, '結果が意外で驚いた。', '결과가 의외라 놀랐다.', 2);

  -- 604. 自ら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '自ら', 'みずから', '스스로', '自(스스로 자)', '부사', 604, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自ら行動を起こした。', '스스로 행동을 일으켰다.', 1),
    (w, '自ら責任を取った。', '스스로 책임을 졌다.', 2);

  -- 605. 自分で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '自分で', 'じぶんで', '스스로, 자신이', '自分 + で', '부사', 605, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分でやってみる。', '스스로 해 본다.', 1),
    (w, '自分でしっかり考えなさい。', '자신이 잘 생각해.', 2);

  -- 606. そろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'そろう', '갖추어지다, 모이다', '관용 동사', '동사', 606, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '参加者がそろった。', '참가자가 모였다.', 1),
    (w, '資料がそろってから始める。', '자료가 갖춰지고 나서 시작한다.', 2);

  -- 607. 集まる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '集まる', 'あつまる', '모이다', '集(모일 집)', '동사', 607, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達が公園に集まった。', '친구들이 공원에 모였다.', 1),
    (w, '参加者が会場に集まる。', '참가자가 회장에 모인다.', 2);

  -- 608. およそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'およそ', '대략', '관용 부사', '부사', 608, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '参加者はおよそ百人だった。', '참가자는 대략 100명이었다.', 1),
    (w, '完成までおよそ一年かかる。', '완성까지 대략 1년 걸린다.', 2);

  -- 609. 計画
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '計画', 'けいかく', '계획', '計(셀 계) + 画(그릴 화)', '명사', 609, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行の計画を立てた。', '여행 계획을 세웠다.', 1),
    (w, '計画通りに進んでいる。', '계획대로 진행되고 있다.', 2);

  -- 610. プラン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'プラン', '플랜', '외래어 (plan)', '명사', 610, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいプランを提案した。', '새 플랜을 제안했다.', 1),
    (w, 'プランを変更することにした。', '플랜을 변경하기로 했다.', 2);

  -- 611. 相変わらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '相変わらず', 'あいかわらず', '여전히', '相 + 変わらず', '부사', 611, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は相変わらず元気だ。', '그는 여전히 건강하다.', 1),
    (w, '相変わらず忙しい毎日だ。', '여전히 바쁜 나날이다.', 2);

  -- 612. 依然として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '依然として', 'いぜんとして', '여전히', '依然 + として', '부사', 612, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '依然として原因は不明だ。', '여전히 원인은 불명이다.', 1),
    (w, '状況は依然として厳しい。', '상황은 여전히 엄격하다.', 2);

  -- 613. 必死な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '必死な', 'ひっしな', '필사적인, 열심인', '必 + 死', 'な형용사', 613, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必死な努力が報われた。', '필사적인 노력이 보답받았다.', 1),
    (w, '彼は必死に勉強している。', '그는 필사적으로 공부하고 있다.', 2);

  -- 614. 一生懸命な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一生懸命な', 'いっしょうけんめいな', '열심인', '一生 + 懸命', 'な형용사', 614, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は一生懸命練習している。', '그는 열심히 연습하고 있다.', 1),
    (w, '一生懸命な姿に感動した。', '열심인 모습에 감동했다.', 2);

  -- 615. 山の麓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '山の麓', 'やまのふもと', '산기슭', '山 + 麓', '명사', 615, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山の麓に村がある。', '산기슭에 마을이 있다.', 1),
    (w, '山の麓で休憩した。', '산기슭에서 쉬었다.', 2);

  -- 616. 山の下のほう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '山の下のほう', 'やまのしたのほう', '산 아래쪽', '관용구', '명사', 616, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山の下のほうに駐車場がある。', '산 아래쪽에 주차장이 있다.', 1),
    (w, '山の下のほうから登り始めた。', '산 아래쪽부터 오르기 시작했다.', 2);

  -- 617. サイズをそろえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'サイズをそろえる', 'サイズをそろえる', '사이즈를 같게 하다', 'サイズ + そろえる', '관용구', 617, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品のサイズをそろえた。', '상품의 사이즈를 같게 했다.', 1),
    (w, '参加者のチームサイズをそろえる。', '참가자의 팀 사이즈를 같게 한다.', 2);

  -- 618. サイズを同じにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'サイズを同じにする', 'サイズをおなじにする', '사이즈를 똑같게 하다', 'サイズ + 同じ', '관용구', 618, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全員のサイズを同じにした。', '전원의 사이즈를 똑같게 했다.', 1),
    (w, '写真のサイズを同じにする。', '사진의 사이즈를 똑같게 한다.', 2);

  -- 619. 買い占める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '買い占める', 'かいしめる', '매점하다, 사 모으다', '買い + 占める', '동사', 619, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人気商品を買い占める。', '인기 상품을 매점한다.', 1),
    (w, 'マスクを買い占める人がいた。', '마스크를 사 모으는 사람이 있었다.', 2);

  -- 620. 全部買う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '全部買う', 'ぜんぶかう', '모두 사다', '全部 + 買う', '관용구', 620, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は商品を全部買った。', '그는 상품을 모두 샀다.', 1),
    (w, 'セールで全部買うことにした。', '세일에서 모두 사기로 했다.', 2);

  -- 621. 間際
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '間際', 'まぎわ', '직전', '間 + 際', '명사', 621, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発の間際に電話が来た。', '출발 직전에 전화가 왔다.', 1),
    (w, '締め切り間際で慌てた。', '마감 직전에 당황했다.', 2);

  -- 622. 直前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '直前', 'ちょくぜん', '직전', '直 + 前', '명사', 622, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合の直前に怪我をした。', '시합 직전에 부상을 입었다.', 1),
    (w, '出発の直前まで荷造りした。', '출발 직전까지 짐을 쌌다.', 2);

  -- 623. たちまち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'たちまち', '금세, 순식간에', '관용 부사', '부사', 623, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品はたちまち売り切れた。', '상품은 금세 다 팔렸다.', 1),
    (w, '噂はたちまち広まった。', '소문은 순식간에 퍼졌다.', 2);

  -- 624. 勘定する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勘定する', 'かんじょうする', '지불하다', '勘(헤아릴 감) + 定', '동사', 624, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お会計を勘定した。', '계산을 마쳤다.', 1),
    (w, '彼が全員分を勘定してくれた。', '그가 전원 분을 계산해 주었다.', 2);

  -- 625. お金を払う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'お金を払う', 'おかねをはらう', '돈을 지불하다', 'お金 + 払う', '관용구', 625, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品代金をお金で払った。', '상품 대금을 돈으로 지불했다.', 1),
    (w, '毎月家賃のお金を払う。', '매달 집세를 지불한다.', 2);

  -- 626. 異なる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '異なる', 'ことなる', '다르다', '異(다를 이)', '동사', 626, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が異なる場合がある。', '의견이 다른 경우가 있다.', 1),
    (w, '彼とは性格が異なる。', '그와는 성격이 다르다.', 2);

  -- 627. 違う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '違う', 'ちがう', '다르다', '違(어긋날 위)', '동사', 627, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の考えとは違う。', '내 생각과는 다르다.', 1),
    (w, '色が少し違う。', '색이 조금 다르다.', 2);

  -- 628. たまたま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'たまたま', '우연히', '관용 부사', '부사', 628, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たまたま昔の友人に会った。', '우연히 옛 친구를 만났다.', 1),
    (w, 'たまたま家にいて電話に出た。', '우연히 집에 있어서 전화를 받았다.', 2);

  -- 629. 明らかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '明らかな', 'あきらかな', '분명한', '明 + 明らか', 'な형용사', 629, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明らかな事実が判明した。', '분명한 사실이 밝혀졌다.', 1),
    (w, '彼の責任は明らかだ。', '그의 책임은 분명하다.', 2);

  -- 630. はっきりした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'はっきりした', '분명한, 확실한', 'はっきり + した', '관용구', 630, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はっきりした証拠が出た。', '확실한 증거가 나왔다.', 1),
    (w, 'はっきりした答えが欲しい。', '확실한 답을 원한다.', 2);

  -- 631. 用心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '用心', 'ようじん', '조심', '用 + 心', '명사', 631, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜道は用心したほうがいい。', '밤길은 조심하는 게 좋다.', 1),
    (w, '用心深く周囲を確認する。', '조심스럽게 주위를 확인한다.', 2);

  -- 632. 注意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '注意', 'ちゅうい', '주의', '注(부을 주) + 意', '명사', 632, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車に注意してください。', '차에 주의해 주세요.', 1),
    (w, '注意を払って作業する。', '주의를 기울여 작업한다.', 2);

  -- 633. 騒々しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '騒々しい', 'そうぞうしい', '시끄럽다, 소란스럽다', '騒(시끄러울 소)', 'い형용사', 633, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '騒々しい場所で集中できない。', '시끄러운 장소에서 집중할 수 없다.', 1),
    (w, '子供たちは騒々しく遊んでいる。', '아이들은 소란스럽게 놀고 있다.', 2);

  -- 634. うるさい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'うるさい', '시끄럽다', '관용 형용사', 'い형용사', 634, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽がうるさい。', '음악이 시끄럽다.', 1),
    (w, '彼はマナーにうるさい。', '그는 매너에 까다롭다.', 2);

  -- 635. 所有する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '所有する', 'しょゆうする', '소유하다', '所有 + する', '동사', 635, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は別荘を所有している。', '그는 별장을 소유하고 있다.', 1),
    (w, '会社は土地を所有する。', '회사는 토지를 소유한다.', 2);

  -- 636. 持つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '持つ', 'もつ', '들다, 소유하다', '持(가질 지)', '동사', 636, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かばんを持って歩く。', '가방을 들고 걷는다.', 1),
    (w, '彼は古い時計を持っている。', '그는 오래된 시계를 가지고 있다.', 2);

  -- 637. おそらく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おそらく', '아마', '관용 부사', '부사', 637, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おそらく彼は来るだろう。', '아마 그는 올 것이다.', 1),
    (w, 'おそらく雨は止むだろう。', '아마 비는 그칠 것이다.', 2);

  -- 638. 多分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '多分', 'たぶん', '아마', '多 + 分', '부사', 638, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多分明日は晴れる。', '아마 내일은 맑다.', 1),
    (w, '多分間に合うと思う。', '아마 시간 맞출 거라 생각한다.', 2);

  -- 639. 収納する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '収納する', 'しゅうのうする', '수납하다', '収納 + する', '동사', 639, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '衣類を収納するスペースが必要だ。', '의류를 수납할 공간이 필요하다.', 1),
    (w, 'きれいに収納されている。', '깔끔하게 수납되어 있다.', 2);

  -- 640. しまう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しまう', '치우다, 간수하다', '관용 동사', '동사', 640, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おもちゃを箱にしまう。', '장난감을 상자에 치운다.', 1),
    (w, '大切な書類は金庫にしまった。', '중요한 서류는 금고에 보관했다.', 2);

  -- 641. 小柄だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '小柄だ', 'こがらだ', '몸집이 작다', '小 + 柄', 'な형용사', 641, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は小柄だが力が強い。', '그녀는 몸집이 작지만 힘이 세다.', 1),
    (w, '小柄な人向けの服が並ぶ。', '몸집이 작은 사람용의 옷이 진열된다.', 2);

  -- 642. 体が小さい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '体が小さい', 'からだがちいさい', '몸집이 작다', '体 + 小さい', '관용구', 642, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私は体が小さいので服選びが難しい。', '나는 몸집이 작아 옷 고르기가 어렵다.', 1),
    (w, '彼は体が小さいけれど力がある。', '그는 몸집이 작지만 힘이 있다.', 2);

  -- 643. 無口だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '無口だ', 'むくちだ', '과묵하다', '無 + 口', 'な형용사', 643, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は無口だが優しい。', '그는 과묵하지만 다정하다.', 1),
    (w, '無口な人ほど深く考える。', '과묵한 사람일수록 깊이 생각한다.', 2);

  -- 644. あまり話さない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'あまり話さない', 'あまりはなさない', '그다지 말하지 않는다', 'あまり + 話さない', '관용구', 644, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はあまり話さないタイプだ。', '그는 그다지 말하지 않는 타입이다.', 1),
    (w, '初対面だとあまり話さない。', '첫 만남에는 그다지 말하지 않는다.', 2);

  -- 645. やや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'やや', '다소, 조금', '관용 부사', '부사', 645, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やや疲れている。', '다소 피곤하다.', 1),
    (w, '価格はやや高めだ。', '가격은 다소 비싼 편이다.', 2);

  -- 646. テンポ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'テンポ', '템포, 속도', '외래어 (tempo)', '명사', 646, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テンポの速い音楽を流した。', '템포가 빠른 음악을 틀었다.', 1),
    (w, '会話のテンポを合わせる。', '대화의 템포를 맞춘다.', 2);

  -- 647. 速さ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '速さ', 'はやさ', '속도', '速 + さ', '명사', 647, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車の速さに驚いた。', '차의 속도에 놀랐다.', 1),
    (w, '彼の話す速さは早い。', '그의 말하는 속도는 빠르다.', 2);

  -- 648. 妙な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '妙な', 'みょうな', '묘한', '妙(묘할 묘)', 'な형용사', 648, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妙な雰囲気を感じた。', '묘한 분위기를 느꼈다.', 1),
    (w, '妙な味の料理だ。', '묘한 맛의 요리다.', 2);

  -- 649. ささやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ささやく', '속삭이다', '관용 동사', '동사', 649, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は耳元でささやいた。', '그는 귓가에 속삭였다.', 1),
    (w, '子供たちが小声でささやいている。', '아이들이 작은 소리로 속삭이고 있다.', 2);

  -- 650. 小声で話す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '小声で話す', 'こごえではなす', '작은 목소리로 말하다', '小声 + 話す', '관용구', 650, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '図書館では小声で話す。', '도서관에서는 작은 목소리로 말한다.', 1),
    (w, '寝ている赤ちゃんを起こさないように小声で話した。', '자고 있는 아기를 깨우지 않게 작은 소리로 말했다.', 2);

  -- 651. かつて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かつて', '일찍이, 예전부터', '관용 부사', '부사', 651, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はかつて教師だった。', '그는 예전에 교사였다.', 1),
    (w, 'かつてないほどの寒さだ。', '유례 없을 정도의 추위다.', 2);

  -- 652. 以前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '以前', 'いぜん', '이전, 예전', '以 + 前', '명사', 652, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '以前ここに住んでいた。', '이전에 여기 살았다.', 1),
    (w, '以前から知っている人だ。', '예전부터 알고 있는 사람이다.', 2);

  -- 653. 注目する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '注目する', 'ちゅうもくする', '주목하다', '注 + 目', '동사', 653, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい技術に注目する。', '새 기술에 주목한다.', 1),
    (w, '彼の活躍が注目された。', '그의 활약이 주목받았다.', 2);

  -- 654. 関心を持つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '関心を持つ', 'かんしんをもつ', '관심을 갖다', '関心 + 持つ', '관용구', 654, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境問題に関心を持っている。', '환경 문제에 관심을 갖고 있다.', 1),
    (w, '政治に関心を持つ若者が増えた。', '정치에 관심을 갖는 젊은이가 늘었다.', 2);

  -- 655. じかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'じかに', '직접', '관용 부사', '부사', 655, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'じかに本人と話したい。', '직접 본인과 이야기하고 싶다.', 1),
    (w, 'じかに会って確認した。', '직접 만나 확인했다.', 2);

  -- 656. 直接
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '直接', 'ちょくせつ', '직접', '直 + 接', '명사', 656, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼に直接会って話した。', '그에게 직접 만나 이야기했다.', 1),
    (w, '直接お問い合わせください。', '직접 문의해 주세요.', 2);

  -- 657. 衝突する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '衝突する', 'しょうとつする', '충돌하다', '衝(찌를 충) + 突(부딪칠 돌)', '동사', 657, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車が壁に衝突した。', '차가 벽에 충돌했다.', 1),
    (w, '意見が衝突して議論になった。', '의견이 충돌해 논쟁이 되었다.', 2);

  -- 658. ぶつかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぶつかる', '충돌하다', '관용 동사', '동사', 658, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '柱にぶつかってしまった。', '기둥에 부딪혔다.', 1),
    (w, '問題にぶつかって悩んでいる。', '문제에 부딪혀 고민하고 있다.', 2);

  -- 659. 卑怯な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '卑怯な', 'ひきょうな', '비겁한', '卑(낮을 비) + 怯(겁낼 겁)', 'な형용사', 659, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '卑怯な手を使うのはやめよう。', '비겁한 수를 쓰는 것은 그만두자.', 1),
    (w, '卑怯な行動は許されない。', '비겁한 행동은 용납되지 않는다.', 2);

  -- 660. ずるい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ずるい', '교활하다, 약다', '관용 형용사', 'い형용사', 660, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ずるい方法で勝つのは嫌だ。', '교활한 방법으로 이기는 것은 싫다.', 1),
    (w, '彼はずるいやり方を選んだ。', '그는 약은 방식을 선택했다.', 2);

  -- 661. 愉快だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '愉快だ', 'ゆかいだ', '유쾌하다', '愉(즐거울 유) + 快(쾌할 쾌)', 'な형용사', 661, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愉快な仲間と過ごす時間。', '유쾌한 동료와 보내는 시간.', 1),
    (w, '愉快な話で笑いが絶えない。', '유쾌한 이야기로 웃음이 끊이지 않는다.', 2);

  -- 662. 面白い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '面白い', 'おもしろい', '재미있다', '面 + 白い', 'い형용사', 662, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この映画はとても面白い。', '이 영화는 매우 재미있다.', 1),
    (w, '面白い話を聞いた。', '재미있는 이야기를 들었다.', 2);

  -- 663. やむをえない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'やむをえない', '어쩔 수 없다, 부득이하다', '止む + 得ない', '관용구', 663, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やむをえない事情で欠席した。', '부득이한 사정으로 결석했다.', 1),
    (w, 'やむをえず計画を変えた。', '어쩔 수 없이 계획을 바꿨다.', 2);

  -- 664. しかたない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しかたない', '어쩔 수 없다', '仕方 + ない', '관용구', 664, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しかたないので諦めた。', '어쩔 수 없이 포기했다.', 1),
    (w, 'しかたなく対応した。', '어쩔 수 없이 대응했다.', 2);

  -- 665. 息抜きする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '息抜きする', 'いきぬきする', '한숨 돌리다, 쉬다', '息 + 抜き', '동사', 665, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事の合間に息抜きする。', '일 사이에 한숨 돌린다.', 1),
    (w, '旅行で息抜きできた。', '여행으로 한숨 돌릴 수 있었다.', 2);

  -- 666. 休む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '休む', 'やすむ', '쉬다', '休(쉴 휴)', '동사', 666, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '週末はゆっくり休む。', '주말은 푹 쉰다.', 1),
    (w, '風邪で会社を休んだ。', '감기로 회사를 쉬었다.', 2);

  -- 667. ついている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ついている', '운이 좋다', '관용 표현', '관용구', 667, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はついている。', '오늘은 운이 좋다.', 1),
    (w, '彼は最近ついている。', '그는 최근 운이 좋다.', 2);

  -- 668. 運がいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '運がいい', 'うんがいい', '운이 좋다', '運 + いい', '관용구', 668, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '運がいいことに席が空いていた。', '운이 좋게도 자리가 비어 있었다.', 1),
    (w, '彼は本当に運がいい。', '그는 정말 운이 좋다.', 2);

  -- 669. つねに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'つねに', '항상', '常(항상 상) + に', '부사', 669, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はつねに前向きだ。', '그는 항상 긍정적이다.', 1),
    (w, 'つねに学び続ける姿勢が大切だ。', '항상 배우는 자세가 중요하다.', 2);

  -- 670. いつも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いつも', '항상', '관용 부사', '부사', 670, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつも笑顔の人だ。', '항상 미소 짓는 사람이다.', 1),
    (w, 'いつも変わらない味だ。', '항상 변하지 않는 맛이다.', 2);

  -- 671. 過剰だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '過剰だ', 'かじょうだ', '과잉이다', '過 + 剰', 'な형용사', 671, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過剰なサービスは負担だ。', '과잉 서비스는 부담이다.', 1),
    (w, '過剰反応は良くない。', '과잉 반응은 좋지 않다.', 2);

  -- 672. 多すぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '多すぎる', 'おおすぎる', '너무 많다', '多い + 過ぎる', '관용구', 672, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '砂糖が多すぎる。', '설탕이 너무 많다.', 1),
    (w, '仕事が多すぎて眠れない。', '일이 너무 많아 잘 수 없다.', 2);

  -- 673. あやまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あやまり', '실수', '관용 명사', '명사', 673, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計算のあやまりに気付いた。', '계산 실수를 알아챘다.', 1),
    (w, 'あやまりを正直に認めた。', '실수를 정직하게 인정했다.', 2);

  -- 674. 間違っているところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '間違っているところ', 'まちがっているところ', '잘못되어 있는 부분', '間違う + ところ', '관용구', 674, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違っているところを直してください。', '잘못되어 있는 부분을 고쳐 주세요.', 1),
    (w, '間違っているところに印をつけた。', '잘못되어 있는 부분에 표시를 했다.', 2);

  -- 675. 臆病だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '臆病だ', 'おくびょうだ', '겁이 많다', '臆(가슴 억) + 病', 'な형용사', 675, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は臆病だが優しい。', '그는 겁이 많지만 다정하다.', 1),
    (w, '臆病な性格を直したい。', '겁이 많은 성격을 고치고 싶다.', 2);

  -- 676. なんでも怖がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'なんでも怖がる', 'なんでもこわがる', '무엇이든 무서워하다', '何でも + 怖がる', '관용구', 676, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はなんでも怖がる。', '그는 뭐든 무서워한다.', 1),
    (w, '子供がなんでも怖がる時期だ。', '아이가 뭐든 무서워하는 시기다.', 2);

  -- 677. とっくに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'とっくに', '진작에', '관용 부사', '부사', 677, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はとっくに帰った。', '그는 진작에 갔다.', 1),
    (w, 'とっくに知っていた話だ。', '진작부터 알고 있던 이야기다.', 2);

  -- 678. ずっと前に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ずっと前に', 'ずっとまえに', '훨씬 전에', 'ずっと + 前', '관용구', 678, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ずっと前に読んだ本だ。', '훨씬 전에 읽은 책이다.', 1),
    (w, 'ずっと前にお会いしました。', '훨씬 전에 뵈었습니다.', 2);

  -- 679. ゆずる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ゆずる', '양보하다', '관용 동사', '동사', 679, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '席をお年寄りにゆずった。', '자리를 노인에게 양보했다.', 1),
    (w, '子供におもちゃをゆずる。', '아이에게 장난감을 양보한다.', 2);

  -- 680. あげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あげる', '주다', '관용 동사', '동사', 680, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼントをあげる。', '선물을 준다.', 1),
    (w, '彼にお金をあげた。', '그에게 돈을 줬다.', 2);

  -- 681. 記憶する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '記憶する', 'きおくする', '기억하다', '記憶 + する', '동사', 681, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の名前を記憶している。', '그의 이름을 기억하고 있다.', 1),
    (w, '地図を記憶するのは難しい。', '지도를 기억하기는 어렵다.', 2);

  -- 682. 覚える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '覚える', 'おぼえる', '외우다', '覚(깨달을 각)', '동사', 682, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '単語を覚えるのが得意だ。', '단어를 외우는 데 능하다.', 1),
    (w, '歌の歌詞を覚えた。', '노래 가사를 외웠다.', 2);

  -- 683. 不平
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '不平', 'ふへい', '불평', '不 + 平', '명사', 683, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は仕事に不平を言う。', '그는 일에 불평을 한다.', 1),
    (w, '不平を抱えたまま続ける。', '불평을 가진 채 계속한다.', 2);

  -- 684. 文句
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '文句', 'もんく', '불평, 불만', '文 + 句', '명사', 684, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '文句ばかり言わないで。', '불평만 하지 마.', 1),
    (w, '料理に文句をつけられた。', '요리에 불평을 들었다.', 2);

  -- 685. むかつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'むかつく', '화가 나다, 역겹다', '관용 동사', '동사', 685, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の態度にむかついた。', '그의 태도에 화가 났다.', 1),
    (w, 'そんな話を聞いてむかつく。', '그런 이야기를 들으니 화가 난다.', 2);

  -- 686. 怒る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '怒る', 'おこる', '화가 나다', '怒(성낼 노)', '동사', 686, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父に怒られた。', '아빠에게 혼났다.', 1),
    (w, '彼はすぐ怒る性格だ。', '그는 금방 화내는 성격이다.', 2);

  -- 687. ほとんどない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ほとんどない', '거의 없는', 'ほとんど + ない', '관용구', 687, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな機会はほとんどない。', '그런 기회는 거의 없다.', 1),
    (w, '失敗はほとんどない。', '실패는 거의 없다.', 2);

  -- 688. 当てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '当てる', 'あてる', '맞히다, 부딪다', '当(마땅 당)', '동사', 688, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クイズの答えを当てた。', '퀴즈 답을 맞혔다.', 1),
    (w, 'ボールを壁に当てた。', '공을 벽에 부딪쳤다.', 2);

  -- 689. ぶつける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ぶつける', '부딪다', '관용 동사', '동사', 689, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車を壁にぶつけた。', '차를 벽에 부딪쳤다.', 1),
    (w, '子供と頭をぶつけた。', '아이와 머리를 부딪쳤다.', 2);

  -- 690. あわれな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あわれな', '불쌍한', '관용 형용사', 'な형용사', 690, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あわれな境遇に同情した。', '불쌍한 처지에 동정했다.', 1),
    (w, 'あわれな声で鳴いていた。', '불쌍한 목소리로 울고 있었다.', 2);

  -- 691. かわいそうな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かわいそうな', '불쌍한', '관용 형용사', 'な형용사', 691, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かわいそうな話を聞いた。', '불쌍한 이야기를 들었다.', 1),
    (w, '彼はかわいそうな子だ。', '그는 불쌍한 아이다.', 2);

  -- 692. 当分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '当分', 'とうぶん', '당분간, 잠시', '当 + 分', '부사', 692, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '当分は様子を見よう。', '당분간은 지켜보자.', 1),
    (w, '当分忙しい日々が続く。', '당분간 바쁜 나날이 이어진다.', 2);

  -- 693. しばらく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しばらく', '당분간, 잠시', '관용 부사', '부사', 693, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しばらくお待ちください。', '잠시 기다려 주세요.', 1),
    (w, 'しばらく会っていない。', '한동안 만나지 못했다.', 2);

  -- 694. 一転する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一転する', 'いってんする', '완전히 바뀌다', '一 + 転', '동사', 694, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況が一転した。', '상황이 완전히 바뀌었다.', 1),
    (w, '試合の流れが一転した。', '시합의 흐름이 완전히 바뀌었다.', 2);

  -- 695. すっかり変わった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'すっかり変わった', 'すっかりかわった', '완전히 바뀌다', 'すっかり + 変わる', '관용구', 695, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '街がすっかり変わった。', '거리가 완전히 바뀌었다.', 1),
    (w, '彼の性格がすっかり変わった。', '그의 성격이 완전히 바뀌었다.', 2);

  -- 696. じたばたする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'じたばたする', '허둥거리다', '관용 동사', '동사', 696, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '締め切り前にじたばたしている。', '마감 전에 허둥거리고 있다.', 1),
    (w, 'じたばたしても仕方ない。', '허둥거려도 소용없다.', 2);

  -- 697. 慌てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '慌てる', 'あわてる', '당황해하다, 허둥대다', '慌(다급할 황)', '동사', 697, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅刻しそうで慌てた。', '지각할 것 같아 허둥댔다.', 1),
    (w, '慌てずに落ち着いて。', '허둥대지 말고 침착해.', 2);

  -- 698. テクニック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'テクニック', '테크닉, 기술', '외래어 (technique)', '명사', 698, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼンのテクニックを学んだ。', '발표 테크닉을 배웠다.', 1),
    (w, 'テクニックを磨くために練習する。', '기술을 갈고닦기 위해 연습한다.', 2);

  -- 699. 技術
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '技術', 'きじゅつ', '기술', '技 + 術', '명사', 699, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最先端の技術を導入した。', '최첨단 기술을 도입했다.', 1),
    (w, 'プログラミング技術を学ぶ。', '프로그래밍 기술을 배운다.', 2);

  -- 700. 利口な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '利口な', 'りこうな', '영리한', '利 + 口', 'な형용사', 700, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '利口な犬を飼っている。', '영리한 개를 키우고 있다.', 1),
    (w, '彼はとても利口だ。', '그는 매우 영리하다.', 2);

  -- 701. 用心する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '用心する', 'ようじんする', '조심하다', '用心 + する', '동사', 701, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜道では用心する。', '밤길에서는 조심한다.', 1),
    (w, '火の取り扱いに用心する。', '불을 다룰 때 조심한다.', 2);

  -- 702. 気をつける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '気をつける', 'きをつける', '조심하다', '気 + つける', '관용구', 702, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転ばないように気をつけて。', '넘어지지 않게 조심해.', 1),
    (w, '健康に気をつけている。', '건강에 신경 쓰고 있다.', 2);

  -- 703. くどい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'くどい', '장황하다, 집요하다', '관용 형용사', 'い형용사', 703, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の話はくどい。', '그의 이야기는 장황하다.', 1),
    (w, 'くどい味付けは苦手だ。', '진한 맛은 잘 못 먹는다.', 2);

  -- 704. しつこい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しつこい', '집요하다, 끈질기다', '관용 형용사', 'い형용사', 704, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しつこい質問にうんざりした。', '집요한 질문에 질렸다.', 1),
    (w, 'しつこく勧誘された。', '끈질기게 권유받았다.', 2);

  -- 705. 物騒になる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '物騒になる', 'ぶっそうになる', '위험해지다', '物騒 + なる', '관용구', 705, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近、街が物騒になった。', '최근 거리가 위험해졌다.', 1),
    (w, '夜は一人歩きが物騒になっている。', '밤에는 혼자 걷는 것이 위험해지고 있다.', 2);

  -- 706. 安全じゃなくなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '安全じゃなくなる', 'あんぜんじゃなくなる', '안전하지 않게 되다', '安全 + じゃなくなる', '관용구', 706, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が増えて安全じゃなくなった。', '사고가 늘어 안전하지 않게 되었다.', 1),
    (w, '環境が変わって安全じゃなくなる。', '환경이 바뀌어 안전하지 않게 된다.', 2);

  -- 707. 落ち込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '落ち込む', 'おちこむ', '낙담하다, 악화되다', '落ち + 込む', '동사', 707, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験に失敗して落ち込んだ。', '시험에 실패해 낙담했다.', 1),
    (w, '売上が落ち込む。', '매출이 떨어진다.', 2);

  -- 708. がっかりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'がっかりする', '실망하다, 낙담하다', '관용 동사', '동사', 708, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果にがっかりした。', '결과에 실망했다.', 1),
    (w, '彼の態度にがっかりした。', '그의 태도에 실망했다.', 2);

  -- 709. 精いっぱい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '精いっぱい', 'せいいっぱい', '힘껏', '精 + 一杯', '부사', 709, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '精いっぱい頑張った。', '힘껏 노력했다.', 1),
    (w, '精いっぱいの努力をした。', '힘껏 노력했다.', 2);

  -- 710. 一生懸命
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一生懸命', 'いっしょうけんめい', '열심히', '一生 + 懸命', '부사', 710, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一生懸命勉強する。', '열심히 공부한다.', 1),
    (w, '彼は一生懸命働く。', '그는 열심히 일한다.', 2);

  -- 711. 同情する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '同情する', 'どうじょうする', '동정하다', '同 + 情', '동사', 711, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不幸な話に同情した。', '불행한 이야기에 동정했다.', 1),
    (w, '彼の境遇に同情する。', '그의 처지에 동정한다.', 2);

  -- 712. かわいそうだと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'かわいそうだと思う', 'かわいそうだとおもう', '불쌍하게 생각하다', 'かわいそう + 思う', '관용구', 712, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供をかわいそうだと思った。', '아이를 불쌍하게 생각했다.', 1),
    (w, '見捨てられた犬をかわいそうだと思う。', '버려진 개를 불쌍하게 생각한다.', 2);

  -- 713. 定める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '定める', 'さだめる', '정하다, 결정하다', '定(정할 정)', '동사', 713, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規則を定めた。', '규칙을 정했다.', 1),
    (w, '方針を定める必要がある。', '방침을 정할 필요가 있다.', 2);

  -- 714. 決める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '決める', 'きめる', '정하다, 결정하다', '決(결단할 결)', '동사', 714, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '進路を決めた。', '진로를 결정했다.', 1),
    (w, '旅行先を決める。', '여행지를 결정한다.', 2);

  -- 715. ハードな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ハードな', 'ハードな', '엄격한, 고된', '외래어 (hard)', 'な형용사', 715, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ハードな練習が続いた。', '고된 연습이 이어졌다.', 1),
    (w, 'ハードなスケジュールをこなす。', '고된 스케줄을 소화한다.', 2);

  -- 716. 大変な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '大変な', 'たいへんな', '힘든', '大 + 変', 'な형용사', 716, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大変な仕事を任された。', '힘든 일을 맡았다.', 1),
    (w, '大変な思いをして合格した。', '힘든 노력 끝에 합격했다.', 2);

  -- 717. 動揺する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '動揺する', 'どうようする', '동요하다', '動 + 揺', '동사', 717, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '突然のニュースに動揺した。', '갑작스러운 뉴스에 동요했다.', 1),
    (w, '彼は動揺した様子だ。', '그는 동요한 모습이다.', 2);

  -- 718. 不安になる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '不安になる', 'ふあんになる', '불안해지다', '不安 + なる', '관용구', 718, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験前は不安になる。', '시험 전에는 불안해진다.', 1),
    (w, '将来が不安になる。', '미래가 불안해진다.', 2);

  -- 719. 引き返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '引き返す', 'ひきかえす', '되돌아가다, 되돌아오다', '引き + 返す', '동사', 719, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忘れ物に気付いて引き返した。', '물건을 잊은 걸 알고 되돌아갔다.', 1),
    (w, '途中で引き返すことになった。', '도중에 되돌아오게 되었다.', 2);

  -- 720. 戻る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '戻る', 'もどる', '되돌아가다, 되돌아오다', '戻(돌아올 려)', '동사', 720, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発点に戻った。', '출발점으로 돌아왔다.', 1),
    (w, '元の場所に戻る。', '원래 장소로 돌아간다.', 2);

  -- 721. 一層
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一層', 'いっそう', '한층 더, 더욱더', '一 + 層', '부사', 721, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一層努力したい。', '한층 더 노력하고 싶다.', 1),
    (w, '彼は一層成長した。', '그는 한층 더 성장했다.', 2);

  -- 722. もっと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'もっと', '더, 더욱', '관용 부사', '부사', 722, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと頑張ろう。', '더 노력하자.', 1),
    (w, 'もっと早く起きるべきだ。', '더 일찍 일어나야 한다.', 2);

  -- 723. かかりつけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かかりつけ', '단골', '관용 명사', '명사', 723, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かかりつけの病院がある。', '단골 병원이 있다.', 1),
    (w, 'かかりつけの医者に相談した。', '단골 의사에게 상담했다.', 2);

  -- 724. いつも行く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'いつも行く', 'いつもいく', '늘 가다', 'いつも + 行く', '관용구', 724, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつも行くカフェだ。', '늘 가는 카페다.', 1),
    (w, 'いつも行く店が閉まっていた。', '늘 가는 가게가 닫혀 있었다.', 2);

  -- 725. ガイド
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ガイド', '가이드, 안내', '외래어 (guide)', '명사', 725, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行のガイドを頼んだ。', '여행 가이드를 부탁했다.', 1),
    (w, 'ガイドが詳しく説明した。', '가이드가 자세히 설명했다.', 2);

  -- 726. 案内
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '案内', 'あんない', '안내', '案 + 内', '명사', 726, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅員が道案内をしてくれた。', '역무원이 길 안내를 해 주었다.', 1),
    (w, '会場の案内を読んだ。', '회장 안내를 읽었다.', 2);

  -- 727. 真剣に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '真剣に', 'しんけんに', '진지하게', '真 + 剣', '부사', 727, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真剣に取り組む。', '진지하게 임한다.', 1),
    (w, '真剣に話し合った。', '진지하게 의논했다.', 2);

  -- 728. まじめに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'まじめに', '진지하게, 성실하게', '관용 부사', '부사', 728, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まじめに勉強している。', '성실하게 공부하고 있다.', 1),
    (w, 'まじめに考えてほしい。', '진지하게 생각해 줬으면 한다.', 2);

  -- 729. あまりいない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'あまりいない', '별로 없다', 'あまり + いない', '관용구', 729, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう人はあまりいない。', '그런 사람은 별로 없다.', 1),
    (w, '平日の昼間はあまりいない。', '평일 낮에는 별로 없다.', 2);

  -- 730. 終日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '終日', 'しゅうじつ', '종일', '終 + 日', '명사', 730, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '終日雨が降った。', '종일 비가 내렸다.', 1),
    (w, '終日会議があった。', '종일 회의가 있었다.', 2);

  -- 731. 一日中
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一日中', 'いちにちじゅう', '하루 종일', '一日 + 中', '부사', 731, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一日中外で過ごした。', '하루 종일 밖에서 보냈다.', 1),
    (w, '一日中働いて疲れた。', '하루 종일 일해서 피곤하다.', 2);

  -- 732. いじる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いじる', '만지다', '관용 동사', '동사', 732, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '髪をいじる癖がある。', '머리를 만지는 버릇이 있다.', 1),
    (w, 'スマホをいじっている。', '스마트폰을 만지작거리고 있다.', 2);

  -- 733. 触る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '触る', 'さわる', '만지다', '触(닿을 촉)', '동사', 733, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '展示品に触らないでください。', '전시품을 만지지 마세요.', 1),
    (w, '柔らかい布に触る。', '부드러운 천을 만진다.', 2);

  -- 734. 失望する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '失望する', 'しつぼうする', '실망하다', '失 + 望', '동사', 734, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果に失望した。', '결과에 실망했다.', 1),
    (w, '彼の発言に失望した。', '그의 발언에 실망했다.', 2);

  -- 735. とりかかる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'とりかかる', '착수하다', '관용 동사', '동사', 735, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいプロジェクトにとりかかる。', '새 프로젝트에 착수한다.', 1),
    (w, '早めに作業にとりかかった。', '빨리 작업에 착수했다.', 2);

  -- 736. 仕事を始める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '仕事を始める', 'しごとをはじめる', '일을 시작하다', '仕事 + 始める', '관용구', 736, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝早く仕事を始める。', '아침 일찍 일을 시작한다.', 1),
    (w, '新しい仕事を始める日だ。', '새 일을 시작하는 날이다.', 2);

  -- 737. 人柄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '人柄', 'ひとがら', '인품', '人 + 柄', '명사', 737, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は人柄が良い。', '그는 인품이 좋다.', 1),
    (w, '人柄が信頼を生む。', '인품이 신뢰를 낳는다.', 2);

  -- 738. 性格
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '性格', 'せいかく', '성격', '性 + 格', '명사', 738, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は明るい性格だ。', '그녀는 밝은 성격이다.', 1),
    (w, '性格が合う友人だ。', '성격이 맞는 친구다.', 2);

  -- 739. 案の定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '案の定', 'あんのじょう', '아니나 다를까', '案 + 定', '부사', 739, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '案の定、雨が降った。', '아니나 다를까 비가 왔다.', 1),
    (w, '案の定彼は遅刻した。', '아니나 다를까 그는 지각했다.', 2);

  -- 740. やっぱり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'やっぱり', '역시', '관용 부사', '부사', 740, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やっぱり君が正しい。', '역시 네가 맞다.', 1),
    (w, 'やっぱり手作りは美味しい。', '역시 수제는 맛있다.', 2);

  -- 741. くるむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'くるむ', '감싸다', '관용 동사', '동사', 741, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤ちゃんを毛布でくるんだ。', '아기를 담요로 감쌌다.', 1),
    (w, 'お弁当をハンカチでくるむ。', '도시락을 손수건으로 감싼다.', 2);

  -- 742. 包む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '包む', 'つつむ', '싸다', '包(쌀 포)', '동사', 742, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プレゼントを包んだ。', '선물을 포장했다.', 1),
    (w, 'マフラーで首を包む。', '목도리로 목을 감싼다.', 2);

  -- 743. 最寄り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '最寄り', 'もより', '가장 가까움', '最 + 寄り', '명사', 743, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最寄りの駅まで歩く。', '가장 가까운 역까지 걷는다.', 1),
    (w, '最寄りのコンビニで買い物した。', '가장 가까운 편의점에서 쇼핑했다.', 2);

  -- 744. 一番近い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一番近い', 'いちばんちかい', '가장 가깝다', '一番 + 近い', '관용구', 744, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一番近い病院を探した。', '가장 가까운 병원을 찾았다.', 1),
    (w, '駅から一番近いホテルだ。', '역에서 가장 가까운 호텔이다.', 2);

  -- 745. レンタル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'レンタル', '렌탈, 대여', '외래어 (rental)', '명사', 745, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自転車のレンタルを利用した。', '자전거 대여를 이용했다.', 1),
    (w, 'レンタル料金を支払った。', '렌탈 요금을 지불했다.', 2);

  -- 746. 指図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '指図', 'さしず', '지시', '指 + 図', '명사', 746, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の指図に従う。', '상사의 지시에 따른다.', 1),
    (w, '細かい指図はしない。', '세세한 지시는 하지 않는다.', 2);

  -- 747. 命令
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '命令', 'めいれい', '명령', '命 + 令', '명사', 747, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軍人は命令に従う。', '군인은 명령에 따른다.', 1),
    (w, '命令を出した。', '명령을 내렸다.', 2);

  -- 748. 欠かせない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '欠かせない', 'かかせない', '빠뜨릴 수 없다', '欠かす + ない', '관용구', 748, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は欠かせないメンバーだ。', '그는 없어서는 안 될 멤버다.', 1),
    (w, '毎朝のコーヒーは欠かせない。', '매일 아침의 커피는 빠뜨릴 수 없다.', 2);

  -- 749. ないと困る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ないと困る', 'ないとこまる', '없으면 곤란하다', 'ない + 困る', '관용구', 749, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞書がないと困る。', '사전이 없으면 곤란하다.', 1),
    (w, '車がないと困る生活だ。', '차가 없으면 곤란한 생활이다.', 2);

  -- 750. 依然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '依然', 'いぜん', '여전히', '依 + 然', '명사', 750, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '依然として状況は厳しい。', '여전히 상황은 어렵다.', 1),
    (w, '依然連絡がない。', '여전히 연락이 없다.', 2);

  -- 751. まだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'まだ', '아직', '관용 부사', '부사', 751, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まだ完成していない。', '아직 완성되지 않았다.', 1),
    (w, 'まだ時間がある。', '아직 시간이 있다.', 2);

  -- 752. 再三
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '再三', 'さいさん', '여러 번', '再 + 三', '부사', 752, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '再三お願いしている。', '여러 번 부탁하고 있다.', 1),
    (w, '再三注意したのに直らない。', '여러 번 주의했는데도 고쳐지지 않는다.', 2);

  -- 753. でたらめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'でたらめ', '엉터리', '관용 명사', '명사', 753, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'でたらめな話を信じてしまった。', '엉터리 이야기를 믿어 버렸다.', 1),
    (w, 'でたらめな計算をした。', '엉터리 계산을 했다.', 2);

  -- 754. うそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'うそ', '거짓말', '관용 명사', '명사', 754, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はうそをつかない。', '그는 거짓말을 하지 않는다.', 1),
    (w, 'うそが平気な人は信用できない。', '거짓말을 태연히 하는 사람은 신뢰할 수 없다.', 2);

  -- 755. 勘定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '勘定', 'かんじょう', '지불, 계산', '勘 + 定', '명사', 755, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勘定を済ませて店を出た。', '계산을 마치고 가게를 나왔다.', 1),
    (w, '勘定が合わない。', '계산이 맞지 않는다.', 2);

  -- 756. 会計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '会計', 'かいけい', '회계, 계산', '会 + 計', '명사', 756, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お会計をお願いします。', '계산 부탁드립니다.', 1),
    (w, '会計部門で働いている。', '회계 부서에서 일하고 있다.', 2);

  -- 757. さわがしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'さわがしい', '시끄럽다', '관용 형용사', 'い형용사', 757, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教室がさわがしい。', '교실이 시끄럽다.', 1),
    (w, '駅前はさわがしい。', '역 앞은 시끄럽다.', 2);

  -- 758. 書籍
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '書籍', 'しょせき', '서적', '書 + 籍', '명사', 758, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '専門書籍を購入した。', '전문 서적을 구입했다.', 1),
    (w, '書籍販売サイトを利用した。', '서적 판매 사이트를 이용했다.', 2);

  -- 759. 本
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '本', 'ほん', '책', '本(근본 본)', '명사', 759, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい本を買った。', '새 책을 샀다.', 1),
    (w, '毎晩本を読んでいる。', '매일 밤 책을 읽고 있다.', 2);

  -- 760. すっかり変わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'すっかり変わる', 'すっかりかわる', '완전히 바뀌다', 'すっかり + 変わる', '관용구', 760, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '街並みがすっかり変わった。', '거리 풍경이 완전히 바뀌었다.', 1),
    (w, '彼の人柄がすっかり変わった。', '그의 인품이 완전히 바뀌었다.', 2);

  -- 761. とがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'とがる', '뾰족해지다', '관용 동사', '동사', 761, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鉛筆の先がとがった。', '연필 끝이 뾰족해졌다.', 1),
    (w, '彼の言葉がとがってきた。', '그의 말이 날카로워졌다.', 2);

  -- 762. 細くなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '細くなる', 'ほそくなる', '가늘어지다', '細い + なる', '관용구', 762, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '紐が細くなった。', '끈이 가늘어졌다.', 1),
    (w, '彼女は細くなった。', '그녀는 날씬해졌다.', 2);

  -- 763. くだらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'くだらない', '시시하다', '관용 형용사', 'い형용사', 763, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'くだらない冗談だ。', '시시한 농담이다.', 1),
    (w, 'くだらない話で時間を潰した。', '시시한 이야기로 시간을 보냈다.', 2);

  -- 764. 価値がない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '価値がない', 'かちがない', '가치가 없다', '価値 + ない', '관용구', 764, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い切手は価値がない。', '낡은 우표는 가치가 없다.', 1),
    (w, '時間を無駄にする価値がない。', '시간을 낭비할 가치가 없다.', 2);

  -- 765. 惜しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '惜しい', 'おしい', '아깝다', '惜(아낄 석)', 'い형용사', 765, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あと一歩で惜しかった。', '한 발짝 차이로 아쉬웠다.', 1),
    (w, '時間が惜しい。', '시간이 아깝다.', 2);

  -- 766. もったいない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'もったいない', '아깝다', '관용 형용사', 'い형용사', 766, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べ物を捨てるのはもったいない。', '음식을 버리는 것은 아깝다.', 1),
    (w, '時間がもったいない。', '시간이 아깝다.', 2);

  -- 767. 概要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '概要', 'がいよう', '개요', '概 + 要', '명사', 767, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の概要を説明した。', '계획의 개요를 설명했다.', 1),
    (w, '事件の概要を伝えた。', '사건의 개요를 전했다.', 2);

  -- 768. 大体の内容
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '大体の内容', 'だいたいのないよう', '대체적인 내용', '大体 + 内容', '관용구', 768, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大体の内容は把握した。', '대체적인 내용은 파악했다.', 1),
    (w, '大体の内容を要約した。', '대체적인 내용을 요약했다.', 2);

  -- 769. 油断している
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '油断している', 'ゆだんしている', '방심하고 있다', '油断 + する', '관용구', 769, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近、油断している様子だ。', '최근 방심하고 있는 모습이다.', 1),
    (w, '試験前なのに油断している。', '시험 전인데 방심하고 있다.', 2);

  -- 770. 気を付けていない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '気を付けていない', 'きをつけていない', '조심하지 않는다', '気を付ける 부정', '관용구', 770, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は健康に気を付けていない。', '그는 건강에 신경 쓰지 않는다.', 1),
    (w, '足元に気を付けていないと転ぶ。', '발밑을 조심하지 않으면 넘어진다.', 2);

  -- 771. 各自
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '各自', 'かくじ', '각자', '各 + 自', '명사', 771, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '各自で準備してください。', '각자 준비해 주세요.', 1),
    (w, '各自の意見を述べた。', '각자의 의견을 말했다.', 2);

  -- 772. 一人一人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一人一人', 'ひとりひとり人', '한사람 한사람', '一人 + 一人', '부사', 772, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人一人に丁寧に対応する。', '한 사람 한 사람에게 정중히 대응한다.', 1),
    (w, '一人一人の声を大切にする。', '한 사람 한 사람의 목소리를 소중히 한다.', 2);

  -- 773. 深刻な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '深刻な', 'しんこくな', '심각한', '深 + 刻', 'な형용사', 773, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '深刻な問題に直面した。', '심각한 문제에 직면했다.', 1),
    (w, '彼は深刻な表情をしていた。', '그는 심각한 표정을 짓고 있었다.', 2);

  -- 774. 重大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '重大な', 'じゅうだいな', '중대한', '重 + 大', 'な형용사', 774, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重大な責任を負う。', '중대한 책임을 진다.', 1),
    (w, '重大な決断を下した。', '중대한 결단을 내렸다.', 2);

  -- 775. 同僚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '同僚', 'どうりょう', '동료', '同 + 僚', '명사', 775, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同僚と昼食を取った。', '동료와 점심을 먹었다.', 1),
    (w, '彼は信頼できる同僚だ。', '그는 신뢰할 수 있는 동료다.', 2);

  -- 776. 同じ会社の人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '同じ会社の人', 'おなじかいしゃのひと', '같은 회사 사람', '同じ + 会社 + 人', '관용구', 776, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は同じ会社の人だ。', '그는 같은 회사 사람이다.', 1),
    (w, '同じ会社の人と旅行に行った。', '같은 회사 사람과 여행에 갔다.', 2);

  -- 777. おおよそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おおよそ', '대략', '관용 부사', '부사', 777, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおよそ三十分かかる。', '대략 30분 걸린다.', 1),
    (w, 'おおよその金額を見積もった。', '대략적인 금액을 견적냈다.', 2);

  -- 778. 大体
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '大体', 'だいたい', '대충', '大 + 体', '부사', 778, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大体の場所は分かる。', '대충의 장소는 안다.', 1),
    (w, '大体の予定を伝えた。', '대체적인 예정을 전했다.', 2);

  -- 779. マナー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'マナー', '매너, 예의', '외래어 (manner)', '명사', 779, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テーブルマナーを学んだ。', '테이블 매너를 배웠다.', 1),
    (w, 'マナーが良い人は好かれる。', '매너가 좋은 사람은 호감을 산다.', 2);

  -- 780. 行儀
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '行儀', 'ぎょうぎ', '예의, 예절', '行 + 儀', '명사', 780, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に行儀を教える。', '아이에게 예절을 가르친다.', 1),
    (w, '行儀よく食事する。', '예의 바르게 식사한다.', 2);

  -- 781. いばる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いばる', '뽐내다', '威張る', '동사', 781, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は地位をいばる。', '그는 지위를 뽐낸다.', 1),
    (w, 'いばる態度は嫌われる。', '뽐내는 태도는 미움받는다.', 2);

  -- 782. 偉そうな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '偉そうな', 'えらそうな', '잘난 체하는', '偉 + そう', 'な형용사', 782, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は偉そうな態度を取る。', '그는 잘난 체하는 태도를 취한다.', 1),
    (w, '偉そうな口を聞く人は嫌だ。', '잘난 체하는 말투를 쓰는 사람은 싫다.', 2);

  -- 783. 収納
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '収納', 'しゅうのう', '수납', '収 + 納', '명사', 783, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '収納スペースを増やした。', '수납 공간을 늘렸다.', 1),
    (w, '収納家具を購入した。', '수납 가구를 구입했다.', 2);

  -- 784. しまう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'しまう', 'しまう', '(물건  등을)넣다', '관용 동사', '동사', 784, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '服をクローゼットにしまう。', '옷을 옷장에 넣는다.', 1),
    (w, '大切なものは金庫にしまう。', '중요한 것은 금고에 넣는다.', 2);

  -- 785. 修正する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '修正する', 'しゅうせいする', '수정하다', '修 + 正', '동사', 785, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '報告書を修正した。', '보고서를 수정했다.', 1),
    (w, '設計を修正する必要がある。', '설계를 수정할 필요가 있다.', 2);

  -- 786. 直す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '直す', 'なおす', '고치다', '直(곧을 직)', '동사', 786, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '壊れた時計を直した。', '망가진 시계를 고쳤다.', 1),
    (w, '悪い癖を直したい。', '나쁜 버릇을 고치고 싶다.', 2);

  -- 787. 次第に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '次第に', 'しだいに', '점차, 점점', '次 + 第', '부사', 787, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '次第に春らしくなってきた。', '점차 봄다워지고 있다.', 1),
    (w, '次第に話が広まった。', '점차 이야기가 퍼졌다.', 2);

  -- 788. はげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'はげる', '벗겨지다', '관용 동사', '동사', 788, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ペンキがはげてきた。', '페인트가 벗겨지기 시작했다.', 1),
    (w, '看板の色がはげる。', '간판 색이 벗겨진다.', 2);

  -- 789. 取れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '取れる', 'とれる', '떨어지다', '取 + れる', '동사', 789, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボタンが取れた。', '단추가 떨어졌다.', 1),
    (w, 'シミが取れない。', '얼룩이 빠지지 않는다.', 2);

  -- 790. しぐさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しぐさ', '행위', '관용 명사', '명사', 790, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼のしぐさが愛らしい。', '그의 행동이 사랑스럽다.', 1),
    (w, '子供のしぐさを観察する。', '아이의 동작을 관찰한다.', 2);

  -- 791. 動作
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '動作', 'どうさ', '동작', '動 + 作', '명사', 791, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の動作は機敏だ。', '그의 동작은 민첩하다.', 1),
    (w, '動作確認をしてください。', '동작 확인을 해 주세요.', 2);

  -- 792. 取材
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '取材', 'しゅざい', '취재', '取 + 材', '명사', 792, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新聞記者が取材に来た。', '신문 기자가 취재하러 왔다.', 1),
    (w, '現場で取材を行った。', '현장에서 취재를 진행했다.', 2);

  -- 793. 外す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '外す', 'はずす', '떼어 내다, 밖으로 빼내다', '外(바깥 외)', '동사', 793, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '眼鏡を外して休む。', '안경을 벗고 쉰다.', 1),
    (w, '席を一時的に外す。', '자리를 잠시 비운다.', 2);

  -- 794. きっかけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'きっかけ', '계기', '관용 명사', '명사', 794, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行がきっかけで結婚した。', '여행이 계기로 결혼했다.', 1),
    (w, 'きっかけがあれば挑戦したい。', '계기가 있으면 도전하고 싶다.', 2);

  -- 795. 注目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '注目', 'ちゅうもく', '주목', '注 + 目', '명사', 795, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の発表に注目が集まった。', '그의 발표에 주목이 모였다.', 1),
    (w, '新製品が注目を浴びている。', '신제품이 주목받고 있다.', 2);

  -- 796. 外見
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '外見', 'がいけん', '외관, 겉보기', '外 + 見', '명사', 796, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外見だけで人を判断するな。', '외모만으로 사람을 판단하지 마.', 1),
    (w, '外見にこだわる必要はない。', '외관에 집착할 필요는 없다.', 2);

  -- 797. 保つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '保つ', 'たもつ', '유지하다, 보존하다', '保(보전할 보)', '동사', 797, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を保つために運動する。', '건강을 유지하기 위해 운동한다.', 1),
    (w, '良い関係を保ちたい。', '좋은 관계를 유지하고 싶다.', 2);

  -- 798. 方針
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '方針', 'ほうしん', '방침', '方 + 針', '명사', 798, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の方針を決めた。', '회사 방침을 정했다.', 1),
    (w, '新しい方針を発表した。', '새 방침을 발표했다.', 2);

  -- 799. 範囲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '範囲', 'はんい', '범위', '範 + 囲', '명사', 799, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験の範囲が広い。', '시험의 범위가 넓다.', 1),
    (w, '責任の範囲を明確にする。', '책임의 범위를 명확히 한다.', 2);

  -- 800. せめて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'せめて', '적어도, 하다못해', '관용 부사', '부사', 800, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'せめて連絡してほしかった。', '적어도 연락해 줬으면 했다.', 1),
    (w, 'せめて一度は会いたい。', '하다못해 한 번은 만나고 싶다.', 2);

  -- 801. 質素な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '質素な', 'しっそな', '검소한', '質 + 素', 'な형용사', 801, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質素な生活を送る。', '검소한 생활을 한다.', 1),
    (w, '質素な暮らしが性に合う。', '검소한 생활이 성격에 맞는다.', 2);

  -- 802. 利益
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '利益', 'りえき', '이익', '利 + 益', '명사', 802, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の利益が増えた。', '회사 이익이 늘었다.', 1),
    (w, 'お互いの利益を考える。', '서로의 이익을 생각한다.', 2);

  -- 803. かなう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'かなう', 'かなう', '(꿈, 희망 등이) 이루어지다', '관용 동사', '동사', 803, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢がついにかなった。', '꿈이 마침내 이루어졌다.', 1),
    (w, '願いがかなうように努力する。', '소원이 이루어지도록 노력한다.', 2);

  -- 804. 受け入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '受け入れる', 'うけいれる', '받아들이다', '受け + 入れる', '동사', 804, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新人を受け入れる準備をした。', '신입을 받아들일 준비를 했다.', 1),
    (w, '彼の意見を受け入れる。', '그의 의견을 받아들인다.', 2);

  -- 805. 廃止
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '廃止', 'はいし', '폐지', '廃 + 止', '명사', 805, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い制度を廃止した。', '낡은 제도를 폐지했다.', 1),
    (w, '不要な規則を廃止する。', '불필요한 규칙을 폐지한다.', 2);

  -- 806. 矛盾
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '矛盾', 'むじゅん', '모순', '矛 + 盾', '명사', 806, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の発言に矛盾がある。', '그의 발언에 모순이 있다.', 1),
    (w, '矛盾を指摘した。', '모순을 지적했다.', 2);

  -- 807. 心強い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '心強い', 'こころづよい', '든든하다', '心 + 強い', 'い형용사', 807, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君がいて心強い。', '네가 있어서 든든하다.', 1),
    (w, '心強い味方ができた。', '든든한 아군이 생겼다.', 2);

  -- 808. 問い合わせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '問い合わせる', 'といあわせる', '문의하다', '問い + 合わせる', '동사', 808, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商品について問い合わせた。', '상품에 대해 문의했다.', 1),
    (w, '料金を問い合わせた。', '요금을 문의했다.', 2);

  -- 809. さっさと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'さっさと', '빨리, 서둘러서', '관용 부사', '부사', 809, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さっさと宿題を済ませた。', '빨리 숙제를 마쳤다.', 1),
    (w, 'さっさと帰ろう。', '빨리 돌아가자.', 2);

  -- 810. 交代
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '交代', 'こうたい', '교대, 교체', '交 + 代', '명사', 810, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交代で運転した。', '교대로 운전했다.', 1),
    (w, 'シフトの交代をお願いする。', '시프트 교체를 부탁한다.', 2);

  -- 811. 塞ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '塞ぐ', 'ふさぐ', '막다, 차단하다', '塞(막을 새)', '동사', 811, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '穴を塞ぐ作業をした。', '구멍을 막는 작업을 했다.', 1),
    (w, '入り口を塞いではいけない。', '입구를 막아서는 안 된다.', 2);

  -- 812. 合同
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '合同', 'ごうどう', '합동', '合 + 同', '명사', 812, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二つの学校が合同で発表した。', '두 학교가 합동으로 발표했다.', 1),
    (w, '合同会社を設立した。', '합동 회사를 설립했다.', 2);

  -- 813. 冷静な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '冷静な', 'れいせいな', '냉정한', '冷 + 静', 'な형용사', 813, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冷静な判断が求められる。', '냉정한 판단이 요구된다.', 1),
    (w, '彼は冷静に対応した。', '그는 냉정하게 대응했다.', 2);

  -- 814. 掲示
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '掲示', 'けいじ', '게시', '掲 + 示', '명사', 814, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お知らせを掲示した。', '알림을 게시했다.', 1),
    (w, '新しいルールが掲示された。', '새 규칙이 게시되었다.', 2);

  -- 815. 補足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '補足', 'ほそく', '보충, 보완', '補 + 足', '명사', 815, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料を補足する。', '자료를 보충한다.', 1),
    (w, '説明を補足してください。', '설명을 보충해 주세요.', 2);

  -- 816. 快い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '快い', 'こころよい', '기분 좋다, 유쾌하다', '快(쾌할 쾌)', 'い형용사', 816, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '快い風が吹いている。', '유쾌한 바람이 불고 있다.', 1),
    (w, '快い返事をもらった。', '기분 좋은 답을 받았다.', 2);

  -- 817. 慌ただしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '慌ただしい', 'あわただしい', '분주하다, 어수선하다', '慌(다급할 황)', 'い형용사', 817, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '慌ただしい朝を過ごす。', '분주한 아침을 보낸다.', 1),
    (w, '慌ただしい一日だった。', '분주한 하루였다.', 2);

  -- 818. 分野
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '分野', 'ぶんや', '분야', '分 + 野', '명사', 818, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は科学分野の専門家だ。', '그는 과학 분야의 전문가다.', 1),
    (w, '新しい分野に挑戦する。', '새로운 분야에 도전한다.', 2);

  -- 819. かすかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かすかな', '희미한', '관용 형용사', 'な형용사', 819, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かすかな光が見えた。', '희미한 빛이 보였다.', 1),
    (w, 'かすかな音がした。', '희미한 소리가 났다.', 2);

  -- 820. 生き生き
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '生き生き', 'いきいき', '생기가 넘치는 모양', '生(살 생)', '부사', 820, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は生き生きと働いている。', '그녀는 생기 있게 일하고 있다.', 1),
    (w, '生き生きした表情で話す。', '생기 있는 표정으로 말한다.', 2);

  -- 821. 催促
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '催促', 'さいそく', '재촉', '催 + 促', '명사', 821, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '返事を催促された。', '답을 재촉받았다.', 1),
    (w, '支払いの催促が来た。', '지불 재촉이 왔다.', 2);

  -- 822. 隔てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '隔てる', 'へだてる', '멀리하다, 사이에 두다', '隔(사이뜰 격)', '동사', 822, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川を隔てて村がある。', '강을 사이에 두고 마을이 있다.', 1),
    (w, '彼との距離を隔ててしまった。', '그와의 거리를 멀리하게 됐다.', 2);

  -- 823. ものたりない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ものたりない', '조금 부족하다, 어딘가 아쉽다', '관용 형용사', 'い형용사', 823, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '味がものたりない。', '맛이 부족하다.', 1),
    (w, '量がものたりない。', '양이 부족하다.', 2);

  -- 824. 頑丈な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頑丈な', 'がんじょうな', '튼튼한', '頑 + 丈', 'な형용사', 824, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑丈な体を作る。', '튼튼한 몸을 만든다.', 1),
    (w, '頑丈なバッグを買った。', '튼튼한 가방을 샀다.', 2);

  -- 825. 会見
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '会見', 'かいけん', '회견', '会 + 見', '명사', 825, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記者会見を開いた。', '기자 회견을 열었다.', 1),
    (w, '首脳会見が行われた。', '정상회담이 열렸다.', 2);

  -- 826. 畳む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '畳む', 'たたむ', '접다, 개다', '畳(겹쳐질 첩)', '동사', 826, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '洗濯物を畳んだ。', '빨래를 갰다.', 1),
    (w, '椅子を畳んでしまった。', '의자를 접어 두었다.', 2);

  -- 827. 支持
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '支持', 'しじ', '지지', '支 + 持', '명사', 827, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の意見を支持した。', '그의 의견을 지지했다.', 1),
    (w, '大多数の支持を得た。', '대다수의 지지를 얻었다.', 2);

  -- 828. 合図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '合図', 'あいず', '신호', '合 + 図', '명사', 828, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手で合図を送った。', '손으로 신호를 보냈다.', 1),
    (w, '発射の合図を待つ。', '발사 신호를 기다린다.', 2);

  -- 829. 妥当な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '妥当な', 'だとうな', '타당한', '妥 + 当', 'な형용사', 829, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妥当な解決策を見つけた。', '타당한 해결책을 찾았다.', 1),
    (w, '妥当な価格で契約した。', '타당한 가격으로 계약했다.', 2);

  -- 830. こつこつと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'こつこつと', '꾸준하게', '의태어 (꾸준히 두드리는 모양)', '부사', 830, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こつこつと努力する。', '꾸준히 노력한다.', 1),
    (w, 'こつこつと貯金している。', '꾸준히 저축하고 있다.', 2);

  -- 831. 言い訳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '言い訳', 'いいわけ', '변명', '言い + 訳', '명사', 831, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言い訳をしないで。', '변명하지 마.', 1),
    (w, '言い訳ばかり並べる。', '변명만 늘어놓는다.', 2);

  -- 832. 手軽な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '手軽な', 'てがるな', '손쉬운, 간편한', '手 + 軽', 'な형용사', 832, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手軽に作れる料理だ。', '손쉽게 만들 수 있는 요리다.', 1),
    (w, '手軽な値段で買える。', '간편한 가격에 살 수 있다.', 2);

  -- 833. 温暖な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '温暖な', 'おんだんな', '온난한', '温 + 暖', 'な형용사', 833, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '温暖な気候の地域だ。', '온난한 기후의 지역이다.', 1),
    (w, '温暖化が進んでいる。', '온난화가 진행되고 있다.', 2);

  -- 834. 作成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '作成', 'さくせい', '작성', '作 + 成', '명사', 834, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書類を作成した。', '서류를 작성했다.', 1),
    (w, '計画書の作成に時間がかかる。', '계획서 작성에 시간이 걸린다.', 2);

  -- 835. 振り向く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '振り向く', 'ふりむく', '돌아보다', '振り + 向く', '동사', 835, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を呼ばれて振り向いた。', '이름을 불려 돌아봤다.', 1),
    (w, '過去を振り向く時間がない。', '과거를 돌아볼 시간이 없다.', 2);

  -- 836. いったん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'いったん', '일단', '관용 부사', '부사', 836, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いったん家に帰る。', '일단 집에 간다.', 1),
    (w, 'いったん決めたら変えない。', '일단 결정하면 바꾸지 않는다.', 2);

  -- 837. 用途
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '用途', 'ようと', '용도', '用 + 途', '명사', 837, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道具の用途は何ですか。', '이 도구의 용도는 무엇입니까?', 1),
    (w, '用途に応じて選ぶ。', '용도에 따라 고른다.', 2);

  -- 838. 思いつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '思いつく', 'おもいつく', '생각이 떠오르다', '思い + つく', '동사', 838, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名案を思いついた。', '묘안이 떠올랐다.', 1),
    (w, 'いいアイデアを思いつく。', '좋은 아이디어가 떠오른다.', 2);

  -- 839. 甘やかす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '甘やかす', 'あまやかす', '응석을 받아 주다', '甘(달 감) + やかす', '동사', 839, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供を甘やかすのは良くない。', '아이를 응석 받아 주는 것은 좋지 않다.', 1),
    (w, '彼は犬を甘やかしている。', '그는 개를 응석 받아 주고 있다.', 2);

  -- 840. 中断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '中断', 'ちゅうだん', '중단', '中 + 断', '명사', 840, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合は雨で中断した。', '시합은 비로 중단되었다.', 1),
    (w, 'プロジェクトを中断する。', '프로젝트를 중단한다.', 2);

  -- 841. 行方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '行方', 'ゆくえ', '행방', '行 + 方', '명사', 841, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行方を捜している。', '행방을 찾고 있다.', 1),
    (w, '行方不明者が見つかった。', '행방 불명자가 발견됐다.', 2);

  -- 842. たくましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'たくましい', '씩씩하다, 늠름하다', '관용 형용사', 'い형용사', 842, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たくましい青年に成長した。', '씩씩한 청년으로 성장했다.', 1),
    (w, 'たくましい身体を作る。', '늠름한 몸을 만든다.', 2);

  -- 843. 発達
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '発達', 'はったつ', '발달', '発 + 達', '명사', 843, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供の発達を見守る。', '아이의 발달을 지켜본다.', 1),
    (w, '技術の発達が著しい。', '기술의 발달이 두드러진다.', 2);

  -- 844. 延長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '延長', 'えんちょう', '연장', '延 + 長', '명사', 844, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議が延長された。', '회의가 연장되었다.', 1),
    (w, '契約を延長することにした。', '계약을 연장하기로 했다.', 2);

  -- 845. さびる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'さびる', '녹슬다', '관용 동사', '동사', 845, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鉄が雨でさびた。', '쇠가 비로 녹슬었다.', 1),
    (w, '古い自転車がさびる。', '낡은 자전거가 녹슨다.', 2);

  -- 846. 引退
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '引退', 'いんたい', '은퇴', '引 + 退', '명사', 846, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選手が引退を発表した。', '선수가 은퇴를 발표했다.', 1),
    (w, '引退後は趣味に専念する。', '은퇴 후에는 취미에 전념한다.', 2);

  -- 847. 目上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '目上', 'めうえ', '손윗사람, 연장자', '目 + 上', '명사', 847, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目上の人に敬意を払う。', '손윗사람에게 경의를 표한다.', 1),
    (w, '目上の人と話す。', '연장자와 이야기한다.', 2);

  -- 848. おおげさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'おおげさ', '과장', '관용 명사', '명사', 848, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおげさに表現するのは良くない。', '과장해서 표현하는 것은 좋지 않다.', 1),
    (w, 'おおげさな反応に驚いた。', '과장된 반응에 놀랐다.', 2);

  -- 849. 生じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '生じる', 'しょうじる', '생기다', '生 + じる', '동사', 849, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題が生じた。', '문제가 생겼다.', 1),
    (w, '新しい疑問が生じる。', '새로운 의문이 생긴다.', 2);

  -- 850. 反省
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '反省', 'はんせい', '반성', '反 + 省', '명사', 850, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '過去を反省した。', '과거를 반성했다.', 1),
    (w, '失敗を反省する。', '실패를 반성한다.', 2);

  -- 851. 頂上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頂上', 'ちょうじょう', '정상', '頂 + 上', '명사', 851, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山の頂上に到達した。', '산 정상에 도달했다.', 1),
    (w, '頂上からの景色は素晴らしい。', '정상에서의 경치는 훌륭하다.', 2);

  -- 852. 分解
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '分解', 'ぶんかい', '분해', '分 + 解', '명사', 852, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時計を分解して修理した。', '시계를 분해해 수리했다.', 1),
    (w, '問題を分解して考える。', '문제를 분해해 생각한다.', 2);

  -- 853. 略す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '略す', 'りゃくす', '줄이다', '略 + す', '동사', 853, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を略して呼ぶ。', '이름을 줄여서 부른다.', 1),
    (w, '説明を略して伝えた。', '설명을 줄여서 전했다.', 2);

  -- 854. 覆う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '覆う', 'おおう', '덮다', '覆(엎을 복)', '동사', 854, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '布で机を覆う。', '천으로 책상을 덮는다.', 1),
    (w, '雪が町を覆っている。', '눈이 마을을 덮고 있다.', 2);

  -- 855. 破る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '破る', 'やぶる', '찢다, 파기하다', '破(깨뜨릴 파)', '동사', 855, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '契約を破ることはできない。', '계약을 파기할 수는 없다.', 1),
    (w, '紙を破って捨てた。', '종이를 찢어 버렸다.', 2);

  -- 856. 限定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '限定', 'げんてい', '한정', '限 + 定', '명사', 856, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '数量限定の商品だ。', '수량 한정 상품이다.', 1),
    (w, '会員限定のイベントだ。', '회원 한정 이벤트다.', 2);

  -- 857. 一斉に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '一斉に', 'いっせいに', '일제히', '一 + 斉', '부사', 857, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生徒たちは一斉に立ち上がった。', '학생들은 일제히 일어섰다.', 1),
    (w, '花火が一斉に上がった。', '불꽃이 일제히 올랐다.', 2);

  -- 858. 散らかす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '散らかす', 'ちらかす', '어지르다, 흩뜨리다', '散 + らかす', '동사', 858, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋を散らかしてしまった。', '방을 어질러 버렸다.', 1),
    (w, '物を散らかすのはやめて。', '물건을 흩뜨리는 것은 그만해.', 2);

  -- 859. 論争
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '論争', 'ろんそう', '논쟁', '論 + 争', '명사', 859, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '激しい論争になった。', '격렬한 논쟁이 되었다.', 1),
    (w, '論争が長引いている。', '논쟁이 길어지고 있다.', 2);

  -- 860. 演説
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '演説', 'えんぜつ', '연설', '演 + 説', '명사', 860, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '候補者が演説をした。', '후보자가 연설을 했다.', 1),
    (w, '彼の演説に感動した。', '그의 연설에 감동했다.', 2);

  -- 861. きっぱり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'きっぱり', '단호히', '의태어 (단호한 모양)', '부사', 861, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'きっぱり断った。', '단호히 거절했다.', 1),
    (w, 'きっぱりした態度を示す。', '단호한 태도를 보인다.', 2);

  -- 862. 保存
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '保存', 'ほぞん', '보존', '保 + 存', '명사', 862, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'データを保存した。', '데이터를 저장했다.', 1),
    (w, '食品を冷蔵で保存する。', '식품을 냉장 보관한다.', 2);

  -- 863. 鈍い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '鈍い', 'にぶい', '둔하다', '鈍(둔할 둔)', 'い형용사', 863, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は反応が鈍い。', '그는 반응이 둔하다.', 1),
    (w, '鈍い痛みが続く。', '둔한 통증이 계속된다.', 2);

  -- 864. 日課
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '日課', 'にっか', '일과', '日 + 課', '명사', 864, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '散歩を日課にしている。', '산책을 일과로 하고 있다.', 1),
    (w, '毎日の日課を決める。', '매일의 일과를 정한다.', 2);

  -- 865. 多彩
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '多彩', 'たさい', '다채', '多 + 彩', '명사', 865, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多彩な行事が行われた。', '다채로운 행사가 열렸다.', 1),
    (w, '彼の趣味は多彩だ。', '그의 취미는 다채롭다.', 2);

  -- 866. 乗り継ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '乗り継ぐ', 'のりつぐ', '다른 탈것으로 갈아타다', '乗り + 継ぐ', '동사', 866, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新幹線からバスに乗り継ぐ。', '신칸센에서 버스로 갈아탄다.', 1),
    (w, '飛行機を乗り継いで現地に着いた。', '비행기를 갈아타고 현지에 도착했다.', 2);

  -- 867. 初歩
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '初歩', 'しょほ', '초보', '初 + 歩', '명사', 867, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初歩から学び直したい。', '초보부터 다시 배우고 싶다.', 1),
    (w, '初歩的なミスをした。', '초보적인 실수를 했다.', 2);

  -- 868. だらしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'だらしない', '단정하지 못하다', '관용 형용사', 'い형용사', 868, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '服装がだらしない。', '복장이 단정치 못하다.', 1),
    (w, 'だらしない態度は嫌われる。', '단정치 못한 태도는 미움받는다.', 2);

  -- 869. 特殊
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '特殊', 'とくしゅ', '특수', '特 + 殊', '명사', 869, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '特殊な技術が必要だ。', '특수한 기술이 필요하다.', 1),
    (w, '特殊なケースとして扱う。', '특수한 케이스로 다룬다.', 2);

  -- 870. しみる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'しみる', '번지다, 스며들다', '관용 동사', '동사', 870, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インクがしみてしまった。', '잉크가 번져 버렸다.', 1),
    (w, '寒さが体にしみる。', '추위가 몸에 스며든다.', 2);

  -- 871. 充満
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '充満', 'じゅうまん', '충만', '充 + 満', '명사', 871, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋にガスが充満している。', '방에 가스가 충만해 있다.', 1),
    (w, '喜びで心が充満した。', '기쁨으로 마음이 가득 찼다.', 2);

  -- 872. めくる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'めくる', '넘기다', '관용 동사', '동사', 872, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本のページをめくった。', '책의 페이지를 넘겼다.', 1),
    (w, 'カレンダーをめくる季節だ。', '달력을 넘기는 계절이다.', 2);

  -- 873. 初期
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '初期', 'しょき', '초기', '初 + 期', '명사', 873, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロジェクトの初期段階だ。', '프로젝트의 초기 단계다.', 1),
    (w, '初期費用が高い。', '초기 비용이 비싸다.', 2);

  -- 874. 打ち明ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '打ち明ける', 'うちあける', '털어놓다, 고백하다', '打ち + 明ける', '동사', 874, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に悩みを打ち明けた。', '친구에게 고민을 털어놓았다.', 1),
    (w, '彼女に気持ちを打ち明ける。', '그녀에게 마음을 고백한다.', 2);

  -- 875. 欠陥
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '欠陥', 'けっかん', '결함', '欠 + 陥', '명사', 875, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '製品に欠陥が見つかった。', '제품에 결함이 발견되었다.', 1),
    (w, '欠陥のない車を選ぶ。', '결함이 없는 차를 고른다.', 2);

  -- 876. 引用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '引用', 'いんよう', '인용', '引 + 用', '명사', 876, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '論文に引用文を入れた。', '논문에 인용문을 넣었다.', 1),
    (w, '名言を引用する。', '명언을 인용한다.', 2);

  -- 877. ほっと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ほっと', '긴장이 풀려 안심하는 모양', '의태어', '부사', 877, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験が終わってほっとした。', '시험이 끝나서 안심했다.', 1),
    (w, '無事を聞いてほっとする。', '무사를 듣고 안심한다.', 2);

  -- 878. 展開
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '展開', 'てんかい', '전개', '展 + 開', '명사', 878, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の展開が予想外だった。', '이야기의 전개가 예상 밖이었다.', 1),
    (w, '新事業を展開する。', '새 사업을 전개한다.', 2);

  -- 879. 妥当
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '妥当', 'だとう', '타당', '妥 + 当', '명사', 879, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妥当な意見だと思う。', '타당한 의견이라고 생각한다.', 1),
    (w, '妥当な金額を提示した。', '타당한 금액을 제시했다.', 2);

  -- 880. かばう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'かばう', '편들다, 두둔하다', '관용 동사', '동사', 880, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟をかばう。', '동생을 두둔한다.', 1),
    (w, '友達をかばって発言した。', '친구를 편들어 발언했다.', 2);

  -- 881. 急激
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '急激', 'きゅうげき', '급격', '急 + 激', '명사', 881, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急激な変化に対応する。', '급격한 변화에 대응한다.', 1),
    (w, '気温が急激に上がった。', '기온이 급격히 올랐다.', 2);

  -- 882. 漏れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '漏れる', 'もれる', '새다', '漏(샐 루)', '동사', 882, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水道から水が漏れる。', '수도에서 물이 샌다.', 1),
    (w, '情報が漏れた可能性がある。', '정보가 샜을 가능성이 있다.', 2);

  -- 883. 傾向
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '傾向', 'けいこう', '경향', '傾 + 向', '명사', 883, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若者の購買傾向を分析する。', '젊은이들의 구매 경향을 분석한다.', 1),
    (w, '最近の傾向を調べる。', '최근의 경향을 조사한다.', 2);

  -- 884. 温厚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '温厚', 'おんこう', '온후, 다정다감함', '温 + 厚', '명사', 884, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の温厚な性格に惹かれた。', '그의 온후한 성격에 끌렸다.', 1),
    (w, '温厚な人柄で慕われている。', '온후한 인품으로 사랑받고 있다.', 2);

  -- 885. 世代
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '世代', 'せだい', '세대', '世 + 代', '명사', 885, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若い世代の意見を聞く。', '젊은 세대의 의견을 듣는다.', 1),
    (w, '世代間のギャップを感じる。', '세대 간 갭을 느낀다.', 2);

  -- 886. 頑固
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '頑固', 'がんこ', '완고', '頑 + 固', '명사', 886, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は頑固な性格だ。', '그는 완고한 성격이다.', 1),
    (w, '頑固な汚れを落とす。', '완고한 때를 제거한다.', 2);

  -- 887. 打ち合わせ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '打ち合わせ', 'うちあわせ', '협의', '打ち + 合わせ', '명사', 887, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の前に打ち合わせをする。', '회의 전에 협의를 한다.', 1),
    (w, 'クライアントとの打ち合わせ。', '클라이언트와의 협의.', 2);

  -- 888. ベテラン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'ベテラン', '베테랑, 고수', '외래어 (veteran)', '명사', 888, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はベテランの料理人だ。', '그는 베테랑 요리사다.', 1),
    (w, 'ベテランの技を学ぶ。', '베테랑의 기술을 배운다.', 2);

  -- 889. 荒れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '荒れる', 'あれる', '거칠어지다, 황폐해지다', '荒(거칠 황)', '동사', 889, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肌が荒れている。', '피부가 거칠어져 있다.', 1),
    (w, '庭が荒れたまま放置された。', '정원이 황폐한 채 방치됐다.', 2);

  -- 890. 早期
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '早期', 'そうき', '조기', '早 + 期', '명사', 890, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早期の発見が大切だ。', '조기 발견이 중요하다.', 1),
    (w, '早期退職を選んだ。', '조기 퇴직을 선택했다.', 2);

  -- 891. 偉大
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '偉大', 'いだい', '위대', '偉 + 大', '명사', 891, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '偉大な業績を残した。', '위대한 업적을 남겼다.', 1),
    (w, '偉大な指導者だった。', '위대한 지도자였다.', 2);

  -- 892. 印
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '印', 'しるし', '표시', '印(도장 인)', '명사', 892, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大事な箇所に印をつけた。', '중요한 부분에 표시를 했다.', 1),
    (w, '賛成のしるしに手を挙げる。', '찬성의 표시로 손을 든다.', 2);

  -- 893. さまたげる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'さまたげる', '방해하다', '관용 동사', '동사', 893, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成長をさまたげる要因だ。', '성장을 방해하는 요인이다.', 1),
    (w, '彼の話をさまたげるな。', '그의 말을 방해하지 마.', 2);

  -- 894. 腫れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '腫れる', 'はれる', '붓다', '腫(부어오를 종)', '동사', 894, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '足が腫れて痛い。', '다리가 부어 아프다.', 1),
    (w, '目が腫れている。', '눈이 부어 있다.', 2);

  -- 895. 上達
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '上達', 'じょうたつ', '기능이 향상됨, 숙달', '上 + 達', '명사', 895, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語が上達した。', '일본어가 늘었다.', 1),
    (w, '練習で上達する。', '연습으로 숙달된다.', 2);

  -- 896. 暮れ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '暮れ', 'くれ', '저물 때', '暮 + れ', '명사', 896, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年の暮れに大掃除をする。', '연말에 대청소를 한다.', 1),
    (w, '夕暮れの空が美しい。', '저물녘 하늘이 아름답다.', 2);

  -- 897. 残高
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '残高', 'ざんだか', '잔액', '残 + 高', '명사', 897, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '口座の残高を確認した。', '계좌 잔액을 확인했다.', 1),
    (w, '残高が足りなくて困った。', '잔액이 부족해 곤란했다.', 2);

  -- 898. 共有
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '共有', 'きょうゆう', '공유', '共 + 有', '명사', 898, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '情報を共有する。', '정보를 공유한다.', 1),
    (w, '経験を共有する仲間。', '경험을 공유하는 동료.', 2);

  -- 899. はきはき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, NULL, 'はきはき', '확실한 모양', '의태어', '부사', 899, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はきはきと答える。', '확실하게 대답한다.', 1),
    (w, 'はきはきした性格だ。', '확실한 성격이다.', 2);

  -- 900. 鑑賞
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '鑑賞', 'かんしょう', '감상', '鑑 + 賞', '명사', 900, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画鑑賞が趣味だ。', '영화 감상이 취미다.', 1),
    (w, '音楽鑑賞をする時間。', '음악 감상을 하는 시간.', 2);

  -- 901. 着々
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '着々', 'ちゅくちゃく', '착착, 순조롭게', '着(붙을 착) → 차곡차곡', '부사', 901, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画は着々と進んでいる。', '계획은 차근차근 진행되고 있다.', 1),
    (w, '準備が着々と整っている。', '준비가 착착 진행되고 있다.', 2);

  -- 902. 薄める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '薄める', 'うすめる', '희석하다, 묽게 하다', '薄(엷을 박)', '동사', 902, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '味噌汁を水で薄めた。', '된장국을 물로 묽게 했다.', 1),
    (w, '色を薄めて使う。', '색을 엷게 해서 사용한다.', 2);

  -- 903. 充実
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '充実', 'じゅうじつ', '충실', '充 + 実', '명사', 903, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '内容が充実している。', '내용이 충실하다.', 1),
    (w, '毎日が充実した日々だ。', '매일이 충실한 나날이다.', 2);

  -- 904. 鮮明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '鮮明', 'せんめい', '선명', '鮮 + 明', '명사', 904, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鮮明な記憶が残っている。', '선명한 기억이 남아 있다.', 1),
    (w, '鮮明な画像で見える。', '선명한 화상으로 보인다.', 2);

  -- 905. ふもと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, 'ふもと', 'ふもと', '(산)기슭', '관용 명사', '명사', 905, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '富士山のふもとで休んだ。', '후지산 기슭에서 쉬었다.', 1),
    (w, '山のふもとに村がある。', '산기슭에 마을이 있다.', 2);

  -- 906. 定年
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n2, '定年', 'ていねん', '정년', '定 + 年', '명사', 906, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '定年退職を迎えた。', '정년 퇴직을 맞이했다.', 1),
    (w, '定年後の生活を考える。', '정년 후의 생활을 생각한다.', 2);

  -- ============================================================
  -- N2 「파이널 문법 체크북」 PDF: 일단합격JLPT완벽대비N2-단어장
  -- 형식판단 327 + 문장완성 141 + 문맥이해 120 = 588 항목
  -- order_index 907 ~ 1494, 각 항목 한자/구조 어원 + 예문 2개
  -- ============================================================

  -- ────────── 문법 형식 판단 (327개, 907~1233) ──────────

  -- 907. ～におうじて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～におうじて', '~에 맞추어, ~에 대응하여', '応(응할 응)じる+て. 명사+に応じて. 「대상에 따라 적절히 대응」', '문법-형식판단', 907, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '能力に応じて給料が決まる。', '능력에 맞추어 급여가 정해진다.', 1),
    (w, '状況に応じて対策を変える。', '상황에 맞추어 대책을 바꾼다.', 2);

  -- 908. ～途中で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～途中で', 'とちゅうで', '~도중에', '途(길 도)+中(가운데). 명사の/동사 진행형+途中で. 행위/이동의 중간 시점', '문법-형식판단', 908, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰宅の途中で雨に降られた。', '귀가 도중에 비를 맞았다.', 1),
    (w, '会議の途中で電話が鳴った。', '회의 도중에 전화가 울렸다.', 2);

  -- 909. ～にわたって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にわたって', '~에 걸쳐서 (광범위·장기간)', '渡(건널 도)る+て. 명사(기간/범위)+にわたって. 「~의 전 범위에 걸침」', '문법-형식판단', 909, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '3日間にわたって会議が行われた。', '3일간에 걸쳐서 회의가 진행되었다.', 1),
    (w, '全国にわたって雨が降った。', '전국에 걸쳐 비가 내렸다.', 2);

  -- 910. 何も～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '何も～', 'なにも', '굳이~, 일부러~', '何(어찌 하)+も+동사. 부정/반어 표현과 함께 「굳이/일부러」 어감', '문법-형식판단', 910, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何もそこまで言わなくてもいい。', '굳이 거기까지 말 안 해도 된다.', 1),
    (w, '何も急ぐ必要はない。', '굳이 서두를 필요는 없다.', 2);

  -- 911. ～一方だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～一方だ', 'いっぽうだ', '~하기만 하다 (한 방향 진행)', '一(한 일)+方(방향 방)+だ. 동사 사전형+一方だ. 한쪽 방향의 진행/악화', '문법-형식판단', 911, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '物価は上がる一方だ。', '물가는 오르기만 한다.', 1),
    (w, '人口は減る一方だ。', '인구는 줄어들기만 한다.', 2);

  -- 912. ～がたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がたい', '~하기 어렵다 (심리·도덕적)', '難(어려울 난)い의 변형 がたい. 동사ます형+がたい. 「~하기 곤란/꺼려짐」', '문법-형식판단', 912, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の話は信じがたい。', '그의 이야기는 믿기 어렵다.', 1),
    (w, '忘れがたい思い出だ。', '잊기 어려운 추억이다.', 2);

  -- 913. ～(さ)せていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せていただく', '~하다 <겸양>', '사역형+ていただく. 자신의 행위를 가장 정중히 겸양 표현', '문법-형식판단', 913, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本日は休ませていただきます。', '오늘은 쉬겠습니다.', 1),
    (w, '発表させていただきます。', '발표하겠습니다.', 2);

  -- 914. ～(さ)れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)れる', '본의 아니게 ~하게 되다 <사역수동>', '사역(さ)せる+受(られ)る의 축약. 강요/유발된 행위', '문법-형식판단', 914, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間待たされた。', '오랜 시간 기다리게 되었다.', 1),
    (w, '無理にお酒を飲まされた。', '억지로 술을 마시게 되었다.', 2);

  -- 915. ～たところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たところ', '~했더니 (결과 발견)', '동사 た형+ところ(곳/때). 어떤 동작 후의 결과·발견', '문법-형식판단', 915, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '相談したところ、いい意見をもらった。', '상담했더니 좋은 의견을 받았다.', 1),
    (w, '駅へ行ったところ、電車が来ていた。', '역에 갔더니 전철이 와 있었다.', 2);

  -- 916. ～にすぎないとはいえ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にすぎないとはいえ', '~에 지나지 않는다고는 해도', 'に+過(지날 과)ぎ+ない+とはいえ. 「불과하지만」+양보', '문법-형식판단', 916, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談にすぎないとはいえ、傷ついた。', '농담에 지나지 않는다고는 해도 상처받았다.', 1),
    (w, '少額にすぎないとはいえ、ありがたい。', '소액에 지나지 않는다고는 해도 고맙다.', 2);

  -- 917. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～はずだ', '틀림없이 ~일 것이다 (근거 있는 확신)', '筈(はず, 마땅한 도리). 근거 있는 강한 추측', '문법-형식판단', 917, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は今日来るはずだ。', '그는 오늘 올 것이다.', 1),
    (w, '彼女なら知っているはずだ。', '그녀라면 알고 있을 것이다.', 2);

  -- 918. ～ままで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ままで', '~대로, ~인 채로', '儘(まま, 그대로)+で. 상태 유지 후 다른 행위', '문법-형식판단', 918, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴を履いたままで部屋に入る。', '신발을 신은 채로 방에 들어간다.', 1),
    (w, '昔のままでとどめておく。', '옛 그대로 두다.', 2);

  -- 919. ～上で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～上で', 'うえで', '~한 후에 / ~하는 데에 있어서', '上(위 상)+で. 동사 た형/명사+の+上で. 전제·기준·후속', '문법-형식판단', 919, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よく考えた上で決めてください。', '잘 생각한 후에 결정해 주세요.', 1),
    (w, '生活する上でお金は必要だ。', '생활하는 데에 있어서 돈은 필요하다.', 2);

  -- 920. ～でありながらも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～でありながらも', '~이면서도 (역접)', 'である(이다)+ながら(하면서)+も(도). 명사 술어 양보·역접', '문법-형식판단', 920, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は社長でありながらも謙虚だ。', '그는 사장이면서도 겸손하다.', 1),
    (w, '医者でありながらも自分の健康を気にしない。', '의사이면서도 자기 건강을 신경 쓰지 않는다.', 2);

  -- 921. ～みたいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～みたいだ', '~인 것 같다 / ~같다 <비유·추측>', '見たい에서 유래. 회화체 비유·추측·전문', '문법-형식판단', 921, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っているみたいだ。', '비가 오고 있는 것 같다.', 1),
    (w, '彼は子供みたいだ。', '그는 어린아이 같다.', 2);

  -- 922. とても～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'とても～ない', '정말이지 ~않다, 도저히 ~않다', 'とても(정말)+ない. 강조된 전면 부정', '문법-형식판단', 922, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とても信じられない。', '도저히 믿을 수 없다.', 1),
    (w, 'とても一人では無理だ。', '도저히 혼자서는 무리다.', 2);

  -- 923. 必ずしも～わけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '必ずしも～わけではない', 'かならずしも', '반드시 ~한 것은 아니다 (부분 부정)', '必(반드시 필)+ずしも+わけではない. 부분 부정', '문법-형식판단', 923, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高ければ必ずしも良いというわけではない。', '비싸다고 반드시 좋은 것은 아니다.', 1),
    (w, '彼の話が必ずしも正しいわけではない。', '그의 이야기가 반드시 맞는 것은 아니다.', 2);

  -- 924. ～ようがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようがない', '~할 방도가 없다, ~할 수가 없다', '동사ます형+よう(방법)+がない. 수단·방법의 부재', '문법-형식판단', 924, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '連絡先が分からないので、知らせようがない。', '연락처를 몰라서 알릴 방도가 없다.', 1),
    (w, '壊れすぎて直しようがない。', '너무 망가져서 고칠 수가 없다.', 2);

  -- 925. 申し上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '申し上げる', 'もうしあげる', '말씀드리다 <겸양>', '申す(말하다 겸양)+上げる(올리다). 「말씀을 올리다」 최정중', '문법-형식판단', 925, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お礼を申し上げます。', '감사 말씀드립니다.', 1),
    (w, 'ご報告申し上げます。', '보고드립니다.', 2);

  -- 926. ～ないでしょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないでしょうか', '~아닐까요?, ~아닐런지요', 'ない+でしょうか. 정중하고 완곡한 의문/제안', '문법-형식판단', 926, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休んだ方がいいのではないでしょうか。', '조금 쉬는 게 좋지 않을까요?', 1),
    (w, '間違いがあるのではないでしょうか。', '실수가 있는 게 아닐까요?', 2);

  -- 927. ～(さ)せてくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せてくれる', '~하게 해 주다 <허락>', '사역형+てくれる. 「내가 하는 것을 상대가 허용해 줌」', '문법-형식판단', 927, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父は私を留学させてくれた。', '아버지는 나를 유학하게 해 주셨다.', 1),
    (w, '少し休ませてくれませんか。', '잠시 쉬게 해 주시지 않겠습니까?', 2);

  -- 928. ～てほしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てほしい', '~해 주었으면 좋겠다', '동사 て형+ほしい. 상대 행동에 대한 강한 희망', '문법-형식판단', 928, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度考え直してほしい。', '한 번 다시 생각해 줬으면 좋겠다.', 1),
    (w, '正直に話してほしいです。', '솔직하게 말해 주었으면 좋겠습니다.', 2);

  -- 929. ～たばかりだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たばかりだ', '막 ~한 참이다', '동사 た형+ばかり(뿐)+だ. 동작 직후', '문법-형식판단', 929, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、起きたばかりだ。', '지금 막 일어난 참이다.', 1),
    (w, '日本に来たばかりです。', '일본에 온 지 얼마 안 되었습니다.', 2);

  -- 930. ～かどうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かどうか', '~인지 어떤지', 'か(의문)+どうか. 불확실 양자택일', '문법-형식판단', 930, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るかどうか分からない。', '그가 올지 어떨지 모르겠다.', 1),
    (w, '正しいかどうか確認してください。', '맞는지 어떤지 확인해 주세요.', 2);

  -- 931. ～とか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とか', '~라든가, ~라는 식으로 (예시/전문)', 'と(인용)+か(불확정). 예시·전해 들음', '문법-형식판단', 931, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '映画とかドラマとかをよく見る。', '영화라든가 드라마 같은 걸 자주 본다.', 1),
    (w, '彼は来ないとか聞いた。', '그는 안 온다고들 한다.', 2);

  -- 932. ～すえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すえに', '~한 끝에', '末(끝 말)に. 동사 た형/명사+の+すえに. 「오랜 과정 끝에」', '문법-형식판단', 932, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長い議論のすえに結論が出た。', '오랜 논의 끝에 결론이 나왔다.', 1),
    (w, '悩んだすえに退職を決めた。', '고민한 끝에 퇴직을 결정했다.', 2);

  -- 933. ～(さ)せられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せられる', '본의 아니게 ~하게 되다 <사역수동>', '사역+수동. 강요된 행위 또는 마음의 자극', '문법-형식판단', 933, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間勉強させられた。', '오랜 시간 공부하게 되었다.', 1),
    (w, '深く考えさせられる映画だ。', '깊이 생각하게 되는 영화다.', 2);

  -- 934. ～まい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～まい', '~하지 않겠다 (의지·추측 부정)', '문어체 부정 의지·추측 조동사', '문법-형식판단', 934, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二度と嘘はつくまい。', '두 번 다시 거짓말은 하지 않겠다.', 1),
    (w, '彼はもう来るまい。', '그는 이제 오지 않을 것이다.', 2);

  -- 935. まいる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '参る', 'まいる', '오다, 가다 <겸양>', '参(참여할 참). 行く/来る의 겸양어', '문법-형식판단', 935, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐに参ります。', '곧 가겠습니다.', 1),
    (w, 'お迎えに参りました。', '마중하러 왔습니다.', 2);

  -- 936. むしろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'むしろ', '오히려, 차라리', '寧(편안 녕)ろ에서 유래. 비교 후 선호 표현', '문법-형식판단', 936, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'むしろ家にいた方がいい。', '오히려 집에 있는 편이 낫다.', 1),
    (w, '怒るよりむしろ笑った。', '화내기보다 차라리 웃었다.', 2);

  -- 937. ～になっているだろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～になっているだろう', '~이 되어 있을 것이다', '명사+に+なっている+だろう. 미래 상태 추측', '문법-형식판단', 937, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '10年後には立派な大人になっているだろう。', '10년 후에는 훌륭한 어른이 되어 있을 것이다.', 1),
    (w, '夜には満員になっているだろう。', '밤에는 만원이 되어 있을 것이다.', 2);

  -- 938. ～ても～なくても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ても～なくても', '~해도 ~하지 않아도', 'ても(양보)+なくても(양보). 어느 쪽이든 상관없음', '문법-형식판단', 938, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行っても行かなくても構わない。', '가든 안 가든 상관없다.', 1),
    (w, '雨が降っても降らなくても出発する。', '비가 오든 안 오든 출발한다.', 2);

  -- 939. ～すぎず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すぎず', '너무 ~하지 말고', '過(지날 과)ぎ+ず(부정). 적절한 정도를 권유', '문법-형식판단', 939, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無理しすぎず体に気をつけて。', '너무 무리하지 말고 몸 조심해.', 1),
    (w, '甘やかしすぎず厳しく育てる。', '너무 응석받이로 키우지 말고 엄하게 키운다.', 2);

  -- 940. ～でしかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～でしかない', '~밖에 되지 않다, ~에 불과하다', 'で+しか(밖에)+ない. 한정·과소평가', '문법-형식판단', 940, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは言い訳でしかない。', '그것은 변명에 불과하다.', 1),
    (w, '夢でしかない話だ。', '꿈에 불과한 이야기다.', 2);

  -- 941. ～わけがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけがない', '~할 리가 없다', '訳(이유)+がない. 가능성을 강하게 부정', '문법-형식판단', 941, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が知らないわけがない。', '그가 모를 리가 없다.', 1),
    (w, 'こんな簡単な問題が分からないわけがない。', '이런 간단한 문제를 모를 리가 없다.', 2);

  -- 942. ～くらいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～くらいだ', '~정도다 (정도 강조)', '位(자리 위)에서. 「~할 정도로 ~함」', '문법-형식판단', 942, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣きたいくらいだ。', '울고 싶을 정도다.', 1),
    (w, '死にたいくらい辛い。', '죽고 싶을 정도로 힘들다.', 2);

  -- 943. ～もの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～もの', '~나 되는 (양/정도 강조)', '物(もの). 수량+もの. 「~씩이나」', '문법-형식판단', 943, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '10時間もの間待った。', '10시간씩이나 기다렸다.', 1),
    (w, '1万円もの寄付を受けた。', '1만 엔이나 되는 기부를 받았다.', 2);

  -- 944. ～すら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すら', '~조차 (극단적 예 강조)', '문어체 조사. 극단적 예시를 통한 강조', '문법-형식판단', 944, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '挨拶すらしない。', '인사조차 안 한다.', 1),
    (w, '名前すら覚えていない。', '이름조차 기억하지 못한다.', 2);

  -- 945. ～くらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～くらい', '~정도, ~만큼', '位(자리)에서 온 정도 표현. 양·정도', '문법-형식판단', 945, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '駅まで5分くらいだ。', '역까지 5분 정도다.', 1),
    (w, '彼くらい優しい人はいない。', '그만큼 친절한 사람은 없다.', 2);

  -- 946. どうも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうも', '아무래도, 어쩐지', '부사. 명확하지 않지만 그렇게 보임/감사 인사', '문법-형식판단', 946, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうも風邪をひいたようだ。', '아무래도 감기에 걸린 것 같다.', 1),
    (w, 'どうもありがとうございます。', '대단히 감사합니다.', 2);

  -- 947. ～にこたえて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にこたえて', '~에 부응하여', '応(응할 응)える+て. 요청/기대에 응함', '문법-형식판단', 947, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '声援にこたえて頑張る。', '응원에 부응하여 노력한다.', 1),
    (w, '期待にこたえて勝利した。', '기대에 부응하여 승리했다.', 2);

  -- 948. ～うちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～うちに', '~하는 사이에, ~동안에', '内(안 내)+に. 그 상태가 지속되는 동안', '문법-형식판단', 948, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若いうちに勉強しよう。', '젊을 때 공부하자.', 1),
    (w, '寝ているうちに雪が積もった。', '자고 있는 사이에 눈이 쌓였다.', 2);

  -- 949. ～によらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によらず', '~에 관계없이', 'に+依(의지할 의)らず. 조건/사정 무관', '문법-형식판단', 949, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年齢によらず誰でも参加できる。', '나이에 관계없이 누구든 참가할 수 있다.', 1),
    (w, '見かけによらず親切だ。', '겉모습과 다르게 친절하다.', 2);

  -- 950. ～ないでもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないでもない', '~하지 않는 것도 아니다', '동사 ない형+で+も+ない. 약한 긍정/소극 인정', '문법-형식판단', 950, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やってみないでもない。', '해 보지 않는 것도 아니다(=조금은 하겠다).', 1),
    (w, '気にしないでもない。', '신경 쓰지 않는 것도 아니다.', 2);

  -- 951. ～とかなくちゃ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とかなくちゃ', '~해 두지 않으면 <축약>', 'ておく+なくては의 회화 축약. 준비/조치의 필요', '문법-형식판단', 951, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く言っとかなくちゃ。', '빨리 말해 두지 않으면.', 1),
    (w, '宿題やっとかなくちゃ。', '숙제 해 두지 않으면.', 2);

  -- 952. ～たら～たで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たら～たで', '~하면 ~하는 대로', 'たら(가정)+たで(상태). 어떻게 되든 그 나름의 결과', '문법-형식판단', 952, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なかったらなかったで何とかなる。', '없으면 없는 대로 어떻게든 된다.', 1),
    (w, '失敗したら失敗したで学べる。', '실패하면 실패한 대로 배울 게 있다.', 2);

  -- 953. ～ざるをえない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ざるをえない', '~하지 않을 수 없다', '문어체 부정 ざる+を+得(얻을 득)ない. 불가피', '문법-형식판단', 953, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の命令だから従わざるをえない。', '상사의 명령이라 따르지 않을 수 없다.', 1),
    (w, '雨だから中止せざるをえない。', '비라서 중지하지 않을 수 없다.', 2);

  -- 954. お～ですか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お～ですか', '~하십니까? <존경>', 'お+동사ます형+ですか. 상대 행위에 대한 정중 질문', '문법-형식판단', 954, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お出かけですか。', '나가십니까?', 1),
    (w, 'お元気ですか。', '잘 지내십니까?', 2);

  -- 955. ～も～ないで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～も～ないで', '~도 ~하지 않고', 'も(도)+ないで. 두 가지를 다 안 함', '문법-형식판단', 955, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '挨拶もしないで帰った。', '인사도 하지 않고 돌아갔다.', 1),
    (w, '朝ご飯も食べないで出かけた。', '아침도 안 먹고 나갔다.', 2);

  -- 956. ～をとわず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～をとわず', '~을 불문하고', '問(물을 문)わず. 「~을 묻지 않고」', '문법-형식판단', 956, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年齢を問わず応募できる。', '나이를 불문하고 응모할 수 있다.', 1),
    (w, '昼夜を問わず働く。', '낮밤을 가리지 않고 일한다.', 2);

  -- 957. もっとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'もっとも', '다만, 단 <접속사>', '尤(가장 우)も. 앞 내용에 단서를 더함', '문법-형식판단', 957, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行きます。もっとも遅れるかもしれません。', '갑니다. 다만 늦을지도 모릅니다.', 1),
    (w, '安いですよ。もっとも品質はそれなりです。', '쌉니다. 단 품질은 그 나름이에요.', 2);

  -- 958. わかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'わかった', '알았다 <감탄/이해>', '分かる(이해하다)의 과거형. 깨달음/동의', '문법-형식판단', 958, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わかった、すぐ行く。', '알았어, 곧 갈게.', 1),
    (w, 'わかった！その通りだ。', '알았다! 바로 그거다.', 2);

  -- 959. ～たってかまわない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たってかまわない', '~해도 상관없다', 'ても의 회화체 たって+かまわない. 양보 허용', '문법-형식판단', 959, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高くたってかまわない。', '비싸도 상관없다.', 1),
    (w, '遅刻したってかまわない。', '지각해도 상관없다.', 2);

  -- 960. お越しくださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'お越しくださる', 'おこしくださる', '와 주시다 <존경>', 'お+越(넘을 월)し+くださる. 「오심을 베풀어 주심」', '문법-형식판단', 960, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本日はお越しくださいましてありがとうございます。', '오늘 와 주셔서 감사합니다.', 1),
    (w, 'ぜひお越しください。', '꼭 와 주십시오.', 2);

  -- 961. ～ている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ている', '~했었다 <완료/결과 지속>', '동사 て형+いる. 동작 완료 후 상태 지속', '문법-형식판단', 961, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は既に到着している。', '그는 이미 도착해 있다.', 1),
    (w, '窓が開いている。', '창문이 열려 있다.', 2);

  -- 962. ～へと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～へと', '~으로 (방향 강조)', 'へ(방향)+と. 변화 방향 강조', '문법-형식판단', 962, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい時代へと進む。', '새 시대로 나아간다.', 1),
    (w, '彼は東京へと向かった。', '그는 도쿄로 향했다.', 2);

  -- 963. ～おかげで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～おかげで', '~덕분에 <긍정 원인>', 'お陰(かげ, 그늘=비호). 긍정적 결과의 원인', '문법-형식판단', 963, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生のおかげで合格できた。', '선생님 덕분에 합격할 수 있었다.', 1),
    (w, '彼のおかげで助かった。', '그 덕분에 살았다.', 2);

  -- 964. やる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'やる', '하다 <속어>', 'する의 회화체. 윗→아래/동·식물에게 베푸는 행위', '문법-형식판단', 964, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題をやる。', '숙제를 한다.', 1),
    (w, '犬に餌をやる。', '강아지에게 먹이를 준다.', 2);

  -- 965. ～としたら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としたら', '~라고 한다면 <가정>', 'とする(라고 하다)+たら. 가정의 상황 설정', '문법-형식판단', 965, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宝くじが当たったとしたら何を買う？', '복권에 당첨된다면 뭘 사겠어?', 1),
    (w, '本当だとしたら大変だ。', '사실이라면 큰일이다.', 2);

  -- 966. ～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ', '~할 것 같다 <양태>', '동사ます형/형용사 어간+そうだ. 외관 추측', '문법-형식판단', 966, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降りそうだ。', '비가 올 것 같다.', 1),
    (w, '彼は元気そうだ。', '그는 건강해 보인다.', 2);

  -- 967. ～からこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～からこそ', '~이기에, ~하기에', 'から(이유)+こそ(강조). 강조된 이유', '문법-형식판단', 967, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛しているからこそ厳しく言う。', '사랑하기에 엄하게 말한다.', 1),
    (w, '友達だからこそ本音を言える。', '친구이기에 본심을 말할 수 있다.', 2);

  -- 968. ～ばかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばかり', '~뿐, ~만 (한정·반복)', '명사/사전형+ばかり. 한정·과다 행위', '문법-형식판단', 968, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '甘いものばかり食べる。', '단것만 먹는다.', 1),
    (w, '泣いてばかりいる。', '울고만 있다.', 2);

  -- 969. かりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '仮に', 'かりに', '만약, 가령', '仮(거짓 가)に. 가설 설정 부사', '문법-형식판단', 969, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仮にお金があっても買わない。', '만약 돈이 있어도 안 산다.', 1),
    (w, '仮に失敗したとしても諦めない。', '가령 실패한다 해도 포기하지 않는다.', 2);

  -- 970. ～ないうちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないうちに', '~하기 전에', '동사 ない형+うちに. 어떤 상태 발생 전 시점', '문법-형식판단', 970, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降らないうちに帰ろう。', '비가 오기 전에 돌아가자.', 1),
    (w, '忘れないうちにメモする。', '잊기 전에 메모한다.', 2);

  -- 971. ～ており
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ており', '~하고 있어서 (정중 연결)', 'ている의 ます형 연용. 문어체/격식', '문법-형식판단', 971, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現在準備しており、来週発表します。', '현재 준비하고 있어서 다음 주 발표합니다.', 1),
    (w, '会議は午後行われており、夜まで続く予定です。', '회의는 오후에 진행되고 있어서 밤까지 계속될 예정입니다.', 2);

  -- 972. ～にもかかわらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にもかかわらず', '~(임)에도 불구하고', 'に+も+関(빗장 관)わる+ず. 강한 역접', '문법-형식판단', 972, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨にもかかわらず試合は行われた。', '비에도 불구하고 시합은 진행되었다.', 1),
    (w, '努力にもかかわらず失敗した。', '노력에도 불구하고 실패했다.', 2);

  -- 973. ～らしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～らしい', '~답다 / ~인 것 같다 <접미·추측>', '명사+らしい. 본래 성질/전형성, 또는 추측', '문법-형식판단', 973, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は男らしい人だ。', '그는 남자다운 사람이다.', 1),
    (w, '彼は来ないらしい。', '그는 안 오는 것 같다.', 2);

  -- 974. ～によっては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によっては', '~에 따라서는', 'に+依る+ては. 조건/경우에 따른 차이 강조', '문법-형식판단', 974, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人によっては苦手な食べ物がある。', '사람에 따라서는 싫어하는 음식이 있다.', 1),
    (w, '日によっては忙しい。', '날에 따라서는 바쁘다.', 2);

  -- 975. ～(さ)せる/～たがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せる/～たがる', '~하게 하다 <사역> / ~하고 싶어하다', '사역(させる) + 욕구(たがる, 3인칭). 두 표현 결합', '문법-형식판단', 975, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟は本を読みたがるので、母は読ませる。', '동생이 책을 읽고 싶어해서 엄마가 읽게 한다.', 1),
    (w, '子供がやりたがることをやらせる。', '아이가 하고 싶어 하는 일을 시킨다.', 2);

  -- 976. どれだけ～か
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どれだけ～か', '얼마나 ~일까? <감탄·강조>', 'どれ(어느)+だけ(만큼)+か(의문). 정도 감탄', '문법-형식판단', 976, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どれだけ嬉しかったか。', '얼마나 기뻤는지.', 1),
    (w, 'どれだけ苦労したか分からない。', '얼마나 고생했는지 모른다.', 2);

  -- 977. ご覧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご覧', 'ごらん', '보심 <존경>', 'ご(존경)+覧(볼 람). 見る의 존경 명사형. ご覧ください 형태', '문법-형식판단', 977, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらをご覧ください。', '이쪽을 봐 주십시오.', 1),
    (w, 'ご覧の通りです。', '보시는 대로입니다.', 2);

  -- 978. ～(ら)れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(ら)れる', '~하게 되다 <수동/가능/존경>', '동사 미연형+れる(1)/られる(2). 수동·가능·존경 다의', '문법-형식판단', 978, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に褒められた。', '선생님께 칭찬받았다.', 1),
    (w, '一人で行かれる。', '혼자서 갈 수 있다.', 2);

  -- 979. ～ようならば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようならば', '~할 것 같으면', '様+なら+ば. 그런 상태가 예상되면', '문법-형식판단', 979, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るようならば出発を遅らせます。', '비가 올 것 같으면 출발을 늦추겠습니다.', 1),
    (w, '間に合わないようならば連絡してください。', '늦을 것 같으면 연락해 주세요.', 2);

  -- 980. ～にのぼる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にのぼる', '~에 달하다', '登(오를 등)る. 수량이 ~에 이르다', '문법-형식판단', 980, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被害は数百億にのぼる。', '피해는 수백억에 달한다.', 1),
    (w, '参加者は千人にのぼった。', '참가자는 천 명에 달했다.', 2);

  -- 981. ～てからでないと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てからでないと', '~한 후가 아니면', 'てから+でないと. 「~을 끝낸 후가 아니면」', '문법-형식판단', 981, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確認してからでないと答えられない。', '확인한 후가 아니면 답할 수 없다.', 1),
    (w, '相談してからでないと決められない。', '상담한 후가 아니면 결정할 수 없다.', 2);

  -- 982. ～次第
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～次第', 'しだい', '~하는 대로 (즉시)', '次(다음 차)+第(차례 제). 동사ます형+次第. 「~하는 즉시」', '문법-형식판단', 982, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '着き次第連絡します。', '도착하는 대로 연락하겠습니다.', 1),
    (w, '分かり次第お知らせください。', '아는 대로 알려 주세요.', 2);

  -- 983. うけたまわる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '承る', 'うけたまわる', '받다, 듣다, 떠맡다 <겸양>', '承(받들 승)る. 「받들어 모시다」. 承る는 引き受ける/聞く의 겸양', '문법-형식판단', 983, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご注文を承ります。', '주문을 받겠습니다.', 1),
    (w, 'お話を承りました。', '말씀 잘 들었습니다.', 2);

  -- 984. ～わけにはいかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけにはいかない', '~할 수는 없다', '訳(이유)+には+いかない. 사회/도덕적으로 그럴 수 없음', '문법-형식판단', 984, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束したから行かないわけにはいかない。', '약속했으니까 가지 않을 수는 없다.', 1),
    (w, '一人だけ休むわけにはいかない。', '나만 쉴 수는 없다.', 2);

  -- 985. ～や何かで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～や何かで', '~와 같은 것에서 <예시>', 'や(나열)+何か(어떤 것). 막연한 예시', '문법-형식판단', 985, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーや何かで一休みしよう。', '커피 같은 거 하면서 잠시 쉬자.', 1),
    (w, '雑誌や何かで見た記事。', '잡지 같은 것에서 본 기사.', 2);

  -- 986. ～のに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のに', '~하는 데에, ~할 때에 (목적/용도)', 'の(명사화)+に. 「~을 위해」 「~할 때 사용」', '문법-형식판단', 986, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理を作るのに2時間かかった。', '요리를 만드는 데에 2시간 걸렸다.', 1),
    (w, 'これは手紙を書くのに使う。', '이것은 편지를 쓸 때 쓴다.', 2);

  -- 987. ～たびに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たびに', '~할 때마다', '度(たび, 횟수)+に. 동사 사전형/명사+の+たびに. 반복', '문법-형식판단', 987, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会うたびに彼は変わっていく。', '만날 때마다 그는 변해 간다.', 1),
    (w, '旅行のたびに写真を撮る。', '여행할 때마다 사진을 찍는다.', 2);

  -- 988. ～かもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かもしれない', '~일지도 모른다', 'か+も+知れない. 낮은 확률의 추측', '문법-형식판단', 988, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は雨かもしれない。', '내일은 비가 올지도 모른다.', 1),
    (w, '彼は来ないかもしれません。', '그는 안 올지도 모릅니다.', 2);

  -- 989. ～さえ～ば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～さえ～ば', '~만 ~하면 (충분조건)', 'さえ(만)+ば(가정). 최소 조건만 충족되면', '문법-형식판단', 989, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君さえいれば幸せだ。', '너만 있으면 행복하다.', 1),
    (w, 'お金さえあれば何でもできる。', '돈만 있으면 뭐든 할 수 있다.', 2);

  -- 990. ～において
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～において', '~에 있어서, ~에서 (격식)', '於(어조사 어)+て. 시간·장소·분야의 격식', '문법-형식판단', 990, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は東京において行われる。', '회의는 도쿄에서 진행된다.', 1),
    (w, '科学において重要な発見だ。', '과학에 있어서 중요한 발견이다.', 2);

  -- 991. ～ものなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ものなら', '~할 수만 있다면 (희망적 가정)', '物(もの)+なら(가정). 가능하다면 ~하고 싶다', '문법-형식판단', 991, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けるものならすぐに行きたい。', '갈 수만 있다면 당장 가고 싶다.', 1),
    (w, '会えるものなら会いたい。', '만날 수만 있다면 만나고 싶다.', 2);

  -- 992. ただし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '但し', 'ただし', '다만, 단 <접속>', '但(다만 단)し. 앞 내용에 조건/예외 부가', '문법-형식판단', 992, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入場無料。ただし、子供のみ。', '입장 무료. 단, 어린이만.', 1),
    (w, '参加可能。ただし、事前予約が必要。', '참가 가능. 다만 사전 예약이 필요.', 2);

  -- 993. ～勢いだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～勢いだ', 'いきおいだ', '~할 기세이다', '勢(기세 세). 동사 사전형+勢いだ. 「~할 듯한 기세」', '문법-형식판단', 993, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今にも泣き出す勢いだ。', '금세라도 울음을 터뜨릴 기세다.', 1),
    (w, '全部食べる勢いだ。', '전부 먹어 치울 기세다.', 2);

  -- 994. ご覧いただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご覧いただく', 'ごらんいただく', '보시다 <겸손>', 'ご覧(존경)+いただく(겸양 받음). 「봐 주심을 받음」', '문법-형식판단', 994, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料をご覧いただきたいです。', '자료를 봐 주셨으면 합니다.', 1),
    (w, 'こちらをご覧いただけますか。', '이쪽을 봐 주시겠습니까?', 2);

  -- 995. ～にすぎない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にすぎない', '~에 지나지 않는다, ~에 불과하다', 'に+過(지날 과)ぎ+ない. 「그저 ~일 뿐」', '문법-형식판단', 995, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは噂にすぎない。', '그것은 소문에 지나지 않는다.', 1),
    (w, '彼はまだ学生にすぎない。', '그는 아직 학생에 불과하다.', 2);

  -- 996. ～ならともかく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ならともかく', '~이라면 몰라도', 'なら(라면)+ともかく(차치하고). 「~이라면 그래도」', '문법-형식판단', 996, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供ならともかく、大人がそんなことを言うのか。', '아이라면 몰라도 어른이 그런 말을 하나.', 1),
    (w, '少しならともかく、こんなにたくさんは無理だ。', '조금이라면 몰라도 이렇게 많이는 무리다.', 2);

  -- 997. ～てもらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てもらう', '~해 주다 (상대로부터 받음)', '동사 て형+貰(받을 모)う. 화자가 타인의 행위를 받음', '문법-형식판단', 997, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達に手伝ってもらった。', '친구에게 도움을 받았다.', 1),
    (w, '先生に教えてもらいます。', '선생님께 가르침을 받습니다.', 2);

  -- 998. ～(さ)せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せる', '~시키다, ~하게 하다 <사역>', '동사 미연형+せる(1)/させる(2). 사역 표현', '문법-형식판단', 998, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に勉強させる。', '아이에게 공부시킨다.', 1),
    (w, '弟を泣かせた。', '동생을 울게 했다.', 2);

  -- 999. いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '致す', 'いたす', '하다 <겸양>', '致(이를 치)す. する의 겸양어', '문법-형식판단', 999, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私がいたします。', '제가 하겠습니다.', 1),
    (w, 'よろしくお願いいたします。', '잘 부탁드립니다.', 2);

  -- 1000. ～がち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がち', '자주 ~함, 일쑤임', '勝(이길 승)ち에서 유래. 동사ます형/명사+がち. 부정적 경향', '문법-형식판단', 1000, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近忘れがちだ。', '최근 자주 잊어버린다.', 1),
    (w, '雨の日は遅れがちだ。', '비 오는 날은 자주 늦는다.', 2);

  -- 1001. ～とおりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とおりに', '~대로', '通(통할 통)り+に. 「~과 같이」, 지시·예상대로', '문법-형식판단', 1001, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言うとおりにしてください。', '말하는 대로 해 주세요.', 1),
    (w, '計画とおりに進んでいる。', '계획대로 진행되고 있다.', 2);

  -- 1002. ～にかけては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にかけては', '~에 관한 한, ~에 있어서는', '掛(걸 괘)ける+ては. 분야 한정 강조', '문법-형식판단', 1002, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理にかけては誰にも負けない。', '요리에 관한 한 누구에게도 안 진다.', 1),
    (w, '速さにかけては自信がある。', '속도에 있어서는 자신 있다.', 2);

  -- 1003. ～(さ)せていただける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せていただける', '~해 주실 수 있다 <겸손>', '사역+ていただく의 가능형. 「~하게 해 받을 수 있음」', '문법-형식판단', 1003, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませていただけますか。', '쉬게 해 주실 수 있습니까?', 1),
    (w, '質問させていただけませんか。', '질문하게 해 주실 수 없겠습니까?', 2);

  -- 1004. ～なりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なりに', '~나름대로', 'なる(되다)+に. 그 사람·상황에 맞는 방식', '문법-형식판단', 1004, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私なりに頑張った。', '나 나름대로 노력했다.', 1),
    (w, '子供なりに考えている。', '아이 나름대로 생각하고 있다.', 2);

  -- 1005. ～(よ)うとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(よ)うとする', '~하려고 하다', '의지형(よう)+とする. 동작의 의도·시도', '문법-형식판단', 1005, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけようとしたら雨が降った。', '나가려고 했더니 비가 왔다.', 1),
    (w, '逃げようとした犯人を捕まえた。', '도망치려던 범인을 붙잡았다.', 2);

  -- 1006. ～てしょうがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てしょうがない', '~해서 어쩔 수가 없다, 매우 ~하다', '仕様(しよう)+が+ない의 변형. 감정·욕구의 극한', '문법-형식판단', 1006, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '眠くてしょうがない。', '졸려서 어쩔 수가 없다.', 1),
    (w, '会いたくてしょうがない。', '너무 만나고 싶다.', 2);

  -- 1007. 見える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '見える', 'みえる', '오시다 <존경> / 보이다', '見(볼 견)える. 「오심이 보이다」→오시다(존경). 또는 「보이다」', '문법-형식판단', 1007, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生がお見えになりました。', '선생님께서 오셨습니다.', 1),
    (w, '富士山が見える。', '후지산이 보인다.', 2);

  -- 1008. ～ようであれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようであれば', '~할 것 같으면 (정중)', '様+で+あれば. ようなら의 정중·문어체', '문법-형식판단', 1008, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間に合わないようであればご連絡ください。', '늦을 것 같으면 연락 주십시오.', 1),
    (w, '体調が悪いようであれば休んでください。', '컨디션이 안 좋으시면 쉬어 주세요.', 2);

  -- 1009. ～(よ)うじゃないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(よ)うじゃないか', '~하지 않겠는가? <권유>', '의지형+じゃないか(부정 의문). 동조 권유', '문법-형식판단', 1009, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'みんなで頑張ろうじゃないか。', '다 같이 노력하지 않겠는가?', 1),
    (w, '一緒に行こうじゃないか。', '함께 가지 않겠는가?', 2);

  -- 1010. 伝わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '伝わる', 'つたわる', '전달되다, 전해지다', '伝(전할 전)わる. 자동사. 정보·감정·문화 등이 전해짐', '문법-형식판단', 1010, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気持ちが伝わった。', '마음이 전해졌다.', 1),
    (w, '昔から伝わる話だ。', '옛날부터 전해 내려오는 이야기다.', 2);

  -- 1011. ～ままに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ままに', '~한 채로, ~대로', '儘(まま)+に. 상태 유지/지시 따름', '문법-형식판단', 1011, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言われるままにやった。', '시키는 대로 했다.', 1),
    (w, '思いつくままに書いた。', '생각나는 대로 썼다.', 2);

  -- 1012. あるいは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '或いは', 'あるいは', '혹은, 또는', '或(혹시 혹)いは. 선택지 제시 접속사', '문법-형식판단', 1012, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーあるいは紅茶を選んでください。', '커피 혹은 홍차를 선택해 주세요.', 1),
    (w, '電話あるいはメールで連絡する。', '전화 또는 메일로 연락한다.', 2);

  -- 1013. ～だって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だって', '~도, ~라도 <예시·강조>', 'でも의 회화체. 양보·강조', '문법-형식판단', 1013, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供だってわかる。', '아이도 안다.', 1),
    (w, '私だって行きたい。', '나도 가고 싶어.', 2);

  -- 1014. ～だけに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけに', '~인 만큼 (당연·예상되는 결과)', 'だけ(만)+に. 「~한 만큼 더더욱」', '문법-형식판단', 1014, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年練習しただけに上手だ。', '오랜 기간 연습한 만큼 잘한다.', 1),
    (w, '期待していただけに残念だ。', '기대했던 만큼 아쉽다.', 2);

  -- 1015. ～とのことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とのことだ', '~라는 것이다 <전달>', 'と(인용)+の+こと+だ. 들은 정보의 정중한 전달', '문법-형식판단', 1015, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は休むとのことだ。', '그는 쉰다는 것이다.', 1),
    (w, '会議は明日とのことです。', '회의는 내일이라고 합니다.', 2);

  -- 1016. ～しかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～しかない', '~할 수밖에 없다', 'しか(밖에)+ない. 유일한 선택', '문법-형식판단', 1016, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう諦めるしかない。', '이제 포기할 수밖에 없다.', 1),
    (w, '待つしかなかった。', '기다릴 수밖에 없었다.', 2);

  -- 1017. お越しいただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'お越しいただく', 'おこしいただく', '와 주시다 <겸손>', 'お+越し+いただく. 손님께서 와 주심', '문법-형식판단', 1017, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本日はお越しいただきありがとうございます。', '오늘 와 주셔서 감사합니다.', 1),
    (w, 'またのお越しをお待ちいたします。', '또 와 주시기를 기다리겠습니다.', 2);

  -- 1018. ～というから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というから', '~라고 하니까', 'という(인용)+から(이유). 들은 정보를 근거로', '문법-형식판단', 1018, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るというから待っている。', '그가 온다고 하니까 기다리고 있다.', 1),
    (w, '安いというから買った。', '싸다고 하니까 샀다.', 2);

  -- 1019. ～ように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように', '~하도록 (목적·기원)', '様(모양 양)+に. 목적·기원·지시', '문법-형식판단', 1019, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見えるように字を大きく書いた。', '보이도록 글자를 크게 썼다.', 1),
    (w, '健康でいられますように。', '건강하게 지낼 수 있도록.', 2);

  -- 1020. ～がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がる', '~해하다 (제3자의 감정)', '형용사 어간+がる. 3인칭의 감정·욕구 외적 표출', '문법-형식판단', 1020, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が寒がる。', '아이가 추워한다.', 1),
    (w, '彼女は欲しがっている。', '그녀는 갖고 싶어한다.', 2);

  -- 1021. ～なきゃいけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なきゃいけない', '~하지 않으면 안 된다 <축약>', 'なければいけない의 회화 축약. 의무', '문법-형식판단', 1021, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く帰らなきゃいけない。', '빨리 돌아가야 한다.', 1),
    (w, '宿題やらなきゃいけない。', '숙제해야 한다.', 2);

  -- 1022. ～つつある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～つつある', '~하는 중이다, ~해 가고 있다', '동사ます형+つつ+ある. 점진적 진행', '문법-형식판단', 1022, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会は変わりつつある。', '사회는 변해 가고 있다.', 1),
    (w, '景気は回復しつつある。', '경기는 회복 중이다.', 2);

  -- 1023. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によって', '~에 의해서, ~로 인해', 'に+依る+て. 수단·원인·근거', '문법-형식판단', 1023, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風によって被害が出た。', '태풍으로 인해 피해가 발생했다.', 1),
    (w, '法律によって守られている。', '법률에 의해 보호받고 있다.', 2);

  -- 1024. ～あまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～あまり', 'あまり', '~한 나머지', '余(남을 여)り. 감정·정도가 과해서 발생한 결과', '문법-형식판단', 1024, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '驚いたあまり言葉が出なかった。', '놀란 나머지 말이 안 나왔다.', 1),
    (w, '緊張のあまり手が震えた。', '긴장한 나머지 손이 떨렸다.', 2);

  -- 1025. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほど', '~정도, ~만큼', '程(법 정). 정도·비례 표현', '문법-형식판단', 1025, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣きたいほど嬉しい。', '울고 싶을 정도로 기쁘다.', 1),
    (w, '彼ほど優しい人はいない。', '그만큼 친절한 사람은 없다.', 2);

  -- 1026. ～ものの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ものの', '~이지만, ~했지만 (역접)', '物(もの)+の. 격식 있는 역접', '문법-형식판단', 1026, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '習ったものの、すぐに忘れた。', '배웠지만 금세 잊어버렸다.', 1),
    (w, '免許を取ったものの、車を持っていない。', '면허는 땄지만 차는 없다.', 2);

  -- 1027. ～ことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことはない', '~할 필요는 없다', '事(こと)+は+ない. 「그렇게 할 필요가 없다」', '문법-형식판단', 1027, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心配することはない。', '걱정할 필요는 없다.', 1),
    (w, 'そんなに急ぐことはない。', '그렇게 서두를 필요는 없다.', 2);

  -- 1028. ～ないことには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないことには', '~하지 않고서는', 'ない+こと+には. 「~하지 않으면 진전 없음」', '문법-형식판단', 1028, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やってみないことには分からない。', '해 보지 않고서는 모른다.', 1),
    (w, '見ないことには判断できない。', '보지 않고서는 판단할 수 없다.', 2);

  -- 1029. ～だけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけ', '~한 만큼, ~할 수 있는 한', '丈(키 장)에서 유래. 정도·한도', '문법-형식판단', 1029, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べたいだけ食べていい。', '먹고 싶은 만큼 먹어도 된다.', 1),
    (w, 'できるだけ早く来てください。', '가능한 한 빨리 와 주세요.', 2);

  -- 1030. ～てくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てくれる', '(나에게) ~해 주다', '동사 て형+呉(줄 호)れる. 타인이 나/우리에게 베푸는 행위', '문법-형식판단', 1030, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達が手伝ってくれた。', '친구가 도와줬다.', 1),
    (w, '先生が教えてくれる。', '선생님이 가르쳐 준다.', 2);

  -- 1031. ～ずに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ずに', '~하지 않고', '문어체 부정 ず+に. 「~없이/안 하고」', '문법-형식판단', 1031, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝ご飯を食べずに出かけた。', '아침을 먹지 않고 나갔다.', 1),
    (w, '何も言わずに帰った。', '아무 말도 하지 않고 돌아갔다.', 2);

  -- 1032. ～おきに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～おきに', '~간격으로, ~걸러서', '置(둘 치)き+に. 일정 간격의 반복', '문법-형식판단', 1032, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一日おきにジムへ行く。', '하루 걸러 헬스장에 간다.', 1),
    (w, '5分おきにバスが来る。', '5분 간격으로 버스가 온다.', 2);

  -- 1033. かえって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '却って', 'かえって', '도리어, 오히려', '却(물리칠 각)って. 예상과 정반대 결과', '문법-형식판단', 1033, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '薬を飲んでかえって悪化した。', '약을 먹고 도리어 악화됐다.', 1),
    (w, '謝ったらかえって怒られた。', '사과했더니 오히려 화를 냈다.', 2);

  -- 1034. ～きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きる', '완전히 ~하다', '切(끊을 절)る. 동사ます형+きる. 끝까지·완전히', '문법-형식판단', 1034, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を読みきった。', '책을 다 읽었다.', 1),
    (w, '使いきってしまった。', '다 써 버렸다.', 2);

  -- 1035. ～ほかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほかない', '~할 수밖에 없다', '他(다를 타)+ない. 「다른 방법이 없음」', '문법-형식판단', 1035, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '諦めるほかない。', '포기할 수밖에 없다.', 1),
    (w, '待つほかなかった。', '기다릴 수밖에 없었다.', 2);

  -- 1036. ～こと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～こと', '~할 것 <명령·규칙>', '事(こと). 규칙·지시 문체에서 명령적', '문법-형식판단', 1036, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '校内では静かにすること。', '교내에서는 조용히 할 것.', 1),
    (w, '時間を守ること。', '시간을 지킬 것.', 2);

  -- 1037. ～なきゃって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なきゃって', '~해야 한다고', 'なきゃ(なければ)+って(인용). 회화체 의무 인용', '문법-형식판단', 1037, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く行かなきゃって思っている。', '빨리 가야 한다고 생각하고 있다.', 1),
    (w, '電話しなきゃって言ってた。', '전화해야 한다고 말했다.', 2);

  -- 1038. ～てほしいだろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てほしいだろうか', '~해 주기를 바라는 것일까?', 'てほしい+だろうか. 상대의 희망 추측 의문', '문법-형식판단', 1038, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は本当に来てほしいだろうか。', '그는 정말로 와 주기를 바라는 것일까?', 1),
    (w, '助けてほしいだろうか、考えてみよう。', '도와주기를 바라는 것일지 생각해 보자.', 2);

  -- 1039. ～につぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～につぐ', '~에 이어지는, ~다음으로', '次(다음 차)ぐ. 「~의 뒤를 잇다」', '문법-형식판단', 1039, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京につぐ大都市は大阪だ。', '도쿄에 이은 대도시는 오사카다.', 1),
    (w, '優勝につぐ準優勝に終わった。', '우승에 이은 준우승으로 끝났다.', 2);

  -- 1040. ～にしては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にしては', '~치고는', 'に+する+ては. 일반적 예상과 다른 평가', '문법-형식판단', 1040, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初心者にしては上手だ。', '초보자치고는 잘한다.', 1),
    (w, '冬にしては暖かい。', '겨울치고는 따뜻하다.', 2);

  -- 1041. お越しになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'お越しになる', 'おこしになる', '오시다, 가시다 <존경>', 'お+越し+になる. 行く/来る의 존경어', '문법-형식판단', 1041, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長がお越しになりました。', '사장님께서 오셨습니다.', 1),
    (w, 'こちらへお越しになってください。', '이쪽으로 오십시오.', 2);

  -- 1042. ～かけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かけ', '~하던 도중, ~하다 만', '掛(걸 괘)け. 동사ます형+かけ. 진행 중인 동작 중단', '문법-형식판단', 1042, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飲みかけのコーヒー。', '마시다 만 커피.', 1),
    (w, '言いかけてやめた。', '말하다 말았다.', 2);

  -- 1043. おいでになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'おいでになる', 'おいでになる', '오시다, 가시다, 계시다 <존경>', 'お+出で+になる. 行く/来る/いる의 존경어', '문법-형식판단', 1043, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生はおいでになりますか。', '선생님 계십니까?', 1),
    (w, 'いつおいでになりますか。', '언제 오십니까?', 2);

  -- 1044. ～ものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ものだ', '~로구나 <감동·당위>', '物(もの)+だ. 감동·일반 진리·도덕적 당위', '문법-형식판단', 1044, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間が経つのは早いものだ。', '시간이 흐르는 것은 빠르구나.', 1),
    (w, '年寄りを敬うものだ。', '노인을 공경하는 법이다.', 2);

  -- 1045. ～かねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かねる', '~하기 어렵다, ~할 수 없다', '兼(겸할 겸)ねる. 동사ます형+かねる. 정중한 거절', '문법-형식판단', 1045, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お答えしかねます。', '답변드리기 어렵습니다.', 1),
    (w, 'お受けしかねます。', '받기 어렵습니다.', 2);

  -- 1046. ～っこない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～っこない', '~할 리가 없다 <회화>', '동사ます형+っこない. 강한 부정 회화체', '문법-형식판단', 1046, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝てっこない。', '이길 리가 없다.', 1),
    (w, 'そんなこと、できっこない。', '그런 거 될 리가 없다.', 2);

  -- 1047. ～に対して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に対して', 'にたいして', '~에 대해서', '対(대할 대). 대상·태도·비교', '문법-형식판단', 1047, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に対して答える。', '질문에 대해 답한다.', 1),
    (w, '彼に対して優しい。', '그에게 친절하다.', 2);

  -- 1048. お～する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お～する', '~하다 <겸손>', 'お/ご+동사ます형/한자어+する. 화자 행위의 겸양', '문법-형식판단', 1048, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お持ちします。', '들어 드리겠습니다.', 1),
    (w, 'ご案内します。', '안내해 드리겠습니다.', 2);

  -- 1049. そのうち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そのうち', '머지않아, 가까운 시일 안에', 'その(그)+うち(안/사이). 시간 안에 곧', '문법-형식판단', 1049, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そのうち分かるよ。', '머지않아 알게 될 거야.', 1),
    (w, 'そのうち遊びに行く。', '가까운 시일 내에 놀러 갈게.', 2);

  -- 1050. ～以上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～以上', 'いじょう', '~한 이상 (당연한 귀결)', '以(써 이)+上(위 상). 「~인 이상은 당연히」', '문법-형식판단', 1050, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束した以上守るべきだ。', '약속한 이상 지켜야 한다.', 1),
    (w, '日本に来た以上、日本語を学ぶ。', '일본에 온 이상 일본어를 배운다.', 2);

  -- 1051. ～とする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とする', '~라고 하다 <가정·판단>', 'と(인용)+する. 가정·간주', '문법-형식판단', 1051, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果は同じだとする。', '결과는 같다고 하자.', 1),
    (w, '彼を犯人とする証拠はない。', '그를 범인이라 할 증거는 없다.', 2);

  -- 1052. ～だけなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけなら', '~뿐이라면', 'だけ(만)+なら(라면). 한정 조건', '문법-형식판단', 1052, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけなら無料です。', '보는 것뿐이라면 무료입니다.', 1),
    (w, '少しだけなら飲める。', '조금뿐이라면 마실 수 있다.', 2);

  -- 1053. ～てからにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てからにする', '~하고 나서 하다', 'てから+にする. 「~을 끝낸 후로 미루다」', '문법-형식판단', 1053, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食事してからにしよう。', '식사하고 나서 하자.', 1),
    (w, '相談してからにします。', '상담하고 나서 하겠습니다.', 2);

  -- 1054. ～することになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～することになる', '~하게 되다', 'する+こと+になる. 외부적 결정', '문법-형식판단', 1054, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来月から出張することになった。', '다음 달부터 출장하게 되었다.', 1),
    (w, '会議に参加することになる。', '회의에 참가하게 된다.', 2);

  -- 1055. ～ないことがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないことがある', '~하지 않는 경우가 있다', 'ない+こと+がある. 가끔의 부정 경우', '문법-형식판단', 1055, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は約束を守らないことがある。', '그는 약속을 안 지키는 경우가 있다.', 1),
    (w, '時々返事しないことがある。', '가끔 답장하지 않는 경우가 있다.', 2);

  -- 1056. ～って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～って', '~라고 해 <인용>', 'と의 회화체. 인용·전문', '문법-형식판단', 1056, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くって言ってた。', '간다고 말했어.', 1),
    (w, '雨だって聞いた。', '비라고 들었어.', 2);

  -- 1057. たとえ～ても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '例え～ても', 'たとえ', '설령 ~할지라도', '例(법식 례)え+ても. 강한 가정·양보', '문법-형식판단', 1057, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たとえ失敗しても諦めない。', '설령 실패해도 포기하지 않는다.', 1),
    (w, 'たとえ雨でも行く。', '설령 비라도 간다.', 2);

  -- 1058. ～おそれがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～恐れがある', 'おそれ', '~할 우려가 있다', '恐(두려울 공)れ+がある. 부정적 가능성', '문법-형식판단', 1058, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大雪のおそれがある。', '폭설의 우려가 있다.', 1),
    (w, '事故が起きるおそれがある。', '사고가 일어날 우려가 있다.', 2);

  -- 1059. ～ないかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないかな', '~하지 않을까? <기대·바람>', 'ない+か+な. 자신의 희망/기대를 혼잣말처럼', '문법-형식판단', 1059, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く春が来ないかな。', '빨리 봄이 오지 않을까.', 1),
    (w, '誰か助けてくれないかな。', '누가 도와주지 않을까.', 2);

  -- 1060. ～というように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というように', '~라는 식으로, ~라는 것처럼', 'という+ように. 인용+양태', '문법-형식판단', 1060, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '「もう帰りたい」というように見えた。', '"이제 돌아가고 싶다"는 것처럼 보였다.', 1),
    (w, '無理だというように首を振った。', '무리라는 듯이 고개를 흔들었다.', 2);

  -- 1061. ～じゃない？
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～じゃない？', '~아닐까? <확인·동의>', 'ではない의 회화체+の상승억양. 동의 구함', '문법-형식판단', 1061, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいんじゃない？', '좋은 거 아냐?', 1),
    (w, 'これ、君のじゃない？', '이거 네 거 아냐?', 2);

  -- 1062. ～できるものなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～できるものなら', '~할 수만 있다면', '可能(できる)+物なら. 거의 불가능한 일을 가정', '문법-형식판단', 1062, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けるものなら今すぐ行きたい。', '갈 수만 있다면 지금 당장 가고 싶다.', 1),
    (w, 'やり直せるものならやり直したい。', '다시 할 수만 있다면 다시 하고 싶다.', 2);

  -- 1063. ～てならない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てならない', '너무 ~하다, 견딜 수 없이 ~하다', '동사 て형+ならない. 자연발생적 감정 극한', '문법-형식판단', 1063, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '残念でならない。', '너무 안타깝다.', 1),
    (w, '気になってならない。', '너무 신경 쓰인다.', 2);

  -- 1064. お～です
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お～です', '~하시다 <존경>', 'お+동사ます형+です. 상대 행위 정중 존경', '문법-형식판단', 1064, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お忙しいですか。', '바쁘십니까?', 1),
    (w, 'お休みです。', '쉬고 계십니다.', 2);

  -- 1065. ～にでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にでも', '~에라도', 'に+でも. 막연한 대상/시점 제시', '문법-형식판단', 1065, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日にでも始めよう。', '내일이라도 시작하자.', 1),
    (w, '公園にでも行こうか。', '공원에라도 갈까?', 2);

  -- 1066. ～はずがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～はずがない', '~할 리가 없다', '筈+がない. 가능성 강한 부정', '문법-형식판단', 1066, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が嘘をつくはずがない。', '그가 거짓말할 리가 없다.', 1),
    (w, 'こんな問題が解けないはずがない。', '이런 문제를 못 풀 리가 없다.', 2);

  -- 1067. ～を通して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～を通して', 'をとおして', '~을 통해', '通(통할 통)す+て. 매개·기간', '문법-형식판단', 1067, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人を通して知った。', '친구를 통해 알게 됐다.', 1),
    (w, '一年を通して暖かい。', '일년 내내 따뜻하다.', 2);

  -- 1068. ～なら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なら', '~라면 <화제 제시>', '단정 だ의 가정형. 화제·가정 양용', '문법-형식판단', 1068, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語ならまかせて。', '일본어라면 맡겨.', 1),
    (w, '安いなら買おう。', '싸다면 사자.', 2);

  -- 1069. まさか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '真逆', 'まさか', '설마', '真(참 진)+逆. 부정·반어와 호응', '문법-형식판단', 1069, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まさかそんなはずがない。', '설마 그럴 리가 없다.', 1),
    (w, 'まさか彼が？', '설마 그가?', 2);

  -- 1070. ～てばかりだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てばかりだ', '~하기만 한다', '동사 て형+ばかり+だ. 같은 행위 반복·과다', '문법-형식판단', 1070, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣いてばかりだ。', '울고만 있다.', 1),
    (w, '寝てばかりいる。', '잠만 자고 있다.', 2);

  -- 1071. ～ということだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ということだ', '~라는 것이다 <전달·결론>', 'という+こと+だ. 전문·결론·해석', '문법-형식판단', 1071, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は退職するということだ。', '그는 퇴직한다는 것이다.', 1),
    (w, 'つまり、無理だということだ。', '즉, 무리라는 것이다.', 2);

  -- 1072. ございます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'ございます', '있습니다 <정중>', '御座(어좌)+ます. ある의 정중어', '문법-형식판단', 1072, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらに資料がございます。', '이쪽에 자료가 있습니다.', 1),
    (w, 'ありがとうございます。', '감사합니다.', 2);

  -- 1073. どうやって～したか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうやって～したか', '어떻게 ~한 것인지', 'どう+やって(방법). 방법 의문', '문법-형식판단', 1073, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうやって解いたか教えて。', '어떻게 푼 것인지 알려줘.', 1),
    (w, 'どうやって来たか知りたい。', '어떻게 왔는지 알고 싶다.', 2);

  -- 1074. ～(よ)うとしないで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(よ)うとしないで', '~하려고 하지 말고', '의지형+とする의 부정+で. 의지 자제 권유', '문법-형식판단', 1074, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無理にやろうとしないで休んで。', '무리해서 하려고 하지 말고 쉬어.', 1),
    (w, '隠そうとしないで話して。', '숨기려 하지 말고 말해줘.', 2);

  -- 1075. もらってくれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'もらってくれない', '받지 않을래? <부탁·의뢰>', '貰う+てくれる의 부정 의뢰형. 받아 달라', '문법-형식판단', 1075, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これ、もらってくれない？', '이거, 받아주지 않을래?', 1),
    (w, '古い本、もらってくれない？', '오래된 책 받아주지 않을래?', 2);

  -- 1076. ～たほうがよかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たほうがよかった', '~하는 편이 좋았다 <아쉬움>', '동사 た형+ほうがよかった. 사후 후회', '문법-형식판단', 1076, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く出発したほうがよかった。', '빨리 출발하는 편이 좋았다.', 1),
    (w, 'もっと勉強したほうがよかった。', '더 공부하는 편이 좋았다.', 2);

  -- 1077. ～てくださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てくださる', '~해 주시다 <존경>', 'てくれる의 존경어 くださる. 상대→나에게', '문법-형식판단', 1077, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生が教えてくださった。', '선생님께서 가르쳐 주셨다.', 1),
    (w, '手伝ってくださいませんか。', '도와주시지 않겠습니까?', 2);

  -- 1078. ～にしては (변형: 일반/특정)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にしては(2)', '~치고는 (일반과 비교)', 'にする+ては. 같은 표현이나 다양한 문맥 활용', '문법-형식판단', 1078, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供にしては大人びている。', '아이치고는 어른스럽다.', 1),
    (w, '安いにしては質がいい。', '싼 것치고는 품질이 좋다.', 2);

  -- 1079. いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '致す(2)', 'いたす', '하다 <겸양·정중>', '致す의 다양한 정중 회화 활용', '문법-형식판단', 1079, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お預かりいたします。', '맡아 두겠습니다.', 1),
    (w, '失礼いたしました。', '실례했습니다.', 2);

  -- 1080. ～向け
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～向け', 'むけ', '~대상, ~용', '向(향할 향)け. 대상자 설정', '문법-형식판단', 1080, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供向けの番組だ。', '아이들을 위한 프로그램이다.', 1),
    (w, '海外向けの製品。', '해외용 제품.', 2);

  -- 1081. ～たところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たところ(2)', '~했더니, ~한 결과', '발견·전개 강조의 たところ 재활용', '문법-형식판단', 1081, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞いたところ、本当だった。', '들어 보니 사실이었다.', 1),
    (w, '尋ねたところ、丁寧に答えてくれた。', '물어봤더니 정성껏 답해 주었다.', 2);

  -- 1082. ～たがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たがる', '~하고 싶어하다', 'たい+がる. 3인칭의 욕구 외적 표출', '문법-형식판단', 1082, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟は外で遊びたがる。', '동생은 밖에서 놀고 싶어한다.', 1),
    (w, '彼女は留学したがっている。', '그녀는 유학하고 싶어한다.', 2);

  -- 1083. ～わけにはいかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけにはいかない(2)', '~할 수는 없다 (의무·도덕)', '동일 표현, 사회·도덕적 제약 재활용', '문법-형식판단', 1083, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '途中でやめるわけにはいかない。', '도중에 그만둘 수는 없다.', 1),
    (w, '黙っているわけにはいかない。', '잠자코 있을 수는 없다.', 2);

  -- 1084. 申し上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '申し上げる(2)', 'もうしあげる', '말씀드리다 <겸양·정중>', '편지·격식문에서의 申し上げる', '문법-형식판단', 1084, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心からお礼申し上げます。', '진심으로 감사 말씀드립니다.', 1),
    (w, 'ご挨拶を申し上げます。', '인사 말씀드립니다.', 2);

  -- 1085. ～だけで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけで', '~만으로, ~하기만 해도', 'だけ(만)+で. 한정 조건·간이 결과', '문법-형식판단', 1085, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけで楽しい。', '보기만 해도 즐겁다.', 1),
    (w, '考えるだけで疲れる。', '생각만 해도 피곤하다.', 2);

  -- 1086. ～ように (지시·내용)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(2)', '~하도록 (간접지시·인용)', '간접지시·간접명령 ように 재활용', '문법-형식판단', 1086, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れないようにと言われた。', '늦지 않도록 말을 들었다.', 1),
    (w, '気をつけるようにしている。', '조심하도록 하고 있다.', 2);

  -- 1087. ～ておきなさい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ておきなさい', '~해 두세요 <지시>', 'ておく+なさい. 사전 준비 지시', '문법-형식판단', 1087, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題をやっておきなさい。', '숙제를 해 두세요.', 1),
    (w, '部屋を片付けておきなさい。', '방을 정리해 두세요.', 2);

  -- 1088. ～そうだ (전문)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ(전문)', '~라고 한다', '동사 보통형+そうだ. 들은 정보 전달', '문법-형식판단', 1088, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は結婚するそうだ。', '그는 결혼한다고 한다.', 1),
    (w, '明日は雪が降るそうだ。', '내일은 눈이 온다고 한다.', 2);

  -- 1089. ～かと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かと思う', '~할까 하고 생각하다', 'か+と+思う. 막연한 의도/추측', '문법-형식판단', 1089, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し休もうかと思っている。', '잠시 쉴까 하고 생각하고 있다.', 1),
    (w, '出かけようかと思った。', '나갈까 하고 생각했다.', 2);

  -- 1090. ～もしないで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～もしないで', '~도 하지 않고', 'も+しないで. 부정 동작 강조', '문법-형식판단', 1090, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強もしないで遊んでいる。', '공부도 안 하고 놀고 있다.', 1),
    (w, '挨拶もしないで出て行った。', '인사도 없이 나가 버렸다.', 2);

  -- 1091. ～ついでに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～ついでに', 'ついでに', '~하는 김에', '序(차례 서)で. 어떤 행위 기회에 다른 행위', '문법-형식판단', 1091, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買い物のついでに郵便局へ行った。', '쇼핑하는 김에 우체국에 갔다.', 1),
    (w, '散歩のついでにパンを買った。', '산책 하는 김에 빵을 샀다.', 2);

  -- 1092. いったい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '一体', 'いったい', '도대체', '一(한 일)+体(몸 체). 강조 의문 부사', '문법-형식판단', 1092, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いったいどうしたの？', '도대체 무슨 일이야?', 1),
    (w, 'いったい誰が言ったの？', '도대체 누가 말한 거야?', 2);

  -- 1093. ～にしたがって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にしたがって', '~에 따라 (변화·지시)', '従(따를 종)う+て. 비례·지시 따름', '문법-형식판단', 1093, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年を取るにしたがって体力が落ちる。', '나이가 들어 감에 따라 체력이 떨어진다.', 1),
    (w, '指示にしたがって行動する。', '지시에 따라 행동한다.', 2);

  -- 1094. ～一方だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～一方だ(2)', 'いっぽうだ', '~하기만 하다 (악화)', '같은 표현, 부정적 진행 강조', '문법-형식판단', 1094, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '景気は悪くなる一方だ。', '경기는 악화되기만 한다.', 1),
    (w, '彼の態度は冷たくなる一方だ。', '그의 태도는 차가워지기만 한다.', 2);

  -- 1095. ～ざるを得ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ざるを得ない(2)', '~하지 않을 수 없다 (격식)', '문어체 변형 ざるを得ない. 격식', '문법-형식판단', 1095, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事実を認めざるを得ない。', '사실을 인정하지 않을 수 없다.', 1),
    (w, '彼の意見に賛成せざるを得ない。', '그의 의견에 찬성하지 않을 수 없다.', 2);

  -- 1096. お/ご～です
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お/ご～です', '~하시다 <존경>', 'お/ご+ます형/한자어+です. 상대의 행위·상태 존경', '문법-형식판단', 1096, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お待ちです。', '기다리고 계십니다.', 1),
    (w, 'ご利用です。', '이용하고 계십니다.', 2);

  -- 1097. ～しか～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～しか～ない', '~밖에 ~할 수 없다', 'しか(밖에)+ない. 한정·소량 강조', '문법-형식판단', 1097, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '500円しか持っていない。', '500엔밖에 가지고 있지 않다.', 1),
    (w, '彼にしかできない。', '그밖에 할 수 없다.', 2);

  -- 1098. ～よりも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～よりも', '~보다도', 'より(보다)+も(도). 비교 강조', '문법-형식판단', 1098, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は昨日よりも寒い。', '오늘은 어제보다도 춥다.', 1),
    (w, '何よりも健康が大事だ。', '무엇보다도 건강이 중요하다.', 2);

  -- 1099. ～ままにせず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ままにせず', '~한 채로 두지 말고', 'まま+に+せず. 방치 부정', '문법-형식판단', 1099, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '汚れたままにせず洗おう。', '더러운 채로 두지 말고 씻자.', 1),
    (w, '放置したままにせずに対処してください。', '방치한 채로 두지 말고 대처해 주세요.', 2);

  -- 1100. ～ようとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようとする(2)', '~하려고 하다', '의지·시도 표현 재활용', '문법-형식판단', 1100, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寝ようとしたら電話が鳴った。', '자려고 했더니 전화가 울렸다.', 1),
    (w, '何度もやろうとしたが失敗した。', '여러 번 하려 했지만 실패했다.', 2);

  -- 1101. ～させてもらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～させてもらう', '~하다 <사역수동·겸양>', '사역+てもらう. 「~하게 받음」 겸양', '문법-형식판단', 1101, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お先に帰らせてもらいます。', '먼저 돌아가겠습니다.', 1),
    (w, '発表させてもらいます。', '발표하겠습니다.', 2);

  -- 1102. ～だらけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だらけ', '~투성이', '명사+だらけ. 부정적 가득 상태', '문법-형식판단', 1102, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泥だらけの靴。', '진흙투성이 신발.', 1),
    (w, 'ミスだらけの答案。', '실수투성이 답안.', 2);

  -- 1103. ～としても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としても', '~라고 할지라도', 'とする+ても. 가정 양보', '문법-형식판단', 1103, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くとしても遅れる。', '간다고 해도 늦는다.', 1),
    (w, '本当だとしても信じられない。', '사실이라 해도 믿을 수 없다.', 2);

  -- 1104. ～にあたって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にあたって', '~에 즈음하여, ~에 있어서', '当(마땅 당)たる+て. 중요 시점/사태에 즈음', '문법-형식판단', 1104, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '開会にあたって挨拶した。', '개회에 즈음하여 인사했다.', 1),
    (w, '出発にあたって注意事項を確認する。', '출발에 즈음하여 주의 사항을 확인한다.', 2);

  -- 1105. ～てたまらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てたまらない', '~해서 견딜 수 없다 (너무 ~하다)', '堪(견딜 감)らない. 감각·욕구 극한', '문법-형식판단', 1105, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会いたくてたまらない。', '너무 만나고 싶다.', 1),
    (w, '暑くてたまらない。', '너무 더워서 견딜 수 없다.', 2);

  -- 1106. そういう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そういう', '그러한', 'そう(그렇게)+いう. 지시 연체사', '문법-형식판단', 1106, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう人は珍しい。', '그러한 사람은 드물다.', 1),
    (w, 'そういう場合はどうするの？', '그러한 경우엔 어떻게 해?', 2);

  -- 1107. ～きる(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きる(2)', '완전히 ~하다 (완수)', '동일 표현, 동작 완수 강조', '문법-형식판단', 1107, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走りきった。', '끝까지 달렸다.', 1),
    (w, '言いきった。', '단언했다.', 2);

  -- 1108. ～ように (목적)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(목적)', '~하도록 (목적)', '동사 사전형/ない형+ように. 목적·예방', '문법-형식판단', 1108, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間に合うように早く出た。', '늦지 않게 일찍 나갔다.', 1),
    (w, '風邪をひかないように気をつけて。', '감기에 걸리지 않도록 조심해.', 2);

  -- 1109. ～としては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としては', '~의 입장에서는, ~로서는', 'と+しては. 입장·관점 제시', '문법-형식판단', 1109, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私としては賛成だ。', '나로서는 찬성이다.', 1),
    (w, '会社としては答えられない。', '회사로서는 답할 수 없다.', 2);

  -- 1110. ～ば～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ば～ほど', '~하면 ~할수록', 'ば(가정)+ほど(정도). 비례 변화', '문법-형식판단', 1110, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えれば考えるほど分からなくなる。', '생각하면 생각할수록 모르게 된다.', 1),
    (w, '早ければ早いほどいい。', '빠르면 빠를수록 좋다.', 2);

  -- 1111. どうしても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうしても', '무슨 일이 있어도, 꼭', 'どう+しても. 강한 의지/필연성', '문법-형식판단', 1111, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしても行きたい。', '꼭 가고 싶다.', 1),
    (w, 'どうしても忘れられない。', '아무리 해도 잊을 수 없다.', 2);

  -- 1112. ～そうだ (전문 2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ(전문2)', '~라고 한다 <전문>', '전문 そうだ의 재활용', '문법-형식판단', 1112, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は留学するそうだ。', '그는 유학한다고 한다.', 1),
    (w, '昨日地震があったそうだ。', '어제 지진이 있었다고 한다.', 2);

  -- 1113. ～だろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だろうか', '~일까? <자문·의문>', 'だろう+か. 자신/타인에 대한 의문', '문법-형식판단', 1113, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は本当に来るだろうか。', '그는 정말 올까?', 1),
    (w, 'これでいいのだろうか。', '이걸로 될까?', 2);

  -- 1114. ～末(に)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～末(に)', 'すえに', '~한 끝에', '末(끝 말). 오랜 과정 후의 결과', '문법-형식판단', 1114, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '迷った末に決めた。', '망설인 끝에 결정했다.', 1),
    (w, '苦労の末に成功した。', '고생 끝에 성공했다.', 2);

  -- 1115. ～たことにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たことにする', '~한 것으로 치다', 'た+こと+にする. 사실과 다르게 처리', '문법-형식판단', 1115, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞かなかったことにする。', '못 들은 걸로 한다.', 1),
    (w, '行ったことにしておこう。', '갔던 걸로 해 두자.', 2);

  -- 1116. ～だろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だろう', '~일 것이다', 'だ의 추량형. 추측·확인', '문법-형식판단', 1116, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日は晴れるだろう。', '내일은 맑을 것이다.', 1),
    (w, '彼は来るだろう。', '그는 올 것이다.', 2);

  -- 1117. ～に備えて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に備えて', 'にそなえて', '~에 대비하여', '備(갖출 비)える+て. 사전 준비', '문법-형식판단', 1117, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地震に備えて備蓄する。', '지진에 대비하여 비축한다.', 1),
    (w, '試験に備えて勉強する。', '시험에 대비하여 공부한다.', 2);

  -- 1118. ～もあれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～もあれば', '~정도만 있다면', 'も+あれば. 충분조건/병렬', '문법-형식판단', 1118, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一日もあれば終わる。', '하루만 있으면 끝난다.', 1),
    (w, '時間もあれば余裕で間に合う。', '시간만 있으면 여유롭게 간다.', 2);

  -- 1119. お/ご～くださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お/ご～くださる', '~해 주시다 <존경>', 'お/ご+ます형+くださる. 상대 행위 정중 존경', '문법-형식판단', 1119, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お読みくださる。', '읽어 주시다.', 1),
    (w, 'ご利用くださる。', '이용해 주시다.', 2);

  -- 1120. ～に決まっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～に決まっている', '반드시 ~하게 되어 있다, 틀림없이 ~하다', '決(결정할 결)まる+ている. 강한 확신', '문법-형식판단', 1120, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が勝つに決まっている。', '그가 이길 게 뻔하다.', 1),
    (w, '冬は寒いに決まっている。', '겨울은 추운 게 당연하다.', 2);

  -- 1121. ～しか～ない (2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～しか～ない(2)', '~밖에 ~할 수 없다 (가능)', '가능형 부정과 결합한 한정 표현', '문법-형식판단', 1121, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本語しか話せない。', '일본어밖에 말할 수 없다.', 1),
    (w, '一人しか入れない。', '한 명밖에 들어갈 수 없다.', 2);

  -- 1122. ～ようにしておく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようにしておく', '~하도록 해 두다', 'ようにする+ておく. 사전 준비 의도', '문법-형식판단', 1122, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見えるようにしておく。', '보이도록 해 둔다.', 1),
    (w, '使えるようにしておく。', '쓸 수 있도록 해 둔다.', 2);

  -- 1123. ～に違いない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～に違いない', '~에 틀림없다', '違(어긋날 위)い+ない. 강한 확신', '문법-형식판단', 1123, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は嘘をついているに違いない。', '그는 거짓말하고 있는 게 틀림없다.', 1),
    (w, 'これは本物に違いない。', '이건 진품임에 틀림없다.', 2);

  -- 1124. ～ように (목적3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(3)', '~하도록 (지시·인용)', '간접 지시·간접 명령 ように', '문법-형식판단', 1124, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気をつけるように伝えてください。', '조심하라고 전해 주세요.', 1),
    (w, '早く来るようにと言われた。', '빨리 오라고 들었다.', 2);

  -- 1125. ～てよかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てよかった', '~해서 다행이다', '동사 て형+よかった. 만족·안도', '문법-형식판단', 1125, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会えてよかった。', '만나서 다행이다.', 1),
    (w, '無事でよかった。', '무사해서 다행이다.', 2);

  -- 1126. ～ぶりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ぶりに', '~만에', '振(떨칠 진)り. 시간 경과 후 재발생', '문법-형식판단', 1126, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '5年ぶりに会った。', '5년 만에 만났다.', 1),
    (w, '一週間ぶりに晴れた。', '일주일 만에 맑게 갰다.', 2);

  -- 1127. ～こそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～こそ', '~야말로', '강조 조사 こそ. 한정 강조', '문법-형식판단', 1127, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度こそ成功する。', '이번에야말로 성공한다.', 1),
    (w, '今こそチャンスだ。', '지금이야말로 기회다.', 2);

  -- 1128. ～ところから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ところから', '~때문에, ~한 점에서', '所(ところ)+から. 사물의 일면을 근거로', '문법-형식판단', 1128, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っているところから出かけない。', '비가 오고 있어서 나가지 않는다.', 1),
    (w, '彼が知っているところから尋ねる。', '그가 안다는 점에서 묻는다.', 2);

  -- 1129. あとは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '後は', 'あとは', '이제는, 남은 일은', '後(뒤 후)+は. 「남은 것은」', '문법-형식판단', 1129, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あとは結果を待つだけだ。', '이제는 결과를 기다릴 뿐이다.', 1),
    (w, 'あとは君次第だ。', '남은 일은 너에게 달렸다.', 2);

  -- 1130. ～場合でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～場合でも', 'ばあいでも', '~한 경우라도', '場合(경우)+でも. 양보적 가정', '문법-형식판단', 1130, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨の場合でも開催する。', '비가 오는 경우라도 개최한다.', 1),
    (w, '失敗した場合でも責任は取らない。', '실패한 경우라도 책임은 안 진다.', 2);

  -- 1131. ～ようでいて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようでいて', '~한 것 같지만', '様+で+いて. 외관과 실제의 차이', '문법-형식판단', 1131, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡単なようでいて実は難しい。', '쉬워 보이지만 실은 어렵다.', 1),
    (w, '冷たいようでいて優しい。', '차가워 보이지만 다정하다.', 2);

  -- 1132. ～てしまわないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てしまわないか', '~해 버리지 않을까', 'てしまう+ない+か. 부정적 결과 우려', '문법-형식판단', 1132, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忘れてしまわないか心配だ。', '잊어버리지 않을까 걱정이다.', 1),
    (w, '壊してしまわないか不安だ。', '망가뜨리지 않을까 불안하다.', 2);

  -- 1133. ～つもりだった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～つもりだった', '~할 생각이었다', 'つもり+だった. 의도했으나 미실현', '문법-형식판단', 1133, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くつもりだったが行けなかった。', '갈 생각이었지만 못 갔다.', 1),
    (w, '断るつもりだった。', '거절할 생각이었다.', 2);

  -- 1134. ～かねる(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かねる(2)', '~할 수 없다, ~하기 어렵다', '兼ねる. 정중한 불가/거절', '문법-형식판단', 1134, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断しかねます。', '판단하기 어렵습니다.', 1),
    (w, '分かりかねます。', '알기 어렵습니다.', 2);

  -- 1135. ～そうだ(양태2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ(양태2)', '~할 것 같다', '양태 そうだ 재활용', '문법-형식판단', 1135, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣きそうだ。', '울 것 같다.', 1),
    (w, '崩れそうな壁。', '무너질 듯한 벽.', 2);

  -- 1136. お越しくださる(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'お越しくださる(2)', 'おこしくださる', '오시다 <존경>', '재활용. 정중한 초대 표현', '문법-형식판단', 1136, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜひお越しくださいませ。', '꼭 와 주십시오.', 1),
    (w, 'お越しくださり光栄です。', '와 주셔서 영광입니다.', 2);

  -- 1137. よければ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '良ければ', 'よければ', '괜찮다면, 좋다면', '良(좋을 양)い+ば. 정중한 제안', '문법-형식판단', 1137, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よければご一緒にどうですか。', '괜찮으시면 같이 어떠세요?', 1),
    (w, 'よければ手伝います。', '괜찮다면 돕겠습니다.', 2);

  -- 1138. ～すら(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すら(2)', '~조차, ~마저', '극단적 예시 すら 재활용', '문법-형식판단', 1138, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '基本すら知らない。', '기본조차 모른다.', 1),
    (w, '水すら飲めなかった。', '물조차 마실 수 없었다.', 2);

  -- 1139. どうも(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうも(2)', '어쩐지, 도무지', '추측·확언 부정과 호응하는 부사', '문법-형식판단', 1139, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうも分からない。', '도무지 모르겠다.', 1),
    (w, 'どうも変だ。', '어쩐지 이상하다.', 2);

  -- 1140. ～を問わず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～を問わず', 'をとわず', '~을 불문하고', '問(물을 문)わず. 조건 무관', '문법-형식판단', 1140, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '男女を問わず参加できる。', '남녀를 불문하고 참가할 수 있다.', 1),
    (w, '経験を問わず採用する。', '경험을 불문하고 채용한다.', 2);

  -- 1141. ～にかぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～にかぎる', 'にかぎる', '~에 한해서 (~할 때만)', '限(한할 한)る. 한정·최선 강조', '문법-형식판단', 1141, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏はビールに限る。', '여름엔 맥주가 최고다.', 1),
    (w, '会員にかぎる。', '회원에 한한다.', 2);

  -- 1142. ～せいか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～せいか', '~탓인지', '所為(せい, 탓)+か. 부정적 원인 추측', '문법-형식판단', 1142, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒いせいか体調が悪い。', '추운 탓인지 몸이 안 좋다.', 1),
    (w, '疲れているせいか集中できない。', '피곤한 탓인지 집중이 안 된다.', 2);

  -- 1143. ～ことに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことに', '~하게도', '事+に. 화자 감정 강조', '문법-형식판단', 1143, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '驚いたことに彼が来た。', '놀랍게도 그가 왔다.', 1),
    (w, '残念なことに合格しなかった。', '안타깝게도 합격하지 못했다.', 2);

  -- 1144. ～ないと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないと', '~하지 않으면', 'ない+と. 부정 조건', '문법-형식판단', 1144, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急がないと遅れる。', '서두르지 않으면 늦는다.', 1),
    (w, '勉強しないと合格できない。', '공부하지 않으면 합격할 수 없다.', 2);

  -- 1145. ～られなかったら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～られなかったら', '~할 수 없다면', '가능형+ない+たら. 가능 불성립 가정', '문법-형식판단', 1145, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行かれなかったら教えて。', '갈 수 없다면 알려줘.', 1),
    (w, '答えられなかったら助ける。', '답할 수 없다면 도와줄게.', 2);

  -- 1146. ～ぬく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ぬく', '끝까지 ~하다', '抜(뺄 발)く. 동사ます형+ぬく. 끝까지 관철', '문법-형식판단', 1146, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最後までやりぬく。', '끝까지 해내다.', 1),
    (w, '考えぬいて出した結論。', '끝까지 생각해 낸 결론.', 2);

  -- 1147. 伺う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '伺う', 'うかがう', '듣다, 여쭈다, 찾아뵙다 <겸양>', '伺(엿볼 사)う. 訪問·尋ねる·聞く의 겸양', '문법-형식판단', 1147, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お話を伺いたいです。', '말씀을 듣고 싶습니다.', 1),
    (w, '明日伺います。', '내일 찾아뵙겠습니다.', 2);

  -- 1148. ～させてもらう(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～させてもらう(2)', '~하다 <사역수동·겸양>', '겸양적 행위 표현 재활용', '문법-형식판단', 1148, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませてもらいます。', '쉬겠습니다.', 1),
    (w, '考えさせてもらう。', '생각하게 해 주세요.', 2);

  -- 1149. ～ばいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばいい', '~하면 된다', 'ば+いい. 조언·충분조건', '문법-형식판단', 1149, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話すればいい。', '전화하면 된다.', 1),
    (w, '謝ればいいでしょ。', '사과하면 되잖아.', 2);

  -- 1150. ～しかない(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～しかない(2)', '~할 수밖에 없다', '유일 선택 표현 재활용', '문법-형식판단', 1150, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やるしかない。', '할 수밖에 없다.', 1),
    (w, '我慢するしかない。', '참을 수밖에 없다.', 2);

  -- 1151. ～にあたって(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にあたって(2)', '~에 즈음하여 (격식)', '격식·공식문 にあたって 재활용', '문법-형식판단', 1151, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新年を迎えるにあたってご挨拶申し上げます。', '신년을 맞이하면서 인사 말씀드립니다.', 1),
    (w, '開業にあたって祝辞を述べる。', '개업에 즈음하여 축사를 한다.', 2);

  -- 1152. まさか(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'まさか(2)', '설마', '강한 의외 표현 まさか 재활용', '문법-형식판단', 1152, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まさかと思った。', '설마 했다.', 1),
    (w, 'まさかこんなことになるとは。', '설마 이렇게 될 줄이야.', 2);

  -- 1153. ～というより
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というより', '~라기보다', 'という+より. 비교·정정', '문법-형식판단', 1153, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒いというより痛い。', '춥다기보다 아프다.', 1),
    (w, '友達というより家族だ。', '친구라기보다 가족이다.', 2);

  -- 1154. ～て以来
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～て以来', 'ていらい', '~한 이래', '以(써 이)+来(올 래). 어떤 시점 이후 지속', '문법-형식판단', 1154, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本に来て以来、一度も帰っていない。', '일본에 온 이래 한 번도 돌아가지 않았다.', 1),
    (w, '別れて以来、会っていない。', '헤어진 이래 만나지 않고 있다.', 2);

  -- 1155. ～ならともかく(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ならともかく(2)', '~이라면 몰라도', '양보·예외 표현 재활용', '문법-형식판단', 1155, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度ならともかく毎回はひどい。', '한 번이라면 몰라도 매번은 심하다.', 1),
    (w, '無料ならともかく有料では行かない。', '무료라면 몰라도 유료라면 안 간다.', 2);

  -- 1156. ～にでもなって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にでもなって', '~나 되어서, ~라도 되어서', 'に+でも+なって. 어림짐작', '문법-형식판단', 1156, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大人にでもなって考えてみろ。', '어른이라도 되어서 생각해 봐라.', 1),
    (w, '医者にでもなったらと思う。', '의사라도 되었으면 한다.', 2);

  -- 1157. ～ように(4)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(4)', '~하도록 (기원·습관)', '기원·습관 ように 재활용', '문법-형식판단', 1157, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康でありますように。', '건강하시기를.', 1),
    (w, '毎日運動するようにしている。', '매일 운동하도록 하고 있다.', 2);

  -- 1158. ～ようがない(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようがない(2)', '~할 수가 없다, ~할 방도가 없다', '수단 부재 ようがない 재활용', '문법-형식판단', 1158, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '助けようがない。', '도울 방도가 없다.', 1),
    (w, '答えようがない。', '답할 방도가 없다.', 2);

  -- 1159. ご覧いただく(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご覧いただく(2)', 'ごらんいただく', '봐 주시다 <겸손>', '겸손 표현 ご覧いただく 재활용', '문법-형식판단', 1159, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こちらをご覧いただけますか。', '이쪽을 봐 주시겠습니까?', 1),
    (w, 'ホームページをご覧いただきたい。', '홈페이지를 봐 주셨으면 합니다.', 2);

  -- 1160. ～きる(3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きる(3)', '완전히 ~하다 (완료)', '완료 きる 재활용', '문법-형식판단', 1160, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読みきってしまった。', '다 읽어 버렸다.', 1),
    (w, '疲れきった顔。', '완전히 지친 얼굴.', 2);

  -- 1161. ～たらよかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たらよかった', '~했으면 좋았을 텐데', 'たら+よかった. 사후 후회', '문법-형식판단', 1161, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと早く行ったらよかった。', '더 빨리 갔으면 좋았을 텐데.', 1),
    (w, '正直に話したらよかった。', '솔직하게 말했으면 좋았을 텐데.', 2);

  -- 1162. ～かけ(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かけ(2)', '~하던 도중', '진행 중단 かけ 재활용', '문법-형식판단', 1162, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読みかけの本。', '읽다 만 책.', 1),
    (w, '言いかけの言葉。', '말하다 만 말.', 2);

  -- 1163. むしろ(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'むしろ(2)', '오히려, 차라리', '비교 후 선호 むしろ 재활용', '문법-형식판단', 1163, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くよりむしろやめたい。', '가기보다 차라리 그만두고 싶다.', 1),
    (w, 'むしろその方がいい。', '오히려 그게 낫다.', 2);

  -- 1164. ～に向けて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に向けて', 'にむけて', '~를 목표로, ~를 향해', '向(향할 향)け+て. 목적/대상', '문법-형식판단', 1164, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験合格に向けて頑張る。', '시험 합격을 목표로 노력한다.', 1),
    (w, '若者に向けて発信する。', '젊은이들을 향해 발신한다.', 2);

  -- 1165. ～なら(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なら(2)', '~이라면', '화제·가정 なら 재활용', '문법-형식판단', 1165, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ラーメンなら大好きだ。', '라멘이라면 정말 좋아한다.', 1),
    (w, '本当ならすぐ行く。', '사실이라면 당장 간다.', 2);

  -- 1166. ～ように(5)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(5)', '~하도록 (희망)', '희망·기원 ように 재활용', '문법-형식판단', 1166, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格できますように。', '합격할 수 있도록.', 1),
    (w, '幸せでありますように。', '행복하시기를.', 2);

  -- 1167. ～からといって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～からといって', '~라고 해서', 'から+といって. 이유와 다른 결과/부분 부정', '문법-형식판단', 1167, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高いからといっていいわけではない。', '비싸다고 해서 다 좋은 것은 아니다.', 1),
    (w, '雨だからといって中止にはならない。', '비라고 해서 중지되지는 않는다.', 2);

  -- 1168. ～たびに(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たびに(2)', '~할 때마다', '반복 たびに 재활용', '문법-형식판단', 1168, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るたびに泣いてしまう。', '볼 때마다 울고 만다.', 1),
    (w, '聞くたびに新しい発見がある。', '들을 때마다 새로운 발견이 있다.', 2);

  -- 1169. ～だっけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だっけ', '~였더라?', 'だ+っけ. 기억 확인 회화체', '문법-형식판단', 1169, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は明日だっけ？', '회의는 내일이었더라?', 1),
    (w, '彼の名前、何だっけ？', '그 사람 이름이 뭐였더라?', 2);

  -- 1170. ～ずにいる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ずにいる', '~하지 않고 있다', 'ず+に+いる. 부정 상태 지속', '문법-형식판단', 1170, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何も食べずにいる。', '아무것도 안 먹고 있다.', 1),
    (w, '連絡せずにいた。', '연락하지 않고 있었다.', 2);

  -- 1171. 申し上げる(3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '申し上げる(3)', 'もうしあげる', '말씀드리다 <겸양>', '겸양어 申し上げる 재활용', '문법-형식판단', 1171, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お詫び申し上げます。', '사과 말씀드립니다.', 1),
    (w, 'ご報告申し上げます。', '보고드립니다.', 2);

  -- 1172. ～そうになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうになる', '~할 뻔 하다', '양태 そう+になる. 동작 직전 상태', '문법-형식판단', 1172, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転びそうになった。', '넘어질 뻔했다.', 1),
    (w, '泣きそうになる。', '울 뻔하다.', 2);

  -- 1173. ～ほど(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほど(2)', '~정도', '정도 ほど 재활용', '문법-형식판단', 1173, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '1時間ほど待った。', '1시간 정도 기다렸다.', 1),
    (w, '驚くほど安い。', '놀랄 만큼 싸다.', 2);

  -- 1174. ～もあれば(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～もあれば(2)', '~정도만 있다면', '충분 조건 もあれば 재활용', '문법-형식판단', 1174, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '30分もあれば終わる。', '30분만 있으면 끝난다.', 1),
    (w, 'お金もあれば旅行できる。', '돈만 있으면 여행할 수 있다.', 2);

  -- 1175. そのうち(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そのうち(2)', '머지않아', '시간 そのうち 재활용', '문법-형식판단', 1175, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そのうち会おう。', '머지않아 만나자.', 1),
    (w, 'そのうちわかるだろう。', '머지않아 알게 될 것이다.', 2);

  -- 1176. ～どころか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～どころか', '~는커녕', '所(ところ)+か. 예상보다 더 강한 부정', '문법-형식판단', 1176, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強どころか遊んでばかりだ。', '공부는커녕 놀기만 한다.', 1),
    (w, '寒いどころか凍えそうだ。', '추운 정도는커녕 얼어 죽을 것 같다.', 2);

  -- 1177. ～だけは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけは', '~만은', 'だけ+は. 한정적 강조', '문법-형식판단', 1177, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これだけは譲れない。', '이것만은 양보할 수 없다.', 1),
    (w, '約束だけは守る。', '약속만은 지킨다.', 2);

  -- 1178. ～にともなって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にともなって', '~에 따라서', '伴(짝 반)う+て. 동반·비례 변화', '문법-형식판단', 1178, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人口の増加に伴って問題が増えた。', '인구 증가에 따라 문제가 늘었다.', 1),
    (w, '時代の変化に伴って働き方も変わる。', '시대 변화에 따라 일하는 방식도 변한다.', 2);

  -- 1179. ～うちに(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～うちに(2)', '~하는 사이에', '상태 지속 中 うちに 재활용', '문법-형식판단', 1179, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読んでいるうちに眠くなった。', '읽고 있는 사이에 졸렸다.', 1),
    (w, '冷めないうちに食べよう。', '식기 전에 먹자.', 2);

  -- 1180. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことから', '~로 인해, ~때문에', '事+から. 사실을 근거로 한 추론', '문법-형식판단', 1180, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雪が積もっていることから道が滑る。', '눈이 쌓여 있어 길이 미끄럽다.', 1),
    (w, '値段が安いことから人気が出た。', '가격이 싸서 인기가 생겼다.', 2);

  -- 1181. いらっしゃる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'いらっしゃる', 'いらっしゃる', '계시다, 가시다, 오시다 <존경>', 'いる/行く/来る의 존경어', '문법-형식판단', 1181, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生はいらっしゃいますか。', '선생님 계십니까?', 1),
    (w, 'またいらしてください。', '또 와 주세요.', 2);

  -- 1182. ～がちだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がちだ', '~한 경향이 있다, ~하기 일쑤다', '勝ち+だ. 부정적 경향', '문법-형식판단', 1182, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は忘れがちだ。', '그는 자주 잊어버린다.', 1),
    (w, '冬は風邪をひきがちだ。', '겨울에는 감기에 걸리기 일쑤다.', 2);

  -- 1183. ～ことはない(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことはない(2)', '~할 필요는 없다', '필요성 부정 ことはない 재활용', '문법-형식판단', 1183, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くことはない。', '울 필요는 없다.', 1),
    (w, '謝ることはない。', '사과할 필요는 없다.', 2);

  -- 1184. ～ことにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことにする', '~하기로 하다', '동사 사전형+こと+にする. 자기 결정', '문법-형식판단', 1184, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎朝走ることにした。', '매일 아침 달리기로 했다.', 1),
    (w, '禁煙することにする。', '금연하기로 한다.', 2);

  -- 1185. ～ないといけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないといけない', '~하지 않으면 안된다', 'ない+と+いけない. 의무·필요', '문법-형식판단', 1185, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く起きないといけない。', '일찍 일어나야 한다.', 1),
    (w, 'これを覚えないといけない。', '이걸 외워야 한다.', 2);

  -- 1186. ～につれて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～につれて', '~함에 따라서', '連(이을 련)れて. 비례 변화', '문법-형식판단', 1186, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '年を取るにつれて忘れっぽくなる。', '나이가 들어 감에 따라 잊기 쉬워진다.', 1),
    (w, '近づくにつれて緊張する。', '가까워질수록 긴장된다.', 2);

  -- 1187. 二度と～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '二度と～ない', 'にどと', '두 번 다시 ~하지 않는다', '二+度+と+ない. 강한 결심', '문법-형식판단', 1187, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二度と行かない。', '두 번 다시 안 간다.', 1),
    (w, '二度と話さない。', '두 번 다시 안 말한다.', 2);

  -- 1188. ～ものの(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ものの(2)', '~했지만 (역접)', '역접 ものの 재활용', '문법-형식판단', 1188, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言ったものの、後悔した。', '말은 했지만 후회했다.', 1),
    (w, '頑張ったものの、結果は出なかった。', '노력했지만 결과는 안 나왔다.', 2);

  -- 1189. ～としてなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としてなら', '~로서라면', 'として+なら. 자격·역할 조건', '문법-형식판단', 1189, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人としてなら相談に乗る。', '친구로서라면 상담해 주겠다.', 1),
    (w, '社員としてなら賛成だ。', '사원으로서라면 찬성이다.', 2);

  -- 1190. ～たばかりだ(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たばかりだ(2)', '막 ~한 참이다', '동작 직후 たばかり 재활용', '문법-형식판단', 1190, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰ったばかりだ。', '막 돌아온 참이다.', 1),
    (w, '買ったばかりの服。', '막 산 옷.', 2);

  -- 1191. ～というように(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というように(2)', '~라는 식으로', '인용+양태 というように 재활용', '문법-형식판단', 1191, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '迷惑だというように顔をしかめた。', '귀찮다는 듯이 얼굴을 찌푸렸다.', 1),
    (w, '何でもないというように笑った。', '아무것도 아니라는 듯이 웃었다.', 2);

  -- 1192. ～ことで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことで', '~로 인해, ~함으로써', '事+で. 원인·수단', '문법-형식판단', 1192, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '練習することで上達する。', '연습함으로써 실력이 는다.', 1),
    (w, '話したことで誤解が解けた。', '이야기함으로써 오해가 풀렸다.', 2);

  -- 1193. ～以来
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～以来', 'いらい', '~이래', '以(써 이)+来(올 래). 시점 이후 지속', '문법-형식판단', 1193, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入社以来、休んだことがない。', '입사 이래 쉰 적이 없다.', 1),
    (w, 'あの日以来、連絡がない。', '그날 이래 연락이 없다.', 2);

  -- 1194. ～にほかならない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～にほかならない', 'にほかならない', '바로 ~이다, 다름 아닌 ~이다', 'に+他(다를 타)+ならない. 강한 단정', '문법-형식판단', 1194, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功は努力の結果にほかならない。', '성공은 다름 아닌 노력의 결과다.', 1),
    (w, 'これは彼の責任にほかならない。', '이것은 다름 아닌 그의 책임이다.', 2);

  -- 1195. ～とのことだ(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とのことだ(2)', '~라는 것이다 <전달>', '전문 とのことだ 재활용', '문법-형식판단', 1195, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は中止とのことだ。', '회의는 중지된다는 것이다.', 1),
    (w, '明日来るとのことだった。', '내일 온다고 했다.', 2);

  -- 1196. ～べきだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～べきだ', '~해야 한다', '可(べし)의 종지형 변형. 당위·도리', '문법-형식판단', 1196, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束は守るべきだ。', '약속은 지켜야 한다.', 1),
    (w, '謝るべきだ。', '사과해야 한다.', 2);

  -- 1197. ～おかげだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～おかげだ', '~덕분이다', 'お陰(かげ)+だ. 긍정적 원인 단정', '문법-형식판단', 1197, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格できたのは先生のおかげだ。', '합격할 수 있던 것은 선생님 덕분이다.', 1),
    (w, '今があるのは家族のおかげだ。', '지금이 있는 건 가족 덕분이다.', 2);

  -- 1198. ～に至って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に至って', 'にいたって', '~에 이르러', '至(이를 지)る. 극단적 상황 도달', '문법-형식판단', 1198, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここに至って後悔しても遅い。', '여기에 이르러 후회해도 늦다.', 1),
    (w, '事件が起こるに至って対応した。', '사건이 일어남에 이르러 대응했다.', 2);

  -- 1199. ～にかかわらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にかかわらず', '~에 관계없이', '関(빗장 관)わる+ず. 조건 무관', '문법-형식판단', 1199, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '天候にかかわらず開催する。', '날씨에 관계없이 개최한다.', 1),
    (w, '結果にかかわらず努力は無駄ではない。', '결과에 관계없이 노력은 헛되지 않다.', 2);

  -- 1200. いつのまに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'いつのまに', 'いつのまに', '어느 틈에, 어느 사이에', '何(なに)+の+間(ま)+に. 무의식 중 변화', '문법-형식판단', 1200, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつのまに眠ってしまった。', '어느새 잠들어 버렸다.', 1),
    (w, 'いつのまにか春になっていた。', '어느새 봄이 되어 있었다.', 2);

  -- 1201. ～反面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～反面', 'はんめん', '~반면', '反(되돌릴 반)+面(낯 면). 대립적 두 측면', '문법-형식판단', 1201, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '便利な反面、危険もある。', '편리한 반면 위험도 있다.', 1),
    (w, '優しい反面、厳しい所もある。', '다정한 반면 엄한 면도 있다.', 2);

  -- 1202. ～でよければ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～でよければ', '~로 괜찮다면', 'で(수단/조건)+よければ. 정중한 제안', '문법-형식판단', 1202, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私でよければ手伝います。', '저로 괜찮다면 돕겠습니다.', 1),
    (w, 'これでよければお持ち帰りください。', '이것으로 괜찮으시면 가져가세요.', 2);

  -- 1203. ～としたら(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としたら(2)', '~라고 한다면', '가정 としたら 재활용', '문법-형식판단', 1203, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今買うとしたらどれがいい？', '지금 산다면 어느 게 좋을까?', 1),
    (w, '行くとしたら午後だ。', '간다고 한다면 오후다.', 2);

  -- 1204. ～ないよう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないよう', '~하지 않도록', 'ない+よう(に의 회화체). 부정적 결과 방지', '문법-형식판단', 1204, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転ばないよう注意する。', '넘어지지 않도록 조심한다.', 1),
    (w, '忘れないようメモする。', '잊지 않도록 메모한다.', 2);

  -- 1205. ～次第だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～次第だ', 'しだいだ', '~에 달렸다', '次第(차례)+だ. 결정 요인 강조', '문법-형식판단', 1205, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功は努力次第だ。', '성공은 노력에 달렸다.', 1),
    (w, '行くかどうかは天気次第だ。', '갈지 안 갈지는 날씨에 달렸다.', 2);

  -- 1206. ～ことがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことがある', '발생하는 경우가 있다', '事+がある. 가끔의 발생', '문법-형식판단', 1206, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たまに遅刻することがある。', '가끔 지각하는 경우가 있다.', 1),
    (w, '雨が降ることがある。', '비가 오는 경우가 있다.', 2);

  -- 1207. ～(さ)せてくれる(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せてくれる(2)', '~하게 해 주다', '허락 사역 させてくれる 재활용', '문법-형식판단', 1207, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少し見させてくれない？', '잠깐 보게 해 주지 않을래?', 1),
    (w, '考えさせてください。', '생각하게 해 주세요.', 2);

  -- 1208. まいる(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '参る(2)', 'まいる', '오다, 가다 <겸양>', '겸양 行く/来る 재활용', '문법-형식판단', 1208, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会場までまいります。', '회장까지 가겠습니다.', 1),
    (w, 'これから参ります。', '지금부터 가겠습니다.', 2);

  -- 1209. ～てもらう(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てもらう(2)', '~해 받다', '수혜 표현 てもらう 재활용', '문법-형식판단', 1209, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者に診てもらった。', '의사에게 진찰받았다.', 1),
    (w, '先輩に教えてもらう。', '선배에게 가르침을 받는다.', 2);

  -- 1210. ～なんか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なんか', '~같은 (것)', 'などか의 회화체. 예시·경시', '문법-형식판단', 1210, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私なんか無理だ。', '나 같은 사람은 무리다.', 1),
    (w, 'コーヒーなんかどう？', '커피 같은 거 어때?', 2);

  -- 1211. どれほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どれほど', '얼마나', 'どれ+ほど. 정도 의문', '문법-형식판단', 1211, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どれほど嬉しかったか。', '얼마나 기뻤는지.', 1),
    (w, 'どれほど時間がかかるか分からない。', '얼마나 시간이 걸릴지 모른다.', 2);

  -- 1212. ～といった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といった', '~와 같은 <예시·열거>', 'と+いう의 활용. 예시 열거', '문법-형식판단', 1212, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京や大阪といった大都市。', '도쿄나 오사카와 같은 대도시.', 1),
    (w, 'リンゴやバナナといった果物。', '사과나 바나나 같은 과일.', 2);

  -- 1213. ～きり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きり', '~한 채 (그것만/그 이후로)', '切(끊을 절)り. 한정·계속', '문법-형식판단', 1213, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は出かけたきり戻らない。', '그는 나간 채 돌아오지 않는다.', 1),
    (w, '二人きりで話す。', '둘이서만 이야기한다.', 2);

  -- 1214. ～てみようか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てみようか', '~해 볼까?', 'てみる+よう+か. 자기 제안/시도 의문', '문법-형식판단', 1214, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '挑戦してみようか。', '도전해 볼까?', 1),
    (w, '電話してみようか。', '전화해 볼까?', 2);

  -- 1215. ～のであれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のであれば', '~한 것이라면', 'のだ+あれば. 정중한 조건 가정', '문법-형식판단', 1215, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当に必要なのであれば買おう。', '정말 필요한 것이라면 사자.', 1),
    (w, '困っているのであれば助けます。', '곤란해하시는 것이라면 도와드리겠습니다.', 2);

  -- 1216. ～ずつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ずつ', '~씩', '균등 배분 조사. 수량+ずつ', '문법-형식판단', 1216, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人ずつ受け取る。', '한 명씩 받는다.', 1),
    (w, '少しずつ進める。', '조금씩 진행한다.', 2);

  -- 1217. ～までになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～までになる', '~할 정도가 되다', 'まで+になる. 정도·수준 달성', '문법-형식판단', 1217, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人で歩けるまでになった。', '혼자 걸을 수 있을 정도가 되었다.', 1),
    (w, '専門家と話せるまでになった。', '전문가와 이야기할 수 있을 정도가 되었다.', 2);

  -- 1218. 欠かせない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '欠かせない', 'かかせない', '빠뜨릴 수 없다, 필요하다', '欠(이지러질 결)く+せ+ない. 필수적', '문법-형식판단', 1218, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は欠かせない存在だ。', '그는 빠뜨릴 수 없는 존재다.', 1),
    (w, '健康に運動は欠かせない。', '건강에 운동은 필수다.', 2);

  -- 1219. ～ばよかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばよかった', '~했으면 좋았을 텐데', 'ば+よかった. 사후 후회', '문법-형식판단', 1219, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと早く来ればよかった。', '더 일찍 왔으면 좋았을 텐데.', 1),
    (w, '言わなければよかった。', '말하지 않았으면 좋았을 텐데.', 2);

  -- 1220. ～ということになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ということになる', '~라는 것이 된다', 'という+ことになる. 결론·논리적 귀결', '문법-형식판단', 1220, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それでは中止ということになる。', '그러면 중지라는 것이 된다.', 1),
    (w, '結局誰も来ないということになった。', '결국 아무도 안 온다는 것이 되었다.', 2);

  -- 1221. 伺う(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '伺う(2)', 'うかがう', '듣다, 여쭈다 <겸양>', '겸양어 伺う 재활용', '문법-형식판단', 1221, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お名前を伺ってもよろしいですか。', '성함을 여쭤도 될까요?', 1),
    (w, '一度伺いたいです。', '한 번 찾아뵙고 싶습니다.', 2);

  -- 1222. ～さえ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～さえ', '~조차, ~마저', '강조 부조사. 극단 예시', '문법-형식판단', 1222, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供さえできる。', '아이조차 할 수 있다.', 1),
    (w, '私さえ知らない。', '나조차 모른다.', 2);

  -- 1223. まず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'まず', '거의, 대체로 <부정>', '先(먼저 선)ず. 부정·추측과 호응', '문법-형식판단', 1223, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まず無理だろう。', '거의 무리일 것이다.', 1),
    (w, 'まず大丈夫だ。', '대체로 괜찮을 거다.', 2);

  -- 1224. ～に対して(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に対して(2)', 'にたいして', '~에 대해서', '대상/대비 に対して 재활용', '문법-형식판단', 1224, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の意見に対して反論した。', '그의 의견에 대해 반론했다.', 1),
    (w, '一人に対して一冊ずつ配る。', '한 사람당 한 권씩 나눠준다.', 2);

  -- 1225. ～てからでないと(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てからでないと(2)', '~한 후가 아니면, ~하지 않고서는', '순서 조건 てからでないと 재활용', '문법-형식판단', 1225, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約してからでないと入れない。', '예약한 후가 아니면 못 들어간다.', 1),
    (w, '確認してからでないと送れない。', '확인하지 않고서는 보낼 수 없다.', 2);

  -- 1226. ～たび
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たび', '~할 때마다', '度(たび). 단독 활용 たび 반복', '문법-형식판단', 1226, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会うたび元気をもらう。', '만날 때마다 힘을 얻는다.', 1),
    (w, '失敗するたび成長する。', '실패할 때마다 성장한다.', 2);

  -- 1227. ～たがらないのなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たがらないのなら', '~하고 싶어하지 않는 것이라면', 'たがる+ない+のなら. 의지 부재 가정', '문법-형식판단', 1227, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行きたがらないのなら無理に誘わない。', '가고 싶어하지 않는다면 무리하게 권하지 않는다.', 1),
    (w, '話したがらないのならそっとしておく。', '말하고 싶어하지 않는다면 그대로 둔다.', 2);

  -- 1228. ～というような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というような', '~라고 하는 듯한', 'という+ような. 인용+양태', '문법-형식판단', 1228, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不満があるというような顔をした。', '불만이 있다는 듯한 얼굴을 했다.', 1),
    (w, '面倒だというような態度。', '귀찮다는 듯한 태도.', 2);

  -- 1229. ～わけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけではない', '반드시 ~한 것은 아니다', '訳+ではない. 부분 부정', '문법-형식판단', 1229, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嫌いなわけではない。', '싫어하는 것은 아니다.', 1),
    (w, 'いつも遅刻するわけではない。', '항상 지각하는 것은 아니다.', 2);

  -- 1230. ～がたい(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がたい(2)', '~하기 어렵다', '심리·도덕적 がたい 재활용', '문법-형식판단', 1230, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '受け入れがたい結果だ。', '받아들이기 어려운 결과다.', 1),
    (w, '理解しがたい行動。', '이해하기 어려운 행동.', 2);

  -- 1231. ～ところだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ところだ', '막 ~하는 참이다', '所(ところ)+だ. 동작 시점', '문법-형식판단', 1231, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今出かけるところだ。', '지금 막 나가는 참이다.', 1),
    (w, 'ちょうど食べ終わったところだ。', '마침 다 먹은 참이다.', 2);

  -- 1232. ～ことがある(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことがある(2)', '~하는 경우가 있다', '가끔 발생 ことがある 재활용', '문법-형식판단', 1232, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時々遅れることがある。', '가끔 늦는 경우가 있다.', 1),
    (w, '寝坊することがある。', '늦잠 자는 경우가 있다.', 2);

  -- 1233. ～でしかない(2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～でしかない(2)', '~밖에 되지 않다, ~에 불과하다', '한정·과소평가 でしかない 재활용', '문법-형식판단', 1233, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は子供でしかない。', '그는 어린아이에 불과하다.', 1),
    (w, '希望でしかない。', '희망에 불과하다.', 2);

  -- ────────── 문법 문장 완성 (141개, 1234~1374) ──────────

  -- 1234. ～までで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～までで', '~까지(로)', 'まで(까지)+で. 종결 시점·범위', '문법-문장완성', 1234, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '受付は5時までで終了します。', '접수는 5시까지로 종료합니다.', 1),
    (w, '本日までで20名集まった。', '오늘까지로 20명이 모였다.', 2);

  -- 1235. ～といっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といっても', '~라고 해도', 'と+いう+ても. 양보·정정', '문법-문장완성', 1235, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理といってもインスタントだ。', '요리라고 해도 인스턴트다.', 1),
    (w, '休みといっても忙しい。', '쉰다고 해도 바쁘다.', 2);

  -- 1236. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によって(차이)', '~에 따라서', 'に+依る+て. 차이/경우 분류', '문법-문장완성', 1236, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '国によって文化が違う。', '나라에 따라 문화가 다르다.', 1),
    (w, '人によって意見が異なる。', '사람에 따라 의견이 다르다.', 2);

  -- 1237. ～ばかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばかり(2)', '~뿐, ~만', 'ばかり 재활용', '문법-문장완성', 1237, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '甘いものばかり食べる。', '단것만 먹는다.', 1),
    (w, '怒ってばかりいる。', '화만 내고 있다.', 2);

  -- 1238. ～というような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というような(2)', '~하는 것과 같은', 'という+ような 재활용', '문법-문장완성', 1238, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '怒っているというような表情。', '화나 있는 것 같은 표정.', 1),
    (w, '何かが起きるというような予感。', '뭔가 일어날 것 같은 예감.', 2);

  -- 1239. ～からすると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～からすると', '~로 보아', 'から+する+と. 근거에 의한 판단', '문법-문장완성', 1239, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の様子からすると本気だ。', '그의 모습으로 보아 진심이다.', 1),
    (w, '値段からすると高すぎる。', '가격으로 보아 너무 비싸다.', 2);

  -- 1240. ～じゃないかと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～じゃないかと思う', '~이 아닐까라고 생각한다', 'じゃないか+と+思う. 완곡 추측', '문법-문장완성', 1240, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るんじゃないかと思う。', '비가 올 것 아닐까 생각한다.', 1),
    (w, '彼は来ないんじゃないかと思う。', '그는 오지 않을 것 아닐까 생각한다.', 2);

  -- 1241. ～ないうちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないうちに(2)', '~하기 전에', 'ない+うちに 재활용', '문법-문장완성', 1241, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '暗くならないうちに帰ろう。', '어두워지기 전에 돌아가자.', 1),
    (w, '熱くならないうちに飲もう。', '뜨거워지기 전에 마시자.', 2);

  -- 1242. ～ものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ものだ(법)', '~한 법이다', 'もの+だ. 도리·당위·일반 진리', '문법-문장완성', 1242, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人は失敗するものだ。', '사람은 실패하는 법이다.', 1),
    (w, '子供は元気なものだ。', '아이는 건강한 법이다.', 2);

  -- 1243. ご存知だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご存知だ', 'ごぞんじだ', '알고 계시다 <존경>', 'ご+存(있을 존)知. 知る의 존경어', '문법-문장완성', 1243, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この方をご存知ですか。', '이 분을 알고 계십니까?', 1),
    (w, '先生はご存知のはずです。', '선생님은 알고 계실 것입니다.', 2);

  -- 1244. ～からこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～からこそ(2)', '~이기에', '강조된 이유 からこそ 재활용', '문법-문장완성', 1244, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君だからこそ言える。', '너이기에 말할 수 있다.', 1),
    (w, '今だからこそ大事だ。', '지금이기에 중요하다.', 2);

  -- 1245. ～にしたら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にしたら', '~로서는, ~입장에서는', 'に+する+たら. 화자/주체의 관점', '문법-문장완성', 1245, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親にしたら心配だろう。', '부모로서는 걱정될 것이다.', 1),
    (w, '子供にしたら遊びだ。', '아이로서는 놀이다.', 2);

  -- 1246. ～なんていう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なんていう', '~라고 하는, ~따위라고 하는', 'なんて+いう. 의외·경시 인용', '문법-문장완성', 1246, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けないなんていうのか。', '못 간다고 하는 거야?', 1),
    (w, '嫌いだなんていう理由はない。', '싫다는 따위의 이유는 없다.', 2);

  -- 1247. ～てくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てくれる(2)', '(나에게) ~해 주다', '수혜 てくれる 재활용', '문법-문장완성', 1247, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が連絡してくれた。', '그가 연락해 주었다.', 1),
    (w, '友達が貸してくれた。', '친구가 빌려주었다.', 2);

  -- 1248. ～てやる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てやる', '(아랫사람/동물에게) ~해 주다', '동사 て형+やる. 윗→아래의 베풂', '문법-문장완성', 1248, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟に本を読んでやった。', '동생에게 책을 읽어 주었다.', 1),
    (w, '犬に餌をやってやる。', '강아지에게 먹이를 주다.', 2);

  -- 1249. ～て初めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～て初めて', 'てはじめて', '~해서야 비로소', '初(처음 초)めて. 「~한 후에 비로소」', '문법-문장완성', 1249, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失って初めて大切さに気づく。', '잃고 나서야 비로소 소중함을 깨닫는다.', 1),
    (w, '行ってみて初めて分かった。', '가 봐서야 비로소 알았다.', 2);

  -- 1250. ～かのようだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かのようだ', '~인 듯하다, 마치 ~한 것 같다', 'か+の+ようだ. 마치 그러한 듯한 비유', '문법-문장완성', 1250, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢を見ているかのようだ。', '꿈을 꾸고 있는 듯하다.', 1),
    (w, '何も知らないかのように振る舞う。', '아무것도 모르는 듯이 행동한다.', 2);

  -- 1251. ～さえ～ば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～さえ～ば(2)', '~만 ~하면', '최소조건 さえ～ば 재활용', '문법-문장완성', 1251, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間さえあれば行く。', '시간만 있으면 간다.', 1),
    (w, '元気さえあれば何でもできる。', '건강만 있으면 뭐든 할 수 있다.', 2);

  -- 1252. ～としても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としても(2)', '~라고 할지라도', '가정 양보 としても 재활용', '문법-문장완성', 1252, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だとしても出かける。', '비라고 해도 나간다.', 1),
    (w, '失敗したとしても挑戦する。', '실패한다 해도 도전한다.', 2);

  -- 1253. ～だって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だって(2)', '~라고 해도, ~도', 'でも 회화체 だって 재활용', '문법-문장완성', 1253, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供だってできる。', '아이도 할 수 있다.', 1),
    (w, 'いつだって構わない。', '언제라도 상관없다.', 2);

  -- 1254. ～おかげだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～おかげだ(2)', '~덕분이다', '긍정 원인 おかげだ 재활용', '문법-문장완성', 1254, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無事に着いたのは彼のおかげだ。', '무사히 도착한 것은 그 덕분이다.', 1),
    (w, '成功は家族のおかげだ。', '성공은 가족 덕분이다.', 2);

  -- 1255. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほど(3)', '~정도', '정도 ほど 재활용', '문법-문장완성', 1255, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くほどではない。', '울 정도는 아니다.', 1),
    (w, 'ご飯が食べられないほど忙しい。', '밥도 못 먹을 정도로 바쁘다.', 2);

  -- 1256. ～ことになっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことになっている', '~하기로 되어 있다', '事+になっている. 규칙/예정', '문법-문장완성', 1256, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は9時に始まることになっている。', '회의는 9시에 시작하기로 되어 있다.', 1),
    (w, '校内は禁煙ということになっている。', '교내는 금연으로 되어 있다.', 2);

  -- 1257. ～だけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけ(2)', '~한 만큼', '한도 だけ 재활용', '문법-문장완성', 1257, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できるだけのことをする。', '할 수 있는 만큼의 것을 한다.', 1),
    (w, '欲しいだけ取ってよい。', '원하는 만큼 가져도 된다.', 2);

  -- 1258. ～ていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ていただく', '~해 받다 / ~해 주시다 <겸양>', '동사 て형+いただく. 정중 수혜', '문법-문장완성', 1258, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に教えていただいた。', '선생님께 가르침을 받았다.', 1),
    (w, '少しお待ちいただけますか。', '잠시 기다려 주시겠습니까?', 2);

  -- 1259. ～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～も(수량강조)', '~이나 <수량의 강조>', '수량+も. 「~씩이나」 강조', '문법-문장완성', 1259, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '1時間も待った。', '1시간이나 기다렸다.', 1),
    (w, '10人も集まった。', '10명이나 모였다.', 2);

  -- 1260. ～から
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～から(약속)', '~할 테니까', '의지/약속 표명 から', '문법-문장완성', 1260, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐ行くから待ってて。', '곧 갈 테니까 기다려.', 1),
    (w, '今度はちゃんとやるから。', '이번엔 제대로 할 테니까.', 2);

  -- 1261. いずれにしても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'いずれにしても', '어느 쪽이든', '何れ+にしても. 결론 종합', '문법-문장완성', 1261, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いずれにしても結果は同じだ。', '어느 쪽이든 결과는 같다.', 1),
    (w, 'いずれにしてもやるしかない。', '어느 쪽이든 할 수밖에 없다.', 2);

  -- 1262. ～とあるが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とあるが', '~라고 적혀 있는데', 'と+ある+が. 문서/문장 인용+역접', '문법-문장완성', 1262, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '禁止とあるが、なぜか守られていない。', '금지라고 적혀 있는데 어쩐 일인지 지켜지지 않는다.', 1),
    (w, '無料とあるが本当だろうか。', '무료라고 적혀 있는데 정말일까.', 2);

  -- 1263. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～はずだ(2)', '틀림없이 ~일 것이다', '근거 추측 はずだ 재활용', '문법-문장완성', 1263, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間通りに来るはずだ。', '시간대로 올 것이다.', 1),
    (w, 'もう着いているはずだ。', '이미 도착해 있을 것이다.', 2);

  -- 1264. ～といえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といえば', '~로 말하자면', 'と+いえば. 화제 제시', '문법-문장완성', 1264, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本の料理といえば寿司だ。', '일본 요리로 말하자면 초밥이다.', 1),
    (w, '夏といえば祭りだ。', '여름으로 말하자면 축제다.', 2);

  -- 1265. ～きり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きり(2)', '~한 채, ~한 것을 끝으로', '한정·계속 きり 재활용', '문법-문장완성', 1265, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昨日会ったきり、連絡がない。', '어제 만난 것을 끝으로 연락이 없다.', 1),
    (w, '寝たきりの生活。', '누워만 있는 생활.', 2);

  -- 1266. ～はもとより
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～はもとより', 'はもとより', '~은 물론', '元(근본 원)+より. 「말할 것도 없이」', '문법-문장완성', 1266, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '英語はもとより中国語も話せる。', '영어는 물론 중국어도 할 수 있다.', 1),
    (w, '休日はもとより平日も忙しい。', '휴일은 물론 평일도 바쁘다.', 2);

  -- 1267. ～上で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～上で(2)', 'うえで', '~하는 측면에서, ~하는 데 있어서', '上で 재활용. 기준·관점', '문법-문장완성', 1267, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を考える上で食事は重要だ。', '건강을 생각하는 데 있어서 식사는 중요하다.', 1),
    (w, '学ぶ上で参考になる。', '배우는 측면에서 참고가 된다.', 2);

  -- 1268. ～ぐらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ぐらい', '~정도', '位(자리 위). 정도 표현', '문법-문장완성', 1268, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これぐらいの距離なら歩ける。', '이 정도 거리라면 걸을 수 있다.', 1),
    (w, '1万円ぐらいする。', '1만 엔 정도 한다.', 2);

  -- 1269. ～をはじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～をはじめ', '~을 비롯하여', '始(처음 시)め. 대표 예시로 시작', '문법-문장완성', 1269, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京をはじめ全国で開催する。', '도쿄를 비롯하여 전국에서 개최한다.', 1),
    (w, '社長をはじめ全員参加した。', '사장을 비롯하여 전원 참가했다.', 2);

  -- 1270. ～に限る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に限る', 'にかぎる', '~이 최고다, ~에 한한다', '限(한할 한)る. 최선/한정', '문법-문장완성', 1270, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏はかき氷に限る。', '여름엔 빙수가 최고다.', 1),
    (w, '会員に限る。', '회원에 한한다.', 2);

  -- 1271. ～すら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すら(3)', '~조차', '극단 강조 すら 재활용', '문법-문장완성', 1271, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寝る時間すらない。', '잘 시간조차 없다.', 1),
    (w, '名前すら知らない。', '이름조차 모른다.', 2);

  -- 1272. ～ばいいのに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばいいのに', '~하면 좋을 텐데', 'ば+いい+のに. 권유·아쉬움', '문법-문장완성', 1272, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く謝ればいいのに。', '빨리 사과하면 좋을 텐데.', 1),
    (w, '休めばいいのに無理している。', '쉬면 좋을 텐데 무리하고 있다.', 2);

  -- 1273. どんなに～ても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どんなに～ても', '아무리 ~해도', 'どんなに(아무리)+ても(양보). 강한 양보', '문법-문장완성', 1273, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんなに頑張っても無理だ。', '아무리 노력해도 무리다.', 1),
    (w, 'どんなに高くても買う。', '아무리 비싸도 산다.', 2);

  -- 1274. ～きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～きる(4)', '완전히 ~하다', '완료 きる 재활용', '문법-문장완성', 1274, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '飲みきった。', '다 마셨다.', 1),
    (w, 'やりきった。', '끝까지 해냈다.', 2);

  -- 1275. ～とは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とは', '~라니, ~란', 'と(인용)+は(주제). 놀라움/정의', '문법-문장완성', 1275, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんな事になるとは。', '이런 일이 되다니.', 1),
    (w, '愛とは何か。', '사랑이란 무엇인가.', 2);

  -- 1276. ～ことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことはない(3)', '~할 필요는 없다', '필요성 부정 ことはない 재활용', '문법-문장완성', 1276, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '焦ることはない。', '서두를 필요는 없다.', 1),
    (w, 'そんなに気にすることはない。', '그렇게 신경 쓸 필요는 없다.', 2);

  -- 1277. ～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ(전문3)', '~라고 한다', '전문 そうだ 재활용', '문법-문장완성', 1277, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来週引っ越すそうだ。', '그는 다음 주 이사한다고 한다.', 1),
    (w, '昨日大雪だったそうだ。', '어제 폭설이었다고 한다.', 2);

  -- 1278. ～なんて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なんて', '~라니, ~따위', 'などと의 회화체. 의외·경시', '문법-문장완성', 1278, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が泣くなんて信じられない。', '그가 울다니 믿을 수 없다.', 1),
    (w, '私なんて関係ない。', '나 따위는 상관없다.', 2);

  -- 1279. ～につれて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～につれて(2)', '~함에 따라서', '비례 변화 につれて 재활용', '문법-문장완성', 1279, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間が経つにつれて慣れる。', '시간이 흐름에 따라 익숙해진다.', 1),
    (w, '練習するにつれて上達する。', '연습할수록 잘하게 된다.', 2);

  -- 1280. つい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'つい', '그만, 무심코', '무의식적 행위/감정 부사', '문법-문장완성', 1280, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つい食べ過ぎてしまった。', '그만 과식해 버렸다.', 1),
    (w, 'つい言ってしまった。', '무심코 말해 버렸다.', 2);

  -- 1281. どうしても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうしても(2)', '무슨 일이 있어도, 꼭', '강한 의지 どうしても 재활용', '문법-문장완성', 1281, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしても勝ちたい。', '꼭 이기고 싶다.', 1),
    (w, 'どうしても無理だ。', '아무리 해도 무리다.', 2);

  -- 1282. ～をこめて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～をこめて', 'をこめて', '~을 담아', '込(담을 입)める+て. 마음/감정을 담음', '문법-문장완성', 1282, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛をこめて作った料理。', '사랑을 담아 만든 요리.', 1),
    (w, '感謝をこめて贈る。', '감사를 담아 선물한다.', 2);

  -- 1283. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～として', '~로서 (자격·역할)', 'と+して. 신분·자격·범주', '문법-문장완성', 1283, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者として働く。', '의사로서 일한다.', 1),
    (w, '友人として助ける。', '친구로서 돕는다.', 2);

  -- 1284. ～どおりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～どおりに', '~대로', '通(통할 통)り+に. 「~과 같이」', '문법-문장완성', 1284, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '指示どおりに動く。', '지시대로 움직인다.', 1),
    (w, '予定どおりに進む。', '예정대로 진행된다.', 2);

  -- 1285. ～のと～ないのでは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のと～ないのでは', '~하는 것과 하지 않는 것과는', 'の+と+ない+のでは. 대조 비교', '문법-문장완성', 1285, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やるのとやらないのでは大違いだ。', '하는 것과 안 하는 것은 큰 차이다.', 1),
    (w, '知るのと知らないのでは結果が違う。', '아는 것과 모르는 것은 결과가 다르다.', 2);

  -- 1286. ～ように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ように(6)', '~하도록', '목적·인용 ように 재활용', '문법-문장완성', 1286, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞こえるように大きな声で話す。', '들리도록 큰 소리로 말한다.', 1),
    (w, '間に合うように早めに出る。', '늦지 않도록 일찍 나간다.', 2);

  -- 1287. ～うえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～うえに', '~인 데다가', '上(うえ)+に. 첨가·누적', '문법-문장완성', 1287, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は優しいうえに頭もいい。', '그는 다정한 데다가 머리도 좋다.', 1),
    (w, '雨のうえに風も強い。', '비도 오는 데다가 바람도 세다.', 2);

  -- 1288. ～せいか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～せいか(2)', '~탓인지', '부정 원인 추측 せいか 재활용', '문법-문장완성', 1288, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '緊張したせいかミスをした。', '긴장한 탓인지 실수했다.', 1),
    (w, '雨のせいか客が少ない。', '비 탓인지 손님이 적다.', 2);

  -- 1289. ～といった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といった(2)', '~와 같은 <예시>', '예시 열거 といった 재활용', '문법-문장완성', 1289, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京や大阪といった大都市。', '도쿄나 오사카와 같은 대도시.', 1),
    (w, '英語や中国語といった言語。', '영어나 중국어 같은 언어.', 2);

  -- 1290. ～と思われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～と思われる', '~라고 생각되다', '思う의 수동. 객관·완곡 추측', '문법-문장완성', 1290, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が犯人だと思われる。', '그가 범인이라고 생각된다.', 1),
    (w, '正しいと思われる。', '맞다고 생각된다.', 2);

  -- 1291. ～(さ)せられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せられる(2)', '본의 아니게 ~하게 되다', '사역수동 させられる 재활용', '문법-문장완성', 1291, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議に出席させられた。', '회의에 출석하게 되었다.', 1),
    (w, 'お酒を飲まされた。', '술을 마시게 되었다.', 2);

  -- 1292. まず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'まず(2)', '거의, 대체로 <부정>', '부사 まず 재활용', '문법-문장완성', 1292, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まず可能性はない。', '거의 가능성은 없다.', 1),
    (w, 'まず無理だろう。', '대체로 무리일 거다.', 2);

  -- 1293. ～ついでに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ついでに(2)', '~하는 김에', '겸사 ついでに 재활용', '문법-문장완성', 1293, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出張のついでに観光した。', '출장하는 김에 관광했다.', 1),
    (w, '散歩のついでに買い物。', '산책하는 김에 쇼핑.', 2);

  -- 1294. ～だけでなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけでなく', '~뿐 아니라', 'だけ+で+なく. 첨가/확장', '문법-문장완성', 1294, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は優しいだけでなく賢い。', '그는 다정할 뿐 아니라 똑똑하다.', 1),
    (w, '安いだけでなく品質もよい。', '쌀 뿐 아니라 품질도 좋다.', 2);

  -- 1295. ～ないで済む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないで済む', '~하지 않아도 된다', 'ないで+済(건널 제)む. 면제·불필요', '문법-문장완성', 1295, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が止んで傘を差さないで済んだ。', '비가 그쳐서 우산을 안 써도 됐다.', 1),
    (w, '会議に出なくて済んだ。', '회의에 안 나와도 됐다.', 2);

  -- 1296. ～て以来
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～て以来(2)', 'ていらい', '~한 이래', '시점 이후 て以来 재활용', '문법-문장완성', 1296, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大学を卒業して以来、会っていない。', '대학을 졸업한 이래 만나지 않았다.', 1),
    (w, '結婚して以来、料理をしている。', '결혼한 이래 요리를 하고 있다.', 2);

  -- 1297. 二度と～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '二度と～ない(2)', 'にどと', '두 번 다시 ~않는다', '강한 결심 二度と 재활용', '문법-문장완성', 1297, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二度と忘れない。', '두 번 다시 잊지 않는다.', 1),
    (w, '二度とその話はしない。', '두 번 다시 그 얘기는 안 한다.', 2);

  -- 1298. ～ながら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ながら', '~이지만 <역접>, ~하면서', '同時/逆接 ながら의 양용', '문법-문장완성', 1298, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽を聞きながら勉強する。', '음악을 들으며 공부한다.', 1),
    (w, '残念ながら参加できない。', '아쉽지만 참가할 수 없다.', 2);

  -- 1299. 今にも～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '今にも～そうだ', 'いまにも', '당장에라도 ~할 것 같다', '今+にも+そうだ. 임박', '문법-문장완성', 1299, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今にも雨が降りそうだ。', '당장에라도 비가 올 것 같다.', 1),
    (w, '今にも泣きそうな顔。', '금방이라도 울 것 같은 얼굴.', 2);

  -- 1300. ～かどうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かどうか(2)', '~인지 어떤지', '양자택일 かどうか 재활용', '문법-문장완성', 1300, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けるかどうかわからない。', '갈 수 있을지 모르겠다.', 1),
    (w, '正しいかどうか判断する。', '맞는지 어떤지 판단한다.', 2);

  -- 1301. ～であっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～であっても', '~라도, ~일지라도', 'で+ある+ても. 격식 양보', '문법-문장완성', 1301, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供であっても責任がある。', '아이라도 책임이 있다.', 1),
    (w, '雨であっても出かける。', '비라도 나간다.', 2);

  -- 1302. ～にとって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にとって', '~에게 있어서', 'に+取る+て. 화자·주체의 관점', '문법-문장완성', 1302, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私にとって大切な人。', '나에게 있어 소중한 사람.', 1),
    (w, '学生にとって試験は重要だ。', '학생에게 시험은 중요하다.', 2);

  -- 1303. ようやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'ようやく', '마침내, 가까스로', '漸(점차 점)く. 시간/노력 끝에 도달', '문법-문장완성', 1303, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ようやく完成した。', '마침내 완성했다.', 1),
    (w, 'ようやく晴れた。', '마침내 맑게 갰다.', 2);

  -- 1304. なかなか～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'なかなか～ない', '좀처럼 ~하지 않다', '中々+ない. 어려운 진척', '문법-문장완성', 1304, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なかなか上達しない。', '좀처럼 늘지 않는다.', 1),
    (w, 'バスがなかなか来ない。', '버스가 좀처럼 안 온다.', 2);

  -- 1305. ～だけの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけの', '~뿐인', 'だけ+の. 한정 수식', '문법-문장완성', 1305, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見ているだけの存在。', '보고만 있는 존재.', 1),
    (w, '言うだけのことを言う。', '말할 만큼 말한다.', 2);

  -- 1306. ～すえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すえに(2)', '~한 끝에', '末に 재활용', '문법-문장완성', 1306, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '熟考のすえに決定した。', '숙고 끝에 결정했다.', 1),
    (w, '長い議論のすえに合意した。', '오랜 논의 끝에 합의했다.', 2);

  -- 1307. 決して～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '決して～ない', 'けっして', '결코 ~않는다', '決(터질 결)して+ない. 강한 부정', '문법-문장완성', 1307, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決して忘れない。', '결코 잊지 않는다.', 1),
    (w, '決して許さない。', '결코 용서하지 않는다.', 2);

  -- 1308. ～わけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけではない(2)', '~인 것은 아니다', '부분 부정 わけではない 재활용', '문법-문장완성', 1308, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反対するわけではない。', '반대하는 것은 아니다.', 1),
    (w, '行きたくないわけではない。', '가고 싶지 않은 것은 아니다.', 2);

  -- 1309. ～たびに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たびに(3)', '~할 때마다', '반복 たびに 재활용', '문법-문장완성', 1309, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くたびに違う発見がある。', '갈 때마다 다른 발견이 있다.', 1),
    (w, '会うたびに楽しくなる。', '만날 때마다 즐거워진다.', 2);

  -- 1310. ～に欠かせない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に欠かせない', 'にかかせない', '~에 빠뜨릴 수 없다', '欠かせない 응용. 필수 요소', '문법-문장완성', 1310, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生活に欠かせないもの。', '생활에 빠뜨릴 수 없는 것.', 1),
    (w, '健康に欠かせない運動。', '건강에 필수적인 운동.', 2);

  -- 1311. ～なら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なら(3)', '~이라면', '화제 なら 재활용', '문법-문장완성', 1311, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノなら弾ける。', '피아노라면 칠 수 있다.', 1),
    (w, '本当なら申し訳ない。', '사실이라면 미안하다.', 2);

  -- 1312. ～ないといけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないといけない(2)', '~하지 않으면 안된다', '의무 ないといけない 재활용', '문법-문장완성', 1312, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宿題を出さないといけない。', '숙제를 내야 한다.', 1),
    (w, '練習しないといけない。', '연습해야 한다.', 2);

  -- 1313. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほど(4)', '~정도', '정도 ほど 재활용', '문법-문장완성', 1313, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人が押し寄せるほど大盛況。', '인파가 몰릴 정도로 대성황.', 1),
    (w, '足が痛いほど歩いた。', '발이 아플 정도로 걸었다.', 2);

  -- 1314. 次第に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '次第に', 'しだいに', '점차', '次第+に. 시간 흐름에 따른 변화', '문법-문장완성', 1314, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '次第に明るくなる。', '점차 밝아진다.', 1),
    (w, '次第に慣れていく。', '점차 익숙해진다.', 2);

  -- 1315. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～として(2)', '~로서 (자격)', '자격 として 재활용', '문법-문장완성', 1315, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リーダーとして責任を取る。', '리더로서 책임을 진다.', 1),
    (w, '記念として残す。', '기념으로 남긴다.', 2);

  -- 1316. ～につれて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～につれて(3)', '~함에 따라서', 'につれて 재활용', '문법-문장완성', 1316, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春が近づくにつれて暖かくなる。', '봄이 가까워질수록 따뜻해진다.', 1),
    (w, '人口が増えるにつれて問題も増える。', '인구가 늘수록 문제도 늘어난다.', 2);

  -- 1317. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によって(원인)', '~에 의해서', '원인 によって 재활용', '문법-문장완성', 1317, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故によって遅刻した。', '사고로 인해 지각했다.', 1),
    (w, '研究によって発見された。', '연구에 의해 발견되었다.', 2);

  -- 1318. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことから(2)', '~로 인해', 'ことから 재활용', '문법-문장완성', 1318, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言葉が似ていることから誤解された。', '말이 비슷해서 오해받았다.', 1),
    (w, '形が花に似ていることから名づけられた。', '모양이 꽃을 닮아 이름이 붙었다.', 2);

  -- 1319. ～うちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～うちに(3)', '~하는 사이에', 'うちに 재활용', '문법-문장완성', 1319, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強しているうちに眠った。', '공부하는 사이에 잠들었다.', 1),
    (w, '若いうちに旅行しよう。', '젊을 때 여행하자.', 2);

  -- 1320. ～次第で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～次第で', 'しだいで', '~에 따라서는', '次第+で. 조건/요인 의존', '문법-문장완성', 1320, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果は努力次第で変わる。', '결과는 노력에 따라 변한다.', 1),
    (w, '天気次第で予定が変わる。', '날씨에 따라 일정이 바뀐다.', 2);

  -- 1321. もう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'もう', '벌써, 이미', '시간/상태 부사. 완료/임박', '문법-문장완성', 1321, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう終わった。', '벌써 끝났다.', 1),
    (w, 'もう少しで着く。', '곧 도착한다.', 2);

  -- 1322. ～に限らず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に限らず', 'にかぎらず', '~뿐 아니라', '限る+ず. 한정 부정', '문법-문장완성', 1322, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若者に限らず大人にも人気だ。', '젊은이뿐 아니라 어른에게도 인기다.', 1),
    (w, '夏に限らず一年中食べる。', '여름뿐 아니라 일년 내내 먹는다.', 2);

  -- 1323. ～は別にして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～は別にして', 'はべつにして', '~는 별개로', '別(다를 별)+にして. 「~을 차치하고」', '문법-문장완성', 1323, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '値段は別にして品質はいい。', '가격은 별개로 품질은 좋다.', 1),
    (w, '結果は別にして努力は認める。', '결과는 별개로 노력은 인정한다.', 2);

  -- 1324. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～はずだ(3)', '틀림없이 ~일 것이다', 'はずだ 재활용', '문법-문장완성', 1324, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう届いているはずだ。', '벌써 도착해 있을 것이다.', 1),
    (w, '本当のはずだ。', '사실일 것이다.', 2);

  -- 1325. ～てからでないと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てからでないと(3)', '~한 후가 아니면', 'てからでないと 재활용', '문법-문장완성', 1325, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会員登録してからでないと利用できない。', '회원 등록한 후가 아니면 이용할 수 없다.', 1),
    (w, '読んでからでないと感想は言えない。', '읽지 않고서는 감상을 말할 수 없다.', 2);

  -- 1326. ～つつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～つつ', '~하면서', '문어체 동시 동작', '문법-문장완성', 1326, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えつつ歩く。', '생각하면서 걷는다.', 1),
    (w, '反省しつつ続ける。', '반성하면서 계속한다.', 2);

  -- 1327. ～ばいい/～たらいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ばいい/～たらいい', '~하면 된다', 'ば/たら + いい. 충분조건/조언', '문법-문장완성', 1327, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうすればいい。', '이렇게 하면 된다.', 1),
    (w, '電話したらいい。', '전화하면 된다.', 2);

  -- 1328. ～らしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～らしい(2)', '~라는 것 같다', '추측 らしい 재활용', '문법-문장완성', 1328, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来週帰国するらしい。', '그는 다음 주 귀국하는 것 같다.', 1),
    (w, '雨が降るらしい。', '비가 오는 것 같다.', 2);

  -- 1329. ～どおり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～どおり', '~대로', '通り의 명사화', '문법-문장완성', 1329, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予定どおり進む。', '예정대로 진행된다.', 1),
    (w, '指示どおりにやる。', '지시대로 한다.', 2);

  -- 1330. ～とおりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とおりに(2)', '~대로', 'とおりに 재활용', '문법-문장완성', 1330, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思ったとおりに動いた。', '생각한 대로 움직였다.', 1),
    (w, '言ったとおりにしてください。', '말한 대로 해 주세요.', 2);

  -- 1331. ～に対して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に対して(3)', 'にたいして', '~에 대해서', 'に対して 재활용', '문법-문장완성', 1331, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は私に対して優しい。', '그는 나에게 친절하다.', 1),
    (w, 'この問題に対して答える。', '이 문제에 대해 답한다.', 2);

  -- 1332. ～に比べると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に比べると', 'にくらべると', '~에 비해', '比(견줄 비)べる. 비교', '문법-문장완성', 1332, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年に比べると暑い。', '작년에 비하면 덥다.', 1),
    (w, '彼に比べると経験不足だ。', '그에 비하면 경험이 부족하다.', 2);

  -- 1333. ～抜きには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～抜きには', 'ぬきには', '~빼고는, ~없이는', '抜(뺄 발)き+に+は. 제외/필수 조건', '문법-문장완성', 1333, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼抜きには成功しなかった。', '그 없이는 성공하지 못했다.', 1),
    (w, '冗談抜きには話せない。', '농담 빼고는 말할 수 없다.', 2);

  -- 1334. ～どころか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～どころか(2)', '~는커녕', 'どころか 재활용', '문법-문장완성', 1334, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感謝されるどころか怒られた。', '감사받기는커녕 혼났다.', 1),
    (w, '休みどころか残業ばかりだ。', '쉬기는커녕 야근뿐이다.', 2);

  -- 1335. ～と思うと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～と思うと', '~라고 생각하니', 'と+思う+と. 연속 변화 묘사', '문법-문장완성', 1335, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣いていたかと思うと笑い出した。', '울고 있었나 싶더니 웃기 시작했다.', 1),
    (w, '帰ったと思うとまた出かけた。', '돌아왔나 싶더니 또 나갔다.', 2);

  -- 1336. ～とは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とは(2)', '~라니', 'とは 재활용. 놀라움', '문법-문장완성', 1336, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まさか落ちるとは。', '설마 떨어지다니.', 1),
    (w, 'ここで会うとは。', '여기서 만나다니.', 2);

  -- 1337. ～うちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～うちに(4)', '~하는 사이에', 'うちに 재활용', '문법-문장완성', 1337, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気づかないうちに夜になった。', '모르는 사이에 밤이 되었다.', 1),
    (w, '考えているうちに眠くなった。', '생각하고 있는 사이에 졸렸다.', 2);

  -- 1338. ～つもりでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～つもりでも', '~한 줄 알았지만', 'つもり+でも. 의도와 실제 차이', '문법-문장완성', 1338, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張ったつもりでも結果が出ない。', '노력한 줄 알았지만 결과가 안 나온다.', 1),
    (w, '丁寧に話したつもりでも誤解された。', '정중히 말한 줄 알았지만 오해받았다.', 2);

  -- 1339. ～そうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～そうだ(전문4)', '~라고 한다', '전문 そうだ 재활용', '문법-문장완성', 1339, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は退職するそうだ。', '그녀는 퇴직한다고 한다.', 1),
    (w, 'その店は美味しいそうだ。', '그 가게는 맛있다고 한다.', 2);

  -- 1340. ～以上は
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～以上は', 'いじょうは', '~한 이상에는', '以上+は. 「~인 이상은 마땅히」', '문법-문장완성', 1340, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '引き受けた以上は最後までやる。', '맡은 이상에는 끝까지 한다.', 1),
    (w, '約束した以上は守る。', '약속한 이상에는 지킨다.', 2);

  -- 1341. ～ずにはいられない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ずにはいられない', '~하지 않을 수 없다', 'ず+に+はいられない. 자제 불가', '문법-문장완성', 1341, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣かずにはいられない。', '울지 않을 수 없다.', 1),
    (w, '助けずにはいられない。', '돕지 않을 수 없다.', 2);

  -- 1342. ～まま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～まま', '~한 채', '儘(まま). 상태 유지', '문법-문장완성', 1342, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビをつけたまま寝た。', '텔레비전을 켠 채 잤다.', 1),
    (w, '窓を開けたままだ。', '창문이 열린 채다.', 2);

  -- 1343. ～ていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ていただく(2)', '~해 받다 <겸양>', '겸양 ていただく 재활용', '문법-문장완성', 1343, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '説明していただけませんか。', '설명해 주시지 않겠습니까?', 1),
    (w, '送っていただきありがとうございます。', '보내 주셔서 감사합니다.', 2);

  -- 1344. ～だろうと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だろうと思う', '~일 것이라고 생각하다', 'だろう+と+思う. 추측+생각', '문법-문장완성', 1344, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るだろうと思う。', '비가 올 것이라고 생각한다.', 1),
    (w, '彼は来るだろうと思う。', '그는 올 것이라고 생각한다.', 2);

  -- 1345. ～がきっかけだった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～がきっかけだった', '~이 계기였다', '切っ掛け. 시작의 계기', '문법-문장완성', 1345, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼との出会いがきっかけだった。', '그와의 만남이 계기였다.', 1),
    (w, 'あの一言がきっかけだった。', '그 한마디가 계기였다.', 2);

  -- 1346. ～となる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～となる', '~이 되다', 'と+なる. 결과/변화. 격식', '문법-문장완성', 1346, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が代表となる。', '그가 대표가 된다.', 1),
    (w, '結果は引き分けとなった。', '결과는 무승부가 되었다.', 2);

  -- 1347. ～と比べて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～と比べて', 'とくらべて', '~에 비해', '比べる+て. 비교', '문법-문장완성', 1347, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔と比べて便利だ。', '옛날에 비해 편리하다.', 1),
    (w, '兄と比べて背が低い。', '형에 비해 키가 작다.', 2);

  -- 1348. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によって(수단)', '~에 의해서', '수단 によって 재활용', '문법-문장완성', 1348, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '機械によって製造される。', '기계에 의해 제조된다.', 1),
    (w, '努力によって変えられる。', '노력에 의해 바꿀 수 있다.', 2);

  -- 1349. ～に先立って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に先立って', 'にさきだって', '~에 앞서', '先(먼저 선)立つ+て. 사전 행위', '문법-문장완성', 1349, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議に先立って資料を配布する。', '회의에 앞서 자료를 배포한다.', 1),
    (w, '出発に先立って点呼を取る。', '출발에 앞서 점호한다.', 2);

  -- 1350. ～たびに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たびに(4)', '~할 때마다', 'たびに 재활용', '문법-문장완성', 1350, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行のたびに新しい発見がある。', '여행할 때마다 새 발견이 있다.', 1),
    (w, '訪れるたびに変わっている。', '방문할 때마다 변해 있다.', 2);

  -- 1351. ～せいで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～せいで', '~탓에', '所為+で. 부정적 원인', '문법-문장완성', 1351, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨のせいで遅刻した。', '비 탓에 지각했다.', 1),
    (w, '彼のせいで失敗した。', '그 탓에 실패했다.', 2);

  -- 1352. どうしても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どうしても(3)', '무슨 일이 있어도, 꼭', 'どうしても 재활용', '문법-문장완성', 1352, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしても食べたい。', '꼭 먹고 싶다.', 1),
    (w, 'どうしても許せない。', '도저히 용서할 수 없다.', 2);

  -- 1353. ～上で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～上で(3)', 'うえで', '~한 후에', '순서 上で 재활용', '문법-문장완성', 1353, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よく確認した上で送る。', '잘 확인한 후에 보낸다.', 1),
    (w, '相談した上で決める。', '상담한 후에 결정한다.', 2);

  -- 1354. ～としても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～としても(3)', '~라고 할지라도', 'としても 재활용', '문법-문장완성', 1354, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談だとしても許せない。', '농담이라 해도 용서할 수 없다.', 1),
    (w, '本当だとしても驚かない。', '사실이라 해도 놀라지 않는다.', 2);

  -- 1355. ～すら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～すら(4)', '~조차', 'すら 재활용', '문법-문장완성', 1355, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一言すら言えなかった。', '한 마디조차 못 했다.', 1),
    (w, '基本すら知らない。', '기본조차 모른다.', 2);

  -- 1356. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ほど(5)', '~정도', 'ほど 재활용', '문법-문장완성', 1356, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '声が出ないほど叫んだ。', '목소리가 안 나올 정도로 외쳤다.', 1),
    (w, '泣くほど嬉しかった。', '울 정도로 기뻤다.', 2);

  -- 1357. ～ながらも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ながらも', '~하면서도 (역접)', 'ながら+も. 양보적 역접', '문법-문장완성', 1357, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さいながらも一軒家を持っている。', '작지만 한 채의 집을 가지고 있다.', 1),
    (w, '残念ながらも諦めた。', '아쉽지만 포기했다.', 2);

  -- 1358. ～たらいいのか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たらいいのか', '~하면 좋을지', 'たら+いい+のか. 방안 모색 의문', '문법-문장완성', 1358, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうしたらいいのか分からない。', '어떻게 하면 좋을지 모르겠다.', 1),
    (w, '何を言ったらいいのか。', '무슨 말을 하면 좋을지.', 2);

  -- 1359. ～わりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わりに', '~에 비해서', '割(쪼갤 할)り+に. 비례 부적합', '문법-문장완성', 1359, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '値段のわりに美味しい。', '가격에 비해 맛있다.', 1),
    (w, '年のわりに若く見える。', '나이에 비해 젊어 보인다.', 2);

  -- 1360. それなりの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'それなりの', '나름대로의', 'それ+なり+の. 그에 상응하는', '문법-문장완성', 1360, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それなりの努力が必要だ。', '나름대로의 노력이 필요하다.', 1),
    (w, 'それなりの理由がある。', '나름대로의 이유가 있다.', 2);

  -- 1361. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～として(3)', '~로서', 'として 재활용', '문법-문장완성', 1361, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父親として誇りに思う。', '아버지로서 자랑스럽다.', 1),
    (w, '記念品として贈る。', '기념품으로서 선물한다.', 2);

  -- 1362. ～かねない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かねない', '~할 수도 있다 (부정적 가능)', '兼ねる+ない. 「~할 위험성」', '문법-문장완성', 1362, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼ならやりかねない。', '그라면 저지를 수도 있다.', 1),
    (w, '事故になりかねない。', '사고가 날 수도 있다.', 2);

  -- 1363. ～といっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といっても(2)', '~라고 해도', 'といっても 재활용', '문법-문장완성', 1363, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強といってもほんの少しだ。', '공부라고 해도 그저 조금이다.', 1),
    (w, '雨といっても弱い雨だ。', '비라고 해도 약한 비다.', 2);

  -- 1364. ～について
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～について', '~에 대하여', '就(나아갈 취)く+て. 주제 제시', '문법-문장완성', 1364, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境問題について話し合う。', '환경 문제에 대해 논의한다.', 1),
    (w, 'この件について説明します。', '이 건에 대해 설명하겠습니다.', 2);

  -- 1365. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ことから(3)', '~로 인해', 'ことから 재활용', '문법-문장완성', 1365, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果が出ていることから判断する。', '결과가 나와 있으므로 판단한다.', 1),
    (w, '名前が似ていることから親子と思われた。', '이름이 비슷해서 부모자식으로 보였다.', 2);

  -- 1366. ～ぐらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ぐらい(2)', '~정도', 'ぐらい 재활용', '문법-문장완성', 1366, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣きたいぐらい辛い。', '울고 싶을 정도로 힘들다.', 1),
    (w, 'これぐらいできるよ。', '이 정도는 할 수 있어.', 2);

  -- 1367. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～によって(차이2)', '~에 의해서, ~에 따라', 'によって 재활용', '문법-문장완성', 1367, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '場合によって対応が違う。', '경우에 따라 대응이 다르다.', 1),
    (w, '人によって好みが違う。', '사람에 따라 취향이 다르다.', 2);

  -- 1368. ～てたまらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～てたまらない(2)', '너무 ~하다, 견딜 수 없다', 'てたまらない 재활용', '문법-문장완성', 1368, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寂しくてたまらない。', '너무 외롭다.', 1),
    (w, '気になってたまらない。', '너무 신경 쓰인다.', 2);

  -- 1369. ～からすると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～からすると(2)', '~로 보아', 'からすると 재활용', '문법-문장완성', 1369, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '声の感じからすると怒っている。', '목소리 느낌으로 보아 화나 있다.', 1),
    (w, '結果からすると成功だ。', '결과로 보아 성공이다.', 2);

  -- 1370. ～と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～と', '~하면, ~라면 <조건>', '조사 と. 항상 그러한 결과/조건', '문법-문장완성', 1370, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春になると暖かくなる。', '봄이 되면 따뜻해진다.', 1),
    (w, 'お金が足りないと買えない。', '돈이 부족하면 살 수 없다.', 2);

  -- 1371. ～だけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だけ(3)', '~한 만큼, ~할 수 있는 한', 'だけ 재활용', '문법-문장완성', 1371, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できるだけ努力する。', '가능한 한 노력한다.', 1),
    (w, 'やれるだけやってみる。', '할 수 있는 만큼 해본다.', 2);

  -- 1372. ～にもなったような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～にもなったような', '~라도 된 것 같은', 'に+も+なる+ような. 가상의 비유', '문법-문장완성', 1372, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '王様にもなったような気分。', '왕이라도 된 것 같은 기분.', 1),
    (w, '別人にもなったような顔。', '딴 사람이라도 된 것 같은 얼굴.', 2);

  -- 1373. ～を込めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～を込めて', 'をこめて', '~을 담아', '込める+て. をこめて 재활용', '문법-문장완성', 1373, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心を込めて贈る。', '마음을 담아 선물한다.', 1),
    (w, '感謝を込めて作った。', '감사를 담아 만들었다.', 2);

  -- 1374. ～あまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～あまり(2)', '~한 나머지', '余り 재활용', '문법-문장완성', 1374, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '喜びのあまり踊り出した。', '기쁜 나머지 춤을 추기 시작했다.', 1),
    (w, '心配のあまり眠れなかった。', '걱정한 나머지 잠들지 못했다.', 2);

  -- ────────── 문법 문맥 이해 (120개, 1375~1494) ──────────

  -- 1375. ～もの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～もの', '~것', '物(もの). 명사화. 사물/추상', '문법-문맥이해', 1375, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大切なものを失った。', '소중한 것을 잃었다.', 1),
    (w, '欲しいものは何ですか。', '갖고 싶은 것은 무엇입니까?', 2);

  -- 1376. ～わけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～わけだ', '~인 것이다 <설명·결론>', '訳(이유)+だ. 논리적 귀결·납득', '문법-문맥이해', 1376, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だから遅れたわけだ。', '그래서 늦은 것이다.', 1),
    (w, '彼が知らないわけだ。', '그가 모르는 것이 당연하다.', 2);

  -- 1377. ～に関して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～に関して', 'にかんして', '~에 관해서', '関(빗장 관). 주제 제시', '문법-문맥이해', 1377, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題に関して話す。', '이 문제에 관해 이야기한다.', 1),
    (w, '彼に関して情報がない。', '그에 관해서 정보가 없다.', 2);

  -- 1378. ～ならば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ならば', '~이라면 (격식)', 'なら+ば. 문어체 가정', '문법-문맥이해', 1378, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もし可能ならばお願いしたい。', '혹시 가능하다면 부탁드리고 싶다.', 1),
    (w, '必要ならば連絡する。', '필요하다면 연락한다.', 2);

  -- 1379. ～ないのではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ないのではない', '~할 수 없는 것은 아니다', 'ない+の+ではない. 이중 부정', '문법-문맥이해', 1379, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けないのではないが、行きたくない。', '갈 수 없는 것은 아니지만 가고 싶지 않다.', 1),
    (w, 'できないのではない、難しいだけだ。', '못 하는 것은 아니다, 단지 어려울 뿐이다.', 2);

  -- 1380. この
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'この', '이', '근칭 연체사. 가까이 있는 것 지시', '문법-문맥이해', 1380, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この本は面白い。', '이 책은 재미있다.', 1),
    (w, 'この件は重要だ。', '이 건은 중요하다.', 2);

  -- 1381. このように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'このように', '이처럼, 이렇게', 'この+ように. 방식 지시', '문법-문맥이해', 1381, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このように準備します。', '이렇게 준비합니다.', 1),
    (w, 'このようにして問題を解決した。', '이런 식으로 문제를 해결했다.', 2);

  -- 1382. ～ましょう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ましょう', '~합시다', 'ます+よう. 권유/제안', '문법-문맥이해', 1382, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一緒に行きましょう。', '같이 갑시다.', 1),
    (w, '頑張りましょう。', '힘냅시다.', 2);

  -- 1383. ～が～だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～が～だ', '~이(가) ~이다', '주격 조사 が+서술 だ. 강조·대비', '문법-문맥이해', 1383, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '味が問題だ。', '맛이 문제다.', 1),
    (w, '時間が大事だ。', '시간이 중요하다.', 2);

  -- 1384. ～たらどうですか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たらどうですか', '~하는 게 어떨까요?', 'たら+どうですか. 제안', '문법-문맥이해', 1384, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休んだらどうですか。', '쉬는 게 어떨까요?', 1),
    (w, '相談したらどうですか。', '상담하는 게 어떨까요?', 2);

  -- 1385. どのように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どのように', '어떻게, 어떤 식으로', 'どの+ように. 방법 의문', '문법-문맥이해', 1385, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どのように解決しますか。', '어떻게 해결합니까?', 1),
    (w, 'どのように説明すればいい？', '어떤 식으로 설명하면 좋을까?', 2);

  -- 1386. ほかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '他に', 'ほかに', '그 밖에', '他(다를 타)+に. 추가/제외', '문법-문맥이해', 1386, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ほかに質問はありますか。', '그 밖에 질문 있습니까?', 1),
    (w, 'ほかに方法はない。', '다른 방법은 없다.', 2);

  -- 1387. こう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'こう', '이렇게', '근칭 부사. 화자 가까이 방법 지시', '문법-문맥이해', 1387, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうやってみてください。', '이렇게 해 보세요.', 1),
    (w, 'こう寒くては外に出られない。', '이렇게 추워서는 밖에 나갈 수 없다.', 2);

  -- 1388. 彼女たち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '彼女たち', 'かのじょたち', '그녀들', '彼女+たち(복수). 여성 3인칭 복수', '문법-문맥이해', 1388, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女たちが話している。', '그녀들이 이야기하고 있다.', 1),
    (w, '彼女たちの意見を聞きたい。', '그녀들의 의견을 듣고 싶다.', 2);

  -- 1389. さまざまだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '様々だ', 'さまざまだ', '다양하다', '様(모양 양)々+だ. 다양·각종', '문법-문맥이해', 1389, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見はさまざまだ。', '의견은 다양하다.', 1),
    (w, 'さまざまな国を旅した。', '다양한 나라를 여행했다.', 2);

  -- 1390. このような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'このような', '이러한', 'この+ような. 종류·성질 지시', '문법-문맥이해', 1390, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このような結果は珍しい。', '이러한 결과는 드물다.', 1),
    (w, 'このような場合はどうしますか。', '이러한 경우에는 어떻게 합니까?', 2);

  -- 1391. ～(ら)れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(ら)れる(2)', '~하게 되다, ~받다 <수동>', '수동/가능/존경 (ら)れる 재활용', '문법-문맥이해', 1391, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨に降られた。', '비를 맞았다.', 1),
    (w, '皆に愛されている。', '모두에게 사랑받고 있다.', 2);

  -- 1392. つまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'つまり', '즉, 다시 말해', '詰まり. 요약/결론 접속사', '문법-문맥이해', 1392, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、もう無理だ。', '즉, 이제 무리다.', 1),
    (w, 'つまり、これが結論だ。', '다시 말해 이것이 결론이다.', 2);

  -- 1393. ～なら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～なら(4)', '~이라면', 'なら 재활용', '문법-문맥이해', 1393, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本ならこちらにあります。', '책이라면 이쪽에 있습니다.', 1),
    (w, '安いなら買う。', '싸다면 산다.', 2);

  -- 1394. たとえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '例えば', 'たとえば', '예를 들면', '例(법식 례)える. 예시 제시', '문법-문맥이해', 1394, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たとえばこんな場合だ。', '예를 들면 이런 경우다.', 1),
    (w, 'たとえばリンゴやバナナです。', '예를 들면 사과나 바나나입니다.', 2);

  -- 1395. もちろん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '勿論', 'もちろん', '물론, 당연히', '勿(말 물)+論. 당연 강조', '문법-문맥이해', 1395, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もちろん行きます。', '물론 가겠습니다.', 1),
    (w, 'もちろん知っている。', '물론 알고 있다.', 2);

  -- 1396. 場合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '場合', 'ばあい', '경우', '場(마당 장)+合(합할 합). 사례·상황', '문법-문맥이해', 1396, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨の場合は中止する。', '비 오는 경우에는 중지한다.', 1),
    (w, 'この場合はどうする？', '이 경우에는 어떻게 해?', 2);

  -- 1397. ～というわけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というわけだ', '~인 것이다 <결론>', 'という+わけだ. 결론/설명', '문법-문맥이해', 1397, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり彼は知らないというわけだ。', '즉 그는 모른다는 것이다.', 1),
    (w, '理由がないというわけだ。', '이유가 없다는 것이다.', 2);

  -- 1398. ～のである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のである', '~인 것이다', 'のだ의 격식. 단정·설명', '문법-문맥이해', 1398, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は努力したのである。', '그는 노력한 것이다.', 1),
    (w, 'これは真実なのである。', '이것은 진실인 것이다.', 2);

  -- 1399. ～かもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～かもしれない(2)', '~일지도 모른다', 'かもしれない 재활용', '문법-문맥이해', 1399, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違っているかもしれない。', '틀렸을지도 모른다.', 1),
    (w, '雪が降るかもしれない。', '눈이 올지도 모른다.', 2);

  -- 1400. 実は
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '実は', 'じつは', '실은', '実(열매 실)は. 진실 도입 부사', '문법-문맥이해', 1400, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実は彼が来る。', '실은 그가 온다.', 1),
    (w, '実は知らなかった。', '실은 몰랐다.', 2);

  -- 1401. ～とされる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とされる', '~라고 되다, ~라고 여겨지다', 'と+する의 수동. 사회적 통념', '문법-문맥이해', 1401, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康に良いとされる食品。', '건강에 좋다고 여겨지는 식품.', 1),
    (w, '正しいとされる方法。', '옳다고 여겨지는 방법.', 2);

  -- 1402. お～いただけますか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'お～いただけますか', '~하실 수 있겠습니까? <겸손>', 'お+ます형+いただけますか. 매우 정중 의뢰', '문법-문맥이해', 1402, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お電話いただけますか。', '전화 주실 수 있겠습니까?', 1),
    (w, 'お待ちいただけますか。', '기다려 주실 수 있겠습니까?', 2);

  -- 1403. そうでもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そうでもない', '그렇지도 않다', 'そう+でも+ない. 부분 부정', '문법-문맥이해', 1403, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高いと思ったがそうでもない。', '비싸다고 생각했는데 그렇지도 않다.', 1),
    (w, '忙しいかと思えばそうでもない。', '바쁘다고 생각하면 그렇지도 않다.', 2);

  -- 1404. ～とは思えない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とは思えない', '~라고는 생각되지 않는다', 'と+は+思える+ない. 강한 부정 추측', '문법-문맥이해', 1404, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当だとは思えない。', '사실이라고는 생각되지 않는다.', 1),
    (w, '彼が嘘をつくとは思えない。', '그가 거짓말한다고는 생각되지 않는다.', 2);

  -- 1405. 理由
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '理由', 'りゆう', '이유', '理(다스릴 리)+由(말미암을 유). 근거', '문법-문맥이해', 1405, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '理由を教えてください。', '이유를 알려 주세요.', 1),
    (w, 'その理由は何ですか。', '그 이유는 무엇입니까?', 2);

  -- 1406. だが～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'だが～', '그렇지만~', 'だ+が. 역접 접속사', '문법-문맥이해', 1406, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張った。だが結果は出なかった。', '노력했다. 그렇지만 결과는 안 나왔다.', 1),
    (w, '寒い。だが行く。', '춥다. 그렇지만 간다.', 2);

  -- 1407. ～(さ)せられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(さ)せられる(3)', '본의 아니게 ~하게 되다', '사역수동 させられる 재활용', '문법-문맥이해', 1407, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反省させられる本。', '반성하게 되는 책.', 1),
    (w, '考えさせられる映画。', '생각하게 되는 영화.', 2);

  -- 1408. 出会う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '出会う', 'であう', '만나다, 마주치다', '出(날 출)+会(만날 회)う. 우연/운명적 만남', '문법-문맥이해', 1408, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼と偶然出会った。', '그와 우연히 만났다.', 1),
    (w, '素晴らしい人に出会えた。', '훌륭한 사람을 만날 수 있었다.', 2);

  -- 1409. ある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '或る', 'ある', '어느, 어떤', '不特定. 「특정하지 않은」', '문법-문맥이해', 1409, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ある日、彼が来た。', '어느 날 그가 왔다.', 1),
    (w, 'ある人が言っていた。', '어떤 사람이 말했다.', 2);

  -- 1410. ～と言える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～と言える', '~라고 말할 수 있다', '言う의 가능형. 결론 도출', '문법-문맥이해', 1410, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは成功だと言える。', '이것은 성공이라고 말할 수 있다.', 1),
    (w, '彼は天才と言える。', '그는 천재라고 말할 수 있다.', 2);

  -- 1411. ～とはいえ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～とはいえ', '~라고는 해도', 'と+は+いえ. 격식 역접', '문법-문맥이해', 1411, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冬とはいえ暖かい日もある。', '겨울이라고는 해도 따뜻한 날도 있다.', 1),
    (w, '休みとはいえ忙しい。', '쉰다고는 해도 바쁘다.', 2);

  -- 1412. ～(よ)うと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～(よ)うと思う', '~하려고 생각하다', '의지형+と+思う. 의도 표명', '문법-문맥이해', 1412, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '留学しようと思っている。', '유학하려고 생각하고 있다.', 1),
    (w, '今度こそやろうと思う。', '이번엔 정말 하려고 생각한다.', 2);

  -- 1413. その
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'その', '그', '중칭 연체사. 상대 가까이 지시', '문법-문맥이해', 1413, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その本を貸してください。', '그 책을 빌려주세요.', 1),
    (w, 'その時、雨が降った。', '그때 비가 왔다.', 2);

  -- 1414. ～といい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といい', '~하면 좋다', 'と(조건)+いい. 조언/희망', '문법-문맥이해', 1414, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く来るといい。', '빨리 오면 좋다.', 1),
    (w, '雨が止むといいな。', '비가 그치면 좋겠다.', 2);

  -- 1415. 使用されている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '使用されている', 'しようされている', '사용되고 있다', '使(부릴 사)用(쓸 용)される+ている. 수동 진행', '문법-문맥이해', 1415, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この技術は広く使用されている。', '이 기술은 널리 사용되고 있다.', 1),
    (w, '古い言葉も今でも使用されている。', '옛 말도 지금도 사용되고 있다.', 2);

  -- 1416. ～に違いない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～に違いない(2)', '~에 틀림없다', 'に違いない 재활용', '문법-문맥이해', 1416, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るに違いない。', '그가 올 게 틀림없다.', 1),
    (w, 'これは本物に違いない。', '이것은 진품임에 틀림없다.', 2);

  -- 1417. どのような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どのような', '어떠한', 'どの+ような. 종류 의문', '문법-문맥이해', 1417, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どのような結果ですか。', '어떠한 결과입니까?', 1),
    (w, 'どのような方法で？', '어떠한 방법으로?', 2);

  -- 1418. ～という(との)ことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～という(との)ことだ', '~라고 한다', 'という+ことだ. 전문', '문법-문맥이해', 1418, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は退院するということだ。', '그는 퇴원한다고 한다.', 1),
    (w, '会議は中止になったとのことだ。', '회의는 중지되었다고 한다.', 2);

  -- 1419. 要するに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '要するに', 'ようするに', '요컨대', '要(요긴할 요)+する+に. 핵심 요약', '문법-문맥이해', 1419, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '要するに練習が大事だ。', '요컨대 연습이 중요하다.', 1),
    (w, '要するに無理だということだ。', '요컨대 무리라는 것이다.', 2);

  -- 1420. ～だろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だろうか(2)', '~일까?', 'だろうか 재활용', '문법-문맥이해', 1420, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当だろうか。', '정말일까?', 1),
    (w, 'これでいいだろうか。', '이걸로 될까?', 2);

  -- 1421. どの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'どの', '어느', '不定 연체사. 선택 의문', '문법-문맥이해', 1421, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どの本がいいですか。', '어느 책이 좋습니까?', 1),
    (w, 'どの道に行く？', '어느 길로 갈래?', 2);

  -- 1422. ～たところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～たところ(3)', '~했더니, ~한 결과', 'たところ 재활용', '문법-문맥이해', 1422, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞いてみたところ、わからないと言った。', '물어 봤더니 모른다고 했다.', 1),
    (w, '調べたところ、間違いがあった。', '조사해 봤더니 오류가 있었다.', 2);

  -- 1423. ～ようだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ようだ', '~인 것 같다, ~듯하다', '様+だ. 추측·비유', '문법-문맥이해', 1423, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降っているようだ。', '비가 오고 있는 것 같다.', 1),
    (w, '彼は怒っているようだ。', '그는 화가 난 것 같다.', 2);

  -- 1424. ～ではないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ではないか', '~가 아닐까?, ~이 아니냐', 'ではない+か. 동의 구함/추측', '문법-문맥이해', 1424, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いい考えではないか。', '좋은 생각이 아닌가?', 1),
    (w, 'これは違うのではないか。', '이건 틀린 게 아닐까?', 2);

  -- 1425. ～以上だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～以上だ', 'いじょうだ', '~이상이다', '以上+だ. 종결/한계 표현', '문법-문맥이해', 1425, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '報告は以上です。', '보고는 이상입니다.', 1),
    (w, '今日の予定は以上だ。', '오늘의 예정은 이상이다.', 2);

  -- 1426. こんな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'こんな', '이러한', 'この+ような의 회화체', '문법-문맥이해', 1426, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんな話は初めてだ。', '이런 이야기는 처음이다.', 1),
    (w, 'こんなに寒いとは。', '이렇게 추울 줄이야.', 2);

  -- 1427. すると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'すると', '그러자, 그랬더니 <접속사>', 'する+と. 시간적 후속', '문법-문맥이해', 1427, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すると、彼が現れた。', '그러자 그가 나타났다.', 1),
    (w, '雨が降った。すると寒くなった。', '비가 왔다. 그러자 추워졌다.', 2);

  -- 1428. ～だろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～だろう(2)', '~일 것이다', 'だろう 재활용', '문법-문맥이해', 1428, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は元気だろう。', '그는 잘 지낼 것이다.', 1),
    (w, 'これで十分だろう。', '이걸로 충분할 것이다.', 2);

  -- 1429. ～ではないのか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～ではないのか', '~가 아닌 것일까?', 'ではない+のか. 강한 의문/확인', '문법-문맥이해', 1429, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もっと簡単な方法があるのではないのか。', '더 쉬운 방법이 있는 게 아닐까?', 1),
    (w, 'これは間違いではないのか。', '이건 잘못된 게 아닐까?', 2);

  -- 1430. こういう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'こういう', '이러한', 'こう+いう. 종류 지시', '문법-문맥이해', 1430, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こういう人が好きだ。', '이런 사람이 좋다.', 1),
    (w, 'こういう場合は注意が必要だ。', '이런 경우에는 주의가 필요하다.', 2);

  -- 1431. ～らしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～らしい(3)', '~라는 것 같다', '추측 らしい 재활용', '문법-문맥이해', 1431, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果が出るらしい。', '결과가 나올 것 같다.', 1),
    (w, '中止になるらしい。', '중지될 것 같다.', 2);

  -- 1432. 確かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '確かに', 'たしかに', '확실히, 분명히', '確(굳을 확)か+に. 확신 부사', '문법-문맥이해', 1432, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確かに受け取りました。', '확실히 받았습니다.', 1),
    (w, '確かに彼は来ていた。', '분명히 그는 와 있었다.', 2);

  -- 1433. ～のだろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のだろう', '~인 것이겠지', 'のだ+だろう. 설명+추측', '문법-문맥이해', 1433, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は疲れているのだろう。', '그는 피곤한 것일 거다.', 1),
    (w, '何か理由があるのだろう。', '뭔가 이유가 있는 것일 거다.', 2);

  -- 1434. ご存じだろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご存じだろうか', 'ごぞんじだろうか', '알고 계시는 것일까? <존경>', 'ご存じ+だろうか. 정중한 추측 의문', '문법-문맥이해', 1434, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '皆様、ご存じだろうか。', '여러분, 알고 계실까요?', 1),
    (w, 'この事実をご存じだろうか。', '이 사실을 알고 계실까?', 2);

  -- 1435. しかし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'しかし', '그러나', '대표적 역접 접속사', '문법-문맥이해', 1435, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張った。しかし失敗した。', '노력했다. 그러나 실패했다.', 1),
    (w, '寒い。しかし出かける。', '춥다. 그러나 나간다.', 2);

  -- 1436. こうして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'こうして', '이렇게 해서', 'こう+して. 과정 지시', '문법-문맥이해', 1436, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうして問題は解決した。', '이렇게 해서 문제는 해결되었다.', 1),
    (w, 'こうして仲良くなった。', '이렇게 해서 친해졌다.', 2);

  -- 1437. さらに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '更に', 'さらに', '게다가, 더욱이', '更(다시 갱)に. 추가/심화', '문법-문맥이해', 1437, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さらに練習を続ける。', '더욱 연습을 계속한다.', 1),
    (w, 'さらに問題が増えた。', '게다가 문제가 늘었다.', 2);

  -- 1438. それには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'それには', '그렇게 하기 위해서는', 'それ+に+は. 목적 달성 조건', '문법-문맥이해', 1438, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それには努力が必要だ。', '그렇게 하기 위해서는 노력이 필요하다.', 1),
    (w, 'それには時間がかかる。', '그것에는 시간이 걸린다.', 2);

  -- 1439. ～のだろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～のだろう(2)', '~인 것이겠지', 'のだろう 재활용', '문법-문맥이해', 1439, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は何を考えているのだろう。', '그는 무엇을 생각하고 있는 것일까.', 1),
    (w, 'なぜ来なかったのだろう。', '왜 안 온 것일까.', 2);

  -- 1440. そんな大きな翼
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'そんな大きな翼', 'そんなおおきなつばさ', '그러한 커다란 날개', 'そんな+大きな+翼. 비유적 표현', '문법-문맥이해', 1440, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな大きな翼で空を飛ぶ。', '그러한 커다란 날개로 하늘을 난다.', 1),
    (w, 'そんな大きな翼を持つ鳥は珍しい。', '그러한 커다란 날개를 가진 새는 드물다.', 2);

  -- 1441. こうして見てみると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'こうして見てみると', 'こうしてみてみると', '이렇게 보면', 'こうして+見てみる+と. 관점 전환', '문법-문맥이해', 1441, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうして見てみると意外と簡単だ。', '이렇게 보면 의외로 간단하다.', 1),
    (w, 'こうして見てみると違いがわかる。', '이렇게 보면 차이를 알 수 있다.', 2);

  -- 1442. 難しそうです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '難しそうです', 'むずかしそうです', '어려울 것 같습니다', '難(어려울 난)しい+양태そうだ+です', '문법-문맥이해', 1442, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この試験は難しそうです。', '이 시험은 어려워 보입니다.', 1),
    (w, '今回の課題も難しそうです。', '이번 과제도 어려울 것 같습니다.', 2);

  -- 1443. 道路
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '道路', 'どうろ', '도로', '道(길 도)+路(길 로). 차량 통행로', '문법-문맥이해', 1443, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道路が混んでいる。', '도로가 막힌다.', 1),
    (w, '新しい道路ができた。', '새 도로가 생겼다.', 2);

  -- 1444. ご存じでしょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご存じだろうか(2)', 'ごぞんじだろうか', '알고 계실까?', 'ご存じ+だろうか. 정중한 추측 의문 재활용', '문법-문맥이해', 1444, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '皆様、ご存じでしょうか。', '여러분, 알고 계신가요?', 1),
    (w, 'この事実をご存じでしょうか。', '이 사실을 알고 계실까요?', 2);

  -- 1445. また
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '又', 'また', '또, 다시 / 게다가', '又(또 우). 반복/추가', '문법-문맥이해', 1445, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'また会いましょう。', '또 만납시다.', 1),
    (w, 'また、新しい問題が出た。', '또한 새 문제가 나왔다.', 2);

  -- 1446. ～工夫も見られる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '～工夫も見られる', 'くふうもみられる', '~하는 고안(궁리)도 볼 수 있다', '工(만들 공)夫. 창의 관찰', '문법-문맥이해', 1446, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デザインに工夫も見られる。', '디자인에 창의도 볼 수 있다.', 1),
    (w, '節電する工夫も見られる。', '절전 노력도 볼 수 있다.', 2);

  -- 1447. 支えてくれているわけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '支えてくれているわけだ', 'ささえてくれているわけだ', '지탱해주고 있는 것이다', '支える+てくれる+わけだ. 수혜+결론', '문법-문맥이해', 1447, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族が支えてくれているわけだ。', '가족이 지탱해주고 있는 것이다.', 1),
    (w, '友人たちが支えてくれているわけだ。', '친구들이 받쳐주고 있는 것이다.', 2);

  -- 1448. 挙げよう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '挙げよう', 'あげよう', '들어보자, 예시하자', '挙(들 거)げる+よう. 예시 권유', '문법-문맥이해', 1448, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '例を挙げよう。', '예를 들어 보자.', 1),
    (w, '理由を挙げよう。', '이유를 들어 보자.', 2);

  -- 1449. そこで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そこで', '그래서, 그리하여', '인과·전환 접속사', '문법-문맥이해', 1449, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降った。そこで傘を差した。', '비가 왔다. 그래서 우산을 폈다.', 1),
    (w, 'そこで提案がある。', '그래서 제안이 있다.', 2);

  -- 1450. 活用して
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '活用して', 'かつようして', '활용해서', '活(살 활)用. 적극 사용', '문법-문맥이해', 1450, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間を活用して勉強する。', '시간을 활용해서 공부한다.', 1),
    (w, '資源を活用して開発する。', '자원을 활용해서 개발한다.', 2);

  -- 1451. ～というわけだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～というわけだ(2)', '~인 것이다', 'というわけだ 재활용', '문법-문맥이해', 1451, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり成功したというわけだ。', '즉 성공했다는 것이다.', 1),
    (w, '理由はないというわけだ。', '이유는 없다는 것이다.', 2);

  -- 1452. ～してみるのも悪くない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～してみるのも悪くない', '~해 보는 것도 나쁘지 않다', 'してみる+のも+悪くない. 권유', '문법-문맥이해', 1452, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行してみるのも悪くない。', '여행해 보는 것도 나쁘지 않다.', 1),
    (w, '挑戦してみるのも悪くない。', '도전해 보는 것도 나쁘지 않다.', 2);

  -- 1453. 増えているそうです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '増えているそうです', 'ふえているそうです', '늘고 있다고 합니다', '増える+ている+そうです(전문)', '문법-문맥이해', 1453, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若い利用者が増えているそうです。', '젊은 이용자가 늘고 있다고 합니다.', 1),
    (w, '需要が増えているそうです。', '수요가 늘고 있다고 합니다.', 2);

  -- 1454. ただ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '只', 'ただ', '다만, 단지', '只. 한정 부사·접속사', '문법-문맥이해', 1454, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ただ見ているだけだ。', '단지 보고 있을 뿐이다.', 1),
    (w, 'ただし、注意点がある。', '다만 주의점이 있다.', 2);

  -- 1455. 下がるというわけです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '下がるというわけです', 'さがるというわけです', '내려간다고 하는 것입니다', '下がる+というわけです. 결론 설명', '문법-문맥이해', 1455, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果、価格が下がるというわけです。', '결과적으로 가격이 내려간다는 것입니다.', 1),
    (w, '冬になると気温が下がるというわけです。', '겨울이 되면 기온이 내려간다는 것입니다.', 2);

  -- 1456. そのような理由が
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'そのような理由が', 'そのようなりゆうが', '그러한 이유가', 'そのような+理由. 원인 지시', '문법-문맥이해', 1456, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そのような理由があったのか。', '그러한 이유가 있었던 것인가.', 1),
    (w, 'そのような理由が考えられる。', '그러한 이유를 생각할 수 있다.', 2);

  -- 1457. 納得させられました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '納得させられました', 'なっとくさせられました', '납득했습니다 <사역수동>', '納(들일 납)得+させられる. 강한 납득', '문법-문맥이해', 1457, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の説明に納得させられました。', '그의 설명에 납득했습니다.', 1),
    (w, 'その理由に納得させられた。', '그 이유에 납득되었다.', 2);

  -- 1458. 学び始めた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '学び始めた', 'まなびはじめた', '배우기 시작했다', '学ぶ+始める의 과거. 학습 개시', '문법-문맥이해', 1458, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '去年から日本語を学び始めた。', '작년부터 일본어를 배우기 시작했다.', 1),
    (w, '最近、楽器を学び始めた。', '최근 악기를 배우기 시작했다.', 2);

  -- 1459. わかれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '分かれば', 'わかれば', '알면', '分かる+ば. 가정 조건', '문법-문맥이해', 1459, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わかれば苦労はしない。', '알면 고생하지 않는다.', 1),
    (w, 'やり方がわかれば簡単だ。', '하는 방법을 알면 간단하다.', 2);

  -- 1460. こうして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'こうして(2)', '이렇게', 'こうして 재활용', '문법-문맥이해', 1460, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうして見ると違う。', '이렇게 보면 다르다.', 1),
    (w, 'こうして長い時間が過ぎた。', '이렇게 긴 시간이 흘렀다.', 2);

  -- 1461. 命じられたことである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '命じられたことである', 'めいじられたことである', '명령을 받았던 것이다', '命(목숨 명)じる+수동+ことである. 격식 결론', '문법-문맥이해', 1461, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは王様に命じられたことである。', '그것은 왕에게 명령받았던 것이다.', 1),
    (w, '上司に命じられたことである。', '상사에게 명령받았던 것이다.', 2);

  -- 1462. 日本地図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '日本地図', 'にほんちず', '일본 지도', '日本+地(땅 지)+図(그림 도)', '문법-문맥이해', 1462, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本地図を見ながら計画する。', '일본 지도를 보면서 계획한다.', 1),
    (w, '日本地図には47都道府県がある。', '일본 지도에는 47개 도도부현이 있다.', 2);

  -- 1463. ご存じでしょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'ご存じでしょうか', 'ごぞんじでしょうか', '알고 계신가요?', 'ご存じ+でしょうか. 매우 정중 의문', '문법-문맥이해', 1463, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道をご存じでしょうか。', '이 길을 아십니까?', 1),
    (w, '彼の連絡先をご存じでしょうか。', '그의 연락처를 알고 계신가요?', 2);

  -- 1464. そこで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そこで(2)', '그래서', 'そこで 재활용', '문법-문맥이해', 1464, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '困っていた。そこで助けを求めた。', '곤란했다. 그래서 도움을 요청했다.', 1),
    (w, 'そこで一つ質問だ。', '그래서 한 가지 질문이다.', 2);

  -- 1465. 得られるのだそうです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '得られるのだそうです', 'えられるのだそうです', '얻을 수 있는 것이라고 합니다', '得る+가능+のだ+そうです. 전문+설명', '문법-문맥이해', 1465, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '良い結果が得られるのだそうです。', '좋은 결과를 얻을 수 있다고 합니다.', 1),
    (w, '無料で得られるのだそうです。', '무료로 얻을 수 있는 것이라고 합니다.', 2);

  -- 1466. 気になるもの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '気になるもの', 'きになるもの', '신경 쓰이는 것', '気+になる+もの. 관심 대상', '문법-문맥이해', 1466, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気になるものがある。', '신경 쓰이는 것이 있다.', 1),
    (w, '気になるものを見つけた。', '신경 쓰이는 것을 발견했다.', 2);

  -- 1467. そこで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そこで(3)', '그래서', 'そこで 재활용', '문법-문맥이해', 1467, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そこで提案がある。', '그래서 제안이 있다.', 1),
    (w, '雨が降った。そこで予定を変えた。', '비가 왔다. 그래서 예정을 바꿨다.', 2);

  -- 1468. この取り組みは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'この取り組みは', 'このとりくみは', '이 대책은, 이 노력은', '取り組み. 사회 활동/사업', '문법-문맥이해', 1468, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この取り組みは全国に広がっている。', '이 대책은 전국으로 퍼지고 있다.', 1),
    (w, 'この取り組みは成功した。', '이 노력은 성공했다.', 2);

  -- 1469. 期待できるそうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '期待できるそうだ', 'きたいできるそうだ', '기대할 수 있다고 한다', '期(기약할 기)待+できる+そうだ(전문)', '문법-문맥이해', 1469, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '効果が期待できるそうだ。', '효과를 기대할 수 있다고 한다.', 1),
    (w, '今後の成長が期待できるそうだ。', '향후 성장을 기대할 수 있다고 한다.', 2);

  -- 1470. 思えなかったからだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '思えなかったからだ', 'おもえなかったからだ', '생각하지 못했기 때문이다', '思える(가능)+なかった+から+だ. 가능 부정 이유', '문법-문맥이해', 1470, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まさかと思えなかったからだ。', '설마라고 생각하지 못했기 때문이다.', 1),
    (w, '当然と思えなかったからだ。', '당연하다고 생각하지 못했기 때문이다.', 2);

  -- 1471. ところが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'ところが', '그런데, 그러나', '所(ところ)+が. 의외 역접', '문법-문맥이해', 1471, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ところが、結果は違った。', '그런데 결과는 달랐다.', 1),
    (w, '行くつもりだった。ところが急用ができた。', '갈 생각이었다. 그런데 급한 일이 생겼다.', 2);

  -- 1472. 楽しむものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '楽しむものだ', 'たのしむものだ', '즐기는 것이다', '楽(즐길 락)しむ+もの+だ. 당위', '문법-문맥이해', 1472, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生は楽しむものだ。', '인생은 즐기는 것이다.', 1),
    (w, '旅は楽しむものだ。', '여행은 즐기는 것이다.', 2);

  -- 1473. どんな表現
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'どんな表現', 'どんなひょうげん', '어떤 표현', 'どんな+表(겉 표)現. 의문', '문법-문맥이해', 1473, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんな表現を使うか考える。', '어떤 표현을 쓸지 생각한다.', 1),
    (w, 'どんな表現が適切だろうか。', '어떤 표현이 적절할까.', 2);

  -- 1474. 増えてきました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '増えてきました', 'ふえてきました', '늘어왔습니다, 늘어났습니다', '増える+てくる+ました. 과거부터의 증가', '문법-문맥이해', 1474, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近、外国人が増えてきました。', '최근 외국인이 늘어났습니다.', 1),
    (w, '冬が近づいて寒い日が増えてきました。', '겨울이 다가오며 추운 날이 늘어왔습니다.', 2);

  -- 1475. ところが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'ところが(2)', '그런데, 그러나', 'ところが 재활용', '문법-문맥이해', 1475, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡単と思った。ところが難しかった。', '쉽다고 생각했다. 그런데 어려웠다.', 1),
    (w, 'ところが、誰も来なかった。', '그런데 아무도 안 왔다.', 2);

  -- 1476. 同じ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '同じ', 'おなじ', '같은', '同(한가지 동). 동일성', '문법-문맥이해', 1476, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同じ意見だ。', '같은 의견이다.', 1),
    (w, '同じものを買った。', '같은 것을 샀다.', 2);

  -- 1477. 問題である
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '問題である', 'もんだいである', '문제이다', '問題+である. 문어체 단정', '문법-문맥이해', 1477, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは大きな問題である。', '이것은 큰 문제이다.', 1),
    (w, '時間管理が問題である。', '시간 관리가 문제이다.', 2);

  -- 1478. このような駐輪場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'このような駐輪場', 'このようなちゅうりんじょう', '이러한 자전거(를 세워) 두는 곳', '駐(머무를 주)輪(바퀴 륜)場(마당 장)', '문법-문맥이해', 1478, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このような駐輪場が増えている。', '이런 자전거 주차장이 늘고 있다.', 1),
    (w, 'このような駐輪場は便利だ。', '이런 자전거 주차장은 편리하다.', 2);

  -- 1479. ～するために～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～するために～', '~하기 위해서', 'する+ために. 목적', '문법-문맥이해', 1479, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康になるために運動する。', '건강해지기 위해 운동한다.', 1),
    (w, '勝つために練習する。', '이기기 위해 연습한다.', 2);

  -- 1480. ～といっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～といっても(3)', '~라고 해도', 'といっても 재활용', '문법-문맥이해', 1480, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理といっても簡単なものだ。', '요리라고 해도 간단한 것이다.', 1),
    (w, '雨といっても少しだけだ。', '비라고 해도 조금일 뿐이다.', 2);

  -- 1481. ～されています
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～されています', '~로 여겨지고 있습니다', '수동+ている+ます. 사회적 통념', '문법-문맥이해', 1481, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは安全だとされています。', '이것은 안전하다고 여겨지고 있습니다.', 1),
    (w, 'その本は名作とされています。', '그 책은 명작으로 여겨지고 있습니다.', 2);

  -- 1482. そのため
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'そのため', '그 때문에', 'その+ため. 결과 접속사', '문법-문맥이해', 1482, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雪が積もった。そのため電車が止まった。', '눈이 쌓였다. 그 때문에 전철이 멈췄다.', 1),
    (w, 'そのため、計画を変更した。', '그 때문에 계획을 변경했다.', 2);

  -- 1483. いいものだと思いました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'いいものだと思いました', 'いいものだとおもいました', '좋다고 생각했습니다', 'いい+ものだ+と思う+ました. 감상 표현', '문법-문맥이해', 1483, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは本当にいいものだと思いました。', '이건 정말 좋다고 생각했습니다.', 1),
    (w, '便利でいいものだと思いました。', '편리해서 좋다고 생각했습니다.', 2);

  -- 1484. 実は
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '実は(2)', 'じつは', '실은', '実は 재활용', '문법-문맥이해', 1484, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実は知っていた。', '실은 알고 있었다.', 1),
    (w, '実は彼が来ていた。', '실은 그가 와 있었다.', 2);

  -- 1485. (부담을)주는 경우도 있습니다
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '(負担を)与える場合もあります', 'あたえるばあいもあります', '(부담을) 주는 경우도 있습니다', '与える(주다)+場合もあります. 가능 사례', '문법-문맥이해', 1485, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '負担を与える場合もあります。', '부담을 주는 경우도 있습니다.', 1),
    (w, '影響を与える場合もあります。', '영향을 주는 경우도 있습니다.', 2);

  -- 1486. 疲れてしまっては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '疲れてしまっては', 'つかれてしまっては', '지쳐버리면', '疲れる+てしまう+ては. 부정적 가정', '문법-문맥이해', 1486, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れてしまっては元も子もない。', '지쳐버리면 본전도 못 챙긴다.', 1),
    (w, 'もう疲れてしまってはどうしようもない。', '이미 지쳐버려서 어쩔 수 없다.', 2);

  -- 1487. そんな紅葉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'そんな紅葉', 'そんなこうよう', '그런 단풍', 'そんな+紅葉(단풍). 지시', '문법-문맥이해', 1487, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな紅葉を一度見たい。', '그런 단풍을 한 번 보고 싶다.', 1),
    (w, 'そんな紅葉に感動した。', '그런 단풍에 감동했다.', 2);

  -- 1488. しかし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, 'しかし(2)', '그러나', 'しかし 재활용', '문법-문맥이해', 1488, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しかし、現実は厳しい。', '그러나 현실은 가혹하다.', 1),
    (w, 'しかし、続けるしかない。', '그러나 계속할 수밖에 없다.', 2);

  -- 1489. はじまらないのです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '始まらないのです', 'はじまらないのです', '시작되지 않는 것입니다', '始まる+ない+のです. 설명/단정', '문법-문맥이해', 1489, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何も始まらないのです。', '아무것도 시작되지 않는 것입니다.', 1),
    (w, 'やる気がないと始まらないのです。', '의욕이 없으면 시작되지 않는 것입니다.', 2);

  -- 1490. 感じるようになりました
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '感じるようになりました', 'かんじるようになりました', '느끼게 되었습니다', '感じる+ようになる+ました. 변화', '문법-문맥이해', 1490, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最近、寒さを感じるようになりました。', '최근 추위를 느끼게 되었습니다.', 1),
    (w, '責任を感じるようになりました。', '책임을 느끼게 되었습니다.', 2);

  -- 1491. 例えば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '例えば(2)', 'たとえば', '예를 들면', '例えば 재활용', '문법-문맥이해', 1491, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '例えば、こんな問題がある。', '예를 들면 이런 문제가 있다.', 1),
    (w, '例えば、料理が好きだ。', '예를 들면 요리가 좋다.', 2);

  -- 1492. ～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, NULL, '～も', '~도', '병렬·첨가 조사 も', '문법-문맥이해', 1492, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私も行く。', '나도 간다.', 1),
    (w, '彼も知っている。', '그도 알고 있다.', 2);

  -- 1493. 感動していた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, '感動していた', 'かんどうしていた', '감동했었다', '感動する+ていた. 과거의 감동 상태 지속', '문법-문맥이해', 1493, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の演説に感動していた。', '그의 연설에 감동했었다.', 1),
    (w, '景色に感動していた。', '경치에 감동했었다.', 2);

  -- 1494. やってみて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n2, 'やってみて', 'やってみて', '해 보고', 'やる+てみる+て. 시도 후 결과', '문법-문맥이해', 1494, array['grammar','jlpt_n2']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やってみて初めてわかった。', '해 보고 비로소 알았다.', 1),
    (w, 'やってみて損はない。', '해 봐서 손해는 없다.', 2);

end $$;
