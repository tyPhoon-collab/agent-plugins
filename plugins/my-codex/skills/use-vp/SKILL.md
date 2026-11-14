---
name: use-vp
description: Use when managing JavaScript/TypeScript projects, running web tasks, or installing dependencies with Vite+ (vp). Treat vp as the unified toolchain for web development and package management.
---

# Use vp

Use `vp` (Vite+) as the unified toolchain for Web and JavaScript/TypeScript projects.

## Project Lifecycle

- Initialize new projects: `vp create`.
- Migrate existing projects: `vp migrate`.
- Install dependencies: `vp install`.
- Prefer `vp add` and `vp remove` for dependencies; avoid manual edits to `package.json`.
- Add devDependencies: `vp add -D <pkg>`.

## Running & Quality Checks

- Run one-step validation: `vp check` (format, lint, and type check).
- Run core workflows: `vp dev`, `vp build`, `vp test`, `vp lint`, `vp fmt`.
- Run project tasks: `vp run <task>`.
- Execute local binaries: `vp exec <tool>`.

## Guardrails

- In `vp` projects, never use `npm`, `npx`, `yarn`, or `pnpm` for package management or dev workflows; use `vp` exclusively.
