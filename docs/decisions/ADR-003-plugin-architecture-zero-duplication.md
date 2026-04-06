# ADR-003: Plugin Architecture with Zero-Duplication Design

## Status
Accepted

## Context
The project was a skill distribution tool that required manual `bash install-claude-code.sh` to copy skills to `~/.claude/skills/`. Claude Code now supports plugins with auto-discovery of skills, commands, agents, and hooks. Converting to a plugin simplifies installation but risks duplicating the 36 upstream skills already archived in `.kiro/skills/`.

## Decision
Convert the project to a Claude Code plugin using `plugin.json` custom paths to reference existing directories instead of creating separate copies:

- **Skills**: `plugin.json` references both `.kiro/skills/` (36 upstream) and `.claude/skills/` (4 project) via custom paths
- **Commands**: `plugin.json` references `.claude/commands/` as custom path
- **Agents**: New `agents/` directory with Markdown format (converted from `.claude/agents/*.yml`)
- **Hooks**: New `hooks/hooks.json` references scripts in `.claude/hooks/` via `$CLAUDE_PLUGIN_ROOT`

The legacy `install-claude-code.sh` installer is preserved for backward compatibility.

## Consequences
- **Zero file duplication**: Plugin references existing directories, no copies needed
- **Single source of truth**: Upstream sync (`install-skills.sh`) and plugin share the same `.kiro/skills/`
- **Dual install paths**: Plugin install (recommended) and legacy shell install both work
- **Agent format split**: `.claude/agents/*.yml` (dev) and `agents/*.md` (plugin) coexist with different formats
- **Test expansion**: Test suite grew from 76 to 99 assertions to cover plugin structure validation
