#!/bin/bash
# Test runner with TAP-style output.
# Usage: bash tests/run-all.sh

set -euo pipefail

PASS=0
FAIL=0
TOTAL=0

pass() {
    TOTAL=$((TOTAL + 1))
    PASS=$((PASS + 1))
    echo "ok $TOTAL - $1"
}

fail() {
    TOTAL=$((TOTAL + 1))
    FAIL=$((FAIL + 1))
    echo "not ok $TOTAL - $1"
}

assert_file_exists() {
    [ -f "$1" ] && pass "$2" || fail "$2"
}

assert_dir_exists() {
    [ -d "$1" ] && pass "$2" || fail "$2"
}

assert_executable() {
    [ -x "$1" ] && pass "$2" || fail "$2"
}

assert_contains() {
    grep -q "$2" "$1" 2>/dev/null && pass "$3" || fail "$3"
}

assert_not_empty() {
    [ -s "$1" ] && pass "$2" || fail "$2"
}

export -f pass fail assert_file_exists assert_dir_exists assert_executable assert_contains assert_not_empty
export PASS FAIL TOTAL

echo "TAP version 13"
echo "# Running test suites..."

# Run each test file
for test_file in tests/hooks/*.sh tests/structure/*.sh; do
    [ -f "$test_file" ] || continue
    echo ""
    echo "# === $(basename "$test_file") ==="
    source "$test_file"
done

echo ""
echo "1..$TOTAL"
echo "# passed: $PASS"
echo "# failed: $FAIL"

[ "$FAIL" -eq 0 ] && echo "# All tests passed." || echo "# Some tests FAILED."
exit "$FAIL"
