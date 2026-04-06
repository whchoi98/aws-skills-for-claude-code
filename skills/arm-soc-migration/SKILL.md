---
name: arm-soc-migration
description: Guides migration of code between Arm SoCs with architecture-aware analysis and safe migration practices. Use when mentioning Arm SoC, Cortex migration, embedded migration, or Arm architecture porting.
---

# Arm SoC Migration

## Overview
Migrate embedded, automotive, or general-purpose applications between Arm SoCs (e.g., Graviton → Raspberry Pi, NXP i.MX8 → NVIDIA Jetson Orin).

## Workflows
1. Discovery — Scan codebase for platform-specific code, compare architectures
2. Planning — Migration plan, risk assessment, performance impact analysis
3. Implementation — Refactor into HAL layers, update build systems
4. Validation — Cross-compilation, benchmarking, functional tests

## Key Rules
- Preserve behavior: no silent API or timing changes
- Isolate SoC-specific code in HAL layers
- Maintain safety properties and error handling
- Document all changes

## MCP Server Config (Docker)
```json
{
  "mcpServers": {
    "arm-mcp-server": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "--pull=always", "armlimited/arm-mcp:latest"],
      "env": { "FASTMCP_LOG_LEVEL": "ERROR" }
    }
  }
}
```
