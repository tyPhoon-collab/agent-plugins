---
name: den-open-yazi
description: Open a directory in Yazi as the initial command of a new Den Terminal Board. Use when the user asks to browse a directory in Den with Yazi.
---

# Den Open Yazi

Open a directory in Yazi on a new Den Terminal Board.

## Procedure

1. Resolve the directory from the user's stated path or the current workspace. If ambiguous, ask which directory they mean. Confirm it exists and is a directory; do not create it.
2. Check that `den` and `yazi` are available. Run `den health --json`; report any unavailable command or unhealthy status, then stop.
3. Use the directory as `<directory>` and set `<command>` to `yazi`. Shell-quote the directory path. Create the Board with `den board terminal new <directory> --run <command> --json`. Do not run Yazi after Board creation.
4. Add `--focus` only if the user explicitly requests it.
5. Report the `board_id` from the JSON response.

If Board creation fails, report the error; do not create another Board automatically.
