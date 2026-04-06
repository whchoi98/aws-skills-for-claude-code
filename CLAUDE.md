# Project Context

## Overview

AWS Skills for Claude Code — Claude Code 사용자가 AWS 환경에서 개발과 배포를 효율적으로 수행할 수 있도록 36개 스킬을 제공하는 Claude Code 플러그인.

## Tech Stack

- **Shell**: Bash (macOS / Linux 호환)
- **Spec**: Agent Skills (agentskills.io), Claude Code Plugin
- **Format**: YAML frontmatter + Markdown (SKILL.md, commands, agents)

## Project Structure

```
.claude-plugin/        - 플러그인 매니페스트 (plugin.json, marketplace.json)
skills/                - 36개 스킬 (업스트림 + 프로젝트 커스텀)
commands/              - 슬래시 커맨드 (/review, /test-all, /deploy)
agents/                - 플러그인 에이전트 MD (code-reviewer, security-auditor)
hooks/                 - 플러그인 훅 설정 (hooks.json)
.claude/hooks/         - Claude Code 훅 스크립트 (doc-sync, secret-scan, session-context, notify)
.claude/agents/        - 에이전트 정의 YML (개발용)
.kiro/agents/          - Kiro 에이전트 설정 (powers.json)
docs/                  - 아키텍처 문서, ADR, 런북, 온보딩
scripts/               - 운영 스크립트 (setup.sh, install-hooks.sh)
tests/                 - TAP 형식 테스트 스위트 (hooks, structure, fixtures)
tools/                 - 스크립트, 프롬프트 (예약 — 현재 비어 있음)
install-claude-code.sh - ~/.claude/skills/로 스킬 설치 (레거시)
install-skills.sh      - 업스트림에서 스킬 다운로드
```

## Architecture

### Marketplace Install (권장)
```
claude plugin marketplace add https://github.com/whchoi98/aws-skills-for-claude-code
claude plugin install aws-skills-for-claude-code@aws-skills-for-claude-code
  → skills/ + commands/ + agents/ + hooks/ 자동 발견
  → 36개 스킬 + 3개 커맨드 + 2개 에이전트 + 2개 훅 활성화
```

### Local Plugin Install
```
git clone → claude plugins add ./aws-skills-for-claude-code
  → 동일하게 auto-discovery
```

### Legacy Install (스킬만)
```
upstream (Powers, MCP Tool Forge)
  ↓ install-skills.sh (다운로드)
skills/{skill-name}/SKILL.md  → 스킬 보관
  ↓ install-claude-code.sh (복사)
~/.claude/skills/{skill-name}/SKILL.md → Claude Code에서 사용
```

- `skills/`는 표준 플러그인 디렉토리 (auto-discovery)
- Skills는 YAML frontmatter(`description`)로 키워드 기반 자동 활성화

## Skill Sources

- **Powers** (25 skills): [kirodotdev/powers](https://github.com/kirodotdev/powers)
- **MCP Tool Forge** (11 skills): [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power)

## Conventions

- Documentation is bilingual (English / Korean)
- Commit messages: [Conventional Commits](https://www.conventionalcommits.org/) — `feat:`, `fix:`, `docs:`, `chore:`
- CHANGELOG: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
- Versioning: [Semantic Versioning](https://semver.org/)

## SKILL.md Format

Agent Skills 스펙 준수. `name` 필드는 디렉토리명과 불일치 시 생략 (디렉토리명 자동 사용).

```yaml
---
description: One-line description for keyword-triggered activation. Use when...
---
```

## Upstream Sync

- `skills/` 내 업스트림 원본은 동기화를 위해 최소한의 변경만 유지
- `name` 필드가 디렉토리명과 불일치하는 경우 행 제거로 해결 (내용 수정 아님)
- 4개 프로젝트 스킬(code-review, refactor, release, sync-docs)은 커스텀 버전으로 덮어씀

## Key Commands

```bash
# 마켓플레이스 설치
claude plugin marketplace add https://github.com/whchoi98/aws-skills-for-claude-code
claude plugin install aws-skills-for-claude-code@aws-skills-for-claude-code

# 레거시 스킬 설치
bash install-claude-code.sh

# 업스트림에서 스킬 다운로드
bash install-skills.sh

# 프로젝트 셋업 (신규 개발자)
bash scripts/setup.sh

# Git 훅 설치
bash scripts/install-hooks.sh

# 테스트 스위트 실행
bash tests/run-all.sh
```

## Verification

```bash
# Validate all skills have SKILL.md with description
for dir in skills/*/; do
    head -3 "$dir/SKILL.md" 2>/dev/null | grep -q 'description:' || echo "FAIL: $(basename $dir)"
done

# Verify install works
bash install-claude-code.sh && ls ~/.claude/skills/ | wc -l
```

## Slash Commands

| Command | Description |
|---------|-------------|
| `/review` | Confidence-based code review on current changes |
| `/test-all` | Validate all 36 skills and project integrity |
| `/deploy` | Install skills to `~/.claude/skills/` |

## Hooks

| Event | Script | Purpose |
|-------|--------|---------|
| SessionStart | `session-context.sh` | Load project context at session start |
| PreCommit | `secret-scan.sh` | Block commits containing secrets |
| PostToolUse | `check-doc-sync.sh` | Detect missing docs after file changes |
| Notification | `notify.sh` | Send webhook alerts (requires `CLAUDE_NOTIFY_WEBHOOK`) |
| Git commit-msg | `.git/hooks/commit-msg` | Remove AI Co-Authored-By lines |

## Key Files

| File | Purpose |
|------|---------|
| `.claude-plugin/plugin.json` | Plugin manifest (name, version, auto-discovery) |
| `.claude-plugin/marketplace.json` | Independent marketplace manifest |
| `skills/` | All 36 skill directories |
| `commands/` | Slash commands (review, test-all, deploy) |
| `agents/*.md` | Plugin agent definitions (code-reviewer, security-auditor) |
| `hooks/hooks.json` | Plugin hook configuration (SessionStart, Notification) |
| `.claude/settings.json` | Claude Code hooks and permissions (dev) |
| `.kiro/agents/powers.json` | Kiro agent configuration |
| `install-claude-code.sh` | Legacy installer (copies to `~/.claude/skills/`) |
| `install-skills.sh` | Downloads skills from upstream repos |
| `scripts/setup.sh` | One-command project setup |
| `scripts/install-hooks.sh` | Git hooks installer |
| `tests/run-all.sh` | TAP-format test runner |
| `docs/architecture.md` | Bilingual architecture document |
| `docs/onboarding.md` | Developer onboarding guide |

---

## Auto-Sync Rules

Rules below are applied automatically after Plan mode exit and on major code changes.

### Post-Plan Mode Actions
After exiting Plan mode (`/plan`), before starting implementation:

1. **Architecture decision made** -> Update `docs/architecture.md`
2. **Technical choice/trade-off made** -> Create `docs/decisions/ADR-NNN-title.md`
3. **New skill added** -> Create SKILL.md in `skills/<name>/`
4. **Operational procedure defined** -> Create runbook in `docs/runbooks/`
5. **Changes needed in this file** -> Update relevant sections above

### Code Change Sync Rules
- New skill directory added -> Must have `SKILL.md` with YAML frontmatter
- `install-claude-code.sh` changed -> Update Key Commands section
- Skill count changed -> Update README (both EN/KR sections) and CHANGELOG
- Version bumped -> Update README badge, CHANGELOG, comparison links

### ADR Numbering
Find the highest number in `docs/decisions/ADR-*.md` and increment by 1.
Format: `ADR-NNN-concise-title.md`
