---
name: den-open-nvim
description: Open a specified file in Neovim as the initial command of a new Den Terminal Board. Use when the user asks to open a file in Den with Nvim.
---

# Den Open Nvim

Open a file in Neovim on a new Den Terminal Board.

## Procedure

1. Resolve the path from the user's stated directory or the current workspace. If ambiguous, ask which file they mean. Confirm it exists; do not create it.
2. Check that `den` and `nvim` are available. Run `den health --json`; report any unavailable command or unhealthy status, then stop.
3. Use the file's parent directory as `<directory>`. Set `<command>` to `nvim [+<line>] -- <file>`, including `+<line>` only when requested. Shell-quote paths. Create the Board with `den board terminal new <directory> --run <command> --json`. Do not run Nvim after Board creation.
4. Add `--focus` only if the user explicitly requests it.
5. Report the `board_id` from the JSON response.

If Board creation fails, report the error; do not create another Board automatically.
