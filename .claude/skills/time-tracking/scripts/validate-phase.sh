#!/usr/bin/env bash

# validate-phase.sh - Validate phase ID for Fixatech time tracking
# Usage: validate-phase.sh <phase>

set -e

# Function to get phase name
get_phase_name() {
    case "$1" in
        admin) echo "Admin & Rencontres" ;;
        migration) echo "Migration de données" ;;
        storefront) echo "Développement vitrine" ;;
        b2b) echo "Implémentation B2B" ;;
        erp) echo "Intégration ERP" ;;
        testing) echo "Tests et AQ" ;;
        training) echo "Formation et lancement" ;;
        *) echo "" ;;
    esac
}

# Check if phase argument provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <phase>"
    echo ""
    echo "Valid phases:"
    echo "  - admin: Admin & Rencontres"
    echo "  - migration: Migration de données"
    echo "  - storefront: Développement vitrine"
    echo "  - b2b: Implémentation B2B"
    echo "  - erp: Intégration ERP"
    echo "  - testing: Tests et AQ"
    echo "  - training: Formation et lancement"
    exit 1
fi

PHASE="$1"
PHASE_NAME=$(get_phase_name "$PHASE")

# Validate phase
if [ -n "$PHASE_NAME" ]; then
    echo "✓ Valid phase: $PHASE ($PHASE_NAME)"
    exit 0
else
    echo "✗ Invalid phase: $PHASE"
    echo ""
    echo "Valid phases:"
    echo "  - admin: Admin & Rencontres"
    echo "  - migration: Migration de données"
    echo "  - storefront: Développement vitrine"
    echo "  - b2b: Implémentation B2B"
    echo "  - erp: Intégration ERP"
    echo "  - testing: Tests et AQ"
    echo "  - training: Formation et lancement"
    exit 1
fi
