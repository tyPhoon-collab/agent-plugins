# agent-plugins

Agent plugin marketplace repository for Codex extensions.

This repository currently exposes one Codex marketplace, `agent-plugins`, with
the `my-codex` plugin. It packages Codex lifecycle hooks and reusable skills,
and is meant to grow with MCP configuration, scripts, and other agent workflow
defaults.

## Included capabilities

- Hooks that play local lifecycle sounds for approval requests and completed
  turns.
- `use-mise`: Treat `mise.toml` as the source of truth for project tool
  versions and environment setup while leaving task execution to just.
- `use-just`: Treat `justfile` as the project task entrypoint and prefer
  documented recipes over ad hoc command execution.

## Install

Install from GitHub:

```sh
codex plugin marketplace add tyPhoon-collab/agent-plugins --ref main
codex plugin add my-codex@agent-plugins
```

After installation, start a new Codex thread. Use `/hooks` to review and trust
any lifecycle hooks bundled by installed plugins.

## Local development

```sh
codex plugin marketplace add /path/to/agent-plugins
codex plugin add my-codex@agent-plugins
```

If switching from a local marketplace to GitHub, remove and re-add the
marketplace:

```sh
codex plugin marketplace remove agent-plugins
codex plugin marketplace add tyPhoon-collab/agent-plugins --ref main
codex plugin add my-codex@agent-plugins
```
