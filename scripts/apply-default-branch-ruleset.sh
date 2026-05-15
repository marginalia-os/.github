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

existing_id="$(
  gh api "orgs/$ORG/rulesets" \
    --jq ".[] | select(.name == \"$RULESET_NAME\" and .target == \"branch\") | .id" \
    2>/dev/null || true
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
