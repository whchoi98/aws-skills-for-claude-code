# Runbook: Upstream Skill Sync

## Overview
Synchronize local skill archive with upstream repositories (Powers, MCP Tool Forge) when new skills are added or existing skills are updated upstream.

## When to Use
- Upstream repository releases new skills
- Existing upstream skills have been updated
- Periodic maintenance sync (recommended: monthly)

## Prerequisites
- Git access to this repository
- Network access to GitHub
- Bash shell

## Procedure

### 1. Check Current State
```bash
# Count current skills
ls -d skills/*/ | wc -l

# Check last sync date
git log --oneline -1 -- install-skills.sh
```

### 2. Run Upstream Sync
```bash
# Download latest skills from upstream
bash install-skills.sh
```

### 3. Verify Changes
```bash
# Check what changed
git diff --stat skills/

# Review any new skills
git diff --name-only --diff-filter=A skills/
```

### 4. Fix Name Field Mismatches
```bash
# For any skill where `name:` doesn't match the directory name,
# remove the `name:` line from the YAML frontmatter
# (directory name is used automatically by the Agent Skills spec)
```

### 5. Update Documentation
- Update skill count in `README.md` (both EN/KR sections)
- Update `CHANGELOG.md` with new skills
- Update `CLAUDE.md` if skill count changed

### 6. Deploy to Claude Code
```bash
bash install-claude-code.sh
```

### 7. Commit
```bash
git add skills/ install-skills.sh README.md CHANGELOG.md
git commit -m "feat: sync upstream skills (N total)"
```

## Verification
- [ ] `ls skills/*/ | wc -l` matches expected count
- [ ] All SKILL.md files have `description:` in frontmatter
- [ ] README skill count matches actual count
- [ ] `bash install-claude-code.sh` completes without errors

## Rollback
```bash
# Revert to previous state
git checkout HEAD -- skills/ install-skills.sh
```

## Notes
- Last verified: 2026-04-05
