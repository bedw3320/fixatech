# Syncing Framework Updates to Client Projects

**How to propagate template improvements to existing migration projects**

---

## 🎯 The Problem

You've created multiple client projects from this template:
- `acme-corp-shopify-migration/`
- `widgets-inc-shopify-migration/`
- `global-retail-shopify-migration/`

You improve the framework (better agents, new skills, bug fixes) in the **template repo**, but those improvements don't automatically appear in existing **client projects**.

**Solution**: Add the template as a git remote and selectively pull updates.

---

## 🚀 Quick Start (One-Time Setup Per Client Project)

### Step 1: Navigate to Client Project
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
```

### Step 2: Add Template Remote
```bash
git remote add template https://github.com/bedw3320/shopify-agency-framework.git
git fetch template
```

### Step 3: Verify Setup
```bash
git remote -v
# Should show:
# origin    https://github.com/bedw3320/acme-corp-shopify-migration.git (fetch)
# origin    https://github.com/bedw3320/acme-corp-shopify-migration.git (push)
# template  https://github.com/bedw3320/shopify-agency-framework.git (fetch)
# template  https://github.com/bedw3320/shopify-agency-framework.git (push)
```

**Done!** Now you can sync framework updates anytime.

---

## 🔄 Syncing Updates (Run Regularly)

### Automated Sync (Recommended)

```bash
# From client project root
.claude/scripts/sync-framework-updates.sh
```

This script:
- ✅ Fetches latest template changes
- ✅ Updates framework files (.claude/agents/, .claude/config/, etc.)
- ✅ Preserves client-specific files (.claude/state/, .claude/knowledge/)
- ✅ Asks for confirmation before overwriting
- ✅ Shows what will be updated

### Manual Sync (Advanced)

If you want more control:

```bash
# 1. Fetch template updates
git fetch template

# 2. View what changed
git log template/main --oneline -10

# 3. Selectively checkout framework files
git checkout template/main -- .claude/agents/
git checkout template/main -- .claude/config/
git checkout template/main -- .claude/docs/
git checkout template/main -- .claude/scripts/
git checkout template/main -- .claude/skills/

# 4. Review and commit
git status
git add -A
git commit -m "chore: Sync framework updates from template"
```

---

## 📂 What Gets Updated vs Preserved

### ✅ Framework Files (Updated from Template)

These are **always safe to overwrite** because they're generic:

```
.claude/
├── agents/                  # ✅ UPDATE - Agent definitions
├── config/                  # ✅ UPDATE - Routing, guardrails, permissions
├── docs/                    # ✅ UPDATE - Documentation
├── scripts/                 # ✅ UPDATE - Automation scripts
├── skills/                  # ✅ UPDATE - Reusable skills
└── references/
    └── shopify-middleware-template/  # ✅ UPDATE - Code patterns
```

### ⚠️ Client-Specific Files (Never Overwrite)

These contain **project-specific data** - never update:

```
.claude/
├── state/                   # ⚠️ PRESERVE - Project state, todos
├── knowledge/               # ⚠️ PRESERVE - Client docs, requirements
├── plans/                   # ⚠️ PRESERVE - Project plans
├── settings.json            # ⚠️ REVIEW - May need manual merge
└── references/
    ├── shopify-horizon-theme/     # ⚠️ PRESERVE - Cloned locally
    └── shopify-dawn-theme/        # ⚠️ PRESERVE - Cloned locally
```

### 🔍 Special Case: settings.json

`settings.json` can have both framework updates AND client-specific data.

**Workflow:**
1. Sync script warns if settings.json changed
2. Review changes carefully: `git diff .claude/settings.json`
3. Manually merge if needed (keep client `project_info`, update `infrastructure_status`)

---

## 📅 Recommended Sync Schedule

### Monthly (Recommended)
Best balance of staying current without constant updates:
```bash
# First Monday of each month
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
```

### After Major Framework Improvements
When you make significant improvements to the template:
```bash
# After improving template
cd ~/Documents/GitHub\ Repos/shopify-agency-framework
git log -1 --oneline  # Note the commit message

# Update all client projects
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
git commit -m "chore: Sync framework - [describe improvement]"
```

### Before Critical Project Milestones
Sync before go-live or major deliveries to ensure latest safety features:
```bash
# 1 week before go-live
.claude/scripts/sync-framework-updates.sh
```

---

## 🛠️ Workflows for Different Scenarios

### Scenario 1: New Agent Added to Template

**Template change**: Added `price-optimization-specialist.md` agent

**Sync to client project:**
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
# New agent automatically appears in .claude/agents/
git add .claude/agents/price-optimization-specialist.md
git commit -m "feat: Add price optimization specialist agent from template"
```

### Scenario 2: Improved Guardrails

**Template change**: Enhanced `.claude/config/guardrails.json` with better validation

**Sync to client project:**
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
# Guardrails updated
git add .claude/config/guardrails.json
git commit -m "chore: Update guardrails with improved validation"
```

### Scenario 3: Bug Fix in Middleware Template

**Template change**: Fixed webhook retry logic in middleware template

**Sync to client project:**
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
# Middleware template updated
git add .claude/references/shopify-middleware-template/
git commit -m "fix: Update middleware template with webhook retry fix"
```

