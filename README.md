# Shopify Agency Framework

**Multi-agent AI framework for Shopify migration and integration projects**

A production-ready Claude Code framework with specialized agents, MCP servers, reference repositories, and automation tools for building Shopify ecommerce solutions.

[![Phase 0](https://img.shields.io/badge/Phase_0-Complete-brightgreen)](.claude/docs/PHASE-0-INFRASTRUCTURE-SETUP.md)
[![MCPs](https://img.shields.io/badge/MCPs-4%2F4_Configured-blue)](.claude/settings.json)
[![Agents](https://img.shields.io/badge/Agents-8_Specialized-orange)](.claude/agents/)
[![Framework](https://img.shields.io/badge/Framework-v1.0.0-purple)]()

---

## 🎯 What Is This?

This framework provides a complete AI-powered development environment for Shopify agencies and freelancers. It includes:

- **8 Specialized AI Agents** for discovery, architecture, development, theme customization, and launch
- **4 Pre-configured MCP Servers** (✅ ALL TESTED) for Shopify API validation, workflow automation, library docs, and web scraping
- **Official Shopify Theme References** (Horizon PRIMARY + Dawn secondary) for Liquid development
- **Middleware Templates** for Express.js integrations with external systems
- **Ralph Loop Plugin** for iterative development with self-correction
- **Validation Framework** with pre/post-execution checks and anti-hallucination enforcement
- **Complete Configuration** with routing, guardrails, and safety gates

**Status:** Phase 0 infrastructure complete. Ready for production work.

---

## 🚀 Quick Start

### Prerequisites

- [Claude Code CLI](https://github.com/anthropics/claude-code) installed
- Node.js 18+ and npm
- Git configured with GitHub access
- Anthropic API key with Claude access

### Installation

```bash
# Clone this template repository
git clone https://github.com/bedw3320/shopify-agency-framework.git
cd shopify-agency-framework

# Verify Phase 0 completion
cat .claude/settings.json | grep "phase_0_complete"
# Should show: "phase_0_complete": true

# Start Claude Code
claude
```

### Your First Project

```bash
# Test MCP servers
"Use shopify-dev-mcp to introspect the Product object"
"Use firecrawl to scrape https://shopify.dev/docs/api"

# Test agent routing
"I need to migrate from Magento to Shopify Plus"
# Routes to → discovery-lead and shopify-architect

# Generate middleware
"Build Express middleware for NetSuite product sync"
# Routes to → data-migration-engineer → code-generator skill

# Customize theme
"Add product comparison feature using Horizon theme"
# Routes to → theme-developer (uses Horizon as primary reference)
```

---

## 📁 Project Structure

```
shopify-agency-framework/
├── .claude/
│   ├── agents/               # 8 specialized agents
│   │   ├── orchestrator.md
│   │   ├── discovery-lead.md
│   │   ├── shopify-architect.md
│   │   ├── data-migration-engineer.md
│   │   ├── theme-developer.md
│   │   ├── integration-specialist.md
│   │   └── launch-coordinator.md
│   ├── config/               # Framework configuration
│   │   ├── agent-routing.json
│   │   ├── guardrails.json
│   │   └── permissions.json
│   ├── docs/                 # Implementation guides
│   │   ├── PHASE-0-INFRASTRUCTURE-SETUP.md
│   │   └── QUICK-START-GUIDE.md
│   ├── knowledge/            # Domain knowledge base
│   ├── references/           # Reference repositories ✅
│   │   ├── shopify-horizon-theme/    # PRIMARY theme reference
│   │   ├── shopify-dawn-theme/       # SECONDARY theme reference
│   │   └── shopify-middleware-template/  # Express.js integration template
│   ├── skills/               # Specialized skills
│   │   ├── code-generator.md
│   │   ├── validation-framework.md
│   │   ├── mcp-integration.md
│   │   └── agent-identifier.md
│   └── settings.json         # Infrastructure configuration ✅
└── README.md
```

---

## 🤖 Specialized Agents

### **Orchestrator** (Always Active)
Universal routing, guardrails, and coordination for ecommerce migration projects. Enforces safety gates, routes to specialists, and maintains core principles.

### **Discovery Lead**
Requirements gathering, stakeholder mapping, discovery frameworks, current state assessment, gap analysis for ecommerce migrations.

### **Shopify Architect**
Migration strategy design, Shopify platform expertise, integration architecture, technical feasibility analysis, app recommendations, API research.

### **Data Migration Engineer**
Data mapping, ETL logic, field transformation, middleware code generation, API integration code, data validation for ecommerce migrations.

### **Theme Developer**
Shopify Liquid expertise (Horizon theme primary), storefront features, component development, theme customization and optimization.

### **Integration Specialist**
ERP/PIM/OMS expertise (NetSuite, SAP, Dynamics), third-party system research, authentication patterns, API documentation analysis.

### **Launch Coordinator**
Cutover planning, go-live readiness, DNS configuration, rollback procedures, post-launch monitoring and support.

---

## 🔌 MCP Servers (All Configured ✅)

### **shopify-dev-mcp** ✅ Tested
- Official Shopify developer documentation
- GraphQL schema introspection and validation
- Component and theme code validation
- Liquid template validation
- **Command**: `npx @modelcontextprotocol/server-shopify-dev`

### **n8n-mcp** ✅ Tested
- 525 workflow automation nodes
- Shopify integration patterns
- Node configuration and validation
- AI tool integration
- **Command**: `n8n-mcp`

### **context7** ✅ Tested
- 1000+ library documentation sources
- Express, React, Node.js, TypeScript docs
- Up-to-date code examples
- **Command**: `npx -y @context7/mcp`

### **firecrawl** ✅ Tested
- Web scraping for external API docs
- Crawling and content extraction
- External system research (NetSuite, SAP, etc.)
- **Command**: `npx -y firecrawl-mcp`
- **Requires**: `FIRECRAWL_API_KEY` environment variable

---

## 🛡️ Safety & Validation

### Anti-Hallucination Enforcement
- **ALL** GraphQL queries validated via `shopify-dev-mcp` before execution
- **ALL** Liquid code validated via `validate_theme` tool
- **ALL** Polaris components validated via `validate_component_codeblocks`
- **NO** code generation without MCP verification
- **Citations required** for all external documentation references

### Ralph Loop Plugin ✅ Installed
Iterative development methodology with self-correction:

```bash
# Start iterative development loop
/ralph-loop "Build NetSuite middleware" --max-iterations 15 --completion-promise "COMPLETE"

# Signal completion in your response
<promise>COMPLETE</promise>

# Cancel active loop
/cancel-ralph
```

**How it works:**
1. Same prompt repeated each iteration
2. Claude sees its previous work in files/git history
3. Iteratively improves until completion or max iterations
4. Self-corrects based on validation failures

### Validation Framework Skill
- Pre-execution validation and comprehension checks
- Post-execution reconciliation (data counts, error rates)
- Automated quality gates for safe autonomous execution
- Ralph Wiggum technique for preventing hallucinated implementations

---

## 📚 Reference Materials

### **Shopify Horizon Theme** (PRIMARY) ✅
- Latest official Shopify theme
- **Default reference for ALL theme development**
- Modern section architecture and component patterns
- Located at: `.claude/references/shopify-horizon-theme/`

### **Shopify Dawn Theme** (SECONDARY) ✅
- Legacy reference theme
- **Use ONLY when Horizon lacks specific pattern**
- Fallback for older pattern examples
- Located at: `.claude/references/shopify-dawn-theme/`

### **Middleware Template** ✅
- Express.js server structure with TypeScript support
- Webhook handlers and GraphQL client setup
- Job scheduling with node-cron
- Field mapping patterns and transformations
- Docker deployment configuration
- Integration tests for Shopify API
- Located at: `.claude/references/shopify-middleware-template/`

---

## 🎓 Usage Examples

### Migration Discovery
```
"I need to migrate a custom ecommerce site with 10,000 products
and 50,000 customers from Magento 2 to Shopify Plus.
Help me create a discovery framework."
```
→ Routes to **discovery-lead** agent
→ Creates structured questionnaire for stakeholder interviews
→ Identifies data sources, integrations, and custom features

### Architecture Design
```
"Design an integration architecture for real-time product sync
between Shopify and NetSuite with bi-directional inventory updates."
```
→ Routes to **shopify-architect** agent
→ Uses **shopify-dev-mcp** for API research
→ Uses **firecrawl** for NetSuite API documentation
→ Designs webhook-based architecture with fallback polling

### Middleware Development
```
"Generate Express.js middleware for handling Shopify order webhooks
and syncing to our ERP system with retry logic and dead letter queue."
```
→ Routes to **data-migration-engineer** agent
→ Invokes **code-generator** skill
→ Uses middleware template from `.claude/references/`
→ Validates with **validation-framework**
→ Generates complete Express app with tests

### Theme Customization
```
"Add a product comparison feature to the Shopify storefront
using Liquid and following Horizon theme patterns."
```
→ Routes to **theme-developer** agent
→ Reads Horizon theme reference (primary)
→ Validates Liquid code with **shopify-dev-mcp**
→ Creates section, snippet, and JavaScript module

### Launch Planning
```
"Create a cutover plan for migrating from BigCommerce to Shopify
during Black Friday week with zero-downtime requirements."
```
→ Routes to **launch-coordinator** agent
→ Creates phased cutover plan with DNS strategy
→ Defines rollback triggers and monitoring
→ Schedules blackout windows and team assignments

---

## 🔧 Configuration

### MCP Server Configuration
All MCP configurations are in your Claude Code config:
```json
{
  "mcpServers": {
    "shopify-dev-mcp": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-shopify-dev"]
    },
    "n8n-mcp": {
      "command": "n8n-mcp"
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp"]
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "your-api-key"
      }
    }
  }
}
```

### Framework Settings
Edit [.claude/settings.json](.claude/settings.json) to:
- Track infrastructure status
- Configure MCP usage policies
- Document verification tests
- Manage agent routing preferences

### Guardrails
Edit [.claude/config/guardrails.json](.claude/config/guardrails.json) to:
- Add safety checks before risky operations
- Configure validation thresholds
- Set anti-hallucination policies

### Routing
Edit [.claude/config/agent-routing.json](.claude/config/agent-routing.json) to:
- Configure agent selection keywords
- Set agent priorities
- Define fallback behaviors

---

## 📖 Documentation

- **[Phase 0 Setup Guide](.claude/docs/PHASE-0-INFRASTRUCTURE-SETUP.md)** - Infrastructure setup and verification (✅ COMPLETE)
- **[Quick Start Guide](.claude/docs/QUICK-START-GUIDE.md)** - 8-week optimization roadmap
- **[Maintenance Guide](.claude/docs/MAINTENANCE.md)** - Keeping references fresh and up-to-date
- **[Agent Routing Logic](.claude/config/agent-routing.json)** - How agents are selected
- **[Permissions & Safety](.claude/config/permissions.json)** - Allowed operations
- **[Guardrails](.claude/config/guardrails.json)** - Safety gates and validation rules
- **[Communication Standards](.claude/docs/communication-standards.md)** - Response formats and tone

---

## 🔄 Keeping References Fresh

Shopify updates Horizon and Dawn themes regularly. Keep your framework current:

### Automated Update (Recommended)
```bash
# Run weekly or before starting new projects
.claude/scripts/update-references.sh
```

### What Gets Updated
- ✅ Shopify Horizon Theme (latest patterns and components)
- ✅ Shopify Dawn Theme (fallback patterns)
- 📊 Shows commit hashes before/after update

### Update Schedule
- **Weekly**: Best for active development (every Monday)
- **Before new projects**: Always update before creating client projects
- **After Shopify releases**: Check [shopify.dev/changelog](https://shopify.dev/changelog)

### GitHub Notifications
Watch repos for updates:
- [Shopify Horizon](https://github.com/Shopify/horizon) - Click "Watch" → "Releases"
- [Shopify Dawn](https://github.com/Shopify/dawn) - Click "Watch" → "Releases"

**Full details**: See [MAINTENANCE.md](.claude/docs/MAINTENANCE.md)

---

## 🏗️ Creating Projects from This Template

### Option 1: GitHub Template (Recommended)

1. **Make this a template repo** on GitHub:
   - Settings → Template repository → Check the box
2. **Create new project**: Click "Use this template" button
3. **Clone locally**:
   ```bash
   cd ~/Documents/GitHub\ Projects
   git clone https://github.com/YOUR_USERNAME/client-project-name.git
   cd client-project-name
   ```
4. **Add template remote** (for future framework updates):
   ```bash
   git remote add template https://github.com/bedw3320/shopify-agency-framework.git
   git fetch template
   ```
5. **Clone reference themes**:
   ```bash
   git clone https://github.com/Shopify/horizon.git .claude/references/shopify-horizon-theme
   git clone https://github.com/Shopify/dawn.git .claude/references/shopify-dawn-theme
   ```

### Option 2: Manual Clone

```bash
cd ~/Documents/GitHub\ Projects
git clone https://github.com/bedw3320/shopify-agency-framework.git client-project-name
cd client-project-name
rm -rf .git
git init
git add .
git commit -m "Initial commit from shopify-agency-framework template"
git remote add origin https://github.com/YOUR_USERNAME/client-project-name.git
git push -u origin main

# Add template remote for future updates
git remote add template https://github.com/bedw3320/shopify-agency-framework.git
git fetch template
```

---

## 🔄 Syncing Framework Updates to Client Projects

Once you've created client projects, you can sync framework improvements back to them:

### Quick Sync
```bash
# From any client project
cd ~/Documents/GitHub\ Projects/client-project-name
.claude/scripts/sync-framework-updates.sh
```

### What Gets Updated
- ✅ **Agents**: New or improved agent definitions
- ✅ **Config**: Routing, guardrails, permissions improvements
- ✅ **Skills**: New reusable skills and capabilities
- ✅ **Scripts**: Automation and maintenance scripts
- ✅ **Docs**: Updated documentation and guides

### What's Preserved
- ⚠️ **Client Data**: `.claude/state/`, `.claude/knowledge/`, `.claude/plans/`
- ⚠️ **Project Settings**: Client-specific `settings.json` entries
- ⚠️ **Theme References**: Locally cloned Horizon and Dawn themes

### Sync Schedule
- **Monthly**: Best balance of staying current without constant changes
- **After major improvements**: When you enhance the template significantly
- **Before milestones**: 1 week before go-live to ensure latest safety features

**Full details**: See [SYNCING-FRAMEWORK-UPDATES.md](.claude/docs/SYNCING-FRAMEWORK-UPDATES.md)

---

## 🧪 Verification Tests

### MCP Servers
```bash
# Verify all 4 MCPs are working
"Use shopify-dev-mcp to introspect the Product object"
"Use n8n-mcp to list 5 Shopify nodes"
"Use context7 to find Express.js routing docs"
"Use firecrawl to scrape https://shopify.dev/docs/api"
```

### Agent Routing
```bash
"I need architecture help for a Shopify Plus migration"
# Should route to → shopify-architect

"How do I customize the Horizon theme's product page?"
# Should route to → theme-developer (uses Horizon primary)

"Build middleware for NetSuite product sync"
# Should route to → data-migration-engineer → code-generator
```

### Validation
```bash
"Generate a GraphQL query to fetch products with variants"
# Should automatically validate using shopify-dev-mcp

"Create a Liquid section for featured products"
# Should automatically validate using validate_theme
```

---

## 🤝 Contributing

This is a personal agency framework template. To customize for your agency:

1. **Add your standards** to `.claude/references/agency-stack/`
2. **Customize agents** in `.claude/agents/` to match your workflow
3. **Update guardrails** in `.claude/config/guardrails.json` for your risk tolerance
4. **Document your stack** in `.claude/knowledge/`

---

## 📝 License

MIT License - See [LICENSE](LICENSE) for details

---

## 🔗 Resources

- **Claude Code**: https://github.com/anthropics/claude-code
- **Shopify Developer Docs**: https://shopify.dev
- **Ralph Loop Technique**: https://ghuntley.com/ralph/
- **MCP Protocol**: https://modelcontextprotocol.io
- **Shopify Horizon Theme**: https://github.com/Shopify/horizon
- **Shopify Dawn Theme**: https://github.com/Shopify/dawn
- **n8n Workflow Automation**: https://n8n.io
- **Firecrawl**: https://firecrawl.dev
- **Context7**: https://context7.com

---

## 📊 Infrastructure Status

**Phase 0 Completion**: ✅ January 27, 2026

| Component | Status | Details |
|-----------|--------|---------|
| **MCP Servers** | ✅ 4/4 Configured | shopify-dev-mcp, n8n-mcp, context7, firecrawl |
| **Reference Repos** | ✅ 3/3 Ready | Horizon (primary), Dawn (secondary), Middleware Template |
| **Agents** | ✅ 8/8 Configured | orchestrator, discovery-lead, shopify-architect, data-migration-engineer, theme-developer, integration-specialist, launch-coordinator |
| **Skills** | ✅ 7 Installed | validation-framework, code-generator, mcp-integration, agent-identifier, figma, frontend-design, ralph-loop |
| **Ralph Loop** | ✅ Verified | /ralph-loop and /cancel-ralph commands available |
| **Theme References** | ✅ Cloned | Horizon (primary), Dawn (secondary fallback) |
| **Middleware Template** | ✅ Created | Express.js with webhooks, jobs, mappings, tests |

**Framework Version**: 1.0.0
**Last Updated**: 2026-01-27

---

## 🎯 What's Next

### Ready for Production
This template is **fully configured and ready** for:
- ✅ Client migration projects
- ✅ Custom Shopify development
- ✅ ERP/PIM/OMS integrations
- ✅ Theme customization
- ✅ App development

### Optional Enhancements
- Add agency-specific standards to `.claude/references/agency-stack/`
- Customize agent prompts for your workflow
- Add custom skills for repeated tasks
- Configure CI/CD pipelines for deployments

### Week 1-2 Tasks (Optional)
See [.claude/settings.json](.claude/settings.json) `next_steps` for:
- Review and enhance config files
- Test validation-framework skill
- Verify orchestrator agent functionality
- Test agents with real migration scenarios

---

**Built with Claude Code by Anthropic**

**Ready to build?** Start using the framework immediately - Phase 0 infrastructure is complete! 🚀
