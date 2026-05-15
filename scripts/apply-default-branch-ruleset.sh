#!/usr/bin/env bash
set -euo pipefail

ORG="${ORG:-marginalia-os}"
RULESET_NAME="${RULESET_NAME:-Default branch protection}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PAYLOAD_FILE="${PAYLOAD_FILE:-$ROOT_DIR/rulesets/default-branches.json}"

if [[ -z "${GH_TOKEN:-}" ]]; then
  echo "GH_TOKEN is required and must have organization administration access for $ORG." >&2
  exit 1
fi

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "GitHub authentication failed. Set GH_TOKEN to a real token with organization administration access for $ORG." >&2
  exit 1
fi

rulesets_json="$(mktemp)"
if ! gh api "orgs/$ORG/rulesets" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  >"$rulesets_json"; then
  echo "Could not list organization rulesets for $ORG." >&2
  echo "The token must be valid and must have organization administration access." >&2
  exit 1
fi

existing_id="$(
  python3 - "$RULESET_NAME" "$rulesets_json" <<'PY'
import json
import sys

name, path = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as handle:
    rulesets = json.load(handle)

for ruleset in rulesets:
    if ruleset.get("name") == name and ruleset.get("target") == "branch":
        print(ruleset["id"])
        break
PY
)"

if [[ -n "$existing_id" ]]; then
  gh api -X PUT "orgs/$ORG/rulesets/$existing_id" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    --input "$PAYLOAD_FILE" >/dev/null
  echo "Updated organization ruleset $existing_id for $ORG."
else
  created_id="$(
    gh api -X POST "orgs/$ORG/rulesets" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      --input "$PAYLOAD_FILE" \
      --jq ".id"
  )"
  echo "Created organization ruleset $created_id for $ORG."
fi
