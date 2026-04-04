---
name: aws-sam-serverless
description: Build serverless applications with AWS SAM - init, build, deploy, local invoke, and logs. Use when mentioning SAM, serverless, Lambda deployment, or AWS serverless application model.
---

# AWS SAM

## MCP Tools
- sam_init - Create new SAM app
- sam_build - Build SAM app
- sam_deploy - Deploy SAM app
- sam_logs - Fetch deployed app logs
- sam_local_invoke - Locally invoke Lambda function

## Project Structure
```
├── infrastructure/
│   ├── cloudformation/
│   └── lambda/
│       └── api/
│           ├── app.py
│           └── requirements.txt
└── template.yaml
```

## Key Rules
- ALWAYS use SAM resource types (AWS::Serverless::Function, etc.)
- ALWAYS use Lambda Powertools via Layers, NEVER add to dependencies
- ALWAYS use version locking for dependencies
- ALWAYS create separate Lambda functions for each API
- Do NOT add boto3/botocore to dependencies (included in runtime)
- Use SAM policy templates for IAM permissions
- Add `.aws-sam` to `.gitignore`

## Create New App Workflow
1. sam_init with chosen runtime
2. Restructure: move functions to `infrastructure/lambda/`
3. Update CodeUri paths in template.yaml
4. sam_build to verify

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-sam": {
      "command": "uvx",
      "args": ["awslabs.aws-serverless-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```

Prerequisites: SAM CLI installed, optionally Docker/Finch.
