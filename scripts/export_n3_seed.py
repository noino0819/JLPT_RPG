"""N3 시드 파일 생성 스크립트.

Supabase 데이터베이스에서 N3 단어와 예문을 가져와
`db/n3_seed.sql` 파일에 멱등성을 가진 SQL 형태로 저장합니다.
"""

import os
import sys
import psycopg2

DB_URL = (
    "postgres://postgres.rpyjfvabxdkyxpgvsnck:afPG4Ks0KGrAuDW9"
    "@aws-1-ap-northeast-2.pooler.supabase.com:5432/postgres?sslmode=require"
)

DECK_ID = "7e9dafac-45a5-43b2-8d9d-58e4a0526067"

HEADER = """-- ============================================================
-- JLPT N3 공식 덱 시드 (PDF: 일단합격JLPT완벽대비N3-단어장)
-- ============================================================
-- 실행 시 기존 N3 공식 덱의 단어/예문(CASCADE)을 모두 삭제 후 재삽입합니다.
-- 사용자 진행도(word_progress)도 함께 삭제됩니다.
-- 멱등성: 여러 번 실행해도 결과 동일.
-- 총 450단어, 900예문 (단어당 의미 2개, 한자어원 2개, 예문 2개)
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

"""

FOOTER = """
end $$;
"""


def quote_literal(text: str | None) -> str:
    """PostgreSQL의 quote_literal과 동일하게 문자열을 SQL 리터럴로 변환."""
    if text is None:
        return "null"
    escaped = text.replace("'", "''")
    return f"'{escaped}'"


def main() -> int:
    conn = psycopg2.connect(DB_URL)
    cur = conn.cursor()
    cur.execute(
        """
        select id, headword, reading, meaning, etymology, part_of_speech, order_index
        from public.words
        where deck_id = %s
        order by order_index
        """,
        (DECK_ID,),
    )
    words = cur.fetchall()

    lines: list[str] = [HEADER]
    for word_id, headword, reading, meaning, etymology, pos, order_index in words:
        display = headword if headword else reading
        lines.append(f"  -- {order_index}. {display}")
        lines.append(
            "  insert into public.words (deck_id, headword, reading, meaning, etymology, "
            "part_of_speech, order_index) values (d_n3, "
            f"{quote_literal(headword)}, "
            f"{quote_literal(reading)}, "
            f"{quote_literal(meaning)}, "
            f"{quote_literal(etymology)}, "
            f"{quote_literal(pos)}, "
            f"{order_index}) returning id into w;"
        )

        cur.execute(
            """
            select jp_sentence, kr_translation, order_index
            from public.examples
            where word_id = %s
            order by order_index
            """,
            (word_id,),
        )
        examples = cur.fetchall()
        if examples:
            lines.append(
                "  insert into public.examples (word_id, jp_sentence, kr_translation, "
                "order_index) values"
            )
            example_lines = [
                f"    (w, {quote_literal(jp)}, {quote_literal(kr)}, {idx})"
                for jp, kr, idx in examples
            ]
            lines.append(",\n".join(example_lines) + ";")
        lines.append("")

    lines.append(FOOTER)

    output_path = os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
        "db",
        "n3_seed.sql",
    )
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    cur.close()
    conn.close()
    print(f"Done. {len(words)} words exported to {output_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
