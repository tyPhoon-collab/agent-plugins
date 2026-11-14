---
name: worktree-switch
description: Use Worktrunk (`wt switch`) safely from Codex when creating, switching, or moving in-progress work into Git worktrees, including uncommitted changes. Trigger when the user asks to use Worktrunk, `wt switch`, create a worktree for an agent task, prepare branch-isolated work, or move current changes into a new worktree.
---

# Worktree Switch

Use `wt switch` with `--no-cd` from Codex. Codex can access the created worktree path normally, but its tool cwd does not automatically move.

## Workflow

1. Confirm `wt` exists with `command -v wt`.
2. Inspect the current worktree with `git status --porcelain --untracked-files=all`.
   Record whether it is dirty; do not modify it yet.
3. Choose the base:
   - If the user explicitly specifies a base, verify it exists and use it.
   - Otherwise, use `--base @` when creating a new branch. `@` means the
     current worktree/branch HEAD; uncommitted changes are handled separately.
   - Do not fetch automatically. If the user explicitly requests a remote or
     latest base, fetch and verify that base first.
4. Leave uncommitted changes in the current worktree by default. Move them only
   if the user explicitly asks to move them to the new worktree.
   - Never discard changes.

   To move changes, run `git stash push -u` before switching, then apply them in
   the new worktree with `git stash apply --index`. Verify success before dropping
   the stash. If application conflicts, keep the stash and report them. If
   switching cannot be completed after stashing, keep the stash and restore it
   to the original worktree before abandoning the operation.
5. Create or switch with:

```sh
wt switch --create <branch> --no-cd --format json [--base <base>]
```

Use `--no-hooks` when hooks would be slow, interactive, or unrelated to the task.
If `--create` fails because the branch exists, retry without `--create`.

## After Switching

- Parse the returned `path` as the worktree root. If stdout has extra human-readable lines, use the JSON object line.
- Run subsequent commands with `workdir` set to that path.
- Edit files under that path directly; it is a normal sibling worktree directory.

For periodic cleanup of completed worktrees, use `$worktree-cleanup`.
