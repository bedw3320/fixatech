# Shopify Agency Framework Architecture Optimization - Quick Start Guide

**Last Updated**: 2026-01-27
**Status**: Ready for Implementation
**Full Plan**: [/.claude/plans/cozy-seeking-breeze.md](/.claude/plans/cozy-seeking-breeze.md)

---

## Overview

This guide provides step-by-step instructions to transform Shopify Agency Framework from an advisory-only framework into a state-of-the-art autonomous execution system with proper guardrails.

**Key Goals**:
- ✅ Reduce agent context from ~5,000 → ~1,875 lines (62% reduction)
- ✅ Enable autonomous execution with safety guardrails
- ✅ Implement clean skills vs agents separation
- ✅ Add state persistence across sessions

**Timeline**: 8 weeks (+ 1-2 days for Phase 0 infrastructure)

---

## Implementation Sequence

```
Phase 0 (1-2 days) → Week 1-2 (Foundation) → Week 3-4 (Agents) → Week 5-6 (Execution) → Week 7-8 (Testing)
```

---

## Phase 0: Infrastructure Setup (1-2 Days)

**CRITICAL**: Complete this BEFORE starting Week 1 implementation.

### Checklist

#### A. MCP Server Configuration

**Goal**: Install and test all required MCPs

- [ ] Install shopify-dev-mcp
  ```bash
  npx @modelcontextprotocol/server-shopify-dev --version
  ```

- [ ] Install firecrawl (requires API key from firecrawl.dev)
  ```bash
  # Get API key from https://firecrawl.dev
  export FIRECRAWL_API_KEY="your-key-here"
  ```

- [ ] Install n8n-mcp
  ```bash
  npm install -g n8n-mcp
  n8n-mcp --version
  ```

- [ ] Install context7
  ```bash
  npx -y @context7/mcp --help
  ```

- [ ] Create `.claude/config/mcp-servers.json`
  ```bash
  mkdir -p .claude/config
  ```

- [ ] Configure MCP servers (copy configuration from plan)

- [ ] Test each MCP connection
  - [ ] Test shopify-dev-mcp: Try `learn_shopify_api(api="admin")`
  - [ ] Test firecrawl: Try scraping a simple URL
  - [ ] Test n8n-mcp: Try `list_nodes()`
  - [ ] Test context7: Try `resolve-library-id(libraryName="express")`

#### B. Reference Repositories Setup

**Goal**: Provide concrete examples for agents to reference

- [ ] Clone Shopify Dawn theme (Horizon theme if available)
  ```bash
  mkdir -p .claude/references
  git clone https://github.com/Shopify/dawn.git .claude/references/shopify-dawn-theme
  ```

- [ ] Create middleware template structure
  ```bash
  mkdir -p .claude/references/shopify-middleware-template/{src,tests}
  ```

- [ ] Document your agency's standard stack (optional)
  ```bash
  mkdir -p .claude/references/agency-stack
  # Add your preferred Express.js structure, Railway config, etc.
  ```

- [ ] Create `.claude/config/settings.json` with reference paths
  ```json
  {
    "reference_repos": {
      "shopify_theme": ".claude/references/shopify-dawn-theme",
      "middleware_template": ".claude/references/shopify-middleware-template",
      "agency_stack": ".claude/references/agency-stack"
    }
  }
  ```

#### C. Verification

- [ ] Test MCP tools are accessible from Claude Code
- [ ] Test agents can read reference repo files
- [ ] Document any issues encountered

**Completion Criteria**: All MCPs installed and tested, reference repos cloned and accessible.

---

## Week 1-2: Foundation (Critical Path)

**Goal**: Create core infrastructure for autonomous execution with guardrails

### Day 1-2: Create Directory Structure

- [ ] Create new directory structure
  ```bash
  mkdir -p .claude/agents/{core,specialists}
  mkdir -p .claude/config
  mkdir -p .claude/skills/{validation-framework,code-generator,platform-knowledge,deployment-automation}/{scripts,templates,references}
  mkdir -p .claude/state/{sessions,projects}
  mkdir -p .claude/knowledge/learnings
  mkdir -p .claude/docs/{architecture,runbooks,templates}
  ```

- [ ] Move existing agents to temporary backup
  ```bash
  mkdir -p .claude/agents/_backup
  cp .claude/agents/*.md .claude/agents/_backup/
  ```

