# Testing

Ground rules:

- Don't add test files to the repository root or a tmp folder. Only add files where the suite expects them.
- Always use the right test suite for each test.
- Never stop if `make test` reports an `[ERROR]`. Check the entire output of the command.

## Commands

`make test` builds and runs every target in `TEST_TARGETS` (see `Makefile`). Each
target also has `-watch` and `-promote` variants (e.g. `make test-parser-watch`,
`make test-ppx-snapshot-reason-promote`). Targets map 1:1 to dune aliases, so
`_opam/bin/dune build @<target>` works too.

| Command | Suite | Location |
| --- | --- | --- |
| `make test-parser` | CSS lexer/parser/render unit tests | `packages/parser/test` |
| `make test-css-grammar` | Grammar combinators, modifiers, rules, interpolation extraction | `packages/css-grammar/test` |
| `make test-ppx-native` | PPX native unit tests | `packages/ppx/test/native` |
| `make test-ppx-snapshot-reason` | PPX output snapshots (cram) | `packages/ppx/test/snapshot/reason` |
| `make test-css-support` | CSS property support (cram) | `packages/ppx/test/css-support` |
| `make test-runtime` | Runtime hash/styles unit tests + witness conformance check | `packages/runtime/test` |
| `make test-murmur2` | Murmur2 hash parity with emotion (cram + scripts) and hash unit tests | `packages/ppx/murmur2/test` |
| `make test-css-spec-parser` | CSS value-definition spec parser | `packages/css-spec-parser/test` |
| `make test-generate` | CSS extraction aggregator (cram) | `packages/generate/test` |

## Runtime witness conformance check

Every property in the css-grammar registry can declare a runtime witness
(`[%spec_module "...", (module Css_types.X)]` in
`packages/css-grammar/lib/Properties/*.ml`). The witness survives only as a
string (`runtime_module_path`), which the PPX bakes into user code as
`CSS.Types.<Module>.toString(value)` for interpolated values (see
`packages/ppx/src/Property_to_types.re`), so nothing ties it to the runtime
at compile time.

`packages/runtime/test/witness` closes that gap: `gen_css_types_witnesses.exe`
walks the registry, collects every property-level `runtime_module_path`, and
generates `css_types_witnesses.ml` (sorted, deterministic), which dune
compiles against `styled-ppx.native` under `@runtest`, `@test-runtime`, and
`@check`. A witness path that doesn't exist in
`packages/runtime/native/shared/Css_types.ml`, or whose `toString` isn't the
unary printer the PPX calls, is a compile error. There is nothing to edit by
hand: when adding a property, declare the witness in the `[%spec_module]` and
make sure the module exists in `Css_types.ml` with a `toString : t -> string`.
Witnesses that intentionally lack a unary `toString` (the `Css_types.Border`
shorthand family) are listed in `gen_css_types_witnesses.ml` and checked for
existence only.

## Cram tests

Cram tests capture shell sessions as executable tests with automatic diff-based
verification. They are used in `test-ppx-snapshot-reason`, `test-css-support`,
and `test-generate` to ensure generated code and extracted CSS are correct.
When asked to "add a test" in the context of cram tests, add one to one of
those folders.

Test types:

- **File tests**: `name.t` — single self-contained file.
- **Directory tests**: `name.t/run.t` — allows separate fixture files.

Regenerate expected output after legitimate changes with the `-promote` variant
(or `dune build @<alias> --auto-promote`).
