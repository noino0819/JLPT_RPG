# Supabase 연동 가이드

JLPT RPG는 환경변수가 설정되어 있으면 자동으로 Supabase 모드로,
없으면 로컬 영속화(Zustand persist) 모드로 동작합니다.

---

## 1. Supabase 프로젝트 생성

1. <https://supabase.com> 가입 후 **New project** 클릭
2. 프로젝트 이름·DB 비밀번호·리전 (가까운 ap-northeast-2 추천) 설정
3. 프로젝트가 준비될 때까지 1~2분 대기

## 2. 스키마 적용

1. 좌측 메뉴 **SQL Editor** 진입
2. `supabase_schema.sql` 파일의 내용을 통째로 복사
3. SQL Editor에 붙여넣고 **Run**
4. 다음이 모두 생성되어야 정상:
   - 테이블: `profiles`, `decks`, `words`, `examples`, `word_progress`
   - 뷰: `user_dungeon_stats`
   - 트리거: `on_auth_user_created`
   - RLS 정책 활성화
   - 공식 덱 5개 시드 (N5~N1)
   - N3 샘플 단어 5개 + 예문

## 3. 인증 설정

### 3.1 이메일/비밀번호

1. 좌측 메뉴 **Authentication > Providers**
2. **Email** 활성화 (기본 활성)
3. 개발 편의를 위해 **Confirm email** 을 일단 OFF 로 두면 즉시 로그인 가능
   (운영 환경에서는 ON 권장)

### 3.2 (선택) 네이버 OAuth

네이버는 Supabase 공식 Provider 로 지원되지 않으므로 별도 Vercel
Serverless Function 으로 콜백을 처리합니다. 이 단계는 추후 구현 예정.

## 4. 환경변수 설정

1. 프로젝트 루트에 `.env.local` 파일 생성 (또는 `.env.example` 복사)
2. Supabase 대시보드 **Project Settings > API** 에서 값 복사

```bash
# .env.local
VITE_SUPABASE_URL=https://YOUR-PROJECT-REF.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOi...
```

3. 개발 서버 재시작: `npm run dev`

## 5. 동작 확인

- 우상단 헤더에 동기화 상태 점이 표시됩니다.
  - 🟢 녹색: Supabase 연결됨 (서버 동기화)
  - ⚪ 회색: 로컬 모드 (오프라인)
- 회원가입 → 자동으로 `profiles` 행이 생성됩니다 (트리거).
- 학습 화면에서 액션을 누르면 `word_progress` 가 즉시 upsert 됩니다.

## 6. 트러블슈팅

| 증상 | 원인/해결 |
|---|---|
| 회원가입 후 즉시 로그인 안 됨 | Auth > Email > "Confirm email" 이 켜져 있음. 개발 환경에서는 OFF 권장 |
| `relation public.profiles does not exist` | 스키마 SQL이 다 실행되지 않음. SQL Editor 에서 다시 실행 |
| `new row violates row-level security policy` | RLS 정책이 있는데 로그인 안 된 상태로 쓰기 시도. 로그인 후 재시도 |
| 진행 상태가 동기화되지 않음 | 환경변수 오타, 또는 dev 서버 재시작 필요 |

## 7. 데이터 마이그레이션 (현재 → 다음 단계)

현재는 **인증 + word_progress** 만 Supabase 와 동기화됩니다.
**덱/단어/예문**은 아직 로컬 시드(`src/data/seed.ts`) 기반입니다.

다음 단계에서 다음을 추가할 예정:

- [ ] 공식 덱/단어를 Supabase 에서 로드
- [ ] 커스텀 덱 생성/수정/삭제 → Supabase 에 저장
- [ ] CSV 업로드 시 Supabase 에 일괄 INSERT
- [ ] `user_dungeon_stats` 뷰를 활용한 서버 사이드 통계