### Day 3-5: Create Configuration Files

#### permissions.json
- [ ] Create `.claude/config/permissions.json`
- [ ] Define tier_1_auto_execute (read-only operations)
- [ ] Define tier_2_auto_execute_staging (staging deployments)
- [ ] Define tier_3_approval_required (production operations)
- [ ] Define tier_4_prohibited (never autonomous)

**Template**:
```json
{
  "tier_1_auto_execute": {
    "description": "Safe, read-only operations",
    "allowed": ["mcp_calls", "read_files", "documentation_generation", "validation_checks"]
  },
  "tier_2_auto_execute_staging": {
    "description": "Write operations in staging/dev only",
    "allowed": ["code_generation", "staging_deployment", "test_execution", "pr_creation"],
    "restrictions": {
      "branch_pattern": "^(feature/|staging/|dev/)",
      "deployment_target": "staging",
      "requires_validation": true
    }
  },
  "tier_3_approval_required": {
    "description": "Production deployments",
    "requires_approval": ["production_deployment", "dns_changes", "data_deletion"]
  },
  "tier_4_prohibited": {
    "description": "Never autonomous",
    "prohibited": ["force_push_main", "delete_production_data", "bypass_security"]
  }
}
```

#### guardrails.json
- [ ] Create `.claude/config/guardrails.json`
- [ ] Define Ralph Wiggum comprehension check triggers
- [ ] Define pre_execution_gates for code generation, data migration, deployment
- [ ] Define execution_monitoring thresholds
- [ ] Define post_execution_validation checks
- [ ] Define rollback_triggers

**Template**:
```json
{
  "ralph_wiggum_triggers": {
    "description": "Comprehension check before high-risk actions",
    "enabled": true,
    "required_for": [
      "code_generation",
      "architecture_design",
      "data_migration",
      "discovery_framework"
    ],
    "pattern": "Before {action}, explain understanding and wait for confirmation"
  },
  "pre_execution_gates": {
    "code_generation": {
      "checks": [
        "ralph_wiggum_comprehension_check",
        "spec_complete",
        "no_secrets",
        "staging_target"
      ],
      "pass_threshold": 1.0
    }
  },
  "execution_monitoring": {
    "api_rate_limit_threshold": 0.8,
    "error_rate_threshold": 0.05,
    "rollback_error_rate": 0.10
  }
}
```

#### agent-routing.json
- [ ] Create `.claude/config/agent-routing.json`
- [ ] Extract routing rules from current orchestrator.md
- [ ] Define keyword → agent mappings
- [ ] Define confidence scores
- [ ] Set fallback_agent

**Template**:
```json
{
  "routing_rules": [
    {
      "keywords": ["discovery", "requirements", "stakeholder"],
      "agent": "discovery-analyst",
      "confidence": 0.9
    },
    {
      "keywords": ["architecture", "technical design", "integration"],
      "agent": "platform-architect",
      "confidence": 0.9
    },
    {
      "keywords": ["code", "middleware", "generate", "build"],
      "agent": "implementation-engineer",
      "confidence": 0.9
    },
    {
      "keywords": ["test", "validate", "deploy", "quality"],
      "agent": "quality-validator",
      "confidence": 0.9
    }
  ],
  "fallback_agent": "orchestrator"
}
```

### Day 6-8: Create validation-framework Skill

- [ ] Create `.claude/skills/validation-framework/SKILL.md` (400-500 lines)
- [ ] Document pre-execution validation patterns
- [ ] Document post-execution reconciliation
- [ ] Document Ralph Wiggum comprehension check implementation

#### Scripts (Priority Order)
- [ ] Create `validate-code.js` (linting, testing, security checks)
  ```bash
  touch .claude/skills/validation-framework/scripts/validate-code.js
  chmod +x .claude/skills/validation-framework/scripts/validate-code.js
  ```

- [ ] Create `validate-data.py` (pre-migration data checks)
  ```bash
  touch .claude/skills/validation-framework/scripts/validate-data.py
  chmod +x .claude/skills/validation-framework/scripts/validate-data.py
  ```

- [ ] Create `check-api-limits.sh` (rate limit verification)
  ```bash
  touch .claude/skills/validation-framework/scripts/check-api-limits.sh
  chmod +x .claude/skills/validation-framework/scripts/check-api-limits.sh
  ```

