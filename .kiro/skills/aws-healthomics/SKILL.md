---
name: aws-healthomics
description: Create, migrate, run, debug and optimize genomics workflows in AWS HealthOmics. Use when mentioning HealthOmics, WDL, CWL, Nextflow, genomics, or bioinformatics pipelines.
---

# AWS HealthOmics

## Overview
Create, migrate, run, debug and identify optimization opportunities for genomics workflows (WDL, Nextflow, CWL) in AWS HealthOmics.

## When to Use
- Creating workflows from Git repos or local files
- Running deployed HealthOmics workflows
- Batch runs (multiple samples)
- Migrating existing WDL/Nextflow workflows
- Diagnosing workflow creation issues or run failures
- Using public containers via ECR Pullthrough Caches

## Setup
1. Ensure valid AWS credentials
2. Get account number: `aws sts get-caller-identity`
3. Create `.healthomics/config.toml` with omics_iam_role and run_output_uri
4. Requires `uvx` installed

## MCP Server Config
```json
{
  "mcpServers": {
    "healthomics": {
      "command": "uvx",
      "args": ["awslabs.aws-healthomics-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```
