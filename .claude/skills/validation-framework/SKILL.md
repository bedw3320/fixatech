---
name: validation-framework
description: Pre-execution validation, post-execution reconciliation, Ralph Wiggum comprehension checks, and automated quality gates for safe autonomous execution. Critical for preventing errors before they happen.
type: executable
invoked_by: ["quality-validator", "implementation-engineer", "orchestrator"]
---

# Validation Framework Skill

**Type**: Executable Skill (scripts + reference documentation)
**Purpose**: Ensure safe autonomous execution through comprehensive validation gates
**Critical For**: Preventing hallucinations, catching errors early, enabling confident autonomous execution

---

## Overview

The validation-framework skill provides three layers of protection:

1. **Ralph Wiggum Comprehension Checks** - Prevent misunderstanding before action
2. **Pre-Execution Validation** - Catch errors before execution
3. **Post-Execution Validation** - Verify results after execution

---

## Ralph Wiggum Comprehension Check

**Named After**: The Simpsons character who innocently repeats things back
**Purpose**: Force agents to explain their understanding before taking action
**Critical For**: Code generation, architecture design, data migration, discovery

### When to Use

**MANDATORY for**:
- Code generation (middleware, ETL scripts, integrations)
- Architecture design (multi-system integrations)
- Data migration planning
- Discovery framework creation

**SKIP for**:
- Simple research queries ("What are Shopify transaction fees?")
- Documentation lookups ("How do I add a metafield?")
- Basic questions with straightforward answers

### Implementation Pattern

```markdown
User: [Complex request requiring action]

Agent: [COMPREHENSION CHECK - Ralph Wiggum]
"Before I [action], let me confirm what I understand:

**[Category 1]:**
- [Key understanding point 1]
- [Key understanding point 2]
- [Key understanding point 3]

**[Category 2]:**
- [Key understanding point 4]
- [Key understanding point 5]

**Generated [Output] Will Include:**
1. [Component 1]
2. [Component 2]
3. [Component 3]

**Assumptions:**
- [Assumption 1]
- [Assumption 2]

**Questions:**
- [Question 1 if anything unclear]

**Is this correct, or should I adjust the approach?**"

[WAIT for user confirmation - DO NOT PROCEED until user responds]

User: [Confirms or corrects]

Agent: [Proceeds with correct understanding, or updates and re-confirms if corrected]
```

### Example: Code Generation

```
User: "Generate middleware for syncing NetSuite products to Shopify every 6 hours"

Agent: [COMPREHENSION CHECK - Ralph Wiggum]
"Before I generate the middleware code, let me confirm what I understand:

**Integration Scope:**
- Direction: NetSuite → Shopify (one-way sync)
- Data Type: Products only (not orders, inventory, customers)
- Frequency: Every 6 hours (batch sync via cron)
- Strategy: Incremental (query products updated since last sync)

**Generated Code Will Include:**
1. NetSuite REST API client (SuiteTalk authentication)
2. Shopify GraphQL client (Admin API)
3. Field mappings (NetSuite Item → Shopify Product)
4. Cron job scheduler (every 6 hours)
5. Error handling (retry logic, logging)

**Assumptions:**
- Middleware hosted on Railway or Vercel
- Node.js + Express framework
- PostgreSQL for storing last sync timestamp
- Using official NetSuite and Shopify SDKs

**Questions:**
- Should I include inventory sync as well, or strictly products only?
- Any custom NetSuite fields that need special handling?

**Is this correct, or should I adjust the approach?**"

[WAIT FOR USER RESPONSE]

User: "Yes, correct. Also add inventory sync."

Agent: "Got it! Updating to include inventory sync. Let me confirm the updated scope:
- Products + Inventory levels (NetSuite → Shopify)
- Inventory sync: Real-time via webhooks (if NetSuite supports) OR batch every hour
Which approach for inventory?"

User: "Batch every hour"

Agent: "Perfect! Generating middleware code now with:
- Products: Batch every 6 hours
- Inventory: Batch every 1 hour"

[PROCEEDS with code generation]
```

### Configuration

