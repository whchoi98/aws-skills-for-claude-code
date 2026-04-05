#!/bin/bash
# Project setup script for new developers.
# Usage: bash scripts/setup.sh

set -e

echo "=== Project Setup ==="

# Check prerequisites
command -v git >/dev/null 2>&1 || { echo "ERROR: git is required"; exit 1; }
command -v bash >/dev/null 2>&1 || { echo "ERROR: bash is required"; exit 1; }

# Verify skill sources exist
SKILL_COUNT=$(find .kiro/skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
echo "Found $SKILL_COUNT skills in .kiro/skills/"

# Setup environment
if [ -f ".env.example" ] && [ ! -f ".env" ]; then
    echo "Creating .env from .env.example..."
    cp .env.example .env
    echo "IMPORTANT: Edit .env with your actual values"
fi

# Setup Claude hooks
if [ -f ".claude/hooks/check-doc-sync.sh" ]; then
    chmod +x .claude/hooks/*.sh
    echo "Claude hooks configured"
fi

# Install Git hooks
if [ -d ".git" ]; then
    if [ -f "scripts/install-hooks.sh" ]; then
        bash scripts/install-hooks.sh
    fi
fi

# Install skills to Claude Code
if [ -f "install-claude-code.sh" ]; then
    echo ""
    echo "To install skills to Claude Code, run:"
    echo "  bash install-claude-code.sh"
fi

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo "  1. Run 'bash install-claude-code.sh' to install skills"
echo "  2. Read CLAUDE.md for project conventions"
echo "  3. Read docs/onboarding.md for development workflow"
