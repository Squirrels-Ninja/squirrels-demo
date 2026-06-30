# L3.6 — Content & Design QA Checklist

Verify that the visual design is correct and consistent across the demo site.

**Demo URL:** `https://demo.squirrels.ninja`  
**Browser:** Chrome latest + Safari (WebKit check)  
**Date tested:** ____________  
**Tester:** ____________

---

## Typography

- [ ] Headings use Geist (or Inter fallback if Geist not loaded) — verify in DevTools → Computed
- [ ] Body text uses Inter (or system font stack) — legible at 16px
- [ ] Code/monospace elements use JetBrains Mono (if any present)
- [ ] No Times New Roman or serif fallback rendering anywhere
- [ ] Heading hierarchy is consistent: H1 only once per page, H2 for sections, H3 for cards
- [ ] Line height is comfortable — not tight, not excessively loose
- [ ] Letter-spacing on large headings is slightly negative (tight, modern feel)

---

## Color

- [ ] Interactive orange (`#C94F10`) used for: primary buttons, links in body text
- [ ] Display orange (`#E8621A`) visible only in the icon/brand mark context
- [ ] No pure black text (`#000000`) — body text should be charcoal (`#1A1714`)
- [ ] No default WordPress blue (`#0073aa`) anywhere
- [ ] Cream (`#FDF5EC`) used for hero/surface areas where applicable
- [ ] Error/accent color (`#B91C1C`) appears on sale badges and error states
- [ ] Focus rings are visible and use the orange focus color
- [ ] All text passes visual contrast check (no light gray on white)

---

## Buttons

- [ ] Primary buttons: orange background, white text, rounded corners
- [ ] Hover state: slightly darker orange (no jarring color jump)
- [ ] "Add to Cart" button matches primary style
- [ ] "Proceed to Checkout" matches primary style
- [ ] "Place Order" matches primary style
- [ ] No default grey WordPress/WooCommerce button styles remaining
- [ ] Button text is readable at normal size (not tiny, not huge)
- [ ] Disabled buttons (out of stock etc.) are visually distinct

---

## Forms

- [ ] Input fields have consistent border style
- [ ] Focus state: orange border + focus ring visible on all inputs
- [ ] Labels are visible and not overlapping placeholder text
- [ ] Error states show below the relevant field (not just at the top)
- [ ] Checkbox and radio elements styled (not default browser grey)
- [ ] Form placeholder text is lighter than label text
- [ ] Checkout form fields align cleanly in the column layout

---

## Header

- [ ] Logo renders at correct size — not too large, not too small
- [ ] Navigation links have correct active/hover states
- [ ] Cart icon (if present) shows item count badge correctly
- [ ] Header is sticky or returns on scroll (depending on design intent)
- [ ] Header does not overlap page content on any viewport
- [ ] Mobile: hamburger menu icon visible at 375px
- [ ] Mobile menu: slides in or drops down cleanly, all items accessible

---

## Footer

- [ ] Footer renders with correct copyright text
- [ ] Footer shows demo notice: "This is a demonstration store. No real orders are processed."
- [ ] Footer links (if any) are functional
- [ ] No "Proudly powered by WordPress" default text unless intentional
- [ ] Footer background and text colors are consistent with the design
- [ ] Footer does not have extra empty space above it
- [ ] Footer is visible on all viewports (not cut off on mobile)

---

## Images

- [ ] Product images are all the same aspect ratio (1:1 square)
- [ ] No broken image icons (all 12 products have images)
- [ ] Images are responsive — not overflowing their containers at any viewport
- [ ] Hero image (if present) scales correctly on mobile
- [ ] No layout shift from slow-loading images (check CLS in DevTools)
- [ ] Alt text is present on all product images (check via DevTools → Elements)

---

## Cards (Product Grid)

- [ ] All product cards are the same height in the grid
- [ ] Card hover effect is subtle — a slight elevation or shadow lift
- [ ] Sale badge is consistently positioned (top-left or top-right)
- [ ] Product name truncates gracefully if too long (no overflow)
- [ ] Price displays cleanly: regular price struck through when on sale
- [ ] "Add to Cart" button visible on card (hover or always-visible)

---

## Spacing & Layout

- [ ] Content is not edge-to-edge — appropriate padding/margin on all viewports
- [ ] No content overflows its container (check by resizing window from 320px–1920px)
- [ ] Section spacing is consistent — not cramped, not too loose
- [ ] Sidebar (on blog/shop if enabled) does not collapse into content unexpectedly
- [ ] Container max-width is appropriate (content readable on large monitors)

---

## Responsive Layout Checks

Test at these specific widths in Chrome DevTools:

| Width | Key checks |
|-------|-----------|
| 375px | Mobile — 1 column, nav menu, tap targets |
| 414px | iPhone 14 Pro — similar to 375px |
| 768px | Tablet — 2-column product grid |
| 1024px | Small desktop — full layout appears |
| 1440px | Standard desktop — target layout |
| 1920px | Large monitor — content stays centered |

- [ ] 375px — no horizontal scroll
- [ ] 768px — product grid shows 2 columns
- [ ] 1024px — sidebar appears (if layout = right)
- [ ] 1440px — full layout, correct widths
- [ ] 1920px — content centered, no extreme stretching

---

## Browser Checks

- [ ] Chrome (latest): full pass
- [ ] Safari (latest): no layout differences
- [ ] Firefox (latest): fonts render correctly
- [ ] Edge (latest): no issues
- [ ] iOS Safari on iPhone: test on device or BrowserStack

---

## Pass / Fail Summary

| Area | Pass | Fail | Notes |
|------|------|------|-------|
| Typography | | | |
| Color | | | |
| Buttons | | | |
| Forms | | | |
| Header | | | |
| Footer | | | |
| Images | | | |
| Cards | | | |
| Spacing & Layout | | | |
| Responsive | | | |
| Cross-browser | | | |

**Overall result:** ⬜ Pass &nbsp;&nbsp; ⬜ Fail  
**Design issues to fix:** (list below)
