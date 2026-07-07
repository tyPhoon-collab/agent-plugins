---
name: worktree-switch
description: Use Worktrunk (`wt switch`) safely from Codex when creating or switching Git worktrees, especially when directory changes should not leak across tool calls. Trigger when the user asks to use Worktrunk, `wt switch`, create a worktree for an agent task, or prepare branch-isolated work.
---

# Worktree Switch

Use `wt switch` with `--no-cd` from Codex. Codex can access the created worktree path normally, but its tool cwd does not automatically move.

## Workflow

1. Confirm `wt` exists with `command -v wt`.
2. If the repo has a remote, run `git fetch --prune` first.
3. Choose the base:
   - Prefer `origin/main` when it exists.
   - Else use `origin/master` when it exists.
   - Else omit `--base` and let Worktrunk use its default branch.
4. Create or switch with:

```sh
wt switch --create <branch> --no-cd --format json [--base <base>]
```

Use `--no-hooks` when hooks would be slow, interactive, or unrelated to the task.

## After Switching

- Parse the returned `path` as the worktree root. If stdout has extra human-readable lines, use the JSON object line.
- Run subsequent commands with `workdir` set to that path.
- Edit files under that path directly; it is a normal sibling worktree directory.
- Do not rely on shell integration or `cd` state inside Codex.

## Notes

- Worktrunk docs define `--base` as the source branch for `--create`; it defaults to the default branch.
- Worktrunk docs define `--no-cd` as skipping directory change after switching, useful for CI/automation.
- If `--create` fails because the branch exists, retry without `--create`.
