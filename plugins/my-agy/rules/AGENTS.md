Use `compact` and `ponytail` skills.

Use `ast-grep outline` to inspect source structure and symbols.
Use `ast-grep run` for simple syntax searches and `ast-grep scan` for relational rules.

After implementation, perform at least one self-review and run relevant checks.
If the review or checks reveal a clear issue, fix it and repeat the affected
review or checks. Stop when the latest pass finds no actionable issue and
validation passes. Do not pursue unrelated or speculative improvements.

# RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy for shell commands.

## Rule

Always prefix shell commands with `rtk`.

Examples:

```bash
rtk git status
rtk cargo test
rtk npm run build
rtk pytest -q
```

## Meta Commands

```bash
rtk gain            # Token savings analytics
rtk gain --history  # Recent command savings history
rtk proxy <cmd>     # Run raw command without filtering
```

## Verification

```bash
rtk --version
rtk gain
which rtk
```

