---
name: commit-message
description: "Use when drafting, reviewing, or choosing a git commit message. Follow project conventions first, then explicit user instructions; otherwise use `type: 日本語の概要` with a Conventional Commits type."
---

# Commit Message

## Overview

Make commit messages clear and predictable. Follow project conventions first; when neither project conventions nor user instructions specify a format, use a Conventional Commits type followed by a concise Japanese summary.

## Rule

1. Check for project-specific commit message instructions in files such as `AGENTS.md`, `CONTRIBUTING.md`, `.github/`, release docs, or existing nearby commit history.
2. If a project-specific rule or established commit-message convention exists, follow it.
3. If neither exists and the user specifies a format or asks to match existing messages, follow the user's instruction.
4. Otherwise, use this format:

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

- Write a concise Japanese summary of the change.
- Prefer domain wording used in the repository.
- Add a scope when it improves clarity or follows project conventions.
- Base claims about the change and its impact on available evidence.

## Intent

Make the intent understandable when someone traces the change later, for example with `git blame`.
If the summary and diff do not convey it, briefly explain the background, reasoning, or constraints in the body.
Omit the body when it adds no useful context; do not recount the sequence of attempts.
