---
name: use-just
description: Use when working in a project with a `justfile`, `Justfile`, or `.justfile`, or when adding, reviewing, or running project tasks. Treat just as the project task runner; inspect `just --list` before calling package-manager or language-specific commands directly.
---

# Use Just

Use just as the project task runner. Let mise manage tool versions and environment setup.

## Project Orientation

1. Look for `justfile`, `Justfile`, or `.justfile`.
2. Run `just --list` to understand available recipes before choosing commands.
3. If modules are present, run `just --list --list-submodules` to include module recipes.
4. Prefer existing recipes for build, test, lint, format, generate, dev, and CI flows.
5. If both just and mise are present, let just answer "which task should run?" and mise answer "which tools and versions?"

## File Layout

- Prefer `justfile` for shared project entrypoints.
- Read existing `Justfile` or `.justfile`, but suggest `justfile` when creating or normalizing shared task files.
- Keep the root `justfile` as the entrypoint.
- When recipes grow, use root-level modules such as `dev.just`, `test.just`, or `ci.just` with `mod dev`, `mod test`, or `mod ci`.

## Adding Recipes

1. Add or reuse a recipe instead of repeating long commands in docs, scripts, or CI.
2. Require doc comments for public recipes and modules so `just --list` stays useful.
3. Group related public recipes with `[group("name")]` to keep `just --list` readable.
4. Use `[confirm]` or `[confirm("message")]` for destructive, deploy, publish, and cleanup recipes.
5. Use `[working-directory("path")]` instead of `cd path && ...` for recipes that run from a subdirectory.
6. Use private `_name` recipes for internal helpers; short private helpers do not need comments.
7. Use recipe dependencies for prerequisite tasks and execution order whenever possible: use `test: build` for prior dependencies, `publish: test && deploy` for subsequent dependencies, and `push target: (build target)` when passing arguments; use recursive `just` calls inside recipe bodies only when dependency syntax cannot express the required ordering.
8. Use module recipe paths for cross-module dependencies, for example `ci: test::unit lint::all`.

## Guardrails

- Do not bypass existing recipes with direct `npm`, `pnpm`, `go`, `cargo`, `flutter`, or similar commands unless the recipe is missing or unsuitable.
- Do not put tool version management in `justfile`; use mise config for that.
- Do not add mise tasks when the project already uses just for task running.
