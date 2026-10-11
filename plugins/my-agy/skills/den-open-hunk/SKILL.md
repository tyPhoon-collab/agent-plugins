---
name: den-open-hunk
description: Open git diff in Hunk as the initial command of a new Den Terminal Board. Use when the user asks to review changes or open diff in Den with Hunk.
---

# Den Open Hunk

Open git diff in a new Den Terminal Board, with Hunk as its initial command.

## Procedure

1. Resolve the repository root against the user's stated directory or the current workspace (`git rev-parse --show-toplevel`). If not inside a git repository, report it and stop.
2. Confirm the `den` and `hunk` commands are available. Run `den health --json`; if either command is unavailable or Den is unhealthy, report it and stop.
3. Create one Terminal Board with the repository root as its working directory. Use `den board terminal new <repo_root> --run <command> --json`, where `<command>` starts `hunk diff HEAD` to display all uncommitted changes (both staged and unstaged). If the user explicitly requested a specific target, commit, or path, adjust the command accordingly (e.g. `hunk show HEAD~1`, `hunk diff --staged`, or `hunk diff HEAD -- <path>`). Quote the command defensively for the shell. Do not run Hunk after board creation.
4. Add `--focus` only when the user explicitly asks to focus the new Board.
5. Read `board_id` from the JSON response and report it.

If Board creation fails, report the error without automatically creating another Board.
