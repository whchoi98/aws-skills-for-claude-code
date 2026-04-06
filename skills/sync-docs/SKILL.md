---
description: Use when synchronizing project documentation with current code state. Quality scoring and gap analysis for CLAUDE.md files.
---

# Sync Docs Skill

Synchronize project documentation with current code state.

## Actions

### 1. Quality Assessment
Score each CLAUDE.md file (0-100) across:
- Commands/workflows (20 pts)
- Architecture clarity (20 pts)
- Non-obvious patterns (15 pts)
- Conciseness (15 pts)
- Currency (15 pts)
- Actionability (15 pts)

Output quality report with grades (A-F) before making changes.

### 2. Root CLAUDE.md Sync
- Update Overview, Tech Stack, Conventions, Key Commands
- Verify commands are copy-paste ready against actual scripts

### 3. Architecture Doc Sync
- Update docs/architecture.md to reflect current system structure
- Add new components, update data flows

### 4. Skill Audit
- Count skills in `skills/` and verify SKILL.md presence
- Verify README skill count matches actual count (both EN/KR)

### 5. ADR Audit
- Check recent commits (git log --oneline -20)
- Suggest new ADRs for undocumented architectural decisions

### 6. README.md Sync
- Update project structure section to match actual directory layout
- Verify version badge matches CHANGELOG

### 7. Report
Output before/after quality scores and list of all changes.

## Usage
Run with `/sync-docs` command
