#!/usr/bin/env bash
# =============================================================================
# Squirrels Demo Site — WP-CLI Setup Script
# L3: Automated demo site configuration
#
# Prerequisites:
#   - WordPress core files are on the server
#   - wp-config.php is configured (DB credentials set)
#   - WP-CLI is installed and `wp` is in $PATH
#   - Run from the WordPress root directory
#   - Update the CONFIG section below before running
#
# Usage:
#   cd /path/to/wordpress-root
#   bash /path/to/install.sh
# =============================================================================

set -euo pipefail

# ============================================================
# CONFIG — Edit before running
# ============================================================
DEMO_URL="https://demo.squirrels.ninja"
ADMIN_USER="squirrels-admin"
ADMIN_EMAIL="admin@squirrels.ninja"
SITE_TITLE="Squirrels Demo Store"

THEME_ZIP=""          # Path to squirrels-1.0.0.zip, e.g. /tmp/squirrels-1.0.0.zip
PRODUCTS_CSV=""       # Path to products.csv, e.g. /tmp/products.csv

STORE_ADDRESS="123 Demo Street"
STORE_CITY="Portland"
STORE_STATE="US:OR"
STORE_POSTCODE="97201"
STORE_CURRENCY="USD"

# ============================================================
# Helpers
# ============================================================
ok()      { echo "  ✓ $*"; }
section() { echo ""; echo "--- $* ---"; }

# ============================================================
# Pre-flight
# ============================================================
echo "============================================"
echo "  Squirrels Demo Site Setup"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================"

if ! command -v wp &> /dev/null; then
  echo "  ✗ WP-CLI not found. Install from https://wp-cli.org/"
  exit 1
fi

wp --info | grep "WP-CLI version"

[[ -z "$THEME_ZIP" ]]    && { echo "  ✗ Set THEME_ZIP in the CONFIG section"; exit 1; }
[[ -z "$PRODUCTS_CSV" ]] && { echo "  ✗ Set PRODUCTS_CSV in the CONFIG section"; exit 1; }
[[ -f "$THEME_ZIP" ]]    || { echo "  ✗ THEME_ZIP not found: $THEME_ZIP"; exit 1; }
[[ -f "$PRODUCTS_CSV" ]] || { echo "  ✗ PRODUCTS_CSV not found: $PRODUCTS_CSV"; exit 1; }

# Generate a secure admin password and show it once at the end
ADMIN_PASS="$(openssl rand -base64 18 | tr -d '/+=' | head -c 20)"

# ============================================================
# L3.2 — WordPress Core Install
# ============================================================
section "L3.2 — WordPress core"

if wp core is-installed 2>/dev/null; then
  ok "WordPress already installed, skipping core install"
else
  wp core install \
    --url="$DEMO_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASS" \
    --admin_email="$ADMIN_EMAIL" \
    --skip-email
  ok "WordPress installed"
fi

# Remove defaults
wp post delete 1 2>/dev/null --force && ok "Deleted Hello World post" || true
wp post delete 2 2>/dev/null --force && ok "Deleted Sample Page" || true
wp comment delete 1 2>/dev/null --force && ok "Deleted default comment" || true

# Discourage search engines during setup
wp option update blog_public 0
ok "Search indexing disabled (re-enable after QA)"

# Core settings
wp option update blogname "$SITE_TITLE"
wp option update blogdescription "Built with the Squirrels WordPress theme"
wp option update date_format "F j, Y"
wp option update time_format "g:i a"
wp option update start_of_week 1
ok "Core settings configured"

# ============================================================
# L3.2 — WooCommerce
# ============================================================
section "L3.2 — WooCommerce plugin"

if wp plugin is-active woocommerce 2>/dev/null; then
  ok "WooCommerce already active"
else
  wp plugin install woocommerce --activate
  ok "WooCommerce installed and activated"
fi

# Run the WooCommerce page installer
wp wc tool run install_pages --user="$ADMIN_USER"
ok "WooCommerce pages created"

# ============================================================
# L3.2 — Squirrels Theme
# ============================================================
section "L3.2 — Squirrels theme"

if wp theme is-active squirrels 2>/dev/null; then
  ok "Squirrels already active"
else
  wp theme install "$THEME_ZIP" --activate
  ok "Squirrels installed and activated"
fi

# Permalink structure (/%postname%/ — required for WooCommerce)
wp rewrite structure '/%postname%/' --hard
wp rewrite flush --hard
ok "Permalinks set to /%postname%/"

# ============================================================
# L3.4 — WooCommerce configuration
# ============================================================
section "L3.4 — WooCommerce store settings"

# Store address
wp option update woocommerce_store_address   "$STORE_ADDRESS"
wp option update woocommerce_store_city      "$STORE_CITY"
wp option update woocommerce_default_country "$STORE_STATE"
wp option update woocommerce_store_postcode  "$STORE_POSTCODE"
ok "Store address set"

# Currency
wp option update woocommerce_currency         "$STORE_CURRENCY"
wp option update woocommerce_currency_pos     "left"
wp option update woocommerce_price_decimal_sep "."
wp option update woocommerce_price_thousand_sep ","
wp option update woocommerce_price_num_decimals "2"
ok "Currency: $STORE_CURRENCY"

# Tax: enabled but not calculated on demo
wp option update woocommerce_calc_taxes "yes"
wp option update woocommerce_tax_display_shop "excl"
wp option update woocommerce_tax_display_cart "excl"
ok "Tax settings configured"

# Payment: Cash on Delivery (no live credentials on demo)
wp option update woocommerce_cod_settings \
  '{"enabled":"yes","title":"Cash on Delivery","description":"Pay with cash upon delivery.","instructions":"Pay with cash upon delivery.","enable_for_methods":"","enable_for_virtual":"yes"}'
