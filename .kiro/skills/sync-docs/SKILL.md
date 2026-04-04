---
name: sync-docs
description: Synchronize project documentation with current code state. Use when mentioning doc sync, documentation update, or CLAUDE.md update.
---

# Sync Docs Skill / 문서 동기화 스킬

Synchronize project documentation with current code state.

프로젝트 문서를 현재 코드 상태와 동기화합니다.

## Actions / 작업

### 1. CLAUDE.md Sync / CLAUDE.md 동기화
- Update root CLAUDE.md to match current project state
- 루트 CLAUDE.md를 현재 프로젝트 상태에 맞게 업데이트

### 2. Architecture Doc Sync / 아키텍처 문서 동기화
- Update docs/architecture.md to reflect current system structure
- docs/architecture.md를 현재 시스템 구조에 맞게 업데이트

### 3. Module CLAUDE.md Audit / 모듈 CLAUDE.md 감사
- Scan all directories under src/
- Create CLAUDE.md for modules missing one
- src/ 하위 모든 디렉터리 스캔
- CLAUDE.md가 없는 모듈에 생성

### 4. ADR Audit / ADR 감사
- Check recent commits (git log --oneline -20)
- Suggest new ADRs for undocumented architectural decisions
- 최근 커밋 확인 (git log --oneline -20)
- 문서화되지 않은 아키텍처 결정에 대한 새 ADR 제안

## Usage / 사용법
Run with `/sync-docs` command

`/sync-docs` 명령으로 실행
