---
name: den-open-nvim
description: Open a specified file in Neovim in a Den Terminal Board, reusing a Board recorded in this conversation for the same target. Use when the user asks to open a file in Den with Nvim.
---

# Den Open Nvim

Open a file in Neovim on a Den Terminal Board.

## Procedure

1. Resolve the path from the user's stated directory or the current workspace. If ambiguous, ask which file they mean. Confirm it exists; do not create it.
2. Check that `den` and `nvim` are available. Run `den health --json`; report any unavailable command or unhealthy status, then stop.
3. Use the file's parent directory as `<directory>`. Set `<command>` to `nvim [+<line>] -- <file>`, including `+<line>` only when requested. Shell-quote paths. Match reuse records by the absolute file path and the requested line number, including whether a line was specified.
4. If this conversation records a Board ID opened by this skill for the same target, run `den board exists --board <id> --json`. Reuse it when `ok: true` and `exists: true`; do not send another launch command. `ok: true` and `exists: false` means create a new Board, even though the exit code is 1. On a command error or `ok: false`, report the error and stop. Do not search other Boards or persist records outside this conversation.
5. If no matching record exists or its Board is absent, create the Board with `den board terminal new <directory> --run <command> --json`. Do not run Nvim after Board creation. Record the target and returned `board_id` in this conversation.
6. Focus only if the user explicitly requests it: add `--focus` when creating, or use `den board focus --board <id> --json` when reusing.
7. Report the Board ID and whether it was created or reused.

If Board creation fails, report the error; do not create another Board automatically.
