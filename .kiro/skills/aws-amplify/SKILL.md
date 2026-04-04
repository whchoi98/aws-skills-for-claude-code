---
name: aws-amplify
description: Build full-stack apps with AWS Amplify Gen 2 using TypeScript, guided workflows, and best practices. Use when mentioning Amplify, Amplify Gen 2, fullstack AWS app, Cognito auth, or GraphQL backend.
---

# AWS Amplify Gen 2

## Overview
Build full-stack applications with TypeScript code-first development. Covers auth, data models, storage, functions, AI/ML integration, and deployment.

## Workflow Phases
1. Backend: Create resources (auth, data, storage, functions)
2. Sandbox: Deploy to sandbox environment for testing
3. Frontend: Integrate with React, Next.js, Vue, Angular, Flutter, Swift
4. Production: Deploy to production

## Key Principles
- Always follow the amplify-workflow steering file
- Validate prerequisites (Node.js, npm, AWS credentials) first
- Execute phases one at a time with user confirmation
- Do not load phase steering files directly; use the orchestrator

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-mcp": {
      "command": "uvx",
      "args": ["awslabs.aws-mcp@latest"]
    }
  }
}
```
