# Memories

## Environment
- Never run background-process / fifo / kill-based smoke tests here: one such test reportedly core-dumped the machine (2026-08-27). Keep verification to builds and read-only checks.

## Project: nimlsp
- Build with `nimble build` (Nim 2.2.10); produces `nimlsp` and `nimlsp_debug` (both gitignored).
- Repo is jj-colocated with git; use jj commands for commits.
- Integrated PMunch/nimlsp#192 (dieWithParent, fixes #180) as commit zknlmtyq (01e25275), simplified vs upstream: fixed-arity prctl decl, `const prSetPdeathsig = 1.cint` instead of `{.importc}` (header defines PR_SET_PDEATHSIG as a macro, no C symbol), no empty `else:` branch.
- Left uncommitted in @ (as of last session): .gitignore edit adding `nimlsp_debug`.
