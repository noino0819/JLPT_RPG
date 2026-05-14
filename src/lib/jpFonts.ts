// ──────────────────────────────────────────────────────────────────
// 일본어 단어/카나 표시 폰트 옵션 정의 + 동적 로더.
//
// 모든 폰트는 Google Fonts 에서 제공되는 일본어 픽셀/레트로 글꼴이며
// 히라가나 + 가타카나 + 한자(부분) 를 모두 지원한다.
// 사용자가 설정에서 선택한 폰트를 :root 의 CSS 변수
// `--jp-font-family` 로 노출하고, .pixel-text-jp 가 이를 사용한다.
// ──────────────────────────────────────────────────────────────────

import type { JpFontId } from "../types";

export interface JpFontOption {
  id: JpFontId;
  // UI 라벨 (한국어) — 일본어 폰트는 한글을 지원하지 않으므로 픽셀 폰트로 표시.
  label: string;
  // 폰트 자체로 표기되는 일본어 라벨(가타카나/한자) — 카드에서 폰트 효과 확인용.
  jpLabel: string;
  // 한 줄 설명
  description: string;
  // CSS font-family 스택 — 항상 "Noto Sans JP", monospace 로 폴백
  family: string;
  // Google Fonts 동적 로더가 사용할 stylesheet href.
  // null 이면 외부 로드가 필요 없는 시스템 폰트(혹은 이미 인덱스 css 에서 로드됨).
  googleHref: string | null;
}

// 폰트 카드 미리보기에 공통으로 사용할 일본어 샘플 (학습 앱 컨셉에 맞춰 "漢字").
// 한자 1글자 + 가나 읽기 조합이라 모든 폰트에서 글꼴 차이를 확인하기 좋다.
export const JP_FONT_PREVIEW = {
  headword: "漢字",
  reading: "かんじ",
} as const;

// CSS 변수에 들어갈 폴백 스택 — 어떤 폰트든 한자 누락 시 Noto Sans JP 가 받쳐준다.
const FALLBACK = `"Noto Sans JP", monospace`;

