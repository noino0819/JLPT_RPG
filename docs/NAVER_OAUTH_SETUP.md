# 네이버 OAuth 연동 가이드

> JLPT RPG 의 "네이버로 시작" 버튼은 Vercel Serverless Function 세 개
> (`api/auth/naver/start.ts`, `api/auth/naver/callback.ts`,
> `api/auth/naver/unlink.ts`) 와 Supabase 매직 링크를 조합해서 동작합니다.

전체 흐름

```
[사용자]
   └─▶ /api/auth/naver/start
         ├─ state(CSRF) 발급 → HttpOnly 쿠키
         └─ 302 → https://nid.naver.com/oauth2.0/authorize?...

[네이버 로그인]
   └─▶ /api/auth/naver/callback?code=...&state=...
         ├─ state 검증
         ├─ code → access_token (네이버 token API)
         ├─ access_token → 프로필 (이메일/닉네임)
         ├─ Supabase admin.createUser (이미 있으면 무시)
         ├─ Supabase admin.generateLink({ type: 'magiclink' })
         └─ 302 → action_link
                       └─ Supabase verify → 우리 사이트(/) 자동 로그인

[연결 끊기 / 회원 탈퇴 알림]  (네이버 → 우리 서버)
   └─▶ POST /api/auth/naver/unlink
         (form-urlencoded: access_token, user_id, service_id)
         ├─ service_id == NAVER_CLIENT_ID 검증
         ├─ user_metadata.naver_id 로 Supabase 사용자 매칭
         └─ admin.deleteUser → 200 OK
```

매직 링크 방식이라 사용자는 한 번도 메일을 열지 않고
**네이버 → 우리 앱**으로 자연스럽게 들어옵니다.

---

## 1. 네이버 개발자 센터에서 애플리케이션 등록

1. https://developers.naver.com/apps/#/list 접속 → **Application 등록**
2. 입력 값
   - **애플리케이션 이름**: `JLPT RPG` (자유)
   - **사용 API**: `네이버 로그인`
   - **제공 정보**: `이메일 주소(필수)`, `이름`, `닉네임` 정도 추천
   - **로고 이미지** (140 × 140, 500KB 이하 PNG):
     - `public/naver-logo.png` 를 업로드하면 됩니다.
     - 운영 URL 로는 `https://jlpt-rpg.vercel.app/naver-logo.png` 에서 바로
       확인할 수 있습니다.
   - **로그인 오픈 API 서비스 환경**: `PC 웹` 추가
     - **서비스 URL**: `https://jlpt-rpg.vercel.app`
       - 로컬 테스트도 함께 하려면 `http://localhost:5173` 도 등록
     - **Callback URL** (로그인 콜백):
       - 운영: `https://jlpt-rpg.vercel.app/api/auth/naver/callback`
       - 로컬: `http://localhost:3000/api/auth/naver/callback`
         (vercel dev 기본 포트)
   - **연결 끊기 Callback URL** (선택, 회원 탈퇴/연결 해제 알림 수신용):
     - 운영: `https://jlpt-rpg.vercel.app/api/auth/naver/unlink`
     - 로컬: `http://localhost:3000/api/auth/naver/unlink`
3. 등록 후 발급되는 **Client ID / Client Secret** 을 복사해둡니다.

> 네이버는 Callback URL 이 정확히 일치해야 합니다 (서브패스/쿼리/포트 모두).
> 연결 끊기 콜백은 네이버가 **POST + application/x-www-form-urlencoded** 로
> 호출합니다. 일반 로그인 콜백 (GET) 과는 다른 엔드포인트로 등록하세요.

---

## 2. Vercel 환경변수 등록

Vercel 대시보드 > **Project** > **Settings** > **Environment Variables** 에서 아래
값을 모두 등록합니다 (Production / Preview / Development 모두 체크).

| Key                          | 값                                                 |
| ---------------------------- | -------------------------------------------------- |
| `NAVER_CLIENT_ID`            | 네이버 콘솔에서 발급받은 Client ID                  |
| `NAVER_CLIENT_SECRET`        | 네이버 콘솔에서 발급받은 Client Secret              |
| `SUPABASE_URL`               | Supabase 프로젝트 URL (VITE\_…와 동일 값)          |
| `SUPABASE_SERVICE_ROLE_KEY`  | Supabase Service Role Key (절대 클라이언트 노출 X) |
| `SITE_URL`                   | `https://jlpt-rpg.vercel.app` (선택, 매직링크 redirect 기준) |

> 클라이언트용 `VITE_SUPABASE_URL` / `VITE_SUPABASE_ANON_KEY` 도 동일하게
> Vercel 에 등록되어 있어야 합니다.

등록 후 한 번 재배포(또는 redeploy without cache) 하면 새 변수가 함수에 적용됩니다.

