---
name: code-generator
description: Automated middleware and integration code generation with field mappings, API clients, and deployment configurations. Invoked by implementation-engineer for autonomous code generation.
type: executable
invoked_by: ["implementation-engineer"]
---

# Code Generator Skill

**Type**: Executable Skill (scripts + templates)
**Purpose**: Generate production-ready middleware, field mappings, and API client code
**Invoked By**: implementation-engineer agent

---

## Overview

The code-generator skill provides executable scripts and templates for generating:
- Shopify integration middleware (Node.js/Express, Python)
- Field mapping transformations (NetSuite → Shopify, SAP → Shopify, etc.)
- API client boilerplate (GraphQL, REST)
- Deployment configurations (Railway, Vercel, Docker)

**Critical Integration:** Works with validation-framework skill for pre-execution validation and shopify-dev-mcp for real-time API validation.

---

## When to Use

**implementation-engineer agent invokes this skill when:**
- User asks to "generate middleware" or "build integration code"
- Field mapping needed for data transformation (ERP → Shopify)
- API client setup required (GraphQL Admin API, NetSuite REST API)
- Deployment configuration needed (Docker, Railway, Vercel)

**Pre-requisite:** Ralph Wiggum comprehension check MUST be completed before code generation (configured in guardrails.json)

---

## Executable Scripts

### 1. Shopify App Scaffolding

**Script**: `scripts/shopify/shopify_init.py`
**Purpose**: Interactive scaffolding for Shopify apps, extensions, themes
**Language**: Python 3.8+

**Usage:**
```bash
cd .claude/skills/code-generator/scripts/shopify
python shopify_init.py

# Interactive prompts:
# 1. Project type: app | extension | theme
# 2. Framework: node | remix | python
# 3. Authentication: oauth | session-tokens
# 4. Features: webhooks | billing | metafields
```

**Output:**
- Shopify app directory structure
- OAuth authentication setup
- Environment variable configuration (.env.example)
- shopify.app.toml configuration
- Webhook handlers (if selected)

**Features:**
- Environment variable loading from multiple sources (.env hierarchy)
- Support for multiple AI tool directories (.claude, .gemini, .cursor, .agent)
- Type-safe configuration with Python dataclasses
- Interactive CLI with validation

**Integration with Shopify Agency Framework:**
- Use AFTER Ralph Wiggum comprehension check confirms requirements
- Use WITH middleware-template reference repo for proven patterns
- Use BEFORE validation-framework validates generated code

### 2. Shopify GraphQL Client

**Script**: `scripts/shopify/shopify_graphql.py`
**Purpose**: Reusable GraphQL client utilities with pagination, rate limiting, error handling
**Language**: Python 3.8+

**Usage:**
```python
from shopify_graphql import ShopifyGraphQL

client = ShopifyGraphQL(
    shop_domain="example.myshopify.com",
    access_token="shpat_xxxxx"
)

# Query with automatic pagination
products = client.query_all_products(
    fields=["id", "title", "handle"],
    query="status:active"
)

# Mutation with error handling
result = client.mutate_product_create(
    title="New Product",
    vendor="Acme Corp"
)

# Rate limit awareness
if client.is_rate_limited():
    wait_seconds = client.get_backoff_time()
    print(f"Rate limited, waiting {wait_seconds}s")
```

**Features:**
- Cursor-based pagination (automatic handling of pageInfo.hasNextPage)
- Rate limit monitoring (X-Shopify-Shop-Api-Call-Limit header)
- Exponential backoff retry logic
- Query cost estimation
- Bulk operation support (for >250 records)
- Error handling with detailed messages

**Integration with Shopify Agency Framework:**
- Use WITH shopify-dev-mcp for schema validation (introspect_graphql_schema)
- Use BEFORE check-api-limits.sh validates rate limits
- Use WITH validation-framework for post-execution reconciliation

### 3. Middleware Generator *(Planned - Week 3-4)*

**Script**: `scripts/middleware-generator.py` *(to be created)*
**Purpose**: Generate Express.js/FastAPI middleware for ERP ↔ Shopify integration
**Language**: Python 3.8+

**Planned Features:**
- Field mapping code generation from spec
- Webhook handler templates
- Cron job schedulers for batch sync
- Error handling and retry logic
- Logging and monitoring setup

---

## Templates

### Middleware Template Reference

**Location**: `.claude/references/shopify-middleware-template/`
**Purpose**: Proven patterns for middleware structure

**Scripts use these templates for:**
- Express.js project structure
- Docker deployment configuration
- Environment variable patterns
- Error handling middleware
- Logging utilities

**Reference:** See [PHASE-0-INFRASTRUCTURE-SETUP.md](../../docs/PHASE-0-INFRASTRUCTURE-SETUP.md) for template structure.

---

## Integration with Shopify Agency Framework Architecture

### Pre-Execution Workflow

```
1. User: "Generate middleware for NetSuite → Shopify product sync"

2. implementation-engineer agent:
   - Triggers Ralph Wiggum comprehension check (guardrails.json)
   - Confirms: data direction, sync frequency, field mappings, assumptions

3. User: Confirms understanding

4. implementation-engineer agent:
   - Invokes code-generator skill (this skill)
   - Calls shopify_init.py or shopify_graphql.py
   - Generates code using middleware-template reference

5. validation-framework skill:
   - Validates generated code (validate-code.js)
   - Checks: no hardcoded secrets, staging target, dependencies valid

6. shopify-dev-mcp:
   - Validates GraphQL queries (validate_graphql_codeblocks)
   - Validates React components (validate_component_codeblocks)

7. implementation-engineer agent:
   - Commits to feature branch (permissions.json tier 2)
   - Deploys to staging automatically
```

