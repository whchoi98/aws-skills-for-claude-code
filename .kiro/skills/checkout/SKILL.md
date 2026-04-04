---
name: checkout-payments
description: Access Checkout.com payment processing APIs - payments, customers, disputes, issuing, workflows, and identity verification. Use when mentioning Checkout.com, payment processing, or Checkout API.
---

# Checkout.com Global Payments

## Key Tools
- docssearch — Search API operations by keyword
- openapilistOperations — List/filter operations by tag
- openapigetOperation — Get detailed endpoint documentation
- openapigetSchema — Retrieve request/response schemas
- markdownsearch — Search implementation guides

## API Coverage
- Payments: process, refund, capture, void
- Customers: profiles and payment instruments
- Disputes: chargeback management
- Issuing: card issuing and management
- Platforms: multi-entity and marketplace
- Workflows: automated business logic
- Identity Verification: KYC services

## MCP Server Config
```json
{
  "mcpServers": {
    "checkout": {
      "command": "npx",
      "args": ["-y", "@checkout/mcp-server"],
      "env": {
        "CKO_SECRET_KEY": "$CKO_SECRET_KEY"
      }
    }
  }
}
```
