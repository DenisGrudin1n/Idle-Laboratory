#!/bin/bash

# ==============================================================================
# AI WHOLE-CODEBASE ARCHITECTURE REVIEW (phased)
# Same rules/prompt shape as review_pr.sh, but reviews source slices of lib/
# instead of a GitHub PR diff. Findings go to ai_docs/Architecture_Audit.md.
# ==============================================================================

set -euo pipefail

AUDIT_DOC="ai_docs/Architecture_Audit.md"

usage() {
  cat <<'USAGE'
Usage: ./review_codebase.sh <PHASE>
       ./review_codebase.sh --list

Phases (run one at a time; paste into Cursor Agent after each run):
  1-bootstrap   main.dart + lib/app/
  2-core        lib/core/ (hand-written only)
  3-data        repositories + LocalStorageDataSource
  4-domain      domain models + services
  5-blocs       presentation BLoCs / Cubits
  6-ui-cells    cells / production / energy / prestige UI + CellsScreen
  7-ui-crafting crafting / research / storage UI
  8-ui-meta     statistics / story / settings / navigation chrome

Example:
  ./review_codebase.sh 4-domain
  # Cmd+I → Agent → paste → Enter
  # Agent appends findings to ai_docs/Architecture_Audit.md and updates the checklist
USAGE
}

list_phases() {
  usage
}

