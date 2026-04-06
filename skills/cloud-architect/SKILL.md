---
name: cloud-architect
description: Build AWS infrastructure with CDK in Python following AWS Well-Architected framework best practices. Use when mentioning AWS architecture, CDK Python, Well-Architected, or cloud infrastructure design.
---

# Cloud Architect

## Overview
AWS infrastructure with CDK in Python, following Well-Architected framework. Combines AWS APIs, pricing, knowledge base, and documentation access.

## MCP Servers
- awspricing: Real-time AWS pricing (uvx awslabs.aws-pricing-mcp-server)
- awsknowledge: AWS best practices (https://knowledge-mcp.global.api.aws)
- awsapi: AWS CLI commands (uvx awslabs.aws-api-mcp-server)
- context7: boto3 and CDK docs (npx @upstash/context7-mcp)
- fetch: Web content retrieval (uvx mcp-server-fetch)

## Key Principles
- CDK with Python, Well-Architected framework adherence
- snake_case for functions, PascalCase for classes
- Service-based project structure, single CDK app per service
- Lambda: Layered architecture (handler, service, model)
- Single stack per app for deployment atomicity
- L2 constructs default, L3 for patterns, L1 only when necessary

## Testing Strategy
- Unit Tests: Pure business logic with mocks (<1s)
- Integration Tests: Lambda locally with real AWS services (1-5s)
- CDK Testing: Fine-grained assertions and snapshot testing

## Best Practices
- Start with clear service boundaries
- Prefer L2 constructs
- Follow layered architecture for Lambda
- Write integration tests against real AWS services
- Use keyword arguments for clarity
- Apply CDK aspects for cross-cutting concerns (tagging)