#### Test Templates
- [ ] Create `unit-test.template.js`
- [ ] Create `integration-test.template.js`

### Day 9-10: Refactor Orchestrator

- [ ] Create `.claude/agents/core/orchestrator.md` (200-250 lines)
- [ ] Extract anti-hallucination principles → move to validation-framework skill
- [ ] Extract response format guidelines → move to `.claude/docs/communication-standards.md`
- [ ] Extract value-based pricing → move to cost-estimator skill (later)
- [ ] Keep: routing logic (reference agent-routing.json)
- [ ] Keep: high-risk query detection keywords
- [ ] Keep: handoff protocols
- [ ] Add: Ralph Wiggum comprehension check section
- [ ] Add: reference to permissions.json and guardrails.json

**Validation**:
- [ ] Line count: 200-250 lines ✓
- [ ] No domain expertise (delegated to specialists) ✓
- [ ] References config files (not hardcoded logic) ✓

### Week 1-2 Completion Checklist

- [ ] `.claude/config/permissions.json` created and complete
- [ ] `.claude/config/guardrails.json` created and complete
- [ ] `.claude/config/agent-routing.json` created and complete
- [ ] validation-framework skill created with SKILL.md + 3 scripts
- [ ] orchestrator.md refactored to 200-250 lines
- [ ] All extracted content moved to appropriate skills/docs
- [ ] Git commit: "feat: add autonomous execution infrastructure"

**Success Metric**: Foundation in place for autonomous execution with guardrails.

---

## Week 3-4: Agent Optimization

**Goal**: Consolidate agents, reduce context size from ~5,000 → ~1,875 lines

### Day 1-3: Extract Content from Shopify Architect

**Current**: 893 lines → **Target**: 400-450 lines

- [ ] Read `.claude/agents/shopify-architect.md` in full
- [ ] Create extraction plan (what goes to skills, what stays)

#### Extract to Skills
- [ ] Solution hierarchy examples → `.claude/skills/platform-knowledge/shopify-patterns.md`
- [ ] App Store search protocol → `.claude/skills/platform-knowledge/app-search-guide.md`
- [ ] Migration strategy patterns → `.claude/skills/migration-methodology/cutover-strategies.md`
- [ ] Integration architecture patterns → `.claude/skills/integration-patterns/sync-strategies.md`
- [ ] Platform research workflow → `.claude/skills/platform-knowledge/shopify-api-research.md`

#### Create New Agent
- [ ] Create `.claude/agents/core/platform-architect.md` (400-450 lines)
- [ ] Keep: decision-making logic, technical feasibility assessment, app evaluation
- [ ] Add: references to platform-knowledge skill for detailed patterns
- [ ] Add: Ralph Wiggum comprehension check for architecture design

**Validation**:
- [ ] Line count: 400-450 lines ✓
- [ ] Decision logic intact, examples moved to skills ✓

### Day 4-6: Split Data Migration Engineer

**Current**: 804 lines → **Target**: Split into two agents (400-450 lines each)

#### Create implementation-engineer.md
- [ ] Create `.claude/agents/core/implementation-engineer.md` (400-450 lines)
- [ ] Responsibilities: Code generation, middleware deployment, integration implementation, autonomous execution
- [ ] Extract: ETL workflow design → keep core, move examples to skills
- [ ] Add: Autonomous execution capabilities with pre/post validation gates
- [ ] Add: Ralph Wiggum comprehension check for code generation

#### Create quality-validator.md
- [ ] Create `.claude/agents/core/quality-validator.md` (350-400 lines)
- [ ] Responsibilities: Pre-deployment validation, code quality, integration testing, deployment verification, rollback triggers
- [ ] Extract: Validation framework sections from data-migration-engineer.md
- [ ] Add: Automated quality gates
- [ ] Add: Monitoring and alerting patterns

### Day 7-9: Consolidate Discovery-Lead

**Current**: discovery-lead.md → **Target**: discovery-analyst.md (350-400 lines)

- [ ] Create `.claude/agents/core/discovery-analyst.md` (350-400 lines)
- [ ] Remove: Redundant methodologies (move to migration-methodology skill)
- [ ] Keep: Interactive discovery workflows, stakeholder management
- [ ] Add: Ralph Wiggum comprehension check for discovery framework

