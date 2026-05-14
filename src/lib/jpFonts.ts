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
  // UI 라벨 (한국어)
  label: string;
  // 한 줄 설명
  description: string;
  // 미리보기에 사용할 일본어 샘플
  sample: string;
  // CSS font-family 스택 — 항상 "Noto Sans JP", monospace 로 폴백
  family: string;
  // Google Fonts 동적 로더가 사용할 stylesheet href.
  // null 이면 외부 로드가 필요 없는 시스템 폰트(혹은 이미 인덱스 css 에서 로드됨).
  googleHref: string | null;
}

// CSS 변수에 들어갈 폴백 스택 — 어떤 폰트든 한자 누락 시 Noto Sans JP 가 받쳐준다.
const FALLBACK = `"Noto Sans JP", monospace`;

export const JP_FONTS: Record<JpFontId, JpFontOption> = {
  dotgothic16: {
    id: "dotgothic16",
    label: "도트픽셀 (기본)",
    description: "8비트 도트 매트릭스 픽셀 글꼴",
    sample: "あア漢字",
    family: `"DotGothic16", ${FALLBACK}`,
    // index.css 에서 이미 import 하므로 추가 로드 불필요
    googleHref: null,
  },
  train_one: {
    id: "train_one",
    label: "트레인 (굵은 블럭)",
    description: "굵직한 블럭형 픽셀 — 강한 임팩트",
    sample: "あア漢字",
    family: `"Train One", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Train+One&display=swap",
  },
  stick: {
    id: "stick",
    label: "스틱 (얇은 선)",
    description: "얇은 선으로 된 미니멀 글꼴",
    sample: "あア漢字",
    family: `"Stick", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Stick&display=swap",
  },
  reggae_one: {
    id: "reggae_one",
    label: "레게 (강한 굴림)",
    description: "두껍고 동글동글한 팝 스타일",
    sample: "あア漢字",
    family: `"Reggae One", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Reggae+One&display=swap",
  },
  yusei_magic: {
    id: "yusei_magic",
    label: "유세이 (손글씨)",
    description: "정겨운 손글씨 느낌의 레트로 글꼴",
    sample: "あア漢字",
    family: `"Yusei Magic", ${FALLBACK}`,
    googleHref:
      "https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap",
  },
  hachi_maru_pop: {
    id: "hachi_maru_pop",
    label: "하치마루팝 (귀여운 둥근)",
    description: "동글동글 귀여운 팝 글꼴",
    sample: "あア漢字",
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