---

## 3. Supabase 설정 점검

### 3-1. Site URL / Redirect URLs

Supabase 대시보드 > **Authentication** > **URL Configuration**

- **Site URL**: `https://jlpt-rpg.vercel.app`
- **Additional Redirect URLs** 에 아래 둘을 추가:
  - `https://jlpt-rpg.vercel.app/`
  - `http://localhost:5173/` (로컬 테스트)
  - 필요하면 Preview URL 도 (`https://*.vercel.app/`)

> 매직 링크는 위 redirect 목록에 등록된 URL 로만 돌려보낼 수 있습니다.

### 3-2. (선택) 이메일 발송 비활성화

매직 링크 방식이지만 우리는 `admin.generateLink` 를 사용하기 때문에
실제 메일은 **발송되지 않습니다**. 별도 설정 변경은 필요 없습니다.

---

## 4. 로컬에서 테스트하기

```bash
# 1) 정적 프런트는 평소처럼
npm run dev          # http://localhost:5173

# 2) Serverless Functions 까지 같이 띄우려면 Vercel CLI
vercel link          # (최초 1회) 프로젝트와 연결
vercel dev           # http://localhost:3000  ← 함수 + 정적 둘 다 서빙
```

브라우저에서 `http://localhost:3000` 을 띄우면 네이버 버튼이 실제 OAuth 흐름을
탑니다. 단, 네이버 콘솔에 `http://localhost:3000/api/auth/naver/callback`
콜백을 등록해두어야 합니다.

---

## 5. 트러블슈팅

| 증상 | 원인 / 해결                                                                |
| ---- | -------------------------------------------------------------------------- |
| `네이버 로그인 실패: 잘못된 state (CSRF)` | 새 탭에서 콜백을 직접 열었거나 쿠키 차단. 로그인 다시 시도               |
| `네이버 이메일 제공 동의가 필요합니다`   | 네이버 동의창에서 이메일 항목을 거절. 다시 로그인 → 이메일 동의 체크    |
| `토큰 교환 실패: invalid_request`       | Callback URL 이 네이버 콘솔 등록값과 다름. 오타/포트/프로토콜 확인       |
| `매직링크 발급 실패: ...`               | Supabase Service Role Key 가 잘못 등록됐거나 사용자 ban 상태             |
| 콜백은 OK 인데 자동 로그인이 안 됨      | Supabase **Redirect URL** 화이트리스트에 사이트 URL 누락. 위 3-1 확인   |

---

## 6. 참고

- 네이버 로그인 가이드: https://developers.naver.com/docs/login/api/
- Supabase Admin API: https://supabase.com/docs/reference/javascript/auth-admin-generatelink
- 본 프로젝트 함수 코드:
  - [`api/auth/naver/start.ts`](../api/auth/naver/start.ts)
  - [`api/auth/naver/callback.ts`](../api/auth/naver/callback.ts)
  - [`api/auth/naver/unlink.ts`](../api/auth/naver/unlink.ts)

---

## 7. 연결 끊기 콜백 동작 상세

네이버는 다음 두 경우에 우리 서버 (`/api/auth/naver/unlink`) 로 POST 요청을 보냅니다.

1. 사용자가 **네이버 프로필 > 연결된 서비스 관리** 에서 "JLPT RPG" 연결을 끊었을 때
2. 사용자가 **네이버 회원 자체를 탈퇴** 했을 때

### 요청 형식

```
POST /api/auth/naver/unlink
Content-Type: application/x-www-form-urlencoded

access_token=AAAA...&user_id=NAVER_UNIQUE_ID&service_id=YOUR_CLIENT_ID
```

### 우리 서버의 처리

| 단계 | 처리                                                                                |
| ---- | ----------------------------------------------------------------------------------- |
| 1    | `service_id` 가 `NAVER_CLIENT_ID` 와 일치하는지 확인 (위변조 1차 차단)              |
| 2    | Supabase `admin.listUsers` 로 `user_metadata.naver_id == user_id` 사용자 검색       |
| 3    | 해당 사용자가 있으면 `admin.deleteUser` 로 계정 삭제 (회원 탈퇴와 동일하게 정리)    |
| 4    | 어떤 결과든 **HTTP 200** 으로 응답 (네이버 측 재시도 큐 누적 방지)                   |

### 로컬 테스트

```bash
# vercel dev 가 떠 있는 상태에서
curl -X POST http://localhost:3000/api/auth/naver/unlink \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "access_token=dummy&user_id=NAVER_UNIQUE_ID&service_id=$NAVER_CLIENT_ID"
```

> 운영 트래픽은 거의 없습니다. 로그(`vercel logs`)에 `[naver/unlink]` 로
> 시작하는 항목이 남는지로 정상 동작을 확인하세요.