export const JP_FONTS: Record<JpFontId, JpFontOption> = {
  dotgothic16: {
    id: "dotgothic16",
    label: "도트픽셀 (기본)",
    jpLabel: "ドット",
    description: "8비트 도트 매트릭스 픽셀 글꼴",
    family: `"DotGothic16", ${FALLBACK}`,
    // index.css 에서 이미 import 하므로 추가 로드 불필요
    googleHref: null,
  },
  train_one: {
    id: "train_one",
    label: "트레인 (굵은 블럭)",
    jpLabel: "トレイン",
    description: "굵직한 블럭형 픽셀 — 강한 임팩트",
    family: `"Train One", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Train+One&display=swap",
  },
  stick: {
    id: "stick",
    label: "스틱 (얇은 선)",
    jpLabel: "スティック",
    description: "얇은 선으로 된 미니멀 글꼴",
    family: `"Stick", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Stick&display=swap",
  },
  reggae_one: {
    id: "reggae_one",
    label: "레게 (강한 굴림)",
    jpLabel: "レゲエ",
    description: "두껍고 동글동글한 팝 스타일",
    family: `"Reggae One", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Reggae+One&display=swap",
  },
  yusei_magic: {
    id: "yusei_magic",
    label: "유세이 (손글씨)",
    jpLabel: "ユウセイ",
    description: "정겨운 손글씨 느낌의 레트로 글꼴",
    family: `"Yusei Magic", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap",
  },
  hachi_maru_pop: {
    id: "hachi_maru_pop",
    label: "하치마루팝 (둥근)",
    jpLabel: "ハチマル",
    description: "동글동글 귀여운 팝 글꼴",
    family: `"Hachi Maru Pop", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&display=swap",
  },
};

export const JP_FONT_OPTIONS: JpFontOption[] = Object.values(JP_FONTS);

// 동일한 stylesheet 를 중복 삽입하지 않기 위한 캐시.
const loadedHrefs = new Set<string>();

/**
 * 지정한 폰트의 Google Fonts stylesheet 를 한 번만 <head> 에 주입한다.
 * SSR 환경(document 미존재)에서는 무시한다.
 */
export function ensureJpFontLoaded(id: JpFontId): void {
  if (typeof document === "undefined") return;
  const opt = JP_FONTS[id];
  if (!opt || !opt.googleHref) return;
  if (loadedHrefs.has(opt.googleHref)) return;

  // 이미 같은 href 의 link 가 있다면 (예: HMR 후) 캐시만 업데이트.
  const existing = document.querySelector<HTMLLinkElement>(
    `link[rel="stylesheet"][href="${opt.googleHref}"]`,
  );
  if (existing) {
    loadedHrefs.add(opt.googleHref);
    return;
  }

  const link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = opt.googleHref;
  link.dataset.jpFont = id;
  document.head.appendChild(link);
  loadedHrefs.add(opt.googleHref);
}

/**
 * 선택된 일본어 폰트를 :root 의 CSS 변수 `--jp-font-family` 로 적용한다.
 * 알 수 없는 id 가 들어오면 기본 폰트(dotgothic16)로 폴백.
 */
export function applyJpFont(id: JpFontId): void {
  if (typeof document === "undefined") return;
  const opt = JP_FONTS[id] ?? JP_FONTS.dotgothic16;
  ensureJpFontLoaded(opt.id);
  document.documentElement.style.setProperty("--jp-font-family", opt.family);
}

// 모든 옵션 폰트를 하나의 Google Fonts URL 로 묶어 가져오는 stylesheet href.
// index.html 에서 동일 href 의 <link> 를 미리 로드하지만, 안전망으로 동적 주입
// 함수도 제공한다(테스트/스토리북/캐시 미스 등 대비).
const ALL_JP_FONTS_HREF =
  "https://fonts.googleapis.com/css2" +
  "?family=DotGothic16" +
  "&family=Train+One" +
  "&family=Stick" +
  "&family=Reggae+One" +
  "&family=Yusei+Magic" +
  "&family=Hachi+Maru+Pop" +
  "&display=swap";

/**
 * 6종 일본어 폰트 stylesheet 가 DOM 에 없다면 주입한다.
 * index.html 이 이미 같은 href 의 <link> 를 가지고 있으면 no-op.
 */
export function ensureAllJpFontsLoaded(): void {
  if (typeof document === "undefined") return;

  const existing = document.querySelector<HTMLLinkElement>(
    `link[rel="stylesheet"][href="${ALL_JP_FONTS_HREF}"]`,
  );
  if (existing) return;

  const link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = ALL_JP_FONTS_HREF;
  link.dataset.jpFontAll = "true";
  document.head.appendChild(link);
}

/**
 * 6종 폰트의 미리보기 글리프(漢字/かんじ/가타카나 라벨)를 명시적으로 다운로드.
 *
 * Google Fonts 는 stylesheet CSS 만 받아오면 woff 파일은 실제로 텍스트가 그려질
 * 때 lazy 다운로드한다. font-display: swap 으로 결국 swap 되긴 하지만, 사용자에게
 * "지금 폰트가 적용된 게 맞는가?" 의 혼란을 줄이기 위해 woff 까지 명시적으로 받고
 * 모두 끝나면 ready 를 알려준다.
 */
export async function loadAllJpFontsForPreview(): Promise<void> {
  if (typeof document === "undefined" || !document.fonts) return;
  const text = `${JP_FONT_PREVIEW.headword}${JP_FONT_PREVIEW.reading}`;
  await Promise.all(
    JP_FONT_OPTIONS.map((opt) => {
      // family 스택 중 첫 번째 family 만 추출하여 명시적으로 로드.
      // ex) `"Train One", "Noto Sans JP", monospace` → `"Train One"`
      const primary = opt.family.split(",")[0]?.trim() ?? "";
      if (!primary) return Promise.resolve([] as FontFace[]);
      // 라벨(가타카나) + 미리보기(한자/가나) 모두 같은 woff subset 안에 있음.
      const sample = `${text}${opt.jpLabel}`;
      return document.fonts.load(`1em ${primary}`, sample).catch(() => []);
    }),
  );
}
