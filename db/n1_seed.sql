-- ============================================================
-- JLPT N1 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N1-단어장)
-- ============================================================
-- 실행 시 기존 N1 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 1583단어 (PDF 어휘 989 + 「파이널 문법 체크북」 594 (형식판단 266 + 문장완성 205 + 문맥이해 123))
-- 유의어: 어휘 페어 154쌍 (PDF p.14~23) + 문법 페어 6쌍 (PDF p.40·47·48·50·51 ＝ 표시) = 양방향 320건
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
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '潤う', 'うるおう', '(1) 축축해지다 (2) 윤택해지다', '潤(불을 윤): 氵(물 수) + 閏(윤달 윤) → 물기가 스며들어 풍족해짐
자동사로 ''(물기·이익이) 늘어나다''의 의미로 발전', '동사', 1, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨で田畑が潤った。', '비로 논밭이 촉촉해졌다.', 1),
    (w, '観光客の増加で町が潤う。', '관광객 증가로 마을이 윤택해진다.', 2);

  -- 2. 極めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '極めて', 'きわめて', '매우, 지극히', '極(다할 극): 木(나무) + 亟(빠를 극) → 끝까지 다다르다
부사형 ''きわめて''는 ''이 이상 없을 정도로''의 의미', '부사', 2, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは極めて重要な問題だ。', '이것은 매우 중요한 문제다.', 1),
    (w, '結論を出すのは極めて難しい。', '결론을 내리기는 지극히 어렵다.', 2);

  -- 3. 契約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '契約', 'けいやく', '계약', '契(맺을 계): 칼로 새겨 약속을 표시함
約(맺을 약): 糸(실)을 묶어 약속을 잊지 않게 함', '명사', 3, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '来月、新しい家の契約をする。', '다음 달에 새 집 계약을 한다.', 1),
    (w, '契約書にサインしてください。', '계약서에 서명해 주세요.', 2);

  -- 4. 推理
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '推理', 'すいり', '추리', '推(밀 추): 扌(손)으로 밀어 나아가게 함 → 미루어 헤아림
理(다스릴 리): 玉(구슬)의 결을 따라 다듬다 → 이치, 도리', '명사', 4, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の推理はいつも鋭い。', '그의 추리는 항상 날카롭다.', 1),
    (w, '推理小説を読むのが趣味だ。', '추리 소설을 읽는 것이 취미다.', 2);

  -- 5. 壊す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '壊す', 'こわす', '부수다, 망가뜨리다', '壊(무너질 괴): 土(흙) + 褱(품을 회) → 흙이 품을 잃고 무너짐
타동사 ''こわす''는 의도적으로 무너뜨림을 의미', '동사', 5, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '弟が私のおもちゃを壊した。', '동생이 내 장난감을 부쉈다.', 1),
    (w, '無理をして体を壊さないで。', '무리해서 몸을 망가뜨리지 마.', 2);

  -- 6. 締める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '締める', 'しめる', '(끈을) 매다, 조이다', '締(맺을 체): 糸(실) + 帝(임금 제) → 실로 단단히 묶음
끈·매듭을 강하게 조이는 동작을 가리킴', '동사', 6, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴ひもをしっかり締める。', '신발끈을 단단히 맨다.', 1),
    (w, '気を引き締めて仕事に臨む。', '마음을 다잡고 일에 임한다.', 2);

  -- 7. 手薄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手薄', 'てうす', '허술한, 불충분한', '手(손 수): 사람의 손 모양 → 인력·자원을 의미
薄(엷을 박): 草(풀) + 溥(넓을 부) → 얇고 부족함', 'な형용사', 7, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜は警備が手薄になる。', '밤에는 경비가 허술해진다.', 1),
    (w, '人手が手薄で対応できない。', '일손이 부족해서 대응할 수 없다.', 2);

  -- 8. 練る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '練る', 'ねる', '반죽하다, (계획·문장을) 다듬다', '練(익힐 련): 糸(실) + 柬(가릴 간) → 실을 거듭 다듬어 정련함
반복하여 단련·정련하는 의미로 확장', '동사', 8, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小麦粉と水をよく練る。', '밀가루와 물을 잘 반죽한다.', 1),
    (w, '計画を練り直す必要がある。', '계획을 다시 다듬을 필요가 있다.', 2);

  -- 9. 華々しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '華々しい', 'はなばなしい', '화려하다', '華(빛날 화): 꽃이 활짝 핀 모양 → 화려함
반복형 ''華々''로 강조되어 ''매우 화려함''을 표현', 'い형용사', 9, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は華々しいデビューを飾った。', '그녀는 화려한 데뷔를 장식했다.', 1),
    (w, '華々しい活躍を見せた選手。', '화려한 활약을 보여준 선수.', 2);

  -- 10. 繁盛
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '繁盛', 'はんじょう', '번성, 번창', '繁(번성할 번): 糸(실) + 敏(민첩할 민) → 실이 무성하게 자람
盛(성할 성): 皿(그릇)에 가득 차오름 → 왕성함', '명사', 10, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '商売が繁盛している。', '장사가 번창하고 있다.', 1),
    (w, 'この店はいつも繁盛している。', '이 가게는 항상 번성하고 있다.', 2);

  -- 11. 伴奏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '伴奏', 'ばんそう', '반주', '伴(짝 반): 亻(사람) + 半(반) → 사람과 함께·짝으로
奏(아될 주): 양손으로 악기를 바쳐 소리를 내는 모양', '명사', 11, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノ伴奏で歌を歌う。', '피아노 반주로 노래를 부른다.', 1),
    (w, '彼女はバイオリン伴奏を担当した。', '그녀는 바이올린 반주를 담당했다.', 2);

  -- 12. 本筋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '本筋', 'ほんすじ', '본론, 본 줄거리', '本(근본 본): 木(나무) 아래에 표시 → 릌리, 근본
筋(힘줄 근): 竹(대나무) + 肋(고기 육) → 근육·줄기', '명사', 12, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が本筋からそれた。', '이야기가 본론에서 벗어났다.', 1),
    (w, '本筋に戻って議論しよう。', '본론으로 돌아가서 논의하자.', 2);

  -- 13. 閲覧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '閲覧', 'えつらん', '열람', '閲(검열할 열): 門(문) + 兌(달 열) → 문으로 들여보며 살핌
覧(볼 람): 臣(신하) + 見(볼 견) → 넓게 둘러보다', '명사', 13, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料の閲覧は無料です。', '자료 열람은 무료입니다.', 1),
    (w, '図書館で古い新聞を閲覧した。', '도서관에서 오래된 신문을 열람했다.', 2);

  -- 14. 合併
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '合併', 'がっぺい', '합병', '合(합할 합): 人(사람)·口(입)이 합쳐짐 → 하나로 모임
併(아우를 병): 亻(사람) + 并(나란히 병) → 사람을 나란히 세움', '명사', 14, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '企業同士の合併が発表された。', '기업 간 합병이 발표되었다.', 1),
    (w, '両社の合併で規模が拡大した。', '두 회사의 합병으로 규모가 확대되었다.', 2);

  -- 15. 肝心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '肝心', 'かんじん', '중요함, 가장 중요한 점', '肝(간 간): 肉(고기 육) + 干(방패 간) → 내장의 핵심
心(마음 심): 심장의 모양 → 마음·핵심의 의미', 'な형용사', 15, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肝心なときに彼はいない。', '중요한 때에 그는 없다.', 1),
    (w, '肝心なのは人の心だ。', '가장 중요한 것은 사람의 마음이다.', 2);

  -- 16. 兆し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '兆し', 'きざし', '징조, 조짐', '兆(조지·억 조): 거북 등껍이 갈라진 모양 → 점치고 조짐
「兆し」는 미리 나타나는 조짐·징후를 의미', '명사', 16, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '回復の兆しが見えてきた。', '회복의 조짐이 보이기 시작했다.', 1),
    (w, '春の兆しを感じる頃だ。', '봄의 징조를 느끼는 때금이다.', 2);

  -- 17. 考慮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '考慮', 'こうりょ', '고려', '考(생각할 고): 老(닅을 로)의 변형 → 깊이 생각함
慮(생각할 려): 虍(호랑이) + 思(생각) → 조심스럽게 살핌', '명사', 17, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それも考慮に入れて決めよう。', '그것도 고려해서 결정하자.', 1),
    (w, '予算を考慮して計画を立てる。', '예산을 고려해서 계획을 세운다.', 2);

  -- 18. 根拠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '根拠', 'こんきょ', '근거', '根(뿌리 근): 木(나무) + 艮(어길 간) → 나무의 뿌리
拠(근거 거): 手(손) + 虔(웅활 거) → 손으로 의지함', '명사', 18, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その主張には根拠がない。', '그 주장에는 근거가 없다.', 1),
    (w, '科学的な根拠に基づく説明だ。', '과학적 근거에 근거한 설명이다.', 2);

  -- 19. 遮る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '遮る', 'さえぎる', '차단하다', '遮(가릴 차): 辶(갈 착) + 庶(여러 서) → 여러 것을 가로막음
빛·시야 등을 가로막는 동작을 나타냄', '동사', 19, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーテンで光を遮る。', '커튼으로 빛을 차단한다.', 1),
    (w, '大きなビルが視界を遮った。', '큰 빌딩이 시야를 가렸다.', 2);

  -- 20. 釈明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '釈明', 'しゃくめい', '석명, 해명', '釈(풀 석): 釆(분별할 변) + 尺(자 척) → 하나하나 분별해 풀이
明(밝을 명): 日(해) + 月(달) → 밝게 드러냄', '명사', 20, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代表が釈明を述べた。', '대표가 해명을 내놓았다.', 1),
    (w, '誤解について釈明する必要がある。', '오해에 대해 해명할 필요가 있다.', 2);

  -- 21. 鈍る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '鈍る', 'にぶる', '둔해지다, 무디어지다', '鈍(둔할 둔): 金(쇠) + 屯(진 칠 둔) → 쇠가 무던
감각·날카로움이 떨어진 상태를 표현', '동사', 21, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '疲れで動きが鈍る。', '피로로 움직임이 둔해진다.', 1),
    (w, '老化で感覚が鈍る。', '노화로 감각이 무디어진다.', 2);

  -- 22. 逃れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '逃れる', 'のがれる', '벗어나다, 피하다', '逃(도망칠 도): 辶(갈 착) + 兆(조짐 조) → 조짐을 보고 도망감
자동사 형태로 위험·곤란에서 벗어남을 나타냄', '동사', 22, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '越哈して責任を逃れた。', '어제그저로 책임을 피했다.', 1),
    (w, '危険から逃れるために走る。', '위험에서 벗어나기 위해 달린다.', 2);

  -- 23. 漠然と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '漠然と', 'ばくぜんと', '막연하게', '漠(넘을 막): 氵(물) + 莫(없을 막) → 물이 없는 사막
然(그럴 연): 犬(개)의 고기를 태움 → 상태 보조사', '부사', 23, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来について漠然と考える。', '미래에 대해 막연하게 생각한다.', 1),
    (w, '不安が漠然と広がる。', '불안이 막연히 퍼진다.', 2);

  -- 24. 利益
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '利益', 'りえき', '이익', '利(이로울 리): 禾(벼) + 刂(칼) → 칼로 벼를 베어 이득
益(더할 익): 水(물)이 皿(그릇)에 넘침 → 넘치는 이득', '명사', 24, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今期の利益は上がった。', '이번 분기의 이익이 올랐다.', 1),
    (w, '会社の利益より顧客の利益を優先する。', '회사 이익보다 고객의 이익을 우선한다.', 2);

  -- 25. 改革
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '改革', 'かいかく', '개혁', '改(고칠 개): 己(자기) + 攵(칠 복) → 자기를 채챍질하여 고침
革(가죽 혁): 짐승의 가죽을 벴겨냄 → 완전히 바꿈', '명사', 25, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政治の改革が求められる。', '정치의 개혁이 요구된다.', 1),
    (w, '教育制度の改革が進んでいる。', '교육 제도의 개혁이 진행되고 있다.', 2);

  -- 26. 覆す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '覆す', 'くつがえす', '뒤집어엎다', '覆(뒤집힐 복): 西(다듰 아·덮을 아) + 復(되돌아갈 복) → 덮여있던 것을 뒤집음
임박이나 설을 뒤바꾸는 의미로 확장', '동사', 26, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '説を覆す証拠が見つかった。', '설을 뒤집을 증거가 발견되었다.', 1),
    (w, '下位チームが預想を覆した。', '하위 팀이 예상을 뒤집었다.', 2);

  -- 27. 克明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '克明', 'こくめい', '극명함', '克(이길 극): ジ(입) + 儿(사람) → 힘들게 이겨냄
明(밝을 명): 日(해) + 月(달) → 밝게 환하게', 'な형용사', 27, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を克明に記録する。', '상황을 극명하게 기록한다.', 1),
    (w, '現場の様子が克明に描かれている。', '현장의 모습이 극명하게 그려져 있다.', 2);

  -- 28. 群衆
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '群衆', 'ぐんしゅう', '군중', '群(무리 군): 君(임금) + 羊(양) → 양떼처럼 모임
衆(무리 중): 血(피) + 众(무리) → 많은 사람이 모임', '명사', 28, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '群衆の中で迷子になった。', '군중 속에서 미아가 되었다.', 1),
    (w, '群衆心理が事件を拡大させた。', '군중심리가 사건을 확대시켰다.', 2);

  -- 29. 心地よい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '心地よい', 'ここちよい', '기분 좋다, 상쿨하다', '心地(ここち): 마음(心) + 장소(地) → 마음의 상태·기분
''よい(좋다)''가 붙어 ''기분이 좋다''의 의미', 'い형용사', 29, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春の風が心地よい。', '봄바람이 상쿨하다.', 1),
    (w, 'このソファは座り心地がよい。', '이 소파는 앉는 기분이 좋다.', 2);

  -- 30. 費やす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '費やす', 'ついやす', '사용하다, 소비하다', '費(쓸 비): 貝(조개) + 弗(아닐 불) → 재물을 쓴
타동사 형태로 시간·돈·노력을 소비하는 의미', '동사', 30, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多くの時間を費やした。', '많은 시간을 소비했다.', 1),
    (w, '計画に費やした努力が実を結んだ。', '계획에 쓸움었던 노력이 결실을 맺었다.', 2);

  -- 31. 手際
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手際', 'てぎわ', '일처리 솨씨, 수완', '手(손 수): 손으로 일을 다루는 기술
際(가 제): 阜(언덕) + 祭(제사 제) → 경계·타이밍이 적절함', '명사', 31, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの人の仕事の手際は見事だ。', '그 사람의 일처리 솨씨는 훌륭하다.', 1),
    (w, '手際よく会議を進めた。', '수완 좋게 회의를 진행했다.', 2);

  -- 32. 踏襲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '踏襲', 'とうしゅう', '답습', '踏(밟을 답): 足(발) + ⊣(구임서 답) → 발로 밟음
襲(엄습할 습): 龍(용) + 衣(옷) → 이전 것을 그대로 겹쳐 입음', '명사', 32, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先代の方針を踏襲する。', '선대의 방침을 답습한다.', 1),
    (w, '伝統を踏襲しつつ革新を図る。', '전통을 답습하면서 혁신을 추구한다.', 2);

  -- 33. 名誉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '名誉', 'めいよ', '명예', '名(이름 명): 夕(저녁) + 口(입) → 어둡는데 입으로 이름을 부름
誉(기릴 예): 言(말) + 與(더불을 여) → 칭찬하는 말을 주고받음', '명사', 33, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の名誉を守る。', '회사의 명예를 지킨다.', 1),
    (w, 'それは君にとって名誉なことだ。', '그것은 너에게 명예로운 일이다.', 2);

  -- 34. 網羅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '網羅', 'もうら', '망라', '網(그물 망): 糸(실) + 罔(부르짖어 망) → 그물
羅(벌라일 라): 罔(그물) + 絭(비단) → 그물로 새를 잡는 모양', '명사', 34, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この辞書は同義語を網羅している。', '이 사전은 동의어를 망라하고 있다.', 1),
    (w, '總務は事務作業を網羅する。', '총무는 사무작업을 망라한다.', 2);

  -- 35. 由緒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '由緒', 'ゆいしょ', '유서, 내력', '由(말미암을 유): 경공으로 이어진 골 → 이때됩·원인
緒(실마리 서): 糸(실) + 者(놈 자) → 실의 끝·단서', '명사', 35, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この寺には長い由緒がある。', '이 절에는 오랜 유서가 있다.', 1),
    (w, '由緒ある家柄に生まれた。', '내력 있는 가문에서 태어났다.', 2);

  -- 36. 枠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '枠', 'わく', '틀, 테두리', '枠(틀 와): 木(나무) + 詶(차머리 괄) → 나무로 둘레세운 틀
경계·한계·틀을 나타내는 명사로 사용', '명사', 36, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予算の枠を超える。', '예산의 틀을 넘어선다.', 1),
    (w, '常識の枠に囚われる。', '상식의 틀에 사로잡힌다.', 2);

  -- 37. 跡地
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '跡地', 'あとち', '철거 부지', '跡(발자취 적): 足(발) + 亦(또 역) → 발자국·흔적
地(땅 지): 土(흥) + 也(이끌 야) → 면적·터', '명사', 37, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '跡地に新しいビルが建つ。', '철거 부지에 새 빌딩이 세워진다.', 1),
    (w, '広い跡地を公園に生まれ変わらせる。', '넓은 철거 부지를 공원으로 탈바꿔움시킨다.', 2);

  -- 38. 憤り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '憤り', 'いきどおり', '분노', '憤(텔 분): 心(마음) + 賁(클 분) → 마음이 크게 일레다
명사형 ''憤り''는 특히 강한 분노·분개의 감정', '명사', 38, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '憤りを抱きながら手紙を書いた。', '분노를 품으며 편지를 썼다.', 1),
    (w, '不正に対する憤りが加わった。', '부정에 대한 분노가 더해졌다.', 2);

  -- 39. 憩い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '憩い', 'いこい', '휴식', '憩(쉬 게): 息(숲 식) + 心(마음) → 숨을 고르며 마음을 쉬게함
명사형 ''憩い''는 편안한 휴식의 의미', '명사', 39, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園は市民の憩いの場だ。', '공원은 시민의 휴식의 장이다.', 1),
    (w, '里山で静かな憩いの一時を過ごす。', '시골에서 고요한 휴식의 시간을 보낸다.', 2);

  -- 40. 愚かな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '愚かな', 'おろかな', '어리석은', '愚(어리석을 우): 禹(원숭이 우) + 心(마음) → 마음이 원숭이처럼 어린석음
「おろかな」는 생각이 얖은 상태를 표현', 'な형용사', 40, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな愚かなことを言うな。', '그런 어리석은 말을 하지 마라.', 1),
    (w, '愚かな判断をして後悔した。', '어리석은 판단을 해서 후회했다.', 2);

  -- 41. 緩和
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '緩和', 'かんわ', '완화', '緩(느릴 완): 糸(실) + 援(도울 원) → 실을 느슨하게 하여 완화함
和(화할 화): 禾(벼) + 口(입) → 먹을 것을 움키면 평온해짐', '명사', 41, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規制の緩和が期待される。', '규제의 완화가 기대된다.', 1),
    (w, '緊張を緩和させる音楽だ。', '긴장을 완화시키는 음악이다.', 2);

  -- 42. 巧妙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '巧妙', 'こうみょう', '교묘함', '巧(공교할 교): 工(장인) + 丕(소리날 키) → 장인의 솨씨가 뛰어남
妙(묘할 묘): 女(여자) + 少(적을 소) → 세밀하고 아름다움', 'な형용사', 42, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '巧妙な手口でただまされた。', '교묘한 수법으로 속았다.', 1),
    (w, '巧妙な仕掛けがある装置だ。', '교묘한 장치가 있는 장비다.', 2);

  -- 43. 趣旨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '趣旨', 'しゅし', '취지', '趣(뚜 취): 走(달릴 주) + 取(취할 취) → 너계서 취함 → 흥미·뚜
旨(뜻 지): 旦(아침 단) + 口(입) → 주된 뜻', '명사', 43, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会の趣旨を説明した。', '모임의 취지를 설명했다.', 1),
    (w, 'ご趣旨に賛同いたします。', '취지에 찬동합니다.', 2);

  -- 44. 需要
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '需要', 'じゅよう', '수요', '需(쓰일 수): 雨(비) + 而(말 이을 이) → 비가 올 때까지 기다림
要(요긴할 요): 西(서띞 서) + 女(여자) → 소중하게 구함', '명사', 44, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気自動車の需要が增えている。', '전기차의 수요가 늘고 있다.', 1),
    (w, '需要と供給のバランスが重要だ。', '수요와 공급의 밸런스가 중요하다.', 2);

  -- 45. 貫く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '貫く', 'つらぬく', '관철하다', '貫(꾰을 관): 毌(꾸러미) + 貝(조개) → 조개를 꾰어 임
난관·의지를 끝까지 관철한다는 동사로 사용', '동사', 45, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初志を貫いて頂上に辿り着いた。', '초지일관으로 정상에 도착했다.', 1),
    (w, '自分の道を貫いて生きる。', '자기의 길을 관철하며 산다.', 2);

  -- 46. 日夜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '日夜', 'にちや', '밤낮, 늘', '日(날 일): 해의 모양 → 낮
夜(밤 야): 多(많을 다의 변형) + 夕(저녁) → 해가 진 뒤', '명사', 46, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日夜努力している。', '밤낮으로 노력하고 있다.', 1),
    (w, '日夜の区別なく働く。', '밤낮 구별 없이 일한다.', 2);

  -- 47. 把握
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '把握', 'はあく', '파악', '把(잡을 파): 手(손) + 巴(큰 뱀 파) → 손으로 꿉 잡음
握(쥐조그리 악): 手(손) + 屋(집 옥) → 손 안에 넣음', '명사', 47, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を正確に把握する。', '상황을 정확히 파악한다.', 1),
    (w, '代表は現状を把握している。', '대표는 현상황을 파악하고 있다.', 2);

  -- 48. 貧富
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '貧富', 'ひんぷ', '빈부', '貧(가난할 빈): 分(나눌 분) + 貝(조개) → 재산을 나눌어 적음
富(부자 부): 宀(집) + 畑(가득할 복) → 집에 재물이 가득', '명사', 48, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貧富の差が拡大している。', '빈부의 차가 확대되고 있다.', 1),
    (w, '貧富に関わらず教育は重要だ。', '빈부와 상관없이 교육은 중요하다.', 2);

  -- 49. 否めない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '否めない', 'いなめない', '부정할 수 없다', '否(아닐 부): 不(아니울 불) + 口(입) → 아니라고 말함
「否む(부정하다)」의 가능 형태가 부정되는 구조', '표현', 49, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の能力は否めない。', '그의 능력은 부정할 수 없다.', 1),
    (w, '影響を受けたことは否めない事実だ。', '영향을 받은 것은 부정할 수 없는 사실이다.', 2);

  -- 50. 概略
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '概略', 'がいりゃく', '개략', '概(대략 개): 木(나무) + 既(이미 기) → 대제 이미 정해진 틀
略(간략할 략): 田(밭) + 各(각각 각) → 조각·대략적', '명사', 50, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の内容を概略する。', '회의 내용을 개략한다.', 1),
    (w, '説明書の概略を記す。', '설명서의 개략을 적는다.', 2);

  -- 51. 凝縮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '凝縮', 'ぎょうしゅく', '응축', '凝(엉길 응): 冰(얼음) + 疑(의심할 의) → 굳게 엉김
縮(줄일 축): 糸(실) + 宿(쟔 숙) → 실을 싁아서 짧게 함', '명사', 51, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の経験を凝縮した作品だ。', '오랜 경험을 응축한 작품이다.', 1),
    (w, 'スープを凝縮して濃い味にする。', '수프를 응축해서 진한 맛으로 한다.', 2);

  -- 52. 厳正
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '厳正', 'げんせい', '엄정함', '厳(엄할 엄): 口(입) + 厈(엄할 엄) → 편지게 말하고 엄격
正(바를 정): 一(하나) + 止(멈춤) → 하나의 올바른 곳에 멈춤', 'な형용사', 52, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳正な審査を受ける。', '엄정한 심사를 받는다.', 1),
    (w, '厳正に規則を遵守させる。', '엄정하게 규칙을 준수시킨다.', 2);

  -- 53. 拒む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '拒む', 'こばむ', '거부하다', '拒(막을 거): 手(손) + 巨(클 거) → 손으로 크게 막음
자동사 형태로 제안·요구를 막아 거절하는 의미', '동사', 53, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '提案を拒んだ理由を説明する。', '제안을 거부한 이유를 설명한다.', 1),
    (w, '彼は協力を拒んだ。', '그는 협력을 거부했다.', 2);

  -- 54. 遂行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '遂行', 'すいこう', '수행', '遂(드디어 수): 辶(갈 착) + 適(수달할 수) → 끝까지 이루어냄
行(다닐 행): 그림자길의 모양 → 걸으며 일을 함', '명사', 54, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '任務を遂行するため努力する。', '임무를 수행하기 위해 노력한다.', 1),
    (w, '計画の遂行には資金が必要だ。', '계획의 수행에는 자금이 필요하다.', 2);

  -- 55. 健やか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '健やか', 'すこやか', '건강함', '健(굽셌 건): 亻(사람) + 建(세울 건) → 사람이 이른 굽셌
고유어 ''すこやか''는 학아들이 강건하게 자라는 모습', 'な형용사', 55, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健やかに肉ている。', '건강하게 자라고 있다.', 1),
    (w, '健やかな身体を保つために運動する。', '건강한 몸을 유지하기 위해 운동한다.', 2);

  -- 56. 漂う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '漂う', 'ただよう', '떠돌다, 감돌다', '漂(떠다닐 표): 氵(물) + 票(표 표) → 물 위를 떠다닐
향기·분위기가 공중에 감독는 모습에도 사용', '동사', 56, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '起源不明の漂流物が見つかった。', '출처 불명의 표류물이 발견되었다.', 1),
    (w, '気品のある香りが漂う。', '고품의 향기가 감돌고 있다.', 2);

  -- 57. 中枢
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '中枢', 'ちゅうすう', '중추', '中(가운데 중): 깃발에 꿰은 모양 → 가운데
枢(쓜리목 추): 木(나무) + 区(지역 구) → 문 닫히 끌채·핵심', '명사', 57, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '都心部は経済の中枢だ。', '도심부는 경제의 중추다.', 1),
    (w, '組織の中枢を担う人物だ。', '조직의 중추를 담당하는 인물이다.', 2);

  -- 58. 督促
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '督促', 'とくそく', '독촉', '督(감독할 독): 叔(아저씨 숙) + 目(눈) → 눈으로 잘펴봄
促(재촉할 촉): 亻(사람) + 足(발) → 사람을 쪻아 재촉함', '명사', 58, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未払い金の督促状が届いた。', '미지급금 독촉장이 도착했다.', 1),
    (w, '何度も督促したが返事がない。', '몇 번이나 독촉했지만 답장이 없다.', 2);

  -- 59. 臨む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '臨む', 'のぞむ', '임하다, (상황에) 직면하다', '臨(임할 임): 臣(신하) + 品(물건 품) → 아래를 내려다 본
''임하다''·''직면하다''의 의미로 확장', '동사', 59, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危機に臨んで冷静さを保った。', '위기에 직면해서 냉정함을 유지했다.', 1),
    (w, '会議に臨む姿勢が重要だ。', '회의에 임하는 자세가 중요하다.', 2);

  -- 60. 躍進
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '躍進', 'やくしん', '약진', '躍(뛸 약): 足(발) + 羿(꿩 적) → 높이 뛰어오름
進(나아갈 진): 辶(갈 착) + 隹(새 추) → 새처럼 앞으로 나아감', '명사', 60, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社は今年、躍進を遇げた。', '회사는 올해 약진을 이뤄냈다.', 1),
    (w, '躍進してトップ企業になった。', '약진해서 최고 기업이 되었다.', 2);

  -- 61. 値する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '値する', 'あたいする', '~할 가치가 있다', '値(값 치): 亻(사람) + 直(곧을 직) → 사람이 마땍하다고 판단
동사화 ''する''이 붙어 「가치가 있다」의 의미', '동사', 61, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この作品は読むに値する。', '이 작품은 읽을 가치가 있다.', 1),
    (w, '彼の努力は評価に値する。', '그의 노력은 평가할 가치가 있다.', 2);

  -- 62. 淡い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '淡い', 'あわい', '연하다, 흐리다', '淡(묽을 담): 氵(물) + 炎(불타오를 염) → 물이 맑고 색이 얇음
색조·맛·감정이 진하지 않은 상태를 표현', 'い형용사', 62, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その色は淡い青だ。', '그 색은 연한 파란이다.', 1),
    (w, '淡い期待を抱いていた。', '희미한 기대를 품고 있었다.', 2);

  -- 63. 画一的
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '画一的', 'かくいつてき', '획일적인', '画一(그을 획 · 하나 일): 그은 듯이 똑같이 하나
的(과녁 적): 白(흰) + 勺(숨을 드릴 석) → 성질·특징을 나타냄', 'な형용사', 63, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画一的な教育を見直す。', '획일적인 교육을 재검토한다.', 1),
    (w, '画一的なファッションを避ける。', '획일적인 패션을 피한다.', 2);

  -- 64. 興奋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '興奋', 'こうふん', '흥분', '興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 들어올림
奋(떨칠 분): 大(클 대) + 隹(새 추) → 큰 새가 날개치게 할', '명사', 64, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試合の勝利で興奋した。', '경기 승리로 흥분했다.', 1),
    (w, '興奋してやずれてしまった。', '흥분해서 잠을 설체고 말았다.', 2);

  -- 65. 慕われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '慕われる', 'したわれる', '추앙받다, 존경받다', '慕(그리워할 모): 莫(없을 막) + 心(마음) → 마음이 끌리는 마음
수동형 ''したわれる''은 다른 사람에게 존경받는 것', '동사', 65, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多くの人に慕われる人物だ。', '많은 사람에게 존경받는 인물이다.', 1),
    (w, '彼は同僚から慕われている。', '그는 동료들에게 추앙받고 있다.', 2);

  -- 66. 承諾
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '承諾', 'しょうだく', '승낙', '承(이을 승): 以(당이울) + 口(입) + 手(손) → 이어받음
諾(허락할 낙): 言(말) + 若(같을 약) → 그래도 좋다고 말함', '명사', 66, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の承諾を得る。', '상사의 승낙을 얻는다.', 1),
    (w, '提案は承諾された。', '제안이 승낙되었다.', 2);

  -- 67. 随時
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '随時', 'ずいじ', '수시로', '随(따를 수): 阜(언덕) + 左(왼 좌) + 辶(갈 착) → 따라감
時(때 시): 日(해) + 寺(절) → 일정 시간·때마다', '부사', 67, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問は随時受け付ける。', '질문은 수시로 받는다.', 1),
    (w, '随時連絡してください。', '수시로 연락해 주세요.', 2);

  -- 68. 添付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '添付', 'てんぷ', '첨부', '添(더할 첨): 氵(물) + 涻(닭울 첨) → 물을 더 부음
付(붙을 부): 亻(사람) + 寸(마디) → 손으로 건네주어 붙임', '명사', 68, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳細を添付ファイルで送った。', '상세를 첨부파일로 보냈다.', 1),
    (w, '領収書を添付してください。', '영수증을 첨부해 주세요.', 2);

  -- 69. 唱える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '唱える', 'となえる', '외치다, 주장하다', '唱(부를 창): 口(입) + 昌(창성할 창) → 입으로 소리 높이 부름
주장·구호를 외치는 의미로 확장', '동사', 69, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境保護を唱える。', '환경 보호를 주장한다.', 1),
    (w, '彼は新しい理論を唱えた。', '그는 새로운 이론을 주장했다.', 2);

  -- 70. 励む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '励む', 'はげむ', '힘쓰다', '励(힘쓸 려): 厲(갈 려) + 力(힘) → 떠자하지 않고 힘을 다함
명사형 ''励み''는 열일을 의미함', '동사', 70, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に励む姿勢が見事だ。', '일에 힘쓰는 자세가 훌륭하다.', 1),
    (w, '毎日勉強に励む学生だ。', '매일 공부에 힘쓰는 학생이다.', 2);

  -- 71. 破損
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '破損', 'はそん', '파손', '破(깨트릴 파): 石(돌) + 皮(가죽) → 돌이 가죽을 찢음
損(덜 손): 手(손) + 員(관원) → 손으로 구성품을 덜어냄', '명사', 71, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '車の破損状態がひどい。', '차의 파손 상태가 심하다.', 1),
    (w, '設備の破損を防ぐ為の対策をとる。', '설비의 파손을 막기 위해 대책을 세운다.', 2);

  -- 72. 変遷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '変遷', 'へんせん', '변천', '変(변할 변): 言(말) + 攵(칠 복) → 언론이 바뀌고 터지
遷(옮길 천): 辶(갈 착) + 遷(옮길 천) → 이동·변화', '명사', 72, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時代の変遷をひしひしと感じる。', '시대의 변천을 절감한다.', 1),
    (w, '言語の変遷を記録した本だ。', '언어의 변천을 기록한 책이다.', 2);

  -- 73. 賢い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '賢い', 'かしこい', '뚜뚝하다', '賢(어질 현): 臣(신하) + 又(또 우) + 貝(조개) → 신하가 재물을 현명하게 다루어 어진 사람
''かしこい''는 지혜롤움·영리함을 표현', 'い형용사', 73, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '賢い選択をした。', '현명한 선택을 했다.', 1),
    (w, 'この犬はとても賢い。', '이 개는 아주 뚜뚝하다.', 2);

  -- 74. 偏る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '偏る', 'かたよる', '치우치다, 편향되다', '偏(치우칠 편): 亻(사람) + 扁(낮을 편) → 낮고 한쪽으로 기웄
자동사 형태로 교형이 깨져 한쪽으로 쪼림을 나타냄', '동사', 74, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が偏らないように気を付ける。', '의견이 치우치지 않도록 조심한다.', 1),
    (w, '食事が肉に偏りがちだ。', '식사가 육류에 치우치기 쉬운 편이다.', 2);

  -- 75. 鑑定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '鑑定', 'かんてい', '감정, 판정', '鑑(거울 감): 金(쇠) + 監(볼 감) → 쇠롯을 자세히 살핌
定(정할 정): 宀(집) + 正(바를 정) → 집안을 바르게 정함', '명사', 75, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '骨董品を鑑定してもらう。', '골동품을 감정받는다.', 1),
    (w, '街で鑑定番組が人気だ。', '거리에서 감정 프로그램이 인기다.', 2);

  -- 76. 顕著
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '顕著', 'けんちょ', '현저함', '顕(나타날 현): 頁(머리) + 魯(멓이타조 권) → 환히 드러남
著(나타날 저): 艸(풀) + 者(놈 자) → 뚜렷해 잘 보임', 'な형용사', 76, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '効果が顕著に現れた。', '효과가 현저하게 나타났다.', 1),
    (w, '顕著な進歩が見られる。', '현저한 진보가 보인다.', 2);

  -- 77. 樹木
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '樹木', 'じゅもく', '수목, 큰 나무', '樹(나무 수): 木(나무) + 設(베풀 등) → 세워서 기르는 나무
木(나무 목): 나무의 모양', '명사', 77, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公園に是々たる樹木がある。', '공원에 웅장한 수목이 있다.', 1),
    (w, '樹木の事だもれた町だ。', '수목이 우거진 도시다.', 2);

  -- 78. 人脈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '人脈', 'じんみゃく', '인맥', '人(사람 인): 사람이 서있는 모양
脈(줄기 맥): 肉(고기 육) + 永(길 영) → 근육의 이어짐', '명사', 78, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事には人脈が重要だ。', '일에는 인맥이 중요하다.', 1),
    (w, '広い人脈を持つ人だ。', '넓은 인맥을 가진 사람이다.', 2);

  -- 79. 廃れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '廃れる', 'すたれる', '쇠퇴하다', '廃(폐할 폐): 广(집) + 発(핀 발) → 집이 버려져 무너짐
자동사 형태로 운용·유행이 쓰이지 않게 됨을 의미', '동사', 79, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い風習が廃れている。', '오랜 풍습이 쇠퇴하고 있다.', 1),
    (w, 'この言い回しは廃れてしまった。', '이 표현은 쓰이지 않게 되어 버렸다.', 2);

  -- 80. 相場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '相場', 'そうば', '시세', '相(서로 상): 木(나무) + 目(눈) → 나무를 눈으로 자세히 봄 → 모습
場(마당 장): 土(흥) + 够(해가 온어떨 양) → 택 트인 곳', '명사', 80, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金の相場が上がっている。', '금 시세가 오르고 있다.', 1),
    (w, '不動産の相場を調べる。', '부동산의 시세를 알아본다.', 2);

  -- 81. 多岐
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '多岐', 'たき', '다기, 다방면', '多(많을 다): 夕(저녁)이 거듭됨 → 많음
岐(갈래길 기): 山(산) + 支(갈래질 지) → 여러 갈래길로 나닄', '명사', 81, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の趣味は多岐にわたる。', '그의 취미는 다방면에 걸친다.', 1),
    (w, '仕事の内容は多岐にわたっている。', '일의 내용은 다방면에 걸쳐있다.', 2);

  -- 82. 蓄える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '蓄える', 'たくわえる', '저축하다, 비축하다', '蓄(한은 축): 艸(풀) + 畜(가축 축) → 풀을 가축의 먹이로 쌓아둔
재물·지식을 모아둔다는 의미로 확장', '동사', 82, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '老後のために貯金を蓄える。', '노후를 위해 저금을 저축한다.', 1),
    (w, 'エネルギーを蓄えて試合に臨む。', '에너지를 비축해서 경기에 임한다.', 2);

  -- 83. 陳列
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '陳列', 'ちんれつ', '진열', '陳(베풀 진): 阜(언덕) + 東(동녕 동) → 언덕에 가지런히 놓음
列(벌일 렬): 歹(병에 걸릴 뱍) + 刂(칼) → 줄지어 벌임', '명사', 83, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新商品を棚に陳列した。', '신상품을 선반에 진열했다.', 1),
    (w, '陳列棚が見易いように設計された。', '진열대가 보기 쉬게 설계되었다.', 2);

  -- 84. 華やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '華やかな', 'はなやかな', '화려한', '華(빛날 화): 꽃이 활짝 핀 모양
''はなやか」는 빛·색·소리가 돋보이는 상태를 표현', 'な형용사', 84, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '華やかなドレスを着てパーティーに出た。', '화려한 드레스를 입고 파티에 갔다.', 1),
    (w, 'はなやかな雰囲気のホテルだ。', '화려한 분위기의 호텔이다.', 2);

  -- 85. 潤す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '潤す', 'うるおす', '적시다, 축축하게 하다', '潤(불을 윤): 氵(물) + 閏(윤달 윤) → 물기를 더함
타동사로 ''うるおす''는 적셔 서서히 함', '동사', 85, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春の雨が大地を潤す。', '봄비가 대지를 적신다.', 1),
    (w, '言葉が心を潤した。', '말이 마음을 촉촉하게 적심다.', 2);

  -- 86. 傾斜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '傾斜', 'けいしゃ', '경사, 기울기', '傾(기울 경): 亻(사람) + 頃(잠깐 경) → 머리가 잘식 기욳
斜(빗금 사): 斗(말 두) + 余(남을 여) → 말을 겹쳐 넓은·기울어짐', '명사', 86, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道の傾斜がも、野い。', '길의 경사가 그림에 겁이 난다.', 1),
    (w, '人口減少の傾斜が鮮明だ。', '인구감소의 경향이 선명하다.', 2);

  -- 87. 殺菌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '殺菌', 'さっきん', '살균', '殺(죽일 살): 殳(목숨 끚을 살) + 殳(칠 수) → 생명을 죽임
菌(버섯 균): 艸(풀) + 菌(먹을 대우 균) → 미생물·고균', '명사', 87, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '殺菌スプレーを使う。', '살균 스프레이를 사용한다.', 1),
    (w, '高温で殺菌する。', '고온으로 살균한다.', 2);

  -- 88. 託す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '託す', 'たくす', '맡기다, 부탁하다', '託(부탁할 탁): 言(말) + 乇(탁) → 말을 의지하여 맡김
타동사 형태로 타인에게 일·물건을 맡게 함', '동사', 88, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ペットを友人に託して出掛ける。', '펭을 친구에게 맡기고 나간다.', 1),
    (w, '思いを手紙に託した。', '마음을 편지에 담아 맡겼다.', 2);

  -- 89. 暴露
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '暴露', 'ばくろ', '폭로', '暴(사나울 폭): 日(해) + 出(날 출) + 米(쌌 미) → 해에 드러남
露(이슬 로): 雨(비) + 路(길 로) → 빗장에 드러남', '명사', 89, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不正が暴露された。', '부정이 폭로되었다.', 1),
    (w, '機密情報の暴露を防ぐ。', '기밀정보의 폭로를 막는다.', 2);

  -- 90. 阮む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '阮む', 'はばむ', '저지하다, 가로막다', '阮(막을 저): 阜(언덕) + 且(또 차) → 언덕이 거듭 막힌
자동사 형태로 진행·서두름을 막아섬을 나타냄', '동사', 90, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '進路を阮む障害がある。', '진로를 가로막는 장애가 있다.', 1),
    (w, '雨が外出を阮んだ。', '비가 외출을 가로막았다.', 2);

  -- 91. 開拓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '開拓', 'かいたく', '개척', '開(열 개): 門(문) + 幵(빗장 개) → 문을 엽
拓(넓힐 척): 手(손) + 石(돌) → 손으로 돌을 어처 의공간 마련', '명사', 91, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい市場の開拓を進める。', '새로운 시장 개척을 추진한다.', 1),
    (w, '荒れ地を開拓して甿とした。', '황무지를 개척해서 밭으로 삼았다.', 2);

  -- 92. 復興
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '復興', 'ふっこう', '부흥', '復(되돌아갈 복): 徳(갈 척) + 復(되돌아갈 복) → 다시 돌아옴
興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 일어남', '명사', 92, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被災地の復興が進んでいる。', '재난지의 부흥이 진행되고 있다.', 1),
    (w, '伝統文化の復興を目指す。', '전통문화의 부흥을 목표로 한다.', 2);

  -- 93. 怠る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '怠る', 'おこたる', '소홀히하다, 게을리하다', '怠(게을림 태): 台(별 태) + 心(마음) → 마음이 느슨해짐
해야할 일을 따롱하게 멈춤이는 의미로 사용', '동사', 93, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予備を怠り、失敗した。', '준비를 소홀히해서 실패했다.', 1),
    (w, '努力を怠ってはいけない。', '노력을 게을리 해서는 안 된다.', 2);

  -- 94. 了承
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '了承', 'りょうしょう', '승낙, 양해', '了(마칠 료): 이루어짐·끝남
承(이을 승): 以(냫어섬) + 手(손) → 받아들임', '명사', 94, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご了承いただきます。', '양해해 주시기 바랍니다.', 1),
    (w, '上司の了承を得たうえで進める。', '상사의 승낙을 받고 진행한다.', 2);

  -- 95. 巡り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '巡り', 'めぐり', '순회, 돌아봄', '巡(돌 순): 巛(개너질 차) + 辶(갈 착) → 강을 건너며 돌아다닐
명사형 ''めぐり''는 이곳저곳 돌아다닐을 표현', '명사', 95, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全国を巡るツアーだ。', '전국을 도는 투어다.', 1),
    (w, '助長の巡りをしている。', '조장이 순회를 하고 있다.', 2);

  -- 96. 指図
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '指図', 'さしず', '지시', '指(가리킬 지): 手(손) + 旨(뜻 지) → 손으로 가리키며 뜻을 전함
図(그림 도): 国(테두리) + 圖(그릴 도) → 그림·계획', '명사', 96, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司の指図で動いた。', '상사의 지시대로 움직였다.', 1),
    (w, 'それは何者かの指図かもしれない。', '그것은 누군가의 지시일지도 모른다.', 2);

  -- 97. 回顧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '回顧', 'かいこ', '회고', '回(돌아올 회): 삼중의 네모난 모양 → 돌림
顧(돌아볼 고): 雇(고용할 고) + 頁(머리) → 목을 돌려 뒤를 돌아봄', '명사', 97, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生を回顧する。', '인생을 회고한다.', 1),
    (w, '退職を机に身を回顧する。', '퇴직을 계기로 자신을 회고한다.', 2);

  -- 98. 偽り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '偽り', 'いつわり', '거짓, 허구', '偽(거짓 위): 亻(사람) + 為(할 위) → 사람이 꾸면서 행동
명사형 ''いつわり''는 진실이 아닌 것', '명사', 98, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この記述に偽りはない。', '이 기술에는 거짓이 없다.', 1),
    (w, '偽りのいん証言だとわかった。', '거짓 증언이라고 밝혀졌다.', 2);

  -- 99. 嫌悪感
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '嫌悪感', 'けんおかん', '혐오감', '嫌(싫을 혐): 女(여자) + 兼(겸할 겸) → 여자가 알차게 행동 → 싫어함
悪感(オカン): 悪(악할 오) + 感(느낌 감) → 싫어하는 감정', '명사', 99, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その人に嫌悪感を抱く。', '그 사람에게 혐오감을 품는다.', 1),
    (w, '不正に対する嫌悪感が高まる。', '부정에 대한 혐오감이 높아진다.', 2);

  -- 100. 自粛
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '自粛', 'じしゅく', '자숙', '自(스스로 자): 코의 모양 → 자신
粛(엄숙할 숙): 肀(파고들 연) + 二(두 이) → 스스로 엄격하게 함', '명사', 100, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '業界全体が自粛を求められている。', '업계 전체가 자숙을 요구받고 있다.', 1),
    (w, '外出を自粛して家で過ごす。', '외출을 자숙하고 집에서 지낸다.', 2);

  -- 101. 戒める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '戒める', 'いましめる', '(1) 훈계하다 (2) 금지하다', '戒(경계할 계): 戊(삼세판 무) + 拱(두 손으로 받들 공) → 무기를 갈고 경계
타동사 형태로 다른 사람에게 주의·경고함', '동사', 101, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不注意な言動を戒める。', '부주의한 언동을 훈계한다.', 1),
    (w, '子どもに火遪びを戒める。', '아이에게 불장난을 금지한다.', 2);

  -- 102. 丘陵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '丘陵', 'きゅうりょう', '구릉', '丘(언덕 구): 北(북녕 북) + 一(한 일) → 높은 곳
陵(큰언덕 릉): 阜(언덕) + ⋧夕(넓을 릉) → 큰 언덕', '명사', 102, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丘陵地帯に住宅が広がる。', '구릉지대에 주택이 퍼진다.', 1),
    (w, '顔と丘陵を嫌う。', '되언덕·구릉을 꾸려한다.', 2);

  -- 103. 豪快に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '豪快に', 'ごうかいに', '호셔하게', '豪(호각 호): 高(높을 고) + 豕(돼지 시) → 높은 고기·희귀
快(쉬울 쿌): 忄(마음) + 夬(터놈을 쿌) → 마음이 틁 틀임', '부사', 103, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は豪快に笑う。', '그는 호쿨하게 웃는다.', 1),
    (w, '豪快な性格で人気者だ。', '호쿨한 성격으로 인기인이다.', 2);

  -- 104. 忍耐
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '忍耐', 'にんたい', '인내', '忍(참을 인): 刃(칼날 인) + 心(마음) → 칼날이 심장에 닿아도 참음
耐(견딜 내): 而(말이을 이) + 寸(마디) → 입을 닫고 참음', '명사', 104, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の忍耐が実を結んだ。', '오랜 인내가 결실을 맺었다.', 1),
    (w, '忍耐強さが試される。', '인내심이 시험당한다.', 2);

  -- 105. 募る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '募る', 'つのる', '(1) 모집하다 (2) (정도가) 심해지다', '募(모을 모): 莫(없을 막) + 力(힘) → 없던 힘을 모음
자동사로 감정·설움 등이 더욱 강해짐을 의미', '동사', 105, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会員を募る。', '회원을 모집한다.', 1),
    (w, '不満が募り、ついに爆発した。', '불만이 심해져 마침내 폭발했다.', 2);

  -- 106. 膨大
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '膨大', 'ぼうだい', '방대함', '膨(명명할 팡): 肉(고기) + 鼓(북 고) → 살이 뙱북이 등등 차오름
大(클 대): 사람이 두 팔을 펼친 모양', 'な형용사', 106, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '膨大なデータを処理する。', '방대한 데이터를 처리한다.', 1),
    (w, '宇宙は膨大な空間だ。', '우주는 방대한 공간이다.', 2);

  -- 107. 滞る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '滞る', 'とどこおる', '밀리다, 정체되다', '滞(막힐 체): 氵(물) + 帶(띄 대) → 물이 띄에 걸려 흐르지 않음
자동사로 일·단계를 제대로 처리하지 못함', '동사', 107, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が滞っている。', '일이 정체되고 있다.', 1),
    (w, '家賃の払いが滞った。', '집세 납부가 밀렸다.', 2);

  -- 108. 驚嘆する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '驚嘆する', 'きょうたんする', '경탄하다, 놀라다', '驚(놀랄 경): 敬(공경 경) + 馬(말 마) → 말이 공경하듯 퍽 뛐
嘆(탄식할 탄): 口(입) + 兙(어려울 난) → 입으로 소리를 내며 탄식함', '동사', 108, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その記録に驚嘆した。', '그 기록에 경탄했다.', 1),
    (w, '作品の細部に驚嘆させられる。', '작품의 세부에 경탄하게 된다.', 2);

  -- 109. 猛烈に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '猛烈に', 'もうれつに', '맹렬히', '猛(사나울 맹): 犭(개) + 孟(맏이 맹) → 개가 처음 그러듯 사나움
烈(매울 렬): 列(벌일 렬) + 火(불) → 세차게 타오르는 불', '부사', 109, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '猛烈にトレーニングした。', '맹렬히 트레이닝했다.', 1),
    (w, '猛烈な勢いで雨が降る。', '맹렬한 기세로 비가 내린다.', 2);

  -- 110. 克服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '克服', 'こくふく', '극복', '克(이길 극): ジ(입) + 儿(사람) → 힘들게 이겨냄
服(옷 복): 月(목이 다르지·멉이 명) + 友(멈추 복) → 모시고 따르게 함', '명사', 110, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい課題を克服した。', '어려운 과제를 극복했다.', 1),
    (w, '慎部を克服して試合に勝った。', '약점을 극복해서 경기에 이겨다.', 2);

  -- 111. 崩れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '崩れる', 'くずれる', '무너지다, 흐트러지다', '崩(무너질 붕): 山(산) + 朋(볗 붕) → 산이 한꺼번에 무너짐
자동사 형태로 형태·질서가 무너짐을 강조', '동사', 111, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '压力に耐えきれず塔が崩れた。', '압력을 견디지 못하고 탑이 무너졌다.', 1),
    (w, '他人の一言で姿勢が崩れた。', '타인의 한 마디로 자세가 흐트러졌다.', 2);

  -- 112. 繁殖
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '繁殖', 'はんしょく', '번식', '繁(번성할 번): 糸(실) + 敏(민첩할 민) → 실이 무성하게 자람
殖(번식할 식): 歹(앤긴 병) + 直(곧을 직) → 병이 곧곳 설아 퍼짐', '명사', 112, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この魚は温水で繁殖する。', '이 물고기는 따뜻한 물에서 번식한다.', 1),
    (w, '雑菌の繁殖を防ぐ。', '잡균의 번식을 막는다.', 2);

  -- 113. 履歴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '履歴', 'りれき', '이력', '履(밟을·신 리): 尸(죽을 시) + 復(되돌아갈 복) → 보행·신
歴(지낼 력): 厤(굴바위 언) + 止(멈춤) → 지난 자취', '명사', 113, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '履歴書を提出した。', '이력서를 제출했다.', 1),
    (w, '彼の履歴は豊富だ。', '그의 이력은 풍부하다.', 2);

  -- 114. 映える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '映える', 'はえる', '(1) 아름답게 빛나다 (2) 잘 어울리다', '映(비칠 영): 日(해) + 央(가운데 앙) → 행빛이 끌어 밝게 빛남
자동사로 색·해의 대비에 더 아름답게 보임', '동사', 114, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スタジアムに映えるユニホーム。', '경기장에 잘 어울리는 유니폼.', 1),
    (w, '夕日に映える銘だ。', '석양에 빛나는 쓰다마그다.', 2);

  -- 115. 披露
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '披露', 'ひろう', '피로, 공개', '披(헤칠 피): 手(손) + 皮(가죽) → 손으로 겹겹이 헤컬
露(이슬 로): 雨(비) + 路(길 로) → 빗장에 드러남', '명사', 115, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新作を披露した。', '신작을 공개했다.', 1),
    (w, '手才を披露するステージだ。', '재주를 피로하는 무대다.', 2);

  -- 116. 砕ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '砕ける', 'くだける', '부서지다, 껏이다', '砕(부술 쇄): 石(돌) + 卒(마칠 졸) → 돌이 끊임없이 잘게 부수어짐
자동사로 형태·기세 등이 껏임을 나타냄', '동사', 116, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '波が岩に砕ける。', '파도가 바위에 부서진다.', 1),
    (w, '反論されて勢いが砕けた。', '반론당해서 기세가 껏였다.', 2);

  -- 117. 執着する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '執着する', 'しゅうちゃくする', '집착하다', '執(잡을 집): 幸(다행·수갑 행) + 丸(잡을 입) → 수갑을 채우고 잡음
着(붙을 착): 羊(양) + 看(볼 간) → 가까이 붙어서 떨어지지 않음', '동사', 117, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金銅に執着すると見えなくなる。', '돈에 집착하면 안 보이게 된다.', 1),
    (w, '過去に執着してはいけない。', '과거에 집착해서는 안 된다.', 2);

  -- 118. 債務
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '債務', 'さいむ', '채무', '債(빚 채): 亻(사람) + 責(책망할 책) → 사람이 갚아야 할 의무
務(힘쓸 무): 矛(창) + 勵(그칠 광) → 창을 들고 일에 힘쁬', '명사', 118, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の債務が增えた。', '회사의 채무가 늘었다.', 1),
    (w, '債務を返済する。', '채무를 상환한다.', 2);

  -- 119. 貢献
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '貢献', 'こうけん', '공헌', '貢(바칠 공): 工(장인) + 貝(조개) → 재물을 바침
献(드릴 헌): 犬(개) + 鬲(솔·소릹 헌) → 제사에 귀하게 드림', '명사', 119, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に貢献する人を目指す。', '사회에 공헌하는 사람을 목표로 한다.', 1),
    (w, '彼の研究は医学に大きく貢献した。', '그의 연구는 의학에 크게 공헌했다.', 2);

  -- 120. 潔い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '潔い', 'いさぎよい', '(미련 없이) 깨끗하다', '潔(깨끗할 결): 氵(물) + 絜(깨끗할 결) → 물로 슻은 듯 맑음
''いさぎよい''는 주저·미련이 없는 태도를 표현', 'い형용사', 120, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '潔い言いずりだと評価された。', '깨끗한 태도라고 평가되었다.', 1),
    (w, '負けを潔く認める。', '패배를 깨끗히 인정한다.', 2);

  -- 121. 干渉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '干渉', 'かんしょう', '간섭', '干(방패 간): 면병기 모양·방패 → 아무래 밤이 들어가
渉(건널 섭): 氵(물) + 步(걸음 보) → 물을 건너 감', '명사', 121, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '中央政府は地方への干渉を控える。', '중앙정부는 지방에대한 간섭을 자제한다.', 1),
    (w, '他人の私生活に干渉してはいけない。', '타인의 사생활에 간섭해서는 안 된다.', 2);

  -- 122. 粘る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '粘る', 'ねばる', '끌기 있게 버티다', '粘(찰기할 점): 米(쌌) + 占(차지할 점) → 쌌이 찰수롭게 자리 잡음
자동사형으로 죽기 살기로 달라붙어 끝까지 함', '동사', 122, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '最後まで粘る。', '끝까지 끌기 있게 버한다.', 1),
    (w, '交渉に粘り勝ち取る。', '협상에 끌기 있게 매달려 얻어낸다.', 2);

  -- 123. 促す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '促す', 'うながす', '재촉하다, 촉구하다', '促(재촉할 촉): 亻(사람) + 足(발) → 사람을 발로 쪻아 최섬임
타동사로 상대의 행동을 촉구함', '동사', 123, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決斷を促す。', '결단을 촉구한다.', 1),
    (w, '跟見予して訪問を促された。', '눈으로 신호를 보내 방문을 재촉받았다.', 2);

  -- 124. 措置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '措置', 'そち', '조치', '措(둘 조): 手(손) + 昔(옆근서) → 손으로 제자리에 돘
置(둘 치): 网(그물 망) + 直(곧을 직) → 그물을 바로 넓음', '명사', 124, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '適切な措置をとる。', '적절한 조치를 취한다.', 1),
    (w, '緊急措置が必要だ。', '긴급 조치가 필요하다.', 2);

  -- 125. 振興
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '振興', 'しんこう', '진흥', '振(떨칠 진): 手(손) + 辰(별 진) → 손으로 흔들어 깨움
興(일 흥): 同(함께 동) + 與(더붙을 여) → 함께 일어남', '명사', 125, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '産業の振興を図る。', '산업의 진흥을 도모한다.', 1),
    (w, '計画と振興をを推進している。', '계획과 진흥을 추진하고 있다.', 2);

  -- 126. 遺憾に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '遺憾に', 'いかんに', '유감스럽게', '遺(남길 유): 辶(갈 착) + 貴(귀할 귀) → 귀한 것을 남서 잃음
憾(섭섭할 감): 忄(마음) + 憾(양소립고 머물거릴 함) → 마음에 수점하는 아쉬운', '부사', 126, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遺憾ながら、参加できません。', '유감스럽게도 참가할 수 없습니다.', 1),
    (w, 'プロジェクトは遺憾な結果に終わった。', '프로젝트는 유감스러운 결과로 끝났다.', 2);

  -- 127. 閉鎖
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '閉鎖', 'へいさ', '폐쇄', '閉(닫을 폐): 門(문) + 才(재주 재) → 문을 닫아 건
鎖(쇠사슬 쇄): 金(쇠) + 小(작을 소) + 貝(조개) → 쇠로 만든 잠금장치', '명사', 127, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コロナで学校が閉鎖された。', '코로나로 학교가 폐쇄되었다.', 1),
    (w, '関係者以外閉鎖となる。', '관계자 이외에는 폐쇄된다.', 2);

  -- 128. 心遺い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '心遺い', 'こころづかい', '배려', '心(마음 심): 심장의 모양 → 마음
遺(보낼 견): 辶(갈 착) + 貴(귀할 귀) → 말을 보냄 → 신경 쓰기', '명사', 128, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の心遺いに感謝した。', '그의 배려에 감사했다.', 1),
    (w, '動さんに心遺いを示す。', '환자에게 배려를 보인다.', 2);

  -- 129. 憤る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '憤る', 'いきどおる', '분노하다, 분개하다', '憤(텔 분): 心(마음) + 賁(클 분) → 마음이 크게 일레다
동사형으로 강한 분노·분개의 감정을 대로 표출', '동사', 129, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不公平な評価に憤る。', '불공평한 평가에 분노한다.', 1),
    (w, '誠意のない謝罪にとても憤った。', '성의 없는 사과에 아주 분절했다.', 2);

  -- 130. 治癒
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '治癒', 'ちゆ', '치유', '治(다스릴 치): 氵(물) + 台(별 태) → 물길을 관리
癒(나을 유): ク(병들 녕) + 噐(올라올 유) → 병이 나아 올라감', '명사', 130, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '音楽で心を治癒する。', '음악으로 마음을 치유한다.', 1),
    (w, 'ペットは治癒効果がある。', '애완동물은 치유 효과가 있다.', 2);

  -- 131. 錯覚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '錯覚', 'さっかく', '착각', '錯(섮일 착): 金(쇠) + 昔(옆근서) → 쇠가 섞임
覚(깨달을 각): 學(배울 학) + 見(볼 견) → 배우고 봅', '명사', 131, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '視覚による錯覚だった。', '시각에 의한 착각이었다.', 1),
    (w, '完璧に記憶したと思ったのは錯覚だった。', '완벽하게 기억했다고 생각한 것은 착각이었다.', 2);

  -- 132. 尊い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '尊い', 'とうとい', '소중하다, 존귀하다', '尊(높을 존): 酉(술단지 유) + 寸(마디) → 높은 재단에 숨 높은 존재
''とうとい''는 높이 받들 만한 가치 있음을 표현', 'い형용사', 132, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '尊い人生を送る。', '존귀한 인생을 보낸다.', 1),
    (w, '尊い犠牲の上に今がある。', '소중한 희생 위에 오늘이 있다.', 2);

  -- 133. 枯渇
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '枯渇', 'こかつ', '고갈', '枯(마를 고): 木(나무) + 古(옥 고) → 나무가 오래되어 말라 죽음
渇(목마를 갈): 氵(물) + 曷(어조사 갈) → 물이 떨어져서 갈증 난 상태', '명사', 133, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資源の枯渇が心配される。', '자원의 고갈이 우려된다.', 1),
    (w, 'アイデアが枯渇した。', '아이디어가 고갈되었다.', 2);

  -- 134. 慰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '慰める', 'なぐさめる', '위로하다, 달래다', '慰(위로할 위): 尉(별 위) + 心(마음) → 마음을 편안하게 함
타동사로 슬픔·고통을 덜어주는 행위', '동사', 134, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人を慰めた。', '친구를 위로했다.', 1),
    (w, '心を慰める音楽を聞く。', '마음을 달래는 음악을 듣는다.', 2);

  -- 135. 緊迫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '緊迫', 'きんぱく', '긴박', '緊(긴할 긴): 臣(신하) + 又(또 우) + 糸(실) → 실을 단단히 종임
迫(핍박할 박): 辶(갈 착) + 白(흰 백) → 조일령 해서 말림', '명사', 135, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両国の関係が緊迫している。', '양국의 관계가 긴박하고 있다.', 1),
    (w, '緊迫した事態に冷静に対応する。', '긴박한 사태에 냉정하게 대응한다.', 2);

  -- 136. 勇敢に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '勇敢に', 'ゆうかんに', '용감하게', '勇(날래론 용): 甬(용솤날 용) + 力(힘) → 힘이 솨아나올
敢(감히 감): 受(받을 수) + 攵(칠 복) → 과감히 행동', '부사', 136, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勇敢に戦う姿勢に感動した。', '용감하게 싸우는 자세에 감동했다.', 1),
    (w, '彼は勇敢に事件に立ち向かった。', '그는 용감하게 사건에 맞서 싸웠다.', 2);

  -- 137. 忠告
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '忠告', 'ちゅうこく', '충고', '忠(충성 충): 中(가운데 중) + 心(마음) → 마음이 겹친·처지우치치 않은
告(고할 고): 牛(소) + 口(입) → 소를 회사로 알림', '명사', 137, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生の忠告を受け入れた。', '선생님의 충고를 받아들였다.', 1),
    (w, '友人に忠告してもらう。', '친구에게서 충고를 받는다.', 2);

  -- 138. 慕う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '慕う', 'したう', '(1) 그리워하다 (2) 따르다, 우러르다', '慕(그리워할 모): 莫(없을 막) + 心(마음) → 없는 것을 마음으로 그리워함
타동사 형태로 마음으로 우러르고 따름을 나타냄', '동사', 138, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '亡き母を慕う。', '돌아가신 어머니를 그리워한다.', 1),
    (w, '誫仮の人柄に多くの人が慕う。', '어질어진 인격에 많은 사람이 따른다.', 2);

  -- 139. 施錠する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '施錠する', 'せじょうする', '자물쇠를 채우다, 잠그다', '施(베풀 시): 方(모 방) + 也(이끌 야) → 깃발을 흔들며 다른 사람에게 행함
錠(자물쇄 정): 金(쇠) + 長(길 장) → 쇠로 된 긴 것 → 자물쇄', '동사', 139, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜は必ず施錠してください。', '밤에는 반드시 자물쇄를 채우세요.', 1),
    (w, '現関を施錠してる。', '현관을 잠그고 있다.', 2);

  -- 140. 沈下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '沈下', 'ちんか', '침하', '沈(잠길 침): 氵(물) + 柕(다하고·심을 점) → 물속에 잠김
下(아래 하): 아래를 가리키는 지사', '명사', 140, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地盤の沈下が起きた。', '지반의 침하가 일어났다.', 1),
    (w, '建物の沈下を調査する。', '건물의 침하를 조사한다.', 2);

  -- 141. 監督
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '監督', 'かんとく', '감독', '監(볼 감): 臣(신하) + 皿(그릇) → 그맭의 물을 둘러볼
督(감독할 독): 叔(아저씨 숙) + 目(눈) → 눈으로 잘펴봄', '명사', 141, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '有名な監督の映画を見た。', '유명한 감독의 영화를 보았다.', 1),
    (w, '工事の監督を担当する。', '공사의 감독을 담당한다.', 2);

  -- 142. 派生
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '派生', 'はせい', '파생', '派(갈래 파): 氵(물) + ➝(물갈래 파) → 물이 갈래짐
生(날 생): 땅에서 새싹이 돋아날', '명사', 142, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この言葉はブラジル語から派生した。', '이 단어는 포르투갈어에서 파생되었다.', 1),
    (w, '事件に佴う派生的な問題が生じた。', '사건에 따른 파생적인 문제가 생겨났다.', 2);

  -- 143. 透ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '透ける', 'すける', '비쳐보이다, 들여다보이다', '透(사무칠 투): 辶(갈 착) + 秀(빼어날 수) → 우수한 것이 관통함
자동사로 난 쪽에서 다른 쪽이 보이는 상태', '동사', 143, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カーテンごしに中が透ける。', '커튼 너머로 안이 비쳐 보인다.', 1),
    (w, '本思が透けて見えた。', '속마음이 들여다 보였다.', 2);

  -- 144. 恩恵
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '恩恵', 'おんけい', '은혜', '恩(은혜 은): 因(인할 인) + 心(마음) → 마음으로 우래함
恵(은혜 혜): 入(들 입) + 心(마음) → 마음을 헤아림', '명사', 144, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両親の恩恵に感謝する。', '부모님의 은혜에 감사한다.', 1),
    (w, '自然の恩恵に恒しまれている。', '자연의 은혜에 그들어 있다.', 2);

  -- 145. 如実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '如実に', 'にょじつに', '여실히', '如(같을 여): 女(여자) + 口(입) → 여자의 말 → 그것과 같이
実(열매 실): 宀(집) + 貧(꾰을 관) → 집에 꾰린 돈 → 실제', '부사', 145, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現場の状況が如実に描かれている。', '현장의 상황이 여실히 그려져 있다.', 1),
    (w, '彼の面舗に遬いが如実に表れた。', '그의 얼굴에 망설임이 여실히 나타났다.', 2);

  -- 146. 騒然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '騒然', 'そうぜん', '시끄러운 상태, 떠들석한 모습', '騒(머리 소): 馬(말) + 蚤(밥이 조) → 말이 밥이에 물어 아닜다함
然(그럴 연): 犬(개) + 肉(고기) + 火(불) → 상태 보조사', 'な형용사', 146, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会場は騒然としていた。', '회장은 소란스러운 상태였다.', 1),
    (w, '事件のニュースで社会が騒然としている。', '사건 뉴스로 사회가 떠들석하다.', 2);

  -- 147. 諭す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '諭す', 'さとす', '잘 타일르다', '諭(깨우칠 유): 言(말) + 俞(대답할 유) → 유연스럭게 말함
타동사로 잘못을 고치도록 이르는 행위', '동사', 147, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもを諭すように話す。', '아이를 타이르듯이 이야기한다.', 1),
    (w, '長老は静かに諭した。', '어른이 조용히 잘 타일렁다.', 2);

  -- 148. 秩序
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '秩序', 'ちつじょ', '질서', '秩(차례 질): 禾(벼) + 失(잃을 실) → 벼를 차례대로 넓어둡
序(차례 서): 广(집) + 予(미리 예) → 집의 차례·순서', '명사', 148, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会の秩序を保つ。', '사회의 질서를 유지한다.', 1),
    (w, '交通の秩序が乱れる。', '교통의 질서가 흐트러진다.', 2);

  -- 149. 潜伏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '潜伏', 'せんぷく', '잠복', '潜(잠길 잠): 氵(물) + 曎(바꿀 체) → 물속에 숨음
伏(엎드릴 복): 亻(사람) + 犬(개) → 개가 잔싫어 엎드림', '명사', 149, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ウイルスの潜伏期間は1週間だ。', '바이러스의 잠복기간은 1주일이다.', 1),
    (w, 'スパイが長い間潜伏していた。', '스파이가 오랜 시간 잠복하고 있었다.', 2);

  -- 150. 朗らかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '朗らかな', 'ほがらかな', '명랑한', '朗(밝을 랑): 良(좋을 랭) + 月(달) → 달이 환하게 빛남
''ほがらか''는 웃음이 끊임없이 터져 나오는 모습', 'な형용사', 150, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女は朗らかな性格だ。', '그녀는 명랑한 성격이다.', 1),
    (w, '朗らかな笑い声が聞こえる。', '명랑한 웃음소리가 들린다.', 2);

  -- 151. 軌跡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軌跡', 'きせき', '굤적', '軌(바퀴자국 굤): 車(수레 거) + 九(아홉 구) → 수레 바퀴·굤도
跡(발자취 적): 足(발) + 亦(또 역) → 다니면서 남긴 흔적', '명사', 151, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生の軌跡を振り返る。', '인생의 굤적을 돌아본다.', 1),
    (w, '魔水の軌跡を追う。', '혜성의 굤적을 쫓는다.', 2);

  -- 152. 偏り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '偏り', 'かたより', '치우침, 편향', '偏(치우칠 편): 亻(사람) + 扁(낮을 편) → 한쪽으로 기움
명사형 ''かたより''는 균형이 깨진 상태', '명사', 152, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見の偏りを避ける。', '의견의 치우침을 피한다.', 1),
    (w, '食事の偏りを見直した。', '식사의 치우침을 다시 볼 필요가 있다.', 2);

  -- 153. 矛盾
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '矛盾', 'む个じゅん', '모순', '矛(창 모): 긴 자루의 창 모양
盾(방패 순): 적을 막는 방패·방어구 → 모·순의 논리평 모순되운 고사', '명사', 153, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の主張には矛盾がある。', '그의 주장에는 모순이 있다.', 1),
    (w, '証言の矛盾を指摘された。', '증언의 모순을 지적받았다.', 2);

  -- 154. 誇張
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '誇張', 'こちょう', '과장', '誇(자랑할 과): 言(말) + 佳(자랑할 과) → 말로 자랑함
張(베풀 장): 弓(활) + 長(길 장) → 활시위를 펼쳐 크게 함', '명사', 154, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誇張して話すおざりがある。', '과장해서 말하는 버릇이 있다.', 1),
    (w, '広告の誇張表現が問題になった。', '광고의 과장 표현이 문제가 되었다.', 2);

  -- 155. 賄う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '賄う', 'まかなう', '(1) 식사를 제공하다 (2) 조달하다', '賄(뀶물 회): 貝(조개) + 有(있을 유) → 재물을 내못하게 쓰
동사형으로 식사·자금을 충당하고 조달함', '동사', 155, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寮で三食を賄う。', '기숨사에서 세끼 식사를 제공한다.', 1),
    (w, '会議の費用は参加費で賄う。', '회의 비용은 참가비로 조달한다.', 2);

  -- 156. 軽率
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軽率', 'けいそつ', '경솔함', '軽(가벼울 경): 車(수레) + 巬(쾰다 경) → 수레가 빨라 가벼운 게임
率(거느릴 률): 玄(검을 현) + 十(열 십) → 그물으로 소를 이뀸', 'な형용사', 156, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽率な言動を慎む。', '경솔한 언동을 삼간다.', 1),
    (w, '彼は軽率な判断で失敗した。', '그는 경솔한 판단으로 실패했다.', 2);

  -- 157. 腐敗
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '腐敗', 'ふはい', '부패', '腐(썰을 부): 府(마을 부) + 肉(고기) → 고기가 썰음
敗(패할 패): 貝(조개) + 攵(칠 복) → 조개를 치서 부수어뜨림', '명사', 157, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '政治の腐敗を防ぐ必要がある。', '정치의 부패를 막아야 한다.', 1),
    (w, '所長は腐敗防止を訴えた。', '소장은 부패방지를 호소했다.', 2);

  -- 158. 粗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '粗い', 'あらい', '거칠다', '粗(거칠 조): 米(쌌) + 且(또 차) → 잘지 못한 거친 쌌
''あらい''는 표면·성질이 투박하고 세밀하지 못함', 'い형용사', 158, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '粗いストで背中を洗う。', '거친 수건으로 등을 씨는다.', 1),
    (w, '言葉遣いが粗くて不快だ。', '말투가 거칠어서 불쿨하다.', 2);

  -- 159. 粘膜
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '粘膜', 'ねんまく', '점막', '粘(붙을 점): 米(쌌) + 占(차지할 점) → 쌌이 찰수롭게 끌
膜(껍질 막): 肉(고기 육) + 莫(없을 막) → 고기의 얇은 껍질', '명사', 159, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鼻の粘膜が腕んでいる。', '코의 점막이 부어있다.', 1),
    (w, '口腕は口の粘膜の炎症だ。', '구내염은 입의 점막 염증이다.', 2);

  -- 160. 寿命
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '寿命', 'じゅみょう', '수명', '寿(목숨 수): 士(선비 사) + 寸(마디) → 사람이 살아온 길이
命(목숨 명): 口(입) + 令(하여금 령) → 하늘이 명한 목숨', '명사', 160, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平均寿命が伸びている。', '평균 수명이 늘고 있다.', 1),
    (w, '製品の寿命は五年だ。', '제품의 수명은 5년이다.', 2);

  -- 161. 誓約書
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '誓約書', 'せいやくしょ', '서약서', '誓(맹세할 서): 拘(꿩을 절) + 言(말) → 꿩는 것을 말로 약속
約書: 約(맺을 약) + 書(글 서) → 약속을 적은 글', '명사', 161, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誓約書にサインした。', '서약서에 서명했다.', 1),
    (w, '仕事上、誓約書を提出させられた。', '업무상 서약서를 제출하게 되었다.', 2);

  -- 162. 絶叫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '絶叫', 'ぜっきょう', '절규', '絶(끊을 절): 糸(실) + 色(색) + 刂(칼) → 칼로 실을 자름
叫(부르지을 규): 口(입) + 厫(뛰어오르고 규) → 입으로 팍 소리침', '명사', 162, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '恐怖のあまり絶叫した。', '공포에 너무 놀라 절규했다.', 1),
    (w, 'スタジアムでサポーターの絶叫が黄いた。', '경기장에서 서포터의 절규가 울렸다.', 2);

  -- 163. 背後
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '背後', 'はいご', '배후', '背(등 배): 北(북녕·이하적) + 肉(고기) → 사람의 등
後(뒤 후): 忄(조금걸을 척) + 麼(서로 자계) → 뒤처짐', '명사', 163, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の背後関係を調査する。', '사건의 배후관계를 조사한다.', 1),
    (w, 'その主張の背後には何かある。', '그 주장의 배후에는 뭐가 있다.', 2);

  -- 164. 抱負
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '抱負', 'ほうふ', '포부', '抱(안을 포): 手(손) + 包(올 포) → 팔로 감쎄 안음
負(질 부): 亻(사람) + 貝(조개) → 사람이 재물을 짐', '명사', 164, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来の抱負を語る。', '장래의 포부를 말한다.', 1),
    (w, '抱負を胸に業を始めた。', '포부를 가슴에 품고 사업을 시작했다.', 2);

  -- 165. 䫥る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '䫥る', 'あなどる', '무시하다', '䫥(업신여길 모): 亻(사람) + 母(어머니 모) → 그의하며 업신여김
타동사형으로 상대를 없이보고 회하게 대함', '동사', 165, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '相手を䫥った够ば、負けた。', '상대를 무시한 엄극, 지고 말았다.', 1),
    (w, '小さな閃眎を䫥ってはいけない。', '작은 미세함을 무시해서는 안 된다.', 2);

  -- 166. 筋道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '筋道', 'すじみち', '조리, 사리', '筋(힘줄 근): 竹(대나무) + 肋(고기 육) + 力(힘) → 근육·장기·논리의 줄
道(길 도): 辶(갈 착) + 首(머리) → 머리를 사용해 나아갈 길', '명사', 166, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の筋道を逆う。', '이야기의 조리가 맞지 않는다.', 1),
    (w, '筋道を立てて説明した。', '조리있게 설명했다.', 2);

  -- 167. 奔放な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '奔放な', 'ほんぽうな', '분방한', '奔(달릴 분): 大(클 대) + 卉(섭 꿼) → 큰 발걸음으로 달림
放(놓을 방): 方(모·방향) + 攵(칠 복) → 한앫 날려버림 → 자유분방', 'な형용사', 167, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '奔放な生き方をしていた。', '분방한 삶을 살고 있었다.', 1),
    (w, '奔放な言動が話題になる。', '분방한 언동이 화제가 된다.', 2);

  -- 168. 円滑な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '円滑な', 'えんかつな', '원활한', '円(둥귀·엔 엔): 㨵(울타리 경) + 圈(테두리 권) → 둥귄 테두리
滑(미끄러울 활): 氵(물) + 骨(보 골) → 물처럼 었쪽이 잘 흐름', 'な형용사', 168, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は円滑に進んだ。', '회의는 원활하게 진행되었다.', 1),
    (w, '心も閃も円滑に話し合う。', '원활하게 대화를 나눌다.', 2);

  -- 169. 及ぼす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '及ぼす', 'およぼす', '(영향을) 미치다, 끼치다', '及(미칠 급): 亻(사람) + 又(또 우) → 손이 사람에게 닿음
타동사로 영향·파급 효과를 이르게 함', '동사', 169, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仮説は世界に影響を及ぼした。', '이 설은 세계에 영향을 끼쳤다.', 1),
    (w, '干ばつが農業に被害を及ぼす。', '가물이 농업에 피해를 끼친다.', 2);

  -- 170. 完結
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '完結', 'かんけつ', '완결', '完(완전할 완): 宀(집) + 元(으뜹 원) → 집이 완전하게 가춘
結(맺을 결): 糸(실) + 吉(길할 길) → 실을 잘 맺음', '명사', 170, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長編小説が完結した。', '장편소설이 완결되었다.', 1),
    (w, 'このドラマは全五話で完結だ。', '이 드라마는 전 5화로 완결이다.', 2);

  -- 171. キャリア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'キャリア', 'きゃりあ', '커리어, 경력', NULL, '명사', 171, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'キャリアアップを目指す。', '경력 향상을 목표로 한다.', 1),
    (w, '長いキャリアを持つ記者だ。', '긴 경력을 가진 기자다.', 2);

  -- 172. 結束
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '結束', 'けっそく', '결속', '結(맺을 결): 糸(실) + 吉(길할 길) → 실을 잘 맺음
束(묶을 속): 木(나무) + 口(입) → 나무를 한데 모아 묶음', '명사', 172, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームの結束を高める。', '팀의 결속을 다진다.', 1),
    (w, '職員間の結束を促進する。', '직원간의 결속을 촉진한다.', 2);

  -- 173. 念願
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '念願', 'ねんがん', '염원', '念(생각할 녕): 今(이제 금) + 心(마음) → 지금 마음에 두고 있음
願(원할 원): 頁(머리) + 原(근원 원) → 머릿속 근본으로 바람', '명사', 173, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の念願だった家を建てた。', '오랜 염원이었던 집을 지었다.', 1),
    (w, '念願が叶って学者になった。', '염원이 이루어져 학자가 되었다.', 2);

  -- 174. 背景
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '背景', 'はいけい', '배경', '背(등 배): 北(북녕 북) + 肉(고기) → 사람의 등·뒤쪽
景(별 경): 日(해) + 京(서울 경) → 해리 끌리는 풍경', '명사', 174, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その事件には複雑な背景がある。', '그 사건에는 복잡한 배경이 있다.', 1),
    (w, '写真の背景は火山だ。', '사진의 배경은 화산이다.', 2);

  -- 175. フォローする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'フォローする', 'ふぉろーする', '보조하다, 지원하다', NULL, '동사', 175, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部下をしっかりフォローする。', '부하를 철저히 지원한다.', 1),
    (w, '新人の仕事をフォローする。', '신입의 업무를 보조한다.', 2);

  -- 176. 報じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '報じる', 'ほうじる', '알리다, 보도하다', '報(갚을 보): 幸(다행 행) + ⋣巳(복종할 복) → 좋은 소식을 알림
동사화 ''じる''이 붙어 ''알리다''의 뜻으로 사용', '동사', 176, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ニュースで事件を報じている。', '뉴스에서 사건을 보도하고 있다.', 1),
    (w, '友人が合格を電話で報じてくれた。', '친구가 합격을 전화로 알려주었다.', 2);

  -- 177. 本音
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '本音', 'ほんね', '본심, 속내', '本(근본 본): 木(나무) 아래에 표시 → 릌리·근본
音(소리 음): 言(말)에서 파생·말소리', '명사', 177, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本音を言うとトラブルになる。', '속말을 하면 트러블이 된다.', 1),
    (w, '街いばんだ本音を明かした。', '드디어 속마음을 밝혔다.', 2);

  -- 178. 綿密な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '綿密な', 'めんみつな', '면밀한', '綿(손견 면): 糸(실) + 帛(비단 백) → 세세한 실
密(비밀 밀): 宀(집) + 必(반드시 필) → 집안에 꿉 들어차서 틈이 없음', 'な형용사', 178, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '綿密な計画を立てた。', '면밀한 계획을 세웠다.', 1),
    (w, '綿密な調査が必要だ。', '면밀한 조사가 필요하다.', 2);

  -- 179. やんわり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'やんわり', '부드럽게, 살며시', NULL, '부사', 179, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やんわりと断った。', '부드럽게 거절했다.', 1),
    (w, 'やんわりと意見を伝える。', '부드럽게 의견을 전한다.', 2);

  -- 180. 逸材
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '逸材', 'いつざい', '일재, 뛰어난 인재', '逸(달아날 일): 辶(갈 착) + 兔(토끼 토) → 토끼처럼 빨르게 달아남
材(재목 재): 木(나무) + 才(재주 재) → 재능 있는 나무·용재', '명사', 180, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は逸材として評価されている。', '그는 뛰어난 인재로 평가받고 있다.', 1),
    (w, '逸材を適した社員を採用した。', '뛰어난 사원을 채용했다.', 2);

  -- 181. 会心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '会心', 'かいしん', '회심, 만족스러운 결과', '会(모일 회): 이쟈을 차고 린곳에 모임 → 함께
心(마음 심): 심장 모양 → 마음·뜻', '명사', 181, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会心の作品が仏さをようやく完成した。', '만족스러운 작품이 드디어 완성되었다.', 1),
    (w, '会心の笑みを浮かべた。', '회심의 미소를 뗠올렸다.', 2);

  -- 182. 実情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '実情', 'じつじょう', '실정, 실제 사정', '実(열매 실): 宀(집) + 貨(꾰을 관) → 집에 재물이 실제로 있음
情(뜻 정): 忄(마음) + 青(푸르르) → 마음 속 고은 뜻', '명사', 182, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実情に合わせて説明した。', '실정에 맞춰서 설명했다.', 1),
    (w, '現場の実情を知る必要がある。', '현장의 실정을 알 필요가 있다.', 2);

  -- 183. 修復
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '修復', 'しゅうふく', '수복, 복원', '修(닦을 수): 亻(사람) + 長(길 장) + 彡(터런 삼) → 사람이 꾸임
復(되돌아갈 복): 復(되돌아갈 복)에서 원래 상태로 돌아감', '명사', 183, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い画の修復作業が進んでいる。', '오래된 그림의 복원 작업이 진행되고 있다.', 1),
    (w, '関係の修復に努める。', '관계 수복에 노력한다.', 2);

  -- 184. ストック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ストック', 'すとっく', '스톡, 재고', NULL, '명사', 184, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '在庫ストックを確認する。', '재고 스톡을 확인한다.', 1),
    (w, 'ストックが不足している。', '재고가 부족하다.', 2);

  -- 185. 強み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '強み', 'つよみ', '강점', '強(강할 강): 弓(활) + 口(입) + 虫(벌레 충) → 활이 강하고 튼튼함
명사형 ''つよみ''는 다른 이보다 뛰어난 점', '명사', 185, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分の強みを生かす。', '자신의 강점을 살린다.', 1),
    (w, 'チームの強みはディフェンスだ。', '팀의 강점은 수비다.', 2);

  -- 186. ニュアンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ニュアンス', 'にゅあんす', '뉘앙스', NULL, '명사', 186, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言葉のニュアンスを伝えるのは難しい。', '언어의 뉘앙스를 전달하는 것은 어렵다.', 1),
    (w, '他人の作品とニュアンスが違う。', '다른 사람의 작품과 뉘앙스가 다르다.', 2);

  -- 187. 弾む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '弾む', 'はずむ', '튀기다, 들뜨다', '弾(탄알 탄): 弓(활) + 單(홀로 단) → 활을 쓐서 탄알을 튀김
자동사형으로 고·명·마음이 튀어오르는 활기차', '동사', 187, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボールがよく弾む。', '공이 잘 튀긴다.', 1),
    (w, '話が弾んで楽しい夜だった。', '대화가 활기차서 즐거운 밤이었다.', 2);

  -- 188. 抜粋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '抜粋', 'ばっすい', '발재', '抜(뽑을 발): 手(손) + 友(볗 붕) → 손으로 뽑아냄
粋(수수 수): 米(쌌) + 卒(졸손) → 잘 고르고 고른 쌌·일품', '명사', 188, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本から重要な部分を抜粋した。', '책에서 중요한 부분을 발제했다.', 1),
    (w, 'これは原文の抜粋だ。', '이것은 원문의 발제다.', 2);

  -- 189. 不備
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不備', 'ふび', '불비, 미비, 불충분함', '不(아닌 불): 근본적 부정
備(갖출 비): 亻(사람) + 备(갖출 비) → 갖춰있음', '명사', 189, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書類の不備が見つかった。', '서류의 미비가 발견되었다.', 1),
    (w, '不備を訂正する。', '부족한 부분을 수정한다.', 2);

  -- 190. 平行
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '平行', 'へいこう', '평행', '平(평평할 평): 귀의 평평함 → 고르고 평평
行(다닐 행): 그림자길의 모양 → 갈김·진행', '명사', 190, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二つの計画を平行して進める。', '두 계획을 평행하게 진행한다.', 1),
    (w, '議論は平行線をたどった。', '논의는 평행선을 달렸다.', 2);

  -- 191. 無謀な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '無謀な', 'むぼうな', '무모한', '無(없을 무): 없음
謀(꽌 모): 言(말)+某(아무 모) → 으싫한 계책', 'な형용사', 191, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無謀な計画は危険だ。', '무모한 계획은 위험하다.', 1),
    (w, '無謀に挑戦した。', '무모하게 도전했다.', 2);

  -- 192. 言い張る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '言い張る', 'いいはる', '우겨대다, 주장하다', '言(말): 입으로 내는 소리
張(베풀 장): 활을 당겨 펼침 → 주장을 세게 퍼', '동사', 192, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分は悪くないと言い張った。', '자신은 나쁜 점이 없다고 우겨도.', 1),
    (w, '証拠があるのに言い張るな。', '증거가 있는데 우기지 마라.', 2);

  -- 193. 大筋
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '大筋', 'おおすじ', '요점, 대강', '大(클 대): 사람이 팔을 펼친 모양
筋(힘줄 근): 주요 줄기·논리', '명사', 193, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議の大筋を伝える。', '회의의 요점을 전한다.', 1),
    (w, '大筋に同意した。', '대강에 동의했다.', 2);

  -- 194. 改訂版
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '改訂版', 'かいていばん', '개정판', '改訂(고칠 개·바로잡을 정): 잘못을 고침
版(판 판): 인쇄의 판', '명사', 194, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞書の改訂版が出た。', '사전의 개정판이 나왔다.', 1),
    (w, '教科書の改訂版を買う。', '교과서의 개정판을 산다.', 2);

  -- 195. 加工する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '加工する', 'かこうする', '가공하다', '加(더할 가): 力(힘)+口(입) → 힘을 더함
工(장인 공): 도구 모양', '동사', 195, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原料を加工して製品にする。', '원료를 가공해서 제품을 만든다.', 1),
    (w, '画像を加工して使う。', '이미지를 가공해서 사용한다.', 2);

  -- 196. 急遽
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '急遽', 'きゅうきょ', '급거, 갑작스럽게', '急(급할 급): 서두름
遽(년가절 거): 辶(갈 착)+蘧 → 갑자기 감', '부사', 196, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '急遽会議を開くことになった。', '급거 회의를 열게 되었다.', 1),
    (w, '急遽予定が変わった。', '갑작스럽게 일정이 바뀌었다.', 2);

  -- 197. 究明する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '究明する', 'きゅうめいする', '규명하다', '究(연구할 구): 穴(구먍)+九 → 구먍 깊이
明(밝을 명): 日+月 → 밝혀냄', '동사', 197, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の真相を究明する。', '사건의 진상을 규명한다.', 1),
    (w, '原因を究明する。', '원인을 규명한다.', 2);

  -- 198. 寄与
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '寄与', 'きよ', '기여', '寄(부칠 기): 宀(집)+奇 → 집을 맡김
与(더붙을 여): 주고받음', '명사', 198, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に寄与する仕事がしたい。', '사회에 기여하는 일을 하고 싶다.', 1),
    (w, 'この研究は医学に大きく寄与した。', '이 연구는 의학에 크게 기여했다.', 2);

  -- 199. 妥協
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '妥協', 'だきょう', '타협', '妥(온당 타): 爪+女 → 손으로 조심스레 안정
協(화할 협): 十+力 → 여러 힘 합침', '명사', 199, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '妥協点を見つける。', '타협점을 찾는다.', 1),
    (w, '品質に妥協しない。', '품질에 타협하지 않는다.', 2);

  -- 200. ハードル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ハードル', 'はーどる', '허들, 장애물', NULL, '명사', 200, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高いハードルを越えた。', '높은 장애물을 넘어섬다.', 1),
    (w, '価格のハードルが高い。', '가격의 허들이 높다.', 2);

  -- 201. 人出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '人出', 'ひとで', '인파, 밖으로 나온 사람들', '人(사람 인): 사람
出(나올 출): 곳에서 나옴', '명사', 201, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夜の街には人出が多い。', '밤거리에는 인파가 많다.', 1),
    (w, '休日の人出を見込む。', '휴일의 인파를 예상한다.', 2);

  -- 202. 紛らわしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '紛らわしい', 'まぎらわしい', '혼동하기 쉬우다', '紛(어지러울 분): 糸(실)+分 → 실이 엉혀 어지러움', 'い형용사', 202, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同姓の人と紛らわしい。', '동명이인과 혼동될 수 있다.', 1),
    (w, '説明が紛らわしくて誤解した。', '설명이 혼란스러워서 오해했다.', 2);

  -- 203. 催す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '催す', 'もよおす', '개최하다', '催(재촉 최): 亻+崔 → 일을 촉구·열고 개최', '동사', 203, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記念イベントを催す。', '기념 이벤트를 개최한다.', 1),
    (w, '市がコンサートを催した。', '시가 콘서트를 개최했다.', 2);

  -- 204. 和らぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '和らぐ', 'やわらぐ', '누그러지다', '和(화할 화): 禾(벼)+口 → 다정하고 평온함', '동사', 204, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さが和らいだ。', '추위가 누그러졌다.', 1),
    (w, '緊張が和らぐ。', '긴장이 누그러진다.', 2);

  -- 205. リストアップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'リストアップ', 'りすとあっぷ', '리스트업, 목록 작성', NULL, '명사', 205, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '候補者をリストアップする。', '후보자를 리스트업한다.', 1),
    (w, '必要な品をリストアップした。', '필요한 물품을 목록으로 작성했다.', 2);

  -- 206. 一任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '一任', 'いちにん', '일임, 모두 맡김', '一: 하나
任(맡길 임): 亻+壬 → 사람에게 맡김', '명사', 206, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断を部下に一任する。', '판단을 부하에게 일임한다.', 1),
    (w, '一任されて責任が重い。', '일임받아 책임이 무겁다.', 2);

  -- 207. 腕前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '腕前', 'うでまえ', '솨씨, 실력', '腕(팔 완): 肉(고기)+宛 → 손·팔
前(앞 전): 앞쪽', '명사', 207, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は腕前がよい職人だ。', '그는 솨씨가 좋은 장인이다.', 1),
    (w, '腕前を発揮する機会だ。', '실력을 발휘할 기회다.', 2);

  -- 208. 強硬に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '強硬に', 'きょうこうに', '강경하게', '強(강할 강): 굳세·세다
硬(굳을 경): 石+更 → 돌처럼 단단함', '부사', 208, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強硬に反対した。', '강경하게 반대했다.', 1),
    (w, '強硬な態度を貫く。', '강경한 태도를 고수한다.', 2);

  -- 209. 障る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '障る', 'さわる', '기분 상하다', '障(멉을 장): 阜(언덕)+章 → 언덕이 가로막음', '동사', 209, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その一言が気に障った。', '그 한마디가 기분을 상하게 했다.', 1),
    (w, '彼の態度が障った。', '그의 태도가 불쿨했다.', 2);

  -- 210. じめじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'じめじめ', '축축하다, 습하다', NULL, '부사', 210, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梨雨の日はじめじめしている。', '장마 년에는 집안이 축축하다.', 1),
    (w, 'トイレがじめじめしている。', '화장실이 축축하다.', 2);

  -- 211. そわそわ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'そわそわ', '안절부절못함, 능궁맞이 뚰다', NULL, '부사', 211, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面接前でそわそわしている。', '면접 앞이라 안절부절못한다.', 1),
    (w, '子供がそわそわしている。', '아이가 안절부절못하고 있다.', 2);

  -- 212. 立て替える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '立て替える', 'たてかえる', '대신 돈을 치르다', '立(설 립): 서다
替(바꿀 체): 曰(아닐 왜)+二 → 바꿈', '동사', 212, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書代を立て替えてくれた。', '책값을 대신 내주었다.', 1),
    (w, 'タクシー代を立て替えた。', '택시비를 대신 냈다.', 2);

  -- 213. ためらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ためらう', '주저하다, 망설이다', NULL, '동사', 213, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '返事をためらっている。', '답장을 망설이고 있다.', 1),
    (w, '買うかどうかためらう。', '살지 말지 망설인다.', 2);

  -- 214. 取りわけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '取りわけ', 'とりわけ', '유단히, 특히', '取(취할 취): 耳(귀)+又(손) → 귀 잡음
わけ: 이유·구분', '부사', 214, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日は取りわけ暑い。', '오늘은 유단히 덩다.', 1),
    (w, '彼は取りわけ優秀だ。', '그는 특히 우수하다.', 2);

  -- 215. 荷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '荷', 'に', '짐, 부담', '荷(머이에 질 하): 艸(초초)+何(누구 하) → 지고 나르는 짐', '명사', 215, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重い荷を背負う。', '무거운 짐을 짊어진다.', 1),
    (w, '彼にとって荷が重い。', '그에게 있어서 부담이 크다.', 2);

  -- 216. 担う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '担う', 'になう', '떠맡다, 짊어지다', '担(먹을 담): 手(손)+詹 → 손으로 떠받침', '동사', 216, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '未来を担う若者たち。', '미래를 떠맡을 젛은이들.', 1),
    (w, '重要な役割を担う。', '중요한 역할을 떠맡는다.', 2);

  -- 217. 念頭
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '念頭', 'ねんとう', '염두, 생각의 재갈아짐', '念(생각할 념): 今(이제)+心 → 지금 마음에 두는 것
頭(머리 두): 머리와 있는 고정', '명사', 217, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '常に者のことを念頭に置く。', '항상 그를 염두에 둔다.', 1),
    (w, '念頭にある計画を話した。', '염두에 있는 계획을 말했다.', 2);

  -- 218. 無性に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '無性に', 'むしょうに', '무짜각, 이유없이', '無: 없음
性(성품 성): 心+生 → 타고난 성틈 → ה상황', '부사', 218, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無性に甚いものが食べたい。', '무짜각 단 게 먹고 싶다.', 1),
    (w, '無性に腕が痒い。', '이유없이 팔이 가렵다.', 2);

  -- 219. 異色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '異色', 'いしょく', '이색, 독특함', '異(다를 이): 이상·다름
色(빛 색): 사람의 표정/빛깔', '명사', 219, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは異色の作品だ。', '이것은 독특한 작품이다.', 1),
    (w, '異色の経歴を持つ。', '독특한 경력을 가지고 있다.', 2);

  -- 220. ウエイト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ウエイト', 'うえいと', '비중, 중요도', NULL, '명사', 220, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'セールスにウエイトを置く。', '세일즈에 비중을 둔다.', 1),
    (w, '生産のウエイトが高い。', '생산의 비중이 높다.', 2);

  -- 221. 太だしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '太だしい', 'しばしい', '엄청나게 많다', NULL, 'い형용사', 221, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '太だしい数の人が集まった。', '엄청나게 많은 수의 사람이 모였다.', 1),
    (w, '太だしい量の仕事がある。', '엄청나게 많은 양의 일이 있다.', 2);

  -- 222. 可決
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '可決', 'かけつ', '가결', '可(옷 가): 인정·의결
決(결정 결): 氵(물)+夬 → 물길을 터 결정', '명사', 222, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '議案が可決された。', '의안이 가결되었다.', 1),
    (w, '多数決で可決した。', '다수결로 가결했다.', 2);

  -- 223. 食い止める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '食い止める', 'くいとめる', '막아내다', '食(먹을 식): 먹음
止(그칠 지): 발자국 → 멈춤', '동사', 223, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤字の拡大を食い止める。', '적자 확대를 막아낸다.', 1),
    (w, '請求の動きを食い止めた。', '청구의 움직임을 막았다.', 2);

  -- 224. 駆使する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '駆使する', 'くしする', '구사하다', '駆(몰 구): 馬(말)+区 → 말을 몰아붙임
使(하여금 사): 亻+吏 → 사람을 부림', '동사', 224, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '英語を自由に駆使する。', '영어를 자유롭게 구사한다.', 1),
    (w, '技術を駆使して作った。', '기술을 구사해서 만들었다.', 2);

  -- 225. 心細い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '心細い', 'こころぼそい', '마음이 불안하다', '心(마음 심): 심장 모양
細(가늘 세): 糸(실)+田 → 가느랜 실→허약', 'い형용사', 225, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人で夜道を歩くのは心細い。', '혼자 밤길을 걷는 건 불안하다.', 1),
    (w, '資金が足りず心細い。', '자금이 부족해 불안하다.', 2);

  -- 226. 支障
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '支障', 'ししょう', '지장', '支(갈래·지탱 지): 나뻐짐
障(멉을 장): 가로막힘', '명사', 226, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '業務に支障が出る。', '업무에 지장이 생긴다.', 1),
    (w, '生活に支障がある。', '생활에 지장이 있다.', 2);

  -- 227. 絶大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '絶大な', 'ぜつだいな', '절대적인, 매우 큰', '絶(끊을 절): 糸(실)+色 → 실을 끊음
大(클 대): 크기', 'な형용사', 227, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は絶大な人気を誇る。', '그는 절대적인 인기를 자랑한다.', 1),
    (w, '絶大な信頼を寄せている。', '절대적인 신뢰를 보내고 있다.', 1);

  -- 228. たどる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'たどる', '더듬다, 따라가다', NULL, '동사', 228, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶をたどってみる。', '기억을 더듰어 본다.', 1),
    (w, '同じ道をたどる。', '같은 길을 따라간다.', 2);

  -- 229. てきぱき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'てきぱき', '일을 척척 해내는 모양', NULL, '부사', 229, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事をてきぱきと処理する。', '일을 척척하게 처리한다.', 1),
    (w, 'てきぱきと動く人だ。', '척척하게 움직이는 사람이다.', 2);

  -- 230. ノルマ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ノルマ', 'のるま', '노르마, 할당량', NULL, '명사', 230, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ノルマを達成する。', '할당량을 달성한다.', 1),
    (w, '今月のノルマが原しい。', '이번 달 할당량이 엄격하다.', 2);

  -- 231. 揺らぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '揺らぐ', 'ゆらぐ', '흔들리다', '揺(흔들 요): 手+摭 → 손으로 흔들림', '동사', 231, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '信念が揺らぐ。', '신념이 흔들린다.', 1),
    (w, '地震で建物が揺らいだ。', '지진으로 건물이 흔들렸다.', 2);

  -- 232. 予断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '予断', 'よだん', '예단, 예측', '予(미리 예)
断(끊을 단): 米+斤 → 자르다', '명사', 232, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況は予断を許さない。', '상황은 예단을 불허한다.', 1),
    (w, '予断に反して勝った。', '예상을 깨고 이겼다.', 2);

  -- 233. おおらかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おおらかな', '너그러운, 우둘은', NULL, 'な형용사', 233, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおらかな性格だ。', '너그러운 성격이다.', 1),
    (w, 'おおらかに接する。', '우둘게 대한다.', 2);

  -- 234. 該当する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '該当する', 'がいとうする', '해당하다', '該(갖출 해): 言+亥
当(마끜할 당): 멈춤·맞춤', '동사', 234, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '該当者は手を挨げて下さい。', '해당되시는 분은 손을 들어주세요.', 1),
    (w, '条件に該当する人を選ぶ。', '조건에 해당하는 사람을 고른다.', 2);

  -- 235. 稼働
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '稼働', 'かどう', '가동', '稼(심을 가): 禾+家 → 집안 벼 심는 일
働(일할 동): 亻+動 → 일함', '명사', 235, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工場が24時間稼働している。', '공장이 24시간 가동하고 있다.', 1),
    (w, 'システムの稼働率が高い。', '시스템의 가동률이 높다.', 2);

  -- 236. 起伏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '起伏', 'きふく', '기복', '起(일어날 기): 일어남
伏(엎드릴 복): 亻+犬 → 사람이 개처럼 엎드림', '명사', 236, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生には起伏がある。', '인생에는 기복이 있다.', 1),
    (w, '起伏の多い道を走る。', '기복이 많은 길을 달린다.', 2);

  -- 237. 強制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '強制', 'きょうせい', '강제', '強(강할 강): 굳세·세다
制(제도 제): 牛+刀 → 마름제입', '명사', 237, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '強制的に参加させる。', '강제적으로 참가시킨다.', 1),
    (w, '他人に強制してはいけない。', '타인에게 강제해서는 안 된다.', 2);

  -- 238. くよくよ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'くよくよ', '끈임없이 고민하는 모양', NULL, '부사', 238, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さなことでくよくよするな。', '사소한 일로 고민하지 마라.', 1),
    (w, '失敗をくよくよ考える。', '실패를 고민한다.', 2);

  -- 239. 合意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '合意', 'ごうい', '합의', '合(합할 합): 언덕+입 → 입이 맞음
意(뜻 의): 音+心 → 마음의 소리', '명사', 239, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両者は合意に達した。', '양자는 합의에 도달했다.', 1),
    (w, '合意の上で進める。', '합의하여 진행한다.', 2);

  -- 240. しいて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しいて', '굳이, 굳이 말하자면', NULL, '부사', 240, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しいて言うなら赤が好きだ。', '굳이 말하자면 빨강을 좋아한다.', 1),
    (w, 'しいて反対もしない。', '굳이 반대도 하지 않는다.', 2);

  -- 241. すさまじい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すさまじい', '엄청나다, 대단하다', NULL, 'い형용사', 241, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すさまじい音が黄ろいた。', '대단한 소리가 울렸다.', 1),
    (w, 'すさまじい勢いで走り去った。', '대단한 기세로 달려갔다.', 2);

  -- 242. 直面する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '直面する', 'ちょくめんする', '직면하다', '直(곧을 직)
面(냭 면): 얼굴·표면', '동사', 242, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難題に直面する。', '난관에 직면하다.', 1),
    (w, '現実に直面した。', '현실에 직면했다.', 2);

  -- 243. 取り戻す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '取り戻す', 'とりもどす', '되찾다, 되돌리다', '取(가질 취): 귀+손 → 귀 잡음
戻(어꺋날 려): 戶+犬 → 원래 자리로', '동사', 243, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を取り戻す。', '건강을 되찾다.', 1),
    (w, '信頼を取り戻すために努力する。', '신뢰를 되찾기 위해 노력한다.', 2);

  -- 244. 幅広い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '幅広い', 'はばひろい', '폭넓다', '幅(폭 폭): 巾+畑 → 직물 폭
広(넓을 광): 집+黄 → 곳이 넓음', 'い형용사', 244, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幅広い年齢層に人気だ。', '폭넓은 연령층에 인기가 있다.', 1),
    (w, '幅広い知識を持つ。', '폭넓은 지식을 가진다.', 2);

  -- 245. 紛れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '紛れる', 'まぎれる', '말려들다, 섞이다', '紛(어지러울 분): 糸+分 → 실이 엉혀 어지러움', '동사', 245, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人ごみに紛れる。', '인파에 말려들다.', 1),
    (w, '雑音に紛れて聡き取りにくい。', '잡음에 섞여 알아듣기 힘들다.', 2);

  -- 246. メディア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'メディア', 'めでぃあ', '미디어', NULL, '명사', 246, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'メディアに取り上げられた。', '미디어에 소개되었다.', 1),
    (w, 'スポーツメディアと話した。', '스포츠 미디어와 이야기했다.', 2);

  -- 247. 愛着
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '愛着', 'あいちゃく', '애착', '愛(사랑 애): 受+心
着(붙을 착): 羊+目 → 달라붙음', '명사', 247, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この街に愛着がある。', '이 동네에 애착이 있다.', 1),
    (w, '古い車に愛着を持つ。', '오래된 차에 애착을 가진다.', 2);

  -- 248. 一揃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '一揃', 'いっそう', '일소, 말끔히 쓸어버림', '一
揃(쓸 소): 手+帚 → 빗자루로 쓸어냄', '명사', 248, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '悪者を一揃する。', '악당을 일소한다.', 1),
    (w, '不満を一揃した。', '불만을 말끔히 없애었다.', 2);

  -- 249. 基盤
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '基盤', 'きばん', '기반', '基(터 기): 土+其 → 터·밑판
盤(쇹반 반): 般+皿 → 큰 그릇·밑바닥', '명사', 249, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済の基盤を固める。', '경제의 기반을 다진다.', 1),
    (w, '企業の基盤が部い。', '기업의 기반이 탄탄하다.', 2);

  -- 250. 教訓
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '教訓', 'きょうくん', '교훈', '教(가르칠 교): 孝+攵
訓(가르칠 훈): 言+川 → 말을 이끌어 가르침', '명사', 250, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歴史に学ぶ教訓。', '역사에서 배우는 교훈.', 1),
    (w, '失敗を教訓にする。', '실패를 교훈으로 삼는다.', 2);

  -- 251. 切り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '切り出す', 'きりだす', '말을 꺼내다', '切(끊을 절): 七+刀
出: 꾸려짐', '동사', 251, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '難しい話を切り出した。', '어려운 이야기를 꺼냈다.', 1),
    (w, '本題を切り出す。', '본제를 꺼낸다.', 2);

  -- 252. 染みる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '染みる', 'しみる', '스머들다, 몽시 마음에 닿다', '染(물들 염): 氵+木+九 → 물에 담게끍', '동사', 252, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒さが骨に染みる。', '추위가 빼속까지 스먴든다.', 1),
    (w, '言葉が心に染みた。', '말이 마음에 쇒앤다.', 2);

  -- 253. すんなり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すんなり', '순조롭게, 쉬우며', NULL, '부사', 253, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交渉はすんなり進んだ。', '협상은 순조롭게 진행되었다.', 1),
    (w, 'すんなりと受け入れられた。', '순조롭게 받아들여졌다.', 2);

  -- 254. センス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'センス', 'せんす', '센스, 감각', NULL, '명사', 254, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女はファッションセンスがいい。', '그녀는 패션 감각이 좋다.', 1),
    (w, 'これはセンスの問題だ。', '이건 감각의 문제다.', 2);

  -- 255. 尽くす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '尽くす', 'つくす', '있는 힘을 다하다', '尽(다할 진): 少+皿 → 그릇이 빌 때까지', '동사', 255, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全力を尽くした。', '전력을 다했다.', 1),
    (w, '人を助けるために尽くす。', '사람을 돕기 위해 힘쓴다.', 2);

  -- 256. ノウハウ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ノウハウ', 'のうはう', '노하우', NULL, '명사', 256, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '技術のノウハウを譲る。', '기술의 노하우를 전수한다.', 1),
    (w, 'ノウハウを蔓める。', '노하우를 축적하다.', 2);

  -- 257. 頻繁に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '頻繁に', 'ひんぱんに', '빈번하게, 자주', '頻(자주 빈): 步+頁 → 머리를 자주
繁(번성·잦을 번): 곳+糸 → 많이 느단 매임', '부사', 257, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頻繁にメールを送る。', '빈번하게 메일을 보낸다.', 1),
    (w, 'ここを頻繁に訪れる。', '이곳을 자주 찾는다.', 2);

  -- 258. へとへと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'へとへと', '녹초가 되다, 몀킸 상태', NULL, 'な형용사', 258, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事でへとへとになった。', '일로 녹초가 되었다.', 1),
    (w, '長時間の走りでへとへとだ。', '장시간 달리기로 몀킸 상태다.', 2);

  -- 259. 見かける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見かける', 'みかける', '눈에 띄다', '見(볼 견): 압+人 → 사람이 봄
かける: 행위를 건도함', '동사', 259, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼を騅で見かけた。', '그를 역에서 뎤다.', 1),
    (w, 'よく見かける顔だ。', '자주 눈에 띄는 얼굴이다.', 2);

  -- 260. 流出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '流出', 'りゅうしゅつ', '유출', '流(흐를 류): 氵+毒 → 물이 흐름
出(나올 출): 나감', '명사', 260, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '個人情報が流出した。', '개인정보가 유출되었다.', 1),
    (w, '人材の海外流出が問題だ。', '인재의 해외 유출이 문제다.', 2);

  -- 261. 一環
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '一環', 'いっかん', '일환', '一: 하나
環(고리 환): 玉+罯 → 둘레 돘', '명사', 261, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の一環として行う。', '계획의 일환으로 수행한다.', 1),
    (w, '医療改革の一環だ。', '의료 개혁의 일환이다.', 2);

  -- 262. コンスタントに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'コンスタントに', 'こんすたんとに', '꾸준하게, 일정하게', NULL, '부사', 262, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はコンスタントに成果を出す。', '그는 꾸준한 성과를 낸다.', 1),
    (w, 'コンスタントに努力している。', '꾸준히 노력하고 있다.', 2);

  -- 263. 賛える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '賛える', 'たたえる', '칭찬하다', '賛(기릴 찬): 贝+先+先 → 재물 봉헌 높임', '동사', 263, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の不思議を賛えた。', '그의 어질어짐을 칭찬했다.', 1),
    (w, '認めて賛える。', '인정하고 칭찬한다.', 2);

  -- 264. 非
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '非', 'ひ', '비, 잘못', '非(아닐 비): 양쪽에 서로 등을 대짐 → 아님', '명사', 264, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '非を認めて謝った。', '잘못을 인정하고 사과했다.', 1),
    (w, '非は一切なかった。', '잘못은 아무것도 없었다.', 2);

  -- 265. もっぱら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もっぱら', '오로지, 전당·전적으로', NULL, '부사', 265, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今はもっぱら勉強だ。', '지금은 오로지 공부뿐이다.', 1),
    (w, 'もっぱら読書にふける。', '오로지 독서에 팔린다.', 2);

  -- 266. よみがえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'よみがえる', '소생하다, 부활하다', NULL, '동사', 266, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い記憶がよみがえった。', '오래된 기억이 되살아났다.', 1),
    (w, '伝統がよみがえる。', '전통이 소생한다.', 2);

  -- 267. 打診
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '打診', 'だしん', '타진, 의견을 떠봄', '打(칠 타): 手+丁
診(진찰 진): 言+叁 → 상태를 살핌 파악', '명사', 267, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心身に打診する。', '의향을 타진한다.', 1),
    (w, '会社側に打診した。', '회사측에 타진했다.', 2);

  -- 268. 経歴
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '経歴', 'けいれき', '경력', '経(경서 경): 실+巬 → 는을 곧게 감
歴(겪을 력): 厝+止 → 지나온 자취', '명사', 268, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経歴を詳しく記す。', '경력을 자세히 적는다.', 1),
    (w, '多彩な経歴を持つ。', '다양한 경력을 가진다.', 2);

  -- 269. 弾く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '弾く', 'はじく', '튀기다, 틈기다', '弾(탄알 탄): 弓(활)+單 → 활을 견욠', '동사', 269, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ギターを弾く。', '기타를 친다.', 1),
    (w, 'そろばんを弾く。', '주판을 튀긴다.', 2);

  -- 270. 逸脱
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '逸脱', 'いつだつ', '일탈', '逸(달아날 일): 辶+兔 → 토끼 달아남
脱(벗을 탈): 肉+兌 → 멸을 벴김', '명사', 270, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が本題から逸脱した。', '이야기가 본제에서 일탈했다.', 1),
    (w, '逸脱行為は許されない。', '일탈 행위는 허용되지 않는다.', 2);

  -- 271. いとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'いとも', '매우, 특히', NULL, '부사', 271, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いとも簡単に解いた。', '너무도 간단히 풀었다.', 1),
    (w, 'いとも誤りやすい表現だ。', '매우 틀리기 쉬운 표현이다.', 2);

  -- 272. まちまち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'まちまち', '각양각색, 제각각', NULL, 'な형용사', 272, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見がまちまちだ。', '의견이 제각각이다.', 1),
    (w, '会員の品質はまちまちだ。', '회원의 질이 제각각이다.', 2);

  -- 273. 在庫
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '在庫', 'ざいこ', '재고', '在(있을 재): 才+土
庫(곳집 고): 广+車 → 마차를 두는 곳', '명사', 273, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '在庫を確認する。', '재고를 확인한다.', 1),
    (w, '在庫が不足している。', '재고가 부족하다.', 2);

  -- 274. リスク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'リスク', 'りすく', '리스크', NULL, '명사', 274, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リスクを取る。', '리스크를 감수한다.', 1),
    (w, 'リスク管理が重要だ。', '리스크 관리가 중요하다.', 2);

  -- 275. 堅実な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '堅実な', 'けんじつな', '견실한, 탄탄한', '堅(굳을 견): 구·소·탔 → 단단
実(열매 실): 宀+貝 → 집안에 재물 가득', 'な형용사', 275, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '堅実な仁事ぶりをする。', '성실한 일 처리를 한다.', 1),
    (w, '堅実な人柄だ。', '성실한 인품이다.', 2);

  -- 276. 遮断
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '遮断', 'しゃだん', '차단', '遮(가릴 차): 辶+庶 → 도중에 가림
断(끊을 단): 잔르다', '명사', 276, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通を遮断する。', '교통을 차단한다.', 1),
    (w, '電源を遮断した。', '전원을 차단했다.', 2);

  -- 277. がらりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'がらりと', '확 바뀌고', NULL, '부사', 277, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '態度ががらりと変わった。', '태도가 확 바뀌었다.', 1),
    (w, '雰囲気ががらりと変わった。', '분위기가 확 바뀌었다.', 2);

  -- 278. なだめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'なだめる', '달래다', NULL, '동사', 278, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣く子供をなだめる。', '우는 아이를 달랜다.', 1),
    (w, '怋りをなだめた。', '화를 달래주었다.', 2);

  -- 279. 言及
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '言及', 'げんきゅう', '언급', '言(말씀 언): 辛+口
及(미칠 급): 人+又 → 손으로 닿는 도달', '명사', 279, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件について言及した。', '사건에 대해 언급했다.', 1),
    (w, 'その点には言及しない。', '그 점에는 언급하지 않는다.', 2);

  -- 280. 解除
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '解除', 'かいじょ', '해제', '解(풀 해): 角+刀+牛 → 칼로 소의 뿔 풀어윗
除(덜 제): 阜+餘 → 계단 치움', '명사', 280, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '警報を解除する。', '경보를 해제한다.', 1),
    (w, '該限の解除を決めた。', '제한을 해제하기로 결정했다.', 2);

  -- 281. レイアウト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'レイアウト', 'れいあうと', '레이아웃, 배치', NULL, '명사', 281, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ページのレイアウトを考える。', '페이지의 배치를 고민한다.', 1),
    (w, '店内のレイアウトを変えた。', '점내의 배치를 바꿨다.', 2);

  -- 282. 起用
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '起用', 'きよう', '기용, 발탁', '起(일어날 기)
用(쓸 용): 그림자제에서 유래', '명사', 282, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新人を主役に起用した。', '신인을 주역으로 발탁했다.', 1),
    (w, '選手を起用する。', '선수를 기용한다.', 2);

  -- 283. 駆けつける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '駆けつける', 'かけつける', '달려오다', '駆(몰 구)
つける: 닿다', '동사', 283, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現場に駆けつけた。', '현장에 달려왔다.', 1),
    (w, '仑息を聴いて駆けつける。', '부고를 듣고 달려온다.', 2);

  -- 284. 多角的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '多角的な', 'たかくてきな', '다각적인', '多(많을 다): 저녁을 쓰다 → 많음
角(뿔 각): 짐승의 뿔', 'な형용사', 284, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '多角的な視点で見る。', '다각적인 관점에서 본다.', 1),
    (w, '多角的に検討する。', '다각적으로 검토한다.', 2);

  -- 285. 盛大に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '盛大に', 'せいだいに', '성대하게', '盛(성할 성): 成+皿 → 그릇이 가득 찬
大(클 대)', '부사', 285, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誠大に記念式を行う。', '성대하게 기념식을 거행한다.', 1),
    (w, '誠大なパーティだった。', '성대한 파티였다.', 2);

  -- 286. せかせかと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'せかせかと', '서어서어 서두르는 모양', NULL, '부사', 286, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はせかせかと歩いている。', '그는 서두르며 걷고 있다.', 1),
    (w, 'せかせかと気が見る。', '안절부절못해 보인다.', 2);

  -- 287. センサー
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'センサー', 'せんさー', '센서, 감지장치', NULL, '명사', 287, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人感センサーが反応した。', '인체감지 센서가 반응했다.', 1),
    (w, 'センサーが故障した。', '센서가 고장났다.', 2);

  -- 288. 壮大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '壮大な', 'そうだいな', '장대한, 웅대한', '壮(잔을 장): 亜+士 → 장수
大(클 대)', 'な형용사', 288, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '壮大な計画を立てる。', '웅대한 계획을 세운다.', 1),
    (w, '壮大な景色だ。', '장엄한 경치이다.', 2);

  -- 289. ここちよく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ここちよく', '기분 좋게, 쇾어게', NULL, '부사', 289, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ソファでここちよく休む。', '소파에서 기분 좋게 쉬단다.', 1),
    (w, 'ここちよく眼りを覊た。', '기분 좋게 눈을 붙였다.', 2);

  -- 290. 従事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '従事', 'じゅうじ', '종사', '従(좌을 종): 彼+從 → 따르다
事(일 사): 그림자·일', '명사', 290, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金融業に従事している。', '금융업에 종사하고 있다.', 1),
    (w, '野作業に従事する。', '농작업에 종사한다.', 2);

  -- 291. にじむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'にじむ', '번지다, 스머나오다', NULL, '동사', 291, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '汗がにじむ。', '땅이 배어나온다.', 1),
    (w, 'インクが紙ににじんだ。', '잉크가 종이에 번졌다.', 2);

  -- 292. 禁物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '禁物', 'きんもつ', '금물, 해서는 안 되는 일', '禁(금할 금): 林+示 → 숨은 숲 → 금지
物(만물 물)', '명사', 292, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面接で違反は禁物だ。', '면접에서 자만은 금물이다.', 1),
    (w, '中途半端は禁物だ。', '어중간은 금물이다.', 2);

  -- 293. ひしひしと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ひしひしと', '강렴하게, 절실히', NULL, '부사', 293, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危機をひしひしと感じる。', '위기를 절실히 느낀다.', 1),
    (w, '意やる気がひしひしと伝わる。', '의욕이 절실하게 전해진다.', 2);

  -- 294. 表明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '表明', 'ひょうめい', '표명', '表(곉 표): 衣+毛 → 옷의 겹
明(밝을 명): 일+월', '명사', 294, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '微認を表明した。', '지지를 표명했다.', 1),
    (w, '辞任を表明する。', '사임을 표명한다.', 2);

  -- 295. 精力的に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '精力的に', 'せいりょくてきに', '정력적으로', '精(정할 정): 米(쌓씬)+青 → 고운 쌓씬
力(힘 력): 근육', '부사', 295, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '精力的に活動している。', '정력적으로 활동하고 있다.', 1),
    (w, '精力的な仅事ぶりだ。', '정력적인 일 처리다.', 2);

  -- 296. 気がかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '気がかり', 'きがかり', '염려, 신경쓰임', '気(기운 기): 기운
かる: 걸린다', '명사', 296, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供のことが気かかりだ。', '아이 일이 염려된다.', 1),
    (w, '気がかりなことがある。', '신경 쓰이는 것이 있다.', 2);

  -- 297. 推移
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '推移', 'すいい', '추이, 변화 과정', '推(밀 추): 手+隹 → 손으로 밀어냄
移(옮길 이): 禾+多 → 병 많이 옮김', '명사', 297, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の推移を見る。', '가격의 추이를 본다.', 1),
    (w, '状況の推移を見守る。', '상황의 추이를 지켜본다.', 2);

  -- 298. 危ぶむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '危ぶむ', 'あやぶむ', '위태롭게 여기다', '危(위태할 위): 厘+厄 → 절벽에서 웅�함', '동사', 298, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の達成を危ぶむ。', '계획의 달성을 위태롭게 여긴다.', 1),
    (w, '選手の出場が危ぶまれる。', '선수의 출전이 위태로워진다.', 2);

  -- 299. ずっしりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ずっしりと', '묵직하게, 손이 무겁게', NULL, '부사', 299, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重い荷物がずっしりと腕に伝わる。', '무거운 짐이 묵직하게 팔에 전해진다.', 1),
    (w, 'ずっしりとした手応えだ。', '묵직한 손맛이다.', 2);

  -- 300. 歴然としている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '歴然としている', 'れきぜんとしている', '역연하다, 뚷렷하다', '歴(지낼 역): 厝+止 → 이해 온 흐름
然(그럴 연): 犬+肉+火 → 불타는 개 → 분명', '동사', 300, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両者の実力差は歴然としている。', '양자의 실력차는 역연하다.', 1),
    (w, '歴然とした事実だ。', '역연한 사실이다.', 2);

  -- 301. クレーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'クレーム', 'くれーむ', '클레임, 불평', NULL, '명사', 301, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '客からクレームが来た。', '고객으로부터 클레임이 들어왔다.', 1),
    (w, 'クレームに対応する。', '클레임에 대응한다.', 2);

  -- 302. 経緯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '経緯', 'けいい', '경위, 경과', '経(경서 경)
緯(씨올 위): 糸+韋 → 가로 짠', '명사', 302, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の経緯を説明する。', '사건의 경위를 설명한다.', 1),
    (w, '以前からの経緯がある。', '이전부터의 경위가 있다.', 2);

  -- 303. みっちり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'みっちり', '아주 아주 철저하게', NULL, '부사', 303, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'みっちり訓練した。', '철저하게 훈련했다.', 1),
    (w, 'もっちり勉強する。', '철저하게 공부한다.', 2);

  -- 304. 撤去
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '撤去', 'てっきょ', '철거', '撤(거둘 철): 手+育 → 아까 처리함
去(갈 거): 土+去 → 곳을 떠남', '명사', 304, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不法建築を撤去する。', '불법 건축물을 철거한다.', 1),
    (w, '障害物を撤去した。', '장애물을 철거했다.', 2);

  -- 305. うずうず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'うずうず', '안달한 모양, 못 참고 움직이고 싶은 모양', NULL, '부사', 305, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うずうずしてたまらない。', '못 참아 안달하다.', 1),
    (w, '試合た、たくてうずうずしている。', '경기하고 싶어서 안달하고 있다.', 2);

  -- 306. 却下する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '却下する', 'きゃっかする', '기각하다', '却(물러날 각): 去+卸 → 물러남
下(아래 하)', '동사', 306, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '許上を却下する。', '항소를 기각한다.', 1),
    (w, '詳請が却下された。', '신청이 기각되었다.', 2);

  -- 307. 旺盛だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '旺盛だ', 'おうせいだ', '왕성하다', '旺(왕성할 왕): 日+王 → 보름+해
盛(성할 성): 成+皿', 'な형용사', 307, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食欲が旺盛だ。', '식욕이 왕성하다.', 1),
    (w, 'チャレンジ精神が旺盛だ。', '도전 정신이 왕성하다.', 2);

  -- 308. 施す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '施す', 'ほどこす', '베풀다, 행하다', '施(베풀 시): 方+是 → 깃발을 펼침', '동사', 308, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人に怟けを施す。', '시주닀에게 자비를 베푹다.', 1),
    (w, '忧全の礼を施す。', '만전의 대책을 행한다.', 2);

  -- 309. 余波
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '余波', 'よは', '여파', '余(남을 여): 식+余 → 남은 음식
波(물결 파): 氵+皮 → 물의 결', '명사', 309, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の余波が続く。', '사건의 여파가 이어진다.', 1),
    (w, '厰徳不況の余波を受けた。', '경제 불황의 여파를 받았다.', 2);

  -- 310. 目先
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '目先', 'めさき', '눈앞, 당장의 일', '目(눈 목): 눈
先(먼저 선): 앞은 발', '명사', 310, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目先の利益だけ考える。', '눈앞의 이익만 생각한다.', 1),
    (w, '目先に迫った試験。', '눈앞으로 다가온 시험.', 2);

  -- 311. ぎくしゃくする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ぎくしゃくする', '서먜서먜하다, 어색하다', NULL, '동사', 311, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人間関係がぎくしゃくする。', '인간관계가 서먜서먜해진다.', 1),
    (w, '会話がぎくしゃくした。', '대화가 어색해졌다.', 2);

  -- 312. 存続
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '存続', 'そんぞく', '존속', '存(있을 존): 才+子 → 아이가 있음
続(이을 속): 糸+買 → 이어짐', '명사', 312, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社の存続が危ぶまれる。', '회사의 존속이 위태롭다.', 1),
    (w, '伝統の存続を願う。', '전통의 존속을 바란다.', 2);

  -- 313. 派
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '派', 'は', '파, 계파', '派(갈래 파): 氵+貝 → 물이 갈라짐', '명사', 313, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '同じ派閘だ。', '같은 파벌이다.', 1),
    (w, '反対派に属する。', '반대파에 속한다.', 2);

  -- 314. 風習
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '風習', 'ふうしゅう', '풍습', '風(바람 풍): 万+虫 → 바람의 움직임
習(익힐 습): 羽+白 → 세 론함을 되풀이함', '명사', 314, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い風習が残っている。', '오래된 풍습이 남아있다.', 1),
    (w, '地域の風習を尊重する。', '지역의 풍습을 존중한다.', 2);

  -- 315. もどかしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もどかしい', '답답하다', NULL, 'い형용사', 315, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言いたいことが伝わらずもどかしい。', '하고 싶은 말이 전해지지 않아 답답하다.', 1),
    (w, 'ボタンが押せずもどかしい。', '버튼이 눌리지 않아 답답하다.', 2);

  -- 316. 熟知
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '熟知', 'じゅくち', '숙지', '熟(익을 숙): 享+丸+火 → 잘 익힌
知(알 지): 矢+口 → 먹이는 입', '명사', 316, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はこの分野に熟知している。', '그는 이 분야에 있어 숙지하다.', 1),
    (w, '熟知の上で決めた。', '숙지한 다음 결정했다.', 2);

  -- 317. 拗れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '拗れる', 'こじれる', '꼬이다, 일이 꼬이다', '拗(솤을 요): 手+譱 → 손으로 솤음', '동사', 317, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '許可が拗れた。', '이야기가 꼬였다.', 1),
    (w, '交渉が拗れてしまう。', '협상이 꼬이고 말았다.', 2);

  -- 318. めきめき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'めきめき', '눈에 띄게, 장족거리는 모양', NULL, '부사', 318, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めきめきと上達した。', '눈에 띄게 실력이 은상되었다.', 1),
    (w, 'めきめき頭角を現す。', '돖보이게 두각을 나타낸다.', 2);

  -- 319. 軽快な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軽快な', 'けいかいな', '경쿨한, 경도있는', '軽(가벼울 경): 車+嵮 → 마차 실이는 짓
快(쿨할 쿨): 心+夬 → 마음이 틀임', 'な형용사', 319, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽快な足取りで走る。', '경쿨한 발걸음으로 달린다.', 1),
    (w, '軽快なリズムだ。', '경쿨한 리듬이다.', 2);

  -- 320. サイクル
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'サイクル', 'さいくる', '사이클, 주기', NULL, '명사', 320, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生産のサイクルが短い。', '생산의 주기가 짧다.', 1),
    (w, '番サイクルの品質が高い。', '서이클의 품질이 높다.', 2);

  -- 321. 仲裁
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仲裁', 'ちゅうさい', '중재', '仲(버금 중): 亻+中 → 사람이 가운데
裁(마름질할 재): 衣+哀 → 옷을 장제함', '명사', 321, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '争議の仲裁に入る。', '분쟁의 중재에 나선다.', 1),
    (w, '仲裁者として評価される。', '중재자로서 평가받는다.', 2);

  -- 322. しわざ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しわざ', '소안·짓, 행적', NULL, '명사', 322, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは誤のしわざだろう。', '이건 적의 소안일 것이다.', 1),
    (w, '何者のしわざだ。', '누구의 소안이는가.', 2);

  -- 323. 発覚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '発覚', 'はっかく', '발각', '発(펼 발): 서·않으로 쇔을 쌏
覚(깨달을 각): 學+見 → 배워 알게됨', '명사', 323, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不正が発覚した。', '부정이 발각되었다.', 1),
    (w, '事件が発覚する。', '사건이 발각된다.', 2);

  -- 324. すべすべ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すべすべ', '매끄럽고 부드러운 모양', NULL, 'な형용사', 324, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肌がすべすべだ。', '피부가 매끄럽다.', 1),
    (w, 'すべすべした表面。', '매끄러운 표면.', 2);

  -- 325. 噂し合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '噂し合う', 'かみあう', '맞물리다, 맞다', '噂(ל 소문 우)
う: 울리머', '동사', 325, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '歯車が噂し合う。', '톱니바퀴가 맞물린다.', 1),
    (w, '議論が噂し合わない。', '논의가 맞물리지 않는다.', 2);

  -- 326. 保護
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '保護', 'ほご', '보호', '保(지키으 보): 亻+呆 → 사람이 아기를 품
護(도울 호): 言+仓 → 말로 보호', '명사', 326, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境を保護する。', '환경을 보호한다.', 1),
    (w, '動物の保護活動に参加する。', '동물 보호 활동에 참여한다.', 2);

  -- 327. 忠実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '忠実に', 'ちゅうじつに', '충실하게', '忠(충성 충): 中+心 → 중심에 차는 마음
実(열매 실): 재물·알차', '부사', 327, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忠実に仕事をこなす。', '충실하게 일을 처리한다.', 1),
    (w, '原作に忠実な映画だ。', '원작에 충실한 영화다.', 2);

  -- 328. すくう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すくう', '주우다, 숨을 주우다', NULL, '동사', 328, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '水をすくう。', '물을 마시다.', 1),
    (w, '人を危険からすくう。', '사람을 위험에서 구한다.', 2);

  -- 329. ピント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ピント', 'ぴんと', '초점, 포인트', NULL, '명사', 329, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カメラのピントが合わない。', '카메라 초점이 맞지 않는다.', 1),
    (w, '話のピントがずれている。', '이야기의 초점이 엇나있다.', 2);

  -- 330. 食い込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '食い込む', 'くいこむ', '파고들다', '食(먹을 식)
込む: 안으로 들어가다', '동사', 330, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ロープが肌に食い込む。', '로프가 살에 파고든다.', 1),
    (w, '人生を食い込むような赤字。', '생계를 파고드는 듯한 적자.', 2);

  -- 331. てっきり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'てっきり', '틀림없이, 분명히', NULL, '부사', 331, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'てっきり雨だと思った。', '틀림없이 비가 올 거라 생각했다.', 1),
    (w, 'てっきり会議は中止だと思っていた。', '틀림없이 회의가 취소될 줄 알았다.', 2);

  -- 332. 自立
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '自立', 'じりつ', '자립', '自(스스로 자): 코 모양
立(설 립): 다리 멈춘 자세', '명사', 332, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済的に自立した。', '경제적으로 자립했다.', 1),
    (w, '子供の自立を愿う。', '아이의 자립을 바란다.', 2);

  -- 333. 還元
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '還元', 'かんげん', '환원', '還(돌아올 환): 辶+環 → 다시 돌아옴
元(으떤 원): 머리+모자 → 근원', '명사', 333, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '利益を社会に還元する。', '이익을 사회에 환원한다.', 1),
    (w, '酒を還元反応させる。', '알코을 환원반응시킨다.', 2);

  -- 334. どんより
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'どんより', '명 타다, 흐릿', NULL, '부사', 334, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんよりした天気だ。', '흐릿한 날씨다.', 1),
    (w, 'どんよりとした顔をしている。', '우울한 얼굴을 하고 있다.', 2);

  -- 335. ネック
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ネック', 'ねっく', '네크, 애로사항', NULL, '명사', 335, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用がネックだ。', '비용이 애로사항이다.', 1),
    (w, '言語の壁がネックとなる。', '언어의 벽이 애로사항이 된다.', 2);

  -- 336. 発散
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '発散', 'はっさん', '발산', '発(펼 발)
散(흔을 산): 莶+肉+攵 → 고기를 쟐게 자름', '명사', 336, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスを発散する。', '스트레스를 발산한다.', 1),
    (w, '余分なエネルギーを発散する。', '여분의 에너지를 발산한다.', 2);

  -- 337. 行き届く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '行き届く', 'ゆきとどく', '구석구석 미치다', '行(다닐 행): 사거리 모양
届(보낼 계): 尸+由 → 이르다', '동사', 337, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古ろ量りが行き届く。', '배려가 구석구석 미친다.', 1),
    (w, '金雏に行き届いたサービス。', '세세한 부분까지 미친 서비스.', 2);

  -- 338. 快挙
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '快挙', 'かいきょ', '쿨거', '快(쿨할 쿨): 心+夬
挙(들 거): 與+手 → 손으로 들어 올림', '명사', 338, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界初の快挙を達成した。', '세계 최초의 쿨거를 달성했다.', 1),
    (w, '快挙を肆げる。', '쿨거를 이룩한다.', 2);

  -- 339. 助長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '助長', 'じょちょう', '조장, 조장함', '助(도울 조): 且+力 → 힘을 더함
長(길 장): 머리카락이 긴 노인', '명사', 339, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不平不満を助長する。', '불평불만을 조장한다.', 1),
    (w, '争いを助長する。', '싸움을 조장한다.', 2);

  -- 340. 見返り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見返り', 'みかえり', '대가, 보상', '見(볼 견)
返: 돌려주다', '명사', 340, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '協力の見返りを要求する。', '협력의 대가를 요구한다.', 1),
    (w, '努力の見返りがあった。', '노력의 대가가 있었다.', 2);

  -- 341. 結成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '結成', 'けっせい', '결성', '結(맺을 결): 糸+吉 → 실이 맺임
成(이룰 성): 戊+丁 → 먹이 있는 안정되면', '명사', 341, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'インドバンドを結成した。', '밴드를 결성했다.', 1),
    (w, '委員会を結成する。', '위원회를 결성한다.', 2);

  -- 342. 手配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手配', 'てはい', '수배, 준비', '手(손 수): 움직이는 손
配(나눌 배): 酉+己 → 술을 나눌함', '명사', 342, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通手配をする。', '교통편을 수배한다.', 1),
    (w, '接足を手配する。', '접속을 수배한다.', 2);

  -- 343. つくづく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'つくづく', '제대로, 고이 고이, 절실히', NULL, '부사', 343, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つくづくと考えた。', '고이 고이 생각했다.', 1),
    (w, 'つくづく誓んだ。', '절실히 느꼈다.', 2);

  -- 344. 解れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '解れる', 'ほぐれる', '풌리다, 괴어 느곳해지다', '解(풀 해)', '동사', 344, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '緊張が解れる。', '긴장이 풌린다.', 1),
    (w, '骪のこりが解れた。', '어깨 결림이 풌렸다.', 2);

  -- 345. 根底
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '根底', 'こんてい', '근저', '根(뿌리 근): 木+嵮 → 나무의 뿌리
底(밑 저): 广+氐 → 집의 밑', '명사', 345, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考え方の根底から違う。', '생각이 근저에서부터 다르다.', 1),
    (w, '社会の根底を揺るがす事件。', '사회의 근저를 흔드는 사건.', 2);

  -- 346. 返上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '返上', 'へんじょう', '반납, 반환', '返(돌아올 반): 辶+反 → 돌아옴
上(위 상)', '명사', 346, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'タイトルを返上した。', '타이틀을 반납했다.', 1),
    (w, '休日を返上して働く。', '휴일을 이낌고 일한다.', 2);

  -- 347. 取り次ぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '取り次ぐ', 'とりつぐ', '중계하다, 전달하다', '取(가질 취)
次(버금 차): 二+欠', '동사', 347, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話を取り次ぐ。', '전화를 바꿔준다.', 1),
    (w, '伝言を取り次いだ。', '전언을 전해주었다.', 2);

  -- 348. 交錯する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '交錯する', 'こうさくする', '교착하다', '交(사귀일 교): 사람이 다리를 꼬은 모양
錯(섮일 착): 金+昔 → 금속이 섮임', '동사', 348, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思いが交錯する。', '생각이 교착한다.', 1),
    (w, '多くの人と車が交錯する。', '많은 사람과 차가 교착한다.', 2);

  -- 349. 難航
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '難航', 'なんこう', '난항, 일이 잘 안 됨', '難(어려울 난)
航(배 항): 舟+亢 → 배가 건너감', '명사', 349, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が難航している。', '계획이 난항하고 있다.', 1),
    (w, '交渉は難航中だ。', '협상은 난항 중이다.', 2);

  -- 350. がやがや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'がやがや', '웅성거려는 모양', NULL, '부사', 350, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教室ががやがやしている。', '교실이 웅성거리고 있다.', 1),
    (w, 'がやがやと話してうるさい。', '웅성거려서 시끄럽다.', 2);

  -- 351. 足手まとい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '足手まとい', 'あしてまとい', '거칩거리는 존재, 거친다리', '足+手+まとう: 손과 발을 얽음', '명사', 351, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が足手まといになる。', '아이가 거칩거리게 된다.', 1),
    (w, '仕事をする上で足手まといだ。', '일하는 데 거칩거리다.', 2);

  -- 352. 適応
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '適応', 'てきおう', '적응', '適(맞을 적): 辶+啇 → 도에서 맞게
応(응할 응): 广+心 → 마음으로 응함', '명사', 352, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '環境に適応する。', '환경에 적응한다.', 1),
    (w, '適応能力が高い。', '적응력이 뛰어나다.', 2);

  -- 353. 掲げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '掲げる', 'かかげる', '높이 들다, 내걸다', '掲(높이 들 게): 手+譁 → 손으로 올림', '동사', 353, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スローガンを掲げる。', '구호를 내건다.', 1),
    (w, '旗を掲げる。', '깃발을 처들고 올린다.', 2);

  -- 354. 足止め
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '足止め', 'あしどめ', '발이 묶임, 이동 제한', '足(발 족)
止: 멈춤', '명사', 354, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電車が足止めされた。', '전철이 멈춰 섬다.', 1),
    (w, '伝染病で交通が足止めになる。', '전염병으로 교통이 멈쎘 되어버린다.', 2);

  -- 355. 払拭
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '払拭', 'ふっしょく', '분식', '払(쓰을 분): 手+弗 → 손으로 쓸어냄
拭(병을 식): 手+芘 → 손으로 쓸어냄', '명사', 355, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不安を払拭する。', '불안을 분식한다.', 1),
    (w, '誤解を払拭したい。', '오해를 분식하고 싶다.', 2);

  -- 356. とっさに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'とっさに', '순간적으로, 순간적으로', NULL, '부사', 356, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とっさに身をかわした。', '순간적으로 몸을 피했다.', 1),
    (w, 'とっさに言い訳をした。', '순간적으로 변명을 했다.', 2);

  -- 357. いやみ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'いやみ', '빈정거림, 랜답거리기', NULL, '명사', 357, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いやみを言う。', '빈정거림을 말한다.', 1),
    (w, 'いやみったたらしい言い方だ。', '빈정거리는 듯한 말투다.', 2);

  -- 358. 丹念に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '丹念に', 'たんねんに', '정성스레', '丹(붉을 단): 주석·단제
念(생각·한와 년): 今+心', '부사', 358, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '丹念に仕上げた作品だ。', '정성스레 마무리한 작품이다.', 1),
    (w, '丹念に調査した。', '정성스레 조사했다.', 2);

  -- 359. なじむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'なじむ', '친숙해지다', NULL, '동사', 359, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しい環境になじんだ。', '새로운 환경에 친숙해졌다.', 1),
    (w, '上司となじめない。', '상사와 친해지지 않는다.', 2);

  -- 360. はかどる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'はかどる', '일이 진첩되다', NULL, '동사', 360, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事がはかどらない。', '일이 진첩되지 않는다.', 1),
    (w, '勉強がはかどる。', '공부가 진첩된다.', 2);

  -- 361. 張り合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '張り合う', 'はりあう', '맞붙다, 경쟁하다', '張(베풀 장)
合(합할 합)', '동사', 361, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ライバルと張り合う。', '라이벌과 맞서다.', 1),
    (w, '子供同士が張り合った。', '아이끼리 경쟁했다.', 2);

  -- 362. まばらだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'まばらだ', '드물다', NULL, 'な형용사', 362, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人館がまばらだ。', '사람 그림자가 드물다.', 1),
    (w, 'そんな話はまばらだ。', '그런 이야기는 드물다.', 2);

  -- 363. 見合わせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見合わせる', 'みあわせる', '보류하다, 일시 중지하다', '見(볼 견)
合わせる: 맞춰다', '동사', 363, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発を見合わせた。', '출발을 보류했다.', 1),
    (w, '買うのを見合わせた。', '사는 것을 보류했다.', 2);

  -- 364. やむをえず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'やむをえず', '어쩔 수 없이', NULL, '부사', 364, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やむをえず中止した。', '어쩔 수 없이 중지했다.', 1),
    (w, 'やむをえず謝った。', '어쩔 수 없이 사과했다.', 2);

  -- 365. ルーズな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ルーズな', 'るーずな', '늨슬한, 고수적이지 못한', NULL, 'な형용사', 365, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '金銘にルーズな人だ。', '돈 관리에 늨슬한 사람이다.', 1),
    (w, '帰りがルーズだ。', '시간 약속이 늨슬하다.', 2);

  -- 366. 朗報
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '朗報', 'ろうほう', '낭보', '朗(밝을 랑): 良+月 → 좋은 달
報(알릴 보): 幸+报 → 행복을 편지로 알림', '명사', 366, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格の朗報が入った。', '합격이라는 낭보가 들어왔다.', 1),
    (w, '朗報を伝える。', '낭보를 전한다.', 2);

  -- 367. わずらわしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'わずらわしい', '번거롭다, 귀찮다', NULL, 'い형용사', 367, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳しい手続きがわずらわしい。', '자세한 절차가 번거롭다.', 1),
    (w, '人間関係がわずらわしい。', '인간관계가 번거롭다.', 2);

  -- 368. あっけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'あっけない', '허무하다, 시시하다', NULL, 'い형용사', 368, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あっけない結末だった。', '허무한 결말이었다.', 1),
    (w, 'あっけないぐらい簡単に勝った。', '허무할 정도로 쉬운게 이겼다.', 2);

  -- 369. ありきたりの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ありきたりの', '흔해 빠진', NULL, '연체·수식어', 369, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありきたりの意見だ。', '흔해 빠진 의견이다.', 1),
    (w, 'ありきたりのメッセージだった。', '흔해 빠진 메시지였다.', 2);

  -- 370. 画期的な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '画期的な', 'かっきてきな', '획기적인', '画(그림 화)
期(기약 기): 其+月 → 일정한 시점', 'な형용사', 370, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画期的な発明だ。', '획기적인 발명이다.', 1),
    (w, '画期的な出作だ。', '획기적인 작품이다.', 2);

  -- 371. 極力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '極力', 'きょくりょく', '극력, 최선을 다해', '極(다할 극): 木+亱 → 뛡의 골리
力(힘 력)', '부사', 371, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '極力黑めるよう努る。', '최선을 다해 피하도록 노력한다.', 1),
    (w, '極力低価格で提供する。', '최대한 낮은 가격으로 제공한다.', 2);

  -- 372. コントラスト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'コントラスト', 'こんとらすと', '콘트라스트, 대비', NULL, '명사', 372, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '色のコントラストが鮮やかだ。', '색깔의 대비가 선명하다.', 1),
    (w, '両者のコントラストが明らかだ。', '양자의 상이가 분명하다.', 2);

  -- 373. シビアな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'シビアな', 'しびあな', '가혹한, 엄격한', NULL, 'な형용사', 373, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シビアな評価を受けた。', '엄격한 평가를 받았다.', 1),
    (w, 'シビアな職場の現実だ。', '가혹한 직장의 현실이다.', 2);

  -- 374. 重宝する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '重宝する', 'ちょうほうする', '유용하게 쓰다', '重(소중할 중): 里+千 → 천 곡
宝(보배 보): 宀+玉 → 집안 너마·올색기', '동사', 374, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道具は重宝している。', '이 도구는 유용하게 쓰고 있다.', 1),
    (w, '多才な人として重宝される。', '다재다능한 사람으로 중시된다.', 2);

  -- 375. 手がかり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手がかり', 'てがかり', '실마리, 단서', '手(손 수)
かり: 걸림', '명사', 375, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の手がかりをつかむ。', '사건의 실마리를 잡는다.', 1),
    (w, '解決の手がかりがない。', '해결의 실마리가 없다.', 2);

  -- 376. にわかには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'にわかには', '썯새도, 당장은', NULL, '부사', 376, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'にわかには信じられない。', '썯새도 믿어지지 않는다.', 1),
    (w, 'にわかには動けない。', '당장은 움직일 수 없다.', 2);

  -- 377. もくろむ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もくろむ', '계획하다, 꾸뮸다', NULL, '동사', 377, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '起業をもくろむ。', '창업을 꾸뮼다.', 1),
    (w, '逆転をもくろむ。', '역전을 꾸뮼다.', 2);

  -- 378. 落胆する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '落胆する', 'らくたんする', '낙담하다', '落(떨어질 락): 일+洛 → 풀이 시들어 떨어짐
胆(쓡개 담): 고기+詹', '동사', 378, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不合格に落胆した。', '불합격에 낙담했다.', 1),
    (w, '試合に負けて落胆した。', '시합에 져서 낙담했다.', 2);

  -- 379. おっくうだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おっくうだ', '귀찮다, 하기 싫다', NULL, 'な형용사', 379, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出かけるのがおっくうだ。', '나가기가 귀찮다.', 1),
    (w, '勉強がおっくうだ。', '공부가 귀찮다.', 2);

  -- 380. おのずと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おのずと', '저절로, 자연히', NULL, '부사', 380, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がおのずと下がった。', '고개가 저절로 숙여졌다.', 1),
    (w, '実力がつけばおのずと認められる。', '실력이 쌓이면 자연히 인정받게 된다.', 2);

  -- 381. 簡素だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '簡素だ', 'かんそだ', '간소하다', '簡(대쉭 간): 竹+間 → 대나무 책
素(흡 소): 主+糸 → 원래의 색 실', 'な형용사', 381, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡素な生活を送る。', '간소한 생활을 한다.', 1),
    (w, '簡素なデザインだ。', '간소한 디자인이다.', 2);

  -- 382. けなされる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'けなされる', '헐뜨김 당하다', NULL, '동사', 382, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品がけなされた。', '작품이 헐뜨긴다.', 1),
    (w, '考えをけなされて舐ろした。', '생각이 헐뜨겨 낙심했다.', 2);

  -- 383. しきりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しきりに', '자꾸, 끊임없이', NULL, '부사', 383, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しきりに電話が鳴る。', '자꾸 전화가 울린다.', 1),
    (w, 'しきりに評価されている。', '자꾸 평가받고 있다.', 2);

  -- 384. 触発される
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '触発される', 'しょくはつされる', '촉발되다', '触(늿을 촉): 角+蜀 → 뿔으로 차·돫
発(펼 발)', '동사', 384, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他の作品に触発された。', '다른 작품에 자극받았다.', 1),
    (w, 'その話に触発されて始めた。', '그 이야기에 자극을 받아 시작했다.', 2);

  -- 385. すがすがしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すがすがしい', '상쿾하다', NULL, 'い형용사', 385, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '朝の空気がすがすがしい。', '아침 공기가 상쿾하다.', 1),
    (w, 'すがすがしい風が吹く。', '상쿾한 바람이 불어온다.', 2);

  -- 386. スケール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スケール', 'すけーる', '스케일, 규모', NULL, '명사', 386, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スケールの大きい計画だ。', '규모가 큰 계획이다.', 1),
    (w, 'スケールアップさせる。', '규모를 키운다.', 2);

  -- 387. 先方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '先方', 'せんぽう', '상대편', '先(먼저 선)
方(모 방): 장소', '명사', 387, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先方の都合を評く。', '상대편의 사정을 듣는다.', 1),
    (w, '先方と連絡を取る。', '상대편과 연락을 취한다.', 2);

  -- 388. 断念する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '断念する', 'だんねんする', '단념하다', '断(끊을 단): 米+斤
念(생각 념): 今+心', '동사', 388, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出場を断念した。', '출전을 단념했다.', 1),
    (w, '夛を断念した。', '꿈을 단념했다.', 2);

  -- 389. 当面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '当面', 'とうめん', '당면, 당분간', '当(마끜할 당): 小+田
面(냭 면)', '명사', 389, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '当面の課題を解決する。', '당면의 과제를 해결한다.', 1),
    (w, '当面はこれでそだ。', '당분간은 이걸로 될 것이다.', 2);

  -- 390. 密かに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '密かに', 'ひそかに', '은밀히', '密(비밀 밀): 宀+必+山 → 산에 숨김', '부사', 390, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '密かに計画を進める。', '은밀히 계획을 진행한다.', 1),
    (w, '密かに顔を見る。', '몰래 얼굴을 본다.', 2);

  -- 391. あらかじめ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'あらかじめ', '미리, 사전에', NULL, '부사', 391, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あらかじめ予約した。', '미리 예약했다.', 1),
    (w, 'あらかじめ見ておく。', '사전에 보아 둔다.', 2);

  -- 392. 裏づけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '裏づけ', 'うらづけ', '뻗받침, 증거', '裏(속 리): 衣+里
づけ: 붙임', '명사', 392, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '裏づけとなる事実。', '뻗받침이 되는 사실.', 1),
    (w, '裏づけをとる。', '뻗받침을 취한다.', 2);

  -- 393. おおむね
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おおむね', '대쪽, 대제로', NULL, '부사', 393, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おおむね了解した。', '대쪽 이해했다.', 1),
    (w, 'おおむね予想通りだ。', '대철 예상대로다.', 2);

  -- 394. 仰天する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仰天する', 'ぎょうてんする', '깜짝 놀라다', '仰(우러러볼 앙): 亻+卯 → 사람이 우러러봄
天(하늘 천)', '동사', 394, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の高さに仰天した。', '가격의 높이에 놀랐다.', 1),
    (w, '意外な結果に仰天した。', '의외의 결과에 깜짝 놀랐다.', 2);

  -- 395. ことごとく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ことごとく', '하나하나, 전부', NULL, '부사', 395, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画がことごとく失敗した。', '계획이 하나하나 실패했다.', 1),
    (w, 'ことごとく説明をした。', '전부 설명을 했다.', 2);

  -- 396. 雑踏
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '雑踏', 'ざっとう', '잡답, 혼잡함', '雑(섮일 잡): 衣+隻
踏(밟을 답): 足+水', '명사', 396, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雑踏の中を歩く。', '인파 속을 걷는다.', 1),
    (w, '駅は雑踏していた。', '역은 혼잡했다.', 2);

  -- 397. 従来の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '従来の', 'じゅうらいの', '종래의', '従(좌을 종)
来(올 래): 올 때까지', '연체·수식어', 397, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '従来の方法を見直す。', '종래의 방법을 재검토한다.', 1),
    (w, '従来のシステムとは違う。', '종래의 시스템과 다르다.', 2);

  -- 398. すべ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すべ', '방법, 수단', NULL, '명사', 398, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なすすべもない。', '어첨할 방법이 없다.', 1),
    (w, 'もうすべもない。', '이제 수단이 없다.', 2);

  -- 399. せかす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'せかす', '재촉하다', NULL, '동사', 399, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼をせかして出かけた。', '그를 재촉해 나갔다.', 1),
    (w, 'ばやく動けとせかされた。', '빨리 움직이라고 재촉당했다.', 2);

  -- 400. バックアップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'バックアップ', 'ばっくあっぷ', '백업, 지원', NULL, '명사', 400, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'データをバックアップする。', '데이터를 백업한다.', 1),
    (w, '仲間のバックアップを受ける。', '동료의 지원을 받는다.', 2);

  -- 401. 抜群だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '抜群だ', 'ばつぐんだ', '뛰어나다', '抜(빼어낼 발): 手+友·友 → 손으로 빼냄
群(무리 군): 君+羊', 'な형용사', 401, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶力は抜群だ。', '기억력은 타의 추종을 불허한다.', 1),
    (w, '抜群の成績だ。', '뛰어난 성적이다.', 2);

  -- 402. メカニズム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'メカニズム', 'めかにずむ', '메카니즘', NULL, '명사', 402, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体のメカニズムを学ぶ。', '몸의 메카니즘을 배운다.', 1),
    (w, '仰事のメカニズムを理解する。', '일의 메카니즘을 이해한다.', 2);

  -- 403. 案の定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '案の定', 'あんのじょう', '아닌게 아닌으로, 아니나 다를까', '案(책상 안)
定(정할 정)', '부사', 403, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '案の定雨が降った。', '아니나 다를까 비가 내렸다.', 1),
    (w, '案の定入診した。', '예상대로 입원했다.', 2);

  -- 404. いたって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'いたって', '매우, 아주', NULL, '부사', 404, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いたって健康だ。', '매우 건강하다.', 1),
    (w, 'いたって逆りはない。', '그닥치 별일 없다.', 2);

  -- 405. 打ち込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '打ち込む', 'うちこむ', '열중하다', '打: 치다
込む: 안으로 들어가다', '동사', 405, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に打ち込む。', '일에 열중한다.', 1),
    (w, '研究に打ち込んだ。', '연구에 못한 열중을 했다.', 2);

  -- 406. お手上げだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'お手上げだ', 'おてあげだ', '속수무책이다', NULL, 'な형용사', 406, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この問題はお手上げだ。', '이 문제는 속수무책이다.', 1),
    (w, 'こうなってはお手上げだ。', '이렇게 되면 속수무책이다.', 2);

  -- 407. 回想する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '回想する', 'かいそうする', '회상하다', '回(돌아올 회): 움직임
想(생각할 상)', '동사', 407, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学生時代を回想する。', '학생 시절을 회상한다.', 1),
    (w, '他人との思い出を回想する。', '옥주와의 추억을 회상한다.', 2);

  -- 408. 格段に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '格段に', 'かくだんに', '견주, 혜씀', '格(격식 격): 木+各 → 나무로 격자
段(쪼건이 단): 殳+段 → 계단 단', '부사', 408, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年は格段に審い。', '올해는 혜씀 추다.', 1),
    (w, '格段に都合がよくなった。', '핌썬 좋아졌다.', 2);

  -- 409. ストレートに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ストレートに', 'すとれーとに', '소직히, 직접적으로', NULL, '부사', 409, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレートに意見を言う。', '직설적으로 의견을 말한다.', 1),
    (w, 'ストレートに表現する。', '직설적으로 표현한다.', 2);

  -- 410. 手分けする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手分けする', 'てわけする', '분담하다', '手(손 수)
分(나눌 분)', '동사', 410, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を手分けしてやる。', '일을 분담해서 한다.', 1),
    (w, '扛した荷物を手分けした。', '짐을 분담했다.', 2);

  -- 411. 不用意な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不用意な', 'ふよういな', '부주의한, 조심성 없는', '不(아닌 부)
用意: 준비', 'な형용사', 411, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不用意な発言をした。', '부주의한 발언을 했다.', 1),
    (w, '不用意に接してそうだ。', '부주의하게 만진 것 같다.', 2);

  -- 412. 無償
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '無償', 'むしょう', '무상', '無: 없음
償(갚을 상): 亻+賞 → 상을 갗', '명사', 412, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無償で提供される。', '무상으로 제공된다.', 1),
    (w, '無償サービスを受けた。', '무상 서비스를 받았다.', 2);

  -- 413. 厄介な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '厄介な', 'やっかいな', '성가신, 귀찮은', '厄(곤액할 액): 상황·재난
介(끼일 개)', 'な형용사', 413, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厄介な仕事を代たされた。', '귀찮은 일을 떠맡게 되었다.', 1),
    (w, '厄介な人と関わった。', '성가신 사람과 엮혀다.', 2);

  -- 414. ありふれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ありふれる', '흔하다, 흔하게 있다', NULL, '동사', 414, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありふれた話だ。', '흔한 이야기다.', 1),
    (w, 'ありふれたデザインだ。', '흔한 디자인이다.', 2);

  -- 415. 糸口
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '糸口', 'いとぐち', '실마리, 단서', '糸(실 사): 실타래
口(입 구)', '명사', 415, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の糸口をつかむ。', '사건의 실마리를 잡는다.', 1),
    (w, '解決の糸口が見えた。', '해결의 실마리가 보였다.', 2);

  -- 416. うろたえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'うろたえる', '당황하다', NULL, '동사', 416, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予期せぬ質問にうろたえた。', '예기치 못한 질문에 당황했다.', 1),
    (w, '逆境にうろたえる。', '역경에 당황한다.', 2);

  -- 417. 苦情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '苦情', 'くじょう', '고정, 클레임', '苦(쓸 고): 艸+古 → 풀이 쓴
情(뜿 정)', '명사', 417, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦情を言う。', '불평을 말한다.', 1),
    (w, '人能上より苦情が出た。', '인공능으로부터 대한 클레임이 나왔다.', 2);

  -- 418. 互角だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '互角だ', 'ごかくだ', '호각이다, 대등하다', '互(서로 호): 파동 모양
角(뿔 각)', 'な형용사', 418, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両チームの実力は互角だ。', '두 팀의 실력은 호각이다.', 1),
    (w, '互角の勝負を繰り広げた。', '호각의 승부를 벌였다.', 2);

  -- 420. 錯覚する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '錯覚する', 'さっかくする', '착각하다', '錯(섮일 착): 金+昔
覚(깨달을 각)', '동사', 420, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を錯覚していた。', '상황을 착각하고 있었다.', 1),
    (w, '主評は錯覚だった。', '주관은 착각이었다.', 2);

  -- 421. 殺到する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '殺到する', 'さっとうする', '쇄도하다', '殺(죽일 살): 乂+殳
到(이를 도): 至+刀', '동사', 421, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問が殺到した。', '질문이 쇄도했다.', 1),
    (w, '注文が殺到している。', '주문이 쇄도하고 있다.', 2);

  -- 422. 仕上がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仕上がる', 'しあがる', '완성되다', '仕(벼슴 사)
上(올릴 상)', '동사', 422, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品が仕上がった。', '작품이 완성되었다.', 1),
    (w, 'レポートが仕上がる。', '리포트가 완성된다.', 2);

  -- 423. 助言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '助言', 'じょげん', '조언', '助(도울 조)
言(말씀 언)', '명사', 423, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '助言を諸る。', '조언을 구한다.', 1),
    (w, '貴重な助言がもらえた。', '귀중한 조언을 받았다.', 2);

  -- 424. 不意に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不意に', 'ふいに', '불의에, 갑자기', '不: 아닌
意(뜻 의)', '부사', 424, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不意に訪れた客。', '불시에 찾아온 손님.', 1),
    (w, '不意に雨が降った。', '갑자기 비가 내렸다.', 2);

  -- 425. 弁解する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '弁解する', 'べんかいする', '변명하다', '弁(고깔 변): 奓+备 → 분별
解(풀 해)', '동사', 425, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅刻の理由を弁解する。', '지각의 이유를 변명한다.', 1),
    (w, '弁解の余地がない。', '변명의 여지가 없다.', 2);

  -- 426. 安堵する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '安堵する', 'あんどする', '안도하다', '安(편안할 안): 집안 여자
堵(막을 도): 이견을 막음', '동사', 426, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無事に計画が進み安堵した。', '무사히 계획이 진행되어 안도했다.', 1),
    (w, 'そのニュースに安堵した。', '그 소식에 안도했다.', 2);

  -- 427. 意気込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '意気込み', 'いきごみ', '의욕, 포부', '意(뜻 의)
気(기운 기)', '명사', 427, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事への意気込みを語る。', '일에 대한 의욕을 이야기한다.', 1),
    (w, '意気込みが違う。', '의욕이 다르다.', 2);

  -- 428. おびえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おびえる', '곁에 질리다', NULL, '동사', 428, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雷におびえる。', '천둥에 곁에 질린다.', 1),
    (w, '危険におびえる。', '위험에 곁에 질린다.', 2);

  -- 429. かねがね
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かねがね', '이전부터, 진작', NULL, '부사', 429, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かねがね考えていた。', '이전부터 생각하고 있었다.', 1),
    (w, 'かねがね見たいと思っていた。', '진작부터 보고 싶어 했다.', 2);

  -- 430. かろうじて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かろうじて', '간신히, 결울각재로', NULL, '부사', 430, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かろうじて間に合った。', '간신히 제시간에 대었다.', 1),
    (w, 'かろうじて勝った。', '이주 겄우 이겼다.', 2);

  -- 431. 故意に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '故意に', 'こいに', '고의로, 일부러', '故(속섬 고): 古+攵
意(뜻 의)', '부사', 431, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '故意に負けた。', '일부러 젼다.', 1),
    (w, '故意に誤りを犯した。', '고의로 실수를 했다.', 2);

  -- 432. ささいな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ささいな', '사소한, 하찮은', NULL, 'な형용사', 432, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ささいなことで誉嘘した。', '사소한 일로 싸웠다.', 1),
    (w, 'ささいな間違いを見つけた。', '사소한 실수를 찾아냈다.', 2);

  -- 433. 自尊心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '自尊心', 'じそんしん', '자존심', '自(스스로 자)
尊(높을 존): 酉+寸 → 술을 받들어 높임', '명사', 433, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自尊心を傷つけられた。', '자존심이 상했다.', 1),
    (w, '自尊心を守りたかった。', '자존심을 지키고 싶었다.', 2);

  -- 434. 戸惑う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '戸惑う', 'とまどう', '당황하다', '戸(집 호)
惑(미혹할 혹): 惑+心 → 일이·마음을 잊음', '동사', 434, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問に戸惑った。', '질문에 당황했다.', 1),
    (w, '状況に戸惑うばかりだ。', '상황에 당황할 뿐이다.', 2);

  -- 435. 端的に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '端的に', 'たんてきに', '단적으로, 명백하게', '端(끝 단): 立+屯 → 끝에 서 있음', '부사', 435, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '端的に言うと反対だ。', '단적으로 말하면 반대다.', 1),
    (w, '端的に評明した。', '명백하게 설명했다.', 2);

  -- 436. 詫びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '詫びる', 'わびる', '사과하다', '詫(사과할 타): 言+于 → 사과·명부', '동사', 436, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れて詫びた。', '늦어서 사과했다.', 1),
    (w, '詫びてしまう評だ。', '사과하고 마는 성격이다.', 2);

  -- 437. うすうす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'うすうす', '희미하게, 어렌풋이', NULL, '부사', 437, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'うすうす勘づいていた。', '어렌풋이 눈치채고 있었다.', 1),
    (w, '本当だとうすうす思っていた。', '사실이라고 희미하게 생각하고 있었다.', 2);

  -- 438. 照会する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '照会する', 'しょうかいする', '조회하다, 문의하다', '照(비칠 조): 昭+火
会(모일 회)', '동사', 438, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '銀行で残高を照会した。', '은행에서 잔고를 조회했다.', 1),
    (w, '務品の絍付を照会する。', '상품의 납품을 문의한다.', 2);

  -- 439. 難点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '難点', 'なんてん', '난점', '難(어려울 난)
点(점 점)', '명사', 439, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この計画の難点を評べる。', '이 계획의 난점을 따진다.', 1),
    (w, '難点を克服したい。', '난점을 극복하고 싶다.', 2);

  -- 440. 入念に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '入念に', 'にゅうねんに', '정성스레', '入(들 입)
念(생각할 념)', '부사', 440, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入念にチェックする。', '정성스레 체크한다.', 1),
    (w, '入念に仕上げた。', '정성스래 마무리했다.', 2);

  -- 441. 粘り強く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '粘り強く', 'ねばりづよく', '끈기있게', '粘(찰긴 점)
強(강할 강)', '부사', 441, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '粘り強く交渉した。', '끈질기게 협상했다.', 1),
    (w, '粘り強く取り組む。', '끈기있게 임했다.', 2);

  -- 442. むっとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'むっとする', '못마때하다, 화난 얼굴을 하다', NULL, '동사', 442, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一言でむっとした。', '한마디에 화다 얼굴을 했다.', 1),
    (w, 'むっとした表情を見せた。', '화난 표정을 지었다.', 2);

  -- 443. 決意
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '決意', 'けつい', '결의', '決(결정 결): 氵+夬
意(뜻 의)', '명사', 443, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '固い決意を誘めた。', '굳은 결의를 입어주어너.', 1),
    (w, '決意を社社した。', '결의를 풌회했다.', 2);

  -- 444. ゆとり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ゆとり', '여유, 여유로움', NULL, '명사', 444, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間にゆとりがある。', '시간에 여유가 있다.', 1),
    (w, '心にゆとりを持つ。', '마음에 여유를 가진다.', 2);

  -- 445. 若干
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '若干', 'じゃっかん', '약간', '若(같을 약): 艸+右
干(방패 간)', '부사', 445, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若干価格が上がった。', '약간 가격이 올랐다.', 1),
    (w, '若干名の不足だ。', '약간명 부족하다.', 2);

  -- 446. 撤回
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '撤回', 'てっかい', '철회', '撤(거둘 철)
回(돌이킬 회)', '명사', 446, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '発言を撤回する。', '발언을 철회한다.', 1),
    (w, '計画を撤回した。', '계획을 철회했다.', 2);

  -- 447. 競い合う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '競い合う', 'きそいあう', '서로 다투다', '競(다투 경): 立+兄 → 서서·형제
合(합할 합)', '동사', 447, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両社がシェアを競い合う。', '양사가 점유율을 다툠다.', 1),
    (w, '選手同士が競い合う。', '선수끼리 다투다.', 2);

  -- 448. かたくなな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かたくなな', '완고한, 고집스러운', NULL, 'な형용사', 448, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かたくな態度を取る。', '완고한 태도를 취한다.', 1),
    (w, 'かたくなに拒む。', '완강하게 거부한다.', 2);

  -- 449. すみやかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'すみやかに', '신속히, 재빨리', NULL, '부사', 449, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すみやかに対応した。', '신속히 대응했다.', 1),
    (w, 'すみやかに報告するように。', '신속히 보고해라.', 2);

  -- 450. ぼんやり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ぼんやり', '멍하다, 흔릿하다', NULL, '부사', 450, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぼんやり考えていた。', '멍하게 생각하고 있었다.', 1),
    (w, 'ぼんやりした記憶だ。', '흔릿한 기억이다.', 2);

  -- 451. 妨害する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '妨害する', 'ぼうがいする', '방해하다', '妨(방해 방): 女+方 → 여자 주변이 소란
害(해할 해): 宀+丰+口', '동사', 451, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作業を妨害する。', '작업을 방해한다.', 1),
    (w, '交通を妨害した。', '교통을 방해했다.', 2);

  -- 452. エレガントな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'エレガントな', 'えれがんとな', '우아한, 고상한', NULL, 'な형용사', 452, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'エレガントなドレスだ。', '우아한 드레스다.', 1),
    (w, 'エレガントに振る舞う。', '고상하게 행동한다.', 2);

  -- 453. つかの間の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'つかの間の', 'つかのまの', '잠시의, 순간적인', NULL, '연체·수식어', 453, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つかの間の休息だった。', '잠시의 휴식이었다.', 1),
    (w, 'つかの間の幸せだ。', '잠시의 행복이다.', 2);

  -- 454. しくじる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しくじる', '실수하다', NULL, '동사', 454, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画をしくじった。', '계획에서 실수했다.', 1),
    (w, '試験をしくじった。', '시험을 실수했다.', 2);

  -- 455. スライスする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スライスする', 'すらいすする', '주점어서 자르다', NULL, '동사', 455, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'パンをスライスする。', '빵을 주점어서 자른다.', 1),
    (w, '肉を薄くスライスする。', '고기를 얇게 자른다.', 2);

  -- 456. めいめいに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'めいめいに', '각자, 각자가', NULL, '부사', 456, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めいめいに買う。', '각자 산다.', 1),
    (w, 'めいめいに帰る。', '각자 집에 간다.', 2);

  -- 457. 手立て
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手立て', 'てだて', '방책, 수단', '手(손 수)
立(설 립)', '명사', 457, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他に手立てがない。', '다른 방책이 없다.', 1),
    (w, '手立てを考える。', '방책을 고민한다.', 2);

  -- 458. ありありと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ありありと', '서서히, 생생히', NULL, '부사', 458, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありありと思い出す。', '생생히 떠올린다.', 1),
    (w, '当時の光景がありありと見える。', '당시의 장면이 생생하게 보인다.', 2);

  -- 459. 返事をしぶる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '返事をしぶる', 'へんじをしぶる', '대답을 꾸물거리다', NULL, '동사', 459, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '返事をしぶり始めた。', '대답을 꾸물거리기 시작했다.', 1),
    (w, '何もしぶり、返事をしてくれない。', '꾸물거리며 대답해 주지 않는다.', 2);

  -- 460. コンパクトな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'コンパクトな', 'こんぱくとな', '컴팩트한, 소형의', NULL, 'な형용사', 460, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンパクトな車が人気だ。', '소형 차가 인기있다.', 1),
    (w, 'コンパクトに收まるサイズだ。', '컴팩트하게 들어가는 사이즈다.', 2);

  -- 461. つぶやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'つぶやく', '중얼거리다, 혼잣말하다', NULL, '동사', 461, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不満をつぶやく。', '불만을 중얼거린다.', 1),
    (w, 'ひとりごとをつぶやく。', '혼자말을 중얼거린다.', 2);

  -- 462. 不審な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不審な', 'ふしんな', '수상한', '不: 아닌
審(살펼 심)', 'な형용사', 462, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不審な人物を見かけた。', '수상한 인물을 보았다.', 1),
    (w, '不審な車が騻車している。', '수상한 차가 주차되어 있다.', 2);

  -- 463. ばてる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ばてる', '지치다', NULL, '동사', 463, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間の助長でばてた。', '장시간의 조장으로 지쳐 있다.', 1),
    (w, '暑さにばてる。', '더위에 지쳐있다.', 2);

  -- 464. まっとうする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'まっとうする', '완수하다, 끝내다', NULL, '동사', 464, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '任務をまっとうした。', '임무를 완수했다.', 1),
    (w, '人生をまっとうする。', '인생을 완수한다.', 2);

  -- 465. 異例の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '異例の', 'いれいの', '이례적인', '異(다를 이)
例(법식 례)', '연체·수식어', 465, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '異例の抹擢がとられた。', '이례적인 발취가 이루어졌다.', 1),
    (w, '異例のスピードだ。', '이례적인 스피드다.', 2);

  -- 466. 熱中する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '熱中する', 'ねっちゅうする', '열중하다', '熱(더울 열): 势+火
中(가운데 중)', '동사', 466, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ゲームに熱中している。', '게임에 열중하고 있다.', 1),
    (w, '勉強に熱中する。', '공부에 열중한다.', 2);

  -- 467. つぶさに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'つぶさに', '소상히, 자세히', NULL, '부사', 467, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件をつぶさに説明する。', '사건을 소상히 설명한다.', 1),
    (w, 'つぶさに検討する。', '자세히 검토한다.', 2);

  -- 468. 脈絡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '脈絡', 'みゃくらく', '맥락', '脈(줄기 맥)
絡(얽을 락)', '명사', 468, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話の脈絡がわからない。', '이야기의 맥락을 모르겠다.', 1),
    (w, '事件の脈絡を読み取る。', '사건의 맥락을 읽는다.', 2);

  -- 469. 吟味
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '吟味', 'ぎんみ', '음미, 숨은 뜻을 뜨어분', '吟(읊을 음): 口+今
味(맛 미)', '명사', 469, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '考えを吟味する。', '생각을 음미한다.', 1),
    (w, '作品の出改を吟味する。', '작품의 맛을 음미한다.', 2);

  -- 470. エキスパート
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'エキスパート', 'えきすぱーと', '전문가, 익스퍼트', NULL, '명사', 470, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その分野のエキスパートだ。', '그 분야의 전문가다.', 1),
    (w, 'エキスパートに相談する。', '전문가에게 상담한다.', 2);

  -- 471. 凝視する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '凝視する', 'ぎょうしする', '응시하다', '凝(엉길 응): 冰+疑
視(볼 시): 示+見', '동사', 471, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '画面を凝視した。', '화면을 응시했다.', 1),
    (w, '中空を凝視する。', '허공을 응시한다.', 2);

  -- 472. 架空
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '架空', 'かくう', '가공', '架(시렁 가): 加+木
空(빌 공)', '명사', 472, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '架空の人物だ。', '가공의 인물이다.', 1),
    (w, '架空の世界を描く。', '가공의 세계를 그린다.', 2);

  -- 473. ぼやく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ぼやく', '투델대다, 투렕거리다', NULL, '동사', 473, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不遇をぼやく。', '불운을 투델대다.', 1),
    (w, '上司にぼやくりしている。', '상사에 대해 투델거리고 있다.', 2);

  -- 474. 寡黙な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '寡黙な', 'かもくな', '과묵한, 말수가 적은', '寡(적을 과): 宀+頃 → 집안이 조용
黙(잠잠할 묵)', 'な형용사', 474, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寡黙な人だ。', '과묵한 사람이다.', 1),
    (w, '寡黙に作業している。', '말없이 작업하고 있다.', 2);

  -- 475. 紛糾する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '紛糾する', 'ふんきゅうする', '분규하다, 혼란해지다', '紛(어지러울 분): 糸+分
糾(어지러울 규): 糸+丩', '동사', 475, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '議論が紛糾した。', '논의가 분규했다.', 1),
    (w, '交渉が紛糾した。', '협상이 혼란해졌다.', 2);

  -- 476. ずれ込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ずれ込む', 'ずれこむ', '지연되다, 늦어지다', 'ずれ: 어긋남
込む: 안으로 들어가다', '동사', 476, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議が夜にずれ込ほだ。', '회의가 밤까지 이어질 것 같다.', 1),
    (w, '出荷が一週間ずれ込んだ。', '출하가 일주일 늦어졌다.', 2);

  -- 477. ろくに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ろくに', '제대로, 충분히', NULL, '부사', 477, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ろくに休めない。', '제대로 쉬지 못한다.', 1),
    (w, 'ろくに読まずに提出した。', '제대로 읽지도 않고 제출했다.', 2);

  -- 479. 絶賛する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '絶賛する', 'ぜっさんする', '극찬하다', '絶(끊을 절)
賛(기릴 찬)', '동사', 479, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を絶賛した。', '작품을 극찬했다.', 1),
    (w, '評論家が絶賛した。', '평론가가 극찬했다.', 2);

  -- 480. くつろぐ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'くつろぐ', '편안하게 쉬다', NULL, '동사', 480, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家でくつろぐ。', '집에서 편안하게 쉬다.', 1),
    (w, 'そファでくつろいでいる。', '소파에서 느궼히 쉬고 있다.', 2);

  -- 481. うやむやに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'うやむやに', '흐지부지하게, 애매하게', NULL, '부사', 481, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話をうやむやにせずに許した。', '이야기를 흐지부지하지 않고 뚠렷이 말했다.', 1),
    (w, 'うやむやにした返事だ。', '애매한 대답이다.', 2);

  -- 482. 出馬
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '出馬', 'しゅつば', '출마', '出(나올 출)
馬(말 마)', '명사', 482, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '選挙に出馬する。', '선거에 출마한다.', 1),
    (w, '出馬を表明した。', '출마를 표명했다.', 2);

  -- 483. 閉口する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '閉口する', 'へいこうする', '당황함, 질린', '閉(닫을 폐): 門+才 → 문을 닫음
口(입 구)', '동사', 483, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あまりの話袖さに閉口した。', '너무 말이 많아 질렸다.', 1),
    (w, '暑さに閉口した。', '더위에 질렸다.', 2);

  -- 484. 気ままな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '気ままな', 'きままな', '제멋대로의, 자유로운', '気(기운 기)
まま: 그대로', 'な형용사', 484, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気ままな生活を送る。', '제멋대로 생활한다.', 1),
    (w, '気ままに振る舞う。', '제멋대로 행동한다.', 2);

  -- 485. 調達する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '調達する', 'ちょうたつする', '조달하다', '調(고를 조): 言+周
達(통달할 달)', '동사', 485, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資金を調達する。', '자금을 조달한다.', 1),
    (w, '原材料を調達した。', '원재료를 조달했다.', 2);

  -- 486. 温和な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '温和な', 'おんわな', '온화한, 온한한', '温(따뜻할 온): 氵+固+皿
和(화할 화)', 'な형용사', 486, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '温和な人柄だ。', '온화한 인품이다.', 1),
    (w, '温和な気候の地域だ。', '온화한 기후의 지역이다.', 2);

  -- 487. スポット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スポット', 'すぽっと', '장소, 명소', NULL, '명사', 487, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人気スポットを訪れる。', '인기 명소를 방문한다.', 1),
    (w, '見るスポットが多い。', '볼 곳이 많다.', 2);

  -- 488. 拮抗する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '拮抗する', 'きっこうする', '팔팔하다, 우섬갌쟥이다', '拮(해봉할 깅): 手+吉
抗(결를 항): 手+亢', '동사', 488, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '両チームは拮抗している。', '두 팀은 우섬가리었다.', 1),
    (w, '互いに拮抗する勢い。', '서로 팔팔한 기세다.', 2);

  -- 489. 風当たり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '風当たり', 'かぜあたり', '세상의 비판', '風(바람 풍)
当(마끜할 당)', '명사', 489, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身に風当たりを感じる。', '세상의 비판을 웹으로 감다.', 1),
    (w, '会社への風当たりが強い。', '회사에 대한 비판이 강하다.', 2);

  -- 490. あどけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'あどけない', '천진난만하다', NULL, 'い형용사', 490, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あどけない顔だ。', '천진난만한 얼굴이다.', 1),
    (w, 'あどけない笑顔を見せる。', '천진난만한 미소를 짓는다.', 2);

  -- 491. 懸念する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '懸念する', 'けねんする', '우려하다', '懸(매달 현): 縣+心
念(생각할 념)', '동사', 491, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '女裝体を懸念している。', '안전을 우려하고 있다.', 1),
    (w, '事件の影響が懸念される。', '사건의 영향이 우려된다.', 2);

  -- 492. やつれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'やつれる', '초첨해지다', NULL, '동사', 492, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '病でやつれた。', '병으로 손죽은 모습이 되었다.', 1),
    (w, '心労でやつれる。', '심적으로 고생해 초첨해진다.', 2);

  -- 493. 奮闘する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '奮闘する', 'ふんとうする', '분투하다', '奮(떨칠 분): 大+隹+田
闘(싸울 투)', '동사', 493, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事で奮闘している。', '일에 분투하고 있다.', 1),
    (w, '遺された人代で奮闘する。', '적은 인원으로 분투한다.', 2);

  -- 494. 不慮の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不慮の', 'ふりょの', '불의의, 이원치 않은', '不: 아닌
慮(생각할 려)', '연체·수식어', 494, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不慮の事故に遭った。', '불의의 사고를 당했다.', 1),
    (w, '不慮の事態に備える。', '불의의 사태에 대비한다.', 2);

  -- 495. 根こそぎ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '根こそぎ', 'ねこそぎ', '뿌리채, 하나도 남김없이', '根(뿌리 근)
そぎ: 근원', '부사', 495, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財産を根こそぎ取られた。', '재산을 올딩이 임셜다.', 1),
    (w, '記憶を根こそぎ失う。', '기억을 완전히 잃어버린다.', 2);

  -- 496. 没頭する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '没頭する', 'ぼっとうする', '몰두하다', '没(빠질 몰): 氵+沒
頭(머리 두)', '동사', 496, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読書に没頭する。', '독서에 몰두한다.', 1),
    (w, '研究に没頭している。', '연구에 몰두하고 있다.', 2);

  -- 497. 尺度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '尺度', 'しゃくど', '척도, 기준', '尺(자 척): 尸+丶 → 잣대
度(헤아릴 도)', '명사', 497, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '評価の尺度が違う。', '평가의 기준이 다르다.', 1),
    (w, '適切な尺度が必要だ。', '적절한 척도가 필요하다.', 2);

  -- 498. 辛抱する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '辛抱する', 'しんぼうする', '인내하다, 참다', '辛(매울 신)
抱(안을 포): 手+包', '동사', 498, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぜひ一個辛抱して下さい。', '조금만 참아 주세요.', 1),
    (w, '辛抱それず言ってしまった。', '참지 못하고 말해버렸다.', 2);

  -- 499. しきたり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しきたり', '관습, 관례', NULL, '명사', 499, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古いしきたりを守る。', '오래된 관려를 지킨다.', 1),
    (w, 'しきたりに従う。', '관습에 따른다.', 2);

  -- 500. 委託する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '委託する', 'いたくする', '위탁하다', '委(맡길 위): 禾+女
託(맡길 탁)', '동사', 500, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仁事を委託する。', '일을 위탁한다.', 1),
    (w, '外部に委託した。', '외부에 위탁했다.', 2);

  -- 501. 爽やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '爽やかな', 'さわやかな', '상쿾한, 시원한', '爽(시원할 상)', 'な형용사', 501, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '爽やかな朝だ。', '상쿾한 아침이다.', 1),
    (w, '爽やかな笑顔を見せる。', '상쿾한 미소를 짓는다.', 2);

  -- 502. 工面する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '工面する', 'くめんする', '돈을 마련하다', '工(장인 공)
面(냭 면)', '동사', 502, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資金を工面した。', '자금을 마련했다.', 1),
    (w, '生活費を工面する。', '생활비를 조달한다.', 2);

  -- 503. ぞんざいな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ぞんざいな', '헙량한, 조잡한', NULL, 'な형용사', 503, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぞんざいな言い方をする。', '헙량한 말투를 쓴다.', 1),
    (w, 'ぞんざいに取り扱う。', '조잡하게 다룬다.', 2);

  -- 504. うなだれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'うなだれる', '고개를 숙이다', NULL, '동사', 504, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '叱られてうなたれた。', '꾾짓어서 고개를 숙였다.', 1),
    (w, 'うなだれて謝った。', '고개를 숙이고 사과했다.', 2);

  -- 505. 打撃
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '打撃', 'だげき', '타격', '打(칠 타)
撃(칠 격)', '명사', 505, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '深刻な打撃を受けた。', '심각한 타격을 받았다.', 1),
    (w, '経済に打撃を与えた。', '경제에 타격을 주었다.', 2);

  -- 506. 手腕
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手腕', 'しゅわん', '수완, 수완을 발휘', '手(손 수)
腕(팔 완)', '명사', 506, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画に手腕を発揮する。', '계획에 수완을 발휘한다.', 1),
    (w, '手腕を認められた。', '수완을 인정받았다.', 2);

  -- 507. ロスする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ロスする', 'ろすする', '손실, 손실하다', NULL, '동사', 507, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間をロスしてしまった。', '시간을 손실해버렸다.', 1),
    (w, '資源をロスしたくない。', '자원을 낭비하고 싶지 않다.', 2);

  -- 508. おろそかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'おろそかに', '소홀히, 소홀하게', NULL, '부사', 508, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強をおろそかにしてはいけない。', '공부를 소홀히 해서는 안 된다.', 1),
    (w, '仕事をおろそかにした。', '일을 소홀히 했다.', 2);

  -- 509. 目下
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '目下', 'もっか', '목하, 바로 지금', '目(눈 목)
下(아래 하)', '명사', 509, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目下調査中だ。', '목하 조사 중이다.', 1),
    (w, '目下の課題は何か。', '별단 병곥°〉을 해접 별°〉°〉.', 2);

  -- 510. 請け負う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '請け負う', 'うけおう', '적쟅해 맡다', '請(청할 청): 言+青
負(짐을 부)', '동사', 510, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工事を請け負う。', '공사를 도급받는다.', 1),
    (w, '谟品を請け負った。', '부품을 도급받았다.', 2);

  -- 511. 進呈する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '進呈する', 'しんていする', '증정하다', '進(나아갈 진)
呈(드릴 정): 口+壬', '동사', 511, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記念品を進呈した。', '기념품을 증정했다.', 1),
    (w, 'サンプルを進呈する。', '샘플을 증정한다.', 2);

  -- 512. 意地
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '意地', 'いじ', '고집, 장대', '意(뜻 의)
地(땅 지)', '명사', 512, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意地を張る。', '고집을 부린다.', 1),
    (w, '意地悪だ。', '심술이 부린다.', 2);

  -- 513. 細心
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '細心', 'さいしん', '세심, 매우 세심함', '細(가늘 세)
心(마음 심)', '명사', 513, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '細心の注意を払う。', '세심한 주의를 쓴다.', 1),
    (w, '細心に計画を立てる。', '세심하게 계획을 세운다.', 2);

  -- 514. 賑わう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '賑わう', 'にぎわう', '붐비다, 번창하다', '賑(쇭소할 짐): 起+中', '동사', 514, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '装靴が賑わう。', '거리가 붐비고 있다.', 1),
    (w, 'イベントで賑わう会場。', '이벤트로 붐비는 행사장.', 2);

  -- 515. ひとまず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ひとまず', '일단, 우선', NULL, '부사', 515, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひとまず休憩しよう。', '일단 쉬자.', 1),
    (w, 'ひとまず完成した。', '일단 완성했다.', 2);

  -- 516. 発足
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '発足', 'ほっそく', '발족, 출발', '発(펼 발)
足(발 족)', '명사', 516, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいチームが発足した。', '새로운 팀이 발족했다.', 1),
    (w, '会社の発足を祝う。', '회사의 발족을 축하한다.', 2);

  -- 517. 満嗫する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '満嗫する', 'まんきつする', '만끈하다', '満(차을 만): 氵+兩
嗫(언어술·딹콩 낙·낙)', '동사', 517, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休暇を満嗫した。', '휴가를 만끈했다.', 1),
    (w, '潜日を満嗫した一日だった。', '온종일 만낌한 하루였다.', 2);

  -- 518. 見落とす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見落とす', 'みおとす', '놓치다, 간과하다', '見(볼 견)
落(떨어질 락)', '동사', 518, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な点を見落とした。', '중요한 점을 놓쳤다.', 1),
    (w, '細部を見落とさないように。', '세부를 놓치지 않도록.', 2);

  -- 519. 密集
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '密集', 'みっしゅう', '밀집', '密(비밀 밀)
集(모일 집)', '명사', 519, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '住宅が密集している。', '주택이 밀집해 있다.', 1),
    (w, '密集地帯を避ける。', '밀집 지역을 피한다.', 2);

  -- 520. 質素な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '質素な', 'しっそな', '검소한, 소박한', '質(바탕 질): 斞+貝
素(흡 소)', 'な형용사', 520, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質素な生活を送る。', '검소한 생활을 한다.', 1),
    (w, '質素な服装だ。', '소박한 옷차림이다.', 2);

  -- 521. とっくに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'とっくに', '이미 오래 전에', NULL, '부사', 521, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とっくに終わった。', '이미 오래 전에 끝났다.', 1),
    (w, 'とっくに知っていた。', '벌써 알고 있었다.', 2);

  -- 522. 配布
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '配布', 'はいふ', '배포', '配(나눌 배)
布(직물 포)', '명사', 522, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チラシを配布する。', '전단지를 배포한다.', 1),
    (w, '資料が配布された。', '자료가 배포되었다.', 2);

  -- 523. 赴任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '赴任', 'ふにん', '부임', '赴(달려갈 부)
任(맡길 임)', '명사', 523, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都に赴任した。', '교토로 부임했다.', 1),
    (w, '仕事で魔ージャージット中だ。', '제명±ªebØ 이Ø이 총±ªe 제명ÎØ 제명.', 2);

  -- 524. 不服
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不服', 'ふふく', '불복', '不: 아닌
服(옷 복·복종 복)', '명사', 524, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判決に不服を申し立てる。', '판결에 불복을 신청한다.', 1),
    (w, '不服そうな顔だ。', '불만스러운 얼굴이다.', 2);

  -- 525. ほどける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ほどける', '풌리다', NULL, '동사', 525, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴のひもがほどけた。', '신발끈이 풀렸다.', 1),
    (w, 'パッケージがほどけた。', '포장이 풌렸다.', 2);

  -- 526. 見失う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見失う', 'みうしなう', '놓치다, 시야에서 놓치다', '見(볼 견)
失(잃을 실)', '동사', 526, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '造を見失った。', '길을 잃었다.', 1),
    (w, '目標を見失う。', '목표를 놓친다.', 2);

  -- 527. 目覚ましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '目覚ましい', 'めざましい', '눈부셔 있다', '目(눈 목)
覚(깨달을 각)', 'い형용사', 527, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目覚ましい發展をとげた。', '눈부신 발전을 이룩했다.', 1),
    (w, '目覚ましい成長だ。', '눈부신 성장이다.', 2);

  -- 528. 連携
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '連携', 'れんけい', '연대, 협력', '連(연이을 련)
携(가질 휴)', '명사', 528, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他社と連携した。', '다른 회사와 연대했다.', 1),
    (w, '連携プレーを試みる。', '협력 플레이를 시도한다.', 2);

  -- 529. 広大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '広大な', 'こうだいな', '광대한', '広(넓을 광)
大(클 대)', 'な형용사', 529, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '広大なような土地。', '광대한 토지.', 1),
    (w, '広大な面積を口める。', '광대한 면적을 차지한다.', 2);

  -- 530. 仕業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仕業', 'しわざ', '소젝, 짓', '仕(벼슸 사)
業(업 업)', '명사', 530, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誤の仕業だろう。', '적의 소젝일 것이다.', 1),
    (w, '何者の仕業か。', '누구의 짓인가.', 2);

  -- 531. 総じて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '総じて', 'そうじて', '대체로, 전반적으로', '総(다 총): 糸+悤', '부사', 531, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '総じて言うと成功だ。', '전반적으로 말하자면 성공이다.', 1),
    (w, '総じて評価が高い。', '대체로 평가가 높다.', 2);

  -- 532. 秘める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '秘める', 'ひめる', '숨기다', '秘(숨길 비): 禾+必', '동사', 532, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原めた思いを秘める。', '숨긴 생각을 숨긴다.', 1),
    (w, '可能性を秘めている。', '가능성을 숨기고 있다.', 2);

  -- 533. ブランク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ブランク', 'ぶらんく', '공백, 브랙', NULL, '명사', 533, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '五年のブランクがある。', '5년의 공백이 있다.', 1),
    (w, 'ブランクを埋める。', '공백을 메운다.', 2);

  -- 534. 見込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見込み', 'みこみ', '전망, 가능성', '見(볼 견)
込む: 안으로 들어가다', '명사', 534, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '希望の見込みがある。', '희망의 가능성이 있다.', 1),
    (w, '豊作の見込みだ。', '풍작의 전망이다.', 2);

  -- 535. 無造作に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '無造作に', 'むぞうさに', '무조건 하게, 대수롭게', '無: 없음
造作: 조작', '부사', 535, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無造作に骪を結ぶ。', '대수롭게 머리를 묶는다.', 1),
    (w, '無造作に並べた。', '대수롭게 늘어놓았다.', 2);

  -- 536. 免除
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '免除', 'めんじょ', '면제', '免(면할 면)
除(덜 제)', '명사', 536, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '授業料の免除を受ける。', '수업료 면제를 받는다.', 1),
    (w, '責任を免除された。', '책임에서 면제되었다.', 2);

  -- 537. 有数
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '有数', 'ゆうすう', '굴지', '有(있을 유)
数(셈 수)', '명사', 537, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界有数の企業だ。', '세계 굴지의 기업이다.', 1),
    (w, '国内有数の誠者だ。', '국내 굴지의 학자다.', 2);

  -- 538. 当てはめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '当てはめる', 'あてはめる', '적용하다, 대입하다', '当(마끜할 당)
はめる: 끜운다', '동사', 538, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '公式に当てはめる。', '공식에 대입한다.', 1),
    (w, '人生に当てはめて考える。', '인생에 적용해 생각한다.', 2);

  -- 539. 円滑だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '円滑だ', 'えんかつだ', '원활하다, 순조롭다', '円(둥근 원)
滑(미끄러울 활)', 'な형용사', 539, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が円滑に進む。', '계획이 순조롭게 진행된다.', 1),
    (w, '円滑に交渉が進む。', '원활하게 협상이 이루어진다.', 2);

  -- 540. 合致
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '合致', 'がっち', '합치, 일치', '合(합할 합)
致(이를 치)', '명사', 540, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '意見が合致した。', '의견이 일치했다.', 1),
    (w, '証言が合致している。', '증언이 일치하고 있다.', 2);

  -- 541. かばう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かばう', '감싸다, 보호하다', NULL, '동사', 541, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部下をかばう。', '부하를 감싸준다.', 1),
    (w, '身をかばう。', '몸을 보호한다.', 2);

  -- 542. 加味する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '加味する', 'かみする', '가미하다', '加(더할 가)
味(맛 미)', '동사', 542, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断に原件を加味する。', '판단에 조건을 가미한다.', 1),
    (w, '年齢を加味して評価する。', '나이를 가미하여 평가한다.', 2);

  -- 543. 口出し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '口出し', 'くちだし', '참견, 간섭', '口(입 구)
出(나올 출)', '명사', 543, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人のビジネスに口出ししない。', '옥주에 속하는 일에 간섭하지 않는다.', 1),
    (w, '口出しされるのを叫う。', '간섭당하는 것을 싫어한다.', 2);

  -- 544. 気配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '気配', 'けはい', '기첤, 냄새', '気(기운 기)
配(나눌 배)', '명사', 544, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人の気配がした。', '사람의 기첤이 느껴졌다.', 1),
    (w, '春の気配がした。', '봄의 기운이 느껴졌다.', 2);

  -- 545. 処置
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '処置', 'しょち', '처치', '処(곳 처)
置(둘 치)', '명사', 545, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応急処置を施す。', '응급처치를 한다.', 1),
    (w, '適切な処置が必要だ。', '적절한 조치가 필요하다.', 2);

  -- 546. 打開する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '打開する', 'だかいする', '타개하다', '打(칠 타)
開(열 개)', '동사', 546, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況を打開する。', '상황을 타개한다.', 1),
    (w, '難局を打開した。', '난국을 타개했다.', 2);

  -- 547. 煩雑な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '煩雑な', 'はんざつな', '번잡한, 복잡한', '煩(불달을 번): 火+頁
雑(섮일 잡)', 'な형용사', 547, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手続きが煩雑だ。', '절차가 복잡하다.', 1),
    (w, '煩雑な計算をした。', '번잡한 계산을 했다.', 2);

  -- 548. 拍子
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '拍子', 'ひょうし', '박자, 순간, 계기', '拍(칠 박)
子(아들 자)', '명사', 548, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '拍子をとる。', '박자를 맞춰 친다.', 1),
    (w, '踊る拍子に足を挫いた。', '춤추는 도중에 발을 점질렆다.', 2);

  -- 549. 優位
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '優位', 'ゆうい', '우위', '優(넘칠 우): 亻+冶
位(자리 위)', '명사', 549, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '優位に立つ。', '우위에 서다.', 1),
    (w, '優位に交渉を進める。', '우위에 협상을 진행한다.', 2);

  -- 550. 一律に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '一律に', 'いちりつに', '일율적으로', '一(한 일)
律(법 률)', '부사', 550, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一律に価格を上げた。', '일율적으로 가격을 올렸다.', 1),
    (w, '一律の対応は難しい。', '일율적인 대응은 어렵다.', 2);

  -- 551. 裏腹
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '裏腹', 'うらはら', '정반대', '裏(속 리)
腹(배 복)', '명사', 551, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言葉と裏腹の態度だ。', '말과 정반대의 태도다.', 1),
    (w, '本心と裏腹だ。', '본심과 정반대다.', 2);

  -- 552. 抱え込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '抱え込む', 'かかえこむ', '안고 파묻히다', '抱(안을 포)
込む: 안으로 들어가다', '동사', 552, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題を一人で抱え込む。', '문제를 혼자 안고있다.', 1),
    (w, '仕事を抱え込んでしまう。', '일을 혼자 끜안고 말았다.', 2);

  -- 553. 心構え
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '心構え', 'こころがまえ', '마음가짐', '心(마음 심)
構(얽을 구)', '명사', 553, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心構えができている。', '마음의 준비가 되어 있다.', 1),
    (w, '心構えを説く。', '마음가짐을 설한다.', 2);

  -- 554. しがみつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しがみつく', '매달리다', NULL, '동사', 554, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身を守ろうとしがみつく。', '몸을 지키려고 매달린다.', 1),
    (w, '仕事にしがみつく。', '일에 매달린다.', 2);

  -- 555. 損なう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '損なう', 'そこなう', '해치다, 손상시키다', '損(덜 손): 手+員', '동사', 555, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康を損なう。', '건강을 해친다.', 1),
    (w, '会社の利益を損なう。', '회사의 이익을 손상시킨다.', 2);

  -- 556. 耐えがたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '耐えがたい', 'たえがたい', '견디기 힘들다', '耐(견딜 내)', 'い형용사', 556, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '痛みが耐えがたい。', '고통을 견디기 힘들다.', 1),
    (w, 'ちも体わしさに耐えがたい。', '그리움을 견디기 힘들다.', 2);

  -- 557. 携わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '携わる', 'たずさわる', '종사하다', '携(가질 휴)', '동사', 557, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医療に携わる。', '의료에 종사한다.', 1),
    (w, '計画に携わってきた。', '계획에 관여해 왔다.', 2);

  -- 558. 剝がす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '剝がす', 'はがす', '벗기다', '剝(벼길 박)', '동사', 558, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ポスターを剝がす。', '포스터를 떼어낸다.', 1),
    (w, 'シールを剝がす。', '스티커를 떼어낸다.', 2);

  -- 559. 人一倍
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '人一倍', 'ひといちばい', '남보다 두 배, 유니종 곧', '人(사람 인)
倍(짓 배)', '부사', 559, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人一倍努力した。', '남보다 두 배 노력했다.', 1),
    (w, '人一倍奌める。', '남보다 더 일한다.', 2);

  -- 560. 復旧
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '復旧', 'ふっきゅう', '복구', '復(회복할 복)
旧(옥 구)', '명사', 560, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気が復旧した。', '전기가 복구되었다.', 1),
    (w, '道路の復旧作業が進む。', '도로 복구 작업이 진행되고 있다.', 2);

  -- 561. 安静
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '安静', 'あんせい', '안정', '安(편안할 안)
静(고요할 정)', '명사', 561, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安静を保つ。', '안정을 유지한다.', 1),
    (w, '安静状態で休む。', '안정 상태로 쉬다.', 2);

  -- 562. 今更
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '今更', 'いまさら', '이제 와서', '今(이제 금)
更(다시 갱)', '부사', 562, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今更謝っても遅い。', '이제 와서 사과해도 늦었다.', 1),
    (w, '今更始めるのも難しい。', '이제 와서 시작하기에도 어렵다.', 2);

  -- 563. 帯びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '帯びる', 'おびる', '띄다, 퍼머금어 있다', '帯(띄 대)', '동사', 563, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '使命を帯びる。', '사명을 띄고 있다.', 1),
    (w, '重大な意味を帯びる。', '중대한 의미를 띄다.', 2);

  -- 564. 思い詰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '思い詰める', 'おもいつめる', '생각에 골뚤하다', '思(생각 사)
詰(막을 휗)', '동사', 564, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひとりで思い詰めた。', '혼자서 생각에 골두했다.', 1),
    (w, '思い詰めて限界に達した。', '생각에 잔넘어 한계에 달했다.', 2);

  -- 565. 軌道
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軌道', 'きどう', '굤도', '軌(바퀴자국 굤)
道(길 도)', '명사', 565, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が軌道に乗る。', '계획이 굤도에 오른다.', 1),
    (w, '車両が軌道をそれた。', '차량이 굤도를 이탈했다.', 2);

  -- 566. くまなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'くまなく', '구석구석, 빠짐없이', NULL, '부사', 566, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'くまなく探した。', '구석구석 찾아봤다.', 1),
    (w, 'くまなく説明する。', '빠짐없이 설명한다.', 2);

  -- 567. 辞任
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '辞任', 'じにん', '사임', '辞(말씀 사)
任(맡길 임)', '명사', 567, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '辞任を表明した。', '사임을 표명했다.', 1),
    (w, '社長が辞任した。', '사장이 사임했다.', 2);

  -- 568. 統合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '統合', 'とうごう', '통합', '統(거느릴 통)
合(합할 합)', '명사', 568, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二社が統合した。', '두 회사가 통합되었다.', 1),
    (w, 'データを統合する。', '데이터를 통합한다.', 2);

  -- 569. はなはだしい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'はなはだしい', '매우 심하다', NULL, 'い형용사', 569, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被害がはなはだしい。', '피해가 심각하다.', 1),
    (w, 'はなはだしい誤りだ。', '종이 심한 실수다.', 2);

  -- 570. 人手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '人手', 'ひとで', '일손', '人(사람 인)
手(손 수)', '명사', 570, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人手が足りない。', '일손이 부족하다.', 1),
    (w, '人手を雇う。', '일손을 고용한다.', 2);

  -- 571. もはや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もはや', '이제는, 이미', NULL, '부사', 571, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もはや手遅れだ。', '이제 닦은 일이다.', 1),
    (w, 'もはや争う余地はない。', '이제 다투는 어제마다.', 2);

  -- 572. 内訳
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '内訳', 'うちわけ', '내역', '内(안 내)
訳(풀 역)', '명사', 572, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用の内訳を示す。', '비용의 내역을 보인다.', 1),
    (w, '内訳を説明する。', '내역을 설명한다.', 2);

  -- 573. 過密
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '過密', 'かみつ', '과밀, 너무 많이 밀집됨', '過(지날 과)
密(비밀 밀)', '명사', 573, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通の過密状態だ。', '교통이 과밀 상태다.', 1),
    (w, '過密スケジュールだ。', '과밀 일정이다.', 2);

  -- 574. 閑静な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '閑静な', 'かんせいな', '한적한, 고요한', '閑(한가롤 한)
静(고요할 정)', 'な형용사', 574, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '閑静な住宅街だ。', '한적한 주택가다.', 1),
    (w, '閑静な環境を好む。', '고요한 환경을 좋아한다.', 2);

  -- 575. 規制
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '規制', 'きせい', '규제', '規(법 규)
制(제도 제)', '명사', 575, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規制を受ける。', '규제를 받는다.', 1),
    (w, '規制を緩める。', '규제를 완화한다.', 2);

  -- 576. 食い違う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '食い違う', 'くいちがう', '어꺋나다', '食(먹을 식)
違(달리할 위)', '동사', 576, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証言が食い違う。', '증언이 어꺋난다.', 1),
    (w, '計画と現実が食い違う。', '계획과 현실이 어꺋난다.', 2);

  -- 577. 察する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '察する', 'さっする', '헤아리다, 이해해주다', '察(살펼 찰)', '동사', 577, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心情を察する。', '심정을 헤아린다.', 1),
    (w, '状況を察する。', '상황을 헤아린다.', 2);

  -- 578. 退く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '退く', 'しりぞく', '물러나다', '退(물러날 퇴)', '동사', 578, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一歩退く。', '한 걸음 물러난다.', 1),
    (w, '現役を退く。', '현역에서 물러난다.', 2);

  -- 579. 素早い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '素早い', 'すばやい', '재빠르다', '素(흡 소)
早(이를 조)', 'い형용사', 579, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '判断が素早い。', '판단이 재빠르다.', 1),
    (w, '素早い動きを見せる。', '재빠른 움직임을 보인다.', 2);

  -- 580. たやすい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'たやすい', '쉬운', NULL, 'い형용사', 580, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たやすいことではない。', '쉬운 일이 아니다.', 1),
    (w, 'たやすく解決した。', '쉬운게 해결했다.', 2);

  -- 581. 入手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '入手', 'にゅうしゅ', '입수', '入(들 입)
手(손 수)', '명사', 581, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チケットを入手した。', '티켓을 입수했다.', 1),
    (w, '貴重な資料を入手した。', '귀중한 자료를 입수했다.', 2);

  -- 582. 昇進
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '昇進', 'しょうしん', '승진', '昇(오를 승)
進(나아갈 진)', '명사', 582, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケタ、部長に昇進した。', '부장으로 승진했다.', 1),
    (w, '昇進試験を受ける。', '승진 시험을 봉한다.', 2);

  -- 583. 提起
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '提起', 'ていき', '제기', '提(끌 제)
起(일어날 기)', '명사', 583, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画の提起をした。', '계획을 제기했다.', 1),
    (w, '問題を提起する。', '문제를 제기한다.', 2);

  -- 584. 滅びる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '滅びる', 'ほろびる', '멸망하다', '滅(멸할 멸)', '동사', 584, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古代文明が滅びた。', '고대 문명이 멸망했다.', 1),
    (w, '言語が滅びる。', '언어가 사라진다.', 2);

  -- 585. 重複
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '重複', 'じゅうふく', '중복', '重(소중할 중)
複(겹칠 복)', '명사', 585, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記録に重複がある。', '기록에 중복이 있다.', 1),
    (w, '重複を避ける。', '중복을 피한다.', 2);

  -- 586. 拠点
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '拠点', 'きょてん', '거점', '拠(근거 거)
点(점 점)', '명사', 586, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'アジアの拠点を設ける。', '아시아 거점을 설치한다.', 1),
    (w, '拠点を京都に上げる。', '거점을 교토에 둔다.', 2);

  -- 587. 真っ先
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '真っ先', 'まっさき', '제일 먼저', '真(참 진)
先(먼저 선)', '명사', 587, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '真っ先に驅けつけた。', '제일 먼저 달려왔다.', 1),
    (w, '真っ先に帰る。', '제일 먼저 집에 간다.', 2);

  -- 588. 緊密
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '緊密', 'きんみつ', '긴밀, 긴밀하게 연결됨', '緊(긴할 긴)
密(비밀 밀)', '명사', 588, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '緊密な関係を保つ。', '긴밀한 관계를 유지한다.', 1),
    (w, '緊密な連携が必要だ。', '긴밀한 협력이 필요하다.', 2);

  -- 589. 遂げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '遂げる', 'とげる', '이루다, 이결°〉', '遂(드디어 수)', '동사', 589, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '目的を遂げた。', '목적을 이뤄냈다.', 1),
    (w, '骨骪の達成を遂げる。', '큰 성과를 이루어낸다.', 2);

  -- 590. 巧みだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '巧みだ', 'たくみだ', '능숙하다', '巧(재주 교)', 'な형용사', 590, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '巧みな応援だ。', '능숙한 대응이다.', 1),
    (w, '巧みに話を進める。', '능숙하게 이야기를 진행한다.', 2);

  -- 591. 配属
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '配属', 'はいぞく', '배속', '配(나눌 배)
属(붙을 속)', '명사', 591, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人事部に配属された。', '인사부에 배속되었다.', 1),
    (w, '配属先が決まった。', '배속지가 정해졌다.', 2);

  -- 592. 乗り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '乗り出す', 'のりだす', '나서다, 착수하다', '乗(타고올 승)
出(나올 출)', '동사', 592, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '調査に乗り出す。', '조사에 나선다.', 1),
    (w, '交渉に乗り出した。', '협상에 착수했다.', 2);

  -- 593. 面識
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '面識', 'めんしき', '면식, 서로 알고 지냄', '面(냭 면)
識(알 식)', '명사', 593, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面識がある人だ。', '안면이 있는 사람이다.', 1),
    (w, '全く面識がない。', '전혀 면식이 없다.', 2);

  -- 594. 心当たり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '心当たり', 'こころあたり', '집히는 데, 떠오르는 것', '心(마음 심)
当(마끜할 당)', '명사', 594, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心当たりがない。', '집히는 데가 없다.', 1),
    (w, '心当たりを探る。', '단서를 찾는다.', 2);

  -- 595. 作動
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作動', 'さどう', '작동', '作(지을 작)
動(움직일 동)', '명사', 595, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'システムが作動した。', '시스템이 작동했다.', 1),
    (w, '作動不良が起きた。', '작동 불량이 발생했다.', 2);

  -- 596. 備え付ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '備え付ける', 'そなえつける', '설치해 두다', '備(갖출 비)
付(줄 부)', '동사', 596, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全室にエアコンを備え付けた。', '전 실에 에어컨을 구비했다.', 1),
    (w, '備え付けの家具がある。', '구비된 가구가 있다.', 2);

  -- 597. かさばる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かさばる', '부피가 커서 거쬜장스럽다', NULL, '동사', 597, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物がかさばる。', '짐이 부피가 크다.', 1),
    (w, 'プレゼントがかさばって運びにくい。', '선물이 짓돈이 난·굼장° 달±ªe〔〕れ.', 2);

  -- 598. 交錯
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '交錯', 'こうさく', '교착', '交(사귀일 교)
錯(섮일 착)', '명사', 598, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さまざまな思いが交錯する。', '다양한 생각이 교착한다.', 1),
    (w, '期待と不安が交錯する。', '기대와 불안이 교착한다.', 2);

  -- 599. しぶとい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'しぶとい', '끈질기다, 질김', NULL, 'い형용사', 599, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しぶとい性格だ。', '끈질긴 성격이다.', 1),
    (w, 'しぶとい雑草。', '질긴 잡초.', 2);

  -- 600. 基調
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '基調', 'きちょう', '기조', '基(터 기)
調(고를 조)', '명사', 600, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '青を基調としたデザインだ。', '파랑을 기조로 한 디자인이다.', 1),
    (w, '作品の基調を詳細する。', '작품의 기조를 자세히 설명한다.', 2);

  -- 601. 簡素
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '簡素', 'かんそ', '간소', '簡(대쉭 간)
素(흡 소)', '명사', 601, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡素化された手続きだ。', '간소화된 절차다.', 1),
    (w, '簡素デザインが人気だ。', '간소한 디자인이 인기다.', 2);

  -- 602. 解明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '解明', 'かいめい', '해명', '解(풀 해)
明(밝을 명)', '명사', 602, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因を解明する。', '원인을 해명한다.', 1),
    (w, '事件の解明が進む。', '사건의 해명이 진행된다.', 2);

  -- 603. ほほえましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ほほえましい', '보기 흔묻하다', NULL, 'い형용사', 603, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ほほえましい光景だ。', '보기 흔묻한 광경이다.', 1),
    (w, 'ほほえましい子供の姿。', '보기 흔묻한 아이의 모습.', 2);

  -- 604. 目安
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '目安', 'めやす', '기준, 짐작', '目(눈 목)
安(편안할 안)', '명사', 604, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格の目安を示す。', '가격의 기준을 제시한다.', 1),
    (w, 'ひとつの目安になる。', '하나의 짐작이 된다.', 2);

  -- 605. 様相
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '様相', 'ようそう', '양상', '様(모양 양)
相(서로 상)', '명사', 605, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '街の様相が変わった。', '거리의 양상이 변했다.', 1),
    (w, '事態は重大な様相を醸している。', '사태는 중대한 양상을 띄고 있다.', 2);

  -- 606. 交える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '交える', 'まじえる', '섞다, 교환하다', '交(사귀일 교)', '동사', 606, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話に冷説を交える。', '이야기에 농담을 섞는다.', 1),
    (w, '言葉を交える。', '말을 주고받는다.', 2);

  -- 607. 要望
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '要望', 'ようぼう', '요망', '要(요구 요)
望(바랄 망)', '명사', 607, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '住民の要望に応える。', '주민의 요망에 부응한다.', 1),
    (w, '要望を出す。', '요구를 제출한다.', 2);

  -- 608. くじける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'くじける', '꿩이다, 좌절하다', NULL, '동사', 608, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '応援がくじける。', '기갈이 꿩인다.', 1),
    (w, '心がくじけた。', '마음이 꿩였다.', 2);

  -- 609. ひたむき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ひたむき', '일도(一途), 외골수이, 올곳', NULL, 'な형용사', 609, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ひたむきに努力する。', '일도이 노력한다.', 1),
    (w, 'ひたむきな態度だ。', '올곳한 태도다.', 2);

  -- 610. 失脚
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '失脚', 'しっきゃく', '실각', '失(잃을 실)
脚(다리 각)', '명사', 610, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '首相が失脚した。', '총리가 실각했다.', 1),
    (w, 'スキャンダルで失脚した。', '스캔들로 실각했다.', 2);

  -- 611. 収容
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '収容', 'しゅうよう', '수용', '収(거둘 수)
容(얼굴 용)', '명사', 611, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ぶんタを収容する。', '한자를 수용한다.', 1),
    (w, '避難所に収容された。', '대피소에 수용되었다.', 2);

  -- 612. 実に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '実に', 'じつに', '실로, 정말로', '実(열매 실)', '부사', 612, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実に驚いた。', '정말로 놀랐다.', 1),
    (w, '実に興味深い話だ。', '실로 흥미로운 이야기다.', 2);

  -- 613. 絶滅
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '絶滅', 'ぜつめつ', '멸종', '絶(끊을 절)
滅(멸할 멸)', '명사', 613, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '種が絶滅の危機にある。', '종이 멸종 위기에 있다.', 1),
    (w, '伝統が絶滅した。', '전통이 멸종되었다.', 2);

  -- 614. 露骨に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '露骨に', 'ろこつに', '노골적으로', '露(이슬 로)
骨(빼 골)', '부사', 614, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '露骨に嫌な顔をした。', '노골적으로 싫은 표정을 지었다.', 1),
    (w, '露骨に不満を表す。', '노골적으로 불만을 드러낸다.', 2);

  -- 615. 交付
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '交付', 'こうふ', '교부', '交(사귀일 교)
付(줄 부)', '명사', 615, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '贻金を交付する。', '장려금을 교부한다.', 1),
    (w, '免許証を交付した。', '면허증을 교부했다.', 2);

  -- 616. なつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'なつく', '따르다, 친해지다', NULL, '동사', 616, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬が人になつく。', '개가 사람을 따른다.', 1),
    (w, 'よくなついている。', '잘 잘 따르고 있다.', 2);

  -- 617. 均等
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '均等', 'きんとう', '균등', '均(고를 균)
等(무리 등)', '명사', 617, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '均等に分ける。', '균등하게 나눠준다.', 1),
    (w, '均等な機会を与える。', '균등한 기회를 준다.', 2);

  -- 618. リタイア
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'リタイア', 'りたいあ', '은퇴', NULL, '명사', 618, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカー選手がリタイアした。', '소서레 선수가 은퇴했다.', 1),
    (w, '会社をリタイアした。', '회사를 은퇴했다.', 2);

  -- 619. 押収
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '押収', 'おうしゅう', '압수', '押(누를 압)
収(거둘 수)', '명사', 619, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証拠品を押収した。', '증거품을 압수했다.', 1),
    (w, '違法車両を押収する。', '불법 차량을 압수한다.', 2);

  -- 620. 望ましい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '望ましい', 'のぞましい', '바람직하다', '望(바랄 망)', 'い형용사', 620, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '望ましい結果だ。', '바람직한 결과다.', 1),
    (w, '望ましい姿だ。', '바람직한 모습이다.', 2);

  -- 621. 本場
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '本場', 'ほんば', '산지, 원조', '本(근본 본)
場(마당 장)', '명사', 621, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本場のイタリア料理だ。', '본고장 이탈리아 요리다.', 1),
    (w, '本場の職人が作る。', '원조의 장인이 만든다.', 2);

  -- 622. 結末
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '結末', 'けつまつ', '결말', '結(맺을 결)
末(끝 말)', '명사', 622, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件の結末を見守る。', '사건의 결말을 지켜본다.', 1),
    (w, '骨骪とした結末だ。', '자초지종한 결말이다.', 2);

  -- 623. そそる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'そそる', '식욕·흥미를 돋구다', NULL, '동사', 623, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食欲をそそる香りだ。', '식욕을 돋구는 향이다.', 1),
    (w, '興味をそそるテーマだ。', '흥미를 돋구는 주제다.', 2);

  -- 624. 要請
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '要請', 'ようせい', '요청', '要(요구 요)
請(청할 청)', '명사', 624, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '協力を要請した。', '협력을 요청했다.', 1),
    (w, '要請に応じる。', '요청에 응한다.', 2);

  -- 625. ぎこちない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ぎこちない', '어색하다, 서투르다', NULL, 'い형용사', 625, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '動きがぎこちない。', '움직임이 어색하다.', 1),
    (w, 'ぎこちない説明だった。', '서투른 설명이었다.', 2);

  -- 626. 断じて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '断じて', 'だんじて', '결단코, 절대로', '断(끊을 단)', '부사', 626, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '断じて許せない。', '결단코 용서할 수 없다.', 1),
    (w, '断じてそんなことはない。', '절대로 그런 일은 없다.', 2);

  -- 627. 出荷
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '出荷', 'しゅっか', '출하', '出(나올 출)
荷(머이에 질 하)', '명사', 627, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豊品を出荷する。', '상품을 출하한다.', 1),
    (w, '車両の出荷が遅れている。', '차량 출하가 늦춰지고 있다.', 2);

  -- 628. 譲る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '譲る', 'ゆずる', '양보하다', '譲(사양할 양)', '동사', 628, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '席を譲る。', '자리를 양보한다.', 1),
    (w, '一歩も譲らない。', '한 걸음도 양보하지 않는다.', 2);

  -- 629. 底力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '底力', 'そこぢから', '저력', '底(밑 저)
力(힘 력)', '명사', 629, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '底力を見せた。', '저력을 보여주었다.', 1),
    (w, '底力に期待したい。', '저력에 기대하고 싶다.', 2);

  -- 630. 手痛い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手痛い', 'ていたい', '뉴아프다, 아프다', '手(손 수)
痛(아플 통)', 'い형용사', 630, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手痛いシージュールを受けた。', '뉴아프의 일격을 받았다.', 1),
    (w, '手痛い逸だ。', '뉴아풍 실수다.', 2);

  -- 631. 誘致
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '誘致', 'ゆうち', '유치', '誘(꾼 유)
致(이를 치)', '명사', 631, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '企業を誘致する。', '기업을 유치한다.', 1),
    (w, '五輪の誘致に成功した。', '올림픽 유치에 성공했다.', 2);

  -- 632. さえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'さえる', '썰주해지다, 맑아지다', NULL, '동사', 632, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭がさえる。', '머리가 맑아진다.', 1),
    (w, '脳がさえる。', '머리가 맑다.', 2);

  -- 633. 痛烈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '痛烈', 'つうれつ', '통렬', '痛(아플 통)
烈(매울 렬)', 'な형용사', 633, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '痛烈に批判した。', '통렬하게 비판했다.', 1),
    (w, '痛烈な一撃だった。', '통렬한 일격이었다.', 2);

  -- 634. もろい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もろい', '부서지기 쉬우다', NULL, 'い형용사', 634, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もろいガラスだ。', '깨지기 쉬운 유리다.', 1),
    (w, '心がもろい。', '마음이 약해서 쉽게 무너진다.', 2);

  -- 635. 解約
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '解約', 'かいやく', '해약', '解(풀 해)
約(맺을 약)', '명사', 635, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '携帯の解約をした。', '휴대폰을 해약했다.', 1),
    (w, '保険を解約する。', '보험을 해약한다.', 2);

  -- 636. 特産
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '特産', 'とくさん', '특산', '特(특별할 특)
産(낳을 산)', '명사', 636, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古部の特産品だ。', '교토의 특산품이다.', 1),
    (w, '特産を買う。', '특산품을 산다.', 2);

  -- 637. 問い詰める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '問い詰める', 'といつめる', '따져묻다', '問(물을 문)
詰(막을 휗)', '동사', 637, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証人を問い詰める。', '증인을 따져묻는다.', 1),
    (w, '責任を問い詰められた。', '책임을 추궁받았다.', 2);

  -- 638. 改修
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '改修', 'かいしゅう', '개수', '改(고칠 개)
修(닦을 수)', '명사', 638, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '道路を改修する。', '도로를 개수한다.', 1),
    (w, '建物の改修工事だ。', '건물의 개수 공사다.', 2);

  -- 639. 手厚い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '手厚い', 'てあつい', '극진하다, 극락한', '手(손 수)
厚(두터울 후)', 'い형용사', 639, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手厚い看護を受けた。', '극진한 간호를 받았다.', 1),
    (w, '手厚いもてなしをした。', '극진한 대접을 했다.', 2);

  -- 640. デマ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'デマ', 'でま', '데마, 유소문', NULL, '명사', 640, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デマが拡散した。', '데마가 확산되었다.', 1),
    (w, 'それはデマだ。', '그건 데마다.', 2);

  -- 641. 風潮
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '風潮', 'ふうちょう', '풍조, 세상의 흐름', '風(바람 풍)
潮(밀물 조)', '명사', 641, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現代の風潮に乗る。', '현대의 풍조에 올라탄다.', 1),
    (w, '社会の風潮を反映する。', '사회의 풍조를 반영한다.', 2);

  -- 642. もたらす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'もたらす', '가져오다, 초래하다', NULL, '동사', 642, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幸運をもたらした。', '행운을 가져왔다.', 1),
    (w, '重大な結果をもたらす。', '중대한 결과를 초래한다.', 2);

  -- 643. 補塀
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '補塀', 'ほてん', '보전, 메움', '補(깁을 보)
塀(메울 전)', '명사', 643, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '赤字を補塀する。', '적자를 메운다.', 1),
    (w, '損失の補塀を求める。', '손실의 보전을 요구한다.', 2);

  -- 644. ずばり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ずばり', '어터 해서, 정확하게', NULL, '부사', 644, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ずばり言うと、反対だ。', '정확하게 말하자면 반대다.', 1),
    (w, '原因をずばりと言い当てた。', '원인을 정확히 맞춰다.', 2);

  -- 645. 養う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '養う', 'やしなう', '기르다, 양육하다', '養(기를 양)', '동사', 645, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子を養う。', '자식을 돌본다.', 1),
    (w, '体力を養う。', '체력을 길러낸다.', 2);

  -- 646. 資質
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '資質', 'ししつ', '자질', '資(재물 자)
質(바탕 질)', '명사', 646, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'リーダーの資質がある。', '리더의 자질이 있다.', 1),
    (w, '資質を磨く。', '자질을 갈고 닦는다.', 2);

  -- 647. 間柄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '間柄', 'あいだがら', '사이, 관계', '間(사이 간)
柄(자루 병)', '명사', 647, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '親しい間柄だ。', '친한 사이다.', 1),
    (w, '間柄がよくない。', '사이가 좋지 않다.', 2);

  -- 648. 正当
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '正当', 'せいとう', '정당', '正(바를 정)
当(마끜할 당)', '명사', 648, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '正当な要求だ。', '정당한 요구다.', 1),
    (w, '正当化されない。', '정당화되지 않는다.', 2);

  -- 649. 理屈
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '理屈', 'りくつ', '논리·이론·이치', '理(다스릴 리)
屈(구부릴 굴)', '명사', 649, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '理屈っぽい話だ。', '이치적인 이야기다.', 1),
    (w, '理屈をこねる。', '이치를 따진다.', 2);

  -- 650. 説とく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '説とく', 'とく', '설도하다', '説(말씀 설)', '동사', 650, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもを説いた。', '아이를 설득했다.', 1),
    (w, '人生の道を説く。', '인생의 길을 설한다.', 2);

  -- 651. 肣る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '肣る', 'なめる', '핵다, 조말하다', '肣(하있을 이)', '동사', 651, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬を肣る。', '개를 핵다.', 1),
    (w, '本を肣るように読む。', '책을 핵듯이 읽는다.', 2);

  -- 652. 定住
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '定住', 'ていじゅう', '정주', '定(정할 정)
住(살 주)', '명사', 652, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都に定住した。', '교토에 정주했다.', 1),
    (w, '外国に定住する。', '외국에 정주한다.', 2);

  -- 653. 隱居
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '隱居', 'いんきょ', '은거', '隱(숨을 은)
居(살 거)', '명사', 653, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '山中に隱居した。', '산속에 은거했다.', 1),
    (w, '隱居生活を送る。', '은거 생활을 보낸다.', 2);

  -- 654. 底辺
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '底辺', 'そこへん', '도저히, 아무래도', '底(밑 저)
辺(가 변)', '부사', 654, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '底辺不可能だ。', '도저히 불가능하다.', 1),
    (w, '底辺受け入れられない。', '도저히 받아들일 수 없다.', 2);

  -- 655. 全面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '全面', 'ぜんめん', '전면', '全(온전 전)
面(냭 면)', '명사', 655, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '全面的に見直した。', '전면적으로 재검토했다.', 1),
    (w, '全面収録だ。', '전면 수록이다.', 2);

  -- 656. 応募
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '応募', 'おうぼ', '응모', '応(응할 응)
募(모을 모)', '명사', 656, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '就職に応募する。', '취직에 응모한다.', 1),
    (w, 'コンテストに応募した。', '콘테스트에 응모했다.', 2);

  -- 657. 「その他」
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '「その他」', 'そのた', '그 외', NULL, '명사', 657, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その他の費用もかかる。', '그 외의 비용도 든다.', 1),
    (w, 'その他詳細は伝言させる。', '그 외 자세한 사항은 전달하겠다.', 2);

  -- 658. 走り回る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '走り回る', 'はしりまわる', '뛰어다니다', '走(달릴 주)
回(돌 회)', '동사', 658, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間を走り回る。', '방 안을 뛰어다닌다.', 1),
    (w, '仕事で走り回った。', '일로 바쁬 다녕다.', 2);

  -- 659. 希薄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '希薄', 'きはく', '희박', '希(바랄 희)
薄(엇을 박)', '명사', 659, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '希薄な金属だ。', '희박한 금속이다.', 1),
    (w, '可能性が希薄だ。', '가능성이 희박하다.', 2);

  -- 660. 代議士
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '代議士', 'だいぎし', '대의사, 국회의원', '代(대신할 대)
議(의론할 의)', '명사', 660, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '代議士に選ばれた。', '국회의원에 선출되었다.', 1),
    (w, '代議士の任期だ。', '국회의원의 임기다.', 2);

  -- 661. 複雑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '複雑', 'ふくざつ', '복잡', '複(겹칠 복)
雑(섞일 잡)', 'な형용사', 661, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題が複雑だ。', '문제가 복잡하다.', 1),
    (w, '複雑な手順だ。', '복잡한 절차다.', 2);

  -- 662. 入門
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '入門', 'にゅうもん', '입문', '入(들 입)
門(문 문)', '명사', 662, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ピアノの入門書を買う。', '피아노 입문서를 산다.', 1),
    (w, '入門講座を受講した。', '입문 강좌를 수강했다.', 2);

  -- 663. 証言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '証言', 'しょうげん', '증언', '証(증거 증)
言(말씀 언)', '명사', 663, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '裁判で証言した。', '재판에서 증언했다.', 1),
    (w, '伝言だけでは信じられない。', '증언만으로는 믿기 어렵다.', 2);

  -- 664. とんだ、あさめて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'とんだ、あさめて', '틀린, 다시, 새로이', NULL, '부사/동사', 664, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あさめて始めよう。', '다시 시작하자.', 1),
    (w, 'あさめて考える。', '새삼 생각한다.', 2);

  -- 665. 越計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '越計', 'たしやか', '확실하다, 탁월하다', '越(넘을 월)
計(셌 계)', 'な형용사', 665, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '越計した才能だ。', '탁월한 재능이다.', 1),
    (w, '越計した独特の人だ。', '독특한 서다.', 2);

  -- 666. 限度
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '限度', 'げんど', '한도', '限(한계 한)
度(법도 도)', '명사', 666, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忍耐の限度だ。', '인내의 한도다.', 1),
    (w, '限度を超える。', '한도를 넘는다.', 2);

  -- 667. 疑う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '疑う', 'うたがう', '의심하다', '疑(의심할 의)', '동사', 667, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話を疑う。', '이야기를 의심한다.', 1),
    (w, '動機を疑われる。', '동기를 의심받는다.', 2);

  -- 668. ヒットする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ヒットする', '히트하다', NULL, '동사', 668, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その映画はヒットした。', '그 영화는 히트했다.', 1),
    (w, '商品がヒットした。', '상품이 히트되었다.', 2);

  -- 669. 低迄
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '低迄', 'ていみよう', '저미', '低(낮을 저)
迄(이를 미)', '명사', 669, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '景気が低迄している。', '경기가 저미하고 있다.', 1),
    (w, '売り上げが低迄だ。', '매출이 저미하다.', 2);

  -- 670. 険しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '険しい', 'けわしい', '험하다, 험상이 나끜다', '険(험할 험)', 'い형용사', 670, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '険しい表情をした。', '험상궁은 표정을 지었다.', 1),
    (w, '険しい顔で見める。', '험상굷은 얼굴로 노려본다.', 2);

  -- 671. よしに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'よしに', '설령, 고의로', NULL, '부사', 671, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よしに反対されてもやる。', '설령 반대한다 해도 한다.', 1),
    (w, 'よしに、雨が降ったとしても。', '설령 비가 온다 해도.', 2);

  -- 672. 付け加える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '付け加える', 'つけくわえる', '덧붙이다, 덧붙여·첨가하다', '付(붙을 부)
加(더할 가)', '동사', 672, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コメントを付け加える。', '코멘트를 덧붙인다.', 1),
    (w, '説明を付け加えた。', '설명을 덧붙였다.', 2);

  -- 673. 伝統
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '伝統', 'でんとう', '전통', '伝(전할 전)
統(거느릴 통)', '명사', 673, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '伝統を守る。', '전통을 지킨다.', 1),
    (w, '伝統的な言茶道だ。', '전통적인 다도다.', 2);

  -- 674. 明染
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '明染', 'めいた', '서명, 명술', '明(밝을 명)
染(팔 서)', '명사', 674, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明染のダンサーだ。', '명임의 대스입시워다.', 1),
    (w, '明染のシェフと言われる。', '명임 셰프라 불린다.', 2);

  -- 675. 玩具
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '玩具', 'がんぐ', '완구, 장난감', '玩(놈 완)
具(갖출 구)', '명사', 675, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子どもが玩具で遊ぶ。', '아이가 장난감으로 논다.', 1),
    (w, '玩具錄を買う。', '장난감을 산다.', 2);

  -- 676. 考察
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '考察', 'こうさつ', '고찰', '考(생각할 고)
察(살필 찰)', '명사', 676, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '現地調査と考察をした。', '현장 조사와 고찰을 했다.', 1),
    (w, '考察レポートを書く。', '고찰 레포트를 쓴다.', 2);

  -- 677. 厳重
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '厳重', 'げんじゅう', '엄중', '厳(엄할 엄)
重(무거울 중)', 'な형용사', 677, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳重な警備だ。', '엄중한 경비다.', 1),
    (w, '厳重に注意した。', '엄중하게 주의했다.', 2);

  -- 678. 規模
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '規模', 'きぼ', '규모', '規(법 규)
模(본바말 모)', '명사', 678, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大規模なイベントだ。', '대규모 이벤트다.', 1),
    (w, '規模を拡大する。', '규모를 확대한다.', 2);

  -- 679. 広告
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '広告', 'こうこく', '광고', '広(넓을 광)
告(알릴 고)', '명사', 679, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビで広告を見た。', '텔레비전에서 광고를 봤다.', 1),
    (w, '広告効果があった。', '광고 효과가 있었다.', 2);

  -- 680. 同情
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '同情', 'どうじょう', '동정', '同(한가지 동)
情(뜻 정)', '명사', 680, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '被害者に同情した。', '피해자에게 동정했다.', 1),
    (w, '同情の余地がない。', '동정의 여지가 없다.', 2);

  -- 681. 備える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '備える', 'そなえる', '갖추다, 대비하다', '備(갖출 비)', '동사', 681, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '地震に備える。', '지진에 대비한다.', 1),
    (w, '試験に備えて勉強する。', '시험에 대비해 공부한다.', 2);

  -- 682. スケジュール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スケジュール', 'すけじゅーる', '스케줄', NULL, '명사', 682, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スケジュールを組む。', '스케줄을 짜다.', 1),
    (w, 'スケジュールが詰まっている。', '스케줄이 빽빽하다.', 2);

  -- 683. 勣る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '勣る', 'まさる', '뛰어나다, 끭주다', '勣(넓은 우)', '동사', 683, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '品質にて勣るものはない。', '품질에 있어 버금가는 것이 없다.', 1),
    (w, '他の起業に勣る。', '다른 기업에 뚤지 않는다.', 2);

  -- 684. 幼い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '幼い', 'おさない', '어리다, 유치하다', '幼(어릴 유)', 'い형용사', 684, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '幼い子どもがいる。', '어린 아이가 있다.', 1),
    (w, '考えが幼い。', '생각이 유치하다.', 2);

  -- 685. 初めて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '初めて', 'はじめて', '처음으로', '初(처음 초)', '부사', 685, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初めて日本に来た。', '처음 일본에 왔다.', 1),
    (w, '初めて願う。', '처음 만나닝곁습니다.', 2);

  -- 686. 外野
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '外野', 'げや', '외야, 한밥에 있음', '外(밖 외)
野(들 야)', '명사', 686, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外野の選手だ。', '외야의 선수다.', 1),
    (w, '外野を守る。', '외야를 수비한다.', 2);

  -- 687. 記録
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '記録', 'きろく', '기록', '記(기록할 기)
録(기록할 록)', '명사', 687, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '世界記録を作った。', '세계 기록을 세웠다.', 1),
    (w, 'データを記録する。', '데이터를 기록한다.', 2);

  -- 688. 規則
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '規則', 'きそく', '규칙', '規(법 규)
則(법칙 칙)', '명사', 688, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規則を守る。', '규칙을 지킨다.', 1),
    (w, '規則違反だ。', '규칙 위반이다.', 2);

  -- 689. 合計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '合計', 'ごうけい', '합계', '合(합할 합)
計(셌 계)', '명사', 689, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '費用は合計1万円。', '비용은 합계 만 엔.', 1),
    (w, '合計を出す。', '합계를 낸다.', 2);

  -- 690. 不明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不明', 'ふめい', '불명', '不(아닐 불)
明(밝을 명)', 'な형용사', 690, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因不明だ。', '원인 불명이다.', 1),
    (w, '行方不明になる。', '행방불명이 되다.', 2);

  -- 691. 代わる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '代わる', 'かわる', '바뀌다, 교체되다', '代(대신할 대)', '동사', 691, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長が代わった。', '사장이 바뀌었다.', 1),
    (w, '代わって読んだ。', '대신 읽었다.', 2);

  -- 692. 証拠
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '証拠', 'しょうこ', '증거', '証(증거 증)
拠(근거 거)', '명사', 692, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '証拠不十分だ。', '증거 불충분이다.', 1),
    (w, '証拠を提示する。', '증거를 제시한다.', 2);

  -- 693. 使う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '使う', 'つかう', '쓰다, 사용하다', '使(하여금 사)', '동사', 693, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンピューターを使う。', '컴퓨터를 사용한다.', 1),
    (w, 'お金を使う。', '돈을 쓴다.', 2);

  -- 694. 難しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '難しい', 'むずかしい', '어렵다', '難(어려울 난)', 'い형용사', 694, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '問題が難しい。', '문제가 어렵다.', 1),
    (w, '読み難い字だ。', '읽기 어려운 글자다.', 2);

  -- 695. スポーツ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スポーツ', 'すぽーつ', '스포츠', NULL, '명사', 695, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スポーツが好きだ。', '스포츠를 좋아한다.', 1),
    (w, 'スポーツをする。', '스포츠를 한다.', 2);

  -- 696. 以前
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '以前', 'いぜん', '이전', '以(써 이)
前(앞 전)', '명사', 696, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '以前会ったことがある。', '이전에 만난 적이 있다.', 1),
    (w, '以前はタバコをすっていた。', '예전에는 담배를 피웠다.', 2);

  -- 697. 社員
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '社員', 'しゃいん', '사원', '社(모일 사)
員(인원 원)', '명사', 697, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'トヨタボ社員だ。', '도요타 사원이다.', 1),
    (w, '社員と話をした。', '사원과 이야기를 나눠다.', 2);

  -- 698. 踊る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '踊る', 'おどる', '춤추다', '踊(춤출 용)', '동사', 698, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サルサを踊る。', '샐샐를 춤춘다.', 1),
    (w, '踊るのが上手だ。', '춤이 능숙하다.', 2);

  -- 699. 長期
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '長期', 'ちょうき', '장기', '長(길 장)
期(기약할 기)', '명사', 699, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長期休暇に入る。', '장기 휴가를 돌입한다.', 1),
    (w, '長期的に考える。', '장기적으로 생각한다.', 2);

  -- 700. 乾煌
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '乾煌', 'かんそう', '건조', '乾(하늘 건)
煌(마를 조)', '명사', 700, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '背中が乾煌している。', '등이 건조하다.', 1),
    (w, '乾煌オレンジを食べる。', '건조 오렌지를 먹는다.', 2);

  -- 701. 社交
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '社交', 'しゃこう', '사교', '社(모일 사)
交(사귀일 교)', '명사', 701, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社交ダンスを踊る。', '사교 대스를 춤춘다.', 1),
    (w, '社交スキルを高める。', '사교 스킬을 높인다.', 2);

  -- 702. 茶色
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '茶色', 'ちゃいろ', '갈색', '茶(차 다)
色(빛 색)', '명사', 702, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '茶色の鞄をしている。', '갈색 구두를 신었다.', 1),
    (w, '髪を茶色に染めた。', '머리를 갈색으로 염색했다.', 2);

  -- 703. 安全
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '安全', 'あんぜん', '안전', '安(편안할 안)
全(온전 전)', 'な형용사', 703, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安全を確認してから乗る。', '안전을 확인하고 탄다.', 1),
    (w, '安全な場所だ。', '안전한 장소다.', 2);

  -- 704. 体験
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '体験', 'たいけん', '체험', '体(모 체)
験(시험 험)', '명사', 704, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '豊富な体験をした。', '풍부한 체험을 했다.', 1),
    (w, '体験談を語る。', '체험담을 말한다.', 2);

  -- 705. 公表
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '公表', 'こうひょう', '공표', '公(공평할 공)
表(갉 표)', '명사', 705, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果が公表された。', '결과가 공표되었다.', 1),
    (w, '今朝公表された。', '오늘 아침 공표되었다.', 2);

  -- 706. テレビ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'テレビ', 'てれび', '텔레비전', NULL, '명사', 706, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テレビでニュースを見た。', '텔레비전으로 뉴스를 봤다.', 1),
    (w, 'テレビ番組を録画した。', '텔레비전 프로그램을 녹화했다.', 2);

  -- 707. 事件
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '事件', 'じけん', '사건', '事(일 사)
件(조건 건)', '명사', 707, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件が起きた。', '사건이 일어났다.', 1),
    (w, '事件の犯人だ。', '사건의 범인이다.', 2);

  -- 708. 記号
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '記号', 'きごう', '기호', '記(기록할 기)
号(이름 호)', '명사', 708, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通記号を守る。', '교통 신호를 지킨다.', 1),
    (w, 'ステックを記号で表す。', '상태를 기호로 표시한다.', 2);

  -- 709. 明朝
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '明朝', 'みょうちょう', '내일 아침', '明(밝을 명)
朝(아침 조)', '명사', 709, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明朝七時に出発する。', '내일 아침 7시에 출발한다.', 1),
    (w, '明朝雨が降るようだ。', '내일 아침 비가 올 것 같다.', 2);

  -- 710. 会計
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '会計', 'かいけい', '회계', '会(모일 회)
計(셌 계)', '명사', 710, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会計を担当する。', '회계를 담당한다.', 1),
    (w, '会計を済ませて退出した。', '계산을 끝내고 나왔다.', 2);

  -- 711. 講演
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '講演', 'こうえん', '강연', '講(외울 강)
演(펼 연)', '명사', 711, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '講演を聞く。', '강연을 듣는다.', 1),
    (w, '講演会を開く。', '강연회를 열다.', 2);

  -- 712. 古い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '古い', 'ふるい', '낚아보이다, 오래되다', '古(예 고)', 'い형용사', 712, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '古い本を読む。', '오래된 책을 읽는다.', 1),
    (w, '考えが古い。', '생각이 낚았다.', 2);

  -- 713. 植物
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '植物', 'しょくぶつ', '식물', '植(심을 식)
物(만물 물)', '명사', 713, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '植物を育てる。', '식물을 키운다.', 1),
    (w, '植物园に行った。', '식물원에 갔다.', 2);

  -- 714. 作成
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作成', 'さくせい', '작성', '作(지을 작)
成(이룰 성)', '명사', 714, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料を作成する。', '자료를 작성한다.', 1),
    (w, 'データを作成した。', '데이터를 작성했다.', 2);

  -- 715. 記者
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '記者', 'きしゃ', '기자', '記(기록할 기)
者(놈 자)', '명사', 715, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スポーツ記者だ。', '스포츠 기자다.', 1),
    (w, '記者会見を開く。', '기자회견을 열다.', 2);

  -- 716. 交換
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '交換', 'こうかん', '교환', '交(사귀일 교)
換(바꿀 환)', '명사', 716, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名刺を交換する。', '명함을 교환한다.', 1),
    (w, '意見を交換する。', '의견을 교환한다.', 2);

  -- 717. ダイエット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ダイエット', 'だいえっと', '다이어트', NULL, '명사', 717, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ダイエットを始めた。', '다이어트를 시작했다.', 1),
    (w, 'ダイエット中だ。', '다이어트 중이다.', 2);

  -- 718. 選手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '選手', 'せんしゅ', '선수', '選(가릴 선)
手(손 수)', '명사', 718, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サッカー選手だ。', '축구 선수다.', 1),
    (w, '選手を選ぶ。', '선수를 고른다.', 2);

  -- 719. 入れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '入れる', 'いれる', '넣다', '入(들 입)', '동사', 719, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カバンに本を入れる。', '가방에 책을 넣는다.', 1),
    (w, 'コーヒーに砂糖を入れる。', '커피에 설탕을 넣는다.', 2);

  -- 720. 差しざ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '差しざ', 'さしざ', '우산', '差(달림 차)', '명사', 720, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るので差しざをさす。', '비가 와서 우산을 쓴다.', 1),
    (w, '差しざを忘れた。', '우산을 잊었다.', 2);

  -- 721. 吃般
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '吃般', 'きっされん', '끝내 안 됨, 하난, 퍼그웠다', '吃(먹을 휗)
般(일반 반)', '명사/な형용사', 721, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう吃般だ。', '이제 지겹다.', 1),
    (w, '吃般にしろよ。', '적당히 해라.', 2);

  -- 722. 表現
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '表現', 'ひょうげん', '표현', '表(갉 표)
現(나타날 현)', '명사', 722, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感情を表現する。', '감정을 표현한다.', 1),
    (w, '言語表現が豊かだ。', '언어 표현이 풍부하다.', 2);

  -- 723. 成長
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '成長', 'せいちょう', '성장', '成(이룰 성)
長(길 장)', '명사', 723, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済成長が著しい。', '경제 성장이 두드러지다.', 1),
    (w, '子供の成長を記録する。', '아이의 성장을 기록한다.', 2);

  -- 724. 不便
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '不便', 'ふべん', '불편', '不(아닐 불)
便(편할 편)', 'な형용사', 724, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交通が不便だ。', '교통이 불편하다.', 1),
    (w, '不便を感じる。', '불편을 느낌다.', 2);

  -- 725. 軽い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軽い', 'かるい', '가볍다', '軽(가벼울 경)', 'い형용사', 725, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽い荷物だ。', '가벼운 짐이다.', 1),
    (w, '軽い身体だ。', '가벼운 못감이다.', 2);

  -- 726. 努力
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '努力', 'どりょく', '노력', '努(힘쓸 노)
力(힘 력)', '명사', 726, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '努力して勉強した。', '노력해서 공부했다.', 1),
    (w, '努力が実を結んだ。', '노력이 결실을 맺었다.', 2);

  -- 727. サービス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'サービス', 'さーびす', '서비스', NULL, '명사', 727, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'サービスがよい。', '서비스가 좋다.', 1),
    (w, 'サービスを提供する。', '서비스를 제공한다.', 2);

  -- 728. 予定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '予定', 'よてい', '예정', '予(미리 예)
定(정할 정)', '명사', 728, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日の予定を確認する。', '내일 일정을 확인한다.', 1),
    (w, '予定が入っている。', '일정이 있다.', 2);

  -- 729. 思い出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '思い出す', 'おもいだす', '기억해내다', '思(생각 사)
出(날 출)', '동사', 729, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を思い出す。', '이름을 기억해낸다.', 1),
    (w, '昨日のことを思い出した。', '어제 일을 떠올렸다.', 2);

  -- 730. 表面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '表面', 'ひょうめん', '표면', '表(갉 표)
面(냭 면)', '명사', 730, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '表面をコートする。', '표면을 코팅한다.', 1),
    (w, '表面上は平静だ。', '표면상으로는 평온하다.', 2);

  -- 731. 体重
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '体重', 'たいじゅう', '체중', '体(모 체)
重(무거울 중)', '명사', 731, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '体重が増えた。', '체중이 늘었다.', 1),
    (w, '体重を量る。', '체중을 쟰다.', 2);

  -- 732. 項目
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '項目', 'こうもく', '항목', '項(항목 항)
目(눈 목)', '명사', 732, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '該当する項目を探す。', '해당하는 항목을 찾는다.', 1),
    (w, '項目ごとに入力する。', '항목별로 입력한다.', 2);

  -- 733. 長手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '長手', 'ちょうしゅ', '잘함', '長(길 장)
手(손 수)', 'な형용사', 733, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'テニスが長手だ。', '테니스를 잘한다.', 1),
    (w, '長手な人に職を任せる。', '잘하는 사람에게 일을 맡긴다.', 2);

  -- 734. 応援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '応援', 'おうえん', '응원', '応(응할 응)
援(도울 원)', '명사', 734, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームを応援した。', '팀을 응원했다.', 1),
    (w, '友人を応援する。', '친구를 응원한다.', 2);

  -- 735. 平凡
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '平凡', 'へいぼん', '평범', '平(평평할 평)
凡(무릇 범)', 'な형용사', 735, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平凡な人生だ。', '평범한 인생이다.', 1),
    (w, '平凡な評価だった。', '평범한 평가였다.', 2);

  -- 736. 主人
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '主人', 'しゅじん', '주인, 남편', '主(주인 주)
人(사람 인)', '명사', 736, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家の主人だ。', '집의 주인이다.', 1),
    (w, '主人は会社員だ。', '남편은 회사원이다.', 2);

  -- 737. 友達
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '友達', 'ともだち', '친구', '友(벳 우)
達(통달할 달)', '명사', 737, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達と遊ぶ。', '친구와 논다.', 1),
    (w, '古い友達だ。', '오래된 친구다.', 2);

  -- 738. 作品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作品', 'さくひん', '작품', '作(지을 작)
品(물건 품)', '명사', 738, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '著名な作品だ。', '유명한 작품이다.', 1),
    (w, '新しい作品を発表する。', '새 작품을 발표한다.', 2);

  -- 739. 見事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見事', 'みごと', '훌륭함, 멋짐', '見(볼 견)
事(일 사)', 'な형용사', 739, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見事な演技だ。', '멋진 연기다.', 1),
    (w, '見事に成功した。', '훌륭하게 성공했다.', 2);

  -- 740. 見本
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見本', 'みほん', '견본, 본보기', '見(볼 견)
本(근본 본)', '명사', 740, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記入見本を見る。', '입력 견본을 본다.', 1),
    (w, '見本を示す。', '본보기를 보인다.', 2);

  -- 741. 予言
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '予言', 'よげん', '예언', '予(미리 예)
言(말씀 언)', '명사', 741, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予言が当たった。', '예언이 맞았다.', 1),
    (w, '未来を予言する。', '미래를 예언한다.', 2);

  -- 742. 作業
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作業', 'さぎょう', '작업', '作(지을 작)
業(일 업)', '명사', 742, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作業を進める。', '작업을 진행한다.', 1),
    (w, '作業が終わった。', '작업이 끝났다.', 2);

  -- 743. ポケット
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ポケット', 'ぽけっと', '주머니', NULL, '명사', 743, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ポケットにスマホを入れる。', '주머니에 스마트폰을 넣는다.', 1),
    (w, 'ポケットがいっぱいだ。', '주머니가 가득 차 있다.', 2);

  -- 744. 什事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '什事', 'じゃずしよ', '잡일, 자잔한 일', '什(세건 십)
事(일 사)', '명사', 744, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '什事に追われる。', '잡일에 쪼긴다.', 1),
    (w, '什事を長よる。', '잡일을 절약한다.', 2);

  -- 745. 反応
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '反応', 'はんのう', '반응', '反(돌이킬 반)
応(응할 응)', '명사', 745, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見者の反応がよかった。', '관객의 반응이 좋았다.', 1),
    (w, '計画に反応しない。', '계획에 반응하지 않는다.', 2);

  -- 746. ケーキ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ケーキ', 'けーき', '케이크', NULL, '명사', 746, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ケーキを焼いた。', '케이크를 굽었다.', 1),
    (w, 'バースデーケーキを買う。', '생일 케이크를 산다.', 2);

  -- 748. 身体
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '身体', 'しんたい', '신체', '身(모 신)
体(모 체)', '명사', 748, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身体を動かす。', '목을 움직인다.', 1),
    (w, '身体に気をつける。', '몸조심한다.', 2);

  -- 749. 微る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '微る', 'ほしる', '웃다, 미소짓다', '微(웃을 미)', '동사', 749, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '静かに微る。', '조용하게 미소짓는다.', 1),
    (w, '揮りながら微った。', '손을 흔들며 미소지었다.', 2);

  -- 750. 仕事
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仕事', 'しごと', '일, 직업', '仕(섬길 사)
事(일 사)', '명사', 750, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に行く。', '일하러 간다.', 1),
    (w, '仕事を辞めた。', '일을 그만두었다.', 2);

  -- 751. チーム
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'チーム', 'ちーむ', '팀', NULL, '명사', 751, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チームを組む。', '팀을 꾸린다.', 1),
    (w, 'チームワークが大切だ。', '팀워크가 중요하다.', 2);

  -- 752. 説明
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '説明', 'せつめい', '설명', '説(말씀 설)
明(밝을 명)', '명사', 752, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳しく説明した。', '자세하게 설명했다.', 1),
    (w, '説明を聞く。', '설명을 듣는다.', 2);

  -- 753. ステレオ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ステレオ', 'すてれお', '스테레오', NULL, '명사', 753, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ステレオで音楽を聞く。', '스테레오로 음악을 듣는다.', 1),
    (w, '車のステレオを交換した。', '차의 스테레오를 교체했다.', 2);

  -- 754. 見付かる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '見付かる', 'みつかる', '발견되다', '見(볼 견)
付(붙을 부)', '동사', 754, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '財布が見付かった。', '지갑이 발견되었다.', 1),
    (w, '間違いが見付かる。', '실수가 발견된다.', 2);

  -- 755. 生える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '生える', 'はえる', '나다, 자라다', '生(날 생)', '동사', 755, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '髪が生える。', '머리입도종이 나다.', 1),
    (w, '草が生える。', '풀이 자란다.', 2);

  -- 756. セール
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'セール', 'せーる', '세일', NULL, '명사', 756, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'セール中に買った。', '세일 중에 샀다.', 1),
    (w, 'セールが始まった。', '세일이 시작되었다.', 2);

  -- 757. 跳ねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '跳ねる', 'はねる', '뛰어오르다, 튀기다', '跳(뛸 도)', '동사', 757, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '魚が跳ねる。', '물고기가 튀어올랐다.', 1),
    (w, 'ボールが跳ねる。', '공이 튀느다.', 2);

  -- 758. 思いつく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '思いつく', 'おもいつく', '떠올리다, 떠오르다', '思(생각 사)', '동사', 758, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいアイデアを思いついた。', '좋은 아이디어가 떠올랐다.', 1),
    (w, '何も思いつかない。', '아무것도 떠오르지 않는다.', 2);

  -- 759. 仕込む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仕込む', 'しこむ', '이고 배우다, 단련하다', '仕(섬길 사)
込(들 입)', '동사', 759, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '身を仕込む。', '몸을 단련한다.', 1),
    (w, '犬に芸を仕込む。', '개에게 재주를 가르친다.', 2);

  -- 760. 限る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '限る', 'かぎる', '한정하다', '限(한계 한)', '동사', 760, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今回に限って無料だ。', '이번에 한해 무료다.', 1),
    (w, '人数を限る。', '인원을 제한한다.', 2);

  -- 761. チップ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'チップ', 'ちっぷ', '팁', NULL, '명사', 761, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チップを渡した。', '팁을 건넘였다.', 1),
    (w, 'チップ不要だ。', '팁은 주지 않는다.', 2);

  -- 762. 作り上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作り上げる', 'つくりあげる', '만들어내다', '作(지을 작)
上(윗 상)', '동사', 762, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を作り上げた。', '작품을 완성했다.', 1),
    (w, 'チームを作り上げる。', '팀을 만들어내다.', 2);

  -- 763. それぞれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'それぞれ', 'それぞれ', '제각각', NULL, '명사/부사', 763, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それぞれの意見がある。', '제각의 의견이 있다.', 1),
    (w, 'それぞれ起きた。', '각자 일어났다.', 2);

  -- 764. どけち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'どけち', '어디, 어느 쪽', NULL, '대명사', 764, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どっちを選ぶ？', '어느 쪽을 고를거야?', 1),
    (w, 'どっちもいい。', '어느 것이든 좋다.', 2);

  -- 765. 厳しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '厳しい', 'きびしい', '엄격하다', '厳(엄할 엄)', 'い형용사', 765, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '厳しい先生だ。', '엄격한 선생님이다.', 1),
    (w, '厳しくしかられた。', '렁이 혼난다.', 2);

  -- 766. 在師
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '在師', 'ざいケシ', '자재의', '在(있을 재)
師(스승 사)', 'な형용사', 766, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '外国語が在師だ。', '외국어를 자재롭게 구사한다.', 1),
    (w, 'スポーツを在師にこなす。', '스포츠를 자재롭게 한다.', 2);

  -- 767. 梨
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '梨', 'なし', '배, 배나무', '梨(배 리)', '명사', 767, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '梨を食べた。', '배를 먹었다.', 1),
    (w, '梨の木がある。', '배나무가 있다.', 2);

  -- 768. 現われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '現われる', 'あらわれる', '나타나다', '現(나타날 현)', '동사', 768, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スターが現われた。', '스타가 나타났다.', 1),
    (w, '効果が現われる。', '효과가 나타난다.', 2);

  -- 769. しよう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'しよう', 'しよう', '소용이 없음, 방법이 없음', NULL, '명사', 769, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司に叱られてしようがない。', '상사에게 혼나서 어첤 수 없다.', 1),
    (w, '反対されてもしようがない。', '반대당해도 어첤 수 없다.', 2);

  -- 770. 規定
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '規定', 'きてい', '규정', '規(법 규)
定(정할 정)', '명사', 770, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '規定に従う。', '규정에 따른다.', 1),
    (w, '規定を設ける。', '규정을 마련한다.', 2);

  -- 771. 送り迎える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '送り迎える', 'おくりむかえる', '맞이하다, 보내고 맞이하다', '送(보낼 송)
迎(맞을 영)', '동사', 771, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新年を送り迎える。', '신년을 맞이한다.', 1),
    (w, '他人と送り迎えをしている。', '다른 사람과 온일을 함께한다.', 2);

  -- 772. 提出
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '提出', 'ていしゅつ', '제출', '提(끌 제)
出(날 출)', '명사', 772, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'レポートを提出した。', '레포트를 제출했다.', 1),
    (w, '提出期限を守る。', '제출기한을 지킨다.', 2);

  -- 773. 進む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '進む', 'すすむ', '나아가다', '進(나아갈 진)', '동사', 773, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事が進む。', '일이 진첩된다.', 1),
    (w, '計画が進む。', '계획이 진행된다.', 2);

  -- 774. ビジネス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ビジネス', 'びじねす', '비즈니스', NULL, '명사', 774, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ビジネスチャンスだ。', '비즈니스 찬스이다.', 1),
    (w, '新規ビジネスを始める。', '신규 비즈니스를 시작한다.', 2);

  -- 775. コツ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'コツ', 'こつ', '요령, 비결', NULL, '명사', 775, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コツをつかむ。', '요령을 터득한다.', 1),
    (w, '勉強のコツを教えてください。', '공부 비결을 가르쳐 주세요.', 2);

  -- 776. 薬局
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '薬局', 'やっきょく', '약국', '薬(약 약)
局(판 국)', '명사', 776, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '薬局で薬を買う。', '약국에서 약을 산다.', 1),
    (w, '付近の薬局を探す。', '근처의 약국을 찾는다.', 2);

  -- 777. プラス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'プラス', 'ぷらす', '플러스', NULL, '명사', 777, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プラスアルファと言う。', '플러스 알파라고 한다.', 1),
    (w, 'プラスの効果だ。', '플러스 효과다.', 2);

  -- 778. コスト
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'コスト', 'こすと', '코스트, 비용', NULL, '명사', 778, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コストを下げる。', '비용을 낮춘다.', 1),
    (w, 'コストパフォーマンスがよい。', '가성비가 좋다.', 2);

  -- 779. 値打ち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '値打ち', 'ねうち', '흥정', '値(값 치)
打(칠 타)', '명사', 779, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '値打ちして買った。', '흥정해서 샀다.', 1),
    (w, '値打ち交渉をした。', '가격 협상을 했다.', 2);

  -- 780. オープン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'オープン', 'おーぷん', '오픈', NULL, 'な형용사', 780, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'オープンな会社だ。', '오픈한 회사다.', 1),
    (w, 'オープンソースだ。', '오픈 소스다.', 2);

  -- 781. 上品
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '上品', 'じょうひん', '고상', '上(윗 상)
品(물건 품)', 'な형용사', 781, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上品な言葉を使う。', '고상한 말을 쓴다.', 1),
    (w, '上品な振る舞いだ。', '고상한 행동이다.', 2);

  -- 782. 軽々
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軽々', 'かるがる', '가볍게, 경쾌하게', '軽(가벼울 경)', '부사', 782, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽々とした足取りだ。', '가벼운 발걸음이다.', 1),
    (w, '軽々しい身なりだ。', '경쾌한 차림이다.', 2);

  -- 783. 複製
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '複製', 'ふくせい', '복제', '複(겹칠 복)
製(지을 제)', '명사', 783, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ファイルを複製する。', '파일을 복제한다.', 1),
    (w, '複製禁止だ。', '복제 금지다.', 2);

  -- 784. 例外
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '例外', 'れいがい', '예외', '例(법식 례)
外(밖 외)', '명사', 784, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '例外は認めない。', '예외는 인정하지 않는다.', 1),
    (w, '例外として許可した。', '예외로 허가했다.', 2);

  -- 785. スクリーン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'スクリーン', 'すくりーん', '스크린', NULL, '명사', 785, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'スクリーンをタッチする。', '스크린을 터치한다.', 1),
    (w, 'スクリーンが割れた。', '스크린이 깨졌다.', 2);

  -- 786. 冷静
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '冷静', 'れいせい', '냉정', '冷(천 령)
静(고요할 정)', 'な형용사', 786, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冷静に判断した。', '냉정하게 판단했다.', 1),
    (w, '冷静さを保つ。', '냉정함을 유지한다.', 2);

  -- 787. 仕掛ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '仕掛ける', 'しかける', '걸어 놓다, 일을 시작하다', '仕(섬길 사)
掛(걸 구)', '동사', 787, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を仕掛けた。', '일을 시작했다.', 1),
    (w, 'しかけている仕事がある。', '하다가 말아둔 일이 있다.', 2);

  -- 788. 起こす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '起こす', 'おこす', '일으키다', '起(일어날 기)', '동사', 788, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件を起こす。', '사건을 일으키다.', 1),
    (w, '関心を起こした。', '관심을 자아냈다.', 2);

  -- 789. 限り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '限り', 'かぎり', '한, 한한, 한도', '限(한계 한)', '명사', 789, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できる限り努力した。', '가능한 한 노력했다.', 1),
    (w, 'ひとりでいる限り、遇〶しい。', '혼자 있는 한 쓸쓸하다.', 2);

  -- 790. 艶やか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '艶やか', 'つややか', '윤이 남, 육머마먹은 근사해 보임', '艶(고울 염)', 'な형용사', 790, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '艶やかな肌だ。', '광칍이 남 피부다.', 1),
    (w, '艶やかな口調だ。', '우아한 어조다.', 2);

  -- 791. デザイン
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'デザイン', 'でざいん', '디자인', NULL, '명사', 791, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デザインの仕事をしている。', '디자인 일을 하고 있다.', 1),
    (w, 'デザインがおしゃれだ。', '디자인이 세련되었다.', 2);

  -- 792. ストレス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'ストレス', 'すとれす', '스트레스', NULL, '명사', 792, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ストレスがたまる。', '스트레스가 쌓인다.', 1),
    (w, 'ストレスを発散する。', '스트레스를 해소한다.', 2);

  -- 793. 領収
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '領収', 'りょうしゅう', '영수', '領(거느릴 령)
収(거둘 수)', '명사', 793, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '領収書をもらう。', '영수증을 받는다.', 1),
    (w, '荷物を領収する。', '짐을 수령한다.', 2);

  -- 794. 誌る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '誌る', 'しるす', '기록하다', '誌(기록할 지)', '동사', 794, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な事を誌す。', '중요한 일을 기록한다.', 1),
    (w, '歴史に誌される。', '역사에 기록된다.', 2);

  -- 795. 代わり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '代わり', 'かわり', '대신', '代(대신할 대)', '명사', 795, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の代わりに行ってくれ。', '나 대신 가줘.', 1),
    (w, '代わりにこれを使おう。', '대신 이걸 쓰자.', 2);

  -- 796. 進路
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '進路', 'しんろ', '진로, 진학 또는 진출길', '進(나아갈 진)
路(길 로)', '명사', 796, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '進路を決める。', '진로를 결정한다.', 1),
    (w, '進路に悩んでいる。', '진로에 대해 고민하고 있다.', 2);

  -- 797. 逕る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '逕る', 'おくる', '보내다', '逕(보낼 송)', '동사', 797, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '荷物を逕る。', '짐을 보낸다.', 1),
    (w, '友達を逕る。', '친구를 배웅한다.', 2);

  -- 798. 適合
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '適合', 'てきごう', '적합', '適(맞을 적)
合(합할 합)', 'な형용사', 798, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この職に適合した人だ。', '이 직책에 적합한 사람이다.', 1),
    (w, '条件に適合する。', '조건에 부합한다.', 2);

  -- 799. 記憶
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '記憶', 'きおく', '기억', '記(기록할 기)
憶(기억할 억)', '명사', 799, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶が鮮明だ。', '기억이 선명하다.', 1),
    (w, '如い記憶だ。', '존궼 기억이다.', 2);

  -- 800. 作る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '作る', 'つくる', '만들다', '作(지을 작)', '동사', 800, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理を作る。', '요리를 만든다.', 1),
    (w, '能助の股を作る。', '도움이 되는 입방을 만들다.', 2);

  -- 801. チャンス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'チャンス', 'ちゃんす', '찬스', NULL, '명사', 801, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'チャンスをつかむ。', '찬스를 잡는다.', 1),
    (w, '今がチャンスだ。', '지금이 기회다.', 2);

  -- 802. 進める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '進める', 'すすめる', '나아가게 하다, 진행하다', '進(나아갈 진)', '동사', 802, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事を進める。', '일을 진행한다.', 1),
    (w, '計画を進める。', '계획을 추진한다.', 2);

  -- 803. とても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'とても', '매우, 도저히', NULL, '부사', 803, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'とても面白い。', '매우 재미있다.', 1),
    (w, 'とてもできない。', '도저히 할 수 없다.', 2);

  -- 804. 取り出す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '取り出す', 'とりだす', '꺼내다', '取(가질 취)
出(날 출)', '동사', 804, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'カバンから本を取り出した。', '가방에서 책을 꺼냈다.', 1),
    (w, '財布を取り出す。', '지갑을 꺼낸다.', 2);

  -- 805. 規模さ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '規模さ', 'さわおくさ', '떠들석, 소란함', '規(소란할 소)
模(소란할 소)', '명사', 805, array[]::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その規模さの中にいる。', '그 떠들석 속에 있다.', 1),
    (w, '規模さを起こした。', '떠들석을 만들었다.', 2);

  -- 808. 踏襲する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '踏襲する', 'とうしゅうする', '답습하다', '踏(밟을 답): 이전 자꿨를 이어받음
襲(엄습할 습): 그대로 계승함을 의미', '동사', 808, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '前任の方針を踏襲する。', '전임자의 방침을 답습한다.', 1),
    (w, '伝統を踏襲した作品だ。', '전통을 답습한 작품이다.', 2);

  -- 809. 健やかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '健やかな', 'すこやかな', '건강한', '健(굳셈 건): 亻(사람)+建(세움) → 튼튼한 사람
やか: 굳셈·온화를 나타내는 접미사', 'な형용사', 809, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健やかな成長を願う。', '건강한 성장을 기원한다.', 1),
    (w, '健やかな毎日を送る。', '건강한 나날을 보낸다.', 2);

  -- 810. 顕著な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '顕著な', 'けんちょな', '현저한', '顕(나타날 현): 명확하게 드러남
著(나타날 저): 뚜렷이 보임', 'な형용사', 810, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '顕著な進歩が見られる。', '현저한 발전이 보인다.', 1),
    (w, '顕著に業績が上がった。', '뚜렷하게 실적이 올랐다.', 2);

  -- 811. 膨大な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '膨大な', 'ぼうだいな', '방대한', '膨(부풀 팡): 크게 부풀어오름
大(큰 대): 규모가 클', 'な형용사', 811, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '膨大な資料を整理する。', '방대한 자료를 정리한다.', 1),
    (w, '膨大な費用がかかる。', '방대한 비용이 든다.', 2);

  -- 812. 克服する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '克服する', 'こくふくする', '극복하다', '克(이길 극): 힘들게 이겨내움
服(옷 복/따를 복): 굴복시키다', '동사', 812, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '困難を克服した。', '어려움을 극복했다.', 1),
    (w, '苦手意識を克服する。', '아김 의식을 극복한다.', 2);

  -- 813. 披露する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '披露する', 'ひろうする', '피로하다, 공개하다', '披(머리권펼 피): 돌릴이며 그읽
露(이슬 로): 숨기지 않고 드러냄', '동사', 813, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手才を披露した。', '소쟈을 공개했다.', 1),
    (w, '新作を披露する。', '신작을 공개한다.', 2);

  -- 814. 貢献する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '貢献する', 'こうけんする', '공헌하다', '貢(바친 공): 돈·물건을 바치다
献(드릴 헌): 안으로 모시고 바치다', '동사', 814, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会に貢献する。', '사회에 공헌한다.', 1),
    (w, 'チームの勝利に貢献した。', '팀의 승리에 공헌했다.', 2);

  -- 815. 干渉する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '干渉する', 'かんしょうする', '간섭하다', '干(마를 간): 차이에 개입
渉(건널 섭): 물을 건너다 → 다른 영역으로 옮김', '동사', 815, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '他人の事に干渉しない。', '타인의 일에 간섭하지 않는다.', 1),
    (w, '干渉主義を批判する。', '간섭주의를 비판한다.', 2);

  -- 816. 巧妙な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '巧妙な', 'こうみょうな', '교묘한', '巧(공교할 교): 소널 속임수가 뛰어남
妙(묘할 묘): 미묘하고 못느뜜 수준', 'な형용사', 816, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '巧妙な手口だ。', '교몦한 수법이다.', 1),
    (w, '巧妙に逃げた。', '교몦하게 도망첤다.', 2);

  -- 817. 閉鎖する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '閉鎖する', 'へいさする', '폐쇄하다', '閉(닫을 폐): 문을 닫다
鎖(쇠사슬 쇄): 자물쇠로 잠귀다', '동사', 817, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工場を閉鎖した。', '공장을 폐쇄했다.', 1),
    (w, '一部道路が閉鎖された。', '일부 도로가 폐쇄되었다.', 2);

  -- 818. 治癒する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '治癒する', 'ちゆする', '치유하다', '治(다스릴 치): 멸을 다스릴
癒(병 나을 유): 아프는 데가 낙아 좋아짐', '동사', 818, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '傷が治癒した。', '상처가 치유되었다.', 1),
    (w, '時間が心を治癒する。', '시간이 마음을 치유한다.', 2);

  -- 819. 克明に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '克明に', 'こくめいに', '극명하게', '克(이길 극): 철저하게 다하다
明(밝을 명): 환히 드러남', '부사', 819, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件を克明に記録した。', '사건을 극명하게 기록했다.', 1),
    (w, '当時の状況を克明に描く。', '당시 상황을 극명하게 그린다.', 2);

  -- 820. 緊迫する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '緊迫する', 'きんぱくする', '긴박하다', '緊(긴할 긴): 팭팭하게 명·당김
迫(닥칠 박): 따지고 조이는 상태', '동사', 820, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '状況が緊迫している。', '상황이 긴박하다.', 1),
    (w, '緊迫した雰囲気だ。', '긴박한 분위기다.', 2);

  -- 821. 誇張する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '誇張する', 'こちょうする', '과장하다', '誇(자랑할 과): 실제보다 크게 말함
張(베풀 장): 늘여 대서스럽게 만듬', '동사', 821, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話を誇張して伝える。', '이야기를 과장해서 전한다.', 1),
    (w, '誇張表現を避ける。', '과장 표현을 피한다.', 2);

  -- 822. 軽率な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '軽率な', 'けいそつな', '경솔한', '軽(가벼울 경): 생각이 가볍움
率(거느릴 솔/비율 률): 신중함이 없이 움직임', 'な형용사', 822, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '軽率な発言だった。', '경솔한 발언이었다.', 1),
    (w, '軽率に判断しない。', '경솔하게 판단하지 않는다.', 2);

  -- 823. 調達
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '調達', 'ちょうたつ', '조달', '調(고를 조): 필요에 맞게 준비
達(통달할 달): 던탐어·어꿳이 달성', '명사', 823, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資金を調達する。', '자금을 조달한다.', 1),
    (w, '部品の調達が難しい。', '부품 조달이 어렵다.', 2);

  -- 824. めきめき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'めきめき', 'めきめき', '눈에 띄게, 못볼 사이에', 'めきめき: 일본어 의성어(의태어) → 높이가 눈에 띄게 좋아지는 모습', '부사', 824, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'めきめき上達している。', '눈에 띄게 실력이 늘고 있다.', 1),
    (w, '成績がめきめき伸びた。', '성적이 보는 대로 올랐다.', 2);

  -- 826. かなう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, 'かなう', 'かなう', '이루어지다 (꿈이)', '叶う: 마음에 드는 대로 되다
〔·望·꿈이 이루어진다〕는 뜯으로 관용적으로 쓰임', '동사', 826, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年の夢がかなった。', '오랭동안의 꿈이 이루어졌다.', 1),
    (w, '願いがかなうように祈る。', '소원이 이루어지기를 빌다.', 2);

  -- 827. ブランク
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ブランク', '블랭크, 공백', '英어 blank의 일본어 차용
온라인·이력서 등에서 경력이 없의 공백기간을 나타냄', '명사', 827, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事のブランクが長い。', '일의 공백기간이 길다.', 1),
    (w, 'ブランクを埋める。', '공백을 메운다.', 2);

  -- 830. 工面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '工面', 'くめん', '자금 마련', '工(장인 공): 손으로 일을 함
面(낮 면): 만난 상황 → 애써 구말하고 장소함', '명사', 830, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '学費を工面する。', '학비를 마련한다.', 1),
    (w, 'やっと資金の工面がついた。', '결국 자금 마련이 되었다.', 2);

  -- 837. 互角
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '互角', 'ごかく', '호각, 비등함', '互(서로 호): 서로 어그다·교환
角(뿔 각): 소의 뿔 → 뚟각이 비슷한 세력', '명사', 837, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '互角の勝負だった。', '호각의 승부였다.', 1),
    (w, '両者は互角に渡り合う。', '양자는 비등하게 견제한다.', 2);

  -- 838. 円滑
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '円滑', 'えんかつ', '원활', '円(둥근 원): 원·머니·둘레
滑(미끄러울 활): 골이 끊김이 없이 진행됨', '명사', 838, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '交渉が円滑に進んだ。', '협상이 원활하게 진행되었다.', 1),
    (w, '業務の円滑化を図る。', '업무의 원활화를 꿀한다.', 2);

  -- 839. かたくな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'かたくな', '완고함, 고집스러울', 'かたくな: 堅い(단단한)에서 파생된 고어·자신의 뜻을 절대 굴히지 않는 태도', 'な형용사', 839, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'かたくな態度を崩さない。', '완고한 태도를 굴히지 않는다.', 1),
    (w, 'かたくに拒否した。', '고집스레 거부했다.', 2);

  -- 840. 絶大
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, '絶大', 'ぜつだい', '절대, 아주 큼', '絶(끊을 절): 다른 것과 비교 불가
大(큰 대): 극도로 클', 'な형용사', 840, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '絶大な人気を誇る。', '절대적인 인기를 끜다.', 1),
    (w, '絶大の信頼を得る。', '절대적 신뢰를 얻는다.', 2);

  -- 842. デマ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'デマ', '헛소문, 유언비어, 가짜 뉴스', '독일어 Demagogie·영어 demagogue에서 온 외래어
원래 선동적 대중 조종을 뜻했으나, 일본어에서는 근거 없는 소문·가짜 뉴스를 의미', '명사', 842, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'デマに惑わされるな。', '헛소문에 혼동하지 마라.', 1),
    (w, 'ネット上でデマが拡散した。', '온라인에서 가짜 뉴스가 퍼졌다.', 2);

  -- 843. コンスタント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'コンスタント', '일정함, 항상적인', '英어 constant(일정한, 불변의)의 일본어 차용
수치·성적·소득 등이 안정적으로 유지되는 상태', 'な형용사', 843, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コンスタントに成果を出す。', '꾸준히 성과를 낸다.', 1),
    (w, '売り上げがコンスタントだ。', '매출이 일정하다.', 2);

  -- 844. ありきたり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values (d_n1, NULL, 'ありきたり', '흔함, 평범함', 'あり(ある·있다) + きたり(···가도 됨·속　이함)
···어디에나 있을 법하고 흔한 것', 'な형용사', 844, array['pdf_extracted']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ありきたりなデザインだ。', '흔한 디자인이다.', 1),
    (w, 'ありきたりな話をしたくない。', '흔한 이야기는 하고 싶지 않다.', 2);

  -- ============================================================
  -- N1 문법 595항목 풀스펙 재구성 (어원+예문 2개씩 + sub 분류)
  -- 형식판단 266 (#845~1110) + 문장완성 205 (#1111~1315) + 문맥이해 124 (#1316~1439)
  -- ============================================================

  -- ============================================================
  -- 문법-형식판단 266개 (PDF p.33~46)
  -- ============================================================

  -- 845. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～はずだ', '~할 것이다 <확신>', '名詞 はず(筈·이치/예정)+だ. 「당연히 그러할 것」', '문법-형식판단', 845, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼はもう来るはずだ。', '그는 곧 올 것이다.', 1),
    (w, '約束したからにはやるはずだ。', '약속한 이상은 할 것이다.', 2);

  -- 846. ～ほどのことではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ほどのことではない', '~할 정도의 일이 아니다', 'ほど(정도)+の+こと(일)+ではない. 「그 정도의 일은 아님」', '문법-형식판단', 846, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心配するほどのことではない。', '걱정할 정도의 일이 아니다.', 1),
    (w, '騒ぐほどのことではないだろう。', '소란 피울 정도의 일은 아닐 것이다.', 2);

  -- 847. ～を機に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を機に', '~을 계기로, ~을 기회로', '機(베틀 기·계기): 어떤 일을 시작하는 시점. 「~을 전환점으로」', '문법-형식판단', 847, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚を機に仕事を辞めた。', '결혼을 계기로 일을 그만뒀다.', 1),
    (w, '入院を機に禁煙を決意した。', '입원을 계기로 금연을 결심했다.', 2);

  -- 848. ～あげく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～あげく', '~한 끝에', '挙(들 거)げ句: 連歌의 마지막 句. 「~한 결과 끝에」 부정적 결말', '문법-형식판단', 848, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '悩んだあげく辞めることにした。', '고민한 끝에 그만두기로 했다.', 1),
    (w, '迷ったあげくに買わなかった。', '망설인 끝에 사지 않았다.', 2);

  -- 849. 思えるくらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思えるくらい', 'おもえるくらい', '생각이 들 정도로', '思(생각할 사)える(가능형)+くらい(정도). 「~라고 생각될 정도」', '문법-형식판단', 849, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢かと思えるくらい嬉しかった。', '꿈인가 싶을 정도로 기뻤다.', 1),
    (w, '同一人物と思えるくらい似ている。', '동일 인물로 생각될 정도로 닮았다.', 2);

  -- 850. ～かっていうと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かっていうと', '~인가 하면', 'か(의문)+って(라고)+いう+と. 회화체. 「~냐 하면 (실은~)」', '문법-형식판단', 850, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '好きかっていうと、そうでもない。', '좋아하냐 하면, 그렇지도 않다.', 1),
    (w, '簡単かっていうと、難しい。', '쉬운가 하면, 어렵다.', 2);

  -- 851. ～(さ)せられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(さ)せられる', '~하게 되다 <사역수동>', '사역(せる)+수동(られる). 「~을 (마지못해) 당하다」', '문법-형식판단', 851, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上司に残業させられた。', '상사가 시켜 잔업하게 되었다.', 1),
    (w, '考えさせられる話だった。', '생각하게 되는 이야기였다.', 2);

  -- 852. ～する以上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～する以上', '~하는 이상', '以(써 이)+上(위 상): 「~한 시점 이상에는」 결심·논리적 귀결', '문법-형식판단', 852, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '引き受ける以上は最後までやる。', '맡는 이상은 끝까지 한다.', 1),
    (w, '約束する以上、守るべきだ。', '약속하는 이상 지켜야 한다.', 2);

  -- 853. ～でしかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～でしかない', '~밖에 되지 않는다', 'で+しか(밖에)+ない. 「~에 지나지 않다」 한정·평가절하', '문법-형식판단', 853, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは言い訳でしかない。', '그것은 변명에 지나지 않는다.', 1),
    (w, '彼にとって金は紙でしかない。', '그에게 돈은 종이에 불과하다.', 2);

  -- 854. ～と
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と', '~라는(내용 제시)', '引用(인용) 조사 と. 「~라는」 내용 제시', '문법-형식판단', 854, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やめると言った。', '그만둔다고 말했다.', 1),
    (w, '行くと決めた。', '간다고 결정했다.', 2);

  -- 855. ～といったところだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といったところだ', '~라는 정도다', 'と+いった+ところ(곳·정도)+だ. 「대략 ~인 정도」', '문법-형식판단', 855, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '月給は20万円といったところだ。', '월급은 20만엔 정도다.', 1),
    (w, '出席率は半分といったところだ。', '출석률은 절반 정도다.', 2);

  -- 856. ～ないでもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないでもない', '~않는 것도 아니다', 'ない(부정)+で+も+ない(이중부정). 「~할 수도 있다」 완곡 긍정', '문법-형식판단', 856, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気持ちは分からないでもない。', '심정은 모르는 것도 아니다.', 1),
    (w, '考えないでもない。', '생각해 보지 않는 것도 아니다.', 2);

  -- 857. ～につけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～につけ', '~할 때마다', '付(붙을 부)け: 「~에 결부되어」 자연스러운 연상·반복', '문법-형식판단', 857, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この曲を聞くにつけ、彼を思い出す。', '이 곡을 들을 때마다 그를 떠올린다.', 1),
    (w, '何かにつけ文句を言う。', '뭔가 있을 때마다 불평한다.', 2);

  -- 858. ～ていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ていただく', '~해 주시다', 'て+いただく(もらう의 겸양). 「(상대로부터) 해 받다」', '문법-형식판단', 858, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生に教えていただいた。', '선생님께서 가르쳐 주셨다.', 1),
    (w, 'お話を聞かせていただきます。', '말씀을 들려 받겠습니다.', 2);

  -- 859. ～わけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～わけではない', '~인 것은 아니다', '訳(번역할 역·이유)+ではない. 「~라는 것은 아니다」 부분 부정', '문법-형식판단', 859, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嫌いなわけではない。', '싫어하는 것은 아니다.', 1),
    (w, '全部知っているわけではない。', '전부 알고 있는 것은 아니다.', 2);

  -- 860. ～を受けて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を受けて', '~을 반영하여, ~의 영향을 받아', '受(받을 수)けて: 「~을 받아들여」 결과·반응', '문법-형식판단', 860, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '指摘を受けて改善した。', '지적을 받아 개선했다.', 1),
    (w, '要望を受けて対応した。', '요청을 반영해 대응했다.', 2);

  -- 861. お～する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'お～する', 'お～する', '제공하다 <겸양>', '접두어 お+ます형+する. 「제가 ~해 드리다」 겸양 표현', '문법-형식판단', 861, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私がお持ちします。', '제가 들어 드리겠습니다.', 1),
    (w, 'お送りします。', '보내 드리겠습니다.', 2);

  -- 862. ～がたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～がたい', '~하기 곤란하다', '難(어려울 난)い의 활용 형태. 「~하기 어렵다」 격식체', '문법-형식판단', 862, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '信じがたい話だ。', '믿기 어려운 이야기다.', 1),
    (w, '理解しがたい行動。', '이해하기 어려운 행동.', 2);

  -- 863. ～こととする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こととする', '~하기로 하다', 'こと(일)+と+する. 「~하기로 정하다」 격식체 결정', '문법-형식판단', 863, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出張は中止することとする。', '출장은 중지하기로 한다.', 1),
    (w, '会議は明日とすることにした。', '회의는 내일로 하기로 했다.', 2);

  -- 864. ～した＋ではないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～した＋ではないか', '하는 것이 아닌가! <놀람>', 'た+ではないか. 「~한 게 아니야!」 놀람·확인', '문법-형식판단', 864, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何だ、もう来たではないか。', '뭐야, 벌써 온 게 아니야!', 1),
    (w, 'うまくいったではないか。', '잘 됐잖아!', 2);

  -- 865. つもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'つもり', '생각, 작정', '積(쌓을 적)もり의 옛 의미. 「마음에 쌓아 둔 생각」 의도', '문법-형식판단', 865, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くつもりだ。', '갈 작정이다.', 1),
    (w, '冗談のつもりだった。', '농담할 작정이었다.', 2);

  -- 866. ～ではあるまいし
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ではあるまいし', '~도 아닐 테고', 'では+ある+まい(부정 추량)+し. 「~인 것도 아닐 텐데」', '문법-형식판단', 866, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供ではあるまいし、自分でやれ。', '아이도 아닐 테고, 직접 해라.', 1),
    (w, '初めてではあるまいし、慌てるな。', '처음도 아닐 테고, 당황하지 마라.', 2);

  -- 867. ～とあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とあって', '~라서 <원인>', 'と+あって. 「~라는 상황이라서」 특별한 원인', '문법-형식판단', 867, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '初公演とあって満員だ。', '첫 공연이라서 만원이다.', 1),
    (w, '連休とあって渋滞している。', '연휴라서 정체되고 있다.', 2);

  -- 868. ～としても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～としても', '~라고는 해도', 'と+しても. 「~라 하더라도」 가정적 양보', '문법-형식판단', 868, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安いとしても買わない。', '싸다 해도 안 산다.', 1),
    (w, '本当だとしても信じない。', '사실이라 해도 믿지 않는다.', 2);

  -- 869. ～ならではの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ならではの', '~다운, ~만의', 'なら+で+は(부정)+の. 「~가 아니고서는 없는」 고유성', '문법-형식판단', 869, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '京都ならではの風景。', '교토만의 풍경.', 1),
    (w, '彼ならではの発想だ。', '그만이 할 수 있는 발상이다.', 2);

  -- 870. ～願えますか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～願えますか', '~해 주시겠습니까?', '願(원할 원)える: 「~을 청하다」의 정중형. 격식체 부탁', '문법-형식판단', 870, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご確認願えますか。', '확인해 주시겠습니까?', 1),
    (w, 'お電話願えますか。', '전화 주시겠습니까?', 2);

  -- 871. ～ゆえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ゆえに', '~때문에', '故(까닭 고)에. 「까닭으로」 격식·논리적 원인', '문법-형식판단', 871, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若いゆえに過ちもある。', '젊기 때문에 잘못도 있다.', 1),
    (w, '貧しさゆえに苦労した。', '가난 때문에 고생했다.', 2);

  -- 872. ～わけにはいかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～わけにはいかない', '~할 수는 없다', '訳(이유)+に+は+いかない. 「(상황상) ~할 수는 없다」', '문법-형식판단', 872, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日休むわけにはいかない。', '오늘 쉴 수는 없다.', 1),
    (w, '黙っているわけにはいかない。', '잠자코 있을 수는 없다.', 2);

  -- 873. あがる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '上がる', 'あがる', '찾아뵙다 <겸양>', '上(위 상)がる: 「오르다·올라가다」 → 윗사람께 「찾아 뵙다」 겸양어', '문법-형식판단', 873, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日お宅にあがります。', '내일 댁으로 찾아뵙겠습니다.', 1),
    (w, '部長のところへあがる。', '부장님께 찾아뵙다.', 2);

  -- 874. ～かねる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かねる', '~하기 곤란하다', '兼(겸할 겸)ねる: 「~을 함께하기 어렵다」 격식체 거절', '문법-형식판단', 874, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お答えしかねます。', '답변 드리기 어렵습니다.', 1),
    (w, '判断しかねる状況だ。', '판단하기 어려운 상황이다.', 2);

  -- 875. ご変更願いたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'ご変更願いたい', 'ごへんこうねがいたい', '변경을 부탁드리고 싶다', 'ご+変更(변경)+願いたい(부탁드리고 싶다). 격식체 요청', '문법-형식판단', 875, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日程をご変更願いたい。', '일정을 변경해 주시기 바랍니다.', 1),
    (w, '提出期限のご変更願いたく存じます。', '제출 기한 변경을 부탁드리고 싶습니다.', 2);

  -- 876. ～ざる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ざる', '~할 수 없는', '문어 부정 조동사 ず의 연체형. 「~할 수 없는」 격식체', '문법-형식판단', 876, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言わざるを得ない。', '말하지 않을 수 없다.', 1),
    (w, '見逃すべからざる行為。', '간과해서는 안 되는 행위.', 2);

  -- 877. ～そうになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～そうになる', '~할 것 같이 되다', 'そう(양태)+に+なる. 「하마터면 ~할 뻔하다」', '문법-형식판단', 877, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転びそうになった。', '넘어질 뻔했다.', 1),
    (w, '泣きそうになる。', '울 것 같이 된다.', 2);

  -- 878. ～だろうと～だろうと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だろうと～だろうと', '~이든 ~이든', '추량 だろう+と의 반복. 「A든 B든 관계없이」', '문법-형식판단', 878, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だろうと雪だろうと行く。', '비든 눈이든 간다.', 1),
    (w, '誰だろうと許さない。', '누구든 용서하지 않는다.', 2);

  -- 879. ～といいましょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といいましょうか', '~라고나 할까', 'と+いう+ましょう(권유)+か(의문). 「~라고 할까」 표현 모색', '문법-형식판단', 879, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '優しいといいましょうか、甘いです。', '다정하다고 할까, 무르다.', 1),
    (w, '不器用といいましょうか、誠実だ。', '서툴다고 할까, 성실하다.', 2);

  -- 880. ～に伴って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に伴って', '~에 따라서', '伴(짝 반): 「~과 동반하여」 동시 변화', '문법-형식판단', 880, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人口増加に伴って需要も増える。', '인구 증가에 따라 수요도 늘어난다.', 1),
    (w, '気温上昇に伴って氷が溶ける。', '기온 상승에 따라 얼음이 녹는다.', 2);

  -- 881. まず～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'まず～ない', '거의 ~않는다', '副詞 まず(先·우선)+부정. 「우선 ~하지 않을 것이다」 강한 부정 추량', '문법-형식판단', 881, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が遅れることはまずない。', '그가 늦는 일은 거의 없다.', 1),
    (w, 'まず失敗しない方法。', '거의 실패하지 않는 방법.', 2);

  -- 882. AもA
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'AもA', 'A도 A <A를 강조>', '같은 명사 반복+も. 「A도 A 나름이다」 강조·평가', '문법-형식판단', 882, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗も失敗、大失敗だ。', '실패도 실패, 대실패다.', 1),
    (w, '冗談も冗談、限度がある。', '농담도 농담, 한도가 있다.', 2);

  -- 883. 동사의 ます형＋よう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '動詞のます形＋よう', '~하는 방법', '様(모양 양): 「방법·모양」 격식체 명사 접미사', '문법-형식판단', 883, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言いようがない。', '말할 방법이 없다.', 1),
    (w, 'やりようを考える。', '할 방법을 생각하다.', 2);

  -- 884. いたす
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '致す', 'いたす', '하다 <겸양>', '致(이를 치)す: する의 겸양어. 「제가 ~해 드리다」', '문법-형식판단', 884, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私が担当いたします。', '제가 담당하겠습니다.', 1),
    (w, 'ご案内いたします。', '안내해 드리겠습니다.', 2);

  -- 885. ～から言えば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～から言えば', '~로 보아', 'から(부터)+言(말씀 언)えば. 「~의 관점에서 보면」', '문법-형식판단', 885, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経験から言えば失敗する。', '경험으로 보아 실패한다.', 1),
    (w, '常識から言えばあり得ない。', '상식으로 보아 있을 수 없다.', 2);

  -- 886. ～させられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～させられる', '~하게 되다 <사역수동>', '사역 させる+수동 られる. 「(누가 시켜) ~을 당하다」', '문법-형식판단', 886, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長時間待たされた。', '오랫동안 기다리게 되었다.', 1),
    (w, '深く考えさせられた。', '깊이 생각하게 되었다.', 2);

  -- 887. ～そうにない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～そうにない', '~할 것 같지 않다', '양태 そう+に+ない. 「~할 가망이 없다」', '문법-형식판단', 887, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日中に終わりそうにない。', '오늘 중에 끝날 것 같지 않다.', 1),
    (w, '雨はやみそうにない。', '비는 그칠 것 같지 않다.', 2);

  -- 888. ～ためを思って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ためを思って', '~을 위해서, ~을 염려하여', '為(할 위)+を+思って. 「~을 위해 생각하여」', '문법-형식판단', 888, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君のためを思って言うのだ。', '너를 위해서 하는 말이다.', 1),
    (w, '将来のためを思って貯金する。', '장래를 염려해 저축한다.', 2);

  -- 889. ～てほしいものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てほしいものだ', '~해 주었으면 좋겠다', 'て+ほしい(원함)+ものだ. 「(꼭) ~해 주길 바라다」 감정 강조', '문법-형식판단', 889, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう少し努力してほしいものだ。', '조금 더 노력해 줬으면 좋겠다.', 1),
    (w, '理解してほしいものだ。', '이해해 줬으면 좋겠다.', 2);

  -- 890. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～として', '~라고 하여', 'と+して. 「~의 자격·입장·이유로」', '문법-형식판단', 890, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教師として働く。', '교사로서 일하다.', 1),
    (w, '記念として贈る。', '기념으로 보내다.', 2);

  -- 891. ～べく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～べく', '~하기 위해서', '可(옳을 가)き의 부사형. 「~할 목적으로」 격식체', '문법-형식판단', 891, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢を実現すべく努力する。', '꿈을 실현하기 위해 노력한다.', 1),
    (w, '事故を防ぐべく対策を講じる。', '사고를 막기 위해 대책을 강구하다.', 2);

  -- 892. ～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～も', '~도 <강조>', '계조사 も. 「~까지도」 강조·놀람·정도', '문법-형식판단', 892, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一週間も雨が続く。', '일주일이나 비가 계속된다.', 1),
    (w, '彼に会えるとは思いもしなかった。', '그를 만날 줄은 생각도 못 했다.', 2);

  -- 893. もらってやってください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'もらってやってください', '받아 주세요', 'もらう+やる(주다 겸양)+ください. 「(부디) 받아 주십시오」', '문법-형식판단', 893, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このお菓子、もらってやってください。', '이 과자, 받아 주세요.', 1),
    (w, '気持ちだけでも、もらってやってください。', '마음만이라도 받아 주세요.', 2);

  -- 894. ～ようがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようがない', '~할 방도가 없다', 'よう(様·방법)+が+ない. 「~할 방법이 없다」', '문법-형식판단', 894, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '連絡しようがない。', '연락할 방도가 없다.', 1),
    (w, '助けようがなかった。', '도와줄 방법이 없었다.', 2);

  -- 895. おっしゃってくださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '仰ってくださる', 'おっしゃってくださる', '말씀해 주시다 <존경>', '仰(우러를 앙)る: 「말씀하시다」 존경어+くださる', '문법-형식판단', 895, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生がおっしゃってくださった。', '선생님께서 말씀해 주셨다.', 1),
    (w, 'もう一度おっしゃってくださいませ。', '한 번 더 말씀해 주십시오.', 2);

  -- 896. かつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'かつ', '및, 또한', '접속사 かつ(且·또 차). 「게다가·또한」 격식체 병렬', '문법-형식판단', 896, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '速くかつ正確に。', '빠르고 또한 정확하게.', 1),
    (w, '健康かつ安全である。', '건강하고도 안전하다.', 2);

  -- 897. ご覧になる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'ご覧になる', 'ごらんになる', '보시다 <존경>', 'ご+覧(볼 람)+になる. 見る(보다)의 존경 표현', '문법-형식판단', 897, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '資料をご覧になってください。', '자료를 봐 주세요.', 1),
    (w, 'こちらをご覧になりますか。', '이쪽을 보시겠습니까?', 2);

  -- 898. ～だけでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけでも', '~만으로도', 'だけ(한정)+でも(이라도). 「~만 해도」 최소 양보', '문법-형식판단', 898, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気持ちだけでも嬉しい。', '마음만으로도 기쁘다.', 1),
    (w, '見るだけでも価値がある。', '보기만 해도 가치가 있다.', 2);

  -- 899. ～とあっては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とあっては', '~라서, ~때문에', 'と+あって+は. 「~인 상황으로는」 특별한 사정', '문법-형식판단', 899, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長の命令とあっては従うしかない。', '사장의 명령이라 따를 수밖에 없다.', 1),
    (w, '最後とあっては大切にしたい。', '마지막이라서 소중히 하고 싶다.', 2);

  -- 900. どうしたものか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どうしたものか', '어떻게 하면 좋을까?', 'どう+した+もの+か. 「어찌해야 할지」 곤혹스러움', '문법-형식판단', 900, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ってきた。どうしたものか。', '비가 내리기 시작했다. 어쩌나.', 1),
    (w, '彼の機嫌が悪い。どうしたものか。', '그가 기분이 나쁘다. 어쩌나.', 2);

  -- 901. ～とく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とく', '~해 두다 <～ておく의 축약>', 'ておく의 회화 축약형. 「미리 ~해 두다」', '문법-형식판단', 901, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言っとく。', '말해 둔다.', 1),
    (w, 'やっとくね。', '해 둘게.', 2);

  -- 902. ～(さ)せてくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(さ)せてくれる', '~하게 해 주다', '사역 (さ)せる+てくれる. 「~을 허락해 주다」', '문법-형식판단', 902, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませてくれた。', '쉬게 해 주었다.', 1),
    (w, '考えさせてくれませんか。', '생각하게 해 주시지 않겠습니까?', 2);

  -- 903. ～にもほどがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にもほどがある', '~에도 정도가 있다', 'に+も+程(정도)+が+ある. 「도가 지나치다」 비난', '문법-형식판단', 903, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談にもほどがある。', '농담에도 정도가 있다.', 1),
    (w, '怠けるにもほどがある。', '게으름에도 정도가 있다.', 2);

  -- 904. AをAで終わらせない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'AをAで終わらせない', 'A를 A만으로 끝내지 않겠다', '동일 명사 반복+で+終わらせない. 「~을 단순한 ~로 그치지 않게 하다」', '문법-형식판단', 904, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗を失敗で終わらせない。', '실패를 실패로 끝내지 않는다.', 1),
    (w, '夢を夢で終わらせない。', '꿈을 꿈으로 끝내지 않는다.', 2);

  -- 905. 思われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思われる', 'おもわれる', '생각이 들다', '思う+れる(자발). 「자연스레 ~라고 느껴지다」', '문법-형식판단', 905, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の言葉が真実と思われる。', '그의 말이 사실이라고 생각된다.', 1),
    (w, '不思議に思われる事件。', '이상하게 느껴지는 사건.', 2);

  -- 906. 存じる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '存じる', 'ぞんじる', '생각하다 <겸양>', '存(있을 존)じる: 思う·知る의 겸양어. 격식체 1인칭', '문법-형식판단', 906, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お元気と存じます。', '건강하시리라 생각합니다.', 1),
    (w, 'よく存じております。', '잘 알고 있습니다.', 2);

  -- 907. ～だけに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけに', '~인 만큼 <당연>', 'だけ(한정)+に. 「~인 만큼 더욱」 원인·합당함', '문법-형식판단', 907, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦労しただけに喜びも大きい。', '고생한 만큼 기쁨도 크다.', 1),
    (w, 'プロだけに技術が違う。', '프로인 만큼 기술이 다르다.', 2);

  -- 908. ～といったらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といったらない', '몹시 ~하다', 'と+いったら+ない. 「말할 수 없을 정도」 강조', '문법-형식판단', 908, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の喜びようといったらなかった。', '그의 기뻐하는 모습은 말할 수 없을 정도였다.', 1),
    (w, '嬉しいといったらない。', '몹시 기쁘다.', 2);

  -- 909. ～と思いきや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と思いきや', '~라고 생각했더니', '문어 思いきや. 「~라 생각했는데 의외로」', '문법-형식판단', 909, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨と思いきや晴れた。', '비가 올 줄 알았더니 맑았다.', 1),
    (w, '成功と思いきや失敗だった。', '성공한 줄 알았는데 실패였다.', 2);

  -- 910. ～とするか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とするか', '~하기로 할까 <결심>', 'と+する+か. 「~으로 할까」 혼잣말 결심', '문법-형식판단', 910, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そろそろ帰るとするか。', '슬슬 돌아갈까.', 1),
    (w, '昼食にするとするか。', '점심으로 할까.', 2);

  -- 911. ～に言わせると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に言わせると', '~의 이야기로는, ~의 의견으로는', 'に+言わせる(사역)+と. 「~의 입장에서 말하자면」', '문법-형식판단', 911, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '父に言わせるとそれは甘い。', '아버지 말씀으로는 그것은 안일하다.', 1),
    (w, '私に言わせると違う。', '내 의견으로는 다르다.', 2);

  -- 912. はたして～だろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'はたして～だろうか', '과연 ~할까?', '果(과실 과)して+だろうか. 「정말로 ~일까」 의구심', '문법-형식판단', 912, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はたしてうまくいくだろうか。', '과연 잘 될까?', 1),
    (w, 'はたして真実だろうか。', '과연 사실일까?', 2);

  -- 913. ～をもって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をもって', '~로 <시간>', '以(써 이)って. 「~로써, ~을 가지고」 격식체 수단·시기', '문법-형식판단', 913, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本日をもって閉店いたします。', '오늘로 폐점합니다.', 1),
    (w, '誠意をもって対応する。', '성의로 대응한다.', 2);

  -- 914. するかしないかのころ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'するかしないかのころ', '막 ~했을 무렵', 'する+か+しない+か+の+ころ. 「~할락 말락 할 무렵」', '문법-형식판단', 914, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発するかしないかのころ電話が来た。', '출발할락 말락 할 때 전화가 왔다.', 1),
    (w, '寝るか寝ないかのころに鳴った。', '잠들락 말락 할 때 울렸다.', 2);

  -- 915. 頂戴する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '頂戴する', 'ちょうだいする', '받다 <겸양>', '頂(정수리 정)+戴(일 대): 「머리에 받들다」 もらう의 겸양어', '문법-형식판단', 915, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お土産を頂戴しました。', '선물을 받았습니다.', 1),
    (w, 'お時間を頂戴できますか。', '시간을 좀 내어 주시겠습니까?', 2);

  -- 916. できる限り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'できる限り', 'できるかぎり', '할 수 있는 한', 'できる(가능)+限(한할 한)り. 「가능한 한」', '문법-형식판단', 916, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できる限り早くお願いします。', '가능한 한 빨리 부탁드립니다.', 1),
    (w, 'できる限りのことはやった。', '할 수 있는 한의 일은 했다.', 2);

  -- 917. AというA
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'AというA', '모든 A는', '동일 명사 반복+という+A. 「A라고 하는 A 전부」 강조 망라', '문법-형식판단', 917, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '窓という窓を開けた。', '모든 창문을 열었다.', 1),
    (w, '客という客が帰った。', '모든 손님이 돌아갔다.', 2);

  -- 918. どうやら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どうやら', '아무래도', '副詞 どう(어떻게)+やら(인가). 「어쩐지·아무래도」 추측', '문법-형식판단', 918, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうやら雨らしい。', '아무래도 비가 올 것 같다.', 1),
    (w, 'どうやら間に合いそうだ。', '아무래도 시간에 맞출 것 같다.', 2);

  -- 919. ～なくはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なくはない', '~않는 것도 아니다', 'なく+は+ない. 이중부정. 「~할 수도 있다」 완곡 긍정', '문법-형식판단', 919, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行かなくはない。', '안 가는 것도 아니다.', 1),
    (w, '理解できなくはない。', '이해 못 하는 것도 아니다.', 2);

  -- 920. ～ものを
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものを', '~텐데', '物(물건 물)+を. 「~할 텐데」 후회·아쉬움 종조사', '문법-형식판단', 920, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言ってくれればよかったものを。', '말해 주었으면 좋았을 텐데.', 1),
    (w, '黙っていればいいものを。', '잠자코 있으면 됐을 텐데.', 2);

  -- 921. ～ようがない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようがない (#2)', '~할 방도가 없다', 'よう(様·방법)+が+ない. 강조 반복형', '문법-형식판단', 921, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '住所が分からないと、行きようがない。', '주소를 모르면 갈 방도가 없다.', 1),
    (w, '答えようがない質問。', '답할 방도가 없는 질문.', 2);

  -- 922. ～てまいる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てまいる', '~해 가다 <겸양>', 'て+参(참여할 참)る. 行く·来る의 겸양어. 「~해 가/오다」', '문법-형식판단', 922, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '努力してまいります。', '노력해 가겠습니다.', 1),
    (w, '勉強してまいりました。', '공부하고 왔습니다.', 2);

  -- 923. ～たら～たで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たら～たで', '~하면 하는 대로', 'たら+동사 た+で. 「~하면 ~한 대로 (다른 문제)」', '문법-형식판단', 923, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休んだら休んだで仕事が溜まる。', '쉬면 쉬는 대로 일이 쌓인다.', 1),
    (w, '雨が降ったら降ったで嬉しい。', '비가 오면 오는 대로 기쁘다.', 2);

  -- 924. ～ておらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ておらず', '~하지 않고 <상태>', 'て+おる(있다 겸양)+ず(부정 문어). 「~하지 않은 채」', '문법-형식판단', 924, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まだ届いておらず、確認できません。', '아직 도착하지 않아 확인할 수 없습니다.', 1),
    (w, '理解しておらず申し訳ない。', '이해하지 못해 죄송합니다.', 2);


  -- 925. ～てならない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てならない', '너무 ~하다', 'て+ならない. 「~해서 견딜 수 없다」 감정 강조', '문법-형식판단', 925, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不安でならない。', '불안해서 견딜 수 없다.', 1),
    (w, '残念でならない。', '너무나 안타깝다.', 2);

  -- 926. ～といっても過言ではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といっても過言ではない', '~라고 해도 과언이 아니다', 'と+いって+も+過言(과언)+ではない. 「~이라 해도 지나치지 않다」', '문법-형식판단', 926, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は天才といっても過言ではない。', '그는 천재라 해도 과언이 아니다.', 1),
    (w, '危機的状況といっても過言ではない。', '위기적 상황이라 해도 과언이 아니다.', 2);

  -- 927. ～ないで済む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないで済む', '~하지 않아도 된다', 'ない+で+済(건널 제)む. 「~하지 않고 끝나다」', '문법-형식판단', 927, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '謝らないで済んだ。', '사과하지 않아도 끝났다.', 1),
    (w, 'お金を払わないで済む。', '돈을 내지 않아도 된다.', 2);

  -- 928. ～にしては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にしては', '~치고는', 'に+して+は. 「~의 정도를 감안하면 의외로」', '문법-형식판단', 928, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供にしては大人びている。', '어린이치고는 어른스럽다.', 1),
    (w, '初心者にしてはうまい。', '초보자치고는 잘한다.', 2);

  -- 929. ～もん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～もん', '~라니까 <감정 표현>', 'もの의 회화 축약. 「~걸·~한 걸」 어리광·이유 강조', '문법-형식판단', 929, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '知らなかったんだもん。', '몰랐단 말이야.', 1),
    (w, '行きたくないもん。', '가기 싫단 말이야.', 2);

  -- 930. ～ようとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようとも', '~할지라도', '의지·추량 よう+と+も. 「~할지언정」 강한 양보', '문법-형식판단', 930, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何があろうとも諦めない。', '무슨 일이 있어도 포기 않는다.', 1),
    (w, '誰が反対しようとも進める。', '누가 반대해도 진행한다.', 2);

  -- 931. ～を最後に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を最後に', '~을 끝으로', '最(가장 최)+後(뒤 후): 「~을 마지막으로」 종결', '문법-형식판단', 931, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日を最後に引退する。', '오늘을 끝으로 은퇴한다.', 1),
    (w, 'その日を最後に連絡が途絶えた。', '그 날을 끝으로 연락이 끊겼다.', 2);

  -- 932. 思い出される
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思い出される', 'おもいだされる', '생각이 떠오르다', '思い出す(생각해 내다)+れる(자발). 「자연히 떠오르다」', '문법-형식판단', 932, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔のことが思い出される。', '옛 일이 떠오른다.', 1),
    (w, 'ふと故郷が思い出された。', '문득 고향이 떠올랐다.', 2);

  -- 933. 存じ上げる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '存じ上げる', 'ぞんじあげる', '알고 있다 <겸양>', '存じる(겸양)+上げる(올리다). 知る·思う의 최고 겸양', '문법-형식판단', 933, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お名前は存じ上げております。', '성함은 알고 있습니다.', 1),
    (w, '失礼ながら存じ上げません。', '실례지만 모릅니다.', 2);

  -- 934. ～だろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だろうか', '~한 것일까?', '추량 だろう+か(의문). 「~인 걸까」 자문·완곡 질문', '문법-형식판단', 934, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当に大丈夫だろうか。', '정말 괜찮은 걸까?', 1),
    (w, '彼は来るだろうか。', '그가 올까?', 2);

  -- 935. ～ていただけると助かります
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ていただけると助かります', '~해 주시면 좋겠습니다 <겸양>', 'て+いただける(가능)+と+助かる. 격식체 의뢰', '문법-형식판단', 935, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早めにご連絡いただけると助かります。', '미리 연락 주시면 감사하겠습니다.', 1),
    (w, '手伝っていただけると助かります。', '도와주시면 감사하겠습니다.', 2);

  -- 936. ～てしまわないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てしまわないか', '~해버리지 않을래', 'てしまう+ない+か. 「~해 버리자」 권유·결심', '문법-형식판단', 936, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一気に片付けてしまわないか。', '한번에 정리해 버리지 않을래?', 1),
    (w, '今日中に終わらせてしまわないか。', '오늘 중에 끝내 버리지 않을래?', 2);

  -- 937. ～に決まっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に決まっている', '~할 것임에 틀림없다', '決(결단할 결)まる: 「확실히 정해져 있음」 강한 확신', '문법-형식판단', 937, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が勝つに決まっている。', '그가 이길 게 분명하다.', 1),
    (w, '嘘に決まっている。', '거짓말임에 틀림없다.', 2);

  -- 938. ～べき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～べき', '~해야 할', '可(옳을 가)き: 「당연히 해야 함」 의무·당위', '문법-형식판단', 938, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今行くべきだ。', '지금 가야 한다.', 1),
    (w, '言うべきことを言う。', '해야 할 말을 한다.', 2);

  -- 939. ～ものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものだ', '~로구나 <감동>', 'もの(物)+だ. 「~인 법이구나」 감회·일반론·감탄', '문법-형식판단', 939, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時が経つのは早いものだ。', '시간이 가는 건 빠른 법이구나.', 1),
    (w, '人生とはそういうものだ。', '인생이란 그런 것이다.', 2);

  -- 940. 大人は大人で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大人は大人で', 'おとなはおとなで', '어른은 어른대로 <고유한 상태>', '동일 명사+は+동일 명사+で. 「~은 ~ 나름으로」', '문법-형식판단', 940, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大人は大人で悩みがある。', '어른은 어른대로 고민이 있다.', 1),
    (w, '子供は子供で大変だ。', '아이는 아이대로 힘들다.', 2);

  -- 941. 決して～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '決して～ない', '결코 ~않는다', '決(결정할 결)して+ない. 「절대로 ~않는다」 강한 부정', '문법-형식판단', 941, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '決して諦めない。', '결코 포기하지 않는다.', 1),
    (w, '決して忘れない。', '결코 잊지 않는다.', 2);

  -- 942. ～だけあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけあって', '~인 만큼 <당연>', 'だけ+あって. 「~의 가치만큼 (당연히)」', '문법-형식판단', 942, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロだけあって上手だ。', '프로인 만큼 잘한다.', 1),
    (w, '高いだけあって品質がいい。', '비싼 만큼 품질이 좋다.', 2);

  -- 943. ～でいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～でいい', '~로 좋다, ~면 된다 <선택>', 'で+いい. 「~이면 충분하다」 양보·만족', '문법-형식판단', 943, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お茶でいいです。', '차로 좋습니다.', 1),
    (w, 'これでいい。', '이걸로 됐다.', 2);

  -- 944. ～てからでは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てからでは', '~하고 나서는', 'てから+で+は. 「~한 후에는 (늦다)」 시간적 한계', '문법-형식판단', 944, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失ってからでは遅い。', '잃고 난 후에는 늦다.', 1),
    (w, '事故が起きてからでは遅い。', '사고가 나고 나서는 늦다.', 2);

  -- 945. ～ても始まらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ても始まらない', '~해도 어쩔 수가 없다 <무의미>', 'ても+始(처음 시)まらない. 「~해도 시작되지 않는다」', '문법-형식판단', 945, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今さら言っても始まらない。', '이제 와서 말해도 소용없다.', 1),
    (w, '後悔しても始まらない。', '후회해도 어쩔 수 없다.', 2);

  -- 946. ～なければ～ことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なければ～ことはない', '~하지 않는다면 ~하는 일은 없다', 'なければ+こと+は+ない. 조건 부정 강조', '문법-형식판단', 946, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降らなければ来ないことはない。', '비가 안 오면 오지 않을 일은 없다.', 1),
    (w, '怒らなければ言わないことはない。', '화내지 않으면 말하지 않는 일은 없다.', 2);

  -- 947. ～にしてみれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にしてみれば', '~입장에서는', 'に+して+みれば. 「~의 입장에서 본다면」', '문법-형식판단', 947, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女にしてみれば当然だ。', '그녀 입장에서는 당연하다.', 1),
    (w, '親にしてみれば心配だ。', '부모 입장에서는 걱정이다.', 2);

  -- 948. まるで～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'まるで～ない', '전혀 ~않는다', '副詞 まるで(완전히)+ない. 「전혀·통」 강한 부정', '문법-형식판단', 948, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まるで分からない。', '전혀 모르겠다.', 1),
    (w, 'まるで違う。', '전혀 다르다.', 2);

  -- 949. おいでになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'おいでになる', 'おいでになる', '계시다 <존경>', 'お+いで(出·외출)+になる. 行く·来る·いる의 존경어', '문법-형식판단', 949, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長は今おいでになりますか。', '사장님은 지금 계십니까?', 1),
    (w, '会場においでになる。', '회장에 오시다.', 2);

  -- 950. ～しかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～しかない', '~할 수밖에 없다', 'しか(밖에)+ない. 「~외에 다른 방법이 없다」', '문법-형식판단', 950, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '諦めるしかない。', '포기할 수밖에 없다.', 1),
    (w, '行くしかない。', '갈 수밖에 없다.', 2);

  -- 951. ～ては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ては', '~하면', 'て(접속)+は(주제). 「~하면 (안 된다)」 조건 강조', '문법-형식판단', 951, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんなことをしてはいけない。', '그런 일을 해서는 안 된다.', 1),
    (w, '雨が降っては困る。', '비가 오면 곤란하다.', 2);

  -- 952. ～というものではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というものではない', '~인 것은 아니다', 'と+いう+もの+ではない. 「반드시 ~인 것은 아니다」 부분 부정', '문법-형식판단', 952, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高ければいいというものではない。', '비싸면 좋다는 것은 아니다.', 1),
    (w, '勝てば良いというものではない。', '이기면 된다는 것은 아니다.', 2);

  -- 953. ～ともなれば/～ともなると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ともなれば/～ともなると', '~라도 되면', 'と+も+なれば/なると. 「~정도가 되면」 단계 가정', '문법-형식판단', 953, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長ともなれば責任が重い。', '사장 정도가 되면 책임이 무겁다.', 1),
    (w, '夜ともなると静かだ。', '밤이 되면 조용하다.', 2);

  -- 954. もっとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'もっとも', '다만', '접속사 もっとも(尤·더욱). 「다만, 하지만」 단서 첨가', '문법-형식판단', 954, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行く。もっとも雨なら中止だ。', '간다. 다만 비라면 중지다.', 1),
    (w, '正しい。もっとも例外もある。', '맞다. 다만 예외도 있다.', 2);

  -- 955. ～ものの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものの', '~이지만', 'もの(物)+の. 「~이긴 하지만」 격식체 역접', '문법-형식판단', 955, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買ったものの、使っていない。', '사긴 했지만 사용하지 않는다.', 1),
    (w, '言ったものの、後悔している。', '말은 했지만 후회하고 있다.', 2);

  -- 956. ～ように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ように', '~하기를 <희망>', '様(모양 양)に. 「~하도록·~하기를」 기원·목적', '문법-형식판단', 956, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格しますように。', '합격하기를.', 1),
    (w, '元気でいられますように。', '건강하시기를.', 2);

  -- 957. ～(さ)せてもらう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(さ)せてもらう', '~하다 <겸양>', '사역 (さ)せる+てもらう. 「~을 (허락 받아) 하다」 겸양', '문법-형식판단', 957, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませてもらいます。', '쉬겠습니다.', 1),
    (w, '使わせてもらいました。', '사용했습니다.', 2);

  -- 958. ～次第では
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～次第では', '~에 따라서는', '次(다음 차)+第(차례 제). 「~의 상황에 따라」', '문법-형식판단', 958, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果次第では再検討する。', '결과에 따라서는 재검토한다.', 1),
    (w, '天気次第では延期する。', '날씨에 따라서는 연기한다.', 2);

  -- 959. ～てみせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てみせる', '~하고야 말겠다', 'て+見(볼 견)せる. 「~해 보이겠다」 결의·과시', '문법-형식판단', 959, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度こそ成功してみせる。', '이번에야말로 성공해 보이겠다.', 1),
    (w, '必ず合格してみせる。', '반드시 합격해 보이겠다.', 2);

  -- 960. ～に越したことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に越したことはない', '~이 최고다', '越(넘을 월)す: 「~을 능가함」 + ない. 「~보다 더 좋은 것은 없다」', '문법-형식판단', 960, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康に越したことはない。', '건강이 최고다.', 1),
    (w, '安いに越したことはない。', '싼 것이 최고다.', 2);

  -- 961. ～もしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～もしない', '~도 하지 않는다', 'も(강조)+しない. 「~조차 하지 않다」 강한 부정', '문법-형식판단', 961, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '挨拶もしない。', '인사도 하지 않는다.', 1),
    (w, '見もしない。', '쳐다보지도 않는다.', 2);

  -- 962. ～ものと思われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものと思われる', '~할 것으로 생각된다 <확신>', 'もの+と+思われる(자발 추량). 「~으로 생각되다」 격식', '문법-형식판단', 962, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因は事故と思われる。', '원인은 사고로 생각된다.', 1),
    (w, '彼が犯人ものと思われる。', '그가 범인으로 보인다.', 2);

  -- 963. ～も～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～も～も', '~도 ~도', 'も+も 병렬. 「A도 B도 (모두)」 망라', '문법-형식판단', 963, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '読書も運動も好きだ。', '독서도 운동도 좋아한다.', 1),
    (w, '彼も私も忙しい。', '그도 나도 바쁘다.', 2);

  -- 964. ～(よ)うと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(よ)うと', '~할지라도', '의지·추량 (よ)う+と. 「~을 하든 (관계없이)」', '문법-형식판단', 964, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何があろうと頑張る。', '무슨 일이 있어도 분발한다.', 1),
    (w, '誰が来ようと驚かない。', '누가 와도 놀라지 않는다.', 2);

  -- 965. ～をよそに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をよそに', '~을 뒷전으로 하고', 'を+余所(よそ)+に. 「~을 무시하고」', '문법-형식판단', 965, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心配をよそに彼は遊んでいた。', '걱정을 뒷전으로 하고 그는 놀고 있었다.', 1),
    (w, '反対をよそに進めた。', '반대에도 아랑곳없이 진행했다.', 2);

  -- 966. ～かぎり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かぎり', '~하는 한', '限(한할 한)り. 「~의 범위 내에서」 조건·한계', '문법-형식판단', 966, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '生きているかぎり頑張る。', '살아 있는 한 분발한다.', 1),
    (w, '私の知るかぎりでは正しい。', '내가 아는 한 옳다.', 2);

  -- 967. ～っこない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～っこない', '~할 리가 없다', 'はずがない의 회화 축약. 「절대 ~않을 것」 회화체 부정 추량', '문법-형식판단', 967, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できっこない。', '될 리가 없다.', 1),
    (w, '勝てっこない。', '이길 리가 없다.', 2);

  -- 968. ～末に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～末に', '~한 끝에', '末(끝 말)に. 「오랜 ~끝에 결국」 결과 강조', '문법-형식판단', 968, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長い議論の末に決定した。', '긴 논의 끝에 결정했다.', 1),
    (w, '考え抜いた末に選んだ。', '깊이 고민한 끝에 골랐다.', 2);

  -- 969. ～とすれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とすれば', '~라고 한다면', 'と+する+ば. 「가정 조건」', '문법-형식판단', 969, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当だとすれば大変だ。', '사실이라면 큰일이다.', 1),
    (w, '彼が来るとすれば明日だ。', '그가 온다면 내일이다.', 2);

  -- 970. ～において
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～において', '~에 있어서', '於(어조사 어)いて. 「~에서·~에 있어」 격식체 시간·장소', '문법-형식판단', 970, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は東京において行われる。', '회의는 도쿄에서 열린다.', 1),
    (w, '研究において重要だ。', '연구에 있어서 중요하다.', 2);

  -- 971. ～は否めない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～は否めない', '~은 부정할 수 없다', 'は+否(아닐 부)めない. 「~을 부인하지 못한다」 인정', '문법-형식판단', 971, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '影響は否めない。', '영향은 부정할 수 없다.', 1),
    (w, '責任は否めない。', '책임은 부인할 수 없다.', 2);

  -- 972. ～ようにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようにする', '~하도록 하다', '様(양)に+する. 「~하도록 노력하다」 목표 행동', '문법-형식판단', 972, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日運動するようにする。', '매일 운동하도록 한다.', 1),
    (w, '早く寝るようにする。', '일찍 자도록 한다.', 2);

  -- 973. ～きれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～きれる', '전부 ~할 수 있다', '切(끊을 절)れる의 가능. 「완전히 ~할 수 있다」', '문법-형식판단', 973, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは食べきれる量だ。', '이건 다 먹을 수 있는 양이다.', 1),
    (w, '一人で運びきれる。', '혼자서 다 옮길 수 있다.', 2);

  -- 974. ご説明なさる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'ご説明なさる', 'ごせつめいなさる', '설명하시다 <존경>', 'ご+説明(설명)+なさる(する의 존경). 격식 존경어', '문법-형식판단', 974, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生がご説明なさいました。', '선생님께서 설명해 주셨습니다.', 1),
    (w, '社長がご説明なさるそうです。', '사장님이 설명하신답니다.', 2);

  -- 975. つもり (회상)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'つもり (회상·기분)', '생각, 작정', '積(쌓을 적)もり. 「~한 셈치다·기분」', '문법-형식판단', 975, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休んだつもりで体を動かす。', '쉬는 셈치고 몸을 움직인다.', 1),
    (w, 'やったつもりだった。', '한 줄 알았다.', 2);

  -- 976. なんら～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なんら～ない', '아무런 ~없다', '何(어찌 하)等(등급 등)+ら+ない. 「조금도 없다」 격식체', '문법-형식판단', 976, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんら問題はない。', '아무런 문제는 없다.', 1),
    (w, 'なんら変わりがない。', '아무런 변화도 없다.', 2);

  -- 977. ～ぬく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ぬく', '끝까지 ~하다', '抜(뺄 발)く: 「뽑아내다」 → 「끝까지 해내다」', '문법-형식판단', 977, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'マラソンを走りぬいた。', '마라톤을 끝까지 달려냈다.', 1),
    (w, '考えぬいた結論だ。', '심사숙고한 결론이다.', 2);

  -- 978. ～ばかりとなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ばかりとなる', '~하기만 하면 된다', 'ばかり(한정)+と+なる. 「준비가 모두 끝나 ~만 남다」', '문법-형식판단', 978, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出発するばかりとなった。', '출발만 하면 되게 되었다.', 1),
    (w, '発表するばかりとなった。', '발표만 하면 되게 되었다.', 2);

  -- 979. ～に先だち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に先だち', '~에 앞서', '先(먼저 선)立(설 립)ち. 「~보다 앞에」 격식체', '문법-형식판단', 979, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議に先だち資料を配る。', '회의에 앞서 자료를 배포한다.', 1),
    (w, '発表に先だち挨拶があった。', '발표에 앞서 인사가 있었다.', 2);

  -- 980. ～が＋ゆえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～が＋ゆえに', '~이기에, ~때문에', 'が+故(까닭 고)に. 「~의 까닭으로」 격식체 원인', '문법-형식판단', 980, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛するがゆえに苦しむ。', '사랑하기에 괴롭다.', 1),
    (w, '若いがゆえの過ち。', '젊기 때문의 잘못.', 2);

  -- 981. ～んなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～んなら', '~것이라면', 'のなら의 회화 축약. 「~인 거라면」 조건', '문법-형식판단', 981, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くんならご一緒します。', '가는 거라면 함께 가겠습니다.', 1),
    (w, '辛いんなら休んだら？', '힘들면 쉬는 게 어때?', 2);

  -- 982. ～(さ)せる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(さ)せる', '~시키다', '사역 조동사 せる/させる. 「~을 시키다·하게 하다」', '문법-형식판단', 982, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供に勉強させる。', '아이에게 공부시키다.', 1),
    (w, '部下に行かせた。', '부하를 가게 했다.', 2);

  -- 983. お＋ます형＋願う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'お＋ます形＋願う', '~해 주세요', 'お+ます형+願(원할 원)う. 「~을 청합니다」 격식체 의뢰', '문법-형식판단', 983, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご記入願います。', '기입해 주십시오.', 1),
    (w, 'お待ち願います。', '기다려 주십시오.', 2);

  -- 984. ～ないまでも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないまでも', '~까지는 아니더라도', 'ない+までも. 「~의 정도까지는 아니지만」 정도 양보', '문법-형식판단', 984, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '満点ないまでも合格はした。', '만점까지는 아니지만 합격했다.', 1),
    (w, '完璧でないまでも十分だ。', '완벽까지는 아니지만 충분하다.', 2);

  -- 985. ～た＋つもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～た＋つもり', '~한 셈, ~했다는 생각', 'た+つもり. 「~한 것으로 친다」 가정·자기 만족', '문법-형식판단', 985, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休んだつもりでお茶を飲む。', '쉰 셈치고 차를 마신다.', 1),
    (w, '本を読んだつもりになる。', '책을 읽은 셈이 된다.', 2);

  -- 986. ～なんか/～んじゃなかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なんか/～んじゃなかった', '~같은 것 / ~하는 게 아니었다', 'なんか(경시)/んじゃなかった(후회). 회화체 감정 표현', '문법-형식판단', 986, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '宝くじなんか当たるはずがない。', '복권 같은 게 당첨될 리 없다.', 1),
    (w, 'あんなこと言うんじゃなかった。', '그런 말 하는 게 아니었어.', 2);

  -- 987. ～と＋している
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と＋している', '~라고 하고 있다 <주장,생각>', 'と+している. 「~라고 보고 있다」 격식체 주장', '문법-형식판단', 987, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '警察は事故としている。', '경찰은 사고로 보고 있다.', 1),
    (w, '彼は無罪としている。', '그는 무죄라고 주장한다.', 2);

  -- 988. ～と引きかえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と引きかえに', '~와 맞바꾸어', '引(끌 인)き+換(바꿀 환)え. 「~과 교환하여」', '문법-형식판단', 988, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康と引きかえに成功した。', '건강과 맞바꿔 성공했다.', 1),
    (w, '時間と引きかえに自由を得た。', '시간과 맞바꿔 자유를 얻었다.', 2);

  -- 989. ～べく (목적)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～べく (목적)', '~하기 위해', '可(옳을 가)き의 부사형. 「~할 목적으로」 격식체', '문법-형식판단', 989, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '改善すべく取り組む。', '개선하기 위해 노력한다.', 1),
    (w, '解決すべく努力する。', '해결하기 위해 노력한다.', 2);

  -- 990. なにも～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なにも～ない', '구태여 ~하지 않다', '何(어찌 하)も+ない. 「굳이 ~하지는 않다」 강조 부정', '문법-형식판단', 990, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なにも泣くことはない。', '구태여 울 일은 아니다.', 1),
    (w, 'なにも急ぐことはない。', '굳이 서두를 필요는 없다.', 2);

  -- 991. ～ったって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ったって', '~라고 해도', 'といったって의 축약. 「~라 한들」 회화체 양보', '문법-형식판단', 991, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無理だったって頑張る。', '무리라 해도 분발한다.', 1),
    (w, '高いったって買う。', '비싸다 해도 산다.', 2);

  -- 992. なんと～ことか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なんと～ことか', '얼마나 ~인가', '何(어찌 하)+と+こと+か. 감탄 강조', '문법-형식판단', 992, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんと美しいことか。', '얼마나 아름다운가.', 1),
    (w, 'なんと懐かしいことか。', '얼마나 그리운가.', 2);

  -- 993. そうかと思えば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そうかと思えば', '그런가 싶더니', 'そう+か+と+思えば. 「그런가 싶더니 다른 면」 대조', '문법-형식판단', 993, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くそうかと思えば笑う。', '우는가 싶더니 웃는다.', 1),
    (w, '怒るそうかと思えば優しい。', '화내는가 싶더니 다정하다.', 2);

  -- 994. ～をいいことに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をいいことに', '~을 틈타', 'を+良い+こと+に. 「~을 좋은 기회로 삼아」', '문법-형식판단', 994, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '留守をいいことにお菓子を食べた。', '집을 비운 틈에 과자를 먹었다.', 1),
    (w, '親切をいいことに甘えた。', '친절을 틈타 어리광 부렸다.', 2);

  -- 995. ～せていただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～せていただく', '~하다', '사역 せる+ていただく(겸양). 「(허락 받아) ~하다」 격식체', '문법-형식판단', 995, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '発表させていただきます。', '발표하겠습니다.', 1),
    (w, '休ませていただきました。', '쉬었습니다.', 2);

  -- 996. ～しかあるまい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～しかあるまい', '~밖에 없겠지', 'しか+ある+まい(부정 추량). 「~외에 다른 방법은 없을 것」', '문법-형식판단', 996, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '謝るしかあるまい。', '사과할 수밖에 없을 것이다.', 1),
    (w, '従うしかあるまい。', '따를 수밖에 없을 것이다.', 2);

  -- 997. ～ばよかったのに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ばよかったのに', '~하면 좋았을 텐데', 'ば+良(좋을 량)かった+のに. 「~했더라면 좋았을 텐데」 후회', '문법-형식판단', 997, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言ってくれればよかったのに。', '말해 주었으면 좋았을 텐데.', 1),
    (w, '早く来ればよかったのに。', '일찍 왔으면 좋았을 텐데.', 2);

  -- 998. ～に (추가)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に (추가)', '~에 <추가>', '조사 に. 「~에 더해」 추가·병렬', '문법-형식판단', 998, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'コーヒーにケーキを頼む。', '커피에 케이크를 주문한다.', 1),
    (w, '雨に風が加わる。', '비에 바람이 더해진다.', 2);

  -- 999. ～ならではの (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ならではの (#2)', '~만의', 'なら+で+は+の. 강조 반복형. 「~가 아니고서는 없는 고유함」', '문법-형식판단', 999, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本ならではの食文化。', '일본만의 식문화.', 1),
    (w, '名人ならではの技。', '명인만의 기예.', 2);

  -- 1000. なかなか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なかなか', '꽤', '副詞 なかなか(中中·꽤). 「상당히」 정도 강조 또는 「쉽게 ~않다」', '문법-형식판단', 1000, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なかなかおいしい。', '꽤 맛있다.', 1),
    (w, 'なかなか終わらない。', '좀처럼 끝나지 않는다.', 2);

  -- 1001. ～ところだった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ところだった', '~할 뻔 했다', 'ところ(상황)+だった. 「하마터면 ~할 뻔」', '문법-형식판단', 1001, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転ぶところだった。', '넘어질 뻔했다.', 1),
    (w, '忘れるところだった。', '잊을 뻔했다.', 2);

  -- 1002. ～かねない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かねない', '~할 지도 모른다', '兼(겸할 겸)ねる+ない. 「~할 가능성이 있다」 부정적 가능성', '문법-형식판단', 1002, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故になりかねない。', '사고가 날 수도 있다.', 1),
    (w, '誤解されかねない発言。', '오해를 살 수도 있는 발언.', 2);

  -- 1003. ～にも～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にも～ない', '~할래야 ~할 수 없다', 'にも+~ない. 「~하려 해도 ~할 수 없다」 불가능', '문법-형식판단', 1003, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寝るにも寝られない。', '자려야 잘 수가 없다.', 1),
    (w, '行くにも行けない。', '가려야 갈 수가 없다.', 2);

  -- 1004. ～までになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～までになる', '~하기까지 되다', '迄(까지 흘)+に+なる. 「~까지 도달하다」 발전·정도', '문법-형식판단', 1004, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長と呼ばれるまでになった。', '사장이라 불릴 만큼 되었다.', 1),
    (w, '泣くまでになるとは。', '울 정도가 되다니.', 2);


  -- 1005. ～なきゃ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なきゃ', '~하지 않으면', 'なければ의 회화 축약. 「~안 하면 (안 된다)」', '문법-형식판단', 1005, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く帰らなきゃ。', '빨리 돌아가지 않으면.', 1),
    (w, '勉強しなきゃダメだ。', '공부 안 하면 안 된다.', 2);

  -- 1006. ～ておけばいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ておけばいい', '~해 두면 된다', 'ておく+ば+いい. 「미리 ~해 두면 충분」', '문법-형식판단', 1006, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '連絡しておけばいい。', '연락해 두면 된다.', 1),
    (w, '準備しておけばいい。', '준비해 두면 된다.', 2);

  -- 1007. ～おそれがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～おそれがある', '~우려가 있다', '恐(두려울 공)れ+が+ある. 「~의 위험이 있다」 격식체', '문법-형식판단', 1007, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風が来るおそれがある。', '태풍이 올 우려가 있다.', 1),
    (w, '事故のおそれがある。', '사고의 우려가 있다.', 2);

  -- 1008. ～こそ～が
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こそ～が', '비록 ~은 ~이지만', 'こそ(강조)+が(역접). 「~은 ~이지만」 양보 강조', '문법-형식판단', 1008, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見た目こそ古いが性能はいい。', '겉모습은 낡았지만 성능은 좋다.', 1),
    (w, '若いこそないが経験豊富だ。', '젊지는 않지만 경험이 풍부하다.', 2);

  -- 1009. ～ことだから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことだから', '~이니까', 'こと+だから. 「~의 성격상 (당연히)」', '문법-형식판단', 1009, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼のことだから時間通りに来る。', '그 사람이니까 시간 맞춰 온다.', 1),
    (w, '優しい君のことだから許してくれる。', '다정한 너니까 용서해 줄 거야.', 2);

  -- 1010. どうやら～ようだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どうやら～ようだ', '아무래도 ~인 것 같다', 'どうやら+ようだ. 「추측·짐작」 부드러운 단정', '문법-형식판단', 1010, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうやら間に合わないようだ。', '아무래도 늦을 것 같다.', 1),
    (w, 'どうやら本当のようだ。', '아무래도 사실인 것 같다.', 2);

  -- 1011. ～ないものか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないものか', '~못하는가', 'ない+もの+か. 「(어떻게든) ~할 수 없을까」 강한 희망', '문법-형식판단', 1011, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何とかならないものか。', '어떻게든 안 될까.', 1),
    (w, '助けられないものか。', '도울 수 없을까.', 2);

  -- 1012. ～じゃない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～じゃない', '~지 않아?', 'では+ない의 회화체. 「~잖아」 확인·동의 유도', '문법-형식판단', 1012, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いいじゃない。', '좋잖아.', 1),
    (w, '行けばいいじゃない。', '가면 되잖아.', 2);

  -- 1013. ～とかで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とかで', '~라는 이유로', 'とか(인용)+で(원인). 「~라고 해서·~인 이유로」', '문법-형식판단', 1013, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '風邪を引いたとかで休んだ。', '감기 걸렸다는 이유로 쉬었다.', 1),
    (w, '忙しいとかで来なかった。', '바쁘다는 이유로 안 왔다.', 2);

  -- 1014. ～ておらず (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ておらず (#2)', '~하지 않고', 'て+おる+ず. 「~하지 않은 상태」 격식체. 반복형', '문법-형식판단', 1014, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結論には至っておらず。', '결론에 이르지 못한 채.', 1),
    (w, '対応できておらず申し訳ありません。', '대응하지 못해 죄송합니다.', 2);

  -- 1015. ～たり～なかったり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たり～なかったり', '~하거나 ~안 하거나', 'たり+なかったり. 「~하는 때도 있고 안 하는 때도」 반복 변동', '문법-형식판단', 1015, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降ったり降らなかったり。', '비가 오다 안 오다 한다.', 1),
    (w, '気分が良かったり悪かったり。', '기분이 좋다 나쁘다 한다.', 2);

  -- 1016. 危うく～ところだった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '危うく～ところだった', 'あやうく～ところだった', '하마터면 ~할 뻔했다', '危(위태할 위)うく+ところだった. 위기 회피 표현', '문법-형식판단', 1016, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危うく事故に遭うところだった。', '하마터면 사고날 뻔했다.', 1),
    (w, '危うく忘れるところだった。', '하마터면 잊을 뻔했다.', 2);

  -- 1017. ～ってわけじゃない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ってわけじゃない', '~인 것은 아니다', 'って(인용)+わけ+じゃない. 회화체 부분 부정', '문법-형식판단', 1017, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嫌いってわけじゃない。', '싫어한다는 건 아니다.', 1),
    (w, '無理ってわけじゃない。', '무리라는 건 아니다.', 2);

  -- 1018. ～を余儀なくされる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を余儀なくされる', '어쩔 수 없이 ~할 수밖에 없다', '余(남을 여)儀(거동 의)+なく+される. 「~을 강요당하다」', '문법-형식판단', 1018, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '中止を余儀なくされた。', '중단할 수밖에 없었다.', 1),
    (w, '退院を余儀なくされた。', '퇴원하지 않을 수 없었다.', 2);

  -- 1019. そう～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そう～ない', '그렇게 ~하지 않다', 'そう(부사)+ない. 「그다지 ~하지 않다」 정도 부정', '문법-형식판단', 1019, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そう難しくない。', '그렇게 어렵지 않다.', 1),
    (w, 'そう簡単にはいかない。', '그렇게 쉽게는 안 된다.', 2);

  -- 1020. ～を控えて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を控えて', '~을 앞두고', '控(당길 공)える: 「대기·삼가다」 → 「(중요 일을) 앞두고」', '문법-형식판단', 1020, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験を控えて緊張する。', '시험을 앞두고 긴장한다.', 1),
    (w, '結婚を控えて忙しい。', '결혼을 앞두고 바쁘다.', 2);

  -- 1021. ～でもあるまい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～でもあるまい', '~도 아니다', 'でも+ある+まい(부정 추량). 「~도 아닐 것이다」', '문법-형식판단', 1021, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談でもあるまい。', '농담도 아닐 것이다.', 1),
    (w, '今さらでもあるまい。', '이제 와서일 것도 아니다.', 2);

  -- 1022. ～ことと存じます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことと存じます', '~이시리라 생각합니다', 'こと+と+存(있을 존)じる(겸양). 격식체 추량', '문법-형식판단', 1022, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お元気のことと存じます。', '건강하시리라 생각합니다.', 1),
    (w, 'ご繁栄のことと存じます。', '번창하시리라 생각합니다.', 2);

  -- 1023. ～たとたんに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たとたんに', '~하자마자', '途端(도단)+に. 「바로 그 순간」 시간적 즉시성', '문법-형식판단', 1023, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ドアを開けたとたんに雨が降った。', '문을 열자마자 비가 왔다.', 1),
    (w, '寝たとたんに電話が鳴った。', '잠들자마자 전화가 울렸다.', 2);

  -- 1024. ～べきところを
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～べきところを', '~해야 하는 상황을', 'べき+ところ+を. 「당연히 ~해야 할 것을」 의무 회상', '문법-형식판단', 1024, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お伺いするべきところを失礼しました。', '찾아 뵈어야 할 것을 실례했습니다.', 1),
    (w, '謝るべきところを黙っていた。', '사과해야 할 것을 잠자코 있었다.', 2);

  -- 1025. ～ようがない (#3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようがない (#3)', '~할 방법이 없다', 'よう(様)+が+ない. 강조 변형', '문법-형식판단', 1025, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '連絡先を知らないから連絡しようがない。', '연락처를 모르니 연락할 수가 없다.', 1),
    (w, '弁解のしようがない。', '변명할 여지가 없다.', 2);

  -- 1026. ～んじゃなかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～んじゃなかった', '괜히 ~했다', 'のではなかった의 회화 축약. 「~하는 게 아니었다」 후회', '문법-형식판단', 1026, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こんなこと言うんじゃなかった。', '괜히 이런 말 했다.', 1),
    (w, '買うんじゃなかった。', '괜히 샀다.', 2);

  -- 1027. ～ないともかぎらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないともかぎらない', '~하지 말라는 법도 없다', 'ない+と+も+限(한할 한)らない. 「~의 가능성도 있다」 약한 긍정', '문법-형식판단', 1027, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝てないともかぎらない。', '이길 가능성도 있다.', 1),
    (w, '雨が降らないともかぎらない。', '비가 안 올 것이라고도 할 수 없다.', 2);

  -- 1028. ～ならではの (#3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ならではの (#3)', '~만의', '강조 반복형. 「특정한 ~만이 가진」', '문법-형식판단', 1028, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プロならではの判断力。', '프로만의 판단력.', 1),
    (w, '若者ならではの発想。', '젊은이만의 발상.', 2);

  -- 1029. ～たばかりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たばかりに', '~한 탓에', 'た+ばかりに. 「~한 것만이 원인이 되어」 부정적 결과', '문법-형식판단', 1029, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '油断したばかりに失敗した。', '방심한 탓에 실패했다.', 1),
    (w, '一言言ったばかりに揉めた。', '한마디 한 탓에 다툼이 났다.', 2);

  -- 1030. それが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'それが', '그게 <변명>', '대명사 それ+が. 「그게 (실은)」 변명·역접 시작', '문법-형식판단', 1030, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それが、実は知らないんです。', '그게, 사실은 모릅니다.', 1),
    (w, 'それが、間に合わなかった。', '그게, 늦었습니다.', 2);

  -- 1031. ～をもってすれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をもってすれば', '~가 있으면', '以(써 이)って+すれば. 「~로(써) 한다면」 격식체 수단·조건', '문법-형식판단', 1031, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の実力をもってすれば成功する。', '그의 실력이면 성공한다.', 1),
    (w, '誠意をもってすれば通じる。', '성의를 다하면 통한다.', 2);

  -- 1032. ～ないうちから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないうちから', '~하기 전부터', 'ない+うち(內)+から. 「~하기 전에 이미」', '문법-형식판단', 1032, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '始まらないうちから諦める。', '시작도 하기 전부터 포기한다.', 1),
    (w, '聞かないうちから決めつける。', '듣기도 전에 단정 짓는다.', 2);

  -- 1033. ～くせに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～くせに', '~이면서', '癖(버릇 벽)に. 「~이면서도 (불만)」 비난·역접', '문법-형식판단', 1033, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '知っているくせに言わない。', '알면서도 말하지 않는다.', 1),
    (w, '子供のくせに偉そうだ。', '어린아이면서 잘난 척한다.', 2);

  -- 1034. ～ている (경험)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ている (경험)', '~한 적이 있다', 'て+いる. 경험 의미. 「과거에 ~한 적이 있는 상태」', '문법-형식판단', 1034, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度行っている。', '한 번 가 본 적이 있다.', 1),
    (w, 'その本は読んでいる。', '그 책은 읽은 적이 있다.', 2);

  -- 1035. あがる (겸손어)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '上がる', 'あがる', '가다 <겸손어>', '上(위 상)がる: 「오르다」 → 윗사람께 「가다·찾아뵙다」', '문법-형식판단', 1035, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お宅にあがらせていただきます。', '댁으로 찾아뵙겠습니다.', 1),
    (w, '明日先生のところへあがります。', '내일 선생님께 찾아뵙겠습니다.', 2);

  -- 1036. ～どころではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～どころではない', '~할 상황이 아니다', '所(곳 소)+で+は+ない. 「~할 여유가 없다」 강한 부정', '문법-형식판단', 1036, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強どころではない。', '공부할 상황이 아니다.', 1),
    (w, '休みどころではない忙しさだ。', '쉴 상황이 아닌 바쁨이다.', 2);

  -- 1037. ～ってもんだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ってもんだ', '~라는 것이다', 'って+もの+だ. 「~라는 것이다」 회화체 단정', '문법-형식판단', 1037, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これが愛ってもんだ。', '이게 사랑이라는 거다.', 1),
    (w, '大人ってもんだ。', '어른이라는 거다.', 2);

  -- 1038. ～ならまだしも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ならまだしも', '~라면 모르나', 'なら+まだ(아직)+しも. 「~라면 이해되지만」 비교 양보', '문법-형식판단', 1038, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一度ならまだしも何度もは困る。', '한 번이라면 모르나 여러 번은 곤란하다.', 1),
    (w, '子供ならまだしも大人がそれをするとは。', '아이라면 모르나 어른이 그러다니.', 2);

  -- 1039. ～極まりない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～極まりない', '~하기 짝이 없다', '極(다할 극)+まりない. 「극에 달함」 극단적 평가', '문법-형식판단', 1039, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失礼極まりない態度だ。', '무례하기 짝이 없는 태도다.', 1),
    (w, '危険極まりない行為。', '위험하기 짝이 없는 행위.', 2);

  -- 1040. ～を皮切りに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を皮切りに', '~을 필두로', '皮(가죽 피)切(끊을 절)り: 「가죽을 처음 자르다」 → 시작', '문법-형식판단', 1040, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京を皮切りに全国ツアー。', '도쿄를 필두로 전국 투어.', 1),
    (w, '彼を皮切りに次々と発言した。', '그를 필두로 잇달아 발언했다.', 2);

  -- 1041. ～だろうと～だろうと (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だろうと～だろうと (#2)', '~이든 ~이든', '추량 반복. 「A든 B든 관계없이」 강조 양보', '문법-형식판단', 1041, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雪だろうと雨だろうと開催する。', '눈이든 비든 개최한다.', 1),
    (w, '大人だろうと子供だろうと平等だ。', '어른이든 아이든 평등하다.', 2);

  -- 1042. ～たばかりに (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たばかりに (#2)', '~한 탓에', '강조 반복. 「~한 것이 원인이 되어 부정적 결과」', '문법-형식판단', 1042, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '余計なことを言ったばかりに怒られた。', '쓸데없는 말을 한 탓에 혼났다.', 1),
    (w, '寝坊したばかりに遅刻した。', '늦잠 잔 탓에 지각했다.', 2);

  -- 1043. ～あまり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～あまり', '~한 나머지', '余(남을 여)り. 「~한 나머지」 감정 결과', '문법-형식판단', 1043, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '驚きのあまり声が出なかった。', '놀란 나머지 말이 안 나왔다.', 1),
    (w, '悲しみのあまり涙が止まらない。', '슬픔에 못 이겨 눈물이 멈추지 않는다.', 2);

  -- 1044. ～て～ないことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～て～ないことはない', '~하려면 ~못 할 것은 없다', 'て+ない+こと+は+ない. 이중부정. 「가능성 인정」', '문법-형식판단', 1044, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張ってできないことはない。', '노력하면 못 할 것은 없다.', 1),
    (w, '走って間に合わないことはない。', '뛰어가면 못 맞출 것은 없다.', 2);

  -- 1045. ～かねない (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かねない (#2)', '~할 지도 모른다', '兼ねる+ない. 강조 반복. 「부정적 가능성」', '문법-형식판단', 1045, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大事故になりかねない。', '대형 사고가 될 수도 있다.', 1),
    (w, '中止になりかねない。', '중단이 될 수도 있다.', 2);

  -- 1046. ～にすぎまい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にすぎまい', '~에 불과할 것이다', 'に+過(지날 과)ぎる+まい(부정 추량). 「~에 지나지 않을 것」', '문법-형식판단', 1046, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言い訳にすぎまい。', '변명에 불과할 것이다.', 1),
    (w, '偶然にすぎまい。', '우연에 불과할 것이다.', 2);

  -- 1047. ～次第です
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～次第です', '~인 바입니다', '次(다음 차)第(차례 제)+です. 「~이 된 경위」 격식체 보고', '문법-형식판단', 1047, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お願いに参った次第です。', '부탁드리러 온 바입니다.', 1),
    (w, '事情を申し上げる次第です。', '사정을 말씀드리는 바입니다.', 2);

  -- 1048. ～はどうあれ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～はどうあれ', '~은 어쨌든', 'は+どう+あれ(あり의 명령형). 「~이 어떻든 상관없이」', '문법-형식판단', 1048, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果はどうあれ全力を尽くす。', '결과는 어쨌든 최선을 다한다.', 1),
    (w, '理由はどうあれ遅刻はダメだ。', '이유는 어쨌든 지각은 안 된다.', 2);

  -- 1049. なんら～ない (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なんら～ない (#2)', '전혀 ~없다', '何等+ら+ない. 강조 반복형', '문법-형식판단', 1049, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんら影響はない。', '아무런 영향은 없다.', 1),
    (w, 'なんら異常なし。', '아무런 이상 없음.', 2);

  -- 1050. ～ものを (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものを (#2)', '~일 것을', 'もの+を. 강조 반복. 「~할 텐데 (안 했다)」 후회·아쉬움', '문법-형식판단', 1050, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話すればすぐ来たものを。', '전화했으면 바로 왔을 것을.', 1),
    (w, '黙ればよかったものを。', '잠자코 있었으면 좋았을 것을.', 2);

  -- 1051. ～かと思いきや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かと思いきや', '~할 줄 알았더니', 'か+と+思いきや. 「~인 줄 알았는데 의외로」', '문법-형식판단', 1051, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くかと思いきや笑った。', '울 줄 알았더니 웃었다.', 1),
    (w, '断るかと思いきや受けた。', '거절할 줄 알았더니 받아들였다.', 2);

  -- 1052. ～といて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といて', '~해 두고', 'ておく의 회화 축약형. 「~해 둬」 회화체 명령·부탁', '문법-형식판단', 1052, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言っといて。', '말해 둬.', 1),
    (w, '買っといてくれる？', '사 둬 줄래?', 2);

  -- 1053. おいでいただく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'おいでいただく', 'おいでいただく', '오시다', 'お+いで(出·외출)+いただく(겸양). 「와 주시다」 정중 겸양', '문법-형식판단', 1053, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わざわざおいでいただきありがとうございます。', '일부러 와 주셔서 감사합니다.', 1),
    (w, '本日はおいでいただき光栄です。', '오늘 와 주셔서 영광입니다.', 2);

  -- 1054. ～どころではない (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～どころではない (#2)', '~할 상황이 아니다', '所+で+は+ない. 강조 반복형', '문법-형식판단', 1054, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遊ぶどころではない。', '놀 상황이 아니다.', 1),
    (w, '寝るどころではなかった。', '잘 상황이 아니었다.', 2);

  -- 1055. ～にもほどがある (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にもほどがある (#2)', '~에도 정도가 있다', 'に+も+程+が+ある. 강조 반복형', '문법-형식판단', 1055, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嘘にもほどがある。', '거짓말에도 정도가 있다.', 1),
    (w, '甘えるにもほどがある。', '응석에도 정도가 있다.', 2);

  -- 1056. ～きれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～きれない', '~할 수 없다', '切(끊을 절)れる+ない. 「다 ~하지 못하다」', '문법-형식판단', 1056, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人では食べきれない。', '혼자서는 다 먹을 수 없다.', 1),
    (w, '感謝してもしきれない。', '아무리 감사해도 다할 수 없다.', 2);

  -- 1057. ～ぐらいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ぐらいだ', '~정도이다', 'ぐらい(정도)+だ. 「~정도이다」 정도 표시', '문법-형식판단', 1057, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣きたいぐらいだ。', '울고 싶을 정도다.', 1),
    (w, '叫びたいぐらいうれしい。', '소리치고 싶을 정도로 기쁘다.', 2);

  -- 1058. いっさい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一切', 'いっさい', '일절, 전혀', '一(한 일)+切(끊을 절). 「모든 것을 끊다·전부」 부정과 호응', '문법-형식판단', 1058, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一切口出ししない。', '일절 참견하지 않는다.', 1),
    (w, '一切認めない。', '전혀 인정하지 않는다.', 2);

  -- 1059. ～と相まって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と相まって', '~과 아우러져', '相(서로 상)+まって. 「~와 어우러져」 시너지', '문법-형식판단', 1059, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '景色と音楽と相まって感動的だ。', '경치와 음악이 어우러져 감동적이다.', 1),
    (w, '才能と努力と相まって成功した。', '재능과 노력이 어우러져 성공했다.', 2);

  -- 1060. ～につけ (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～につけ (#2)', '~할 때마다', '付け. 강조 반복형. 「~할 때마다 자연스레」', '문법-형식판단', 1060, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何かにつけ思い出す。', '뭔가 있을 때마다 떠올린다.', 1),
    (w, 'この絵を見るにつけ涙する。', '이 그림을 볼 때마다 눈물이 난다.', 2);

  -- 1061. ～そうにない (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～そうにない (#2)', '~하지 않을 것 같다', '양태+ない. 강조 반복형', '문법-형식판단', 1061, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日も降りそうにない。', '오늘도 안 올 것 같다.', 1),
    (w, '時間内に終わりそうにない。', '시간 내에 끝나지 않을 것 같다.', 2);

  -- 1062. ～かというと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かというと', '~냐 하면', 'か+と+いう+と. 「~인가 하면 (실은)」 화제 도입', '문법-형식판단', 1062, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '好きかというと、好きだ。', '좋아하냐 하면, 좋아한다.', 1),
    (w, 'なぜかというと、簡単だからだ。', '왜냐 하면, 쉽기 때문이다.', 2);

  -- 1063. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことから', '~라서', 'こと+から. 「~라는 사실로부터」 격식체 원인', '문법-형식판단', 1063, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が多いことから注意が必要だ。', '사고가 많아서 주의가 필요하다.', 1),
    (w, '雨が降ったことから道が滑る。', '비가 와서 길이 미끄럽다.', 2);

  -- 1064. 見込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '見込み', 'みこみ', '예상, 전망', '見(볼 견)+込(담을 입)む의 명사형. 「내다보는 전망」', '문법-형식판단', 1064, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '回復の見込みがある。', '회복할 전망이 있다.', 1),
    (w, '完成の見込みは来月だ。', '완성 예상은 다음 달이다.', 2);

  -- 1065. ～てはいられない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てはいられない', '~하고 있을 수는 없다', 'て+は+いられない. 「~의 여유가 없다」', '문법-형식판단', 1065, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'のんびりしてはいられない。', '느긋하게 있을 수는 없다.', 1),
    (w, '黙ってはいられない。', '잠자코 있을 수는 없다.', 2);

  -- 1066. ～んだっけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～んだっけ', '~하는 거지?', 'んだ+っけ. 「~던가?·~던가」 회상 확인', '문법-형식판단', 1066, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日休みなんだっけ。', '내일 휴일이었던가?', 1),
    (w, 'どこに行くんだっけ。', '어디 가는 거였지?', 2);

  -- 1067. ～つもりはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～つもりはない', '~할 생각은 없다', 'つもり(작정)+は+ない. 「~할 의도가 없다」 강한 부정 의지', '문법-형식판단', 1067, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '謝るつもりはない。', '사과할 생각은 없다.', 1),
    (w, '行くつもりはない。', '갈 생각은 없다.', 2);

  -- 1068. ～をも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をも', '~도', 'を+も. 「~조차도」 격식체 강조 망라', '문법-형식판단', 1068, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '命をも惜しまない。', '목숨조차 아끼지 않는다.', 1),
    (w, '困難をも乗り越える。', '곤란도 극복한다.', 2);

  -- 1069. いつか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いつか', '언젠가', '何(어찌 하)時(때 시)+か. 「언젠가 (불확정 시점)」', '문법-형식판단', 1069, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'いつか必ず会おう。', '언젠가 꼭 만나자.', 1),
    (w, 'いつかこの夢が叶う。', '언젠가 이 꿈이 이루어진다.', 2);

  -- 1070. ～をもって (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をもって (#2)', '~을 끝으로', '以(써 이)って. 「~을 가지고」 격식체 시기 종결', '문법-형식판단', 1070, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本日をもって閉店いたします。', '오늘로 폐점합니다.', 1),
    (w, '3月をもって退職する。', '3월을 끝으로 퇴직한다.', 2);

  -- 1071. ～まま
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～まま', '~하는 채', '儘(다할 진): 「그 상태 그대로」', '문법-형식판단', 1071, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '靴を履いたまま入る。', '신발을 신은 채 들어간다.', 1),
    (w, 'テレビをつけたまま寝た。', 'TV를 켠 채 잠들었다.', 2);

  -- 1072. ～を除いて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を除いて', '~을 제외하고', '除(덜 제)く: 「~을 빼고」', '문법-형식판단', 1072, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼を除いて全員参加した。', '그를 제외하고 전원 참가했다.', 1),
    (w, '雨の日を除いて毎日歩く。', '비 오는 날을 빼고 매일 걷는다.', 2);

  -- 1073. ～とは存じます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とは存じます', '~이시리라 생각합니다', 'と+は+存(있을 존)じる. 격식체 추량 (#2)', '문법-형식판단', 1073, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ご多忙とは存じますが。', '바쁘시리라 생각합니다만.', 1),
    (w, 'ご無理とは存じますが。', '무리이시리라 생각합니다만.', 2);

  -- 1074. ～てからというもの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てからというもの', '~하고 나서부터', 'てから+という+もの. 「~한 이래로 (계속)」', '문법-형식판단', 1074, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚してからというもの忙しい。', '결혼하고 나서부터 바쁘다.', 1),
    (w, '上京してからというもの帰省していない。', '상경한 이래로 귀성하지 않았다.', 2);

  -- 1075. ～っぱなしだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～っぱなしだ', '~한 채이다', '放(놓을 방)し+だ. 「~을 놔둔 채」 방치 상태', '문법-형식판단', 1075, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気をつけっぱなしだ。', '불을 켜 놓은 채다.', 1),
    (w, '窓を開けっぱなしだ。', '창문을 열어 둔 채다.', 2);

  -- 1076. ～なんてもんじゃない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なんてもんじゃない', '매우 ~하다', 'なんて+もの+じゃない. 「~로 표현 못할 정도로」', '문법-형식판단', 1076, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寒いなんてもんじゃない。', '추운 정도가 아니다.', 1),
    (w, '驚いたなんてもんじゃない。', '놀란 정도가 아니다.', 2);

  -- 1077. ～ものだ (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものだ (#2)', '~하곤 했다', 'もの+だ. 「~하곤 했다」 회상·습관', '문법-형식판단', 1077, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供のころよく遊んだものだ。', '어릴 적 자주 놀곤 했다.', 1),
    (w, '昔はそうしたものだ。', '옛날엔 그랬다.', 2);

  -- 1078. ～に思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に思う', '~로 생각하다', 'に+思う. 「~하게 느끼다」 감정·평가', '문법-형식판단', 1078, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '残念に思う。', '아쉽게 생각한다.', 1),
    (w, '不思議に思う。', '이상하게 생각한다.', 2);

  -- 1079. ～からしか～ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からしか～ない', '~에서 밖에 ~않다', 'から+しか+ない. 「~로부터 외에는 ~할 수 없다」', '문법-형식판단', 1079, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この駅からしか乗れない。', '이 역에서밖에 탈 수 없다.', 1),
    (w, '彼からしか聞けない情報だ。', '그에게서밖에 들을 수 없는 정보다.', 2);

  -- 1080. そのものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そのものだ', '그 자체이다', 'その(그)+もの(物)+だ. 「~자체·바로 그것」 강조', '문법-형식판단', 1080, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誠実そのものだ。', '성실 그 자체다.', 1),
    (w, '美しさそのものだ。', '아름다움 그 자체다.', 2);

  -- 1081. ～うちに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～うちに', '~하는 사이에', '内(안 내)に. 「~하는 동안에」', '문법-형식판단', 1081, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若いうちに勉強する。', '젊을 때 공부한다.', 1),
    (w, '見ているうちに眠くなった。', '보는 사이에 졸렸다.', 2);

  -- 1082. ～ところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ところ', '~때, ~상황에', '所(곳 소). 「~한 시점에」 격식체 시점', '문법-형식판단', 1082, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰ろうとしたところに電話が来た。', '돌아가려던 참에 전화가 왔다.', 1),
    (w, 'お忙しいところすみません。', '바쁘신 와중에 죄송합니다.', 2);

  -- 1083. ～んじゃないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～んじゃないか', '~하는 게 아닌가', 'の+じゃ+ない+か. 「~인 것이 아닌가」 추측·확인', '문법-형식판단', 1083, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '間違っているんじゃないか。', '잘못된 거 아닌가?', 1),
    (w, '無理なんじゃないか。', '무리인 거 아닌가?', 2);

  -- 1084. ～なくもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なくもない', '~못할 것도 없다', 'なく+も+ない. 이중부정 완곡 긍정', '문법-형식판단', 1084, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けなくもない。', '못 갈 것도 없다.', 1),
    (w, '分かりなくもない。', '이해 못 할 것도 없다.', 2);

  -- 1085. おいでくださる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'おいでくださる', 'おいでくださる', '와 주시다', 'お+いで+くださる. 「와 주시다」 정중 존경', '문법-형식판단', 1085, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お忙しい中、おいでくださいました。', '바쁘신 중에 와 주셨습니다.', 1),
    (w, 'またおいでくださいませ。', '또 와 주십시오.', 2);

  -- 1086. ～たつもり (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たつもり (#2)', '~한 셈, ~한 기분', 'た+つもり. 「~한 것으로 친다」 가정·자기 만족', '문법-형식판단', 1086, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行に行ったつもりで貯金する。', '여행 간 셈 치고 저축한다.', 1),
    (w, '勝ったつもりだ。', '이긴 셈 친다.', 2);

  -- 1087. ～もん (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～もん (#2)', '~인 걸', 'もの의 회화 축약. 강조 반복형', '문법-형식판단', 1087, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できないんだもん。', '할 수 없는걸.', 1),
    (w, '欲しいんだもん。', '갖고 싶은걸.', 2);

  -- 1088. ～を機に (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を機に (#2)', '~을 계기로', '機(틀 기). 강조 반복형. 「~을 전환점으로」', '문법-형식판단', 1088, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '転勤を機に引っ越した。', '전근을 계기로 이사했다.', 1),
    (w, '退職を機に旅に出る。', '퇴직을 계기로 여행을 떠난다.', 2);

  -- 1089. ～あっての
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～あっての', '~있고 나서', 'あって+の. 「~이 있어서 비로소」 의존 강조', '문법-형식판단', 1089, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '客あっての商売だ。', '손님이 있어야 장사다.', 1),
    (w, '健康あっての成功だ。', '건강이 있어야 성공이다.', 2);

  -- 1090. ～返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～返す', '되풀이하여 ~하다', '返(돌이킬 반)す. 「~을 되돌리다·반복하다」 동작 반복', '문법-형식판단', 1090, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何度も読み返す。', '몇 번이고 다시 읽는다.', 1),
    (w, '言い返す。', '맞받아치다.', 2);

  -- 1091. ～てばかりいる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てばかりいる', '~만 하고 있다', 'て+ばかり+いる. 「~만 줄곧」 부정적 평가', '문법-형식판단', 1091, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遊んでばかりいる。', '놀고만 있다.', 1),
    (w, '泣いてばかりいる。', '울고만 있다.', 2);

  -- 1092. ～といたしましては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といたしましては', '~로서는', 'と+いたす(겸양)+まして+は. 「~의 입장에서는」 격식체', '문법-형식판단', 1092, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私といたしましては反対です。', '저로서는 반대입니다.', 1),
    (w, '会社といたしましては困ります。', '회사로서는 곤란합니다.', 2);

  -- 1093. ～はいいが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～はいいが', '~하긴 했는데', 'は+いい+が. 「~은 좋은데 (그런데)」 역접·문제 제시', '문법-형식판단', 1093, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買ったはいいが、使い方が分からない。', '사긴 샀는데 사용법을 모른다.', 1),
    (w, '言ったはいいが反対された。', '말은 했는데 반대당했다.', 2);

  -- 1094. ～思いをする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～思いをする', '~기분이 들다', '思(생각할 사)い+を+する. 「~기분·경험을 하다」', '문법-형식판단', 1094, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '怖い思いをした。', '무서운 경험을 했다.', 1),
    (w, '辛い思いをする。', '괴로운 기분이 든다.', 2);

  -- 1095. 見える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '見える', 'みえる', '오시다', '見える: 来る의 존경어 「오시다」', '문법-형식판단', 1095, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長が見えました。', '사장님이 오셨습니다.', 1),
    (w, 'お客様がお見えです。', '손님이 와 계십니다.', 2);

  -- 1096. ～ようとしている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようとしている', '~하려 하다', '의지·추량 よう+と+している. 「~하려 하고 있다」 임박', '문법-형식판단', 1096, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日が沈もうとしている。', '해가 지려 하고 있다.', 1),
    (w, '電車が出発しようとしている。', '전철이 출발하려 하고 있다.', 2);

  -- 1097. ～に決まっている (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に決まっている (#2)', '~임에 틀림없다', 'に+決まっている. 강조 반복형', '문법-형식판단', 1097, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るに決まっている。', '그가 올 것임에 틀림없다.', 1),
    (w, '当たるに決まっている。', '맞을 게 분명하다.', 2);

  -- 1098. ～はする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～はする', '~하기는 하다', 'は+する. 「~만은 하다」 한정 인정', '문법-형식판단', 1098, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行きはするが乗らない。', '가긴 하지만 타지는 않는다.', 1),
    (w, '見はするが買わない。', '보긴 하지만 사지 않는다.', 2);

  -- 1099. ～にして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にして', '~가 되어', 'に+して. 「~에 이르러서 비로소」 격식체 시간 도달', '문법-형식판단', 1099, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '60にして悟った。', '60이 되어서 깨달았다.', 1),
    (w, '今にして思えば後悔だ。', '지금에 와서 생각하면 후회다.', 2);

  -- 1100. お越しになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'お越しになる', 'おこしになる', '오시다', 'お+越(넘을 월)す+になる. 来る의 존경어', '문법-형식판단', 1100, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長がお越しになりました。', '사장님이 오셨습니다.', 1),
    (w, 'ご家族でお越しになる。', '가족 동반으로 오시다.', 2);

  -- 1101. ～かどうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かどうか', '~인지 아닌지', 'か+どう+か. 「~할지 안 할지」 의문 선택', '문법-형식판단', 1101, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くかどうか迷う。', '갈지 말지 망설인다.', 1),
    (w, '本当かどうか分からない。', '사실인지 아닌지 모른다.', 2);

  -- 1102. ～かのごとく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かのごとく', '~인 것처럼', 'か+の+如(같을 여)く. 「마치 ~인 것처럼」 격식체 비유', '문법-형식판단', 1102, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何事もなかったかのごとく振る舞う。', '아무 일도 없었던 것처럼 행동한다.', 1),
    (w, '夢かのごとく感じる。', '꿈인 것처럼 느낀다.', 2);

  -- 1103. ～始末だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～始末だ', '~꼴이다', '始(시작 시)末(끝 말)+だ. 「(결국) ~의 꼴이 되다」 부정적 결말', '문법-형식판단', 1103, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣き出す始末だ。', '울기 시작하는 꼴이다.', 1),
    (w, '怒鳴られる始末だ。', '꾸중 듣는 꼴이다.', 2);

  -- 1104. ～だけのことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけのことだ', '~일 뿐이다', 'だけ+の+こと+だ. 「~할 뿐이다」 단순화', '문법-형식판단', 1104, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やればいいだけのことだ。', '하면 될 뿐이다.', 1),
    (w, '謝るだけのことだ。', '사과하면 될 일이다.', 2);

  -- 1105. ～ことはない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことはない', '~할 필요 없다', 'こと+は+ない. 「~할 필요가 없다」 충고·위로', '문법-형식판단', 1105, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気にすることはない。', '신경 쓸 필요 없다.', 1),
    (w, '泣くことはない。', '울 필요 없다.', 2);

  -- 1106. 見込み (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '見込み', 'みこみ', '예상, 전망', '見(볼 견)+込(담을 입)む의 명사형. 강조 반복형', '문법-형식판단', 1106, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今年の見込みは黒字だ。', '올해 전망은 흑자다.', 1),
    (w, '雨の見込みが高い。', '비가 올 전망이 높다.', 2);

  -- 1107. ～ものだ (#3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものだ (#3)', '~인 법이다', 'もの+だ. 일반 진리·당위. 「~한 법이다」', '문법-형식판단', 1107, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若い時は失敗するものだ。', '젊을 때는 실패하는 법이다.', 1),
    (w, '人は支え合うものだ。', '사람은 서로 의지하는 법이다.', 2);

  -- 1108. ～だけ無駄だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけ無駄だ', '~할 필요 없다', 'だけ+無駄(무다)+だ. 「~해 봐야 헛수고」', '문법-형식판단', 1108, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言うだけ無駄だ。', '말해 봐야 헛수고다.', 1),
    (w, '頼むだけ無駄だ。', '부탁해 봐야 소용없다.', 2);

  -- 1109. ～を受けて (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を受けて (#2)', '~로 인해', '受(받을 수)けて. 강조 반복형. 「~의 영향으로」', '문법-형식판단', 1109, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件を受けて対策を講じる。', '사건으로 인해 대책을 강구한다.', 1),
    (w, '要請を受けて出動した。', '요청을 받아 출동했다.', 2);

  -- 1110. ～なり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なり', '~하자마자', 'なり: 「~한 즉시」 격식체 즉시성', '문법-형식판단', 1110, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰宅するなり倒れた。', '귀가하자마자 쓰러졌다.', 1),
    (w, '見るなり泣き出した。', '보자마자 울기 시작했다.', 2);


  -- ============================================================
  -- 문법-문장완성 205개 (PDF p.47~57)
  -- ============================================================

  -- 1111. ～恐れがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～恐れがある', '~할 우려가 있다', '恐(두려울 공)れ+が+ある. 「~의 위험이 있다」 격식체', '문법-문장완성', 1111, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '台風が直撃する恐れがある。', '태풍이 직격할 우려가 있다.', 1),
    (w, '健康を害する恐れがある。', '건강을 해칠 우려가 있다.', 2);

  -- 1112. ～きれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～きれない', '~할 수 없다', '切(끊을 절)れる+ない. 「다 ~하지 못하다」 한계', '문법-문장완성', 1112, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感謝してもしきれない。', '아무리 감사해도 다할 수 없다.', 1),
    (w, '一日では読みきれない。', '하루로는 다 읽을 수 없다.', 2);

  -- 1113. ～ところだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ところだ', '~상황이다', '所(곳 소)+だ. 「~할 참이다·막 ~하려는 상황」', '문법-문장완성', 1113, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今出るところだ。', '지금 나가려는 참이다.', 1),
    (w, '食べ終わったところだ。', '막 다 먹은 참이다.', 2);

  -- 1114. ～てみせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てみせる', '~해 보이다', 'て+見(볼 견)せる. 「(증명하듯) 해 보이다」 결의·과시', '문법-문장완성', 1114, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '必ず合格してみせる。', '반드시 합격해 보이겠다.', 1),
    (w, '私が勝ってみせます。', '제가 이겨 보이겠습니다.', 2);

  -- 1115. ～という
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～という', '~라고 한다', 'と+いう. 「~라고 한다」 인용·소개', '문법-문장완성', 1115, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は教師だという。', '그는 교사라고 한다.', 1),
    (w, 'これは伝統という。', '이것을 전통이라고 한다.', 2);

  -- 1116. ～てはならない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てはならない', '~해서는 안 된다', 'て+は+ならない. 「~의 일이 있으면 안 됨」 강한 금지', '문법-문장완성', 1116, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '嘘をついてはならない。', '거짓말해서는 안 된다.', 1),
    (w, '油断してはならない。', '방심해서는 안 된다.', 2);

  -- 1117. ～なんかでいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なんかでいい', '~로 괜찮다', 'なんか(경시)+で+いい. 「~정도로 충분」 겸손 또는 가벼움', '문법-문장완성', 1117, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お茶なんかでいいですか。', '차로 괜찮습니까?', 1),
    (w, '簡単なものなんかでいい。', '간단한 거 정도로 좋다.', 2);

  -- 1118. ～あっての
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～あっての (#2)', '~있고 나서의', 'あって+の. 「~이 있어야 비로소」 의존 강조 반복', '문법-문장완성', 1118, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康あっての人生だ。', '건강이 있어야 인생이다.', 1),
    (w, '皆様あっての我が社です。', '여러분이 있어야 저희 회사입니다.', 2);

  -- 1119. ～からには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からには', '~하는 이상에는', 'から+には. 「~한 이상은 (당연히)」 결의·각오', '문법-문장완성', 1119, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束したからには守る。', '약속한 이상은 지킨다.', 1),
    (w, 'やるからには全力で。', '하는 이상은 전력으로.', 2);

  -- 1120. ～だけあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけあって (#2)', '~인 만큼', 'だけ+あって. 강조 반복형. 「~의 가치만큼 당연히」', '문법-문장완성', 1120, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日本に住んでいただけあって日本語が上手だ。', '일본에 산 만큼 일본어가 능숙하다.', 1),
    (w, '勉強しただけあって合格した。', '공부한 만큼 합격했다.', 2);

  -- 1121. ～というような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というような', '~와 같은', 'と+いう+ような. 「~과 같이」 예시·인용', '문법-문장완성', 1121, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '感謝というような感情。', '감사와 같은 감정.', 1),
    (w, '彼が来ないというような気がする。', '그가 안 올 것 같은 기분이 든다.', 2);

  -- 1122. ～によるところが大きい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～によるところが大きい', '~에 의한 바가 크다', 'に+よる+所+が+大きい. 「~에 의존하는 부분이 크다」', '문법-문장완성', 1122, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功は彼の努力によるところが大きい。', '성공은 그의 노력에 의한 바가 크다.', 1),
    (w, '結果は運によるところが大きい。', '결과는 운에 의한 바가 크다.', 2);

  -- 1123. ～からして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からして', '~부터가', 'から+して. 「~조차도」 극단적 예시', '문법-문장완성', 1123, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前からして変だ。', '이름부터가 이상하다.', 1),
    (w, '見た目からして違う。', '겉모습부터가 다르다.', 2);

  -- 1124. ～さえ～ば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～さえ～ば', '~만 ~하면', 'さえ+ば. 「~만 ~하면 충분」 최소 조건', '문법-문장완성', 1124, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君さえ来れば成功する。', '너만 오면 성공한다.', 1),
    (w, '時間さえあれば旅行する。', '시간만 있으면 여행한다.', 2);

  -- 1125. ～って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～って(＝という)', '~라는', 'って: という의 회화 축약. 인용·소개', '문법-문장완성', 1125, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中って人を知ってる？', '다나카라는 사람 알아?', 1),
    (w, '今日って忙しい？', '오늘은 바빠?', 2);

  -- 1126. ～ならではの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ならではの (#4)', '~만의, ~다운', 'なら+で+は+の. 강조 반복형. 고유성', '문법-문장완성', 1126, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼ならではの優しさだ。', '그만의 다정함이다.', 1),
    (w, '春ならではの風景。', '봄만의 풍경.', 2);

  -- 1127. ～ばかりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ばかりに', '~탓에', 'ばかり+に. 「~만이 원인이 되어」 부정적 결과', '문법-문장완성', 1127, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '油断したばかりに失敗した。', '방심한 탓에 실패했다.', 1),
    (w, '一言言ったばかりに怒られた。', '한마디 한 탓에 혼났다.', 2);

  -- 1128. ～こそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こそ', '~야말로', '계조사 こそ. 「바로 ~」 강한 강조', '문법-문장완성', 1128, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度こそ成功する。', '이번에야말로 성공한다.', 1),
    (w, 'これこそが本物だ。', '이것이야말로 진짜다.', 2);

  -- 1129. ～だけのことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけのことだ (#2)', '~하면 되는 일이다', 'だけ+の+こと+だ. 「~하면 끝이다」 단순화', '문법-문장완성', 1129, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行けばいいだけのことだ。', '가면 되는 일이다.', 1),
    (w, 'やり直すだけのことだ。', '다시 하면 되는 일이다.', 2);

  -- 1130. ～と思いきや
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と思いきや (#2)', '~라고 생각했더니', 'と+思いきや. 강조 반복. 「~인 줄 알았는데 의외로」', '문법-문장완성', 1130, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '簡単と思いきや難しかった。', '쉬울 줄 알았는데 어려웠다.', 1),
    (w, '勝ったと思いきや負けた。', '이긴 줄 알았는데 졌다.', 2);

  -- 1131. ～となると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～となると', '~가 되면', 'と+なる+と. 「~의 상황이 되면」 단계 가정', '문법-문장완성', 1131, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本番となると緊張する。', '실전이 되면 긴장한다.', 1),
    (w, '結婚となると話は別だ。', '결혼이 되면 얘기는 다르다.', 2);

  -- 1132. ～のみならず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～のみならず', '~뿐만 아니라', '의 격식체 のみ(만)+ならず. 「~만 아니라」 격식체', '문법-문장완성', 1132, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強のみならず運動もできる。', '공부뿐만 아니라 운동도 할 수 있다.', 1),
    (w, '国内のみならず海外でも有名だ。', '국내뿐만 아니라 해외에서도 유명하다.', 2);

  -- 1133. ～わけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～わけではない (#2)', '~인 것은 아니다', '訳(역)+で+は+ない. 강조 반복. 부분 부정', '문법-문장완성', 1133, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反対しているわけではない。', '반대하는 것은 아니다.', 1),
    (w, '全部知っているわけではない。', '전부 아는 것은 아니다.', 2);

  -- 1134. ～次第だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～次第だ', '~에 달려 있다', '次(다음 차)第(차례 제)+だ. 「~의 상황에 좌우됨」', '문법-문장완성', 1134, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果は努力次第だ。', '결과는 노력에 달려 있다.', 1),
    (w, '成功はあなた次第だ。', '성공은 당신에게 달려 있다.', 2);

  -- 1135. ～しようとしまいと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～しようとしまいと', '~하든 ~말든', '의지 しよう+と+しまい+と. 「~하든 안 하든 상관없이」', '문법-문장완성', 1135, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行こうと行くまいと君の自由だ。', '가든 말든 네 자유다.', 1),
    (w, '彼が来ようと来まいと進める。', '그가 오든 말든 진행한다.', 2);

  -- 1136. ～つもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～つもり', '~하는 생각', '積(쌓을 적)もり. 「~할 작정」 의도', '문법-문장완성', 1136, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '謝るつもりだ。', '사과할 생각이다.', 1),
    (w, '行くつもりはない。', '갈 생각은 없다.', 2);

  -- 1137. ～と(＝でも)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と(＝でも)', '~라고(~라도)', 'と+(でも). 「~이라도」 가정 양보 축약', '문법-문장완성', 1137, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何と言われようと気にしない。', '뭐라 해도 신경 안 쓴다.', 1),
    (w, '誰が来ようと進める。', '누가 와도 진행한다.', 2);

  -- 1138. ～ばこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ばこそ', '~하기에', 'ば+こそ. 「~이기에 (당연한 이유)」 격식체 강조', '문법-문장완성', 1138, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛していればこそ叱る。', '사랑하기에 꾸짖는다.', 1),
    (w, '健康であればこそ働ける。', '건강하기에 일할 수 있다.', 2);

  -- 1139. ～しようと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～しようと', '~할지라도', '의지 しよう+と. 「~할지언정」 강한 양보', '문법-문장완성', 1139, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰が反対しようと進める。', '누가 반대해도 진행한다.', 1),
    (w, '何が起きようと心配ない。', '뭐가 일어나도 걱정 없다.', 2);

  -- 1140. ～て参る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～て参る', '~해 가다 <겸양>', 'て+参(참여할 참)る. 来る·行く의 겸양. 「~해 가다·오다」', '문법-문장완성', 1140, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑張って参ります。', '열심히 해 나가겠습니다.', 1),
    (w, '勉強して参りました。', '공부하고 왔습니다.', 2);

  -- 1141. ～にあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にあって', '~에서', 'に+あって. 「~에서·~한 상황에서」 격식체 시간·장소', '문법-문장완성', 1141, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '困難な状況にあって冷静だ。', '곤란한 상황에서 침착하다.', 1),
    (w, '危機にあって団結する。', '위기 속에서 단결한다.', 2);

  -- 1142. ～(よ)うにできない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(よ)うにできない', '~하려고 해도 할 수 없다', '의지 (よ)う+に+できない. 「~하고 싶어도 못 함」', '문법-문장완성', 1142, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '寝ようにも眠れない。', '자려 해도 잘 수 없다.', 1),
    (w, '逃げようにも逃げられない。', '도망치려 해도 도망칠 수 없다.', 2);

  -- 1143. ～からすれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からすれば', '~로 보아', 'から+すれば. 「~의 입장에서 보면」 관점·기준', '문법-문장완성', 1143, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の経験からすれば当然だ。', '그의 경험으로 보아 당연하다.', 1),
    (w, '価格からすれば妥当だ。', '가격으로 보아 타당하다.', 2);

  -- 1144. すくなからぬ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '少なからぬ', 'すくなからぬ', '적지 않다', '少(적을 소)+ から+ぬ(부정). 「적지 않은」 격식체', '문법-문장완성', 1144, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すくなからぬ影響を与える。', '적지 않은 영향을 준다.', 1),
    (w, 'すくなからぬ努力が必要だ。', '적지 않은 노력이 필요하다.', 2);

  -- 1145. ～ついでに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ついでに', '~하는 김에', '序(차례 서)で+に. 「~하는 김에」 부가 행동', '문법-문장완성', 1145, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '買い物のついでに郵便を出した。', '쇼핑하는 김에 우편을 보냈다.', 1),
    (w, '散歩のついでに本を借りた。', '산책하는 김에 책을 빌렸다.', 2);

  -- 1146. ～ところを見ると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ところを見ると', '~인 상황을 보면', '所+を+見る+と. 「~을 보아하니」 판단·추정', '문법-문장완성', 1146, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '笑っているところを見ると元気そうだ。', '웃고 있는 것을 보니 기운 좋아 보인다.', 1),
    (w, '電気がついているところを見ると在宅だ。', '불이 켜져 있는 것을 보니 집에 있다.', 2);

  -- 1147. ～ながらも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ながらも', '~하면서도', 'ながら(동시)+も. 「~함에도 불구하고」 역접 양보', '문법-문장완성', 1147, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '貧しいながらも幸せだ。', '가난하면서도 행복하다.', 1),
    (w, '小さいながらも家を建てた。', '작지만 집을 지었다.', 2);

  -- 1148. ～のみ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～のみ', '~뿐, ~만', '限定 のみ. 「~만」 격식체', '문법-문장완성', 1148, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できるのは私のみだ。', '할 수 있는 것은 나뿐이다.', 1),
    (w, 'あとは待つのみだ。', '이제 기다릴 뿐이다.', 2);

  -- 1149. ～もさることながら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～もさることながら', '~도 그렇지만', 'も+然(그러할 연)る+こと+ながら. 「~도 물론이고」', '문법-문장완성', 1149, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '味もさることながら見た目も美しい。', '맛도 그렇지만 외관도 아름답다.', 1),
    (w, '料金もさることながらサービスがいい。', '요금도 그렇지만 서비스가 좋다.', 2);

  -- 1150. ～ようと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようと (#2)', '~할지라도', '의지·추량 (よ)う+と. 강조 반복형', '문법-문장완성', 1150, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何があろうと諦めない。', '무슨 일이 있어도 포기 않는다.', 1),
    (w, '誰が来ようと驚かない。', '누가 와도 놀라지 않는다.', 2);

  -- 1151. ～ぐらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ぐらい', '정도', '副助詞 ぐらい(位·정도). 「대략의 정도」', '문법-문장완성', 1151, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一時間ぐらいかかる。', '한 시간 정도 걸린다.', 1),
    (w, '10人ぐらいいる。', '10명 정도 있다.', 2);

  -- 1152. それっきり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'それっきり', '그것을 끝으로', 'それ+っきり(限り의 회화). 「그것을 마지막으로」', '문법-문장완성', 1152, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それっきり会っていない。', '그것을 끝으로 만나지 않았다.', 1),
    (w, 'それっきり連絡が途絶えた。', '그것을 끝으로 연락이 끊겼다.', 2);

  -- 1153. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～として', '~로서', 'と+して. 「~의 자격·입장으로」', '문법-문장완성', 1153, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医者として働く。', '의사로서 일하다.', 1),
    (w, '友人として忠告する。', '친구로서 충고한다.', 2);

  -- 1154. ～分
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～分', '~만큼 <정도, 상태>', '分(나눌 분). 「~의 분량·정도」', '문법-문장완성', 1154, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の分まで頑張る。', '내 몫까지 분발한다.', 1),
    (w, '頑張った分だけ成果が出る。', '노력한 만큼 성과가 난다.', 2);

  -- 1155. ～ものがある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものがある', '~한 데가 있다', 'もの+が+ある. 「~한 면이 있다」 평가 강조', '문법-문장완성', 1155, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の演技には鬼気迫るものがある。', '그의 연기에는 섬뜩한 데가 있다.', 1),
    (w, '心に響くものがある。', '마음에 와닿는 데가 있다.', 2);

  -- 1156. ～かというと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かというと (#2)', '~인가 하면', 'か+と+いう+と. 강조 반복형', '문법-문장완성', 1156, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なぜかというと簡単だからだ。', '왜냐 하면 쉽기 때문이다.', 1),
    (w, '好きかというとそうでもない。', '좋아하냐 하면 그렇지도 않다.', 2);

  -- 1157. ～とは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とは', '~라니', 'と+は. 「~이라는 것은」 정의·놀람', '문법-문장완성', 1157, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '愛とは何か。', '사랑이란 무엇인가.', 1),
    (w, '彼がそんなことをするとは。', '그가 그런 짓을 하다니.', 2);

  -- 1158. ～なくして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なくして', '~없이', '無(없을 무)く+して. 「~없이는」 격식체', '문법-문장완성', 1158, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '努力なくして成功はない。', '노력 없이 성공은 없다.', 1),
    (w, '愛なくして人生は語れない。', '사랑 없이 인생은 말할 수 없다.', 2);

  -- 1159. ～にして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にして (#2)', '~에, ~으로 <수량의 강조>', 'に+して. 「~에 이르러서 비로소」 시기 도달', '문법-문장완성', 1159, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '50歳にして始めた。', '50세에 시작했다.', 1),
    (w, '一週間にして完成した。', '일주일 만에 완성했다.', 2);

  -- 1160. ～までに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～までに', '~할 정도로', '迄(까지 흘)+に. 「~까지의 기한·정도」', '문법-문장완성', 1160, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くまでに感動した。', '울 정도로 감동했다.', 1),
    (w, '明日までに提出する。', '내일까지 제출한다.', 2);

  -- 1161. ～ように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ように (#2)', '~하기를 <희망,의뢰>', '様(양)に. 「~하기를 (희망)」 기원', '문법-문장완성', 1161, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格しますように。', '합격하기를.', 1),
    (w, '元気になりますように。', '건강해지기를.', 2);

  -- 1162. ～からといって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からといって', '~라고 해서', 'から+と+いって. 「~의 이유만으로 (는 ~하지 않다)」', '문법-문장완성', 1162, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '高いからといって品質がいいとは限らない。', '비싸다고 해서 품질이 좋은 것은 아니다.', 1),
    (w, '若いからといって油断するな。', '젊다고 해서 방심하지 마라.', 2);

  -- 1163. ～といったら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～といったら', '~로 말하자면', 'と+いったら. 「~을 말하면 (그 정도가)」 강조', '문법-문장완성', 1163, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その喜びといったらなかった。', '그 기쁨은 말할 수 없을 정도였다.', 1),
    (w, '怒ったといったらない。', '몹시 화났다.', 2);

  -- 1164. ～とみられる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とみられる', '~로 보인다', 'と+見られる(자발 수동). 「~로 추정된다」', '문법-문장완성', 1164, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '原因は事故とみられる。', '원인은 사고로 보인다.', 1),
    (w, '彼が犯人とみられる。', '그가 범인으로 보인다.', 2);

  -- 1165. ～に至る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に至る', '~에 이르다', 'に+至(이를 지)る. 「~에 도달하다」 격식체', '문법-문장완성', 1165, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結論に至る。', '결론에 이른다.', 1),
    (w, '死に至る病。', '죽음에 이르는 병.', 2);

  -- 1166. ～には(＝にとっては)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～には(＝にとっては)', '~에게는', 'に+は. 「~에게는·~의 입장에서는」', '문법-문장완성', 1166, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私には難しい。', '나에게는 어렵다.', 1),
    (w, '子供には早い時間だ。', '아이에게는 이른 시간이다.', 2);

  -- 1167. ～ようがない (#4)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようがない (#4)', '~할 방도가 없다', 'よう(様)+が+ない. 강조 반복', '문법-문장완성', 1167, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言いようがない。', '말할 방도가 없다.', 1),
    (w, '助けようがなかった。', '도울 방도가 없었다.', 2);

  -- 1168. ～をもって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をもって (#3)', '~으로써', '以(써 이)って. 「~을 가지고·~로써」 격식체 수단', '문법-문장완성', 1168, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誠意をもって謝罪する。', '성의를 가지고 사과한다.', 1),
    (w, '責任をもって対応する。', '책임을 갖고 대응한다.', 2);

  -- 1169. ～かもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かもしれない', '~할지도 모른다', 'か+も+知(알 지)れない. 「~할 가능성」 약한 추측', '문법-문장완성', 1169, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るかもしれない。', '비가 올지도 모른다.', 1),
    (w, '間違いかもしれない。', '잘못일지도 모른다.', 2);

  -- 1170. ～なんて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なんて', '~라니', 'などと의 회화 축약. 「~이라니」 놀람·경시', '문법-문장완성', 1170, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来ないなんて意外だ。', '그가 안 오다니 의외다.', 1),
    (w, '失敗するなんて思わなかった。', '실패할 거라곤 생각 못 했다.', 2);

  -- 1171. ～にたえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にたえる', '~할 만하다', 'に+堪(견딜 감)える. 「~의 가치가 있다」', '문법-문장완성', 1171, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '鑑賞にたえる作品だ。', '감상할 만한 작품이다.', 1),
    (w, '使用にたえる品質だ。', '사용할 만한 품질이다.', 2);

  -- 1172. ～には
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～には', '~하는 경우에는, ~하려면', 'に+は. 「~하기 위해서는」 목적·조건', '문법-문장완성', 1172, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格するには勉強が必要だ。', '합격하려면 공부가 필요하다.', 1),
    (w, '行くには時間がかかる。', '가려면 시간이 걸린다.', 2);

  -- 1173. ～みたいだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～みたいだ', '~인 것 같다', '見(볼 견)た+いだ. 「~로 보이다」 회화체 추량', '문법-문장완성', 1173, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るみたいだ。', '비가 올 것 같다.', 1),
    (w, '彼は疲れているみたいだ。', '그는 피곤한 것 같다.', 2);

  -- 1174. ～ようにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようにする (#2)', '~하도록 하다', '様(양)に+する. 강조 반복형. 「~하도록 노력」', '문법-문장완성', 1174, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早起きするようにする。', '일찍 일어나도록 한다.', 1),
    (w, '健康に気をつけるようにする。', '건강에 신경 쓰도록 한다.', 2);

  -- 1175. ～ことなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことなく', '~하는 일 없이', 'こと+なく. 「~하지 않고」 격식체', '문법-문장완성', 1175, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休むことなく働く。', '쉬는 일 없이 일한다.', 1),
    (w, '諦めることなく挑戦する。', '포기하는 일 없이 도전한다.', 2);

  -- 1176. ～との(＝という)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～との(＝という)', '~라는', 'と+の. 「~라고 하는」 격식체 인용', '문법-문장완성', 1176, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るとの話だ。', '그가 온다는 이야기다.', 1),
    (w, '中止との連絡を受けた。', '중지라는 연락을 받았다.', 2);

  -- 1177. ～にしても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にしても', '~라고 하더라도', 'に+しても. 「~의 경우도」 양보·예시', '문법-문장완성', 1177, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨にしても今日来るだろう。', '비라도 오늘 올 것이다.', 1),
    (w, '誰がやるにしても大変だ。', '누가 하든 힘들다.', 2);

  -- 1178. ～にとって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にとって', '~에게 있어서', 'に+取(취할 취)って. 「~의 입장에서」', '문법-문장완성', 1178, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私にとって大切な人だ。', '나에게 있어서 소중한 사람이다.', 1),
    (w, '子供にとって遊びは仕事だ。', '아이에게 있어 놀이는 일이다.', 2);

  -- 1179. ～への
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～への', '~으로의', 'へ+の. 「~을 향한」 방향 명사 수식', '문법-문장완성', 1179, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '東京への引っ越し。', '도쿄로의 이사.', 1),
    (w, '未来への希望。', '미래로의 희망.', 2);

  -- 1180. ～ものか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ものか', '~하지 않겠다', 'もの+か. 「~할 리가 있을까」 반어 강한 부정', '문법-문장완성', 1180, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう二度と行くものか。', '두 번 다시는 가지 않겠다.', 1),
    (w, '負けるものか。', '질 리가 있나.', 2);

  -- 1181. ～か否か
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～か否か', '~인지 어떤지', 'か+否(아닐 부)か. 「~인지 아닌지」 격식체 의문 선택', '문법-문장완성', 1181, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くか否か悩む。', '갈지 말지 고민한다.', 1),
    (w, '本物か否か確認する。', '진짜인지 아닌지 확인한다.', 2);

  -- 1182. ～(さ)せてくれる (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～(さ)せてくれる (#2)', '~하게 해 주다', '사역+くれる. 강조 반복형', '문법-문장완성', 1182, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休ませてくれた。', '쉬게 해 주었다.', 1),
    (w, '考えさせてくれませんか。', '생각하게 해 주시지 않겠습니까?', 2);

  -- 1183. ～たつもり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たつもり (#3)', '~한 셈, ~했다는 생각', 'た+つもり. 「~한 것으로 친다」 가정', '문법-문장완성', 1183, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勝ったつもりだった。', '이긴 줄 알았다.', 1),
    (w, '休んだつもりで動く。', '쉰 셈치고 움직인다.', 2);

  -- 1184. ～という (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～という (#2)', '~라는', 'と+いう. 강조 반복형. 「~라고 하는」 정의·소개', '문법-문장완성', 1184, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '田中という人。', '다나카라는 사람.', 1),
    (w, '愛という名の感情。', '사랑이라는 이름의 감정.', 2);

  -- 1185. ～とか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とか', '~라든가', 'と+か. 「~이라든가·~라고」 예시·간접 인용', '문법-문장완성', 1185, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'りんごとかみかんとか。', '사과라든가 귤이라든가.', 1),
    (w, '彼は風邪だとか言っていた。', '그는 감기라든가 했었다.', 2);

  -- 1186. ～きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～きる', '완전히 ~하다, 전부 ~하다', '切(끊을 절)る. 「완전히 끝까지 ~하다」', '문법-문장완성', 1186, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '使いきった。', '다 써 버렸다.', 1),
    (w, '走りきった。', '끝까지 달려냈다.', 2);

  -- 1187. ～だけでなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけでなく', '~뿐만 아니라', 'だけ+で+なく. 「~만 아니라」 추가', '문법-문장완성', 1187, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '味だけでなく見た目もいい。', '맛뿐만 아니라 외관도 좋다.', 1),
    (w, '勉強だけでなく運動もする。', '공부뿐만 아니라 운동도 한다.', 2);

  -- 1188. 誰かしら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '誰かしら', 'だれかしら', '누군가', '誰(누구 수)か+しら(불확정). 「누군가」 불특정', '문법-문장완성', 1188, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰かしら知っているはずだ。', '누군가는 알고 있을 것이다.', 1),
    (w, '誰かしら助けてくれる。', '누군가는 도와줄 것이다.', 2);

  -- 1189. どうだって(＝どうでも)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どうだって(＝どうでも)', '아무래도', 'どう+だって. 「어떻게 되든」 무관심·강조', '문법-문장완성', 1189, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どうだっていい。', '아무래도 좋다.', 1),
    (w, '彼の意見はどうだっていい。', '그의 의견은 아무래도 좋다.', 2);

  -- 1190. ～として (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～として (#2)', '~라고 하여', 'と+して. 「~의 이유·자격으로」', '문법-문장완성', 1190, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記念として贈る。', '기념으로 보낸다.', 1),
    (w, '罰として残業した。', '벌로 잔업했다.', 2);


  -- 1191. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ほど', '~정도', '副助詞 ほど(程·정도). 「~만큼·~의 정도」', '문법-문장완성', 1191, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くほど嬉しい。', '울 정도로 기쁘다.', 1),
    (w, '思っていたほど難しくない。', '생각만큼 어렵지 않다.', 2);

  -- 1192. ～直す(を)繰り返し
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～直す(を)繰り返し', '고치기를 반복하여 <생략>', '直(곧을 직)す+繰(걷을 견)り返し. 「~을 거듭 반복」', '문법-문장완성', 1192, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '書き直しを繰り返した。', '고쳐쓰기를 반복했다.', 1),
    (w, 'やり直しを繰り返してついに完成。', '다시 하기를 반복하여 마침내 완성.', 2);

  -- 1193. ～なりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なりに', '~나름대로', 'なり+に. 「~의 분수에 맞게」 자기 기준', '문법-문장완성', 1193, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自分なりに頑張った。', '나름대로 분발했다.', 1),
    (w, '子供なりに考えている。', '아이 나름대로 생각하고 있다.', 2);

  -- 1194. ～には及ばない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～には及ばない', '~에는 미치지 않는다', 'に+は+及(미칠 급)ばない. 「~에 못 미치다·필요 없다」', '문법-문장완성', 1194, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心配には及ばない。', '걱정할 필요 없다.', 1),
    (w, '彼の腕には及ばない。', '그의 실력에는 미치지 못한다.', 2);

  -- 1195. ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ことから', '~로부터', 'こと+から. 「~라는 점에서」 격식체 원인', '문법-문장완성', 1195, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が多いことから対策を講じる。', '사고가 많은 점에서 대책을 강구한다.', 1),
    (w, '評判が良いことから人気がある。', '평판이 좋은 점에서 인기가 있다.', 2);

  -- 1196. 以上
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '以上', 'いじょう', '~하는 이상', '以(써 이)+上(위 상). 「~한 이상에는」 결의·논리적 귀결', '문법-문장완성', 1196, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '約束した以上は守る。', '약속한 이상은 지킨다.', 1),
    (w, '社員である以上、規則に従う。', '사원인 이상 규칙을 따른다.', 2);

  -- 1197. わけにはいかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'わけにはいかない', '~할 수 없다', '訳+に+は+いかない. 「(사정상) ~할 수는 없다」', '문법-문장완성', 1197, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休むわけにはいかない。', '쉴 수는 없다.', 1),
    (w, '断るわけにはいかない。', '거절할 수는 없다.', 2);

  -- 1198. ～はずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～はずだ (#2)', '~할 것이다 <확신>', 'はず(筈)+だ. 강조 반복. 「당연히 그러할 것」', '문법-문장완성', 1198, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は来るはずだ。', '그는 올 것이다.', 1),
    (w, '正しいはずだ。', '맞을 것이다.', 2);

  -- 1199. ～ようだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようだ', '~한 것 같다', '様(양)だ. 「~인 듯하다」 부드러운 추량', '문법-문장완성', 1199, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降るようだ。', '비가 올 것 같다.', 1),
    (w, '彼は疲れているようだ。', '그는 피곤한 것 같다.', 2);

  -- 1200. ～によって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～によって', '~에 의해서', 'に+依(의지할 의)って. 「~으로 인하여·~에 따라」', '문법-문장완성', 1200, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼によって発見された。', '그에 의해 발견되었다.', 1),
    (w, '時間によって料金が違う。', '시간에 따라 요금이 다르다.', 2);

  -- 1201. ～まじき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～まじき', '~해서는 안 될', '문어 부정 추량 まじ의 연체형. 「있어서는 안 될」 격식체', '문법-문장완성', 1201, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '教師にあるまじき行動。', '교사로서 있어서는 안 될 행동.', 1),
    (w, '人としてあるまじき発言。', '사람으로서 있어서는 안 될 발언.', 2);

  -- 1202. ～を機に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を機に (#3)', '~을 계기로', '機(틀 기). 강조 반복형', '문법-문장완성', 1202, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入学を機に上京した。', '입학을 계기로 상경했다.', 1),
    (w, '退職を機に旅に出た。', '퇴직을 계기로 여행을 떠났다.', 2);

  -- 1203. ～つつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～つつ', '~하면서도', 'つつ: 「동시·역접」 격식체', '문법-문장완성', 1203, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反省しつつも同じ過ちを繰り返す。', '반성하면서도 같은 잘못을 반복한다.', 1),
    (w, '話しつつ歩く。', '말하면서 걷는다.', 2);

  -- 1204. ～ことにする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことにする', '~하기로 하다', 'こと+に+する. 「~하기로 정하다」 결정', '문법-문장완성', 1204, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明日から早起きすることにする。', '내일부터 일찍 일어나기로 한다.', 1),
    (w, 'タバコをやめることにした。', '담배를 끊기로 했다.', 2);

  -- 1205. ～と言えば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と言えば', '~라고 하면', 'と+言えば. 「~을 말하자면」 화제 도입', '문법-문장완성', 1205, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏と言えば海だ。', '여름이라면 바다다.', 1),
    (w, '京都と言えば寺だ。', '교토라고 하면 절이다.', 2);

  -- 1206. 要するに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '要するに', 'ようするに', '요컨대', '要(요긴할 요)+する+に. 「요약하면」 결론', '문법-문장완성', 1206, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '要するに失敗した。', '요컨대 실패했다.', 1),
    (w, '要するに無理だ。', '요컨대 무리다.', 2);

  -- 1207. ～ごとき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ごとき', '~와 같은', '如(같을 여)き. 「~과 같은」 격식체 비유', '문법-문장완성', 1207, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢のごとき出来事。', '꿈과 같은 사건.', 1),
    (w, '彼ごとき相手ではない。', '그 따위가 상대할 자가 아니다.', 2);

  -- 1208. ～ことなしに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことなしに', '~하지 않고', 'こと+なし+に. 「~하는 일 없이」 격식체', '문법-문장완성', 1208, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休むことなしに働く。', '쉬는 일 없이 일한다.', 1),
    (w, '努力することなしに成功しない。', '노력 없이는 성공하지 않는다.', 2);

  -- 1209. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～として (#3)', '~라고 해서', 'と+して. 「~의 이유·자격으로」 강조 반복', '문법-문장완성', 1209, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無罪として釈放された。', '무죄로 석방되었다.', 1),
    (w, '罰として残された。', '벌로 남게 되었다.', 2);

  -- 1210. ～における
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～における', '~의', '於(어조사 어)+ける. 「~에서의·~에 있어서의」 격식체', '문법-문장완성', 1210, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議における発言。', '회의에서의 발언.', 1),
    (w, '日常生活における工夫。', '일상생활에서의 궁리.', 2);

  -- 1211. ところを
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ところを', '상황을', '所(곳 소)+を. 「~한 상황·시점에」 격식체 양보', '문법-문장완성', 1211, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お忙しいところをすみません。', '바쁘신데 죄송합니다.', 1),
    (w, '寝ているところを起こされた。', '자고 있는데 깨워졌다.', 2);

  -- 1212. ～ことにする (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことにする (#2)', '~하기로 하다', 'こと+に+する. 강조 반복형', '문법-문장완성', 1212, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今度は休むことにする。', '이번에는 쉬기로 한다.', 1),
    (w, '一人で行くことにした。', '혼자 가기로 했다.', 2);

  -- 1213. ～わけにもいかず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～わけにもいかず', '~할 수도 없어', '訳+に+も+いかず(부정 문어). 「(사정상) ~할 수도 없어」', '문법-문장완성', 1213, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '断るわけにもいかず引き受けた。', '거절할 수도 없어 맡았다.', 1),
    (w, '休むわけにもいかず出勤した。', '쉴 수도 없어 출근했다.', 2);

  -- 1214. ～にあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にあって (#2)', '~라서', 'に+あって. 강조 반복형. 「~한 상황이라서」', '문법-문장완성', 1214, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '困難な時期にあって冷静だった。', '어려운 시기에서 침착했다.', 1),
    (w, '危機にあって団結する。', '위기에 처해 단결한다.', 2);

  -- 1215. ～にして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にして (#3)', '~가 되어', 'に+して. 강조 반복형', '문법-문장완성', 1215, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '60にして始めた。', '60이 되어 시작했다.', 1),
    (w, '今にして悟る。', '지금에야 깨닫는다.', 2);

  -- 1216. それで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'それで', '그것으로', '대명사+で. 「그래서·그로 인해」 결과 접속', '문법-문장완성', 1216, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それで電車が遅れたんです。', '그래서 전철이 늦었어요.', 1),
    (w, 'それで結局どうなったの？', '그래서 결국 어떻게 됐어?', 2);

  -- 1217. たとえ～ても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'たとえ～ても', '설령 ~라 해도', 'たとえ(假令)+ても. 「가령 ~라도」 강한 양보', '문법-문장완성', 1217, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たとえ反対されても進める。', '설령 반대당해도 진행한다.', 1),
    (w, 'たとえ高くても買う。', '설령 비싸도 산다.', 2);

  -- 1218. ～ことなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことなく (#2)', '~하지 않고', 'こと+なく. 강조 반복형', '문법-문장완성', 1218, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休むことなく働く。', '쉼 없이 일한다.', 1),
    (w, '諦めることなく挑戦する。', '포기하지 않고 도전한다.', 2);

  -- 1219. ～がちだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～がちだ', '~하기 십상이다', '勝(이길 승)ち+だ. 「~의 경향이 강함」 부정적 경향', '문법-문장완성', 1219, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '忘れがちだ。', '잊기 십상이다.', 1),
    (w, '休みがちだ。', '결석하기 일쑤다.', 2);

  -- 1220. ～だけに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけに (#2)', '~인 만큼', 'だけ+に. 강조 반복. 「~인 만큼 더욱」', '문법-문장완성', 1220, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦労しただけに喜びも大きい。', '고생한 만큼 기쁨도 크다.', 1),
    (w, 'プロだけに違う。', '프로인 만큼 다르다.', 2);

  -- 1221. ～には
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～には (#2)', '~하려면', 'に+は. 강조 반복형', '문법-문장완성', 1221, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功するには努力が必要だ。', '성공하려면 노력이 필요하다.', 1),
    (w, '行くには時間が足りない。', '가기에는 시간이 부족하다.', 2);

  -- 1222. ～かといえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かといえば', '~냐 하면', 'か+と+いえば. 「~인가 하면」 화제 도입', '문법-문장완성', 1222, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なぜかといえば、簡単だからだ。', '왜냐 하면 쉽기 때문이다.', 1),
    (w, '好きかといえば、そうでもない。', '좋아하냐 하면, 그렇지도 않다.', 2);

  -- 1223. ～としては
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～としては', '~로서는', 'と+して+は. 「~의 입장에서는」', '문법-문장완성', 1223, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私としては反対です。', '저로서는 반대입니다.', 1),
    (w, '会社としては困る。', '회사로서는 곤란하다.', 2);

  -- 1224. ～からには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～からには (#2)', '~이상', 'から+には. 강조 반복. 「~한 이상에는」', '문법-문장완성', 1224, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やるからには本気で。', '하는 이상은 진지하게.', 1),
    (w, '言ったからには責任を持つ。', '말한 이상 책임진다.', 2);

  -- 1225. きっかけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'きっかけ', '계기', '명사 きっかけ(切っ掛け). 「발단·계기」', '문법-문장완성', 1225, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '出会いがきっかけで結婚した。', '만남이 계기가 되어 결혼했다.', 1),
    (w, 'これをきっかけに始めた。', '이를 계기로 시작했다.', 2);

  -- 1226. ～ことは～が
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことは～が', '~하기는 ~했지만', 'こと+は+が. 「~하기는 했지만 (역접)」', '문법-문장완성', 1226, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くことは行くが、遅れる。', '가기는 가지만, 늦는다.', 1),
    (w, '読んだことは読んだが、忘れた。', '읽기는 읽었지만, 잊었다.', 2);

  -- 1227. ～くらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～くらい', '~정도로', 'くらい(位·정도). 「대략의 정도」', '문법-문장완성', 1227, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一時間くらいかかる。', '한 시간 정도 걸린다.', 1),
    (w, '泣きたいくらい嬉しい。', '울고 싶을 정도로 기쁘다.', 2);

  -- 1228. ～についてなら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～についてなら', '~에 관해서라면', 'について+なら. 「~에 관해서라면 (잘 안다)」', '문법-문장완성', 1228, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理についてなら任せて。', '요리에 관해서라면 맡겨.', 1),
    (w, 'その件についてなら知っている。', '그 건에 대해서라면 안다.', 2);

  -- 1229. ともかく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ともかく', '어쨌든', '副詞 ともかく. 「우선·하여튼」 잠정 결정', '문법-문장완성', 1229, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ともかく行ってみよう。', '어쨌든 가 보자.', 1),
    (w, 'ともかく時間がない。', '어쨌든 시간이 없다.', 2);

  -- 1230. 何かしら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '何かしら', 'なにかしら', '무언가', '何(어찌 하)か+しら. 「뭔가」 불특정', '문법-문장완성', 1230, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何かしら問題がある。', '뭔가 문제가 있다.', 1),
    (w, '何かしら手伝う。', '뭐든 돕는다.', 2);

  -- 1231. ～ために
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ために', '~하기 위해', '為(할 위)+に. 「~을 위해」 목적·이유', '문법-문장완성', 1231, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家族のために働く。', '가족을 위해 일한다.', 1),
    (w, '雨のために中止だ。', '비 때문에 중지다.', 2);

  -- 1232. ～なかったりで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なかったりで', '~없거나 해서', 'なかったり+で. 「~하지 않는 경우 등으로」', '문법-문장완성', 1232, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だったり晴れだったりで定まらない。', '비가 오거나 맑거나 해서 안정되지 않는다.', 1),
    (w, '行ったり行かなかったりで進まない。', '가다 안 가다 해서 진행이 안 된다.', 2);

  -- 1233. ～うえで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～うえで', '~하는 데 있어', '上(위 상)で. 「~한 후에·~의 점에서」', '문법-문장완성', 1233, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '検討したうえで決める。', '검토한 후 결정한다.', 1),
    (w, '生活する上で大切だ。', '생활하는 데 있어 중요하다.', 2);

  -- 1234. ～として
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～として (#4)', '~로서', 'と+して. 강조 반복', '문법-문장완성', 1234, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友人として相談する。', '친구로서 상담한다.', 1),
    (w, '社員として責任を持つ。', '사원으로서 책임을 진다.', 2);

  -- 1235. ～てまで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てまで', '~하면서까지', 'て+まで. 「~하면서까지 (극단)」 극단적 행위', '문법-문장완성', 1235, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '借金してまで買いたくない。', '빚을 내면서까지 사고 싶지 않다.', 1),
    (w, '休んでまで参加した。', '쉬면서까지 참가했다.', 2);

  -- 1236. 無理に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '無理に', 'むりに', '억지로', '無(없을 무)+理(다스릴 리)+に. 「도리에 어긋나게」', '문법-문장완성', 1236, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無理に飲まないで。', '억지로 마시지 마.', 1),
    (w, '無理に笑った。', '억지로 웃었다.', 2);

  -- 1237. ～こそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こそ (#2)', '~야말로', 'こそ. 강조 반복형', '문법-문장완성', 1237, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今こそチャンスだ。', '지금이야말로 기회다.', 1),
    (w, '私こそ感謝です。', '저야말로 감사합니다.', 2);

  -- 1238. ～ないように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないように', '~하지 않도록', 'ない+ように. 「~하지 않게」 부정 목적', '문법-문장완성', 1238, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遅れないように家を出る。', '늦지 않도록 집을 나선다.', 1),
    (w, '忘れないようにメモする。', '잊지 않도록 메모한다.', 2);

  -- 1239. ～ことから
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことから (#2)', '~여서', 'こと+から. 강조 반복형', '문법-문장완성', 1239, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事故が多いことから注意が必要だ。', '사고가 많아서 주의가 필요하다.', 1),
    (w, '雨が降ったことから道が滑る。', '비가 와서 길이 미끄럽다.', 2);

  -- 1240. ～ようと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようと (#3)', '~하려고', '의지 (よ)う+と. 「~할 마음으로」', '문법-문장완성', 1240, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強しようと机に向かう。', '공부하려고 책상 앞에 앉는다.', 1),
    (w, '行こうとした時に電話が来た。', '가려던 참에 전화가 왔다.', 2);

  -- 1241. ～までもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～までもない', '~할 필요도 없다', '迄(까지 흘)+も+ない. 「당연하여 ~할 필요 없음」', '문법-문장완성', 1241, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言うまでもない。', '말할 필요도 없다.', 1),
    (w, '聞くまでもない。', '물어볼 것도 없다.', 2);

  -- 1242. ～だってこと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だってこと', '~라는 사실', 'だって(인용)+こと. 「~이라는 것」 회화체 강조', '문법-문장완성', 1242, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が来るだってこと知ってる？', '그가 온다는 사실 알아?', 1),
    (w, '無理だってことが分かった。', '무리라는 사실을 알았다.', 2);

  -- 1243. ～くらい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～くらい (#2)', '~정도', 'くらい. 강조 반복', '문법-문장완성', 1243, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くくらい悔しい。', '울고 싶을 정도로 분하다.', 1),
    (w, '10分くらいで終わる。', '10분 정도면 끝난다.', 2);

  -- 1244. ～だろうに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だろうに', '~일 텐데', '추량 だろう+に. 「~인데도」 안타까움·기대', '문법-문장완성', 1244, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '言えば許してくれただろうに。', '말했으면 용서해 줬을 텐데.', 1),
    (w, '早く来ればよかっただろうに。', '일찍 오면 좋았을 텐데.', 2);

  -- 1245. ～のみならず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～のみならず (#2)', '~뿐만 아니라', 'のみ+ならず. 강조 반복', '문법-문장완성', 1245, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理のみならずサービスも一流だ。', '요리뿐 아니라 서비스도 일류다.', 1),
    (w, '日本のみならず世界で有名だ。', '일본뿐 아니라 세계에서 유명하다.', 2);

  -- 1246. そのものも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そのものも', '그 자체도', 'その+もの+も. 「~ 자체도 (포함)」 강조', '문법-문장완성', 1246, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '形そのものも変だ。', '형태 자체도 이상하다.', 1),
    (w, '考え方そのものも違う。', '사고방식 자체도 다르다.', 2);

  -- 1247. ～というところで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というところで', '~라는 상황에서', 'と+いう+所+で. 「~인 시점에서·~정도로」', '문법-문장완성', 1247, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '完成というところで止まった。', '완성이라는 단계에서 멈췄다.', 1),
    (w, 'ここまでというところで終わった。', '여기까지라는 데서 끝났다.', 2);

  -- 1248. ～にあたって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にあたって', '~에 즈음하여', 'に+当(당할 당)って. 「~을 맞이하여」 격식체', '문법-문장완성', 1248, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新年にあたって挨拶する。', '신년을 맞이하여 인사한다.', 1),
    (w, '出発にあたって注意事項を確認する。', '출발에 즈음하여 주의사항을 확인한다.', 2);

  -- 1249. ～べきか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～べきか', '~해야 할 것인가', 'べき+か. 「~해야 하는가」 갈등·고민', '문법-문장완성', 1249, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くべきか悩む。', '가야 할지 고민한다.', 1),
    (w, '謝るべきか迷う。', '사과해야 할지 망설인다.', 2);

  -- 1250. ～いうことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～いうことだ', '~라는 것이다', 'と+いう+こと+だ. 「~라는 의미·전언」', '문법-문장완성', 1250, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり中止というということだ。', '즉 중지라는 것이다.', 1),
    (w, '彼は来ないということだ。', '그는 안 온다는 것이다.', 2);

  -- 1251. ～に応える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に応える', '~에 부응하다', 'に+応(응할 응)える. 「기대·요청에 답하다」', '문법-문장완성', 1251, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '期待に応える。', '기대에 부응한다.', 1),
    (w, '要望に応える。', '요청에 응한다.', 2);

  -- 1252. ～なり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なり (#2)', '~하자 마자', 'なり: 「~한 즉시」 격식체 즉시성. 강조 반복', '문법-문장완성', 1252, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰宅するなり倒れた。', '귀가하자마자 쓰러졌다.', 1),
    (w, '見るなり驚いた。', '보자마자 놀랐다.', 2);

  -- 1253. ～きる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～きる (#2)', '끝까지 ~하다', '切(끊을 절)る. 강조 반복. 「완전히 끝까지」', '문법-문장완성', 1253, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '走りきった。', '끝까지 달려냈다.', 1),
    (w, '言い切れる自信がある。', '단언할 자신이 있다.', 2);

  -- 1254. ～だったら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だったら', '~라면', 'だった+ら. 「~이라면」 가정 조건', '문법-문장완성', 1254, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私だったら行く。', '나라면 간다.', 1),
    (w, '雨だったら中止だ。', '비라면 중지다.', 2);

  -- 1255. ～ぐらいで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ぐらいで', '~정도로', 'ぐらい+で. 「~의 정도로」', '문법-문장완성', 1255, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '少しぐらいで諦めるな。', '조금 정도로 포기 말라.', 1),
    (w, '一時間ぐらいで済む。', '한 시간 정도면 끝난다.', 2);

  -- 1256. ～たりしないで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たりしないで', '~하거나 하지 말고', 'たり+しないで. 「~하지 말고」 회화체 금지', '문법-문장완성', 1256, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '騒いだりしないで集中する。', '소란 피우지 말고 집중한다.', 1),
    (w, 'サボったりしないで頑張る。', '땡땡이치지 말고 분발한다.', 2);

  -- 1257. ～というものだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というものだ', '~라는 것이다', 'と+いう+もの+だ. 「~이라는 것이다」 일반화·정의', '문법-문장완성', 1257, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これが愛というものだ。', '이게 사랑이라는 것이다.', 1),
    (w, '人生というものは難しい。', '인생이라는 것은 어렵다.', 2);

  -- 1258. ～となると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～となると (#2)', '~가 되면', 'と+なる+と. 강조 반복', '문법-문장완성', 1258, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚となると話は別だ。', '결혼이 되면 얘기는 다르다.', 1),
    (w, '本番となると緊張する。', '실전이 되면 긴장한다.', 2);

  -- 1259. ～における
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～における (#2)', '~의', '於ける. 강조 반복형', '문법-문장완성', 1259, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会における役割。', '사회에서의 역할.', 1),
    (w, '研究における重要性。', '연구에 있어서의 중요성.', 2);

  -- 1260. そのうち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そのうち', '곧', 'その+うち(內). 「머지않아」 미래 시점', '문법-문장완성', 1260, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そのうち分かるだろう。', '머지않아 알게 될 것이다.', 1),
    (w, 'そのうち会いに行く。', '곧 만나러 간다.', 2);

  -- 1261. ～中で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～中で', '~중에', '中(가운데 중)で. 「~의 가운데에서」 범위·환경', '문법-문장완성', 1261, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'クラスの中で一番だ。', '반에서 1등이다.', 1),
    (w, '会議の中で出た意見。', '회의 중에 나온 의견.', 2);

  -- 1262. ～のみに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～のみに', '~만에', 'のみ+に. 「~만으로 한정해」 격식체', '문법-문장완성', 1262, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会員のみに公開する。', '회원에게만 공개한다.', 1),
    (w, '専門家のみに与えられる権利。', '전문가에게만 주어지는 권리.', 2);

  -- 1263. ～限り
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～限り', '~한', '限(한할 한)り. 「~의 범위 내에서」', '문법-문장완성', 1263, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の知る限りでは正しい。', '내가 아는 한 옳다.', 1),
    (w, '生きている限り頑張る。', '살아 있는 한 분발한다.', 2);

  -- 1264. ～ところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ところ', '~했더니', '所(곳 소). 「~해 보니 (결과)」 격식체 결과 발견', '문법-문장완성', 1264, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '聞いたところ、明日休みだそうだ。', '들어보니 내일 휴일이라고 한다.', 1),
    (w, '調べたところ、誤りが見つかった。', '조사해 보니 오류가 발견됐다.', 2);

  -- 1265. ～ばこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ばこそ (#2)', '하기에 <이유 강조>', 'ば+こそ. 강조 반복형', '문법-문장완성', 1265, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康であればこそ働ける。', '건강하기에 일할 수 있다.', 1),
    (w, '愛していればこそ厳しく言う。', '사랑하기에 엄하게 말한다.', 2);

  -- 1266. ～もさることながら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～もさることながら (#2)', '~도 물론이거니와', 'も+然+こと+ながら. 강조 반복', '문법-문장완성', 1266, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '料理もさることながら雰囲気も良い。', '요리도 물론이거니와 분위기도 좋다.', 1),
    (w, '才能もさることながら努力も必要だ。', '재능도 물론이거니와 노력도 필요하다.', 2);

  -- 1267. ～を機に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を機に (#4)', '~을 계기로', '機(틀 기). 강조 반복형', '문법-문장완성', 1267, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '震災を機に防災を考えた。', '지진을 계기로 방재를 생각했다.', 1),
    (w, '出会いを機に変わった。', '만남을 계기로 변했다.', 2);

  -- 1268. ～かのような
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かのような', '~인 것 같은', 'か+の+ような. 「마치 ~인 듯한」 격식체 비유', '문법-문장완성', 1268, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢かのような出来事。', '꿈같은 사건.', 1),
    (w, '何も知らないかのような顔。', '아무것도 모르는 듯한 얼굴.', 2);

  -- 1269. ～も～ば～も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～も～ば～も', '~도 ~하고', 'も+ば+も. 「~도 ~이고 ~도」 병렬 망라', '문법-문장완성', 1269, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雪も降れば雨も降る。', '눈도 오고 비도 온다.', 1),
    (w, '料理もできれば掃除もできる。', '요리도 할 수 있고 청소도 할 수 있다.', 2);

  -- 1270. ～ほどの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ほどの', '~정도의', 'ほど+の. 「~만큼의·~할 정도의」', '문법-문장완성', 1270, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '泣くほどの理由はない。', '울 정도의 이유는 없다.', 1),
    (w, '驚くほどの実力。', '놀랄 만한 실력.', 2);


  -- 1271. ～や～といったろ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～や～といった', '~나 ~같은', 'や(병렬)+と+いった. 「~이라든가 ~과 같은」 예시 나열', '문법-문장완성', 1271, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本や雑誌といった印刷物。', '책이나 잡지와 같은 인쇄물.', 1),
    (w, 'りんごやみかんといった果物。', '사과나 귤과 같은 과일.', 2);

  -- 1272. ～こともあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こともあって', '~이기도 해서', 'こと+も+あって. 「~인 사정도 있어서」 부수적 원인', '문법-문장완성', 1272, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨だったこともあって遅れた。', '비가 온 것도 있어서 늦었다.', 1),
    (w, '初めてだったこともあって緊張した。', '처음이었던 것도 있어서 긴장했다.', 2);

  -- 1273. ～ようとも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ようとも (#2)', '~할지라도', '의지·추량 (よ)う+と+も. 강조 반복', '문법-문장완성', 1273, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何があろうとも頑張る。', '무슨 일이 있어도 분발한다.', 1),
    (w, '反対されようとも実行する。', '반대당해도 실행한다.', 2);

  -- 1274. ～かどうかは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～かどうかは', '~할지 아닌지는', 'か+どう+か+は. 「~할지 안 할지의 여부는」', '문법-문장완성', 1274, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くかどうかはまだ分からない。', '갈지 말지는 아직 모른다.', 1),
    (w, '本物かどうかは確認が必要だ。', '진짜인지 아닌지는 확인이 필요하다.', 2);

  -- 1275. ～にかかっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にかかっている', '~에 달려있다', 'に+掛(걸 괘)かる+ている. 「~에 좌우된다」', '문법-문장완성', 1275, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '成功は努力にかかっている。', '성공은 노력에 달려있다.', 1),
    (w, '結果は天気にかかっている。', '결과는 날씨에 달려있다.', 2);

  -- 1276. ～か否か
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～か否か (#2)', '~인가 아닌가', 'か+否か. 강조 반복형', '문법-문장완성', 1276, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くか否か決める。', '갈지 안 갈지 결정한다.', 1),
    (w, '本当か否か疑わしい。', '진짜인지 아닌지 의심스럽다.', 2);

  -- 1277. ～において
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～において (#2)', '~에 있어', '於(어조사 어)+いて. 강조 반복', '문법-문장완성', 1277, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社会において重要だ。', '사회에 있어 중요하다.', 1),
    (w, '人生において必要なこと。', '인생에 있어 필요한 것.', 2);

  -- 1278. ～こともある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こともある', '~경우도 있다', 'こと+も+ある. 「~할 때도 있다」 부분 긍정', '문법-문장완성', 1278, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗することもある。', '실패할 때도 있다.', 1),
    (w, '休むこともある。', '쉴 경우도 있다.', 2);

  -- 1279. ～反面
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～反面', '~인 반면', '反(돌이킬 반)+面(낯 면). 「반대 면에서는」 대조', '문법-문장완성', 1279, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '便利な反面、危険だ。', '편리한 반면 위험하다.', 1),
    (w, '安い反面、品質が落ちる。', '싼 반면 품질이 떨어진다.', 2);

  -- 1280. あまりに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'あまりに', '너무', '副詞 あまりに. 「지나치게」 정도 강조', '문법-문장완성', 1280, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あまりに難しい。', '너무 어렵다.', 1),
    (w, 'あまりにも美しい。', '너무도 아름답다.', 2);

  -- 1281. かえって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'かえって', '도리어', '副詞 却(물리칠 각)って. 「오히려」 역접 결과', '문법-문장완성', 1281, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '謝るとかえって怒られた。', '사과하니 도리어 혼났다.', 1),
    (w, '助けようとしてかえって邪魔した。', '돕는다는 게 도리어 방해했다.', 2);

  -- 1282. ～に居ながらにして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に居ながらにして', '~에 있으면서', 'に+居る+ながら+にして. 「~한 채로 (그 자리에서)」', '문법-문장완성', 1282, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '家に居ながらにして買い物ができる。', '집에 있으면서 쇼핑할 수 있다.', 1),
    (w, '自宅に居ながらにして仕事をする。', '자택에 있으면서 일을 한다.', 2);

  -- 1283. ～でさえも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～でさえも', '~조차도', 'で+さえ+も. 「~까지도」 극단적 예시', '문법-문장완성', 1283, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '専門家でさえも難しい。', '전문가조차도 어렵다.', 1),
    (w, '子供でさえも知っている。', '아이조차도 알고 있다.', 2);

  -- 1284. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ほど (#2)', '~정도', '副助詞 ほど. 강조 반복형', '문법-문장완성', 1284, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '声が出ないほど驚いた。', '소리가 안 나올 정도로 놀랐다.', 1),
    (w, '泣くほど嬉しい。', '울 정도로 기쁘다.', 2);

  -- 1285. ～にあたり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にあたり', '~에 즈음하여', 'に+当(당할 당)り. 「~의 시점에」 격식체 문어', '문법-문장완성', 1285, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '開会にあたり一言挨拶する。', '개회에 즈음하여 한마디 인사한다.', 1),
    (w, '出発にあたり注意する。', '출발에 즈음하여 주의한다.', 2);

  -- 1286. ～と言えば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と言えば (#2)', '~라고 하면', 'と+言えば. 강조 반복형', '문법-문장완성', 1286, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏と言えばかき氷だ。', '여름이라면 빙수다.', 1),
    (w, '日本と言えば寿司だ。', '일본이라면 초밥이다.', 2);

  -- 1287. 今でこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '今でこそ', 'いまでこそ', '지금이야말로', '今+で+こそ. 「지금이야말로 (예전과 대비)」', '문법-문장완성', 1287, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今でこそ笑えるが当時は辛かった。', '지금이야 웃지만 당시에는 괴로웠다.', 1),
    (w, '今でこそ有名だが昔は無名だった。', '지금이야 유명하지만 옛날엔 무명이었다.', 2);

  -- 1288. ～との
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～との', '~라는', 'と+の. 격식체 인용 명사 수식', '문법-문장완성', 1288, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '中止との連絡を受けた。', '중지라는 연락을 받았다.', 1),
    (w, '彼が来るとの噂だ。', '그가 온다는 소문이다.', 2);

  -- 1289. ～たところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～たところ', '~했더니', 'た+ところ. 「~해 보니 (결과)」', '문법-문장완성', 1289, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電話したところ留守だった。', '전화했더니 부재중이었다.', 1),
    (w, '聞いたところ知らないそうだ。', '물어봤더니 모른다고 한다.', 2);

  -- 1290. ～だけあって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけあって (#3)', '~하는 만큼', 'だけ+あって. 강조 반복', '문법-문장완성', 1290, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '苦労しただけあって美味しい。', '고생한 만큼 맛있다.', 1),
    (w, 'プロだけあって違う。', '프로인 만큼 다르다.', 2);

  -- 1291. ～ほど
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ほど (#3)', '~정도로', 'ほど. 강조 반복형', '문법-문장완성', 1291, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見たことのないほど美しい。', '본 적이 없을 정도로 아름답다.', 1),
    (w, '信じられないほど大きい。', '믿기지 않을 정도로 크다.', 2);

  -- 1292. ～限りでは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～限りでは', '~하는 한', '限(한할 한)り+で+は. 「~의 범위 내에서는」', '문법-문장완성', 1292, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私の知る限りでは正しい。', '내가 아는 한 옳다.', 1),
    (w, '見た限りでは問題ない。', '본 한에서는 문제 없다.', 2);

  -- 1293. ～に沿って
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に沿って', '~에 따라', 'に+沿(따를 연)って. 「~을 따라서」 방침·노선', '문법-문장완성', 1293, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '川に沿って歩く。', '강을 따라 걷는다.', 1),
    (w, '方針に沿って進める。', '방침에 따라 진행한다.', 2);

  -- 1294. ～だけで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけで', '~만으로', 'だけ+で. 「~만으로 (충분)」 최소 조건', '문법-문장완성', 1294, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '見るだけで分かる。', '보기만 해도 안다.', 1),
    (w, '聞くだけで悲しくなる。', '듣기만 해도 슬퍼진다.', 2);

  -- 1295. ～だって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だって', '~도', 'だって(인용·강조). 「~도 (역시)」 회화체 망라', '문법-문장완성', 1295, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供だって分かる。', '아이라도 안다.', 1),
    (w, '私だってできる。', '나도 할 수 있다.', 2);

  -- 1296. しかも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'しかも', '게다가', '접속사 しかも. 「게다가·더구나」 추가 강조', '문법-문장완성', 1296, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安くて、しかも美味しい。', '싸고, 게다가 맛있다.', 1),
    (w, '雨で、しかも風も強い。', '비 오는데, 게다가 바람도 세다.', 2);

  -- 1297. ～に限っての
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に限っての', '~에 한해서의', 'に+限(한할 한)って+の. 「~에 한정된」', '문법-문장완성', 1297, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今回に限っての特例。', '이번에 한해서의 특례.', 1),
    (w, 'お客様に限ってのサービス。', '손님에게 한해서의 서비스.', 2);

  -- 1298. ～を控えた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を控えた', '~을 앞둔', '控(당길 공)える. 「(중요 일을) 앞두고 있는」', '문법-문장완성', 1298, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験を控えた学生たち。', '시험을 앞둔 학생들.', 1),
    (w, '結婚を控えた二人。', '결혼을 앞둔 두 사람.', 2);

  -- 1299. ～のに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～のに', '~하는 데', 'の+に. 「~하는 데에」 용도·역접', '문법-문장완성', 1299, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強するのに役立つ。', '공부하는 데 도움이 된다.', 1),
    (w, '行くのに二時間かかる。', '가는 데 두 시간 걸린다.', 2);

  -- 1300. ～ことにする (#3)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ことにする (#3)', '~하기로 하다', 'こと+に+する. 강조 반복', '문법-문장완성', 1300, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '毎日運動することにした。', '매일 운동하기로 했다.', 1),
    (w, '休むことにする。', '쉬기로 한다.', 2);

  -- 1301. ～うえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～うえに', '~인데다', '上(위 상)に. 「~에 더하여·~인데다가」 추가', '문법-문장완성', 1301, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '安いうえに美味しい。', '싼데다 맛있다.', 1),
    (w, '雨のうえに風も強い。', '비 오는데다 바람도 세다.', 2);

  -- 1302. ～を踏まえ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～を踏まえ', '~에 입각하여', '踏(밟을 답)まえ: 「밟고 서다」 → 「~을 토대로」', '문법-문장완성', 1302, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果を踏まえて判断する。', '결과를 토대로 판단한다.', 1),
    (w, '経験を踏まえてアドバイスする。', '경험을 토대로 조언한다.', 2);

  -- 1303. ～なんて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なんて (#2)', '~라니', 'などと의 축약. 강조 반복', '문법-문장완성', 1303, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が裏切るなんて信じられない。', '그가 배신하다니 믿을 수 없다.', 1),
    (w, '失敗するなんて思わなかった。', '실패할 거라곤 생각 못 했다.', 2);

  -- 1304. ～だけで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だけで (#2)', '~만으로', 'だけ+で. 강조 반복형', '문법-문장완성', 1304, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前を聞くだけで嬉しい。', '이름을 듣기만 해도 기쁘다.', 1),
    (w, '一目見るだけで分かる。', '한 번 보기만 해도 안다.', 2);

  -- 1305. ～をはじめとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～をはじめとする', '~을 비롯한', 'を+始(처음 시)め+とする. 「~을 시작으로 하는」 격식체', '문법-문장완성', 1305, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '社長をはじめとする社員たち。', '사장을 비롯한 사원들.', 1),
    (w, '富士山をはじめとする日本の名所。', '후지산을 비롯한 일본의 명소.', 2);

  -- 1306. ～つつも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～つつも', '~하면서도', 'つつ+も. 「~하면서도 (역접)」 격식체', '문법-문장완성', 1306, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反省しつつも繰り返す。', '반성하면서도 반복한다.', 1),
    (w, '悪いと知りつつもやめられない。', '나쁜 줄 알면서도 그만둘 수 없다.', 2);

  -- 1307. ～に至る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～に至る (#2)', '~에 이르다', 'に+至る. 강조 반복형', '문법-문장완성', 1307, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事件は解決に至った。', '사건은 해결에 이르렀다.', 1),
    (w, '結論に至るまで時間がかかった。', '결론에 이르기까지 시간이 걸렸다.', 2);

  -- 1308. ～こそ～が
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～こそ～が (#2)', '비록 ~은 ~이지만', 'こそ+が. 강조 반복', '문법-문장완성', 1308, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '若さこそないが経験豊富だ。', '젊지는 않지만 경험 풍부하다.', 1),
    (w, '見た目こそ古いが性能は新しい。', '겉모습은 낡았지만 성능은 새것이다.', 2);

  -- 1309. ～すぎる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～すぎる', '~지나치다', '過(지날 과)ぎる. 「~을 넘어 지나치다」', '문법-문장완성', 1309, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '食べすぎる。', '과식하다.', 1),
    (w, '速すぎる。', '너무 빠르다.', 2);

  -- 1310. ～がゆえに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～がゆえに', '~라서', 'が+故(까닭 고)に. 「~의 이유로」 격식체', '문법-문장완성', 1310, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '優しいがゆえに苦しむ。', '다정하기에 괴롭다.', 1),
    (w, '愛するがゆえに怒る。', '사랑하기에 화낸다.', 2);

  -- 1311. ～がちだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～がちだ (#2)', '~하기 쉽다', '勝ち+だ. 강조 반복형', '문법-문장완성', 1311, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨が降りがちだ。', '비가 자주 온다.', 1),
    (w, '忘れがちだ。', '잊기 쉽다.', 2);

  -- 1312. ～というと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というと', '~라고 하면', 'と+いう+と. 「~을 듣고 떠오르는 것」 연상', '문법-문장완성', 1312, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夏というとプールだ。', '여름이라면 수영장이다.', 1),
    (w, '日本というと富士山だ。', '일본이라면 후지산이다.', 2);

  -- 1313. ～と思ったら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～と思ったら', '~한 줄 알았더니', 'と+思った+ら. 「~인 줄 알았더니 (의외)」', '문법-문장완성', 1313, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '帰ったと思ったらまた出かけた。', '돌아온 줄 알았더니 또 나갔다.', 1),
    (w, '寝たと思ったら起きた。', '잠든 줄 알았더니 일어났다.', 2);

  -- 1314. どんなに～でも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どんなに～でも', '아무리 ~라도', 'どんなに+でも. 「아무리 ~할지라도」 강한 양보', '문법-문장완성', 1314, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'どんなに難しくても諦めない。', '아무리 어려워도 포기 않는다.', 1),
    (w, 'どんなに頑張っても勝てない。', '아무리 분발해도 이길 수 없다.', 2);

  -- 1315. ～ないことには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ないことには', '~하지 않고서는', 'ない+こと+に+は. 「~하지 않고는 (안 된다)」', '문법-문장완성', 1315, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '確認しないことには進められない。', '확인하지 않고서는 진행할 수 없다.', 1),
    (w, '会わないことには分からない。', '만나보지 않고서는 알 수 없다.', 2);


  -- ============================================================
  -- 문법-문맥이해 123개 (PDF p.58~64)
  -- 본문 문장에서 발췌된 표현·접속사·연어 위주
  -- ============================================================

  -- 1316. ～も～ないも
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～も～ないも', '~하지 않는 것도', 'も+ない+も. 「~도 ~안 하는 것도」 양극 망라', '문법-문맥이해', 1316, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行くも行かないも自由だ。', '가든 안 가든 자유다.', 1),
    (w, '見るも見ないもあなた次第。', '보든 안 보든 너에게 달렸다.', 2);

  -- 1317. 通う人もいるほどだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '通う人もいるほどだ', 'かようひともいるほどだ', '다니는 사람도 있을 정도다', '通(통할 통)う+ほどだ. 「~할 정도이다」 강조', '문법-문맥이해', 1317, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '遠くから通う人もいるほどだ。', '멀리서 다니는 사람도 있을 정도다.', 1),
    (w, '毎日通う人もいるほど人気がある。', '매일 다니는 사람도 있을 정도로 인기가 있다.', 2);

  -- 1318. ～てしまうだけである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～てしまうだけである', '~되어 버릴 뿐이다', 'てしまう+だけ+である. 「~할 뿐이다」 격식체 단정', '문법-문맥이해', 1318, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '逃げてしまうだけである。', '도망쳐 버릴 뿐이다.', 1),
    (w, '忘れてしまうだけである。', '잊혀져 버릴 뿐이다.', 2);

  -- 1319. その結果
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'その結果', 'そのけっか', '그 결과', 'その+結果(결과). 「그 결과로」 격식체 결과 도입', '문법-문맥이해', 1319, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その結果、成功した。', '그 결과 성공했다.', 1),
    (w, 'その結果として認められた。', '그 결과로 인정받았다.', 2);

  -- 1320. 対等
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '対等', 'たいとう', '대등', '対(대할 대)+等(가지런할 등). 「대등·동등」', '문법-문맥이해', 1320, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '対等な立場で話す。', '대등한 입장에서 이야기한다.', 1),
    (w, '対等の関係を築く。', '대등한 관계를 쌓는다.', 2);

  -- 1321. とはいえ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'とはいえ', '그렇다고는 해도', 'と+は+いえ. 「그렇다 하더라도」 격식체 역접', '문법-문맥이해', 1321, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '春とはいえまだ寒い。', '봄이라고는 해도 아직 춥다.', 1),
    (w, '便利とはいえ問題もある。', '편리하다고는 해도 문제도 있다.', 2);

  -- 1322. 親しまれることになる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '親しまれることになる', 'したしまれることになる', '친숙해지게 된다', '親(친할 친)しむ의 수동+こと+になる. 「~한 결과가 되다」', '문법-문맥이해', 1322, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '長年で多くの人に親しまれることになる。', '오랜 세월로 많은 사람에게 친숙해지게 된다.', 1),
    (w, '皆に親しまれることになった。', '모두에게 친숙해지게 되었다.', 2);

  -- 1323. そういう父親の子ども
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'そういう父親の子ども', 'そういうちちおやのこども', '그러한 아버지의 자녀', 'そういう+父親+の+子ども. 지시·연결', '문법-문맥이해', 1323, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう父親の子どもとして育った。', '그런 아버지의 아이로 자랐다.', 1),
    (w, 'そういう父親の子どもは少ない。', '그런 아버지의 자녀는 적다.', 2);

  -- 1324. それにつまずいてしまった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'それにつまずいてしまった', 'それにつまずいてしまった', '그것에 좌절해 버렸다', 'それ+に+躓(넘어질 지)く+てしまう. 「~에 좌절해 버리다」', '문법-문맥이해', 1324, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さなことにつまずいてしまった。', '사소한 일에 좌절해 버렸다.', 1),
    (w, '誤解につまずいてしまった。', '오해에 걸려 넘어졌다.', 2);

  -- 1325. 父ではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '父ではない', 'ちちではない', '아버지가 아니다', '父+で+は+ない. 「아버지가 아니다」 단정 부정', '문법-문맥이해', 1325, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は私の父ではない。', '그는 내 아버지가 아니다.', 1),
    (w, '名ばかりで実の父ではない。', '이름뿐이고 친아버지가 아니다.', 2);

  -- 1326. はたして健全なのだろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'はたして健全なのだろうか', 'はたしてけんぜんなのだろうか', '과연 건전한 것일까?', 'はたして+健全+なのだろうか. 자문·의구심', '문법-문맥이해', 1326, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは、はたして健全なのだろうか。', '이것은 과연 건전한 것일까?', 1),
    (w, 'はたして健全な社会と言えるのだろうか。', '과연 건전한 사회라 할 수 있을까?', 2);

  -- 1327. あれ以来
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'あれ以来', 'あれいらい', '그 이후로', 'あれ+以来(이래). 「그 일 이후」', '문법-문맥이해', 1327, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あれ以来会っていない。', '그 후 만나지 않았다.', 1),
    (w, 'あれ以来連絡が途絶えた。', '그 이후 연락이 끊겼다.', 2);

  -- 1328. 貸したままなのは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '貸したままなのは', 'かしたままなのは', '빌려 준 채로 있는 것은', '貸(빌릴 대)す+まま+な+の+は. 「빌려준 채로의 것은」', '문법-문맥이해', 1328, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本を貸したままなのは私だ。', '책을 빌려준 채인 것은 나다.', 1),
    (w, '貸したままなのは申し訳ない。', '빌려준 채인 것은 미안하다.', 2);

  -- 1329. しましょうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'しましょうか', '할까요?', 'する+ましょう+か. 권유·제안 정중형', '문법-문맥이해', 1329, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お手伝いしましょうか。', '도와 드릴까요?', 1),
    (w, '一緒に行きましょうか。', '함께 갈까요?', 2);

  -- 1330. 入るのはいい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '入るのはいい', 'はいるのはいい', '들어가는 것은 좋다', '入(들 입)る+の+は+いい. 「들어가는 것은 괜찮다」 부분 인정', '문법-문맥이해', 1330, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '部屋に入るのはいいが、靴は脱いで。', '방에 들어가는 건 좋은데 신발은 벗어.', 1),
    (w, '入るのはいいけど静かに。', '들어오는 건 좋은데 조용히.', 2);

  -- 1331. 見させてしまう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '見させてしまう', 'みさせてしまう', '보게 만들어 버린다', '見る의 사역+てしまう. 「의도치 않게 보게 만들다」', '문법-문맥이해', 1331, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思わず子供に見させてしまう。', '무심코 아이에게 보여 줘 버린다.', 1),
    (w, '悲しい場面を見させてしまった。', '슬픈 장면을 보게 해 버렸다.', 2);

  -- 1332. 一方
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一方', 'いっぽう', '한편', '一(한 일)+方(모 방). 「한쪽·반면에」 대조·추가', '문법-문맥이해', 1332, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一方、彼は反対している。', '한편 그는 반대하고 있다.', 1),
    (w, '一方では喜び、一方では悲しむ。', '한편으로는 기뻐하고, 한편으로는 슬퍼한다.', 2);

  -- 1333. 君から
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '君から', 'きみから', '너에게서', '君(임금 군)+から. 「너로부터」', '문법-문맥이해', 1333, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '君から連絡が欲しい。', '너에게서 연락받고 싶다.', 1),
    (w, '君から始めよう。', '너부터 시작하자.', 2);

  -- 1334. たしかに～ことは間違いない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'たしかに～ことは間違いない', '분명히 ~라는 것은 틀림없다', '確(굳을 확)かに+こと+は+間違(잘못할 간위)いない. 강조 확언', '문법-문맥이해', 1334, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たしかに彼が来ることは間違いない。', '분명히 그가 온다는 것은 틀림없다.', 1),
    (w, 'たしかに優秀であることは間違いない。', '분명히 우수하다는 것은 틀림없다.', 2);

  -- 1335. やめてほしいのだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'やめてほしいのだ', 'やめてほしいのだ', '그만두었으면 좋겠다', 'やめる+てほしい+のだ. 강한 희망 단정', '문법-문맥이해', 1335, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もうやめてほしいのだ。', '이제 그만했으면 한다.', 1),
    (w, 'こんな争いはやめてほしいのだ。', '이런 다툼은 그만했으면 한다.', 2);

  -- 1336. こと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こと', '것', '형식명사 こと(事). 「~한 것·일」 추상화', '문법-문맥이해', 1336, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強することが大切だ。', '공부하는 것이 중요하다.', 1),
    (w, '彼が来たことは知っている。', '그가 온 것은 안다.', 2);

  -- 1337. そういう
    insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そういう', '그러한', '指示 そう+いう. 「그러한·그런」', '문법-문맥이해', 1337, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういう人もいる。', '그런 사람도 있다.', 1),
    (w, 'そういう考え方は良くない。', '그런 사고방식은 좋지 않다.', 2);

  -- 1338. そして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そして', '그리고', '접속사 そして. 「그리고·그러고 나서」 순접', '문법-문맥이해', 1338, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強した。そして合格した。', '공부했다. 그리고 합격했다.', 1),
    (w, '走った。そして転んだ。', '뛰었다. 그리고 넘어졌다.', 2);

  -- 1339. ～というものである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というものである', '~인 것이다', 'と+いう+もの+である. 「~이라는 것이다」 격식체 단정', '문법-문맥이해', 1339, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人生というものである。', '인생이라는 것이다.', 1),
    (w, '愛とはそういうものである。', '사랑이란 그런 것이다.', 2);

  -- 1340. 思わされた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思わされた', 'おもわされた', '생각하게 되었다', '思う의 사역수동. 「(자연스럽게) 생각하게 됨」', '문법-문맥이해', 1340, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '深く考えさせられた。', '깊이 생각하게 되었다.', 1),
    (w, '人生について思わされた。', '인생에 대해 생각하게 되었다.', 2);

  -- 1341. ～しなければ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～しなければ', '~하지 않으면', 'する+なければ. 조건 부정. 「~해야 한다」', '문법-문맥이해', 1341, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強しなければならない。', '공부해야 한다.', 1),
    (w, '行かなければダメだ。', '안 가면 안 된다.', 2);

  -- 1342. そうだろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そうだろうか', '그럴까?', 'そう+だろうか. 자문·의구심', '문법-문맥이해', 1342, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '本当にそうだろうか。', '정말 그럴까?', 1),
    (w, 'そうだろうかと疑った。', '그럴까 하고 의심했다.', 2);

  -- 1343. ～ではないか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ではないか', '~가 아닐까?', 'では+ないか. 「~인 것 아닌가」 확인·놀람', '문법-문맥이해', 1343, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これでいいではないか。', '이걸로 되는 거 아닌가.', 1),
    (w, '間違いではないか。', '잘못 아닌가?', 2);

  -- 1344. なぜならば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なぜならば', '왜냐하면', '何(어찌 하)故(까닭 고)+ならば. 「왜냐하면」 격식체 이유', '문법-문맥이해', 1344, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なぜならば、簡単だからだ。', '왜냐하면 쉽기 때문이다.', 1),
    (w, 'なぜならば、それが正しいからだ。', '왜냐하면 그것이 옳기 때문이다.', 2);

  -- 1345. 朝だと思って頂きたい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '朝だと思って頂きたい', 'あさだとおもっていただきたい', '아침이라고 생각해 주었으면 좋겠다', '朝だ+と+思って+頂きたい. 격식체 의뢰', '문법-문맥이해', 1345, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もう朝だと思って頂きたい。', '이제 아침이라고 생각해 주셨으면 합니다.', 1),
    (w, '出発時刻だと思って頂きたい。', '출발 시각이라고 생각해 주십시오.', 2);

  -- 1346. いつごろになろうか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いつごろになろうか', '언제쯤이 될 것인가?', 'いつ+ごろ+に+なろうか. 시점 추량', '문법-문맥이해', 1346, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '完成はいつごろになろうか。', '완성은 언제쯤이 될 것인가?', 1),
    (w, '次の会議はいつごろになろうか。', '다음 회의는 언제쯤이 될까?', 2);

  -- 1347. 買ってきましょう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '買ってきましょう', 'かってきましょう', '사 옵시다', '買う+てくる+ましょう. 「사 옵시다」 권유', '문법-문맥이해', 1347, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一緒に買ってきましょう。', '함께 사 옵시다.', 1),
    (w, 'お土産を買ってきましょう。', '선물을 사 옵시다.', 2);

  -- 1348. 気にかかるといっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '気にかかるといっても', 'きにかかるといっても', '신경이 쓰인다고는 해도', '気にかかる+と+いっても. 「~신경 쓰인다 해도」 양보', '문법-문맥이해', 1348, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '気にかかるといっても大したことはない。', '신경 쓰인다 해도 별 일은 아니다.', 1),
    (w, '気にかかるといっても無視する。', '신경 쓰인다 해도 무시한다.', 2);

  -- 1349. その上で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'その上で', 'そのうえで', '그후에', 'その+上+で. 「그 위에서·그러고 나서」', '문법-문맥이해', 1349, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'よく考えて、その上で決める。', '잘 생각하고, 그러고 나서 결정한다.', 1),
    (w, '確認して、その上で進める。', '확인하고, 그 후에 진행한다.', 2);

  -- 1350. いたっていいんです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いたっていいんです', '있어도 되는 것입니다', 'いる+ても+いい+んです. 「있어도 좋다」 허용', '문법-문맥이해', 1350, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ここにいたっていいんです。', '여기 있어도 되는 거예요.', 1),
    (w, '一人でいたっていいんです。', '혼자 있어도 괜찮은 거예요.', 2);

  -- 1351. 気が揉めるのである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '気が揉めるのである', 'きがもめるのである', '마음을 졸이게 되는 것이다', '気+が+揉(주무를 유)める+のである. 「초조해진다」 격식체', '문법-문맥이해', 1351, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果が出るまで気が揉めるのである。', '결과가 나올 때까지 마음 졸이게 된다.', 1),
    (w, '心配で気が揉めるのである。', '걱정으로 마음 졸이게 된다.', 2);

  -- 1352. すると
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'すると', '그러면', '접속사 すると. 「그러자·그러면」 결과·발견', '문법-문맥이해', 1352, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ボタンを押した。すると音が鳴った。', '버튼을 눌렀다. 그러자 소리가 울렸다.', 1),
    (w, 'すると、彼が現れた。', '그러자 그가 나타났다.', 2);

  -- 1353. よだれを流して迎えてくれる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'よだれを流して迎えてくれる', 'よだれをながしてむかえてくれる', '침을 흘리며 맞이해 준다', '涎(연)+流す+迎える+てくれる. 강아지의 반김', '문법-문맥이해', 1353, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬がよだれを流して迎えてくれた。', '강아지가 침을 흘리며 맞이해 주었다.', 1),
    (w, '帰宅すると犬がよだれを流して迎えてくれる。', '귀가하면 강아지가 침을 흘리며 맞이해 준다.', 2);

  -- 1354. 嬉しそうにこういった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '嬉しそうにこういった', 'うれしそうにこういった', '기쁜 듯이 이렇게 말했다', '嬉しい+そう+に+こう+いう+た. 양태+인용', '문법-문맥이해', 1354, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は嬉しそうにこういった。', '그는 기쁜 듯이 이렇게 말했다.', 1),
    (w, '母は嬉しそうにこういったものだ。', '어머니는 기쁜 듯이 이렇게 말하곤 했다.', 2);

  -- 1355. 子供ながらに感じた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '子供ながらに感じた', 'こどもながらにかんじた', '어린 마음에 느꼈다', '子供+ながらに+感じる+た. 「~의 입장에서도」', '문법-문맥이해', 1355, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供ながらに大人の悲しみを感じた。', '어린 마음에 어른의 슬픔을 느꼈다.', 1),
    (w, '子供ながらに違和感を感じた。', '아이임에도 위화감을 느꼈다.', 2);

  -- 1356. そこで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そこで', '그래서', '접속사 そこで. 「그래서·그래서 말인데」', '문법-문맥이해', 1356, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そこで、私は決心した。', '그래서 나는 결심했다.', 1),
    (w, '失敗した。そこで再挑戦した。', '실패했다. 그래서 재도전했다.', 2);

  -- 1357. 助かった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '助かった', 'たすかった', '도움이 되었다', '助(도울 조)かる+た. 「도움이 되었다」 안도·감사', '문법-문맥이해', 1357, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お陰で助かった。', '덕분에 도움이 되었다.', 1),
    (w, 'みんなのおかげで助かった。', '모두 덕분에 살았다.', 2);

  -- 1358. ～でもないのかもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～でもないのかもしれない', '~도 아닐지도 모른다', 'でも+ない+のかもしれない. 약한 부정 추량', '문법-문맥이해', 1358, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '冗談でもないのかもしれない。', '농담도 아닐지도 모른다.', 1),
    (w, '無理でもないのかもしれない。', '무리도 아닐지도 모른다.', 2);

  -- 1359. 全然悪くなかったのだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '全然悪くなかったのだ', 'ぜんぜんわるくなかったのだ', '전혀 나쁘지 않은 것이다', '全然+悪い+なかった+のだ. 강한 부정 단정', '문법-문맥이해', 1359, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あれは全然悪くなかったのだ。', '그것은 전혀 나쁘지 않았던 것이다.', 1),
    (w, '私の判断は全然悪くなかったのだ。', '내 판단은 전혀 나쁘지 않았다.', 2);

  -- 1360. そんな日には
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そんな日には', '그런 날에는', 'そんな+日+に+は. 특정 상황·기간 지시', '문법-문맥이해', 1360, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そんな日には家でゆっくりする。', '그런 날에는 집에서 푹 쉰다.', 1),
    (w, 'そんな日には酒が欲しくなる。', '그런 날에는 술이 당긴다.', 2);

  -- 1361. 出会えたと思った
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '出会えたと思った', 'であえたとおもった', '만날 수 있었다고 생각했다', '出会える+と+思った. 가능형+회상', '문법-문맥이해', 1361, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '運命の人に出会えたと思った。', '운명의 사람을 만났다고 생각했다.', 1),
    (w, '本当の友達に出会えたと思った。', '진정한 친구를 만났다고 생각했다.', 2);

  -- 1362. ～も (역접)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～も (역접·놀람)', '~도', '계조사 も. 「~조차·~도」 강조 망라', '문법-문맥이해', 1362, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一週間も雨が続く。', '일주일이나 비가 계속된다.', 1),
    (w, '彼は子供の名前も忘れた。', '그는 아이 이름조차 잊었다.', 2);

  -- 1363. 一冊といえる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一冊といえる', 'いっさついえる', '한 권이라고 말할 수 있다', '一冊+と+いえる. 평가·인정', '문법-문맥이해', 1363, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは名著一冊といえる。', '이것은 명저 한 권이라 할 수 있다.', 1),
    (w, '人生の指針となる一冊といえる。', '인생의 지침이 되는 한 권이라 할 수 있다.', 2);

  -- 1364. こうして
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こうして', '이렇게 해서', '副詞 こうして. 「이렇게 하여」 결과 도입', '문법-문맥이해', 1364, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうして物語が始まった。', '이렇게 해서 이야기가 시작되었다.', 1),
    (w, 'こうして二人は結婚した。', '이렇게 해서 두 사람은 결혼했다.', 2);

  -- 1365. すなわち
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'すなわち', '즉, 이를테면', '即(곧 즉)ち. 「즉·다시 말해」 격식체 부연', '문법-문맥이해', 1365, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すなわち、これが結論だ。', '즉, 이것이 결론이다.', 1),
    (w, 'すなわち、彼が犯人だ。', '즉, 그가 범인이다.', 2);

  -- 1366. 聞くだけだった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '聞くだけだった', 'きくだけだった', '들을 뿐이었다', '聞く+だけ+だった. 「~할 뿐이었다」 한정·과거', '문법-문맥이해', 1366, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔は話を聞くだけだった。', '예전엔 이야기를 듣기만 했다.', 1),
    (w, '反応せず聞くだけだった。', '반응하지 않고 듣기만 했다.', 2);

  -- 1367. じゃあねはないだろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '「じゃあね」はないだろう', '"그럼 잘 가"는 말이 안 되잖아', 'じゃあね+は+ない+だろう. 「그 정도 인사는 안 되지」 책망', '문법-문맥이해', 1367, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'お別れに「じゃあね」はないだろう。', '이별 인사로 "안녕"은 너무하잖아.', 1),
    (w, '長年の友に「じゃあね」はないだろう。', '오랜 친구에게 "잘 가"는 너무하다.', 2);

  -- 1368. 育ち続けるに違いない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '育ち続けるに違いない', 'そだちつづけるにちがいない', '계속 성장할 것임에 틀림없다', '育つ+続ける+に+違いない. 강한 확신 추량', '문법-문맥이해', 1368, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は育ち続けるに違いない。', '그는 계속 성장할 것임에 틀림없다.', 1),
    (w, 'この子は育ち続けるに違いない。', '이 아이는 계속 자랄 것이 틀림없다.', 2);

  -- 1369. ～である
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～である', '~이다', 'で+ある. 「~이다」 격식체 단정 (문어체)', '문법-문맥이해', 1369, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これは事実である。', '이것은 사실이다.', 1),
    (w, '私は学生である。', '나는 학생이다.', 2);

  -- 1370. ～なってきたのだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なってきたのだ', '되기 시작한 것이다', 'なる+てくる+のだ. 「점차 ~되어 왔다」 변화 강조', '문법-문맥이해', 1370, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '徐々に冷たくなってきたのだ。', '점차 차가워지기 시작한 것이다.', 1),
    (w, '人気が出てきたのだ。', '인기가 생기기 시작한 것이다.', 2);

  -- 1371. あの～
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'あの～', '그~', '연체사 あの. 「저·그(특정 대상)」 명사 수식', '문법-문맥이해', 1371, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あの店は美味しい。', '저 가게는 맛있다.', 1),
    (w, 'あの時の彼を覚えている。', '그때의 그를 기억한다.', 2);

  -- 1372. いたらなあ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いたらなあ', '있으면 좋을 텐데', 'いる+たら+なあ. 「~있으면 좋겠다」 회화체 희망', '문법-문맥이해', 1372, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今あの人がいたらなあ。', '지금 그 사람이 있으면 좋을 텐데.', 1),
    (w, '時間がもっといたらなあ。', '시간이 더 있다면 좋겠는데.', 2);

  -- 1373. トイレのことだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'トイレのことだ', 'トイレのことだ', '배변에 관한 것이다', 'トイレ(외래어)+の+こと+だ. 완곡 표현', '문법-문맥이해', 1373, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あれはトイレのことだった。', '그것은 화장실 일이었다.', 1),
    (w, '子供のトイレのことで悩む。', '아이의 배변 문제로 고민한다.', 2);

  -- 1374. 飛び出してきたのだろう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '飛び出してきたのだろう', 'とびだしてきたのだろう', '뛰쳐나온 것이겠지', '飛び出す+てくる+のだろう. 추측·짐작', '문법-문맥이해', 1374, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供が急に飛び出してきたのだろう。', '아이가 갑자기 뛰쳐나온 것이겠지.', 1),
    (w, '驚いて飛び出してきたのだろう。', '놀라서 뛰쳐나온 것이겠지.', 2);

  -- 1375. 認識させられる出来事だった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '認識させられる出来事だった', 'にんしきさせられるできごとだった', '인식하게 된 일이었다', '認識+させられる(사역수동)+出来事+だった. 「깨닫게 만든 사건」', '문법-문맥이해', 1375, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大切さを認識させられる出来事だった。', '소중함을 인식하게 된 일이었다.', 1),
    (w, '現実を認識させられる出来事だった。', '현실을 인식하게 된 사건이었다.', 2);

  -- 1376. こちらにいえるとは限らない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こちらにいえるとは限らない', '이쪽에도 말할 수 있다고는 단정할 수 없다', 'いえる+とは+限らない. 부분 부정 단정', '문법-문맥이해', 1376, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '相手側だけでなく、こちらにもいえるとは限らない。', '상대뿐 아니라 우리에게도 통한다고는 단언 못한다.', 1),
    (w, '全員にいえるとは限らない。', '전원에게 말할 수 있다고 단정할 수 없다.', 2);

  -- 1377. ところがである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ところがである', '그런데 말이다', 'ところが+である. 격식체 역접 도입', '문법-문맥이해', 1377, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ところがである、結果は逆だった。', '그런데 말이지, 결과는 반대였다.', 1),
    (w, 'ところがである、彼は来なかった。', '그런데 말이야, 그는 안 왔다.', 2);

  -- 1378. ～なのに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なのに', '그런데도', '断定+のに. 「~인데도 (예상과 다름)」 역접', '문법-문맥이해', 1378, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨なのに出かけた。', '비가 오는데 외출했다.', 1),
    (w, '安全なのに怖がる。', '안전한데도 무서워한다.', 2);

  -- 1379. ～にとっても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～にとっても', '~에게 있어서도', 'に+とって+も. 「~의 입장에서도」 강조', '문법-문맥이해', 1379, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼女にとっても大切な日だ。', '그녀에게도 소중한 날이다.', 1),
    (w, '私にとっても初めての経験だ。', '나에게도 처음 경험이다.', 2);

  -- 1380. ある日
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'ある日', 'あるひ', '어느 날', 'ある+日. 「어느 날(특정 안 함)」 이야기 도입', '문법-문맥이해', 1380, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ある日のことだった。', '어느 날의 일이었다.', 1),
    (w, 'ある日、不思議なことが起きた。', '어느 날 신기한 일이 일어났다.', 2);

  -- 1381. よく思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'よく思う', 'よくおもう', '자주 생각한다', '副詞 よく+思う. 「자주·잘 ~생각한다」', '문법-문맥이해', 1381, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '故郷のことをよく思う。', '고향을 자주 생각한다.', 1),
    (w, '彼のことをよく思う。', '그에 대해 잘 생각한다.', 2);

  -- 1382. ただ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ただ', '다만, 단', '副詞 ただ(只). 「오직·단지·다만」', '문법-문맥이해', 1382, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ただ祈るしかない。', '다만 기도할 수밖에 없다.', 1),
    (w, '行く。ただし、雨なら中止だ。', '간다. 단, 비라면 중지다.', 2);

  -- 1383. 消すように
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '消すように', 'けすように', '끄도록', '消す+ように. 「끄도록」 목적·지시', '문법-문맥이해', 1383, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '電気を消すように頼んだ。', '전등을 끄도록 부탁했다.', 1),
    (w, '消すように指示する。', '끄도록 지시한다.', 2);

  -- 1384. やつ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'やつ', '녀석', '대명사 奴(종 노). 「녀석·놈」 회화체', '문법-문맥이해', 1384, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あいつはすごいやつだ。', '저 녀석은 대단한 녀석이다.', 1),
    (w, 'いいやつだよ。', '좋은 녀석이야.', 2);

  -- 1385. が (역접)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'が (역접)', '그러나', '접속조사 が. 「그러나·하지만」 역접', '문법-문맥이해', 1385, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行きたいが、時間がない。', '가고 싶지만 시간이 없다.', 1),
    (w, '簡単そうだが、難しい。', '쉬워 보이지만 어렵다.', 2);

  -- 1386. 外すわけにもいかない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '外すわけにもいかない', 'はずすわけにもいかない', '뺄 수도 없다', '外す+わけ+に+も+いかない. 「뺄 수 없는 상황」', '문법-문맥이해', 1386, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会議は外すわけにもいかない。', '회의는 뺄 수도 없다.', 1),
    (w, '彼を外すわけにもいかない。', '그를 빼낼 수도 없다.', 2);

  -- 1387. 励ます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '励ます', 'はげます', '격려하다', '励(힘쓸 려)ます: 「힘을 북돋우다」', '문법-문맥이해', 1387, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友達を励ます。', '친구를 격려한다.', 1),
    (w, '言葉で励ます。', '말로 격려한다.', 2);

  -- 1388. 見つけられなかった
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '見つけられなかった', 'みつけられなかった', '찾을 수 없었다', '見つける+가능+なかった. 「발견 불가능 과거」', '문법-문맥이해', 1388, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結局見つけられなかった。', '결국 찾지 못했다.', 1),
    (w, '答えを見つけられなかった。', '답을 찾을 수 없었다.', 2);

  -- 1389. 一方で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一方で', 'いっぽうで', '한편', '一方+で. 「한편으로는」 대조 도입', '문법-문맥이해', 1389, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一方で、批判もある。', '한편으로는 비판도 있다.', 1),
    (w, '彼は明るい。一方で寂しがり屋でもある。', '그는 밝다. 한편 외로움도 잘 탄다.', 2);

  -- 1390. その時のことである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'その時のことである', 'そのときのことである', '그때의 일이다', 'その時+の+こと+である. 격식체 회상 단정', '문법-문맥이해', 1390, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まさにその時のことである。', '바로 그때의 일이다.', 1),
    (w, '事件はその時のことである。', '사건은 그때의 일이다.', 2);

  -- 1391. こうした
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こうした', '이러한', '연체사 こうした. 「이러한·이런」 명사 수식', '문법-문맥이해', 1391, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうした問題は多い。', '이러한 문제는 많다.', 1),
    (w, 'こうした考えに賛成だ。', '이런 사고에 찬성이다.', 2);

  -- 1392. 持っているのだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '持っているのだ', 'もっているのだ', '갖고 있는 것이다', '持つ+ている+のだ. 상태 강조 단정', '문법-문맥이해', 1392, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '誰もが才能を持っているのだ。', '누구나 재능을 갖고 있는 것이다.', 1),
    (w, '彼は秘密を持っているのだ。', '그는 비밀을 갖고 있는 것이다.', 2);

  -- 1393. まず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'まず', '우선', '副詞 先(먼저 선)ず. 「먼저·우선」 순서 도입', '문법-문맥이해', 1393, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'まず手を洗おう。', '먼저 손을 씻자.', 1),
    (w, 'まず結論から述べる。', '우선 결론부터 말한다.', 2);

  -- 1394. 別の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '別の', 'べつの', '다른', '別(나눌 별)+の. 「다른·별도의」 명사 수식', '문법-문맥이해', 1394, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '別の方法を試す。', '다른 방법을 시도한다.', 1),
    (w, '別の機会に話そう。', '다른 기회에 이야기하자.', 2);

  -- 1395. いれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いれば', '있으면', 'いる+ば. 「있으면」 가정 조건', '문법-문맥이해', 1395, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '困っている人がいれば助ける。', '곤란한 사람이 있으면 돕는다.', 1),
    (w, 'いれば声をかけてください。', '있으면 말 걸어 주세요.', 2);

  -- 1396. わかってくるはずだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'わかってくるはずだ', 'わかってくるはずだ', '알게 될 것이다', '分かる+てくる+はず+だ. 「점차 이해될 것」 확신', '문법-문맥이해', 1396, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やがてわかってくるはずだ。', '머지않아 알게 될 것이다.', 1),
    (w, '経験すればわかってくるはずだ。', '경험하면 알게 될 것이다.', 2);

  -- 1397. しかしその一方で
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'しかしその一方で', '그러나 그 한편에서', 'しかし+その+一方+で. 격식체 대조 강조', '문법-문맥이해', 1397, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しかしその一方で問題もある。', '그러나 한편으로는 문제도 있다.', 1),
    (w, 'しかしその一方で批判が出た。', '그러나 그 한편에서는 비판이 나왔다.', 2);

  -- 1398. わたしにとって
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'わたしにとって', 'わたしにとって', '나에게 있어', 'わたし+に+とって. 「내 입장에서는」', '문법-문맥이해', 1398, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わたしにとって大切な人だ。', '나에게 있어 소중한 사람이다.', 1),
    (w, 'わたしにとって難しい問題だ。', '나에게 있어서 어려운 문제다.', 2);

  -- 1399. もしかしたら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'もしかしたら', '어쩌면', '副詞 もしかしたら. 「만약 ~한다면」 약한 추측', '문법-문맥이해', 1399, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もしかしたら遅刻するかもしれない。', '어쩌면 지각할지도 모른다.', 1),
    (w, 'もしかしたら彼は知っているかも。', '어쩌면 그는 알고 있을지도.', 2);

  -- 1400. 否定しているわけではない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '否定しているわけではない', 'ひていしているわけではない', '부정하고 있는 것은 아니다', '否定+する+ている+わけ+ではない. 부분 부정', '문법-문맥이해', 1400, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の意見を否定しているわけではない。', '그의 의견을 부정하는 것은 아니다.', 1),
    (w, '全てを否定しているわけではない。', '모두를 부정하는 것은 아니다.', 2);

  -- 1401. 生まれるからだが
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '生まれるからだが', 'うまれるからだが', '생겨나기 때문이지만', '生まれる+から+だが. 「~이기 때문이지만」 원인+역접', '문법-문맥이해', 1401, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新たな価値が生まれるからだが、課題もある。', '새 가치가 생겨나기 때문이지만 과제도 있다.', 1),
    (w, '違いから対立が生まれるからだが、対話が大切だ。', '차이에서 대립이 생기지만 대화가 중요하다.', 2);

  -- 1402. なり得ないのだと思う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'なり得ないのだと思う', 'なりえないのだとおもう', '될 수 없는 것이라고 생각한다', 'なる+得る+ない+のだ+と+思う. 격식체 단정', '문법-문맥이해', 1402, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'それは答えになり得ないのだと思う。', '그것은 답이 될 수 없는 것이라고 생각한다.', 1),
    (w, '解決にはなり得ないのだと思う。', '해결이 될 수는 없다고 생각한다.', 2);

  -- 1403. 力である
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '力である', 'ちからである', '힘이다', '力+である. 「힘이다」 격식체 단정', '문법-문맥이해', 1403, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '知識は力である。', '지식은 힘이다.', 1),
    (w, '愛は最大の力である。', '사랑은 최대의 힘이다.', 2);

  -- 1404. あるとき
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'あるとき', 'あるとき', '언젠가', 'ある+とき. 「어느 때·언젠가」 이야기 도입', '문법-문맥이해', 1404, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あるとき不思議なことが起きた。', '언젠가 신기한 일이 일어났다.', 1),
    (w, 'あるとき、彼が現れた。', '어느 때 그가 나타났다.', 2);

  -- 1405. 思えてきた
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思えてきた', 'おもえてきた', '생각되기 시작했다', '思える+てくる+た. 「점차 ~로 느껴지다」', '문법-문맥이해', 1405, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼が正しいと思えてきた。', '그가 맞는 것 같이 느껴지기 시작했다.', 1),
    (w, '無駄に思えてきた。', '쓸데없게 느껴지기 시작했다.', 2);

  -- 1406. そういえば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'そういえば', '그러고 보니', 'そう+いえば. 「그러고 보니·말이 났으니」 화제 전환', '문법-문맥이해', 1406, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そういえば、明日は休日だ。', '그러고 보니 내일은 휴일이다.', 1),
    (w, 'そういえば、彼から連絡があった。', '그러고 보니 그에게서 연락이 왔다.', 2);

  -- 1407. 思ったのである
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思ったのである', 'おもったのである', '생각한 것이다', '思う+た+のである. 격식체 단정 회상', '문법-문맥이해', 1407, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これでよかったと思ったのである。', '이게 좋았다고 생각한 것이다.', 1),
    (w, '本気だと思ったのである。', '진심이라고 생각한 것이다.', 2);

  -- 1408. ～なら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～なら', '~라면', '断定 だ+ば(なら). 「~이라면」 가정 조건', '문법-문맥이해', 1408, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨なら中止だ。', '비라면 중지다.', 1),
    (w, '私なら行く。', '나라면 간다.', 2);

  -- 1409. とはいえ (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'とはいえ (#2)', '그렇지만', 'と+は+いえ. 강조 반복형', '문법-문맥이해', 1409, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さい子供とはいえ侮れない。', '어린 아이지만 얕볼 수 없다.', 1),
    (w, '簡単とはいえ油断は禁物だ。', '쉽다고는 해도 방심은 금물이다.', 2);

  -- 1410. こうして (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こうして (#2)', '이렇게', 'こう+して. 강조 반복형', '문법-문맥이해', 1410, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こうして手紙を書いた。', '이렇게 편지를 썼다.', 1),
    (w, 'こうしてみると、君は正しい。', '이렇게 보니 네가 옳다.', 2);

  -- 1411. 驚くほどだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '驚くほどだ', 'おどろくほどだ', '놀랄 정도이다', '驚(놀랄 경)く+ほど+だ. 「놀랄 만큼 ~하다」 강조', '문법-문맥이해', 1411, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の技術は驚くほどだ。', '그의 기술은 놀랄 정도다.', 1),
    (w, '美しさは驚くほどだ。', '아름다움은 놀랄 정도다.', 2);

  -- 1412. 片付けなくても
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '片付けなくても', 'かたづけなくても', '정리하지 않아도', '片付ける+なくて+も. 「~안 해도 (괜찮다)」', '문법-문맥이해', 1412, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今、片付けなくても大丈夫だ。', '지금 정리 안 해도 괜찮다.', 1),
    (w, '片付けなくてもいい。', '치우지 않아도 된다.', 2);

  -- 1413. プロセスなのだと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'プロセスなのだと', '과정인 것이라고', '외래어 process+な+のだ+と. 「~이라는 과정이라고」', '문법-문맥이해', 1413, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗もプロセスなのだと考える。', '실패도 과정이라고 생각한다.', 1),
    (w, '成長のプロセスなのだと信じる。', '성장의 과정이라고 믿는다.', 2);

  -- 1414. 戻すことにしていこう
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '戻すことにしていこう', 'もどすことにしていこう', '되돌리기로 해 가자', '戻す+こと+に+する+ていく+う. 「~하기로 해 가자」 결심', '문법-문맥이해', 1414, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '元の生活に戻すことにしていこう。', '본래 생활로 되돌리기로 해 가자.', 1),
    (w, '少しずつ戻すことにしていこう。', '조금씩 되돌리기로 해 가자.', 2);

  -- 1415. そうした保育園
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'そうした保育園', 'そうしたほいくえん', '그런 보육원', 'そうした+保育園. 「그러한 보육원」', '문법-문맥이해', 1415, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'そうした保育園が増えている。', '그러한 보육원이 늘고 있다.', 1),
    (w, 'そうした保育園を探している。', '그런 보육원을 찾고 있다.', 2);

  -- 1416. ただ (다만)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ただ (다만)', '다만', '副詞·접속사 ただ. 강조 반복형', '문법-문맥이해', 1416, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '行く。ただ、条件がある。', '간다. 다만 조건이 있다.', 1),
    (w, 'できる。ただ時間がかかる。', '할 수 있다. 다만 시간이 걸린다.', 2);

  -- 1417. 入学したとたん
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '入学したとたん', 'にゅうがくしたとたん', '입학하자마자', '入学+する+た+とたん(途端). 「~한 순간」', '문법-문맥이해', 1417, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '入学したとたん友達ができた。', '입학하자마자 친구가 생겼다.', 1),
    (w, '入学したとたん忙しくなった。', '입학하자마자 바빠졌다.', 2);

  -- 1418. たくましく思えます
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'たくましく思えます', 'たくましくおもえます', '늠름하게 생각됩니다', '逞(굳셀 정)しい+思える+ます. 「~로 느껴집니다」', '문법-문맥이해', 1418, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供がたくましく思えます。', '아이가 늠름해 보입니다.', 1),
    (w, '彼の姿がたくましく思えます。', '그의 모습이 듬직하게 느껴집니다.', 2);

  -- 1419. たしかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'たしかに', '확실히', '副詞 確(굳을 확)かに. 「확실히·분명히」', '문법-문맥이해', 1419, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'たしかに、彼の言う通りだ。', '확실히 그의 말 그대로다.', 1),
    (w, 'たしかに難しい問題だ。', '확실히 어려운 문제다.', 2);

  -- 1420. そのためだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'そのためだ', 'そのためだ', '그 때문이다', 'その+ため+だ. 「그 때문이다」 원인 단정', '문법-문맥이해', 1420, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗したのはそのためだ。', '실패한 것은 그 때문이다.', 1),
    (w, '遅刻はそのためだ。', '지각은 그 때문이다.', 2);

  -- 1421. ～すら
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～すら', '~마저', '계조사 すら. 「~조차」 격식체 극단적 예시', '문법-문맥이해', 1421, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '名前すら覚えていない。', '이름조차 기억나지 않는다.', 1),
    (w, '挨拶すらしない。', '인사조차 하지 않는다.', 2);

  -- 1422. 使者のようでもある
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '使者のようでもある', 'ししゃのようでもある', '사신 같기도 하다', '使者+の+よう+でもある. 비유 단정', '문법-문맥이해', 1422, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は天使の使者のようでもある。', '그는 천사의 사신과도 같다.', 1),
    (w, '神の使者のようでもある。', '신의 사신 같기도 하다.', 2);

  -- 1423. 小説であってもだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '小説であってもだ', 'しょうせつであってもだ', '소설이어도 말이다', '小説+であって+も+だ. 강한 단정 양보', '문법-문맥이해', 1423, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小説であってもだ、真実は描かれる。', '소설이어도 말이다, 진실은 그려진다.', 1),
    (w, 'フィクションであってもだ、教訓はある。', '픽션이어도 말이지, 교훈은 있다.', 2);

  -- 1424. 褒めたり叱ったりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '褒めたり叱ったりする', 'ほめたりしかったりする', '칭찬하기도 야단치기도 한다', '褒(기릴 포)める+たり+叱(꾸짖을 질)る+たり+する. 동작 나열', '문법-문맥이해', 1424, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供を褒めたり叱ったりする。', '아이를 칭찬하기도 야단치기도 한다.', 1),
    (w, '部下を褒めたり叱ったりして育てる。', '부하를 칭찬하기도 야단치기도 하며 키운다.', 2);

  -- 1425. 否定せずにいられなくなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '否定せずにいられなくなる', 'ひていせずにいられなくなる', '부정하지 않을 수 없게 된다', '否定+せず+に+いられない+なる. 「~할 수밖에 없게 된다」', '문법-문맥이해', 1425, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'その事実を否定せずにいられなくなる。', '그 사실을 부정하지 않을 수 없다.', 1),
    (w, '誤りを否定せずにいられなくなる。', '잘못을 부정하지 않을 수 없다.', 2);

  -- 1426. ～とは
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～とは (정의)', '~란', 'と+は. 「~이라는 것은」 정의·놀람', '문법-문맥이해', 1426, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '友情とは支え合うことだ。', '우정이란 서로 의지하는 것이다.', 1),
    (w, '彼が裏切るとは思わなかった。', '그가 배신할 줄은 몰랐다.', 2);

  -- 1427. 選ばなければならない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '選ばなければならない', 'えらばなければならない', '선택해야 한다', '選ぶ+なければならない. 의무·필연', '문법-문맥이해', 1427, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一つを選ばなければならない。', '하나를 선택해야 한다.', 1),
    (w, '道を選ばなければならない。', '길을 선택해야 한다.', 2);

  -- 1428. ～ということだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～ということだ', '~란 것이다', 'と+いう+こと+だ. 「~라는 의미·전언」', '문법-문맥이해', 1428, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり中止ということだ。', '즉 중지라는 것이다.', 1),
    (w, '彼は来ないということだ。', '그는 안 온다는 것이다.', 2);

  -- 1429. 小説
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '小説', 'しょうせつ', '소설', '小(작을 소)+説(말씀 설). 「짧은 이야기」 → 소설', '문법-문맥이해', 1429, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小説を読む。', '소설을 읽는다.', 1),
    (w, '彼は小説家だ。', '그는 소설가다.', 2);

  -- 1430. アプローチかもしれない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'アプローチかもしれない', '접근일지도 모른다', '외래어 approach+かもしれない. 추량', '문법-문맥이해', 1430, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '新しいアプローチかもしれない。', '새 접근법일지도 모른다.', 1),
    (w, '間違ったアプローチかもしれない。', '잘못된 접근일지도 모른다.', 2);

  -- 1431. 話すことで
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '話すことで', 'はなすことで', '이야기하는 것으로', '話す+こと+で. 「말하는 것으로(써)」 수단', '문법-문맥이해', 1431, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話すことで気持ちが楽になる。', '이야기하는 것으로 마음이 편해진다.', 1),
    (w, '話すことで理解が深まる。', '대화를 통해 이해가 깊어진다.', 2);

  -- 1432. 会ってこそ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '会ってこそ', 'あってこそ', '만나야 비로소', '会う+て+こそ. 「~해야만」 강조 조건', '문법-문맥이해', 1432, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会ってこそ分かることもある。', '만나야만 알 수 있는 것도 있다.', 1),
    (w, '実際に会ってこそ理解できる。', '실제로 만나야 비로소 이해할 수 있다.', 2);

  -- 1433. 思い出してください
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思い出してください', 'おもいだしてください', '떠올려 주세요', '思い出す+てください. 정중 부탁', '문법-문맥이해', 1433, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔のことを思い出してください。', '예전 일을 떠올려 주세요.', 1),
    (w, '彼の顔を思い出してください。', '그의 얼굴을 떠올려 주세요.', 2);

  -- 1434. ～というわけです
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～というわけです', '~라는 것입니다', 'と+いう+わけ+です. 「결국 ~인 셈입니다」 결론·설명', '문법-문맥이해', 1434, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'つまり、こうなったというわけです。', '즉, 이렇게 된 것입니다.', 1),
    (w, '彼が来ないというわけです。', '그가 안 온다는 것입니다.', 2);

  -- 1435. 気を使わせられはしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '気を使わせられはしない', 'きをつかわせられはしない', '신경쓰게 할 수는 없다', '気を使う+사역+수동+はしない. 「~하게 만들지 않는다」', '문법-문맥이해', 1435, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼に気を使わせられはしない。', '그에게 신경 쓰게 할 수는 없다.', 1),
    (w, 'お客様に気を使わせられはしない。', '손님께 신경 쓰게 할 수는 없다.', 2);

  -- 1436. それにもかかわらず
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'それにもかかわらず', '그럼에도 불구하고', 'それ+に+も+かかわらず(関わらず). 격식체 강한 역접', '문법-문맥이해', 1436, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '反対された。それにもかかわらず実行した。', '반대당했다. 그럼에도 불구하고 실행했다.', 1),
    (w, '危険だ。それにもかかわらず挑戦する。', '위험하다. 그럼에도 불구하고 도전한다.', 2);

  -- 1437. 承知していれば
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '承知していれば', 'しょうちしていれば', '알고 있으면', '承(받들 승)知+する+ている+ば. 「알고 있으면」 조건', '문법-문맥이해', 1437, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事情を承知していれば対応できた。', '사정을 알고 있었으면 대응할 수 있었다.', 1),
    (w, 'リスクを承知していれば備える。', '위험을 알고 있으면 대비한다.', 2);

  -- 1438. ～だって (#2)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, '～だって (#2)', '~도', 'だって(인용·강조). 강조 반복형', '문법-문맥이해', 1438, array['grammar']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '私だって行きたい。', '나도 가고 싶다.', 1),
    (w, '子供だって意見はある。', '아이라도 의견은 있다.', 2);

end $$;

-- ============================================================
-- N1 어휘 174개 어원 보강 + 손상 데이터 정정 패치
-- (PDF 추출 시 일부 한자/한국어가 깨졌던 항목을 정정하고,
--  외래어/의태어/한자어에 대한 어원 풀이를 일괄 추가)
-- ============================================================

-- ============================================================
-- N1 어휘 어원 보강 + 손상 데이터 정정 (Chunk 1: order 171~329, 50개)
-- ============================================================
do $$
declare
  d_n1 uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 171 キャリア (career)
  update public.words set etymology='영어 career(경력). 「직업·경력·진로」로 사용' where deck_id=d_n1 and order_index=171;
  -- 175 フォローする (follow)
  update public.words set etymology='영어 follow(따르다)+する. 「지원하다·뒤따르다·보조하다」' where deck_id=d_n1 and order_index=175;
  -- 179 やんわり (의태어)
  update public.words set etymology='やわらか(부드러움)의 음성 변형. 「부드럽게·완곡하게」' where deck_id=d_n1 and order_index=179;
  -- 184 ストック (stock)
  update public.words set etymology='영어 stock(재고). 「재고·저장·축적」' where deck_id=d_n1 and order_index=184;
  -- 186 ニュアンス (nuance)
  update public.words set etymology='프랑스어 nuance(색조). 「미묘한 차이·뉘앙스」' where deck_id=d_n1 and order_index=186;
  -- 200 ハードル (hurdle)
  update public.words set etymology='영어 hurdle(장애물). 「허들·장애·난관」' where deck_id=d_n1 and order_index=200;
  -- 205 リストアップ (list-up, 일본식 영어)
  update public.words set etymology='영어 list+up. 「목록화하기·열거하기」 일본식 조어' where deck_id=d_n1 and order_index=205;
  -- 210 じめじめ
  update public.words set etymology='습기 어린 끈적임을 나타내는 의태어. 「축축·눅눅」' where deck_id=d_n1 and order_index=210;
  -- 211 そわそわ (손상 정정)
  update public.words set meaning='안절부절못함, 들떠 어쩔 줄 모르는 모양', etymology='안정되지 못한 모양의 의태어. 「안절부절·들썩들썩」' where deck_id=d_n1 and order_index=211;
  -- 213 ためらう
  update public.words set etymology='溜(머무를 류)める의 자동사화. 「행동을 멈추다」→ 망설이다' where deck_id=d_n1 and order_index=213;
  -- 220 ウエイト (weight)
  update public.words set etymology='영어 weight(무게). 「무게·비중·중요도」' where deck_id=d_n1 and order_index=220;
  -- 221 甚だしい (손상 정정: 太だしい→甚だしい, しばしい→はなはだしい)
  update public.words set headword='甚だしい', reading='はなはだしい', meaning='엄청나다, (정도가) 심하다', etymology='甚(심할 심)+だしい. 「정도가 매우 심함」' where deck_id=d_n1 and order_index=221;
  -- 228 たどる
  update public.words set etymology='手繰(たぐ)る와 동근. 「실마리를 따라가다」→ 더듬다·따라가다' where deck_id=d_n1 and order_index=228;
  -- 229 てきぱき
  update public.words set etymology='시원시원하고 능률적인 모양의 의태어. 「척척·시원시원」' where deck_id=d_n1 and order_index=229;
  -- 230 ノルマ (norma)
  update public.words set etymology='러시아어 норма(노르마/할당량). 「의무 할당량」' where deck_id=d_n1 and order_index=230;
  -- 233 おおらかな (손상 정정)
  update public.words set meaning='너그러운, 대범한, 느긋한', etymology='大(おお, 클 대)+らか(상태 접미사). 「큰 마음씨」→ 너그러움' where deck_id=d_n1 and order_index=233;
  -- 238 くよくよ (손상 정정)
  update public.words set meaning='끙끙, 사소한 일을 끊임없이 고민하는 모양', etymology='작은 일을 곱씹는 모양의 의태어. 「끙끙·자꾸자꾸」' where deck_id=d_n1 and order_index=238;
  -- 240 しいて
  update public.words set etymology='強(し)いる(강요하다)의 て형. 「굳이·억지로」' where deck_id=d_n1 and order_index=240;
  -- 241 すさまじい
  update public.words set etymology='凄(처량할 처)まじい. 「섬뜩할 정도로 대단하다」' where deck_id=d_n1 and order_index=241;
  -- 246 メディア (media)
  update public.words set etymology='영어 media(매체). 「매체·미디어」' where deck_id=d_n1 and order_index=246;
  -- 253 すんなり (손상 정정)
  update public.words set meaning='순조롭게, 쉽게, 매끈하게', etymology='막힘없이 매끄러운 모양의 의태어. 「쑥·술술」' where deck_id=d_n1 and order_index=253;
  -- 254 センス (sense)
  update public.words set etymology='영어 sense(감각). 「감각·센스·취향」' where deck_id=d_n1 and order_index=254;
  -- 256 ノウハウ (know-how)
  update public.words set etymology='영어 know-how. 「실무 지식·요령」' where deck_id=d_n1 and order_index=256;
  -- 258 へとへと (손상 정정)
  update public.words set meaning='녹초가 된 모양, 기진맥진한 상태', etymology='완전히 지친 모양의 의태어. 「녹초·기진맥진」' where deck_id=d_n1 and order_index=258;
  -- 262 コンスタントに (constant)
  update public.words set etymology='영어 constant(일정한)+に. 「일정하게·꾸준히」' where deck_id=d_n1 and order_index=262;
  -- 265 もっぱら (손상 정정)
  update public.words set meaning='오로지, 한결같이, 전적으로', etymology='専(오로지 전)ら. 「오로지 그것만」' where deck_id=d_n1 and order_index=265;
  -- 266 よみがえる
  update public.words set etymology='黄泉(よみ, 저승)+帰(かえ)る. 「저승에서 돌아오다」→ 소생하다' where deck_id=d_n1 and order_index=266;
  -- 271 いとも
  update public.words set etymology='고어 副 いと(매우)+も. 「실로·매우·아주」 문어체' where deck_id=d_n1 and order_index=271;
  -- 272 まちまち
  update public.words set etymology='区(まち)々. 「제각각 구역마다 다름」→ 각양각색' where deck_id=d_n1 and order_index=272;
  -- 274 リスク (risk)
  update public.words set etymology='영어 risk(위험). 「위험·리스크」' where deck_id=d_n1 and order_index=274;
  -- 277 がらりと (손상 정정)
  update public.words set meaning='확, 완전히 바뀌는 모양', etymology='문을 활짝 열거나 상황이 급변하는 의태어. 「확·홀딱」' where deck_id=d_n1 and order_index=277;
  -- 278 なだめる
  update public.words set etymology='和(なご)む(누그러지다)와 동근. 「화를 가라앉히다」→ 달래다' where deck_id=d_n1 and order_index=278;
  -- 281 レイアウト (layout)
  update public.words set etymology='영어 layout(배치). 「배치·구성·레이아웃」' where deck_id=d_n1 and order_index=281;
  -- 286 せかせかと (손상 정정)
  update public.words set meaning='허둥지둥, 서두르며 부산스러운 모양', etymology='急(せ)く(서두르다)의 반복형. 「허둥허둥·부산스럽게」' where deck_id=d_n1 and order_index=286;
  -- 287 センサー (sensor)
  update public.words set etymology='영어 sensor(감지기). 「감지 장치·센서」' where deck_id=d_n1 and order_index=287;
  -- 289 ここちよく (손상 정정)
  update public.words set meaning='기분 좋게, 상쾌하게', etymology='心地(ここち)+よく. 「마음의 상태가 좋게」→ 상쾌하게' where deck_id=d_n1 and order_index=289;
  -- 291 にじむ (손상 정정)
  update public.words set meaning='번지다, 스며 나오다', etymology='滲(스밀 삼)む. 「액체가 천천히 퍼지다」' where deck_id=d_n1 and order_index=291;
  -- 293 ひしひしと (손상 정정)
  update public.words set meaning='강렬하게, 절실히, 뼈저리게', etymology='조여드는 듯한 압박감의 의태어. 「뼈저리게·절실히」' where deck_id=d_n1 and order_index=293;
  -- 299 ずっしりと (손상 정정)
  update public.words set meaning='묵직하게, 손에 무겁게', etymology='무게가 가득 실린 모양의 의태어. 「묵직·묵직」' where deck_id=d_n1 and order_index=299;
  -- 301 クレーム (claim)
  update public.words set etymology='영어 claim(불평·청구). 「불만 제기·항의」 일본식 의미' where deck_id=d_n1 and order_index=301;
  -- 303 みっちり (손상 정정)
  update public.words set meaning='꼼꼼히, 철저하게', etymology='틈없이 꽉 채워진 모양의 의태어. 「빈틈없이·철저히」' where deck_id=d_n1 and order_index=303;
  -- 305 うずうず (손상 정정)
  update public.words set meaning='근질근질, 안달이 나서 못 견디는 모양', etymology='몸이 근질거리는 의태어. 「안달·근질근질」' where deck_id=d_n1 and order_index=305;
  -- 311 ぎくしゃくする (손상 정정)
  update public.words set meaning='어색하다, 삐걱거리다', etymology='움직임이 부자연스러운 의태어 ぎくしゃく+する. 「삐걱삐걱」' where deck_id=d_n1 and order_index=311;
  -- 315 もどかしい
  update public.words set etymology='고어 もどく(반대로 하다)+しい. 「뜻대로 안 되어 답답함」' where deck_id=d_n1 and order_index=315;
  -- 318 めきめき (손상 정정)
  update public.words set meaning='눈에 띄게, 부쩍부쩍 성장·발전하는 모양', etymology='드러나게 진보하는 모양의 의태어. 「부쩍부쩍·쑥쑥」' where deck_id=d_n1 and order_index=318;
  -- 320 サイクル (cycle)
  update public.words set etymology='영어 cycle(주기). 「순환·주기·자전거」' where deck_id=d_n1 and order_index=320;
  -- 322 しわざ (손상 정정)
  update public.words set meaning='소행, 짓, 행적', etymology='仕(し)+業(わざ). 「(좋지 않은) 행위·짓」' where deck_id=d_n1 and order_index=322;
  -- 324 すべすべ
  update public.words set etymology='滑(すべ)る(미끄러지다)의 반복. 「매끈매끈한 촉감」' where deck_id=d_n1 and order_index=324;
  -- 328 すくう (손상 정정)
  update public.words set meaning='떠올리다, 건져내다, 퍼올리다', etymology='掬(움킬 국)う. 「손바닥으로 떠내다」' where deck_id=d_n1 and order_index=328;
  -- 329 ピント (네덜란드어 brandpunt)
  update public.words set etymology='네덜란드어 brandpunt(초점)에서 차용. 「렌즈의 초점」' where deck_id=d_n1 and order_index=329;
end $$;
-- ============================================================
-- N1 어휘 어원 보강 + 손상 데이터 정정 (Chunk 2: order 331~454, 50개)
-- ============================================================
do $$
declare
  d_n1 uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 331 てっきり
  update public.words set etymology='꼭 그렇다고 단정짓는 어감의 의태어. 「틀림없이·꼭」' where deck_id=d_n1 and order_index=331;
  -- 334 どんより (손상 정정)
  update public.words set meaning='날씨가 흐릿한 모양, 잿빛으로 가라앉은 모양', etymology='무겁고 흐릿한 분위기를 나타내는 의태어. 「잿빛·우중충」' where deck_id=d_n1 and order_index=334;
  -- 335 ネック (neck)
  update public.words set meaning='병목, 애로사항', etymology='영어 neck(목)의 비유. 「병목·관건이 되는 부분」' where deck_id=d_n1 and order_index=335;
  -- 343 つくづく (손상 정정)
  update public.words set meaning='절실히, 곰곰이, 정말로', etymology='속을 깊이 들여다보는 모양의 의태어. 「절실히·곰곰이」' where deck_id=d_n1 and order_index=343;
  -- 350 がやがや (손상 정정)
  update public.words set meaning='왁자지껄, 시끄럽게 떠드는 모양', etymology='여러 사람이 동시에 떠드는 의성어. 「왁자지껄」' where deck_id=d_n1 and order_index=350;
  -- 356 とっさに (손상 정정)
  update public.words set meaning='순간적으로, 즉시', etymology='咄嗟(とっさ, 한순간)+に. 「눈 깜짝할 사이에」' where deck_id=d_n1 and order_index=356;
  -- 357 いやみ (손상 정정)
  update public.words set meaning='빈정거림, 비꼬는 말, 꼴사나움', etymology='嫌(いや, 싫음)+味. 「싫은 맛」→ 빈정거림' where deck_id=d_n1 and order_index=357;
  -- 359 なじむ
  update public.words set etymology='馴(친할 순)染(물들 염)む. 「점차 익숙해지고 물들다」' where deck_id=d_n1 and order_index=359;
  -- 360 はかどる (손상 정정)
  update public.words set meaning='일이 진척되다, 순조롭게 나아가다', etymology='捗(척)る. 「작업이 빠르게 나아감」' where deck_id=d_n1 and order_index=360;
  -- 362 まばらだ
  update public.words set etymology='疎(まば)ら+だ. 「듬성듬성하다·드물다」' where deck_id=d_n1 and order_index=362;
  -- 364 やむをえず
  update public.words set etymology='止(や)む+を+得(え)+ず. 「그만둘 수밖에 없어서」→ 부득이' where deck_id=d_n1 and order_index=364;
  -- 365 ルーズな (손상 정정: 늨슬한, 고수적이지 못한)
  update public.words set meaning='헐렁한, 야무지지 못한, 칠칠치 못한', etymology='영어 loose(느슨한)+な. 「(태도가) 헐렁한·칠칠치 못한」' where deck_id=d_n1 and order_index=365;
  -- 367 わずらわしい
  update public.words set etymology='煩(번거로울 번)わしい. 「귀찮을 정도로 번잡함」' where deck_id=d_n1 and order_index=367;
  -- 368 あっけない
  update public.words set etymology='呆気(あっけ, 어이없음)+ない. 「어이가 없다·허무하다」' where deck_id=d_n1 and order_index=368;
  -- 369 ありきたりの
  update public.words set etymology='有(あ)り+来(きた)り+の. 「예전부터 있어 온」→ 흔한·진부한' where deck_id=d_n1 and order_index=369;
  -- 372 コントラスト (contrast)
  update public.words set etymology='영어 contrast(대비). 「대조·대비·콘트라스트」' where deck_id=d_n1 and order_index=372;
  -- 373 シビアな (severe)
  update public.words set etymology='영어 severe(엄격한)+な. 「가혹한·냉정한·엄격한」' where deck_id=d_n1 and order_index=373;
  -- 376 にわかには (손상 정정)
  update public.words set meaning='갑자기는, 당장은', etymology='俄(にわか, 갑자기)+には. 「급히는·당장은」 부정 호응' where deck_id=d_n1 and order_index=376;
  -- 377 もくろむ (손상 정정)
  update public.words set meaning='계획하다, 꾸미다, 의도하다', etymology='目論(もくろ)む. 「머릿속으로 그려보다」→ 계획하다' where deck_id=d_n1 and order_index=377;
  -- 379 おっくうだ
  update public.words set etymology='億劫(おっくう, 매우 긴 시간)+だ. 「엄두가 안 날 정도로 귀찮음」' where deck_id=d_n1 and order_index=379;
  -- 380 おのずと
  update public.words set etymology='自(おの)ずと. 「스스로·자연스럽게」 문어체 부사' where deck_id=d_n1 and order_index=380;
  -- 382 けなされる (손상 정정)
  update public.words set meaning='헐뜯기다, 깎아내림을 당하다', etymology='貶(けな)す의 수동형. 「(나쁘게) 평가받다」' where deck_id=d_n1 and order_index=382;
  -- 383 しきりに
  update public.words set etymology='頻(しき)りに. 「잇따라·끊임없이」' where deck_id=d_n1 and order_index=383;
  -- 385 すがすがしい (손상 정정)
  update public.words set meaning='상쾌하다, 산뜻하다', etymology='清(すが)+清(すが)+しい. 「청량함이 거듭됨」' where deck_id=d_n1 and order_index=385;
  -- 386 スケール (scale)
  update public.words set etymology='영어 scale(눈금·규모). 「규모·크기·스케일」' where deck_id=d_n1 and order_index=386;
  -- 391 あらかじめ
  update public.words set etymology='予(あらかじ)め. 「미리·사전에」 문어체' where deck_id=d_n1 and order_index=391;
  -- 393 おおむね (손상 정정)
  update public.words set meaning='대략, 대체로, 대강', etymology='概(おおむね, 대략 개). 「큰 줄거리·대략」' where deck_id=d_n1 and order_index=393;
  -- 395 ことごとく
  update public.words set etymology='悉(다할 실)く. 「하나도 빠짐없이·모조리」' where deck_id=d_n1 and order_index=395;
  -- 398 すべ
  update public.words set etymology='術(꾀 술). 「방법·수단」 문어체' where deck_id=d_n1 and order_index=398;
  -- 399 せかす
  update public.words set etymology='急(せ)かす. 「서두르게 하다」→ 재촉하다' where deck_id=d_n1 and order_index=399;
  -- 400 バックアップ (backup)
  update public.words set etymology='영어 backup(지원·예비). 「지원·백업·후원」' where deck_id=d_n1 and order_index=400;
  -- 402 メカニズム (mechanism)
  update public.words set etymology='영어 mechanism(메커니즘). 「구조·원리·작동 방식」' where deck_id=d_n1 and order_index=402;
  -- 404 いたって
  update public.words set etymology='至(いた)って. 「지극히 ~에 이르러」→ 매우·아주' where deck_id=d_n1 and order_index=404;
  -- 406 お手上げだ
  update public.words set etymology='お+手+上(あ)げ+だ. 「두 손을 든 상태」→ 속수무책' where deck_id=d_n1 and order_index=406;
  -- 409 ストレートに (손상 정정)
  update public.words set meaning='솔직히, 직접적으로, 곧바로', etymology='영어 straight(곧은)+に. 「똑바로·직설적으로」' where deck_id=d_n1 and order_index=409;
  -- 414 ありふれる
  update public.words set etymology='有(あ)り+触(ふ)れる. 「도처에 널려 있다」→ 흔하다' where deck_id=d_n1 and order_index=414;
  -- 416 うろたえる
  update public.words set etymology='狼狽(うろた)える. 「어찌할 바를 모르다」→ 당황하다' where deck_id=d_n1 and order_index=416;
  -- 428 おびえる (손상 정정)
  update public.words set meaning='겁에 질리다, 무서워하다', etymology='怯(겁낼 겁)える. 「공포로 위축되다」' where deck_id=d_n1 and order_index=428;
  -- 429 かねがね
  update public.words set etymology='兼(かね)+ね. 「이전부터·예전부터」 문어체' where deck_id=d_n1 and order_index=429;
  -- 430 かろうじて (손상 정정)
  update public.words set meaning='간신히, 가까스로, 겨우', etymology='辛(から)うじて. 「간신히·고생 끝에」' where deck_id=d_n1 and order_index=430;
  -- 432 ささいな
  update public.words set etymology='些細(ささい, 적을 사+가늘 세)+な. 「하찮은·사소한」' where deck_id=d_n1 and order_index=432;
  -- 437 うすうす (손상 정정)
  update public.words set meaning='희미하게, 어렴풋이', etymology='薄(うす)い의 반복. 「엷게·어렴풋이」' where deck_id=d_n1 and order_index=437;
  -- 442 むっとする (손상 정정)
  update public.words set meaning='발끈하다, 못마땅한 얼굴을 하다', etymology='むっ(불쾌함의 의태어)+とする. 「불쾌해서 표정이 굳다」' where deck_id=d_n1 and order_index=442;
  -- 444 ゆとり
  update public.words set etymology='ゆる(느슨)+り. 「공간·시간의 여유」' where deck_id=d_n1 and order_index=444;
  -- 448 かたくなな
  update public.words set etymology='頑(かたく)な+な. 「완고하게 고집하는」' where deck_id=d_n1 and order_index=448;
  -- 449 すみやかに
  update public.words set etymology='速(すみ)やかに. 「빠른 모양으로」→ 신속히' where deck_id=d_n1 and order_index=449;
  -- 450 ぼんやり (손상 정정)
  update public.words set meaning='멍하니, 흐릿하게', etymology='몽롱한 상태를 나타내는 의태어. 「멍하니·흐릿」' where deck_id=d_n1 and order_index=450;
  -- 452 エレガントな (elegant)
  update public.words set etymology='영어 elegant(우아한)+な. 「우아한·고상한」' where deck_id=d_n1 and order_index=452;
  -- 453 つかの間の
  update public.words set etymology='束(つか)の+間+の. 「한 줌만큼의 짧은 시간」' where deck_id=d_n1 and order_index=453;
  -- 454 しくじる
  update public.words set etymology='動詞 しくじる. 「(일을) 잘못 처리하다」→ 실수하다' where deck_id=d_n1 and order_index=454;
end $$;
-- ============================================================
-- N1 어휘 어원 보강 + 손상 데이터 정정 (Chunk 3: order 455~580, 50개)
-- ============================================================
do $$
declare
  d_n1 uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 455 スライスする (slice)
  update public.words set meaning='얇게 자르다, 슬라이스하다', etymology='영어 slice(얇게 자르기)+する. 「얇게 저미다」' where deck_id=d_n1 and order_index=455;
  -- 456 めいめいに
  update public.words set etymology='銘々(めいめい, 새길 명)+に. 「제각기·각자」' where deck_id=d_n1 and order_index=456;
  -- 458 ありありと (손상 정정)
  update public.words set meaning='생생히, 또렷이', etymology='有(あ)り+有(あ)り+と. 「확실히 존재하듯」→ 생생히' where deck_id=d_n1 and order_index=458;
  -- 459 返事をしぶる
  update public.words set meaning='대답을 망설이다, 답을 꺼리다', etymology='返事+を+渋(しぶ)る. 「대답하기를 주저하다」' where deck_id=d_n1 and order_index=459;
  -- 460 コンパクトな (compact)
  update public.words set etymology='영어 compact(작고 조밀한)+な. 「작고 알찬·콤팩트」' where deck_id=d_n1 and order_index=460;
  -- 461 つぶやく (손상 정정)
  update public.words set meaning='중얼거리다, 혼잣말하다', etymology='呟(つぶや)く. 「작은 소리로 말하다」' where deck_id=d_n1 and order_index=461;
  -- 463 ばてる
  update public.words set etymology='動詞 ばてる. 「체력이 다해 녹초가 되다」' where deck_id=d_n1 and order_index=463;
  -- 464 まっとうする
  update public.words set etymology='全(まっと)うする. 「온전히 다하다」→ 완수하다' where deck_id=d_n1 and order_index=464;
  -- 467 つぶさに
  update public.words set etymology='具(つぶさ, 갖출 구)+に. 「세세히 모두」→ 자세히' where deck_id=d_n1 and order_index=467;
  -- 470 エキスパート (expert)
  update public.words set etymology='영어 expert(전문가). 「전문가·숙련자」' where deck_id=d_n1 and order_index=470;
  -- 473 ぼやく (손상 정정)
  update public.words set meaning='투덜대다, 푸념하다', etymology='動詞 ぼやく. 「불만을 작게 흘리다」' where deck_id=d_n1 and order_index=473;
  -- 477 ろくに
  update public.words set etymology='碌(녹록할 록)に. 「제대로·충분히」 부정 호응' where deck_id=d_n1 and order_index=477;
  -- 480 くつろぐ
  update public.words set etymology='寛(너그러울 관)ぐ. 「긴장을 풀고 편하게 있다」' where deck_id=d_n1 and order_index=480;
  -- 481 うやむやに
  update public.words set etymology='有耶無耶(うやむや, 있는 듯 없는 듯)+に. 「흐지부지」' where deck_id=d_n1 and order_index=481;
  -- 487 スポット (spot)
  update public.words set meaning='장소, 명소, 스폿', etymology='영어 spot(지점·자리). 「특정 장소·명소」' where deck_id=d_n1 and order_index=487;
  -- 490 あどけない
  update public.words set etymology='動詞 あどける(천진하다)+ない. 「때 묻지 않은·천진난만한」' where deck_id=d_n1 and order_index=490;
  -- 492 やつれる (손상 정정)
  update public.words set meaning='수척해지다, 초췌해지다', etymology='窶(やつ)れる. 「(피로·고생으로) 야위어 마르다」' where deck_id=d_n1 and order_index=492;
  -- 499 しきたり
  update public.words set etymology='為(し)+来(きた)り. 「예로부터 해 온 것」→ 관습' where deck_id=d_n1 and order_index=499;
  -- 503 ぞんざいな (손상 정정)
  update public.words set meaning='무성의한, 거친, 함부로 하는', etymology='存(ぞん)在(ざい)에서 유래한 의태어적 형용. 「대충대충」' where deck_id=d_n1 and order_index=503;
  -- 504 うなだれる (손상 정정)
  update public.words set meaning='고개를 떨구다, 풀이 죽다', etymology='項(うな)+垂(た)れる. 「목덜미가 늘어지다」→ 고개를 숙이다' where deck_id=d_n1 and order_index=504;
  -- 507 ロスする (loss)
  update public.words set meaning='손실하다, 잃다', etymology='영어 loss(손실)+する. 「(시간·자원을) 낭비하다」' where deck_id=d_n1 and order_index=507;
  -- 508 おろそかに
  update public.words set etymology='疎(おろ)か+に. 「관심을 두지 않고 소홀히」' where deck_id=d_n1 and order_index=508;
  -- 515 ひとまず
  update public.words set etymology='一(ひと)+先(ま)ず. 「우선 한번」→ 일단·우선' where deck_id=d_n1 and order_index=515;
  -- 521 とっくに
  update public.words set meaning='이미, 벌써, 이미 오래 전에', etymology='疾(と)っく(빠름)+に. 「이미 한참 전에」' where deck_id=d_n1 and order_index=521;
  -- 525 ほどける (손상 정정)
  update public.words set meaning='풀리다, (매듭이) 풀어지다', etymology='解(ほど)ける. 「엉킨 것이 풀리다」' where deck_id=d_n1 and order_index=525;
  -- 533 ブランク (blank)
  update public.words set meaning='공백, 블랭크', etymology='영어 blank(빈 곳). 「공백 기간·빈자리」' where deck_id=d_n1 and order_index=533;
  -- 541 かばう
  update public.words set etymology='庇(かば)う. 「몸으로 가려 지키다」→ 감싸다' where deck_id=d_n1 and order_index=541;
  -- 554 しがみつく
  update public.words set etymology='動詞 しがみ+付(つ)く. 「꽉 붙들고 놓지 않다」' where deck_id=d_n1 and order_index=554;
  -- 566 くまなく
  update public.words set etymology='隈(くま, 모퉁이 구석)+なく. 「구석에 빠진 곳 없이」' where deck_id=d_n1 and order_index=566;
  -- 569 はなはだしい
  update public.words set etymology='甚(はなはだ)しい. 「정도가 매우 심함」' where deck_id=d_n1 and order_index=569;
  -- 571 もはや
  update public.words set etymology='最(も)+早(はや). 「이미 그 단계가 지나」→ 이제는·이미' where deck_id=d_n1 and order_index=571;
  -- 580 たやすい
  update public.words set meaning='쉽다, 손쉽다', etymology='容易(たやす)い. 「힘들이지 않고 할 수 있는」' where deck_id=d_n1 and order_index=580;
end $$;
-- ============================================================
-- N1 어휘 어원 보강 + 손상 데이터 정정 (Chunk 4: order 597~803, 42개 최종)
-- ============================================================
do $$
declare
  d_n1 uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 597 かさばる (손상 정정)
  update public.words set meaning='부피가 커서 거추장스럽다', etymology='嵩(かさ, 부피)+張(ば)る. 「부피가 커지다」' where deck_id=d_n1 and order_index=597;
  -- 599 しぶとい (손상 정정)
  update public.words set meaning='끈질기다, 강인하다', etymology='動詞 しぶる(주저하다)+とい. 「쉽게 물러서지 않는」' where deck_id=d_n1 and order_index=599;
  -- 603 ほほえましい (손상 정정)
  update public.words set meaning='보기에 흐뭇하다, 미소가 절로 나다', etymology='微笑(ほほえ)ましい. 「저절로 미소가 나오는」' where deck_id=d_n1 and order_index=603;
  -- 608 くじける (손상 정정)
  update public.words set meaning='꺾이다, 좌절하다', etymology='挫(꺾을 좌)ける. 「기세나 의지가 꺾이다」' where deck_id=d_n1 and order_index=608;
  -- 609 ひたむき (손상 정정)
  update public.words set meaning='한결같음, 외골수, 일편단심', etymology='直(ひた)+向(む)き. 「한 방향만 향한」→ 한결같음' where deck_id=d_n1 and order_index=609;
  -- 616 なつく
  update public.words set etymology='懐(품을 회)く. 「(특히 동물·아이가) 정을 들이다」→ 따르다' where deck_id=d_n1 and order_index=616;
  -- 618 リタイア (retire)
  update public.words set etymology='영어 retire(은퇴하다). 「은퇴·중도 포기」' where deck_id=d_n1 and order_index=618;
  -- 623 そそる
  update public.words set meaning='(식욕·흥미를) 돋우다, 자극하다', etymology='動詞 そそる. 「자극을 가해 일으키다」' where deck_id=d_n1 and order_index=623;
  -- 625 ぎこちない
  update public.words set etymology='動詞 ぎこつ(투박함)+ない. 「부자연스럽고 어색한」' where deck_id=d_n1 and order_index=625;
  -- 632 さえる (손상 정정)
  update public.words set meaning='맑아지다, (정신·소리가) 또렷해지다', etymology='冴(さ)える. 「추위로 사물이 또렷해지다」→ 맑다' where deck_id=d_n1 and order_index=632;
  -- 634 もろい (손상 정정)
  update public.words set meaning='부서지기 쉽다, 약하다', etymology='脆(약할 취)い. 「쉽게 무너지는」' where deck_id=d_n1 and order_index=634;
  -- 640 デマ (Demagogie)
  update public.words set meaning='유언비어, 헛소문', etymology='독일어 Demagogie(선동)에서 차용. 「근거 없는 소문」' where deck_id=d_n1 and order_index=640;
  -- 642 もたらす
  update public.words set etymology='持(も)+た+らす. 「가지고 와서 결과를 두다」→ 초래하다' where deck_id=d_n1 and order_index=642;
  -- 644 ずばり (손상 정정)
  update public.words set meaning='단도직입적으로, 정확하게, 정곡으로', etymology='날카롭게 베어내는 의태어. 「딱·정곡으로」' where deck_id=d_n1 and order_index=644;
  -- 657 その他
  update public.words set meaning='그 외, 기타', etymology='その+他(た, 다른 타). 「그것 외의 나머지」' where deck_id=d_n1 and order_index=657;
  -- 664 손상 항목: とんだ・あらためて (재정정: 두 단어가 잘못 묶임 → 'あらためて'를 표제어로)
  update public.words set headword='改めて', reading='あらためて', meaning='다시, 새삼스럽게, 새로이', etymology='改(고칠 개)めて. 「새로 한 번 더」 부사', part_of_speech='부사' where deck_id=d_n1 and order_index=664;
  -- 668 ヒットする (hit)
  update public.words set meaning='히트하다, 큰 성공을 거두다', etymology='영어 hit(맞다·성공)+する. 「대중적 성공」' where deck_id=d_n1 and order_index=668;
  -- 671 よしに (손상 정정: よしんば가 옳음)
  update public.words set headword='よしんば', reading='よしんば', meaning='설령, 만약', etymology='고어 よし(좋다)+ん+ば. 「설령 ~한다고 해도」 가정' where deck_id=d_n1 and order_index=671;
  -- 682 スケジュール (schedule)
  update public.words set etymology='영어 schedule(일정). 「일정·예정표」' where deck_id=d_n1 and order_index=682;
  -- 695 スポーツ (sports)
  update public.words set etymology='영어 sports(스포츠). 「운동 경기·체육」' where deck_id=d_n1 and order_index=695;
  -- 706 テレビ (television 약어)
  update public.words set etymology='영어 television의 일본식 약어. 「텔레비전」' where deck_id=d_n1 and order_index=706;
  -- 717 ダイエット (diet)
  update public.words set etymology='영어 diet(식이요법). 「체중 감량·식단 조절」' where deck_id=d_n1 and order_index=717;
  -- 727 サービス (service)
  update public.words set etymology='영어 service(봉사·서비스). 「서비스·접대」' where deck_id=d_n1 and order_index=727;
  -- 743 ポケット (pocket)
  update public.words set etymology='영어 pocket(주머니). 「의복의 작은 주머니」' where deck_id=d_n1 and order_index=743;
  -- 746 ケーキ (cake)
  update public.words set etymology='영어 cake(케이크). 「서양식 단 빵·과자」' where deck_id=d_n1 and order_index=746;
  -- 751 チーム (team)
  update public.words set etymology='영어 team(팀). 「공동의 목적을 가진 집단」' where deck_id=d_n1 and order_index=751;
  -- 753 ステレオ (stereo)
  update public.words set etymology='영어 stereo(입체 음향). 「스테레오 음향 장치」' where deck_id=d_n1 and order_index=753;
  -- 756 セール (sale)
  update public.words set etymology='영어 sale(판매·할인). 「할인 판매」' where deck_id=d_n1 and order_index=756;
  -- 761 チップ (tip)
  update public.words set etymology='영어 tip(팁). 「봉사료·심부름값」' where deck_id=d_n1 and order_index=761;
  -- 763 それぞれ
  update public.words set headword=NULL, reading='それぞれ', meaning='제각각, 각각', etymology='連体詞·副詞 それ(그것)+ぞれ. 「각각·따로따로」' where deck_id=d_n1 and order_index=763;
  -- 764 どこ (손상 정정: どけち → どこ)
  update public.words set headword=NULL, reading='どこ', meaning='어디, 어느 곳', etymology='疑問代名詞 ど(의문)+こ(장소). 「장소를 묻는 말」', part_of_speech='대명사' where deck_id=d_n1 and order_index=764;
  -- 769 しよう (仕様/しょうがない 어원)
  update public.words set headword='仕様', reading='しよう', meaning='방법, 수단; (없음과 함께) 어쩔 도리', etymology='仕(섬길 사)+様(모양 양). 「하는 방식」→ 방법' where deck_id=d_n1 and order_index=769;
  -- 774 ビジネス (business)
  update public.words set etymology='영어 business(사업). 「업무·사업·비즈니스」' where deck_id=d_n1 and order_index=774;
  -- 775 コツ
  update public.words set etymology='骨(こつ, 뼈 골). 「핵심·뼈대」→ 요령·비결' where deck_id=d_n1 and order_index=775;
  -- 777 プラス (plus)
  update public.words set etymology='영어 plus(더하기). 「양·득·플러스」' where deck_id=d_n1 and order_index=777;
  -- 778 コスト (cost)
  update public.words set etymology='영어 cost(비용). 「원가·경비·코스트」' where deck_id=d_n1 and order_index=778;
  -- 780 オープン (open)
  update public.words set etymology='영어 open(열린)+な. 「개방적·공개적·오픈」' where deck_id=d_n1 and order_index=780;
  -- 785 スクリーン (screen)
  update public.words set etymology='영어 screen(스크린). 「영사막·화면」' where deck_id=d_n1 and order_index=785;
  -- 791 デザイン (design)
  update public.words set etymology='영어 design(디자인). 「의장·설계·도안」' where deck_id=d_n1 and order_index=791;
  -- 792 ストレス (stress)
  update public.words set etymology='영어 stress(스트레스). 「정신적·신체적 압박」' where deck_id=d_n1 and order_index=792;
  -- 801 チャンス (chance)
  update public.words set etymology='영어 chance(기회). 「기회·찬스」' where deck_id=d_n1 and order_index=801;
  -- 803 とても
  update public.words set etymology='副詞 とても. 「매우」(긍정)/「도저히」(부정 호응)' where deck_id=d_n1 and order_index=803;
end $$;


-- ============================================================
-- N1 유의어 페어 보강 패치 (PDF p.14~23 유의어 박스 + p.40·47·48·50·51 문법 ＝ 표시)
-- 누락 단어 145개 추가 (order 1439~1583) + word_relations 양방향 320건
-- ============================================================
-- ============================================================
-- N1 유의어 페어 누락 단어 Chunk 1 (40개, order 1439~1478)
-- PDF p.14~23 유의어 박스 전용 표현 (본문에는 없는 풀어 쓴 동의 표현 등)
-- ============================================================
do $$
declare
  d_n1 uuid;
  w   uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 1439. あいまいに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'あいまいに', '애매하게', '曖昧(애매)+に. 「뚜렷하지 않게」', '부사', 1439, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あいまいに答える。', '애매하게 대답한다.', 1),
    (w, '責任をあいまいにする。', '책임을 애매하게 한다.', 2);

  -- 1440. あきらめずに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'あきらめずに', '포기하지 않고', '諦(체)める+ず+に. 「포기하지 않은 채」 부사구', '부사', 1440, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'あきらめずに挑戦する。', '포기하지 않고 도전한다.', 1),
    (w, '最後まであきらめずに頑張る。', '끝까지 포기하지 않고 노력한다.', 2);

  -- 1441. いくつか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'いくつか', '몇 개쯤, 조금', '幾(이)+つ+か. 「몇 개 정도」', '부사', 1441, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問がいくつかある。', '질문이 몇 개 있다.', 1),
    (w, 'いくつかの方法を試した。', '몇 가지 방법을 시도했다.', 2);

  -- 1442. うれしい知らせ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'うれしい知らせ', 'うれしいしらせ', '기쁜 소식', '嬉(うれ)しい+知らせ. 「기쁘게 하는 통지」', '명사', 1442, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '合格のうれしい知らせが届いた。', '합격이라는 기쁜 소식이 도착했다.', 1),
    (w, '友人からうれしい知らせを聞いた。', '친구에게서 기쁜 소식을 들었다.', 2);

  -- 1443. おだやかな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'おだやかな', '온화한, 평온한', '穏(편안할 온)やか+な. 「조용하고 부드러운」', 'な형용사', 1443, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'おだやかな性格。', '온화한 성격.', 1),
    (w, 'おだやかな天気だ。', '평온한 날씨다.', 2);

  -- 1444. がっかりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'がっかりする', '낙담하다, 실망하다', '의태어 がっかり+する. 「기대가 무너져 풀이 죽다」', '동사', 1444, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結果を聞いてがっかりした。', '결과를 듣고 낙담했다.', 1),
    (w, '試合に負けてがっかりする。', '시합에 져서 실망한다.', 2);

  -- 1445. こっそり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'こっそり', '살짝, 몰래', '몰래 행동하는 모양의 의태어. 「살그머니」', '부사', 1445, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'こっそり部屋を出た。', '살짝 방을 나왔다.', 1),
    (w, 'こっそりプレゼントを置いた。', '몰래 선물을 두었다.', 2);

  -- 1446. これまでの
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'これまでの', '지금까지의', 'これ+まで+の. 「현재까지의」 연체수식', '연체·수식어', 1446, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'これまでの努力を無駄にしない。', '지금까지의 노력을 헛되게 하지 않는다.', 1),
    (w, 'これまでの経験を活かす。', '지금까지의 경험을 살린다.', 2);

  -- 1447. さわやかだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'さわやかだ', '상쾌하다, 산뜻하다', '爽(상쾌할 상)やか+だ. 「청량하고 시원함」', 'な형용사', 1447, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'さわやかな朝だ。', '상쾌한 아침이다.', 1),
    (w, '彼の笑顔はさわやかだ。', '그의 미소는 산뜻하다.', 2);

  -- 1448. しかたなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'しかたなく', '어쩔 수 없이', '仕方(しかた, 방법)+なく. 「방법이 없어」', '부사', 1448, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しかたなく承諾した。', '어쩔 수 없이 승낙했다.', 1),
    (w, '雨でしかたなく帰った。', '비 때문에 어쩔 수 없이 돌아왔다.', 2);

  -- 1449. しばらく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'しばらく', '잠시, 당분간', '暫(잠시 잠)く. 「짧지 않은 시간 동안」', '부사', 1449, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'しばらくお待ちください。', '잠시 기다려 주세요.', 1),
    (w, 'しばらく会っていない。', '한동안 만나지 않았다.', 2);

  -- 1450. じっくりと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'じっくりと', '정성껏, 곰곰이', '느긋이 시간을 들여 하는 의태어 じっくり+と. 「차분히」', '부사', 1450, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'じっくりと考える。', '곰곰이 생각한다.', 1),
    (w, 'じっくりと話を聞く。', '차분히 이야기를 듣는다.', 2);

  -- 1451. じっと見る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'じっと見る', 'じっとみる', '가만히 보다, 응시하다', '의태어 じっと+見る. 「움직이지 않고 보다」', '동사', 1451, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の目をじっと見る。', '그의 눈을 가만히 본다.', 1),
    (w, 'じっと見られて困った。', '가만히 보여서 곤란했다.', 2);

  -- 1452. じゃまする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'じゃまする', '방해하다, 훼방 놓다', '邪魔(じゃま)+する. 「방해 행위를 하다」', '동사', 1452, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '勉強をじゃまする。', '공부를 방해한다.', 1),
    (w, 'じゃましないでください。', '방해하지 마세요.', 2);

  -- 1453. すぐには
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'すぐには', '바로는, 당장에는', '直(곧 직)ぐ+に+は. 「당장에는 ~안 됨」 부정 호응', '부사', 1453, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すぐには答えられない。', '당장에는 답할 수 없다.', 1),
    (w, 'すぐには信じがたい。', '바로는 믿기 어렵다.', 2);

  -- 1454. すべて
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'すべて', '전부, 모두', '全(온전할 전)て. 「전부」 부사·명사', '부사', 1454, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'すべてを話した。', '전부를 이야기했다.', 1),
    (w, 'すべての人が賛成した。', '모든 사람이 찬성했다.', 2);

  -- 1455. だらしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'だらしない', '단정하지 못한, 절도가 없는', '의태어 だらだら(질질)+しい. 「야무지지 못한」', 'い형용사', 1455, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'だらしない格好。', '단정치 못한 모습.', 1),
    (w, '時間にだらしない人。', '시간 관념이 야무지지 못한 사람.', 2);

  -- 1456. つながり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'つながり', '연계, 관계, 연결', '繋(이을 계)がる의 명사형. 「이어진 관계」', '명사', 1456, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人とのつながりを大切にする。', '사람과의 관계를 소중히 한다.', 1),
    (w, '事件とのつながりを調べる。', '사건과의 연관을 조사한다.', 2);

  -- 1457. てきぱきと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'てきぱきと', '척척, 솜씨 좋게', '시원시원하고 능률적인 모양의 의태어 てきぱき+と', '부사', 1457, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'てきぱきと仕事を片付ける。', '척척 일을 처리한다.', 1),
    (w, '質問にてきぱきと答える。', '질문에 시원시원하게 답한다.', 2);

  -- 1458. できるだけ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'できるだけ', '가능한 한, 할 수 있는 한', '出来(でき)る+だけ. 「가능한 범위에서」', '부사', 1458, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できるだけ早く来てください。', '가능한 한 빨리 와 주세요.', 1),
    (w, 'できるだけの努力をする。', '할 수 있는 한 노력을 한다.', 2);

  -- 1459. できるだけ早く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'できるだけ早く', 'できるだけはやく', '가능한 한 빨리', 'できるだけ+早く. 「최대한 빠르게」', '부사', 1459, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'できるだけ早く連絡します。', '가능한 한 빨리 연락드립니다.', 1),
    (w, 'できるだけ早く帰宅した。', '가능한 한 빨리 귀가했다.', 2);

  -- 1460. とても驚く
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'とても驚く', 'とてもおどろく', '매우 놀라다', 'とても(매우)+驚(놀랄 경)く. 「깊이 놀라다」', '동사', 1460, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の話にとても驚いた。', '그의 이야기에 매우 놀랐다.', 1),
    (w, '突然の知らせにとても驚く。', '갑작스런 소식에 매우 놀란다.', 2);

  -- 1461. どうしようもない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'どうしようもない', '어쩔 방법이 없다, 도리가 없다', 'どう+しよう+も+ない. 「어떻게도 할 수 없다」', 'い형용사', 1461, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'もうどうしようもない状況だ。', '이제 어쩔 도리가 없는 상황이다.', 1),
    (w, '一人ではどうしようもない。', '혼자서는 어찌할 도리가 없다.', 2);

  -- 1462. どんよりした天気だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'どんよりした天気だ', 'どんよりしたてんきだ', '우중충한 날씨다', '의태어 どんより+した+天気+だ. 「잿빛 흐린 날씨」', 'な형용사', 1462, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今日はどんよりした天気だ。', '오늘은 우중충한 날씨다.', 1),
    (w, '雨が降りそうなどんよりした天気だ。', '비가 올 듯한 우중충한 날씨다.', 2);

  -- 1463. なかなか返事をしようとしない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'なかなか返事をしようとしない', 'なかなかへんじをしようとしない', '좀처럼 대답하려고 하지 않다', 'なかなか(좀처럼)+返事+を+する+ようとしない. 부정 의지', '동사', 1463, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '質問してもなかなか返事をしようとしない。', '질문해도 좀처럼 대답하려고 하지 않는다.', 1),
    (w, '彼はなかなか返事をしようとしない。', '그는 좀처럼 대답하려고 하지 않는다.', 2);

  -- 1464. なんとなく
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'なんとなく', '왠지 모르게, 어쩐지', '何(なに)+と+なく. 「딱히 이유 없이」', '부사', 1464, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'なんとなく不安だ。', '왠지 불안하다.', 1),
    (w, 'なんとなく彼が来そうだ。', '어쩐지 그가 올 것 같다.', 2);

  -- 1465. はっきり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'はっきり', '확실히, 분명히', '명확함을 나타내는 의태어. 「분명하게」', '부사', 1465, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'はっきり言ってください。', '분명히 말해 주세요.', 1),
    (w, 'はっきり覚えている。', '확실히 기억하고 있다.', 2);

  -- 1466. はっきりしている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'はっきりしている', '분명하다, 또렷하다', 'はっきり+している. 「뚜렷한 상태」', '동사', 1466, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '答えがはっきりしている。', '답이 분명하다.', 1),
    (w, '違いがはっきりしている。', '차이가 또렷하다.', 2);

  -- 1467. ほっとする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ほっとする', '안심하다, 한숨 돌리다', '의태어 ほっ+とする. 「긴장이 풀린 상태」', '동사', 1467, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無事の知らせにほっとした。', '무사하다는 소식에 안심했다.', 1),
    (w, '試験が終わってほっとする。', '시험이 끝나 한숨 돌린다.', 2);

  -- 1468. ぼんやりしている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ぼんやりしている', '분명하지 않다, 멍하다', 'ぼんやり(흐릿)+している. 「흐릿한 상태」', '동사', 1468, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '記憶がぼんやりしている。', '기억이 흐릿하다.', 1),
    (w, '彼は朝からぼんやりしている。', '그는 아침부터 멍하다.', 2);

  -- 1469. やせ衰える
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, 'やせ衰える', 'やせおとろえる', '야위어 쇠약해지다', '痩(やせ)+衰(쇠할 쇠)える. 「살이 빠지고 쇠약해지다」', '동사', 1469, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '病でやせ衰える。', '병으로 야위어 쇠약해지다.', 1),
    (w, '老人がやせ衰えていく。', '노인이 야위어 쇠약해져 간다.', 2);

  -- 1470. やはり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'やはり', '역시', '副詞 やはり(矢張り). 「예상대로·역시」', '부사', 1470, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'やはり彼が一番だ。', '역시 그가 최고다.', 1),
    (w, 'やはり来なかった。', '역시 안 왔다.', 2);

  -- 1471. ゆっくりする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ゆっくりする', '편하게 쉬다, 느긋이 보내다', 'ゆっくり(천천히)+する. 「느긋한 시간을 보내다」', '동사', 1471, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '休日は家でゆっくりする。', '휴일에는 집에서 편하게 쉰다.', 1),
    (w, '温泉でゆっくりした。', '온천에서 느긋이 보냈다.', 2);

  -- 1472. ろくに(～ない)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ろくに(～ない)', '제대로, 변변히(~않다)', '碌(녹록할 록)に. 부정 호응. 「제대로 ~안 하다」', '부사', 1472, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'ろくに眠れなかった。', '제대로 잠들지 못했다.', 1),
    (w, 'ろくに食事もしない。', '변변히 식사도 안 한다.', 2);

  -- 1473. わざと
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'わざと', '일부러, 고의로', '副詞 わざと. 「의도적으로」', '부사', 1473, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わざと負けた。', '일부러 졌다.', 1),
    (w, 'わざと無視する。', '고의로 무시한다.', 2);

  -- 1474. わずかに
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'わずかに', '아주 조금, 근소하게', '僅(겨우 근)か+に. 「아주 약간」', '부사', 1474, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'わずかに残っている。', '아주 조금 남아 있다.', 1),
    (w, 'わずかに動いた。', '근소하게 움직였다.', 2);

  -- 1475. アドバイス
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'アドバイス', '조언, 충고', '영어 advice. 「조언·충고」', '명사', 1475, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '先生のアドバイスを聞く。', '선생님의 조언을 듣는다.', 1),
    (w, '友達にアドバイスを求める。', '친구에게 충고를 구한다.', 2);

  -- 1476. シンプルだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'シンプルだ', '심플하다, 단순하다', '영어 simple+だ. 「단순·간결한」', 'な형용사', 1476, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'シンプルなデザイン。', '심플한 디자인.', 1),
    (w, '考え方がシンプルだ。', '사고방식이 단순하다.', 2);

  -- 1477. ヒント
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'ヒント', '힌트, 실마리', '영어 hint. 「단서·힌트」', '명사', 1477, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '答えのヒントをもらう。', '답의 힌트를 받는다.', 1),
    (w, 'ヒントを見つけた。', '힌트를 찾았다.', 2);

  -- 1478. プライド
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, NULL, 'プライド', '프라이드, 자존심', '영어 pride. 「자긍심·자존심」', '명사', 1478, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'プライドが高い。', '자존심이 강하다.', 1),
    (w, '仕事にプライドを持つ。', '일에 자긍심을 갖는다.', 2);

end $$;

-- ============================================================
-- N1 유의어 페어 누락 단어 Chunk 2 (50개, order 1479~1528)
-- ============================================================
do $$
declare
  d_n1 uuid;
  w   uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 1479. 一人一人に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一人一人に', 'ひとりひとりに', '한 사람 한 사람에게', '一人(한 사람)+一人(한 사람)+に. 「개개인 모두에게」', '부사', 1479, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '一人一人に手紙を書く。', '한 사람 한 사람에게 편지를 쓴다.', 1),
    (w, '一人一人に声をかけた。', '한 사람 한 사람에게 말을 걸었다.', 2);

  -- 1480. 一度に大勢来る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '一度に大勢来る', 'いちどにおおぜいくる', '한꺼번에 많이 몰려들다', '一度+に+大勢(많은 인원)+来る. 동시 다수 방문', '동사', 1480, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '客が一度に大勢来た。', '손님이 한꺼번에 많이 왔다.', 1),
    (w, 'バスから一度に大勢来る。', '버스에서 한꺼번에 많이 내려온다.', 2);

  -- 1481. 上品な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '上品な', 'じょうひんな', '고상한, 품위 있는', '上(상)+品(품)+な. 「격이 높은」', 'な형용사', 1481, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '上品な言葉遣い。', '품위 있는 말씨.', 1),
    (w, '上品な雰囲気の店。', '고상한 분위기의 가게.', 2);

  -- 1482. 不安なところ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '不安なところ', 'ふあんなところ', '불안한 점, 걱정되는 부분', '不安+な+ところ. 「불안한 부분」', '명사', 1482, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画に不安なところがある。', '계획에 불안한 점이 있다.', 1),
    (w, '不安なところを質問した。', '불안한 부분을 질문했다.', 2);

  -- 1483. 不注意な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '不注意な', 'ふちゅういな', '부주의한', '不(아닐 부)+注意(주의)+な. 「주의가 부족한」', 'な형용사', 1483, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '不注意なミス。', '부주의한 실수.', 1),
    (w, '不注意な運転は危険だ。', '부주의한 운전은 위험하다.', 2);

  -- 1484. 中止する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '中止する', 'ちゅうしする', '중지하다', '中(가운데 중)+止(그칠 지)+する. 「중간에 그치다」', '동사', 1484, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '雨で試合を中止する。', '비로 시합을 중지한다.', 1),
    (w, '計画を中止する。', '계획을 중지한다.', 2);

  -- 1485. 事前に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '事前に', 'じぜんに', '사전에, 미리', '事(일 사)+前(앞 전)+に. 「일이 일어나기 전에」', '부사', 1485, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '事前に連絡してください。', '사전에 연락해 주세요.', 1),
    (w, '事前に準備を整える。', '미리 준비를 갖춘다.', 2);

  -- 1486. 人込み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '人込み', 'ひとごみ', '혼잡, 북새통', '人(사람)+込(섞을 입)+み. 「사람으로 붐비는 곳」', '명사', 1486, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人込みを避ける。', '사람 많은 곳을 피한다.', 1),
    (w, '駅は人込みだった。', '역은 북새통이었다.', 2);

  -- 1487. 今までになく新しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '今までになく新しい', 'いままでになくあたらしい', '지금까지 없이 새로운', '今+まで+に+なく+新(새 신)しい. 「전례 없이 새롭다」', 'い형용사', 1487, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '今までになく新しい試みだ。', '지금까지 없이 새로운 시도다.', 1),
    (w, '今までになく新しい技術。', '지금까지 없이 새로운 기술.', 2);

  -- 1488. 仕組み
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '仕組み', 'しくみ', '구조, 짜임새', '仕(섬길 사)+組(짤 조)+み. 「짜여진 구조」', '명사', 1488, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '機械の仕組み。', '기계의 구조.', 1),
    (w, '社会の仕組みを学ぶ。', '사회의 짜임새를 배운다.', 2);

  -- 1489. 他と比べて特によい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '他と比べて特によい', 'ほかとくらべてとくによい', '다른 것과 비교하여 특히 좋다', '他(다른)+と+比べる+て+特+に+よい. 비교 우위', 'い형용사', 1489, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'このワインは他と比べて特によい。', '이 와인은 다른 것과 비교해 특히 좋다.', 1),
    (w, '彼の作品は他と比べて特によい。', '그의 작품은 다른 것보다 특히 좋다.', 2);

  -- 1490. 以前から
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '以前から', 'いぜんから', '이전부터', '以前(이전)+から. 「예전부터」', '부사', 1490, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '以前から知っていた。', '이전부터 알고 있었다.', 1),
    (w, '以前から興味があった。', '예전부터 흥미가 있었다.', 2);

  -- 1491. 何とか
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '何とか', 'なんとか', '그럭저럭, 어떻게든', '何(어찌 하)+とか. 「어떻게든 해결」', '부사', 1491, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何とか間に合った。', '그럭저럭 시간에 맞췄다.', 1),
    (w, '何とかしてみる。', '어떻게든 해 보겠다.', 2);

  -- 1492. 何度も
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '何度も', 'なんども', '몇 번이고, 여러 번', '何(어찌 하)+度(번 도)+も. 「반복적으로」', '부사', 1492, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '何度も読み返す。', '몇 번이고 다시 읽는다.', 1),
    (w, '何度も電話した。', '여러 번 전화했다.', 2);

  -- 1493. 余裕
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '余裕', 'よゆう', '여유', '余(남을 여)+裕(넉넉할 유). 「남는 여백·여유」', '명사', 1493, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間に余裕がある。', '시간에 여유가 있다.', 1),
    (w, '心の余裕を持つ。', '마음의 여유를 갖는다.', 2);

  -- 1494. 便利で役に立つ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '便利で役に立つ', 'べんりでやくにたつ', '편리해서 쓸모가 있다', '便利+で+役(역할)+に+立(설 립)つ. 「유용함」', '동사', 1494, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, 'この道具は便利で役に立つ。', '이 도구는 편리해서 쓸모 있다.', 1),
    (w, '小さくて便利で役に立つ。', '작고 편리해서 쓸모 있다.', 2);

  -- 1495. 出馬する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '出馬する', 'しゅつばする', '출마하다', '出(날 출)+馬(말 마)+する. 「말을 타고 나가다」→ 선거에 입후보', '동사', 1495, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '市長選に出馬する。', '시장 선거에 출마한다.', 1),
    (w, '次の選挙に出馬する予定だ。', '다음 선거에 출마할 예정이다.', 2);

  -- 1496. 分担
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '分担', 'ぶんたん', '분담', '分(나눌 분)+担(멜 담). 「나누어 짊어짐」', '명사', 1496, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事の分担を決める。', '일의 분담을 정한다.', 1),
    (w, '家事の分担をする。', '집안일을 분담한다.', 2);

  -- 1497. 分担する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '分担する', 'ぶんたんする', '분담하다', '分担+する. 「나누어 맡다」', '동사', 1497, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '責任を分担する。', '책임을 분담한다.', 1),
    (w, '費用を分担する。', '비용을 분담한다.', 2);

  -- 1498. 刺激を受ける
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '刺激を受ける', 'しげきをうける', '자극을 받다', '刺(찌를 자)+激(격할 격)+を+受ける. 「외부 자극으로 영향받음」', '동사', 1498, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼の作品に刺激を受けた。', '그의 작품에 자극을 받았다.', 1),
    (w, '新しい体験に刺激を受ける。', '새 경험에 자극을 받는다.', 2);

  -- 1499. 勘違いする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '勘違いする', 'かんちがいする', '착각하다, 잘못 알다', '勘(헤아릴 감)+違(어긋날 위)い+する. 「잘못 판단하다」', '동사', 1499, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '日付を勘違いした。', '날짜를 착각했다.', 1),
    (w, '人を勘違いしてしまった。', '사람을 잘못 알아봤다.', 2);

  -- 1500. 危険
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '危険', 'きけん', '위험', '危(위태할 위)+険(험할 험). 「위태롭고 험함」', '명사', 1500, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '危険を知らせる。', '위험을 알린다.', 1),
    (w, '危険な場所には行かない。', '위험한 곳에는 가지 않는다.', 2);

  -- 1501. 取り消す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '取り消す', 'とりけす', '취소하다', '取(취할 취)+消(꺼질 소)す. 「취하여 없애다」', '동사', 1501, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '予約を取り消す。', '예약을 취소한다.', 1),
    (w, '発言を取り消す。', '발언을 취소한다.', 2);

  -- 1502. 口数が少ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '口数が少ない', 'くちかずがすくない', '말수가 적다', '口(입)+数(수)+が+少ない. 「말 횟수가 적음」', 'い형용사', 1502, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は口数が少ない。', '그는 말수가 적다.', 1),
    (w, '口数が少ないが優しい。', '말수는 적지만 다정하다.', 2);

  -- 1503. 問い合わせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '問い合わせる', 'といあわせる', '문의하다, 조회하다', '問(물을 문)い+合わせる. 「물어보고 맞춰 확인하다」', '동사', 1503, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '会社に問い合わせる。', '회사에 문의한다.', 1),
    (w, '在庫を問い合わせる。', '재고를 조회한다.', 2);

  -- 1504. 困る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '困る', 'こまる', '곤란하다, 난처하다', '困(곤할 곤)る. 「대처가 어려움」', '동사', 1504, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '答えに困る。', '대답하기 곤란하다.', 1),
    (w, '雨で困った。', '비 때문에 난처했다.', 2);

  -- 1505. 基準
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '基準', 'きじゅん', '기준', '基(터 기)+準(준할 준). 「판단의 토대」', '명사', 1505, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '評価の基準を決める。', '평가 기준을 정한다.', 1),
    (w, '基準を満たす。', '기준을 충족한다.', 2);

  -- 1506. 場所
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '場所', 'ばしょ', '장소', '場(마당 장)+所(곳 소). 「특정 위치」', '명사', 1506, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '集合場所を決める。', '집합 장소를 정한다.', 1),
    (w, '静かな場所で勉強する。', '조용한 장소에서 공부한다.', 2);

  -- 1507. 大げさ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大げさ', 'おおげさ', '과장, 호들갑', '大(클 대)+げさ(접미사). 「실제보다 부풀림」', 'な형용사', 1507, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話が大げさだ。', '이야기가 과장되었다.', 1),
    (w, '大げさに驚く。', '호들갑스럽게 놀란다.', 2);

  -- 1508. 大して(～ない)
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大して(～ない)', 'たいして', '그다지, 별로(~않다)', '大(클 대)+して. 부정 호응. 「그다지 ~안」', '부사', 1508, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大して難しくない。', '그다지 어렵지 않다.', 1),
    (w, '大して気にしない。', '별로 신경 쓰지 않는다.', 2);

  -- 1509. 大体
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大体', 'だいたい', '대체로, 대강', '大(클 대)+体(몸 체). 「큰 줄기·전체적으로」', '부사', 1509, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '大体わかった。', '대체로 알았다.', 1),
    (w, '大体の見当をつける。', '대강의 짐작을 한다.', 2);

  -- 1510. 大体同じだ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大体同じだ', 'だいたいおなじだ', '대체로 같다', '大体+同(같을 동)じ+だ. 「거의 비슷함」', 'な형용사', 1510, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '二つは大体同じだ。', '두 개는 대체로 같다.', 1),
    (w, '実力は大体同じだ。', '실력은 대체로 같다.', 2);

  -- 1511. 大幅に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '大幅に', 'おおはばに', '대폭적으로, 크게', '大幅(큰 폭)+に. 「범위가 크게」', '부사', 1511, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '価格が大幅に下がる。', '가격이 대폭 내려간다.', 1),
    (w, '大幅に変更する。', '대폭 변경한다.', 2);

  -- 1512. 失敗する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '失敗する', 'しっぱいする', '실패하다, 실수하다', '失(잃을 실)+敗(패할 패)+する. 「뜻을 이루지 못하다」', '동사', 1512, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画が失敗する。', '계획이 실패한다.', 1),
    (w, '何度も失敗した。', '몇 번이고 실패했다.', 2);

  -- 1513. 完了する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '完了する', 'かんりょうする', '완료하다', '完(완전할 완)+了(마칠 료)+する. 「완전히 마치다」', '동사', 1513, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工事を完了する。', '공사를 완료한다.', 1),
    (w, '手続きが完了した。', '수속이 완료되었다.', 2);

  -- 1514. 完成する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '完成する', 'かんせいする', '완성되다, 완성하다', '完+成(이룰 성)+する. 「온전히 이루다」', '동사', 1514, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品が完成する。', '작품이 완성된다.', 1),
    (w, '建物が完成した。', '건물이 완성되었다.', 2);

  -- 1515. 対比
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '対比', 'たいひ', '대비', '対(대할 대)+比(견줄 비). 「맞대어 비교함」', '명사', 1515, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '色の対比が美しい。', '색의 대비가 아름답다.', 1),
    (w, '新旧の対比。', '신구의 대비.', 2);

  -- 1516. 専門家
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '専門家', 'せんもんか', '전문가', '専(오로지 전)+門(문 문)+家(전문가 가). 「특정 분야 전문가」', '명사', 1516, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '医療の専門家。', '의료 전문가.', 1),
    (w, '専門家に相談する。', '전문가에게 상담한다.', 2);

  -- 1517. 小さな
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '小さな', 'ちいさな', '작은, 사소한', '小(작을 소)さ+な. 「작은」 연체수식', '연체·수식어', 1517, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小さな家。', '작은 집.', 1),
    (w, '小さな問題だ。', '사소한 문제다.', 2);

  -- 1518. 小さな声で言う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '小さな声で言う', 'ちいさなこえでいう', '작은 소리로 말하다', '小さな+声+で+言う. 「낮은 음성으로」', '동사', 1518, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '秘密を小さな声で言う。', '비밀을 작은 소리로 말한다.', 1),
    (w, '小さな声で言って聞き取れない。', '작은 소리로 말해서 들리지 않는다.', 2);

  -- 1519. 小型の
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '小型の', 'こがたの', '소형의', '小+型(거푸집 형)+の. 「작은 형태의」', '연체·수식어', 1519, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '小型のカメラ。', '소형 카메라.', 1),
    (w, '小型の車を運転する。', '소형 차를 운전한다.', 2);

  -- 1520. 少ない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '少ない', 'すくない', '적다, 드물다', '少(적을 소)ない. 「양이 적음」', 'い형용사', 1520, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '人が少ない。', '사람이 적다.', 1),
    (w, 'お金が少ない。', '돈이 적다.', 2);

  -- 1521. 差がない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '差がない', 'さがない', '차이가 없다', '差(차이)+が+ない. 「격차가 없음」', 'い형용사', 1521, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '実力に差がない。', '실력에 차이가 없다.', 1),
    (w, '値段に大差がない。', '가격에 큰 차이가 없다.', 2);

  -- 1522. 平凡だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '平凡だ', 'へいぼんだ', '평범하다', '平(평평할 평)+凡(무릇 범)+だ. 「특별하지 않음」', 'な형용사', 1522, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平凡な人生だ。', '평범한 인생이다.', 1),
    (w, '彼は平凡だが誠実だ。', '그는 평범하지만 성실하다.', 2);

  -- 1523. 平凡な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '平凡な', 'へいぼんな', '평범한', '平凡+な. 「특별하지 않은」', 'な형용사', 1523, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '平凡な毎日。', '평범한 매일.', 1),
    (w, '平凡な見た目。', '평범한 외모.', 2);

  -- 1524. 心配
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '心配', 'しんぱい', '걱정, 근심', '心(마음 심)+配(나눌 배). 「마음을 쓰다」', '명사', 1524, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '健康が心配だ。', '건강이 걱정이다.', 1),
    (w, '心配をかけて申し訳ない。', '걱정 끼쳐 죄송합니다.', 2);

  -- 1525. 心配する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '心配する', 'しんぱいする', '걱정하다', '心配+する. 「마음을 쓰며 걱정함」', '동사', 1525, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来を心配する。', '장래를 걱정한다.', 1),
    (w, '親が子を心配する。', '부모가 자식을 걱정한다.', 2);

  -- 1526. 必死に頑張る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '必死に頑張る', 'ひっしにがんばる', '필사적으로 분발하다', '必死(필사)+に+頑張(굳셀 완)る. 「죽기 살기로 노력하다」', '동사', 1526, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '試験のために必死に頑張る。', '시험을 위해 필사적으로 분발한다.', 1),
    (w, '夢に向かって必死に頑張った。', '꿈을 향해 필사적으로 분발했다.', 2);

  -- 1527. 怒ったような顔をする
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '怒ったような顔をする', 'おこったようなかおをする', '화가 난 듯한 얼굴을 하다', '怒(노할 노)る+た+ような+顔+を+する. 표정 표현', '동사', 1527, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '彼は怒ったような顔をして黙っていた。', '그는 화난 듯한 얼굴로 잠자코 있었다.', 1),
    (w, '理由もなく怒ったような顔をする。', '이유 없이 화난 듯한 얼굴을 한다.', 2);

  -- 1528. 怖がる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '怖がる', 'こわがる', '무서워하다', '怖(두려울 포)い+がる. 「두려움을 보이다」', '동사', 1528, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '犬を怖がる。', '개를 무서워한다.', 1),
    (w, '暗闇を怖がる子供。', '어둠을 무서워하는 아이.', 2);

end $$;

-- ============================================================
-- N1 유의어 페어 누락 단어 Chunk 3 (55개, order 1529~1583)
-- ============================================================
do $$
declare
  d_n1 uuid;
  w   uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- 1529. 思いがけない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思いがけない', 'おもいがけない', '뜻밖이다, 예상 밖이다', '思い+掛(걸 괘)け+ない. 「예상도 못한」', 'い형용사', 1529, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '思いがけない出来事。', '뜻밖의 일.', 1),
    (w, '思いがけない再会。', '예상 밖의 재회.', 2);

  -- 1530. 思い返す
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '思い返す', 'おもいかえす', '돌이켜 생각하다, 회상하다', '思い+返(돌이킬 반)す. 「생각을 되돌리다」', '동사', 1530, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '昔のことを思い返す。', '옛일을 돌이켜 생각한다.', 1),
    (w, '思い返してみると、間違っていた。', '돌이켜 보면 잘못되었다.', 2);

  -- 1531. 急がせる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '急がせる', 'いそがせる', '서두르게 하다, 재촉하다', '急(급할 급)ぐ의 사역형. 「급히 행하게 하다」', '동사', 1531, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結論を急がせる。', '결론을 재촉한다.', 1),
    (w, '出発を急がせた。', '출발을 서두르게 했다.', 2);

  -- 1532. 怪しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '怪しい', 'あやしい', '수상하다, 의심스럽다', '怪(괴이할 괴)しい. 「이상하고 의심스러움」', 'い형용사', 1532, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '怪しい人を見かけた。', '수상한 사람을 봤다.', 1),
    (w, '彼の話は怪しい。', '그의 이야기는 의심스럽다.', 2);

  -- 1533. 悪く言われる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '悪く言われる', 'わるくいわれる', '나쁜 말을 듣다, 험담을 듣다', '悪く+言う의 수동. 「부정적으로 평가받다」', '동사', 1533, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '陰で悪く言われる。', '뒤에서 험담을 듣는다.', 1),
    (w, '彼が悪く言われるのは心外だ。', '그가 험담받는 것은 의외다.', 2);

  -- 1534. 想像
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '想像', 'そうぞう', '상상', '想(생각 상)+像(모양 상). 「머릿속에 그림」', '명사', 1534, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '想像を超える。', '상상을 초월한다.', 1),
    (w, '想像力豊かな子。', '상상력 풍부한 아이.', 2);

  -- 1535. 意外につまらない
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '意外につまらない', 'いがいにつまらない', '의외로 시시하다', '意外+に+つまらない. 「예상 외로 재미없음」', 'い형용사', 1535, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '評判の映画が意外につまらない。', '평이 좋은 영화가 의외로 시시하다.', 1),
    (w, 'パーティーは意外につまらなかった。', '파티는 의외로 시시했다.', 2);

  -- 1536. 意欲
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '意欲', 'いよく', '의욕', '意(뜻 의)+欲(욕심 욕). 「하고자 하는 의지」', '명사', 1536, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事への意欲が高い。', '일에 대한 의욕이 높다.', 1),
    (w, '学ぶ意欲を失う。', '배우려는 의욕을 잃는다.', 2);

  -- 1537. 愚痴を言う
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '愚痴を言う', 'ぐちをいう', '불평하다, 푸념하다', '愚(어리석을 우)+痴(어리석을 치)+を+言う. 「푸념을 늘어놓다」', '동사', 1537, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事の愚痴を言う。', '일에 대한 푸념을 한다.', 1),
    (w, 'いつも愚痴を言ってばかりだ。', '늘 푸념만 한다.', 2);

  -- 1538. 慌てる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '慌てる', 'あわてる', '당황하다, 허둥지둥하다', '慌(어리둥절할 황)てる. 「마음이 다급해짐」', '동사', 1538, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '時間に遅れて慌てる。', '시간에 늦어 당황한다.', 1),
    (w, '慌てて家を出た。', '허둥지둥 집을 나왔다.', 2);

  -- 1539. 慣れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '慣れる', 'なれる', '익숙해지다', '慣(익숙할 관)れる. 「반복으로 친숙해짐」', '동사', 1539, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事に慣れる。', '일에 익숙해진다.', 1),
    (w, '生活に慣れてきた。', '생활에 익숙해졌다.', 2);

  -- 1540. 手分け
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '手分け', 'てわけ', '분담, 나눔', '手(손)+分(나눌 분)け. 「손을 나누어 일함」', '명사', 1540, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手分けして探す。', '분담해서 찾는다.', 1),
    (w, '仕事の手分けを決める。', '일의 분담을 정한다.', 2);

  -- 1541. 批判
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '批判', 'ひはん', '비판', '批(비평할 비)+判(판단할 판). 「판단해 비평함」', '명사', 1541, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '批判を浴びる。', '비판을 받는다.', 1),
    (w, '彼は批判に強い。', '그는 비판에 강하다.', 2);

  -- 1542. 撤回する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '撤回する', 'てっかいする', '철회하다', '撤(거둘 철)+回(돌 회)+する. 「(말·결정을) 거두어 들임」', '동사', 1542, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '発言を撤回する。', '발언을 철회한다.', 1),
    (w, '決定を撤回した。', '결정을 철회했다.', 2);

  -- 1543. 支援
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '支援', 'しえん', '지원', '支(가지 지)+援(도울 원). 「뒤에서 도와줌」', '명사', 1543, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '経済的な支援。', '경제적 지원.', 1),
    (w, '友人の支援を受ける。', '친구의 지원을 받는다.', 2);

  -- 1544. 方法
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '方法', 'ほうほう', '방법', '方(모 방)+法(법 법). 「일을 하는 방식」', '명사', 1544, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '解決の方法を考える。', '해결 방법을 생각한다.', 1),
    (w, '別の方法を試す。', '다른 방법을 시도한다.', 2);

  -- 1545. 早く正確に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '早く正確に', 'はやくせいかくに', '빠르고 정확하게', '早く+正確+に. 「신속·정밀하게」', '부사', 1545, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '早く正確に作業する。', '빠르고 정확하게 작업한다.', 1),
    (w, '早く正確に処理してください。', '빠르고 정확하게 처리해 주세요.', 2);

  -- 1546. 明白に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '明白に', 'めいはくに', '명백하게', '明(밝을 명)+白(흰 백)+に. 「분명하고 환하게」', '부사', 1546, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '明白に間違っている。', '명백히 잘못되었다.', 1),
    (w, '事実が明白に示された。', '사실이 명백하게 드러났다.', 2);

  -- 1547. 曇っていて暗い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '曇っていて暗い', 'くもっていてくらい', '흐리고 어둡다', '曇(흐릴 담)る+て+暗(어두울 암)い. 「잿빛으로 어두움」', 'い형용사', 1547, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '空が曇っていて暗い。', '하늘이 흐리고 어둡다.', 1),
    (w, '曇っていて暗い朝だ。', '흐리고 어두운 아침이다.', 2);

  -- 1548. 検討
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '検討', 'けんとう', '검토', '検(검사할 검)+討(칠 토). 「세밀히 살펴봄」', '명사', 1548, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '計画を検討する。', '계획을 검토한다.', 1),
    (w, '前向きに検討する。', '긍정적으로 검토한다.', 2);

  -- 1549. 気掛かり
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '気掛かり', 'きがかり', '걱정, 근심', '気(기운 기)+掛(걸 괘)+かり. 「마음에 걸리는 일」', '명사', 1549, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '子供のことが気掛かりだ。', '아이의 일이 걱정된다.', 1),
    (w, '気掛かりがあって眠れない。', '근심이 있어서 잠들지 못한다.', 2);

  -- 1550. 混乱する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '混乱する', 'こんらんする', '혼란스럽다', '混(섞일 혼)+乱(어지러울 란)+する. 「뒤섞여 어지러움」', '동사', 1550, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頭が混乱する。', '머리가 혼란스럽다.', 1),
    (w, '会場が混乱した。', '회장이 혼란스러웠다.', 2);

  -- 1551. 漠然としている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '漠然としている', 'ばくぜんとしている', '막연하다', '漠(아득할 막)+然+と+している. 「뚜렷하지 않은 상태」', '동사', 1551, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '将来の夢が漠然としている。', '장래의 꿈이 막연하다.', 1),
    (w, '計画は漠然としている。', '계획은 막연하다.', 2);

  -- 1552. 無邪気な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '無邪気な', 'むじゃきな', '천진난만한, 악의 없는', '無(없을 무)+邪気(악의)+な. 「악한 마음이 없는」', 'な형용사', 1552, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '無邪気な笑顔。', '천진난만한 미소.', 1),
    (w, '子供は無邪気だ。', '아이는 악의가 없다.', 2);

  -- 1553. 熱心に取り組む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '熱心に取り組む', 'ねっしんにとりくむ', '열심히 몰두하다', '熱心+に+取り組(짤 조)む. 「열정적으로 매달리다」', '동사', 1553, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '研究に熱心に取り組む。', '연구에 열심히 몰두한다.', 1),
    (w, '問題に熱心に取り組んだ。', '문제에 열심히 매달렸다.', 2);

  -- 1554. 率直に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '率直に', 'そっちょくに', '솔직하게', '率(거느릴 솔)+直(곧을 직)+に. 「있는 그대로」', '부사', 1554, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '率直に意見を述べる。', '솔직하게 의견을 말한다.', 1),
    (w, '率直に謝った。', '솔직하게 사과했다.', 2);

  -- 1555. 珍しい
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '珍しい', 'めずらしい', '드물다, 흔히 없다', '珍(보배 진)しい. 「귀하고 드문」', 'い형용사', 1555, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '珍しい花が咲いた。', '진귀한 꽃이 피었다.', 1),
    (w, '珍しいお客様だ。', '드문 손님이다.', 2);

  -- 1556. 用意する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '用意する', 'よういする', '준비하다', '用(쓸 용)+意(뜻 의)+する. 「쓸 것을 미리 준비」', '동사', 1556, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夕食を用意する。', '저녁 식사를 준비한다.', 1),
    (w, '会議の資料を用意する。', '회의 자료를 준비한다.', 2);

  -- 1557. 疲れる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '疲れる', 'つかれる', '피곤하다, 지치다', '疲(피곤할 피)れる. 「힘이 다하다」', '동사', 1557, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '仕事で疲れる。', '일로 피곤하다.', 1),
    (w, '今日はとても疲れた。', '오늘은 매우 지쳤다.', 2);

  -- 1558. 皮肉
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '皮肉', 'ひにく', '비꼼, 빈정거림', '皮(가죽 피)+肉(고기 육). 「겉만 닿고 본질을 찌름」→ 비꼼', '명사', 1558, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '皮肉を言う。', '비꼬는 말을 한다.', 1),
    (w, '皮肉な結果。', '아이러니한 결과.', 2);

  -- 1559. 相手
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '相手', 'あいて', '상대', '相(서로 상)+手(손 수). 「마주하는 사람」', '명사', 1559, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '話す相手がいない。', '말할 상대가 없다.', 1),
    (w, '試合の相手が決まった。', '시합 상대가 정해졌다.', 2);

  -- 1560. 短い
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '短い', 'みじかい', '짧다', '短(짧을 단)い. 「길지 않은」', 'い형용사', 1560, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '短い時間。', '짧은 시간.', 1),
    (w, '髪を短くする。', '머리를 짧게 한다.', 2);

  -- 1561. 突然
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '突然', 'とつぜん', '돌연, 갑자기', '突(부딪칠 돌)+然. 「예고 없이」', '부사', 1561, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '突然雨が降ってきた。', '갑자기 비가 내렸다.', 1),
    (w, '突然の訪問。', '돌연한 방문.', 2);

  -- 1562. 競争する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '競争する', 'きょうそうする', '경쟁하다', '競(다툴 경)+争(다툴 쟁)+する. 「겨루다」', '동사', 1562, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '互いに競争する。', '서로 경쟁한다.', 1),
    (w, '企業が競争する市場。', '기업이 경쟁하는 시장.', 2);

  -- 1563. 細かく丁寧に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '細かく丁寧に', 'こまかくていねいに', '섬세하고 정성껏', '細(가늘 세)かく+丁寧(정녕)+に. 「세밀하고 공손하게」', '부사', 1563, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '細かく丁寧に説明する。', '섬세하고 정성껏 설명한다.', 1),
    (w, '細かく丁寧に作業する。', '꼼꼼하게 작업한다.', 2);

  -- 1564. 肝心な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '肝心な', 'かんじんな', '가장 중요한', '肝(간 간)+心(마음 심)+な. 「간과 심장처럼 핵심적인」', 'な형용사', 1564, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肝心なところを見落とす。', '가장 중요한 부분을 놓친다.', 1),
    (w, '肝心な質問をする。', '핵심적인 질문을 한다.', 2);

  -- 1565. 自然に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '自然に', 'しぜんに', '자연히, 저절로', '自(스스로 자)+然+に. 「있는 그대로」', '부사', 1565, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自然に笑顔になる。', '자연히 미소가 나온다.', 1),
    (w, '時間が経てば自然に治る。', '시간이 지나면 저절로 낫는다.', 2);

  -- 1566. 自由な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '自由な', 'じゆうな', '자유로운', '自由+な. 「구속이 없는」', 'な형용사', 1566, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '自由な発想。', '자유로운 발상.', 1),
    (w, '自由な時間を楽しむ。', '자유로운 시간을 즐긴다.', 2);

  -- 1567. 薄く切る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '薄く切る', 'うすくきる', '얇게 자르다', '薄(엷을 박)く+切る. 「두께를 얇게 분리」', '동사', 1567, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '肉を薄く切る。', '고기를 얇게 자른다.', 1),
    (w, 'パンを薄く切ってください。', '빵을 얇게 잘라 주세요.', 2);

  -- 1568. 言い訳する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '言い訳する', 'いいわけする', '변명하다', '言い+訳(가릴 역)+する. 「변명을 늘어놓다」', '동사', 1568, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '失敗を言い訳する。', '실패를 변명한다.', 1),
    (w, '言い訳ばかりするな。', '변명만 하지 마.', 2);

  -- 1569. 計画する
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '計画する', 'けいかくする', '계획하다', '計(셀 계)+画(그을 획)+する. 「미리 짜다」', '동사', 1569, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '旅行を計画する。', '여행을 계획한다.', 1),
    (w, '将来を計画する。', '장래를 계획한다.', 2);

  -- 1570. 詳しく丁寧に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '詳しく丁寧に', 'くわしくていねいに', '자세하고 꼼꼼하게', '詳(자세할 상)しく+丁寧+に. 「상세하고 공손히」', '부사', 1570, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳しく丁寧に教えてくれた。', '자세하고 꼼꼼하게 가르쳐 주었다.', 1),
    (w, '詳しく丁寧に説明する。', '상세하고 정중하게 설명한다.', 2);

  -- 1571. 詳細に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '詳細に', 'しょうさいに', '상세하게', '詳細(상세)+に. 「자세히 빠짐없이」', '부사', 1571, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '詳細に報告する。', '상세하게 보고한다.', 1),
    (w, '詳細に調査した。', '상세하게 조사했다.', 2);

  -- 1572. 諦める
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '諦める', 'あきらめる', '포기하다, 단념하다', '諦(살필 체)める. 「결의를 접다」', '동사', 1572, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '夢を諦める。', '꿈을 포기한다.', 1),
    (w, '諦めないで頑張ろう。', '포기하지 말고 노력하자.', 2);

  -- 1573. 謝る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '謝る', 'あやまる', '사과하다', '謝(사례할 사)る. 「잘못을 인정해 빌다」', '동사', 1573, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '心から謝る。', '진심으로 사과한다.', 1),
    (w, '友達に謝った。', '친구에게 사과했다.', 2);

  -- 1574. 返事をしぶっている
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '返事をしぶっている', 'へんじをしぶっている', '대답을 꺼리다, 주저하다', '返事+を+渋(껄끄러울 삽)る+ている. 「답을 망설임」', '동사', 1574, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '結婚の話に返事をしぶっている。', '결혼 이야기에 대답을 꺼리고 있다.', 1),
    (w, '転職の打診に返事をしぶっている。', '이직 제안에 대답을 주저하고 있다.', 2);

  -- 1575. 遅くなる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '遅くなる', 'おそくなる', '늦어지다', '遅(늦을 지)く+なる. 「시간이 늦은 상태가 됨」', '동사', 1575, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '到着が遅くなる。', '도착이 늦어진다.', 1),
    (w, '帰りが遅くなった。', '귀가가 늦어졌다.', 2);

  -- 1576. 選挙に出る
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '選挙に出る', 'せんきょにでる', '선거에 나가다, 출마하다', '選挙+に+出る. 「선거 후보로 등장」', '동사', 1576, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '市議会選挙に出る。', '시의회 선거에 나간다.', 1),
    (w, '彼は選挙に出ることを決めた。', '그는 선거에 출마하기로 결정했다.', 2);

  -- 1577. 重要な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '重要な', 'じゅうような', '중요한', '重(무거울 중)+要(중요할 요)+な. 「비중이 큰」', 'な형용사', 1577, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '重要な会議。', '중요한 회의.', 1),
    (w, '重要な情報を得る。', '중요한 정보를 얻는다.', 2);

  -- 1578. 非常に
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '非常に', 'ひじょうに', '매우, 몹시', '非(아닐 비)+常(항상 상)+に. 「평소와 다르게」→ 매우', '부사', 1578, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '非常に重要だ。', '매우 중요하다.', 1),
    (w, '非常に喜ぶ。', '몹시 기뻐한다.', 2);

  -- 1579. 非常に素晴らしいとほめる
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '非常に素晴らしいとほめる', 'ひじょうにすばらしいとほめる', '매우 훌륭하다고 칭찬하다', '非常+に+素晴らしい+と+褒める. 강한 칭찬', '동사', 1579, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '作品を非常に素晴らしいとほめる。', '작품을 매우 훌륭하다고 칭찬한다.', 1),
    (w, '先生が彼を非常に素晴らしいとほめた。', '선생님이 그를 매우 훌륭하다고 칭찬했다.', 2);

  -- 1580. 面倒だ
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '面倒だ', 'めんどうだ', '귀찮다, 성가시다', '面(낯 면)+倒(넘어질 도)+だ. 「체면이 무너질 정도로 번거로움」', 'な형용사', 1580, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '手続きが面倒だ。', '수속이 귀찮다.', 1),
    (w, '面倒な仕事だ。', '성가신 일이다.', 2);

  -- 1581. 面倒な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '面倒な', 'めんどうな', '귀찮은, 성가신', '面倒+な. 연체수식형', 'な형용사', 1581, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '面倒な手続き。', '귀찮은 절차.', 1),
    (w, '面倒な相手。', '성가신 상대.', 2);

  -- 1582. 順調に進む
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '順調に進む', 'じゅんちょうにすすむ', '순조롭게 진행되다', '順(순할 순)調+に+進む. 「막힘없이 나아감」', '동사', 1582, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '工事が順調に進む。', '공사가 순조롭게 진행된다.', 1),
    (w, '計画が順調に進んでいる。', '계획이 순조롭게 진행되고 있다.', 2);

  -- 1583. 頑固な
  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index, tags) values
    (d_n1, '頑固な', 'がんこな', '완고한, 고집스러운', '頑(완고할 완)+固(굳을 고)+な. 「쉽게 굽히지 않는」', 'な형용사', 1583, array['synonym_pair']::text[]) returning id into w;
  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) values
    (w, '頑固な性格。', '완고한 성격.', 1),
    (w, '頑固な汚れが落ちない。', '잘 안 빠지는 얼룩.', 2);

end $$;

-- ============================================================
-- N1 유의어 word_relations 양방향 등록
-- 어휘 154쌍 (PDF p.14~23 유의어 박스) + 문법 6쌍 (PDF p.40·47·48·50·51 ＝ 표시)
-- ============================================================
do $$
declare
  d_n1 uuid;
  w1 uuid; w2 uuid;
begin
  select id into d_n1 from public.decks where jlpt_level='N1' and is_official limit 1;

  -- ==== 어휘 유의어 페어 (PDF 박스) ====
  -- 1. いやみ ⇔ 皮肉
  select id into w1 from public.words where deck_id=d_n1 and (headword='いやみ' or reading='いやみ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='皮肉' or reading='皮肉') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'いやみ(불쾌한 언행)≒皮肉(비꼼, 빈정거림)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '皮肉(비꼼, 빈정거림)≒いやみ(불쾌한 언행)', 1) on conflict do nothing;
  end if;
  -- 2. どんよりした天気だ ⇔ 曇っていて暗い
  select id into w1 from public.words where deck_id=d_n1 and (headword='どんよりした天気だ' or reading='どんよりした天気だ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='曇っていて暗い' or reading='曇っていて暗い') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'どんよりした天気だ(우중충한 날씨다)≒曇っていて暗い(흐리고 어둡다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '曇っていて暗い(흐리고 어둡다)≒どんよりした天気だ(우중충한 날씨다)', 1) on conflict do nothing;
  end if;
  -- 3. 丹念に ⇔ じっくりと
  select id into w1 from public.words where deck_id=d_n1 and (headword='丹念に' or reading='丹念に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='じっくりと' or reading='じっくりと') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '丹念に(정성껏, 꼼꼼하게)≒じっくりと(정성껏, 곰곰이)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'じっくりと(정성껏, 곰곰이)≒丹念に(정성껏, 꼼꼼하게)', 1) on conflict do nothing;
  end if;
  -- 4. あっけない ⇔ 意外につまらない
  select id into w1 from public.words where deck_id=d_n1 and (headword='あっけない' or reading='あっけない') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='意外につまらない' or reading='意外につまらない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'あっけない(어이없다)≒意外につまらない(의외로 시시하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '意外につまらない(의외로 시시하다)≒あっけない(어이없다)', 1) on conflict do nothing;
  end if;
  -- 5. ありきたりの ⇔ 平凡な
  select id into w1 from public.words where deck_id=d_n1 and (headword='ありきたりの' or reading='ありきたりの') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='平凡な' or reading='平凡な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ありきたりの(흔한)≒平凡な(평범한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '平凡な(평범한)≒ありきたりの(흔한)', 1) on conflict do nothing;
  end if;
  -- 6. なじむ ⇔ 慣れる
  select id into w1 from public.words where deck_id=d_n1 and (headword='なじむ' or reading='なじむ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='慣れる' or reading='慣れる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'なじむ(친숙해지다, 정들다)≒慣れる(익숙해지다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '慣れる(익숙해지다)≒なじむ(친숙해지다, 정들다)', 1) on conflict do nothing;
  end if;
  -- 7. はかどる ⇔ 順調に進む
  select id into w1 from public.words where deck_id=d_n1 and (headword='はかどる' or reading='はかどる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='順調に進む' or reading='順調に進む') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'はかどる(진척되다)≒順調に進む(순조롭게 진행되다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '順調に進む(순조롭게 진행되다)≒はかどる(진척되다)', 1) on conflict do nothing;
  end if;
  -- 8. まばらだ ⇔ 少ない
  select id into w1 from public.words where deck_id=d_n1 and (headword='まばらだ' or reading='まばらだ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='少ない' or reading='少ない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'まばらだ(드문드문 있다, 듬성듬성하다)≒少ない(적다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '少ない(적다)≒まばらだ(드문드문 있다, 듬성듬성하다)', 1) on conflict do nothing;
  end if;
  -- 9. やむをえず ⇔ しかたなく
  select id into w1 from public.words where deck_id=d_n1 and (headword='やむをえず' or reading='やむをえず') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='しかたなく' or reading='しかたなく') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'やむをえず(어쩔 수 없이)≒しかたなく(어쩔 수 없이)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'しかたなく(어쩔 수 없이)≒やむをえず(어쩔 수 없이)', 1) on conflict do nothing;
  end if;
  -- 10. わずらわしい ⇔ 面倒だ
  select id into w1 from public.words where deck_id=d_n1 and (headword='わずらわしい' or reading='わずらわしい') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='面倒だ' or reading='面倒だ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'わずらわしい(성가시다, 번거롭다)≒面倒だ(귀찮다, 성가시다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '面倒だ(귀찮다, 성가시다)≒わずらわしい(성가시다, 번거롭다)', 1) on conflict do nothing;
  end if;
  -- 11. コントラスト ⇔ 対比
  select id into w1 from public.words where deck_id=d_n1 and (headword='コントラスト' or reading='コントラスト') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='対比' or reading='対比') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'コントラスト(콘트라스트, 대조, 대비)≒対比(대비)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '対比(대비)≒コントラスト(콘트라스트, 대조, 대비)', 1) on conflict do nothing;
  end if;
  -- 12. シビアな ⇔ 厳しい
  select id into w1 from public.words where deck_id=d_n1 and (headword='シビアな' or reading='シビアな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='厳しい' or reading='厳しい') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'シビアな(엄격한, 어려운)≒厳しい(엄격하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '厳しい(엄격하다)≒シビアな(엄격한, 어려운)', 1) on conflict do nothing;
  end if;
  -- 13. ルーズな ⇔ だらしない
  select id into w1 from public.words where deck_id=d_n1 and (headword='ルーズな' or reading='ルーズな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='だらしない' or reading='だらしない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ルーズな(느슨한, 단정치 못한)≒だらしない(단정하지 못한, 절도가 없는)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'だらしない(단정하지 못한, 절도가 없는)≒ルーズな(느슨한, 단정치 못한)', 1) on conflict do nothing;
  end if;
  -- 14. 張り合う ⇔ 競争する
  select id into w1 from public.words where deck_id=d_n1 and (headword='張り合う' or reading='張り合う') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='競争する' or reading='競争する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '張り合う(겨루다, 경쟁하다)≒競争する(경쟁하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '競争する(경쟁하다)≒張り合う(겨루다, 경쟁하다)', 1) on conflict do nothing;
  end if;
  -- 15. 朗報 ⇔ うれしい知らせ
  select id into w1 from public.words where deck_id=d_n1 and (headword='朗報' or reading='朗報') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='うれしい知らせ' or reading='うれしい知らせ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '朗報(낭보, 희소식)≒うれしい知らせ(기쁜 소식)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'うれしい知らせ(기쁜 소식)≒朗報(낭보, 희소식)', 1) on conflict do nothing;
  end if;
  -- 16. 極力 ⇔ できる限り
  select id into w1 from public.words where deck_id=d_n1 and (headword='極力' or reading='極力') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='できる限り' or reading='できる限り') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '極力(극력, 힘껏)≒できる限り(가능한 한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'できる限り(가능한 한)≒極力(극력, 힘껏)', 1) on conflict do nothing;
  end if;
  -- 17. 画期的な ⇔ 今までになく新しい
  select id into w1 from public.words where deck_id=d_n1 and (headword='画期的な' or reading='画期的な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='今までになく新しい' or reading='今までになく新しい') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '画期的な(획기적인)≒今までになく新しい(지금까지 없이 새로운)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '今までになく新しい(지금까지 없이 새로운)≒画期的な(획기적인)', 1) on conflict do nothing;
  end if;
  -- 18. 見合わせる ⇔ 中止する
  select id into w1 from public.words where deck_id=d_n1 and (headword='見合わせる' or reading='見合わせる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='中止する' or reading='中止する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '見合わせる(보류하다)≒中止する(중지하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '中止する(중지하다)≒見合わせる(보류하다)', 1) on conflict do nothing;
  end if;
  -- 19. 重宝する ⇔ 便利で役に立つ
  select id into w1 from public.words where deck_id=d_n1 and (headword='重宝する' or reading='重宝する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='便利で役に立つ' or reading='便利で役に立つ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '重宝する(애용하다)≒便利で役に立つ(편리해서 쓸모가 있다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '便利で役に立つ(편리해서 쓸모가 있다)≒重宝する(애용하다)', 1) on conflict do nothing;
  end if;
  -- 20. あらかじめ ⇔ 事前に
  select id into w1 from public.words where deck_id=d_n1 and (headword='あらかじめ' or reading='あらかじめ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='事前に' or reading='事前に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'あらかじめ(미리)≒事前に(사전에)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '事前に(사전에)≒あらかじめ(미리)', 1) on conflict do nothing;
  end if;
  -- 21. おっくうだ ⇔ 面倒だ
  select id into w1 from public.words where deck_id=d_n1 and (headword='おっくうだ' or reading='おっくうだ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='面倒だ' or reading='面倒だ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'おっくうだ(귀찮다)≒面倒だ(귀찮다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '面倒だ(귀찮다)≒おっくうだ(귀찮다)', 1) on conflict do nothing;
  end if;
  -- 22. おのずと ⇔ 自然に
  select id into w1 from public.words where deck_id=d_n1 and (headword='おのずと' or reading='おのずと') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='自然に' or reading='自然に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'おのずと(저절로, 자연히)≒自然に(자연히)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '自然に(자연히)≒おのずと(저절로, 자연히)', 1) on conflict do nothing;
  end if;
  -- 23. けなされる ⇔ 悪く言われる
  select id into w1 from public.words where deck_id=d_n1 and (headword='けなされる' or reading='けなされる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='悪く言われる' or reading='悪く言われる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'けなされる(비난을 받다)≒悪く言われる(나쁜 말을 듣다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '悪く言われる(나쁜 말을 듣다)≒けなされる(비난을 받다)', 1) on conflict do nothing;
  end if;
  -- 24. しきりに ⇔ 何度も
  select id into w1 from public.words where deck_id=d_n1 and (headword='しきりに' or reading='しきりに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='何度も' or reading='何度も') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'しきりに(자꾸, 연달아)≒何度も(몇 번이고)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '何度も(몇 번이고)≒しきりに(자꾸, 연달아)', 1) on conflict do nothing;
  end if;
  -- 25. すがすがしい ⇔ さわやかだ
  select id into w1 from public.words where deck_id=d_n1 and (headword='すがすがしい' or reading='すがすがしい') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='さわやかだ' or reading='さわやかだ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'すがすがしい(상쾌하다, 시원하다)≒さわやかだ(상쾌하다, 산뜻하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'さわやかだ(상쾌하다, 산뜻하다)≒すがすがしい(상쾌하다, 시원하다)', 1) on conflict do nothing;
  end if;
  -- 26. にわかには ⇔ すぐには
  select id into w1 from public.words where deck_id=d_n1 and (headword='にわかには' or reading='にわかには') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='すぐには' or reading='すぐには') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'にわかには(갑자기는)≒すぐには(바로는, 당장에는)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'すぐには(바로는, 당장에는)≒にわかには(갑자기는)', 1) on conflict do nothing;
  end if;
  -- 27. もくろむ ⇔ 計画する
  select id into w1 from public.words where deck_id=d_n1 and (headword='もくろむ' or reading='もくろむ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='計画する' or reading='計画する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'もくろむ(계획하다, 꾀하다)≒計画する(계획하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '計画する(계획하다)≒もくろむ(계획하다, 꾀하다)', 1) on conflict do nothing;
  end if;
  -- 28. スケール ⇔ 規模
  select id into w1 from public.words where deck_id=d_n1 and (headword='スケール' or reading='スケール') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='規模' or reading='規模') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'スケール(스케일)≒規模(규모)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '規模(규모)≒スケール(스케일)', 1) on conflict do nothing;
  end if;
  -- 29. 先方 ⇔ 相手
  select id into w1 from public.words where deck_id=d_n1 and (headword='先方' or reading='先方') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='相手' or reading='相手') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '先方(상대)≒相手(상대)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '相手(상대)≒先方(상대)', 1) on conflict do nothing;
  end if;
  -- 30. 密かに ⇔ こっそり
  select id into w1 from public.words where deck_id=d_n1 and (headword='密かに' or reading='密かに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='こっそり' or reading='こっそり') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '密かに(은밀하게)≒こっそり(살짝, 몰래)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'こっそり(살짝, 몰래)≒密かに(은밀하게)', 1) on conflict do nothing;
  end if;
  -- 31. 当面 ⇔ しばらく
  select id into w1 from public.words where deck_id=d_n1 and (headword='当面' or reading='当面') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='しばらく' or reading='しばらく') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '当面(당면, 당분간)≒しばらく(잠시)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'しばらく(잠시)≒当面(당면, 당분간)', 1) on conflict do nothing;
  end if;
  -- 32. 手がかり ⇔ ヒント
  select id into w1 from public.words where deck_id=d_n1 and (headword='手がかり' or reading='手がかり') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ヒント' or reading='ヒント') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '手がかり(단서, 실마리)≒ヒント(힌트)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ヒント(힌트)≒手がかり(단서, 실마리)', 1) on conflict do nothing;
  end if;
  -- 33. 断念する ⇔ 諦める
  select id into w1 from public.words where deck_id=d_n1 and (headword='断念する' or reading='断念する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='諦める' or reading='諦める') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '断念する(단념하다)≒諦める(포기하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '諦める(포기하다)≒断念する(단념하다)', 1) on conflict do nothing;
  end if;
  -- 34. 歴然としている ⇔ はっきりしている
  select id into w1 from public.words where deck_id=d_n1 and (headword='歴然としている' or reading='歴然としている') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='はっきりしている' or reading='はっきりしている') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '歴然としている(역연하다, 또렷하다)≒はっきりしている(분명하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'はっきりしている(분명하다)≒歴然としている(역연하다, 또렷하다)', 1) on conflict do nothing;
  end if;
  -- 35. 簡素だ ⇔ シンプルだ
  select id into w1 from public.words where deck_id=d_n1 and (headword='簡素だ' or reading='簡素だ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='シンプルだ' or reading='シンプルだ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '簡素だ(간소하다)≒シンプルだ(심플하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'シンプルだ(심플하다)≒簡素だ(간소하다)', 1) on conflict do nothing;
  end if;
  -- 36. 落胆する ⇔ がっかりする
  select id into w1 from public.words where deck_id=d_n1 and (headword='落胆する' or reading='落胆する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='がっかりする' or reading='がっかりする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '落胆する(낙담하다)≒がっかりする(낙담하다, 실망하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'がっかりする(낙담하다, 실망하다)≒落胆する(낙담하다)', 1) on conflict do nothing;
  end if;
  -- 37. 裏づけ ⇔ 証拠
  select id into w1 from public.words where deck_id=d_n1 and (headword='裏づけ' or reading='裏づけ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='証拠' or reading='証拠') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '裏づけ(뒷받침, 증거)≒証拠(증거)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '証拠(증거)≒裏づけ(뒷받침, 증거)', 1) on conflict do nothing;
  end if;
  -- 38. 触発される ⇔ 刺激を受ける
  select id into w1 from public.words where deck_id=d_n1 and (headword='触発される' or reading='触発される') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='刺激を受ける' or reading='刺激を受ける') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '触発される(촉발되다)≒刺激を受ける(자극을 받다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '刺激を受ける(자극을 받다)≒触発される(촉발되다)', 1) on conflict do nothing;
  end if;
  -- 39. いたって ⇔ 非常に
  select id into w1 from public.words where deck_id=d_n1 and (headword='いたって' or reading='いたって') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='非常に' or reading='非常に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'いたって(지극히)≒非常に(매우, 몹시)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '非常に(매우, 몹시)≒いたって(지극히)', 1) on conflict do nothing;
  end if;
  -- 40. おおむね ⇔ 大体
  select id into w1 from public.words where deck_id=d_n1 and (headword='おおむね' or reading='おおむね') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='大体' or reading='大体') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'おおむね(대체로, 대강)≒大体(대체로)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '大体(대체로)≒おおむね(대체로, 대강)', 1) on conflict do nothing;
  end if;
  -- 41. お手上げだ ⇔ どうしようもない
  select id into w1 from public.words where deck_id=d_n1 and (headword='お手上げだ' or reading='お手上げだ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='どうしようもない' or reading='どうしようもない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'お手上げだ(두 손 들었다, 속수무책이다)≒どうしようもない(어쩔 방법이 없다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'どうしようもない(어쩔 방법이 없다)≒お手上げだ(두 손 들었다, 속수무책이다)', 1) on conflict do nothing;
  end if;
  -- 42. ことごとく ⇔ すべて
  select id into w1 from public.words where deck_id=d_n1 and (headword='ことごとく' or reading='ことごとく') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='すべて' or reading='すべて') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ことごとく(전부)≒すべて(전부)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'すべて(전부)≒ことごとく(전부)', 1) on conflict do nothing;
  end if;
  -- 43. すべ ⇔ 方法
  select id into w1 from public.words where deck_id=d_n1 and (headword='すべ' or reading='すべ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='方法' or reading='方法') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'すべ(방법)≒方法(방법)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '方法(방법)≒すべ(방법)', 1) on conflict do nothing;
  end if;
  -- 44. せかす ⇔ 急がせる
  select id into w1 from public.words where deck_id=d_n1 and (headword='せかす' or reading='せかす') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='急がせる' or reading='急がせる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'せかす(재촉하다)≒急がせる(서두르게 하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '急がせる(서두르게 하다)≒せかす(재촉하다)', 1) on conflict do nothing;
  end if;
  -- 45. バックアップ ⇔ 支援
  select id into w1 from public.words where deck_id=d_n1 and (headword='バックアップ' or reading='バックアップ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='支援' or reading='支援') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'バックアップ(백업, 지원)≒支援(지원)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '支援(지원)≒バックアップ(백업, 지원)', 1) on conflict do nothing;
  end if;
  -- 46. メカニズム ⇔ 仕組み
  select id into w1 from public.words where deck_id=d_n1 and (headword='メカニズム' or reading='メカニズム') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='仕組み' or reading='仕組み') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'メカニズム(메커니즘)≒仕組み(구조)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '仕組み(구조)≒メカニズム(메커니즘)', 1) on conflict do nothing;
  end if;
  -- 47. 仰天する ⇔ とても驚く
  select id into w1 from public.words where deck_id=d_n1 and (headword='仰天する' or reading='仰天する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='とても驚く' or reading='とても驚く') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '仰天する(경악하다, 몹시 놀라다)≒とても驚く(매우 놀라다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'とても驚く(매우 놀라다)≒仰天する(경악하다, 몹시 놀라다)', 1) on conflict do nothing;
  end if;
  -- 48. 回想する ⇔ 思い返す
  select id into w1 from public.words where deck_id=d_n1 and (headword='回想する' or reading='回想する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='思い返す' or reading='思い返す') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '回想する(회상하다)≒思い返す(돌아보다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '思い返す(돌아보다)≒回想する(회상하다)', 1) on conflict do nothing;
  end if;
  -- 49. 従来の ⇔ これまでの
  select id into w1 from public.words where deck_id=d_n1 and (headword='従来の' or reading='従来の') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='これまでの' or reading='これまでの') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '従来の(종래의)≒これまでの(지금까지의)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'これまでの(지금까지의)≒従来の(종래의)', 1) on conflict do nothing;
  end if;
  -- 50. 打ち込む ⇔ 熱心に取り組む
  select id into w1 from public.words where deck_id=d_n1 and (headword='打ち込む' or reading='打ち込む') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='熱心に取り組む' or reading='熱心に取り組む') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '打ち込む(몰입하다, 몰두하다)≒熱心に取り組む(열심히 몰두하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '熱心に取り組む(열심히 몰두하다)≒打ち込む(몰입하다, 몰두하다)', 1) on conflict do nothing;
  end if;
  -- 51. 抜群だ ⇔ 他と比べて特によい
  select id into w1 from public.words where deck_id=d_n1 and (headword='抜群だ' or reading='抜群だ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='他と比べて特によい' or reading='他と比べて特によい') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '抜群だ(발군이다, 뛰어나다)≒他と比べて特によい(다른 것과 비교하여 특히 좋다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '他と比べて特によい(다른 것과 비교하여 특히 좋다)≒抜群だ(발군이다, 뛰어나다)', 1) on conflict do nothing;
  end if;
  -- 52. 格段に ⇔ 大幅に
  select id into w1 from public.words where deck_id=d_n1 and (headword='格段に' or reading='格段に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='大幅に' or reading='大幅に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '格段に(현격하게)≒大幅に(대폭적으로)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '大幅に(대폭적으로)≒格段に(현격하게)', 1) on conflict do nothing;
  end if;
  -- 53. 案の定 ⇔ やはり
  select id into w1 from public.words where deck_id=d_n1 and (headword='案の定' or reading='案の定') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='やはり' or reading='やはり') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '案の定(역시, 예상대로)≒やはり(역시)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'やはり(역시)≒案の定(역시, 예상대로)', 1) on conflict do nothing;
  end if;
  -- 54. 気掛かり ⇔ 心配
  select id into w1 from public.words where deck_id=d_n1 and (headword='気掛かり' or reading='気掛かり') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='心配' or reading='心配') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '気掛かり(걱정, 근심)≒心配(걱정, 근심)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '心配(걱정, 근심)≒気掛かり(걱정, 근심)', 1) on conflict do nothing;
  end if;
  -- 55. 雑踏 ⇔ 人込み
  select id into w1 from public.words where deck_id=d_n1 and (headword='雑踏' or reading='雑踏') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='人込み' or reading='人込み') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '雑踏(혼잡)≒人込み(혼잡, 북새통)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '人込み(혼잡, 북새통)≒雑踏(혼잡)', 1) on conflict do nothing;
  end if;
  -- 56. ありふれる ⇔ 平凡だ
  select id into w1 from public.words where deck_id=d_n1 and (headword='ありふれる' or reading='ありふれる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='平凡だ' or reading='平凡だ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ありふれる(흔하다)≒平凡だ(평범하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '平凡だ(평범하다)≒ありふれる(흔하다)', 1) on conflict do nothing;
  end if;
  -- 57. うろたえる ⇔ 慌てる
  select id into w1 from public.words where deck_id=d_n1 and (headword='うろたえる' or reading='うろたえる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='慌てる' or reading='慌てる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'うろたえる(허둥거리다, 당황하다)≒慌てる(당황하다, 허둥지둥하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '慌てる(당황하다, 허둥지둥하다)≒うろたえる(허둥거리다, 당황하다)', 1) on conflict do nothing;
  end if;
  -- 58. クレーム ⇔ 苦情
  select id into w1 from public.words where deck_id=d_n1 and (headword='クレーム' or reading='クレーム') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='苦情' or reading='苦情') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'クレーム(클레임)≒苦情(클레임, 불만)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '苦情(클레임, 불만)≒クレーム(클레임)', 1) on conflict do nothing;
  end if;
  -- 59. ストレートに ⇔ 率直に
  select id into w1 from public.words where deck_id=d_n1 and (headword='ストレートに' or reading='ストレートに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='率直に' or reading='率直に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ストレートに(직설적으로)≒率直に(솔직하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '率直に(솔직하게)≒ストレートに(직설적으로)', 1) on conflict do nothing;
  end if;
  -- 60. 不意に ⇔ 突然
  select id into w1 from public.words where deck_id=d_n1 and (headword='不意に' or reading='不意に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='突然' or reading='突然') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '不意に(갑자기)≒突然(돌연)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '突然(돌연)≒不意に(갑자기)', 1) on conflict do nothing;
  end if;
  -- 61. 不用意な ⇔ 不注意な
  select id into w1 from public.words where deck_id=d_n1 and (headword='不用意な' or reading='不用意な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='不注意な' or reading='不注意な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '不用意な(부주의한)≒不注意な(부주의한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '不注意な(부주의한)≒不用意な(부주의한)', 1) on conflict do nothing;
  end if;
  -- 62. 互角だ ⇔ 大体同じだ
  select id into w1 from public.words where deck_id=d_n1 and (headword='互角だ' or reading='互角だ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='大体同じだ' or reading='大体同じだ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '互角だ(호각이다, 백중세다)≒大体同じだ(대체로 같다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '大体同じだ(대체로 같다)≒互角だ(호각이다, 백중세다)', 1) on conflict do nothing;
  end if;
  -- 63. 仕上がる ⇔ 完成する
  select id into w1 from public.words where deck_id=d_n1 and (headword='仕上がる' or reading='仕上がる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='完成する' or reading='完成する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '仕上がる(마무리되다, 완성되다)≒完成する(완성되다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '完成する(완성되다)≒仕上がる(마무리되다, 완성되다)', 1) on conflict do nothing;
  end if;
  -- 64. 助言 ⇔ アドバイス
  select id into w1 from public.words where deck_id=d_n1 and (headword='助言' or reading='助言') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='アドバイス' or reading='アドバイス') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '助言(조언)≒アドバイス(조언, 충고)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'アドバイス(조언, 충고)≒助言(조언)', 1) on conflict do nothing;
  end if;
  -- 65. 厄介な ⇔ 面倒な
  select id into w1 from public.words where deck_id=d_n1 and (headword='厄介な' or reading='厄介な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='面倒な' or reading='面倒な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '厄介な(귀찮은)≒面倒な(귀찮은)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '面倒な(귀찮은)≒厄介な(귀찮은)', 1) on conflict do nothing;
  end if;
  -- 66. 安堵する ⇔ ほっとする
  select id into w1 from public.words where deck_id=d_n1 and (headword='安堵する' or reading='安堵する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ほっとする' or reading='ほっとする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '安堵する(안도하다)≒ほっとする(안심하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ほっとする(안심하다)≒安堵する(안도하다)', 1) on conflict do nothing;
  end if;
  -- 67. 弁解する ⇔ 言い訳する
  select id into w1 from public.words where deck_id=d_n1 and (headword='弁解する' or reading='弁解する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='言い訳する' or reading='言い訳する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '弁解する(변명하다)≒言い訳する(변명하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '言い訳する(변명하다)≒弁解する(변명하다)', 1) on conflict do nothing;
  end if;
  -- 68. 意気込み ⇔ 意欲
  select id into w1 from public.words where deck_id=d_n1 and (headword='意気込み' or reading='意気込み') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='意欲' or reading='意欲') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '意気込み(열의, 패기)≒意欲(의욕)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '意欲(의욕)≒意気込み(열의, 패기)', 1) on conflict do nothing;
  end if;
  -- 69. 手分けする ⇔ 分担する
  select id into w1 from public.words where deck_id=d_n1 and (headword='手分けする' or reading='手分けする') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='分担する' or reading='分担する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '手分けする(분담하다)≒分担する(분담하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '分担する(분담하다)≒手分けする(분담하다)', 1) on conflict do nothing;
  end if;
  -- 70. 殺到する ⇔ 一度に大勢来る
  select id into w1 from public.words where deck_id=d_n1 and (headword='殺到する' or reading='殺到する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='一度に大勢来る' or reading='一度に大勢来る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '殺到する(쇄도하다)≒一度に大勢来る(한꺼번에 많이 몰려들다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '一度に大勢来る(한꺼번에 많이 몰려들다)≒殺到する(쇄도하다)', 1) on conflict do nothing;
  end if;
  -- 71. 無償 ⇔ ただ
  select id into w1 from public.words where deck_id=d_n1 and (headword='無償' or reading='無償') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ただ' or reading='ただ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '無償(무상)≒ただ(공짜, 무료)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ただ(공짜, 무료)≒無償(무상)', 1) on conflict do nothing;
  end if;
  -- 72. 糸口 ⇔ ヒント
  select id into w1 from public.words where deck_id=d_n1 and (headword='糸口' or reading='糸口') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ヒント' or reading='ヒント') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '糸口(실마리)≒ヒント(힌트)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ヒント(힌트)≒糸口(실마리)', 1) on conflict do nothing;
  end if;
  -- 73. 誇張 ⇔ 大げさ
  select id into w1 from public.words where deck_id=d_n1 and (headword='誇張' or reading='誇張') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='大げさ' or reading='大げさ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '誇張(과장(사실보다 크게 부풀림))≒大げさ(과장, 호들갑)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '大げさ(과장, 호들갑)≒誇張(과장(사실보다 크게 부풀림))', 1) on conflict do nothing;
  end if;
  -- 74. 錯覚する ⇔ 勘違いする
  select id into w1 from public.words where deck_id=d_n1 and (headword='錯覚する' or reading='錯覚する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='勘違いする' or reading='勘違いする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '錯覚する(착각하다)≒勘違いする(착각하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '勘違いする(착각하다)≒錯覚する(착각하다)', 1) on conflict do nothing;
  end if;
  -- 75. うすうす ⇔ なんとなく
  select id into w1 from public.words where deck_id=d_n1 and (headword='うすうす' or reading='うすうす') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='なんとなく' or reading='なんとなく') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'うすうす(희미하게, 어렴풋이)≒なんとなく(왠지 모르게, 어쩐지)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'なんとなく(왠지 모르게, 어쩐지)≒うすうす(희미하게, 어렴풋이)', 1) on conflict do nothing;
  end if;
  -- 76. おびえる ⇔ 怖がる
  select id into w1 from public.words where deck_id=d_n1 and (headword='おびえる' or reading='おびえる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='怖がる' or reading='怖がる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'おびえる(겁을 내다)≒怖がる(무서워하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '怖がる(무서워하다)≒おびえる(겁을 내다)', 1) on conflict do nothing;
  end if;
  -- 77. かねがね ⇔ 以前から
  select id into w1 from public.words where deck_id=d_n1 and (headword='かねがね' or reading='かねがね') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='以前から' or reading='以前から') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'かねがね(전부터)≒以前から(이전부터)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '以前から(이전부터)≒かねがね(전부터)', 1) on conflict do nothing;
  end if;
  -- 78. かろうじて ⇔ 何とか
  select id into w1 from public.words where deck_id=d_n1 and (headword='かろうじて' or reading='かろうじて') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='何とか' or reading='何とか') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'かろうじて(겨우, 간신히)≒何とか(그럭저럭)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '何とか(그럭저럭)≒かろうじて(겨우, 간신히)', 1) on conflict do nothing;
  end if;
  -- 79. ささいな ⇔ 小さな
  select id into w1 from public.words where deck_id=d_n1 and (headword='ささいな' or reading='ささいな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='小さな' or reading='小さな') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ささいな(사소한)≒小さな(작은)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '小さな(작은)≒ささいな(사소한)', 1) on conflict do nothing;
  end if;
  -- 80. むっとする ⇔ 怒ったような顔をする
  select id into w1 from public.words where deck_id=d_n1 and (headword='むっとする' or reading='むっとする') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='怒ったような顔をする' or reading='怒ったような顔をする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'むっとする(부루퉁해지다)≒怒ったような顔をする(화가 난 듯한 얼굴을 하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '怒ったような顔をする(화가 난 듯한 얼굴을 하다)≒むっとする(부루퉁해지다)', 1) on conflict do nothing;
  end if;
  -- 81. ゆとり ⇔ 余裕
  select id into w1 from public.words where deck_id=d_n1 and (headword='ゆとり' or reading='ゆとり') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='余裕' or reading='余裕') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ゆとり(여유)≒余裕(여유)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '余裕(여유)≒ゆとり(여유)', 1) on conflict do nothing;
  end if;
  -- 82. わずらわしい ⇔ 面倒な
  select id into w1 from public.words where deck_id=d_n1 and (headword='わずらわしい' or reading='わずらわしい') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='面倒な' or reading='面倒な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'わずらわしい(번거로운)≒面倒な(귀찮은)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '面倒な(귀찮은)≒わずらわしい(번거로운)', 1) on conflict do nothing;
  end if;
  -- 83. 入念に ⇔ 細かく丁寧に
  select id into w1 from public.words where deck_id=d_n1 and (headword='入念に' or reading='入念に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='細かく丁寧に' or reading='細かく丁寧に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '入念に(꼼꼼하게, 정성들여)≒細かく丁寧に(섬세하고 정성껏)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '細かく丁寧に(섬세하고 정성껏)≒入念に(꼼꼼하게, 정성들여)', 1) on conflict do nothing;
  end if;
  -- 84. 戸惑う ⇔ 困る
  select id into w1 from public.words where deck_id=d_n1 and (headword='戸惑う' or reading='戸惑う') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='困る' or reading='困る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '戸惑う(어리둥절해하다, 당황하다)≒困る(곤란하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '困る(곤란하다)≒戸惑う(어리둥절해하다, 당황하다)', 1) on conflict do nothing;
  end if;
  -- 85. 抱負 ⇔ 決意
  select id into w1 from public.words where deck_id=d_n1 and (headword='抱負' or reading='抱負') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='決意' or reading='決意') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '抱負(포부)≒決意(결의)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '決意(결의)≒抱負(포부)', 1) on conflict do nothing;
  end if;
  -- 86. 故意に ⇔ わざと
  select id into w1 from public.words where deck_id=d_n1 and (headword='故意に' or reading='故意に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='わざと' or reading='わざと') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '故意に(고의로)≒わざと(일부러)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'わざと(일부러)≒故意に(고의로)', 1) on conflict do nothing;
  end if;
  -- 87. 照会する ⇔ 問い合わせる
  select id into w1 from public.words where deck_id=d_n1 and (headword='照会する' or reading='照会する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='問い合わせる' or reading='問い合わせる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '照会する(조회하다)≒問い合わせる(문의하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '問い合わせる(문의하다)≒照会する(조회하다)', 1) on conflict do nothing;
  end if;
  -- 88. 端的に ⇔ 明白に
  select id into w1 from public.words where deck_id=d_n1 and (headword='端的に' or reading='端的に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='明白に' or reading='明白に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '端的に(단적으로)≒明白に(명백하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '明白に(명백하게)≒端的に(단적으로)', 1) on conflict do nothing;
  end if;
  -- 89. 粘り強く ⇔ あきらめずに
  select id into w1 from public.words where deck_id=d_n1 and (headword='粘り強く' or reading='粘り強く') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='あきらめずに' or reading='あきらめずに') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '粘り強く(끈기 있게)≒あきらめずに(포기하지 않고)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'あきらめずに(포기하지 않고)≒粘り強く(끈기 있게)', 1) on conflict do nothing;
  end if;
  -- 90. 自尊心 ⇔ プライド
  select id into w1 from public.words where deck_id=d_n1 and (headword='自尊心' or reading='自尊心') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='プライド' or reading='プライド') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '自尊心(자존심)≒プライド(프라이드)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'プライド(프라이드)≒自尊心(자존심)', 1) on conflict do nothing;
  end if;
  -- 91. 詫びる ⇔ 謝る
  select id into w1 from public.words where deck_id=d_n1 and (headword='詫びる' or reading='詫びる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='謝る' or reading='謝る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '詫びる(사과하다)≒謝る(사과하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '謝る(사과하다)≒詫びる(사과하다)', 1) on conflict do nothing;
  end if;
  -- 92. 難点 ⇔ 不安なところ
  select id into w1 from public.words where deck_id=d_n1 and (headword='難点' or reading='難点') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='不安なところ' or reading='不安なところ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '難点(난점)≒不安なところ(불안한 점)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '不安なところ(불안한 점)≒難点(난점)', 1) on conflict do nothing;
  end if;
  -- 93. ありありと ⇔ はっきり
  select id into w1 from public.words where deck_id=d_n1 and (headword='ありありと' or reading='ありありと') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='はっきり' or reading='はっきり') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ありありと(똑똑히, 뚜렷이)≒はっきり(확실히, 분명히)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'はっきり(확실히, 분명히)≒ありありと(똑똑히, 뚜렷이)', 1) on conflict do nothing;
  end if;
  -- 94. かたくなな ⇔ 頑固な
  select id into w1 from public.words where deck_id=d_n1 and (headword='かたくなな' or reading='かたくなな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='頑固な' or reading='頑固な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'かたくなな(고집이 센)≒頑固な(완고한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '頑固な(완고한)≒かたくなな(고집이 센)', 1) on conflict do nothing;
  end if;
  -- 95. しくじる ⇔ 失敗する
  select id into w1 from public.words where deck_id=d_n1 and (headword='しくじる' or reading='しくじる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='失敗する' or reading='失敗する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'しくじる(실수하다, 실패하다)≒失敗する(실패하다, 실수하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '失敗する(실패하다, 실수하다)≒しくじる(실수하다, 실패하다)', 1) on conflict do nothing;
  end if;
  -- 96. すみやかに ⇔ できるだけ早く
  select id into w1 from public.words where deck_id=d_n1 and (headword='すみやかに' or reading='すみやかに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='できるだけ早く' or reading='できるだけ早く') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'すみやかに(신속히)≒できるだけ早く(가능한 한 빨리)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'できるだけ早く(가능한 한 빨리)≒すみやかに(신속히)', 1) on conflict do nothing;
  end if;
  -- 97. つかの間の ⇔ 短い
  select id into w1 from public.words where deck_id=d_n1 and (headword='つかの間の' or reading='つかの間の') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='短い' or reading='短い') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'つかの間の(짧은, 잠깐 동안의)≒短い(짧은)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '短い(짧은)≒つかの間の(짧은, 잠깐 동안의)', 1) on conflict do nothing;
  end if;
  -- 98. めいめいに ⇔ 一人一人に
  select id into w1 from public.words where deck_id=d_n1 and (headword='めいめいに' or reading='めいめいに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='一人一人に' or reading='一人一人に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'めいめいに(각각에게, 각자에게)≒一人一人に(한 사람 한 사람에게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '一人一人に(한 사람 한 사람에게)≒めいめいに(각각에게, 각자에게)', 1) on conflict do nothing;
  end if;
  -- 99. エレガントな ⇔ 上品な
  select id into w1 from public.words where deck_id=d_n1 and (headword='エレガントな' or reading='エレガントな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='上品な' or reading='上品な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'エレガントな(우아한, 고상한)≒上品な(고상한, 품위 있는)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '上品な(고상한, 품위 있는)≒エレガントな(우아한, 고상한)', 1) on conflict do nothing;
  end if;
  -- 100. コンパクトな ⇔ 小型の
  select id into w1 from public.words where deck_id=d_n1 and (headword='コンパクトな' or reading='コンパクトな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='小型の' or reading='小型の') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'コンパクトな(콤팩트한)≒小型の(소형인)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '小型の(소형인)≒コンパクトな(콤팩트한)', 1) on conflict do nothing;
  end if;
  -- 101. スライスする ⇔ 薄く切る
  select id into w1 from public.words where deck_id=d_n1 and (headword='スライスする' or reading='スライスする') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='薄く切る' or reading='薄く切る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'スライスする(얇게 썰다)≒薄く切る(얇게 자르다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '薄く切る(얇게 자르다)≒スライスする(얇게 썰다)', 1) on conflict do nothing;
  end if;
  -- 102. 克明に ⇔ 詳しく丁寧に
  select id into w1 from public.words where deck_id=d_n1 and (headword='克明に' or reading='克明に') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='詳しく丁寧に' or reading='詳しく丁寧に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '克明に(극명하게, 정확하고 자세하게)≒詳しく丁寧に(자세하고 꼼꼼하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '詳しく丁寧に(자세하고 꼼꼼하게)≒克明に(극명하게, 정확하고 자세하게)', 1) on conflict do nothing;
  end if;
  -- 103. 妨害する ⇔ じゃまする
  select id into w1 from public.words where deck_id=d_n1 and (headword='妨害する' or reading='妨害する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='じゃまする' or reading='じゃまする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '妨害する(방해하다)≒じゃまする(방해하다, 훼방 놓다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'じゃまする(방해하다, 훼방 놓다)≒妨害する(방해하다)', 1) on conflict do nothing;
  end if;
  -- 104. 張り合う ⇔ 競い合う
  select id into w1 from public.words where deck_id=d_n1 and (headword='張り合う' or reading='張り合う') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='競い合う' or reading='競い合う') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '張り合う(경쟁하다)≒競い合う(경합하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '競い合う(경합하다)≒張り合う(경쟁하다)', 1) on conflict do nothing;
  end if;
  -- 105. 手立て ⇔ 方法
  select id into w1 from public.words where deck_id=d_n1 and (headword='手立て' or reading='手立て') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='方法' or reading='方法') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '手立て(방법, 수단)≒方法(방법)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '方法(방법)≒手立て(방법, 수단)', 1) on conflict do nothing;
  end if;
  -- 106. 撤回する ⇔ 取り消す
  select id into w1 from public.words where deck_id=d_n1 and (headword='撤回する' or reading='撤回する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='取り消す' or reading='取り消す') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '撤回する(철회하다)≒取り消す(취소하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '取り消す(취소하다)≒撤回する(철회하다)', 1) on conflict do nothing;
  end if;
  -- 107. 極力 ⇔ できるだけ
  select id into w1 from public.words where deck_id=d_n1 and (headword='極力' or reading='極力') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='できるだけ' or reading='できるだけ') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '極力(될 수 있는 한)≒できるだけ(가능한 한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'できるだけ(가능한 한)≒極力(될 수 있는 한)', 1) on conflict do nothing;
  end if;
  -- 108. 漠然としている ⇔ ぼんやりしている
  select id into w1 from public.words where deck_id=d_n1 and (headword='漠然としている' or reading='漠然としている') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ぼんやりしている' or reading='ぼんやりしている') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '漠然としている(막연하다)≒ぼんやりしている(분명하지 않다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ぼんやりしている(분명하지 않다)≒漠然としている(막연하다)', 1) on conflict do nothing;
  end if;
  -- 109. 若干 ⇔ わずかに
  select id into w1 from public.words where deck_id=d_n1 and (headword='若干' or reading='若干') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='わずかに' or reading='わずかに') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '若干(약간)≒わずかに(아주 조금)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'わずかに(아주 조금)≒若干(약간)', 1) on conflict do nothing;
  end if;
  -- 110. 返事をしぶっている ⇔ なかなか返事をしようとしない
  select id into w1 from public.words where deck_id=d_n1 and (headword='返事をしぶっている' or reading='返事をしぶっている') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='なかなか返事をしようとしない' or reading='なかなか返事をしようとしない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '返事をしぶっている(대답하기를 꺼리다, 주저하다)≒なかなか返事をしようとしない(좀처럼 대답하려고 하지 않다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'なかなか返事をしようとしない(좀처럼 대답하려고 하지 않다)≒返事をしぶっている(대답하기를 꺼리다, 주저하다)', 1) on conflict do nothing;
  end if;
  -- 111. つぶさに ⇔ 詳細に
  select id into w1 from public.words where deck_id=d_n1 and (headword='つぶさに' or reading='つぶさに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='詳細に' or reading='詳細に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'つぶさに(자세하게, 빠짐없이)≒詳細に(상세하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '詳細に(상세하게)≒つぶさに(자세하게, 빠짐없이)', 1) on conflict do nothing;
  end if;
  -- 112. つぶやく ⇔ 小さな声で言う
  select id into w1 from public.words where deck_id=d_n1 and (headword='つぶやく' or reading='つぶやく') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='小さな声で言う' or reading='小さな声で言う') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'つぶやく(중얼거리다)≒小さな声で言う(작은 소리로 말하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '小さな声で言う(작은 소리로 말하다)≒つぶやく(중얼거리다)', 1) on conflict do nothing;
  end if;
  -- 113. ばてる ⇔ 疲れる
  select id into w1 from public.words where deck_id=d_n1 and (headword='ばてる' or reading='ばてる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='疲れる' or reading='疲れる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ばてる(지치다, 녹초가 되다)≒疲れる(피곤하다, 지치다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '疲れる(피곤하다, 지치다)≒ばてる(지치다, 녹초가 되다)', 1) on conflict do nothing;
  end if;
  -- 114. ぼやく ⇔ 愚痴を言う
  select id into w1 from public.words where deck_id=d_n1 and (headword='ぼやく' or reading='ぼやく') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='愚痴を言う' or reading='愚痴を言う') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ぼやく(투덜대다)≒愚痴を言う(불평하다, 푸념하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '愚痴を言う(불평하다, 푸념하다)≒ぼやく(투덜대다)', 1) on conflict do nothing;
  end if;
  -- 115. まっとうする ⇔ 完了する
  select id into w1 from public.words where deck_id=d_n1 and (headword='まっとうする' or reading='まっとうする') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='完了する' or reading='完了する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'まっとうする(다하다, 완수하다)≒完了する(완료하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '完了する(완료하다)≒まっとうする(다하다, 완수하다)', 1) on conflict do nothing;
  end if;
  -- 116. エキスパート ⇔ 専門家
  select id into w1 from public.words where deck_id=d_n1 and (headword='エキスパート' or reading='エキスパート') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='専門家' or reading='専門家') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'エキスパート(전문가)≒専門家(전문가)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '専門家(전문가)≒エキスパート(전문가)', 1) on conflict do nothing;
  end if;
  -- 117. 不審な ⇔ 怪しい
  select id into w1 from public.words where deck_id=d_n1 and (headword='不審な' or reading='不審な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='怪しい' or reading='怪しい') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '不審な(수상한, 의심스러운, 미심쩍은)≒怪しい(수상한, 의심스러운)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '怪しい(수상한, 의심스러운)≒不審な(수상한, 의심스러운, 미심쩍은)', 1) on conflict do nothing;
  end if;
  -- 118. 凝視する ⇔ じっと見る
  select id into w1 from public.words where deck_id=d_n1 and (headword='凝視する' or reading='凝視する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='じっと見る' or reading='じっと見る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '凝視する(응시하다)≒じっと見る(가만히 보다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'じっと見る(가만히 보다)≒凝視する(응시하다)', 1) on conflict do nothing;
  end if;
  -- 119. 吟味 ⇔ 検討
  select id into w1 from public.words where deck_id=d_n1 and (headword='吟味' or reading='吟味') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='検討' or reading='検討') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '吟味(음미, 자세히 조사함)≒検討(검토)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '検討(검토)≒吟味(음미, 자세히 조사함)', 1) on conflict do nothing;
  end if;
  -- 120. 寡黙な ⇔ 口数が少ない
  select id into w1 from public.words where deck_id=d_n1 and (headword='寡黙な' or reading='寡黙な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='口数が少ない' or reading='口数が少ない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '寡黙な(과묵한)≒口数が少ない(말수가 적은)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '口数が少ない(말수가 적은)≒寡黙な(과묵한)', 1) on conflict do nothing;
  end if;
  -- 121. 打ち込む ⇔ 熱中する
  select id into w1 from public.words where deck_id=d_n1 and (headword='打ち込む' or reading='打ち込む') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='熱中する' or reading='熱中する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '打ち込む(열중하다, 박아넣다)≒熱中する(열중하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '熱中する(열중하다)≒打ち込む(열중하다, 박아넣다)', 1) on conflict do nothing;
  end if;
  -- 122. 架空 ⇔ 想像
  select id into w1 from public.words where deck_id=d_n1 and (headword='架空' or reading='架空') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='想像' or reading='想像') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '架空(가공)≒想像(상상)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '想像(상상)≒架空(가공)', 1) on conflict do nothing;
  end if;
  -- 123. 異例の ⇔ 珍しい
  select id into w1 from public.words where deck_id=d_n1 and (headword='異例の' or reading='異例の') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='珍しい' or reading='珍しい') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '異例の(이례인)≒珍しい(드문, 흔히 없는)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '珍しい(드문, 흔히 없는)≒異例の(이례인)', 1) on conflict do nothing;
  end if;
  -- 124. 脈絡 ⇔ つながり
  select id into w1 from public.words where deck_id=d_n1 and (headword='脈絡' or reading='脈絡') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='つながり' or reading='つながり') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '脈絡(맥락, 연관, 관련)≒つながり(연계, 관계, 연결)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'つながり(연계, 관계, 연결)≒脈絡(맥락, 연관, 관련)', 1) on conflict do nothing;
  end if;
  -- 125. いくつか ⇔ 若干
  select id into w1 from public.words where deck_id=d_n1 and (headword='いくつか' or reading='いくつか') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='若干' or reading='若干') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'いくつか(몇 개쯤, 조금)≒若干(약간)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '若干(약간)≒いくつか(몇 개쯤, 조금)', 1) on conflict do nothing;
  end if;
  -- 126. うやむやに ⇔ あいまいに
  select id into w1 from public.words where deck_id=d_n1 and (headword='うやむやに' or reading='うやむやに') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='あいまいに' or reading='あいまいに') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'うやむやに(흐지부지하게, 애매하게)≒あいまいに(애매하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'あいまいに(애매하게)≒うやむやに(흐지부지하게, 애매하게)', 1) on conflict do nothing;
  end if;
  -- 127. くつろぐ ⇔ ゆっくりする
  select id into w1 from public.words where deck_id=d_n1 and (headword='くつろぐ' or reading='くつろぐ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='ゆっくりする' or reading='ゆっくりする') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'くつろぐ(느긋이, 편하게 쉬다)≒ゆっくりする(편하게 쉬다, 느긋이 시간을 보내다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'ゆっくりする(편하게 쉬다, 느긋이 시간을 보내다)≒くつろぐ(느긋이, 편하게 쉬다)', 1) on conflict do nothing;
  end if;
  -- 128. ずれ込む ⇔ 遅くなる
  select id into w1 from public.words where deck_id=d_n1 and (headword='ずれ込む' or reading='ずれ込む') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='遅くなる' or reading='遅くなる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ずれ込む(늦춰지다, 미루어지다)≒遅くなる(늦어지다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '遅くなる(늦어지다)≒ずれ込む(늦춰지다, 미루어지다)', 1) on conflict do nothing;
  end if;
  -- 129. てきぱきと ⇔ 早く正確に
  select id into w1 from public.words where deck_id=d_n1 and (headword='てきぱきと' or reading='てきぱきと') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='早く正確に' or reading='早く正確に') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'てきぱきと(일을 솜씨 좋게 처리하는 모습, 척척)≒早く正確に(빠르고 정확하게)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '早く正確に(빠르고 정확하게)≒てきぱきと(일을 솜씨 좋게 처리하는 모습, 척척)', 1) on conflict do nothing;
  end if;
  -- 130. ろくに(～ない) ⇔ 大して(～ない)
  select id into w1 from public.words where deck_id=d_n1 and (headword='ろくに(～ない)' or reading='ろくに(～ない)') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='大して(～ない)' or reading='大して(～ない)') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'ろくに(～ない)(제대로, 변변히(~않다))≒大して(～ない)(그다지, 별로(~않다))', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '大して(～ない)(그다지, 별로(~않다))≒ろくに(～ない)(제대로, 변변히(~않다))', 1) on conflict do nothing;
  end if;
  -- 131. リスク ⇔ 危険
  select id into w1 from public.words where deck_id=d_n1 and (headword='リスク' or reading='リスク') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='危険' or reading='危険') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'リスク(리스크, 위험)≒危険(위험)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '危険(위험)≒リスク(리스크, 위험)', 1) on conflict do nothing;
  end if;
  -- 132. 出馬する ⇔ 選挙に出る
  select id into w1 from public.words where deck_id=d_n1 and (headword='出馬する' or reading='出馬する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='選挙に出る' or reading='選挙に出る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '出馬する(출마하다)≒選挙に出る(선거에 나가다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '選挙に出る(선거에 나가다)≒出馬する(출마하다)', 1) on conflict do nothing;
  end if;
  -- 133. 寄与 ⇔ 貢献
  select id into w1 from public.words where deck_id=d_n1 and (headword='寄与' or reading='寄与') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='貢献' or reading='貢献') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '寄与(기여)≒貢献(공헌)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '貢献(공헌)≒寄与(기여)', 1) on conflict do nothing;
  end if;
  -- 134. 手分け ⇔ 分担
  select id into w1 from public.words where deck_id=d_n1 and (headword='手分け' or reading='手分け') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='分担' or reading='分担') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '手分け(분담, 나눔)≒分担(분담)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '分担(분담)≒手分け(분담, 나눔)', 1) on conflict do nothing;
  end if;
  -- 135. 気ままな ⇔ 自由な
  select id into w1 from public.words where deck_id=d_n1 and (headword='気ままな' or reading='気ままな') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='自由な' or reading='自由な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '気ままな(제 마음대로인)≒自由な(자유로운)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '自由な(자유로운)≒気ままな(제 마음대로인)', 1) on conflict do nothing;
  end if;
  -- 136. 紛糾する ⇔ 混乱する
  select id into w1 from public.words where deck_id=d_n1 and (headword='紛糾する' or reading='紛糾する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='混乱する' or reading='混乱する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '紛糾する(분규하다, 분규를 겪다)≒混乱する(혼란스럽다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '混乱する(혼란스럽다)≒紛糾する(분규하다, 분규를 겪다)', 1) on conflict do nothing;
  end if;
  -- 137. 絶賛する ⇔ 非常に素晴らしいとほめる
  select id into w1 from public.words where deck_id=d_n1 and (headword='絶賛する' or reading='絶賛する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='非常に素晴らしいとほめる' or reading='非常に素晴らしいとほめる') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '絶賛する(절찬하다, 극구 칭찬하다)≒非常に素晴らしいとほめる(매우 훌륭하다고 칭찬하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '非常に素晴らしいとほめる(매우 훌륭하다고 칭찬하다)≒絶賛する(절찬하다, 극구 칭찬하다)', 1) on conflict do nothing;
  end if;
  -- 138. 閉口する ⇔ 困る
  select id into w1 from public.words where deck_id=d_n1 and (headword='閉口する' or reading='閉口する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='困る' or reading='困る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '閉口する(난처하다, 기막히다)≒困る(곤란하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '困る(곤란하다)≒閉口する(난처하다, 기막히다)', 1) on conflict do nothing;
  end if;
  -- 139. あどけない ⇔ 無邪気な
  select id into w1 from public.words where deck_id=d_n1 and (headword='あどけない' or reading='あどけない') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='無邪気な' or reading='無邪気な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'あどけない(천진난만하다)≒無邪気な(천진난만한, 악의 없는)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '無邪気な(천진난만한, 악의 없는)≒あどけない(천진난만하다)', 1) on conflict do nothing;
  end if;
  -- 140. はかどる ⇔ 順調に進む
  select id into w1 from public.words where deck_id=d_n1 and (headword='はかどる' or reading='はかどる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='順調に進む' or reading='順調に進む') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'はかどる(일이 잘 되고 있다, 진척되다)≒順調に進む(순조롭게 진행되다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '順調に進む(순조롭게 진행되다)≒はかどる(일이 잘 되고 있다, 진척되다)', 1) on conflict do nothing;
  end if;
  -- 141. やつれる ⇔ やせ衰える
  select id into w1 from public.words where deck_id=d_n1 and (headword='やつれる' or reading='やつれる') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='やせ衰える' or reading='やせ衰える') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'やつれる(여위다, 수척해지다)≒やせ衰える(야위어 쇠약해지다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'やせ衰える(야위어 쇠약해지다)≒やつれる(여위다, 수척해지다)', 1) on conflict do nothing;
  end if;
  -- 142. わずらわしい ⇔ 面倒な
  select id into w1 from public.words where deck_id=d_n1 and (headword='わずらわしい' or reading='わずらわしい') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='面倒な' or reading='面倒な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'わずらわしい(귀찮다, 성가시다, 번거롭다)≒面倒な(귀찮은, 성가신)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '面倒な(귀찮은, 성가신)≒わずらわしい(귀찮다, 성가시다, 번거롭다)', 1) on conflict do nothing;
  end if;
  -- 143. スポット ⇔ 場所
  select id into w1 from public.words where deck_id=d_n1 and (headword='スポット' or reading='スポット') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='場所' or reading='場所') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'スポット(스폿, 장소)≒場所(장소)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '場所(장소)≒スポット(스폿, 장소)', 1) on conflict do nothing;
  end if;
  -- 144. 不慮の ⇔ 思いがけない
  select id into w1 from public.words where deck_id=d_n1 and (headword='不慮の' or reading='不慮の') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='思いがけない' or reading='思いがけない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '不慮の(뜻밖의, 예상 밖의, 불의의)≒思いがけない(뜻밖이다, 생각지 못하다, 예상 밖이다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '思いがけない(뜻밖이다, 생각지 못하다, 예상 밖이다)≒不慮の(뜻밖의, 예상 밖의, 불의의)', 1) on conflict do nothing;
  end if;
  -- 145. 奮闘する ⇔ 必死に頑張る
  select id into w1 from public.words where deck_id=d_n1 and (headword='奮闘する' or reading='奮闘する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='必死に頑張る' or reading='必死に頑張る') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '奮闘する(분투하다)≒必死に頑張る(필사적으로 분발하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '必死に頑張る(필사적으로 분발하다)≒奮闘する(분투하다)', 1) on conflict do nothing;
  end if;
  -- 146. 尺度 ⇔ 基準
  select id into w1 from public.words where deck_id=d_n1 and (headword='尺度' or reading='尺度') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='基準' or reading='基準') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '尺度(척도, 기준)≒基準(기준)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '基準(기준)≒尺度(척도, 기준)', 1) on conflict do nothing;
  end if;
  -- 147. 懸念する ⇔ 心配する
  select id into w1 from public.words where deck_id=d_n1 and (headword='懸念する' or reading='懸念する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='心配する' or reading='心配する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '懸念する(걱정하다, 우려하다)≒心配する(걱정하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '心配する(걱정하다)≒懸念する(걱정하다, 우려하다)', 1) on conflict do nothing;
  end if;
  -- 148. 拮抗する ⇔ 差がない
  select id into w1 from public.words where deck_id=d_n1 and (headword='拮抗する' or reading='拮抗する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='差がない' or reading='差がない') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '拮抗する(팽팽하다, 우열을 가릴 수 없다)≒差がない(차이가 없다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '差がない(차이가 없다)≒拮抗する(팽팽하다, 우열을 가릴 수 없다)', 1) on conflict do nothing;
  end if;
  -- 149. 根こそぎ ⇔ すべて
  select id into w1 from public.words where deck_id=d_n1 and (headword='根こそぎ' or reading='根こそぎ') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='すべて' or reading='すべて') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '根こそぎ(전부, 모조리, 몽땅)≒すべて(모두)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'すべて(모두)≒根こそぎ(전부, 모조리, 몽땅)', 1) on conflict do nothing;
  end if;
  -- 150. 没頭する ⇔ 熱中する
  select id into w1 from public.words where deck_id=d_n1 and (headword='没頭する' or reading='没頭する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='熱中する' or reading='熱中する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '没頭する(몰두하다)≒熱中する(열중하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '熱中する(열중하다)≒没頭する(몰두하다)', 1) on conflict do nothing;
  end if;
  -- 151. 温和な ⇔ おだやかな
  select id into w1 from public.words where deck_id=d_n1 and (headword='温和な' or reading='温和な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='おだやかな' or reading='おだやかな') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '温和な(온화한)≒おだやかな(온화한, 평온한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'おだやかな(온화한, 평온한)≒温和な(온화한)', 1) on conflict do nothing;
  end if;
  -- 152. 肝心な ⇔ 重要な
  select id into w1 from public.words where deck_id=d_n1 and (headword='肝心な' or reading='肝心な') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='重要な' or reading='重要な') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '肝心な(가장 중요한)≒重要な(중요한)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '重要な(중요한)≒肝心な(가장 중요한)', 1) on conflict do nothing;
  end if;
  -- 153. 調達する ⇔ 用意する
  select id into w1 from public.words where deck_id=d_n1 and (headword='調達する' or reading='調達する') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='用意する' or reading='用意する') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '調達する(조달하다)≒用意する(준비하다)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '用意する(준비하다)≒調達する(조달하다)', 1) on conflict do nothing;
  end if;
  -- 154. 風当たり ⇔ 批判
  select id into w1 from public.words where deck_id=d_n1 and (headword='風当たり' or reading='風当たり') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='批判' or reading='批判') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '風当たり(비난)≒批判(비판)', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '批判(비판)≒風当たり(비난)', 1) on conflict do nothing;
  end if;

  -- ==== 문법 ＝ 페어 ====
  -- G1. ～んなら ⇔ ～のなら
  select id into w1 from public.words where deck_id=d_n1 and (headword='～んなら' or reading='～んなら') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='～のなら' or reading='～のなら') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '～んなら(＝のなら) 격식체 가정 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '～んなら(＝のなら) 격식체 가정 단축', 1) on conflict do nothing;
  end if;
  -- G2. ～って ⇔ ～という
  select id into w1 from public.words where deck_id=d_n1 and (headword='～って' or reading='～って') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='～という' or reading='～という') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '～って(＝という) 회화체 인용 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '～って(＝という) 회화체 인용 단축', 1) on conflict do nothing;
  end if;
  -- G3. ～と ⇔ ～でも
  select id into w1 from public.words where deck_id=d_n1 and (headword='～と' or reading='～と') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='～でも' or reading='～でも') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '～と(＝でも) 양보 가정 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '～と(＝でも) 양보 가정 단축', 1) on conflict do nothing;
  end if;
  -- G4. ～には ⇔ ～にとっては
  select id into w1 from public.words where deck_id=d_n1 and (headword='～には' or reading='～には') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='～にとっては' or reading='～にとっては') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '～には(＝にとっては) 대상 한정 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '～には(＝にとっては) 대상 한정 단축', 1) on conflict do nothing;
  end if;
  -- G5. ～との ⇔ ～という
  select id into w1 from public.words where deck_id=d_n1 and (headword='～との' or reading='～との') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='～という' or reading='～という') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', '～との(＝という) 인용 격식체 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', '～との(＝という) 인용 격식체 단축', 1) on conflict do nothing;
  end if;
  -- G6. どうだって ⇔ どうでも
  select id into w1 from public.words where deck_id=d_n1 and (headword='どうだって' or reading='どうだって') limit 1;
  select id into w2 from public.words where deck_id=d_n1 and (headword='どうでも' or reading='どうでも') limit 1;
  if w1 is not null and w2 is not null and w1 <> w2 then
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w1, w2, 'synonym', 'どうだって(＝どうでも) 회화체 단축', 1) on conflict do nothing;
    insert into public.word_relations (word_id, related_word_id, relation_type, explanation, order_index) values
      (w2, w1, 'synonym', 'どうだって(＝どうでも) 회화체 단축', 1) on conflict do nothing;
  end if;
end $$;