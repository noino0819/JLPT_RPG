"""
PDF 텍스트 추출 스크립트.
pypdf 와 pdfplumber 두 가지 방식으로 추출 결과를 비교/저장한다.
"""

import sys
from pathlib import Path

PDF = Path("/Users/noino/Downloads/일단합격JLPT완벽대비N2-단어장.pdf")
OUT_DIR = Path(__file__).parent

import pypdf

reader = pypdf.PdfReader(str(PDF))
print(f"pages: {len(reader.pages)}")

texts = []
for i, page in enumerate(reader.pages):
    t = page.extract_text() or ""
    texts.append(f"-- {i + 1} of {len(reader.pages)} --\n{t}")

(OUT_DIR / "raw_text.txt").write_text("\n".join(texts), encoding="utf-8")
print("wrote", OUT_DIR / "raw_text.txt", "size", (OUT_DIR / "raw_text.txt").stat().st_size)
