# Scamper Checklist — Release Validation

Run before every version tag. Takes ~20 minutes. This is a regression check, not a full audit.

**Version being validated:** ____________  
**Date:** ____________  
**Tester:** ____________  
**Demo URL:** `https://demo.squirrels.ninja`

---

## 1. Lighthouse Scores

Run Lighthouse against homepage, shop, and one product page. These three pages cover the critical path.

```bash
lhci autorun --config=setup/lighthouserc.json
```

| Page | Performance | Accessibility | Pass? |
|------|-------------|---------------|-------|
| Homepage | | | |
| Shop | | | |
| Product | | | |

**Thresholds:** Performance ≥ 85 · Accessibility ≥ 95

- [ ] All pages pass Performance threshold
- [ ] All pages pass Accessibility threshold (hard block if any fail)

---

## 2. Core Web Vitals

Check in Chrome DevTools → Performance panel or via CrUX data.

| Metric | Homepage | Shop | Target |
|--------|----------|------|--------|
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| CLS | | | < 0.05 |

- [ ] LCP passes on homepage
- [ ] INP passes on homepage
- [ ] CLS passes on homepage and shop

---

## 3. JavaScript

- [ ] No jQuery dependency in theme JS (after T7.4 is merged)
- [ ] `main.js` loads in footer, no render blocking
- [ ] No console errors on homepage, shop, or product page
- [ ] DevTools → Network: no unexpected third-party scripts added

---

## 4. CSS

- [ ] `brand-tokens.css` tokens are available (check `--squirrels-primary` in DevTools → Computed)
- [ ] No render-blocking CSS (Lighthouse → Opportunities → Eliminate render-blocking resources)
- [ ] Pattern CSS loads only on pages with block content (after T7.3)
- [ ] No new `!important` overrides added outside WooCommerce compatibility rules

---

## 5. Fonts

- [ ] Headings render in Geist (or documented system fallback if self-hosting not yet complete)
- [ ] Body renders in Inter (or documented system fallback)
- [ ] No FOIT (flash of invisible text) visible on slow connection
- [ ] `font-display: swap` confirmed in `@font-face` rules (after T7.7)

---

## 6. Images

- [ ] Product images have `loading="lazy"` on shop and product pages
- [ ] No missing `alt` attributes (Lighthouse → Accessibility → Image alt attributes)
- [ ] Pattern placeholder images replaced with real content on demo site

---

## 7. WooCommerce Patterns

- [ ] WooCommerce patterns (`best-sellers`, `new-arrivals`, `product-grid`) load products correctly
- [ ] `product-collection` shows correct count per pattern
- [ ] WooCommerce patterns hidden in pattern inserter when WooCommerce is deactivated (test on staging)

---

## 8. Mobile

Test in Chrome DevTools → device emulation → iPhone SE (375×667)

- [ ] Homepage: no horizontal scroll
- [ ] Shop: single-column product grid
- [ ] Mobile navigation opens and closes
- [ ] CTA Banner and Sale Banner stack vertically
- [ ] Newsletter form stacks (email input above button)
- [ ] Trust badges stack to single column

---

## 9. Accessibility

- [ ] Tab order is logical on homepage (header → main → footer)
- [ ] Skip-to-content link functional
- [ ] Focus rings visible on all interactive elements
- [ ] All buttons and links have accessible labels (no "click here" or "read more" without context)
- [ ] Colour contrast passes on new or modified elements (check with axe DevTools or similar)

---

## 10. No Regressions

- [ ] Customizer still saves and previews colors correctly
- [ ] Acorn importer page loads without errors
- [ ] All pattern categories visible in block editor
- [ ] Child theme still activates without PHP errors

---

## Pass / Fail

| Section | Pass | Fail | Notes |
|---------|------|------|-------|
| 1. Lighthouse scores | | | |
| 2. Core Web Vitals | | | |
| 3. JavaScript | | | |
| 4. CSS | | | |
| 5. Fonts | | | |
| 6. Images | | | |
| 7. WooCommerce patterns | | | |
| 8. Mobile | | | |
| 9. Accessibility | | | |
| 10. No regressions | | | |

**Result:** ⬜ Pass — ready to tag  &nbsp;&nbsp; ⬜ Fail — fix before tagging
