# Marginalia Organization

Shared organization profile, governance notes, and maintenance automation for Marginalia.

## Branch Rules

Default branches are protected directly on the current repositories. Future repositories should also be covered by the organization ruleset in `rulesets/default-branches.json`.

Apply or update the organization ruleset with:

```bash
GH_TOKEN=... scripts/apply-default-branch-ruleset.sh
```

The token must have organization administration access for `marginalia-os`. Do not commit tokens, paste them into issues, or pass them through shell commands that will be saved in history.
