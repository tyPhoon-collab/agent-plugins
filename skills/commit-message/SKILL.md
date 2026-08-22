---
name: commit-message
description: "Use when drafting, reviewing, or choosing a git commit message. If the project has no explicit rule, use `type: 日本語の概要` with a Conventional Commits type."
---

# Commit Message

## Overview

Make commit messages clear and predictable. When the project has no stronger rule, use a Conventional Commits type followed by a concise Japanese summary.

## Rule

1. Check for project-specific commit message instructions in files such as `AGENTS.md`, `CONTRIBUTING.md`, `.github/`, release docs, or existing nearby commit history.
2. If a project-specific rule exists, follow it.
3. If no project-specific rule exists, use this format:

```text
type: 日本語の概要
```

## Type Selection

Use Conventional Commits types. Prefer:

- `feat`: user-facing feature or new capability
- `fix`: bug fix
- `docs`: documentation-only change
- `style`: formatting-only change
- `refactor`: behavior-preserving code restructuring
- `test`: tests only
- `chore`: maintenance, tooling, config, or repository housekeeping
- `build`: build system or dependency change
- `ci`: CI workflow change
- `perf`: performance improvement
- `revert`: revert a previous commit

## Summary

- Write the summary in Japanese.
- Keep it short and specific to the actual diff.
- Prefer the user's domain wording when the repository already uses it.
- Do not add a scope unless project rules or nearby history clearly prefer it.
- Do not invent impact that is not visible in the staged changes.
