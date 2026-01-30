---
name: time-tracking
description: This skill should be used when the user asks to "log time", "track hours", "log my hours", "I spent X hours on Y", "generate invoice", "create monthly report", "show time summary", "track my time", "how many hours", "time breakdown", or mentions time tracking for the Fixatech project.
version: 0.1.0
---

# Time Tracking Skill for Fixatech Migration

## Purpose

This skill provides time tracking and invoicing capabilities for the Fixatech Shopify migration project. Track billable hours against the 7-phase project estimate (290-380 hours total at $125/hour), log daily work activities, and generate monthly invoice reports in Markdown format.

The skill stores all time entries in `.claude/state/time-tracking/project-time-log.json` and provides utilities to:
- Log time entries with natural language descriptions
- Map activities to project phases automatically
- Generate professional monthly invoice reports
- Track progress against phase estimates
- Maintain detailed work history for billing

## When to Use This Skill

Invoke this skill when the user:
- Logs completed work: "I spent 6 hours on storefront development"
- Requests invoice generation: "Generate my January invoice"
- Checks phase progress: "How many hours have I logged on ERP?"
- Wants time summaries: "Show me my time breakdown this month"
- Tracks daily activities: "Log 2.5h admin for kickoff meeting"

## Project Phase Overview

The Fixatech project consists of 7 phases with hour estimates:

| Phase ID | Phase Name | Estimate | French Name |
|----------|------------|----------|-------------|
| `admin` | Admin & Meetings | 15-18h | Admin & Rencontres |
| `migration` | Data Migration | 50-60h | Migration de données |
| `storefront` | Storefront Development | 105-130h | Développement vitrine |
| `b2b` | B2B Implementation | 40-45h | Implémentation B2B |
| `erp` | ERP Integration | 55-85h | Intégration ERP |
| `testing` | Testing & QA | 15-25h | Tests et AQ |
| `training` | Training & Launch | 10-17h | Formation et lancement |

**Total Estimate:** 290-380 hours at $125/hour = $36,250-$47,500

For detailed phase descriptions, activities, and keywords, consult `references/phase-definitions.md`.

## Logging Time Entries

### Natural Language Interface

Parse the user's natural language time logging requests and extract:
1. **Hours worked** - Decimal format (e.g., 2.5, 6, 0.75)
2. **Phase** - Map keywords to phase IDs
3. **Description** - What work was completed

**Example user requests:**
- "I spent 6 hours on storefront development today"
  - Hours: 6
  - Phase: storefront
  - Description: "Storefront development"

- "Log 2.5h admin work for project kickoff meeting"
  - Hours: 2.5
  - Phase: admin
  - Description: "Project kickoff meeting"

- "Just finished 8 hours implementing SparkLayer B2B features"
  - Hours: 8
  - Phase: b2b
  - Description: "Implementing SparkLayer B2B features"

### Phase Keyword Mapping

Map user descriptions to phase IDs using keywords:

- **admin**: kickoff, meeting, planning, admin, coordination, status update, client call
- **migration**: migration, data, import, CSV, Matrixify, products, mapping, 4000 products
- **storefront**: storefront, theme, Horizon, frontend, Figma, design, UI, components, Liquid
- **b2b**: B2B, SparkLayer, pricing tiers, wholesale, customer groups, tier pricing
- **erp**: ERP, ServiCentre 360, middleware, integration, API, sync, inventory
- **testing**: testing, QA, quality, validation, bug fixing, test cases, debugging
- **training**: training, launch, deployment, documentation, handoff, go-live

If multiple phases match, ask the user to clarify which phase to log against.

### Using the Log Script

Call `scripts/log-time.sh` with extracted parameters:

```bash
./claude/skills/time-tracking/scripts/log-time.sh <phase> <hours> "<description>"
```

**Examples:**
```bash
# Log 6 hours of storefront work
./claude/skills/time-tracking/scripts/log-time.sh storefront 6 "Built product listing components"

# Log 2.5 hours of admin work
./claude/skills/time-tracking/scripts/log-time.sh admin 2.5 "Client kickoff meeting and requirements review"

# Log 8 hours of ERP integration
./claude/skills/time-tracking/scripts/log-time.sh erp 8 "Implemented ServiCentre 360 inventory sync middleware"
```

The script automatically:
- Validates the phase ID exists
- Generates a unique entry ID with timestamp
- Appends the entry to `project-time-log.json`
- Updates phase totals
- Confirms the entry was logged

### Manual Data Entry

If the script is unavailable or for bulk entries, edit `.claude/state/time-tracking/project-time-log.json` directly:

```json
{
  "entries": [
    {
      "id": "2026-01-30-001",
      "date": "2026-01-30",
      "phase": "storefront",
      "hours": 6,
      "description": "Built product listing components from Figma designs",
      "tags": ["frontend", "components"]
    }
  ]
}
```

Ensure:
- `id` follows format: `YYYY-MM-DD-###` (sequential daily counter)
- `date` uses ISO 8601 format: `YYYY-MM-DD`
- `phase` matches one of the 7 phase IDs
- `hours` is a positive decimal number
- `description` is clear and specific

## Generating Invoice Reports

### Monthly Invoice Generation

Generate monthly invoice reports using `scripts/generate-report.py`:

```bash
# Generate report for current month
python3 .claude/skills/time-tracking/scripts/generate-report.py

# Generate report for specific month
python3 .claude/skills/time-tracking/scripts/generate-report.py --month 2026-01

# Generate report with custom output path
python3 .claude/skills/time-tracking/scripts/generate-report.py --month 2026-01 --output invoices/jan-2026.md
```

