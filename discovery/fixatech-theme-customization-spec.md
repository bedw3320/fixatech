# Fixatech Theme Customization Specification

**Project:** Fixatech E-Commerce Platform
**Theme:** Shopify Horizon v3.2.1
**Date:** 2026-01-27
**Purpose:** Developer specification for implementing Fixatech design system in Shopify Horizon theme

---

## Overview

This document specifies the customizations needed to implement the approved Fixatech design (Figma file: T0UWoZjMrE5Zr43fh9A0FO) using the Shopify Horizon theme. This is a specification document that outlines **what** needs to be built, not a step-by-step implementation guide.

**Base Setup:**
- Theme: Horizon v3.2.1
- Local reference: `.claude/references/shopify-horizon-theme/`
- Design system spec: `discovery/design-system-specification.md`
- Target: B2B/B2C e-commerce with 4,000 SKUs

**Design Principles:**
- Dark industrial aesthetic (#141414 background)
- Vibrant yellow accent (#FFC600) for CTAs and highlights
- High contrast for readability
- Pill-shaped buttons and inputs (39.5px radius)
- 8px base spacing unit
- Bilingual (French/English)

---

## 1. Theme Settings Configuration

### Settings to Add to `config/settings_schema.json`

#### 1.1 Brand Colors

Add a new color scheme group for Fixatech branding:

```json
{
  "name": "Fixatech Colors",
  "settings": [
    {
      "type": "color",
      "id": "fixatech_primary",
      "label": "Primary Yellow",
      "default": "#FFC600"
    },
    {
      "type": "color",
      "id": "fixatech_primary_hover",
      "label": "Primary Yellow Hover",
      "default": "#E9B217"
    },
    {
      "type": "color",
      "id": "fixatech_background_dark",
      "label": "Background Dark",
      "default": "#141414"
    },
    {
      "type": "color",
      "id": "fixatech_black",
      "label": "Pure Black",
      "default": "#000000"
    },
    {
      "type": "color",
      "id": "fixatech_white",
      "label": "Pure White",
      "default": "#FFFFFF"
    },
    {
      "type": "color",
      "id": "fixatech_border",
      "label": "Border Color",
      "default": "#343434"
    },
    {
      "type": "color",
      "id": "fixatech_text_dark",
      "label": "Dark Gray Text",
      "default": "#333333"
    }
  ]
}
```

#### 1.2 Typography

Add font pickers and upload custom fonts:

```json
{
  "name": "Fixatech Typography",
  "settings": [
    {
      "type": "font_picker",
      "id": "fixatech_font_heading",
      "label": "Heading Font (Flintstock:Round)",
      "default": "helvetica_n4",
      "info": "Upload Flintstock:Round as custom font in assets/"
    },
    {
      "type": "font_picker",
      "id": "fixatech_font_body",
      "label": "Body Font (Geist:Medium)",
      "default": "helvetica_n4",
      "info": "Upload Geist:Medium as custom font in assets/"
    }
  ]
}
```

#### 1.3 Spacing & Layout

```json
{
  "name": "Fixatech Spacing",
  "settings": [
    {
      "type": "range",
      "id": "fixatech_spacing_base",
      "label": "Base Spacing Unit",
      "min": 4,
      "max": 12,
      "step": 1,
      "unit": "px",
      "default": 8
    },
    {
      "type": "range",
      "id": "fixatech_container_width",
      "label": "Container Width",
      "min": 1200,
      "max": 1600,
      "step": 10,
      "unit": "px",
      "default": 1512
    },
    {
      "type": "range",
      "id": "fixatech_content_width",
      "label": "Content Width",
      "min": 1000,
      "max": 1400,
      "step": 10,
      "unit": "px",
      "default": 1238
    }
  ]
}
```

---

## 2. CSS Custom Properties

### Create `assets/fixatech-variables.css.liquid`

Define all design tokens as CSS custom properties:

```css
:root {
  /* Brand Colors */
  --fixatech-primary: {{ settings.fixatech_primary | default: '#FFC600' }};
  --fixatech-primary-hover: {{ settings.fixatech_primary_hover | default: '#E9B217' }};
  --fixatech-background-dark: {{ settings.fixatech_background_dark | default: '#141414' }};
  --fixatech-black: {{ settings.fixatech_black | default: '#000000' }};
  --fixatech-white: {{ settings.fixatech_white | default: '#FFFFFF' }};
  --fixatech-border: {{ settings.fixatech_border | default: '#343434' }};
  --fixatech-text-dark: {{ settings.fixatech_text_dark | default: '#333333' }};

  /* Accent Colors */
  --fixatech-gold-accent: #E9B217;
  --fixatech-gold-underline: #B9930D;
  --fixatech-overlay-light: rgba(255, 255, 255, 0.8);
  --fixatech-overlay-dark: rgba(0, 0, 0, 0.7);

  /* Typography */
  --fixatech-font-heading: {{ settings.fixatech_font_heading.family }}, sans-serif;
  --fixatech-font-body: {{ settings.fixatech_font_body.family }}, Arial, sans-serif;
  --fixatech-font-weight-medium: 500;

  /* Font Sizes */
  --fixatech-font-size-hero: 90px;
  --fixatech-font-size-h2: 60px;
  --fixatech-font-size-price: 38px;
  --fixatech-font-size-body-lg: 15px;
  --fixatech-font-size-body: 12px;
  --fixatech-font-size-caption: 10px;

  /* Line Heights */
  --fixatech-line-height-heading: 73px;
  --fixatech-line-height-normal: normal;

  /* Spacing (8px base unit) */
  --fixatech-spacing-xxs: 10px;
  --fixatech-spacing-xs: 13px;
  --fixatech-spacing-sm: 26px;
  --fixatech-spacing-md: 27px;
  --fixatech-spacing-lg: 137px;
  --fixatech-spacing-xl: 234px;

  /* Border Radius */
  --fixatech-radius-sm: 13px;
  --fixatech-radius-pill: 39.5px;

  /* Transitions */
  --fixatech-transition-base: all 0.3s ease-in-out;
  --fixatech-transition-fast: all 0.2s ease;

  /* Layout */
  --fixatech-container-width: {{ settings.fixatech_container_width | default: 1512 }}px;
  --fixatech-content-width: {{ settings.fixatech_content_width | default: 1238 }}px;
  --fixatech-side-padding: 137px;

  /* Component Sizes */
  --fixatech-header-height: 120px;
  --fixatech-subnav-height: 60px;
  --fixatech-input-height: 42px;
  --fixatech-section-height: 982px;
}

/* Responsive adjustments */
@media (max-width: 1511px) {
  :root {
    --fixatech-font-size-hero: 60px;
    --fixatech-side-padding: 48px;
  }
}

@media (max-width: 767px) {
  :root {
    --fixatech-font-size-hero: 48px;
    --fixatech-font-size-h2: 36px;
    --fixatech-side-padding: 24px;
  }
}
```

---

## 3. Component Mapping & Implementation Strategy

| Figma Component | Horizon Base Section | Customization Level | Implementation Notes |
|-----------------|---------------------|---------------------|----------------------|
| **Header** | `sections/header.liquid` | Moderate | Customize: dark background, custom search bar, yellow pill active nav, 120px height |
| **Sub-Navigation** | Extend `header.liquid` | Moderate | Add 60px bar below header with 4 menu items, border divider |
| **Hero Section** | **Custom section needed** | High | Create `sections/fixatech-hero.liquid` - full-width background, dark overlay, product grid |
| **Product Carousel** | `sections/carousel.liquid` | Moderate | Customize card styling: borders, hover overlay, 13px gaps |
| **Product Card** | `snippets/collection-card.liquid` | Moderate | Add 0.5px border, hover overlay with zoom, circular price badge |
| **Brands Section** | `sections/carousel.liquid` | Moderate | Same as product carousel with brand logo images |
| **Service Grid** | `sections/multicolumn.liquid` or custom | Light | 3-column layout, 389x497px images, individual CTAs |
| **Engagement Module** | **Custom section needed** | High | Create `sections/fixatech-engagement.liquid` - dark bg with logo watermark |
| **Newsletter Section** | **Custom section needed** | High | Create `sections/fixatech-newsletter.liquid` - yellow background, 2-column form |
| **Footer** | `sections/footer.liquid` | Moderate | Customize: 4-column layout, dark background, social icons with arrows |

---

## 4. Custom Sections Required

### 4.1 Fixatech Hero Section

**File:** `sections/fixatech-hero.liquid`

**Requirements:**
- Full-width background image (1512px x 982px)
- Dark overlay: rgba(0, 0, 0, 0.7)
- Content positioning: left-aligned with padding
- Heading: 90px Flintstock:Round, white text
- Subheading/description: 15px Geist, white text
- Primary CTA button: yellow pill-shaped with arrow prefix
- Product showcase grid: 3 images horizontally
  - Each image: 389px x 497px
  - Gap between images: 13px
  - Border radius: 13px
  - Lazy loading for images
- Total section height: 982px
- Responsive: stacks vertically on mobile

**Schema Settings:**
- Background image picker
- Heading text input
- Description textarea
- CTA button text & URL
- Product image blocks (repeatable, max 3)

### 4.2 Fixatech Newsletter Section

**File:** `sections/fixatech-newsletter.liquid`

**Requirements:**
- Background color: #FFC600 (yellow)
- 2-column grid layout:
  - Left: Form (60% width)
  - Right: Info text (40% width)
- Section height: 982px minimum
- Padding: 100px top/bottom, 137px sides

**Form Fields:**
- Nom (Name) - required
- Prénom (First name) - required
- Adresse courriel (Email) - required, type="email"
- Mot de passe (Password) - required, type="password"
- Intérêts (Interests) - checkbox group (optional)

**Form Styling:**
- All inputs: pill-shaped (39.5px radius), 42px height
- Background: rgba(255, 255, 255, 0.8)
- Labels: 15px Geist, dark text (#141414)
- Submit button: Dark/black button (not yellow on yellow)
- Responsive: stacks vertically on mobile

**Schema Settings:**
- Heading text
- Info text (right column)
- Form action URL
- Success message
- Error message

### 4.3 Fixatech Engagement Module

**File:** `sections/fixatech-engagement.liquid`

**Requirements:**
- Background: #141414 (dark)
- Logo watermark: Fixatech logo as background (large, semi-transparent)
- 3-column layout or centered content
- Heading: 60px Flintstock:Round, white text
- Description: 15px Geist, white text
- CTA button: "DÉCOUVREZ NOS ENGAGEMENTS" - yellow pill

**Schema Settings:**
- Heading text
- Description textarea
- CTA button text & URL
- Background logo image picker (optional watermark)

---

## 5. Custom Snippets Required

### 5.1 Fixatech Button Component

**File:** `snippets/fixatech-button.liquid`

**Variants:**
- **Primary:** Yellow background (#FFC600), dark text (#141414)
- **Secondary:** Black background (#000000), white text
- **Outlined:** Transparent background, white border (0.5px), white text

**Styling Requirements:**
- Border radius: 39.5px (pill shape)
- Padding: 10px (compact) or 10px 26px (standard)
- Font: Geist:Medium, 12px, weight 500
- Text transform: lowercase with capitalized first letter
- Arrow prefix: → symbol before text
- Hover state:
  - Primary: background to #E9B217, scale 1.05
  - Secondary: slight opacity change
  - Outlined: background to rgba(255,255,255,0.1)
- Transition: 0.2s ease

**Parameters:**
- `text` - button label
- `url` - link destination
- `style` - 'primary' | 'secondary' | 'outlined'
- `arrow` - boolean (default true)

### 5.2 Fixatech Form Input

**File:** `snippets/fixatech-input.liquid`

**Requirements:**
- Height: 42px
- Border radius: 39.5px (pill)
- Padding: 0 24px (horizontal only)
- Font: Geist:Medium, 15px
- Background: rgba(255, 255, 255, 0.8) on colored sections, solid white on dark sections
- Border: none (or optional 0.5px for outlines)
- Label: above input, 15px size, matching section text color
- Placeholder: same color as text, 60% opacity
- Focus state:
  - Outline: 2px solid #FFC600
  - Outline offset: 2px
  - No box-shadow

**Parameters:**
- `id` - input ID
- `name` - form field name
- `type` - input type (text, email, password, etc.)
- `label` - label text
- `placeholder` - placeholder text
- `required` - boolean

### 5.3 Fixatech Product Card

**File:** `snippets/fixatech-product-card.liquid`

**Requirements:**
- Dimensions: 315px width x 409px height
- Border: 0.5px solid #343434
- Border radius: 13px
- Padding: 17px internal
- Background: transparent

**Image Section:**
- Full-width within card
- Border radius: 13px
- Object-fit: cover
- Lazy loading
- Hover effect: zoom to scale 1.1

**Overlay (on hover):**
- Background: rgba(0, 0, 0, 0.7)
- Centered text: "Voir le produit" (15px Geist, white)
- Fade in: opacity 0 to 1 on hover

**Content Section:**
- Product title: 15px Geist, white text
- Price display:
  - Regular price: 24px Flintstock, yellow (#FFC600)
  - Compare-at price: 12px, strikethrough, gray (#999)
- Vendor/brand: optional, 10px caption

**Price Badge (Optional - for featured products):**
- Circular badge overlaid on image
- Diameter: 125.6px
- Background: white or gradient
- Price: 38px Flintstock
- Cents: 24.51px Flintstock
- Position: top-right or center of image

**Parameters:**
- `product` - Shopify product object
- `show_badge` - boolean for price badge
- `badge_position` - 'top-right' | 'center'

---

## 6. Header & Navigation Customizations

### 6.1 Main Header

**File:** Customize `sections/header.liquid`

**Layout:**
- Height: 120px
- Background: #141414 (dark)
- Position: sticky (fixed on scroll)
- Z-index: 100

**Content (3-column flex layout):**

**Left - Logo:**
- Fixatech logo SVG
- Dimensions: 275px x 40px
- Link to homepage
- White/yellow version depending on scroll state

**Center - Search Bar:**
- Width: ~400px
- Background: transparent
- Border: 0.5px solid #FFFFFF
- Border radius: 39.5px (pill)
- Height: 42px
- Padding: 0 24px
- Placeholder: "Rechercher un article" (French) / "Search for a product" (English)
- Color: white text, white placeholder (70% opacity)
- Submit button: arrow icon (→) right-aligned within input

**Right - Account & Cart:**
- Account link: "Mon compte" button (outlined style)
- Cart icon with count badge:
  - Icon: cart symbol
  - Badge: circular, white background, dark text
  - Count: current cart item count
  - Diameter: 24px, 10px font

### 6.2 Sub-Navigation

**File:** Part of `sections/header.liquid` or separate include

**Layout:**
- Height: 60px
- Border-top: 0.5px solid #343434
- Background: #141414 (matches header)

**Menu Items (horizontal list, centered):**
1. MAGASINER (Shop)
2. LE COIN DES PROS (B2B Section)
3. SERVICE DE RÉPARATION (Repair Service)
4. CARTE-CADEAU (Gift Card)

**Styling:**
- Font: Geist:Medium, 12px, uppercase
- Color: white
- Spacing: 40px gap between items
- Active state: yellow pill background (#FFC600), dark text
- Hover state: underline with gold color (#B9930D)
- Padding: 8px 16px for each item
- Border radius: 39.5px for pills

**Responsive:**
- Mobile: convert to hamburger menu
- Tablet: reduce spacing between items

---

## 7. Footer Customizations

**File:** Customize `sections/footer.liquid`

**Layout:**
- Background: #141414 (dark)
- Min height: 982px (matches other sections)
- Padding: 100px vertical, 137px sides

**4-Column Grid:**

**Column 1 - FIXATECH:**
- Company info
- Address: "1010, route des Rivières, local 100, Lévis (Québec) G7A 2V1"
- Hours: "7H00 À 17H00, DU LUNDI AU VENDREDI"
- Contact CTA button (primary yellow)

**Column 2 - PLAN DU SITE (primary links):**
- FIXATIONS
- ÉQUIPEMENT
- LE COIN DES PROS
- RÉPARATION
- CONDITIONS GÉNÉRALES
- POLITIQUE DE CONFIDENTIALITÉ
- NOS ENGAGEMENTS

**Column 3 - PLAN DU SITE (account links):**
- PANIER (Cart)
- MON COMPTE (My Account)

**Column 4 - SUIVEZ-NOUS & INFOLETTRE:**
- Social links with arrows:
  - FACEBOOK →
  - YOUTUBE →
  - LINKEDIN →
- Newsletter signup:
  - Email input (pill-shaped)
  - Subscribe button

**Styling:**
- Headers: 15px Geist, white
- Links: 12px Geist, white
- Arrow prefix: → on links
- Vertical spacing: 11-13px between links
- Link hover: underline with gold (#B9930D)

**Bottom Bar:**
- Centered Fixatech logo (larger version)
- Copyright text (left): "© 2026 Fixatech"
- Design credit (right): "Design par Atelier Bienvenue"
- Font: 12px Geist, #333333 (dark gray)

**Responsive:**
- Mobile: stack columns vertically
- Tablet: 2x2 grid

---

## 8. Product Card Carousel Styling

**Base:** Use `sections/carousel.liquid` from Horizon

**Customizations Needed:**

**Section Title:**
- Font: Flintstock:Round, 60px
- Color: white on dark background
- Margin-bottom: 40px

**Carousel Container:**
- 5 cards visible at once (desktop)
- Gap between cards: 13px
- Horizontal scroll with navigation arrows
- Snap scroll behavior

**Navigation Arrows:**
- Circular buttons
- Background: white with dark icon
- Size: 48px diameter
- Position: vertically centered, outside carousel edges
- Hover: yellow background

**Indicators (Dots):**
- Below carousel
- Active: white
- Inactive: gray (#343434)
- Gap: 8px

**"Voir tous les produits" CTA:**
- Below carousel
- Centered
- Primary yellow button
- Arrow prefix

**Responsive:**
- Tablet: 3 cards visible
- Mobile: 1 card visible, swipe gestures

---

## 9. Responsive Breakpoints & Requirements

### Desktop (1512px+)
- Full layout as designed
- Container: 1512px max-width
- Content: 1238px with 137px side padding
- Product grids: 5 columns (or 3 for large cards)
- Typography: full sizes (90px hero, 60px h2)

### Tablet (768px - 1511px)
- Product grids: 2-3 columns
- Side padding: 48px
- Typography: slightly reduced
  - Hero: 60px (from 90px)
  - H2: 48px (from 60px)
- Newsletter: stacks to single column
- Navigation: maintained but tighter spacing

### Mobile (<768px)
- All layouts: single column, full-width
- Side padding: 24px
- Typography: significantly reduced
  - Hero: 48px
  - H2: 36px
  - Body: maintained at 15px/12px
- Navigation: hamburger menu
- Touch targets: minimum 48px x 48px
- Form inputs: full width
- Buttons: full width or centered
- Product cards: full width, auto height
- Hero products: stacked vertically
- Footer: stacked columns with generous spacing

**Critical Mobile Considerations:**
- Touch-friendly: all interactive elements 48px minimum
- No hover states: replace with tap/press states
- Readable text: maintain font sizes, don't go below 12px
- Scrollable carousels: enable gesture-based swiping
- Reduced animation: respect prefers-reduced-motion

---

## 10. Asset Requirements

### 10.1 Custom Fonts

**Flintstock:Round (Display font):**
- Use case: Headings, hero text, prices
- Formats needed: WOFF2 (primary), WOFF (fallback)
- Weights: Regular
- Upload to: `assets/flintstock-round.woff2`, `assets/flintstock-round.woff`
- Fallback: Helvetica, Arial, sans-serif
- Font-display: swap (for performance)

**Geist:Medium (Body font):**
- Use case: Body text, buttons, navigation, labels
- Formats needed: WOFF2 (primary), WOFF (fallback)
- Weights: Medium (500)
- Upload to: `assets/geist-medium.woff2`, `assets/geist-medium.woff`
- Fallback: Arial, Helvetica, sans-serif
- Font-display: swap

**Font Loading Strategy:**
- Preload both fonts in `<head>` of `theme.liquid`
- Use `font-display: swap` to show fallback while loading
- Subset fonts to include only Latin characters + French accents
- Compress font files for optimal size

### 10.2 Logo Assets

**Fixatech Logo:**
- Format: SVG (preferred) + PNG fallback
- Usage: Header (275x40px), Footer (larger, centered)
- Variants:
  - Default: Yellow + white
  - Inverse: Yellow + black (for light backgrounds)
- Upload to: `assets/fixatech-logo.svg`, `assets/fixatech-logo.png`

**Fixatech Icon (3 yellow stripes):**
- Format: SVG
- Usage: Favicon, small branding elements
- Size: Scalable
- Upload to: `assets/fixatech-icon.svg`

**Favicons:**
- Sizes: 16x16, 32x32, 64x64 (PNG)
- Upload to: `assets/favicon-16x16.png`, `assets/favicon-32x32.png`, `assets/favicon-64x64.png`
- Configure in theme settings: `settings_schema.json` favicon picker

### 10.3 Product & Hero Images

**Hero Background Images:**
- Dimensions: 1512px x 982px (desktop)
- Format: WebP (primary), JPG (fallback)
- Optimization: <150KB per image
- Upload to: Shopify CDN via theme editor or Files section

**Product Images:**
- Large cards: 389px x 497px
- Small cards: 315px x 409px
- Thumbnails: 252px x 332px
- Format: WebP (primary), JPG (fallback)
- Optimization: <100KB per image
- Aspect ratio: maintain 3:4 (portrait) or 1:1 (square)
- Alt text: required for all product images

**Service Section Images:**
- Dimensions: 389px x 497px (same as large product cards)
- Format: WebP + JPG fallback
- Optimization: <100KB

### 10.4 Icons

**Social Media Icons:**
- Platforms: Facebook, YouTube, LinkedIn
- Style: Line icons (minimal, outlined)
- Size: 24px x 24px
- Color: white (CSS controlled)
- Format: SVG (inline or sprite)

**UI Icons:**
- Cart, Account, Search, Arrow (→)
- Size: 20-24px
- Color: white or yellow (CSS controlled)
- Format: SVG inline or icon font

**Implementation:**
- Use inline SVG for flexibility (color, size)
- OR use icon font (like Fontello, Icomoon)
- Ensure icons are accessible (ARIA labels, semantic HTML)

---

## 11. Performance Requirements

### Target Metrics (Lighthouse)
- **Performance:** >90
- **Accessibility:** 100
- **Best Practices:** >95
- **SEO:** 100

### Image Optimization Strategy

**Responsive Images:**
```liquid
<img
  src="{{ image | img_url: '389x497' }}"
  srcset="
    {{ image | img_url: '195x249' }} 195w,
    {{ image | img_url: '389x497' }} 389w,
    {{ image | img_url: '778x994' }} 778w
  "
  sizes="(max-width: 767px) 100vw, 389px"
  loading="lazy"
  alt="{{ image.alt }}"
/>
```

**WebP with Fallback:**
```liquid
<picture>
  <source srcset="{{ image | img_url: '389x497', format: 'webp' }}" type="image/webp">
  <img src="{{ image | img_url: '389x497' }}" alt="{{ image.alt }}" loading="lazy" />
</picture>
```

**Lazy Loading:**
- All images below the fold: `loading="lazy"`
- Hero/above-fold images: `loading="eager"` or no attribute
- Use Intersection Observer for advanced lazy loading

### Font Loading Strategy

**Preload Critical Fonts:**
```html
<!-- In theme.liquid <head> -->
<link rel="preload" href="{{ 'flintstock-round.woff2' | asset_url }}" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="{{ 'geist-medium.woff2' | asset_url }}" as="font" type="font/woff2" crossorigin>
```

**Font-Face Declaration:**
```css
@font-face {
  font-family: 'Flintstock Round';
  src: url('{{ 'flintstock-round.woff2' | asset_url }}') format('woff2'),
       url('{{ 'flintstock-round.woff' | asset_url }}') format('woff');
  font-weight: normal;
  font-style: normal;
  font-display: swap;
}
```

### Critical CSS
- Inline above-the-fold CSS in `<head>`
- Load remaining CSS asynchronously
- Minimize CSS file size (<50KB)
- Use CSS variables for theming (reduces duplication)

### JavaScript Optimization
- Minimize/bundle JS files
- Defer non-critical scripts
- Use dynamic imports for heavy components (carousel, modal)
- Avoid layout shift with proper sizing

---

## 12. Accessibility Requirements

### WCAG 2.1 Level AA Compliance

**Color Contrast:**
All color combinations meet or exceed WCAG AA standards:
- White on Dark (#FFFFFF on #141414): 15.48:1 ✓ AAA
- Yellow on Dark (#FFC600 on #141414): 10.05:1 ✓ AAA
- Black on Yellow (#000000 on #FFC600): 11.48:1 ✓ AAA
- White on Black (#FFFFFF on #000000): 21:1 ✓ AAA

**Focus Indicators:**
- All interactive elements: visible focus state
- Style: 2px solid #FFC600 (yellow outline)
- Offset: 2px from element
- Never remove focus outlines (`:focus` styles)
- Consider `:focus-visible` for mouse vs. keyboard distinction

**Keyboard Navigation:**
- Tab order: logical and sequential
- Enter/Space: activate buttons and links
- Escape: close modals, dropdowns, overlays
- Arrow keys: navigate carousels, sliders
- Skip to content link: first focusable element

**Semantic HTML:**
```html
<header> - Site header with navigation
<nav> - Navigation menus
<main> - Main content area
<section> - Distinct content sections
<article> - Self-contained content (blog posts, products)
<footer> - Site footer
<h1>, <h2>, <h3> - Proper heading hierarchy
```

**ARIA Labels:**
- Icon-only buttons: `aria-label="Cart"` or `aria-labelledby`
- Navigation landmarks: `<nav aria-label="Main navigation">`
- Form inputs: always pair with `<label>` using `for` attribute
- Loading states: `aria-live="polite"` for dynamic content
- Expanded/collapsed states: `aria-expanded="true|false"`

**Images:**
- All images: descriptive `alt` text
- Decorative images: `alt=""` (empty, not missing)
- Complex images: longer descriptions via `aria-describedby`

**Forms:**
- All inputs: associated `<label>` elements
- Required fields: `required` attribute + visual indicator
- Error messages: `aria-invalid="true"` + error text
- Success messages: `role="status"` or `aria-live="polite"`

**Touch Targets (Mobile):**
- Minimum size: 48px x 48px
- Adequate spacing: 8px minimum between targets
- Easy to tap: no tiny links or buttons

### Screen Reader Testing
- Test with VoiceOver (Mac/iOS)
- Test with NVDA or JAWS (Windows)
- Ensure proper reading order
- Announce dynamic content changes

---

## 13. Development Priorities & Phases

### Phase 1: Foundation (Week 1)
**Goal:** Set up Fixatech design system in Horizon theme

1. **Theme Settings Configuration**
   - Add Fixatech color scheme to `settings_schema.json`
   - Add typography settings (font pickers)
   - Configure spacing/layout settings

2. **CSS Variables**
   - Create `assets/fixatech-variables.css.liquid`
   - Define all design tokens (colors, fonts, spacing, etc.)
   - Link stylesheet in `theme.liquid`

3. **Custom Fonts**
   - Upload Flintstock:Round (WOFF2, WOFF)
   - Upload Geist:Medium (WOFF2, WOFF)
   - Add `@font-face` declarations
   - Preload critical fonts in `<head>`

4. **Basic Snippets**
   - Create `snippets/fixatech-button.liquid` (3 variants)
   - Create `snippets/fixatech-input.liquid`
   - Test snippets in isolation

**Deliverable:** Functional design system foundation ready for component development.

---

### Phase 2: Layout & Navigation (Week 2)
**Goal:** Implement header, footer, and basic page structure

5. **Header Customization**
   - Modify `sections/header.liquid`:
     - Dark background (#141414)
     - Custom search bar (pill-shaped, transparent)
     - Logo placement (275x40px)
     - Account/cart buttons
   - Height: 120px

6. **Sub-Navigation**
   - Add to header or create separate include
   - 4 menu items: MAGASINER, LE COIN DES PROS, SERVICE DE RÉPARATION, CARTE-CADEAU
   - Yellow pill for active state
   - Height: 60px

7. **Footer Customization**
   - Modify `sections/footer.liquid`:
     - 4-column layout
     - Dark background (#141414)
     - Company info, site map, social links, newsletter
     - Bottom bar with logo and copyright

8. **Mobile Navigation**
   - Hamburger menu for mobile
   - Slide-out or dropdown navigation
   - Touch-friendly targets

**Deliverable:** Fully functional header and footer with navigation.

---

### Phase 3: Custom Sections (Week 3)
**Goal:** Build unique Fixatech sections

9. **Hero Section**
   - Create `sections/fixatech-hero.liquid`
   - Full-width background, dark overlay
   - Heading, CTA, product grid (3 images)
   - Height: 982px

10. **Newsletter Section**
    - Create `sections/fixatech-newsletter.liquid`
    - Yellow background (#FFC600)
    - 2-column form layout
    - Pill-shaped inputs

11. **Engagement Module**
    - Create `sections/fixatech-engagement.liquid`
    - Dark background with logo watermark
    - Centered content with CTA

**Deliverable:** Three custom sections ready for use in theme editor.

---

### Phase 4: Product Components (Week 4)
**Goal:** Style product displays and carousels

12. **Product Card Snippet**
    - Create `snippets/fixatech-product-card.liquid`
    - Border, hover overlay, price badge
    - Dimensions: 315x409px

13. **Carousel Customization**
    - Modify `sections/carousel.liquid`
    - Custom card styling
    - Navigation arrows, indicators
    - 5 cards visible (desktop)

14. **Collection/Product Pages**
    - Customize collection grid layouts
    - Apply product card styling
    - Filters and sorting

**Deliverable:** Fully styled product displays and carousels.

---

### Phase 5: Responsive & Polish (Week 5)
**Goal:** Ensure mobile responsiveness and design polish

15. **Responsive Breakpoints**
    - Create `assets/fixatech-responsive.css`
    - Tablet styles (768-1511px)
    - Mobile styles (<768px)
    - Touch targets, stacked layouts

16. **Animations & Interactions**
    - Hover states (scale, color shift)
    - Transitions (0.3s ease)
    - Image zoom on hover
    - Smooth scrolling

17. **Final Design Polish**
    - Match Figma pixel-perfect
    - Adjust spacing, alignment
    - Typography fine-tuning
    - Color accuracy

**Deliverable:** Responsive, polished theme matching Figma design.

---

### Phase 6: Optimization & Accessibility (Week 6)
**Goal:** Optimize performance and ensure accessibility

18. **Performance Optimization**
    - Image optimization (WebP, lazy loading)
    - Font subsetting and preloading
    - CSS/JS minification
    - Lighthouse audit (target >90)

19. **Accessibility Audit**
    - Keyboard navigation testing
    - Screen reader testing (VoiceOver, NVDA)
    - Color contrast verification
    - ARIA labels and semantic HTML

20. **Cross-Browser Testing**
    - Chrome, Firefox, Safari, Edge
    - iOS Safari, Android Chrome
    - Fix browser-specific issues

**Deliverable:** Optimized, accessible theme ready for production.

---

### Phase 7: Testing & QA (Week 7)
**Goal:** Comprehensive testing before launch

21. **Functional Testing**
    - All links work
    - Forms submit correctly
    - Search functions properly
    - Cart operations (add, remove, update)
    - Account creation/login

22. **Visual QA**
    - Design matches Figma
    - Spacing consistent (8px grid)
    - Colors accurate
    - Typography correct
    - Images properly sized

23. **Device Testing**
    - Desktop: 1920px, 1512px, 1440px
    - Tablet: 1024px, 768px
    - Mobile: 375px, 360px, 320px
    - Various orientations

**Deliverable:** Fully tested, production-ready Fixatech theme.

---

## 14. Testing Checklist

### Visual QA
- [ ] All typography matches Figma exactly (fonts, sizes, weights)
- [ ] Colors match design system (use color picker to verify hex codes)
- [ ] Spacing matches 8px grid system
- [ ] Border radius consistent: 13px for cards, 39.5px for pills
- [ ] Images properly sized and optimized (<100KB)
- [ ] Hover states implemented (buttons, cards, links)
- [ ] Focus states visible (2px yellow outline, 2px offset)

### Functional QA
- [ ] All navigation links work correctly
- [ ] Search bar functions and returns results
- [ ] Forms submit successfully (newsletter, contact)
- [ ] Cart operations work (add, remove, update quantity)
- [ ] Product cards link to correct product pages
- [ ] Carousels scroll smoothly with navigation arrows
- [ ] Mobile menu opens/closes correctly
- [ ] Account creation and login work

### Responsive QA
- [ ] Desktop (1512px+): full layout, 5-column grids
- [ ] Tablet (768-1511px): 2-3 column grids, adjusted spacing
- [ ] Mobile (<768px): single column, stacked layout, hamburger menu
- [ ] Touch targets minimum 48px on mobile
- [ ] Text remains readable at all sizes (no font below 12px)
- [ ] Images scale properly without distortion
- [ ] Forms are usable on mobile (full-width inputs)

### Performance QA
- [ ] Lighthouse Performance score >90
- [ ] All images lazy-loaded below fold
- [ ] Critical CSS inlined in `<head>`
- [ ] Fonts loaded efficiently (preload, font-display: swap)
- [ ] No Cumulative Layout Shift (CLS <0.1)
- [ ] First Contentful Paint <1.5s
- [ ] Time to Interactive <3s

### Accessibility QA
- [ ] WCAG 2.1 AA compliant
- [ ] Screen reader tested (VoiceOver, NVDA)
- [ ] Keyboard navigation works (Tab, Enter, Escape, Arrows)
- [ ] All images have descriptive alt text
- [ ] Form labels associated with inputs
- [ ] Color contrast ratios pass (all verified AA or AAA)
- [ ] Focus indicators visible and consistent
- [ ] Skip to content link present and functional
- [ ] ARIA labels on icon-only buttons
- [ ] Semantic HTML structure (`<header>`, `<nav>`, `<main>`, `<footer>`)

### Cross-Browser QA
- [ ] Chrome (Windows & Mac)
- [ ] Firefox (Windows & Mac)
- [ ] Safari (Mac & iOS)
- [ ] Edge (Windows)
- [ ] Mobile Safari (iOS)
- [ ] Chrome (Android)

### B2B Functionality QA (Sparklayer Integration)
- [ ] B2B customer login shows custom pricing
- [ ] Pricing tiers display correctly (5 levels)
- [ ] Bulk/quantity pricing visible for applicable products
- [ ] B2B account creation flow works
- [ ] Customer portal accessible

---

## 15. Additional Considerations

### Bilingual Support (French/English)
- All text strings should be translation-ready
- Use Shopify's translation system: `{{ 'theme.key' | t }}`
- Create locale files: `locales/en.default.json`, `locales/fr.json`
- Test language switcher if implemented

### B2B Features (Sparklayer Integration)
- Ensure custom sections work with Sparklayer B2B app
- Test customer-specific pricing display
- Verify bulk pricing tables integrate smoothly
- Check multi-user account features don't conflict with theme

### Shopify Apps Compatibility
- Test with common apps: reviews, wishlist, search (if installed)
- Ensure app blocks work in custom sections
- Verify checkout customizations (if any)

### Content Management
- All sections should be editable in theme editor
- Schema settings clear and user-friendly
- Preview mode works correctly for merchants
- Theme customizer doesn't break on save

---

## 16. Resources & References

### Project Documentation
- **Design System Specification:** `discovery/design-system-specification.md`
- **Technical Discovery:** `discovery/fixatech-technical-discovery.md`
- **Email Findings:** `discovery/email-findings-summary.md`
- **Figma Design:** https://www.figma.com/design/T0UWoZjMrE5Zr43fh9A0FO/Fixatech

### Horizon Theme
- **Local Codebase:** `.claude/references/shopify-horizon-theme/`
- **GitHub Repository:** https://github.com/Shopify/horizon
- **Version:** 3.2.1

### Shopify Documentation
- **Theme Development:** https://shopify.dev/docs/storefronts/themes
- **Liquid Reference:** https://shopify.dev/docs/api/liquid
- **Theme Architecture:** https://shopify.dev/docs/storefronts/themes/architecture
- **Shopify CLI:** https://shopify.dev/docs/api/shopify-cli

### Horizon-Specific Resources
- **Customization Guide:** https://growth-services.shopify.com/blogs/blog/how-to-safely-customize-the-horizon-theme-to-maintain-upgradability
- **Theme Blocks Documentation:** https://shopify.dev/docs/storefronts/themes/architecture/blocks

### Accessibility
- **WCAG 2.1 Guidelines:** https://www.w3.org/WAI/WCAG21/quickref/
- **Shopify Accessibility:** https://shopify.dev/docs/storefronts/themes/best-practices/accessibility
- **Color Contrast Checker:** https://webaim.org/resources/contrastchecker/

### Performance
- **Lighthouse:** https://developers.google.com/web/tools/lighthouse
- **Shopify Performance:** https://shopify.dev/docs/storefronts/themes/best-practices/performance

---

## Document History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2026-01-27 | 1.0 | Initial theme customization specification | Will |

---

**End of Specification Document**

This document should be used as the primary reference for implementing the Fixatech design in Shopify Horizon theme. For design details (colors, typography, spacing), refer to `discovery/design-system-specification.md`. For business requirements and integration details, refer to `discovery/fixatech-technical-discovery.md`.
