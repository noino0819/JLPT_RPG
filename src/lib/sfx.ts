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

// 소환사: 짧은 소환 종(triangle pluck) + 정령이 휘잉 날아드는 sweep + 가벼운 골드 임팩트
function playSummonerAttack(ac: AudioContext, t: number) {
  // 1) 소환을 알리는 작은 종 (밝은 triangle 아르페지오 — G5 → C6)
  tone(ac, 783.99, t, 0.1, { type: "triangle", gain: 0.13 });
  tone(ac, 1046.5, t + 0.05, 0.12, { type: "triangle", gain: 0.12 });
  // 2) 정령이 휙 — 음정이 살짝 올라가는 sine sweep
  tone(ac, 660, t + 0.06, 0.18, {
    type: "sine",
    gain: 0.08,
    sweepTo: 1320,
    attack: 0.01,
  });
  // 3) 정령이 적에게 부딪치는 작은 임팩트 (얇은 고음 노이즈)
  noise(ac, t + 0.16, 0.08, {
    gain: 0.1,
    filterFrom: 4000,
    filterTo: 1200,
    filterQ: 1.0,
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

// 소환사: 화려한 소환 종소리 → 정령 무리의 다중 휘잉 → 마무리 골드 임팩트
function playSummonerDefeat(ac: AudioContext, t: number) {
  // 1) 소환의 종 — 밝은 메이저 트라이어드 + 옥타브 (C5/E5/G5/C6)
  const summonChord = [
    { f: 523.25, g: 0.14 }, // C5
    { f: 659.25, g: 0.12 }, // E5
    { f: 783.99, g: 0.12 }, // G5
    { f: 1046.5, g: 0.1 }, // C6
  ];
  for (const c of summonChord) {
    tone(ac, c.f, t, 0.45, { type: "triangle", gain: c.g, attack: 0.01 });
  }
  // 2) 정령들이 적에게 달려드는 다중 sweep (시간차로 3마리)
  const flights = [
    { f: 600, to: 1320, o: 0.08 },
    { f: 520, to: 1180, o: 0.18 },
    { f: 700, to: 1500, o: 0.28 },
  ];
  for (const f of flights) {
    tone(ac, f.f, t + f.o, 0.22, {
      type: "sine",
      gain: 0.09,
      sweepTo: f.to,
      attack: 0.01,
    });
    // 정령이 지나가는 휘잉 노이즈
    noise(ac, t + f.o, 0.18, {
      gain: 0.07,
      filterFrom: 3500,
      filterTo: 800,
      filterQ: 1.2,
    });
  }
  // 3) 정령들의 일제 강타 임팩트 (밝은 메탈 sweep + 굵은 노이즈)
  tone(ac, 1320, t + 0.42, 0.18, {
    type: "square",
    gain: 0.14,
    sweepTo: 660,
  });
  noise(ac, t + 0.42, 0.22, {
    gain: 0.16,
    filterFrom: 5000,
    filterTo: 600,
    filterQ: 0.8,
  });
  // 4) 끝나는 황금 잔향 sparkle
  tone(ac, 2093, t + 0.55, 0.45, { type: "sine", gain: 0.07 });
  tone(ac, 2637, t + 0.6, 0.45, { type: "sine", gain: 0.05 });
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
 * 하단 탭/상단 탭 등 네비게이션 이동 — 매우 짧은 두 톤 "틱-탁".
 * 너무 자주 발생하므로 게인을 낮게.
 */
export function playNav(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  tone(ac, 740, t, 0.04, { type: "square", gain: 0.06 });
  tone(ac, 980, t + 0.03, 0.04, { type: "square", gain: 0.05 });
}

/**
 * 토글 스위치 on/off 사운드.
 * - on : 짧은 상승 두 톤 (확정감)
 * - off: 짧은 하강 두 톤 (해제감)
 */
export function playToggle(on: boolean): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  if (on) {
    tone(ac, 520, t, 0.05, { type: "square", gain: 0.09 });
    tone(ac, 880, t + 0.04, 0.07, { type: "triangle", gain: 0.1 });
  } else {
    tone(ac, 660, t, 0.05, { type: "square", gain: 0.08 });
    tone(ac, 392, t + 0.04, 0.08, { type: "triangle", gain: 0.09 });
  }
}

/**
 * 옷장에서 코스튬·펫·칭호·뱃지·프레임 등을 선택/장착할 때.
 * 짧고 마법스러운 "선택+장착" 사운드.
 */
export function playEquip(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  // 두 음 빠른 상승 (G5 → C6)
  tone(ac, 783.99, t, 0.08, { type: "triangle", gain: 0.1 });
  tone(ac, 1046.5, t + 0.05, 0.1, { type: "triangle", gain: 0.11 });
  // 가벼운 sparkle
  tone(ac, 2093, t + 0.08, 0.18, { type: "sine", gain: 0.06 });
}

/**
 * 일반 선택/확인 사운드.
 * - 카드 선택, 아이템 픽 등 가벼운 확정.
 */
export function playSelect(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  tone(ac, 660, t, 0.05, { type: "triangle", gain: 0.09 });
  tone(ac, 880, t + 0.04, 0.07, { type: "triangle", gain: 0.08 });
}

/**
 * 던전 입장 — 무게감 있는 저음 sweep + 짧은 메탈릭 chime.
 * "안으로 빨려 들어가는" 느낌.
 */
export function playEnter(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  // 깊은 저음 sweep up (드럼의 부 — boom)
  tone(ac, 110, t, 0.35, {
    type: "sawtooth",
    gain: 0.18,
    sweepTo: 220,
    attack: 0.02,
  });
  // 중음 화성 보강
  tone(ac, 220, t + 0.02, 0.35, {
    type: "triangle",
    gain: 0.12,
    sweepTo: 440,
    attack: 0.02,
  });
  // 입구 노이즈 (바람/먼지)
  noise(ac, t, 0.28, {
    gain: 0.08,
    filterFrom: 1200,
    filterTo: 200,
    filterQ: 0.7,
  });
  // 끝에 살짝 chime
  tone(ac, 1320, t + 0.18, 0.3, { type: "triangle", gain: 0.09 });
  tone(ac, 1760, t + 0.22, 0.3, { type: "sine", gain: 0.06 });
}

// ─────────────────────────────────────────────────────────────────────
// 보스 던전 사운드
// ─────────────────────────────────────────────────────────────────────

/** 보스에게 한 방 — 묵직한 임팩트 + 짧은 잔향. */
export function playBossHit(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  // 묵직한 임팩트 (저주파 sweep)
  tone(ac, 220, t, 0.18, {
    type: "sawtooth",
    gain: 0.2,
    sweepTo: 80,
  });
  // 위쪽 트랜지언트 (날카로운 메탈)
  noise(ac, t, 0.08, {
    gain: 0.15,
    filterFrom: 6000,
    filterTo: 2000,
    filterQ: 0.8,
  });
  // 잔향 (살짝)
  tone(ac, 110, t + 0.05, 0.3, {
    type: "triangle",
    gain: 0.1,
  });
}

/** 보스 포효 — 등장 시 사용. 굵직한 저음 + 노이즈. */
export function playBossRoar(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  // 굵은 sawtooth 저음
  tone(ac, 120, t, 0.6, {
    type: "sawtooth",
    gain: 0.18,
    sweepTo: 60,
  });
  tone(ac, 180, t + 0.05, 0.6, {
    type: "sawtooth",
    gain: 0.13,
    sweepTo: 90,
  });
  // 거친 숨소리 노이즈
  noise(ac, t + 0.05, 0.5, {
    gain: 0.12,
    filterFrom: 1200,
    filterTo: 400,
    filterQ: 1.5,
  });
}

/** 플레이어 피격 — 약한 둔탁음 + 잔진동. */
export function playPlayerHurt(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;
  tone(ac, 180, t, 0.12, {
    type: "square",
    gain: 0.12,
    sweepTo: 70,
  });
  noise(ac, t, 0.08, {
    gain: 0.08,
    filterFrom: 1500,
    filterTo: 300,
  });
}

/**
 * 보스 사망 — 길고 풍성한 사운드.
 * 장엄한 저음 → 화이트 노이즈 폭발 → 영혼 승천 화음.
 */
export function playBossDeath(): void {
  const ac = getCtx();
  if (!ac) return;
  const t = ac.currentTime;

  // 1) 무너지는 저음 sweep
  tone(ac, 220, t, 0.4, {
    type: "sawtooth",
    gain: 0.2,
    sweepTo: 50,
  });
  // 2) 폭발 노이즈
  noise(ac, t + 0.1, 0.35, {
    gain: 0.22,
    filterFrom: 6000,
    filterTo: 200,
    filterQ: 0.7,
  });
  // 3) 메탈 충격
  tone(ac, 880, t + 0.1, 0.25, {
    type: "square",
    gain: 0.15,
    sweepTo: 220,
  });
  // 4) 영혼 승천 화음 (메이저 코드 트라이어드 + 옥타브)
  const chord = [
    { f: 523.25, o: 0.45 }, // C5
    { f: 659.25, o: 0.5 }, // E5
    { f: 783.99, o: 0.55 }, // G5
    { f: 1046.5, o: 0.6 }, // C6
  ];
  for (const n of chord) {
    tone(ac, n.f, t + n.o, 0.9, {
      type: "triangle",
      gain: 0.13,
      attack: 0.04,
    });
  }
  // 마지막 sparkle
  tone(ac, 2093, t + 0.7, 0.6, { type: "sine", gain: 0.08 });
  tone(ac, 2637, t + 0.75, 0.6, { type: "sine", gain: 0.06 });
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
