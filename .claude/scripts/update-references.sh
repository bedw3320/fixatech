#!/bin/bash

###############################################################################
# Update Reference Repositories
#
# Pulls latest changes from Shopify Horizon and Dawn themes
# Run this weekly or before starting new projects to ensure fresh context
###############################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REFERENCES_DIR="$(cd "$SCRIPT_DIR/../references" && pwd)"

echo "🔄 Updating Shopify Theme References..."
echo "================================================"
echo ""

# Update Horizon Theme (PRIMARY)
if [ -d "$REFERENCES_DIR/shopify-horizon-theme" ]; then
    echo "📦 Updating Shopify Horizon Theme (PRIMARY)..."
    cd "$REFERENCES_DIR/shopify-horizon-theme"

    # Check if it's a git repo
    if [ -d ".git" ]; then
        BEFORE=$(git rev-parse HEAD)
        git fetch origin
        git pull origin main
        AFTER=$(git rev-parse HEAD)

        if [ "$BEFORE" != "$AFTER" ]; then
            echo "✅ Horizon updated from $BEFORE to $AFTER"
        else
            echo "✅ Horizon already up-to-date"
        fi
    else
        echo "❌ Not a git repository. Skipping..."
    fi
    echo ""
else
    echo "⚠️  Horizon theme not found. Run Phase 0 setup first."
    echo "   git clone https://github.com/Shopify/horizon.git $REFERENCES_DIR/shopify-horizon-theme"
    echo ""
fi

# Update Dawn Theme (SECONDARY)
if [ -d "$REFERENCES_DIR/shopify-dawn-theme" ]; then
    echo "📦 Updating Shopify Dawn Theme (SECONDARY)..."
    cd "$REFERENCES_DIR/shopify-dawn-theme"

    # Check if it's a git repo
    if [ -d ".git" ]; then
        BEFORE=$(git rev-parse HEAD)
        git fetch origin
        git pull origin main
        AFTER=$(git rev-parse HEAD)

        if [ "$BEFORE" != "$AFTER" ]; then
            echo "✅ Dawn updated from $BEFORE to $AFTER"
        else
            echo "✅ Dawn already up-to-date"
        fi
    else
        echo "❌ Not a git repository. Skipping..."
    fi
    echo ""
else
    echo "⚠️  Dawn theme not found. Run Phase 0 setup first."
    echo "   git clone https://github.com/Shopify/dawn.git $REFERENCES_DIR/shopify-dawn-theme"
    echo ""
fi

# Summary
echo "================================================"
echo "✅ Reference update complete!"
echo ""
echo "📌 Horizon: $REFERENCES_DIR/shopify-horizon-theme"
echo "📌 Dawn: $REFERENCES_DIR/shopify-dawn-theme"
echo ""
echo "💡 Tip: Run this script weekly or before starting new projects"
echo "   to ensure you're working with the latest theme patterns."
