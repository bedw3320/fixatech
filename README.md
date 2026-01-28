# Fixatech - Shopify Migration Project

**Quebec-based pneumatic and battery tool distribution company migrating to Shopify Plus**

[![Project Status](https://img.shields.io/badge/Status-In_Progress-yellow)]()
[![Framework](https://img.shields.io/badge/Framework-Shopify_Agency-blue)]()
[![MCPs](https://img.shields.io/badge/MCPs-4%2F4_Active-green)](.claude/settings.json)

---

## 🏢 About Fixatech

**Website**: https://fixatech.com
**Current Platform**: fixatech.servicentre.net (legacy system)
**Location**: South Shore of Quebec, Canada

Fixatech is Quebec's reference for pneumatic and battery-powered tools, serving construction professionals, manufacturing companies, and prefabricated industries. They offer:

- **4,000+ Products**: Pneumatic tools, cordless tools, compressors, nails, staples, accessories, hand tools, safety equipment
- **On-Site Repair Services**: Professional tool repair and maintenance
- **B2B Focus**: Serving contractors and construction companies across Quebec
- **Bilingual Operations**: French-primary with English support

### Current Catalog Categories
- Pneumatic tools (cloueuses, agrafeuses)
- Cordless/battery tools
- Compressors and air equipment
- Hand tools
- Nails, staples, and fasteners
- Safety equipment and workwear
- Tool storage solutions
- Outdoor equipment
- Measurement and precision tools

---

## 🎯 Migration Goals

### Business Objectives
- Migrate 4,000+ products from legacy ServiceNtre platform to Shopify Plus
- Maintain existing B2B customer accounts and pricing structures
- Preserve French-first, bilingual content strategy
- Integrate repair services booking with ecommerce
- Improve mobile experience for on-site contractors
- Enable modern payment methods while maintaining net terms for B2B

### Technical Requirements
- **Product Migration**: 4,000+ SKUs with French/English descriptions
- **Customer Migration**: B2B accounts with custom pricing tiers
- **Bilingual Theme**: French primary, English secondary (Quebec standards)
- **B2B Features**: Custom pricing, quote requests, account management
- **Repair Portal**: Service request system integrated with storefront
- **Inventory Integration**: Real-time stock sync with warehouse system
- **Payment Methods**: Net terms, credit cards, possibly financing options

---

## 🚀 Project Setup

This project uses the [Shopify Agency Framework](https://github.com/bedw3320/shopify-agency-framework) with specialized AI agents, MCP servers, and reference materials.

### Framework Components Active

**8 Specialized Agents**:
- **orchestrator**: Project coordination and routing
- **discovery-lead**: Requirements gathering and planning
- **shopify-architect**: Platform design and integrations
- **data-migration-engineer**: Product and customer data migration
- **theme-developer**: Bilingual Horizon theme customization
- **integration-specialist**: ServiceNtre API research and mapping
- **launch-coordinator**: Cutover planning and go-live support

**4 MCP Servers**:
- **shopify-dev-mcp**: GraphQL validation and Shopify API docs
- **n8n-mcp**: Workflow automation for data sync
- **context7**: Express.js and library documentation
- **firecrawl**: Web scraping for legacy system research

**Reference Materials**:
- Shopify Horizon Theme (PRIMARY - for modern bilingual storefront)
- Shopify Dawn Theme (SECONDARY - fallback patterns)
- Express.js Middleware Template (for ServiceNtre integration)

---

## 📁 Project Structure

```
fixatech/
├── .claude/
│   ├── agents/              # 8 specialized migration agents
│   ├── config/              # Routing, guardrails, permissions
│   ├── docs/                # Project documentation
│   ├── knowledge/           # Fixatech-specific domain knowledge
│   │   └── fixatech-business-context.md  # Company info, products, B2B model
│   ├── plans/               # Migration planning documents
│   ├── references/          # Theme and middleware templates
│   │   ├── shopify-horizon-theme/
│   │   ├── shopify-dawn-theme/
│   │   └── shopify-middleware-template/
│   ├── scripts/             # Automation scripts
│   ├── state/               # Project state and progress tracking
│   └── settings.json        # Framework configuration
├── data-migration/          # Product and customer ETL scripts
├── theme/                   # Customized Shopify theme
├── middleware/              # ServiceNtre integration server
└── README.md
```

---

## 🗺️ Migration Phases

### Phase 0: Infrastructure ✅ Complete
- Framework setup with MCP servers
- Reference materials cloned
- Agent routing configured
- Template remote linked for updates

### Phase 1: Discovery (Current)
- [ ] Audit current ServiceNtre platform
- [ ] Map product catalog structure
- [ ] Identify B2B pricing rules
- [ ] Document repair service workflow
- [ ] Stakeholder interviews
- [ ] Gap analysis

### Phase 2: Architecture Design
- [ ] Shopify Plus architecture design
- [ ] ServiceNtre integration strategy
- [ ] Data migration approach
- [ ] B2B app selection (B2B or custom)
- [ ] Theme customization plan
- [ ] Repair booking system design

### Phase 3: Data Migration
- [ ] Product data export and transformation
- [ ] Customer account migration strategy
- [ ] Image optimization and migration
- [ ] Metafield schema design
- [ ] Test data imports

### Phase 4: Theme Development
- [ ] Horizon theme setup (bilingual)
- [ ] French/English language switching
- [ ] B2B customer portal
- [ ] Repair service request forms
- [ ] Product catalog customization
- [ ] Mobile optimization

### Phase 5: Integration Development
- [ ] ServiceNtre API research
- [ ] Express.js middleware development
- [ ] Inventory sync implementation
- [ ] Order webhook handlers
- [ ] Repair service integration

### Phase 6: Testing & UAT
- [ ] Data validation
- [ ] Bilingual content review
- [ ] B2B workflow testing
- [ ] Payment gateway testing
- [ ] Performance optimization

### Phase 7: Launch
- [ ] Cutover planning
- [ ] DNS configuration
- [ ] Go-live execution
- [ ] Post-launch monitoring

---

## 🔄 Keeping Framework Fresh

### Update Reference Materials
```bash
# Run weekly or before major work sessions
.claude/scripts/update-references.sh
```

### Sync Framework Improvements
```bash
# Monthly sync from template repo
.claude/scripts/sync-framework-updates.sh
```

This project stays current with framework improvements while preserving Fixatech-specific customizations in `.claude/state/`, `.claude/knowledge/`, and `.claude/plans/`.

---

## 🛠️ Quick Commands

### Start Discovery
```
"Help me create a discovery framework for the Fixatech migration"
```
→ Routes to **discovery-lead** agent

### Research Current Platform
```
"Use firecrawl to analyze the fixatech.servicentre.net platform structure"
```
→ Uses **firecrawl** MCP to scrape and analyze legacy system

### Design Architecture
```
"Design a Shopify Plus architecture for Fixatech's 4000+ products with B2B pricing"
```
→ Routes to **shopify-architect** agent

### Bilingual Theme Development
```
"Customize Horizon theme for French-primary bilingual storefront"
```
→ Routes to **theme-developer** agent with Horizon reference

### Data Migration
```
"Generate ETL script for migrating ServiceNtre products to Shopify"
```
→ Routes to **data-migration-engineer** → **code-generator** skill

---

## 📚 Project Documentation

- **[Migration Plan](.claude/plans/migration-plan.md)** - Overall migration strategy
- **[Discovery Notes](.claude/state/discovery-notes.md)** - Stakeholder interviews and findings
- **[Technical Specs](.claude/docs/technical-specifications.md)** - Architecture and integration details
- **[Data Mapping](.claude/state/data-mapping.md)** - Product and customer field mappings
- **[Bilingual Strategy](.claude/docs/bilingual-content-strategy.md)** - French/English content approach

---

## 🎯 Success Metrics

### Migration KPIs
- [ ] 100% of 4,000+ products migrated successfully
- [ ] Zero data loss in customer account migration
- [ ] French/English content parity maintained
- [ ] B2B pricing rules accurately replicated
- [ ] Mobile performance score >90
- [ ] SEO rankings maintained or improved
- [ ] Repair booking system integrated and functional

### Business KPIs
- [ ] Zero downtime during cutover
- [ ] B2B customers can access accounts day 1
- [ ] Contractors can browse and order on mobile
- [ ] French content meets Quebec standards
- [ ] Repair service requests flowing through new system

---

## 🔗 Resources

**Fixatech**:
- Current Website: https://fixatech.com
- Current Catalog: https://fixatech.servicentre.net
- B2B Portal: https://fixatechb2b.servicentre.net

**Framework**:
- Template Repository: https://github.com/bedw3320/shopify-agency-framework
- Claude Code: https://github.com/anthropics/claude-code
- Shopify Plus Docs: https://shopify.dev

**Theme References**:
- Horizon Theme: https://github.com/Shopify/horizon
- Dawn Theme: https://github.com/Shopify/dawn

---

## 📊 Current Status

**Project Start Date**: January 27, 2026
**Current Phase**: Phase 1 - Discovery
**Framework Version**: 1.0.0
**Last Updated**: January 27, 2026

**Infrastructure**: ✅ Ready
**Discovery**: 🟡 In Progress
**Development**: ⏸️ Not Started
**Launch**: ⏸️ Not Started

---

**Built with [Shopify Agency Framework](https://github.com/bedw3320/shopify-agency-framework)**

Ready to migrate Fixatech to Shopify Plus 🚀
