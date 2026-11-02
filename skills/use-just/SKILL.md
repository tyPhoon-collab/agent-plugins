---
name: use-just
description: Use when selecting, adding, or running a project task in a project with a `justfile`. Treat just as the project task runner; inspect `just --list` when the available recipes are unknown.
---

# Use Just

Use `just` as the project task runner and entrypoint for reusable commands.

## Orientation & Running

1. Look for a root `justfile`. Run `just --list` (or `just --list --list-submodules` if submodules exist) when available recipes are unknown.
2. Prefer existing recipes over direct shell commands for build, test, lint, format, dev, and CI workflows.

## Adding Recipes

1. Keep shared entrypoints in the root `justfile`. Use `mod <name>` to split large justfiles into namespaced submodules when it improves maintenance.
2. Require doc comments for public recipes so `just --list` stays useful. Point users to `just --list` rather than duplicating the full recipe list in documentation.
3. Use recipe dependency syntax for prerequisites and execution order (e.g. `test: build`, `publish: test && deploy`, `push target: (build target)`). Avoid recursive `just` calls inside recipe bodies unless dependency syntax cannot express the order.
4. Use submodule paths for cross-module dependencies (e.g. `ci: test::unit lint::all`).
5. Use private `_name` recipes for internal helpers.
6. Use attributes instead of ad-hoc shell logic:
   - `[working-directory("path")]` instead of `cd path && ...`
   - `[confirm]` for destructive recipes where interactive confirmation is appropriate
7. Use `[script]` for long or stateful recipes with variables, loops, conditionals, or multi-line logic. Note that `set shell` does not apply to script recipes; use `[script(COMMAND)]` or `set script-interpreter` to specify the interpreter.

