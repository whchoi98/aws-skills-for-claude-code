---
description: Use when creating a new release with semantic versioning, changelog updates, and git tagging.
---

# Release Skill

Automate the release process with validation checks.

## Procedure

### 1. Pre-release Checks
- Verify working tree is clean: `git status`
- Check for uncommitted changes

### 2. Determine Version
- Review changes since last tag: `git log $(git describe --tags --abbrev=0)..HEAD --oneline`
- Apply semver rules:
  - MAJOR: Breaking changes (skill format change, installer incompatibility)
  - MINOR: New skills added, new features
  - PATCH: Bug fixes, documentation updates

### 3. Update Changelog
- Group changes by type (Added, Changed, Fixed, Removed)
- Update both English and Korean sections
- Add date and version header

### 4. Create Release
- Update version badge in README.md
- Update CHANGELOG.md comparison links
- Create git tag: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`

### 5. Summary
- Display version bump
- List key changes
- Show next steps (push tag, etc.)

## Usage
Run with `/release` command
