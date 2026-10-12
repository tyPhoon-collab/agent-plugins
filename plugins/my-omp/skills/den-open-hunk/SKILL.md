---
name: den-open-hunk
description: Open git diff in Hunk as the initial command of a new Den Terminal Board. Use when the user asks to review changes or open diff in Den with Hunk.
---

# Den Open Hunk

Open a Git diff in Hunk on a new Den Terminal Board.

## Procedure

1. Resolve the repository root from the user's stated directory or the current workspace using `git rev-parse --show-toplevel`. If it is not a Git repository, report that and stop.
2. Check that `den` and `hunk` are available. Run `den health --json`; report any unavailable command or unhealthy status, then stop.
3. Use the repository root as `<repo_root>`. Set `<command>` to `hunk diff HEAD` to show staged and unstaged changes. Adjust it only if the user requests a specific target, commit, or path (for example, `hunk show HEAD~1`, `hunk diff --staged`, or `hunk diff HEAD -- <path>`). Shell-quote the command and any paths. Create the Board with `den board terminal new <repo_root> --run <command> --json`. Do not run Hunk after Board creation.
4. Add `--focus` only if the user explicitly requests it.
5. Report the `board_id` from the JSON response.

If Board creation fails, report the error; do not create another Board automatically.
