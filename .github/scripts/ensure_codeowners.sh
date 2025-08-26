#!/usr/bin/env bash
set -euo pipefail

CODEOWNERS_PATH=".github/CODEOWNERS"
STANDARD_CONTENT="* @growhi/devops"

mkdir -p .github

# Normalize existing file content (remove blank lines, normalize whitespace)
if [[ -f "$CODEOWNERS_PATH" ]]; then
  existing="$(grep -v '^[[:space:]]*$' "$CODEOWNERS_PATH" | sed 's/[[:space:]]\+/ /g')"
else
  existing=""
fi

# Compare and rewrite if needed
if [[ "$existing" != "$STANDARD_CONTENT" ]]; then
  echo "🔧 CODEOWNERS is not compliant. Rewriting it to standard."
  printf "%s\n" "$STANDARD_CONTENT" > "$CODEOWNERS_PATH"

  # Git status check to fail the job and notify the dev
  if [[ -n "$(git status --porcelain "$CODEOWNERS_PATH")" ]]; then
    echo "❌ CODEOWNERS was updated by CI to match standards."
    echo "👉 Please commit the updated $CODEOWNERS_PATH into this PR."
    git diff "$CODEOWNERS_PATH"
    exit 1
  fi
else
  echo "✅ CODEOWNERS is already compliant."
fi

