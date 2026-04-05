#!/bin/bash
# Load project context at Claude Code session start.
# Outputs key project information for immediate context.

echo "=== Project Context ==="

# Project type detection
echo "Project: aws-skills-for-claude-code (Bash/Shell)"

# Skill count
SKILL_COUNT=$(find .kiro/skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
echo "Skills: $SKILL_COUNT"

# Recent activity
LAST_COMMIT=$(git log -1 --format="%h %s (%cr)" 2>/dev/null)
[ -n "$LAST_COMMIT" ] && echo "Last commit: $LAST_COMMIT"

# Branch info
BRANCH=$(git branch --show-current 2>/dev/null)
[ -n "$BRANCH" ] && echo "Branch: $BRANCH"

# Uncommitted changes
CHANGES=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
[ "$CHANGES" -gt 0 ] && echo "Uncommitted changes: $CHANGES file(s)"

# Documentation status
CLAUDE_COUNT=$(find . -name "CLAUDE.md" -not -path "./.git/*" 2>/dev/null | wc -l | tr -d ' ')
echo "CLAUDE.md files: $CLAUDE_COUNT"

echo "======================"
