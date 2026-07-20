# styled-ppx Agent Handbook

## Mission
- Deliver maintainer-grade support for `styled-ppx` while respecting user intent, repository conventions, and safety rules.
- Keep the codebase healthy: clarify requests, surface risks early, and document important decisions.
- Act as a multiplier for the team—favour clear communication, reproducible steps, and actionable suggestions.
- Balance velocity with correctness; when unsure, ask instead of guessing.

## Overview

styled-ppx is a CSS-in-Reason/OCaml ppx (preprocessor extension) and a library that provides type-safe, compile-time verified CSS with minimal runtime overhead.

## Architecture

The project consists of three main components:

## Working Agreements
- Never revert user-authored changes unless explicitly requested; coordinate if unexpected diffs appear.
- Avoid commits unless the user asks; stage or push only after explicit approval.
- Keep responses concise yet complete. Use Markdown, short headers when they aid scanning, and bulleted lists with consistent phrasing.
- Use the todo list tool for multi-step tasks; update statuses as you progress.
- If the user requests a “review”, switch to code-review tone: findings first, severity ordered, cite files/lines, then residual risks.

## Testing & Quality Assurance
- Consult `documents/testing.md` for the authoritative testing matrix and command catalogue.
- Typical commands (use the local switch, `_opam/bin/dune`):
  - Everything: `make test` (or `_opam/bin/dune test`).
  - Per package: `make test-<package>` targets with `-watch`/`-promote` variants; see `documents/testing.md`.
- When tests are skipped (time, platform, or request), call out the gap and suggest how the user can validate.
- Record observed failures with enough context (command, exit code, snippet of output) for reproducibility.

## Architecture Orientation
- **Parser & Type Checker** (`packages/parser`, `packages/css-grammar`): builds the CSS AST, validates properties via generated combinators (`[%spec ...]`), and produces rich error messages for invalid CSS.
- **PPX Transformer** (`packages/ppx/src/ppx.re`): exposes `[%css]`, `[%styled.<tag>]`, `[%styled.global]`, and `[%keyframe]`; orchestrates parsing, validation, and code generation.
- **Runtime Emission** (`packages/ppx/src/Css_to_runtime.re`): turns validated declarations into runtime calls, preserves interpolations, and decides extraction vs runtime emission.
- **Runtimes** (`packages/runtime/native`, `.../melange`, `.../rescript`): emit CSS for native servers, JS environments, and ReScript compatibility. Shared types live in `packages/runtime/native/shared/Css_types.ml`.
- **Extraction Pipeline**: all live extensions (`[%css]`, `[%styled.<tag>]`, `[%styled.global]`, `[%keyframe]`) are statically extracted; the PPX emits `[@@@css ...]` attributes that the `styled-ppx.generate` aggregator collects into CSS assets during compilation for zero runtime overhead.

## Reference Documents
- Consult `documents/design.md` before making structural changes across `packages/parser`, `packages/css-grammar`, `packages/ppx`, or the runtime pipeline.
- Consult `documents/css-extraction.md` for the extraction wire protocol (`[@@@css ...]`, `[@@@css.bindings ...]`, `[@@@css.refs ...]`) and the aggregator.

## Troubleshooting Tips
- Regenerate snapshots via the appropriate dune alias if expect tests fail after legitimate changes.
- If opam tooling appears missing, double-check the `_opam` switch integrity before troubleshooting dune.
- Watch for generated code churn; understand the source generator before editing outputs directly.
- When PPX errors are opaque, reproduce with `dune exec -- <binary>` or `dune build --verbose` to capture the PPX invocation.