**Defined in**: [.claude/config/guardrails.json](.claude/config/guardrails.json)

```json
{
  "ralph_wiggum_triggers": {
    "enabled": true,
    "required_for": [
      "code_generation",
      "architecture_design",
      "data_migration",
      "discovery_framework"
    ],
    "pattern": "Before {action}, explain understanding and wait for confirmation"
  }
}
```

---

## Pre-Execution Validation

**Purpose**: Catch errors BEFORE execution (not after)
**Scripts**: `validate-code.js`, `validate-data.py`, `check-api-limits.sh`

### Code Generation Validation

**Script**: `scripts/validate-code.js`

**Checks Before Generating Code:**
- [ ] Spec complete (all required fields defined)
- [ ] No hardcoded secrets (API keys, passwords, tokens)
- [ ] Staging target only (not production)
- [ ] Template exists (for template-based generation)
- [ ] Dependencies valid (packages exist, versions compatible)

**Usage**:
```bash
node .claude/skills/validation-framework/scripts/validate-code.js \
  --spec path/to/spec.json \
  --target staging \
  --check-secrets
```

**Output**:
```json
{
  "valid": true,
  "checks": {
    "spec_complete": { "pass": true },
    "no_secrets": { "pass": true },
    "staging_target": { "pass": true },
    "template_exists": { "pass": true },
    "dependencies_valid": { "pass": true }
  },
  "errors": [],
  "warnings": []
}
```

### Data Migration Validation

**Script**: `scripts/validate-data.py`

**Checks Before Migrating Data:**
- [ ] Data format valid (prices numeric, dates ISO 8601)
- [ ] No duplicate keys (SKUs, customer IDs)
- [ ] Within platform limits (Shopify: ≤100 variants, ≤3 options)
- [ ] Required fields present (title, SKU, price)
- [ ] No data corruption (malformed JSON, encoding issues)

**Usage**:
```bash
python .claude/skills/validation-framework/scripts/validate-data.py \
  --input products.json \
  --type shopify_products \
  --sample-size 1000
```

**Output**:
```json
{
  "valid": false,
  "total_records": 5000,
  "passed": 4850,
  "failed": 150,
  "pass_rate": 0.97,
  "errors": [
    {
      "type": "missing_required_field",
      "field": "sku",
      "count": 50,
      "sample_records": ["product-123", "product-456"]
    },
    {
      "type": "duplicate_key",
      "field": "sku",
      "count": 100,
      "duplicates": ["SKU-001", "SKU-002"]
    }
  ],
  "warnings": [
    {
      "type": "title_too_long",
      "count": 25,
      "message": "Title >255 chars (will be truncated)"
    }
  ],
  "recommendations": [
    "Generate SKUs for 50 products missing SKU field",
    "Deduplicate 100 SKUs before import"
  ]
}
```

### API Rate Limit Validation

**Script**: `scripts/check-api-limits.sh`

**Checks Before Making API Calls:**
- [ ] Current rate limit usage (<80% consumed)
- [ ] Estimated calls within limits
- [ ] Retry budget available (for failed requests)

**Usage**:
```bash
bash .claude/skills/validation-framework/scripts/check-api-limits.sh \
  --api shopify \
  --operation bulkProductCreate \
  --count 5000
```

**Output**:
```
✓ Shopify Admin API Rate Limit Check
  Current: 450/1000 points used (45%)
  Threshold: 800/1000 points (80%)
  Available: 550 points

✓ Estimated Usage for Operation
  Operation: bulkProductCreate
  Records: 5,000 products
  Estimated Points: 50 points (batch operation)

✓ Safety Check
  After operation: 500/1000 points (50%)
  Still under threshold (80%)

✅ SAFE TO PROCEED
```

---

## Post-Execution Validation

**Purpose**: Verify execution completed successfully
**Invoked By**: quality-validator, implementation-engineer

### Data Reconciliation

**After data migration, verify:**

1. **Record Counts Match**
   ```javascript
   const sourceCount = 5000
   const targetCount = await shopify.product.count()
   assert(sourceCount === targetCount, `Mismatch: ${sourceCount} vs ${targetCount}`)
   ```

