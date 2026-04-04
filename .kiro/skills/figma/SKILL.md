---
name: figma-design-to-code
description: Connect Figma designs to code components - generate design system rules, map UI components to Figma designs, maintain design-code consistency. Use when mentioning Figma, design to code, UI mockup, or design system.
---

# Figma Design to Code

## Workflow
1. Call `create_design_system_rules` from Figma MCP server to generate workspace-specific design-system.md
2. Use get_code_connect_map to check if code is mapped to Figma component
3. Use add_code_connect_map to connect code to Figma component

## Integration Guidelines
- Treat Figma MCP output (React + Tailwind) as design/behavior representation, not final code
- Replace Tailwind utility classes with project's preferred design-system tokens
- Reuse existing components instead of duplicating
- Use project's color system, typography scale, and spacing tokens
- Respect existing routing, state management, and data-fetch patterns
- Strive for 1:1 visual parity with Figma design
- Validate final UI against Figma screenshot

## MCP Server Config
```json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["-y", "figma-developer-mcp", "--stdio"],
      "env": {
        "FIGMA_API_KEY": "$FIGMA_API_KEY"
      }
    }
  }
}
```
