# Fixatech Design System Specification

**Date:** 2026-01-27
**Source:** Figma Design (T0UWoZjMrE5Zr43fh9A0FO)
**Page:** Fixatech Landing Page (Node 1:103)

---

## Overview

The Fixatech e-commerce design uses a bold, industrial aesthetic with high contrast dark backgrounds and vibrant yellow accents. The design emphasizes visual hierarchy through large typography, generous spacing, and strategic use of the brand color.

---

## Color System

### Primary Colors

| Color Name | Hex Code | RGB | Usage |
|------------|----------|-----|-------|
| **Fixatech Yellow** | `#FFC600` | rgb(255, 198, 0) | Primary CTA buttons, accents, highlights, newsletter section background |
| **Background Dark** | `#141414` | rgb(20, 20, 20) | Main background, header, footer, dark sections |
| **Pure Black** | `#000000` | rgb(0, 0, 0) | Secondary buttons, overlays, text on light backgrounds |
| **Pure White** | `#FFFFFF` | rgb(255, 255, 255) | Primary text on dark backgrounds, icons |

### Secondary Colors

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| **Dark Gray** | `#333333` | Footer copyright text, subtle elements |
| **Gold Accent** | `#E9B217` | Alternative yellow for hover states |
| **Gold Underline** | `#B9930D` | Link underlines, decorative accents |
| **Light Overlay** | `rgba(255,255,255,0.8)` | Form input backgrounds on colored sections |
| **Dark Overlay** | `rgba(0,0,0,0.7)` | Image overlays |
| **Border Gray** | `#343434` | Subtle borders, dividers |

---

## Typography

### Font Families

1. **Flintstock:Round** (Display font)
   - **Usage:** Main headings, hero text, section titles
   - **Weights:** Regular
   - **Sizes:** 60px, 90px
   - **Line Height:** 73px
   - **Characteristics:** Bold, rounded, industrial feel

2. **Geist:Medium** (System font)
   - **Usage:** Body text, buttons, navigation, labels
   - **Weights:** Medium (500)
   - **Sizes:** 10px, 12px, 15px, 38px
   - **Line Height:** normal
   - **Characteristics:** Clean, modern, highly legible

### Typography Scale

| Type | Font | Size | Line Height | Weight | Letter Spacing |
|------|------|------|-------------|--------|----------------|
| **H1 - Hero** | Flintstock:Round | 90px | 73px | Regular | Normal |
| **H2 - Section** | Flintstock:Round | 60px | 73px | Regular | Normal |
| **Body Large** | Geist:Medium | 15px | normal | Medium | Normal |
| **Body Regular** | Geist:Medium | 12px | normal | Medium | Normal |
| **Caption** | Geist:Medium | 10px | normal | Medium | Normal |
| **Price Display** | Flintstock:Round | 38px | 0 | Regular | Normal |
| **Price Cents** | Flintstock:Round | 24.51px | normal | Regular | Normal |

### Text Styles

**Headings:**
- White text on dark backgrounds
- Black text on light/yellow backgrounds
- Pre-wrap whitespace for multi-line control
- Centered alignment for hero sections

**Body Text:**
- White on dark backgrounds
- Black on light/yellow backgrounds
- Lowercase for buttons with capitalized first letter
- Underline decoration for links (gold color)

---

## Spacing System

### Base Unit: 8px

| Size | px | Usage |
|------|-------|-------|
| **XXS** | 10px | Internal padding for compact elements |
| **XS** | 13px | Small gaps between inline elements |
| **SM** | 26px | Button horizontal padding |
| **MD** | 27px | Standard button padding |
| **LG** | 137px | Large section spacing (hero elements) |
| **XL** | 234px | Extra large section spacing |

### Component Spacing

- **Button padding:** 10px (compact) / 26-27px (standard)
- **Section padding:** 137-234px from edges
- **Card spacing:** 13px gaps between cards
- **Input padding:** 10px internal
- **Form gaps:** 10px between fields

---

