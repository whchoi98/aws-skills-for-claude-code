# Architecture

## System Overview

AWS Skills for Claude Code는 업스트림 스킬 리포지토리에서 SKILL.md 파일을 수집하고, Claude Code 사용자의 `~/.claude/skills/`에 설치하는 배포 파이프라인입니다.

## Components

| Component | Path | Role |
|-----------|------|------|
| Skill Source (Powers) | upstream repo | 25개 스킬 원본 |
| Skill Source (MCP Tool Forge) | upstream repo | 11개 스킬 원본 |
| Skill Archive | `.kiro/skills/` | 업스트림 원본 보관 (36개) |
| Kiro Agent Config | `.kiro/agents/powers.json` | Kiro `skill://` 리소스 매핑 |
| Claude Code Installer | `install-claude-code.sh` | `.kiro/skills/` → `~/.claude/skills/` 복사 |
| Kiro Installer | `install-skills.sh` | 업스트림 → `.kiro/skills/` 다운로드 |

## Data Flow

```
1. install-skills.sh
   업스트림 리포지토리 → .kiro/skills/{name}/SKILL.md (heredoc 방식)

2. install-claude-code.sh
   .kiro/skills/{name}/SKILL.md → ~/.claude/skills/{name}/SKILL.md (파일 복사)

3. Claude Code 세션
   ~/.claude/skills/ 스캔 → description 매칭 → 온디맨드 로딩
```

## Infrastructure

- **호스팅**: GitHub (whchoi98/aws-skills-for-claude-code)
- **배포**: `git clone` + `bash install-claude-code.sh`
- **의존성**: bash, git (외부 의존성 없음)
