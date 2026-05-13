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
      },
      animation: {
        bob: "bob 1.6s ease-in-out infinite",
        attackSwing: "attackSwing 0.5s ease-out",
        slash: "slash 0.5s ease-out forwards",
        ring: "ring 0.6s ease-out forwards",
        arrow: "arrow 0.5s ease-out forwards",
        cardShake: "cardShake 0.4s ease-in-out",
        rankPop: "rankPop 0.5s ease-out",
        floatUp: "floatUp 0.9s ease-out forwards",
      },
    },
  },
  plugins: [],
};
