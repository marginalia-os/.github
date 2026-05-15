# Contributing to Marginalia

Marginalia is split across several small repositories. Keep changes focused, run
the checks for the repository you are changing, and open pull requests with a
clear problem statement and verification notes.

## Pull Request Review

CodeRabbit is installed on Marginalia pull requests. It provides automated
summaries and review comments after a PR is opened or updated.

Use it as review input, not as a substitute for maintainer judgment:

- Fix CodeRabbit comments that identify a real bug, crash risk, data loss risk,
  security issue, or broken user workflow.
- Treat style-only suggestions and broad refactor ideas as optional.
- If a suggestion conflicts with the repository architecture, explain why in the
  PR thread instead of changing the code to satisfy the bot.
- Do not paste secrets, private device logs, account tokens, or unpublished
  content into PRs or review prompts.

## Optional Local CodeRabbit Review

Maintainers and contributors with the CodeRabbit CLI can run a local review
before opening a PR:

```sh
coderabbit auth login
coderabbit review --plain -t uncommitted
```

For agent-driven workflows, use structured output:

```sh
coderabbit review --agent -t uncommitted
```

Run local CodeRabbit only on changes you are comfortable sending to CodeRabbit's
service. The CLI is useful for finding bugs before CI, but repository checks and
manual review still decide whether a change is ready.

## Repository Checks

Each repository has its own checks. Start with its README or contributing docs.
For firmware changes, see:

- [Getting started](https://github.com/marginalia-os/marginalia-firmware/blob/master/docs/contributing/getting-started.md)
- [Development workflow](https://github.com/marginalia-os/marginalia-firmware/blob/master/docs/contributing/development-workflow.md)
- [Testing and debugging](https://github.com/marginalia-os/marginalia-firmware/blob/master/docs/contributing/testing-debugging.md)

For package work, check the SDK package contract and the examples README before
publishing artifacts to the registry or hub.
