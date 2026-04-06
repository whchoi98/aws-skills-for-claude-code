# Developer Onboarding

## Quick Start

### 1. Prerequisites
- [ ] Bash 4+ installed (macOS: `brew install bash`, Linux: pre-installed)
- [ ] Git installed
- [ ] Claude Code CLI installed
- [ ] Repository access granted

### 2. Setup

```bash
# Clone the repository
git clone https://github.com/whchoi98/aws-skills-for-claude-code.git
cd aws-skills-for-claude-code

# Option A: Marketplace install (recommended)
claude plugin marketplace add https://github.com/whchoi98/aws-skills-for-claude-code
claude plugin install aws-skills-for-claude-code@aws-skills-for-claude-code

# Option B: Local plugin install (40 skills + commands + agents + hooks)
claude plugins add ./aws-skills-for-claude-code

# Option C: Legacy install (skills only — 36 upstream skills)
bash scripts/setup.sh
bash install-claude-code.sh
```

### 3. Verify

```bash
# Check skills are installed
ls ~/.claude/skills/

# Count installed skills (should be 36)
ls -d ~/.claude/skills/*/ | wc -l

# Run test suite (should output 76 passed, 0 failed)
bash tests/run-all.sh
```

## Project Overview

This project distributes 36 AWS-focused skills for Claude Code. Skills are sourced from two upstream repositories and installed to `~/.claude/skills/` for on-demand activation.

- Read `CLAUDE.md` for project context and conventions
- Read `docs/architecture.md` for system design
- Review `docs/decisions/` for architectural decisions

### Architecture at a Glance

```
Upstream repos → install-skills.sh → .kiro/skills/ → install-claude-code.sh → ~/.claude/skills/
```

## Development Workflow

### Adding a New Skill
1. Add SKILL.md to `.kiro/skills/<skill-name>/SKILL.md`
2. Ensure YAML frontmatter has `description` field
3. Update `install-claude-code.sh` if needed
4. Update README.md skill count (EN/KR sections)
5. Update CHANGELOG.md

### Conventions
- Branch naming: `feat/`, `fix/`, `docs/`, `refactor/`
- Commit convention: [Conventional Commits](https://www.conventionalcommits.org/) — `feat:`, `fix:`, `docs:`, `chore:`
- Documentation: Bilingual (English / Korean)
- CHANGELOG: [Keep a Changelog](https://keepachangelog.com/)

## Key Concepts

| Term | Meaning |
|------|---------|
| SKILL.md | Agent Skills spec file with YAML frontmatter for keyword-triggered activation |
| Powers | Upstream skill source from [kirodotdev/powers](https://github.com/kirodotdev/powers) (25 skills) |
| MCP Tool Forge | Upstream skill source from [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power) (11 skills) |
| `.kiro/skills/` | Local archive of upstream skill originals |
| `~/.claude/skills/` | Claude Code's skill loading directory |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Skills not loading in Claude Code | Run `bash install-claude-code.sh` and restart Claude Code |
| `install-skills.sh` fails | Check network access to GitHub; verify `curl`/`wget` available |
| Permission denied on hooks | Run `chmod +x .claude/hooks/*.sh` |
| Skill count mismatch | Run `ls .kiro/skills/ | wc -l` to verify, update README |

## Resources

- [Agent Skills Spec](https://agentskills.io) — SKILL.md format specification
- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code) — Claude Code documentation
- [Powers repo](https://github.com/kirodotdev/powers) — Upstream skill source
