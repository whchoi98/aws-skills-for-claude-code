# AWS Skills for Claude Code

## Project Overview

Claude Code 사용자가 AWS 환경에서 개발과 배포를 효율적으로 수행할 수 있도록 36개 스킬을 제공하는 배포 프로젝트입니다.

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
- Commit messages use [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, `chore:`
- CHANGELOG follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format
- Version follows [Semantic Versioning](https://semver.org/)

## SKILL.md Format

Agent Skills 스펙(agentskills.io) 준수. `name` 필드는 디렉토리명과 불일치하는 경우 생략 (디렉토리명이 자동 사용됨).

```yaml
---
description: One-line description for keyword-triggered activation. Use when...
---
```

Followed by markdown content with usage examples (CLI commands, Python/boto3 snippets).

## Upstream Sync

- `.kiro/skills/` 내 원본은 업스트림과 동기화를 위해 최소한의 변경만 유지
- `name` 필드가 디렉토리명과 불일치하는 경우 행 제거로 해결 (내용 수정 아님)

## Key Files

| File | Purpose |
|------|---------|
| `install-claude-code.sh` | Installs skills to `~/.claude/skills/` |
| `install-skills.sh` | Downloads skills from upstream repos |
| `.kiro/skills/` | All 36 skill directories |
| `.kiro/agents/powers.json` | Kiro agent configuration |
