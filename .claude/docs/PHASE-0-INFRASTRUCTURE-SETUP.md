# Phase 0: Infrastructure Setup Guide

**Timeline:** 1-2 days (COMPLETE BEFORE WEEK 1)
**Version:** 1.0.0
**Last Updated:** 2026-01-27

---

## Overview

Phase 0 establishes the foundational infrastructure that all agents and skills depend on. This MUST be completed before beginning Week 1-2 Foundation work.

**Dependencies:**
- MCP servers for real-time API documentation access
- Reference repositories for code generation templates
- Ralph Wiggum plugin for comprehension checks
- Verification that all systems are operational

---

## Checklist

### MCP Servers (Model Context Protocol)
- [ ] shopify-dev-mcp configured (Shopify API docs + GraphQL validation)
- [ ] firecrawl configured (web scraping for external docs)
- [ ] n8n-mcp configured (workflow automation insights)
- [ ] context7 configured (library documentation for Node.js, Python, etc.)
- [ ] All MCPs tested and responding

### Reference Repositories
- [ ] Shopify Dawn theme cloned to `.claude/references/shopify-dawn-theme/`
- [ ] Middleware template structure created in `.claude/references/shopify-middleware-template/`
- [ ] Agency stack documented (if applicable)
- [ ] Reference paths added to settings.json

### Plugins
- [ ] Ralph Wiggum plugin installed for comprehension checks

### Verification
- [ ] All MCPs respond to test queries
- [ ] Reference repos accessible by agents
- [ ] Documentation complete

---

## Part 1: MCP Server Configuration

### What are MCPs?

**Model Context Protocol (MCP)** servers provide Claude with real-time access to external data sources like API documentation, web content, and development tools. This prevents hallucination by ensuring agents always have current information.

### Required MCPs for Shopify Agency Framework

#### 1. shopify-dev-mcp
**Purpose:** Real-time access to Shopify API documentation and GraphQL schema
**Used by:** platform-architect, implementation-engineer, theme-specialist
**Critical for:** Preventing API hallucination, GraphQL validation, capabilities verification

**Status Check:**
```bash
# Test if shopify-dev-mcp is available
# If you can call learn_shopify_api in a Claude session, it's configured
```

**What it provides:**
- `learn_shopify_api` - Load Shopify API context (Admin, Storefront, Functions, etc.)
- `introspect_graphql_schema` - Query GraphQL schema for fields/mutations
- `search_docs_chunks` - Search Shopify developer documentation
- `fetch_full_docs` - Retrieve complete documentation pages
- `validate_component_codeblocks` - Validate Polaris components
- `validate_graphql_codeblocks` - Validate GraphQL queries/mutations
- `validate_theme` - Validate Liquid code

**Installation** (if not already configured):
```bash
npm install -g @modelcontextprotocol/server-shopify-dev
```

#### 2. firecrawl
**Purpose:** Web scraping for external API documentation (NetSuite, SAP, etc.)
**Used by:** integration-researcher, platform-architect
**Critical for:** Third-party system research when official MCPs unavailable

**Status Check:**
```bash
# Test if firecrawl is available by checking available tools
# Should see firecrawl_scrape and firecrawl_crawl functions
```

**What it provides:**
- `firecrawl_scrape` - Scrape single page (returns markdown)
- `firecrawl_crawl` - Crawl multiple pages (site-wide)
- `firecrawl_map` - Get sitemap structure

**Installation** (if not already configured):
```bash
npm install -g firecrawl-mcp
```

**Configuration:**
- Requires `FIRECRAWL_API_KEY` environment variable
- Get API key from https://firecrawl.dev

#### 3. n8n-mcp
**Purpose:** Workflow automation node catalog and configuration patterns
**Used by:** implementation-engineer for understanding integration workflows
**Critical for:** Recommending workflow automation alternatives

**Status Check:**
```bash
# Test if n8n-mcp is available
# Should see list_nodes, get_node_info, search_nodes functions
```

**What it provides:**
- `list_nodes` - List n8n integration nodes (500+ integrations)
- `get_node_info` - Get technical schema for specific node
- `search_nodes` - Search nodes by keyword
- `list_ai_tools` - List AI-compatible nodes
- `get_node_documentation` - Get human-readable node docs
- `validate_node_operation` - Validate node configuration

**Installation** (if not already configured):
```bash
npm install -g n8n-mcp
```

#### 4. context7
**Purpose:** Library documentation for modern frameworks and languages
**Used by:** implementation-engineer for middleware code generation
**Critical for:** Generating code with current library APIs (Express.js, React, etc.)

