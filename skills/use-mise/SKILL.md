---
name: use-mise
description: Use when starting work in a project that may define developer tools with mise, when inspecting or changing mise config, or when adding a project tool. Treat mise as the source of truth for tool versions and environment setup; delegate task running to just when a justfile exists.
---

# Use Mise

Use mise for project tool versions and environment setup. Let just handle project tasks when a justfile exists.

## Project Orientation

1. Look for mise configuration before inferring tools from package files:
   - `mise.toml`
   - `.mise.toml`
   - `mise/config.toml`
   - `.mise/config.toml`
   - `.tool-versions`
2. Prefer `mise.toml` for shared project configuration. Read existing dotfile-style config, but when creating or normalizing project config, use `mise.toml`.
3. Use `[tools]` and `[env]` as the source of truth for available tools and environment variables.

## When No Mise Config Exists

1. Inspect package manifests, lockfiles, task files, and CI workflows to infer likely versioned tools.
2. Propose `mise.toml` only when there are concrete tools to pin.
3. Keep initial `mise.toml` focused on `[tools]` and necessary `[env]`.

## Adding Tools

1. Add new project tools to `mise.toml` unless the user explicitly asks for local-only config.
2. Avoid `latest` and other floating versions for shared project tools.
3. Check versions with `mise ls-remote <tool>`, choose a concrete stable version, then prefer `mise use --pin <tool>@<version>`.
4. Directly edit `mise.toml` when preserving comments, ordering, or grouped TOML style matters.

## Installing Tools

- Do not run `mise install` just because config exists.
- Run `mise install` when the user asks for setup, a required tool is missing, or a command fails because the configured tool is unavailable.
- If install requires network access or changes the local toolchain, use the normal approval flow.

## Guardrails

- Use `[env]` for shared non-secret defaults and required declarations; keep secrets and personal overrides in `mise.local.toml`, external env, or gitignored dotenv files loaded with `env._.file`.
- Do not assume globally installed versions are correct when mise config pins a version.
- Treat `mise.local.toml` as local-only config; do not commit it or move shared requirements there.
