#!/bin/bash
# Test hook existence, permissions, and registration.

# Hook files exist
assert_file_exists ".claude/hooks/check-doc-sync.sh" "check-doc-sync.sh exists"
assert_file_exists ".claude/hooks/secret-scan.sh" "secret-scan.sh exists"
assert_file_exists ".claude/hooks/session-context.sh" "session-context.sh exists"
assert_file_exists ".claude/hooks/notify.sh" "notify.sh exists"

# Hook files are executable
assert_executable ".claude/hooks/check-doc-sync.sh" "check-doc-sync.sh is executable"
assert_executable ".claude/hooks/secret-scan.sh" "secret-scan.sh is executable"
assert_executable ".claude/hooks/session-context.sh" "session-context.sh is executable"
assert_executable ".claude/hooks/notify.sh" "notify.sh is executable"

# Hooks registered in settings.json
assert_contains ".claude/settings.json" "SessionStart" "SessionStart hook registered"
assert_contains ".claude/settings.json" "PreCommit" "PreCommit hook registered"
assert_contains ".claude/settings.json" "PostToolUse" "PostToolUse hook registered"
assert_contains ".claude/settings.json" "Notification" "Notification hook registered"

# Hook scripts reference correct paths
assert_contains ".claude/settings.json" "session-context.sh" "session-context.sh referenced in settings"
assert_contains ".claude/settings.json" "secret-scan.sh" "secret-scan.sh referenced in settings"
assert_contains ".claude/settings.json" "check-doc-sync.sh" "check-doc-sync.sh referenced in settings"
assert_contains ".claude/settings.json" "notify.sh" "notify.sh referenced in settings"

# Git commit-msg hook exists
assert_file_exists ".git/hooks/commit-msg" "Git commit-msg hook exists"
assert_executable ".git/hooks/commit-msg" "Git commit-msg hook is executable"

# Hook scripts have proper shebang
for hook in .claude/hooks/*.sh; do
    name=$(basename "$hook")
    head -1 "$hook" | grep -q '^#!/bin/bash' && pass "$name has bash shebang" || fail "$name has bash shebang"
done
