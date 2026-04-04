---
name: saas-builder
description: Build production-ready multi-tenant SaaS applications with serverless architecture, integrated billing, and enterprise-grade security. Use when mentioning SaaS, multi-tenant, tenant isolation, or SaaS billing.
---

# SaaS Builder

## Core Architecture
- Multi-tenant with tenant isolation at data layer
- Serverless-first: Lambda, API Gateway, DynamoDB
- Integrated billing with Stripe and usage metering
- JWT auth with RBAC
- React + TypeScript frontend with Tailwind CSS

## Multi-Tenancy Pattern
- Tenant ID prefix in all DB keys: `${tenantId}#${entityType}#${id}`
- Lambda authorizer injects tenant context from JWT
- No cross-tenant data access
- Tenant-specific feature flags and quotas

## Project Structure
```
├── frontend/          # React + TypeScript + Tailwind
├── backend/
│   ├── functions/     # Lambda handlers (authorizer, api, billing)
│   ├── lib/           # Business logic
│   └── infrastructure/# IaC (CDK/SAM)
├── schema/            # OpenAPI contracts
└── .kiro/
```

## Lambda Function Pattern
1. Extract tenant context from authorizer
2. Extract user roles
3. Validate parameters
4. Check permissions (RBAC)
5. Prefix DB operations with tenant ID
6. Return proper status codes
7. Log with tenant context

## Billing Rules
- Integer cents only (never floats): `amount_cents: 1999`
- Currency code with every amount
- Stripe for payments, webhook verification, idempotency
- Subscription states: trial, active, past_due, canceled, expired

## MCP Servers
- fetch, stripe, aws-knowledge-mcp-server
- awslabs.dynamodb-mcp-server, awslabs.aws-serverless-mcp
- playwright (disabled by default)
