import type { CharacterId } from "../types";

/**
 * Web Audio API 기반 8-bit 풍 효과음 헬퍼.
 * - 외부 오디오 파일 없이 즉석에서 톤을 합성해 가벼움.
 * - AudioContext 는 사용자 인터랙션 이후에 lazy 생성 (브라우저 자동재생 정책 회피).
 */

let ctx: AudioContext | null = null;

function getCtx(): AudioContext | null {
  if (typeof window === "undefined") return null;
  if (!ctx) {
    const Ctor =
      window.AudioContext ||
      (window as unknown as { webkitAudioContext?: typeof AudioContext })
        .webkitAudioContext;
    if (!Ctor) return null;
    try {
      ctx = new Ctor();
    } catch {
      return null;
    }
  }
  if (ctx.state === "suspended") {
    ctx.resume().catch(() => {
      /* ignore */
    });
  }
  return ctx;
}

// 단음 톤 (sine/triangle/square/sawtooth)
function tone(
  ac: AudioContext,
  freq: number,
  when: number,
  dur: number,
  opts: {
    type?: OscillatorType;
    gain?: number;
    attack?: number;
    sweepTo?: number;
  } = {},
) {
  const { type = "sine", gain = 0.18, attack = 0.005, sweepTo } = opts;
  const osc = ac.createOscillator();
  const g = ac.createGain();
  osc.type = type;
  osc.frequency.setValueAtTime(freq, when);
  if (sweepTo) {
    osc.frequency.exponentialRampToValueAtTime(
      Math.max(40, sweepTo),
      when + dur,
    );
  }
  osc.connect(g);
  g.connect(ac.destination);
  g.gain.setValueAtTime(0.0001, when);
  g.gain.exponentialRampToValueAtTime(gain, when + attack);
  g.gain.exponentialRampToValueAtTime(0.0001, when + dur);
  osc.start(when);
  osc.stop(when + dur + 0.02);
}

// 노이즈 (sword swing / arrow swoosh 등)
function noise(
  ac: AudioContext,
  when: number,
  dur: number,
  opts: {
    gain?: number;
    filterFrom?: number;
    filterTo?: number;
    filterQ?: number;
  } = {},
) {
  const { gain = 0.18, filterFrom, filterTo, filterQ = 1 } = opts;
  const sampleRate = ac.sampleRate;
  const bufferSize = Math.max(1, Math.floor(sampleRate * dur));
  const buffer = ac.createBuffer(1, bufferSize, sampleRate);
  const data = buffer.getChannelData(0);
  for (let i = 0; i < bufferSize; i++) {
    data[i] = Math.random() * 2 - 1;
  }
  const src = ac.createBufferSource();
  src.buffer = buffer;
  const g = ac.createGain();
  g.gain.setValueAtTime(gain, when);
  g.gain.exponentialRampToValueAtTime(0.0001, when + dur);

  if (filterFrom !== undefined) {
    const filter = ac.createBiquadFilter();
    filter.type = "lowpass";
    filter.Q.value = filterQ;
    filter.frequency.setValueAtTime(filterFrom, when);
    if (filterTo !== undefined) {
      filter.frequency.exponentialRampToValueAtTime(
        Math.max(40, filterTo),
        when + dur,
      );
    }
    src.connect(filter);
    filter.connect(g);
  } else {
    src.connect(g);
  }
  g.connect(ac.destination);
  src.start(when);
  src.stop(when + dur + 0.02);
}

/** 단어 액션(외운것같아요/플래그/스킵) 시 가벼운 8-bit 클릭. */
export function playClick(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  tone(ac, 880, t, 0.06, { type: "square", gain: 0.08 });
  tone(ac, 1320, t + 0.02, 0.05, { type: "square", gain: 0.05 });
}

/** 직업별 처치 사운드 — 캐릭터 컨셉에 맞춰 차별화. */
export function playDefeat(id: CharacterId): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  switch (id) {
    case "warrior":
      playWarriorDefeat(ac, t);
      break;
    case "mage":
      playMageDefeat(ac, t);
      break;
    case "archer":
      playArcherDefeat(ac, t);
      break;
    case "summoner":
      playSummonerDefeat(ac, t);
      break;
  }
}

// 전사: 칼날 스윙(노이즈) → 금속 임팩트 + 종소리 잔향
function playWarriorDefeat(ac: AudioContext, t: number) {
  // swing (filtered noise high→low)
  noise(ac, t, 0.16, {
    gain: 0.22,
    filterFrom: 5000,
    filterTo: 800,
    filterQ: 0.8,
  });
  // metal clang (sharp saw burst)
  tone(ac, 320, t + 0.13, 0.22, {
    type: "sawtooth",
    gain: 0.18,
    sweepTo: 110,
  });
  // bell shimmer (high triangle)
  tone(ac, 1320, t + 0.14, 0.45, { type: "triangle", gain: 0.13 });
  tone(ac, 1980, t + 0.16, 0.45, { type: "triangle", gain: 0.09 });
}

// 마법사: 4음 상승 아르페지오 + 마지막 음 잔향
function playMageDefeat(ac: AudioContext, t: number) {
  const notes = [
    { f: 659.25, o: 0.0 }, // E5
    { f: 783.99, o: 0.06 }, // G5
    { f: 987.77, o: 0.12 }, // B5
    { f: 1318.5, o: 0.18 }, // E6
  ];
  for (const n of notes) {
    tone(ac, n.f, t + n.o, 0.3, { type: "triangle", gain: 0.16 });
  }
  // sparkle shimmer
  tone(ac, 2637, t + 0.22, 0.5, { type: "sine", gain: 0.08 });
  tone(ac, 3136, t + 0.26, 0.5, { type: "sine", gain: 0.06 });
}

// 궁수: 화살 슝(필터 노이즈) → 꽂히는 thunk
function playArcherDefeat(ac: AudioContext, t: number) {
  // arrow swoosh
  noise(ac, t, 0.22, {
    gain: 0.18,
    filterFrom: 3000,
    filterTo: 500,
    filterQ: 1.5,
  });
  // 두 번째 화살(시간차)
  noise(ac, t + 0.1, 0.18, {
    gain: 0.14,
    filterFrom: 2500,
    filterTo: 400,
  });
  // thunk impact (low square pluck)
  tone(ac, 140, t + 0.2, 0.18, {
    type: "square",
    gain: 0.2,
    sweepTo: 70,
  });
  // small high "tip" overtone
  tone(ac, 1760, t + 0.21, 0.12, { type: "triangle", gain: 0.08 });
}

// 소환사: 차분한 화음 + 천천히 사라지는 잔향
function playSummonerDefeat(ac: AudioContext, t: number) {
  const chord = [
    { f: 329.63, g: 0.12 }, // E4
    { f: 493.88, g: 0.1 }, // B4
    { f: 659.25, g: 0.1 }, // E5
    { f: 987.77, g: 0.09 }, // B5
  ];
  for (const c of chord) {
    tone(ac, c.f, t, 0.7, { type: "sine", gain: c.g, attack: 0.04 });
  }
  // ethereal up-glide
  tone(ac, 880, t + 0.05, 0.6, {
    type: "triangle",
    gain: 0.08,
    sweepTo: 1760,
  });
  // 짧은 wisp noise tail
  noise(ac, t + 0.1, 0.4, {
    gain: 0.06,
    filterFrom: 2000,
    filterTo: 600,
  });
}

/** 사용자가 토글을 켜면 호출 — 미리듣기 용. */
export function playPreview(id: CharacterId): void {
  playDefeat(id);
}
