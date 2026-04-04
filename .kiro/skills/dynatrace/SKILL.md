---
description: Query logs, metrics, traces, problems, and Kubernetes events from Dynatrace using DQL. Use when mentioning Dynatrace, DQL, Davis AI, or Dynatrace monitoring.
---

# Dynatrace Observability

## Key Tools
- execute_dql - Execute DQL queries against GRAIL data lake
- generate_dql_from_natural_language - Convert questions to DQL
- explain_dql / verify_dql - Understand and validate DQL
- find_entity_by_name - Find services, hosts, processes
- list_problems - Track active/closed problems
- chat_with_davis_copilot - Get Davis AI insights
- list_vulnerabilities - Security vulnerabilities
- get_kubernetes_events - K8s cluster events

## DQL Syntax
```dql
fetch <table> | filter <condition> | fields <columns> | summarize <agg> | sort | limit
```

### Critical Rules
- Strings use double quotes: `"ERROR"` ✅ `'ERROR'` ❌
- Summarize needs aggregation: `summarize count(), by:{x}`
- Multiple values use OR: `id == "A" or id == "B"`
- Always filter by time: `timestamp > now() - 1h`

### Common Patterns
```dql
-- Error analysis
fetch logs | filter loglevel == "ERROR" and timestamp > now() - 1h
| summarize cnt = count(), by:{k8s.deployment.name} | sort cnt desc

-- Service metrics
timeseries avg(dt.service.request.response_time),
from: now() - 6h, filter: dt.entity.service == "SERVICE-123"
```

## Best Practices
- Start with narrow time ranges (1h)
- Use find_entity_by_name before hardcoding IDs
- Ask Davis AI first before writing complex queries
- Use verify_dql before executing

## MCP Server Config
```json
{
  "mcpServers": {
    "dynatrace": {
      "command": "npx",
      "args": ["-y", "@dynatrace-oss/dynatrace-mcp-server@latest"],
      "env": {
        "DT_ENVIRONMENT": "https://your-tenant.apps.dynatrace.com",
        "DT_API_TOKEN": "$DT_API_TOKEN"
      }
    }
  }
}
```
