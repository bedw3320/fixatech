/**
 * Field Mapping Transformations
 * Maps data between Shopify and external systems (e.g., NetSuite, SAP)
 */

/**
 * Map external system product to Shopify format
 * @param {Object} externalProduct - Product data from external system
 * @returns {Object} Shopify-formatted product data
 */
function mapProductToShopify(externalProduct) {
  return {
    title: externalProduct.name || externalProduct.displayName,
    descriptionHtml: externalProduct.description || '',
    productType: externalProduct.category || 'General',
    vendor: externalProduct.vendor || externalProduct.manufacturer || '',
    tags: parseTagsFromExternal(externalProduct.tags),
    status: externalProduct.active ? 'ACTIVE' : 'DRAFT',
    variants: mapVariantsToShopify(externalProduct.variants || [externalProduct]),
    metafields: mapMetafieldsToShopify(externalProduct.customFields || {}),
  };
}

/**
 * Map external system variants to Shopify format
 * @param {Array} externalVariants - Variant data from external system
 * @returns {Array} Shopify-formatted variants
 */
function mapVariantsToShopify(externalVariants) {
  return externalVariants.map(variant => ({
    sku: variant.sku || variant.itemId,
    price: parseFloat(variant.price || variant.basePrice || 0).toFixed(2),
    compareAtPrice: variant.msrp ? parseFloat(variant.msrp).toFixed(2) : null,
    inventoryQuantity: parseInt(variant.quantityAvailable || 0, 10),
    weight: parseFloat(variant.weight || 0),
    weightUnit: variant.weightUnit || 'POUNDS',
    requiresShipping: variant.requiresShipping !== false,
    taxable: variant.taxable !== false,
    barcode: variant.upc || variant.barcode || null,
    inventoryManagement: 'SHOPIFY',
  }));
}

/**
 * Map custom fields to Shopify metafields
 * @param {Object} customFields - Custom fields from external system
 * @returns {Array} Shopify metafields
 */
function mapMetafieldsToShopify(customFields) {
  return Object.entries(customFields).map(([key, value]) => ({
    namespace: 'custom',
    key: key.toLowerCase().replace(/\s+/g, '_'),
    value: String(value),
    type: inferMetafieldType(value),
  }));
}

/**
 * Infer Shopify metafield type from value
 * @param {*} value - Field value
 * @returns {string} Shopify metafield type
 */
function inferMetafieldType(value) {
  if (typeof value === 'number') return 'number_integer';
  if (typeof value === 'boolean') return 'boolean';
  if (value instanceof Date) return 'date';
  return 'single_line_text_field';
}

/**
 * Parse tags from external system format
 * @param {string|Array} tags - Tags from external system
 * @returns {Array} Array of tag strings
 */
function parseTagsFromExternal(tags) {
  if (Array.isArray(tags)) return tags;
  if (typeof tags === 'string') return tags.split(',').map(t => t.trim());
  return [];
}

/**
 * Map Shopify order to external system format
 * @param {Object} shopifyOrder - Order data from Shopify
 * @returns {Object} External system-formatted order data
 */
function mapOrderToExternal(shopifyOrder) {
  return {
    externalOrderId: shopifyOrder.name,
    orderDate: shopifyOrder.created_at,
    customerEmail: shopifyOrder.email,
    customerName: `${shopifyOrder.customer?.first_name || ''} ${shopifyOrder.customer?.last_name || ''}`.trim(),
    shippingAddress: mapShippingAddress(shopifyOrder.shipping_address),
    billingAddress: mapBillingAddress(shopifyOrder.billing_address),
    lineItems: shopifyOrder.line_items.map(mapLineItem),
    subtotal: parseFloat(shopifyOrder.subtotal_price),
    tax: parseFloat(shopifyOrder.total_tax),
    shipping: parseFloat(shopifyOrder.total_shipping_price_set?.shop_money?.amount || 0),
    total: parseFloat(shopifyOrder.total_price),
    currency: shopifyOrder.currency,
  };
}

/**
 * Map address to external system format
 * @param {Object} address - Shopify address
 * @returns {Object} External system address format
 */
function mapShippingAddress(address) {
  if (!address) return null;

  return {
    address1: address.address1,
    address2: address.address2 || '',
    city: address.city,
    province: address.province_code || address.province,
    postalCode: address.zip,
    country: address.country_code,
    phone: address.phone || '',
  };
}

function mapBillingAddress(address) {
  return mapShippingAddress(address);
}

/**
 * Map line item to external system format
 * @param {Object} lineItem - Shopify line item
 * @returns {Object} External system line item format
 */
function mapLineItem(lineItem) {
  return {
    sku: lineItem.sku,
    productName: lineItem.name,
    quantity: lineItem.quantity,
    unitPrice: parseFloat(lineItem.price),
    total: parseFloat(lineItem.price) * lineItem.quantity,
    taxable: lineItem.taxable,
  };
}

module.exports = {
  mapProductToShopify,
  mapVariantsToShopify,
  mapMetafieldsToShopify,
  mapOrderToExternal,
  mapShippingAddress,
  mapBillingAddress,
  mapLineItem,
};
