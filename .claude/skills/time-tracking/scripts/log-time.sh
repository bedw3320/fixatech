#!/usr/bin/env bash

# log-time.sh - Log time entries for Fixatech project
# Usage: log-time.sh <phase> <hours> "<description>"

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Project configuration
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo ".")"
DATA_DIR="$PROJECT_ROOT/.claude/state/time-tracking"
DATA_FILE="$DATA_DIR/project-time-log.json"
HOURLY_RATE=125

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

# Function to get phase estimate
get_phase_estimate() {
    case "$1" in
        admin) echo "15-18h" ;;
        migration) echo "50-60h" ;;
        storefront) echo "105-130h" ;;
        b2b) echo "40-45h" ;;
        erp) echo "55-85h" ;;
        testing) echo "15-25h" ;;
        training) echo "10-17h" ;;
        *) echo "" ;;
    esac
}

# Function to validate phase
is_valid_phase() {
    case "$1" in
        admin|migration|storefront|b2b|erp|testing|training) return 0 ;;
        *) return 1 ;;
    esac
}

# Function to display usage
usage() {
    echo "Usage: $0 <phase> <hours> \"<description>\""
    echo ""
    echo "Valid phases:"
    echo "  - admin: Admin & Rencontres"
    echo "  - migration: Migration de données"
    echo "  - storefront: Développement vitrine"
    echo "  - b2b: Implémentation B2B"
    echo "  - erp: Intégration ERP"
    echo "  - testing: Tests et AQ"
    echo "  - training: Formation et lancement"
    echo ""
    echo "Example:"
    echo "  $0 storefront 6 \"Built product listing components\""
    exit 1
}

# Validate arguments
if [ $# -lt 3 ]; then
    echo -e "${RED}Error: Missing required arguments${NC}"
    usage
fi

PHASE="$1"
HOURS="$2"
DESCRIPTION="$3"

# Validate phase
if ! is_valid_phase "$PHASE"; then
    echo -e "${RED}Error: Invalid phase '${PHASE}'${NC}"
    echo "Valid phases: admin, migration, storefront, b2b, erp, testing, training"
    exit 1
fi

# Validate hours (positive decimal number)
if ! [[ "$HOURS" =~ ^[0-9]+\.?[0-9]*$ ]] || (( $(echo "$HOURS <= 0" | bc -l) )); then
    echo -e "${RED}Error: Hours must be a positive number${NC}"
    exit 1
fi

# Create data directory if it doesn't exist
mkdir -p "$DATA_DIR"

# Initialize data file if it doesn't exist
if [ ! -f "$DATA_FILE" ]; then
    echo "Initializing time tracking data file..."
    cat > "$DATA_FILE" << EOF
{
  "project": "Fixatech Migration",
  "hourlyRate": $HOURLY_RATE,
  "currency": "CAD",
  "phases": {
    "admin": {
      "name": "Admin & Rencontres",
      "estimate": "15-18h",
      "logged": 0
    },
    "migration": {
      "name": "Migration de données",
      "estimate": "50-60h",
      "logged": 0
    },
    "storefront": {
      "name": "Développement vitrine",
      "estimate": "105-130h",
      "logged": 0
    },
    "b2b": {
      "name": "Implémentation B2B",
      "estimate": "40-45h",
      "logged": 0
    },
    "erp": {
      "name": "Intégration ERP",
      "estimate": "55-85h",
      "logged": 0
    },
    "testing": {
      "name": "Tests et AQ",
      "estimate": "15-25h",
      "logged": 0
    },
    "training": {
      "name": "Formation et lancement",
      "estimate": "10-17h",
      "logged": 0
    }
  },
  "entries": [],
  "metadata": {
    "created": "$(date +%Y-%m-%d)",
    "lastUpdated": "$(date +%Y-%m-%d)",
    "totalEntries": 0,
    "totalHours": 0
  }
}
EOF
fi

# Generate entry ID (format: YYYY-MM-DD-###)
CURRENT_DATE=$(date +%Y-%m-%d)
ENTRY_COUNT=$(jq "[.entries[] | select(.date == \"$CURRENT_DATE\")] | length" "$DATA_FILE")
ENTRY_ID=$(printf "%s-%03d" "$CURRENT_DATE" "$((ENTRY_COUNT + 1))")

# Create the new entry
NEW_ENTRY=$(cat <<EOF
{
  "id": "$ENTRY_ID",
  "date": "$CURRENT_DATE",
  "phase": "$PHASE",
  "hours": $HOURS,
  "description": "$DESCRIPTION",
  "tags": []
}
EOF
)

# Use jq to update the JSON file
TMP_FILE=$(mktemp)
jq --argjson entry "$NEW_ENTRY" \
   --arg phase "$PHASE" \
   --argjson hours "$HOURS" \
   --arg date "$CURRENT_DATE" '
  .entries += [$entry] |
  .phases[$phase].logged += $hours |
  .metadata.lastUpdated = $date |
  .metadata.totalEntries = (.entries | length) |
  .metadata.totalHours = ([.entries[].hours] | add)
' "$DATA_FILE" > "$TMP_FILE"

# Replace original file with updated content
mv "$TMP_FILE" "$DATA_FILE"

# Get updated phase total
PHASE_TOTAL=$(jq -r ".phases.$PHASE.logged" "$DATA_FILE")
TOTAL_HOURS=$(jq -r ".metadata.totalHours" "$DATA_FILE")

# Calculate billable amount
BILLABLE=$(echo "$HOURS * $HOURLY_RATE" | bc)

# Get phase info
PHASE_NAME=$(get_phase_name "$PHASE")
PHASE_ESTIMATE=$(get_phase_estimate "$PHASE")

# Display confirmation
echo -e "${GREEN}✓ Time entry logged successfully${NC}"
echo ""
echo "Entry ID: $ENTRY_ID"
echo "Phase: $PHASE_NAME ($PHASE)"
echo "Hours: ${HOURS}h"
echo "Description: $DESCRIPTION"
echo "Billable: \$$(printf "%.2f" $BILLABLE)"
echo ""
echo -e "${YELLOW}Phase Progress:${NC}"
echo "$PHASE_NAME: ${PHASE_TOTAL}h / $PHASE_ESTIMATE logged"
echo ""
echo -e "${YELLOW}Project Total:${NC} ${TOTAL_HOURS}h / 290-380h"
echo ""
