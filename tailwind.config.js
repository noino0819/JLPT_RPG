/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        japanese: [
          "'Noto Sans JP'",
          "'Hiragino Sans'",
          "'Yu Gothic'",
          "sans-serif",
        ],
        pixel: ["'Press Start 2P'", "monospace"],
      },
      colors: {
        sakura: {
          50: "#fff1f4",
          100: "#ffe4ea",
          200: "#ffcad6",
          300: "#ff9fb5",
          400: "#ff6b8c",
          500: "#fb3a68",
          600: "#e91653",
          700: "#c40c45",
          800: "#a30d40",
          900: "#88103c",
        },
      },
      keyframes: {
        shake: {
          "0%, 100%": { transform: "translateX(0)" },
          "25%": { transform: "translateX(-6px)" },
          "75%": { transform: "translateX(6px)" },
        },
        pop: {
          "0%": { transform: "scale(0.95)", opacity: "0" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
      },
      animation: {
        shake: "shake 0.4s ease-in-out",
        pop: "pop 0.25s ease-out",
      },
    },
  },
  plugins: [],
};
