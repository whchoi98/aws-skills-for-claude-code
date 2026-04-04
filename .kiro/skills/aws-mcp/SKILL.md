---
name: aws-mcp
description: Perform complex multi-step AWS tasks with real-time documentation, API execution, and Agent SOPs following AWS best practices. Use when mentioning AWS CLI, AWS API, AWS tasks, or AWS automation.
---

# Work with AWS

## Key Capabilities
- Execute 15,000+ AWS APIs with SigV4 authentication
- Search AWS documentation, best practices, and guides
- Pre-built Agent SOPs for complex workflows (VPC setup, Lambda deployment, etc.)
- Regional availability checks
- Cost management and optimization

## Tools
- search_documentation / read_documentation / recommend
- call_aws / suggest_aws_commands
- retrieve_agent_sop
- get_regional_availability / list_regions

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-mcp": {
      "command": "uvx",
      "args": ["awslabs.aws-mcp@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```

Requires AWS CLI v2+ and uv installed.
