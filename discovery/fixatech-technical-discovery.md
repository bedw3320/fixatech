# Fixatech - Technical Discovery Document

**Last Updated:** 2026-01-27
**Project Type:** B2B/B2C E-Commerce Migration to Shopify
**Sources:** Google Drive discovery documents

---

## Executive Summary

**Annual Revenue:** $12M CAD
- **B2B:** 85% ($10.2M) - Contractors, industries, hardware stores
- **B2C:** 15% ($1.8M) - Includes physical store sales

**Key Metrics:**
- **SKUs:** 4,000 products
- **Annual Orders:** 21,000 orders (~$1,000 average order value)
- **B2B Online Orders:** 650/year (only 3% of total orders - **huge growth opportunity**)
- **Facebook Followers:** 6,500 users
- **Market:** Quebec
- **Languages:** Bilingual (French/English)

**Client Contact:** Jacob (jracine@fixatech.com)

**Project Team:**
- **Alexandre Poirier** - UI/UX Designer & Brand Strategist (Atelier Bienvenue)
- **Catherine Anctil-Martin** - Industrial Engineer & Business Architect
- **William Bédard** - Developer (Shopify)
- **Marc Anthony Lemieux** - Developer (Shopify)

---

## Current System Architecture

### Core Systems

| System | Platform | Usage | Contact |
|--------|----------|-------|---------|
| **ERP** | ServiCentre 360 | 20+ years, staying | Pierre Maxime Ducquette<br>pierremaxime.duquette@micromedica.com<br>819-378-1799 x245 |
| **Accounting** | Accomba | Connected to ServiCentre | (inventory, products, clients, suppliers) |
| **B2C Website** | WordPress | Current B2C site | Will remain accessible |
| **B2B Portal** | ServiCentre Module | Current B2B portal | Will remain accessible indefinitely |
| **PIM** | None | - | - |
| **Database** | SQL Server | For queries | - |
| **Shipping** | Trinet | NOT currently connected | LTL + Parcel carriers (Morneau, FedEx) |
| **Payment** | Bank Transfer | 95% of B2B payments | Banque Nationale (connected to Accomba) |
| **Forms** | Zoho Forms | B2B account requests | - |
| **Emailing** | Manual | (Previously Mailchimp) | - |
| **Social Media** | Yes | Active | - |

### Proposed Integration Architecture

```
ServiCentre 360 (ERP)
        ↓ ↑
   Synergy Sync (Middleware)
        ↓ ↑
     Shopify
        ↓ ↑
  Sparklayer (B2B App)
```

**Middleware:** Synergy Sync - Bridge for Shopify + accounting/POS systems
- **Provider:** https://commerce-electronique.ca/pont-e-commerce-pour-comptabilite-et-pdv/

**ServiCentre API:** Open API (Swagger) available

**B2B Solution:** Sparklayer
- Mini demo completed with Sparklayer rep (Jan 27, 2026)
- Screenshots available from demo
- App: https://apps.shopify.com/sparklayer

### Current Development Status

**Development Site:** lightpink-squirrel-564093.hostingersite.com
- **Status:** Early stage development (not production-ready)
- **Access:** Credentials available (see Resources section)
- **Note:** Initial small mandate, will be refined during main project

**Design Assets:**
- **Figma Design:** Approved by client
- **Areas for Optimization:**
  - Landing page refinement
  - Mega menu design (product category navigation)
  - Overall UI polish during project execution

---

## B2B Requirements (85% of revenue - CRITICAL)

### Customer Structure

#### Pricing Tiers (5 levels)
Customer pricing based on annual purchase volume:

1. **Prix Suggéré** (MSRP/Suggested Price)
2. **Bronze**
3. **Argent** (Silver)
4. **Or** (Gold)
5. **Revendeur** (Reseller)

**Pricing Logic:**
- Different price lists per tier
- Discount percentages vary by product family
- Quantity-based pricing for specific families (e.g., nails/fasteners)
- B2B prices already discounted (no additional cart discounts)
- Custom pricing for specific articles/clients possible
- **NOT** tiered volume discounts at checkout

