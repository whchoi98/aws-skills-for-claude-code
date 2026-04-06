#!/bin/bash
# Validate project structure, manifests, and CLAUDE.md.

# Core files
assert_file_exists "CLAUDE.md" "Root CLAUDE.md exists"
assert_file_exists "README.md" "README.md exists"
assert_file_exists "CHANGELOG.md" "CHANGELOG.md exists"
assert_file_exists "LICENSE" "LICENSE exists"
assert_file_exists ".mcp.json" "MCP config exists"
assert_file_exists ".gitignore" ".gitignore exists"
assert_file_exists ".editorconfig" ".editorconfig exists"
assert_file_exists ".env.example" ".env.example exists"

# Directory structure
assert_dir_exists ".claude/hooks" ".claude/hooks/ directory exists"
assert_dir_exists "skills" "skills/ directory exists"
assert_dir_exists "commands" "commands/ directory exists"
assert_dir_exists "agents" "agents/ directory exists"
assert_dir_exists ".claude/agents" ".claude/agents/ directory exists"
assert_dir_exists "docs/decisions" "docs/decisions/ directory exists"
assert_dir_exists "docs/runbooks" "docs/runbooks/ directory exists"
assert_dir_exists "scripts" "scripts/ directory exists"

# Skills have SKILL.md
for skill_dir in skills/*/; do
    name=$(basename "$skill_dir")
    assert_file_exists "$skill_dir/SKILL.md" "Skill $name has SKILL.md"
done

# Commands exist
assert_file_exists "commands/review.md" "review command exists"
assert_file_exists "commands/test-all.md" "test-all command exists"
assert_file_exists "commands/deploy.md" "deploy command exists"

# Agents exist
assert_file_exists ".claude/agents/code-reviewer.yml" "code-reviewer agent exists"
assert_file_exists ".claude/agents/security-auditor.yml" "security-auditor agent exists"

# Docs
assert_file_exists "docs/architecture.md" "architecture.md exists"
assert_file_exists "docs/onboarding.md" "onboarding.md exists"
assert_file_exists "docs/decisions/.template.md" "ADR template exists"
assert_file_exists "docs/runbooks/.template.md" "Runbook template exists"

# Scripts are executable
assert_executable "scripts/setup.sh" "setup.sh is executable"
assert_executable "scripts/install-hooks.sh" "install-hooks.sh is executable"
assert_executable "install-claude-code.sh" "install-claude-code.sh is executable"
assert_executable "install-skills.sh" "install-skills.sh is executable"

# CLAUDE.md contains required sections
assert_contains "CLAUDE.md" "Tech Stack" "CLAUDE.md has Tech Stack section"
assert_contains "CLAUDE.md" "Project Structure" "CLAUDE.md has Project Structure section"
assert_contains "CLAUDE.md" "Conventions" "CLAUDE.md has Conventions section"
assert_contains "CLAUDE.md" "Key Commands" "CLAUDE.md has Key Commands section"
assert_contains "CLAUDE.md" "Auto-Sync Rules" "CLAUDE.md has Auto-Sync Rules section"

# Skills count
SKILL_COUNT=$(find skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
[ "$SKILL_COUNT" -ge 30 ] && pass "At least 30 skills present ($SKILL_COUNT)" || fail "Expected 30+ skills, found $SKILL_COUNT"

# Each skill has SKILL.md with description
MISSING_DESC=0
for dir in skills/*/; do
    if ! head -3 "$dir/SKILL.md" 2>/dev/null | grep -q 'description:'; then
        MISSING_DESC=$((MISSING_DESC + 1))
    fi
done
[ "$MISSING_DESC" -eq 0 ] && pass "All skills have description in SKILL.md" || fail "$MISSING_DESC skills missing description"
