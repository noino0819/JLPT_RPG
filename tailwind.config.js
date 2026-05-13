/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        pixel: ["'DungGeunMo'", "'DotGothic16'", "monospace"],
        jp: ["'DotGothic16'", "'Noto Sans JP'", "monospace"],
        ui: [
          "'DungGeunMo'",
          "'Noto Sans KR'",
          "system-ui",
          "sans-serif",
        ],
      },
      colors: {
        parchment: {
          50: "#fdf8ec",
          100: "#f7eccd",
          200: "#f0dba1",
          300: "#e6c374",
          400: "#d6a44d",
          500: "#bd8434",
          600: "#9a662a",
          700: "#794c24",
          800: "#5b3919",
          900: "#3a2410",
        },
        rune: {
          400: "#7be3ff",
          500: "#33c4ff",
          600: "#1399d8",
        },
        dungeon: {
          50: "#1a1428",
          100: "#161021",
          200: "#120d1b",
          300: "#0f0b17",
          400: "#0c0913",
          500: "#08060d",
        },
        forest: {
          400: "#7cd66a",
          500: "#3ea33a",
          700: "#21501f",
          900: "#0f2410",
        },
        cave: {
          400: "#b59377",
          500: "#7a5736",
          700: "#43301d",
          900: "#231809",
        },
        ruin: {
          400: "#f0c97c",
          500: "#cf9342",
          700: "#7a5117",
          900: "#3b240a",
        },
        volcano: {
          400: "#ff8a4c",
          500: "#e64518",
          700: "#7a1e0a",
          900: "#330a04",
        },
        sky: {
          400: "#cba8ff",
          500: "#7a4cf0",
          700: "#3a1d80",
          900: "#160831",
        },
      },
      boxShadow: {
        pixel: "0 4px 0 0 rgba(0,0,0,0.6)",
        pixelHover: "0 6px 0 0 rgba(0,0,0,0.6)",
        pressed: "0 2px 0 0 rgba(0,0,0,0.6)",
        rune: "0 0 0 2px rgba(123,227,255,0.5), 0 0 24px rgba(51,196,255,0.4)",
        gold: "0 0 0 2px rgba(240,201,124,0.6), 0 0 24px rgba(207,147,66,0.45)",
      },
      keyframes: {
        bob: {
          "0%, 100%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(-2px)" },
        },
        attackSwing: {
          "0%": { transform: "translateX(0) rotate(0deg)" },
          "30%": { transform: "translateX(8px) rotate(-12deg)" },
          "60%": { transform: "translateX(4px) rotate(4deg)" },
          "100%": { transform: "translateX(0) rotate(0deg)" },
        },
        slash: {
          "0%": { transform: "translate(-30px,-30px) scale(0.6)", opacity: "0" },
          "30%": { opacity: "1" },
          "100%": { transform: "translate(30px,30px) scale(1.1)", opacity: "0" },
        },
        ring: {
          "0%": { transform: "scale(0.6)", opacity: "0.9" },
          "100%": { transform: "scale(2.4)", opacity: "0" },
        },
        arrow: {
          "0%": { transform: "translateX(-40px)", opacity: "0" },
          "30%": { opacity: "1" },
          "100%": { transform: "translateX(60px)", opacity: "0" },
        },
        cardShake: {
          "0%, 100%": { transform: "translateX(0)" },
          "20%": { transform: "translateX(-6px)" },
          "40%": { transform: "translateX(6px)" },
          "60%": { transform: "translateX(-3px)" },
          "80%": { transform: "translateX(3px)" },
        },
        rankPop: {
          "0%": { transform: "scale(0.6)", opacity: "0" },
          "60%": { transform: "scale(1.15)", opacity: "1" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
        floatUp: {
          "0%": { transform: "translateY(0)", opacity: "1" },
          "100%": { transform: "translateY(-30px)", opacity: "0" },
        },
        // 처치 이펙트용 — "처치!" 텍스트가 통통 튀며 등장
        defeatPop: {
          "0%": { transform: "scale(0) rotate(-12deg)", opacity: "0" },
          "25%": { transform: "scale(1.4) rotate(8deg)", opacity: "1" },
          "45%": { transform: "scale(0.85) rotate(-4deg)", opacity: "1" },
          "65%": { transform: "scale(1.1) rotate(2deg)", opacity: "1" },
          "80%": { transform: "scale(1) rotate(0deg)", opacity: "1" },
          "100%": { transform: "scale(0.9) translateY(-12px)", opacity: "0" },
        },
        // 카드 파편이 사방으로 회전하며 흩어짐 (CSS 변수 --dx, --dy 사용)
        shatter: {
          "0%": {
            transform: "translate(0,0) rotate(0deg) scale(1)",
            opacity: "1",
          },
          "100%": {
            transform:
              "translate(var(--dx,40px), var(--dy,-40px)) rotate(540deg) scale(0.4)",
            opacity: "0",
          },
        },
        // 별 반짝이 — 작게 등장 → 커지며 사라짐
        sparkle: {
          "0%": { transform: "scale(0.2) rotate(0deg)", opacity: "0" },
          "30%": { transform: "scale(1.2) rotate(120deg)", opacity: "1" },
          "100%": { transform: "scale(0.4) rotate(360deg)", opacity: "0" },
        },
        // 영혼이 위로 둥둥 떠오름 (소환사용)
        spiritDrift: {
          "0%": {
            transform: "translate(0,0) scale(0.6)",
            opacity: "0",
          },
          "30%": {
            transform: "translate(var(--dx,0px), -10px) scale(1)",
            opacity: "1",
          },
          "100%": {
            transform: "translate(var(--dx,0px), -70px) scale(0.7)",
            opacity: "0",
          },
        },
        // 짧은 화면 플래시
        flashOverlay: {
          "0%": { opacity: "0" },
          "20%": { opacity: "0.55" },
          "100%": { opacity: "0" },
        },
        // 두 번째 슬래시 (방향 반대)
        slashAlt: {
          "0%": {
            transform: "translate(30px,-30px) scale(0.6)",
            opacity: "0",
          },
          "30%": { opacity: "1" },
          "100%": {
            transform: "translate(-30px,30px) scale(1.2)",
            opacity: "0",
          },
        },
        // 보스 idle - 천천히 흔들흔들 (일반 캐릭터보다 느리고 큼직)
        bobSlow: {
          "0%, 100%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(-4px)" },
        },
        // 보스 등장 - 위에서 떨어지며 살짝 튀어오름
        bossEntrance: {
          "0%": { transform: "translateY(-80px) scale(0.6)", opacity: "0" },
          "50%": { transform: "translateY(8px) scale(1.05)", opacity: "1" },
          "75%": { transform: "translateY(-4px) scale(0.98)" },
          "100%": { transform: "translateY(0) scale(1)", opacity: "1" },
        },
        // 보스 피격 - 좌우 흔들림 (붉은 깜빡과 동시 진행)
        monsterHurt: {
          "0%, 100%": { transform: "translateX(0) translateY(0)" },
          "15%": { transform: "translateX(-5px) translateY(-2px)" },
          "30%": { transform: "translateX(5px) translateY(0)" },
          "45%": { transform: "translateX(-3px) translateY(-1px)" },
          "60%": { transform: "translateX(3px) translateY(0)" },
          "80%": { transform: "translateX(-1px)" },
        },
        // 피격 시 붉은 오버레이 깜빡임 (도트 위에 덮어 빨강 플래시)
        hurtFlash: {
          "0%": { opacity: "0.7" },
          "50%": { opacity: "0.2" },
          "100%": { opacity: "0" },
        },
        // 사망 직전 - 격하게 깜빡깜빡 + 흔들림
        monsterDying: {
          "0%, 100%": { transform: "translateX(0) scale(1)" },
          "10%, 30%, 50%, 70%, 90%": {
            transform: "translateX(-3px) scale(1.03)",
            filter: "brightness(2.2) saturate(0)",
          },
          "20%, 40%, 60%, 80%": {
            transform: "translateX(3px) scale(0.98)",
            filter: "brightness(1)",
          },
        },
        // 보스 산산조각 - 모든 픽셀이 사방으로 회전하며 흩어지고 페이드
        monsterShatter: {
          "0%": {
            transform: "translate(0,0) rotate(0deg) scale(1)",
            opacity: "1",
          },
          "20%": { opacity: "1" },
          "100%": {
            transform:
              "translate(var(--dx,40px), var(--dy,-40px)) rotate(var(--rot,540deg)) scale(0.2)",
            opacity: "0",
          },
        },
        // 사망 시 영혼이 위로 천천히 떠오름
        soulRise: {
          "0%": {
            transform: "translateX(var(--dx,0px)) translateY(0) scale(0.4)",
            opacity: "0",
          },
          "20%": {
            transform: "translateX(var(--dx,0px)) translateY(-8px) scale(1)",
            opacity: "1",
          },
          "100%": {
            transform:
              "translateX(calc(var(--dx,0px) * 0.5)) translateY(-90px) scale(0.6)",
            opacity: "0",
          },
        },
        // 플레이어 피격 시 화면 가장자리 붉게 + 좌우 살짝 흔들림
        playerHurt: {
          "0%, 100%": { transform: "translateX(0)" },
          "20%": { transform: "translateX(-4px)" },
          "40%": { transform: "translateX(4px)" },
          "60%": { transform: "translateX(-2px)" },
          "80%": { transform: "translateX(2px)" },
        },
        // HP 바가 깜빡거리며 위급 신호
        hpPulse: {
          "0%, 100%": { opacity: "1" },
          "50%": { opacity: "0.55" },
        },
        // 화면 전체 붉게 비네팅 (피격 시)
        bloodVignette: {
          "0%": { opacity: "0" },
          "20%": { opacity: "0.7" },
          "100%": { opacity: "0" },
        },
        // 보스 사망 후 화이트 플래시
        whiteFlash: {
          "0%": { opacity: "0" },
          "10%": { opacity: "0.85" },
          "100%": { opacity: "0" },
        },
      },
      animation: {
        bob: "bob 1.6s ease-in-out infinite",
        bobSlow: "bobSlow 2.4s ease-in-out infinite",
        bossEntrance: "bossEntrance 0.7s cubic-bezier(0.3,1.6,0.4,1) forwards",
        monsterHurt: "monsterHurt 0.5s ease-in-out",
        hurtFlash: "hurtFlash 0.5s ease-out forwards",
        monsterDying: "monsterDying 1.0s linear",
        monsterShatter: "monsterShatter 1.2s ease-out forwards",
        soulRise: "soulRise 1.6s ease-out forwards",
        playerHurt: "playerHurt 0.4s ease-in-out",
        hpPulse: "hpPulse 0.8s ease-in-out infinite",
        bloodVignette: "bloodVignette 0.6s ease-out forwards",
        whiteFlash: "whiteFlash 0.5s ease-out forwards",
        attackSwing: "attackSwing 0.5s ease-out",
        slash: "slash 0.5s ease-out forwards",
        slashAlt: "slashAlt 0.5s ease-out forwards",
        ring: "ring 0.6s ease-out forwards",
        arrow: "arrow 0.5s ease-out forwards",
        cardShake: "cardShake 0.4s ease-in-out",
        rankPop: "rankPop 0.5s ease-out",
        floatUp: "floatUp 0.9s ease-out forwards",
        defeatPop: "defeatPop 1.1s cubic-bezier(0.3,1.6,0.4,1) forwards",
        shatter: "shatter 0.9s ease-out forwards",
        sparkle: "sparkle 0.8s ease-out forwards",
        spiritDrift: "spiritDrift 1.1s ease-out forwards",
        flashOverlay: "flashOverlay 0.5s ease-out forwards",
      },
    },
  },
  plugins: [],
};
