/**
 * Order Created Webhook Handler
 * Triggered when a new order is created in Shopify
 */

const crypto = require('crypto');
const logger = require('../utils/logger');

/**
 * Verify webhook signature
 * @param {string} body - Raw request body
 * @param {string} hmac - HMAC signature from header
 * @returns {boolean} Whether signature is valid
 */
function verifyWebhook(body, hmac) {
  const hash = crypto
    .createHmac('sha256', process.env.SHOPIFY_WEBHOOK_SECRET)
    .update(body, 'utf8')
    .digest('base64');

  return hash === hmac;
}

/**
 * Handle order creation webhook
 */
async function handleOrderCreate(req, res) {
  try {
    // Verify webhook signature
    const hmac = req.get('X-Shopify-Hmac-Sha256');
    const isValid = verifyWebhook(JSON.stringify(req.body), hmac);

    if (!isValid) {
      logger.warn('Invalid webhook signature');
      return res.status(401).send('Unauthorized');
    }

    const order = req.body;
    logger.info(`Processing order created: ${order.id}`);

    // Process order data
    // Example: Send to external system, update inventory, send notifications
    await processOrder(order);

    res.status(200).send('Webhook processed');
  } catch (error) {
    logger.error('Error processing order webhook:', error);
    res.status(500).send('Internal server error');
  }
}

/**
 * Process order data
 * @param {Object} order - Order data from webhook
 */
async function processOrder(order) {
  // Example implementation:
  // 1. Transform order data for external system
  // 2. Send order to ERP/OMS
  // 3. Update inventory levels
  // 4. Send confirmation email

  logger.info(`Order processed: ${order.name} - Total: ${order.total_price}`);
}

module.exports = handleOrderCreate;