### Day 10: Extract Specialists (On-Demand Loading)

- [ ] Move integration-specialist.md → `.claude/agents/specialists/integration-researcher.md` (300-400 lines)
- [ ] Move theme-developer.md → `.claude/agents/specialists/theme-specialist.md` (300-400 lines)
- [ ] Move launch-coordinator.md → `.claude/agents/specialists/launch-manager.md` (300-400 lines)
- [ ] Update orchestrator routing to only load specialists when keywords match

### Week 3-4 Completion Checklist

- [ ] 5 core agents created in `.claude/agents/core/` (all 350-450 lines)
  - [ ] orchestrator.md (200-250 lines)
  - [ ] discovery-analyst.md (350-400 lines)
  - [ ] platform-architect.md (400-450 lines)
  - [ ] implementation-engineer.md (400-450 lines)
  - [ ] quality-validator.md (350-400 lines)

- [ ] 3 specialist agents in `.claude/agents/specialists/` (all 300-400 lines)
  - [ ] integration-researcher.md
  - [ ] theme-specialist.md
  - [ ] launch-manager.md

- [ ] Platform-knowledge skill created with extracted content
- [ ] Baseline context: ~1,875 lines (5 core agents)
- [ ] Git commit: "feat: consolidate agents, reduce context by 62%"

**Validation**:
```bash
# Verify line counts
wc -l .claude/agents/core/*.md
# Total should be ~1,875 lines (down from ~5,000)
```

**Success Metric**: 62% reduction in baseline context size.

---

## Week 5-6: Execution & Deployment

**Goal**: Enable autonomous code generation, validation, and staging deployment

### Day 1-4: Create code-generator Skill

- [ ] Create `.claude/skills/code-generator/SKILL.md` (300-400 lines)
- [ ] Document code generation patterns
- [ ] Document template usage workflow
- [ ] Document field mapping automation

#### Scripts (Priority Order)
- [ ] Create `generate-middleware.py`
  - Field mappings generation
  - API client scaffolding
  - Input: Source/target systems, data types
  - Output: Complete middleware codebase

- [ ] Create `generate-field-mappings.js`
  - Data transformation templates
  - Input: Source/target field specs
  - Output: Mapping JSON + transformation functions

- [ ] Create `deploy-to-staging.sh`
  - Deployment automation (Railway/Vercel)
  - Environment variable setup
  - Health check verification

#### Templates
- [ ] Create `node-express-middleware.js` template
- [ ] Create `python-etl-script.py` template
- [ ] Create `docker-compose.yml` template

### Day 5-8: Create deployment-automation Skill

- [ ] Create `.claude/skills/deployment-automation/SKILL.md` (300-400 lines)
- [ ] Document deployment workflows
- [ ] Document rollback procedures
- [ ] Document CI/CD integration patterns

#### Scripts (Priority Order)
- [ ] Create `deploy-shopify.sh`
  - Shopify CLI automation
  - Theme deployment to dev store
  - Verification checks

- [ ] Create `deploy-middleware.sh`
  - Railway/Vercel deployment
  - Environment config
  - Database migration execution
  - Health check verification

- [ ] Create `rollback.sh`
  - Automated rollback triggers
  - Git revert procedures
  - State restoration
  - Notification/alerting

#### Templates
- [ ] Create `github-actions-workflow.yml` for CI/CD
- [ ] Create `railway.json` for Railway deployments
- [ ] Create `vercel.json` for Vercel deployments

### Day 9-10: State Management Implementation

#### Session Persistence
- [ ] Create `.claude/state/sessions/current-session.json` template
- [ ] Document session state structure in implementation-engineer.md
- [ ] Add git hooks to commit state after significant actions

**Template**:
```json
{
  "session_id": "uuid",
  "created_at": "ISO 8601",
  "last_updated": "ISO 8601",
  "current_phase": "discovery|architecture|implementation|validation|launch",
  "active_agent": "agent-name",
  "conversation_history": [],
  "decisions_made": [],
  "artifacts_generated": []
}
```

#### Project State Tracking
- [ ] Create `.claude/state/projects/{project-id}/project-metadata.json` template
- [ ] Document project state structure

#### Cross-Project Learning
- [ ] Create `.claude/knowledge/learnings/patterns.json` template
- [ ] Document pattern capture workflow
- [ ] Create `.claude/knowledge/learnings/anti-patterns.json` template
- [ ] Create `.claude/knowledge/learnings/vendor-quirks.json` template

