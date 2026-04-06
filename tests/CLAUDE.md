# Tests Module

## Role
TAP 형식 테스트 스위트. 훅 동작, 시크릿 패턴, 프로젝트 구조를 검증 (76개 어설션).

## Running Tests

```bash
bash tests/run-all.sh
```

## Structure
- `run-all.sh` — 테스트 러너 (TAP v13 출력, 어설션 헬퍼 내장)
- `hooks/test-hooks.sh` — 훅 존재, 권한, settings.json 등록, shebang 검증
- `hooks/test-secret-patterns.sh` — 시크릿 패턴 true positive / false positive 검증
- `structure/test-plugin-structure.sh` — 코어 파일, 디렉토리, 스킬, 커맨드, 에이전트, CLAUDE.md 섹션 검증
- `fixtures/secret-samples.txt` — 반드시 감지되어야 하는 시크릿 샘플
- `fixtures/false-positives.txt` — 감지되지 않아야 하는 안전한 문자열

## Adding Tests
1. `tests/hooks/` 또는 `tests/structure/`에 `test-*.sh` 파일 생성
2. `run-all.sh`의 `pass()`, `fail()`, `assert_*()` 헬퍼 사용
3. 테스트 파일은 `source`로 로드되므로 별도 실행 권한 불필요 (단, 컨벤션상 `chmod +x` 권장)
