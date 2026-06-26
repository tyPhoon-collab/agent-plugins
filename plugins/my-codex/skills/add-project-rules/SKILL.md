---
name: add-project-rules
description: Install project-local Codex rules templates into a repository. Use when the user wants to add, copy, initialize, or update `.codex/rules/*.rules` for project-specific command allowlists such as `git add`, `git commit`, or `just`.
---

# Add Project Rules

## Overview

Install a starter Codex rules file into the current repository so the project owns its command policy. The bundled template allows `git add`, `git commit`, and `just`, then expects each project to edit `.codex/rules/default.rules` as its workflow matures.

## Workflow

1. Confirm the target is a repository where project-local Codex config is appropriate.
2. Run `scripts/install-project-rules.sh` from this skill, passing the target repo path when it is not the current directory.
3. Review the generated `.codex/rules/default.rules` with the user when the allowlist affects risky workflows.
4. Leave project-specific changes in the target repository; do not copy rules into `~/.codex/rules/` unless the user explicitly asks for global rules.

## Commands

Install into the current directory:

```sh
<this-skill>/scripts/install-project-rules.sh
```

Install into another repository:

```sh
<this-skill>/scripts/install-project-rules.sh /path/to/repo
```

Overwrite an existing rules file only when the user has asked for replacement:

```sh
<this-skill>/scripts/install-project-rules.sh --force /path/to/repo
```

## Rule Policy

- Prefer project-local `.codex/rules/default.rules` for `just`, because `justfile` contents are repository-specific.
- Treat `[confirm]` in `justfile` as useful defense-in-depth, not as a reason to make a global `just` allow rule.
- Keep global `~/.codex/rules/` rules limited to commands that are safe across unrelated repositories.
- After copying, suggest `codex execpolicy check --rules .codex/rules/default.rules -- <command>` when the user wants to verify a match.

## Resources

- `assets/default.rules`: starter project-local rules template.
- `scripts/install-project-rules.sh`: copies the template to `.codex/rules/default.rules`.
