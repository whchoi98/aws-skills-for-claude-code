---
name: spark-troubleshooting
description: Troubleshoot Spark applications on AWS EMR, Glue, and SageMaker - analyze failures, identify bottlenecks, get code recommendations. Use when mentioning Spark, EMR, PySpark, Glue Spark, or Spark troubleshooting.
---

# Spark Troubleshooting Agent

## Key Capabilities
- Failure analysis for PySpark and Scala jobs
- Root cause identification via telemetry correlation
- Performance diagnostics and bottleneck detection
- Code recommendations and optimizations
- Supports EMR EC2, EMR Serverless, Glue, SageMaker

## MCP Servers
- sagemaker-unified-studio-mcp-troubleshooting — Failure analysis
- sagemaker-unified-studio-mcp-code-rec — Code recommendations

## Best Practices
- Provide specific identifiers (cluster ID, application ID, job ID)
- Describe symptoms clearly (observed vs expected)
- Include exact error messages
- Specify platform (EMR EC2, EMR Serverless, Glue, SageMaker)

## Setup
Requires CloudFormation stack deployment for IAM role. See AWS docs for setup.
