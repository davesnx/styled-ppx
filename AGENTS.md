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

## Cursor Cloud specific instructions

### Environment prerequisites

The Cloud VM update script handles: opam dependency installation (with `--assume-depexts` since npm is provided via nvm, not apt) and `npm install`. The opam local switch at `./_opam` with OCaml 5.4.0 must already exist.

### Key commands

All commands are documented in the `Makefile`; run `make help` for the full list. The critical ones:

- **Build**: `eval $(opam env --switch=. --set-switch) && make build`
- **Test all**: `eval $(opam env --switch=. --set-switch) && make test`
- **Lint/format check**: `eval $(opam env --switch=. --set-switch) && make format-check`
- **Auto-format**: `eval $(opam env --switch=. --set-switch) && make fmt`
- **Dev watch mode**: `eval $(opam env --switch=. --set-switch) && make dev`
- **Individual test suites**: `make test-parser`, `make test-ppx-native`, etc. (see `testing.mdc` workspace rule)

### Gotchas

- **Always activate the opam switch first**: Run `eval $(opam env --switch=. --set-switch)` before any `make` or `dune` command. The `Makefile` uses `opam exec --` internally, but many shell invocations still need the environment set.
- **Reason pin**: The `Makefile` pins `reason.3.17.3` from a GitHub branch (`fix-stackoverflow-on-Pconstraint-414`) that no longer exists. Reason 3.17.3 is now available directly on opam, so the pin step can be skipped. If the pin fails, install deps directly with `opam install . --deps-only --with-test --assume-depexts --working-dir . -y`.
- **opam 2.1 vs 2.2+**: The `--with-dev-setup` flag in `make install` requires opam >= 2.2. On opam 2.1.x (Ubuntu 24.04 default), install dev deps manually: `opam install ocamlformat.0.28.1 ocaml-lsp-server -y`.
- **Menhir warnings**: `Warning: 6 states have shift/reduce conflicts` during build is expected and benign.
- **Demo executables**: `dune exec ast-renderer "<css>"` and `dune exec lexer-renderer "<css>"` are useful for quick CSS parsing checks. `dune exec demo-melange-server` runs an SSR demo rendering styled React components.
