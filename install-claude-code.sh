#!/usr/bin/env bash
set -euo pipefail

# Claude Code Global Skills Installer
# Converts kiro-cli-power skills to ~/.claude/skills/ for on-demand loading
# Works on macOS and Linux
# Usage: bash install-claude-code.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIRO_SKILLS_DIR="${SCRIPT_DIR}/.kiro/skills"
CLAUDE_SKILLS_DIR="${HOME}/.claude/skills"

if [ ! -d "${KIRO_SKILLS_DIR}" ]; then
  echo "Error: Source skills not found at ${KIRO_SKILLS_DIR}"
  echo "Run this script from the kiro-cli-power project root."
  exit 1
fi

echo "Installing Kiro Power Skills to Claude Code..."
echo "  Source: ${KIRO_SKILLS_DIR}"
echo "  Target: ${CLAUDE_SKILLS_DIR}"
echo ""

mkdir -p "${CLAUDE_SKILLS_DIR}"

installed=0
skipped=0

for skill_dir in "${KIRO_SKILLS_DIR}"/*/; do
  skill_name="$(basename "${skill_dir}")"
  skill_file="${skill_dir}SKILL.md"

  if [ ! -f "${skill_file}" ]; then
    echo "  [skip] ${skill_name} (no SKILL.md)"
    skipped=$((skipped + 1))
    continue
  fi

  target_dir="${CLAUDE_SKILLS_DIR}/${skill_name}"
  mkdir -p "${target_dir}"
  cp "${skill_file}" "${target_dir}/SKILL.md"
  echo "  [ok] ${skill_name}"
  installed=$((installed + 1))
done

echo ""
echo "Done! ${installed} skills installed, ${skipped} skipped."
echo ""
echo "Usage in Claude Code:"
echo "  /aws-cloudwatch     — invoke a skill manually"
echo "  Just mention keywords like 'CloudWatch', 'Stripe', etc."
echo "  Claude will auto-detect and load the relevant skill."
echo ""
echo "To verify:"
echo "  ls ~/.claude/skills/"
