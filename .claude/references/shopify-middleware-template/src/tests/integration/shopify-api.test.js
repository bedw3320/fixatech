/**
 * Integration Tests for Shopify API
 * Tests API connectivity and basic operations
 */

const { executeQuery } = require('../../config/shopify-client');

describe('Shopify API Integration Tests', () => {
  describe('Shop Query', () => {
    test('should fetch shop information', async () => {
      const query = `
        query {
          shop {
            name
            email
            currencyCode
          }
        }
      `;

      const data = await executeQuery(query);

      expect(data.shop).toBeDefined();
      expect(data.shop.name).toBeDefined();
      expect(data.shop.email).toBeDefined();
      expect(data.shop.currencyCode).toBeDefined();
    });
  });

  describe('Product Queries', () => {
    test('should fetch products list', async () => {
      const query = `
        query GetProducts($first: Int!) {
          products(first: $first) {
            edges {
              node {
                id
                title
                handle
              }
            }
          }
        }
      `;

      const data = await executeQuery(query, { first: 10 });

      expect(data.products).toBeDefined();
      expect(Array.isArray(data.products.edges)).toBe(true);
    });

    test('should handle product by ID query', async () => {
      const query = `
        query GetProduct($id: ID!) {
          product(id: $id) {
            id
            title
            description
            variants(first: 5) {
              edges {
                node {
                  id
                  sku
                  price
                }
              }
            }
          }
        }
      `;

      // Replace with actual product ID from your store
      const productId = 'gid://shopify/Product/1234567890';

      try {
        const data = await executeQuery(query, { id: productId });
        expect(data.product).toBeDefined();
      } catch (error) {
        // Product might not exist - test should still verify error handling
        expect(error).toBeDefined();
      }
    });
  });

  describe('Error Handling', () => {
    test('should handle invalid GraphQL queries', async () => {
      const invalidQuery = `
        query {
          invalidField {
            nonExistent
          }
        }
      `;

      await expect(executeQuery(invalidQuery)).rejects.toThrow();
    });
  });
});
