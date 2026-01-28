# Shopify Integration Middleware Template

Reference template for building Shopify integration middleware using Node.js and Express.

## Structure

```
├── src/
│   ├── index.js                 # Express server entry point
│   ├── config/
│   │   └── shopify-client.js    # Shopify GraphQL client configuration
│   ├── webhooks/
│   │   ├── orders-create.js     # Order creation webhook handler
│   │   └── inventory-update.js  # Inventory update webhook handler
│   ├── jobs/
│   │   └── product-sync.js      # Batch product sync cron job
│   ├── mappings/
│   │   └── field-mappings.js    # Field transformation logic (e.g., NetSuite → Shopify)
│   └── utils/
│       ├── logger.js            # Logging utility
│       └── error-handler.js     # Error handling middleware
└── tests/
    └── integration/
        └── shopify-api.test.js  # Integration tests
```

## Usage

This template provides patterns for:
- Express.js server setup with middleware
- Shopify Admin API GraphQL client configuration
- Webhook handlers with signature verification
- Background job scheduling
- Field mapping and data transformation
- Error handling and logging
- Integration testing

## Environment Variables

See `.env.example` for required configuration.

## Deployment

Supports deployment to:
- Railway
- Vercel
- AWS Lambda
- Docker containers
