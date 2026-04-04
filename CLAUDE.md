# Project Context

## Overview

AWS Skills for Claude Code — Claude Code 사용자가 AWS 환경에서 개발과 배포를 효율적으로 수행할 수 있도록 36개 스킬을 제공하는 배포 프로젝트.

## Tech Stack

- **Shell**: Bash (macOS / Linux 호환)
- **Spec**: Agent Skills (agentskills.io)
- **Format**: YAML frontmatter + Markdown (SKILL.md)

## Project Structure

```
.kiro/skills/       - 36개 스킬 원본 보관 (업스트림 동기화)
.claude/            - Claude Code 설정, hooks, 프로젝트 스킬
docs/               - 아키텍처 문서, ADR, 런북
tools/              - 스크립트, 프롬프트
install-claude-code.sh - ~/.claude/skills/로 스킬 설치
install-skills.sh      - 업스트림에서 스킬 다운로드
```

## Architecture

```
upstream (Powers, MCP Tool Forge)
  ↓ install-skills.sh (다운로드)
.kiro/skills/{skill-name}/SKILL.md  → 원본 보관
  ↓ install-claude-code.sh (복사)
~/.claude/skills/{skill-name}/SKILL.md → Claude Code에서 사용
```

- `.kiro/skills/`는 업스트림 원본의 보관 디렉토리 (수정 최소화)
- `install-claude-code.sh`가 `~/.claude/skills/`로 복사하여 Claude Code에서 온디맨드 로딩
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

- `.kiro/skills/` 내 원본은 업스트림과 동기화를 위해 최소한의 변경만 유지
- `name` 필드가 디렉토리명과 불일치하는 경우 행 제거로 해결 (내용 수정 아님)

## Key Commands

```bash
# 스킬 설치 (Claude Code)
bash install-claude-code.sh

# 업스트림에서 스킬 다운로드 (Kiro)
bash install-skills.sh

# 스킬 검증
ls ~/.claude/skills/
```

## Key Files

| File | Purpose |
|------|---------|
| `install-claude-code.sh` | Installs skills to `~/.claude/skills/` |
| `install-skills.sh` | Downloads skills from upstream repos |
| `.kiro/skills/` | All 36 skill directories |
| `.kiro/agents/powers.json` | Kiro agent configuration |

---

## Auto-Sync Rules

Rules below are applied automatically after Plan mode exit and on major code changes.

### Post-Plan Mode Actions
After exiting Plan mode (`/plan`), before starting implementation:

1. **Architecture decision made** -> Update `docs/architecture.md`
2. **Technical choice/trade-off made** -> Create `docs/decisions/ADR-NNN-title.md`
3. **New skill added** -> Create SKILL.md in `.kiro/skills/<name>/`
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