### Scenario 4: New Documentation Added

**Template change**: Added new guide to `.claude/docs/`

**Sync to client project:**
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
.claude/scripts/sync-framework-updates.sh
# New docs appear
git add .claude/docs/
git commit -m "docs: Sync latest documentation from template"
```

---

## 🚨 Handling Conflicts

### Conflict in settings.json

```bash
# After sync, if settings.json conflicts:
git diff .claude/settings.json

# Manual merge:
# 1. Keep client project_info (name, description)
# 2. Update infrastructure_status if template improved
# 3. Keep client-specific notes
# 4. Update mcp_servers if template added new ones
```

### Accidentally Overwrote Client Files

```bash
# Restore from last commit
git checkout HEAD -- .claude/state/
git checkout HEAD -- .claude/knowledge/
git checkout HEAD -- .claude/plans/
```

### Sync Script Not Working

```bash
# Check template remote exists
git remote -v | grep template

# If missing, add it:
git remote add template https://github.com/bedw3320/shopify-agency-framework.git
git fetch template
```

---

## 📊 Tracking What Changed

### View Template Changes Since Last Sync

```bash
# See what's new in template
git fetch template
git log template/main --oneline -10

# Detailed changes in specific directory
git log template/main -- .claude/agents/
```

### Compare Your Project with Template

```bash
# See differences between your project and template
git diff HEAD template/main -- .claude/agents/
git diff HEAD template/main -- .claude/config/
```

### View Sync History

```bash
# See when you last synced from template
git log --grep="Sync framework" --oneline
```

---

## 🎯 Best Practices

### ✅ DO:
- Sync monthly or after major template improvements
- Review changes before committing: `git status` and `git diff`
- Test agents after sync to verify routing still works
- Keep template remote up to date: `git fetch template`
- Document major syncs in commit messages

### ❌ DON'T:
- Don't overwrite `.claude/state/`, `.claude/knowledge/`, or `.claude/plans/`
- Don't blindly sync during active development (finish feature first)
- Don't sync right before go-live (sync 1 week early, test thoroughly)
- Don't modify template files directly in client projects (change in template, then sync)
- Don't forget to commit after sync

---

## 🔄 Alternative: Git Submodule (Advanced)

For power users who want automatic framework tracking:

### Initial Setup (Template Repo)
```bash
# Move .claude/ to separate repo
cd ~/Documents/GitHub\ Repos
mkdir shopify-agency-framework-core
cd shopify-agency-framework-core
# Move .claude/ contents here
git init
git add .
git commit -m "Initial framework core"
git remote add origin https://github.com/bedw3320/shopify-agency-framework-core.git
git push -u origin main
```

### Use in Client Projects
```bash
cd ~/Documents/GitHub\ Projects/acme-corp-shopify-migration
git submodule add https://github.com/bedw3320/shopify-agency-framework-core.git .claude
```

### Update Submodule
```bash
cd .claude
git pull origin main
cd ..
git add .claude
git commit -m "chore: Update framework core"
```

**Pros**: Automatic tracking, clean separation
**Cons**: More complex, harder for team members to understand

**Recommendation**: Stick with the git remote approach (simpler, more flexible)

---

## 📋 Sync Checklist

### Before Syncing
- [ ] Commit or stash current work
- [ ] Note current framework version: `git log -1 .claude/`
- [ ] Fetch template: `git fetch template`
- [ ] Review template changes: `git log template/main --oneline -10`

### During Sync
- [ ] Run sync script: `.claude/scripts/sync-framework-updates.sh`
- [ ] Review changes: `git status` and `git diff`
- [ ] Check settings.json for conflicts
- [ ] Ensure client files preserved (.claude/state/, .claude/knowledge/)

### After Sync
- [ ] Test agent routing with sample query
- [ ] Update theme references: `.claude/scripts/update-references.sh`
- [ ] Run validation tests if available
- [ ] Commit: `git commit -m "chore: Sync framework updates"`
- [ ] Document what changed in commit message

---

## 🆘 Troubleshooting

### "Template remote not found"
```bash
git remote add template https://github.com/bedw3320/shopify-agency-framework.git
git fetch template
```

### "Conflicts in settings.json"
```bash
# Manual merge - keep client project_info, update framework fields
git diff .claude/settings.json
# Edit file manually
git add .claude/settings.json
```

### "Accidentally overwrote client data"
```bash
git checkout HEAD -- .claude/state/
git checkout HEAD -- .claude/knowledge/
git checkout HEAD -- .claude/plans/
```

### "Sync script permissions denied"
```bash
chmod +x .claude/scripts/sync-framework-updates.sh
```

---

## 🔗 Resources

- **Template Repository**: https://github.com/bedw3320/shopify-agency-framework
- **Git Remotes**: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
- **Git Cherry-Pick**: https://git-scm.com/docs/git-cherry-pick
- **Git Submodules**: https://git-scm.com/book/en/v2/Git-Tools-Submodules

---

**Last Updated**: 2026-01-27
**Framework Version**: 1.0.0
