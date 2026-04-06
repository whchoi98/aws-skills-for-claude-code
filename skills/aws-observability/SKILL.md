---
name: aws-observability
description: Comprehensive AWS observability with CloudWatch Logs, Metrics, Alarms, Application Signals APM, CloudTrail auditing, and codebase observability gap analysis. Use when mentioning CloudWatch, observability, monitoring, logs, metrics, alarms, traces, or CloudTrail.
---

# AWS Observability

## Key Capabilities
- CloudWatch Logs Insights queries across up to 50 log groups
- Metrics & Alarms with recommended configurations
- Application Signals APM with distributed tracing and SLOs
- CloudTrail security auditing (Lake, CloudWatch Logs, Lookup Events)
- Codebase observability gap analysis (Python, Java, JS/TS, Go, Ruby, C#)

## MCP Servers
- awslabs.cloudwatch-mcp-server — Logs, Metrics, Alarms
- awslabs.cloudwatch-applicationsignals-mcp-server — APM, SLOs, tracing
- awslabs.cloudtrail-mcp-server — Security auditing
- awslabs.aws-documentation-mcp-server — AWS docs

## Scenario Routing
- Incident response / troubleshooting → incident-response workflow
- Log analysis → log-analysis workflow
- Alerting setup → alerting-setup workflow
- Performance monitoring → performance-monitoring workflow
- Security auditing → security-auditing workflow
- Observability gaps → observability-gap-analysis workflow

## MCP Server Config
```json
{
  "mcpServers": {
    "cloudwatch": {
      "command": "uvx",
      "args": ["awslabs.cloudwatch-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```