**Status Check:**
```bash
# Test if context7 is available
# Should see resolve-library-id and query-docs functions
```

**What it provides:**
- `resolve-library-id` - Find library ID for package name
- `query-docs` - Query library documentation and code examples

**Installation** (if not already configured):
```bash
npm install -g @context7/mcp
```

**Supported libraries:**
- Node.js frameworks (Express, Fastify, NestJS)
- Frontend frameworks (React, Vue, Svelte)
- Shopify libraries (@shopify/app, @shopify/cli)
- Database libraries (Prisma, TypeORM)
- And 1000+ more

### MCP Configuration File

**Location:** `.claude/config/settings.json`

**Purpose:** Document which MCPs are configured and how agents should use them

```json
{
  "mcp_servers": {
    "shopify-dev-mcp": {
      "status": "configured",
      "command": "npx @modelcontextprotocol/server-shopify-dev",
      "used_by": ["platform-architect", "implementation-engineer", "theme-specialist"],
      "capabilities": [
        "learn_shopify_api",
        "introspect_graphql_schema",
        "validate_component_codeblocks",
        "validate_graphql_codeblocks"
      ]
    },
    "firecrawl": {
      "status": "configured",
      "command": "firecrawl-mcp",
      "requires_api_key": true,
      "used_by": ["integration-researcher", "platform-architect"],
      "capabilities": ["firecrawl_scrape", "firecrawl_crawl"]
    },
    "n8n-mcp": {
      "status": "configured",
      "command": "n8n-mcp",
      "used_by": ["implementation-engineer"],
      "capabilities": ["list_nodes", "search_nodes", "get_node_documentation"]
    },
    "context7": {
      "status": "configured",
      "command": "npx -y @context7/mcp",
      "used_by": ["implementation-engineer"],
      "capabilities": ["resolve-library-id", "query-docs"]
    }
  },
  "mcp_usage_policy": {
    "high_risk_queries": "MUST use MCPs for verification",
    "fallback_on_failure": "Use cached knowledge with date disclaimer",
    "citation_required": true
  }
}
```

### Testing MCPs

**Verify each MCP is working:**

1. **Test shopify-dev-mcp:**
   ```
   Can you call learn_shopify_api with api="admin"?
   # Should return conversationId if working
   ```

2. **Test firecrawl:**
   ```
   Can you scrape https://shopify.dev/docs/api/admin-graphql?
   # Should return markdown content if working
   ```

3. **Test n8n-mcp:**
   ```
   Can you list 5 n8n nodes related to Shopify?
   # Should return list of Shopify integration nodes
   ```

4. **Test context7:**
   ```
   Can you query documentation for Express.js routing?
   # Should return Express.js route documentation
   ```

---

## Part 2: Reference Repositories

### Why Reference Repos?

Reference repositories provide concrete examples for agents to learn patterns from when generating code. Instead of hallucinating implementations, agents can:
- Read actual working code from reference repos
- Copy proven patterns and structures
- Generate code that matches your team's standards

### Required Reference Repos

#### 1. Shopify Dawn Theme

**Purpose:** Official Shopify reference theme for Liquid patterns and component structure
**Used by:** theme-specialist agent
**Size:** ~15-20 MB

**Setup:**
```bash
# Clone Shopify Dawn theme
git clone https://github.com/Shopify/dawn.git .claude/references/shopify-dawn-theme

# Alternative: If Horizon theme is available (newer)
# git clone https://github.com/Shopify/horizon.git .claude/references/shopify-horizon-theme
```

**What agents learn from it:**
- Liquid templating patterns
- Section/block architecture
- Theme settings structure (JSON schemas)
- Component naming conventions
- Accessibility patterns
- Performance optimization techniques

**Example agent usage:**
```
User: "Add a custom product recommendations section to the theme"

theme-specialist agent:
1. Reads .claude/references/shopify-horizon-theme/sections/product-recommendations.liquid
2. Understands the schema structure for section settings
3. Generates new section following the same patterns
4. Validates generated Liquid code using shopify-dev-mcp
```

#### 2. Middleware Template

**Purpose:** Standard structure for Shopify integration middleware
**Used by:** implementation-engineer, code-generator skill
**Size:** ~1-2 MB

