#!/usr/bin/env python3

"""
generate-report.py - Generate monthly invoice reports for Fixatech project
Usage: generate-report.py [--month YYYY-MM] [--output FILE]
"""

import json
import argparse
from datetime import datetime
from pathlib import Path
from collections import defaultdict
import sys

# Project configuration
HOURLY_RATE = 125
CURRENCY = "CAD"
PROJECT_NAME = "Fixatech Shopify Migration"

def load_time_data(data_file):
    """Load time tracking data from JSON file."""
    if not data_file.exists():
        print(f"Error: Data file not found: {data_file}", file=sys.stderr)
        sys.exit(1)

    with open(data_file, 'r') as f:
        return json.load(f)

def filter_entries_by_month(entries, target_month=None):
    """Filter entries by month. If target_month is None, use current month."""
    if target_month is None:
        target_month = datetime.now().strftime('%Y-%m')

    filtered = [
        entry for entry in entries
        if entry['date'].startswith(target_month)
    ]

    return filtered, target_month

def calculate_phase_totals(entries):
    """Calculate total hours per phase from entries."""
    phase_totals = defaultdict(float)
    for entry in entries:
        phase_totals[entry['phase']] += entry['hours']
    return dict(phase_totals)

def format_currency(amount):
    """Format amount as currency."""
    return f"${amount:,.2f}"

def parse_estimate_range(estimate_str):
    """Parse estimate string like '15-18h' into (min, max) tuple."""
    if '-' not in estimate_str:
        return None, None

    parts = estimate_str.replace('h', '').split('-')
    return int(parts[0]), int(parts[1])

def calculate_progress_percentage(logged, estimate_str):
    """Calculate progress as a percentage range."""
    min_est, max_est = parse_estimate_range(estimate_str)
    if min_est is None or max_est is None:
        return "N/A"

    min_pct = (logged / max_est) * 100 if max_est > 0 else 0
    max_pct = (logged / min_est) * 100 if min_est > 0 else 0

    return f"{min_pct:.0f}-{max_pct:.0f}%"

