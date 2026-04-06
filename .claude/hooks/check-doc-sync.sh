#!/bin/bash
# Detect documentation sync needs after file changes.
# Triggered by PostToolUse (Write|Edit) events.

FILE_PATH="${1:-}"
[ -z "$FILE_PATH" ] && exit 0

# Detect missing SKILL.md in skills/ subdirectories
if [[ "$FILE_PATH" == skills/* ]]; then
    DIR=$(dirname "$FILE_PATH")
    if [ ! -f "$DIR/SKILL.md" ] && [ "$DIR" != "skills" ]; then
        echo "[doc-sync] $DIR/SKILL.md is missing. Create skill documentation."
    fi
fi

# Alert if no ADRs exist when source or architecture files change
if [[ "$FILE_PATH" == skills/* ]] || [[ "$FILE_PATH" == docs/architecture.md ]]; then
    ADR_COUNT=$(find docs/decisions -name 'ADR-*.md' 2>/dev/null | wc -l)
    if [ "$ADR_COUNT" -eq 0 ]; then
        echo "[doc-sync] No ADRs found. Record architectural decisions."
    fi
fi
