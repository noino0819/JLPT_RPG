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

// ─────────────────────────────────────────────────────────────────────
// 직업별 공격 사운드 (가벼운 한 방 — 처치 사운드보다 짧고 임팩트가 약함)
// ─────────────────────────────────────────────────────────────────────

/** 직업별 일반 공격 사운드 — "외운 것 같아요" 등 가벼운 히트 시. */
export function playAttack(id: CharacterId): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  switch (id) {
    case "warrior":
      playWarriorAttack(ac, t);
      break;
    case "mage":
      playMageAttack(ac, t);
      break;
    case "archer":
      playArcherAttack(ac, t);
      break;
    case "summoner":
      playSummonerAttack(ac, t);
      break;
  }
}

// 전사: 빠른 검 휘두름 (짧은 노이즈 스윙 + 작은 메탈 탭)
function playWarriorAttack(ac: AudioContext, t: number) {
  noise(ac, t, 0.09, {
    gain: 0.18,
    filterFrom: 6000,
    filterTo: 1500,
    filterQ: 0.7,
  });
  tone(ac, 220, t + 0.06, 0.08, {
    type: "sawtooth",
    gain: 0.12,
    sweepTo: 140,
  });
}

// 마법사: 짧은 2음 상승 + 스파클 한 점
function playMageAttack(ac: AudioContext, t: number) {
  tone(ac, 659.25, t, 0.12, { type: "triangle", gain: 0.14 }); // E5
  tone(ac, 880.0, t + 0.05, 0.16, { type: "triangle", gain: 0.14 }); // A5
  tone(ac, 2637, t + 0.08, 0.18, { type: "sine", gain: 0.07 });
}

// 궁수: 활시위 트왕 + 화살 슝
function playArcherAttack(ac: AudioContext, t: number) {
  // 활시위 (낮은 square pluck)
  tone(ac, 200, t, 0.06, { type: "square", gain: 0.16, sweepTo: 100 });
  // 화살 슝 (필터 노이즈)
  noise(ac, t + 0.02, 0.18, {
    gain: 0.14,
    filterFrom: 4000,
    filterTo: 600,
    filterQ: 1.2,
  });
}

// 소환사: 짧은 2음 화음 + 미세한 wisp
function playSummonerAttack(ac: AudioContext, t: number) {
  tone(ac, 329.63, t, 0.28, { type: "sine", gain: 0.1, attack: 0.02 }); // E4
  tone(ac, 493.88, t, 0.28, { type: "sine", gain: 0.09, attack: 0.02 }); // B4
  noise(ac, t + 0.04, 0.2, {
    gain: 0.05,
    filterFrom: 1500,
    filterTo: 400,
  });
}

// ─────────────────────────────────────────────────────────────────────
// 직업별 처치 사운드 (마무리 일격 — 풍부한 잔향 + 임팩트)
// ─────────────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────────────
// UI 인터랙션 사운드
// ─────────────────────────────────────────────────────────────────────

/**
 * 보관함(🔖) 토글 사운드.
 * - on: 책 펼치는 듯한 짧은 상승 2음 + 페이지 노이즈
 * - off: 책 덮는 듯한 짧은 하강 2음
 */
export function playFlag(on: boolean): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  if (on) {
    tone(ac, 660, t, 0.07, { type: "triangle", gain: 0.13 });
    tone(ac, 990, t + 0.05, 0.09, { type: "triangle", gain: 0.13 });
    // 종이 펄럭이는 짧은 노이즈
    noise(ac, t + 0.02, 0.06, {
      gain: 0.06,
      filterFrom: 4000,
      filterTo: 1500,
    });
  } else {
    tone(ac, 990, t, 0.07, { type: "triangle", gain: 0.11 });
    tone(ac, 660, t + 0.05, 0.09, { type: "triangle", gain: 0.11 });
    noise(ac, t + 0.02, 0.05, {
      gain: 0.05,
      filterFrom: 3000,
      filterTo: 1000,
    });
  }
}

/** "다음" 버튼 — 매우 가벼운 페이지 넘김 whoosh. */
export function playSkip(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  noise(ac, t, 0.09, {
    gain: 0.07,
    filterFrom: 2400,
    filterTo: 800,
    filterQ: 0.6,
  });
  tone(ac, 520, t + 0.01, 0.05, { type: "triangle", gain: 0.05 });
}

/**
 * 해금 팡파레 — 새 코스튬/펫/뱃지 등이 해금됐을 때.
 * 짧고 산뜻한 4음 아르페지오 + 스파클.
 */
export function playUnlock(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  // C5 - E5 - G5 - C6 (메이저 트라이어드 + 옥타브)
  const notes = [
    { f: 523.25, o: 0.0 },
    { f: 659.25, o: 0.07 },
    { f: 783.99, o: 0.14 },
    { f: 1046.5, o: 0.22 },
  ];
  for (const n of notes) {
    tone(ac, n.f, t + n.o, 0.32, { type: "triangle", gain: 0.14 });
  }
  // 마지막 sparkle
  tone(ac, 2093, t + 0.28, 0.5, { type: "sine", gain: 0.08 });
  tone(ac, 2637, t + 0.32, 0.5, { type: "sine", gain: 0.06 });
}

// ─────────────────────────────────────────────────────────────────────
// 미리듣기
// ─────────────────────────────────────────────────────────────────────

/** 사용자가 토글을 켜면 호출 — 미리듣기 용 (공격 → 처치 시퀀스). */
export function playPreview(id: CharacterId): void {
  playAttack(id);
  // 공격 사운드의 자연스러운 잔향 뒤에 처치 사운드 이어 재생
  window.setTimeout(() => playDefeat(id), 380);
}
