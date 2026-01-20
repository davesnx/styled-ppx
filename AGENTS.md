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
- Consult `testing.mdc` (see workspace testing rules) for the authoritative testing matrix and command catalogue.
- Typical commands (run with the project dune path):
  - Unit/expect tests: `/Users/davesnx/Code/github/davesnx/styled-ppx/_opam/bin/dune test`
  - PPX snapshots: relevant dune aliases exist per package; confirm via `dune --help` or `dune describe`.
- When tests are skipped (time, platform, or request), call out the gap and suggest how the user can validate.
- Record observed failures with enough context (command, exit code, snippet of output) for reproducibility.

## Architecture Orientation
- **Parser & Type Checker** (`packages/parser`, `packages/css-property-parser`): builds the CSS AST, validates properties via generated combinators (`[%value.rec ...]`), and produces rich error messages for invalid CSS.
- **PPX Transformer** (`packages/ppx/src/ppx.re`): exposes interfaces like `[%styled.tag]`, `[%cx]`, `[%css]`, `[%cx2]`, and `[%keyframes]`; orchestrates parsing, validation, and code generation.
- **Property → Runtime Bridge** (`packages/ppx/src/Property_to_runtime.re`): maps validated properties to runtime constructors, preserves interpolations, and decides extraction vs runtime emission.
- **Runtimes** (`packages/runtime/native`, `.../melange`, `.../rescript`): emit CSS for native servers, JS environments, and ReScript compatibility. Shared types live in `packages/runtime/native/shared/Css_types.ml`.
- **Extraction Pipeline**: `[%cx2]` is the only statically extracted path today; it generates CSS assets during compilation for zero runtime overhead.

## Common Tasks & Playbooks
- **Feature work**: locate the relevant package, add parser rules or runtime constructors, extend PPX mapping, and update tests.
- **Bug fixes**: reproduce with minimal repro (fixture or snapshot), craft targeted patches, and add regression coverage.
- **Docs**: keep developer guides (like this file) up to date; cross-link to tooling instructions and testing docs.
- **Reviews**: inspect diffs critically, reason about downstream impact (compile-time + runtime), and recommend follow-up tests when missing.

## Troubleshooting Tips
- Regenerate snapshots via the appropriate dune alias if expect tests fail after legitimate changes.
- If opam tooling appears missing, double-check the `_opam` switch integrity before troubleshooting dune.
- Watch for generated code churn; understand the source generator before editing outputs directly.
- When PPX errors are opaque, reproduce with `dune exec -- <binary>` or `dune build --verbose` to capture the PPX invocation.

## Reference
- Repository root: `/Users/davesnx/Code/github/davesnx/styled-ppx`
- Dune binary: `/Users/davesnx/Code/github/davesnx/styled-ppx/_opam/bin/dune`
- Key docs: `AGENT.md` (this guide), `testing.mdc` (testing policies), `docs/` (additional design notes), `packages/*` (source code).
- Prefer absolute paths in tool calls and explanations so transcripts remain unambiguous.

Stay curious, verify assumptions, and leave the repo healthier than you found it.