### Invoice Report Format

The generated Markdown report includes:

1. **Header** - Month, date range, project name
2. **Executive Summary** - Total hours, billable amount, rate
3. **Phase Breakdown Table** - Hours logged per phase with subtotals
4. **Detailed Time Entries** - Daily log with descriptions
5. **Progress Tracking** - Hours logged vs. phase estimates
6. **Invoice Total** - Final billable amount

**Example output structure:**
```markdown
# Invoice - January 2026
## Fixatech Shopify Migration

**Period:** January 1-31, 2026
**Rate:** $125/hour

### Summary
- Total Hours: 45.5h
- Billable Amount: $5,687.50

### Hours by Phase
| Phase | Hours | Amount |
|-------|-------|--------|
| Admin & Meetings | 8.0h | $1,000.00 |
| Data Migration | 12.5h | $1,562.50 |
| Storefront Development | 25.0h | $3,125.00 |

### Detailed Entries
[Daily breakdown of work completed]

### Progress Against Estimate
- Admin: 8h logged / 15-18h budgeted (44-53%)
- Migration: 12.5h logged / 50-60h budgeted (21-25%)
- Storefront: 25h logged / 105-130h budgeted (19-24%)
```

See `examples/sample-invoice.md` for a complete example report.

## Checking Progress and Summaries

### View Phase Summary

To show the user their current progress:

1. Read `.claude/state/time-tracking/project-time-log.json`
2. Calculate total hours per phase
3. Compare against phase estimates
4. Present as a summary table

**Example response:**
```
Your Fixatech Time Summary:

Admin & Rencontres: 8.0h / 15-18h (44-53% complete)
Migration de données: 12.5h / 50-60h (21-25% complete)
Développement vitrine: 25.0h / 105-130h (19-24% complete)
Implémentation B2B: 0h / 40-45h (0% complete)
Intégration ERP: 0h / 55-85h (0% complete)
Tests et AQ: 0h / 15-25h (0% complete)
Formation et lancement: 0h / 10-17h (0% complete)

Total: 45.5h / 290-380h (12-16% complete)
Billable: $5,687.50
```

### Recent Activity

To show recent time entries, read the last 5-10 entries from the JSON file and format them:

```
Recent Activity:
- 2026-01-30: 6.0h on Storefront - Built product listing components
- 2026-01-29: 4.5h on Migration - Mapped product fields for CSV import
- 2026-01-28: 8.0h on Storefront - Implemented Horizon theme customizations
```

## Data Storage Structure

All time tracking data lives in `.claude/state/time-tracking/project-time-log.json`:

```json
{
  "project": "Fixatech Migration",
  "hourlyRate": 125,
  "currency": "CAD",
  "phases": {
    "admin": {
      "name": "Admin & Rencontres",
      "estimate": "15-18h",
      "logged": 8.0
    },
    "migration": {
      "name": "Migration de données",
      "estimate": "50-60h",
      "logged": 12.5
    }
    // ... other phases
  },
  "entries": [
    {
      "id": "2026-01-30-001",
      "date": "2026-01-30",
      "phase": "storefront",
      "hours": 6.0,
      "description": "Built product listing components from Figma designs",
      "tags": ["frontend", "components"]
    }
    // ... more entries
  ],
  "metadata": {
    "created": "2026-01-30",
    "lastUpdated": "2026-01-30",
    "totalEntries": 15,
    "totalHours": 45.5
  }
}
```

The `logged` field in each phase is automatically updated when entries are added.

## Validation and Error Handling

### Phase Validation

Before logging time, validate that the phase ID is valid:

```bash
# Use the validation script
./claude/skills/time-tracking/scripts/validate-phase.sh <phase>
```

Valid phases: `admin`, `migration`, `storefront`, `b2b`, `erp`, `testing`, `training`

If an invalid phase is provided, suggest the closest match or ask the user to clarify.

### Data Integrity

When reading or updating `project-time-log.json`:
1. Check file exists, create if missing
2. Validate JSON structure
3. Ensure required fields are present
4. Verify numeric values are positive
5. Confirm dates are valid ISO 8601 format

If data corruption is detected, alert the user and suggest restoring from backup or reconstructing from git history.

## Additional Resources

### Reference Files

For detailed phase information:
- **`references/phase-definitions.md`** - Complete phase descriptions, activities, deliverables, and keyword mappings

### Example Files

Working examples:
- **`examples/sample-time-log.json`** - Example data structure with multiple entries
- **`examples/sample-invoice.md`** - Example monthly invoice report output

### Scripts

Utility scripts:
- **`scripts/log-time.sh`** - CLI for logging time entries
- **`scripts/generate-report.py`** - Monthly invoice report generator
- **`scripts/validate-phase.sh`** - Phase ID validation utility

## Workflow Summary

1. **User logs time** → Parse request → Extract hours, phase, description
2. **Validate phase** → Use `validate-phase.sh` or check against valid IDs
3. **Log entry** → Call `log-time.sh` or update JSON directly
4. **Confirm** → Show confirmation message with entry details
5. **Generate invoices** → Run `generate-report.py` monthly or on request
6. **Track progress** → Calculate phase totals and compare to estimates

Keep time logging simple, accurate, and integrated into the user's daily workflow. Focus on capturing billable work without administrative overhead.
