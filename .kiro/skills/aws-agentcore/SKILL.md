---
name: aws-agentcore
description: Build, test, and deploy AI agents using AWS Bedrock AgentCore with local development workflow. Use when mentioning AgentCore, Bedrock agents, or AI agent deployment on AWS.
---

# AWS Bedrock AgentCore

## Overview
Build and deploy AI agents using AWS Bedrock AgentCore. Supports Strands, Claude, OpenAI SDKs and Bedrock/OpenAI model providers. Infrastructure via CDK or Terraform.

## MCP Tools
- search_agentcore_docs - Search AgentCore documentation
- fetch_agentcore_doc - Retrieve specific doc pages
- manage_agentcore_runtime - Runtime configuration and deployment
- manage_agentcore_memory - Agent memory operations
- manage_agentcore_gateway - Gateway configuration

## Getting Started
1. Use `agentcore create` for new agent projects
2. Run `agentcore dev` for local development with hot reloading
3. Test locally before cloud deployment
4. Deploy with `agentcore deploy`

## Troubleshooting
- "Could not find entrypoint module" → Ensure `.bedrock_agentcore.yaml` exists
- "Port 8080 already in use" → CLI auto-tries next port
- "AWS authentication failed" → Run `aws login`
- "Model access denied" → Check Bedrock model permissions

## MCP Server Config
```json
{
  "mcpServers": {
    "agentcore": {
      "command": "uvx",
      "args": ["awslabs.agentcore-mcp-server@latest"]
    }
  }
}
```
