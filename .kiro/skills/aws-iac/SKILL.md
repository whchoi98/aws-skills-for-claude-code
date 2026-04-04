---
name: aws-infrastructure-as-code
description: Build well-architected AWS infrastructure with CDK and CloudFormation - latest documentation, validation, compliance, and troubleshooting. Use when mentioning CDK, CloudFormation, cfn-lint, cfn-guard, or AWS IaC.
---

# AWS Infrastructure as Code

## Key Tools
- search_cdk_documentation / search_cdk_samples_and_constructs - CDK docs and code samples
- cdk_best_practices - Comprehensive CDK best practices
- read_iac_documentation_page - Full documentation pages
- validate_cloudformation_template - cfn-lint validation
- check_cloudformation_template_compliance - cfn-guard security compliance
- troubleshoot_cloudformation_deployment - Pattern-based failure analysis with CloudTrail
- search_cloudformation_documentation - CloudFormation docs

## CDK Development Workflow
1. Research: search_cdk_documentation + search_cdk_samples_and_constructs
2. Best Practices: cdk_best_practices
3. Write CDK Code
4. Synthesize: `cdk synth`
5. Validate: validate_cloudformation_template + check_cloudformation_template_compliance
6. Deploy: `cdk deploy`
7. Troubleshoot: troubleshoot_cloudformation_deployment (if needed)

## Best Practices
- Prefer L2 constructs, use L3 for patterns, avoid L1 unless necessary
- Search before coding to find proven patterns
- Always synthesize (`cdk synth`) to validate before deployment
- Check compliance before production
- Supports TypeScript, Python, Java, C#, Go

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-iac": {
      "command": "uvx",
      "args": ["awslabs.aws-iac-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

Most features work without AWS credentials. Credentials only needed for deployment and troubleshooting.
