# Fixatech Project Phase Definitions

Detailed descriptions of the 7 project phases for the Fixatech Shopify migration. Use this reference to understand phase scope, typical activities, deliverables, and keyword mappings for time logging.

## Phase 1: Admin & Rencontres (15-18h)

**English:** Admin & Meetings
**Estimate:** 15-18 hours
**Budget:** $1,875 - $2,250

### Description
Project management, client communication, team coordination, and administrative overhead. Includes kickoff meetings, status updates, requirements gathering, stakeholder management, and documentation review.

### Typical Activities
- Initial project kickoff and requirements gathering
- Weekly/bi-weekly status update meetings with PM and designer
- Client calls and presentations
- Scope clarification and change request discussions
- Sprint planning and retrospectives
- Time tracking and progress reporting
- Email correspondence and Slack communications
- Document reviews (discovery, technical specs, design files)
- Risk assessment and mitigation planning
- Budget tracking and invoice preparation

### Deliverables
- Meeting notes and action items
- Status update reports
- Updated project timeline
- Risk register updates
- Change request documentation

### Keywords for Auto-Mapping
- kickoff, meeting, planning, admin, coordination
- status update, client call, presentation
- requirements, scope, change request
- email, correspondence, slack, communication
- review, documentation, notes
- PM meeting, designer sync, team standup

### Example Time Entries
- "2.5h - Project kickoff meeting with PM and client stakeholder"
- "1h - Weekly status update and timeline review"
- "0.5h - Email correspondence clarifying B2B pricing tier requirements"
- "1.5h - Sprint planning session with designer and PM"

---

## Phase 2: Migration de données (50-60h)

**English:** Data Migration
**Estimate:** 50-60 hours
**Budget:** $6,250 - $7,500

### Description
Migration of 4,000 products from WooCommerce to Shopify using CSV export/import with Matrixify app. Includes data mapping, field transformation, validation, and quality assurance.

### Typical Activities
- Export product data from WooCommerce (CSV)
- Analyze and document data structure and relationships
- Create mapping document (WooCommerce fields → Shopify fields)
- Clean and transform data (pricing, inventory, descriptions)
- Handle bilingual content (French/English)
- Map 5-tier pricing structure to SparkLayer format
- Process product images and media assets
- Import data using Matrixify app
- Validate data integrity post-import
- Fix data issues and re-import as needed
- Test product display on storefront
- Document migration process and field mappings

### Deliverables
- WooCommerce data export (CSV files)
- Data mapping documentation
- Cleaned and transformed CSV files
- Matrixify import configurations
- Data validation reports
- Migration runbook for future use

### Keywords for Auto-Mapping
- migration, data, import, export, CSV
- Matrixify, products, 4000 products
- mapping, field mapping, transformation
- WooCommerce, data cleanup, validation
- product data, pricing, inventory
- bilingual, French, English
- images, media, assets

### Example Time Entries
- "6h - Analyzed WooCommerce product structure and created field mapping document"
- "8h - Cleaned and transformed 4,000 product CSV with pricing tier mappings"
- "4h - First Matrixify import attempt and data validation"
- "5h - Fixed data issues and re-imported products with images"

---

## Phase 3: Développement vitrine (105-130h)

**English:** Storefront Development
**Estimate:** 105-130 hours
**Budget:** $13,125 - $16,250

### Description
Custom Shopify storefront development starting from Horizon theme, implementing Figma designs, bilingual functionality, and frontend features. Largest phase of the project.

### Typical Activities
- Set up Horizon theme in development environment
- Implement custom components from Figma designs
- Build product listing and detail pages
- Create collection pages with filtering
- Implement search functionality
- Develop cart and checkout customizations
- Build header, footer, and navigation
- Implement bilingual switching (FR/EN)
- Create custom Liquid sections and snippets
- Add responsive design for mobile/tablet
- Implement SEO optimizations (meta tags, structured data)
- Performance optimization (lazy loading, asset optimization)
- Accessibility improvements (WCAG compliance)
- Cross-browser testing
- Content entry and page setup

### Deliverables
- Customized Horizon theme
- Custom Liquid templates and sections
- Responsive frontend components
- Bilingual storefront (FR/EN)
- Product/collection/cart/checkout pages
- Navigation and global components
- SEO optimizations
- Performance benchmarks

### Keywords for Auto-Mapping
- storefront, theme, Horizon, frontend
- Figma, design, UI, components
- Liquid, template, section, snippet
- product page, collection, cart, checkout
- navigation, header, footer, menu
- bilingual, French, English, translation
- responsive, mobile, tablet
- SEO, performance, optimization
- CSS, JavaScript, styling
- layout, design system, branding

