"""
N2 단어장 PDF 파싱 스크립트

PDF 의 텍스트를 읽어 (kanji, reading, meaning) 형태로 추출하고,
어휘 / 문법(～로 시작) 으로 카테고리를 나누어 JSON 으로 저장한다.
"""

import json
import re
import unicodedata
from pathlib import Path

PDF_TXT_PATH = Path(__file__).parent / "raw_text.txt"
OUTPUT_PATH = Path(__file__).parent / "parsed_words.json"

SKIP_LINE_PATTERNS = [
    re.compile(r"^--\s*\d+\s*of\s*\d+\s*--\s*$"),
    re.compile(r"^N·2·합·격$"),
    re.compile(r"^\d+$"),
]

SECTION_LABELS = {
    "한자 읽기", "한자 표기", "단어 형성", "문맥 규정", "문맥 이해",
    "용법", "유의 표현",
    "문법 형식 판단", "문장의 문법", "독해", "내용 이해",
    "단어 체크북", "문법 체크북", "파이널 단어 체크북", "파이널 문법 체크북",
    "본문에 수록된 기출 단어들을 정리해 두었습니다.",
    "본문에 수록된 기출 문법들을 정리해 두었습니다.",
    "합격을 결정하는 것은 바로 어휘력!",
    "문법을 정복하는 자가 시험을 정복한다!",
    "시험장에서 마지막으로 단어를 체크할 때, 활용하세요.",
    "시험장에서 마지막으로 문법 체크할 때, 활용하세요.",
    "파 이 널",
    "일단", "합격", "완벽 대비",
    "기본서 \t모의고사 \t단어장",
    "일본어능력시험",
    "N2",
    "단어장",
}

CATEGORY_RE = re.compile(
    r"^(한자 읽기|한자 표기|단어 형성|문맥 규정|문맥 이해|용법|유의 표현|문법 형식 판단|문장의 문법|독해|내용 이해)(\s*\t.*|\1)?$"
)

VOCAB_SECTIONS = {"한자 읽기", "한자 표기", "단어 형성", "문맥 규정", "문맥 이해", "용법", "유의 표현"}
GRAMMAR_SECTIONS = {"문법 형식 판단", "문장의 문법", "독해", "내용 이해"}


def char_kind(c: str) -> str:
    code = ord(c)
    if 0xAC00 <= code <= 0xD7A3 or 0x3131 <= code <= 0x318F:
        return "kr"
    if 0x3040 <= code <= 0x309F:
        return "hira"
    if 0x30A0 <= code <= 0x30FF:
        return "kata"
    if 0x4E00 <= code <= 0x9FFF:
        return "kanji"
    if c == "～" or c == "~":
        return "tilde"
    if c == "々":
        return "iter"  # 한자 반복 기호
    if c.isspace():
        return "space"
    return "other"


def has_korean(line: str) -> bool:
    return any(char_kind(c) == "kr" for c in line)


def is_pure_hiragana(s: str) -> bool:
    if not s:
        return False
    return all(char_kind(c) in ("hira",) for c in s)


def is_pure_katakana(s: str) -> bool:
    if not s:
        return False
    return all(char_kind(c) in ("kata",) for c in s)


def detect_category(line: str):
    s = line.strip()
    # 카테고리 헤더는 텍스트 추출 시 두 번 반복되어 나오는 케이스가 많음
    # ex) "한자 읽기한자 읽기"
    for cat in [
        "한자 읽기", "한자 표기", "단어 형성", "문맥 규정", "문맥 이해",
        "용법", "유의 표현", "문법 형식 판단", "문장의 문법", "독해", "내용 이해",
    ]:
        if s == cat or s == cat + cat or s.startswith(cat + "\t") or s.startswith(cat + " "):
            return cat
    return None


def is_skip_line(line: str) -> bool:
    s = line.strip()
    if not s:
        return True
    if s in SECTION_LABELS:
        return True
    if CATEGORY_RE.match(s):
        return True
    for pat in SKIP_LINE_PATTERNS:
        if pat.match(s):
            return True
    return False


def split_meaning_line(line: str):
    first_kr_idx = None
    for i, c in enumerate(line):
        if char_kind(c) == "kr":
            first_kr_idx = i
            break
    if first_kr_idx is None:
        return [line.strip()] if line.strip() else [], ""
    prefix = line[:first_kr_idx].rstrip()
    meaning = line[first_kr_idx:].strip()
    tokens = [prefix] if prefix else []
    return tokens, meaning


def parse_lines(lines):
    words = []
    buffer: list[str] = []
    current_section = None  # 현재 카테고리

    def flush(meaning_line: str):
        nonlocal buffer
        prefix_tokens, meaning = split_meaning_line(meaning_line)
        if not meaning:
            buffer = []
            return
        tokens = buffer + prefix_tokens
        buffer = []
        if not tokens:
            return
        word = build_word(tokens, meaning)
        if word is not None:
            word["section"] = current_section
            word["category"] = (
                "grammar" if (current_section in GRAMMAR_SECTIONS or word.get("is_grammar")) else "vocab"
            )
            words.append(word)

    for raw in lines:
        line = raw.rstrip("\n")
        cat = detect_category(line)
        if cat:
            current_section = cat
            buffer = []
            continue
        if is_skip_line(line):
            buffer = []
            continue
        if has_korean(line):
            flush(line)
            continue
        s = line.strip()
        if s:
            buffer.append(s)
    return words


