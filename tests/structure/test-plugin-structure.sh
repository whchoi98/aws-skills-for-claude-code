#!/bin/bash
# Validate Claude Code plugin structure.

# Plugin manifest
assert_file_exists ".claude-plugin/plugin.json" "Plugin manifest exists"
assert_contains ".claude-plugin/plugin.json" '"name"' "plugin.json has name field"
assert_contains ".claude-plugin/plugin.json" '"version"' "plugin.json has version field"
assert_contains ".claude-plugin/plugin.json" '"description"' "plugin.json has description field"

# Marketplace manifest
assert_file_exists ".claude-plugin/marketplace.json" "Marketplace manifest exists"
assert_contains ".claude-plugin/marketplace.json" '"name"' "marketplace.json has name field"
assert_contains ".claude-plugin/marketplace.json" '"plugins"' "marketplace.json has plugins array"

# Plugin agents (Markdown format)
assert_dir_exists "agents" "Plugin agents/ directory exists"
assert_file_exists "agents/code-reviewer.md" "code-reviewer agent exists (md)"
assert_file_exists "agents/security-auditor.md" "security-auditor agent exists (md)"
assert_contains "agents/code-reviewer.md" "description:" "code-reviewer has description frontmatter"
assert_contains "agents/security-auditor.md" "description:" "security-auditor has description frontmatter"

# Plugin hooks
assert_file_exists "hooks/hooks.json" "Plugin hooks.json exists"
assert_contains "hooks/hooks.json" "SessionStart" "hooks.json has SessionStart event"
assert_contains "hooks/hooks.json" "CLAUDE_PLUGIN_ROOT" "hooks.json uses CLAUDE_PLUGIN_ROOT"

# Standard commands directory
assert_dir_exists "commands" "Plugin commands/ directory exists"
assert_file_exists "commands/review.md" "review command exists"
assert_file_exists "commands/test-all.md" "test-all command exists"
assert_file_exists "commands/deploy.md" "deploy command exists"

# Standard skills directory
assert_dir_exists "skills" "Plugin skills/ directory exists"

# Skills have YAML frontmatter (required for plugin discovery)
SKILL_COUNT=$(find skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
[ "$SKILL_COUNT" -ge 36 ] && pass "Plugin has $SKILL_COUNT skills (>= 36)" || fail "Expected 36+ skills, found $SKILL_COUNT"

# Spot-check key skills have description frontmatter
for skill_name in code-review aws-cloudwatch terraform stripe; do
    if [ -d "skills/$skill_name" ]; then
        head -3 "skills/$skill_name/SKILL.md" 2>/dev/null | grep -q 'description:' \
            && pass "Skill $skill_name has description frontmatter" \
            || fail "Skill $skill_name missing description frontmatter"
    fi
done
