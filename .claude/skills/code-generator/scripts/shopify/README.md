# Shopify Code Generation Scripts

**Purpose**: Executable utilities for generating Shopify apps, extensions, and GraphQL client code.

---

## Scripts

### shopify_init.py
**Interactive scaffolding for Shopify projects**

```bash
python shopify_init.py

# Generates:
# - Shopify app/extension/theme structure
# - OAuth authentication setup
# - Environment variable configuration
# - Webhook handlers
# - shopify.app.toml configuration
```

**Features:**
- Multi-AI-tool support (.claude, .gemini, .cursor, .agent)
- Environment variable loading from multiple .env locations
- Type-safe configuration
- Interactive CLI with validation

---

### shopify_graphql.py
**Reusable GraphQL client utilities**

```python
from shopify_graphql import ShopifyGraphQL

client = ShopifyGraphQL(
    shop_domain="example.myshopify.com",
    access_token="shpat_xxxxx"
)

# Query with pagination
products = client.query_all_products(
    fields=["id", "title"],
    query="status:active"
)

# Mutations with error handling
result = client.mutate_product_create(
    title="New Product",
    vendor="Acme"
)
```

**Features:**
- Automatic cursor-based pagination
- Rate limit monitoring and exponential backoff
- Bulk operation support (>250 records)
- Query cost estimation
- Detailed error handling

---

## Installation

```bash
cd .claude/skills/code-generator/scripts/shopify
pip install -r requirements.txt
```

**Requirements:**
- Python 3.8+
- requests>=2.31.0
- python-dotenv>=1.0.0
- typing-extensions>=4.8.0

---

## Environment Variables

Scripts automatically load from (priority order):
1. `.claude/skills/code-generator/scripts/shopify/.env`
2. `.claude/skills/.env`
3. `.claude/.env`

**Required variables:**
```bash
SHOPIFY_API_KEY=your_api_key
SHOPIFY_API_SECRET=your_api_secret
SHOPIFY_SHOP=your-store.myshopify.com
SHOPIFY_ACCESS_TOKEN=shpat_xxxxx  # For GraphQL client
```

---

## Integration with Shopify Agency Framework

**These scripts are invoked by the implementation-engineer agent after:**
1. Ralph Wiggum comprehension check completed
2. User confirmed requirements
3. Pre-execution validation passed

**Validation workflow:**
1. Generate code using these scripts
2. Validate with validation-framework/scripts/validate-code.js
3. Validate GraphQL with shopify-dev-mcp (validate_graphql_codeblocks)
4. Deploy to staging (if all validation passes)

---

## Credits

**Extracted from:** davila7/claude-code-templates shopify-development skill
**Adapted for:** Shopify Agency Framework autonomous execution architecture
**Integration:** Ralph Wiggum checks, validation-framework, shopify-dev-mcp