#### Account Management

✅ **Required:**
- Multi-user accounts per company
- Multiple ship-to addresses per account
- Role-based permissions (TBC on specific roles: buyer, approver, admin, finance)
- Complete order history per customer/location
- Generic customer account for B2C
- One account per company for B2B

❌ **NOT Required:**
- Order limits per user
- Internal approval workflows
- Credit limits (first order via CC, then Net terms)

### Current B2B Order Process

1. Customer submits B2B account request via **Zoho Forms**
2. Account created in ServiCentre
3. Customer logs into B2B portal (ServiCentre module)
4. Builds cart (prices already discounted for their tier)
5. Confirms delivery + billing addresses
6. **Delivery split:** 5% pickup in-store, 95% shipped
7. Customer service receives email notification
8. Order automatically appears in ServiCentre 360
9. Fulfillment managed in ServiCentre

### Payment Terms

- **Standard:** Payable on delivery OR Net 30
- **New Customers:** First order must be credit card
- **Existing Customers:** Net payment terms available
- **Credit Limits:** NOT required (not a problem)
- **Payment Method:** 95% bank transfer (virement)

**Question:** How are orders marked as "paid" in ERP when bank transfer received?

### Product Catalog Features

✅ **Required:**
- Detailed technical specifications
- Downloadable documents (PDFs, safety sheets, manuals)
- Product substitutes/alternatives (upsell, cross-sell)
- Brand and product line management
- Custom products created and associated to specific clients

❌ **NOT Required:**
- Accessory compatibility mapping
- Obsolete product management with replacements
- Serial number tracking (no serialized products)

### Ordering Features

✅ **Required:**
- Purchase Order (PO) reference field
- Order by project/job site (TBC)

🔄 **Phase 2:**
- Quick order by SKU
- CSV import (though Sparklayer supports this)
- Saved shopping lists
- Recurring orders
- Reorder from previous orders

❌ **NOT Required:**
- Split shipments (if needed, create new order)

### Invoicing & Payments

✅ **Required:**
- Payment on invoice
- Credit card payment for authorized B2B clients
- Invoice download (verify if Sparklayer covers this)

❌ **NOT Required:**
- Partial payments/deposits
- Customer credit management
- Financial history tracking
- Consolidated invoicing (ERP or Accomba handles this)

---

## B2C Requirements (15% of revenue)

✅ **Required:**
- Customer account creation
- Standard e-commerce functionality
- Same template as B2B
- Same checkout (only delivery/payment terms differ)
- Gift cards (currently using Freebeeze system - needs import)

**Pricing:** B2C uses MSRP price list

---

## Integration Requirements

### Data Synchronization

| Data Type | Source | Direction | Frequency | Status |
|-----------|--------|-----------|-----------|--------|
| **Products** | ServiCentre | ERP → Shopify | Initial import + TBC | Required |
| **Inventory** | ServiCentre | ERP → Shopify | **Real-time (LIVE)** | ⚠️ CRITICAL |
| **Prices** | ServiCentre | ERP → Shopify | **Real-time** | ⚠️ CRITICAL - Automated |
| **Categories** | ServiCentre | ERP → Shopify | TBC | Manual association |
| **Product Images** | ServiCentre | ERP → Shopify | TBC | Initial import |
| **Customers** | TBC | Bidirectional? | TBC | TBC |
| **Orders** | Shopify | Shopify → ERP | **Real-time** | ⚠️ CRITICAL |
| **Invoices** | ServiCentre | ERP → Shopify | TBC | Required |
| **Shipments** | ServiCentre | ERP → Shopify | **Real-time** | Required (1 SO = 1 Shipment) |
| **Refunds** | TBC | **Bidirectional** | None | ERP for B2B, Shopify for B2C |
| **Promotions** | TBC | ERP → Shopify | Automatic activation/deactivation | Date-based promos |

