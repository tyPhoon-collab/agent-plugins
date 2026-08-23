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
3. If the repo has a remote, run `git fetch --prune` first.
4. Choose the base:
   - If the user explicitly specifies a base, use it after verifying it exists.
   - Otherwise select `origin/main` when it exists; otherwise select
     `origin/master` when it exists.
   - When no base was specified, compare a matching local branch with the
     selected remote using `git rev-list --left-right --count <local>...<remote>`.
   - If local is behind or equal, use the remote branch. If local is ahead or
     diverged, mark the base as ambiguous. Do not guess.
   - If no matching local branch exists, use the selected remote branch.
   - If neither remote branch exists, omit `--base` and let Worktrunk use its
     default branch.
5. Before changing files, resolve only ambiguous choices:
   - If the worktree is dirty and the user explicitly asks to move the current
     changes to a new worktree, move them without asking again.
   - If the user explicitly asks to leave the changes in the current worktree,
     do so without asking again.
   - Otherwise, ask whether to leave the changes or move them.
   - If the base is ambiguous, ask whether to use the local or remote branch
     unless the user explicitly specified one.
   - Ask once when both choices need confirmation. Never discard changes.

   To move changes, run `git stash push -u` before switching, then apply them in
   the new worktree with `git stash apply --index`. Verify success before dropping
   the stash. If application conflicts, keep the stash and report them. If
   switching cannot be completed after stashing, keep the stash and restore it
   to the original worktree before abandoning the operation.
6. Create or switch with:

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

For periodic cleanup of completed worktrees, use `$worktree-cleanup`.