### Week 5-6 Completion Checklist

- [ ] code-generator skill complete with 3 scripts + 3 templates
- [ ] deployment-automation skill complete with 3 scripts + 3 templates
- [ ] State management system implemented (sessions, projects, learnings)
- [ ] Autonomous execution enabled for tier 2 operations (staging only)
- [ ] Git commit: "feat: enable autonomous code generation and deployment"

**Success Metric**: Can autonomously generate middleware code, validate, and deploy to staging.

---

## Week 7-8: Testing & Validation

**Goal**: Comprehensive testing and pilot project

### Day 1-3: Build Test Suite

#### Unit Tests
- [ ] Test validation-framework scripts
  - [ ] `validate-code.js` unit tests
  - [ ] `validate-data.py` unit tests
  - [ ] `check-api-limits.sh` unit tests

- [ ] Test code-generator scripts
  - [ ] `generate-middleware.py` unit tests
  - [ ] `generate-field-mappings.js` unit tests

- [ ] Test deployment-automation scripts
  - [ ] `deploy-shopify.sh` unit tests
  - [ ] `deploy-middleware.sh` unit tests
  - [ ] `rollback.sh` unit tests

#### Integration Tests
- [ ] Test agent routing (orchestrator → specialist agents)
- [ ] Test Ralph Wiggum comprehension checks trigger correctly
- [ ] Test autonomous execution flow (code gen → validate → deploy → verify)
- [ ] Test rollback procedures (error rate threshold → automatic rollback)

#### End-to-End Tests
- [ ] Test: Discovery → Architecture → Implementation → Validation → Launch
- [ ] Test: State persistence across sessions (exit/resume conversation)
- [ ] Test: MCP integration (shopify-dev-mcp, firecrawl, n8n-mcp, context7)
- [ ] Test: Reference repo usage (theme-specialist reads Horizon theme)

### Day 4-6: Run Test Scenarios

#### Scenario 1: Simple Code Generation
- [ ] Request: "Generate middleware for WooCommerce → Shopify product sync"
- [ ] Verify: Ralph Wiggum comprehension check triggered
- [ ] Verify: code-generator skill invoked
- [ ] Verify: Code generated using templates
- [ ] Verify: validation-framework checks pass
- [ ] Verify: Deploy to staging successful

#### Scenario 2: Complex Architecture Design
- [ ] Request: "Design integration for Shopify + NetSuite + Akeneo PIM"
- [ ] Verify: Ralph Wiggum comprehension check triggered
- [ ] Verify: platform-architect agent handles (not specialist)
- [ ] Verify: References platform-knowledge skill
- [ ] Verify: MCP calls made (shopify-dev-mcp for capabilities)

#### Scenario 3: State Persistence
- [ ] Start discovery phase for new project
- [ ] Exit conversation mid-discovery
- [ ] Resume conversation
- [ ] Verify: State loaded from `.claude/state/sessions/current-session.json`
- [ ] Verify: Context restored ("You were in discovery, working on...")

### Day 7-10: Pilot Project

- [ ] Select non-critical migration project (or create test project)
- [ ] Run complete migration workflow using new architecture
- [ ] Document issues encountered
- [ ] Document learnings
- [ ] Refine guardrails based on pilot results
- [ ] Update agent boundaries if needed

### Week 7-8 Completion Checklist

- [ ] All unit tests passing
- [ ] All integration tests passing
- [ ] All end-to-end tests passing
- [ ] Test scenarios completed successfully
- [ ] Pilot project completed
- [ ] Issues documented and resolved
- [ ] Architecture refinements made based on pilot
- [ ] Git commit: "test: comprehensive testing and pilot project complete"

**Success Metric**: Pilot project completed successfully with autonomous execution.

---

## Final Verification

### Agent Size Validation
```bash
# Before: ~5,000 lines
# After: ~1,875 lines (62% reduction)
wc -l .claude/agents/core/*.md

# Expected output:
# 225 orchestrator.md (target: 200-250)
# 375 discovery-analyst.md (target: 350-400)
# 425 platform-architect.md (target: 400-450)
# 425 implementation-engineer.md (target: 400-450)
# 375 quality-validator.md (target: 350-400)
# 1825 total
```

