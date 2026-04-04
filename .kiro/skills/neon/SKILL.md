---
description: Serverless Postgres with database branching, autoscaling, and scale-to-zero via Neon. Use when mentioning Neon, Postgres database branching, serverless database, or PostgreSQL with branching.
---

# Neon Database

## Key Capabilities
- Database Branching: Isolated copies for dev/test/schema changes
- Project Management: Create and manage Neon projects
- Schema Management: Execute SQL, create tables, manage schema
- Connection Strings: Get connection strings for any project/branch
- Autoscaling and scale-to-zero for cost efficiency

## MCP Tools
- list_organizations, list_projects, create_project
- get_connection_string, list_branches, create_branch
- execute_sql

## Best Practices
- Use database branching for development and testing before production
- Create separate branches for each feature or migration
- Test schema changes on branches before applying to main
- Store connection strings in .env (never commit to version control)
- Name branches descriptively (e.g., "feature-auth", "migration-v2")
- Delete old branches after merging

## Common Workflows

### Safe Schema Migration
1. Create migration branch from main
2. Test schema changes on branch
3. Verify with test queries
4. Apply to main if tests pass

### Multi-Environment Setup
1. Get main project connection (prod)
2. Create development branch
3. Create staging branch
4. Get connection strings for each environment

## MCP Server Config
```json
{
  "mcpServers": {
    "neon": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.neon.tech/mcp"]
    }
  }
}
```

No API keys required - authentication via Neon CLI or browser login.
