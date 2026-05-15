# Marginalia Organization

Shared organization profile, governance notes, and maintenance automation for Marginalia.

## Branch Rules

Default branches are protected directly on the current repositories.

For the current GitHub plan, use the per-repository protection script whenever a new repository is created:

```bash
scripts/apply-current-repo-protections.sh
```

The script protects each non-archived repository's default branch from force pushes and deletion, enables linear history, and requires review thread resolution.

GitHub organization rulesets are documented in `rulesets/default-branches.json` for later. Apply or update the organization ruleset after upgrading to a plan that supports organization rulesets:

```bash
GH_TOKEN=... scripts/apply-default-branch-ruleset.sh
```

The token must have organization administration access for `marginalia-os`. Do not commit tokens, paste them into issues, or pass them through shell commands that will be saved in history.
