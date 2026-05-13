# 📨 Supabase 이메일 템플릿 (픽셀 RPG 테마)

JLPT RPG 의 양피지·픽셀 컨셉에 맞춘 4종 이메일 템플릿입니다.

| 파일 | 용도 | Supabase 템플릿 슬롯 |
|---|---|---|
| `confirm-signup.html` | 회원가입 인증 | **Confirm signup** |
| `magic-link.html` | 비밀번호 없이 로그인 | **Magic Link** |
| `reset-password.html` | 비밀번호 재설정 | **Reset Password** |
| `change-email.html` | 메일 주소 변경 | **Change Email Address** |

---

## ✨ 적용 방법

1. Supabase 대시보드 접속 → 프로젝트 선택
2. 좌측 메뉴 **Authentication > Email Templates**
3. 위 표를 참고해 각 슬롯 선택
4. **Subject** 와 **Message body (HTML)** 를 아래처럼 입력
5. 우상단 **Save** 클릭

### 추천 Subject (제목)

| 템플릿 | 제목 |
|---|---|
| Confirm signup | `🗡️ JLPT RPG · 모험가 등록을 완료해주세요` |
| Magic Link | `🔮 JLPT RPG · 마법 통로가 열렸습니다` |
| Reset Password | `🔑 JLPT RPG · 비밀번호 재설정 링크` |
| Change Email | `📨 JLPT RPG · 새 메일 주소 인증` |

### Message body

해당 `.html` 파일의 내용을 통째로 복사해 붙여넣으면 됩니다.

---

## 🔧 Site URL · Redirect URLs

이메일에 들어가는 인증 링크는 Supabase 의 **Site URL** 을 기반으로 만들어집니다.

1. **Authentication > URL Configuration**
2. **Site URL**: 배포된 사이트 주소 (예: `https://jlpt-rpg.vercel.app`)
   - 개발 중에는 `http://localhost:5173` 으로 두면 로컬 dev 서버로 리다이렉트됩니다
3. **Redirect URLs (additional)**: 양쪽 다 등록해두면 편합니다
   ```
   http://localhost:5173/**
   https://jlpt-rpg.vercel.app/**
   ```

---

## 🧪 테스트

1. 회원가입 (LoginPage) → 메일함에서 받은 메일이 양피지/픽셀 디자인으로 보이는지 확인
2. 인증 버튼 클릭 → 앱에 자동 로그인되는지 확인
3. 만약 깨져 보이면 메일 클라이언트(Gmail, Outlook 등)별 호환성 이슈일 수 있습니다.
   - 모든 스타일이 `style="..."` 인라인으로 들어가 있어 대부분 클라이언트에서 잘 보입니다
   - Google Fonts (DotGothic16) 가 차단되면 fallback 폰트로 표시됩니다 (정상)

---

## 🪄 변수 (Go template)

Supabase 가 치환해주는 변수:

| 변수 | 설명 |
|---|---|
| `{{ .ConfirmationURL }}` | 인증/재설정 링크 (모든 템플릿에서 핵심) |
| `{{ .Email }}` | 대상 이메일 |
| `{{ .Token }}` | 6자리 OTP (사용 시) |
| `{{ .TokenHash }}` | 토큰 해시 |
| `{{ .SiteURL }}` | Site URL 설정 값 |

이 템플릿들은 가장 단순한 `{{ .ConfirmationURL }}` 만 사용합니다.
OTP 코드를 표시하고 싶다면 `{{ .Token }}` 으로 6자리 숫자를 추가할 수 있습니다.
