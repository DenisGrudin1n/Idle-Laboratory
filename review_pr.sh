#!/bin/bash

# ==============================================================================
# AI PULL REQUEST REVIEW GENERATOR (FOR CURSOR PRO / CLAUDE CODE)
# Target Architecture: Feature-First, BLoC, RxDart Services (Idle Laboratory)
# ==============================================================================

# Ensure a PR number was provided
if [ -z "$1" ]; then
  echo "❌ Error: Please provide a Pull Request number."
  echo "👉 Usage: ./review_pr.sh <PR_NUMBER>"
  echo "👉 Example: ./review_pr.sh 12"
  exit 1
fi

PR_NUMBER=$1

echo "⏳ Step 1: Downloading code changes from GitHub PR #$PR_NUMBER..."
# Fetch the git diff using GitHub CLI
PR_DIFF=$(gh pr diff "$PR_NUMBER" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$PR_DIFF" ]; then
  echo "❌ Error: Failed to fetch diff from GitHub."
  echo "💡 Make sure you are authenticated. Run: gh auth login"
  exit 1
fi

echo "📖 Step 2: Extracting project context and custom rules..."

# Gather global instructions from README.md if it exists
README_CONTEXT=""
if [ -f "README.md" ]; then
  README_CONTEXT=$(cat README.md | grep -A 50 "## Architecture & Data Flow")
fi

# Dynamically gather all specific custom rules from .cursor/rules/
RULES_CONTEXT=""
if [ -d ".cursor/rules" ]; then
  for rule_file in .cursor/rules/*.md; do
    if [ -f "$rule_file" ]; then
      RULES_CONTEXT="$RULES_CONTEXT\n\n--- Rule: $(basename "$rule_file") ---\n$(cat "$rule_file")"
    fi
  fi
else
  # Fallback check if rules are stored as extensionless or alternative structures
  for rule_file in .cursor/rules/*; do
    if [ -f "$rule_file" ]; then
      RULES_CONTEXT="$RULES_CONTEXT\n\n--- Rule: $(basename "$rule_file") ---\n$(cat "$rule_file")"
    fi
  fi
fi

echo "🤖 Step 3: Packing prompt for Cursor Pro..."

# Build the golden master prompt combining your file definitions
read -r -d '' PROMPT <<EOF
You are an elite Senior Flutter & Architecture Reviewer assessing code for the "Idle Laboratory" project.
Your goal is to perform a strict architectural audit on the provided Pull Request Diff based on our explicit core design documentation and rules.

=========================================
PROJECT ARCHITECTURE OVERVIEW (From README)
=========================================
$README_CONTEXT

=========================================
ENFORCEABLE PROJECT RULES (.cursor/rules)
=========================================
$RULES_CONTEXT

=========================================
PULL REQUEST CHANGES (Git Diff)
=========================================
$PR_DIFF

=========================================
REVIEW INSTRUCTIONS
=========================================
Evaluate the Git Diff strictly against the project architecture rules provided above.
1. Ignore trivial issues (formatting, missing const, typos) unless they break performance rules (e.g. 100ms hot path ticks).
2. Look out for critical anti-patterns:
   - Business or game rules leaking directly into UI Widgets or Repositories instead of domain Services.
   - Manual object instantiation instead of resolving components via our Dependency Injection layer (GetIt/Injectable).
   - Missing stream lifecycle controls or unmanaged StreamSubscriptions causing memory leaks.
   - Cross-module boundary violations (Feature-First encapsulation breaks).
   - Direct Local Storage or SharedPreferences calls skipping the Repository layer.

Provide your feedback in a clean, professional markdown format. Group your points into "Critical Architectural Breaches" and "Refactoring Options".
EOF

# Copy the generated payload to system clipboard cleanly based on the OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "$PROMPT" | pbcopy
  echo "✅ Success! The entire context and rules prompt has been copied to your macOS clipboard."
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  echo "$PROMPT" | clip.exe
  echo "✅ Success! The entire context and rules prompt has been copied to your Windows clipboard."
else
  # Linux fallback using xclip
  if command -v xclip &> /dev/null; then
    echo "$PROMPT" | xclip -selection clipboard
    echo "✅ Success! The entire context and rules prompt has been copied to your Linux clipboard."
  else
    echo "⚠️ System clipboard utility not found. Writing output directly to 'ai_pr_prompt.txt' instead."
    echo "$PROMPT" > ai_pr_prompt.txt
  fi
fi

echo ""
echo "👉 Next steps:"
echo "1. Press 'Cmd + I' (Mac) or 'Ctrl + I' (Windows) inside Cursor to open the Composer panel."
echo "2. Switch the Composer mode to 'Agent' and select Claude 3.5 Sonnet."
echo "3. Paste your clipboard content into the chat and hit Enter."
echo "4. After the review completes, ask the agent to execute this terminal command to post comments directly back to the GitHub PR:"
echo "   gh pr comment $PR_NUMBER --body \"<PASTE_AI_RESPONSE_TEXT_HERE>\""
