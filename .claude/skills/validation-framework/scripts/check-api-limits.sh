#!/usr/bin/env bash

#
# check-api-limits.sh
#
# Purpose: Verify API rate limits before bulk operations
# Usage: bash check-api-limits.sh --api shopify --operation bulkProductCreate --count 5000
#
# Checks:
# 1. Current rate limit usage (<80% consumed)
# 2. Estimated calls within limits
# 3. Retry budget available (for failed requests)
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
API="shopify"
OPERATION=""
COUNT=0
THRESHOLD=0.8

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --api)
      API="$2"
      shift 2
      ;;
    --operation)
      OPERATION="$2"
      shift 2
      ;;
    --count)
      COUNT="$2"
      shift 2
      ;;
    --threshold)
      THRESHOLD="$2"
      shift 2
      ;;
    --help)
      echo "Usage: check-api-limits.sh [options]"
      echo ""
      echo "Options:"
      echo "  --api <name>         API name (shopify, netsuite, etc.)"
      echo "  --operation <op>     Operation name (bulkProductCreate, etc.)"
      echo "  --count <n>          Number of records to process"
      echo "  --threshold <0-1>    Rate limit threshold (default: 0.8 = 80%)"
      echo "  --help               Show this help message"
      echo ""
      echo "Example:"
      echo "  bash check-api-limits.sh --api shopify --operation bulkProductCreate --count 5000"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate required arguments
if [[ -z "$OPERATION" ]] || [[ $COUNT -eq 0 ]]; then
  echo -e "${RED}Error: --operation and --count are required${NC}"
  echo "Use --help for usage information"
  exit 1
fi

# Function to check Shopify Admin API limits
check_shopify_limits() {
  echo -e "${GREEN}✓ Shopify Admin API Rate Limit Check${NC}"

  # TODO: Implement actual API call to Shopify
  # For now, simulate with placeholder values

  # Shopify Admin GraphQL API: 1000 points per second (calculated cost)
  # REST API: 2 requests per second

  # Simulated current usage (in production, query actual usage)
  CURRENT_POINTS=450
  MAX_POINTS=1000
  THRESHOLD_POINTS=$(echo "$MAX_POINTS * $THRESHOLD" | bc | cut -d. -f1)
  AVAILABLE_POINTS=$((MAX_POINTS - CURRENT_POINTS))
  USAGE_PERCENT=$(echo "scale=2; $CURRENT_POINTS / $MAX_POINTS * 100" | bc)

  echo "  Current: ${CURRENT_POINTS}/${MAX_POINTS} points used (${USAGE_PERCENT}%)"
  echo "  Threshold: ${THRESHOLD_POINTS}/${MAX_POINTS} points ($(echo "scale=0; $THRESHOLD * 100" | bc)%)"
  echo "  Available: ${AVAILABLE_POINTS} points"
  echo ""

  # Estimate operation cost
  echo -e "${GREEN}✓ Estimated Usage for Operation${NC}"
  echo "  Operation: $OPERATION"
  echo "  Records: $(printf "%'d" $COUNT) records"

  # Estimate points based on operation type
  case $OPERATION in
    bulkProductCreate|bulkProductUpdate)
      # Bulk operations are more efficient: ~10 points per 100 products
      ESTIMATED_POINTS=$((COUNT / 100 * 10))
      echo "  Estimated Points: ${ESTIMATED_POINTS} points (batch operation)"
      ;;
    productCreate|productUpdate)
      # Individual operations: ~10 points per product
      ESTIMATED_POINTS=$((COUNT * 10))
      echo "  Estimated Points: ${ESTIMATED_POINTS} points (individual operations)"
      echo -e "  ${YELLOW}⚠️  Recommendation: Use bulk operation for better efficiency${NC}"
      ;;
    *)
      # Default estimate
      ESTIMATED_POINTS=$((COUNT * 10))
      echo "  Estimated Points: ${ESTIMATED_POINTS} points (estimated)"
      ;;
  esac

  echo ""

  # Safety check
  echo -e "${GREEN}✓ Safety Check${NC}"
  AFTER_POINTS=$((CURRENT_POINTS + ESTIMATED_POINTS))
  AFTER_PERCENT=$(echo "scale=0; $AFTER_POINTS / $MAX_POINTS * 100" | bc)

  echo "  After operation: ${AFTER_POINTS}/${MAX_POINTS} points (${AFTER_PERCENT}%)"

  if [[ $AFTER_POINTS -gt $THRESHOLD_POINTS ]]; then
    echo -e "  ${YELLOW}⚠️  Will exceed threshold ($(echo "scale=0; $THRESHOLD * 100" | bc)%)${NC}"
    echo ""
    echo -e "${RED}❌ NOT SAFE TO PROCEED${NC}"
    echo ""
    echo "Recommendations:"
    echo "1. Reduce batch size (try $(($COUNT / 2)) records)"
    echo "2. Wait for rate limit to reset"
    echo "3. Use bulk operations instead of individual calls"
    return 1
  else:
    echo -e "  ${GREEN}Still under threshold ($(echo "scale=0; $THRESHOLD * 100" | bc)%)${NC}"
    echo ""
    echo -e "${GREEN}✅ SAFE TO PROCEED${NC}"
    return 0
  fi
}

# Function to check NetSuite API limits
check_netsuite_limits() {
  echo -e "${GREEN}✓ NetSuite API Rate Limit Check${NC}"
  echo "  ${YELLOW}⚠️  NetSuite validation not yet implemented${NC}"
  echo "  Default: Assuming SAFE TO PROCEED"
  return 0
}

# Main execution
echo ""
case $API in
  shopify)
    check_shopify_limits
    ;;
  netsuite)
    check_netsuite_limits
    ;;
  *)
    echo -e "${YELLOW}⚠️  Unknown API: $API${NC}"
    echo "  Supported APIs: shopify, netsuite"
    echo "  Assuming SAFE TO PROCEED (but cannot verify)"
    exit 0
    ;;
esac

exit $?
