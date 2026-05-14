/**
 * 일본어 텍스트 음성 합성(TTS) 헬퍼.
 *
 * - 브라우저 내장 Web Speech API(`window.speechSynthesis`) 사용 → 무료/오프라인.
 * - 외부 API 키 / 서버리스 함수 / 의존성 추가 없이 동작.
 * - 음성 품질은 OS 내장 일본어 보이스에 의존(macOS/iOS Kyoko·Otoya, Android Google 日本語, Windows Haruka 등).
 *
 * 사용 예:
 *   if (isTtsAvailable()) speakJa("勉強します", { rate: 0.9 });
 *
 * 주의:
 * - SpeechSynthesis는 모바일 브라우저에서 첫 사용자 인터랙션 이후에만 동작하는 경우가 많다.
 * - voices 목록은 `voiceschanged` 이벤트 발생 후에 채워지는 경우가 있어 lazy 로 갱신한다.
 */

let cachedVoices: SpeechSynthesisVoice[] | null = null;
let cachedJaVoice: SpeechSynthesisVoice | null = null;

/** 브라우저가 Web Speech API 를 지원하는지. */
export function isTtsAvailable(): boolean {
  return (
    typeof window !== "undefined" &&
    "speechSynthesis" in window &&
    typeof window.SpeechSynthesisUtterance !== "undefined"
  );
}

/** 현재 로드된 모든 보이스. 비어 있으면 voiceschanged 한 번 기다린 뒤 재시도. */
function loadVoices(): SpeechSynthesisVoice[] {
  if (!isTtsAvailable()) return [];
  const list = window.speechSynthesis.getVoices();
  if (list && list.length > 0) {
    cachedVoices = list;
    return list;
  }
  return cachedVoices ?? [];
}

/** voiceschanged 이벤트를 한번이라도 받았는지 확인하기 위한 워밍업. */
function warmUpVoices(): void {
  if (!isTtsAvailable()) return;
  // Chrome/Safari 일부 버전은 첫 호출 시 voices 가 빈 배열로 반환되고
  // voiceschanged 이벤트 이후에야 실제 목록이 채워진다.
  const synth = window.speechSynthesis;
  const apply = () => {
    cachedVoices = synth.getVoices();
    cachedJaVoice = pickJaVoice(cachedVoices);
  };
  apply();
  synth.onvoiceschanged = apply;
}

if (typeof window !== "undefined") {
  warmUpVoices();
}

/** 일본어 보이스를 우선순위에 따라 선택. */
function pickJaVoice(
  voices: SpeechSynthesisVoice[],
): SpeechSynthesisVoice | null {
  if (!voices || voices.length === 0) return null;
  const ja = voices.filter((v) => /^ja(-|_|$)/i.test(v.lang));
  if (ja.length === 0) return null;
  // 선호 순: 1) Google 日本語  2) Kyoko / Otoya(고품질 macOS/iOS)  3) localService=true  4) 첫 번째
  const preferred =
    ja.find((v) => /google/i.test(v.name)) ??
    ja.find((v) => /(kyoko|otoya|hattori|nanami)/i.test(v.name)) ??
    ja.find((v) => v.localService) ??
    ja[0];
  return preferred ?? null;
}

/** 사용 가능한 일본어 보이스(있으면) — 캐시된 값 우선. */
export function getJaVoice(): SpeechSynthesisVoice | null {
  if (cachedJaVoice) return cachedJaVoice;
  cachedJaVoice = pickJaVoice(loadVoices());
  return cachedJaVoice;
}

/** 일본어 보이스가 하나라도 설치되어 있는지. */
export function hasJaVoice(): boolean {
  return getJaVoice() !== null;
}

export interface SpeakOptions {
  /** 0.5(느림) ~ 1.5(빠름). 기본 1.0 */
  rate?: number;
  /** 0(낮음) ~ 2(높음). 기본 1.0 */
  pitch?: number;
  /** 0(무음) ~ 1(최대). 기본 1.0 */
  volume?: number;
  /** 발화 종료 시 콜백. */
  onEnd?: () => void;
}

/**
 * 일본어 텍스트를 읽어준다.
 * - 진행 중인 발화는 중단 후 새 발화 시작 (사용자가 빠르게 다음 카드로 넘기는 케이스 대응).
 */
export function speakJa(text: string, opts: SpeakOptions = {}): void {
  if (!isTtsAvailable() || !text) return;
  const synth = window.speechSynthesis;

  try {
    synth.cancel();
  } catch {
    /* ignore */
  }

  const u = new SpeechSynthesisUtterance(text);
  u.lang = "ja-JP";
  const voice = getJaVoice();
  if (voice) u.voice = voice;
  u.rate = clamp(opts.rate ?? 1.0, 0.3, 2.0);
  u.pitch = clamp(opts.pitch ?? 1.0, 0.0, 2.0);
  u.volume = clamp(opts.volume ?? 1.0, 0.0, 1.0);
  if (opts.onEnd) {
    u.onend = opts.onEnd;
    u.onerror = opts.onEnd;
  }
  try {
    synth.speak(u);
  } catch {
    /* ignore */
  }
}

/** 진행 중인 모든 발화 중단. */
export function stopTts(): void {
  if (!isTtsAvailable()) return;
  try {
    window.speechSynthesis.cancel();
  } catch {
    /* ignore */
  }
}

function clamp(v: number, lo: number, hi: number): number {
  return Math.min(hi, Math.max(lo, v));
}