### Example Time Entries
- "8h - Implemented product listing page with filtering from Figma designs"
- "6h - Built custom cart drawer component with Liquid and JavaScript"
- "10h - Developed bilingual navigation with language switcher"
- "7h - Optimized storefront performance and added lazy loading for images"

---

## Phase 4: Implémentation B2B (40-45h)

**English:** B2B Implementation
**Estimate:** 40-45 hours
**Budget:** $5,000 - $5,625

### Description
SparkLayer B2B functionality implementation for wholesale customers with 5-tier pricing structure. Configure customer groups, pricing tiers, and B2B-specific features.

### Typical Activities
- Install and configure SparkLayer app
- Set up customer groups and tags
- Configure 5-tier pricing structure:
  - Prix Suggéré (Suggested Retail)
  - Bronze
  - Argent (Silver)
  - Or (Gold)
  - Revendeur (Reseller)
- Map pricing tiers to customer groups
- Test tier-based pricing calculations
- Build B2B customer portal customizations
- Implement minimum order quantities (if applicable)
- Configure B2B-specific checkout rules
- Set up payment terms and NET payment options
- Test B2B order workflows
- Create documentation for B2B customers
- Train client on managing B2B customers

### Deliverables
- Configured SparkLayer app
- 5-tier pricing structure
- Customer group configurations
- B2B portal customizations
- B2B workflow documentation
- Admin training materials

### Keywords for Auto-Mapping
- B2B, SparkLayer, wholesale
- pricing tiers, tier pricing, customer groups
- Bronze, Silver, Gold, Argent, Or, Revendeur
- NET payment, payment terms
- minimum order, MOQ
- B2B portal, B2B checkout
- wholesale customers, trade accounts

### Example Time Entries
- "8h - Set up SparkLayer and configured 5-tier pricing structure"
- "6h - Mapped customer groups to pricing tiers and tested calculations"
- "5h - Built B2B portal customizations for wholesale customers"
- "4h - Tested B2B order workflows and payment term configurations"

---

## Phase 5: Intégration ERP (55-85h)

**English:** ERP Integration
**Estimate:** 55-85 hours
**Budget:** $6,875 - $10,625

### Description
Integration with ServiCentre 360 ERP via middleware (Express.js) for inventory sync, order processing, and data exchange. Widest hour bracket due to API uncertainty.

### Typical Activities
- Review ServiCentre 360 Swagger API documentation
- Design integration architecture (middleware approach)
- Build Express.js middleware server
- Implement authentication with ERP API
- Develop inventory sync endpoints
- Build order push/pull functionality
- Handle product data synchronization
- Implement error handling and retry logic
- Set up webhook listeners for real-time updates
- Build data transformation layer (Shopify ↔ ERP formats)
- Implement logging and monitoring
- Test integration end-to-end
- Handle edge cases and error scenarios
- Deploy middleware to hosting environment
- Create runbook for troubleshooting

### Deliverables
- Express.js middleware server
- ERP API integration code
- Inventory sync functionality
- Order processing workflows
- Data transformation layer
- Error handling and logging
- Deployment configuration
- Integration documentation

### Keywords for Auto-Mapping
- ERP, ServiCentre 360, integration
- middleware, Express.js, Node.js
- API, Swagger, authentication
- inventory sync, order sync, data sync
- webhook, real-time, polling
- transformation, mapping, data format
- error handling, retry, logging
- deployment, hosting, server

### Example Time Entries
- "10h - Reviewed Swagger docs and designed middleware architecture"
- "12h - Built Express.js middleware with ERP authentication"
- "8h - Implemented inventory sync with error handling and retry logic"
- "6h - Tested end-to-end order processing workflow"

---

## Phase 6: Tests et AQ (15-25h)

**English:** Testing & QA
**Estimate:** 15-25 hours
**Budget:** $1,875 - $3,125

### Description
Quality assurance testing across all project deliverables. Focus on middleware integration, data integrity, B2B workflows, and storefront functionality.

### Typical Activities
- Create test plans and test cases
- Test data migration integrity
- Validate product display and data
- Test storefront functionality (cart, checkout, search)
- Test B2B pricing and customer workflows
- Test ERP integration endpoints
- Validate inventory sync accuracy
- Test order processing end-to-end
- Cross-browser testing (Chrome, Safari, Firefox)
- Mobile/tablet responsive testing
- Performance testing and benchmarks
- Accessibility testing (WCAG compliance)
- Load testing for high-traffic scenarios
- User acceptance testing (UAT) with client
- Bug fixing and issue resolution
- Regression testing after fixes

### Deliverables
- Test plan document
- Test case list
- Bug tracking report
- QA sign-off documentation
- Performance benchmarks
- UAT feedback and resolutions