**Setup:**
```bash
# Create middleware template directory
mkdir -p .claude/references/shopify-middleware-template

# Structure to create:
.claude/references/shopify-middleware-template/
├── README.md
├── package.json
├── .env.example
├── docker-compose.yml
├── src/
│   ├── index.js                    # Express server entry point
│   ├── config/
│   │   └── shopify-client.js       # Shopify GraphQL client setup
│   ├── webhooks/
│   │   ├── orders-create.js        # Order webhook handler
│   │   └── inventory-update.js     # Inventory webhook handler
│   ├── jobs/
│   │   └── product-sync.js         # Batch product sync cron job
│   ├── mappings/
│   │   └── field-mappings.js       # NetSuite → Shopify field transformations
│   └── utils/
│       ├── logger.js               # Logging utility
│       └── error-handler.js        # Error handling middleware
└── tests/
    └── integration/
        └── shopify-api.test.js     # Integration tests
```

**What agents learn from it:**
- Express.js project structure
- Shopify Admin API client patterns
- Webhook handler structure
- Field mapping patterns
- Error handling and retry logic
- Environment variable management
- Docker deployment configuration

#### 3. Agency Stack (Optional)

**Purpose:** Your agency's preferred technology stack and coding standards
**Used by:** All agents generating code
**Size:** Varies

**Setup:**
```bash
mkdir -p .claude/references/agency-stack
```

**Example structure:**
```
.claude/references/agency-stack/
├── README.md                       # Overview of your stack
├── code-standards.md               # Coding conventions
├── deployment-checklist.md         # Pre-deployment requirements
├── templates/
│   ├── express-middleware/         # Your Express.js boilerplate
│   ├── railway-config/             # Railway deployment configs
│   └── github-actions/             # CI/CD workflows
└── examples/
    └── shopify-netsuite-integration/  # Reference implementation
```

**Document:**
- Preferred frameworks (Express vs Fastify vs NestJS)
- Hosting platforms (Railway, Vercel, AWS Lambda)
- CI/CD pipelines (GitHub Actions, GitLab CI)
- Testing frameworks (Jest, Vitest)
- Code style (ESLint config, Prettier config)

### Adding Reference Repos to Configuration

**Update:** `.claude/config/settings.json`

```json
{
  "reference_repos": {
    "shopify_theme": {
      "path": ".claude/references/shopify-horizon-theme",
      "description": "Official Shopify Horizon theme for Liquid patterns",
      "used_by": ["theme-specialist"],
      "status": "ready"
    },
    "middleware_template": {
      "path": ".claude/references/shopify-middleware-template",
      "description": "Standard Node.js Express middleware structure",
      "used_by": ["implementation-engineer", "code-generator"],
      "status": "ready"
    },
    "agency_stack": {
      "path": ".claude/references/agency-stack",
      "description": "Agency coding standards and preferred stack",
      "used_by": ["all agents"],
      "status": "optional"
    }
  }
}
```

---

## Part 3: Ralph Wiggum Plugin

### What is Ralph Wiggum Plugin?

The Ralph Wiggum plugin enforces comprehension checks before high-risk actions. Named after the Simpsons character who innocently repeats things back, it forces Claude to explain its understanding before proceeding.

**Critical for:**
- Code generation (prevents generating wrong integration)
- Architecture design (clarifies assumptions before designing)
- Data migration (confirms scope before migrating thousands of records)
- Discovery frameworks (validates understanding of requirements)

### Installation

```bash
/plugin install ralph-loop@claude-plugins-official
```

**From Claude interface:**
1. Open Claude Code CLI
2. Run: `/plugin install ralph-loop@claude-plugins-official`
3. Confirm installation
4. Plugin will be available in all future sessions

**Verification:**
```bash
/plugins list
# Should show: ralph-loop@claude-plugins-official (installed)
```

### How It Works with Shopify Agency Framework

**Integration:** Plugin works with [guardrails.json](../config/guardrails.json) configuration

**Trigger conditions** (defined in guardrails.json):
- Code generation requests
- Architecture design tasks
- Data migration planning
- Discovery framework creation
- Middleware builds
- Integration design

**Pattern:**
1. User requests high-risk action ("Generate middleware for NetSuite → Shopify")
2. Ralph Wiggum plugin triggers comprehension check
3. Agent explains understanding and waits for confirmation
4. User confirms or corrects
5. Agent proceeds with correct understanding

**Example:**
```
User: "Generate middleware for syncing NetSuite products to Shopify"

Ralph Wiggum plugin triggers:

Agent: [COMPREHENSION CHECK - Ralph Wiggum]
"Before I generate the middleware code, let me confirm what I understand:

**Integration Scope:**
- Direction: NetSuite → Shopify (one-way)
- Data Type: Products only (not orders/inventory/customers)
- Frequency: Not specified - should I default to batch sync?

**Questions:**
- What sync frequency do you need? (Real-time webhooks vs batch every X hours)
- Any custom NetSuite fields that need special handling?

**Is this correct, or should I adjust?**"

[WAITS for user response before generating code]
```

