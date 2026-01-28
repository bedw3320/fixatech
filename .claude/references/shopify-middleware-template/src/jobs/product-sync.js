/**
 * Product Sync Background Job
 * Batch syncs products between Shopify and external system
 */

const cron = require('node-cron');
const { executeQuery } = require('../config/shopify-client');
const logger = require('../utils/logger');
const { mapProductToShopify } = require('../mappings/field-mappings');

/**
 * Fetch products from Shopify
 * @returns {Promise<Array>} Array of products
 */
async function fetchShopifyProducts() {
  const query = `
    query GetProducts($first: Int!) {
      products(first: $first) {
        edges {
          node {
            id
            title
            handle
            status
            variants(first: 10) {
              edges {
                node {
                  id
                  sku
                  price
                  inventoryQuantity
                }
              }
            }
          }
        }
      }
    }
  `;

  const data = await executeQuery(query, { first: 50 });
  return data.products.edges.map(edge => edge.node);
}

/**
 * Sync products between systems
 */
async function syncProducts() {
  try {
    logger.info('Starting product sync job...');

    // 1. Fetch products from Shopify
    const shopifyProducts = await fetchShopifyProducts();
    logger.info(`Fetched ${shopifyProducts.length} products from Shopify`);

    // 2. Fetch products from external system (e.g., NetSuite)
    // const externalProducts = await fetchExternalProducts();

    // 3. Compare and sync differences
    // for (const product of shopifyProducts) {
    //   const mappedData = mapProductToShopify(externalProduct);
    //   await updateShopifyProduct(product.id, mappedData);
    // }

    logger.info('Product sync completed successfully');
  } catch (error) {
    logger.error('Product sync failed:', error);
  }
}

/**
 * Schedule product sync cron job
 */
function scheduleProductSync() {
  const cronSchedule = process.env.PRODUCT_SYNC_CRON || '0 */6 * * *'; // Default: every 6 hours

  cron.schedule(cronSchedule, async () => {
    await syncProducts();
  });

  logger.info(`Product sync scheduled: ${cronSchedule}`);
}

module.exports = {
  syncProducts,
  scheduleProductSync,
};
