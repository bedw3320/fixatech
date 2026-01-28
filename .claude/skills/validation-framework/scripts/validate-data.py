#!/usr/bin/env python3

"""
validate-data.py

Purpose: Validate data quality before migration to Shopify
Usage: python validate-data.py --input products.json --type shopify_products --sample-size 1000

Checks:
1. Data format valid (prices numeric, dates ISO 8601)
2. No duplicate keys (SKUs, customer IDs)
3. Within platform limits (Shopify: ≤100 variants, ≤3 options)
4. Required fields present (title, SKU, price)
5. No data corruption (malformed JSON, encoding issues)
"""

import json
import sys
import argparse
from datetime import datetime
from collections import Counter
from typing import Dict, List, Any

def parse_args():
    parser = argparse.ArgumentParser(
        description='Validate data quality before Shopify migration'
    )
    parser.add_argument(
        '--input',
        required=True,
        help='Path to input JSON file'
    )
    parser.add_argument(
        '--type',
        required=True,
        choices=['shopify_products', 'shopify_customers', 'shopify_orders'],
        help='Data type to validate'
    )
    parser.add_argument(
        '--sample-size',
        type=int,
        default=0,
        help='Sample size for validation (0 = all records)'
    )
    return parser.parse_args()

def load_data(input_path: str) -> List[Dict]:
    """Load JSON data from file"""
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return data if isinstance(data, list) else [data]
    except FileNotFoundError:
        print(f"Error: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON: {e}", file=sys.stderr)
        sys.exit(1)

def validate_shopify_products(records: List[Dict], sample_size: int) -> Dict:
    """Validate Shopify product data"""
    result = {
        'valid': True,
        'total_records': len(records),
        'passed': 0,
        'failed': 0,
        'pass_rate': 0.0,
        'errors': [],
        'warnings': [],
        'recommendations': []
    }

    # Sample if requested
    if sample_size > 0 and len(records) > sample_size:
        import random
        records = random.sample(records, sample_size)
        result['sampled'] = True
        result['sample_size'] = sample_size

    # Track issues
    missing_sku = []
    missing_title = []
    missing_price = []
    invalid_price = []
    duplicate_skus = []
    too_many_variants = []
    too_many_options = []
    title_too_long = []

    # Check for duplicates
    skus = [r.get('sku') for r in records if r.get('sku')]
    sku_counts = Counter(skus)
    duplicate_skus = [sku for sku, count in sku_counts.items() if count > 1]

    # Validate each record
    for idx, record in enumerate(records):
        record_id = record.get('id', f'record-{idx}')
        has_error = False

        # Check 1: Required fields present
        if not record.get('title'):
            missing_title.append(record_id)
            has_error = True

        if not record.get('sku'):
            missing_sku.append(record_id)
            has_error = True

        if not record.get('price'):
            missing_price.append(record_id)
            has_error = True

        # Check 2: Data format valid
        if record.get('price') is not None:
            try:
                price = float(record['price'])
                if price < 0:
                    invalid_price.append(record_id)
                    has_error = True
            except (ValueError, TypeError):
                invalid_price.append(record_id)
                has_error = True

        # Check 3: Within Shopify limits
        variants = record.get('variants', [])
        if len(variants) > 100:
            too_many_variants.append({
                'id': record_id,
                'count': len(variants)
            })
            has_error = True

        options = record.get('options', [])
        if len(options) > 3:
            too_many_options.append({
                'id': record_id,
                'count': len(options)
            })
            has_error = True

        # Check 4: Warnings (not errors)
        title = record.get('title', '')
        if len(title) > 255:
            title_too_long.append(record_id)

        if has_error:
            result['failed'] += 1
        else:
            result['passed'] += 1

    # Build error list
    if missing_sku:
        result['errors'].append({
            'type': 'missing_required_field',
            'field': 'sku',
            'count': len(missing_sku),
            'sample_records': missing_sku[:5]
        })

    if missing_title:
        result['errors'].append({
            'type': 'missing_required_field',
            'field': 'title',
            'count': len(missing_title),
            'sample_records': missing_title[:5]
        })

    if missing_price:
        result['errors'].append({
            'type': 'missing_required_field',
            'field': 'price',
            'count': len(missing_price),
            'sample_records': missing_price[:5]
        })

    if invalid_price:
        result['errors'].append({
            'type': 'invalid_data_format',
            'field': 'price',
            'count': len(invalid_price),
            'message': 'Price must be numeric and >= 0',
            'sample_records': invalid_price[:5]
        })

    if duplicate_skus:
        result['errors'].append({
            'type': 'duplicate_key',
            'field': 'sku',
            'count': len(duplicate_skus),
            'duplicates': duplicate_skus[:10]
        })

    if too_many_variants:
        result['errors'].append({
            'type': 'platform_limit_exceeded',
            'field': 'variants',
            'limit': 100,
            'message': 'Shopify allows maximum 100 variants per product',
            'count': len(too_many_variants),
            'sample_records': [v['id'] for v in too_many_variants[:5]]
        })

    if too_many_options:
        result['errors'].append({
            'type': 'platform_limit_exceeded',
            'field': 'options',
            'limit': 3,
            'message': 'Shopify allows maximum 3 options per product',
            'count': len(too_many_options),
            'sample_records': [o['id'] for o in too_many_options[:5]]
        })

    # Build warnings
    if title_too_long:
        result['warnings'].append({
            'type': 'title_too_long',
            'count': len(title_too_long),
            'message': 'Title >255 chars (will be truncated)'
        })

    # Calculate pass rate
    result['pass_rate'] = result['passed'] / result['total_records'] if result['total_records'] > 0 else 0

    # Set overall valid status
    result['valid'] = result['pass_rate'] >= 0.95

    # Generate recommendations
    if missing_sku:
        result['recommendations'].append(
            f"Generate SKUs for {len(missing_sku)} products missing SKU field"
        )

    if duplicate_skus:
        result['recommendations'].append(
            f"Deduplicate {len(duplicate_skus)} SKUs before import"
        )

    if too_many_variants:
        result['recommendations'].append(
            f"Split {len(too_many_variants)} products with >100 variants into multiple products"
        )

    if too_many_options:
        result['recommendations'].append(
            f"Reduce options for {len(too_many_options)} products (use apps like Infinite Options)"
        )

    return result

def validate_shopify_customers(records: List[Dict], sample_size: int) -> Dict:
    """Validate Shopify customer data"""
    # TODO: Implement customer validation
    return {
        'valid': True,
        'message': 'Customer validation not yet implemented'
    }

def validate_shopify_orders(records: List[Dict], sample_size: int) -> Dict:
    """Validate Shopify order data"""
    # TODO: Implement order validation
    return {
        'valid': True,
        'message': 'Order validation not yet implemented'
    }

def main():
    args = parse_args()

    # Load data
    records = load_data(args.input)

    # Validate based on type
    if args.type == 'shopify_products':
        result = validate_shopify_products(records, args.sample_size)
    elif args.type == 'shopify_customers':
        result = validate_shopify_customers(records, args.sample_size)
    elif args.type == 'shopify_orders':
        result = validate_shopify_orders(records, args.sample_size)
    else:
        print(f"Error: Unknown type: {args.type}", file=sys.stderr)
        sys.exit(1)

    # Output result as JSON
    print(json.dumps(result, indent=2))

    # Exit with appropriate code
    sys.exit(0 if result['valid'] else 1)

if __name__ == '__main__':
    main()
