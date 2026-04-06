---
name: gcp-aws-migrate
description: Guided 5-phase migration from Google Cloud Platform to AWS - Terraform discovery, requirements clarification, architecture design, cost estimation, and execution planning. Use when mentioning GCP to AWS migration, cloud migration, or re-platform.
---

# GCP to AWS Migration Advisor

## 5-Phase Process
1. Discover — Scan Terraform, app code, billing data for GCP resources
2. Clarify — Gather user requirements and preferences
3. Design — Map GCP services to AWS equivalents (re-platform by default)
4. Estimate — Cost comparison (cached pricing + AWS Pricing API)
5. Generate — Terraform configs, migration scripts, documentation

## Inputs (at least one required)
- Terraform .tf files
- Application source code with GCP SDK imports
- GCP billing/cost export (CSV or JSON)

## Defaults
- Re-platform approach (Cloud Run → Fargate, Cloud SQL → RDS)
- Dev sizing unless specified
- Region: us-east-1
- Timeline: 8-12 weeks

## MCP Server Config
```json
{
  "mcpServers": {
    "awspricing": {
      "command": "uvx",
      "args": ["awslabs.aws-pricing-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```
