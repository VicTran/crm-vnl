---
name: Literary Heritage CRM
colors:
  surface: '#fff8f4'
  surface-dim: '#e4d8cc'
  surface-bright: '#fff8f4'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fff1e5'
  surface-container: '#f9ecdf'
  surface-container-high: '#f3e6da'
  surface-container-highest: '#ede0d4'
  on-surface: '#211b13'
  on-surface-variant: '#514535'
  inverse-surface: '#362f27'
  inverse-on-surface: '#fcefe2'
  outline: '#837563'
  outline-variant: '#d6c4b0'
  surface-tint: '#825500'
  primary: '#825500'
  on-primary: '#ffffff'
  primary-container: '#c8881c'
  on-primary-container: '#412800'
  inverse-primary: '#ffb952'
  secondary: '#6b5c4a'
  on-secondary: '#ffffff'
  secondary-container: '#f1dcc6'
  on-secondary-container: '#6f604e'
  tertiary: '#6d5c46'
  on-tertiary: '#ffffff'
  tertiary-container: '#a6927a'
  on-tertiary-container: '#392b19'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffddb3'
  primary-fixed-dim: '#ffb952'
  on-primary-fixed: '#291800'
  on-primary-fixed-variant: '#633f00'
  secondary-fixed: '#f4dfc9'
  secondary-fixed-dim: '#d7c3ae'
  on-secondary-fixed: '#241a0c'
  on-secondary-fixed-variant: '#524434'
  tertiary-fixed: '#f7dfc4'
  tertiary-fixed-dim: '#d9c3a9'
  on-tertiary-fixed: '#251909'
  on-tertiary-fixed-variant: '#544430'
  background: '#fff8f4'
  on-background: '#211b13'
  surface-variant: '#ede0d4'
typography:
  display-lg:
    fontFamily: Literata
    fontSize: 48px
    fontWeight: '300'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Literata
    fontSize: 32px
    fontWeight: '300'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Literata
    fontSize: 28px
    fontWeight: '300'
    lineHeight: 36px
  headline-md:
    fontFamily: Literata
    fontSize: 24px
    fontWeight: '300'
    lineHeight: 32px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '300'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '300'
    lineHeight: 24px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.05em
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-padding-desktop: 40px
  container-padding-mobile: 20px
  gutter: 24px
  section-gap: 64px
---

## Brand & Style
The design system for this CRM evokes the quiet, intellectual atmosphere of a private heritage library, reimagined through a modern lens. It targets book collectors, curators, and boutique publishers who value tradition and precision. 

The aesthetic is a sophisticated blend of **Modern Minimalism** and **Glassmorphism**. It utilizes heavy whitespace to create a sense of "tranquility," while technical elements are softened by translucent layers. The emotional response is one of calm authority—a tool that feels as much like a leather-bound ledger as it does a high-performance software suite.

## Colors
The palette is rooted in earth tones and precious metals. **Amber Gold** serves as the primary action color, used sparingly for emphasis and high-priority interactions. **Deep Espresso** provides the structural grounding, used for text and deep iconography to ensure legibility.

**Soft Cream** and **Sand** form the primary canvas, replacing stark whites to reduce eye strain and enhance the "paper-like" feel. **Muted Earth** and **Warm Grey** are used for secondary UI elements, borders, and metadata, maintaining a low-contrast, harmonious visual hierarchy that feels organic and timeless.

## Typography
The typographic system relies on a high-contrast pairing between a bookish serif and a clinical sans-serif. 

**Literata** is used for all headings and display text. Its scholarly, refined character is emphasized by using a Light (300) weight, which gives the interface an editorial, high-end appearance. 

**Inter** handles all functional UI, data entry, and body copy. By maintaining a 300 weight for body text, the interface remains airy and modern. Label styles use a slightly heavier weight and increased letter spacing to ensure utility and navigation are never lost within the aesthetic.

## Layout & Spacing
The layout follows a **Fixed Grid** philosophy on desktop to mimic the structured layout of a printed book. It utilizes a 12-column system with generous 40px outer margins to provide "breathing room."

Spacing is governed by an 8px scale, but preference is always given to larger increments (24px, 32px, 64px) to prevent the UI from feeling cluttered. On mobile, the layout reflows to a single column with reduced margins, while maintaining the vertical rhythm of the section gaps to preserve the sense of tranquility.

## Elevation & Depth
Depth is achieved through **Glassmorphism** rather than traditional heavy shadows. Surfaces use a semi-transparent "Soft Cream" fill with a background blur (Backdrop Filter: 12px-20px).

Key hierarchical decisions:
- **Tonal Layers:** The background is "Sand," while active workspace panels are "Soft Cream."
- **Frosted Surfaces:** Floating cards and navigation menus use 80% opacity with a blur to allow background colors to bleed through subtly.
- **Outlines:** All elevated containers feature a 0.5px or 1px border in "Warm Grey" at low opacity (20%) to define edges without adding visual weight.
- **Ambient Shadows:** When used, shadows are highly diffused, using "Deep Espresso" at 5% opacity to avoid a "dirty" look.

## Shapes
The shape language is contemporary and inviting. While the base system uses a "Rounded" (0.5rem) standard for smaller elements like inputs and buttons, **Cards** and primary containers utilize a specific **20px radius**. 

This oversized corner radius softens the architectural layout of the CRM, making the professional tool feel more approachable. Buttons use a more conservative 8px radius to maintain a sense of precision and "clickability."

## Components

### Cards
Cards are the primary container. They must feature a `backdrop-filter: blur(16px)`, a background color of `rgba(251, 248, 241, 0.8)`, and a 1px border of `rgba(168, 153, 128, 0.3)`. The 20px corner radius is mandatory for all main dashboard cards.

### Buttons
- **Primary:** Amber Gold (#C8881C) background with Deep Espresso text. No shadows; flat but vibrant.
- **Secondary:** Transparent background with a Deep Espresso 1px border and Amber Gold text for a "ghost" effect.
- **Tertiary:** Text-only in Muted Earth, used for low-emphasis actions.

### Input Fields
Inputs use the "Sand" color for the background to distinguish them from the "Soft Cream" cards. The bottom border is emphasized over a full box stroke to mimic the lines of a notebook. Focus states should transition the bottom border to Amber Gold.

### Lists & Data Tables
Tables should avoid vertical grid lines. Use horizontal rules in "Warm Grey" (10% opacity). The "Deep Espresso" text should be used for primary data, while "Warm Grey" handles metadata.

### Chips & Tags
Small, pill-shaped tags with "Sand" backgrounds and "Muted Earth" text. These should be understated, serving as subtle organizational markers rather than focal points.