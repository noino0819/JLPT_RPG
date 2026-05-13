"""
네이버 로그인용 140x140 PNG 로고 생성 스크립트.

- 디자인 출처: public/apple-touch-icon.svg (32x32 viewBox, 던전 배경 + 룬 후광 + 픽셀 검).
- 32x32 픽셀 그리드를 4x 스케일업한 128x128 픽셀 아트를 만든 뒤,
  140x140 캔버스 중앙에 6px 패딩으로 배치한다.
- 라운드 코너, 다크 그라데이션 배경, 청록색 라디얼 후광은 캔버스 전체(140x140)에
  벡터 방식으로 그려서 가장자리가 매끈하게 보이도록 한다.
- 결과물은 public/naver-logo.png 로 저장한다 (RGB, JPG/PNG/GIF 중 PNG 선택,
  네이버 요구 사양: 140x140, 500KB 이하).
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw

# 캔버스 / 픽셀 스케일 설정
CANVAS = 140  # 최종 PNG 크기 (네이버 권장 140x140)
GRID = 32  # apple-touch-icon viewBox 단위 (32x32)
SCALE = 4  # 픽셀당 4px → 32 * 4 = 128
PAD = (CANVAS - GRID * SCALE) // 2  # 6px (좌우/상하 패딩)
CORNER_RADIUS = round(6 / 32 * CANVAS)  # 26px


def _hex_to_rgb(hex_color: str) -> tuple[int, int, int]:
    """#rrggbb 문자열을 (r, g, b) 튜플로 변환."""
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) for i in (0, 2, 4))  # type: ignore[return-value]


def _blend(
    base: tuple[int, int, int],
    overlay: tuple[int, int, int],
    alpha: float,
) -> tuple[int, int, int]:
    """알파 블렌딩 (단순 over 합성). alpha 0.0 ~ 1.0."""
    return tuple(round(base[i] * (1 - alpha) + overlay[i] * alpha) for i in range(3))  # type: ignore[return-value]


def _draw_background(img: Image.Image) -> None:
    """다크 던전 그라데이션 배경 (위 #1a1428 → 아래 #0c0913) + 라운드 코너."""
    top = _hex_to_rgb("#1a1428")
    bottom = _hex_to_rgb("#0c0913")

    # 세로 그라데이션을 픽셀 단위로 직접 칠한다.
    px = img.load()
    assert px is not None
    for y in range(CANVAS):
        ratio = y / (CANVAS - 1)
        color = tuple(round(top[i] * (1 - ratio) + bottom[i] * ratio) for i in range(3))
        for x in range(CANVAS):
            px[x, y] = (*color, 255)

    # 라운드 코너 마스크: 사각형 밖 영역을 투명으로 만든다.
    mask = Image.new("L", (CANVAS, CANVAS), 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [(0, 0), (CANVAS - 1, CANVAS - 1)],
        radius=CORNER_RADIUS,
        fill=255,
    )
    img.putalpha(mask)


def _draw_halo(img: Image.Image) -> None:
    """중앙 청록색 라디얼 그라데이션 후광."""
    cx, cy = CANVAS // 2, CANVAS // 2
    radius = round(11 / 32 * CANVAS)  # SVG 의 r=11 → 약 48px
    glow_color = _hex_to_rgb("#33c4ff")

    px = img.load()
    assert px is not None
    for y in range(cy - radius, cy + radius + 1):
        if not (0 <= y < CANVAS):
            continue
        for x in range(cx - radius, cx + radius + 1):
            if not (0 <= x < CANVAS):
                continue
            dx, dy = x - cx, y - cy
            dist = (dx * dx + dy * dy) ** 0.5
            if dist >= radius:
                continue
            t = dist / radius  # 0(중심) ~ 1(가장자리)
            # SVG 의 stop: 0% → 0.55, 55% → 0.12, 100% → 0
            if t <= 0.55:
                alpha = 0.55 + (0.12 - 0.55) * (t / 0.55)
            else:
                alpha = 0.12 * (1 - (t - 0.55) / 0.45)
            r, g, b, a = px[x, y]
            blended = _blend((r, g, b), glow_color, alpha)
            px[x, y] = (*blended, a)


