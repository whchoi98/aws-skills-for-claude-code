# ADR-002: Two-Stage Install Pipeline (.kiro → .claude)

## Status
Accepted

## Context

Skills need to be both archived (for upstream sync) and deployed (for Claude Code use). Three approaches were considered:

### Option 1: Install directly from upstream to ~/.claude/skills/
- **Pros**: Simple, one step
- **Cons**: No local archive, can't track changes, no version control of skill contents

### Option 2: Single directory used for both archive and deployment
- **Pros**: No duplication
- **Cons**: Kiro and Claude Code may have different requirements for the same files

### Option 3: Two-stage pipeline (.kiro/skills/ → ~/.claude/skills/)
- **Pros**: Clean separation, upstream originals preserved, independent toolchains
- **Cons**: Two install scripts, slight duplication of files

## Decision

Use two-stage pipeline (Option 3):
1. `install-skills.sh` downloads upstream → `.kiro/skills/` (archive)
2. `install-claude-code.sh` copies `.kiro/skills/` → `~/.claude/skills/` (deploy)

## Consequences

### Positive
- `.kiro/skills/` stays close to upstream originals (minimal diff for sync)
- `~/.claude/skills/` can be modified without affecting the archive
- Each installer can evolve independently (Kiro vs Claude Code)

### Negative
- Two scripts to maintain instead of one
- Users must understand the two-stage model
