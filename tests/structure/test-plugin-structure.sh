#!/bin/bash
# Validate Claude Code plugin structure.

# Plugin manifest
assert_file_exists ".claude-plugin/plugin.json" "Plugin manifest exists"
assert_contains ".claude-plugin/plugin.json" '"name"' "plugin.json has name field"
assert_contains ".claude-plugin/plugin.json" '"version"' "plugin.json has version field"
assert_contains ".claude-plugin/plugin.json" '"description"' "plugin.json has description field"
assert_contains ".claude-plugin/plugin.json" '"commands"' "plugin.json has commands path"
assert_contains ".claude-plugin/plugin.json" '"skills"' "plugin.json has skills path"

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

# Commands referenced by plugin
assert_file_exists ".claude/commands/review.md" "review command exists for plugin"
assert_file_exists ".claude/commands/test-all.md" "test-all command exists for plugin"
assert_file_exists ".claude/commands/deploy.md" "deploy command exists for plugin"

# Project skills have YAML frontmatter (required for plugin discovery)
for skill_dir in .claude/skills/*/; do
    name=$(basename "$skill_dir")
    head -3 "$skill_dir/SKILL.md" 2>/dev/null | grep -q 'description:' \
        && pass "Project skill $name has description frontmatter" \
        || fail "Project skill $name missing description frontmatter"
done

# Upstream skills referenced by plugin
UPSTREAM_COUNT=$(find .kiro/skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
[ "$UPSTREAM_COUNT" -ge 30 ] && pass "Plugin references $UPSTREAM_COUNT upstream skills" || fail "Expected 30+ upstream skills, found $UPSTREAM_COUNT"

# Total skill count (upstream + project)
PROJECT_SKILL_COUNT=$(find .claude/skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
SKILL_TOTAL=$((UPSTREAM_COUNT + PROJECT_SKILL_COUNT))
[ "$SKILL_TOTAL" -ge 40 ] && pass "Total plugin skills: $SKILL_TOTAL (>= 40)" || fail "Expected 40+ total skills, found $SKILL_TOTAL"
