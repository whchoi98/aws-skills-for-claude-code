# Code Review Skill

Review changed code with confidence-based scoring to filter false positives.

## Review Scope

By default, review unstaged changes from `git diff`. The user may specify different files or scope.

## Review Criteria

### Project Guidelines Compliance
- SKILL.md YAML frontmatter format (description field required)
- Shell script POSIX compatibility (macOS/Linux)
- Bilingual documentation consistency (EN/KR)
- Conventional Commits format

### Bug Detection
- Logic errors and null/undefined handling
- Security vulnerabilities (OWASP Top 10)
- Shell script portability issues (BSD vs GNU)

### Code Quality
- Code duplication and unnecessary complexity
- Missing critical error handling
- Documentation gaps

## Confidence Scoring

Rate each issue 0-100:
- **0-49**: Do not report.
- **50-74**: Report only if critical.
- **75-89**: Verified real issue. Report with fix suggestion.
- **90-100**: Confirmed critical issue. Must report.

**Only report issues with confidence >= 75.**

## Output Format

For each issue:
```
### [CRITICAL|IMPORTANT] <issue title> (confidence: XX)
**File:** `path/to/file.ext:line`
**Issue:** Clear description of the problem
**Fix:** Concrete code suggestion
```

## Usage
Run with `/code-review` command
