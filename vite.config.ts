import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    open: true,
    // 개발 서버를 LAN 에 노출하지 않는다. 같은 네트워크의 다른 기기에서
    // dev 빌드(소스맵 포함) 와 인증 토큰을 들여다볼 수 있는 것을 차단.
    host: "127.0.0.1",
    strictPort: true,
  },
  preview: {
    host: "127.0.0.1",
    port: 4173,
  },
  build: {
    // 운영 번들에 소스맵 노출 금지 (펜테스트에서 흔히 잡히는 정보 누출).
    sourcemap: false,
  },
});
