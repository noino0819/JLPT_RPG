# JLPT RPG 🗾⚔️

JLPT(일본어 능력 시험) 단어를 외우면서 몬스터를 쓰러뜨리는 학습용 RPG 웹 게임입니다.

## ✨ 주요 기능

- **단어 수련 모드**: 플래시카드 형식으로 일본어 단어를 학습하고 EXP를 얻어요.
- **전투 모드**: 단어 뜻 4지선다 퀴즈로 적을 공격! 틀리면 적의 반격을 받습니다.
- **레벨업 시스템**: EXP를 모으면 자동 레벨업, HP/공격력이 상승합니다.
- **JLPT 레벨 선택**: N5 ~ N1 중 도전할 단계를 자유롭게 선택할 수 있어요.
- **로컬 스토리지 저장**: 진행 상황은 브라우저에 자동 저장됩니다.

## 🛠 기술 스택

- [Vite](https://vitejs.dev/) + [React 19](https://react.dev/) + [TypeScript](https://www.typescriptlang.org/)
- [Tailwind CSS](https://tailwindcss.com/) — UI 스타일링
- [React Router](https://reactrouter.com/) — 페이지 라우팅
- [Zustand](https://zustand-demo.pmnd.rs/) — 전역 상태 관리 (영속화 포함)

## 🚀 시작하기

```bash
# 의존성 설치
npm install

# 개발 서버 실행 (http://localhost:5173)
npm run dev

# 프로덕션 빌드
npm run build
```

## 📁 프로젝트 구조

```
src/
├── components/     # 공통 UI 컴포넌트 (Layout 등)
├── data/           # 단어/적 데이터
├── pages/          # 페이지 컴포넌트
│   ├── HomePage.tsx
│   ├── StudyPage.tsx
│   ├── BattlePage.tsx
│   └── StatusPage.tsx
├── store/          # Zustand 상태 스토어
├── App.tsx
├── main.tsx
└── index.css
```

## 🗺 향후 로드맵

- [ ] 단어 데이터 대량 추가 (JLPT 공식 어휘 리스트 기반)
- [ ] 한자 읽기 / 듣기 / 문법 퀴즈 모드
- [ ] 상점 (포션, 장비) 및 인벤토리
- [ ] 보스 던전, 일일 미션
- [ ] 학습 통계 / 복습 알고리즘 (SRS)

## 📜 라이선스

MIT
