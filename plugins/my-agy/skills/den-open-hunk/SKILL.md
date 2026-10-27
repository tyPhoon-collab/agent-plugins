---
name: den-open-hunk
description: Open git diff in Hunk in a Den Terminal Board, reusing a Board recorded in this conversation for the same target. Use when the user asks to review changes or open diff in Den with Hunk.
---

# Den Open Hunk

Open a Git diff in Hunk on a Den Terminal Board.

Hunk automatically refreshes working-tree changes. Avoid inspecting the screen, manually reloading, or relaunching Hunk merely to confirm that file edits are reflected. This does not change the target-matching rules below.

## Procedure

1. Resolve the repository root from the user's stated directory or the current workspace using `git rev-parse --show-toplevel`. If it is not a Git repository, report that and stop.
2. Check that `den` and `hunk` are available. Run `den health --json`; report any unavailable command or unhealthy status, then stop.
3. Use the repository root as `<repo_root>`. Set `<command>` to `hunk diff HEAD` to show staged and unstaged changes. Adjust it only if the user requests a specific target, commit, or path (for example, `hunk show HEAD~1`, `hunk diff --staged`, or `hunk diff HEAD -- <path>`). Shell-quote the command and any paths. Match reuse records by the absolute repository path and the Hunk command, including comparison and path arguments.
4. If this conversation records a Board ID opened by this skill for the same target, run `den board exists --board <id> --json`. Reuse it when `ok: true` and `exists: true`; do not send another launch command. `ok: true` and `exists: false` means create a new Board, even though the exit code is 1. On a command error or `ok: false`, report the error and stop. Do not search other Boards or persist records outside this conversation.
5. If no matching record exists or its Board is absent, create the Board with `den board terminal new <repo_root> --run <command> --json`. Do not run Hunk after Board creation. Record the target and returned `board_id` in this conversation.
6. Focus only if the user explicitly requests it: add `--focus` when creating, or use `den board focus --board <id> --json` when reusing.
7. Report the Board ID and whether it was created or reused.

If Board creation fails, report the error; do not create another Board automatically.
