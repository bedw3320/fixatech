# Google Workspace Integration (gog)

## Setup Status

✅ **Configured**: January 27, 2026
✅ **Account**: bedard.w@gmail.com
✅ **Services**: Gmail, Calendar, Drive, Contacts, Docs, Sheets

## Quick Reference

### Google Sheets

```bash
# Read data
gog sheets get <sheetId> "Tab!A1:Z100" --json --account bedard.w@gmail.com

# Write data
gog sheets update <sheetId> "Tab!A1:B2" --values-json '[["A","B"],["1","2"]]' --account bedard.w@gmail.com

# Append rows
gog sheets append <sheetId> "Tab!A:C" --values-json '[["x","y","z"]]' --account bedard.w@gmail.com

# Get metadata (find tab names, ranges)
gog sheets metadata <sheetId> --json --account bedard.w@gmail.com
```

### Google Docs

```bash
# Read document
gog docs cat <docId> --account bedard.w@gmail.com

# Export to text file
gog docs export <docId> --format txt --out /tmp/doc.txt --account bedard.w@gmail.com
```

### Extract IDs from URLs

**Google Sheets URL**:
`https://docs.google.com/spreadsheets/d/SHEET_ID_HERE/edit`

**Google Docs URL**:
`https://docs.google.com/document/d/DOC_ID_HERE/edit`

## Environment Variable (Optional)

```bash
# Add to ~/.zshrc or ~/.bashrc to skip --account flag
export GOG_ACCOUNT=bedard.w@gmail.com
```

## Common Use Cases

**Product Catalog Migration**:
```bash
# Read product catalog from client's Sheet
gog sheets get 1abc123xyz "Products!A1:Z5000" --json > products.json
```

**Requirements Documentation**:
```bash
# Read discovery notes from Google Doc
gog docs cat 1dlMkIc8MgyPq_5zhCERSNst1WvtVxjojBFHIfPMX3vQ
```

**Progress Tracking**:
```bash
# Append migration progress to tracking sheet
gog sheets append 1abc123 "Progress!A:D" --values-json '[["2026-01-27","Products","Completed","4000"]]'
```

## Credentials Location

- **OAuth Client**: `~/Library/Application Support/gogcli/credentials.json`
- **Auth Tokens**: `~/Library/Application Support/gogcli/`

## Re-authentication

If you need to re-authenticate or add another account:

```bash
# Add another account
gog auth add another@gmail.com --services gmail,calendar,drive,contacts,docs,sheets

# List all authenticated accounts
gog auth list
```

## Full Documentation

Skill file: `.claude/skills/gog/SKILL.md`
Official docs: https://gogcli.sh
