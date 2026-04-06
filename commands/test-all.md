---
description: Validate all skills and project integrity
allowed-tools: Read, Bash(find:*), Bash(ls:*), Bash(head:*), Bash(wc:*), Bash(diff:*), Glob, Grep
---

# Test All

Validate the integrity of all skills and project files.

## Step 1: Skill Validation

For each directory in `skills/`:
1. Verify `SKILL.md` exists
2. Verify YAML frontmatter has `description` field
3. Check description is a single line, not empty

```bash
for dir in skills/*/; do
    skill=$(basename "$dir")
    if [ ! -f "$dir/SKILL.md" ]; then
        echo "FAIL: $skill - missing SKILL.md"
    fi
done
```

## Step 2: Installer Validation

Verify `install-claude-code.sh` references all skills:
- Count skills in `skills/`
- Run installer in dry-run mode if available
- Verify target path `~/.claude/skills/` structure

## Step 3: Documentation Validation

- Verify README.md skill count matches actual count
- Verify CHANGELOG.md is up to date
- Check bilingual sections are present (EN/KR)

## Step 4: Report

Present:
- Total skills validated, passed, failed
- Any missing SKILL.md files
- Documentation sync status