2. **Sample Validation** (spot-check random records)
   ```javascript
   const sampleSKUs = ['SKU-001', 'SKU-123', 'SKU-999']
   for (const sku of sampleSKUs) {
     const source = await getFromSource(sku)
     const target = await shopify.product.find({ sku })
     assert(source.title === target.title, `Title mismatch for ${sku}`)
     assert(Math.abs(source.price - target.price) < 0.01, `Price mismatch for ${sku}`)
   }
   ```

3. **No Broken References**
   ```javascript
   // Check all product images are accessible
   for (const product of products) {
     for (const image of product.images) {
       const response = await fetch(image.src, { method: 'HEAD' })
       assert(response.status === 200, `Image not found: ${image.src}`)
     }
   }
   ```

### Integration Health Check

**After deployment, verify:**

1. **Webhooks Responding**
   ```bash
   curl -X POST https://middleware.example.com/webhooks/orders/create \
     -H "Content-Type: application/json" \
     -d '{"test": true}' \
     --max-time 5
   # Expect: 200 OK
   ```

2. **Sync Jobs Running**
   ```javascript
   const cronJobs = await getCronJobs()
   for (const job of cronJobs) {
     assert(job.status === 'running', `Job ${job.name} not running`)
     assert(job.lastRun within 24 hours, `Job ${job.name} hasn't run recently`)
   }
   ```

3. **No Queued Errors**
   ```javascript
   const errorQueue = await getErrorQueue()
   assert(errorQueue.length === 0, `${errorQueue.length} errors in queue`)
   ```

---

## Validation Gates Configuration

**Defined in**: [.claude/config/guardrails.json](.claude/config/guardrails.json)

### Gate 1: Code Generation

```json
{
  "pre_execution_gates": {
    "code_generation": {
      "checks": [
        "ralph_wiggum_comprehension_check",
        "spec_complete",
        "no_secrets",
        "staging_target"
      ],
      "pass_threshold": 1.0,
      "failure_action": "abort_and_report"
    }
  }
}
```

**Logic**: ALL checks must pass (threshold = 1.0). If any fail, abort and report errors.

### Gate 2: Data Migration

```json
{
  "pre_execution_gates": {
    "data_migration": {
      "checks": [
        "ralph_wiggum_comprehension_check",
        "data_valid",
        "no_duplicates",
        "within_limits"
      ],
      "pass_threshold": 0.95,
      "failure_action": "report_issues_and_wait"
    }
  }
}
```

**Logic**: 95% of checks must pass. If below threshold, report issues and wait for user decision.

### Gate 3: Deployment

```json
{
  "pre_execution_gates": {
    "deployment": {
      "checks": [
        "tests_pass",
        "no_lint_errors",
        "rollback_ready"
      ],
      "pass_threshold": 1.0,
      "failure_action": "abort_and_report"
    }
  }
}
```

**Logic**: ALL checks must pass. Deployment is too critical to allow partial pass.

---

## Rollback Triggers

**Defined in**: [.claude/config/guardrails.json](.claude/config/guardrails.json)

### Automatic Rollback Conditions

1. **Error Rate >10%** (within first hour)
   ```
   If (errors / total_requests) > 0.10:
     trigger_immediate_rollback()
   ```

2. **Post-Execution Validation <90%**
   ```
   If validation_pass_rate < 0.90:
     rollback_and_investigate()
   ```

3. **Critical Error Detected**
   - Payment processing failure
   - Data corruption detected
   - Security breach detected
   - Cascading system failure

---

## Usage by Agents

### quality-validator Agent

**Uses validation-framework to**:
- Run pre-deployment validation (`validate-code.js`)
- Verify post-deployment health (integration health checks)
- Monitor for rollback triggers

**Example**:
```
[quality-validator receives code from implementation-engineer]

1. Run validate-code.js --spec middleware-spec.json
2. If validation passes → deploy to staging
3. After deployment → run integration health checks
4. If health checks pass → mark as successful
5. If error rate >10% → trigger automatic rollback
```

### implementation-engineer Agent

**Uses validation-framework to**:
- Validate data before migration (`validate-data.py`)
- Check API rate limits before bulk operations (`check-api-limits.sh`)
- Trigger Ralph Wiggum comprehension check before code generation

**Example**:
```
[implementation-engineer receives request to migrate 5000 products]

