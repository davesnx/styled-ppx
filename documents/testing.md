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
| `make test-runtime` | Runtime hash/styles unit tests | `packages/runtime/test` |
| `make test-murmur2` | Murmur2 hash parity with emotion (cram + scripts) | `packages/murmur2/test` |
| `make test-css-spec-parser` | CSS value-definition spec parser | `packages/css-spec-parser/test` |
| `make test-generate` | CSS extraction aggregator (cram) | `packages/generate/test` |

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
