# L3.5 — Functional QA Checklist

Test each item on desktop (1440px) and mobile (375px) unless noted.

**Demo URL:** `https://demo.squirrels.ninja`  
**Browser:** Chrome latest (clear cache before starting)  
**Date tested:** ____________  
**Tester:** ____________

---

## Homepage

- [ ] Page loads without errors (check browser console)
- [ ] Hero section renders correctly — heading, paragraph visible
- [ ] Header logo visible and links to homepage
- [ ] Primary navigation renders — all menu items visible and linked
- [ ] Footer renders — copyright text, links functional
- [ ] "Add to Cart" buttons on any featured products work
- [ ] Page is responsive at 375px — no horizontal scroll

---

## Shop Archive (`/shop/`)

- [ ] Page loads with product grid (12 products expected)
- [ ] Product cards show: image, name, price
- [ ] Sale badges show on discounted products
- [ ] Featured products (3) show a featured indicator or appear correctly
- [ ] Pagination renders if more than one page
- [ ] Category navigation (if present) filters correctly
- [ ] Sort dropdown works (price low-high, high-low, latest)
- [ ] Mobile: grid collapses to 1 column at 375px

---

## Product Page (test on 2+ products)

### SQ-CLO-001 — Classic Cotton Tee
- [ ] `/shop/classic-cotton-tee/` loads without 404
- [ ] Product image displays
- [ ] Name, price, and sale price display correctly ($22.00 sale / $29.00 regular)
- [ ] "Add to Cart" button works
- [ ] Quantity selector works
- [ ] Short description renders below title
- [ ] Full description renders in the Description tab
- [ ] Related products section visible (shows other products)

### SQ-HOM-001 — Ceramic Pour-Over Set
- [ ] `/shop/ceramic-pour-over-set/` loads
- [ ] Sale price shown correctly ($38.00 sale / $48.00 regular)
- [ ] Add to cart works

---

## Cart (`/cart/`)

- [ ] After adding a product, cart icon shows item count
- [ ] `/cart/` shows the cart table with correct items
- [ ] Quantities can be updated
- [ ] Items can be removed
- [ ] Subtotal, shipping, and total display correctly
- [ ] "Proceed to Checkout" button links to `/checkout/`
- [ ] Empty cart state: message shows when cart is cleared

---

## Checkout (`/checkout/`)

- [ ] Page loads the checkout form
- [ ] Billing fields render (name, address, email, phone)
- [ ] "Cash on Delivery" payment method is visible and selected by default
- [ ] No other payment gateways showing
- [ ] Order Notes field present
- [ ] "Place Order" button is present and correctly labeled
- [ ] Form validation fires on empty required fields
- [ ] Complete a test order end-to-end:
  - [ ] Fill billing fields
  - [ ] Click "Place Order"
  - [ ] Redirected to `/order-received/` (or `/checkout/order-received/`)
  - [ ] Order confirmation number shown
  - [ ] Confirmation email received (check ADMIN_EMAIL inbox)

---

## My Account (`/my-account/`)

- [ ] Page renders with login form
- [ ] Login with test credentials created during checkout
- [ ] Dashboard shows: Orders, Downloads, Addresses, Payment methods, Account details
- [ ] "Orders" tab shows the test order placed above
- [ ] Order detail page shows correct items and totals
- [ ] "Logout" link works

---

## Blog (`/blog/` or `/`)

- [ ] Blog archive page renders (may be homepage in non-store configurations)
- [ ] Post cards show: title, excerpt, date, featured image (placeholder or default)
- [ ] Click a post → single post renders correctly
- [ ] Post title, content, date, categories visible
- [ ] Comments section present (even if empty)
- [ ] Back to blog navigation works

---

## Search

- [ ] Search form in header/navigation works
- [ ] Searching for "tote" returns Canvas Market Tote
- [ ] Searching for "ceramic" returns Ceramic Pour-Over Set
- [ ] Empty search results: graceful "nothing found" message

---

## 404 Page

- [ ] Visit a nonexistent URL (e.g. `/this-does-not-exist/`)
- [ ] Custom 404 page renders (not server error, not blank)
- [ ] Navigation is still present
- [ ] Link back to homepage works

---

## Admin Smoke Check

- [ ] Log into `/wp-admin/` with admin credentials
- [ ] WooCommerce → Orders → view the test order placed above
- [ ] Appearance → Acorn: the importer page renders correctly
- [ ] Appearance → Customize: opens and shows Squirrels panels
- [ ] WooCommerce → Products: all 12 products visible

---

## Mobile (375px viewport — iPhone SE)

Test in Chrome DevTools → Device toolbar → iPhone SE

- [ ] Homepage: hero readable, nav accessible
- [ ] Mobile menu opens and closes
- [ ] Shop: 1-column product grid
- [ ] Product page: image full-width, add-to-cart accessible
- [ ] Cart: table readable, not broken
- [ ] Checkout: form fields stack correctly, no overflow
- [ ] Footer: readable, links tappable

---

## Pass / Fail Summary

| Area | Pass | Fail | Notes |
|------|------|------|-------|
| Homepage | | | |
| Shop archive | | | |
| Product pages | | | |
| Cart | | | |
| Checkout + order | | | |
| My Account | | | |
| Blog | | | |
| Search | | | |
| 404 | | | |
| Admin | | | |
| Mobile | | | |

**Overall result:** ⬜ Pass &nbsp;&nbsp; ⬜ Fail  
**Issues to fix:** (list below)
