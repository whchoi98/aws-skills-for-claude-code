---
name: aws-graviton-migration
description: Analyze source code for Graviton (Arm64) compatibility, identify issues, and suggest fixes for language runtimes and dependencies. Use when mentioning Graviton, Arm64 migration, x86 to Arm, or aarch64 porting.
---

# Graviton Migration

## Overview
Migrate workloads from x86 to AWS Graviton (Arm64). Scans code for x86-specific dependencies, checks Docker image compatibility, and suggests Arm-compatible alternatives.

## Steps
1. Check Dockerfiles with check_image/skopeo for Arm compatibility
2. Verify each package via knowledge_base_search for Arm support
3. Scan requirements.txt/dependencies line-by-line
4. Run migrate_ease_scan on codebase (C++, Python, Go, JS, Java)
5. Generate analysis report with recommendations
6. Get user confirmation before code changes

## Supported Languages
C++, Python, Go, JavaScript, Java

## MCP Server Config (Docker)
```json
{
  "mcpServers": {
    "arm-mcp-server": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "--pull=always", "armswdev/arm-mcp:latest"],
      "env": { "FASTMCP_LOG_LEVEL": "ERROR" }
    }
  }
}
```

Requires Docker installed and running.