def _draw_sparkles(img: Image.Image) -> None:
    """배경 모서리에 살짝 깔린 노란/하늘색 반짝임."""
    sparkles: list[tuple[int, int, str, float]] = [
        (3, 4, "#f0c97c", 0.5),
        (28, 6, "#f0c97c", 0.6),
        (5, 27, "#f0c97c", 0.5),
        (26, 25, "#f0c97c", 0.6),
        (2, 14, "#7be3ff", 0.55),
        (29, 18, "#7be3ff", 0.55),
    ]
    px = img.load()
    assert px is not None
    for gx, gy, hex_color, alpha in sparkles:
        color = _hex_to_rgb(hex_color)
        # 32x32 그리드 좌표를 140x140 캔버스 좌표로 환산 (그리드 셀 크기 SCALE=4 + 패딩).
        x0 = PAD + gx * SCALE
        y0 = PAD + gy * SCALE
        for dy in range(SCALE):
            for dx in range(SCALE):
                x, y = x0 + dx, y0 + dy
                if not (0 <= x < CANVAS and 0 <= y < CANVAS):
                    continue
                r, g, b, a = px[x, y]
                blended = _blend((r, g, b), color, alpha)
                px[x, y] = (*blended, a)


# 픽셀 검 스프라이트 (32x32 viewBox 기준, translate(8, 8) 오프셋 적용 좌표)
# 각 항목: (그리드 x, y, 채움 색상). 좌표는 32x32 캔버스 기준.
SWORD_PIXELS: list[tuple[int, int, str]] = []

_OFFSET = 8  # apple-touch-icon.svg 의 <g transform="translate(8 8)">


def _add_sword_layer(coords: list[tuple[int, int]], color: str) -> None:
    """검 스프라이트의 한 색상 레이어를 SWORD_PIXELS 에 추가."""
    for x, y in coords:
        SWORD_PIXELS.append((x + _OFFSET, y + _OFFSET, color))


# 검 외곽선 (#0a0610)
_add_sword_layer(
    [
        (7, 1),
        (6, 2), (8, 2),
        (6, 3), (8, 3),
        (6, 4), (9, 4),
        (6, 5), (9, 5),
        (6, 6), (9, 6),
        (6, 7), (9, 7),
        (6, 8), (9, 8),
        (5, 9), (10, 9),
        (4, 10), (11, 10),
        (6, 11), (9, 11),
        (6, 12), (9, 12),
        (5, 13), (10, 13),
        (6, 14), (9, 14),
        (7, 15),
    ],
    "#0a0610",
)
# 검날 하이라이트 (#f2f6ff)
_add_sword_layer(
    [(7, 2), (7, 3), (8, 4), (8, 5), (8, 6), (8, 7), (8, 8)],
    "#f2f6ff",
)
# 검날 음영 (#9aa4c2)
_add_sword_layer(
    [(7, 4), (7, 5), (7, 6), (7, 7), (7, 8)],
    "#9aa4c2",
)
# 가드 어두운 금색 (#bd8434)
_add_sword_layer(
    [(6, 9), (7, 9), (9, 9), (5, 10), (10, 10)],
    "#bd8434",
)
# 가드 밝은 금색 (#f0c97c)
_add_sword_layer(
    [(8, 9), (6, 10), (7, 10), (8, 10), (9, 10)],
    "#f0c97c",
)
# 손잡이 어두운 갈색 (#5a2a14)
_add_sword_layer(
    [(7, 11), (7, 12)],
    "#5a2a14",
)
# 손잡이 밝은 갈색 (#a06a44)
_add_sword_layer(
    [(8, 11), (8, 12)],
    "#a06a44",
)
# 폼멜 청록 (#33c4ff)
_add_sword_layer(
    [(7, 13), (8, 13), (7, 14)],
    "#33c4ff",
)
# 폼멜 하이라이트 (#cdeeff)
_add_sword_layer(
    [(6, 13), (9, 13), (8, 14)],
    "#cdeeff",
)


def _draw_sword(img: Image.Image) -> None:
    """32x32 그리드 픽셀 검을 4x 스케일로 캔버스에 그린다."""
    draw = ImageDraw.Draw(img)
    for gx, gy, hex_color in SWORD_PIXELS:
        color = (*_hex_to_rgb(hex_color), 255)
        x0 = PAD + gx * SCALE
        y0 = PAD + gy * SCALE
        draw.rectangle(
            [(x0, y0), (x0 + SCALE - 1, y0 + SCALE - 1)],
            fill=color,
        )


def main() -> None:
    """모든 레이어를 순서대로 합성한 뒤 PNG 로 저장."""
    img = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))

    _draw_background(img)
    _draw_sparkles(img)
    _draw_halo(img)
    _draw_sword(img)

    # 네이버는 RGB JPG/PNG/GIF 만 허용 → 다크 배경 위에 합성한 RGB 로 저장.
    bg = Image.new("RGB", (CANVAS, CANVAS), _hex_to_rgb("#0c0913"))
    bg.paste(img, mask=img.split()[-1])

    out_path = Path(__file__).resolve().parent.parent / "public" / "naver-logo.png"
    bg.save(out_path, format="PNG", optimize=True)
    size_kb = out_path.stat().st_size / 1024
    print(f"saved {out_path} ({CANVAS}x{CANVAS}, {size_kb:.1f} KB)")


if __name__ == "__main__":
    main()
