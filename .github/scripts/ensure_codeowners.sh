#!/usr/bin/env bash
set -euo pipefail

CODEOWNERS_PATH=".github/CODEOWNERS"

# ---- POLICY: Strict (default) ----
STANDARD_CONTENT="* @DriveWealth/devops"

# ---- POLICY: Targeted (uncomment to use instead) ----
# STANDARD_CONTENT=".github/CODEOWNERS @DriveWealth/devops"

if [[ ! -f "$CODEOWNERS_PATH" ]]; then
  echo " ERROR: $CODEOWNERS_PATH does not exist."
  exit 1
fi

content="$(grep -v '^[[:space:]]*$' "$CODEOWNERS_PATH" | sed 's/[[:space:]]\+/ /g')"

if [[ "$content" != "$STANDARD_CONTENT" ]]; then
  echo " ERROR: CODEOWNERS content is not standard."
  echo "Expected: $STANDARD_CONTENT"
  echo "Found: $content"
  exit 1
fi

echo " CODEOWNERS file is valid."

