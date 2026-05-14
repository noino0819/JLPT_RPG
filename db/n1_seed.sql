-- ============================================================
-- JLPT N1 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N1-단어장)
-- ============================================================
-- 실행 시 기존 N1 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 805단어, 1610예문 (단어당 의미·한자어원·예문 2개씩)
-- ============================================================

delete from public.words
where deck_id in (
  select id from public.decks
  where is_official and jlpt_level = 'N1'
);

do $$
declare
  d_n1 uuid;
  w   uuid;
begin
  select id into d_n1
  from public.decks
  where is_official and jlpt_level = 'N1'
  limit 1;

  -- 1. 潤う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '潤う', 'うるおう', '(1) 축축해지다 (2) 윤택해지다', '潤(불을 윤): 氵(물 수) + 閏(윤달 윤) → 물기가 스며들어 풍족해짐\n자동사로 ''(물기·이익이) 늘어나다''의 의미로 발전', '동사', 1) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨で田畑が潤った。', '비로 논밭이 촉촉해졌다.', 1),
    (w, '観光客の増加で町が潤う。', '관광객 증가로 마을이 윤택해진다.', 2);

  -- 2. 極めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '極めて', 'きわめて', '매우, 지극히', '極(다할 극): 木(나무) + 亟(빠를 극) → 끝까지 다다르다\n부사형 ''きわめて''는 ''이 이상 없을 정도로''의 의미', '부사', 2) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは極めて重要な問題だ。', '이것은 매우 중요한 문제다.', 1),
    (w, '結論を出すのは極めて難しい。', '결론을 내리기는 지극히 어렵다.', 2);

  -- 3. 契約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '契約', 'けいやく', '계약', '契(맺을 계): 칼로 새겨 약속을 표시함\n約(맺을 약): 糸(실)을 묶어 약속을 잊지 않게 함', '명사', 3) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来月、新しい家の契約をする。', '다음 달에 새 집 계약을 한다.', 1),
    (w, '契約書にサインしてください。', '계약서에 서명해 주세요.', 2);

  -- 4. 推理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '推理', 'すいり', '추리', '推(밀 추): 扌(손)으로 밀어 나아가게 함 → 미루어 헤아림\n理(다스릴 리): 玉(구슬)의 결을 따라 다듬다 → 이치, 도리', '명사', 4) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の推理はいつも鋭い。', '그의 추리는 항상 날카롭다.', 1),
    (w, '推理小説を読むのが趣味だ。', '추리 소설을 읽는 것이 취미다.', 2);

  -- 5. 壊す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '壊す', 'こわす', '부수다, 망가뜨리다', '壊(무너질 괴): 土(흙) + 褱(품을 회) → 흙이 품을 잃고 무너짐\n타동사 ''こわす''는 의도적으로 무너뜨림을 의미', '동사', 5) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟が私のおもちゃを壊した。', '동생이 내 장난감을 부쉈다.', 1),
    (w, '無理をして体を壊さないで。', '무리해서 몸을 망가뜨리지 마.', 2);

  -- 6. 締める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '締める', 'しめる', '(끈을) 매다, 조이다', '締(맺을 체): 糸(실) + 帝(임금 제) → 실로 단단히 묶음\n끈·매듭을 강하게 조이는 동작을 가리킴', '동사', 6) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴ひもをしっかり締める。', '신발끈을 단단히 맨다.', 1),
    (w, '気を引き締めて仕事に臨む。', '마음을 다잡고 일에 임한다.', 2);

  -- 7. 手薄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手薄', 'てうす', '허술한, 불충분한', '手(손 수): 사람의 손 모양 → 인력·자원을 의미\n薄(엷을 박): 草(풀) + 溥(넓을 부) → 얇고 부족함', 'な형용사', 7) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜は警備が手薄になる。', '밤에는 경비가 허술해진다.', 1),
    (w, '人手が手薄で対応できない。', '일손이 부족해서 대응할 수 없다.', 2);

  -- 8. 練る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '練る', 'ねる', '반죽하다, (계획·문장을) 다듬다', '練(익힐 련): 糸(실) + 柬(가릴 간) → 실을 거듭 다듬어 정련함\n반복하여 단련·정련하는 의미로 확장', '동사', 8) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小麦粉と水をよく練る。', '밀가루와 물을 잘 반죽한다.', 1),
    (w, '計画を練り直す必要がある。', '계획을 다시 다듬을 필요가 있다.', 2);

  -- 9. 華々しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '華々しい', 'はなばなしい', '화려하다', '華(빛날 화): 꽃이 활짝 핀 모양 → 화려함\n반복형 ''華々''로 강조되어 ''매우 화려함''을 표현', 'い형용사', 9) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は華々しいデビューを飾った。', '그녀는 화려한 데뷔를 장식했다.', 1),
    (w, '華々しい活躍を見せた選手。', '화려한 활약을 보여준 선수.', 2);

  -- 10. 繁盛
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '繁盛', 'はんじょう', '번성, 번창', '繁(번성할 번): 糸(실) + 敏(민첩할 민) → 실이 무성하게 자람\n盛(성할 성): 皿(그릇)에 가득 차오름 → 왕성함', '명사', 10) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商売が繁盛している。', '장사가 번창하고 있다.', 1),
    (w, 'この店はいつも繁盛している。', '이 가게는 항상 번성하고 있다.', 2);

  -- 11. 伴奏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '伴奏', 'ばんそう', '반주', '伴(짝 반): 亻(사람) + 半(반) → 사람과 함께·짝으로\n奏(아될 주): 양손으로 악기를 바쳐 소리를 내는 모양', '명사', 11) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノ伴奏で歌を歌う。', '피아노 반주로 노래를 부른다.', 1),
    (w, '彼女はバイオリン伴奏を担当した。', '그녀는 바이올린 반주를 담당했다.', 2);

  -- 12. 本筋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '本筋', 'ほんすじ', '본론, 본 줄거리', '本(근본 본): 木(나무) 아래에 표시 → 릌리, 근본\n筋(힘줄 근): 竹(대나무) + 肋(고기 육) → 근육·줄기', '명사', 12) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が本筋からそれた。', '이야기가 본론에서 벗어났다.', 1),
    (w, '本筋に戻って議論しよう。', '본론으로 돌아가서 논의하자.', 2);

  -- 13. 閲覧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '閲覧', 'えつらん', '열람', '閲(검열할 열): 門(문) + 兌(달 열) → 문으로 들여보며 살핌\n覧(볼 람): 臣(신하) + 見(볼 견) → 넓게 둘러보다', '명사', 13) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料の閲覧は無料です。', '자료 열람은 무료입니다.', 1),
    (w, '図書館で古い新聞を閲覧した。', '도서관에서 오래된 신문을 열람했다.', 2);

  -- 14. 合併
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '合併', 'がっぺい', '합병', '合(합할 합): 人(사람)·口(입)이 합쳐짐 → 하나로 모임\n併(아우를 병): 亻(사람) + 并(나란히 병) → 사람을 나란히 세움', '명사', 14) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '企業同士の合併が発表された。', '기업 간 합병이 발표되었다.', 1),
    (w, '両社の合併で規模が拡大した。', '두 회사의 합병으로 규모가 확대되었다.', 2);

  -- 15. 肝心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '肝心', 'かんじん', '중요함, 가장 중요한 점', '肝(간 간): 肉(고기 육) + 干(방패 간) → 내장의 핵심\n心(마음 심): 심장의 모양 → 마음·핵심의 의미', 'な형용사', 15) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肝心なときに彼はいない。', '중요한 때에 그는 없다.', 1),
    (w, '肝心なのは人の心だ。', '가장 중요한 것은 사람의 마음이다.', 2);

  -- 16. 兆し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '兆し', 'きざし', '징조, 조짐', '兆(조지·억 조): 거북 등껍이 갈라진 모양 → 점치고 조짐\n「兆し」는 미리 나타나는 조짐·징후를 의미', '명사', 16) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '回復の兆しが見えてきた。', '회복의 조짐이 보이기 시작했다.', 1),
    (w, '春の兆しを感じる頃だ。', '봄의 징조를 느끼는 때금이다.', 2);

  -- 17. 考慮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '考慮', 'こうりょ', '고려', '考(생각할 고): 老(닅을 로)의 변형 → 깊이 생각함\n慮(생각할 려): 虍(호랑이) + 思(생각) → 조심스럽게 살핌', '명사', 17) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それも考慮に入れて決めよう。', '그것도 고려해서 결정하자.', 1),
    (w, '予算を考慮して計画を立てる。', '예산을 고려해서 계획을 세운다.', 2);

  -- 18. 根拠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '根拠', 'こんきょ', '근거', '根(뿌리 근): 木(나무) + 艮(어길 간) → 나무의 뿌리\n拠(근거 거): 手(손) + 虔(웅활 거) → 손으로 의지함', '명사', 18) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その主張には根拠がない。', '그 주장에는 근거가 없다.', 1),
    (w, '科学的な根拠に基づく説明だ。', '과학적 근거에 근거한 설명이다.', 2);

  -- 19. 遮る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '遮る', 'さえぎる', '차단하다', '遮(가릴 차): 辶(갈 착) + 庶(여러 서) → 여러 것을 가로막음\n빛·시야 등을 가로막는 동작을 나타냄', '동사', 19) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーテンで光を遮る。', '커튼으로 빛을 차단한다.', 1),
    (w, '大きなビルが視界を遮った。', '큰 빌딩이 시야를 가렸다.', 2);

  -- 20. 釈明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '釈明', 'しゃくめい', '석명, 해명', '釈(풀 석): 釆(분별할 변) + 尺(자 척) → 하나하나 분별해 풀이\n明(밝을 명): 日(해) + 月(달) → 밝게 드러냄', '명사', 20) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代表が釈明を述べた。', '대표가 해명을 내놓았다.', 1),
    (w, '誤解について釈明する必要がある。', '오해에 대해 해명할 필요가 있다.', 2);

  -- 21. 鈍る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '鈍る', 'にぶる', '둔해지다, 무디어지다', '鈍(둔할 둔): 金(쇠) + 屯(진 칠 둔) → 쇠가 무던\n감각·날카로움이 떨어진 상태를 표현', '동사', 21) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れで動きが鈍る。', '피로로 움직임이 둔해진다.', 1),
    (w, '老化で感覚が鈍る。', '노화로 감각이 무디어진다.', 2);

  -- 22. 逃れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '逃れる', 'のがれる', '벗어나다, 피하다', '逃(도망칠 도): 辶(갈 착) + 兆(조짐 조) → 조짐을 보고 도망감\n자동사 형태로 위험·곤란에서 벗어남을 나타냄', '동사', 22) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '越哈して責任を逃れた。', '어제그저로 책임을 피했다.', 1),
    (w, '危険から逃れるために走る。', '위험에서 벗어나기 위해 달린다.', 2);

  -- 23. 漠然と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '漠然と', 'ばくぜんと', '막연하게', '漠(넘을 막): 氵(물) + 莫(없을 막) → 물이 없는 사막\n然(그럴 연): 犬(개)의 고기를 태움 → 상태 보조사', '부사', 23) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来について漠然と考える。', '미래에 대해 막연하게 생각한다.', 1),
    (w, '不安が漠然と広がる。', '불안이 막연히 퍼진다.', 2);

  -- 24. 利益
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '利益', 'りえき', '이익', '利(이로울 리): 禾(벼) + 刂(칼) → 칼로 벼를 베어 이득\n益(더할 익): 水(물)이 皿(그릇)에 넘침 → 넘치는 이득', '명사', 24) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今期の利益は上がった。', '이번 분기의 이익이 올랐다.', 1),
    (w, '会社の利益より顧客の利益を優先する。', '회사 이익보다 고객의 이익을 우선한다.', 2);

  -- 25. 改革
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '改革', 'かいかく', '개혁', '改(고칠 개): 己(자기) + 攵(칠 복) → 자기를 채챍질하여 고침\n革(가죽 혁): 짐승의 가죽을 벴겨냄 → 완전히 바꿈', '명사', 25) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政治の改革が求められる。', '정치의 개혁이 요구된다.', 1),
    (w, '教育制度の改革が進んでいる。', '교육 제도의 개혁이 진행되고 있다.', 2);

  -- 26. 覆す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '覆す', 'くつがえす', '뒤집어엎다', '覆(뒤집힐 복): 西(다듰 아·덮을 아) + 復(되돌아갈 복) → 덮여있던 것을 뒤집음\n임박이나 설을 뒤바꾸는 의미로 확장', '동사', 26) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '説を覆す証拠が見つかった。', '설을 뒤집을 증거가 발견되었다.', 1),
    (w, '下位チームが預想を覆した。', '하위 팀이 예상을 뒤집었다.', 2);

  -- 27. 克明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '克明', 'こくめい', '극명함', '克(이길 극): ジ(입) + 儿(사람) → 힘들게 이겨냄\n明(밝을 명): 日(해) + 月(달) → 밝게 환하게', 'な형용사', 27) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を克明に記録する。', '상황을 극명하게 기록한다.', 1),
    (w, '現場の様子が克明に描かれている。', '현장의 모습이 극명하게 그려져 있다.', 2);

  -- 28. 群衆
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '群衆', 'ぐんしゅう', '군중', '群(무리 군): 君(임금) + 羊(양) → 양떼처럼 모임\n衆(무리 중): 血(피) + 众(무리) → 많은 사람이 모임', '명사', 28) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '群衆の中で迷子になった。', '군중 속에서 미아가 되었다.', 1),
    (w, '群衆心理が事件を拡大させた。', '군중심리가 사건을 확대시켰다.', 2);

  -- 29. 心地よい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '心地よい', 'ここちよい', '기분 좋다, 상쿨하다', '心地(ここち): 마음(心) + 장소(地) → 마음의 상태·기분\n''よい(좋다)''가 붙어 ''기분이 좋다''의 의미', 'い형용사', 29) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春の風が心地よい。', '봄바람이 상쿨하다.', 1),
    (w, 'このソファは座り心地がよい。', '이 소파는 앉는 기분이 좋다.', 2);

  -- 30. 費やす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '費やす', 'ついやす', '사용하다, 소비하다', '費(쓸 비): 貝(조개) + 弗(아닐 불) → 재물을 쓴\n타동사 형태로 시간·돈·노력을 소비하는 의미', '동사', 30) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多くの時間を費やした。', '많은 시간을 소비했다.', 1),
    (w, '計画に費やした努力が実を結んだ。', '계획에 쓸움었던 노력이 결실을 맺었다.', 2);

  -- 31. 手際
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手際', 'てぎわ', '일처리 솨씨, 수완', '手(손 수): 손으로 일을 다루는 기술\n際(가 제): 阜(언덕) + 祭(제사 제) → 경계·타이밍이 적절함', '명사', 31) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの人の仕事の手際は見事だ。', '그 사람의 일처리 솨씨는 훌륭하다.', 1),
    (w, '手際よく会議を進めた。', '수완 좋게 회의를 진행했다.', 2);

  -- 32. 踏襲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '踏襲', 'とうしゅう', '답습', '踏(밟을 답): 足(발) + ⊣(구임서 답) → 발로 밟음\n襲(엄습할 습): 龍(용) + 衣(옷) → 이전 것을 그대로 겹쳐 입음', '명사', 32) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先代の方針を踏襲する。', '선대의 방침을 답습한다.', 1),
    (w, '伝統を踏襲しつつ革新を図る。', '전통을 답습하면서 혁신을 추구한다.', 2);

  -- 33. 名誉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '名誉', 'めいよ', '명예', '名(이름 명): 夕(저녁) + 口(입) → 어둡는데 입으로 이름을 부름\n誉(기릴 예): 言(말) + 與(더불을 여) → 칭찬하는 말을 주고받음', '명사', 33) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の名誉を守る。', '회사의 명예를 지킨다.', 1),
    (w, 'それは君にとって名誉なことだ。', '그것은 너에게 명예로운 일이다.', 2);

  -- 34. 網羅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '網羅', 'もうら', '망라', '網(그물 망): 糸(실) + 罔(부르짖어 망) → 그물\n羅(벌라일 라): 罔(그물) + 絭(비단) → 그물로 새를 잡는 모양', '명사', 34) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この辞書は同義語を網羅している。', '이 사전은 동의어를 망라하고 있다.', 1),
    (w, '總務は事務作業を網羅する。', '총무는 사무작업을 망라한다.', 2);

  -- 35. 由緒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '由緒', 'ゆいしょ', '유서, 내력', '由(말미암을 유): 경공으로 이어진 골 → 이때됩·원인\n緒(실마리 서): 糸(실) + 者(놈 자) → 실의 끝·단서', '명사', 35) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この寺には長い由緒がある。', '이 절에는 오랜 유서가 있다.', 1),
    (w, '由緒ある家柄に生まれた。', '내력 있는 가문에서 태어났다.', 2);

  -- 36. 枠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '枠', 'わく', '틀, 테두리', '枠(틀 와): 木(나무) + 詶(차머리 괄) → 나무로 둘레세운 틀\n경계·한계·틀을 나타내는 명사로 사용', '명사', 36) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予算の枠を超える。', '예산의 틀을 넘어선다.', 1),
    (w, '常識の枠に囚われる。', '상식의 틀에 사로잡힌다.', 2);

  -- 37. 跡地
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '跡地', 'あとち', '철거 부지', '跡(발자취 적): 足(발) + 亦(또 역) → 발자국·흔적\n地(땅 지): 土(흥) + 也(이끌 야) → 면적·터', '명사', 37) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '跡地に新しいビルが建つ。', '철거 부지에 새 빌딩이 세워진다.', 1),
    (w, '広い跡地を公園に生まれ変わらせる。', '넓은 철거 부지를 공원으로 탈바꿔움시킨다.', 2);

  -- 38. 憤り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '憤り', 'いきどおり', '분노', '憤(텔 분): 心(마음) + 賁(클 분) → 마음이 크게 일레다\n명사형 ''憤り''는 특히 강한 분노·분개의 감정', '명사', 38) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '憤りを抱きながら手紙を書いた。', '분노를 품으며 편지를 썼다.', 1),
    (w, '不正に対する憤りが加わった。', '부정에 대한 분노가 더해졌다.', 2);

  -- 39. 憩い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '憩い', 'いこい', '휴식', '憩(쉬 게): 息(숲 식) + 心(마음) → 숨을 고르며 마음을 쉬게함\n명사형 ''憩い''는 편안한 휴식의 의미', '명사', 39) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園は市民の憩いの場だ。', '공원은 시민의 휴식의 장이다.', 1),
    (w, '里山で静かな憩いの一時を過ごす。', '시골에서 고요한 휴식의 시간을 보낸다.', 2);

  -- 40. 愚かな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '愚かな', 'おろかな', '어리석은', '愚(어리석을 우): 禹(원숭이 우) + 心(마음) → 마음이 원숭이처럼 어린석음\n「おろかな」는 생각이 얖은 상태를 표현', 'な형용사', 40) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな愚かなことを言うな。', '그런 어리석은 말을 하지 마라.', 1),
    (w, '愚かな判断をして後悔した。', '어리석은 판단을 해서 후회했다.', 2);

  -- 41. 緩和
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '緩和', 'かんわ', '완화', '緩(느릴 완): 糸(실) + 援(도울 원) → 실을 느슨하게 하여 완화함\n和(화할 화): 禾(벼) + 口(입) → 먹을 것을 움키면 평온해짐', '명사', 41) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規制の緩和が期待される。', '규제의 완화가 기대된다.', 1),
    (w, '緊張を緩和させる音楽だ。', '긴장을 완화시키는 음악이다.', 2);

  -- 42. 巧妙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '巧妙', 'こうみょう', '교묘함', '巧(공교할 교): 工(장인) + 丕(소리날 키) → 장인의 솨씨가 뛰어남\n妙(묘할 묘): 女(여자) + 少(적을 소) → 세밀하고 아름다움', 'な형용사', 42) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '巧妙な手口でただまされた。', '교묘한 수법으로 속았다.', 1),
    (w, '巧妙な仕掛けがある装置だ。', '교묘한 장치가 있는 장비다.', 2);

  -- 43. 趣旨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '趣旨', 'しゅし', '취지', '趣(뚜 취): 走(달릴 주) + 取(취할 취) → 너계서 취함 → 흥미·뚜\n旨(뜻 지): 旦(아침 단) + 口(입) → 주된 뜻', '명사', 43) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会の趣旨を説明した。', '모임의 취지를 설명했다.', 1),
    (w, 'ご趣旨に賛同いたします。', '취지에 찬동합니다.', 2);

  -- 44. 需要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '需要', 'じゅよう', '수요', '需(쓰일 수): 雨(비) + 而(말 이을 이) → 비가 올 때까지 기다림\n要(요긴할 요): 西(서띞 서) + 女(여자) → 소중하게 구함', '명사', 44) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気自動車の需要が增えている。', '전기차의 수요가 늘고 있다.', 1),
    (w, '需要と供給のバランスが重要だ。', '수요와 공급의 밸런스가 중요하다.', 2);

  -- 45. 貫く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '貫く', 'つらぬく', '관철하다', '貫(꾰을 관): 毌(꾸러미) + 貝(조개) → 조개를 꾰어 임\n난관·의지를 끝까지 관철한다는 동사로 사용', '동사', 45) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初志を貫いて頂上に辿り着いた。', '초지일관으로 정상에 도착했다.', 1),
    (w, '自分の道を貫いて生きる。', '자기의 길을 관철하며 산다.', 2);

  -- 46. 日夜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '日夜', 'にちや', '밤낮, 늘', '日(날 일): 해의 모양 → 낮\n夜(밤 야): 多(많을 다의 변형) + 夕(저녁) → 해가 진 뒤', '명사', 46) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日夜努力している。', '밤낮으로 노력하고 있다.', 1),
    (w, '日夜の区別なく働く。', '밤낮 구별 없이 일한다.', 2);

  -- 47. 把握
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '把握', 'はあく', '파악', '把(잡을 파): 手(손) + 巴(큰 뱀 파) → 손으로 꿉 잡음\n握(쥐조그리 악): 手(손) + 屋(집 옥) → 손 안에 넣음', '명사', 47) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を正確に把握する。', '상황을 정확히 파악한다.', 1),
    (w, '代表は現状を把握している。', '대표는 현상황을 파악하고 있다.', 2);

  -- 48. 貧富
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '貧富', 'ひんぷ', '빈부', '貧(가난할 빈): 分(나눌 분) + 貝(조개) → 재산을 나눌어 적음\n富(부자 부): 宀(집) + 畑(가득할 복) → 집에 재물이 가득', '명사', 48) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貧富の差が拡大している。', '빈부의 차가 확대되고 있다.', 1),
    (w, '貧富に関わらず教育は重要だ。', '빈부와 상관없이 교육은 중요하다.', 2);

  -- 49. 否めない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '否めない', 'いなめない', '부정할 수 없다', '否(아닐 부): 不(아니울 불) + 口(입) → 아니라고 말함\n「否む(부정하다)」의 가능 형태가 부정되는 구조', '표현', 49) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の能力は否めない。', '그의 능력은 부정할 수 없다.', 1),
    (w, '影響を受けたことは否めない事実だ。', '영향을 받은 것은 부정할 수 없는 사실이다.', 2);

  -- 50. 概略
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '概略', 'がいりゃく', '개략', '概(대략 개): 木(나무) + 既(이미 기) → 대제 이미 정해진 틀\n略(간략할 략): 田(밭) + 各(각각 각) → 조각·대략적', '명사', 50) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の内容を概略する。', '회의 내용을 개략한다.', 1),
    (w, '説明書の概略を記す。', '설명서의 개략을 적는다.', 2);

  -- 51. 凝縮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '凝縮', 'ぎょうしゅく', '응축', '凝(엉길 응): 冰(얼음) + 疑(의심할 의) → 굳게 엉김\n縮(줄일 축): 糸(실) + 宿(쟔 숙) → 실을 싁아서 짧게 함', '명사', 51) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の経験を凝縮した作品だ。', '오랜 경험을 응축한 작품이다.', 1),
    (w, 'スープを凝縮して濃い味にする。', '수프를 응축해서 진한 맛으로 한다.', 2);

  -- 52. 厳正
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '厳正', 'げんせい', '엄정함', '厳(엄할 엄): 口(입) + 厈(엄할 엄) → 편지게 말하고 엄격\n正(바를 정): 一(하나) + 止(멈춤) → 하나의 올바른 곳에 멈춤', 'な형용사', 52) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳正な審査を受ける。', '엄정한 심사를 받는다.', 1),
    (w, '厳正に規則を遵守させる。', '엄정하게 규칙을 준수시킨다.', 2);

  -- 53. 拒む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '拒む', 'こばむ', '거부하다', '拒(막을 거): 手(손) + 巨(클 거) → 손으로 크게 막음\n자동사 형태로 제안·요구를 막아 거절하는 의미', '동사', 53) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '提案を拒んだ理由を説明する。', '제안을 거부한 이유를 설명한다.', 1),
    (w, '彼は協力を拒んだ。', '그는 협력을 거부했다.', 2);

  -- 54. 遂行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '遂行', 'すいこう', '수행', '遂(드디어 수): 辶(갈 착) + 適(수달할 수) → 끝까지 이루어냄\n行(다닐 행): 그림자길의 모양 → 걸으며 일을 함', '명사', 54) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '任務を遂行するため努力する。', '임무를 수행하기 위해 노력한다.', 1),
    (w, '計画の遂行には資金が必要だ。', '계획의 수행에는 자금이 필요하다.', 2);

  -- 55. 健やか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '健やか', 'すこやか', '건강함', '健(굽셌 건): 亻(사람) + 建(세울 건) → 사람이 이른 굽셌\n고유어 ''すこやか''는 학아들이 강건하게 자라는 모습', 'な형용사', 55) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健やかに肉ている。', '건강하게 자라고 있다.', 1),
    (w, '健やかな身体を保つために運動する。', '건강한 몸을 유지하기 위해 운동한다.', 2);

  -- 56. 漂う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '漂う', 'ただよう', '떠돌다, 감돌다', '漂(떠다닐 표): 氵(물) + 票(표 표) → 물 위를 떠다닐\n향기·분위기가 공중에 감독는 모습에도 사용', '동사', 56) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '起源不明の漂流物が見つかった。', '출처 불명의 표류물이 발견되었다.', 1),
    (w, '気品のある香りが漂う。', '고품의 향기가 감돌고 있다.', 2);

  -- 57. 中枢
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '中枢', 'ちゅうすう', '중추', '中(가운데 중): 깃발에 꿰은 모양 → 가운데\n枢(쓜리목 추): 木(나무) + 区(지역 구) → 문 닫히 끌채·핵심', '명사', 57) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '都心部は経済の中枢だ。', '도심부는 경제의 중추다.', 1),
    (w, '組織の中枢を担う人物だ。', '조직의 중추를 담당하는 인물이다.', 2);

  -- 58. 督促
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '督促', 'とくそく', '독촉', '督(감독할 독): 叔(아저씨 숙) + 目(눈) → 눈으로 잘펴봄\n促(재촉할 촉): 亻(사람) + 足(발) → 사람을 쪻아 재촉함', '명사', 58) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未払い金の督促状が届いた。', '미지급금 독촉장이 도착했다.', 1),
    (w, '何度も督促したが返事がない。', '몇 번이나 독촉했지만 답장이 없다.', 2);

  -- 59. 臨む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '臨む', 'のぞむ', '임하다, (상황에) 직면하다', '臨(임할 임): 臣(신하) + 品(물건 품) → 아래를 내려다 본\n''임하다''·''직면하다''의 의미로 확장', '동사', 59) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危機に臨んで冷静さを保った。', '위기에 직면해서 냉정함을 유지했다.', 1),
    (w, '会議に臨む姿勢が重要だ。', '회의에 임하는 자세가 중요하다.', 2);

  -- 60. 躍進
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '躍進', 'やくしん', '약진', '躍(뛸 약): 足(발) + 羿(꿩 적) → 높이 뛰어오름\n進(나아갈 진): 辶(갈 착) + 隹(새 추) → 새처럼 앞으로 나아감', '명사', 60) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社は今年、躍進を遇げた。', '회사는 올해 약진을 이뤄냈다.', 1),
    (w, '躍進してトップ企業になった。', '약진해서 최고 기업이 되었다.', 2);

  -- 61. 値する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '値する', 'あたいする', '~할 가치가 있다', '値(값 치): 亻(사람) + 直(곧을 직) → 사람이 마땍하다고 판단\n동사화 ''する''이 붙어 「가치가 있다」의 의미', '동사', 61) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この作品は読むに値する。', '이 작품은 읽을 가치가 있다.', 1),
    (w, '彼の努力は評価に値する。', '그의 노력은 평가할 가치가 있다.', 2);

  -- 62. 淡い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '淡い', 'あわい', '연하다, 흐리다', '淡(묽을 담): 氵(물) + 炎(불타오를 염) → 물이 맑고 색이 얇음\n색조·맛·감정이 진하지 않은 상태를 표현', 'い형용사', 62) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その色は淡い青だ。', '그 색은 연한 파란이다.', 1),
    (w, '淡い期待を抱いていた。', '희미한 기대를 품고 있었다.', 2);

  -- 63. 画一的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '画一的', 'かくいつてき', '획일적인', '画一(그을 획 · 하나 일): 그은 듯이 똑같이 하나\n的(과녁 적): 白(흰) + 勺(숨을 드릴 석) → 성질·특징을 나타냄', 'な형용사', 63) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画一的な教育を見直す。', '획일적인 교육을 재검토한다.', 1),
    (w, '画一的なファッションを避ける。', '획일적인 패션을 피한다.', 2);

  -- 64. 興奋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '興奋', 'こうふん', '흥분', '興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 들어올림\n奋(떨칠 분): 大(클 대) + 隹(새 추) → 큰 새가 날개치게 할', '명사', 64) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合の勝利で興奋した。', '경기 승리로 흥분했다.', 1),
    (w, '興奋してやずれてしまった。', '흥분해서 잠을 설체고 말았다.', 2);

  -- 65. 慕われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '慕われる', 'したわれる', '추앙받다, 존경받다', '慕(그리워할 모): 莫(없을 막) + 心(마음) → 마음이 끌리는 마음\n수동형 ''したわれる''은 다른 사람에게 존경받는 것', '동사', 65) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多くの人に慕われる人物だ。', '많은 사람에게 존경받는 인물이다.', 1),
    (w, '彼は同僚から慕われている。', '그는 동료들에게 추앙받고 있다.', 2);

  -- 66. 承諾
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '承諾', 'しょうだく', '승낙', '承(이을 승): 以(당이울) + 口(입) + 手(손) → 이어받음\n諾(허락할 낙): 言(말) + 若(같을 약) → 그래도 좋다고 말함', '명사', 66) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の承諾を得る。', '상사의 승낙을 얻는다.', 1),
    (w, '提案は承諾された。', '제안이 승낙되었다.', 2);

  -- 67. 随時
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '随時', 'ずいじ', '수시로', '随(따를 수): 阜(언덕) + 左(왼 좌) + 辶(갈 착) → 따라감\n時(때 시): 日(해) + 寺(절) → 일정 시간·때마다', '부사', 67) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問は随時受け付ける。', '질문은 수시로 받는다.', 1),
    (w, '随時連絡してください。', '수시로 연락해 주세요.', 2);

  -- 68. 添付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '添付', 'てんぷ', '첨부', '添(더할 첨): 氵(물) + 涻(닭울 첨) → 물을 더 부음\n付(붙을 부): 亻(사람) + 寸(마디) → 손으로 건네주어 붙임', '명사', 68) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳細を添付ファイルで送った。', '상세를 첨부파일로 보냈다.', 1),
    (w, '領収書を添付してください。', '영수증을 첨부해 주세요.', 2);

  -- 69. 唱える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '唱える', 'となえる', '외치다, 주장하다', '唱(부를 창): 口(입) + 昌(창성할 창) → 입으로 소리 높이 부름\n주장·구호를 외치는 의미로 확장', '동사', 69) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境保護を唱える。', '환경 보호를 주장한다.', 1),
    (w, '彼は新しい理論を唱えた。', '그는 새로운 이론을 주장했다.', 2);

  -- 70. 励む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '励む', 'はげむ', '힘쓰다', '励(힘쓸 려): 厲(갈 려) + 力(힘) → 떠자하지 않고 힘을 다함\n명사형 ''励み''는 열일을 의미함', '동사', 70) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に励む姿勢が見事だ。', '일에 힘쓰는 자세가 훌륭하다.', 1),
    (w, '毎日勉強に励む学生だ。', '매일 공부에 힘쓰는 학생이다.', 2);

  -- 71. 破損
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '破損', 'はそん', '파손', '破(깨트릴 파): 石(돌) + 皮(가죽) → 돌이 가죽을 찢음\n損(덜 손): 手(손) + 員(관원) → 손으로 구성품을 덜어냄', '명사', 71) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車の破損状態がひどい。', '차의 파손 상태가 심하다.', 1),
    (w, '設備の破損を防ぐ為の対策をとる。', '설비의 파손을 막기 위해 대책을 세운다.', 2);

  -- 72. 変遷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '変遷', 'へんせん', '변천', '変(변할 변): 言(말) + 攵(칠 복) → 언론이 바뀌고 터지\n遷(옮길 천): 辶(갈 착) + 遷(옮길 천) → 이동·변화', '명사', 72) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時代の変遷をひしひしと感じる。', '시대의 변천을 절감한다.', 1),
    (w, '言語の変遷を記録した本だ。', '언어의 변천을 기록한 책이다.', 2);

  -- 73. 賢い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '賢い', 'かしこい', '뚜뚝하다', '賢(어질 현): 臣(신하) + 又(또 우) + 貝(조개) → 신하가 재물을 현명하게 다루어 어진 사람\n''かしこい''는 지혜롤움·영리함을 표현', 'い형용사', 73) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '賢い選択をした。', '현명한 선택을 했다.', 1),
    (w, 'この犬はとても賢い。', '이 개는 아주 뚜뚝하다.', 2);

  -- 74. 偏る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '偏る', 'かたよる', '치우치다, 편향되다', '偏(치우칠 편): 亻(사람) + 扁(낮을 편) → 낮고 한쪽으로 기웄\n자동사 형태로 교형이 깨져 한쪽으로 쪼림을 나타냄', '동사', 74) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が偏らないように気を付ける。', '의견이 치우치지 않도록 조심한다.', 1),
    (w, '食事が肉に偏りがちだ。', '식사가 육류에 치우치기 쉬운 편이다.', 2);

  -- 75. 鑑定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '鑑定', 'かんてい', '감정, 판정', '鑑(거울 감): 金(쇠) + 監(볼 감) → 쇠롯을 자세히 살핌\n定(정할 정): 宀(집) + 正(바를 정) → 집안을 바르게 정함', '명사', 75) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '骨董品を鑑定してもらう。', '골동품을 감정받는다.', 1),
    (w, '街で鑑定番組が人気だ。', '거리에서 감정 프로그램이 인기다.', 2);

  -- 76. 顕著
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '顕著', 'けんちょ', '현저함', '顕(나타날 현): 頁(머리) + 魯(멓이타조 권) → 환히 드러남\n著(나타날 저): 艸(풀) + 者(놈 자) → 뚜렷해 잘 보임', 'な형용사', 76) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '効果が顕著に現れた。', '효과가 현저하게 나타났다.', 1),
    (w, '顕著な進歩が見られる。', '현저한 진보가 보인다.', 2);

  -- 77. 樹木
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '樹木', 'じゅもく', '수목, 큰 나무', '樹(나무 수): 木(나무) + 設(베풀 등) → 세워서 기르는 나무\n木(나무 목): 나무의 모양', '명사', 77) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園に是々たる樹木がある。', '공원에 웅장한 수목이 있다.', 1),
    (w, '樹木の事だもれた町だ。', '수목이 우거진 도시다.', 2);

  -- 78. 人脈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '人脈', 'じんみゃく', '인맥', '人(사람 인): 사람이 서있는 모양\n脈(줄기 맥): 肉(고기 육) + 永(길 영) → 근육의 이어짐', '명사', 78) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事には人脈が重要だ。', '일에는 인맥이 중요하다.', 1),
    (w, '広い人脈を持つ人だ。', '넓은 인맥을 가진 사람이다.', 2);

  -- 79. 廃れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '廃れる', 'すたれる', '쇠퇴하다', '廃(폐할 폐): 广(집) + 発(핀 발) → 집이 버려져 무너짐\n자동사 형태로 운용·유행이 쓰이지 않게 됨을 의미', '동사', 79) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い風習が廃れている。', '오랜 풍습이 쇠퇴하고 있다.', 1),
    (w, 'この言い回しは廃れてしまった。', '이 표현은 쓰이지 않게 되어 버렸다.', 2);

  -- 80. 相場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '相場', 'そうば', '시세', '相(서로 상): 木(나무) + 目(눈) → 나무를 눈으로 자세히 봄 → 모습\n場(마당 장): 土(흥) + 够(해가 온어떨 양) → 택 트인 곳', '명사', 80) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金の相場が上がっている。', '금 시세가 오르고 있다.', 1),
    (w, '不動産の相場を調べる。', '부동산의 시세를 알아본다.', 2);

  -- 81. 多岐
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '多岐', 'たき', '다기, 다방면', '多(많을 다): 夕(저녁)이 거듭됨 → 많음\n岐(갈래길 기): 山(산) + 支(갈래질 지) → 여러 갈래길로 나닄', '명사', 81) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の趣味は多岐にわたる。', '그의 취미는 다방면에 걸친다.', 1),
    (w, '仕事の内容は多岐にわたっている。', '일의 내용은 다방면에 걸쳐있다.', 2);

  -- 82. 蓄える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '蓄える', 'たくわえる', '저축하다, 비축하다', '蓄(한은 축): 艸(풀) + 畜(가축 축) → 풀을 가축의 먹이로 쌓아둔\n재물·지식을 모아둔다는 의미로 확장', '동사', 82) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '老後のために貯金を蓄える。', '노후를 위해 저금을 저축한다.', 1),
    (w, 'エネルギーを蓄えて試合に臨む。', '에너지를 비축해서 경기에 임한다.', 2);

  -- 83. 陳列
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '陳列', 'ちんれつ', '진열', '陳(베풀 진): 阜(언덕) + 東(동녕 동) → 언덕에 가지런히 놓음\n列(벌일 렬): 歹(병에 걸릴 뱍) + 刂(칼) → 줄지어 벌임', '명사', 83) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新商品を棚に陳列した。', '신상품을 선반에 진열했다.', 1),
    (w, '陳列棚が見易いように設計された。', '진열대가 보기 쉬게 설계되었다.', 2);

  -- 84. 華やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '華やかな', 'はなやかな', '화려한', '華(빛날 화): 꽃이 활짝 핀 모양\n''はなやか」는 빛·색·소리가 돋보이는 상태를 표현', 'な형용사', 84) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '華やかなドレスを着てパーティーに出た。', '화려한 드레스를 입고 파티에 갔다.', 1),
    (w, 'はなやかな雰囲気のホテルだ。', '화려한 분위기의 호텔이다.', 2);

  -- 85. 潤す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '潤す', 'うるおす', '적시다, 축축하게 하다', '潤(불을 윤): 氵(물) + 閏(윤달 윤) → 물기를 더함\n타동사로 ''うるおす''는 적셔 서서히 함', '동사', 85) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春の雨が大地を潤す。', '봄비가 대지를 적신다.', 1),
    (w, '言葉が心を潤した。', '말이 마음을 촉촉하게 적심다.', 2);

  -- 86. 傾斜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '傾斜', 'けいしゃ', '경사, 기울기', '傾(기울 경): 亻(사람) + 頃(잠깐 경) → 머리가 잘식 기욳\n斜(빗금 사): 斗(말 두) + 余(남을 여) → 말을 겹쳐 넓은·기울어짐', '명사', 86) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道の傾斜がも、野い。', '길의 경사가 그림에 겁이 난다.', 1),
    (w, '人口減少の傾斜が鮮明だ。', '인구감소의 경향이 선명하다.', 2);

  -- 87. 殺菌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '殺菌', 'さっきん', '살균', '殺(죽일 살): 殳(목숨 끚을 살) + 殳(칠 수) → 생명을 죽임\n菌(버섯 균): 艸(풀) + 菌(먹을 대우 균) → 미생물·고균', '명사', 87) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '殺菌スプレーを使う。', '살균 스프레이를 사용한다.', 1),
    (w, '高温で殺菌する。', '고온으로 살균한다.', 2);

  -- 88. 託す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '託す', 'たくす', '맡기다, 부탁하다', '託(부탁할 탁): 言(말) + 乇(탁) → 말을 의지하여 맡김\n타동사 형태로 타인에게 일·물건을 맡게 함', '동사', 88) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ペットを友人に託して出掛ける。', '펭을 친구에게 맡기고 나간다.', 1),
    (w, '思いを手紙に託した。', '마음을 편지에 담아 맡겼다.', 2);

  -- 89. 暴露
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '暴露', 'ばくろ', '폭로', '暴(사나울 폭): 日(해) + 出(날 출) + 米(쌌 미) → 해에 드러남\n露(이슬 로): 雨(비) + 路(길 로) → 빗장에 드러남', '명사', 89) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不正が暴露された。', '부정이 폭로되었다.', 1),
    (w, '機密情報の暴露を防ぐ。', '기밀정보의 폭로를 막는다.', 2);

  -- 90. 阮む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '阮む', 'はばむ', '저지하다, 가로막다', '阮(막을 저): 阜(언덕) + 且(또 차) → 언덕이 거듭 막힌\n자동사 형태로 진행·서두름을 막아섬을 나타냄', '동사', 90) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '進路を阮む障害がある。', '진로를 가로막는 장애가 있다.', 1),
    (w, '雨が外出を阮んだ。', '비가 외출을 가로막았다.', 2);

  -- 91. 開拓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '開拓', 'かいたく', '개척', '開(열 개): 門(문) + 幵(빗장 개) → 문을 엽\n拓(넓힐 척): 手(손) + 石(돌) → 손으로 돌을 어처 의공간 마련', '명사', 91) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい市場の開拓を進める。', '새로운 시장 개척을 추진한다.', 1),
    (w, '荒れ地を開拓して甿とした。', '황무지를 개척해서 밭으로 삼았다.', 2);

  -- 92. 復興
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '復興', 'ふっこう', '부흥', '復(되돌아갈 복): 徳(갈 척) + 復(되돌아갈 복) → 다시 돌아옴\n興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 일어남', '명사', 92) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被災地の復興が進んでいる。', '재난지의 부흥이 진행되고 있다.', 1),
    (w, '伝統文化の復興を目指す。', '전통문화의 부흥을 목표로 한다.', 2);

  -- 93. 怠る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '怠る', 'おこたる', '소홀히하다, 게을리하다', '怠(게을림 태): 台(별 태) + 心(마음) → 마음이 느슨해짐\n해야할 일을 따롱하게 멈춤이는 의미로 사용', '동사', 93) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予備を怠り、失敗した。', '준비를 소홀히해서 실패했다.', 1),
    (w, '努力を怠ってはいけない。', '노력을 게을리 해서는 안 된다.', 2);

  -- 94. 了承
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '了承', 'りょうしょう', '승낙, 양해', '了(마칠 료): 이루어짐·끝남\n承(이을 승): 以(냫어섬) + 手(손) → 받아들임', '명사', 94) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご了承いただきます。', '양해해 주시기 바랍니다.', 1),
    (w, '上司の了承を得たうえで進める。', '상사의 승낙을 받고 진행한다.', 2);

  -- 95. 巡り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '巡り', 'めぐり', '순회, 돌아봄', '巡(돌 순): 巛(개너질 차) + 辶(갈 착) → 강을 건너며 돌아다닐\n명사형 ''めぐり''는 이곳저곳 돌아다닐을 표현', '명사', 95) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全国を巡るツアーだ。', '전국을 도는 투어다.', 1),
    (w, '助長の巡りをしている。', '조장이 순회를 하고 있다.', 2);

  -- 96. 指図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '指図', 'さしず', '지시', '指(가리킬 지): 手(손) + 旨(뜻 지) → 손으로 가리키며 뜻을 전함\n図(그림 도): 国(테두리) + 圖(그릴 도) → 그림·계획', '명사', 96) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の指図で動いた。', '상사의 지시대로 움직였다.', 1),
    (w, 'それは何者かの指図かもしれない。', '그것은 누군가의 지시일지도 모른다.', 2);

  -- 97. 回顧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '回顧', 'かいこ', '회고', '回(돌아올 회): 삼중의 네모난 모양 → 돌림\n顧(돌아볼 고): 雇(고용할 고) + 頁(머리) → 목을 돌려 뒤를 돌아봄', '명사', 97) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生を回顧する。', '인생을 회고한다.', 1),
    (w, '退職を机に身を回顧する。', '퇴직을 계기로 자신을 회고한다.', 2);

  -- 98. 偽り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '偽り', 'いつわり', '거짓, 허구', '偽(거짓 위): 亻(사람) + 為(할 위) → 사람이 꾸면서 행동\n명사형 ''いつわり''는 진실이 아닌 것', '명사', 98) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この記述に偽りはない。', '이 기술에는 거짓이 없다.', 1),
    (w, '偽りのいん証言だとわかった。', '거짓 증언이라고 밝혀졌다.', 2);

  -- 99. 嫌悪感
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '嫌悪感', 'けんおかん', '혐오감', '嫌(싫을 혐): 女(여자) + 兼(겸할 겸) → 여자가 알차게 행동 → 싫어함\n悪感(オカン): 悪(악할 오) + 感(느낌 감) → 싫어하는 감정', '명사', 99) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その人に嫌悪感を抱く。', '그 사람에게 혐오감을 품는다.', 1),
    (w, '不正に対する嫌悪感が高まる。', '부정에 대한 혐오감이 높아진다.', 2);

  -- 100. 自粛
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '自粛', 'じしゅく', '자숙', '自(스스로 자): 코의 모양 → 자신\n粛(엄숙할 숙): 肀(파고들 연) + 二(두 이) → 스스로 엄격하게 함', '명사', 100) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '業界全体が自粛を求められている。', '업계 전체가 자숙을 요구받고 있다.', 1),
    (w, '外出を自粛して家で過ごす。', '외출을 자숙하고 집에서 지낸다.', 2);

  -- 101. 戒める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '戒める', 'いましめる', '(1) 훈계하다 (2) 금지하다', '戒(경계할 계): 戊(삼세판 무) + 拱(두 손으로 받들 공) → 무기를 갈고 경계\n타동사 형태로 다른 사람에게 주의·경고함', '동사', 101) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不注意な言動を戒める。', '부주의한 언동을 훈계한다.', 1),
    (w, '子どもに火遪びを戒める。', '아이에게 불장난을 금지한다.', 2);

  -- 102. 丘陵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '丘陵', 'きゅうりょう', '구릉', '丘(언덕 구): 北(북녕 북) + 一(한 일) → 높은 곳\n陵(큰언덕 릉): 阜(언덕) + ⋧夕(넓을 릉) → 큰 언덕', '명사', 102) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丘陵地帯に住宅が広がる。', '구릉지대에 주택이 퍼진다.', 1),
    (w, '顔と丘陵を嫌う。', '되언덕·구릉을 꾸려한다.', 2);

  -- 103. 豪快に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '豪快に', 'ごうかいに', '호셔하게', '豪(호각 호): 高(높을 고) + 豕(돼지 시) → 높은 고기·희귀\n快(쉬울 쿌): 忄(마음) + 夬(터놈을 쿌) → 마음이 틁 틀임', '부사', 103) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は豪快に笑う。', '그는 호쿨하게 웃는다.', 1),
    (w, '豪快な性格で人気者だ。', '호쿨한 성격으로 인기인이다.', 2);

  -- 104. 忍耐
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '忍耐', 'にんたい', '인내', '忍(참을 인): 刃(칼날 인) + 心(마음) → 칼날이 심장에 닿아도 참음\n耐(견딜 내): 而(말이을 이) + 寸(마디) → 입을 닫고 참음', '명사', 104) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の忍耐が実を結んだ。', '오랜 인내가 결실을 맺었다.', 1),
    (w, '忍耐強さが試される。', '인내심이 시험당한다.', 2);

  -- 105. 募る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '募る', 'つのる', '(1) 모집하다 (2) (정도가) 심해지다', '募(모을 모): 莫(없을 막) + 力(힘) → 없던 힘을 모음\n자동사로 감정·설움 등이 더욱 강해짐을 의미', '동사', 105) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会員を募る。', '회원을 모집한다.', 1),
    (w, '不満が募り、ついに爆発した。', '불만이 심해져 마침내 폭발했다.', 2);

  -- 106. 膨大
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '膨大', 'ぼうだい', '방대함', '膨(명명할 팡): 肉(고기) + 鼓(북 고) → 살이 뙱북이 등등 차오름\n大(클 대): 사람이 두 팔을 펼친 모양', 'な형용사', 106) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '膨大なデータを処理する。', '방대한 데이터를 처리한다.', 1),
    (w, '宇宙は膨大な空間だ。', '우주는 방대한 공간이다.', 2);

  -- 107. 滞る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '滞る', 'とどこおる', '밀리다, 정체되다', '滞(막힐 체): 氵(물) + 帶(띄 대) → 물이 띄에 걸려 흐르지 않음\n자동사로 일·단계를 제대로 처리하지 못함', '동사', 107) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が滞っている。', '일이 정체되고 있다.', 1),
    (w, '家賃の払いが滞った。', '집세 납부가 밀렸다.', 2);

  -- 108. 驚嘆する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '驚嘆する', 'きょうたんする', '경탄하다, 놀라다', '驚(놀랄 경): 敬(공경 경) + 馬(말 마) → 말이 공경하듯 퍽 뛐\n嘆(탄식할 탄): 口(입) + 兙(어려울 난) → 입으로 소리를 내며 탄식함', '동사', 108) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その記録に驚嘆した。', '그 기록에 경탄했다.', 1),
    (w, '作品の細部に驚嘆させられる。', '작품의 세부에 경탄하게 된다.', 2);

  -- 109. 猛烈に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '猛烈に', 'もうれつに', '맹렬히', '猛(사나울 맹): 犭(개) + 孟(맏이 맹) → 개가 처음 그러듯 사나움\n烈(매울 렬): 列(벌일 렬) + 火(불) → 세차게 타오르는 불', '부사', 109) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '猛烈にトレーニングした。', '맹렬히 트레이닝했다.', 1),
    (w, '猛烈な勢いで雨が降る。', '맹렬한 기세로 비가 내린다.', 2);

  -- 110. 克服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '克服', 'こくふく', '극복', '克(이길 극): ジ(입) + 儿(사람) → 힘들게 이겨냄\n服(옷 복): 月(목이 다르지·멉이 명) + 友(멈추 복) → 모시고 따르게 함', '명사', 110) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい課題を克服した。', '어려운 과제를 극복했다.', 1),
    (w, '慎部を克服して試合に勝った。', '약점을 극복해서 경기에 이겨다.', 2);

  -- 111. 崩れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '崩れる', 'くずれる', '무너지다, 흐트러지다', '崩(무너질 붕): 山(산) + 朋(볗 붕) → 산이 한꺼번에 무너짐\n자동사 형태로 형태·질서가 무너짐을 강조', '동사', 111) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '压力に耐えきれず塔が崩れた。', '압력을 견디지 못하고 탑이 무너졌다.', 1),
    (w, '他人の一言で姿勢が崩れた。', '타인의 한 마디로 자세가 흐트러졌다.', 2);

  -- 112. 繁殖
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '繁殖', 'はんしょく', '번식', '繁(번성할 번): 糸(실) + 敏(민첩할 민) → 실이 무성하게 자람\n殖(번식할 식): 歹(앤긴 병) + 直(곧을 직) → 병이 곧곳 설아 퍼짐', '명사', 112) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この魚は温水で繁殖する。', '이 물고기는 따뜻한 물에서 번식한다.', 1),
    (w, '雑菌の繁殖を防ぐ。', '잡균의 번식을 막는다.', 2);

  -- 113. 履歴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '履歴', 'りれき', '이력', '履(밟을·신 리): 尸(죽을 시) + 復(되돌아갈 복) → 보행·신\n歴(지낼 력): 厤(굴바위 언) + 止(멈춤) → 지난 자취', '명사', 113) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '履歴書を提出した。', '이력서를 제출했다.', 1),
    (w, '彼の履歴は豊富だ。', '그의 이력은 풍부하다.', 2);

  -- 114. 映える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '映える', 'はえる', '(1) 아름답게 빛나다 (2) 잘 어울리다', '映(비칠 영): 日(해) + 央(가운데 앙) → 행빛이 끌어 밝게 빛남\n자동사로 색·해의 대비에 더 아름답게 보임', '동사', 114) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スタジアムに映えるユニホーム。', '경기장에 잘 어울리는 유니폼.', 1),
    (w, '夕日に映える銘だ。', '석양에 빛나는 쓰다마그다.', 2);

  -- 115. 披露
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '披露', 'ひろう', '피로, 공개', '披(헤칠 피): 手(손) + 皮(가죽) → 손으로 겹겹이 헤컬\n露(이슬 로): 雨(비) + 路(길 로) → 빗장에 드러남', '명사', 115) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新作を披露した。', '신작을 공개했다.', 1),
    (w, '手才を披露するステージだ。', '재주를 피로하는 무대다.', 2);

  -- 116. 砕ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '砕ける', 'くだける', '부서지다, 껏이다', '砕(부술 쇄): 石(돌) + 卒(마칠 졸) → 돌이 끊임없이 잘게 부수어짐\n자동사로 형태·기세 등이 껏임을 나타냄', '동사', 116) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '波が岩に砕ける。', '파도가 바위에 부서진다.', 1),
    (w, '反論されて勢いが砕けた。', '반론당해서 기세가 껏였다.', 2);

  -- 117. 執着する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '執着する', 'しゅうちゃくする', '집착하다', '執(잡을 집): 幸(다행·수갑 행) + 丸(잡을 입) → 수갑을 채우고 잡음\n着(붙을 착): 羊(양) + 看(볼 간) → 가까이 붙어서 떨어지지 않음', '동사', 117) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金銅に執着すると見えなくなる。', '돈에 집착하면 안 보이게 된다.', 1),
    (w, '過去に執着してはいけない。', '과거에 집착해서는 안 된다.', 2);

  -- 118. 債務
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '債務', 'さいむ', '채무', '債(빚 채): 亻(사람) + 責(책망할 책) → 사람이 갚아야 할 의무\n務(힘쓸 무): 矛(창) + 勵(그칠 광) → 창을 들고 일에 힘쁬', '명사', 118) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の債務が增えた。', '회사의 채무가 늘었다.', 1),
    (w, '債務を返済する。', '채무를 상환한다.', 2);

  -- 119. 貢献
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '貢献', 'こうけん', '공헌', '貢(바칠 공): 工(장인) + 貝(조개) → 재물을 바침\n献(드릴 헌): 犬(개) + 鬲(솔·소릹 헌) → 제사에 귀하게 드림', '명사', 119) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に貢献する人を目指す。', '사회에 공헌하는 사람을 목표로 한다.', 1),
    (w, '彼の研究は医学に大きく貢献した。', '그의 연구는 의학에 크게 공헌했다.', 2);

  -- 120. 潔い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '潔い', 'いさぎよい', '(미련 없이) 깨끗하다', '潔(깨끗할 결): 氵(물) + 絜(깨끗할 결) → 물로 슻은 듯 맑음\n''いさぎよい''는 주저·미련이 없는 태도를 표현', 'い형용사', 120) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '潔い言いずりだと評価された。', '깨끗한 태도라고 평가되었다.', 1),
    (w, '負けを潔く認める。', '패배를 깨끗히 인정한다.', 2);

  -- 121. 干渉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '干渉', 'かんしょう', '간섭', '干(방패 간): 면병기 모양·방패 → 아무래 밤이 들어가\n渉(건널 섭): 氵(물) + 步(걸음 보) → 물을 건너 감', '명사', 121) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '中央政府は地方への干渉を控える。', '중앙정부는 지방에대한 간섭을 자제한다.', 1),
    (w, '他人の私生活に干渉してはいけない。', '타인의 사생활에 간섭해서는 안 된다.', 2);

  -- 122. 粘る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '粘る', 'ねばる', '끌기 있게 버티다', '粘(찰기할 점): 米(쌌) + 占(차지할 점) → 쌌이 찰수롭게 자리 잡음\n자동사형으로 죽기 살기로 달라붙어 끝까지 함', '동사', 122) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最後まで粘る。', '끝까지 끌기 있게 버한다.', 1),
    (w, '交渉に粘り勝ち取る。', '협상에 끌기 있게 매달려 얻어낸다.', 2);

  -- 123. 促す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '促す', 'うながす', '재촉하다, 촉구하다', '促(재촉할 촉): 亻(사람) + 足(발) → 사람을 발로 쪻아 최섬임\n타동사로 상대의 행동을 촉구함', '동사', 123) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決斷を促す。', '결단을 촉구한다.', 1),
    (w, '跟見予して訪問を促された。', '눈으로 신호를 보내 방문을 재촉받았다.', 2);

  -- 124. 措置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '措置', 'そち', '조치', '措(둘 조): 手(손) + 昔(옆근서) → 손으로 제자리에 돘\n置(둘 치): 网(그물 망) + 直(곧을 직) → 그물을 바로 넓음', '명사', 124) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '適切な措置をとる。', '적절한 조치를 취한다.', 1),
    (w, '緊急措置が必要だ。', '긴급 조치가 필요하다.', 2);

  -- 125. 振興
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '振興', 'しんこう', '진흥', '振(떨칠 진): 手(손) + 辰(별 진) → 손으로 흔들어 깨움\n興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 일어남', '명사', 125) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '産業の振興を図る。', '산업의 진흥을 도모한다.', 1),
    (w, '計画と振興をを推進している。', '계획과 진흥을 추진하고 있다.', 2);

  -- 126. 遺憾に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '遺憾に', 'いかんに', '유감스럽게', '遺(남길 유): 辶(갈 착) + 貴(귀할 귀) → 귀한 것을 남서 잃음\n憾(섭섭할 감): 忄(마음) + 憾(양소립고 머물거릴 함) → 마음에 수점하는 아쉬운', '부사', 126) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遺憾ながら、参加できません。', '유감스럽게도 참가할 수 없습니다.', 1),
    (w, 'プロジェクトは遺憾な結果に終わった。', '프로젝트는 유감스러운 결과로 끝났다.', 2);

  -- 127. 閉鎖
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '閉鎖', 'へいさ', '폐쇄', '閉(닫을 폐): 門(문) + 才(재주 재) → 문을 닫아 건\n鎖(쇠사슬 쇄): 金(쇠) + 小(작을 소) + 貝(조개) → 쇠로 만든 잠금장치', '명사', 127) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コロナで学校が閉鎖された。', '코로나로 학교가 폐쇄되었다.', 1),
    (w, '関係者以外閉鎖となる。', '관계자 이외에는 폐쇄된다.', 2);

  -- 128. 心遺い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '心遺い', 'こころづかい', '배려', '心(마음 심): 심장의 모양 → 마음\n遺(보낼 견): 辶(갈 착) + 貴(귀할 귀) → 말을 보냄 → 신경 쓰기', '명사', 128) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の心遺いに感謝した。', '그의 배려에 감사했다.', 1),
    (w, '動さんに心遺いを示す。', '환자에게 배려를 보인다.', 2);

  -- 129. 憤る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '憤る', 'いきどおる', '분노하다, 분개하다', '憤(텔 분): 心(마음) + 賁(클 분) → 마음이 크게 일레다\n동사형으로 강한 분노·분개의 감정을 대로 표출', '동사', 129) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不公平な評価に憤る。', '불공평한 평가에 분노한다.', 1),
    (w, '誠意のない謝罪にとても憤った。', '성의 없는 사과에 아주 분절했다.', 2);

  -- 130. 治癒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '治癒', 'ちゆ', '치유', '治(다스릴 치): 氵(물) + 台(별 태) → 물길을 관리\n癒(나을 유): ク(병들 녕) + 噐(올라올 유) → 병이 나아 올라감', '명사', 130) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽で心を治癒する。', '음악으로 마음을 치유한다.', 1),
    (w, 'ペットは治癒効果がある。', '애완동물은 치유 효과가 있다.', 2);

  -- 131. 錯覚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '錯覚', 'さっかく', '착각', '錯(섮일 착): 金(쇠) + 昔(옆근서) → 쇠가 섞임\n覚(깨달을 각): 學(배울 학) + 見(볼 견) → 배우고 봅', '명사', 131) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '視覚による錯覚だった。', '시각에 의한 착각이었다.', 1),
    (w, '完璧に記憶したと思ったのは錯覚だった。', '완벽하게 기억했다고 생각한 것은 착각이었다.', 2);

  -- 132. 尊い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '尊い', 'とうとい', '소중하다, 존귀하다', '尊(높을 존): 酉(술단지 유) + 寸(마디) → 높은 재단에 숨 높은 존재\n''とうとい''는 높이 받들 만한 가치 있음을 표현', 'い형용사', 132) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '尊い人生を送る。', '존귀한 인생을 보낸다.', 1),
    (w, '尊い犠牲の上に今がある。', '소중한 희생 위에 오늘이 있다.', 2);

  -- 133. 枯渇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '枯渇', 'こかつ', '고갈', '枯(마를 고): 木(나무) + 古(옥 고) → 나무가 오래되어 말라 죽음\n渇(목마를 갈): 氵(물) + 曷(어조사 갈) → 물이 떨어져서 갈증 난 상태', '명사', 133) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資源の枯渇が心配される。', '자원의 고갈이 우려된다.', 1),
    (w, 'アイデアが枯渇した。', '아이디어가 고갈되었다.', 2);

  -- 134. 慰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '慰める', 'なぐさめる', '위로하다, 달래다', '慰(위로할 위): 尉(별 위) + 心(마음) → 마음을 편안하게 함\n타동사로 슬픔·고통을 덜어주는 행위', '동사', 134) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人を慰めた。', '친구를 위로했다.', 1),
    (w, '心を慰める音楽を聞く。', '마음을 달래는 음악을 듣는다.', 2);

  -- 135. 緊迫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '緊迫', 'きんぱく', '긴박', '緊(긴할 긴): 臣(신하) + 又(또 우) + 糸(실) → 실을 단단히 종임\n迫(핍박할 박): 辶(갈 착) + 白(흰 백) → 조일령 해서 말림', '명사', 135) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両国の関係が緊迫している。', '양국의 관계가 긴박하고 있다.', 1),
    (w, '緊迫した事態に冷静に対応する。', '긴박한 사태에 냉정하게 대응한다.', 2);

  -- 136. 勇敢に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '勇敢に', 'ゆうかんに', '용감하게', '勇(날래론 용): 甬(용솤날 용) + 力(힘) → 힘이 솨아나올\n敢(감히 감): 受(받을 수) + 攵(칠 복) → 과감히 행동', '부사', 136) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勇敢に戦う姿勢に感動した。', '용감하게 싸우는 자세에 감동했다.', 1),
    (w, '彼は勇敢に事件に立ち向かった。', '그는 용감하게 사건에 맞서 싸웠다.', 2);

  -- 137. 忠告
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '忠告', 'ちゅうこく', '충고', '忠(충성 충): 中(가운데 중) + 心(마음) → 마음이 겹친·처지우치치 않은\n告(고할 고): 牛(소) + 口(입) → 소를 회사로 알림', '명사', 137) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生の忠告を受け入れた。', '선생님의 충고를 받아들였다.', 1),
    (w, '友人に忠告してもらう。', '친구에게서 충고를 받는다.', 2);

  -- 138. 慕う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '慕う', 'したう', '(1) 그리워하다 (2) 따르다, 우러르다', '慕(그리워할 모): 莫(없을 막) + 心(마음) → 없는 것을 마음으로 그리워함\n타동사 형태로 마음으로 우러르고 따름을 나타냄', '동사', 138) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '亡き母を慕う。', '돌아가신 어머니를 그리워한다.', 1),
    (w, '誫仮の人柄に多くの人が慕う。', '어질어진 인격에 많은 사람이 따른다.', 2);

  -- 139. 施錠する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '施錠する', 'せじょうする', '자물쇠를 채우다, 잠그다', '施(베풀 시): 方(모 방) + 也(이끌 야) → 깃발을 흔들며 다른 사람에게 행함\n錠(자물쇄 정): 金(쇠) + 長(길 장) → 쇠로 된 긴 것 → 자물쇄', '동사', 139) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜は必ず施錠してください。', '밤에는 반드시 자물쇄를 채우세요.', 1),
    (w, '現関を施錠してる。', '현관을 잠그고 있다.', 2);

  -- 140. 沈下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '沈下', 'ちんか', '침하', '沈(잠길 침): 氵(물) + 柕(다하고·심을 점) → 물속에 잠김\n下(아래 하): 아래를 가리키는 지사', '명사', 140) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地盤の沈下が起きた。', '지반의 침하가 일어났다.', 1),
    (w, '建物の沈下を調査する。', '건물의 침하를 조사한다.', 2);

  -- 141. 監督
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '監督', 'かんとく', '감독', '監(볼 감): 臣(신하) + 皿(그릇) → 그맭의 물을 둘러볼\n督(감독할 독): 叔(아저씨 숙) + 目(눈) → 눈으로 잘펴봄', '명사', 141) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '有名な監督の映画を見た。', '유명한 감독의 영화를 보았다.', 1),
    (w, '工事の監督を担当する。', '공사의 감독을 담당한다.', 2);

  -- 142. 派生
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '派生', 'はせい', '파생', '派(갈래 파): 氵(물) + ➝(물갈래 파) → 물이 갈래짐\n生(날 생): 땅에서 새싹이 돋아날', '명사', 142) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この言葉はブラジル語から派生した。', '이 단어는 포르투갈어에서 파생되었다.', 1),
    (w, '事件に佴う派生的な問題が生じた。', '사건에 따른 파생적인 문제가 생겨났다.', 2);

  -- 143. 透ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '透ける', 'すける', '비쳐보이다, 들여다보이다', '透(사무칠 투): 辶(갈 착) + 秀(빼어날 수) → 우수한 것이 관통함\n자동사로 난 쪽에서 다른 쪽이 보이는 상태', '동사', 143) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーテンごしに中が透ける。', '커튼 너머로 안이 비쳐 보인다.', 1),
    (w, '本思が透けて見えた。', '속마음이 들여다 보였다.', 2);

  -- 144. 恩恵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '恩恵', 'おんけい', '은혜', '恩(은혜 은): 因(인할 인) + 心(마음) → 마음으로 우래함\n恵(은혜 혜): 入(들 입) + 心(마음) → 마음을 헤아림', '명사', 144) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両親の恩恵に感謝する。', '부모님의 은혜에 감사한다.', 1),
    (w, '自然の恩恵に恒しまれている。', '자연의 은혜에 그들어 있다.', 2);

  -- 145. 如実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '如実に', 'にょじつに', '여실히', '如(같을 여): 女(여자) + 口(입) → 여자의 말 → 그것과 같이\n実(열매 실): 宀(집) + 貧(꾰을 관) → 집에 꾰린 돈 → 실제', '부사', 145) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現場の状況が如実に描かれている。', '현장의 상황이 여실히 그려져 있다.', 1),
    (w, '彼の面舗に遬いが如実に表れた。', '그의 얼굴에 망설임이 여실히 나타났다.', 2);

  -- 146. 騒然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '騒然', 'そうぜん', '시끄러운 상태, 떠들석한 모습', '騒(머리 소): 馬(말) + 蚤(밥이 조) → 말이 밥이에 물어 아닜다함\n然(그럴 연): 犬(개) + 肉(고기) + 火(불) → 상태 보조사', 'な형용사', 146) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会場は騒然としていた。', '회장은 소란스러운 상태였다.', 1),
    (w, '事件のニュースで社会が騒然としている。', '사건 뉴스로 사회가 떠들석하다.', 2);

  -- 147. 諭す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '諭す', 'さとす', '잘 타일르다', '諭(깨우칠 유): 言(말) + 俞(대답할 유) → 유연스럭게 말함\n타동사로 잘못을 고치도록 이르는 행위', '동사', 147) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもを諭すように話す。', '아이를 타이르듯이 이야기한다.', 1),
    (w, '長老は静かに諭した。', '어른이 조용히 잘 타일렁다.', 2);

  -- 148. 秩序
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '秩序', 'ちつじょ', '질서', '秩(차례 질): 禾(벼) + 失(잃을 실) → 벼를 차례대로 넓어둡\n序(차례 서): 广(집) + 予(미리 예) → 집의 차례·순서', '명사', 148) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会の秩序を保つ。', '사회의 질서를 유지한다.', 1),
    (w, '交通の秩序が乱れる。', '교통의 질서가 흐트러진다.', 2);

  -- 149. 潜伏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '潜伏', 'せんぷく', '잠복', '潜(잠길 잠): 氵(물) + 曎(바꿀 체) → 물속에 숨음\n伏(엎드릴 복): 亻(사람) + 犬(개) → 개가 잔싫어 엎드림', '명사', 149) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ウイルスの潜伏期間は1週間だ。', '바이러스의 잠복기간은 1주일이다.', 1),
    (w, 'スパイが長い間潜伏していた。', '스파이가 오랜 시간 잠복하고 있었다.', 2);

  -- 150. 朗らかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '朗らかな', 'ほがらかな', '명랑한', '朗(밝을 랑): 良(좋을 랭) + 月(달) → 달이 환하게 빛남\n''ほがらか''는 웃음이 끊임없이 터져 나오는 모습', 'な형용사', 150) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は朗らかな性格だ。', '그녀는 명랑한 성격이다.', 1),
    (w, '朗らかな笑い声が聞こえる。', '명랑한 웃음소리가 들린다.', 2);

  -- 151. 軌跡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軌跡', 'きせき', '굤적', '軌(바퀴자국 굤): 車(수레 거) + 九(아홉 구) → 수레 바퀴·굤도\n跡(발자취 적): 足(발) + 亦(또 역) → 다니면서 남긴 흔적', '명사', 151) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生の軌跡を振り返る。', '인생의 굤적을 돌아본다.', 1),
    (w, '魔水の軌跡を追う。', '혜성의 굤적을 쫓는다.', 2);

  -- 152. 偏り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '偏り', 'かたより', '치우침, 편향', '偏(치우칠 편): 亻(사람) + 扁(낮을 편) → 한쪽으로 기움\n명사형 ''かたより''는 균형이 깨진 상태', '명사', 152) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見の偏りを避ける。', '의견의 치우침을 피한다.', 1),
    (w, '食事の偏りを見直した。', '식사의 치우침을 다시 볼 필요가 있다.', 2);

  -- 153. 矛盾
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '矛盾', 'む个じゅん', '모순', '矛(창 모): 긴 자루의 창 모양\n盾(방패 순): 적을 막는 방패·방어구 → 모·순의 논리평 모순되운 고사', '명사', 153) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の主張には矛盾がある。', '그의 주장에는 모순이 있다.', 1),
    (w, '証言の矛盾を指摘された。', '증언의 모순을 지적받았다.', 2);

  -- 154. 誇張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '誇張', 'こちょう', '과장', '誇(자랑할 과): 言(말) + 佳(자랑할 과) → 말로 자랑함\n張(베풀 장): 弓(활) + 長(길 장) → 활시위를 펼쳐 크게 함', '명사', 154) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誇張して話すおざりがある。', '과장해서 말하는 버릇이 있다.', 1),
    (w, '広告の誇張表現が問題になった。', '광고의 과장 표현이 문제가 되었다.', 2);

  -- 155. 賄う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '賄う', 'まかなう', '(1) 식사를 제공하다 (2) 조달하다', '賄(뀶물 회): 貝(조개) + 有(있을 유) → 재물을 내못하게 쓰\n동사형으로 식사·자금을 충당하고 조달함', '동사', 155) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寮で三食を賄う。', '기숨사에서 세끼 식사를 제공한다.', 1),
    (w, '会議の費用は参加費で賄う。', '회의 비용은 참가비로 조달한다.', 2);

  -- 156. 軽率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軽率', 'けいそつ', '경솔함', '軽(가벼울 경): 車(수레) + 巬(쾰다 경) → 수레가 빨라 가벼운 게임\n率(거느릴 률): 玄(검을 현) + 十(열 십) → 그물으로 소를 이뀸', 'な형용사', 156) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽率な言動を慎む。', '경솔한 언동을 삼간다.', 1),
    (w, '彼は軽率な判断で失敗した。', '그는 경솔한 판단으로 실패했다.', 2);

  -- 157. 腐敗
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '腐敗', 'ふはい', '부패', '腐(썰을 부): 府(마을 부) + 肉(고기) → 고기가 썰음\n敗(패할 패): 貝(조개) + 攵(칠 복) → 조개를 치서 부수어뜨림', '명사', 157) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政治の腐敗を防ぐ必要がある。', '정치의 부패를 막아야 한다.', 1),
    (w, '所長は腐敗防止を訴えた。', '소장은 부패방지를 호소했다.', 2);

  -- 158. 粗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '粗い', 'あらい', '거칠다', '粗(거칠 조): 米(쌌) + 且(또 차) → 잘지 못한 거친 쌌\n''あらい''는 표면·성질이 투박하고 세밀하지 못함', 'い형용사', 158) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '粗いストで背中を洗う。', '거친 수건으로 등을 씨는다.', 1),
    (w, '言葉遣いが粗くて不快だ。', '말투가 거칠어서 불쿨하다.', 2);

  -- 159. 粘膜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '粘膜', 'ねんまく', '점막', '粘(붙을 점): 米(쌌) + 占(차지할 점) → 쌌이 찰수롭게 끌\n膜(껍질 막): 肉(고기 육) + 莫(없을 막) → 고기의 얇은 껍질', '명사', 159) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鼻の粘膜が腕んでいる。', '코의 점막이 부어있다.', 1),
    (w, '口腕は口の粘膜の炎症だ。', '구내염은 입의 점막 염증이다.', 2);

  -- 160. 寿命
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '寿命', 'じゅみょう', '수명', '寿(목숨 수): 士(선비 사) + 寸(마디) → 사람이 살아온 길이\n命(목숨 명): 口(입) + 令(하여금 령) → 하늘이 명한 목숨', '명사', 160) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平均寿命が伸びている。', '평균 수명이 늘고 있다.', 1),
    (w, '製品の寿命は五年だ。', '제품의 수명은 5년이다.', 2);

  -- 161. 誓約書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '誓約書', 'せいやくしょ', '서약서', '誓(맹세할 서): 拘(꿩을 절) + 言(말) → 꿩는 것을 말로 약속\n約書: 約(맺을 약) + 書(글 서) → 약속을 적은 글', '명사', 161) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誓約書にサインした。', '서약서에 서명했다.', 1),
    (w, '仕事上、誓約書を提出させられた。', '업무상 서약서를 제출하게 되었다.', 2);

  -- 162. 絶叫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '絶叫', 'ぜっきょう', '절규', '絶(끊을 절): 糸(실) + 色(색) + 刂(칼) → 칼로 실을 자름\n叫(부르지을 규): 口(입) + 厫(뛰어오르고 규) → 입으로 팍 소리침', '명사', 162) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '恐怖のあまり絶叫した。', '공포에 너무 놀라 절규했다.', 1),
    (w, 'スタジアムでサポーターの絶叫が黄いた。', '경기장에서 서포터의 절규가 울렸다.', 2);

  -- 163. 背後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '背後', 'はいご', '배후', '背(등 배): 北(북녕·이하적) + 肉(고기) → 사람의 등\n後(뒤 후): 忄(조금걸을 척) + 麼(서로 자계) → 뒤처짐', '명사', 163) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の背後関係を調査する。', '사건의 배후관계를 조사한다.', 1),
    (w, 'その主張の背後には何かある。', '그 주장의 배후에는 뭐가 있다.', 2);

  -- 164. 抱負
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '抱負', 'ほうふ', '포부', '抱(안을 포): 手(손) + 包(올 포) → 팔로 감쎄 안음\n負(질 부): 亻(사람) + 貝(조개) → 사람이 재물을 짐', '명사', 164) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来の抱負を語る。', '장래의 포부를 말한다.', 1),
    (w, '抱負を胸に業を始めた。', '포부를 가슴에 품고 사업을 시작했다.', 2);

  -- 165. 䫥る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '䫥る', 'あなどる', '무시하다', '䫥(업신여길 모): 亻(사람) + 母(어머니 모) → 그의하며 업신여김\n타동사형으로 상대를 없이보고 회하게 대함', '동사', 165) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '相手を䫥った够ば、負けた。', '상대를 무시한 엄극, 지고 말았다.', 1),
    (w, '小さな閃眎を䫥ってはいけない。', '작은 미세함을 무시해서는 안 된다.', 2);

  -- 166. 筋道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '筋道', 'すじみち', '조리, 사리', '筋(힘줄 근): 竹(대나무) + 肋(고기 육) + 力(힘) → 근육·장기·논리의 줄\n道(길 도): 辶(갈 착) + 首(머리) → 머리를 사용해 나아갈 길', '명사', 166) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の筋道を逆う。', '이야기의 조리가 맞지 않는다.', 1),
    (w, '筋道を立てて説明した。', '조리있게 설명했다.', 2);

  -- 167. 奔放な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '奔放な', 'ほんぽうな', '분방한', '奔(달릴 분): 大(클 대) + 卉(섭 꿼) → 큰 발걸음으로 달림\n放(놓을 방): 方(모·방향) + 攵(칠 복) → 한앫 날려버림 → 자유분방', 'な형용사', 167) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '奔放な生き方をしていた。', '분방한 삶을 살고 있었다.', 1),
    (w, '奔放な言動が話題になる。', '분방한 언동이 화제가 된다.', 2);

  -- 168. 円滑な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '円滑な', 'えんかつな', '원활한', '円(둥귀·엔 엔): 㨵(울타리 경) + 圈(테두리 권) → 둥귄 테두리\n滑(미끄러울 활): 氵(물) + 骨(보 골) → 물처럼 었쪽이 잘 흐름', 'な형용사', 168) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は円滑に進んだ。', '회의는 원활하게 진행되었다.', 1),
    (w, '心も閃も円滑に話し合う。', '원활하게 대화를 나눌다.', 2);

  -- 169. 及ぼす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '及ぼす', 'およぼす', '(영향을) 미치다, 끼치다', '及(미칠 급): 亻(사람) + 又(또 우) → 손이 사람에게 닿음\n타동사로 영향·파급 효과를 이르게 함', '동사', 169) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仮説は世界に影響を及ぼした。', '이 설은 세계에 영향을 끼쳤다.', 1),
    (w, '干ばつが農業に被害を及ぼす。', '가물이 농업에 피해를 끼친다.', 2);

  -- 170. 完結
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '完結', 'かんけつ', '완결', '完(완전할 완): 宀(집) + 元(으뜹 원) → 집이 완전하게 가춘\n結(맺을 결): 糸(실) + 吉(길할 길) → 실을 잘 맺음', '명사', 170) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長編小説が完結した。', '장편소설이 완결되었다.', 1),
    (w, 'このドラマは全五話で完結だ。', '이 드라마는 전 5화로 완결이다.', 2);

  -- 171. キャリア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'キャリア', 'きゃりあ', '커리어, 경력', NULL, '명사', 171) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'キャリアアップを目指す。', '경력 향상을 목표로 한다.', 1),
    (w, '長いキャリアを持つ記者だ。', '긴 경력을 가진 기자다.', 2);

  -- 172. 結束
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '結束', 'けっそく', '결속', '結(맺을 결): 糸(실) + 吉(길할 길) → 실을 잘 맺음\n束(묶을 속): 木(나무) + 口(입) → 나무를 한데 모아 묶음', '명사', 172) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームの結束を高める。', '팀의 결속을 다진다.', 1),
    (w, '職員間の結束を促進する。', '직원간의 결속을 촉진한다.', 2);

  -- 173. 念願
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '念願', 'ねんがん', '염원', '念(생각할 녕): 今(이제 금) + 心(마음) → 지금 마음에 두고 있음\n願(원할 원): 頁(머리) + 原(근원 원) → 머릿속 근본으로 바람', '명사', 173) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の念願だった家を建てた。', '오랜 염원이었던 집을 지었다.', 1),
    (w, '念願が叶って学者になった。', '염원이 이루어져 학자가 되었다.', 2);

  -- 174. 背景
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '背景', 'はいけい', '배경', '背(등 배): 北(북녕 북) + 肉(고기) → 사람의 등·뒤쪽\n景(별 경): 日(해) + 京(서울 경) → 해리 끌리는 풍경', '명사', 174) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その事件には複雑な背景がある。', '그 사건에는 복잡한 배경이 있다.', 1),
    (w, '写真の背景は火山だ。', '사진의 배경은 화산이다.', 2);

  -- 175. フォローする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'フォローする', 'ふぉろーする', '보조하다, 지원하다', NULL, '동사', 175) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部下をしっかりフォローする。', '부하를 철저히 지원한다.', 1),
    (w, '新人の仕事をフォローする。', '신입의 업무를 보조한다.', 2);

  -- 176. 報じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '報じる', 'ほうじる', '알리다, 보도하다', '報(갚을 보): 幸(다행 행) + ⋣巳(복종할 복) → 좋은 소식을 알림\n동사화 ''じる''이 붙어 ''알리다''의 뜻으로 사용', '동사', 176) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ニュースで事件を報じている。', '뉴스에서 사건을 보도하고 있다.', 1),
    (w, '友人が合格を電話で報じてくれた。', '친구가 합격을 전화로 알려주었다.', 2);

  -- 177. 本音
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '本音', 'ほんね', '본심, 속내', '本(근본 본): 木(나무) 아래에 표시 → 릌리·근본\n音(소리 음): 言(말)에서 파생·말소리', '명사', 177) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本音を言うとトラブルになる。', '속말을 하면 트러블이 된다.', 1),
    (w, '街いばんだ本音を明かした。', '드디어 속마음을 밝혔다.', 2);

  -- 178. 綿密な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '綿密な', 'めんみつな', '면밀한', '綿(손견 면): 糸(실) + 帛(비단 백) → 세세한 실\n密(비밀 밀): 宀(집) + 必(반드시 필) → 집안에 꿉 들어차서 틈이 없음', 'な형용사', 178) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '綿密な計画を立てた。', '면밀한 계획을 세웠다.', 1),
    (w, '綿密な調査が必要だ。', '면밀한 조사가 필요하다.', 2);

  -- 179. やんわり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'やんわり', '부드럽게, 살며시', NULL, '부사', 179) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やんわりと断った。', '부드럽게 거절했다.', 1),
    (w, 'やんわりと意見を伝える。', '부드럽게 의견을 전한다.', 2);

  -- 180. 逸材
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '逸材', 'いつざい', '일재, 뛰어난 인재', '逸(달아날 일): 辶(갈 착) + 兔(토끼 토) → 토끼처럼 빨르게 달아남\n材(재목 재): 木(나무) + 才(재주 재) → 재능 있는 나무·용재', '명사', 180) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は逸材として評価されている。', '그는 뛰어난 인재로 평가받고 있다.', 1),
    (w, '逸材を適した社員を採用した。', '뛰어난 사원을 채용했다.', 2);

  -- 181. 会心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '会心', 'かいしん', '회심, 만족스러운 결과', '会(모일 회): 이쟈을 차고 린곳에 모임 → 함께\n心(마음 심): 심장 모양 → 마음·뜻', '명사', 181) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会心の作品が仏さをようやく完成した。', '만족스러운 작품이 드디어 완성되었다.', 1),
    (w, '会心の笑みを浮かべた。', '회심의 미소를 뗠올렸다.', 2);

  -- 182. 実情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '実情', 'じつじょう', '실정, 실제 사정', '実(열매 실): 宀(집) + 貨(꾰을 관) → 집에 재물이 실제로 있음\n情(뜻 정): 忄(마음) + 青(푸르르) → 마음 속 고은 뜻', '명사', 182) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実情に合わせて説明した。', '실정에 맞춰서 설명했다.', 1),
    (w, '現場の実情を知る必要がある。', '현장의 실정을 알 필요가 있다.', 2);

  -- 183. 修復
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '修復', 'しゅうふく', '수복, 복원', '修(닦을 수): 亻(사람) + 長(길 장) + 彡(터런 삼) → 사람이 꾸임\n復(되돌아갈 복): 復(되돌아갈 복)에서 원래 상태로 돌아감', '명사', 183) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い画の修復作業が進んでいる。', '오래된 그림의 복원 작업이 진행되고 있다.', 1),
    (w, '関係の修復に努める。', '관계 수복에 노력한다.', 2);

  -- 184. ストック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ストック', 'すとっく', '스톡, 재고', NULL, '명사', 184) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '在庫ストックを確認する。', '재고 스톡을 확인한다.', 1),
    (w, 'ストックが不足している。', '재고가 부족하다.', 2);

  -- 185. 強み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '強み', 'つよみ', '강점', '強(강할 강): 弓(활) + 口(입) + 虫(벌레 충) → 활이 강하고 튼튼함\n명사형 ''つよみ''는 다른 이보다 뛰어난 점', '명사', 185) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分の強みを生かす。', '자신의 강점을 살린다.', 1),
    (w, 'チームの強みはディフェンスだ。', '팀의 강점은 수비다.', 2);

  -- 186. ニュアンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ニュアンス', 'にゅあんす', '뉘앙스', NULL, '명사', 186) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言葉のニュアンスを伝えるのは難しい。', '언어의 뉘앙스를 전달하는 것은 어렵다.', 1),
    (w, '他人の作品とニュアンスが違う。', '다른 사람의 작품과 뉘앙스가 다르다.', 2);

  -- 187. 弾む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '弾む', 'はずむ', '튀기다, 들뜨다', '弾(탄알 탄): 弓(활) + 單(홀로 단) → 활을 쓐서 탄알을 튀김\n자동사형으로 고·명·마음이 튀어오르는 활기차', '동사', 187) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボールがよく弾む。', '공이 잘 튀긴다.', 1),
    (w, '話が弾んで楽しい夜だった。', '대화가 활기차서 즐거운 밤이었다.', 2);

  -- 188. 抜粋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '抜粋', 'ばっすい', '발재', '抜(뽑을 발): 手(손) + 友(볗 붕) → 손으로 뽑아냄\n粋(수수 수): 米(쌌) + 卒(졸손) → 잘 고르고 고른 쌌·일품', '명사', 188) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本から重要な部分を抜粋した。', '책에서 중요한 부분을 발제했다.', 1),
    (w, 'これは原文の抜粋だ。', '이것은 원문의 발제다.', 2);

  -- 189. 不備
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不備', 'ふび', '불비, 미비, 불충분함', '不(아닌 불): 근본적 부정\n備(갖출 비): 亻(사람) + 备(갖출 비) → 갖춰있음', '명사', 189) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書類の不備が見つかった。', '서류의 미비가 발견되었다.', 1),
    (w, '不備を訂正する。', '부족한 부분을 수정한다.', 2);

  -- 190. 平行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '平行', 'へいこう', '평행', '平(평평할 평): 귀의 평평함 → 고르고 평평\n行(다닐 행): 그림자길의 모양 → 갈김·진행', '명사', 190) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二つの計画を平行して進める。', '두 계획을 평행하게 진행한다.', 1),
    (w, '議論は平行線をたどった。', '논의는 평행선을 달렸다.', 2);

  -- 191. 無謀な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '無謀な', 'むぼうな', '무모한', '無(없을 무): 없음\n謀(꽌 모): 言(말)+某(아무 모) → 으싫한 계책', 'な형용사', 191) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無謀な計画は危険だ。', '무모한 계획은 위험하다.', 1),
    (w, '無謀に挑戦した。', '무모하게 도전했다.', 2);

  -- 192. 言い張る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '言い張る', 'いいはる', '우겨대다, 주장하다', '言(말): 입으로 내는 소리\n張(베풀 장): 활을 당겨 펼침 → 주장을 세게 퍼', '동사', 192) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分は悪くないと言い張った。', '자신은 나쁜 점이 없다고 우겨도.', 1),
    (w, '証拠があるのに言い張るな。', '증거가 있는데 우기지 마라.', 2);

  -- 193. 大筋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '大筋', 'おおすじ', '요점, 대강', '大(클 대): 사람이 팔을 펼친 모양\n筋(힘줄 근): 주요 줄기·논리', '명사', 193) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の大筋を伝える。', '회의의 요점을 전한다.', 1),
    (w, '大筋に同意した。', '대강에 동의했다.', 2);

  -- 194. 改訂版
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '改訂版', 'かいていばん', '개정판', '改訂(고칠 개·바로잡을 정): 잘못을 고침\n版(판 판): 인쇄의 판', '명사', 194) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞書の改訂版が出た。', '사전의 개정판이 나왔다.', 1),
    (w, '教科書の改訂版を買う。', '교과서의 개정판을 산다.', 2);

  -- 195. 加工する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '加工する', 'かこうする', '가공하다', '加(더할 가): 力(힘)+口(입) → 힘을 더함\n工(장인 공): 도구 모양', '동사', 195) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原料を加工して製品にする。', '원료를 가공해서 제품을 만든다.', 1),
    (w, '画像を加工して使う。', '이미지를 가공해서 사용한다.', 2);

  -- 196. 急遽
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '急遽', 'きゅうきょ', '급거, 갑작스럽게', '急(급할 급): 서두름\n遽(년가절 거): 辶(갈 착)+蘧 → 갑자기 감', '부사', 196) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急遽会議を開くことになった。', '급거 회의를 열게 되었다.', 1),
    (w, '急遽予定が変わった。', '갑작스럽게 일정이 바뀌었다.', 2);

  -- 197. 究明する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '究明する', 'きゅうめいする', '규명하다', '究(연구할 구): 穴(구먍)+九 → 구먍 깊이\n明(밝을 명): 日+月 → 밝혀냄', '동사', 197) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の真相を究明する。', '사건의 진상을 규명한다.', 1),
    (w, '原因を究明する。', '원인을 규명한다.', 2);

  -- 198. 寄与
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '寄与', 'きよ', '기여', '寄(부칠 기): 宀(집)+奇 → 집을 맡김\n与(더붙을 여): 주고받음', '명사', 198) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に寄与する仕事がしたい。', '사회에 기여하는 일을 하고 싶다.', 1),
    (w, 'この研究は医学に大きく寄与した。', '이 연구는 의학에 크게 기여했다.', 2);

  -- 199. 妥協
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '妥協', 'だきょう', '타협', '妥(온당 타): 爪+女 → 손으로 조심스레 안정\n協(화할 협): 十+力 → 여러 힘 합침', '명사', 199) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妥協点を見つける。', '타협점을 찾는다.', 1),
    (w, '品質に妥協しない。', '품질에 타협하지 않는다.', 2);

  -- 200. ハードル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ハードル', 'はーどる', '허들, 장애물', NULL, '명사', 200) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高いハードルを越えた。', '높은 장애물을 넘어섬다.', 1),
    (w, '価格のハードルが高い。', '가격의 허들이 높다.', 2);

  -- 201. 人出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '人出', 'ひとで', '인파, 밖으로 나온 사람들', '人(사람 인): 사람\n出(나올 출): 곳에서 나옴', '명사', 201) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜の街には人出が多い。', '밤거리에는 인파가 많다.', 1),
    (w, '休日の人出を見込む。', '휴일의 인파를 예상한다.', 2);

  -- 202. 紛らわしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '紛らわしい', 'まぎらわしい', '혼동하기 쉬우다', '紛(어지러울 분): 糸(실)+分 → 실이 엉혀 어지러움', 'い형용사', 202) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同姓の人と紛らわしい。', '동명이인과 혼동될 수 있다.', 1),
    (w, '説明が紛らわしくて誤解した。', '설명이 혼란스러워서 오해했다.', 2);

  -- 203. 催す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '催す', 'もよおす', '개최하다', '催(재촉 최): 亻+崔 → 일을 촉구·열고 개최', '동사', 203) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記念イベントを催す。', '기념 이벤트를 개최한다.', 1),
    (w, '市がコンサートを催した。', '시가 콘서트를 개최했다.', 2);

  -- 204. 和らぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '和らぐ', 'やわらぐ', '누그러지다', '和(화할 화): 禾(벼)+口 → 다정하고 평온함', '동사', 204) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さが和らいだ。', '추위가 누그러졌다.', 1),
    (w, '緊張が和らぐ。', '긴장이 누그러진다.', 2);

  -- 205. リストアップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'リストアップ', 'りすとあっぷ', '리스트업, 목록 작성', NULL, '명사', 205) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '候補者をリストアップする。', '후보자를 리스트업한다.', 1),
    (w, '必要な品をリストアップした。', '필요한 물품을 목록으로 작성했다.', 2);

  -- 206. 一任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '一任', 'いちにん', '일임, 모두 맡김', '一: 하나\n任(맡길 임): 亻+壬 → 사람에게 맡김', '명사', 206) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断を部下に一任する。', '판단을 부하에게 일임한다.', 1),
    (w, '一任されて責任が重い。', '일임받아 책임이 무겁다.', 2);

  -- 207. 腕前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '腕前', 'うでまえ', '솨씨, 실력', '腕(팔 완): 肉(고기)+宛 → 손·팔\n前(앞 전): 앞쪽', '명사', 207) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は腕前がよい職人だ。', '그는 솨씨가 좋은 장인이다.', 1),
    (w, '腕前を発揮する機会だ。', '실력을 발휘할 기회다.', 2);

  -- 208. 強硬に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '強硬に', 'きょうこうに', '강경하게', '強(강할 강): 굳세·세다\n硬(굳을 경): 石+更 → 돌처럼 단단함', '부사', 208) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強硬に反対した。', '강경하게 반대했다.', 1),
    (w, '強硬な態度を貫く。', '강경한 태도를 고수한다.', 2);

  -- 209. 障る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '障る', 'さわる', '기분 상하다', '障(멉을 장): 阜(언덕)+章 → 언덕이 가로막음', '동사', 209) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その一言が気に障った。', '그 한마디가 기분을 상하게 했다.', 1),
    (w, '彼の態度が障った。', '그의 태도가 불쿨했다.', 2);

  -- 210. じめじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'じめじめ', '축축하다, 습하다', NULL, '부사', 210) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梨雨の日はじめじめしている。', '장마 년에는 집안이 축축하다.', 1),
    (w, 'トイレがじめじめしている。', '화장실이 축축하다.', 2);

  -- 211. そわそわ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'そわそわ', '안절부절못함, 능궁맞이 뚰다', NULL, '부사', 211) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面接前でそわそわしている。', '면접 앞이라 안절부절못한다.', 1),
    (w, '子供がそわそわしている。', '아이가 안절부절못하고 있다.', 2);

  -- 212. 立て替える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '立て替える', 'たてかえる', '대신 돈을 치르다', '立(설 립): 서다\n替(바꿀 체): 曰(아닐 왜)+二 → 바꿈', '동사', 212) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書代を立て替えてくれた。', '책값을 대신 내주었다.', 1),
    (w, 'タクシー代を立て替えた。', '택시비를 대신 냈다.', 2);

  -- 213. ためらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ためらう', '주저하다, 망설이다', NULL, '동사', 213) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '返事をためらっている。', '답장을 망설이고 있다.', 1),
    (w, '買うかどうかためらう。', '살지 말지 망설인다.', 2);

  -- 214. 取りわけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '取りわけ', 'とりわけ', '유단히, 특히', '取(취할 취): 耳(귀)+又(손) → 귀 잡음\nわけ: 이유·구분', '부사', 214) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は取りわけ暑い。', '오늘은 유단히 덩다.', 1),
    (w, '彼は取りわけ優秀だ。', '그는 특히 우수하다.', 2);

  -- 215. 荷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '荷', 'に', '짐, 부담', '荷(머이에 질 하): 艸(초초)+何(누구 하) → 지고 나르는 짐', '명사', 215) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重い荷を背負う。', '무거운 짐을 짊어진다.', 1),
    (w, '彼にとって荷が重い。', '그에게 있어서 부담이 크다.', 2);

  -- 216. 担う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '担う', 'になう', '떠맡다, 짊어지다', '担(먹을 담): 手(손)+詹 → 손으로 떠받침', '동사', 216) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来を担う若者たち。', '미래를 떠맡을 젛은이들.', 1),
    (w, '重要な役割を担う。', '중요한 역할을 떠맡는다.', 2);

  -- 217. 念頭
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '念頭', 'ねんとう', '염두, 생각의 재갈아짐', '念(생각할 념): 今(이제)+心 → 지금 마음에 두는 것\n頭(머리 두): 머리와 있는 고정', '명사', 217) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '常に者のことを念頭に置く。', '항상 그를 염두에 둔다.', 1),
    (w, '念頭にある計画を話した。', '염두에 있는 계획을 말했다.', 2);

  -- 218. 無性に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '無性に', 'むしょうに', '무짜각, 이유없이', '無: 없음\n性(성품 성): 心+生 → 타고난 성틈 → ה상황', '부사', 218) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無性に甚いものが食べたい。', '무짜각 단 게 먹고 싶다.', 1),
    (w, '無性に腕が痒い。', '이유없이 팔이 가렵다.', 2);

  -- 219. 異色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '異色', 'いしょく', '이색, 독특함', '異(다를 이): 이상·다름\n色(빛 색): 사람의 표정/빛깔', '명사', 219) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは異色の作品だ。', '이것은 독특한 작품이다.', 1),
    (w, '異色の経歴を持つ。', '독특한 경력을 가지고 있다.', 2);

  -- 220. ウエイト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ウエイト', 'うえいと', '비중, 중요도', NULL, '명사', 220) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'セールスにウエイトを置く。', '세일즈에 비중을 둔다.', 1),
    (w, '生産のウエイトが高い。', '생산의 비중이 높다.', 2);

  -- 221. 太だしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '太だしい', 'しばしい', '엄청나게 많다', NULL, 'い형용사', 221) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '太だしい数の人が集まった。', '엄청나게 많은 수의 사람이 모였다.', 1),
    (w, '太だしい量の仕事がある。', '엄청나게 많은 양의 일이 있다.', 2);

  -- 222. 可決
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '可決', 'かけつ', '가결', '可(옷 가): 인정·의결\n決(결정 결): 氵(물)+夬 → 물길을 터 결정', '명사', 222) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '議案が可決された。', '의안이 가결되었다.', 1),
    (w, '多数決で可決した。', '다수결로 가결했다.', 2);

  -- 223. 食い止める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '食い止める', 'くいとめる', '막아내다', '食(먹을 식): 먹음\n止(그칠 지): 발자국 → 멈춤', '동사', 223) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤字の拡大を食い止める。', '적자 확대를 막아낸다.', 1),
    (w, '請求の動きを食い止めた。', '청구의 움직임을 막았다.', 2);

  -- 224. 駆使する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '駆使する', 'くしする', '구사하다', '駆(몰 구): 馬(말)+区 → 말을 몰아붙임\n使(하여금 사): 亻+吏 → 사람을 부림', '동사', 224) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '英語を自由に駆使する。', '영어를 자유롭게 구사한다.', 1),
    (w, '技術を駆使して作った。', '기술을 구사해서 만들었다.', 2);

  -- 225. 心細い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '心細い', 'こころぼそい', '마음이 불안하다', '心(마음 심): 심장 모양\n細(가늘 세): 糸(실)+田 → 가느랜 실→허약', 'い형용사', 225) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人で夜道を歩くのは心細い。', '혼자 밤길을 걷는 건 불안하다.', 1),
    (w, '資金が足りず心細い。', '자금이 부족해 불안하다.', 2);

  -- 226. 支障
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '支障', 'ししょう', '지장', '支(갈래·지탱 지): 나뻐짐\n障(멉을 장): 가로막힘', '명사', 226) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '業務に支障が出る。', '업무에 지장이 생긴다.', 1),
    (w, '生活に支障がある。', '생활에 지장이 있다.', 2);

  -- 227. 絶大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '絶大な', 'ぜつだいな', '절대적인, 매우 큰', '絶(끊을 절): 糸(실)+色 → 실을 끊음\n大(클 대): 크기', 'な형용사', 227) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '絶大な信頼を寄せている。', '절대적인 신뢰를 보내고 있다.', 1),
    (w, '彼は絶大な人気を誇る。', '그는 절대적인 인기를 자랑한다.', 1);

  -- 228. たどる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'たどる', '더듬다, 따라가다', NULL, '동사', 228) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶をたどってみる。', '기억을 더듰어 본다.', 1),
    (w, '同じ道をたどる。', '같은 길을 따라간다.', 2);

  -- 229. てきぱき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'てきぱき', '일을 척척 해내는 모양', NULL, '부사', 229) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事をてきぱきと処理する。', '일을 척척하게 처리한다.', 1),
    (w, 'てきぱきと動く人だ。', '척척하게 움직이는 사람이다.', 2);

  -- 230. ノルマ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ノルマ', 'のるま', '노르마, 할당량', NULL, '명사', 230) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ノルマを達成する。', '할당량을 달성한다.', 1),
    (w, '今月のノルマが原しい。', '이번 달 할당량이 엄격하다.', 2);

  -- 231. 揺らぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '揺らぐ', 'ゆらぐ', '흔들리다', '揺(흔들 요): 手+摭 → 손으로 흔들림', '동사', 231) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '信念が揺らぐ。', '신념이 흔들린다.', 1),
    (w, '地震で建物が揺らいだ。', '지진으로 건물이 흔들렸다.', 2);

  -- 232. 予断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '予断', 'よだん', '예단, 예측', '予(미리 예)\n断(끊을 단): 米+斤 → 자르다', '명사', 232) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況は予断を許さない。', '상황은 예단을 불허한다.', 1),
    (w, '予断に反して勝った。', '예상을 깨고 이겼다.', 2);

  -- 233. おおらかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おおらかな', '너그러운, 우둘은', NULL, 'な형용사', 233) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおらかな性格だ。', '너그러운 성격이다.', 1),
    (w, 'おおらかに接する。', '우둘게 대한다.', 2);

  -- 234. 該当する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '該当する', 'がいとうする', '해당하다', '該(갖출 해): 言+亥\n当(마끜할 당): 멈춤·맞춤', '동사', 234) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '該当者は手を挨げて下さい。', '해당되시는 분은 손을 들어주세요.', 1),
    (w, '条件に該当する人を選ぶ。', '조건에 해당하는 사람을 고른다.', 2);

  -- 235. 稼働
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '稼働', 'かどう', '가동', '稼(심을 가): 禾+家 → 집안 벼 심는 일\n働(일할 동): 亻+動 → 일함', '명사', 235) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工場が24時間稼働している。', '공장이 24시간 가동하고 있다.', 1),
    (w, 'システムの稼働率が高い。', '시스템의 가동률이 높다.', 2);

  -- 236. 起伏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '起伏', 'きふく', '기복', '起(일어날 기): 일어남\n伏(엎드릴 복): 亻+犬 → 사람이 개처럼 엎드림', '명사', 236) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生には起伏がある。', '인생에는 기복이 있다.', 1),
    (w, '起伏の多い道を走る。', '기복이 많은 길을 달린다.', 2);

  -- 237. 強制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '強制', 'きょうせい', '강제', '強(강할 강): 굳세·세다\n制(제도 제): 牛+刀 → 마름제입', '명사', 237) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強制的に参加させる。', '강제적으로 참가시킨다.', 1),
    (w, '他人に強制してはいけない。', '타인에게 강제해서는 안 된다.', 2);

  -- 238. くよくよ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'くよくよ', '끈임없이 고민하는 모양', NULL, '부사', 238) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さなことでくよくよするな。', '사소한 일로 고민하지 마라.', 1),
    (w, '失敗をくよくよ考える。', '실패를 고민한다.', 2);

  -- 239. 合意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '合意', 'ごうい', '합의', '合(합할 합): 언덕+입 → 입이 맞음\n意(뜻 의): 音+心 → 마음의 소리', '명사', 239) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両者は合意に達した。', '양자는 합의에 도달했다.', 1),
    (w, '合意の上で進める。', '합의하여 진행한다.', 2);

  -- 240. しいて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しいて', '굳이, 굳이 말하자면', NULL, '부사', 240) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しいて言うなら赤が好きだ。', '굳이 말하자면 빨강을 좋아한다.', 1),
    (w, 'しいて反対もしない。', '굳이 반대도 하지 않는다.', 2);

  -- 241. すさまじい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すさまじい', '엄청나다, 대단하다', NULL, 'い형용사', 241) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すさまじい音が黄ろいた。', '대단한 소리가 울렸다.', 1),
    (w, 'すさまじい勢いで走り去った。', '대단한 기세로 달려갔다.', 2);

  -- 242. 直面する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '直面する', 'ちょくめんする', '직면하다', '直(곧을 직)\n面(냭 면): 얼굴·표면', '동사', 242) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難題に直面する。', '난관에 직면하다.', 1),
    (w, '現実に直面した。', '현실에 직면했다.', 2);

  -- 243. 取り戻す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '取り戻す', 'とりもどす', '되찾다, 되돌리다', '取(가질 취): 귀+손 → 귀 잡음\n戻(어꺋날 려): 戶+犬 → 원래 자리로', '동사', 243) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を取り戻す。', '건강을 되찾다.', 1),
    (w, '信頼を取り戻すために努力する。', '신뢰를 되찾기 위해 노력한다.', 2);

  -- 244. 幅広い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '幅広い', 'はばひろい', '폭넓다', '幅(폭 폭): 巾+畑 → 직물 폭\n広(넓을 광): 집+黄 → 곳이 넓음', 'い형용사', 244) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幅広い年齢層に人気だ。', '폭넓은 연령층에 인기가 있다.', 1),
    (w, '幅広い知識を持つ。', '폭넓은 지식을 가진다.', 2);

  -- 245. 紛れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '紛れる', 'まぎれる', '말려들다, 섞이다', '紛(어지러울 분): 糸+分 → 실이 엉혀 어지러움', '동사', 245) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人ごみに紛れる。', '인파에 말려들다.', 1),
    (w, '雑音に紛れて聡き取りにくい。', '잡음에 섞여 알아듣기 힘들다.', 2);

  -- 246. メディア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'メディア', 'めでぃあ', '미디어', NULL, '명사', 246) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メディアに取り上げられた。', '미디어에 소개되었다.', 1),
    (w, 'スポーツメディアと話した。', '스포츠 미디어와 이야기했다.', 2);

  -- 247. 愛着
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '愛着', 'あいちゃく', '애착', '愛(사랑 애): 受+心\n着(붙을 착): 羊+目 → 달라붙음', '명사', 247) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この街に愛着がある。', '이 동네에 애착이 있다.', 1),
    (w, '古い車に愛着を持つ。', '오래된 차에 애착을 가진다.', 2);

  -- 248. 一揃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '一揃', 'いっそう', '일소, 말끔히 쓸어버림', '一\n揃(쓸 소): 手+帚 → 빗자루로 쓸어냄', '명사', 248) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '悪者を一揃する。', '악당을 일소한다.', 1),
    (w, '不満を一揃した。', '불만을 말끔히 없애었다.', 2);

  -- 249. 基盤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '基盤', 'きばん', '기반', '基(터 기): 土+其 → 터·밑판\n盤(쇹반 반): 般+皿 → 큰 그릇·밑바닥', '명사', 249) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済の基盤を固める。', '경제의 기반을 다진다.', 1),
    (w, '企業の基盤が部い。', '기업의 기반이 탄탄하다.', 2);

  -- 250. 教訓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '教訓', 'きょうくん', '교훈', '教(가르칠 교): 孝+攵\n訓(가르칠 훈): 言+川 → 말을 이끌어 가르침', '명사', 250) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歴史に学ぶ教訓。', '역사에서 배우는 교훈.', 1),
    (w, '失敗を教訓にする。', '실패를 교훈으로 삼는다.', 2);

  -- 251. 切り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '切り出す', 'きりだす', '말을 꺼내다', '切(끊을 절): 七+刀\n出: 꾸려짐', '동사', 251) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい話を切り出した。', '어려운 이야기를 꺼냈다.', 1),
    (w, '本題を切り出す。', '본제를 꺼낸다.', 2);

  -- 252. 染みる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '染みる', 'しみる', '스머들다, 몽시 마음에 닿다', '染(물들 염): 氵+木+九 → 물에 담게끍', '동사', 252) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さが骨に染みる。', '추위가 빼속까지 스먴든다.', 1),
    (w, '言葉が心に染みた。', '말이 마음에 쇒앤다.', 2);

  -- 253. すんなり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すんなり', '순조롭게, 쉬우며', NULL, '부사', 253) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交渉はすんなり進んだ。', '협상은 순조롭게 진행되었다.', 1),
    (w, 'すんなりと受け入れられた。', '순조롭게 받아들여졌다.', 2);

  -- 254. センス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'センス', 'せんす', '센스, 감각', NULL, '명사', 254) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女はファッションセンスがいい。', '그녀는 패션 감각이 좋다.', 1),
    (w, 'これはセンスの問題だ。', '이건 감각의 문제다.', 2);

  -- 255. 尽くす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '尽くす', 'つくす', '있는 힘을 다하다', '尽(다할 진): 少+皿 → 그릇이 빌 때까지', '동사', 255) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全力を尽くした。', '전력을 다했다.', 1),
    (w, '人を助けるために尽くす。', '사람을 돕기 위해 힘쓴다.', 2);

  -- 256. ノウハウ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ノウハウ', 'のうはう', '노하우', NULL, '명사', 256) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '技術のノウハウを譲る。', '기술의 노하우를 전수한다.', 1),
    (w, 'ノウハウを蔓める。', '노하우를 축적하다.', 2);

  -- 257. 頻繁に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '頻繁に', 'ひんぱんに', '빈번하게, 자주', '頻(자주 빈): 步+頁 → 머리를 자주\n繁(번성·잦을 번): 곳+糸 → 많이 느단 매임', '부사', 257) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頻繁にメールを送る。', '빈번하게 메일을 보낸다.', 1),
    (w, 'ここを頻繁に訪れる。', '이곳을 자주 찾는다.', 2);

  -- 258. へとへと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'へとへと', '녹초가 되다, 몀킸 상태', NULL, 'な형용사', 258) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事でへとへとになった。', '일로 녹초가 되었다.', 1),
    (w, '長時間の走りでへとへとだ。', '장시간 달리기로 몀킸 상태다.', 2);

  -- 259. 見かける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見かける', 'みかける', '눈에 띄다', '見(볼 견): 압+人 → 사람이 봄\nかける: 행위를 건도함', '동사', 259) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼を騅で見かけた。', '그를 역에서 뎤다.', 1),
    (w, 'よく見かける顔だ。', '자주 눈에 띄는 얼굴이다.', 2);

  -- 260. 流出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '流出', 'りゅうしゅつ', '유출', '流(흐를 류): 氵+毒 → 물이 흐름\n出(나올 출): 나감', '명사', 260) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '個人情報が流出した。', '개인정보가 유출되었다.', 1),
    (w, '人材の海外流出が問題だ。', '인재의 해외 유출이 문제다.', 2);

  -- 261. 一環
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '一環', 'いっかん', '일환', '一: 하나\n環(고리 환): 玉+罯 → 둘레 돘', '명사', 261) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の一環として行う。', '계획의 일환으로 수행한다.', 1),
    (w, '医療改革の一環だ。', '의료 개혁의 일환이다.', 2);

  -- 262. コンスタントに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'コンスタントに', 'こんすたんとに', '꾸준하게, 일정하게', NULL, '부사', 262) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はコンスタントに成果を出す。', '그는 꾸준한 성과를 낸다.', 1),
    (w, 'コンスタントに努力している。', '꾸준히 노력하고 있다.', 2);

  -- 263. 賛える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '賛える', 'たたえる', '칭찬하다', '賛(기릴 찬): 贝+先+先 → 재물 봉헌 높임', '동사', 263) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の不思議を賛えた。', '그의 어질어짐을 칭찬했다.', 1),
    (w, '認めて賛える。', '인정하고 칭찬한다.', 2);

  -- 264. 非
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '非', 'ひ', '비, 잘못', '非(아닐 비): 양쪽에 서로 등을 대짐 → 아님', '명사', 264) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '非を認めて謝った。', '잘못을 인정하고 사과했다.', 1),
    (w, '非は一切なかった。', '잘못은 아무것도 없었다.', 2);

  -- 265. もっぱら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もっぱら', '오로지, 전당·전적으로', NULL, '부사', 265) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今はもっぱら勉強だ。', '지금은 오로지 공부뿐이다.', 1),
    (w, 'もっぱら読書にふける。', '오로지 독서에 팔린다.', 2);

  -- 266. よみがえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'よみがえる', '소생하다, 부활하다', NULL, '동사', 266) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い記憶がよみがえった。', '오래된 기억이 되살아났다.', 1),
    (w, '伝統がよみがえる。', '전통이 소생한다.', 2);

  -- 267. 打診
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '打診', 'だしん', '타진, 의견을 떠봄', '打(칠 타): 手+丁\n診(진찰 진): 言+叁 → 상태를 살핌 파악', '명사', 267) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心身に打診する。', '의향을 타진한다.', 1),
    (w, '会社側に打診した。', '회사측에 타진했다.', 2);

  -- 268. 経歴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '経歴', 'けいれき', '경력', '経(경서 경): 실+巬 → 는을 곧게 감\n歴(겪을 력): 厝+止 → 지나온 자취', '명사', 268) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経歴を詳しく記す。', '경력을 자세히 적는다.', 1),
    (w, '多彩な経歴を持つ。', '다양한 경력을 가진다.', 2);

  -- 269. 弾く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '弾く', 'はじく', '튀기다, 틈기다', '弾(탄알 탄): 弓(활)+單 → 활을 견욠', '동사', 269) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ギターを弾く。', '기타를 친다.', 1),
    (w, 'そろばんを弾く。', '주판을 튀긴다.', 2);

  -- 270. 逸脱
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '逸脱', 'いつだつ', '일탈', '逸(달아날 일): 辶+兔 → 토끼 달아남\n脱(벗을 탈): 肉+兌 → 멸을 벴김', '명사', 270) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が本題から逸脱した。', '이야기가 본제에서 일탈했다.', 1),
    (w, '逸脱行為は許されない。', '일탈 행위는 허용되지 않는다.', 2);

  -- 271. いとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'いとも', '매우, 특히', NULL, '부사', 271) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いとも簡単に解いた。', '너무도 간단히 풀었다.', 1),
    (w, 'いとも誤りやすい表現だ。', '매우 틀리기 쉬운 표현이다.', 2);

  -- 272. まちまち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'まちまち', '각양각색, 제각각', NULL, 'な형용사', 272) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見がまちまちだ。', '의견이 제각각이다.', 1),
    (w, '会員の品質はまちまちだ。', '회원의 질이 제각각이다.', 2);

  -- 273. 在庫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '在庫', 'ざいこ', '재고', '在(있을 재): 才+土\n庫(곳집 고): 广+車 → 마차를 두는 곳', '명사', 273) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '在庫を確認する。', '재고를 확인한다.', 1),
    (w, '在庫が不足している。', '재고가 부족하다.', 2);

  -- 274. リスク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'リスク', 'りすく', '리스크', NULL, '명사', 274) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リスクを取る。', '리스크를 감수한다.', 1),
    (w, 'リスク管理が重要だ。', '리스크 관리가 중요하다.', 2);

  -- 275. 堅実な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '堅実な', 'けんじつな', '견실한, 탄탄한', '堅(굳을 견): 구·소·탔 → 단단\n実(열매 실): 宀+貝 → 집안에 재물 가득', 'な형용사', 275) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '堅実な仁事ぶりをする。', '성실한 일 처리를 한다.', 1),
    (w, '堅実な人柄だ。', '성실한 인품이다.', 2);

  -- 276. 遮断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '遮断', 'しゃだん', '차단', '遮(가릴 차): 辶+庶 → 도중에 가림\n断(끊을 단): 잔르다', '명사', 276) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通を遮断する。', '교통을 차단한다.', 1),
    (w, '電源を遮断した。', '전원을 차단했다.', 2);

  -- 277. がらりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'がらりと', '확 바뀌고', NULL, '부사', 277) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '態度ががらりと変わった。', '태도가 확 바뀌었다.', 1),
    (w, '雰囲気ががらりと変わった。', '분위기가 확 바뀌었다.', 2);

  -- 278. なだめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'なだめる', '달래다', NULL, '동사', 278) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣く子供をなだめる。', '우는 아이를 달랜다.', 1),
    (w, '怋りをなだめた。', '화를 달래주었다.', 2);

  -- 279. 言及
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '言及', 'げんきゅう', '언급', '言(말씀 언): 辛+口\n及(미칠 급): 人+又 → 손으로 닿는 도달', '명사', 279) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件について言及した。', '사건에 대해 언급했다.', 1),
    (w, 'その点には言及しない。', '그 점에는 언급하지 않는다.', 2);

  -- 280. 解除
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '解除', 'かいじょ', '해제', '解(풀 해): 角+刀+牛 → 칼로 소의 뿔 풀어윗\n除(덜 제): 阜+餘 → 계단 치움', '명사', 280) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '警報を解除する。', '경보를 해제한다.', 1),
    (w, '該限の解除を決めた。', '제한을 해제하기로 결정했다.', 2);

  -- 281. レイアウト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'レイアウト', 'れいあうと', '레이아웃, 배치', NULL, '명사', 281) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ページのレイアウトを考える。', '페이지의 배치를 고민한다.', 1),
    (w, '店内のレイアウトを変えた。', '점내의 배치를 바꿨다.', 2);

  -- 282. 起用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '起用', 'きよう', '기용, 발탁', '起(일어날 기)\n用(쓸 용): 그림자제에서 유래', '명사', 282) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新人を主役に起用した。', '신인을 주역으로 발탁했다.', 1),
    (w, '選手を起用する。', '선수를 기용한다.', 2);

  -- 283. 駆けつける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '駆けつける', 'かけつける', '달려오다', '駆(몰 구)\nつける: 닿다', '동사', 283) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現場に駆けつけた。', '현장에 달려왔다.', 1),
    (w, '仑息を聴いて駆けつける。', '부고를 듣고 달려온다.', 2);

  -- 284. 多角的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '多角的な', 'たかくてきな', '다각적인', '多(많을 다): 저녁을 쓰다 → 많음\n角(뿔 각): 짐승의 뿔', 'な형용사', 284) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多角的な視点で見る。', '다각적인 관점에서 본다.', 1),
    (w, '多角的に検討する。', '다각적으로 검토한다.', 2);

  -- 285. 盛大に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '盛大に', 'せいだいに', '성대하게', '盛(성할 성): 成+皿 → 그릇이 가득 찬\n大(클 대)', '부사', 285) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誠大に記念式を行う。', '성대하게 기념식을 거행한다.', 1),
    (w, '誠大なパーティだった。', '성대한 파티였다.', 2);

  -- 286. せかせかと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'せかせかと', '서어서어 서두르는 모양', NULL, '부사', 286) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はせかせかと歩いている。', '그는 서두르며 걷고 있다.', 1),
    (w, 'せかせかと気が見る。', '안절부절못해 보인다.', 2);

  -- 287. センサー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'センサー', 'せんさー', '센서, 감지장치', NULL, '명사', 287) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人感センサーが反応した。', '인체감지 센서가 반응했다.', 1),
    (w, 'センサーが故障した。', '센서가 고장났다.', 2);

  -- 288. 壮大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '壮大な', 'そうだいな', '장대한, 웅대한', '壮(잔을 장): 亜+士 → 장수\n大(클 대)', 'な형용사', 288) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '壮大な計画を立てる。', '웅대한 계획을 세운다.', 1),
    (w, '壮大な景色だ。', '장엄한 경치이다.', 2);

  -- 289. ここちよく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ここちよく', '기분 좋게, 쇾어게', NULL, '부사', 289) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ソファでここちよく休む。', '소파에서 기분 좋게 쉬단다.', 1),
    (w, 'ここちよく眼りを覊た。', '기분 좋게 눈을 붙였다.', 2);

  -- 290. 従事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '従事', 'じゅうじ', '종사', '従(좌을 종): 彼+從 → 따르다\n事(일 사): 그림자·일', '명사', 290) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金融業に従事している。', '금융업에 종사하고 있다.', 1),
    (w, '野作業に従事する。', '농작업에 종사한다.', 2);

  -- 291. にじむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'にじむ', '번지다, 스머나오다', NULL, '동사', 291) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '汗がにじむ。', '땅이 배어나온다.', 1),
    (w, 'インクが紙ににじんだ。', '잉크가 종이에 번졌다.', 2);

  -- 292. 禁物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '禁物', 'きんもつ', '금물, 해서는 안 되는 일', '禁(금할 금): 林+示 → 숨은 숲 → 금지\n物(만물 물)', '명사', 292) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面接で違反は禁物だ。', '면접에서 자만은 금물이다.', 1),
    (w, '中途半端は禁物だ。', '어중간은 금물이다.', 2);

  -- 293. ひしひしと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ひしひしと', '강렴하게, 절실히', NULL, '부사', 293) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危機をひしひしと感じる。', '위기를 절실히 느낀다.', 1),
    (w, '意やる気がひしひしと伝わる。', '의욕이 절실하게 전해진다.', 2);

  -- 294. 表明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '表明', 'ひょうめい', '표명', '表(곉 표): 衣+毛 → 옷의 겹\n明(밝을 명): 일+월', '명사', 294) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '微認を表明した。', '지지를 표명했다.', 1),
    (w, '辞任を表明する。', '사임을 표명한다.', 2);

  -- 295. 精力的に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '精力的に', 'せいりょくてきに', '정력적으로', '精(정할 정): 米(쌓씬)+青 → 고운 쌓씬\n力(힘 력): 근육', '부사', 295) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '精力的に活動している。', '정력적으로 활동하고 있다.', 1),
    (w, '精力的な仅事ぶりだ。', '정력적인 일 처리다.', 2);

  -- 296. 気がかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '気がかり', 'きがかり', '염려, 신경쓰임', '気(기운 기): 기운\nかる: 걸린다', '명사', 296) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供のことが気かかりだ。', '아이 일이 염려된다.', 1),
    (w, '気がかりなことがある。', '신경 쓰이는 것이 있다.', 2);

  -- 297. 推移
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '推移', 'すいい', '추이, 변화 과정', '推(밀 추): 手+隹 → 손으로 밀어냄\n移(옮길 이): 禾+多 → 병 많이 옮김', '명사', 297) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の推移を見る。', '가격의 추이를 본다.', 1),
    (w, '状況の推移を見守る。', '상황의 추이를 지켜본다.', 2);

  -- 298. 危ぶむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '危ぶむ', 'あやぶむ', '위태롭게 여기다', '危(위태할 위): 厘+厄 → 절벽에서 웅�함', '동사', 298) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の達成を危ぶむ。', '계획의 달성을 위태롭게 여긴다.', 1),
    (w, '選手の出場が危ぶまれる。', '선수의 출전이 위태로워진다.', 2);

  -- 299. ずっしりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ずっしりと', '묵직하게, 손이 무겁게', NULL, '부사', 299) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重い荷物がずっしりと腕に伝わる。', '무거운 짐이 묵직하게 팔에 전해진다.', 1),
    (w, 'ずっしりとした手応えだ。', '묵직한 손맛이다.', 2);

  -- 300. 歴然としている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '歴然としている', 'れきぜんとしている', '역연하다, 뚷렷하다', '歴(지낼 역): 厝+止 → 이해 온 흐름\n然(그럴 연): 犬+肉+火 → 불타는 개 → 분명', '동사', 300) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両者の実力差は歴然としている。', '양자의 실력차는 역연하다.', 1),
    (w, '歴然とした事実だ。', '역연한 사실이다.', 2);

  -- 301. クレーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'クレーム', 'くれーむ', '클레임, 불평', NULL, '명사', 301) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '客からクレームが来た。', '고객으로부터 클레임이 들어왔다.', 1),
    (w, 'クレームに対応する。', '클레임에 대응한다.', 2);

  -- 302. 経緯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '経緯', 'けいい', '경위, 경과', '経(경서 경)\n緯(씨올 위): 糸+韋 → 가로 짠', '명사', 302) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の経緯を説明する。', '사건의 경위를 설명한다.', 1),
    (w, '以前からの経緯がある。', '이전부터의 경위가 있다.', 2);

  -- 303. みっちり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'みっちり', '아주 아주 철저하게', NULL, '부사', 303) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'みっちり訓練した。', '철저하게 훈련했다.', 1),
    (w, 'もっちり勉強する。', '철저하게 공부한다.', 2);

  -- 304. 撤去
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '撤去', 'てっきょ', '철거', '撤(거둘 철): 手+育 → 아까 처리함\n去(갈 거): 土+去 → 곳을 떠남', '명사', 304) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不法建築を撤去する。', '불법 건축물을 철거한다.', 1),
    (w, '障害物を撤去した。', '장애물을 철거했다.', 2);

  -- 305. うずうず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'うずうず', '안달한 모양, 못 참고 움직이고 싶은 모양', NULL, '부사', 305) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うずうずしてたまらない。', '못 참아 안달하다.', 1),
    (w, '試合た、たくてうずうずしている。', '경기하고 싶어서 안달하고 있다.', 2);

  -- 306. 却下する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '却下する', 'きゃっかする', '기각하다', '却(물러날 각): 去+卸 → 물러남\n下(아래 하)', '동사', 306) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '許上を却下する。', '항소를 기각한다.', 1),
    (w, '詳請が却下された。', '신청이 기각되었다.', 2);

  -- 307. 旺盛だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '旺盛だ', 'おうせいだ', '왕성하다', '旺(왕성할 왕): 日+王 → 보름+해\n盛(성할 성): 成+皿', 'な형용사', 307) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食欲が旺盛だ。', '식욕이 왕성하다.', 1),
    (w, 'チャレンジ精神が旺盛だ。', '도전 정신이 왕성하다.', 2);

  -- 308. 施す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '施す', 'ほどこす', '베풀다, 행하다', '施(베풀 시): 方+是 → 깃발을 펼침', '동사', 308) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人に怟けを施す。', '시주닀에게 자비를 베푹다.', 1),
    (w, '忧全の礼を施す。', '만전의 대책을 행한다.', 2);

  -- 309. 余波
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '余波', 'よは', '여파', '余(남을 여): 식+余 → 남은 음식\n波(물결 파): 氵+皮 → 물의 결', '명사', 309) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の余波が続く。', '사건의 여파가 이어진다.', 1),
    (w, '厰徳不況の余波を受けた。', '경제 불황의 여파를 받았다.', 2);

  -- 310. 目先
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '目先', 'めさき', '눈앞, 당장의 일', '目(눈 목): 눈\n先(먼저 선): 앞은 발', '명사', 310) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目先の利益だけ考える。', '눈앞의 이익만 생각한다.', 1),
    (w, '目先に迫った試験。', '눈앞으로 다가온 시험.', 2);

  -- 311. ぎくしゃくする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ぎくしゃくする', '서먜서먜하다, 어색하다', NULL, '동사', 311) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人間関係がぎくしゃくする。', '인간관계가 서먜서먜해진다.', 1),
    (w, '会話がぎくしゃくした。', '대화가 어색해졌다.', 2);

  -- 312. 存続
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '存続', 'そんぞく', '존속', '存(있을 존): 才+子 → 아이가 있음\n続(이을 속): 糸+買 → 이어짐', '명사', 312) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の存続が危ぶまれる。', '회사의 존속이 위태롭다.', 1),
    (w, '伝統の存続を願う。', '전통의 존속을 바란다.', 2);

  -- 313. 派
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '派', 'は', '파, 계파', '派(갈래 파): 氵+貝 → 물이 갈라짐', '명사', 313) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同じ派閘だ。', '같은 파벌이다.', 1),
    (w, '反対派に属する。', '반대파에 속한다.', 2);

  -- 314. 風習
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '風習', 'ふうしゅう', '풍습', '風(바람 풍): 万+虫 → 바람의 움직임\n習(익힐 습): 羽+白 → 세 론함을 되풀이함', '명사', 314) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い風習が残っている。', '오래된 풍습이 남아있다.', 1),
    (w, '地域の風習を尊重する。', '지역의 풍습을 존중한다.', 2);

  -- 315. もどかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もどかしい', '답답하다', NULL, 'い형용사', 315) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言いたいことが伝わらずもどかしい。', '하고 싶은 말이 전해지지 않아 답답하다.', 1),
    (w, 'ボタンが押せずもどかしい。', '버튼이 눌리지 않아 답답하다.', 2);

  -- 316. 熟知
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '熟知', 'じゅくち', '숙지', '熟(익을 숙): 享+丸+火 → 잘 익힌\n知(알 지): 矢+口 → 먹이는 입', '명사', 316) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はこの分野に熟知している。', '그는 이 분야에 있어 숙지하다.', 1),
    (w, '熟知の上で決めた。', '숙지한 다음 결정했다.', 2);

  -- 317. 拗れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '拗れる', 'こじれる', '꼬이다, 일이 꼬이다', '拗(솤을 요): 手+譱 → 손으로 솤음', '동사', 317) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '許可が拗れた。', '이야기가 꼬였다.', 1),
    (w, '交渉が拗れてしまう。', '협상이 꼬이고 말았다.', 2);

  -- 318. めきめき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'めきめき', '눈에 띄게, 장족거리는 모양', NULL, '부사', 318) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めきめきと上達した。', '눈에 띄게 실력이 은상되었다.', 1),
    (w, 'めきめき頭角を現す。', '돖보이게 두각을 나타낸다.', 2);

  -- 319. 軽快な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軽快な', 'けいかいな', '경쿨한, 경도있는', '軽(가벼울 경): 車+嵮 → 마차 실이는 짓\n快(쿨할 쿨): 心+夬 → 마음이 틀임', 'な형용사', 319) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽快な足取りで走る。', '경쿨한 발걸음으로 달린다.', 1),
    (w, '軽快なリズムだ。', '경쿨한 리듬이다.', 2);

  -- 320. サイクル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'サイクル', 'さいくる', '사이클, 주기', NULL, '명사', 320) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生産のサイクルが短い。', '생산의 주기가 짧다.', 1),
    (w, '番サイクルの品質が高い。', '서이클의 품질이 높다.', 2);

  -- 321. 仲裁
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仲裁', 'ちゅうさい', '중재', '仲(버금 중): 亻+中 → 사람이 가운데\n裁(마름질할 재): 衣+哀 → 옷을 장제함', '명사', 321) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '争議の仲裁に入る。', '분쟁의 중재에 나선다.', 1),
    (w, '仲裁者として評価される。', '중재자로서 평가받는다.', 2);

  -- 322. しわざ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しわざ', '소안·짓, 행적', NULL, '명사', 322) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは誤のしわざだろう。', '이건 적의 소안일 것이다.', 1),
    (w, '何者のしわざだ。', '누구의 소안이는가.', 2);

  -- 323. 発覚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '発覚', 'はっかく', '발각', '発(펼 발): 서·않으로 쇔을 쌏\n覚(깨달을 각): 學+見 → 배워 알게됨', '명사', 323) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不正が発覚した。', '부정이 발각되었다.', 1),
    (w, '事件が発覚する。', '사건이 발각된다.', 2);

  -- 324. すべすべ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すべすべ', '매끄럽고 부드러운 모양', NULL, 'な형용사', 324) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肌がすべすべだ。', '피부가 매끄럽다.', 1),
    (w, 'すべすべした表面。', '매끄러운 표면.', 2);

  -- 325. 噂し合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '噂し合う', 'かみあう', '맞물리다, 맞다', '噂(ל 소문 우)\nう: 울리머', '동사', 325) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歯車が噂し合う。', '톱니바퀴가 맞물린다.', 1),
    (w, '議論が噂し合わない。', '논의가 맞물리지 않는다.', 2);

  -- 326. 保護
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '保護', 'ほご', '보호', '保(지키으 보): 亻+呆 → 사람이 아기를 품\n護(도울 호): 言+仓 → 말로 보호', '명사', 326) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境を保護する。', '환경을 보호한다.', 1),
    (w, '動物の保護活動に参加する。', '동물 보호 활동에 참여한다.', 2);

  -- 327. 忠実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '忠実に', 'ちゅうじつに', '충실하게', '忠(충성 충): 中+心 → 중심에 차는 마음\n実(열매 실): 재물·알차', '부사', 327) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忠実に仕事をこなす。', '충실하게 일을 처리한다.', 1),
    (w, '原作に忠実な映画だ。', '원작에 충실한 영화다.', 2);

  -- 328. すくう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すくう', '주우다, 숨을 주우다', NULL, '동사', 328) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水をすくう。', '물을 마시다.', 1),
    (w, '人を危険からすくう。', '사람을 위험에서 구한다.', 2);

  -- 329. ピント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ピント', 'ぴんと', '초점, 포인트', NULL, '명사', 329) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カメラのピントが合わない。', '카메라 초점이 맞지 않는다.', 1),
    (w, '話のピントがずれている。', '이야기의 초점이 엇나있다.', 2);

  -- 330. 食い込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '食い込む', 'くいこむ', '파고들다', '食(먹을 식)\n込む: 안으로 들어가다', '동사', 330) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ロープが肌に食い込む。', '로프가 살에 파고든다.', 1),
    (w, '人生を食い込むような赤字。', '생계를 파고드는 듯한 적자.', 2);

  -- 331. てっきり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'てっきり', '틀림없이, 분명히', NULL, '부사', 331) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'てっきり雨だと思った。', '틀림없이 비가 올 거라 생각했다.', 1),
    (w, 'てっきり会議は中止だと思っていた。', '틀림없이 회의가 취소될 줄 알았다.', 2);

  -- 332. 自立
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '自立', 'じりつ', '자립', '自(스스로 자): 코 모양\n立(설 립): 다리 멈춘 자세', '명사', 332) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済的に自立した。', '경제적으로 자립했다.', 1),
    (w, '子供の自立を愿う。', '아이의 자립을 바란다.', 2);

  -- 333. 還元
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '還元', 'かんげん', '환원', '還(돌아올 환): 辶+環 → 다시 돌아옴\n元(으떤 원): 머리+모자 → 근원', '명사', 333) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '利益を社会に還元する。', '이익을 사회에 환원한다.', 1),
    (w, '酒を還元反応させる。', '알코을 환원반응시킨다.', 2);

  -- 334. どんより
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'どんより', '명 타다, 흐릿', NULL, '부사', 334) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんよりした天気だ。', '흐릿한 날씨다.', 1),
    (w, 'どんよりとした顔をしている。', '우울한 얼굴을 하고 있다.', 2);

  -- 335. ネック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ネック', 'ねっく', '네크, 애로사항', NULL, '명사', 335) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用がネックだ。', '비용이 애로사항이다.', 1),
    (w, '言語の壁がネックとなる。', '언어의 벽이 애로사항이 된다.', 2);

  -- 336. 発散
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '発散', 'はっさん', '발산', '発(펼 발)\n散(흔을 산): 莶+肉+攵 → 고기를 쟐게 자름', '명사', 336) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスを発散する。', '스트레스를 발산한다.', 1),
    (w, '余分なエネルギーを発散する。', '여분의 에너지를 발산한다.', 2);

  -- 337. 行き届く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '行き届く', 'ゆきとどく', '구석구석 미치다', '行(다닐 행): 사거리 모양\n届(보낼 계): 尸+由 → 이르다', '동사', 337) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古ろ量りが行き届く。', '배려가 구석구석 미친다.', 1),
    (w, '金雏に行き届いたサービス。', '세세한 부분까지 미친 서비스.', 2);

  -- 338. 快挙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '快挙', 'かいきょ', '쿨거', '快(쿨할 쿨): 心+夬\n挙(들 거): 與+手 → 손으로 들어 올림', '명사', 338) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界初の快挙を達成した。', '세계 최초의 쿨거를 달성했다.', 1),
    (w, '快挙を肆げる。', '쿨거를 이룩한다.', 2);

  -- 339. 助長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '助長', 'じょちょう', '조장, 조장함', '助(도울 조): 且+力 → 힘을 더함\n長(길 장): 머리카락이 긴 노인', '명사', 339) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不平不満を助長する。', '불평불만을 조장한다.', 1),
    (w, '争いを助長する。', '싸움을 조장한다.', 2);

  -- 340. 見返り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見返り', 'みかえり', '대가, 보상', '見(볼 견)\n返: 돌려주다', '명사', 340) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '協力の見返りを要求する。', '협력의 대가를 요구한다.', 1),
    (w, '努力の見返りがあった。', '노력의 대가가 있었다.', 2);

  -- 341. 結成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '結成', 'けっせい', '결성', '結(맺을 결): 糸+吉 → 실이 맺임\n成(이룰 성): 戊+丁 → 먹이 있는 안정되면', '명사', 341) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インドバンドを結成した。', '밴드를 결성했다.', 1),
    (w, '委員会を結成する。', '위원회를 결성한다.', 2);

  -- 342. 手配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手配', 'てはい', '수배, 준비', '手(손 수): 움직이는 손\n配(나눌 배): 酉+己 → 술을 나눌함', '명사', 342) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通手配をする。', '교통편을 수배한다.', 1),
    (w, '接足を手配する。', '접속을 수배한다.', 2);

  -- 343. つくづく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'つくづく', '제대로, 고이 고이, 절실히', NULL, '부사', 343) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つくづくと考えた。', '고이 고이 생각했다.', 1),
    (w, 'つくづく誓んだ。', '절실히 느꼈다.', 2);

  -- 344. 解れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '解れる', 'ほぐれる', '풌리다, 괴어 느곳해지다', '解(풀 해)', '동사', 344) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '緊張が解れる。', '긴장이 풌린다.', 1),
    (w, '骪のこりが解れた。', '어깨 결림이 풌렸다.', 2);

  -- 345. 根底
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '根底', 'こんてい', '근저', '根(뿌리 근): 木+嵮 → 나무의 뿌리\n底(밑 저): 广+氐 → 집의 밑', '명사', 345) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考え方の根底から違う。', '생각이 근저에서부터 다르다.', 1),
    (w, '社会の根底を揺るがす事件。', '사회의 근저를 흔드는 사건.', 2);

  -- 346. 返上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '返上', 'へんじょう', '반납, 반환', '返(돌아올 반): 辶+反 → 돌아옴\n上(위 상)', '명사', 346) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タイトルを返上した。', '타이틀을 반납했다.', 1),
    (w, '休日を返上して働く。', '휴일을 이낌고 일한다.', 2);

  -- 347. 取り次ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '取り次ぐ', 'とりつぐ', '중계하다, 전달하다', '取(가질 취)\n次(버금 차): 二+欠', '동사', 347) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話を取り次ぐ。', '전화를 바꿔준다.', 1),
    (w, '伝言を取り次いだ。', '전언을 전해주었다.', 2);

  -- 348. 交錯する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '交錯する', 'こうさくする', '교착하다', '交(사귀일 교): 사람이 다리를 꼬은 모양\n錯(섮일 착): 金+昔 → 금속이 섮임', '동사', 348) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思いが交錯する。', '생각이 교착한다.', 1),
    (w, '多くの人と車が交錯する。', '많은 사람과 차가 교착한다.', 2);

  -- 349. 難航
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '難航', 'なんこう', '난항, 일이 잘 안 됨', '難(어려울 난)\n航(배 항): 舟+亢 → 배가 건너감', '명사', 349) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が難航している。', '계획이 난항하고 있다.', 1),
    (w, '交渉は難航中だ。', '협상은 난항 중이다.', 2);

  -- 350. がやがや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'がやがや', '웅성거려는 모양', NULL, '부사', 350) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教室ががやがやしている。', '교실이 웅성거리고 있다.', 1),
    (w, 'がやがやと話してうるさい。', '웅성거려서 시끄럽다.', 2);

  -- 351. 足手まとい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '足手まとい', 'あしてまとい', '거칩거리는 존재, 거친다리', '足+手+まとう: 손과 발을 얽음', '명사', 351) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が足手まといになる。', '아이가 거칩거리게 된다.', 1),
    (w, '仕事をする上で足手まといだ。', '일하는 데 거칩거리다.', 2);

  -- 352. 適応
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '適応', 'てきおう', '적응', '適(맞을 적): 辶+啇 → 도에서 맞게\n応(응할 응): 广+心 → 마음으로 응함', '명사', 352) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境に適応する。', '환경에 적응한다.', 1),
    (w, '適応能力が高い。', '적응력이 뛰어나다.', 2);

  -- 353. 掲げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '掲げる', 'かかげる', '높이 들다, 내걸다', '掲(높이 들 게): 手+譁 → 손으로 올림', '동사', 353) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スローガンを掲げる。', '구호를 내건다.', 1),
    (w, '旗を掲げる。', '깃발을 처들고 올린다.', 2);

  -- 354. 足止め
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '足止め', 'あしどめ', '발이 묶임, 이동 제한', '足(발 족)\n止: 멈춤', '명사', 354) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が足止めされた。', '전철이 멈춰 섬다.', 1),
    (w, '伝染病で交通が足止めになる。', '전염병으로 교통이 멈쎘 되어버린다.', 2);

  -- 355. 払拭
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '払拭', 'ふっしょく', '분식', '払(쓰을 분): 手+弗 → 손으로 쓸어냄\n拭(병을 식): 手+芘 → 손으로 쓸어냄', '명사', 355) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不安を払拭する。', '불안을 분식한다.', 1),
    (w, '誤解を払拭したい。', '오해를 분식하고 싶다.', 2);

  -- 356. とっさに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'とっさに', '순간적으로, 순간적으로', NULL, '부사', 356) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とっさに身をかわした。', '순간적으로 몸을 피했다.', 1),
    (w, 'とっさに言い訳をした。', '순간적으로 변명을 했다.', 2);

  -- 357. いやみ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'いやみ', '빈정거림, 랜답거리기', NULL, '명사', 357) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いやみを言う。', '빈정거림을 말한다.', 1),
    (w, 'いやみったたらしい言い方だ。', '빈정거리는 듯한 말투다.', 2);

  -- 358. 丹念に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '丹念に', 'たんねんに', '정성스레', '丹(붉을 단): 주석·단제\n念(생각·한와 년): 今+心', '부사', 358) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丹念に仕上げた作品だ。', '정성스레 마무리한 작품이다.', 1),
    (w, '丹念に調査した。', '정성스레 조사했다.', 2);

  -- 359. なじむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'なじむ', '친숙해지다', NULL, '동사', 359) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい環境になじんだ。', '새로운 환경에 친숙해졌다.', 1),
    (w, '上司となじめない。', '상사와 친해지지 않는다.', 2);

  -- 360. はかどる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'はかどる', '일이 진첩되다', NULL, '동사', 360) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事がはかどらない。', '일이 진첩되지 않는다.', 1),
    (w, '勉強がはかどる。', '공부가 진첩된다.', 2);

  -- 361. 張り合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '張り合う', 'はりあう', '맞붙다, 경쟁하다', '張(베풀 장)\n合(합할 합)', '동사', 361) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ライバルと張り合う。', '라이벌과 맞서다.', 1),
    (w, '子供同士が張り合った。', '아이끼리 경쟁했다.', 2);

  -- 362. まばらだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'まばらだ', '드물다', NULL, 'な형용사', 362) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人館がまばらだ。', '사람 그림자가 드물다.', 1),
    (w, 'そんな話はまばらだ。', '그런 이야기는 드물다.', 2);

  -- 363. 見合わせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見合わせる', 'みあわせる', '보류하다, 일시 중지하다', '見(볼 견)\n合わせる: 맞춰다', '동사', 363) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発を見合わせた。', '출발을 보류했다.', 1),
    (w, '買うのを見合わせた。', '사는 것을 보류했다.', 2);

  -- 364. やむをえず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'やむをえず', '어쩔 수 없이', NULL, '부사', 364) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やむをえず中止した。', '어쩔 수 없이 중지했다.', 1),
    (w, 'やむをえず謝った。', '어쩔 수 없이 사과했다.', 2);

  -- 365. ルーズな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ルーズな', 'るーずな', '늨슬한, 고수적이지 못한', NULL, 'な형용사', 365) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金銘にルーズな人だ。', '돈 관리에 늨슬한 사람이다.', 1),
    (w, '帰りがルーズだ。', '시간 약속이 늨슬하다.', 2);

  -- 366. 朗報
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '朗報', 'ろうほう', '낭보', '朗(밝을 랑): 良+月 → 좋은 달\n報(알릴 보): 幸+报 → 행복을 편지로 알림', '명사', 366) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格の朗報が入った。', '합격이라는 낭보가 들어왔다.', 1),
    (w, '朗報を伝える。', '낭보를 전한다.', 2);

  -- 367. わずらわしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'わずらわしい', '번거롭다, 귀찮다', NULL, 'い형용사', 367) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳しい手続きがわずらわしい。', '자세한 절차가 번거롭다.', 1),
    (w, '人間関係がわずらわしい。', '인간관계가 번거롭다.', 2);

  -- 368. あっけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'あっけない', '허무하다, 시시하다', NULL, 'い형용사', 368) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あっけない結末だった。', '허무한 결말이었다.', 1),
    (w, 'あっけないぐらい簡単に勝った。', '허무할 정도로 쉬운게 이겼다.', 2);

  -- 369. ありきたりの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ありきたりの', '흔해 빠진', NULL, '연체·수식어', 369) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありきたりの意見だ。', '흔해 빠진 의견이다.', 1),
    (w, 'ありきたりのメッセージだった。', '흔해 빠진 메시지였다.', 2);

  -- 370. 画期的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '画期的な', 'かっきてきな', '획기적인', '画(그림 화)\n期(기약 기): 其+月 → 일정한 시점', 'な형용사', 370) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画期的な発明だ。', '획기적인 발명이다.', 1),
    (w, '画期的な出作だ。', '획기적인 작품이다.', 2);

  -- 371. 極力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '極力', 'きょくりょく', '극력, 최선을 다해', '極(다할 극): 木+亱 → 뛡의 골리\n力(힘 력)', '부사', 371) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '極力黑めるよう努る。', '최선을 다해 피하도록 노력한다.', 1),
    (w, '極力低価格で提供する。', '최대한 낮은 가격으로 제공한다.', 2);

  -- 372. コントラスト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'コントラスト', 'こんとらすと', '콘트라스트, 대비', NULL, '명사', 372) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '色のコントラストが鮮やかだ。', '색깔의 대비가 선명하다.', 1),
    (w, '両者のコントラストが明らかだ。', '양자의 상이가 분명하다.', 2);

  -- 373. シビアな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'シビアな', 'しびあな', '가혹한, 엄격한', NULL, 'な형용사', 373) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シビアな評価を受けた。', '엄격한 평가를 받았다.', 1),
    (w, 'シビアな職場の現実だ。', '가혹한 직장의 현실이다.', 2);

  -- 374. 重宝する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '重宝する', 'ちょうほうする', '유용하게 쓰다', '重(소중할 중): 里+千 → 천 곡\n宝(보배 보): 宀+玉 → 집안 너마·올색기', '동사', 374) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道具は重宝している。', '이 도구는 유용하게 쓰고 있다.', 1),
    (w, '多才な人として重宝される。', '다재다능한 사람으로 중시된다.', 2);

  -- 375. 手がかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手がかり', 'てがかり', '실마리, 단서', '手(손 수)\nかり: 걸림', '명사', 375) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の手がかりをつかむ。', '사건의 실마리를 잡는다.', 1),
    (w, '解決の手がかりがない。', '해결의 실마리가 없다.', 2);

  -- 376. にわかには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'にわかには', '썯새도, 당장은', NULL, '부사', 376) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'にわかには信じられない。', '썯새도 믿어지지 않는다.', 1),
    (w, 'にわかには動けない。', '당장은 움직일 수 없다.', 2);

  -- 377. もくろむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もくろむ', '계획하다, 꾸뮸다', NULL, '동사', 377) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '起業をもくろむ。', '창업을 꾸뮼다.', 1),
    (w, '逆転をもくろむ。', '역전을 꾸뮼다.', 2);

  -- 378. 落胆する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '落胆する', 'らくたんする', '낙담하다', '落(떨어질 락): 일+洛 → 풀이 시들어 떨어짐\n胆(쓡개 담): 고기+詹', '동사', 378) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不合格に落胆した。', '불합격에 낙담했다.', 1),
    (w, '試合に負けて落胆した。', '시합에 져서 낙담했다.', 2);

  -- 379. おっくうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おっくうだ', '귀찮다, 하기 싫다', NULL, 'な형용사', 379) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけるのがおっくうだ。', '나가기가 귀찮다.', 1),
    (w, '勉強がおっくうだ。', '공부가 귀찮다.', 2);

  -- 380. おのずと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おのずと', '저절로, 자연히', NULL, '부사', 380) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がおのずと下がった。', '고개가 저절로 숙여졌다.', 1),
    (w, '実力がつけばおのずと認められる。', '실력이 쌓이면 자연히 인정받게 된다.', 2);

  -- 381. 簡素だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '簡素だ', 'かんそだ', '간소하다', '簡(대쉭 간): 竹+間 → 대나무 책\n素(흡 소): 主+糸 → 원래의 색 실', 'な형용사', 381) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡素な生活を送る。', '간소한 생활을 한다.', 1),
    (w, '簡素なデザインだ。', '간소한 디자인이다.', 2);

  -- 382. けなされる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'けなされる', '헐뜨김 당하다', NULL, '동사', 382) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品がけなされた。', '작품이 헐뜨긴다.', 1),
    (w, '考えをけなされて舐ろした。', '생각이 헐뜨겨 낙심했다.', 2);

  -- 383. しきりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しきりに', '자꾸, 끊임없이', NULL, '부사', 383) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しきりに電話が鳴る。', '자꾸 전화가 울린다.', 1),
    (w, 'しきりに評価されている。', '자꾸 평가받고 있다.', 2);

  -- 384. 触発される
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '触発される', 'しょくはつされる', '촉발되다', '触(늿을 촉): 角+蜀 → 뿔으로 차·돫\n発(펼 발)', '동사', 384) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他の作品に触発された。', '다른 작품에 자극받았다.', 1),
    (w, 'その話に触発されて始めた。', '그 이야기에 자극을 받아 시작했다.', 2);

  -- 385. すがすがしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すがすがしい', '상쿾하다', NULL, 'い형용사', 385) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝の空気がすがすがしい。', '아침 공기가 상쿾하다.', 1),
    (w, 'すがすがしい風が吹く。', '상쿾한 바람이 불어온다.', 2);

  -- 386. スケール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スケール', 'すけーる', '스케일, 규모', NULL, '명사', 386) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スケールの大きい計画だ。', '규모가 큰 계획이다.', 1),
    (w, 'スケールアップさせる。', '규모를 키운다.', 2);

  -- 387. 先方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '先方', 'せんぽう', '상대편', '先(먼저 선)\n方(모 방): 장소', '명사', 387) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先方の都合を評く。', '상대편의 사정을 듣는다.', 1),
    (w, '先方と連絡を取る。', '상대편과 연락을 취한다.', 2);

  -- 388. 断念する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '断念する', 'だんねんする', '단념하다', '断(끊을 단): 米+斤\n念(생각 념): 今+心', '동사', 388) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出場を断念した。', '출전을 단념했다.', 1),
    (w, '夛を断念した。', '꿈을 단념했다.', 2);

  -- 389. 当面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '当面', 'とうめん', '당면, 당분간', '当(마끜할 당): 小+田\n面(냭 면)', '명사', 389) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '当面の課題を解決する。', '당면의 과제를 해결한다.', 1),
    (w, '当面はこれでそだ。', '당분간은 이걸로 될 것이다.', 2);

  -- 390. 密かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '密かに', 'ひそかに', '은밀히', '密(비밀 밀): 宀+必+山 → 산에 숨김', '부사', 390) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '密かに計画を進める。', '은밀히 계획을 진행한다.', 1),
    (w, '密かに顔を見る。', '몰래 얼굴을 본다.', 2);

  -- 391. あらかじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'あらかじめ', '미리, 사전에', NULL, '부사', 391) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あらかじめ予約した。', '미리 예약했다.', 1),
    (w, 'あらかじめ見ておく。', '사전에 보아 둔다.', 2);

  -- 392. 裏づけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '裏づけ', 'うらづけ', '뻗받침, 증거', '裏(속 리): 衣+里\nづけ: 붙임', '명사', 392) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '裏づけとなる事実。', '뻗받침이 되는 사실.', 1),
    (w, '裏づけをとる。', '뻗받침을 취한다.', 2);

  -- 393. おおむね
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おおむね', '대쪽, 대제로', NULL, '부사', 393) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおむね了解した。', '대쪽 이해했다.', 1),
    (w, 'おおむね予想通りだ。', '대철 예상대로다.', 2);

  -- 394. 仰天する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仰天する', 'ぎょうてんする', '깜짝 놀라다', '仰(우러러볼 앙): 亻+卯 → 사람이 우러러봄\n天(하늘 천)', '동사', 394) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の高さに仰天した。', '가격의 높이에 놀랐다.', 1),
    (w, '意外な結果に仰天した。', '의외의 결과에 깜짝 놀랐다.', 2);

  -- 395. ことごとく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ことごとく', '하나하나, 전부', NULL, '부사', 395) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画がことごとく失敗した。', '계획이 하나하나 실패했다.', 1),
    (w, 'ことごとく説明をした。', '전부 설명을 했다.', 2);

  -- 396. 雑踏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '雑踏', 'ざっとう', '잡답, 혼잡함', '雑(섮일 잡): 衣+隻\n踏(밟을 답): 足+水', '명사', 396) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雑踏の中を歩く。', '인파 속을 걷는다.', 1),
    (w, '駅は雑踏していた。', '역은 혼잡했다.', 2);

  -- 397. 従来の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '従来の', 'じゅうらいの', '종래의', '従(좌을 종)\n来(올 래): 올 때까지', '연체·수식어', 397) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '従来の方法を見直す。', '종래의 방법을 재검토한다.', 1),
    (w, '従来のシステムとは違う。', '종래의 시스템과 다르다.', 2);

  -- 398. すべ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すべ', '방법, 수단', NULL, '명사', 398) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なすすべもない。', '어첨할 방법이 없다.', 1),
    (w, 'もうすべもない。', '이제 수단이 없다.', 2);

  -- 399. せかす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'せかす', '재촉하다', NULL, '동사', 399) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼をせかして出かけた。', '그를 재촉해 나갔다.', 1),
    (w, 'ばやく動けとせかされた。', '빨리 움직이라고 재촉당했다.', 2);

  -- 400. バックアップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'バックアップ', 'ばっくあっぷ', '백업, 지원', NULL, '명사', 400) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'データをバックアップする。', '데이터를 백업한다.', 1),
    (w, '仲間のバックアップを受ける。', '동료의 지원을 받는다.', 2);

  -- 401. 抜群だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '抜群だ', 'ばつぐんだ', '뛰어나다', '抜(빼어낼 발): 手+友·友 → 손으로 빼냄\n群(무리 군): 君+羊', 'な형용사', 401) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶力は抜群だ。', '기억력은 타의 추종을 불허한다.', 1),
    (w, '抜群の成績だ。', '뛰어난 성적이다.', 2);

  -- 402. メカニズム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'メカニズム', 'めかにずむ', '메카니즘', NULL, '명사', 402) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体のメカニズムを学ぶ。', '몸의 메카니즘을 배운다.', 1),
    (w, '仰事のメカニズムを理解する。', '일의 메카니즘을 이해한다.', 2);

  -- 403. 案の定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '案の定', 'あんのじょう', '아닌게 아닌으로, 아니나 다를까', '案(책상 안)\n定(정할 정)', '부사', 403) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '案の定雨が降った。', '아니나 다를까 비가 내렸다.', 1),
    (w, '案の定入診した。', '예상대로 입원했다.', 2);

  -- 404. いたって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'いたって', '매우, 아주', NULL, '부사', 404) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いたって健康だ。', '매우 건강하다.', 1),
    (w, 'いたって逆りはない。', '그닥치 별일 없다.', 2);

  -- 405. 打ち込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '打ち込む', 'うちこむ', '열중하다', '打: 치다\n込む: 안으로 들어가다', '동사', 405) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に打ち込む。', '일에 열중한다.', 1),
    (w, '研究に打ち込んだ。', '연구에 못한 열중을 했다.', 2);

  -- 406. お手上げだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'お手上げだ', 'おてあげだ', '속수무책이다', NULL, 'な형용사', 406) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題はお手上げだ。', '이 문제는 속수무책이다.', 1),
    (w, 'こうなってはお手上げだ。', '이렇게 되면 속수무책이다.', 2);

  -- 407. 回想する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '回想する', 'かいそうする', '회상하다', '回(돌아올 회): 움직임\n想(생각할 상)', '동사', 407) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学生時代を回想する。', '학생 시절을 회상한다.', 1),
    (w, '他人との思い出を回想する。', '옥주와의 추억을 회상한다.', 2);

  -- 408. 格段に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '格段に', 'かくだんに', '견주, 혜씀', '格(격식 격): 木+各 → 나무로 격자\n段(쪼건이 단): 殳+段 → 계단 단', '부사', 408) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年は格段に審い。', '올해는 혜씀 추다.', 1),
    (w, '格段に都合がよくなった。', '핌썬 좋아졌다.', 2);

  -- 409. ストレートに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ストレートに', 'すとれーとに', '소직히, 직접적으로', NULL, '부사', 409) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレートに意見を言う。', '직설적으로 의견을 말한다.', 1),
    (w, 'ストレートに表現する。', '직설적으로 표현한다.', 2);

  -- 410. 手分けする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手分けする', 'てわけする', '분담하다', '手(손 수)\n分(나눌 분)', '동사', 410) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を手分けしてやる。', '일을 분담해서 한다.', 1),
    (w, '扛した荷物を手分けした。', '짐을 분담했다.', 2);

  -- 411. 不用意な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不用意な', 'ふよういな', '부주의한, 조심성 없는', '不(아닌 부)\n用意: 준비', 'な형용사', 411) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不用意な発言をした。', '부주의한 발언을 했다.', 1),
    (w, '不用意に接してそうだ。', '부주의하게 만진 것 같다.', 2);

  -- 412. 無償
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '無償', 'むしょう', '무상', '無: 없음\n償(갚을 상): 亻+賞 → 상을 갗', '명사', 412) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無償で提供される。', '무상으로 제공된다.', 1),
    (w, '無償サービスを受けた。', '무상 서비스를 받았다.', 2);

  -- 413. 厄介な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '厄介な', 'やっかいな', '성가신, 귀찮은', '厄(곤액할 액): 상황·재난\n介(끼일 개)', 'な형용사', 413) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厄介な仕事を代たされた。', '귀찮은 일을 떠맡게 되었다.', 1),
    (w, '厄介な人と関わった。', '성가신 사람과 엮혀다.', 2);

  -- 414. ありふれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ありふれる', '흔하다, 흔하게 있다', NULL, '동사', 414) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありふれた話だ。', '흔한 이야기다.', 1),
    (w, 'ありふれたデザインだ。', '흔한 디자인이다.', 2);

  -- 415. 糸口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '糸口', 'いとぐち', '실마리, 단서', '糸(실 사): 실타래\n口(입 구)', '명사', 415) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の糸口をつかむ。', '사건의 실마리를 잡는다.', 1),
    (w, '解決の糸口が見えた。', '해결의 실마리가 보였다.', 2);

  -- 416. うろたえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'うろたえる', '당황하다', NULL, '동사', 416) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予期せぬ質問にうろたえた。', '예기치 못한 질문에 당황했다.', 1),
    (w, '逆境にうろたえる。', '역경에 당황한다.', 2);

  -- 417. 苦情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '苦情', 'くじょう', '고정, 클레임', '苦(쓸 고): 艸+古 → 풀이 쓴\n情(뜿 정)', '명사', 417) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦情を言う。', '불평을 말한다.', 1),
    (w, '人能上より苦情が出た。', '인공능으로부터 대한 클레임이 나왔다.', 2);

  -- 418. 互角だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '互角だ', 'ごかくだ', '호각이다, 대등하다', '互(서로 호): 파동 모양\n角(뿔 각)', 'な형용사', 418) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両チームの実力は互角だ。', '두 팀의 실력은 호각이다.', 1),
    (w, '互角の勝負を繰り広げた。', '호각의 승부를 벌였다.', 2);

  -- 419. 誇張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '誇張', 'こちょう', '과장', '誇(자랑할 과): 言+夺\n張(베풀 장)', '명사', 419) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誇張して話す。', '과장해서 말한다.', 1),
    (w, '誇張表現を領ける。', '과장 표현을 피한다.', 2);

  -- 420. 錯覚する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '錯覚する', 'さっかくする', '착각하다', '錯(섮일 착): 金+昔\n覚(깨달을 각)', '동사', 420) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を錯覚していた。', '상황을 착각하고 있었다.', 1),
    (w, '主評は錯覚だった。', '주관은 착각이었다.', 2);

  -- 421. 殺到する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '殺到する', 'さっとうする', '쇄도하다', '殺(죽일 살): 乂+殳\n到(이를 도): 至+刀', '동사', 421) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問が殺到した。', '질문이 쇄도했다.', 1),
    (w, '注文が殺到している。', '주문이 쇄도하고 있다.', 2);

  -- 422. 仕上がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仕上がる', 'しあがる', '완성되다', '仕(벼슴 사)\n上(올릴 상)', '동사', 422) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品が仕上がった。', '작품이 완성되었다.', 1),
    (w, 'レポートが仕上がる。', '리포트가 완성된다.', 2);

  -- 423. 助言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '助言', 'じょげん', '조언', '助(도울 조)\n言(말씀 언)', '명사', 423) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '助言を諸る。', '조언을 구한다.', 1),
    (w, '貴重な助言がもらえた。', '귀중한 조언을 받았다.', 2);

  -- 424. 不意に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不意に', 'ふいに', '불의에, 갑자기', '不: 아닌\n意(뜻 의)', '부사', 424) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不意に訪れた客。', '불시에 찾아온 손님.', 1),
    (w, '不意に雨が降った。', '갑자기 비가 내렸다.', 2);

  -- 425. 弁解する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '弁解する', 'べんかいする', '변명하다', '弁(고깔 변): 奓+备 → 분별\n解(풀 해)', '동사', 425) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅刻の理由を弁解する。', '지각의 이유를 변명한다.', 1),
    (w, '弁解の余地がない。', '변명의 여지가 없다.', 2);

  -- 426. 安堵する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '安堵する', 'あんどする', '안도하다', '安(편안할 안): 집안 여자\n堵(막을 도): 이견을 막음', '동사', 426) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無事に計画が進み安堵した。', '무사히 계획이 진행되어 안도했다.', 1),
    (w, 'そのニュースに安堵した。', '그 소식에 안도했다.', 2);

  -- 427. 意気込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '意気込み', 'いきごみ', '의욕, 포부', '意(뜻 의)\n気(기운 기)', '명사', 427) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事への意気込みを語る。', '일에 대한 의욕을 이야기한다.', 1),
    (w, '意気込みが違う。', '의욕이 다르다.', 2);

  -- 428. おびえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おびえる', '곁에 질리다', NULL, '동사', 428) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雷におびえる。', '천둥에 곁에 질린다.', 1),
    (w, '危険におびえる。', '위험에 곁에 질린다.', 2);

  -- 429. かねがね
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'かねがね', '이전부터, 진작', NULL, '부사', 429) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かねがね考えていた。', '이전부터 생각하고 있었다.', 1),
    (w, 'かねがね見たいと思っていた。', '진작부터 보고 싶어 했다.', 2);

  -- 430. かろうじて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'かろうじて', '간신히, 결울각재로', NULL, '부사', 430) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かろうじて間に合った。', '간신히 제시간에 대었다.', 1),
    (w, 'かろうじて勝った。', '이주 겄우 이겼다.', 2);

  -- 431. 故意に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '故意に', 'こいに', '고의로, 일부러', '故(속섬 고): 古+攵\n意(뜻 의)', '부사', 431) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '故意に負けた。', '일부러 젼다.', 1),
    (w, '故意に誤りを犯した。', '고의로 실수를 했다.', 2);

  -- 432. ささいな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ささいな', '사소한, 하찮은', NULL, 'な형용사', 432) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ささいなことで誉嘘した。', '사소한 일로 싸웠다.', 1),
    (w, 'ささいな間違いを見つけた。', '사소한 실수를 찾아냈다.', 2);

  -- 433. 自尊心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '自尊心', 'じそんしん', '자존심', '自(스스로 자)\n尊(높을 존): 酉+寸 → 술을 받들어 높임', '명사', 433) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自尊心を傷つけられた。', '자존심이 상했다.', 1),
    (w, '自尊心を守りたかった。', '자존심을 지키고 싶었다.', 2);

  -- 434. 戸惑う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '戸惑う', 'とまどう', '당황하다', '戸(집 호)\n惑(미혹할 혹): 惑+心 → 일이·마음을 잊음', '동사', 434) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に戸惑った。', '질문에 당황했다.', 1),
    (w, '状況に戸惑うばかりだ。', '상황에 당황할 뿐이다.', 2);

  -- 435. 端的に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '端的に', 'たんてきに', '단적으로, 명백하게', '端(끝 단): 立+屯 → 끝에 서 있음', '부사', 435) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '端的に言うと反対だ。', '단적으로 말하면 반대다.', 1),
    (w, '端的に評明した。', '명백하게 설명했다.', 2);

  -- 436. 詫びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '詫びる', 'わびる', '사과하다', '詫(사과할 타): 言+于 → 사과·명부', '동사', 436) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れて詫びた。', '늦어서 사과했다.', 1),
    (w, '詫びてしまう評だ。', '사과하고 마는 성격이다.', 2);

  -- 437. うすうす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'うすうす', '희미하게, 어렌풋이', NULL, '부사', 437) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うすうす勘づいていた。', '어렌풋이 눈치채고 있었다.', 1),
    (w, '本当だとうすうす思っていた。', '사실이라고 희미하게 생각하고 있었다.', 2);

  -- 438. 照会する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '照会する', 'しょうかいする', '조회하다, 문의하다', '照(비칠 조): 昭+火\n会(모일 회)', '동사', 438) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行で残高を照会した。', '은행에서 잔고를 조회했다.', 1),
    (w, '務品の絍付を照会する。', '상품의 납품을 문의한다.', 2);

  -- 439. 難点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '難点', 'なんてん', '난점', '難(어려울 난)\n点(점 점)', '명사', 439) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この計画の難点を評べる。', '이 계획의 난점을 따진다.', 1),
    (w, '難点を克服したい。', '난점을 극복하고 싶다.', 2);

  -- 440. 入念に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '入念に', 'にゅうねんに', '정성스레', '入(들 입)\n念(생각할 념)', '부사', 440) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入念にチェックする。', '정성스레 체크한다.', 1),
    (w, '入念に仕上げた。', '정성스래 마무리했다.', 2);

  -- 441. 粘り強く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '粘り強く', 'ねばりづよく', '끈기있게', '粘(찰긴 점)\n強(강할 강)', '부사', 441) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '粘り強く交渉した。', '끈질기게 협상했다.', 1),
    (w, '粘り強く取り組む。', '끈기있게 임했다.', 2);

  -- 442. むっとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'むっとする', '못마때하다, 화난 얼굴을 하다', NULL, '동사', 442) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一言でむっとした。', '한마디에 화다 얼굴을 했다.', 1),
    (w, 'むっとした表情を見せた。', '화난 표정을 지었다.', 2);

  -- 443. 決意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '決意', 'けつい', '결의', '決(결정 결): 氵+夬\n意(뜻 의)', '명사', 443) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '固い決意を誘めた。', '굳은 결의를 입어주어너.', 1),
    (w, '決意を社社した。', '결의를 풌회했다.', 2);

  -- 444. ゆとり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ゆとり', '여유, 여유로움', NULL, '명사', 444) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間にゆとりがある。', '시간에 여유가 있다.', 1),
    (w, '心にゆとりを持つ。', '마음에 여유를 가진다.', 2);

  -- 445. 若干
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '若干', 'じゃっかん', '약간', '若(같을 약): 艸+右\n干(방패 간)', '부사', 445) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若干価格が上がった。', '약간 가격이 올랐다.', 1),
    (w, '若干名の不足だ。', '약간명 부족하다.', 2);

  -- 446. 撤回
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '撤回', 'てっかい', '철회', '撤(거둘 철)\n回(돌이킬 회)', '명사', 446) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '発言を撤回する。', '발언을 철회한다.', 1),
    (w, '計画を撤回した。', '계획을 철회했다.', 2);

  -- 447. 競い合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '競い合う', 'きそいあう', '서로 다투다', '競(다투 경): 立+兄 → 서서·형제\n合(합할 합)', '동사', 447) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両社がシェアを競い合う。', '양사가 점유율을 다툠다.', 1),
    (w, '選手同士が競い合う。', '선수끼리 다투다.', 2);

  -- 448. かたくなな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'かたくなな', '완고한, 고집스러운', NULL, 'な형용사', 448) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かたくな態度を取る。', '완고한 태도를 취한다.', 1),
    (w, 'かたくなに拒む。', '완강하게 거부한다.', 2);

  -- 449. すみやかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'すみやかに', '신속히, 재빨리', NULL, '부사', 449) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すみやかに対応した。', '신속히 대응했다.', 1),
    (w, 'すみやかに報告するように。', '신속히 보고해라.', 2);

  -- 450. ぼんやり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ぼんやり', '멍하다, 흔릿하다', NULL, '부사', 450) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼんやり考えていた。', '멍하게 생각하고 있었다.', 1),
    (w, 'ぼんやりした記憶だ。', '흔릿한 기억이다.', 2);

  -- 451. 妨害する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '妨害する', 'ぼうがいする', '방해하다', '妨(방해 방): 女+方 → 여자 주변이 소란\n害(해할 해): 宀+丰+口', '동사', 451) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作業を妨害する。', '작업을 방해한다.', 1),
    (w, '交通を妨害した。', '교통을 방해했다.', 2);

  -- 452. エレガントな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'エレガントな', 'えれがんとな', '우아한, 고상한', NULL, 'な형용사', 452) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'エレガントなドレスだ。', '우아한 드레스다.', 1),
    (w, 'エレガントに振る舞う。', '고상하게 행동한다.', 2);

  -- 453. つかの間の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'つかの間の', 'つかのまの', '잠시의, 순간적인', NULL, '연체·수식어', 453) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つかの間の休息だった。', '잠시의 휴식이었다.', 1),
    (w, 'つかの間の幸せだ。', '잠시의 행복이다.', 2);

  -- 454. しくじる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しくじる', '실수하다', NULL, '동사', 454) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画をしくじった。', '계획에서 실수했다.', 1),
    (w, '試験をしくじった。', '시험을 실수했다.', 2);

  -- 455. スライスする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スライスする', 'すらいすする', '주점어서 자르다', NULL, '동사', 455) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パンをスライスする。', '빵을 주점어서 자른다.', 1),
    (w, '肉を薄くスライスする。', '고기를 얇게 자른다.', 2);

  -- 456. めいめいに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'めいめいに', '각자, 각자가', NULL, '부사', 456) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めいめいに買う。', '각자 산다.', 1),
    (w, 'めいめいに帰る。', '각자 집에 간다.', 2);

  -- 457. 手立て
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手立て', 'てだて', '방책, 수단', '手(손 수)\n立(설 립)', '명사', 457) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他に手立てがない。', '다른 방책이 없다.', 1),
    (w, '手立てを考える。', '방책을 고민한다.', 2);

  -- 458. ありありと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ありありと', '서서히, 생생히', NULL, '부사', 458) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありありと思い出す。', '생생히 떠올린다.', 1),
    (w, '当時の光景がありありと見える。', '당시의 장면이 생생하게 보인다.', 2);

  -- 459. 返事をしぶる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '返事をしぶる', 'へんじをしぶる', '대답을 꾸물거리다', NULL, '동사', 459) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '返事をしぶり始めた。', '대답을 꾸물거리기 시작했다.', 1),
    (w, '何もしぶり、返事をしてくれない。', '꾸물거리며 대답해 주지 않는다.', 2);

  -- 460. コンパクトな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'コンパクトな', 'こんぱくとな', '컴팩트한, 소형의', NULL, 'な형용사', 460) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンパクトな車が人気だ。', '소형 차가 인기있다.', 1),
    (w, 'コンパクトに收まるサイズだ。', '컴팩트하게 들어가는 사이즈다.', 2);

  -- 461. つぶやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'つぶやく', '중얼거리다, 혼잣말하다', NULL, '동사', 461) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不満をつぶやく。', '불만을 중얼거린다.', 1),
    (w, 'ひとりごとをつぶやく。', '혼자말을 중얼거린다.', 2);

  -- 462. 不審な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不審な', 'ふしんな', '수상한', '不: 아닌\n審(살펼 심)', 'な형용사', 462) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不審な人物を見かけた。', '수상한 인물을 보았다.', 1),
    (w, '不審な車が騻車している。', '수상한 차가 주차되어 있다.', 2);

  -- 463. ばてる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ばてる', '지치다', NULL, '동사', 463) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間の助長でばてた。', '장시간의 조장으로 지쳐 있다.', 1),
    (w, '暑さにばてる。', '더위에 지쳐있다.', 2);

  -- 464. まっとうする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'まっとうする', '완수하다, 끝내다', NULL, '동사', 464) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '任務をまっとうした。', '임무를 완수했다.', 1),
    (w, '人生をまっとうする。', '인생을 완수한다.', 2);

  -- 465. 異例の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '異例の', 'いれいの', '이례적인', '異(다를 이)\n例(법식 례)', '연체·수식어', 465) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '異例の抹擢がとられた。', '이례적인 발취가 이루어졌다.', 1),
    (w, '異例のスピードだ。', '이례적인 스피드다.', 2);

  -- 466. 熱中する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '熱中する', 'ねっちゅうする', '열중하다', '熱(더울 열): 势+火\n中(가운데 중)', '동사', 466) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ゲームに熱中している。', '게임에 열중하고 있다.', 1),
    (w, '勉強に熱中する。', '공부에 열중한다.', 2);

  -- 467. つぶさに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'つぶさに', '소상히, 자세히', NULL, '부사', 467) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件をつぶさに説明する。', '사건을 소상히 설명한다.', 1),
    (w, 'つぶさに検討する。', '자세히 검토한다.', 2);

  -- 468. 脈絡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '脈絡', 'みゃくらく', '맥락', '脈(줄기 맥)\n絡(얽을 락)', '명사', 468) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の脈絡がわからない。', '이야기의 맥락을 모르겠다.', 1),
    (w, '事件の脈絡を読み取る。', '사건의 맥락을 읽는다.', 2);

  -- 469. 吟味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '吟味', 'ぎんみ', '음미, 숨은 뜻을 뜨어분', '吟(읊을 음): 口+今\n味(맛 미)', '명사', 469) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えを吟味する。', '생각을 음미한다.', 1),
    (w, '作品の出改を吟味する。', '작품의 맛을 음미한다.', 2);

  -- 470. エキスパート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'エキスパート', 'えきすぱーと', '전문가, 익스퍼트', NULL, '명사', 470) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その分野のエキスパートだ。', '그 분야의 전문가다.', 1),
    (w, 'エキスパートに相談する。', '전문가에게 상담한다.', 2);

  -- 471. 凝視する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '凝視する', 'ぎょうしする', '응시하다', '凝(엉길 응): 冰+疑\n視(볼 시): 示+見', '동사', 471) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画面を凝視した。', '화면을 응시했다.', 1),
    (w, '中空を凝視する。', '허공을 응시한다.', 2);

  -- 472. 架空
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '架空', 'かくう', '가공', '架(시렁 가): 加+木\n空(빌 공)', '명사', 472) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '架空の人物だ。', '가공의 인물이다.', 1),
    (w, '架空の世界を描く。', '가공의 세계를 그린다.', 2);

  -- 473. ぼやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ぼやく', '투델대다, 투렕거리다', NULL, '동사', 473) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不遇をぼやく。', '불운을 투델대다.', 1),
    (w, '上司にぼやくりしている。', '상사에 대해 투델거리고 있다.', 2);

  -- 474. 寡黙な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '寡黙な', 'かもくな', '과묵한, 말수가 적은', '寡(적을 과): 宀+頃 → 집안이 조용\n黙(잠잠할 묵)', 'な형용사', 474) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寡黙な人だ。', '과묵한 사람이다.', 1),
    (w, '寡黙に作業している。', '말없이 작업하고 있다.', 2);

  -- 475. 紛糾する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '紛糾する', 'ふんきゅうする', '분규하다, 혼란해지다', '紛(어지러울 분): 糸+分\n糾(어지러울 규): 糸+丩', '동사', 475) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '議論が紛糾した。', '논의가 분규했다.', 1),
    (w, '交渉が紛糾した。', '협상이 혼란해졌다.', 2);

  -- 476. ずれ込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ずれ込む', 'ずれこむ', '지연되다, 늦어지다', 'ずれ: 어긋남\n込む: 안으로 들어가다', '동사', 476) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議が夜にずれ込ほだ。', '회의가 밤까지 이어질 것 같다.', 1),
    (w, '出荷が一週間ずれ込んだ。', '출하가 일주일 늦어졌다.', 2);

  -- 477. ろくに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ろくに', '제대로, 충분히', NULL, '부사', 477) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ろくに休めない。', '제대로 쉬지 못한다.', 1),
    (w, 'ろくに読まずに提出した。', '제대로 읽지도 않고 제출했다.', 2);

  -- 478. 貢献
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '貢献', 'こうけん', '공헌', '貢(바칠 공): 工+貝 → 재물을 바침\n献(드릴 헌)', '명사', 478) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に貢献した。', '사회에 공헌했다.', 1),
    (w, '学問に貢献する研究だ。', '학문에 공헌하는 연구다.', 2);

  -- 479. 絶賛する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '絶賛する', 'ぜっさんする', '극찬하다', '絶(끊을 절)\n賛(기릴 찬)', '동사', 479) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を絶賛した。', '작품을 극찬했다.', 1),
    (w, '評論家が絶賛した。', '평론가가 극찬했다.', 2);

  -- 480. くつろぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'くつろぐ', '편안하게 쉬다', NULL, '동사', 480) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家でくつろぐ。', '집에서 편안하게 쉬다.', 1),
    (w, 'そファでくつろいでいる。', '소파에서 느궼히 쉬고 있다.', 2);

  -- 481. うやむやに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'うやむやに', '흐지부지하게, 애매하게', NULL, '부사', 481) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話をうやむやにせずに許した。', '이야기를 흐지부지하지 않고 뚠렷이 말했다.', 1),
    (w, 'うやむやにした返事だ。', '애매한 대답이다.', 2);

  -- 482. 出馬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '出馬', 'しゅつば', '출마', '出(나올 출)\n馬(말 마)', '명사', 482) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選挙に出馬する。', '선거에 출마한다.', 1),
    (w, '出馬を表明した。', '출마를 표명했다.', 2);

  -- 483. 閉口する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '閉口する', 'へいこうする', '당황함, 질린', '閉(닫을 폐): 門+才 → 문을 닫음\n口(입 구)', '동사', 483) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あまりの話袖さに閉口した。', '너무 말이 많아 질렸다.', 1),
    (w, '暑さに閉口した。', '더위에 질렸다.', 2);

  -- 484. 気ままな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '気ままな', 'きままな', '제멋대로의, 자유로운', '気(기운 기)\nまま: 그대로', 'な형용사', 484) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気ままな生活を送る。', '제멋대로 생활한다.', 1),
    (w, '気ままに振る舞う。', '제멋대로 행동한다.', 2);

  -- 485. 調達する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '調達する', 'ちょうたつする', '조달하다', '調(고를 조): 言+周\n達(통달할 달)', '동사', 485) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資金を調達する。', '자금을 조달한다.', 1),
    (w, '原材料を調達した。', '원재료를 조달했다.', 2);

  -- 486. 温和な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '温和な', 'おんわな', '온화한, 온한한', '温(따뜻할 온): 氵+固+皿\n和(화할 화)', 'な형용사', 486) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '温和な人柄だ。', '온화한 인품이다.', 1),
    (w, '温和な気候の地域だ。', '온화한 기후의 지역이다.', 2);

  -- 487. スポット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スポット', 'すぽっと', '장소, 명소', NULL, '명사', 487) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人気スポットを訪れる。', '인기 명소를 방문한다.', 1),
    (w, '見るスポットが多い。', '볼 곳이 많다.', 2);

  -- 488. 拮抗する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '拮抗する', 'きっこうする', '팔팔하다, 우섬갌쟥이다', '拮(해봉할 깅): 手+吉\n抗(결를 항): 手+亢', '동사', 488) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両チームは拮抗している。', '두 팀은 우섬가리었다.', 1),
    (w, '互いに拮抗する勢い。', '서로 팔팔한 기세다.', 2);

  -- 489. 風当たり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '風当たり', 'かぜあたり', '세상의 비판', '風(바람 풍)\n当(마끜할 당)', '명사', 489) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身に風当たりを感じる。', '세상의 비판을 웹으로 감다.', 1),
    (w, '会社への風当たりが強い。', '회사에 대한 비판이 강하다.', 2);

  -- 490. あどけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'あどけない', '천진난만하다', NULL, 'い형용사', 490) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あどけない顔だ。', '천진난만한 얼굴이다.', 1),
    (w, 'あどけない笑顔を見せる。', '천진난만한 미소를 짓는다.', 2);

  -- 491. 懸念する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '懸念する', 'けねんする', '우려하다', '懸(매달 현): 縣+心\n念(생각할 념)', '동사', 491) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '女裝体を懸念している。', '안전을 우려하고 있다.', 1),
    (w, '事件の影響が懸念される。', '사건의 영향이 우려된다.', 2);

  -- 492. やつれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'やつれる', '초첨해지다', NULL, '동사', 492) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '病でやつれた。', '병으로 손죽은 모습이 되었다.', 1),
    (w, '心労でやつれる。', '심적으로 고생해 초첨해진다.', 2);

  -- 493. 奮闘する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '奮闘する', 'ふんとうする', '분투하다', '奮(떨칠 분): 大+隹+田\n闘(싸울 투)', '동사', 493) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事で奮闘している。', '일에 분투하고 있다.', 1),
    (w, '遺された人代で奮闘する。', '적은 인원으로 분투한다.', 2);

  -- 494. 不慮の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不慮の', 'ふりょの', '불의의, 이원치 않은', '不: 아닌\n慮(생각할 려)', '연체·수식어', 494) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不慮の事故に遭った。', '불의의 사고를 당했다.', 1),
    (w, '不慮の事態に備える。', '불의의 사태에 대비한다.', 2);

  -- 495. 根こそぎ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '根こそぎ', 'ねこそぎ', '뿌리채, 하나도 남김없이', '根(뿌리 근)\nそぎ: 근원', '부사', 495) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財産を根こそぎ取られた。', '재산을 올딩이 임셜다.', 1),
    (w, '記憶を根こそぎ失う。', '기억을 완전히 잃어버린다.', 2);

  -- 496. 没頭する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '没頭する', 'ぼっとうする', '몰두하다', '没(빠질 몰): 氵+沒\n頭(머리 두)', '동사', 496) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読書に没頭する。', '독서에 몰두한다.', 1),
    (w, '研究に没頭している。', '연구에 몰두하고 있다.', 2);

  -- 497. 尺度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '尺度', 'しゃくど', '척도, 기준', '尺(자 척): 尸+丶 → 잣대\n度(헤아릴 도)', '명사', 497) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '評価の尺度が違う。', '평가의 기준이 다르다.', 1),
    (w, '適切な尺度が必要だ。', '적절한 척도가 필요하다.', 2);

  -- 498. 辛抱する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '辛抱する', 'しんぼうする', '인내하다, 참다', '辛(매울 신)\n抱(안을 포): 手+包', '동사', 498) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜひ一個辛抱して下さい。', '조금만 참아 주세요.', 1),
    (w, '辛抱それず言ってしまった。', '참지 못하고 말해버렸다.', 2);

  -- 499. しきたり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しきたり', '관습, 관례', NULL, '명사', 499) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古いしきたりを守る。', '오래된 관려를 지킨다.', 1),
    (w, 'しきたりに従う。', '관습에 따른다.', 2);

  -- 500. 委託する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '委託する', 'いたくする', '위탁하다', '委(맡길 위): 禾+女\n託(맡길 탁)', '동사', 500) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仁事を委託する。', '일을 위탁한다.', 1),
    (w, '外部に委託した。', '외부에 위탁했다.', 2);

  -- 501. 爽やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '爽やかな', 'さわやかな', '상쿾한, 시원한', '爽(시원할 상)', 'な형용사', 501) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '爽やかな朝だ。', '상쿾한 아침이다.', 1),
    (w, '爽やかな笑顔を見せる。', '상쿾한 미소를 짓는다.', 2);

  -- 502. 工面する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '工面する', 'くめんする', '돈을 마련하다', '工(장인 공)\n面(냭 면)', '동사', 502) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資金を工面した。', '자금을 마련했다.', 1),
    (w, '生活費を工面する。', '생활비를 조달한다.', 2);

  -- 503. ぞんざいな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ぞんざいな', '헙량한, 조잡한', NULL, 'な형용사', 503) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぞんざいな言い方をする。', '헙량한 말투를 쓴다.', 1),
    (w, 'ぞんざいに取り扱う。', '조잡하게 다룬다.', 2);

  -- 504. うなだれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'うなだれる', '고개를 숙이다', NULL, '동사', 504) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '叱られてうなたれた。', '꾾짓어서 고개를 숙였다.', 1),
    (w, 'うなだれて謝った。', '고개를 숙이고 사과했다.', 2);

  -- 505. 打撃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '打撃', 'だげき', '타격', '打(칠 타)\n撃(칠 격)', '명사', 505) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '深刻な打撃を受けた。', '심각한 타격을 받았다.', 1),
    (w, '経済に打撃を与えた。', '경제에 타격을 주었다.', 2);

  -- 506. 手腕
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手腕', 'しゅわん', '수완, 수완을 발휘', '手(손 수)\n腕(팔 완)', '명사', 506) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画に手腕を発揮する。', '계획에 수완을 발휘한다.', 1),
    (w, '手腕を認められた。', '수완을 인정받았다.', 2);

  -- 507. ロスする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ロスする', 'ろすする', '손실, 손실하다', NULL, '동사', 507) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間をロスしてしまった。', '시간을 손실해버렸다.', 1),
    (w, '資源をロスしたくない。', '자원을 낭비하고 싶지 않다.', 2);

  -- 508. おろそかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'おろそかに', '소홀히, 소홀하게', NULL, '부사', 508) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強をおろそかにしてはいけない。', '공부를 소홀히 해서는 안 된다.', 1),
    (w, '仕事をおろそかにした。', '일을 소홀히 했다.', 2);

  -- 509. 目下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '目下', 'もっか', '목하, 바로 지금', '目(눈 목)\n下(아래 하)', '명사', 509) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目下調査中だ。', '목하 조사 중이다.', 1),
    (w, '目下の課題は何か。', '별단 병곥°〉을 해접 별°〉°〉.', 2);

  -- 510. 請け負う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '請け負う', 'うけおう', '적쟅해 맡다', '請(청할 청): 言+青\n負(짐을 부)', '동사', 510) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工事を請け負う。', '공사를 도급받는다.', 1),
    (w, '谟品を請け負った。', '부품을 도급받았다.', 2);

  -- 511. 進呈する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '進呈する', 'しんていする', '증정하다', '進(나아갈 진)\n呈(드릴 정): 口+壬', '동사', 511) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記念品を進呈した。', '기념품을 증정했다.', 1),
    (w, 'サンプルを進呈する。', '샘플을 증정한다.', 2);

  -- 512. 意地
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '意地', 'いじ', '고집, 장대', '意(뜻 의)\n地(땅 지)', '명사', 512) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意地を張る。', '고집을 부린다.', 1),
    (w, '意地悪だ。', '심술이 부린다.', 2);

  -- 513. 細心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '細心', 'さいしん', '세심, 매우 세심함', '細(가늘 세)\n心(마음 심)', '명사', 513) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '細心の注意を払う。', '세심한 주의를 쓴다.', 1),
    (w, '細心に計画を立てる。', '세심하게 계획을 세운다.', 2);

  -- 514. 賑わう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '賑わう', 'にぎわう', '붐비다, 번창하다', '賑(쇭소할 짐): 起+中', '동사', 514) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '装靴が賑わう。', '거리가 붐비고 있다.', 1),
    (w, 'イベントで賑わう会場。', '이벤트로 붐비는 행사장.', 2);

  -- 515. ひとまず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ひとまず', '일단, 우선', NULL, '부사', 515) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひとまず休憩しよう。', '일단 쉬자.', 1),
    (w, 'ひとまず完成した。', '일단 완성했다.', 2);

  -- 516. 発足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '発足', 'ほっそく', '발족, 출발', '発(펼 발)\n足(발 족)', '명사', 516) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいチームが発足した。', '새로운 팀이 발족했다.', 1),
    (w, '会社の発足を祝う。', '회사의 발족을 축하한다.', 2);

  -- 517. 満嗫する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '満嗫する', 'まんきつする', '만끈하다', '満(차을 만): 氵+兩\n嗫(언어술·딹콩 낙·낙)', '동사', 517) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休暇を満嗫した。', '휴가를 만끈했다.', 1),
    (w, '潜日を満嗫した一日だった。', '온종일 만낌한 하루였다.', 2);

  -- 518. 見落とす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見落とす', 'みおとす', '놓치다, 간과하다', '見(볼 견)\n落(떨어질 락)', '동사', 518) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な点を見落とした。', '중요한 점을 놓쳤다.', 1),
    (w, '細部を見落とさないように。', '세부를 놓치지 않도록.', 2);

  -- 519. 密集
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '密集', 'みっしゅう', '밀집', '密(비밀 밀)\n集(모일 집)', '명사', 519) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '住宅が密集している。', '주택이 밀집해 있다.', 1),
    (w, '密集地帯を避ける。', '밀집 지역을 피한다.', 2);

  -- 520. 質素な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '質素な', 'しっそな', '검소한, 소박한', '質(바탕 질): 斞+貝\n素(흡 소)', 'な형용사', 520) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質素な生活を送る。', '검소한 생활을 한다.', 1),
    (w, '質素な服装だ。', '소박한 옷차림이다.', 2);

  -- 521. とっくに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'とっくに', '이미 오래 전에', NULL, '부사', 521) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とっくに終わった。', '이미 오래 전에 끝났다.', 1),
    (w, 'とっくに知っていた。', '벌써 알고 있었다.', 2);

  -- 522. 配布
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '配布', 'はいふ', '배포', '配(나눌 배)\n布(직물 포)', '명사', 522) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チラシを配布する。', '전단지를 배포한다.', 1),
    (w, '資料が配布された。', '자료가 배포되었다.', 2);

  -- 523. 赴任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '赴任', 'ふにん', '부임', '赴(달려갈 부)\n任(맡길 임)', '명사', 523) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都に赴任した。', '교토로 부임했다.', 1),
    (w, '仕事で魔ージャージット中だ。', '제명±ªebØ 이Ø이 총±ªe 제명ÎØ 제명.', 2);

  -- 524. 不服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不服', 'ふふく', '불복', '不: 아닌\n服(옷 복·복종 복)', '명사', 524) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判決に不服を申し立てる。', '판결에 불복을 신청한다.', 1),
    (w, '不服そうな顔だ。', '불만스러운 얼굴이다.', 2);

  -- 525. ほどける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ほどける', '풌리다', NULL, '동사', 525) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴のひもがほどけた。', '신발끈이 풀렸다.', 1),
    (w, 'パッケージがほどけた。', '포장이 풌렸다.', 2);

  -- 526. 見失う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見失う', 'みうしなう', '놓치다, 시야에서 놓치다', '見(볼 견)\n失(잃을 실)', '동사', 526) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '造を見失った。', '길을 잃었다.', 1),
    (w, '目標を見失う。', '목표를 놓친다.', 2);

  -- 527. 目覚ましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '目覚ましい', 'めざましい', '눈부셔 있다', '目(눈 목)\n覚(깨달을 각)', 'い형용사', 527) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目覚ましい發展をとげた。', '눈부신 발전을 이룩했다.', 1),
    (w, '目覚ましい成長だ。', '눈부신 성장이다.', 2);

  -- 528. 連携
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '連携', 'れんけい', '연대, 협력', '連(연이을 련)\n携(가질 휴)', '명사', 528) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他社と連携した。', '다른 회사와 연대했다.', 1),
    (w, '連携プレーを試みる。', '협력 플레이를 시도한다.', 2);

  -- 529. 広大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '広大な', 'こうだいな', '광대한', '広(넓을 광)\n大(클 대)', 'な형용사', 529) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広大なような土地。', '광대한 토지.', 1),
    (w, '広大な面積を口める。', '광대한 면적을 차지한다.', 2);

  -- 530. 仕業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仕業', 'しわざ', '소젝, 짓', '仕(벼슸 사)\n業(업 업)', '명사', 530) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誤の仕業だろう。', '적의 소젝일 것이다.', 1),
    (w, '何者の仕業か。', '누구의 짓인가.', 2);

  -- 531. 総じて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '総じて', 'そうじて', '대체로, 전반적으로', '総(다 총): 糸+悤', '부사', 531) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '総じて言うと成功だ。', '전반적으로 말하자면 성공이다.', 1),
    (w, '総じて評価が高い。', '대체로 평가가 높다.', 2);

  -- 532. 秘める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '秘める', 'ひめる', '숨기다', '秘(숨길 비): 禾+必', '동사', 532) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原めた思いを秘める。', '숨긴 생각을 숨긴다.', 1),
    (w, '可能性を秘めている。', '가능성을 숨기고 있다.', 2);

  -- 533. ブランク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ブランク', 'ぶらんく', '공백, 브랙', NULL, '명사', 533) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '五年のブランクがある。', '5년의 공백이 있다.', 1),
    (w, 'ブランクを埋める。', '공백을 메운다.', 2);

  -- 534. 見込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見込み', 'みこみ', '전망, 가능성', '見(볼 견)\n込む: 안으로 들어가다', '명사', 534) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '希望の見込みがある。', '희망의 가능성이 있다.', 1),
    (w, '豊作の見込みだ。', '풍작의 전망이다.', 2);

  -- 535. 無造作に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '無造作に', 'むぞうさに', '무조건 하게, 대수롭게', '無: 없음\n造作: 조작', '부사', 535) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無造作に骪を結ぶ。', '대수롭게 머리를 묶는다.', 1),
    (w, '無造作に並べた。', '대수롭게 늘어놓았다.', 2);

  -- 536. 免除
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '免除', 'めんじょ', '면제', '免(면할 면)\n除(덜 제)', '명사', 536) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '授業料の免除を受ける。', '수업료 면제를 받는다.', 1),
    (w, '責任を免除された。', '책임에서 면제되었다.', 2);

  -- 537. 有数
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '有数', 'ゆうすう', '굴지', '有(있을 유)\n数(셈 수)', '명사', 537) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界有数の企業だ。', '세계 굴지의 기업이다.', 1),
    (w, '国内有数の誠者だ。', '국내 굴지의 학자다.', 2);

  -- 538. 当てはめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '当てはめる', 'あてはめる', '적용하다, 대입하다', '当(마끜할 당)\nはめる: 끜운다', '동사', 538) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公式に当てはめる。', '공식에 대입한다.', 1),
    (w, '人生に当てはめて考える。', '인생에 적용해 생각한다.', 2);

  -- 539. 円滑だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '円滑だ', 'えんかつだ', '원활하다, 순조롭다', '円(둥근 원)\n滑(미끄러울 활)', 'な형용사', 539) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が円滑に進む。', '계획이 순조롭게 진행된다.', 1),
    (w, '円滑に交渉が進む。', '원활하게 협상이 이루어진다.', 2);

  -- 540. 合致
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '合致', 'がっち', '합치, 일치', '合(합할 합)\n致(이를 치)', '명사', 540) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が合致した。', '의견이 일치했다.', 1),
    (w, '証言が合致している。', '증언이 일치하고 있다.', 2);

  -- 541. かばう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'かばう', '감싸다, 보호하다', NULL, '동사', 541) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部下をかばう。', '부하를 감싸준다.', 1),
    (w, '身をかばう。', '몸을 보호한다.', 2);

  -- 542. 加味する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '加味する', 'かみする', '가미하다', '加(더할 가)\n味(맛 미)', '동사', 542) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断に原件を加味する。', '판단에 조건을 가미한다.', 1),
    (w, '年齢を加味して評価する。', '나이를 가미하여 평가한다.', 2);

  -- 543. 口出し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '口出し', 'くちだし', '참견, 간섭', '口(입 구)\n出(나올 출)', '명사', 543) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人のビジネスに口出ししない。', '옥주에 속하는 일에 간섭하지 않는다.', 1),
    (w, '口出しされるのを叫う。', '간섭당하는 것을 싫어한다.', 2);

  -- 544. 気配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '気配', 'けはい', '기첤, 냄새', '気(기운 기)\n配(나눌 배)', '명사', 544) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人の気配がした。', '사람의 기첤이 느껴졌다.', 1),
    (w, '春の気配がした。', '봄의 기운이 느껴졌다.', 2);

  -- 545. 処置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '処置', 'しょち', '처치', '処(곳 처)\n置(둘 치)', '명사', 545) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応急処置を施す。', '응급처치를 한다.', 1),
    (w, '適切な処置が必要だ。', '적절한 조치가 필요하다.', 2);

  -- 546. 打開する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '打開する', 'だかいする', '타개하다', '打(칠 타)\n開(열 개)', '동사', 546) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を打開する。', '상황을 타개한다.', 1),
    (w, '難局を打開した。', '난국을 타개했다.', 2);

  -- 547. 煩雑な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '煩雑な', 'はんざつな', '번잡한, 복잡한', '煩(불달을 번): 火+頁\n雑(섮일 잡)', 'な형용사', 547) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手続きが煩雑だ。', '절차가 복잡하다.', 1),
    (w, '煩雑な計算をした。', '번잡한 계산을 했다.', 2);

  -- 548. 拍子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '拍子', 'ひょうし', '박자, 순간, 계기', '拍(칠 박)\n子(아들 자)', '명사', 548) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '拍子をとる。', '박자를 맞춰 친다.', 1),
    (w, '踊る拍子に足を挫いた。', '춤추는 도중에 발을 점질렆다.', 2);

  -- 549. 優位
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '優位', 'ゆうい', '우위', '優(넘칠 우): 亻+冶\n位(자리 위)', '명사', 549) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '優位に立つ。', '우위에 서다.', 1),
    (w, '優位に交渉を進める。', '우위에 협상을 진행한다.', 2);

  -- 550. 一律に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '一律に', 'いちりつに', '일율적으로', '一(한 일)\n律(법 률)', '부사', 550) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一律に価格を上げた。', '일율적으로 가격을 올렸다.', 1),
    (w, '一律の対応は難しい。', '일율적인 대응은 어렵다.', 2);

  -- 551. 裏腹
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '裏腹', 'うらはら', '정반대', '裏(속 리)\n腹(배 복)', '명사', 551) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言葉と裏腹の態度だ。', '말과 정반대의 태도다.', 1),
    (w, '本心と裏腹だ。', '본심과 정반대다.', 2);

  -- 552. 抱え込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '抱え込む', 'かかえこむ', '안고 파묻히다', '抱(안을 포)\n込む: 안으로 들어가다', '동사', 552) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題を一人で抱え込む。', '문제를 혼자 안고있다.', 1),
    (w, '仕事を抱え込んでしまう。', '일을 혼자 끜안고 말았다.', 2);

  -- 553. 心構え
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '心構え', 'こころがまえ', '마음가짐', '心(마음 심)\n構(얽을 구)', '명사', 553) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心構えができている。', '마음의 준비가 되어 있다.', 1),
    (w, '心構えを説く。', '마음가짐을 설한다.', 2);

  -- 554. しがみつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しがみつく', '매달리다', NULL, '동사', 554) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身を守ろうとしがみつく。', '몸을 지키려고 매달린다.', 1),
    (w, '仕事にしがみつく。', '일에 매달린다.', 2);

  -- 555. 損なう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '損なう', 'そこなう', '해치다, 손상시키다', '損(덜 손): 手+員', '동사', 555) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を損なう。', '건강을 해친다.', 1),
    (w, '会社の利益を損なう。', '회사의 이익을 손상시킨다.', 2);

  -- 556. 耐えがたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '耐えがたい', 'たえがたい', '견디기 힘들다', '耐(견딜 내)', 'い형용사', 556) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '痛みが耐えがたい。', '고통을 견디기 힘들다.', 1),
    (w, 'ちも体わしさに耐えがたい。', '그리움을 견디기 힘들다.', 2);

  -- 557. 携わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '携わる', 'たずさわる', '종사하다', '携(가질 휴)', '동사', 557) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医療に携わる。', '의료에 종사한다.', 1),
    (w, '計画に携わってきた。', '계획에 관여해 왔다.', 2);

  -- 558. 剝がす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '剝がす', 'はがす', '벗기다', '剝(벼길 박)', '동사', 558) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ポスターを剝がす。', '포스터를 떼어낸다.', 1),
    (w, 'シールを剝がす。', '스티커를 떼어낸다.', 2);

  -- 559. 人一倍
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '人一倍', 'ひといちばい', '남보다 두 배, 유니종 곧', '人(사람 인)\n倍(짓 배)', '부사', 559) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人一倍努力した。', '남보다 두 배 노력했다.', 1),
    (w, '人一倍奌める。', '남보다 더 일한다.', 2);

  -- 560. 復旧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '復旧', 'ふっきゅう', '복구', '復(회복할 복)\n旧(옥 구)', '명사', 560) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気が復旧した。', '전기가 복구되었다.', 1),
    (w, '道路の復旧作業が進む。', '도로 복구 작업이 진행되고 있다.', 2);

  -- 561. 安静
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '安静', 'あんせい', '안정', '安(편안할 안)\n静(고요할 정)', '명사', 561) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安静を保つ。', '안정을 유지한다.', 1),
    (w, '安静状態で休む。', '안정 상태로 쉬다.', 2);

  -- 562. 今更
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '今更', 'いまさら', '이제 와서', '今(이제 금)\n更(다시 갱)', '부사', 562) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今更謝っても遅い。', '이제 와서 사과해도 늦었다.', 1),
    (w, '今更始めるのも難しい。', '이제 와서 시작하기에도 어렵다.', 2);

  -- 563. 帯びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '帯びる', 'おびる', '띄다, 퍼머금어 있다', '帯(띄 대)', '동사', 563) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '使命を帯びる。', '사명을 띄고 있다.', 1),
    (w, '重大な意味を帯びる。', '중대한 의미를 띄다.', 2);

  -- 564. 思い詰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '思い詰める', 'おもいつめる', '생각에 골뚤하다', '思(생각 사)\n詰(막을 휗)', '동사', 564) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひとりで思い詰めた。', '혼자서 생각에 골두했다.', 1),
    (w, '思い詰めて限界に達した。', '생각에 잔넘어 한계에 달했다.', 2);

  -- 565. 軌道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軌道', 'きどう', '굤도', '軌(바퀴자국 굤)\n道(길 도)', '명사', 565) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が軌道に乗る。', '계획이 굤도에 오른다.', 1),
    (w, '車両が軌道をそれた。', '차량이 굤도를 이탈했다.', 2);

  -- 566. くまなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'くまなく', '구석구석, 빠짐없이', NULL, '부사', 566) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'くまなく探した。', '구석구석 찾아봤다.', 1),
    (w, 'くまなく説明する。', '빠짐없이 설명한다.', 2);

  -- 567. 辞任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '辞任', 'じにん', '사임', '辞(말씀 사)\n任(맡길 임)', '명사', 567) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞任を表明した。', '사임을 표명했다.', 1),
    (w, '社長が辞任した。', '사장이 사임했다.', 2);

  -- 568. 統合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '統合', 'とうごう', '통합', '統(거느릴 통)\n合(합할 합)', '명사', 568) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二社が統合した。', '두 회사가 통합되었다.', 1),
    (w, 'データを統合する。', '데이터를 통합한다.', 2);

  -- 569. はなはだしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'はなはだしい', '매우 심하다', NULL, 'い형용사', 569) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被害がはなはだしい。', '피해가 심각하다.', 1),
    (w, 'はなはだしい誤りだ。', '종이 심한 실수다.', 2);

  -- 570. 人手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '人手', 'ひとで', '일손', '人(사람 인)\n手(손 수)', '명사', 570) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人手が足りない。', '일손이 부족하다.', 1),
    (w, '人手を雇う。', '일손을 고용한다.', 2);

  -- 571. もはや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もはや', '이제는, 이미', NULL, '부사', 571) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もはや手遅れだ。', '이제 닦은 일이다.', 1),
    (w, 'もはや争う余地はない。', '이제 다투는 어제마다.', 2);

  -- 572. 内訳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '内訳', 'うちわけ', '내역', '内(안 내)\n訳(풀 역)', '명사', 572) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用の内訳を示す。', '비용의 내역을 보인다.', 1),
    (w, '内訳を説明する。', '내역을 설명한다.', 2);

  -- 573. 過密
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '過密', 'かみつ', '과밀, 너무 많이 밀집됨', '過(지날 과)\n密(비밀 밀)', '명사', 573) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通の過密状態だ。', '교통이 과밀 상태다.', 1),
    (w, '過密スケジュールだ。', '과밀 일정이다.', 2);

  -- 574. 閑静な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '閑静な', 'かんせいな', '한적한, 고요한', '閑(한가롤 한)\n静(고요할 정)', 'な형용사', 574) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '閑静な住宅街だ。', '한적한 주택가다.', 1),
    (w, '閑静な環境を好む。', '고요한 환경을 좋아한다.', 2);

  -- 575. 規制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '規制', 'きせい', '규제', '規(법 규)\n制(제도 제)', '명사', 575) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規制を受ける。', '규제를 받는다.', 1),
    (w, '規制を緩める。', '규제를 완화한다.', 2);

  -- 576. 食い違う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '食い違う', 'くいちがう', '어꺋나다', '食(먹을 식)\n違(달리할 위)', '동사', 576) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証言が食い違う。', '증언이 어꺋난다.', 1),
    (w, '計画と現実が食い違う。', '계획과 현실이 어꺋난다.', 2);

  -- 577. 察する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '察する', 'さっする', '헤아리다, 이해해주다', '察(살펼 찰)', '동사', 577) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心情を察する。', '심정을 헤아린다.', 1),
    (w, '状況を察する。', '상황을 헤아린다.', 2);

  -- 578. 退く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '退く', 'しりぞく', '물러나다', '退(물러날 퇴)', '동사', 578) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一歩退く。', '한 걸음 물러난다.', 1),
    (w, '現役を退く。', '현역에서 물러난다.', 2);

  -- 579. 素早い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '素早い', 'すばやい', '재빠르다', '素(흡 소)\n早(이를 조)', 'い형용사', 579) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断が素早い。', '판단이 재빠르다.', 1),
    (w, '素早い動きを見せる。', '재빠른 움직임을 보인다.', 2);

  -- 580. たやすい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'たやすい', '쉬운', NULL, 'い형용사', 580) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たやすいことではない。', '쉬운 일이 아니다.', 1),
    (w, 'たやすく解決した。', '쉬운게 해결했다.', 2);

  -- 581. 入手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '入手', 'にゅうしゅ', '입수', '入(들 입)\n手(손 수)', '명사', 581) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チケットを入手した。', '티켓을 입수했다.', 1),
    (w, '貴重な資料を入手した。', '귀중한 자료를 입수했다.', 2);

  -- 582. 昇進
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '昇進', 'しょうしん', '승진', '昇(오를 승)\n進(나아갈 진)', '명사', 582) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケタ、部長に昇進した。', '부장으로 승진했다.', 1),
    (w, '昇進試験を受ける。', '승진 시험을 봉한다.', 2);

  -- 583. 提起
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '提起', 'ていき', '제기', '提(끌 제)\n起(일어날 기)', '명사', 583) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の提起をした。', '계획을 제기했다.', 1),
    (w, '問題を提起する。', '문제를 제기한다.', 2);

  -- 584. 滅びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '滅びる', 'ほろびる', '멸망하다', '滅(멸할 멸)', '동사', 584) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古代文明が滅びた。', '고대 문명이 멸망했다.', 1),
    (w, '言語が滅びる。', '언어가 사라진다.', 2);

  -- 585. 重複
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '重複', 'じゅうふく', '중복', '重(소중할 중)\n複(겹칠 복)', '명사', 585) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記録に重複がある。', '기록에 중복이 있다.', 1),
    (w, '重複を避ける。', '중복을 피한다.', 2);

  -- 586. 拠点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '拠点', 'きょてん', '거점', '拠(근거 거)\n点(점 점)', '명사', 586) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'アジアの拠点を設ける。', '아시아 거점을 설치한다.', 1),
    (w, '拠点を京都に上げる。', '거점을 교토에 둔다.', 2);

  -- 587. 真っ先
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '真っ先', 'まっさき', '제일 먼저', '真(참 진)\n先(먼저 선)', '명사', 587) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真っ先に驅けつけた。', '제일 먼저 달려왔다.', 1),
    (w, '真っ先に帰る。', '제일 먼저 집에 간다.', 2);

  -- 588. 緊密
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '緊密', 'きんみつ', '긴밀, 긴밀하게 연결됨', '緊(긴할 긴)\n密(비밀 밀)', '명사', 588) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '緊密な関係を保つ。', '긴밀한 관계를 유지한다.', 1),
    (w, '緊密な連携が必要だ。', '긴밀한 협력이 필요하다.', 2);

  -- 589. 遂げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '遂げる', 'とげる', '이루다, 이결°〉', '遂(드디어 수)', '동사', 589) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目的を遂げた。', '목적을 이뤄냈다.', 1),
    (w, '骨骪の達成を遂げる。', '큰 성과를 이루어낸다.', 2);

  -- 590. 巧みだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '巧みだ', 'たくみだ', '능숙하다', '巧(재주 교)', 'な형용사', 590) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '巧みな応援だ。', '능숙한 대응이다.', 1),
    (w, '巧みに話を進める。', '능숙하게 이야기를 진행한다.', 2);

  -- 591. 配属
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '配属', 'はいぞく', '배속', '配(나눌 배)\n属(붙을 속)', '명사', 591) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人事部に配属された。', '인사부에 배속되었다.', 1),
    (w, '配属先が決まった。', '배속지가 정해졌다.', 2);

  -- 592. 乗り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '乗り出す', 'のりだす', '나서다, 착수하다', '乗(타고올 승)\n出(나올 출)', '동사', 592) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '調査に乗り出す。', '조사에 나선다.', 1),
    (w, '交渉に乗り出した。', '협상에 착수했다.', 2);

  -- 593. 面識
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '面識', 'めんしき', '면식, 서로 알고 지냄', '面(냭 면)\n識(알 식)', '명사', 593) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面識がある人だ。', '안면이 있는 사람이다.', 1),
    (w, '全く面識がない。', '전혀 면식이 없다.', 2);

  -- 594. 心当たり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '心当たり', 'こころあたり', '집히는 데, 떠오르는 것', '心(마음 심)\n当(마끜할 당)', '명사', 594) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心当たりがない。', '집히는 데가 없다.', 1),
    (w, '心当たりを探る。', '단서를 찾는다.', 2);

  -- 595. 作動
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作動', 'さどう', '작동', '作(지을 작)\n動(움직일 동)', '명사', 595) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'システムが作動した。', '시스템이 작동했다.', 1),
    (w, '作動不良が起きた。', '작동 불량이 발생했다.', 2);

  -- 596. 備え付ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '備え付ける', 'そなえつける', '설치해 두다', '備(갖출 비)\n付(줄 부)', '동사', 596) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全室にエアコンを備え付けた。', '전 실에 에어컨을 구비했다.', 1),
    (w, '備え付けの家具がある。', '구비된 가구가 있다.', 2);

  -- 597. かさばる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'かさばる', '부피가 커서 거쬜장스럽다', NULL, '동사', 597) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物がかさばる。', '짐이 부피가 크다.', 1),
    (w, 'プレゼントがかさばって運びにくい。', '선물이 짓돈이 난·굼장° 달±ªe〔〕れ.', 2);

  -- 598. 交錯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '交錯', 'こうさく', '교착', '交(사귀일 교)\n錯(섮일 착)', '명사', 598) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さまざまな思いが交錯する。', '다양한 생각이 교착한다.', 1),
    (w, '期待と不安が交錯する。', '기대와 불안이 교착한다.', 2);

  -- 599. しぶとい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'しぶとい', '끈질기다, 질김', NULL, 'い형용사', 599) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しぶとい性格だ。', '끈질긴 성격이다.', 1),
    (w, 'しぶとい雑草。', '질긴 잡초.', 2);

  -- 600. 基調
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '基調', 'きちょう', '기조', '基(터 기)\n調(고를 조)', '명사', 600) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '青を基調としたデザインだ。', '파랑을 기조로 한 디자인이다.', 1),
    (w, '作品の基調を詳細する。', '작품의 기조를 자세히 설명한다.', 2);

  -- 601. 簡素
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '簡素', 'かんそ', '간소', '簡(대쉭 간)\n素(흡 소)', '명사', 601) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡素化された手続きだ。', '간소화된 절차다.', 1),
    (w, '簡素デザインが人気だ。', '간소한 디자인이 인기다.', 2);

  -- 602. 解明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '解明', 'かいめい', '해명', '解(풀 해)\n明(밝을 명)', '명사', 602) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因を解明する。', '원인을 해명한다.', 1),
    (w, '事件の解明が進む。', '사건의 해명이 진행된다.', 2);

  -- 603. ほほえましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ほほえましい', '보기 흔묻하다', NULL, 'い형용사', 603) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ほほえましい光景だ。', '보기 흔묻한 광경이다.', 1),
    (w, 'ほほえましい子供の姿。', '보기 흔묻한 아이의 모습.', 2);

  -- 604. 目安
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '目安', 'めやす', '기준, 짐작', '目(눈 목)\n安(편안할 안)', '명사', 604) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の目安を示す。', '가격의 기준을 제시한다.', 1),
    (w, 'ひとつの目安になる。', '하나의 짐작이 된다.', 2);

  -- 605. 様相
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '様相', 'ようそう', '양상', '様(모양 양)\n相(서로 상)', '명사', 605) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '街の様相が変わった。', '거리의 양상이 변했다.', 1),
    (w, '事態は重大な様相を醸している。', '사태는 중대한 양상을 띄고 있다.', 2);

  -- 606. 交える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '交える', 'まじえる', '섞다, 교환하다', '交(사귀일 교)', '동사', 606) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話に冷説を交える。', '이야기에 농담을 섞는다.', 1),
    (w, '言葉を交える。', '말을 주고받는다.', 2);

  -- 607. 要望
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '要望', 'ようぼう', '요망', '要(요구 요)\n望(바랄 망)', '명사', 607) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '住民の要望に応える。', '주민의 요망에 부응한다.', 1),
    (w, '要望を出す。', '요구를 제출한다.', 2);

  -- 608. くじける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'くじける', '꿩이다, 좌절하다', NULL, '동사', 608) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応援がくじける。', '기갈이 꿩인다.', 1),
    (w, '心がくじけた。', '마음이 꿩였다.', 2);

  -- 609. ひたむき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ひたむき', '일도(一途), 외골수이, 올곳', NULL, 'な형용사', 609) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひたむきに努力する。', '일도이 노력한다.', 1),
    (w, 'ひたむきな態度だ。', '올곳한 태도다.', 2);

  -- 610. 失脚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '失脚', 'しっきゃく', '실각', '失(잃을 실)\n脚(다리 각)', '명사', 610) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '首相が失脚した。', '총리가 실각했다.', 1),
    (w, 'スキャンダルで失脚した。', '스캔들로 실각했다.', 2);

  -- 611. 収容
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '収容', 'しゅうよう', '수용', '収(거둘 수)\n容(얼굴 용)', '명사', 611) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぶんタを収容する。', '한자를 수용한다.', 1),
    (w, '避難所に収容された。', '대피소에 수용되었다.', 2);

  -- 612. 実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '実に', 'じつに', '실로, 정말로', '実(열매 실)', '부사', 612) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実に驚いた。', '정말로 놀랐다.', 1),
    (w, '実に興味深い話だ。', '실로 흥미로운 이야기다.', 2);

  -- 613. 絶滅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '絶滅', 'ぜつめつ', '멸종', '絶(끊을 절)\n滅(멸할 멸)', '명사', 613) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '種が絶滅の危機にある。', '종이 멸종 위기에 있다.', 1),
    (w, '伝統が絶滅した。', '전통이 멸종되었다.', 2);

  -- 614. 露骨に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '露骨に', 'ろこつに', '노골적으로', '露(이슬 로)\n骨(빼 골)', '부사', 614) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '露骨に嫌な顔をした。', '노골적으로 싫은 표정을 지었다.', 1),
    (w, '露骨に不満を表す。', '노골적으로 불만을 드러낸다.', 2);

  -- 615. 交付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '交付', 'こうふ', '교부', '交(사귀일 교)\n付(줄 부)', '명사', 615) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '贻金を交付する。', '장려금을 교부한다.', 1),
    (w, '免許証を交付した。', '면허증을 교부했다.', 2);

  -- 616. なつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'なつく', '따르다, 친해지다', NULL, '동사', 616) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬が人になつく。', '개가 사람을 따른다.', 1),
    (w, 'よくなついている。', '잘 잘 따르고 있다.', 2);

  -- 617. 均等
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '均等', 'きんとう', '균등', '均(고를 균)\n等(무리 등)', '명사', 617) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '均等に分ける。', '균등하게 나눠준다.', 1),
    (w, '均等な機会を与える。', '균등한 기회를 준다.', 2);

  -- 618. リタイア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'リタイア', 'りたいあ', '은퇴', NULL, '명사', 618) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカー選手がリタイアした。', '소서레 선수가 은퇴했다.', 1),
    (w, '会社をリタイアした。', '회사를 은퇴했다.', 2);

  -- 619. 押収
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '押収', 'おうしゅう', '압수', '押(누를 압)\n収(거둘 수)', '명사', 619) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証拠品を押収した。', '증거품을 압수했다.', 1),
    (w, '違法車両を押収する。', '불법 차량을 압수한다.', 2);

  -- 620. 望ましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '望ましい', 'のぞましい', '바람직하다', '望(바랄 망)', 'い형용사', 620) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '望ましい結果だ。', '바람직한 결과다.', 1),
    (w, '望ましい姿だ。', '바람직한 모습이다.', 2);

  -- 621. 本場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '本場', 'ほんば', '산지, 원조', '本(근본 본)\n場(마당 장)', '명사', 621) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本場のイタリア料理だ。', '본고장 이탈리아 요리다.', 1),
    (w, '本場の職人が作る。', '원조의 장인이 만든다.', 2);

  -- 622. 結末
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '結末', 'けつまつ', '결말', '結(맺을 결)\n末(끝 말)', '명사', 622) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の結末を見守る。', '사건의 결말을 지켜본다.', 1),
    (w, '骨骪とした結末だ。', '자초지종한 결말이다.', 2);

  -- 623. そそる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'そそる', '식욕·흥미를 돋구다', NULL, '동사', 623) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食欲をそそる香りだ。', '식욕을 돋구는 향이다.', 1),
    (w, '興味をそそるテーマだ。', '흥미를 돋구는 주제다.', 2);

  -- 624. 要請
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '要請', 'ようせい', '요청', '要(요구 요)\n請(청할 청)', '명사', 624) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '協力を要請した。', '협력을 요청했다.', 1),
    (w, '要請に応じる。', '요청에 응한다.', 2);

  -- 625. ぎこちない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ぎこちない', '어색하다, 서투르다', NULL, 'い형용사', 625) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '動きがぎこちない。', '움직임이 어색하다.', 1),
    (w, 'ぎこちない説明だった。', '서투른 설명이었다.', 2);

  -- 626. 断じて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '断じて', 'だんじて', '결단코, 절대로', '断(끊을 단)', '부사', 626) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '断じて許せない。', '결단코 용서할 수 없다.', 1),
    (w, '断じてそんなことはない。', '절대로 그런 일은 없다.', 2);

  -- 627. 出荷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '出荷', 'しゅっか', '출하', '出(나올 출)\n荷(머이에 질 하)', '명사', 627) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豊品を出荷する。', '상품을 출하한다.', 1),
    (w, '車両の出荷が遅れている。', '차량 출하가 늦춰지고 있다.', 2);

  -- 628. 譲る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '譲る', 'ゆずる', '양보하다', '譲(사양할 양)', '동사', 628) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '席を譲る。', '자리를 양보한다.', 1),
    (w, '一歩も譲らない。', '한 걸음도 양보하지 않는다.', 2);

  -- 629. 底力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '底力', 'そこぢから', '저력', '底(밑 저)\n力(힘 력)', '명사', 629) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '底力を見せた。', '저력을 보여주었다.', 1),
    (w, '底力に期待したい。', '저력에 기대하고 싶다.', 2);

  -- 630. 手痛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手痛い', 'ていたい', '뉴아프다, 아프다', '手(손 수)\n痛(아플 통)', 'い형용사', 630) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手痛いシージュールを受けた。', '뉴아프의 일격을 받았다.', 1),
    (w, '手痛い逸だ。', '뉴아풍 실수다.', 2);

  -- 631. 誘致
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '誘致', 'ゆうち', '유치', '誘(꾼 유)\n致(이를 치)', '명사', 631) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '企業を誘致する。', '기업을 유치한다.', 1),
    (w, '五輪の誘致に成功した。', '올림픽 유치에 성공했다.', 2);

  -- 632. さえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'さえる', '썰주해지다, 맑아지다', NULL, '동사', 632) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がさえる。', '머리가 맑아진다.', 1),
    (w, '脳がさえる。', '머리가 맑다.', 2);

  -- 633. 痛烈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '痛烈', 'つうれつ', '통렬', '痛(아플 통)\n烈(매울 렬)', 'な형용사', 633) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '痛烈に批判した。', '통렬하게 비판했다.', 1),
    (w, '痛烈な一撃だった。', '통렬한 일격이었다.', 2);

  -- 634. もろい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もろい', '부서지기 쉬우다', NULL, 'い형용사', 634) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もろいガラスだ。', '깨지기 쉬운 유리다.', 1),
    (w, '心がもろい。', '마음이 약해서 쉽게 무너진다.', 2);

  -- 635. 解約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '解約', 'かいやく', '해약', '解(풀 해)\n約(맺을 약)', '명사', 635) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '携帯の解約をした。', '휴대폰을 해약했다.', 1),
    (w, '保険を解約する。', '보험을 해약한다.', 2);

  -- 636. 特産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '特産', 'とくさん', '특산', '特(특별할 특)\n産(낳을 산)', '명사', 636) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古部の特産品だ。', '교토의 특산품이다.', 1),
    (w, '特産を買う。', '특산품을 산다.', 2);

  -- 637. 問い詰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '問い詰める', 'といつめる', '따져묻다', '問(물을 문)\n詰(막을 휗)', '동사', 637) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証人を問い詰める。', '증인을 따져묻는다.', 1),
    (w, '責任を問い詰められた。', '책임을 추궁받았다.', 2);

  -- 638. 改修
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '改修', 'かいしゅう', '개수', '改(고칠 개)\n修(닦을 수)', '명사', 638) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道路を改修する。', '도로를 개수한다.', 1),
    (w, '建物の改修工事だ。', '건물의 개수 공사다.', 2);

  -- 639. 手厚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '手厚い', 'てあつい', '극진하다, 극락한', '手(손 수)\n厚(두터울 후)', 'い형용사', 639) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手厚い看護を受けた。', '극진한 간호를 받았다.', 1),
    (w, '手厚いもてなしをした。', '극진한 대접을 했다.', 2);

  -- 640. デマ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'デマ', 'でま', '데마, 유소문', NULL, '명사', 640) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デマが拡散した。', '데마가 확산되었다.', 1),
    (w, 'それはデマだ。', '그건 데마다.', 2);

  -- 641. 風潮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '風潮', 'ふうちょう', '풍조, 세상의 흐름', '風(바람 풍)\n潮(밀물 조)', '명사', 641) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現代の風潮に乗る。', '현대의 풍조에 올라탄다.', 1),
    (w, '社会の風潮を反映する。', '사회의 풍조를 반영한다.', 2);

  -- 642. もたらす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'もたらす', '가져오다, 초래하다', NULL, '동사', 642) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幸運をもたらした。', '행운을 가져왔다.', 1),
    (w, '重大な結果をもたらす。', '중대한 결과를 초래한다.', 2);

  -- 643. 補塀
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '補塀', 'ほてん', '보전, 메움', '補(깁을 보)\n塀(메울 전)', '명사', 643) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤字を補塀する。', '적자를 메운다.', 1),
    (w, '損失の補塀を求める。', '손실의 보전을 요구한다.', 2);

  -- 644. ずばり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ずばり', '어터 해서, 정확하게', NULL, '부사', 644) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ずばり言うと、反対だ。', '정확하게 말하자면 반대다.', 1),
    (w, '原因をずばりと言い当てた。', '원인을 정확히 맞춰다.', 2);

  -- 645. 養う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '養う', 'やしなう', '기르다, 양육하다', '養(기를 양)', '동사', 645) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子を養う。', '자식을 돌본다.', 1),
    (w, '体力を養う。', '체력을 길러낸다.', 2);

  -- 646. 資質
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '資質', 'ししつ', '자질', '資(재물 자)\n質(바탕 질)', '명사', 646) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リーダーの資質がある。', '리더의 자질이 있다.', 1),
    (w, '資質を磨く。', '자질을 갈고 닦는다.', 2);

  -- 647. 間柄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '間柄', 'あいだがら', '사이, 관계', '間(사이 간)\n柄(자루 병)', '명사', 647) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親しい間柄だ。', '친한 사이다.', 1),
    (w, '間柄がよくない。', '사이가 좋지 않다.', 2);

  -- 648. 正当
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '正当', 'せいとう', '정당', '正(바를 정)\n当(마끜할 당)', '명사', 648) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '正当な要求だ。', '정당한 요구다.', 1),
    (w, '正当化されない。', '정당화되지 않는다.', 2);

  -- 649. 理屈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '理屈', 'りくつ', '논리·이론·이치', '理(다스릴 리)\n屈(구부릴 굴)', '명사', 649) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '理屈っぽい話だ。', '이치적인 이야기다.', 1),
    (w, '理屈をこねる。', '이치를 따진다.', 2);

  -- 650. 説とく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '説とく', 'とく', '설도하다', '説(말씀 설)', '동사', 650) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもを説いた。', '아이를 설득했다.', 1),
    (w, '人生の道を説く。', '인생의 길을 설한다.', 2);

  -- 651. 肣る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '肣る', 'なめる', '핵다, 조말하다', '肣(하있을 이)', '동사', 651) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬を肣る。', '개를 핵다.', 1),
    (w, '本を肣るように読む。', '책을 핵듯이 읽는다.', 2);

  -- 652. 定住
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '定住', 'ていじゅう', '정주', '定(정할 정)\n住(살 주)', '명사', 652) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都に定住した。', '교토에 정주했다.', 1),
    (w, '外国に定住する。', '외국에 정주한다.', 2);

  -- 653. 隱居
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '隱居', 'いんきょ', '은거', '隱(숨을 은)\n居(살 거)', '명사', 653) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山中に隱居した。', '산속에 은거했다.', 1),
    (w, '隱居生活を送る。', '은거 생활을 보낸다.', 2);

  -- 654. 底辺
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '底辺', 'そこへん', '도저히, 아무래도', '底(밑 저)\n辺(가 변)', '부사', 654) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '底辺不可能だ。', '도저히 불가능하다.', 1),
    (w, '底辺受け入れられない。', '도저히 받아들일 수 없다.', 2);

  -- 655. 全面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '全面', 'ぜんめん', '전면', '全(온전 전)\n面(냭 면)', '명사', 655) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全面的に見直した。', '전면적으로 재검토했다.', 1),
    (w, '全面収録だ。', '전면 수록이다.', 2);

  -- 656. 応募
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '応募', 'おうぼ', '응모', '応(응할 응)\n募(모을 모)', '명사', 656) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '就職に応募する。', '취직에 응모한다.', 1),
    (w, 'コンテストに応募した。', '콘테스트에 응모했다.', 2);

  -- 657. 「その他」
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '「その他」', 'そのた', '그 외', NULL, '명사', 657) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その他の費用もかかる。', '그 외의 비용도 든다.', 1),
    (w, 'その他詳細は伝言させる。', '그 외 자세한 사항은 전달하겠다.', 2);

  -- 658. 走り回る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '走り回る', 'はしりまわる', '뛰어다니다', '走(달릴 주)\n回(돌 회)', '동사', 658) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間を走り回る。', '방 안을 뛰어다닌다.', 1),
    (w, '仕事で走り回った。', '일로 바쁬 다녕다.', 2);

  -- 659. 希薄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '希薄', 'きはく', '희박', '希(바랄 희)\n薄(엇을 박)', '명사', 659) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '希薄な金属だ。', '희박한 금속이다.', 1),
    (w, '可能性が希薄だ。', '가능성이 희박하다.', 2);

  -- 660. 代議士
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '代議士', 'だいぎし', '대의사, 국회의원', '代(대신할 대)\n議(의론할 의)', '명사', 660) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代議士に選ばれた。', '국회의원에 선출되었다.', 1),
    (w, '代議士の任期だ。', '국회의원의 임기다.', 2);

  -- 661. 複雑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '複雑', 'ふくざつ', '복잡', '複(겹칠 복)\n雑(섞일 잡)', 'な형용사', 661) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題が複雑だ。', '문제가 복잡하다.', 1),
    (w, '複雑な手順だ。', '복잡한 절차다.', 2);

  -- 662. 入門
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '入門', 'にゅうもん', '입문', '入(들 입)\n門(문 문)', '명사', 662) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノの入門書を買う。', '피아노 입문서를 산다.', 1),
    (w, '入門講座を受講した。', '입문 강좌를 수강했다.', 2);

  -- 663. 証言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '証言', 'しょうげん', '증언', '証(증거 증)\n言(말씀 언)', '명사', 663) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '裁判で証言した。', '재판에서 증언했다.', 1),
    (w, '伝言だけでは信じられない。', '증언만으로는 믿기 어렵다.', 2);

  -- 664. とんだ、あさめて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'とんだ、あさめて', '틀린, 다시, 새로이', NULL, '부사/동사', 664) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あさめて始めよう。', '다시 시작하자.', 1),
    (w, 'あさめて考える。', '새삼 생각한다.', 2);

  -- 665. 越計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '越計', 'たしやか', '확실하다, 탁월하다', '越(넘을 월)\n計(셌 계)', 'な형용사', 665) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '越計した才能だ。', '탁월한 재능이다.', 1),
    (w, '越計した独特の人だ。', '독특한 서다.', 2);

  -- 666. 限度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '限度', 'げんど', '한도', '限(한계 한)\n度(법도 도)', '명사', 666) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忍耐の限度だ。', '인내의 한도다.', 1),
    (w, '限度を超える。', '한도를 넘는다.', 2);

  -- 667. 疑う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '疑う', 'うたがう', '의심하다', '疑(의심할 의)', '동사', 667) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話を疑う。', '이야기를 의심한다.', 1),
    (w, '動機を疑われる。', '동기를 의심받는다.', 2);

  -- 668. ヒットする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'ヒットする', '히트하다', NULL, '동사', 668) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その映画はヒットした。', '그 영화는 히트했다.', 1),
    (w, '商品がヒットした。', '상품이 히트되었다.', 2);

  -- 669. 低迄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '低迄', 'ていみよう', '저미', '低(낮을 저)\n迄(이를 미)', '명사', 669) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '景気が低迄している。', '경기가 저미하고 있다.', 1),
    (w, '売り上げが低迄だ。', '매출이 저미하다.', 2);

  -- 670. 険しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '険しい', 'けわしい', '험하다, 험상이 나끜다', '険(험할 험)', 'い형용사', 670) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '険しい表情をした。', '험상궁은 표정을 지었다.', 1),
    (w, '険しい顔で見める。', '험상굷은 얼굴로 노려본다.', 2);

  -- 671. よしに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'よしに', '설령, 고의로', NULL, '부사', 671) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よしに反対されてもやる。', '설령 반대한다 해도 한다.', 1),
    (w, 'よしに、雨が降ったとしても。', '설령 비가 온다 해도.', 2);

  -- 672. 付け加える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '付け加える', 'つけくわえる', '덧붙이다, 덧붙여·첨가하다', '付(붙을 부)\n加(더할 가)', '동사', 672) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コメントを付け加える。', '코멘트를 덧붙인다.', 1),
    (w, '説明を付け加えた。', '설명을 덧붙였다.', 2);

  -- 673. 伝統
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '伝統', 'でんとう', '전통', '伝(전할 전)\n統(거느릴 통)', '명사', 673) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '伝統を守る。', '전통을 지킨다.', 1),
    (w, '伝統的な言茶道だ。', '전통적인 다도다.', 2);

  -- 674. 明染
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '明染', 'めいた', '서명, 명술', '明(밝을 명)\n染(팔 서)', '명사', 674) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明染のダンサーだ。', '명임의 대스입시워다.', 1),
    (w, '明染のシェフと言われる。', '명임 셰프라 불린다.', 2);

  -- 675. 玩具
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '玩具', 'がんぐ', '완구, 장난감', '玩(놈 완)\n具(갖출 구)', '명사', 675) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもが玩具で遊ぶ。', '아이가 장난감으로 논다.', 1),
    (w, '玩具錄を買う。', '장난감을 산다.', 2);

  -- 676. 考察
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '考察', 'こうさつ', '고찰', '考(생각할 고)\n察(살필 찰)', '명사', 676) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現地調査と考察をした。', '현장 조사와 고찰을 했다.', 1),
    (w, '考察レポートを書く。', '고찰 레포트를 쓴다.', 2);

  -- 677. 厳重
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '厳重', 'げんじゅう', '엄중', '厳(엄할 엄)\n重(무거울 중)', 'な형용사', 677) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳重な警備だ。', '엄중한 경비다.', 1),
    (w, '厳重に注意した。', '엄중하게 주의했다.', 2);

  -- 678. 規模
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '規模', 'きぼ', '규모', '規(법 규)\n模(본바말 모)', '명사', 678) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大規模なイベントだ。', '대규모 이벤트다.', 1),
    (w, '規模を拡大する。', '규모를 확대한다.', 2);

  -- 679. 広告
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '広告', 'こうこく', '광고', '広(넓을 광)\n告(알릴 고)', '명사', 679) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビで広告を見た。', '텔레비전에서 광고를 봤다.', 1),
    (w, '広告効果があった。', '광고 효과가 있었다.', 2);

  -- 680. 同情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '同情', 'どうじょう', '동정', '同(한가지 동)\n情(뜻 정)', '명사', 680) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被害者に同情した。', '피해자에게 동정했다.', 1),
    (w, '同情の余地がない。', '동정의 여지가 없다.', 2);

  -- 681. 備える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '備える', 'そなえる', '갖추다, 대비하다', '備(갖출 비)', '동사', 681) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地震に備える。', '지진에 대비한다.', 1),
    (w, '試験に備えて勉強する。', '시험에 대비해 공부한다.', 2);

  -- 682. スケジュール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スケジュール', 'すけじゅーる', '스케줄', NULL, '명사', 682) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スケジュールを組む。', '스케줄을 짜다.', 1),
    (w, 'スケジュールが詰まっている。', '스케줄이 빽빽하다.', 2);

  -- 683. 勣る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '勣る', 'まさる', '뛰어나다, 끭주다', '勣(넓은 우)', '동사', 683) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '品質にて勣るものはない。', '품질에 있어 버금가는 것이 없다.', 1),
    (w, '他の起業に勣る。', '다른 기업에 뚤지 않는다.', 2);

  -- 684. 幼い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '幼い', 'おさない', '어리다, 유치하다', '幼(어릴 유)', 'い형용사', 684) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幼い子どもがいる。', '어린 아이가 있다.', 1),
    (w, '考えが幼い。', '생각이 유치하다.', 2);

  -- 685. 初めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '初めて', 'はじめて', '처음으로', '初(처음 초)', '부사', 685) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初めて日本に来た。', '처음 일본에 왔다.', 1),
    (w, '初めて願う。', '처음 만나닝곁습니다.', 2);

  -- 686. 外野
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '外野', 'げや', '외야, 한밥에 있음', '外(밖 외)\n野(들 야)', '명사', 686) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外野の選手だ。', '외야의 선수다.', 1),
    (w, '外野を守る。', '외야를 수비한다.', 2);

  -- 687. 記録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '記録', 'きろく', '기록', '記(기록할 기)\n録(기록할 록)', '명사', 687) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界記録を作った。', '세계 기록을 세웠다.', 1),
    (w, 'データを記録する。', '데이터를 기록한다.', 2);

  -- 688. 規則
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '規則', 'きそく', '규칙', '規(법 규)\n則(법칙 칙)', '명사', 688) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規則を守る。', '규칙을 지킨다.', 1),
    (w, '規則違反だ。', '규칙 위반이다.', 2);

  -- 689. 合計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '合計', 'ごうけい', '합계', '合(합할 합)\n計(셌 계)', '명사', 689) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用は合計1万円。', '비용은 합계 만 엔.', 1),
    (w, '合計を出す。', '합계를 낸다.', 2);

  -- 690. 不明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不明', 'ふめい', '불명', '不(아닐 불)\n明(밝을 명)', 'な형용사', 690) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因不明だ。', '원인 불명이다.', 1),
    (w, '行方不明になる。', '행방불명이 되다.', 2);

  -- 691. 代わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '代わる', 'かわる', '바뀌다, 교체되다', '代(대신할 대)', '동사', 691) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長が代わった。', '사장이 바뀌었다.', 1),
    (w, '代わって読んだ。', '대신 읽었다.', 2);

  -- 692. 証拠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '証拠', 'しょうこ', '증거', '証(증거 증)\n拠(근거 거)', '명사', 692) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証拠不十分だ。', '증거 불충분이다.', 1),
    (w, '証拠を提示する。', '증거를 제시한다.', 2);

  -- 693. 使う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '使う', 'つかう', '쓰다, 사용하다', '使(하여금 사)', '동사', 693) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンピューターを使う。', '컴퓨터를 사용한다.', 1),
    (w, 'お金を使う。', '돈을 쓴다.', 2);

  -- 694. 難しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '難しい', 'むずかしい', '어렵다', '難(어려울 난)', 'い형용사', 694) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題が難しい。', '문제가 어렵다.', 1),
    (w, '読み難い字だ。', '읽기 어려운 글자다.', 2);

  -- 695. スポーツ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スポーツ', 'すぽーつ', '스포츠', NULL, '명사', 695) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スポーツが好きだ。', '스포츠를 좋아한다.', 1),
    (w, 'スポーツをする。', '스포츠를 한다.', 2);

  -- 696. 以前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '以前', 'いぜん', '이전', '以(써 이)\n前(앞 전)', '명사', 696) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '以前会ったことがある。', '이전에 만난 적이 있다.', 1),
    (w, '以前はタバコをすっていた。', '예전에는 담배를 피웠다.', 2);

  -- 697. 社員
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '社員', 'しゃいん', '사원', '社(모일 사)\n員(인원 원)', '명사', 697) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'トヨタボ社員だ。', '도요타 사원이다.', 1),
    (w, '社員と話をした。', '사원과 이야기를 나눠다.', 2);

  -- 698. 踊る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '踊る', 'おどる', '춤추다', '踊(춤출 용)', '동사', 698) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サルサを踊る。', '샐샐를 춤춘다.', 1),
    (w, '踊るのが上手だ。', '춤이 능숙하다.', 2);

  -- 699. 長期
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '長期', 'ちょうき', '장기', '長(길 장)\n期(기약할 기)', '명사', 699) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長期休暇に入る。', '장기 휴가를 돌입한다.', 1),
    (w, '長期的に考える。', '장기적으로 생각한다.', 2);

  -- 700. 乾煌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '乾煌', 'かんそう', '건조', '乾(하늘 건)\n煌(마를 조)', '명사', 700) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '背中が乾煌している。', '등이 건조하다.', 1),
    (w, '乾煌オレンジを食べる。', '건조 오렌지를 먹는다.', 2);

  -- 701. 社交
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '社交', 'しゃこう', '사교', '社(모일 사)\n交(사귀일 교)', '명사', 701) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社交ダンスを踊る。', '사교 대스를 춤춘다.', 1),
    (w, '社交スキルを高める。', '사교 스킬을 높인다.', 2);

  -- 702. 茶色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '茶色', 'ちゃいろ', '갈색', '茶(차 다)\n色(빛 색)', '명사', 702) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '茶色の鞄をしている。', '갈색 구두를 신었다.', 1),
    (w, '髪を茶色に染めた。', '머리를 갈색으로 염색했다.', 2);

  -- 703. 安全
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '安全', 'あんぜん', '안전', '安(편안할 안)\n全(온전 전)', 'な형용사', 703) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安全を確認してから乗る。', '안전을 확인하고 탄다.', 1),
    (w, '安全な場所だ。', '안전한 장소다.', 2);

  -- 704. 体験
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '体験', 'たいけん', '체험', '体(모 체)\n験(시험 험)', '명사', 704) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豊富な体験をした。', '풍부한 체험을 했다.', 1),
    (w, '体験談を語る。', '체험담을 말한다.', 2);

  -- 705. 公表
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '公表', 'こうひょう', '공표', '公(공평할 공)\n表(갉 표)', '명사', 705) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果が公表された。', '결과가 공표되었다.', 1),
    (w, '今朝公表された。', '오늘 아침 공표되었다.', 2);

  -- 706. テレビ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'テレビ', 'てれび', '텔레비전', NULL, '명사', 706) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビでニュースを見た。', '텔레비전으로 뉴스를 봤다.', 1),
    (w, 'テレビ番組を録画した。', '텔레비전 프로그램을 녹화했다.', 2);

  -- 707. 事件
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '事件', 'じけん', '사건', '事(일 사)\n件(조건 건)', '명사', 707) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件が起きた。', '사건이 일어났다.', 1),
    (w, '事件の犯人だ。', '사건의 범인이다.', 2);

  -- 708. 記号
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '記号', 'きごう', '기호', '記(기록할 기)\n号(이름 호)', '명사', 708) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通記号を守る。', '교통 신호를 지킨다.', 1),
    (w, 'ステックを記号で表す。', '상태를 기호로 표시한다.', 2);

  -- 709. 明朝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '明朝', 'みょうちょう', '내일 아침', '明(밝을 명)\n朝(아침 조)', '명사', 709) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明朝七時に出発する。', '내일 아침 7시에 출발한다.', 1),
    (w, '明朝雨が降るようだ。', '내일 아침 비가 올 것 같다.', 2);

  -- 710. 会計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '会計', 'かいけい', '회계', '会(모일 회)\n計(셌 계)', '명사', 710) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会計を担当する。', '회계를 담당한다.', 1),
    (w, '会計を済ませて退出した。', '계산을 끝내고 나왔다.', 2);

  -- 711. 講演
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '講演', 'こうえん', '강연', '講(외울 강)\n演(펼 연)', '명사', 711) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '講演を聞く。', '강연을 듣는다.', 1),
    (w, '講演会を開く。', '강연회를 열다.', 2);

  -- 712. 古い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '古い', 'ふるい', '낚아보이다, 오래되다', '古(예 고)', 'い형용사', 712) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い本を読む。', '오래된 책을 읽는다.', 1),
    (w, '考えが古い。', '생각이 낚았다.', 2);

  -- 713. 植物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '植物', 'しょくぶつ', '식물', '植(심을 식)\n物(만물 물)', '명사', 713) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '植物を育てる。', '식물을 키운다.', 1),
    (w, '植物园に行った。', '식물원에 갔다.', 2);

  -- 714. 作成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作成', 'さくせい', '작성', '作(지을 작)\n成(이룰 성)', '명사', 714) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料を作成する。', '자료를 작성한다.', 1),
    (w, 'データを作成した。', '데이터를 작성했다.', 2);

  -- 715. 記者
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '記者', 'きしゃ', '기자', '記(기록할 기)\n者(놈 자)', '명사', 715) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スポーツ記者だ。', '스포츠 기자다.', 1),
    (w, '記者会見を開く。', '기자회견을 열다.', 2);

  -- 716. 交換
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '交換', 'こうかん', '교환', '交(사귀일 교)\n換(바꿀 환)', '명사', 716) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名刺を交換する。', '명함을 교환한다.', 1),
    (w, '意見を交換する。', '의견을 교환한다.', 2);

  -- 717. ダイエット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ダイエット', 'だいえっと', '다이어트', NULL, '명사', 717) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ダイエットを始めた。', '다이어트를 시작했다.', 1),
    (w, 'ダイエット中だ。', '다이어트 중이다.', 2);

  -- 718. 選手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '選手', 'せんしゅ', '선수', '選(가릴 선)\n手(손 수)', '명사', 718) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカー選手だ。', '축구 선수다.', 1),
    (w, '選手を選ぶ。', '선수를 고른다.', 2);

  -- 719. 入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '入れる', 'いれる', '넣다', '入(들 입)', '동사', 719) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カバンに本を入れる。', '가방에 책을 넣는다.', 1),
    (w, 'コーヒーに砂糖を入れる。', '커피에 설탕을 넣는다.', 2);

  -- 720. 差しざ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '差しざ', 'さしざ', '우산', '差(달림 차)', '명사', 720) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るので差しざをさす。', '비가 와서 우산을 쓴다.', 1),
    (w, '差しざを忘れた。', '우산을 잊었다.', 2);

  -- 721. 吃般
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '吃般', 'きっされん', '끝내 안 됨, 하난, 퍼그웠다', '吃(먹을 휗)\n般(일반 반)', '명사/な형용사', 721) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう吃般だ。', '이제 지겹다.', 1),
    (w, '吃般にしろよ。', '적당히 해라.', 2);

  -- 722. 表現
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '表現', 'ひょうげん', '표현', '表(갉 표)\n現(나타날 현)', '명사', 722) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感情を表現する。', '감정을 표현한다.', 1),
    (w, '言語表現が豊かだ。', '언어 표현이 풍부하다.', 2);

  -- 723. 成長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '成長', 'せいちょう', '성장', '成(이룰 성)\n長(길 장)', '명사', 723) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済成長が著しい。', '경제 성장이 두드러지다.', 1),
    (w, '子供の成長を記録する。', '아이의 성장을 기록한다.', 2);

  -- 724. 不便
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '不便', 'ふべん', '불편', '不(아닐 불)\n便(편할 편)', 'な형용사', 724) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通が不便だ。', '교통이 불편하다.', 1),
    (w, '不便を感じる。', '불편을 느낌다.', 2);

  -- 725. 軽い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軽い', 'かるい', '가볍다', '軽(가벼울 경)', 'い형용사', 725) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽い荷物だ。', '가벼운 짐이다.', 1),
    (w, '軽い身体だ。', '가벼운 못감이다.', 2);

  -- 726. 努力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '努力', 'どりょく', '노력', '努(힘쓸 노)\n力(힘 력)', '명사', 726) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '努力して勉強した。', '노력해서 공부했다.', 1),
    (w, '努力が実を結んだ。', '노력이 결실을 맺었다.', 2);

  -- 727. サービス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'サービス', 'さーびす', '서비스', NULL, '명사', 727) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サービスがよい。', '서비스가 좋다.', 1),
    (w, 'サービスを提供する。', '서비스를 제공한다.', 2);

  -- 728. 予定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '予定', 'よてい', '예정', '予(미리 예)\n定(정할 정)', '명사', 728) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日の予定を確認する。', '내일 일정을 확인한다.', 1),
    (w, '予定が入っている。', '일정이 있다.', 2);

  -- 729. 思い出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '思い出す', 'おもいだす', '기억해내다', '思(생각 사)\n出(날 출)', '동사', 729) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を思い出す。', '이름을 기억해낸다.', 1),
    (w, '昨日のことを思い出した。', '어제 일을 떠올렸다.', 2);

  -- 730. 表面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '表面', 'ひょうめん', '표면', '表(갉 표)\n面(냭 면)', '명사', 730) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '表面をコートする。', '표면을 코팅한다.', 1),
    (w, '表面上は平静だ。', '표면상으로는 평온하다.', 2);

  -- 731. 体重
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '体重', 'たいじゅう', '체중', '体(모 체)\n重(무거울 중)', '명사', 731) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体重が増えた。', '체중이 늘었다.', 1),
    (w, '体重を量る。', '체중을 쟰다.', 2);

  -- 732. 項目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '項目', 'こうもく', '항목', '項(항목 항)\n目(눈 목)', '명사', 732) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '該当する項目を探す。', '해당하는 항목을 찾는다.', 1),
    (w, '項目ごとに入力する。', '항목별로 입력한다.', 2);

  -- 733. 長手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '長手', 'ちょうしゅ', '잘함', '長(길 장)\n手(손 수)', 'な형용사', 733) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テニスが長手だ。', '테니스를 잘한다.', 1),
    (w, '長手な人に職を任せる。', '잘하는 사람에게 일을 맡긴다.', 2);

  -- 734. 応援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '応援', 'おうえん', '응원', '応(응할 응)\n援(도울 원)', '명사', 734) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームを応援した。', '팀을 응원했다.', 1),
    (w, '友人を応援する。', '친구를 응원한다.', 2);

  -- 735. 平凡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '平凡', 'へいぼん', '평범', '平(평평할 평)\n凡(무릇 범)', 'な형용사', 735) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平凡な人生だ。', '평범한 인생이다.', 1),
    (w, '平凡な評価だった。', '평범한 평가였다.', 2);

  -- 736. 主人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '主人', 'しゅじん', '주인, 남편', '主(주인 주)\n人(사람 인)', '명사', 736) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家の主人だ。', '집의 주인이다.', 1),
    (w, '主人は会社員だ。', '남편은 회사원이다.', 2);

  -- 737. 友達
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '友達', 'ともだち', '친구', '友(벳 우)\n達(통달할 달)', '명사', 737) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達と遊ぶ。', '친구와 논다.', 1),
    (w, '古い友達だ。', '오래된 친구다.', 2);

  -- 738. 作品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作品', 'さくひん', '작품', '作(지을 작)\n品(물건 품)', '명사', 738) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '著名な作品だ。', '유명한 작품이다.', 1),
    (w, '新しい作品を発表する。', '새 작품을 발표한다.', 2);

  -- 739. 見事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見事', 'みごと', '훌륭함, 멋짐', '見(볼 견)\n事(일 사)', 'な형용사', 739) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見事な演技だ。', '멋진 연기다.', 1),
    (w, '見事に成功した。', '훌륭하게 성공했다.', 2);

  -- 740. 見本
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見本', 'みほん', '견본, 본보기', '見(볼 견)\n本(근본 본)', '명사', 740) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記入見本を見る。', '입력 견본을 본다.', 1),
    (w, '見本を示す。', '본보기를 보인다.', 2);

  -- 741. 予言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '予言', 'よげん', '예언', '予(미리 예)\n言(말씀 언)', '명사', 741) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予言が当たった。', '예언이 맞았다.', 1),
    (w, '未来を予言する。', '미래를 예언한다.', 2);

  -- 742. 作業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作業', 'さぎょう', '작업', '作(지을 작)\n業(일 업)', '명사', 742) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作業を進める。', '작업을 진행한다.', 1),
    (w, '作業が終わった。', '작업이 끝났다.', 2);

  -- 743. ポケット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ポケット', 'ぽけっと', '주머니', NULL, '명사', 743) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ポケットにスマホを入れる。', '주머니에 스마트폰을 넣는다.', 1),
    (w, 'ポケットがいっぱいだ。', '주머니가 가득 차 있다.', 2);

  -- 744. 什事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '什事', 'じゃずしよ', '잡일, 자잔한 일', '什(세건 십)\n事(일 사)', '명사', 744) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '什事に追われる。', '잡일에 쪼긴다.', 1),
    (w, '什事を長よる。', '잡일을 절약한다.', 2);

  -- 745. 反応
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '反応', 'はんのう', '반응', '反(돌이킬 반)\n応(응할 응)', '명사', 745) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見者の反応がよかった。', '관객의 반응이 좋았다.', 1),
    (w, '計画に反応しない。', '계획에 반응하지 않는다.', 2);

  -- 746. ケーキ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ケーキ', 'けーき', '케이크', NULL, '명사', 746) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケーキを焼いた。', '케이크를 굽었다.', 1),
    (w, 'バースデーケーキを買う。', '생일 케이크를 산다.', 2);

  -- 747. 記録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '記録', 'きろく', '기록·자료', '記(기록할 기)\n録(기록할 록)', '명사', 747) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生活の記録を付ける。', '생활 기록을 쓴다.', 1),
    (w, '会議の記録を取る。', '회의 기록을 쓴다.', 2);

  -- 748. 身体
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '身体', 'しんたい', '신체', '身(모 신)\n体(모 체)', '명사', 748) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身体を動かす。', '목을 움직인다.', 1),
    (w, '身体に気をつける。', '몸조심한다.', 2);

  -- 749. 微る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '微る', 'ほしる', '웃다, 미소짓다', '微(웃을 미)', '동사', 749) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '静かに微る。', '조용하게 미소짓는다.', 1),
    (w, '揮りながら微った。', '손을 흔들며 미소지었다.', 2);

  -- 750. 仕事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仕事', 'しごと', '일, 직업', '仕(섬길 사)\n事(일 사)', '명사', 750) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に行く。', '일하러 간다.', 1),
    (w, '仕事を辞めた。', '일을 그만두었다.', 2);

  -- 751. チーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'チーム', 'ちーむ', '팀', NULL, '명사', 751) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームを組む。', '팀을 꾸린다.', 1),
    (w, 'チームワークが大切だ。', '팀워크가 중요하다.', 2);

  -- 752. 説明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '説明', 'せつめい', '설명', '説(말씀 설)\n明(밝을 명)', '명사', 752) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳しく説明した。', '자세하게 설명했다.', 1),
    (w, '説明を聞く。', '설명을 듣는다.', 2);

  -- 753. ステレオ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ステレオ', 'すてれお', '스테레오', NULL, '명사', 753) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ステレオで音楽を聞く。', '스테레오로 음악을 듣는다.', 1),
    (w, '車のステレオを交換した。', '차의 스테레오를 교체했다.', 2);

  -- 754. 見付かる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '見付かる', 'みつかる', '발견되다', '見(볼 견)\n付(붙을 부)', '동사', 754) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布が見付かった。', '지갑이 발견되었다.', 1),
    (w, '間違いが見付かる。', '실수가 발견된다.', 2);

  -- 755. 生える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '生える', 'はえる', '나다, 자라다', '生(날 생)', '동사', 755) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '髪が生える。', '머리입도종이 나다.', 1),
    (w, '草が生える。', '풀이 자란다.', 2);

  -- 756. セール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'セール', 'せーる', '세일', NULL, '명사', 756) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'セール中に買った。', '세일 중에 샀다.', 1),
    (w, 'セールが始まった。', '세일이 시작되었다.', 2);

  -- 757. 跳ねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '跳ねる', 'はねる', '뛰어오르다, 튀기다', '跳(뛸 도)', '동사', 757) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '魚が跳ねる。', '물고기가 튀어올랐다.', 1),
    (w, 'ボールが跳ねる。', '공이 튀느다.', 2);

  -- 758. 思いつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '思いつく', 'おもいつく', '떠올리다, 떠오르다', '思(생각 사)', '동사', 758) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいアイデアを思いついた。', '좋은 아이디어가 떠올랐다.', 1),
    (w, '何も思いつかない。', '아무것도 떠오르지 않는다.', 2);

  -- 759. 仕込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仕込む', 'しこむ', '이고 배우다, 단련하다', '仕(섬길 사)\n込(들 입)', '동사', 759) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身を仕込む。', '몸을 단련한다.', 1),
    (w, '犬に芸を仕込む。', '개에게 재주를 가르친다.', 2);

  -- 760. 限る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '限る', 'かぎる', '한정하다', '限(한계 한)', '동사', 760) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今回に限って無料だ。', '이번에 한해 무료다.', 1),
    (w, '人数を限る。', '인원을 제한한다.', 2);

  -- 761. チップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'チップ', 'ちっぷ', '팁', NULL, '명사', 761) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チップを渡した。', '팁을 건넘였다.', 1),
    (w, 'チップ不要だ。', '팁은 주지 않는다.', 2);

  -- 762. 作り上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作り上げる', 'つくりあげる', '만들어내다', '作(지을 작)\n上(윗 상)', '동사', 762) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を作り上げた。', '작품을 완성했다.', 1),
    (w, 'チームを作り上げる。', '팀을 만들어내다.', 2);

  -- 763. それぞれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'それぞれ', 'それぞれ', '제각각', NULL, '명사/부사', 763) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それぞれの意見がある。', '제각의 의견이 있다.', 1),
    (w, 'それぞれ起きた。', '각자 일어났다.', 2);

  -- 764. どけち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'どけち', '어디, 어느 쪽', NULL, '대명사', 764) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どっちを選ぶ？', '어느 쪽을 고를거야?', 1),
    (w, 'どっちもいい。', '어느 것이든 좋다.', 2);

  -- 765. 厳しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '厳しい', 'きびしい', '엄격하다', '厳(엄할 엄)', 'い형용사', 765) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳しい先生だ。', '엄격한 선생님이다.', 1),
    (w, '厳しくしかられた。', '렁이 혼난다.', 2);

  -- 766. 在師
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '在師', 'ざいケシ', '자재의', '在(있을 재)\n師(스승 사)', 'な형용사', 766) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外国語が在師だ。', '외국어를 자재롭게 구사한다.', 1),
    (w, 'スポーツを在師にこなす。', '스포츠를 자재롭게 한다.', 2);

  -- 767. 梨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '梨', 'なし', '배, 배나무', '梨(배 리)', '명사', 767) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梨を食べた。', '배를 먹었다.', 1),
    (w, '梨の木がある。', '배나무가 있다.', 2);

  -- 768. 現われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '現われる', 'あらわれる', '나타나다', '現(나타날 현)', '동사', 768) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スターが現われた。', '스타가 나타났다.', 1),
    (w, '効果が現われる。', '효과가 나타난다.', 2);

  -- 769. しよう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'しよう', 'しよう', '소용이 없음, 방법이 없음', NULL, '명사', 769) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司に叱られてしようがない。', '상사에게 혼나서 어첤 수 없다.', 1),
    (w, '反対されてもしようがない。', '반대당해도 어첤 수 없다.', 2);

  -- 770. 規定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '規定', 'きてい', '규정', '規(법 규)\n定(정할 정)', '명사', 770) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規定に従う。', '규정에 따른다.', 1),
    (w, '規定を設ける。', '규정을 마련한다.', 2);

  -- 771. 送り迎える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '送り迎える', 'おくりむかえる', '맞이하다, 보내고 맞이하다', '送(보낼 송)\n迎(맞을 영)', '동사', 771) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新年を送り迎える。', '신년을 맞이한다.', 1),
    (w, '他人と送り迎えをしている。', '다른 사람과 온일을 함께한다.', 2);

  -- 772. 提出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '提出', 'ていしゅつ', '제출', '提(끌 제)\n出(날 출)', '명사', 772) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'レポートを提出した。', '레포트를 제출했다.', 1),
    (w, '提出期限を守る。', '제출기한을 지킨다.', 2);

  -- 773. 進む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '進む', 'すすむ', '나아가다', '進(나아갈 진)', '동사', 773) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が進む。', '일이 진첩된다.', 1),
    (w, '計画が進む。', '계획이 진행된다.', 2);

  -- 774. ビジネス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ビジネス', 'びじねす', '비즈니스', NULL, '명사', 774) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビジネスチャンスだ。', '비즈니스 찬스이다.', 1),
    (w, '新規ビジネスを始める。', '신규 비즈니스를 시작한다.', 2);

  -- 775. コツ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'コツ', 'こつ', '요령, 비결', NULL, '명사', 775) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コツをつかむ。', '요령을 터득한다.', 1),
    (w, '勉強のコツを教えてください。', '공부 비결을 가르쳐 주세요.', 2);

  -- 776. 薬局
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '薬局', 'やっきょく', '약국', '薬(약 약)\n局(판 국)', '명사', 776) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '薬局で薬を買う。', '약국에서 약을 산다.', 1),
    (w, '付近の薬局を探す。', '근처의 약국을 찾는다.', 2);

  -- 777. プラス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'プラス', 'ぷらす', '플러스', NULL, '명사', 777) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プラスアルファと言う。', '플러스 알파라고 한다.', 1),
    (w, 'プラスの効果だ。', '플러스 효과다.', 2);

  -- 778. コスト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'コスト', 'こすと', '코스트, 비용', NULL, '명사', 778) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コストを下げる。', '비용을 낮춘다.', 1),
    (w, 'コストパフォーマンスがよい。', '가성비가 좋다.', 2);

  -- 779. 値打ち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '値打ち', 'ねうち', '흥정', '値(값 치)\n打(칠 타)', '명사', 779) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '値打ちして買った。', '흥정해서 샀다.', 1),
    (w, '値打ち交渉をした。', '가격 협상을 했다.', 2);

  -- 780. オープン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'オープン', 'おーぷん', '오픈', NULL, 'な형용사', 780) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'オープンな会社だ。', '오픈한 회사다.', 1),
    (w, 'オープンソースだ。', '오픈 소스다.', 2);

  -- 781. 上品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '上品', 'じょうひん', '고상', '上(윗 상)\n品(물건 품)', 'な형용사', 781) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上品な言葉を使う。', '고상한 말을 쓴다.', 1),
    (w, '上品な振る舞いだ。', '고상한 행동이다.', 2);

  -- 782. 軽々
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '軽々', 'かるがる', '가볍게, 경쾌하게', '軽(가벼울 경)', '부사', 782) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽々とした足取りだ。', '가벼운 발걸음이다.', 1),
    (w, '軽々しい身なりだ。', '경쾌한 차림이다.', 2);

  -- 783. 複製
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '複製', 'ふくせい', '복제', '複(겹칠 복)\n製(지을 제)', '명사', 783) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ファイルを複製する。', '파일을 복제한다.', 1),
    (w, '複製禁止だ。', '복제 금지다.', 2);

  -- 784. 例外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '例外', 'れいがい', '예외', '例(법식 례)\n外(밖 외)', '명사', 784) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '例外は認めない。', '예외는 인정하지 않는다.', 1),
    (w, '例外として許可した。', '예외로 허가했다.', 2);

  -- 785. スクリーン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'スクリーン', 'すくりーん', '스크린', NULL, '명사', 785) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スクリーンをタッチする。', '스크린을 터치한다.', 1),
    (w, 'スクリーンが割れた。', '스크린이 깨졌다.', 2);

  -- 786. 冷静
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '冷静', 'れいせい', '냉정', '冷(천 령)\n静(고요할 정)', 'な형용사', 786) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冷静に判断した。', '냉정하게 판단했다.', 1),
    (w, '冷静さを保つ。', '냉정함을 유지한다.', 2);

  -- 787. 仕掛ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '仕掛ける', 'しかける', '걸어 놓다, 일을 시작하다', '仕(섬길 사)\n掛(걸 구)', '동사', 787) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を仕掛けた。', '일을 시작했다.', 1),
    (w, 'しかけている仕事がある。', '하다가 말아둔 일이 있다.', 2);

  -- 788. 起こす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '起こす', 'おこす', '일으키다', '起(일어날 기)', '동사', 788) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件を起こす。', '사건을 일으키다.', 1),
    (w, '関心を起こした。', '관심을 자아냈다.', 2);

  -- 789. 限り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '限り', 'かぎり', '한, 한한, 한도', '限(한계 한)', '명사', 789) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できる限り努力した。', '가능한 한 노력했다.', 1),
    (w, 'ひとりでいる限り、遇〶しい。', '혼자 있는 한 쓸쓸하다.', 2);

  -- 790. 艶やか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '艶やか', 'つややか', '윤이 남, 육머마먹은 근사해 보임', '艶(고울 염)', 'な형용사', 790) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '艶やかな肌だ。', '광칍이 남 피부다.', 1),
    (w, '艶やかな口調だ。', '우아한 어조다.', 2);

  -- 791. デザイン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'デザイン', 'でざいん', '디자인', NULL, '명사', 791) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デザインの仕事をしている。', '디자인 일을 하고 있다.', 1),
    (w, 'デザインがおしゃれだ。', '디자인이 세련되었다.', 2);

  -- 792. ストレス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'ストレス', 'すとれす', '스트레스', NULL, '명사', 792) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスがたまる。', '스트레스가 쌓인다.', 1),
    (w, 'ストレスを発散する。', '스트레스를 해소한다.', 2);

  -- 793. 領収
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '領収', 'りょうしゅう', '영수', '領(거느릴 령)\n収(거둘 수)', '명사', 793) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '領収書をもらう。', '영수증을 받는다.', 1),
    (w, '荷物を領収する。', '짐을 수령한다.', 2);

  -- 794. 誌る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '誌る', 'しるす', '기록하다', '誌(기록할 지)', '동사', 794) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な事を誌す。', '중요한 일을 기록한다.', 1),
    (w, '歴史に誌される。', '역사에 기록된다.', 2);

  -- 795. 代わり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '代わり', 'かわり', '대신', '代(대신할 대)', '명사', 795) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の代わりに行ってくれ。', '나 대신 가줘.', 1),
    (w, '代わりにこれを使おう。', '대신 이걸 쓰자.', 2);

  -- 796. 進路
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '進路', 'しんろ', '진로, 진학 또는 진출길', '進(나아갈 진)\n路(길 로)', '명사', 796) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '進路を決める。', '진로를 결정한다.', 1),
    (w, '進路に悩んでいる。', '진로에 대해 고민하고 있다.', 2);

  -- 797. 逕る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '逕る', 'おくる', '보내다', '逕(보낼 송)', '동사', 797) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物を逕る。', '짐을 보낸다.', 1),
    (w, '友達を逕る。', '친구를 배웅한다.', 2);

  -- 798. 適合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '適合', 'てきごう', '적합', '適(맞을 적)\n合(합할 합)', 'な형용사', 798) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この職に適合した人だ。', '이 직책에 적합한 사람이다.', 1),
    (w, '条件に適合する。', '조건에 부합한다.', 2);

  -- 799. 記憶
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '記憶', 'きおく', '기억', '記(기록할 기)\n憶(기억할 억)', '명사', 799) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶が鮮明だ。', '기억이 선명하다.', 1),
    (w, '如い記憶だ。', '존궼 기억이다.', 2);

  -- 800. 作る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '作る', 'つくる', '만들다', '作(지을 작)', '동사', 800) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理を作る。', '요리를 만든다.', 1),
    (w, '能助の股を作る。', '도움이 되는 입방을 만들다.', 2);

  -- 801. チャンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, 'チャンス', 'ちゃんす', '찬스', NULL, '명사', 801) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チャンスをつかむ。', '찬스를 잡는다.', 1),
    (w, '今がチャンスだ。', '지금이 기회다.', 2);

  -- 802. 進める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '進める', 'すすめる', '나아가게 하다, 진행하다', '進(나아갈 진)', '동사', 802) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を進める。', '일을 진행한다.', 1),
    (w, '計画を進める。', '계획을 추진한다.', 2);

  -- 803. とても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, NULL, 'とても', '매우, 도저히', NULL, '부사', 803) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とても面白い。', '매우 재미있다.', 1),
    (w, 'とてもできない。', '도저히 할 수 없다.', 2);

  -- 804. 取り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '取り出す', 'とりだす', '꺼내다', '取(가질 취)\n出(날 출)', '동사', 804) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カバンから本を取り出した。', '가방에서 책을 꺼냈다.', 1),
    (w, '財布を取り出す。', '지갑을 꺼낸다.', 2);

  -- 805. 規模さ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) values (d_n1, '規模さ', 'さわおくさ', '떠들석, 소란함', '規(소란할 소)\n模(소란할 소)', '명사', 805) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その規模さの中にいる。', '그 떠들석 속에 있다.', 1),
    (w, '規模さを起こした。', '떠들석을 만들었다.', 2);

end $$;