## Border Radius

| Size | px | Usage |
|------|-----|-------|
| **Small** | 13px | Product images, content cards |
| **Medium** | 39.5px | Buttons, pills, form inputs, badges |

---

## Components

### Buttons

#### Primary Button (Yellow CTA)
```css
Background: #FFC600
Color: #141414
Padding: 10px
Border Radius: 39.5px
Font: Geist:Medium, 12px
Text: lowercase with capitalized first letter
Prefix: → arrow
```

#### Secondary Button (Black)
```css
Background: #000000
Color: #FFFFFF
Padding: 10px 26px
Border Radius: 39.5px
Font: Geist:Medium, 12px
Text: lowercase with capitalized first letter
Prefix: → arrow
```

#### Outlined Button
```css
Background: transparent
Border: 0.5px solid #FFFFFF
Color: #FFFFFF
Padding: 12px 27px
Border Radius: 39.5px
Font: Geist:Medium, 12px
```

#### Button States
- **Hover:** Gold Accent (#E9B217) for yellow buttons
- **Active:** Darken by 10%
- **Disabled:** 50% opacity

### Form Inputs

```css
Background: rgba(255,255,255,0.8)
Height: 42px
Border Radius: 39.5px
Padding: 0 24px
Font: Geist:Medium, 15px
Color: #141414
Label: Above input, 15px, #141414
Placeholder: #141414 with reduced opacity
```

**Search Bar (Header):**
```css
Background: transparent
Border: 0.5px solid #FFFFFF
Height: 42px
Border Radius: 39.5px
Color: #FFFFFF
Placeholder: "Rechercher un article"
Icon: → arrow (right aligned)
```

### Cards

#### Product Card
```css
Border: 0.5px solid #343434
Border Radius: 13px
Height: 409px
Width: 315px
Padding: 17px
Background: transparent
Hover: Overlay with rgba(0,0,0,0.7)
```

#### Image Card
```css
Border Radius: 13px
Width: 389px
Height: 497px
Object Fit: cover
Overlay: rgba(0,0,0,0.7) on hover
```

### Navigation

#### Menu Header
```css
Height: 45px
Background: transparent
Items: Spaced evenly
Font: Geist:Medium, 12px
Color: #FFFFFF
Active: Yellow background pill (#FFC600)
```

#### Sub-Menu
```css
Height: 60px
Background: transparent
Border Top: 0.5px solid divider
Font: Geist:Medium, 15px
Color: #FFFFFF
Hover: Underline
```

#### Footer Navigation
```css
Background: #141414
4-column layout
Headers: 15px, #FFFFFF
Links: 12px, #FFFFFF
Prefix: → arrow
Gap: 11-13px vertical spacing
```

### Badges

#### Cart Badge (Notification)
```css
Background: #FFFFFF (or brand color)
Color: #000000
Size: Circular
Diameter: 24px
Font: Geist:Medium, 10px
Position: Top-right of icon
```

#### Price Badge
```css
Background: Circular gradient
Size: 125.6px diameter
Color: #FFFFFF
Font: Flintstock:Round, 38px
Cents: 24.51px
Position: Overlaid on product images
```

### Carousels

```css
Gap: 10px between items
Navigation: Circular buttons with arrows
Swipe: Gesture-based (mobile)
Indicator: Dots below carousel
Active: White, Inactive: Gray
```

---

## Layout Grid

### Desktop (1512px container)

| Section | Width | Padding |
|---------|-------|---------|
| **Container** | 1512px | - |
| **Content Width** | 1238px | 137px sides |
| **Columns** | 5 (equal width) | 13px gap |

### Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| **Desktop** | 1512px+ | Full 5-column |
| **Tablet** | 768-1511px | 3-column, adjusted spacing |
| **Mobile** | 320-767px | Single column, stacked |

---

## Sections

### 1. Header (120px height)

**Components:**
- Logo (275px x 40px) - Left aligned
- Search bar (center) - ~400px width
- Account buttons (right) - ~124px each
- Cart icon with badge (right)

**Background:**
- Dark (#141414) with 50% opacity overlay on hero
- Fixed position on scroll

### 2. Hero Section (982px height)

**Layout:**
- Full-width background image
- Text overlay (left-aligned)
- CTA button
- Product showcase grid (3 columns)

**Content:**
- Heading: "Promotion de la semaine"
- Sub-heading/description
- Primary CTA button
- Product images (389px x 497px)

### 3. Sub-Navigation (60px height)

**Layout:**
- Horizontal menu below header
- 4 main items: MAGASINER, LE COIN DES PROS, SERVICE DE RÉPARATION, CARTE-CADEAU
- Border top: 0.5px divider

### 4. Brands Section

**Layout:**
- Section title (60px Flintstock)
- Horizontal scrolling product cards
- 5 cards visible at once
- Navigation arrows
- CTA button below

**Card Specs:**
- 315px x 409px
- Border: 0.5px #343434
- Image: full-width, auto height
- Overlay on hover

### 5. Engagement Module

**Components:**
- Dark background (#141414)
- 3-column layout
- Text content + CTA
- Background: Fixatech logo watermark

**Content:**
- Heading
- Description
- "DÉCOUVREZ NOS ENGAGEMENTS" button

### 6. Services Section

**Layout:**
- Section title
- 3 images (389px x 497px each)
- 3 CTA buttons (one per service)

**Services:**
- Service de réparation
- Le coin des Pros
- Le coin Brico

### 7. Newsletter Signup (982px height)

**Background:** #FFC600 (Yellow)

**Layout:**
- 2-column: Form (left) + Info text (right)

**Form Fields:**
- Nom (Name)
- Prénom (First name)
- Adresse courriel (Email)
- Mot de passe (Password)
- Intérêts (Interests) - Checkbox group

**CTA Buttons:**
- Créer un compte (Primary)
- Already have account (Link)
- Forgot password (Link)

### 8. Footer (982px height)

**Background:** #141414

**Layout:** 4 columns

1. **FIXATECH**
   - Address: 1010, route des Rivières, local 100, Lévis (Québec) G7A 2V1
   - Hours: 7H00 À 17H00, DU LUNDI AU VENDREDI
   - Contact CTA button

2. **PLAN DU SITE**
   - FIXATIONS
   - ÉQUIPEMENT
   - LE COIN DES PROS
   - RÉPARATION
   - CONDITIONS GÉNÉRALES
   - POLITIQUE DE CONFIDENTIALITÉ
   - NOS ENGAGEMENTS

3. **PLAN DU SITE (continued)**
   - PANIER
   - MON COMPTE

4. **SUIVEZ-NOUS**
   - FACEBOOK →
   - YOUTUBE →
   - LINKEDIN →

5. **INFOLETTRE**
   - Email input
   - Subscribe button

**Bottom Bar:**
- Fixatech logo (center)
- Copyright text (left)
- Design credit (right)

---

## Logo Assets

### Primary Logo
- **File:** Fixatech logo with 3 yellow stripes
- **Colors:** Yellow (#FFC600) + White
- **Sizes:**
  - Header: 275px x 40px
  - Footer: Large centered version

### Favicon
- Use simplified version of the 3-stripe icon
- Multiple sizes: 16x16, 32x32, 64x64

---

## Icons & Graphics

### Arrow Icon
- **Symbol:** →
- **Usage:** Button prefixes, navigation indicators
- **Font:** Geist:Medium, 12px
- **Color:** Inherits from parent

### Social Icons
- Style: Line icons (minimal)
- Size: 24px x 24px
- Color: #FFFFFF
- Hover: #FFC600

---

## Images

### Product Images
- **Aspect Ratio:** 3:4 (portrait) or 1:1 (square)
- **Sizes:**
  - Large: 389px x 497px
  - Medium: 315px x 409px
  - Thumbnail: 252px x 332px
- **Format:** WebP with JPG fallback
- **Optimization:** Compress to <100KB
- **Alt Text:** Required for accessibility

### Hero/Background Images
- **Size:** 1512px x 982px (full-width sections)
- **Format:** WebP
- **Overlay:** Dark overlay (rgba(0,0,0,0.7)) for text legibility
- **Optimization:** Progressive loading

### Brand Logos
- **Format:** SVG (scalable)
- **Fallback:** PNG @2x
- **Size:** Variable, maintain aspect ratio
- **Max height:** 80px

---

## Animation & Interactions

### Transitions
```css
Default: all 0.3s ease-in-out
Buttons: transform 0.2s ease
Images: opacity 0.3s ease
Overlays: background 0.3s ease
```

### Hover States
- **Buttons:** Scale(1.05) + color shift
- **Cards:** Overlay fade-in + subtle lift
- **Links:** Underline + color change to #FFC600
- **Images:** Zoom 1.1x (contained)

### Scroll Behaviors
- **Header:** Sticky/fixed on scroll with shadow
- **Carousels:** Smooth horizontal scroll
- **Parallax:** Subtle on hero background (optional)

---

## Accessibility

### Contrast Ratios
- **White on Dark (#141414):** 15.48:1 ✓ AAA
- **Yellow (#FFC600) on Dark:** 10.05:1 ✓ AAA
- **Black on Yellow:** 11.48:1 ✓ AAA
- **White on Black:** 21:1 ✓ AAA

### Focus States
- **Visible outline:** 2px solid #FFC600
- **Offset:** 2px from element
- **No focus:** Never remove for keyboard navigation

### ARIA Labels
- All interactive elements
- Icon-only buttons
- Navigation landmarks
- Form inputs with labels

### Keyboard Navigation
- Tab order: Logical flow
- Enter/Space: Activate buttons/links
- Escape: Close modals/dropdowns
- Arrow keys: Navigate carousels

---

## Responsive Behavior

### Mobile Adaptations (<768px)

**Typography:**
- H1: 60px → 48px
- H2: 48px → 36px
- Body: 15px → 14px
- Buttons: 12px (maintain)

**Layout:**
- Single column
- Horizontal scroll for carousels
- Stacked navigation (hamburger menu)
- Full-width cards
- Reduced padding: 24px sides

**Images:**
- Full-width with maintained aspect ratio
- Reduced heights for hero sections
- Lazy loading below fold

**Forms:**
- Full-width inputs
- Stacked buttons
- Larger touch targets (48px min)

### Tablet (768px - 1511px)

**Layout:**
- 2-3 column grid
- Adjusted padding: 48px sides
- Maintain desktop typography with slight reduction

---

## Component Mapping to Shopify

| Component | Shopify Section Type | Theme Block |
|-----------|---------------------|-------------|
| **Header** | `header.liquid` | Navigation, Cart, Search |
| **Hero** | `hero.liquid` section | Image-with-text |
| **Product Carousel** | `featured-collection.liquid` | Product-card |
| **Services Grid** | `multicolumn.liquid` | Column-with-image |
| **Newsletter** | `newsletter.liquid` | Email-signup |
| **Footer** | `footer.liquid` | Footer-group |

---

## Implementation Notes

### Fonts
- **Flintstock:Round:** Custom font - needs to be uploaded to Shopify
  - Include .woff2 and .woff formats
  - Add font-display: swap for performance
- **Geist:Medium:** System font or web font
  - Fallback: Arial, Helvetica, sans-serif

### CSS Variables
Define in `theme.css`:

```css
:root {
  /* Colors */
  --color-primary: #FFC600;
  --color-background-dark: #141414;
  --color-black: #000000;
  --color-white: #FFFFFF;
  --color-text-dark: #333333;
  --color-border: #343434;
  --color-overlay-light: rgba(255,255,255,0.8);
  --color-overlay-dark: rgba(0,0,0,0.7);

  /* Typography */
  --font-heading: 'Flintstock Round', sans-serif;
  --font-body: 'Geist', Arial, sans-serif;
  --font-weight-medium: 500;

  /* Spacing */
  --spacing-xs: 10px;
  --spacing-sm: 13px;
  --spacing-md: 26px;
  --spacing-lg: 137px;

  /* Border Radius */
  --radius-sm: 13px;
  --radius-md: 39.5px;

  /* Transitions */
  --transition-base: all 0.3s ease-in-out;
  --transition-fast: all 0.2s ease;
}
```

### Performance
- **Images:** Use Shopify's image CDN with size parameters
- **Fonts:** Subset to include only used characters (French + English)
- **Critical CSS:** Inline above-the-fold styles
- **Lazy Loading:** Implement for images below fold
- **Code Splitting:** Load sections on demand

---

## Design Tokens Export

For use with Shopify theme editor:

```json
{
  "colors": {
    "primary": "#FFC600",
    "background_dark": "#141414",
    "black": "#000000",
    "white": "#FFFFFF"
  },
  "typography": {
    "heading_font": "Flintstock Round",
    "body_font": "Geist",
    "heading_size": "60px",
    "body_size": "15px"
  },
  "spacing": {
    "small": "10px",
    "medium": "26px",
    "large": "137px"
  }
}
```

---

## Figma Assets to Download

### Required Downloads:
1. **Logo Assets:**
   - Fixatech logo (SVG)
   - Fixatech icon (3 stripes)

2. **Product Images:**
   - All product photos from carousel
   - Hero section images
   - Service section images

3. **Icons:**
   - Social media icons
   - Arrow icons
   - UI icons (cart, account, search)

4. **Fonts:**
   - Flintstock:Round (if licensed)
   - Geist:Medium font files

### Asset URLs (from Figma MCP):
All assets are available at: `https://www.figma.com/api/mcp/asset/[asset-id]`

**Note:** Assets expire after 7 days and need to be downloaded and hosted on Shopify CDN.

---

## Browser Support

### Target Browsers:
- Chrome/Edge: Last 2 versions
- Firefox: Last 2 versions
- Safari: Last 2 versions
- iOS Safari: Last 2 versions
- Android Chrome: Last 2 versions

### Fallbacks:
- **CSS Grid:** Flexbox fallback
- **WebP Images:** JPG fallback
- **Custom Fonts:** System font stack fallback
- **CSS Variables:** Sass variables for preprocessing

---

## Quality Checklist

### Visual QA:
- [ ] All typography matches Figma exactly
- [ ] Colors match design system (use color picker)
- [ ] Spacing matches specification (8px grid)
- [ ] Border radius consistent across components
- [ ] Images properly sized and optimized
- [ ] Hover states implemented
- [ ] Focus states visible

### Functional QA:
- [ ] All links work
- [ ] Forms submit correctly
- [ ] Search functions properly
- [ ] Cart adds/removes items
- [ ] Navigation accessible via keyboard
- [ ] Mobile menu functions
- [ ] Carousels swipe on touch devices

### Performance QA:
- [ ] Lighthouse score >90
- [ ] All images lazy-loaded
- [ ] Critical CSS inlined
- [ ] Fonts loaded efficiently
- [ ] No layout shift (CLS <0.1)
- [ ] First Contentful Paint <1.5s

### Accessibility QA:
- [ ] WCAG 2.1 AA compliant
- [ ] Screen reader tested
- [ ] Keyboard navigation works
- [ ] Alt text on all images
- [ ] Form labels associated
- [ ] Color contrast ratios pass
- [ ] Focus indicators visible

---

## Document History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2026-01-27 | 1.0 | Initial design system specification from Figma | Will |

---

## References

- **Figma File:** https://www.figma.com/design/T0UWoZjMrE5Zr43fh9A0FO/Fixatech
- **Node ID:** 1:103 (Landing Page)
- **Shopify Theme Documentation:** https://shopify.dev/docs/themes
- **WCAG Guidelines:** https://www.w3.org/WAI/WCAG21/quickref/
