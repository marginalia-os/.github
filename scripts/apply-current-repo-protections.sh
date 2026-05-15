#!/usr/bin/env bash
set -euo pipefail

ORG="${ORG:-marginalia-os}"
LIMIT="${LIMIT:-400}"

payload="$(mktemp)"
cat >"$payload" <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
JSON

repos="$(
  gh repo list "$ORG" \
    --limit "$LIMIT" \
    --json name,defaultBranchRef,isArchived \
    --jq '.[] | select(.isArchived == false and .defaultBranchRef.name != "") | [.name, .defaultBranchRef.name] | @tsv'
)"

if [[ -z "$repos" ]]; then
  echo "No non-archived repositories with default branches found for $ORG."
  exit 0
fi

while IFS=$'\t' read -r repo branch; do
  echo "Protecting $ORG/$repo:$branch"
  gh api -X PUT "repos/$ORG/$repo/branches/$branch/protection" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    --input "$payload" >/dev/null
done <<<"$repos"

echo
echo "Protected branches:"
while IFS=$'\t' read -r repo branch; do
  protected="$(
    gh api "repos/$ORG/$repo/branches/$branch" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      --jq '.protected'
  )"
  echo "$ORG/$repo:$branch protected=$protected"
done <<<"$repos"
