---
description: Query logs, metrics, traces, RUM events, incidents, and monitors from Datadog for production debugging and performance analysis. Use when mentioning Datadog, APM traces, RUM, or Datadog monitoring.
---

# Datadog Observability

## Key Tools
- search_datadog_logs - Search logs with filtering
- get_datadog_metric - Query time-series metrics
- search_datadog_spans / get_datadog_trace - APM traces
- search_datadog_rum_events - Real User Monitoring
- search_datadog_incidents / get_datadog_incident - Incident management
- search_datadog_monitors - Alerting monitors
- search_datadog_docs - Documentation search

## Query Syntax

### Logs: Tags (no @) vs Attributes (@ prefix)
- `service:api status:error` (tags)
- `@http.status_code:500 @user.id:abc` (attributes)

### Metrics: `aggregator:metric{filters} by {grouping}`
- `avg:system.cpu.user{env:prod} by {host}`

### APM: Reserved fields (no @) vs Span attributes (@)
- `service:api status:error` (reserved)
- `@duration:>100000000` (nanoseconds!)

### Duration Units
- Spans: nanoseconds (1ms = 1,000,000ns)
- Logs/RUM: milliseconds

## Best Practices
- Start with narrow time ranges (15m-1h)
- Use unified service tags (service, env, version)
- Use @ prefix correctly for attributes
- Check incidents first when investigating issues

## MCP Server Config
```json
{
  "mcpServers": {
    "datadog": {
      "command": "npx",
      "args": ["mcp-remote", "https://mcp.datadoghq.com/api/unstable/mcp-server/mcp"],
      "env": {
        "DD_API_KEY": "$DD_API_KEY",
        "DD_APP_KEY": "$DD_APP_KEY",
        "DD_SITE": "datadoghq.com"
      }
    }
  }
}
```
