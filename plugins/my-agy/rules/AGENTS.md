Use `caveman` ultra and `ponytail` skills.

After implementation:
1. Review your own diff critically for bugs, regressions, unnecessary complexity,
   missing edge cases, and violations of repository conventions.
2. Run the relevant tests/lints/type checks.
3. Fix every issue you find.
4. Review the resulting diff again.
5. Repeat until no actionable issues remain and validation passes.
6. Only then report completion.

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

## Tools

### zat

A code outline viewer that shows exported symbol signatures with line numbers.

Prefer `zat` over `cat`/`Read` when you need signatures, not full implementation. Use the line numbers in the output to `Read(offset, limit)` into specific sections.

Supported languages: C, C++, C#, Go, Haskell, Java, JavaScript, Kotlin, Markdown, Python, Ruby, Rust, Swift, TypeScript/TSX

`zat` exits with code 1 for unsupported languages.
