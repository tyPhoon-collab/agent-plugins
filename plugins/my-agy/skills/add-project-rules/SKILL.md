---
name: add-project-rules
description: Install project-local Antigravity rules (AGENTS.md) into a repository. Use when the user wants to add, initialize, or template project-specific rules, guidelines, or tool policies for AI assistants.
---

# Add Project Rules

## Overview

Install a starter `AGENTS.md` rules file into the current repository so the project defines its tool policies and guidelines. The starter template sets conventions for `mise`, `just`, commit messages, and concise replies.

## Workflow

1. Confirm the target is a repository where project-local rules are appropriate.
2. Run `scripts/install-project-rules.sh` from this skill, passing the target repository path when it is not the current directory.
3. Review the generated `AGENTS.md` with the user.
4. Adapt the rules to the project's specific workflows and conventions.

## Commands

Install into the current directory:

```sh
<this-skill>/scripts/install-project-rules.sh
```

Install into another repository:

```sh
<this-skill>/scripts/install-project-rules.sh /path/to/repo
```

Overwrite an existing `AGENTS.md`:

```sh
<this-skill>/scripts/install-project-rules.sh --force /path/to/repo
```

## Resources

- `assets/AGENTS.starter.md`: Starter `AGENTS.md` template.
- `scripts/install-project-rules.sh`: Copies the template to `AGENTS.md`.