def build_word(tokens: list[str], meaning: str):
    tokens = [t.strip() for t in tokens if t.strip()]
    if not tokens:
        return None

    is_grammar = any(("～" in t or "~" in t) for t in tokens)

    if len(tokens) == 1:
        t = tokens[0]
        if is_pure_hiragana(t) or is_pure_katakana(t):
            return {
                "headword": None,
                "reading": t,
                "meaning": meaning,
                "is_grammar": is_grammar,
            }
        return {
            "headword": t,
            "reading": _strip_for_reading(t) or None,
            "meaning": meaning,
            "is_grammar": is_grammar,
        }

    headword_parts: list[str] = []
    reading_parts: list[str] = []

    i = 0
    n = len(tokens)
    while i < n:
        chunk = tokens[i]
        if is_pure_hiragana(chunk) or is_pure_katakana(chunk):
            headword_parts.append(chunk)
            reading_parts.append(chunk)
            i += 1
            continue
        if i + 1 < n:
            furi = tokens[i + 1]
            if is_pure_hiragana(furi) or is_pure_katakana(furi):
                headword_parts.append(chunk)
                reading_parts.append(_chunk_reading(chunk, furi))
                i += 2
                continue
        headword_parts.append(chunk)
        reading_parts.append(_strip_for_reading(chunk) or chunk)
        i += 1

    headword = "".join(headword_parts).strip()
    reading = "".join(reading_parts).strip()
    return {
        "headword": headword if headword else None,
        "reading": reading if reading else None,
        "meaning": meaning,
        "is_grammar": is_grammar,
    }


def _strip_for_reading(s: str) -> str:
    return "".join(c for c in s if char_kind(c) in ("hira", "kata"))


def _chunk_reading(chunk: str, furi: str) -> str:
    has_kanji = any(char_kind(c) in ("kanji", "iter") for c in chunk)
    if not has_kanji:
        return chunk
    out = []
    kanji_replaced = False
    for c in chunk:
        k = char_kind(c)
        if k in ("kanji", "iter"):
            if not kanji_replaced:
                out.append(furi)
                kanji_replaced = True
        else:
            out.append(c)
    return "".join(out)


def _clean_text(s):
    if s is None:
        return None
    # 다양한 공백 문자를 일반 공백으로
    out = []
    for c in s:
        if c in ("\u2002", "\u2003", "\u00a0", "\u3000"):
            out.append(" ")
        else:
            out.append(c)
    return "".join(out).strip()


def _clean_word(w):
    h = _clean_text(w.get("headword"))
    r = _clean_text(w.get("reading"))
    m = _clean_text(w.get("meaning"))
    if h:
        # 후행 ~ / ~~ / 공백+~ 제거
        h = re.sub(r"\s*~+\s*$", "", h)
        h = re.sub(r"\s+", "", h)  # 일본어 단어 안의 공백 제거
        # 잘려 들어온 괄호 제거 (예: '務める(' → '務める')
        h = h.rstrip("(（")
    if r:
        # reading 의 끝에 붙은 ~ 도 제거 (예: '～しだい~' → '～しだい')
        r = re.sub(r"\s*~+\s*$", "", r)
        r = re.sub(r"\s+", "", r)
        # 표제어가 ～로 시작하는데 reading 이 ～가 없으면 추가
    # 문법 패턴인 경우 ～ 를 reading 시작에 보강
    is_g = w.get("is_grammar")
    if is_g and r and not r.startswith("～") and not r.startswith("~"):
        if h and h.startswith("～"):
            r = "～" + r
    if not h and r and (r.startswith("～") or r.startswith("~")):
        is_g = True
    # 의미에 닫는 괄호 ')' 만 있고 여는 괄호 '(' 가 없는 경우 보강.
    # 예) "임무를) 맡다, 노력하다" → "(임무를) 맡다, 노력하다"
    if m and ")" in m and "(" not in m:
        m = "(" + m
    w["headword"] = h or None
    w["reading"] = r or None
    w["meaning"] = m or ""
    w["is_grammar"] = bool(is_g)
    w["category"] = "grammar" if is_g else "vocab"
    return w


def main():
    raw = PDF_TXT_PATH.read_text(encoding="utf-8")
    raw = unicodedata.normalize("NFC", raw)
    lines = raw.splitlines()
    words = parse_lines(lines)
    words = [_clean_word(w) for w in words if w]

    # 의미가 없는 항목 (메타/잔여) 제거
    words = [w for w in words if w["meaning"] and (w["headword"] or w["reading"])]

    # 중복 제거
    seen = {}
    deduped = []
    for w in words:
        key = (w["headword"], w["reading"])
        if key in seen:
            continue
        seen[key] = True
        deduped.append(w)

    OUTPUT_PATH.write_text(
        json.dumps(deduped, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )

    by_cat = {}
    by_section = {}
    for w in deduped:
        by_cat[w["category"]] = by_cat.get(w["category"], 0) + 1
        by_section[w["section"]] = by_section.get(w["section"], 0) + 1

    print(f"총 추출 단어 수: {len(words)}")
    print(f"중복 제거 후: {len(deduped)}")
    print(f"카테고리별: {by_cat}")
    print(f"섹션별: {by_section}")
    print(f"-> {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