### Validation Gates

**From guardrails.json:**
```json
{
  "pre_execution_gates": {
    "code_generation": {
      "checks": [
        "ralph_wiggum_comprehension_check",  // MANDATORY
        "spec_complete",
        "no_hardcoded_secrets",
        "staging_target_only"
      ],
      "pass_threshold": 1.0
    }
  }
}
```

**All checks must pass before code generation proceeds.**

---

## Usage Examples

### Example 1: Generate Shopify App

```python
# implementation-engineer agent workflow:

# 1. Ralph Wiggum comprehension check completed
# 2. User confirmed: OAuth app with product sync webhook

# 3. Invoke code-generator skill
subprocess.run([
    "python",
    ".claude/skills/code-generator/scripts/shopify/shopify_init.py"
])

# Interactive prompts auto-answered by agent:
# Project type: app
# Framework: node
# Features: webhooks (products/update)

# 4. Validate generated code
subprocess.run([
    "node",
    ".claude/skills/validation-framework/scripts/validate-code.js",
    "--spec", "generated-spec.json",
    "--target", "staging"
])

# 5. If validation passes, commit and deploy
```

### Example 2: Generate GraphQL Client for Middleware

```python
# implementation-engineer agent workflow:

# 1. Read middleware-template reference
with open(".claude/references/shopify-middleware-template/src/config/shopify-client.js") as f:
    template = f.read()

# 2. Generate Python equivalent using shopify_graphql.py as base
# 3. Add field mappings for NetSuite → Shopify
# 4. Validate with shopify-dev-mcp

# Example generated code:
from shopify_graphql import ShopifyGraphQL

def sync_products_from_netsuite(netsuite_products):
    """Sync products from NetSuite to Shopify."""
    client = ShopifyGraphQL(
        shop_domain=os.getenv("SHOPIFY_SHOP"),
        access_token=os.getenv("SHOPIFY_ACCESS_TOKEN")
    )

    for ns_product in netsuite_products:
        # Field mapping: NetSuite → Shopify
        shopify_product = {
            "title": ns_product["displayName"],
            "vendor": ns_product["manufacturer"],
            "productType": ns_product["itemType"],
            "variants": [{
                "price": str(ns_product["basePrice"]),
                "sku": ns_product["itemId"],
                "inventoryQuantity": ns_product["quantityAvailable"]
            }]
        }

        client.mutate_product_create(**shopify_product)
```

---

## Script Dependencies

**Python Requirements** (from `scripts/shopify/requirements.txt`):
```
requests>=2.31.0
python-dotenv>=1.0.0
typing-extensions>=4.8.0
```

**Install:**
```bash
cd .claude/skills/code-generator/scripts/shopify
pip install -r requirements.txt
```

---

## Configuration

**Environment Variables** (loaded by scripts):
```bash
# .env file locations (priority order):
# 1. .claude/skills/code-generator/scripts/shopify/.env
# 2. .claude/skills/.env
# 3. .claude/.env

SHOPIFY_API_KEY=your_api_key
SHOPIFY_API_SECRET=your_api_secret
SHOPIFY_SHOP=your-store.myshopify.com
SHOPIFY_ACCESS_TOKEN=shpat_xxxxx
```

**Scripts automatically search for .env files in this hierarchy.**

---

## Anti-Hallucination Integration

**Code generation MUST use real-time validation:**

1. **Before generating GraphQL queries:**
   ```
   Call shopify-dev-mcp → introspect_graphql_schema(query: "product")
   Use returned schema fields (don't guess)
   ```

2. **After generating code:**
   ```
   Call shopify-dev-mcp → validate_graphql_codeblocks(codeblocks)
   Ensure queries are valid against current API version
   ```

3. **Reference proven patterns:**
   ```
   Read .claude/references/shopify-middleware-template/
   Copy working patterns instead of inventing new ones
   ```

**Never generate code based on assumptions - always validate first.**

---

## Autonomous Execution

**Permissions** (from permissions.json):
- ✅ Tier 2: Auto-execute in staging environments
- ✅ Generate code on feature branches
- ✅ Deploy to staging automatically
- ❌ Tier 3: Production deployment requires approval

**Safety Gates:**
- Ralph Wiggum comprehension check (MANDATORY)
- Pre-execution validation (validate-code.js)
- API rate limit check (check-api-limits.sh)
- Post-execution code validation (shopify-dev-mcp)

---

## Future Enhancements (Week 3-4)

**Planned Scripts:**
1. `middleware-generator.py` - Full middleware generation from spec
2. `field-mapper.py` - Interactive field mapping wizard
3. `deployment-config-generator.py` - Docker/Railway/Vercel configs
4. `test-generator.py` - Unit and integration test scaffolding

**Planned Templates:**
- Node.js Express middleware template
- Python FastAPI middleware template
- Docker Compose configurations
- GitHub Actions CI/CD workflows

---

## Version History

**v1.0** (2026-01-27): Initial code-generator skill
- Extracted shopify_init.py from shopify-development skill
- Extracted shopify_graphql.py from shopify-development skill
- Integrated with validation-framework and shopify-dev-mcp
- Added Ralph Wiggum comprehension check integration
- Aligned with Shopify Agency Framework autonomous execution architecture

---

**End of Code Generator Skill**