### Success Metrics Checklist

- [ ] **Agent Size**: Baseline context reduced from ~5,000 → ~1,875 lines (62% reduction) ✓
- [ ] **Autonomous Execution**: 80%+ of code generation, validation, and staging deployments fully autonomous ✓
- [ ] **Safety**: Zero production incidents from autonomous execution (guardrails working) ✓
- [ ] **State Persistence**: 100% of sessions can resume from previous state ✓
- [ ] **Skills Invocation**: Clear separation - 6 skills implemented with executable scripts ✓

### Skills Implemented Checklist

- [ ] validation-framework (SKILL.md + 3 scripts + 2 test templates)
- [ ] code-generator (SKILL.md + 3 scripts + 3 code templates)
- [ ] deployment-automation (SKILL.md + 3 scripts + 3 deployment templates)
- [ ] platform-knowledge (SKILL.md + 7 reference docs)
- [ ] mcp-integration (SKILL.md enhanced with failure handling)
- [ ] cost-estimator (extracted from orchestrator, SKILL.md)

### Configuration Files Created

- [ ] `.claude/config/permissions.json`
- [ ] `.claude/config/guardrails.json`
- [ ] `.claude/config/agent-routing.json`
- [ ] `.claude/config/settings.json` (with reference_repos)
- [ ] `.claude/config/mcp-servers.json`

---

## Troubleshooting

### Issue: MCP not connecting
**Solution**: Verify MCP installed correctly, check `mcp-servers.json` configuration, test with `npx @modelcontextprotocol/server-shopify-dev`

### Issue: Agent still too large (>450 lines)
**Solution**: Extract more examples to skills, keep only decision logic in agent, move detailed patterns to platform-knowledge skill

### Issue: Autonomous execution not triggering
**Solution**: Check permissions.json tier definitions, verify guardrails.json pre-execution gates, ensure validation-framework skill is accessible

### Issue: State not persisting
**Solution**: Check `.claude/state/sessions/` directory exists, verify git hooks configured, check session.json write permissions

### Issue: Ralph Wiggum checks not triggering
**Solution**: Verify guardrails.json has `ralph_wiggum_triggers.enabled: true`, check orchestrator.md has Ralph Wiggum section, verify task type matches `required_for` list

---

## Documentation

### Created Documents
- [/.claude/plans/cozy-seeking-breeze.md](/.claude/plans/cozy-seeking-breeze.md) - Full architectural plan
- [/.claude/docs/QUICK-START-GUIDE.md](/.claude/docs/QUICK-START-GUIDE.md) - This guide
- `.claude/docs/communication-standards.md` - Response format guidelines (Week 1-2)
- `.claude/docs/architecture/migration-guide.md` - Architecture migration notes (Week 7-8)

### Runbooks to Create
- `.claude/docs/runbooks/deployment-procedures.md` - Step-by-step deployment guide
- `.claude/docs/runbooks/rollback-procedures.md` - Emergency rollback procedures
- `.claude/docs/runbooks/troubleshooting.md` - Common issues and solutions

### Templates to Create
- `.claude/docs/templates/agent-template.md` - Template for creating new agents
- `.claude/docs/templates/skill-template.md` - Template for creating new skills
- `.claude/docs/templates/project-brief-template.md` - Template for new migration projects

---

## Next Steps

After completing all phases:

1. **Archive Old Agents**
   ```bash
   mv .claude/agents/_backup .claude/agents/_archived_v1
   git add .claude/agents/_archived_v1
   git commit -m "chore: archive v1 agents"
   ```

2. **Update README**
   - Document new architecture
   - Add setup instructions for MCPs
   - Add usage examples with Ralph Wiggum technique

3. **Share with Team**
   - Walkthrough of new architecture
   - Demo autonomous execution with guardrails
   - Training on Ralph Wiggum technique

4. **Continuous Improvement**
   - Capture learnings in `.claude/knowledge/learnings/`
   - Refine agent boundaries based on usage
   - Optimize guardrails based on real-world usage

---

## Support

- **Full Plan**: [/.claude/plans/cozy-seeking-breeze.md](/.claude/plans/cozy-seeking-breeze.md)
- **Questions**: Document in `.claude/docs/architecture/questions.md`
- **Issues**: Create GitHub issues or document in project tracker

**Last Updated**: 2026-01-27