---

## Part 4: Verification Checklist

**Before proceeding to Week 1-2, verify all infrastructure is operational:**

### MCP Verification

```bash
# Test each MCP by asking Claude:

# 1. Shopify Dev MCP
"Use shopify-dev-mcp to fetch the Shopify Admin API product object schema"
✅ Should return GraphQL schema for Product type

# 2. Firecrawl
"Use firecrawl to scrape https://shopify.dev/docs/api/usage"
✅ Should return markdown content from Shopify docs

# 3. N8N MCP
"Use n8n-mcp to list 5 Shopify integration nodes"
✅ Should return list: Shopify, Shopify Trigger, Shopify Product, etc.

# 4. Context7
"Use context7 to find Express.js route parameter documentation"
✅ Should return Express.js routing docs with examples
```

### Reference Repo Verification

```bash
# Check reference repos exist and are accessible

ls -la .claude/references/shopify-horizon-theme/sections/
# ✅ Should show Liquid section files

ls -la .claude/references/shopify-middleware-template/src/
# ✅ Should show middleware source structure

# Test agent can read reference files
"Read the product-recommendations.liquid section from the Horizon theme reference"
# ✅ Agent should successfully read and explain the file
```

### Configuration Verification

```bash
# Verify configuration files created in Week 1-2 exist

ls -la .claude/config/
# ✅ Should show: permissions.json, guardrails.json, agent-routing.json, settings.json

# Verify documentation exists
ls -la .claude/docs/
# ✅ Should show: QUICK-START-GUIDE.md, communication-standards.md, PHASE-0-INFRASTRUCTURE-SETUP.md
```

### Ralph Wiggum Plugin Verification

```bash
# Test comprehension check triggers

"Generate middleware code for Shopify product sync"
# ✅ Agent should pause and ask for confirmation BEFORE generating code

# If agent generates code immediately without asking, plugin not working
# ❌ Need to verify ralph-loop plugin installation
```

---

## Troubleshooting

### MCP Not Responding

**Symptom:** Function calls fail or return errors

**Fixes:**
1. Check MCP server is installed: `npm list -g | grep mcp`
2. Verify API keys configured (for firecrawl)
3. Restart Claude Code CLI
4. Check MCP server logs for errors

### Reference Repos Not Found

**Symptom:** Agent says "I cannot find the reference file"

**Fixes:**
1. Verify repo cloned: `ls .claude/references/shopify-horizon-theme/`
2. Check file paths in settings.json match actual paths
3. Ensure agent has read permissions: `ls -la .claude/references/`

### Ralph Wiggum Plugin Not Triggering

**Symptom:** Agent generates code immediately without comprehension check

**Fixes:**
1. Verify plugin installed: `/plugins list`
2. Check guardrails.json has ralph_wiggum_triggers enabled
3. Ensure request matches trigger keywords (code generation, architecture design, etc.)

---

## Success Criteria

**Phase 0 is complete when:**
- ✅ All 4 MCPs (shopify-dev-mcp, firecrawl, n8n-mcp, context7) responding to test queries
- ✅ Shopify Dawn/Horizon theme cloned and accessible
- ✅ Middleware template structure created
- ✅ Ralph Wiggum plugin installed and triggering comprehension checks
- ✅ settings.json configuration file created documenting all infrastructure
- ✅ Verification tests passing for MCPs, reference repos, and plugin

**You can now proceed to Week 1-2 Foundation tasks with confidence.**

---

## Next Steps

After completing Phase 0:

1. Return to [QUICK-START-GUIDE.md](./QUICK-START-GUIDE.md)
2. Continue with Week 1-2 Foundation (already started):
   - ✅ Create permissions.json, guardrails.json, agent-routing.json
   - ✅ Create validation-framework skill
   - ✅ Refactor orchestrator agent
3. Proceed to Week 3-4: Agent Optimization

---

## Version History

**v1.0** (2026-01-27): Initial Phase 0 infrastructure setup guide
- MCP server configuration (4 required MCPs)
- Reference repository setup (Dawn theme, middleware template)
- Ralph Wiggum plugin installation
- Verification checklists and troubleshooting

---

**End of Phase 0 Infrastructure Setup Guide**
