/**
 * Express Server Entry Point
 * Shopify Integration Middleware
 */

require('dotenv').config();
const express = require('express');
const logger = require('./utils/logger');
const errorHandler = require('./utils/error-handler');
const ordersCreateWebhook = require('./webhooks/orders-create');
const inventoryUpdateWebhook = require('./webhooks/inventory-update');
const { scheduleProductSync } = require('./jobs/product-sync');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Webhook endpoints
app.post('/webhooks/orders/create', ordersCreateWebhook);
app.post('/webhooks/inventory/update', inventoryUpdateWebhook);

// Error handling middleware (must be last)
app.use(errorHandler);

// Start server
app.listen(PORT, () => {
  logger.info(`Shopify middleware server running on port ${PORT}`);

  // Schedule background jobs
  scheduleProductSync();
  logger.info('Background jobs scheduled');
});

// Graceful shutdown
process.on('SIGTERM', () => {
  logger.info('SIGTERM signal received: closing HTTP server');
  process.exit(0);
});

module.exports = app;