# Collect hand-written Dart under PATHS (skip codegen / flutter_gen).
collect_sources() {
  local paths=("$@")
  local out=""
  local f
  while IFS= read -r f; do
    [[ -z "$f" ]] && continue
    case "$f" in
      *.g.dart|*.freezed.dart|*.config.dart) continue ;;
    esac
    [[ "$f" == lib/gen/* ]] && continue
    [[ "$f" == lib/l10n/app_localizations*.dart ]] && continue
    out+="
=========================================
FILE: $f
=========================================
$(cat "$f")
"
  done < <(find "${paths[@]}" -type f -name '*.dart' 2>/dev/null | sort)
  printf '%s' "$out"
}

PHASE="${1:-}"
if [[ -z "$PHASE" ]]; then
  usage
  exit 1
fi
if [[ "$PHASE" == "--list" || "$PHASE" == "-h" || "$PHASE" == "--help" ]]; then
  list_phases
  exit 0
fi

case "$PHASE" in
  1-bootstrap)
    PHASE_TITLE="Bootstrap (main + AppWidget)"
    SOURCE_ROOTS=(lib/main.dart lib/app)
    ;;
  2-core)
    PHASE_TITLE="Core (lib/core)"
    SOURCE_ROOTS=(lib/core)
    ;;
  3-data)
    PHASE_TITLE="Data layer (repositories + LocalStorageDataSource)"
    SOURCE_ROOTS=(lib/features/home/data)
    ;;
  4-domain)
    PHASE_TITLE="Domain (models + services)"
    SOURCE_ROOTS=(lib/features/home/domain)
    ;;
  5-blocs)
    PHASE_TITLE="Presentation BLoCs"
    SOURCE_ROOTS=(lib/features/home/presentation/blocs)
    ;;
  6-ui-cells)
    PHASE_TITLE="UI — cells / production / energy / prestige"
    SOURCE_ROOTS=(
      lib/features/home/presentation/screens
      lib/features/home/presentation/widgets/cells
      lib/features/home/presentation/widgets/production
      lib/features/home/presentation/widgets/energy_display.dart
      lib/features/home/presentation/widgets/main_navigation_bar.dart
      lib/features/home/presentation/controllers
    )
    ;;
  7-ui-crafting)
    PHASE_TITLE="UI — crafting / research / storage"
    SOURCE_ROOTS=(
      lib/features/home/presentation/widgets/crafting
      lib/features/home/presentation/widgets/research
      lib/features/home/presentation/widgets/storage
    )
    ;;
  8-ui-meta)
    PHASE_TITLE="UI — statistics / story / settings / misc chrome"
    SOURCE_ROOTS=(
      lib/features/home/presentation/widgets/statistics
      lib/features/home/presentation/widgets/story
      lib/features/home/presentation/widgets/settings_toggle.dart
    )
    ;;
  *)
    echo "❌ Unknown phase: $PHASE"
    echo ""
    list_phases
    exit 1
    ;;
esac

# Expand roots: allow both dirs and single files
EXISTING_ROOTS=()
for root in "${SOURCE_ROOTS[@]}"; do
  if [[ -e "$root" ]]; then
    EXISTING_ROOTS+=("$root")
  else
    echo "⚠️  Missing path (skipped): $root"
  fi
done
if [[ ${#EXISTING_ROOTS[@]} -eq 0 ]]; then
  echo "❌ No source paths found for phase $PHASE"
  exit 1
fi

echo "⏳ Step 1: Collecting sources for phase [$PHASE] — $PHASE_TITLE..."
CODE_SLICE=$(collect_sources "${EXISTING_ROOTS[@]}")
FILE_COUNT=$(printf '%s' "$CODE_SLICE" | grep -c '^FILE: ' || true)
if [[ -z "$CODE_SLICE" || "$FILE_COUNT" -eq 0 ]]; then
  echo "❌ No Dart sources collected for phase $PHASE"
  exit 1
fi
echo "   → $FILE_COUNT file(s)"

echo "📖 Step 2: Extracting project context and custom rules..."

README_CONTEXT=""
if [[ -f "README.md" ]]; then
  README_CONTEXT=$(grep -A 80 "## Architecture & Data Flow" README.md || true)
fi

RULES_CONTEXT=""
if [[ -d ".cursor/rules" ]]; then
  for rule_file in .cursor/rules/*.mdc; do
    if [[ -f "$rule_file" ]]; then
      RULES_CONTEXT="$RULES_CONTEXT

--- Rule: $(basename "$rule_file") ---
$(cat "$rule_file")"
    fi
  done
fi

AUDIT_SNAPSHOT=""
if [[ -f "$AUDIT_DOC" ]]; then
  AUDIT_SNAPSHOT=$(cat "$AUDIT_DOC")
fi

echo "🤖 Step 3: Packing prompt for Cursor Agent..."

read -r -d '' PROMPT <<EOF || true
You are an elite Senior Flutter & Architecture Reviewer assessing code for the "Idle Laboratory" project.
Your goal is to perform a strict architectural audit on the provided **codebase slice** based on our explicit core design documentation and rules.

This is a **phased whole-project review** (same standards as a PR review via review_pr.sh), not a git diff.
Current phase: **$PHASE** — $PHASE_TITLE

=========================================
PROJECT ARCHITECTURE OVERVIEW (From README)
=========================================
$README_CONTEXT

=========================================
ENFORCEABLE PROJECT RULES (.cursor/rules)
=========================================
$RULES_CONTEXT

=========================================
AUDIT PROGRESS DOC (read + update)
=========================================
Path: $AUDIT_DOC

Current contents:
$AUDIT_SNAPSHOT

=========================================
CODEBASE SLICE TO REVIEW (phase $PHASE)
=========================================
$CODE_SLICE

=========================================
REVIEW & WRITE-BACK INSTRUCTIONS (CRITICAL)
=========================================
Evaluate the codebase slice strictly against the project architecture rules above.
1. Ignore trivial issues (formatting, missing const, typos) unless they break performance rules (e.g. 100ms hot path ticks).
2. Look out for critical anti-patterns:
   - Business or game rules leaking directly into UI Widgets or Repositories instead of domain Services.
   - Manual object instantiation instead of resolving components via our Dependency Injection layer (GetIt/Injectable).
   - Missing stream lifecycle controls or unmanaged StreamSubscriptions causing memory leaks.
   - Cross-module boundary violations (Feature-First encapsulation breaks).
   - Direct Local Storage or SharedPreferences calls skipping the Repository layer.
3. Do **not** re-audit phases already marked reviewed in $AUDIT_DOC unless this slice clearly contradicts a prior note.
4. Prefer concrete file paths + short rationale. Skip praise of compliant code.

OUTPUT FORMAT (markdown):
### Phase $PHASE — $PHASE_TITLE
#### Critical Architectural Breaches
- …
#### Refactoring Options
- …
#### Notes
- short scope caveats if any

AUTOMATIC EXECUTION (DO NOT WAIT FOR USER):
1. Append the review section above to \`$AUDIT_DOC\` under "## Findings" (create the heading if missing).
2. Update the checklist in \`$AUDIT_DOC\`:
   - Mark **$PHASE** as reviewed (\`[x]\`) with today's date.
   - Leave remaining phases unchecked.
   - At the bottom under "## Coverage", rewrite a short "Reviewed" / "Left" summary listing phase ids.
3. Do **not** open a GitHub PR or run \`gh pr comment\` unless the user asks.
4. After writing the file, briefly confirm to the user what you appended and which phases remain.
EOF

if [[ "$OSTYPE" == "darwin"* ]]; then
  printf '%s' "$PROMPT" | pbcopy
  echo "✅ Prompt for phase [$PHASE] copied to macOS clipboard."
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  printf '%s' "$PROMPT" | clip.exe
  echo "✅ Prompt for phase [$PHASE] copied to Windows clipboard."
elif command -v xclip &>/dev/null; then
  printf '%s' "$PROMPT" | xclip -selection clipboard
  echo "✅ Prompt for phase [$PHASE] copied to Linux clipboard."
else
  OUT="ai_codebase_review_${PHASE}.txt"
  printf '%s' "$PROMPT" > "$OUT"
  echo "✅ Prompt written to $OUT (no clipboard tool found)."
fi

echo ""
echo "🚀 Next steps:"
echo "1. Cmd+I → Agent mode"
echo "2. Paste (Cmd+V) and Enter"
echo "3. Agent reviews this slice and updates $AUDIT_DOC"
echo "4. When done, run the next phase, e.g.:"
case "$PHASE" in
  1-bootstrap) echo "   ./review_codebase.sh 2-core" ;;
  2-core) echo "   ./review_codebase.sh 3-data" ;;
  3-data) echo "   ./review_codebase.sh 4-domain" ;;
  4-domain) echo "   ./review_codebase.sh 5-blocs" ;;
  5-blocs) echo "   ./review_codebase.sh 6-ui-cells" ;;
  6-ui-cells) echo "   ./review_codebase.sh 7-ui-crafting" ;;
  7-ui-crafting) echo "   ./review_codebase.sh 8-ui-meta" ;;
  8-ui-meta) echo "   (all phases done — skim $AUDIT_DOC for prioritised fixes)" ;;
esac
