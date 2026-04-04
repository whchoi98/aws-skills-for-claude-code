---
name: cloudwatch-application-signals
description: Monitor service health, analyze SLO compliance, and perform root cause analysis with CloudWatch Application Signals. Use when mentioning Application Signals, SLO monitoring, APM on AWS, or CloudWatch traces.
---

# CloudWatch Application Signals

## Key Tools
- audit_services - Primary service health auditing (use `auditors="all"` for root cause)
- audit_slos - SLO compliance monitoring
- audit_service_operations - Operation-specific analysis
- list_monitored_services / get_service_detail - Service discovery
- search_transaction_spans - 100% sampled OpenTelemetry spans
- query_sampled_traces - X-Ray traces (5% sampled)
- analyze_canary_failures - Synthetics canary analysis
- get_enablement_guide - Setup guidance

## Best Practices
- Start with audit tools for overview, then drill down
- Use wildcard patterns for discovery: `*payment*`
- Use Transaction Search for 100% trace visibility (not X-Ray's 5%)
- Use `auditors="all"` for root cause analysis
- Always specify time ranges

## Workflow: Service Health Investigation
1. audit_services with `*` to find issues
2. Deep dive into problematic service with `auditors="all"`

## MCP Server Config
```json
{
  "mcpServers": {
    "cloudwatch-appsignals": {
      "command": "uvx",
      "args": ["awslabs.cloudwatch-applicationsignals-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

Requires AWS credentials and Application Signals enabled in your account.
