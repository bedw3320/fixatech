# Framework Maintenance Guide

**Keeping your Shopify Agency Framework fresh and up-to-date**

---

## 🔄 Updating Reference Repositories

### Why Update?

Shopify regularly updates their official themes (Horizon and Dawn) with:
- New Liquid patterns and best practices
- Performance improvements
- Bug fixes
- New section types and components
- Accessibility enhancements

**Stale references = Outdated patterns in your projects.**

---

## 🚀 Quick Update (Recommended Weekly)

### Automated Update Script

```bash
# From your framework root directory
.claude/scripts/update-references.sh
```

This script:
- ✅ Pulls latest changes from Shopify Horizon (primary)
- ✅ Pulls latest changes from Shopify Dawn (secondary)
- ✅ Shows commit hashes before/after update
- ✅ Confirms if already up-to-date

### Manual Update

```bash
# Update Horizon Theme (PRIMARY)
cd .claude/references/shopify-horizon-theme
git pull origin main

# Update Dawn Theme (SECONDARY)
cd .claude/references/shopify-dawn-theme
git pull origin main
```

---

## 📅 Update Schedule Recommendations

### **Weekly** (Recommended)
Best for active development. Run every Monday morning:
```bash
# Add to your weekly routine
cd ~/Documents/GitHub\ Repos/shopify-agency-framework
.claude/scripts/update-references.sh
```

### **Before New Projects**
Always update before creating a new client project:
```bash
# 1. Update template framework
cd ~/Documents/GitHub\ Repos/shopify-agency-framework
.claude/scripts/update-references.sh

# 2. Then create new project from template
cd ~/Documents/GitHub\ Projects
git clone https://github.com/bedw3320/shopify-agency-framework.git client-name
cd client-name

# 3. Clone fresh references in new project
git clone https://github.com/Shopify/horizon.git .claude/references/shopify-horizon-theme
git clone https://github.com/Shopify/dawn.git .claude/references/shopify-dawn-theme
```

### **After Major Shopify Releases**
Shopify announces major theme updates on [shopify.dev/changelog](https://shopify.dev/changelog):
- Check changelog monthly
- Update immediately after major releases
- Test new patterns in sandbox before production

---

## 🔔 Setting Up Automatic Notifications

### Option 1: GitHub Watch (Recommended)

1. **Watch Horizon repo**: https://github.com/Shopify/horizon
   - Click "Watch" → "Custom" → "Releases"
2. **Watch Dawn repo**: https://github.com/Shopify/dawn
   - Click "Watch" → "Custom" → "Releases"

You'll get email notifications when Shopify releases updates.

### Option 2: Cron Job (Advanced)

Set up weekly automated updates:

```bash
# Edit crontab
crontab -e

# Add this line (runs every Monday at 9 AM)
0 9 * * 1 cd ~/Documents/GitHub\ Repos/shopify-agency-framework && .claude/scripts/update-references.sh >> .claude/logs/reference-updates.log 2>&1
```

Create log directory:
```bash
mkdir -p .claude/logs
```

---

## 📊 Checking Reference Status

### View Current Commit Hashes

```bash
# Horizon Theme
cd .claude/references/shopify-horizon-theme
git log -1 --oneline

# Dawn Theme
cd .claude/references/shopify-dawn-theme
git log -1 --oneline
```

### Check if Updates Available

```bash
# Horizon Theme
cd .claude/references/shopify-horizon-theme
git fetch origin
git status

# Dawn Theme
cd .claude/references/shopify-dawn-theme
git fetch origin
git status
```

---

## 🆕 What to Do After Updates

### 1. Review Changelog

Check what changed:
```bash
# Horizon Theme
cd .claude/references/shopify-horizon-theme
git log --oneline -10

# Dawn Theme
cd .claude/references/shopify-dawn-theme
git log --oneline -10
```

### 2. Test New Patterns

Ask Claude to show you what's new:
```
"What are the latest changes in the Horizon theme?
Review the recent commits and highlight any new Liquid patterns,
section types, or component structures I should know about."
```

### 3. Update Your Knowledge Base

Document new patterns in `.claude/knowledge/` if they're significant.

### 4. Update Active Projects (Optional)

If you have active client projects using old patterns:
```bash
cd ~/Documents/GitHub\ Projects/client-project
cd .claude/references/shopify-horizon-theme
git pull origin main
```

---

## 🛠️ Troubleshooting

### "Not a git repository" Error

Reference theme directories got corrupted. Re-clone:
```bash
cd .claude/references
rm -rf shopify-horizon-theme shopify-dawn-theme

git clone https://github.com/Shopify/horizon.git shopify-horizon-theme
git clone https://github.com/Shopify/dawn.git shopify-dawn-theme
```

### Merge Conflicts

If you've made local changes (shouldn't happen):
```bash
cd .claude/references/shopify-horizon-theme
git reset --hard origin/main
```

### Permission Denied on Script

Make script executable:
```bash
chmod +x .claude/scripts/update-references.sh
```

---

## 📦 Updating Other Components

### MCP Servers

MCPs are installed via npm/npx and auto-update:
- `npx @modelcontextprotocol/server-shopify-dev` (always latest)
- `npx -y @context7/mcp` (always latest)
- `npx -y firecrawl-mcp` (always latest)
- `n8n-mcp` (update: `npm update -g n8n-mcp`)

### Framework Configuration

Update your template framework from git:
```bash
cd ~/Documents/GitHub\ Repos/shopify-agency-framework
git pull origin main
```

### Middleware Template

Middleware template is static. Update manually if you improve patterns:
```bash
cd .claude/references/shopify-middleware-template
# Make improvements
git add .
git commit -m "feat: Improve webhook retry logic"
```

---

## 🎯 Best Practices

### ✅ DO:
- Update references weekly or before new projects
- Review changelogs after updates
- Test new patterns in sandbox projects
- Document significant changes in `.claude/knowledge/`
- Watch GitHub repos for release notifications

### ❌ DON'T:
- Don't modify cloned theme files directly (they'll be overwritten)
- Don't commit theme repos to your framework git (they're gitignored)
- Don't skip updates for months (you'll miss important changes)
- Don't update mid-project without testing impact

---

## 📅 Maintenance Checklist

### Weekly
- [ ] Run `.claude/scripts/update-references.sh`
- [ ] Check for MCP server updates
- [ ] Review Shopify developer changelog

### Monthly
- [ ] Check for breaking changes in Shopify APIs
- [ ] Update framework from git (`git pull origin main`)
- [ ] Review and update agent prompts if needed

### Before New Projects
- [ ] Update all references
- [ ] Verify MCP servers working
- [ ] Check settings.json for accuracy
- [ ] Test agents with sample queries

---

## 🔗 Resources

- **Shopify Horizon**: https://github.com/Shopify/horizon
- **Shopify Dawn**: https://github.com/Shopify/dawn
- **Shopify Changelog**: https://shopify.dev/changelog
- **Theme Updates**: https://shopify.dev/themes/updates

---

**Last Updated**: 2026-01-27
**Framework Version**: 1.0.0
