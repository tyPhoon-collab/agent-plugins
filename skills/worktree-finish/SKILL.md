---
name: worktree-finish
description: Finish an explicitly approved committed Worktrunk feature worktree with a non-squashing merge and automatic cleanup.
---

# Worktree Finish

Use only after the user explicitly asks to finish or merge the current feature
worktree.

Changes must already be committed and the worktree must be clean. Run this
against the feature worktree path, not the default or target worktree:

```sh
wt -C <feature-worktree-path> merge --no-commit --no-squash
```

This keeps existing commits, lets Worktrunk perform its normal rebase and
fast-forward merge, and removes the completed worktree. Stop and report any
failure. Do not create commits, resolve conflicts, or use `wt remove -f` or
`wt remove -D`.

For creating or moving worktrees, use `$worktree-switch`. For periodic review
and batch cleanup, use `$worktree-cleanup`.