### Keywords for Auto-Mapping
- testing, QA, quality assurance, validation
- test cases, test plan, bug fixing
- cross-browser, mobile testing, responsive
- UAT, user acceptance, client testing
- performance, load testing, benchmarks
- accessibility, WCAG, compliance
- debugging, issue, bug, fix
- regression testing, smoke test

### Example Time Entries
- "6h - Created test plan and executed storefront functionality tests"
- "5h - Tested B2B pricing tiers and customer workflows"
- "4h - Bug fixing from QA findings and regression testing"
- "3h - User acceptance testing session with client"

---

## Phase 7: Formation et lancement (10-17h)

**English:** Training & Launch
**Estimate:** 10-17 hours
**Budget:** $1,250 - $2,125

### Description
Client training, launch preparation, go-live deployment, and immediate post-launch support. Final phase before project handoff.

### Typical Activities
- Prepare training materials and documentation
- Conduct admin training sessions (product management, orders, customers)
- Train on B2B customer management (SparkLayer)
- Train on inventory management and ERP sync
- Create video tutorials and screencasts
- Prepare launch checklist
- DNS configuration and domain setup
- SSL certificate configuration
- Final pre-launch testing
- Go-live deployment
- Monitor launch day for issues
- Provide immediate post-launch support
- Create handoff documentation
- Knowledge transfer to client team

### Deliverables
- Training documentation
- Video tutorials
- Admin user guides
- Launch checklist
- Go-live deployment confirmation
- Post-launch monitoring report
- Handoff documentation

### Keywords for Auto-Mapping
- training, formation, documentation
- launch, go-live, deployment
- handoff, knowledge transfer
- DNS, domain, SSL
- tutorial, video, screencast
- admin training, user guide
- monitoring, support, post-launch
- checklist, runbook

### Example Time Entries
- "4h - Created training materials and conducted admin training session"
- "3h - Prepared launch checklist and performed pre-launch testing"
- "2h - DNS configuration and go-live deployment"
- "2h - Post-launch monitoring and immediate support"

---

## Phase Mapping Quick Reference

| Phase ID | French Name | English Name | Estimate | Primary Keywords |
|----------|-------------|--------------|----------|------------------|
| `admin` | Admin & Rencontres | Admin & Meetings | 15-18h | meeting, planning, coordination |
| `migration` | Migration de données | Data Migration | 50-60h | migration, CSV, Matrixify, products |
| `storefront` | Développement vitrine | Storefront Development | 105-130h | theme, Horizon, Figma, Liquid, UI |
| `b2b` | Implémentation B2B | B2B Implementation | 40-45h | SparkLayer, pricing tiers, wholesale |
| `erp` | Intégration ERP | ERP Integration | 55-85h | ServiCentre 360, middleware, API |
| `testing` | Tests et AQ | Testing & QA | 15-25h | QA, testing, bug fixing, validation |
| `training` | Formation et lancement | Training & Launch | 10-17h | training, launch, go-live, handoff |

## Multi-Phase Activities

Some activities may span multiple phases. Use your best judgment or ask the user to clarify:

**Frontend + B2B:**
- "Built B2B portal styling" → Could be `storefront` or `b2b` (prefer `b2b`)
- "Implemented B2B checkout UI" → `b2b` (B2B-specific functionality)

**Migration + ERP:**
- "Mapped product fields for ERP sync" → `erp` (integration work)
- "Exported products from WooCommerce" → `migration` (data migration)

**Testing + Any Phase:**
- "Testing B2B pricing" → `testing` (QA activity)
- "Debugging storefront issue found in testing" → `storefront` (development fix)

**Admin + Any Phase:**
- "Meeting about ERP integration approach" → `admin` (meeting overhead)
- "Implemented ERP authentication" → `erp` (actual work)

When in doubt, prefer the phase where the actual **implementation work** occurred rather than the coordination/planning phase.

## Tips for Accurate Time Logging

1. **Be specific in descriptions** - Include what was built, fixed, or configured
2. **Log daily** - Don't batch log at end of week (memory fades)
3. **Round to 0.25h increments** - 15-minute granularity (0.25, 0.5, 0.75, 1.0)
4. **Separate distinct activities** - Don't lump 8h as "storefront work"
5. **Use consistent keywords** - Helps with auto-phase-mapping
6. **Include context** - What feature, bug, or milestone?
7. **Tag cross-phase work** - Use tags if work spans multiple phases

## Billing Notes

- **Hourly Rate:** $125/hour (CAD)
- **Total Project Estimate:** 290-380 hours = $36,250-$47,500
- **Invoice Frequency:** Monthly (generate reports at month-end)
- **Billable Activities:** All logged time is billable at standard rate
- **Non-Billable:** Post-launch support is separate phase (not in Phase 1-7)

---

*Last updated: 2026-01-30*
