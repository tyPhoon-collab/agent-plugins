---
name: worktree-cleanup
description: Review and remove completed Worktrunk (`wt`) worktrees in batches. Use when the user asks to clean up, prune, or remove stale or completed Git worktrees, especially at the end of a work session. Do not use for creating or switching worktrees.
---

# Worktree Cleanup

Clean up completed Worktrunk worktrees periodically, not after every task.
Review candidates first, then remove only the branches the user approved.

## Workflow

1. Confirm `wt` exists with `command -v wt`.
2. Work from a stable worktree, usually the default-branch worktree. Do not
   use a target worktree as Codex's `workdir` while removing it.
3. List worktrees:

```sh
wt list
```

4. Identify completed candidates. Check status and branch state when the list
   is not sufficient. Keep the current worktree, active work, and branches
   with uncommitted changes out of the removal set by default.
5. Show the exact branches to remove and get confirmation before deletion.
6. Remove approved branches in the foreground so completion can be verified:

```sh
wt remove --foreground --format json <branch>...
```

7. Run `wt list` again and report any candidates left unresolved.

## Safety

- Never use `--force` (`-f`) unless the user explicitly confirms discarding
  staged, modified, or untracked files.
- Never use `--force-delete` (`-D`) unless the user explicitly confirms
  deleting an unmerged branch.
- Use `--no-delete-branch` when removing the worktree but keeping its branch.
- Do not remove the current worktree. Codex's `workdir` does not automatically
  move after `wt remove`, and later commands may target a deleted path.
- Do not treat age alone as evidence that a worktree is safe to remove.

For creating or switching worktrees, use `$worktree-switch`.
