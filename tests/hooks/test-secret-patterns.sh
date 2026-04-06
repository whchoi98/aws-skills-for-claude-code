#!/bin/bash
# Test secret scanning patterns for true positives and false positives.

PATTERNS=(
    'AKIA[0-9A-Z]{16}'
    '[A-Za-z0-9/+=]{40}'
    'sk-[A-Za-z0-9]{48}'
    'sk-ant-[A-Za-z0-9-]{95}'
    'ghp_[A-Za-z0-9]{36}'
    'xoxb-[0-9]+-[A-Za-z0-9]+'
    'password\s*[:=]\s*["\x27][^"\x27]{8,}'
    'secret\s*[:=]\s*["\x27][^"\x27]{8,}'
    'api[_-]?key\s*[:=]\s*["\x27][^"\x27]{8,}'
)

# True positives: these SHOULD be detected
while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    matched=false
    for regex in "${PATTERNS[@]}"; do
        echo "$line" | grep -qP "$regex" 2>/dev/null && matched=true && break
    done
    $matched && pass "Detects: ${line:0:40}..." || fail "Missed: ${line:0:40}..."
done < tests/fixtures/secret-samples.txt

# False positives: these should NOT be detected
while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    matched=false
    for regex in "${PATTERNS[@]}"; do
        echo "$line" | grep -qP "$regex" 2>/dev/null && matched=true && break
    done
    $matched && fail "False positive: ${line:0:40}..." || pass "Ignores: ${line:0:40}..."
done < tests/fixtures/false-positives.txt