ok "Payment: Cash on Delivery enabled"

# Disable other default gateways
wp option update woocommerce_cheque_settings   '{"enabled":"no"}'
wp option update woocommerce_bacs_settings     '{"enabled":"no"}'
wp option update woocommerce_paypal_settings   '{"enabled":"no"}'
ok "Other payment gateways disabled"

# Shipping: free shipping zone for US
wp eval '
  $zone = new WC_Shipping_Zone();
  $zone->set_zone_name( "United States" );
  $zone->set_zone_order( 0 );
  $zone->add_location( "US", "country" );
  $zone->save();
  $instance_id = $zone->add_shipping_method( "free_shipping" );
  $method = WC_Shipping_Zones::get_shipping_method( $instance_id );
  if ( $method ) {
      $method->update_option( "title", "Free Shipping" );
      $method->update_option( "requires", "" );
  }
  echo "Shipping zone created (zone ID: {$zone->get_id()})\n";
'
ok "Shipping: Free Shipping zone added for US"

# Email settings
wp option update woocommerce_email_from_name     "Squirrels Demo Store"
wp option update woocommerce_email_from_address  "orders@squirrels.ninja"
ok "Email sender configured"

# ============================================================
# L3.3 — Acorn demo content import
# ============================================================
section "L3.3 — Acorn Classic Store import"

wp eval '
  $ajax_file = get_template_directory() . "/inc/demo-import/ajax-handlers.php";
  if ( ! file_exists( $ajax_file ) ) {
      echo "ERROR: ajax-handlers.php not found at: " . $ajax_file . "\n";
      exit;
  }
  require_once $ajax_file;

  $json_file = get_template_directory() . "/inc/demo-import/demos/classic-store.json";
  if ( ! file_exists( $json_file ) ) {
      echo "ERROR: classic-store.json not found\n";
      exit;
  }

  $data   = json_decode( file_get_contents( $json_file ), true );
  $result = squirrels_import_demo_data( "classic-store", $data );

  if ( is_wp_error( $result ) ) {
      echo "ERROR: " . $result->get_error_message() . "\n";
  } else {
      echo "Acorn import complete.\n";
  }
'
ok "Acorn Classic Store imported"

# ============================================================
# Products import
# ============================================================
section "Product catalog import"

wp wc product import "$PRODUCTS_CSV" \
  --user="$ADMIN_USER" \
  --update-existing \
  --delimiter=","
ok "12 products imported"

# ============================================================
# Navigation menus
# ============================================================
section "Navigation menus"

# Create Primary menu if it doesn't exist
if ! wp menu list --format=csv | grep -q "Primary Navigation"; then
  wp menu create "Primary Navigation"
  ok "Created Primary Navigation menu"
fi

PRIMARY_MENU_ID="$(wp menu list --format=csv | grep "Primary Navigation" | head -1 | cut -d',' -f1)"

# Get pages to add to menu (by slug)
for SLUG in home shop blog about contact; do
  PAGE_ID="$(wp post list --post_type=page --name="$SLUG" --fields=ID --format=csv 2>/dev/null | tail -1 | tr -d '\r')"
  if [[ -n "$PAGE_ID" && "$PAGE_ID" != "ID" ]]; then
    wp menu item add-post "$PRIMARY_MENU_ID" "$PAGE_ID" 2>/dev/null && ok "Added $SLUG to menu" || true
  fi
done

wp menu location assign "$PRIMARY_MENU_ID" primary
ok "Primary Navigation assigned to primary location"

# ============================================================
# Customizer / theme mods
# ============================================================
section "Customizer settings"

wp option update theme_mods_squirrels \
  '{"squirrels_primary_color":"#C94F10","squirrels_accent_color":"#B91C1C","squirrels_body_font_size":"16","squirrels_sidebar_position":"right","squirrels_footer_text":"© 2026 Squirrels Demo Store. Built with <a href=\"https://squirrels.ninja\">Squirrels<\/a>. &nbsp;·&nbsp; This is a demonstration store. No real orders are processed."}'
ok "Customizer: brand colors and footer text set"

# ============================================================
# Final settings
# ============================================================
section "Final settings"

# Set home page
HOME_ID="$(wp post list --post_type=page --name=home --fields=ID --format=csv 2>/dev/null | tail -1 | tr -d '\r')"
if [[ -n "$HOME_ID" && "$HOME_ID" != "ID" ]]; then
  wp option update show_on_front  page
  wp option update page_on_front  "$HOME_ID"
  ok "Front page set to imported Home page (ID: $HOME_ID)"
fi

# Flush rewrite rules
wp rewrite flush
ok "Rewrite rules flushed"

# WooCommerce cache clear
wp wc tool run clear_transients --user="$ADMIN_USER" 2>/dev/null || true
ok "WooCommerce transients cleared"

# ============================================================
# DONE
# ============================================================
echo ""
echo "============================================"
echo "  ✓ Demo site setup complete."
echo ""
echo "  Site URL:  $DEMO_URL"
echo "  Admin URL: $DEMO_URL/wp-admin/"
echo "  Username:  $ADMIN_USER"
echo "  Password:  $ADMIN_PASS"
echo ""
echo "  SAVE THE PASSWORD ABOVE — it is not stored anywhere."
echo ""
echo "  Next: Run the L3.5 functional QA checklist."
echo "  Then: Enable search indexing when QA passes:"
echo "    wp option update blog_public 1"
echo ""
echo "  Lighthouse baseline:"
echo "    npx @lhci/cli@0.14 autorun --config=setup/lighthouserc.json"
echo "============================================"