1. Ralph Wiggum comprehension check (confirm migration scope)
2. Run validate-data.py --input products.json
3. If 150 errors found → report to user, ask to fix or proceed with 4850 valid
4. Run check-api-limits.sh --operation bulkProductCreate --count 4850
5. If safe → proceed with migration
6. After migration → verify counts match (5000 source, 4850 imported)
```

### orchestrator Agent

**Uses validation-framework to**:
- Enforce Ralph Wiggum comprehension checks (via guardrails.json)
- Route validation tasks to quality-validator
- Monitor execution and trigger rollbacks if needed

---

## Anti-Hallucination Enforcement

**Integration with MCP Tools**:

### High-Risk Keywords Detection

**Defined in**: [.claude/config/guardrails.json](.claude/config/guardrails.json)

```json
{
  "anti_hallucination_enforcement": {
    "high_risk_keywords": [
      "fee", "rate", "cost", "pricing", "payment",
      "security", "compliance", "data_loss", "timeline", "estimate"
    ],
    "enforcement_rules": {
      "pricing_fees": {
        "action": "cross_validate_2_sources",
        "citation_required": true
      },
      "platform_capabilities": {
        "action": "verify_with_mcp_tier_1_sources",
        "sources": ["shopify_dev", "official_docs"]
      }
    }
  }
}
```

### Enforcement Workflow

```
User asks: "What are Shopify transaction fees?"

1. Detect high-risk keyword: "fees"
2. Trigger enforcement rule: "cross_validate_2_sources"
3. Agent MUST:
   - Call shopify-dev-mcp for official pricing docs
   - Call firecrawl to scrape help.shopify.com/pricing
   - Cross-validate both sources
   - Quote exact text with URLs
   - Flag: "Verify current rates at [URL] as pricing may change"
4. Citation required: Include source URLs in response
```

---

## Scripts Reference

### validate-code.js

**Location**: `.claude/skills/validation-framework/scripts/validate-code.js`
**Language**: Node.js
**Purpose**: Validate code generation specifications before execution

**Input**:
```json
{
  "spec": "path/to/spec.json",
  "target": "staging",
  "check_secrets": true
}
```

**Output**:
```json
{
  "valid": boolean,
  "checks": { ... },
  "errors": [],
  "warnings": []
}
```

### validate-data.py

**Location**: `.claude/skills/validation-framework/scripts/validate-data.py`
**Language**: Python
**Purpose**: Validate data quality before migration

**Input**:
```bash
python validate-data.py --input products.json --type shopify_products --sample-size 1000
```

**Output**: JSON with validation results, errors, warnings, recommendations

### check-api-limits.sh

**Location**: `.claude/skills/validation-framework/scripts/check-api-limits.sh`
**Language**: Bash
**Purpose**: Verify API rate limits before bulk operations

**Input**:
```bash
bash check-api-limits.sh --api shopify --operation bulkProductCreate --count 5000
```

**Output**: Human-readable status report (safe/unsafe to proceed)

---

## Success Metrics

- **Ralph Wiggum Checks**: 100% triggered for high-risk actions
- **Pre-Execution Validation**: 95%+ of errors caught before execution
- **Post-Execution Validation**: 98%+ pass rate for deployed code
- **Rollback Triggers**: <5% false positives (rollback when not needed)
- **Zero Production Incidents**: No production issues from autonomous execution

---

## Version History

**v1.0** (2026-01-27): Initial validation-framework skill
- Ralph Wiggum comprehension check pattern
- Pre-execution validation (code, data, API limits)
- Post-execution validation (reconciliation, health checks)
- Rollback triggers (error rate, validation failure, critical errors)
- Anti-hallucination enforcement with MCP integration
- 3 validation scripts (validate-code.js, validate-data.py, check-api-limits.sh)

---

**End of Validation Framework Skill**
