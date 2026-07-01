# Scamper Report — v1.1.0

**Theme version:** 1.1.0  
**Baseline captured:** ____________  
**Optimization complete:** ____________  
**Author:** ____________  
**Hosting:** WPMU DEV Managed Hosting  
**WordPress version:** ____________  
**WooCommerce version:** ____________  
**PHP version:** ____________

---

## Scamper Score

| | Baseline | After T7 | Δ |
|--|---------|----------|---|
| **Scamper Score** (avg Performance) | — | — | — |

---

## Lighthouse Results — Baseline (before optimization)

### Homepage (`/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| Best Practices | | | ≥ 90 |
| SEO | | | ≥ 90 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |
| CLS | | | < 0.05 |
| TTI | | | < 3.8s |

---

### Shop (`/shop/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| Best Practices | | | ≥ 90 |
| SEO | | | ≥ 90 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |
| CLS | | | < 0.05 |

---

### Product Page (`/shop/classic-cotton-tee/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |
| CLS | | | < 0.05 |

---

### Cart (`/cart/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |

---

### Checkout (`/checkout/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |

---

### Blog (`/blog/`)

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| FCP | | | < 1.8s |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |
| CLS | | | < 0.05 |

---

### Pattern Landing Page (custom)

*Create a page with: Hero Store + Features Three + Testimonials + CTA Banner*

| Metric | Baseline | After T7 | Target |
|--------|----------|----------|--------|
| Performance | | | ≥ 85 |
| Accessibility | | | ≥ 95 |
| LCP | | | < 2.5s |
| INP | | | < 200ms |
| TBT | | | < 200ms |
| CLS | | | < 0.05 |

---

## T7.2 — Asset Audit

### CSS

| Asset | Transfer size | Notes |
|-------|--------------|-------|
| `main.css` | 18.5KB (uncompressed) | |
| `brand-tokens.css` | 13.8KB (uncompressed) | Not currently enqueued |
| `style.css` (root) | ~0.5KB | Theme header only |
| **Total CSS** | | To measure on live site |
| Unused CSS (DevTools Coverage) | | % on homepage |

### JavaScript

| Asset | Transfer size | Notes |
|-------|--------------|-------|
| `main.js` | 406B | Depends on jQuery (~30KB gzipped) |
| jQuery (WordPress bundled) | ~30KB gzipped | Loaded on all pages via theme |
| WooCommerce JS (cart) | | To measure on live site |
| **Total JS** | | To measure on live site |
| Unused JS (DevTools Coverage) | | % on homepage |

### Fonts

| Font | Load method | Status |
|------|------------|--------|
| Geist | Not loaded | CSS var references only; falls back to system font |
| Inter | Not loaded | CSS var references only; falls back to system font |
| JetBrains Mono | Not loaded | CSS var references only; falls back to system font |

### Pre-identified issues (from static analysis)

| Issue | Severity | T7 task |
|-------|----------|---------|
| jQuery dependency for menu toggle only | High | T7.4 |
| Fonts not enqueued | High | T7.7 |
| `brand-tokens.css` not enqueued | Medium | T7.3 |
| No WooCommerce page conditionals | Medium | T7.5 |
| Pattern CSS bundled into main.css (loads everywhere) | Low | T7.3 |

---

## T7.2.5 — Asset Inventory

Complete after recording baseline. Measure in Chrome DevTools → Network (no cache, slow 3G) per page type.

| Asset | Raw size | Gzip size | Loads on | Conditional? | Deferrable? | Decision |
|-------|----------|-----------|----------|--------------|-------------|----------|
| `main.css` | 18.5KB | | All pages | No | No | Keep; merge tokens into it |
| `brand-tokens.css` | 13.8KB | | **Nowhere** | No | — | Merge `:root` block into `main.css`; archive file |
| `style.css` (root) | ~0.5KB | | All pages | No | No | Keep (WP theme requirement) |
| `main.js` | 406B | | All pages | No | Yes (footer) | Remove jQuery dep; vanilla menu toggle |
| `jquery.js` (WP bundled) | ~87KB | | All pages | No | No | Remove theme dep; WC loads it on shop pages anyway |
| `demo-import.css` | 1.5KB | | Admin only | Yes | — | Already conditional; keep |
| `demo-import.js` | 1.6KB | | Admin only | Yes | — | Already conditional; keep |
| WooCommerce CSS | | | | | | Measure on live site; add `squirrels_is_woocommerce_page()` gate |
| `wc-cart-fragments.js` | | | All pages | No | — | Gate on `is_cart() \|\| is_checkout()` if no header cart count |
| **Total CSS** | | | | | | |
| **Total JS** | | | | | | |

**Brand token decision (choose before T7.3):**  
- [ ] Path A — inline `:root` block via `wp_head`  
- [ ] Path B — merge `:root` block into `main.css`, archive `brand-tokens.css`

---

## T7.3–T7.8 — Optimization Log

Document each change as it is made (in recommended execution order).

| Date | T7 task | File(s) changed | Description | Impact |
|------|---------|----------------|-------------|--------|
| | T7.4 (jQuery) | | | |
| | T7.7 (Fonts) | | | |
| | T7.3 (CSS/tokens) | | | |
| | T7.5 (WooCommerce) | | | |
| | T7.6 (Images) | | | |

---

## Failed Lighthouse Audits

List audits flagged 🔴 or 🟡 in the baseline run. These become the T7 work queue.

| Audit | Page(s) | Severity | Notes |
|-------|---------|----------|-------|
| | | | |

---

## Notes

*Server environment, cache state, or external factors affecting scores:*

