/**
 * Shopify GraphQL Client Configuration
 */

const { shopifyApi, ApiVersion } = require('@shopify/shopify-api');

const shopify = shopifyApi({
  apiKey: process.env.SHOPIFY_API_KEY,
  apiSecretKey: process.env.SHOPIFY_API_SECRET,
  scopes: ['read_products', 'write_products', 'read_orders', 'write_inventory'],
  hostName: process.env.SHOPIFY_SHOP_DOMAIN,
  apiVersion: ApiVersion.October24,
  isEmbeddedApp: false,
});

/**
 * Create authenticated Shopify GraphQL client
 * @returns {Object} Shopify API client
 */
function createShopifyClient() {
  const session = shopify.session.customAppSession(process.env.SHOPIFY_SHOP_DOMAIN);
  session.accessToken = process.env.SHOPIFY_ACCESS_TOKEN;

  return new shopify.clients.Graphql({ session });
}

/**
 * Execute GraphQL query with error handling
 * @param {string} query - GraphQL query string
 * @param {Object} variables - Query variables
 * @returns {Promise<Object>} Query response data
 */
async function executeQuery(query, variables = {}) {
  const client = createShopifyClient();

  try {
    const response = await client.query({
      data: { query, variables },
    });

    return response.body.data;
  } catch (error) {
    console.error('Shopify GraphQL Error:', error.response?.errors || error.message);
    throw new Error(`Shopify API request failed: ${error.message}`);
  }
}

module.exports = {
  shopify,
  createShopifyClient,
  executeQuery,
};
