# AGENTS.md

Guidance for agents working in `marginalia-os/.github`.

## Project Role

This repo backs the `marginalia-os/.github` organization profile, default contribution guidance, and repository
protection automation.

## Common Commands

Apply current per-repository branch protections:

```sh
scripts/apply-current-repo-protections.sh
```

Organization rulesets are documented for later plan support:

```sh
GH_TOKEN=... scripts/apply-default-branch-ruleset.sh
```

## Guidelines

- Never commit GitHub tokens, credentials, or generated command history containing tokens.
- Keep organization profile copy consistent with the actual repo map.
- Prefer per-repo protections until organization rulesets are available on the current GitHub plan.
- Protection changes should preserve review thread resolution and prevent force pushes/deletion on default branches.
- Shared contribution guidance belongs here only when it applies to most Marginalia repos; repo-specific commands belong in that repo.
