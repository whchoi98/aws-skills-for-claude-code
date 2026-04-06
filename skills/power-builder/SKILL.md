---
name: power-builder
description: Complete guide for building and testing new Kiro Powers with templates, best practices, and validation. Use when mentioning power builder, create power, build power, or Kiro power development.
---

# Power Builder

## Overview
Guide for building Kiro Powers. Two types:
- **Guided MCP Power** — MCP server config + documentation (has mcp.json)
- **Knowledge Base Power** — Pure documentation (no mcp.json)

## Power Structure
```
my-power/
├── POWER.md       # Required: metadata + documentation
├── mcp.json       # Required for Guided MCP Powers only
└── steering/      # Optional: workflow guides
```

## POWER.md Frontmatter (5 fields only)
```yaml
---
name: "power-name"
displayName: "Human Readable Name"
description: "Clear description (max 3 sentences)"
keywords: ["keyword1", "keyword2"]
author: "Your Name"
---
```

## Best Practices
- Default to single power (only split with strong conviction)
- Use kebab-case for power names
- Include 5-7 keywords
- Document exact MCP tool names
- Create steering/ only when POWER.md >500 lines
- No MCP server needed for Knowledge Base Powers