### Critical Integration Points

#### 1. Inventory Sync (CRITICAL)
- **Requirement:** LIVE real-time synchronization
- **Source of Truth:** ServiCentre 360
- **Warehouses:** 1 single warehouse
- **No stock reservation** for B2B orders
- **No backorder management** (refund and reorder if needed)

#### 2. Order Flow (CRITICAL)
- **Direction:** Shopify → ServiCentre 360
- **Must be automatic** - orders appear in ServiCentre immediately
- **All fulfillment** managed in ServiCentre
- Can create orders directly from ERP (sync to Shopify TBC)

#### 3. Price Management (CRITICAL - Automated)
- **Customer-specific pricing** in real-time
- **5 price tiers** automatically applied based on customer group
- **Product family variations** in discount percentages
- **Quantity-based pricing** for specific categories
- **Custom prices** for certain articles/clients
- **Date-based promotions** with auto activation/deactivation
- ⚠️ **Must remain automated** (NOT manual updates)

#### 4. Shipping Integration
- **Current:** Trinet NOT connected to ServiCentre
- **Carriers:** LTL and parcel (Morneau, FedEx)
- **Question:** How are shipping costs managed? Absorbed or passed to customer?
- **Tracking:** Verify if tracking numbers entered manually in ServiCentre
- **Potential:** Integrate Trinet with Shopify
- **App Option:** https://apps.shopify.com/real-time-shipping-quotes

#### 5. Proposed Middleware: Sparklayer
- B2B app for Shopify: https://apps.shopify.com/sparklayer
- Handles B2B pricing, customer accounts, CSV import, etc.
- Potential API connection with ServiCentre

---

## Feature Requirements Matrix

### Core Features

| Feature | Priority | Status | Notes |
|---------|----------|--------|-------|
| B2B distinct accounts | ✅ Required | MVP | Separate from B2C |
| Multi-user accounts | ✅ Required | MVP | Multiple users per company |
| Multiple ship-to addresses | ✅ Required | MVP | Per customer |
| Customer-specific pricing | ✅ Required | MVP | 5 tier system |
| Real-time inventory | ✅ Required | MVP | LIVE sync |
| Order history | ✅ Required | MVP | Per customer/location |
| Technical specs | ✅ Required | MVP | Detailed product info |
| Downloadable docs | ✅ Required | MVP | PDFs, manuals, safety sheets |
| Product substitutes | ✅ Required | MVP | Upsell/cross-sell |
| PO reference field | ✅ Required | MVP | Order reference |
| Invoice download | ✅ Required | MVP | Verify Sparklayer coverage |
| Payment on invoice | ✅ Required | MVP | Net 30 terms |
| Advanced search | ✅ Required | MVP | SKU, brand, Quebec expressions |
| Advanced filters | ✅ Required | MVP | Technical filters |
| Mobile access | ✅ Required | MVP | For job sites |
| Role management | ✅ Required | MVP | Access control |
| Shared catalog | ✅ Required | MVP | B2B + B2C |
| Differentiated pricing | ✅ Required | MVP | B2B vs B2C |

### Phase 2 Features

| Feature | Priority | Status | Notes |
|---------|----------|--------|-------|
| Quick order by SKU | 🔄 Phase 2 | Backlog | Fast ordering |
| CSV import | 🔄 Phase 2 | Backlog | Bulk ordering (Sparklayer supports) |
| Saved shopping lists | 🔄 Phase 2 | Backlog | Reusable lists |
| Recurring orders | 🔄 Phase 2 | Backlog | Automated reorders |
| Repeat previous orders | 🔄 Phase 2 | Backlog | Quick reorder |
| B2B returns (RMA) | 🔄 Phase 2 | Backlog | Not using ServiCentre RMA yet |
| CRM integration | 🔄 Phase 2 | Backlog | Optimization |
| Warranty tracking | 🔄 Phase 2 | Backlog | Manufacturer warranties |
| Repair history | 🔄 Phase 2 | Backlog | Service tracking |
| Repair service | 🔄 Phase 2 | Backlog | Tool repairs |

