# L3.7 — Lighthouse Performance Baseline

Recorded immediately after QA passes. These numbers become the official T7 (Scamper) baseline — no optimizations applied, clean v1.0.0 install.

**Date captured:** ____________  
**Theme version:** 1.0.0  
**WordPress version:** ____________  
**WooCommerce version:** ____________  
**Hosting:** ____________  
**Server region:** ____________  
**Tool:** Lighthouse CLI 3× average (see `setup/lighthouserc.json`)

---

## How to run

```bash
# Install Lighthouse CI
npm install -g @lhci/cli@0.14

# Run baseline (from squirrels-demo/setup/)
lhci autorun --config=lighthouserc.json

# Or run manually for a single URL
npx lighthouse https://demo.squirrels.ninja \
  --form-factor=desktop \
  --output=json \
  --output-path=./baseline/homepage-$(date +%Y%m%d).json
```

---

## Baseline Scores (fill in after running)

### Homepage (`/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| Best Practices | | |
| SEO | | |
| FCP (First Contentful Paint) | | |
| LCP (Largest Contentful Paint) | | |
| INP (Interaction to Next Paint) | | |
| TBT (Total Blocking Time) | | |
| CLS (Cumulative Layout Shift) | | |
| TTI (Time to Interactive) | | |
| Speed Index | | |

---

### Shop (`/shop/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| Best Practices | | |
| SEO | | |
| FCP | | |
| LCP | | |
| INP | | |
| TBT | | |
| CLS | | |
| TTI | | |

---

### Product Page (`/shop/classic-cotton-tee/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| Best Practices | | |
| SEO | | |
| FCP | | |
| LCP | | |
| INP | | |
| TBT | | |
| CLS | | |
| TTI | | |

---

### Cart (`/cart/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| FCP | | |
| LCP | | |
| INP | | |
| TBT | | |

---

### Checkout (`/checkout/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| FCP | | |
| LCP | | |
| INP | | |
| TBT | | |

---

### Blog (`/blog/`)

| Metric | Score | Raw value |
|--------|-------|-----------|
| Performance | | |
| Accessibility | | |
| FCP | | |
| LCP | | |
| INP | | |
| TBT | | |

---

## Notable Audit Failures

List any Lighthouse audits that failed (🔴) or warned (🟡). These become T7 work items.

| Audit | Page | Severity | Description |
|-------|------|----------|-------------|
| | | | |
| | | | |

---

## T7 Targets (fill in after reviewing baseline)

After recording the baseline, set improvement targets for T7 (Scamper):

| Metric | Baseline | T7 Target |
|--------|---------|-----------|
| Homepage Performance | | ≥90 |
| Homepage LCP | | <2.5s |
| Homepage INP | | <200ms |
| Homepage TBT | | <200ms |
| Homepage CLS | | <0.05 |
| Shop Performance | | ≥85 |
| Product Performance | | ≥85 |

---

## Notes

_Record any observations about the server environment, cache state, or external factors that may affect these numbers._
