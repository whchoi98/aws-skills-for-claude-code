---
description: Build payment integrations with Stripe - Checkout Sessions, Payment Intents, subscriptions, billing, refunds. Use when mentioning payments, checkout, subscriptions, billing, invoices, or Stripe.
---

# Stripe Payments

## Key Capabilities
- Checkout Sessions: Hosted payment pages for one-time payments and subscriptions
- Payment Intents: Custom payment flows with full control
- Subscriptions: Recurring billing with flexible pricing
- Customers, Invoices, Refunds, Payment Methods

## Best Practices
- Always prefer Checkout Sessions for standard payment flows
- Use Payment Intents only for custom checkout UI or off-session payments
- Never use deprecated Charges API or Sources API
- Enable dynamic payment methods in Dashboard instead of hardcoding payment_method_types
- Use Setup Intents to save payment methods for future use
- Handle webhooks for all async events
- Implement idempotency keys for safe retries
- Never expose secret keys in client-side code
- Do not include API version in code snippets

## Common Workflows

### One-Time Payment
1. Create Checkout Session (mode: "payment")
2. Redirect customer to session.url
3. Handle webhook for payment_intent.succeeded

### Subscription
1. Create/retrieve customer
2. Create Checkout Session (mode: "subscription")
3. Handle webhook for customer.subscription.created

### Refund
1. Retrieve payment intent
2. Create refund (full or partial with amount in cents)
3. Handle webhook for charge.refunded

## MCP Server Config
```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

## Resources
- [Integration Options](https://docs.stripe.com/payments/payment-methods/integration-options)
- [Go Live Checklist](https://docs.stripe.com/get-started/checklist/go-live)
- [Subscription Use Cases](https://docs.stripe.com/billing/subscriptions/use-cases)
- [Testing](https://docs.stripe.com/testing)