### NOT Required

| Feature | Status | Notes |
|---------|--------|-------|
| Order limits per user | ❌ Not required | - |
| Approval workflows | ❌ Not required | No internal validation |
| Credit limits | ❌ Not required | Not a problem |
| Quote management | ❌ Not required | - |
| Split shipments | ❌ Not required | Create new order instead |
| Accessory compatibility | ❌ Not required | - |
| Obsolete product mgmt | ❌ Not required | - |
| Serial number tracking | ❌ Not required | No serialized products |
| Stock reservation | ❌ Not required | - |
| Backorder management | ❌ Not required | Refund and reorder |
| Partial shipments | ❌ Not required | 1 SO = 1 Shipment |
| Partial payments | ❌ Not required | - |
| Customer credit mgmt | ❌ Not required | - |
| Financial history | ❌ Not required | - |
| Consolidated invoicing | ❌ Not required | ERP/Accomba handles |
| B2B-specific promos | ❌ Not required | Same promos for all |
| MAP pricing display | ❌ Not required | B2B accounts hide MSRP |
| Separate promotions | ❌ Not required | - |
| Shared stock rules | ❌ Not required | - |
| Different UX by type | ❌ Not required | Same template |
| Different checkout | ❌ Not required | Same checkout |
| User action logs | ❌ Not required | - |
| Price validation | ❌ Not required | - |
| Order audits | ❌ Not required | - |
| Tax exemptions | ❌ TBC | Need clarification |
| Dashboard | ❌ Not required | - |
| Rental service | ❌ Not required | - |
| Credit notes | ❌ Not required | Manual management |

---

## Success Metrics

### Track These KPIs:

✅ **Required:**
- B2B portal adoption rate
- Reduction in phone orders

❌ **NOT Tracking:**
- Average order time
- Recurring order rate
- Order error rate
- Volume per customer

---

## Competitive Analysis / Inspiration

### Similar B2B/B2C Tool Suppliers

1. **Groupe JSV**
   - https://groupejsv.com/

2. **GH Berger**
   - https://ghberger.com/

3. **Pierre Berger (Outils Pierre Berger)**
   - https://www.outilspierreberger.com/

---

## Open Questions & Action Items

### Critical Questions

1. **ServiCentre 360 Integration**
   - ✅ Contact: Pierre Maxime Ducquette (pierremaxime.duquette@micromedica.com, 819-378-1799 x245)
   - ❓ Does ServiCentre offer integration services?
   - ❓ Do they know partners who have connected to Shopify?
   - ❓ Is there a dev/sandbox environment available?
   - ❓ API documentation access?
   - ❓ What API endpoints are available for:
     - Product sync
     - Inventory sync
     - Customer sync
     - Order creation
     - Invoice retrieval
     - Shipment status

2. **Synergy Sync Middleware**
   - ❓ Access to Synergy Sync platform
   - ❓ Capabilities evaluation
   - ❓ Cost structure
   - ❓ Integration timeline

3. **Budget & Scope**
   - ❓ What is the budget specifically for integration?
   - ❓ If full real-time bidirectional integration isn't possible, what's the MVP?

4. **Data & Access**
   - ❓ Access to existing B2B account (for UX review)
   - ❓ Access to ServiCentre 360 (viewing/testing)
   - ❓ Product data structure and export capability
   - ❓ Customer data migration requirements
   - ❓ Historical order data import needs
   - ❓ Gift card balance import (Freebeeze system)

5. **Operations**
   - ❓ Number of employees
   - ❓ Number of people who will use Shopify admin
   - ❓ How is invoice payment status tracked?
   - ❓ How are shipping costs managed? (Absorbed vs. passed to customer)
   - ❓ Tax exemption requirements (TBC)
   - ❓ Google Analytics 4 installation status?

