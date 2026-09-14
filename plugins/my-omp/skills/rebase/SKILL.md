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

2. If no tracked changes exist, run the normal rebase:

   ```sh
   git rebase <upstream>
   ```

   If tracked changes exist, include `--autostash`:

   ```sh
   git rebase --autostash <upstream>
   ```

   Do not start a rebase with tracked local changes without `--autostash`. `--autostash` does not include untracked files; handle those separately when they matter.

3. If the rebase stops for conflicts, stop and report the conflicted files. Do not resolve or continue unless the user asks.
