#!/usr/bin/env bash
set -euo pipefail

CODEOWNERS_PATH=".github/CODEOWNERS"

# ---- POLICY: Strict (default) ----
STANDARD_CONTENT="* @growhi/devops"

# ---- POLICY: Targeted (uncomment to use instead) ----
# STANDARD_CONTENT=".github/CODEOWNERS @growhi/devops"

mkdir -p .github

# Read existing if present, normalize whitespace
if [[ -f "$CODEOWNERS_PATH" ]]; then
  existing="$(grep -v '^[[:space:]]*$' "$CODEOWNERS_PATH" | sed 's/[[:space:]]\+/ /g')"
else
  existing=""
fi

if [[ "$existing" != "$STANDARD_CONTENT" ]]; then
  printf "%s\n" "$STANDARD_CONTENT" > "$CODEOWNERS_PATH"
  echo " Wrote $CODEOWNERS_PATH to match the standard."
else
  echo " $CODEOWNERS_PATH already compliant."
fi
