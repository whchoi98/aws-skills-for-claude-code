# Architecture

<p align="center">
  <a href="#-한국어"><kbd>한국어</kbd></a>&nbsp;&nbsp;&nbsp;
  <a href="#-english"><kbd>English</kbd></a>
</p>

---

# 한국어

## System Overview

AWS Skills for Claude Code는 업스트림 스킬 리포지토리에서 SKILL.md 파일을 수집하고, Claude Code 사용자의 `~/.claude/skills/`에 설치하는 배포 파이프라인입니다.
Bash 스크립트 기반으로 외부 의존성 없이 동작하며, 36개 AWS 관련 스킬을 제공합니다.
핵심 데이터 흐름: 업스트림 → 로컬 아카이브 → Claude Code 스킬 디렉토리.

## Components

### Ingestion Layer
- **.kiro/skills/** -- 36개 스킬 원본 아카이브. 업스트림과 동기화를 위해 최소한의 변경만 유지.
- **install-skills.sh** -- 업스트림 리포지토리에서 SKILL.md를 heredoc 방식으로 다운로드.

### Distribution Layer
- **install-claude-code.sh** -- `.kiro/skills/` → `~/.claude/skills/` 파일 복사로 설치 수행.
- **.kiro/agents/powers.json** -- Kiro 에이전트용 `skill://` 리소스 매핑 설정.

### Observability Layer
- **.claude/hooks/** -- 문서 동기화 감지(`check-doc-sync.sh`), 시크릿 스캔(`secret-scan.sh`), 세션 컨텍스트 로딩(`session-context.sh`), 웹훅 알림(`notify.sh`).
- **.claude/settings.json** -- Claude Code 훅 이벤트 등록 (SessionStart, PreCommit, PostToolUse, Notification).

### Security Layer
- **secret-scan.sh** -- 9개 패턴(AWS 키, OpenAI, Anthropic, GitHub, Slack, 비밀번호 등)으로 커밋 전 시크릿 차단.
- **settings.json deny list** -- `rm -rf /`, `git push --force origin main`, `git reset --hard` 등 위험 명령어 차단.
- **.git/hooks/commit-msg** -- AI Co-Authored-By 라인 자동 제거.

### Testing Layer
- **tests/run-all.sh** -- TAP 형식 테스트 러너 (76개 어설션).
- **tests/hooks/** -- 훅 존재, 권한, 등록, 시크릿 패턴 테스트.
- **tests/structure/** -- 프로젝트 구조, 매니페스트, CLAUDE.md 검증.
- **tests/fixtures/** -- 시크릿 감지용 true/false positive 샘플.

## Full Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Upstream Sources                          │
│                                                             │
│  ┌───────────────────┐       ┌───────────────────┐          │
│  │ kirodotdev/powers │       │whchoi98/kiro-cli  │          │
│  │   (25 skills)     │       │-power (11 skills) │          │
│  └────────┬──────────┘       └────────┬──────────┘          │
│           └──────────┬───────────────┘                      │
└──────────────────────┼──────────────────────────────────────┘
                       ▼
              install-skills.sh
              (curl/heredoc download)
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                  Local Archive                               │
│                                                             │
│  ┌─────────────────────────────────────────────┐            │
│  │ .kiro/skills/{skill-name}/SKILL.md (×36)    │            │
│  └─────────────────────┬───────────────────────┘            │
│                        │                                    │
└────────────────────────┼────────────────────────────────────┘
                         ▼
             install-claude-code.sh
                  (file copy)
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│               Claude Code Runtime                            │
│                                                             │
│  ┌─────────────────────────────────────────────┐            │
│  │ ~/.claude/skills/{skill-name}/SKILL.md (×36)│            │
│  └─────────────────────┬───────────────────────┘            │
│                        │                                    │
│                   description                               │
│                   keyword match                             │
│                        ▼                                    │
│             On-demand skill activation                      │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow Summary

```
Upstream repos → install-skills.sh → .kiro/skills/ → install-claude-code.sh → ~/.claude/skills/ → Claude Code 세션
```

## Infrastructure

### Hosting
- **GitHub**: whchoi98/aws-skills-for-claude-code
- **배포**: `git clone` + `bash install-claude-code.sh`
- **의존성**: bash, git (외부 의존성 없음)

### Skill Sources

| Source | Repository | Skills | Description |
|--------|-----------|--------|-------------|
| Powers | kirodotdev/powers | 25 | 범용 개발 스킬 (code-review, refactor, terraform 등) |
| MCP Tool Forge | whchoi98/kiro-cli-power | 11 | AWS 특화 스킬 (aws-iac, aws-sam, cloud-architect 등) |

## Key Design Decisions

- **Heredoc 기반 다운로드** -- 개별 파일을 `curl`로 가져오는 대신 heredoc 블록으로 `install-skills.sh`에 내장하여 네트워크 의존성을 설치 시 1회로 최소화
- **`.kiro/skills/` 원본 보관** -- 업스트림 동기화를 위해 원본을 별도 보관하고, Claude Code 설치는 복사본을 사용
- **YAML frontmatter의 `description` 필드** -- Claude Code가 키워드 매칭으로 스킬을 자동 활성화하므로, 정확한 description이 핵심
- **`name` 필드 생략** -- Agent Skills 스펙에서 디렉토리명이 자동 사용되므로, 불일치 시 행 제거로 해결

## Operations

- Skill 설치: `bash install-claude-code.sh`
- 업스트림 동기화: `bash install-skills.sh`
- 프로젝트 셋업: `bash scripts/setup.sh`
- 테스트 실행: `bash tests/run-all.sh`

---

# English

## System Overview

AWS Skills for Claude Code is a distribution pipeline that collects SKILL.md files from upstream skill repositories and installs them to Claude Code users' `~/.claude/skills/` directory.
It operates purely on Bash scripts with no external dependencies, providing 36 AWS-related skills.
Core data flow: upstream → local archive → Claude Code skills directory.

## Components

### Ingestion Layer
- **.kiro/skills/** -- Archive of 36 skill originals. Minimal changes to maintain upstream sync.
- **install-skills.sh** -- Downloads SKILL.md from upstream repositories via heredoc embedding.

### Distribution Layer
- **install-claude-code.sh** -- Installs by copying `.kiro/skills/` → `~/.claude/skills/`.
- **.kiro/agents/powers.json** -- Kiro agent `skill://` resource mapping configuration.

### Observability Layer
- **.claude/hooks/** -- Documentation sync detection (`check-doc-sync.sh`), secret scanning (`secret-scan.sh`), session context loading (`session-context.sh`), webhook notifications (`notify.sh`).
- **.claude/settings.json** -- Claude Code hook event registration (SessionStart, PreCommit, PostToolUse, Notification).

### Security Layer
- **secret-scan.sh** -- Pre-commit secret blocking with 9 patterns (AWS keys, OpenAI, Anthropic, GitHub, Slack, passwords, etc.).
- **settings.json deny list** -- Blocks dangerous commands: `rm -rf /`, `git push --force origin main`, `git reset --hard`, etc.
- **.git/hooks/commit-msg** -- Auto-removes AI Co-Authored-By lines.

### Testing Layer
- **tests/run-all.sh** -- TAP-format test runner (76 assertions).
- **tests/hooks/** -- Hook existence, permissions, registration, and secret pattern tests.
- **tests/structure/** -- Project structure, manifest, and CLAUDE.md validation.
- **tests/fixtures/** -- True/false positive samples for secret detection.

## Full Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Upstream Sources                          │
│                                                             │
│  ┌───────────────────┐       ┌───────────────────┐          │
│  │ kirodotdev/powers │       │whchoi98/kiro-cli  │          │
│  │   (25 skills)     │       │-power (11 skills) │          │
│  └────────┬──────────┘       └────────┬──────────┘          │
│           └──────────┬───────────────┘                      │
└──────────────────────┼──────────────────────────────────────┘
                       ▼
              install-skills.sh
              (curl/heredoc download)
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                  Local Archive                               │
│                                                             │
│  ┌─────────────────────────────────────────────┐            │
│  │ .kiro/skills/{skill-name}/SKILL.md (×36)    │            │
│  └─────────────────────┬───────────────────────┘            │
│                        │                                    │
└────────────────────────┼────────────────────────────────────┘
                         ▼
             install-claude-code.sh
                  (file copy)
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│               Claude Code Runtime                            │
│                                                             │
│  ┌─────────────────────────────────────────────┐            │
│  │ ~/.claude/skills/{skill-name}/SKILL.md (×36)│            │
│  └─────────────────────┬───────────────────────┘            │
│                        │                                    │
│                   description                               │
│                   keyword match                             │
│                        ▼                                    │
│             On-demand skill activation                      │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow Summary

```
Upstream repos → install-skills.sh → .kiro/skills/ → install-claude-code.sh → ~/.claude/skills/ → Claude Code session
```

## Infrastructure

### Hosting
- **GitHub**: whchoi98/aws-skills-for-claude-code
- **Deployment**: `git clone` + `bash install-claude-code.sh`
- **Dependencies**: bash, git (no external dependencies)

### Skill Sources

| Source | Repository | Skills | Description |
|--------|-----------|--------|-------------|
| Powers | kirodotdev/powers | 25 | General dev skills (code-review, refactor, terraform, etc.) |
| MCP Tool Forge | whchoi98/kiro-cli-power | 11 | AWS-specialized skills (aws-iac, aws-sam, cloud-architect, etc.) |

## Key Design Decisions

- **Heredoc-based download** -- Embed skills as heredoc blocks in `install-skills.sh` instead of individual `curl` calls, minimizing network dependency to a single install step
- **`.kiro/skills/` as source of truth** -- Keep originals separate for upstream sync; Claude Code installation uses copies
- **YAML frontmatter `description` field** -- Claude Code auto-activates skills via keyword matching, making accurate descriptions essential
- **Omit `name` field** -- Agent Skills spec uses directory name automatically; mismatches resolved by removing the line

## Operations

- Install skills: `bash install-claude-code.sh`
- Sync upstream: `bash install-skills.sh`
- Project setup: `bash scripts/setup.sh`
- Run tests: `bash tests/run-all.sh`
