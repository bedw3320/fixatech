#!/bin/bash

###############################################################################
# Sync Framework Updates to Client Project
#
# Pulls latest framework changes from template repo into client project
# Safely updates .claude/ directory while preserving client-specific files
###############################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "🔄 Syncing Framework Updates..."
echo "================================================"
echo ""

# Check if we're in a client project (has template remote)
if ! git remote | grep -q "template"; then
    echo "⚠️  Template remote not found!"
    echo ""
    echo "This appears to be a client project without the template remote."
    echo "Add the template remote first:"
    echo ""
    echo "  git remote add template https://github.com/bedw3320/shopify-agency-framework.git"
    echo "  git fetch template"
    echo ""
    exit 1
fi

echo "📥 Fetching latest template changes..."
git fetch template

echo ""
echo "📊 Framework Files to Update:"
echo "   ├── .claude/agents/ (agent definitions)"
echo "   ├── .claude/config/ (routing, guardrails, permissions)"
echo "   ├── .claude/docs/ (documentation)"
echo "   ├── .claude/scripts/ (automation scripts)"
echo "   ├── .claude/skills/ (reusable skills)"
echo "   └── .claude/references/shopify-middleware-template/ (code patterns)"
echo ""

# Ask for confirmation
read -p "⚠️  This will overwrite framework files. Client-specific files in .claude/state/ and .claude/knowledge/ will be preserved. Continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Update cancelled."
    exit 0
fi

echo ""
echo "🔄 Applying framework updates..."

# Strategy: Cherry-pick framework directories while preserving client files
# We'll use git checkout for specific paths from the template

# Framework directories to update (overwrite)
FRAMEWORK_DIRS=(
    ".claude/agents/"
    ".claude/config/"
    ".claude/docs/"
    ".claude/scripts/"
    ".claude/skills/"
    ".claude/references/shopify-middleware-template/"
    ".gitignore"
    "README.md"
)

# Client-specific directories to preserve (never overwrite)
CLIENT_DIRS=(
    ".claude/state/"
    ".claude/knowledge/"
    ".claude/plans/"
)

# Checkout framework files from template
for dir in "${FRAMEWORK_DIRS[@]}"; do
    if git ls-tree template/main "$dir" >/dev/null 2>&1; then
        echo "  ✅ Updating $dir"
        git checkout template/main -- "$dir" 2>/dev/null || echo "  ⚠️  $dir not found in template (may be new)"
    fi
done

echo ""
echo "🔍 Checking for conflicts..."

# Check if settings.json was modified
if git diff --quiet HEAD .claude/settings.json 2>/dev/null; then
    echo "  ✅ No conflicts in settings.json"
else
    echo "  ⚠️  settings.json has changes - review carefully!"
    echo "     You may need to manually merge infrastructure updates"
fi

echo ""
echo "================================================"
echo "✅ Framework update complete!"
echo ""
echo "📋 Next Steps:"
echo "   1. Review changes: git status"
echo "   2. Test agents: Ask a sample query to verify routing"
echo "   3. Update references: .claude/scripts/update-references.sh"
echo "   4. Commit changes: git add -A && git commit -m 'chore: Sync framework updates from template'"
echo ""
echo "💡 Files Preserved (client-specific):"
echo "   ├── .claude/state/ (project state)"
echo "   ├── .claude/knowledge/ (client docs)"
echo "   ├── .claude/plans/ (project plans)"
echo "   └── .claude/settings.json (merged manually if needed)"
