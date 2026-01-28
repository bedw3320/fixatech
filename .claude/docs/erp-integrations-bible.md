# ERP Integration Bible for MM SEs

**Source:** Google Drive - ERP Integrations Bible for MM SEs  
**Last Synced:** 2026-01-14  
**Original Document ID:** 1Xu3wwhqJN_ToMnk1ix6RLlXXWmKAMZUGYuLRtltECpg

---

## Why This Guide Exists

Midmarket SEs face ERP integration discussions that can make or break a deal. As much as we try to rely on Partners, these conversations happen in real-time, where confidence and accuracy matter most.

Without standardized guidance, SEs are left piecing together information from Slack threads, outdated docs, and tribal knowledge, leading to:

- Underestimated project complexity and timelines
- Lost deals due to integration uncertainty
- Failed implementations from choosing the wrong approach

This guide is meant to support those high-stakes conversations and ensure we can confidently show up with a POV for our merchants. 

Our goal is to reduce integration assessment time while improving deal qualification accuracy.

---

## How to Use This Guide

Use the Table of Contents + Document Sections to quickly identify your respective ERP during discovery calls for instant assessment.

---

## Table of Contents

**More ERPs to come*

- [NetSuite Integration Playbook](#netsuite-integration-playbook-for-ses)
  - [30-Second Deal Assessment](#netsuite-30-second-deal-assessment)
  - [Expert NetSuite Contacts](#expert-contacts)
  - [Understanding NetSuite Integration Fundamentals](#understanding-netsuite-integration-fundamentals)
  - [Integration Options Deep Dive](#integration-options-guide)
  - [Technical Decision Framework](#example-technical-decision-tree)
  - [Discovery Questions](#discovery-questions)

---

## NetSuite Integration Playbook for SEs
**Speed-to-Solution Guide for Merchant Deals**

---

### NetSuite 30-Second Deal Assessment

Before investing time, quickly assess viability:

#### 🟢 GREEN LIGHT - Pursue with confidence
- Standard customization needs (text, logos, etc.)
- Using Assembly, Kit, or Matrix items in NetSuite (i.e. not Group items)
- Technical resources available (internal team OR integration partner budget)

#### 🟡 YELLOW LIGHT - Proceed with caution
- "Fully customized" NetSuite instance (high integration complexity)
- Made-to-order with 100+ suppliers
- IT team overwhelmed with current projects + doesn't have resources to commit to an integration
- Budget constraints ($25K+ integration investment required)

#### 🔴 RED LIGHT - Higher technical risk
- Heavy use of NetSuite Group items (integration complexity)
- No technical resources and unwilling to hire integration partner
- Complex product pricing managed outside NetSuite
- No technical or financial resources to commit to the integration

---

### Expert Contacts

**When to engage experts:**
- ✅ Discovery calls
- ✅ Technical validation 
- ✅ Proof of concept + testing critical workflows
- ✅ Risk mitigation + expert opinions

**Key Contacts:**
- **Ron Traum** - Partner relationships and technical consultation
- **Clement Louis** - NetSuite integration expertise
- **Catherine O'Callaghan** (Oracle) - Oracle contact (please connect with Aleesa + Clement first)

---

### Understanding NetSuite Integration Fundamentals

#### What Makes NetSuite Integrations Complex?

Unlike simple app installations, ERP integrations require understanding how business data and processes flow between systems. The complexity comes from:

##### 1. Data Structure Differences
- NetSuite organizes data around Business Accounting principles
- Shopify organizes data around Customer experience and sales
- → Integration must translate between these different data models

##### 2. Business Process Alignment
- Order management workflows differ between platforms
- Inventory tracking approaches may not match
- Customer data structures serve different business purposes

##### 3. Customization Impact
- Many merchants have customized NetSuite for their specific business
- These customizations affect how integration can work + standard integrations may not handle unique customizations

---

### NetSuite Item Types - The Foundation of Integration Complexity

**This is the most critical concept to understand.** How products are set up in NetSuite determines which integration approach will work best.

The following is a brief overview of NetSuite's nomenclature for product taxonomy.

#### Assembly Items ✅ (Integration-Friendly)

**What it is:** Products made from multiple components that are assembled together.

**How it works in NetSuite:**
- Base product + components tracked separately
- Final product pricing can include assembly labor/overhead
- Inventory tracked at component level, availability calculated for final product

**Integration implications:**
- ✅ Pre-built connectors handle Assembly items well
- ✅ Standard sync processes work for products and inventory
- ✅ Custom fields for specifications sync easily

**Business examples:** Custom t-shirts (base shirt + printing), gift baskets (container + items), configured electronics

---

#### Kit Items ✅ (Integration-Friendly)

**What it is:** Products sold as a bundle where the final price is NOT dependent on which components are included.

**How it works in NetSuite:**
- Fixed price regardless of component variations
- Components may vary but price stays consistent
- Simple inventory tracking

**Integration implications:**
- ✅ Pre-built connectors handle Kit items easily
- ✅ Standard pricing sync works
- ✅ Straightforward product setup

**Business examples:** Sample packs with fixed pricing; welcome bundles; promotional packages

---

#### Matrix Items ✅ (Integration-Friendly)

**What it is:** Products with variants (size, color, style) managed as a single item family.

**How it works in NetSuite:**
- Parent item with Child variants
- Each variant can have different pricing/inventory
- Organized in matrix view for easy management

**Integration implications:**
- ✅ Pre-built connectors support Matrix items
- ✅ Variant sync works automatically
- ✅ Standard product management

**Business examples:** Clothing with sizes/colors; products with multiple configurations; variant-based customization

---

#### Group Items 🚩 (Integration-Complex)

**What it is:** Products where final price IS dependent on which specific components are selected.

**How it works in NetSuite:**
- Component prices add up to final product price
- Complex pricing calculations based on component selection
- Dynamic pricing based on configuration choices

**Integration implications:**
- ❌ Pre-built connectors struggle with Group items
- ❌ Pricing calculations are complex to sync
- ❌ Usually requires custom development

**Business examples:** Build-your-own computer systems; complex machinery with options; fully configurable products.

---

#### Virtual Variations (Alternative Approach)

**What it is:** Alternative to Matrix items that provides variant-like behavior without NetSuite Matrix complexity.

**How it works:**
- Supported by Celigo integration app
- Provides variant functionality through integration layer
- Simpler NetSuite setup, advanced functionality in Shopify

**When to consider:** When Matrix items are too complex but variants are needed.

---

## Integration Options Guide

**Pricing are internal estimates for our contextual understanding only. Do not quote to the merchant.**  
→ Engage with NetSuite expert contacts who can provide pricing.

---

### NetSuite Connector - $15K-30K

**What It Is:** NetSuite's plug-in-play Shopify app for most standard business scenarios.

**Best for:** Assembly/Kit items, simple customizations, B2C focus  
**Risk:** Low technical risk; limited customization flexibility

#### Technical capabilities:
- ✅ Handles Assembly, Kit, and Matrix items automatically
- ✅ Syncs standard product fields (name, price, description, inventory)
- ✅ Processes standard orders with basic custom fields
- ✅ Manages simple customer records
- ✅ Handles image links (not actual file uploads)

#### Technical considerations:
- ❌ Cannot handle Group items easily (complex pricing)
- ❌ Limited B2B pricing support (no customer tiers or volume breaks)
- ❌ No order meta fields (custom order-level data)
- ❌ Basic customer syncing only (customers not linked to companies)
- ❌ File uploads require workarounds

---

### Celigo Hybrid - $40K-80K

**What It Is:** Integration platform offering pre-built connectors plus ability to add-on custom "platform flows" for complex requirements.

**Best for:** Platform customizations; B2B pricing; complex logic; provides more granular control to Merchant  
**Risk:** Moderate, requires platform flow development

#### Technical capabilities:
- ✅ Assembly, Kit, Matrix items supported out-of-the-box
- ✅ Product meta fields sync automatically
- ✅ Standard order processing with custom fields
- ✅ Volume pricing at order level (when calculated in Shopify)
- ✅ Virtual variations as Matrix item alternative

#### Custom "Platform Flows" Often Created for:
- 🟡 B2B customer-to-company mapping
- 🟡 Order meta fields (critical for complex customization)
- 🟡 Advanced pricing formulas
- 🟡 File handling and artwork processing
- 🟡 Multi-supplier routing and workflows

---

### NSIP/OIC Custom - $60K+ first year

**What It Is:** NetSuite's own low-code, iPaaS platform for building completely custom integrations from scratch.

**Best for:** Unique requirements, multiple brands, strong technical team; scalable across multiple sites/brands; No per-connector licensing fees  
**Risk:** High technical resource dependency

#### Technical capabilities:
- ✅ Complete flexibility - can handle any business requirement
- ✅ Multiple communication protocols (API, EDI, SFTP, screen scraping)
- ✅ Custom business logic implementation
- ✅ Advanced error handling and retry logic

#### Technical considerations:
- 🟡 Significant development expertise needed
- 🟡 Custom coding for every integration point
- 🟡 Manual handling of API updates and changes
- 🟡 Ongoing commitment to maintain and update code (for example, as Shopify APIs change)
- 🟡 Full responsibility for integration reliability and performance

---

## Example Technical Decision Tree

```
START: Complex NetSuite Integration Opportunity

1. Is NetSuite currently live?
   ├── YES → Continue to Item Type Assessment
   └── NO → Is implementation timeline confirmed with partner?
       ├── YES → Continue (but flag timeline dependency)
       └── NO → HIGH RISK - Consider delaying until NetSuite clarity

2. What NetSuite Item Types are used?
   ├── Assembly/Kit/Matrix → PRE-BUILT INTEGRATION likely sufficient
   ├── Group Items → CUSTOM FLOWS required (higher complexity/cost)
   └── Unknown → ENGAGE RON TRAUM for assessment

3. Customization Complexity?
   ├── Standard (text, logos, decoration) → NetSuite Connector viable
   ├── Complex (artwork, multi-supplier) → Celigo with platform flows
   └── Highly Complex (custom workflows) → NSIP/OIC consideration

4. Pricing Requirements?
   ├── Simple B2C pricing → NetSuite Connector
   ├── B2B volume pricing → Celigo (order-level pricing sufficient)
   └── Complex pricing formulas → Platform flows or NSIP/OIC

5. Technical Resources?
   ├── Strong internal team → Any approach viable
   ├── Integration partner budget → Celigo recommended
   └── Limited resources → NetSuite Connector only option

RECOMMENDATION:
- Simple scenarios → NetSuite Connector ($15K-25K, 4-8 weeks)
- Complex scenarios → Celigo hybrid ($40K-80K, 8-16 weeks)  
- Unique requirements → NSIP/OIC ($60K+, 12+ weeks)
```

---

## Discovery Questions

### NetSuite Implementation:
- "How would you describe your NetSuite customization level - standard, moderately customized, or heavily customized?"
- "How is NetSuite currently integrated with your eCommerce platform?"

### Product Structure (Critical!):
- "In NetSuite, what item types do you use for your products - Assembly, Kit, Matrix, or Group items?"
- "For products that customers can customize, how are those set up in NetSuite - as Assembly items with components, or another way?"
- "Are there any NetSuite Group items in your setup?"

### Data Storage and Custom Fields:
- "When customers place orders with customizations, where does that customization information get stored in NetSuite?"
- "Do you use custom fields on sales order lines, or is customization data stored elsewhere?"
- "What custom fields or data elements are critical to your business that need to flow between systems?"

### Pricing Structure:
- "How is pricing calculated for your products - simple fixed pricing, or more complex based on customizations?"
- "Do you have different customer types with different pricing levels?"
- "Where do pricing calculations happen today - in NetSuite, in external systems, or manually?"

### Order Processing and Fulfillment:
- "What information do suppliers need to fulfill orders correctly?"

---

## Key Takeaway

The complexity of NetSuite integration can depend on how NetSuite is configured (especially item types) and what data needs to flow between systems. 

Understanding these fundamentals allows you to quickly assess any NetSuite deal and recommend the appropriate integration approach, regardless of industry or specific business model.