def generate_report(data, entries, target_month, output_file=None):
    """Generate Markdown invoice report."""

    # Parse month for display
    year, month = target_month.split('-')
    month_name = datetime.strptime(target_month, '%Y-%m').strftime('%B %Y')

    # Calculate totals
    phase_totals = calculate_phase_totals(entries)
    total_hours = sum(entry['hours'] for entry in entries)
    total_amount = total_hours * HOURLY_RATE

    # Sort entries by date
    entries_sorted = sorted(entries, key=lambda x: x['date'])

    # Build report
    lines = []
    lines.append(f"# Invoice - {month_name}")
    lines.append(f"## {PROJECT_NAME}")
    lines.append("")

    # Period info
    if entries_sorted:
        first_date = datetime.strptime(entries_sorted[0]['date'], '%Y-%m-%d').strftime('%B %d')
        last_date = datetime.strptime(entries_sorted[-1]['date'], '%Y-%m-%d').strftime('%B %d, %Y')
        lines.append(f"**Period:** {first_date} - {last_date}")
    else:
        lines.append(f"**Period:** {month_name}")

    lines.append(f"**Rate:** ${HOURLY_RATE}/hour")
    lines.append("")

    # Executive Summary
    lines.append("### Summary")
    lines.append("")
    lines.append(f"- **Total Hours:** {total_hours:.1f}h")
    lines.append(f"- **Billable Amount:** {format_currency(total_amount)}")
    lines.append("")

    # Phase Breakdown Table
    lines.append("### Hours by Phase")
    lines.append("")
    lines.append("| Phase | Hours | Amount |")
    lines.append("|-------|-------|--------|")

    # Sort phases by total hours (descending)
    sorted_phases = sorted(phase_totals.items(), key=lambda x: x[1], reverse=True)

    for phase_id, hours in sorted_phases:
        phase_info = data['phases'].get(phase_id, {})
        phase_name = phase_info.get('name', phase_id)
        amount = hours * HOURLY_RATE
        lines.append(f"| {phase_name} | {hours:.1f}h | {format_currency(amount)} |")

    lines.append("")

    # Detailed Time Entries
    lines.append("### Detailed Time Entries")
    lines.append("")

    # Group entries by date
    entries_by_date = defaultdict(list)
    for entry in entries_sorted:
        entries_by_date[entry['date']].append(entry)

    for date, day_entries in sorted(entries_by_date.items()):
        date_formatted = datetime.strptime(date, '%Y-%m-%d').strftime('%A, %B %d, %Y')
        lines.append(f"#### {date_formatted}")
        lines.append("")

        for entry in day_entries:
            phase_info = data['phases'].get(entry['phase'], {})
            phase_name = phase_info.get('name', entry['phase'])
            amount = entry['hours'] * HOURLY_RATE

            lines.append(f"**{phase_name}** - {entry['hours']:.1f}h ({format_currency(amount)})")
            lines.append(f"- {entry['description']}")
            lines.append("")

    # Progress Against Estimate
    lines.append("### Progress Against Estimate")
    lines.append("")
    lines.append("| Phase | Logged | Budgeted | Progress |")
    lines.append("|-------|--------|----------|----------|")

    # All phases (including those with 0 hours)
    for phase_id, phase_info in data['phases'].items():
        phase_name = phase_info['name']
        estimate = phase_info['estimate']
        logged = phase_totals.get(phase_id, 0)
        progress = calculate_progress_percentage(logged, estimate)

        lines.append(f"| {phase_name} | {logged:.1f}h | {estimate} | {progress} |")

    lines.append("")

    # Project Totals
    lines.append("### Project Total")
    lines.append("")

    # Get overall project hours from metadata
    project_total = data['metadata']['totalHours']
    project_estimate = "290-380h"
    project_progress = calculate_progress_percentage(project_total, project_estimate)

    lines.append(f"- **Total Hours Logged:** {project_total:.1f}h")
    lines.append(f"- **Project Budget:** {project_estimate}")
    lines.append(f"- **Overall Progress:** {project_progress}")
    lines.append(f"- **Total Billable:** {format_currency(project_total * HOURLY_RATE)}")
    lines.append("")

    # Invoice Total (for this month)
    lines.append("---")
    lines.append("")
    lines.append(f"## Invoice Total: {format_currency(total_amount)}")
    lines.append("")
    lines.append(f"*Generated on {datetime.now().strftime('%B %d, %Y at %I:%M %p')}*")
    lines.append("")

    # Write to output
    report_content = '\n'.join(lines)

    if output_file:
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w') as f:
            f.write(report_content)
        print(f"✓ Report generated: {output_path}")
    else:
        print(report_content)

    return report_content

def main():
    parser = argparse.ArgumentParser(
        description='Generate monthly invoice report for Fixatech project'
    )
    parser.add_argument(
        '--month',
        help='Target month in YYYY-MM format (default: current month)',
        default=None
    )
    parser.add_argument(
        '--output',
        help='Output file path (default: print to stdout)',
        default=None
    )

    args = parser.parse_args()

    # Locate data file
    try:
        # Try to find git root
        import subprocess
        git_root = subprocess.check_output(
            ['git', 'rev-parse', '--show-toplevel'],
            stderr=subprocess.DEVNULL
        ).decode().strip()
        data_file = Path(git_root) / '.claude' / 'state' / 'time-tracking' / 'project-time-log.json'
    except:
        # Fallback to current directory
        data_file = Path('.claude/state/time-tracking/project-time-log.json')

    # Load data
    data = load_time_data(data_file)

    # Filter entries by month
    entries, target_month = filter_entries_by_month(data['entries'], args.month)

    if not entries:
        month_display = datetime.strptime(target_month, '%Y-%m').strftime('%B %Y')
        print(f"No time entries found for {month_display}", file=sys.stderr)
        sys.exit(1)

    # Generate report
    generate_report(data, entries, target_month, args.output)

if __name__ == '__main__':
    main()
