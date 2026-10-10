---
name: den-open-nvim
description: Open a specified file in Neovim as the initial command of a new Den Terminal Board. Use when the user asks to open a file in Den with Nvim.
---

# Den Open Nvim

Open the requested file in a new Den Terminal Board, with Neovim as its initial command.

## Procedure

1. Resolve the requested path against the user's stated directory or the current workspace. If the path is ambiguous, ask which file they mean. Confirm it exists and is a file; do not create a missing file.
2. Confirm the `den` and `nvim` commands are available. Run `den health --json`; if either command is unavailable or Den is unhealthy, report it and stop.
3. Create one Terminal Board with the file's parent directory as its working directory. Use `den board terminal new <directory> --run <command> --json`, where `<command>` starts `nvim --` with the requested file path. Quote the path for the command's shell so spaces and shell metacharacters remain part of the filename. Do not pass an unquoted path or run Nvim after board creation.
4. Add `--focus` only when the user explicitly asks to focus the new Board.
5. Read `board_id` from the JSON response and report it.

If Board creation fails, report the error without automatically creating another Board.
