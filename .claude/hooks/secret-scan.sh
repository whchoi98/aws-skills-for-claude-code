#!/bin/bash
# Scan staged files for secrets before commit.
# Triggered by PreCommit event.
# Exit 1 to block the commit if secrets are found.

SECRETS_FOUND=0

# Patterns to detect
PATTERNS=(
    'AKIA[0-9A-Z]{16}'                          # AWS Access Key ID
    '[A-Za-z0-9/+=]{40}'                         # AWS Secret Key (heuristic)
    'sk-[A-Za-z0-9]{48}'                         # OpenAI API Key
    'sk-ant-[A-Za-z0-9-]{95}'                    # Anthropic API Key
    'ghp_[A-Za-z0-9]{36}'                        # GitHub Personal Access Token
    'xoxb-[0-9]+-[A-Za-z0-9]+'                   # Slack Bot Token
    'password\s*[:=]\s*["\x27][^"\x27]{8,}'      # Password assignments
    'secret\s*[:=]\s*["\x27][^"\x27]{8,}'        # Secret assignments
    'api[_-]?key\s*[:=]\s*["\x27][^"\x27]{8,}'   # API key assignments
)

# Files to skip
SKIP_PATTERNS=('.env.example' 'secret-scan.sh' '*.md' 'package-lock.json' 'yarn.lock')

# Get staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null)
[ -z "$STAGED_FILES" ] && exit 0

for file in $STAGED_FILES; do
    # Skip binary files and excluded patterns
    skip=false
    for pattern in "${SKIP_PATTERNS[@]}"; do
        [[ "$file" == $pattern ]] && skip=true && break
    done
    $skip && continue
    [ ! -f "$file" ] && continue

    for regex in "${PATTERNS[@]}"; do
        if grep -qP "$regex" "$file" 2>/dev/null; then
            echo "[secret-scan] Potential secret found in $file (pattern: ${regex:0:30}...)"
            SECRETS_FOUND=1
        fi
    done
done

if [ "$SECRETS_FOUND" -eq 1 ]; then
    echo ""
    echo "[secret-scan] BLOCKED: Potential secrets detected in staged files."
    echo "[secret-scan] Review the files above and remove secrets before committing."
    echo "[secret-scan] Use .env files for secrets and .env.example for templates."
    exit 1
fi
