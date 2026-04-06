---
description: Install skills to ~/.claude/skills/ for local use
allowed-tools: Read, Bash(bash install-claude-code.sh:*), Bash(ls:*), Bash(find:*), Bash(git status:*), Glob
---

# Deploy (Install Skills)

Install all skills from `skills/` to `~/.claude/skills/` for Claude Code use.

## Step 1: Pre-Deploy Checks

1. Verify working tree is clean: `git status`
2. Verify `skills/` has skills to install
3. Verify `install-claude-code.sh` exists and is executable

## Step 2: Install

Run the installer:

```bash
bash install-claude-code.sh
```

## Step 3: Verify

After installation:
- Count installed skills: `ls ~/.claude/skills/ | wc -l`
- Verify all `skills/` entries are present in `~/.claude/skills/`
- Spot-check YAML frontmatter in a few installed skills

## Step 4: Summary

Display:
- Number of skills installed
- Source and target paths
- Any missing or failed installations
