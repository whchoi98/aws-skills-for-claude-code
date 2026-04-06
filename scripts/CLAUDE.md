# Scripts Module

## Role
프로젝트 셋업 및 Git 훅 설치를 위한 운영 스크립트.

## Key Files
- `setup.sh` — 신규 개발자 원커맨드 셋업 (디렉토리 생성, 훅 설치, 스킬 설치)
- `install-hooks.sh` — Git `commit-msg` 훅 설치 (AI Co-Authored-By 라인 자동 제거)

## Conventions
- 모든 스크립트는 `set -e`로 시작
- 실패 시 명확한 에러 메시지 출력 후 `exit 1`
- `chmod +x` 권한 필수
