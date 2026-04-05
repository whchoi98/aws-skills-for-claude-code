# ADR-001: Heredoc-based Skill Embedding in install-skills.sh

## Status
Accepted

## Context

Skills need to be downloaded from two upstream repositories (kirodotdev/powers, whchoi98/kiro-cli-power) and stored locally for distribution. Two approaches were considered:

### Option 1: Individual curl downloads
- **Pros**: Always fetches latest version, simple per-file logic
- **Cons**: Requires network access on every install, 36+ HTTP requests, fragile if any URL changes

### Option 2: Heredoc embedding in install-skills.sh
- **Pros**: Single-file distribution, works offline after initial download, atomic install
- **Cons**: Large script file (~70KB), requires manual re-run of `install-skills.sh` to update

## Decision

Use heredoc embedding (Option 2). Each skill's SKILL.md content is embedded as a heredoc block within `install-skills.sh`. The script writes each block to the corresponding `.kiro/skills/<name>/SKILL.md` path.

## Consequences

### Positive
- Zero network dependency during `install-claude-code.sh` (end-user install)
- Single script contains all 36 skills — easy to version and distribute
- Installation is atomic and idempotent

### Negative
- `install-skills.sh` is large (~70KB) and must be regenerated when upstream skills change
- Upstream sync requires re-running the download process and committing the updated script
