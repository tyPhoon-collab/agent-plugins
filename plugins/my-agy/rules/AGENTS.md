Use `compact`

When you develop something, Use `ponytail` and `ast-grep`

Do not fix unless the clear cause is identified.

After implementation, perform at least one self-review and run relevant checks.
If the review or checks reveal a clear issue, fix it and repeat the affected
review or checks. Stop when the latest pass finds no actionable issue and
validation passes. Do not pursue unrelated or speculative improvements.

Commit history should be clean and only reviewed and organized commits should be made.

## Test

Prefer the smallest test that protects a meaningful behavioral contract.
Do not preserve incidental implementation details or one-off reproduction values unless they are themselves part of the contract.
Before adding a regression test, generalize the bug into the invariant that was violated.

## Tools

### RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy for shell commands.

#### Rule

Always prefix shell commands with `rtk`.

Examples:

```bash
rtk git status
rtk cargo test
rtk npm run build
rtk pytest -q
```

#### Meta Commands

```bash
rtk gain            # Token savings analytics
rtk gain --history  # Recent command savings history
rtk proxy <cmd>     # Run raw command without filtering
```

#### Verification

```bash
rtk --version
rtk gain
which rtk
```