6. **Order Management**
   - ❓ Order status definitions (processing, on hold, canceled, etc.)
   - ❓ Which statuses to display to customers?
   - ❓ How is an order marked as "completed"? (Delivery + full invoicing?)
   - ❓ Receive specific status to cancel unfulfilled/unbilled items?

7. **Payment Processing**
   - ❓ Transaction mode: Authorization or Direct Capture?
   - ❓ Anti-fraud system in place?

---

## Technical Architecture Notes

### Data Flow

```
┌─────────────────┐
│  ServiCentre 360│ (Master Data: Products, Inventory, Customers, Pricing)
│      (ERP)      │
└────────┬────────┘
         │
         │ API (Swagger)
         ↓
┌─────────────────┐
│  Synergy Sync   │ (Middleware/Bridge)
│   (Middleware)  │
└────────┬────────┘
         │
         │ Shopify API
         ↓
┌─────────────────┐
│    Shopify      │ (E-commerce Platform)
│   + Sparklayer  │ (B2B App Layer)
└────────┬────────┘
         │
         ↓
  Customers (B2B/B2C)
```

### Integration Considerations

#### Real-time Sync Required:
- ✅ Inventory levels
- ✅ Customer-specific pricing
- ✅ Order submission to ERP
- ✅ Shipment updates

#### Batch Sync Acceptable:
- Product catalog updates
- Customer data
- Historical invoices

#### Manual Management:
- Credit notes (confirmed)
- Gift card imports (one-time)
- Category associations (ongoing)

---

## Migration Checklist

