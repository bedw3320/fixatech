# Fixatech E-Commerce Discovery Notes

**Date:** 2026-01-27
**Source:** Google Doc - 10 Essential Questions for Monday

## Overview

Fixatech is a B2B/B2C e-commerce project requiring integration with their existing ERP system (ServiCentre 360).

---

## Current System Architecture

### ERP System: ServiCentre 360
- **Current B2B Portal:** https://fixatech.servicentre.net/
- **Current Website:** https://fixatech.com/
- **Accounting System:** Accomba (connected to ServiCentre for inventory, product sheets, clients, suppliers)

### Key Contact
- **Pierre Maxime Ducquette** - IT Supervisor
- Email: pierremaxime.duquette@micromedica.com
- Phone: 819 378 1799 ext. 245

### Proposed Integration
- **Bridge/Middleware:** Synergy Sync for Shopify integration
- **Platform:** Synergie E-Commerce (https://commerce-electronique.ca/pont-e-commerce-pour-comptabilite-et-pdv/)

---

## B2B Requirements

### Pricing Structure
Currently 5 B2B price categories:
1. Prix Suggéré (Suggested Price)
2. Bronze
3. Argent (Silver)
4. Or (Gold)
5. Revendeur (Reseller)

**Pricing Logic:**
- Different price lists displayed to different customer tiers
- Discount management
- Quantity-based pricing for fasteners and other products

### Customer Portal Requirements
- ✅ Customer portal for orders
- ✅ Real-time personalized pricing
- ✅ Customer account management
- ✅ B2B account creation
- ✅ B2C account creation
- ❌ Quote management (NOT required)

### Order Management
- **Current Process:** Orders placed via client portal (Espace client)
- **Workflow:** Orders automatically flow into ServiCentre 360
- **Fulfillment:** All order management happens in ServiCentre 360

### Payment Terms
- **Standard Terms:** Payable on delivery or Net 30
- **First Order:** Credit card payment required
- **Subsequent Orders:** Net payment terms available
- **Credit Limits:** NOT required

---

## B2C Requirements

- Customer account creation needed
- Standard e-commerce functionality

---

## Integration Requirements

### Inventory Synchronization
- **Frequency:** LIVE/Real-time synchronization required
- **Source of Truth:** ServiCentre 360
- **Direction:** ServiCentre 360 → Shopify (inventory levels)

### Order Flow
- **Direction:** Shopify → ServiCentre 360
- **Requirement:** Orders must automatically appear in ServiCentre 360 for fulfillment
- **Management:** All order processing happens in ServiCentre 360

### Price List Management
- **Current State:** Automated with ServiCentre
- **Requirement:** Must remain automated (NOT manual updates)
- **Frequency:** Real-time customer-specific pricing

---

## Technical Considerations

### Integration Options
1. **Preferred:** Bidirectional real-time integration
2. **Fallback:** Minimum viable version if budget constraints exist
3. **Question for ServiCentre 360 vendor:**
   - Do they offer integration services?
   - Do they know partners who have connected to Shopify?

### Third-Party Solutions
- **Trinet Solution:** API logistique
- **Synergy Sync:** Bridge/middleware for Shopify + accounting/POS systems

---

## Additional Requirements

### Newsletter Module
- CRM optimization needed

### Domain Access
- Need access to domain name configuration

---

## Competitive/Inspiration References

### Similar B2B/B2C Businesses
1. **Groupe JSV:** https://groupejsv.com/
2. **GH Berger:** https://ghberger.com/
3. **Pierre Berger:** https://www.outilspierreberger.com/

---

## Key Questions for Discovery

1. **Integration Depth:** What level of real-time integration is feasible with ServiCentre 360?
2. **Budget Constraints:** What is the budget specifically for the integration component?
3. **MVP Definition:** If full bidirectional real-time integration isn't possible, what's the minimum viable version?
4. **ServiCentre 360 API:** Does the ERP expose APIs for:
   - Inventory sync
   - Order creation
   - Customer pricing
   - Product data
5. **Data Migration:** What product/customer data needs to be migrated initially?
6. **Testing Environment:** Is there a sandbox/staging instance of ServiCentre 360?

---

## Next Steps

1. Contact Pierre Maxime Ducquette to discuss:
   - ServiCentre 360 API capabilities
   - Integration options and partnerships
   - Access to documentation/sandbox
2. Evaluate Synergy Sync middleware capabilities
3. Define integration scope based on budget
4. Review competitor sites for UX patterns
5. Document current product catalog structure

---

## Notes

- Client currently likes the product architecture of their existing B2B system
- Strong preference for automated pricing (not manual updates)
- Real-time inventory is critical
- Orders MUST flow to ServiCentre 360 for fulfillment
