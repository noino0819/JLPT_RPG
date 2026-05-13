"""
parsed_words.json + enrichment/*.tsv  →  n2_seed.sql 생성기

- 단어별 한자어원(etymology) 과 예문 2개를 enrichment 파일에서 읽어
  공식 N2 덱(d_n2) 에 INSERT 하는 SQL 을 만든다.
- enrichment TSV 형식 (탭 구분, 헤더 없음):
    headword<TAB>reading<TAB>meaning<TAB>part_of_speech<TAB>etymology<TAB>jp1<TAB>kr1<TAB>jp2<TAB>kr2
  * 일부 항목은 etymology 가 비어있을 수 있다(문법 패턴 등).
  * headword 가 없는 (히라가나/카타카나 only) 항목은 빈칸으로 둔다.
"""

import json
import re
from pathlib import Path

ROOT = Path(__file__).parent
PARSED_JSON = ROOT / "parsed_words.json"
ENRICH_DIR = ROOT / "enrichment"
OUT_SQL = ROOT / "n2_seed.sql"


def sql_quote(s: str | None) -> str:
    if s is None or s == "":
        return "NULL"
    return "'" + s.replace("'", "''") + "'"


def main():
    parsed = json.loads(PARSED_JSON.read_text(encoding="utf-8"))
    enrichment = {}

    if ENRICH_DIR.exists():
        for tsv_path in sorted(ENRICH_DIR.glob("*.tsv")):
            for line_no, raw in enumerate(tsv_path.read_text(encoding="utf-8").splitlines(), 1):
                line = raw.rstrip("\n")
                if not line.strip() or line.startswith("#"):
                    continue
                parts = line.split("\t")
                if len(parts) < 9:
                    print(f"⚠ {tsv_path.name}:{line_no} 컬럼 수 부족 ({len(parts)}): {line!r}")
                    continue
                headword = parts[0].strip() or None
                reading = parts[1].strip() or None
                meaning = parts[2].strip()
                pos = parts[3].strip() or None
                etym = parts[4].strip() or None
                jp1 = parts[5].strip()
                kr1 = parts[6].strip()
                jp2 = parts[7].strip()
                kr2 = parts[8].strip()
                key = (headword, reading)
                enrichment[key] = {
                    "meaning": meaning,
                    "part_of_speech": pos,
                    "etymology": etym,
                    "examples": [(jp1, kr1), (jp2, kr2)],
                }

    # 통계
    matched = 0
    missing = []
    for w in parsed:
        key = (w["headword"], w["reading"])
        if key in enrichment:
            matched += 1
        else:
            missing.append(key)

    print(f"전체 단어: {len(parsed)}")
    print(f"enrichment 매칭: {matched}")
    print(f"미매칭: {len(missing)}")

    # SQL 빌드
    lines = []
    lines.append("-- N2 (화산) 덱 시드 데이터 - 자동 생성됨")
    lines.append("-- 출처: 일단합격 JLPT 완벽대비 N2 단어장 PDF")
    lines.append("")
    lines.append("delete from public.examples")
    lines.append("  where word_id in (")
    lines.append("    select w.id from public.words w")
    lines.append("    join public.decks d on d.id = w.deck_id")
    lines.append("    where d.is_official and d.jlpt_level = 'N2'")
    lines.append("  );")
    lines.append("delete from public.words")
    lines.append("  where deck_id in (select id from public.decks where is_official and jlpt_level='N2');")
    lines.append("")
    lines.append("do $$")
    lines.append("declare")
    lines.append("  d_n2 uuid;")
    lines.append("  w uuid;")
    lines.append("begin")
    lines.append("  select id into d_n2 from public.decks where jlpt_level='N2' and is_official limit 1;")
    lines.append("")

    order_index = 0
    for w in parsed:
        order_index += 1
        key = (w["headword"], w["reading"])
        e = enrichment.get(key)
        if e is None:
            # enrichment 미존재 시 기본 정보만으로 INSERT
            meaning = w["meaning"]
            pos = None
            etym = None
            examples = []
        else:
            meaning = e["meaning"] or w["meaning"]
            pos = e["part_of_speech"]
            etym = e["etymology"]
            examples = [(jp, kr) for jp, kr in e["examples"] if jp and kr]

        lines.append(
            "  insert into public.words (deck_id, headword, reading, meaning, etymology, part_of_speech, order_index) "
            f"values (d_n2, {sql_quote(w['headword'])}, {sql_quote(w['reading'])}, "
            f"{sql_quote(meaning)}, {sql_quote(etym)}, {sql_quote(pos)}, {order_index})"
            + (" returning id into w;" if examples else ";")
        )
        for ex_idx, (jp, kr) in enumerate(examples, 1):
            lines.append(
                "  insert into public.examples (word_id, jp_sentence, kr_translation, order_index) "
                f"values (w, {sql_quote(jp)}, {sql_quote(kr)}, {ex_idx});"
            )

    lines.append("end $$;")
    lines.append("")

    OUT_SQL.write_text("\n".join(lines), encoding="utf-8")
    print(f"-> {OUT_SQL}")


if __name__ == "__main__":
    main()