### Discovery Phase
- [ ] Map and diagram current systems (Will's task)
- [ ] Contact Pierre Maxime Ducquette at ServiCentre
- [ ] Request ServiCentre API documentation
- [ ] Request dev/sandbox environment access
- [ ] Review existing B2B portal UX
- [ ] Evaluate Synergy Sync capabilities
- [ ] Define integration scope based on budget
- [ ] Review competitor sites for UX patterns

### Data Assessment
- [ ] Document current product catalog structure
- [ ] Export sample product data from ServiCentre
- [ ] Map product attributes ERP → Shopify
- [ ] Document customer data structure
- [ ] Define customer migration strategy
- [ ] Assess historical order data requirements
- [ ] Plan gift card balance migration

### Technical Planning
- [ ] Design integration architecture
- [ ] Define API endpoints and data contracts
- [ ] Plan real-time vs. batch sync strategy
- [ ] Design error handling and monitoring
- [ ] Plan rollback procedures
- [ ] Define testing strategy (dev, staging, prod)

### Shopify Setup
- [ ] Select Shopify plan (Shopify Plus for B2B features?)
- [ ] Install Sparklayer B2B app
- [ ] Configure customer groups (5 pricing tiers)
- [ ] Set up payment gateways
- [ ] Configure shipping zones and rates
- [ ] Install search app with AI (Quebec expressions)
- [ ] Install product filter/search app
- [ ] Set up analytics (GA4)
- [ ] Configure email templates
- [ ] Set up domain access

---

## Risk Considerations

### High Risk
- ⚠️ **Real-time inventory sync** - Critical for customer experience
- ⚠️ **Customer-specific pricing** - Complex 5-tier system with family variations
- ⚠️ **Order flow to ERP** - Must be automatic and reliable
- ⚠️ **Budget constraints** - May limit integration depth

### Medium Risk
- ⚙️ **ServiCentre API limitations** - Unknown capabilities until documented
- ⚙️ **Synergy Sync learning curve** - New middleware platform
- ⚙️ **Data migration complexity** - 4,000 SKUs, customer data, pricing rules
- ⚙️ **Shipping integration** - Trinet currently not connected

### Low Risk
- ✓ **B2C functionality** - Standard Shopify capabilities
- ✓ **Template design** - Same for B2B/B2C
- ✓ **Payment processing** - Standard gateway integration

---

## Next Steps (Prioritized)

### Immediate (Week 1)
1. **Contact Pierre Maxime Ducquette** (ServiCentre IT Supervisor)
   - Schedule technical discovery call
   - Request API documentation
   - Request dev environment access
   - Discuss integration options

2. **System Mapping** (Will)
   - Map current system architecture
   - Document data flows
   - Identify integration points

3. **Synergy Sync Evaluation**
   - Request demo/documentation
   - Understand capabilities and limitations
   - Get pricing structure

### Short-term (Weeks 2-3)
4. **Define Integration Scope**
   - Establish budget for integration work
   - Prioritize features for MVP
   - Create fallback plan if full real-time not feasible

5. **Data Discovery**
   - Review ServiCentre data structures
   - Export sample datasets
   - Map attributes to Shopify schema

6. **UX Research**
   - Access existing B2B portal
   - Review competitor sites
   - Define desired user experience

### Medium-term (Weeks 4-6)
7. **Technical Architecture**
   - Design integration architecture
   - Define API contracts
   - Plan sync strategies

8. **Shopify Setup**
   - Provision Shopify account
   - Install Sparklayer
   - Configure initial settings

---

## Document History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2026-01-27 | 1.0 | Initial technical discovery document | Will |

---

## Appendices

### A. Glossary

- **ServiCentre 360**: ERP system used by Fixatech for 20+ years
- **Synergy Sync**: Proposed middleware/bridge between ServiCentre and Shopify
- **Sparklayer**: Shopify B2B app for advanced B2B features
- **Trinet**: Logistics/shipping API provider
- **Accomba**: Accounting system connected to ServiCentre
- **MSRP**: Manufacturer's Suggested Retail Price (used for B2C)
- **LTL**: Less Than Truckload (shipping method)
- **PO**: Purchase Order
- **RMA**: Return Merchandise Authorization

### B. Contact List

| Name | Role | Company | Email | Phone |
|------|------|---------|-------|-------|
| **Client Side** |
| Jacob | Client Contact | Fixatech | jracine@fixatech.com | - |
| Pierre Maxime Ducquette | IT Supervisor | Micromedica (ServiCentre) | pierremaxime.duquette@micromedica.com | 819-378-1799 x245 |
| **Project Team** |
| Alexandre Poirier | UI/UX Designer & Brand Strategist | Atelier Bienvenue | alexandre@atelierbienvenue.ca | 581-986-1989 |
| Catherine Anctil-Martin | Industrial Engineer & Business Architect | Consultant | catherine.anctilmartin@gmail.com | 418-802-1098 |
| William Bédard | Developer | - | bedard.w@gmail.com | - |
| Marc Anthony Lemieux | Developer | - | marcanthony.lemieux@gmail.com | - |

### C. Resources

#### Systems & Platforms
- **ServiCentre:** www.servicentre.ca
- **Synergy Sync:** https://commerce-electronique.ca/pont-e-commerce-pour-comptabilite-et-pdv/
- **Sparklayer:** https://apps.shopify.com/sparklayer
- **Current B2B Portal:** https://fixatech.servicentre.net/
- **Current Website:** https://fixatech.com/
- **Shipping App Option:** https://apps.shopify.com/real-time-shipping-quotes
- **Search App Option:** https://apps.shopify.com/product-filter-search

#### Development Resources
- **Dev Site:** lightpink-squirrel-564093.hostingersite.com
  - User: jracine@fixatech.com
  - Password: pTbX4uvdx@^s%KyC
  - Status: Early stage ("pas Top" - not great yet)
  - Note: Small initial mandate, UI will be refined during project

- **Figma Design:** https://www.figma.com/design/T0UWoZjMrE5Zr43fh9A0FO/Fixatech?node-id=0-1&t=UWYKkTfOTaPsa7GB-1
  - Status: Approved by client
  - Areas for optimization: Landing page, mega menu (product category optimization)

- **Sparklayer Demo:** Screenshots available from mini demo with Sparklayer rep (Jan 27, 2026)
