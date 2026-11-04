---
name: rebase
description: "Use when rebasing a Git branch onto another branch or commit, especially when local changes exist."
---

# Rebase

Never create a commit just to make a dirty worktree rebaseable. Use `--autostash` instead.

1. Check the current branch and worktree:

   ```sh
   git status --short --branch
   ```

2. Identify both the branch to rebase and its destination from the request and
   context. If either is unclear, ask the user rather than guessing.

3. If no tracked changes exist, run the normal rebase:

   ```sh
   git rebase <upstream>
   ```

   If tracked changes exist, include `--autostash`:

   ```sh
   git rebase --autostash <upstream>
   ```

   Do not start a rebase with tracked local changes without `--autostash`. `--autostash` does not include untracked files; handle those separately when they matter.

4. If the rebase stops for conflicts, resolve and continue when the intended
   result is clear. If the correct resolution is ambiguous, stop and report
   the conflicted files.

5. Check the final worktree status. If autostash restoration fails, inspect the
   conflicts and stash state; resolve them when the intended result is clear.
   Otherwise, stop and report the situation.
