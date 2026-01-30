# Time Tracking Data Storage

This directory contains time tracking data for the Fixatech Shopify migration project.

## Files

### project-time-log.json

**Primary data file** containing all time entries, phase information, and project metadata.

**Structure:**
```json
{
  "project": "Fixatech Migration",
  "hourlyRate": 125,
  "currency": "CAD",
  "phases": {
    "admin": { "name": "...", "estimate": "...", "logged": 0 },
    ...
  },
  "entries": [
    { "id": "...", "date": "...", "phase": "...", "hours": 0, "description": "..." }
  ],
  "metadata": {
    "created": "...",
    "lastUpdated": "...",
    "totalEntries": 0,
    "totalHours": 0
  }
}
```

**Auto-created:** This file is automatically created by `log-time.sh` on first use if it doesn't exist.

**Manual editing:** Can be edited directly, but ensure JSON validity and field consistency.

**Backup:** Stored in git, so all changes are versioned. Use `git log` to view history.

## Usage

### Log Time

Use the time-tracking skill or call scripts directly:

```bash
# Via skill (natural language)
"I spent 6 hours on storefront development"

# Direct script call
./.claude/skills/time-tracking/scripts/log-time.sh storefront 6 "Built product listing components"
```

### Generate Invoice

```bash
# Current month
python3 ./.claude/skills/time-tracking/scripts/generate-report.py

# Specific month
python3 ./.claude/skills/time-tracking/scripts/generate-report.py --month 2026-01

# Save to file
python3 ./.claude/skills/time-tracking/scripts/generate-report.py --month 2026-01 --output invoices/jan-2026.md
```

### View Progress

Ask Claude via the time-tracking skill:
- "Show me my time summary"
- "How many hours have I logged?"
- "What's my progress on the storefront phase?"

## Phase IDs

| Phase ID | French Name | Estimate |
|----------|-------------|----------|
| `admin` | Admin & Rencontres | 15-18h |
| `migration` | Migration de données | 50-60h |
| `storefront` | Développement vitrine | 105-130h |
| `b2b` | Implémentation B2B | 40-45h |
| `erp` | Intégration ERP | 55-85h |
| `testing` | Tests et AQ | 15-25h |
| `training` | Formation et lancement | 10-17h |

**Total:** 290-380h

## Data Integrity

- **Validation:** Scripts validate phase IDs and numeric values
- **Backups:** Git versioning provides automatic backup
- **Recovery:** Use `git log` and `git checkout` to recover previous versions

## Monthly Workflow

1. **Log time daily** throughout the month
2. **Generate invoice** at month-end
3. **Review and send** invoice to PM/client
4. **Archive invoice** in project documentation

## Troubleshooting

**File not found:**
- Log-time.sh auto-creates the file on first use
- Or manually create with empty structure (see example)

**JSON syntax error:**
- Use `jq . project-time-log.json` to validate
- Check for missing commas, quotes, or brackets

**Phase not found:**
- Run `./.claude/skills/time-tracking/scripts/validate-phase.sh <phase>`
- Valid phases: admin, migration, storefront, b2b, erp, testing, training

**Incorrect totals:**
- Recalculate: `jq '.metadata.totalHours = ([.entries[].hours] | add)' project-time-log.json`
- Scripts automatically update totals on each entry

---

*See `.claude/skills/time-tracking/` for complete documentation and examples.*
