# CSS Parsing Design

This document records the intended architecture for CSS parsing, validation,
code generation, and static extraction in `styled-ppx`.

It consolidates and supersedes the pipeline notes in
`.cursor/rules/cx-pipeline.mdc` and `.cursor/rules/cx2-pipeline.mdc`.

See also `documents/primitives.md` for the shared glossary used in this
document.

## Status

- Draft
- Intended as the working design for the parser/css-grammar integration cleanup

## Current Pipeline

### `[%cx]`

1. The PPX parses CSS through `Styled_ppx_css_parser.Driver.parse_declaration_list`.
2. `packages/parser` builds a stylesheet AST in `packages/parser/lib/Ast.re`.
   Declaration values and at-rule preludes are currently represented as generic
   `component_value_list` values.
3. The PPX type-checks declarations in `packages/ppx/src/ppx.re` by rendering a
   declaration value back into a string with
   `Styled_ppx_css_parser.Render.component_value_list`.
4. `packages/css-grammar` lexes and parses that string again in
   `packages/css-grammar/lib/Rule.re` and `packages/css-grammar/lib/Parser.ml`.
5. Runtime generation later slices the original source again with
   `source_code_of_loc` in `packages/ppx/src/Css_to_runtime.re` and passes a
   string into `packages/ppx/src/Property_to_runtime.re`.
6. `Property_to_runtime` then parses the value again through generated property
   parsers before producing `CSS.*` runtime expressions.

The same declaration value can therefore be:

- tokenized by the stylesheet lexer
- rendered back into a string
- lexed again by `css-grammar`
- parsed again for runtime generation

### `[%cx2]`

`[%cx2]` shares the same front-end parser path, then diverges into static
extraction:

1. Parse declaration lists with `packages/parser`
2. Type-check declarations against `packages/css-grammar`
3. Atomize declarations in `packages/ppx/src/Css_file.re`
4. Extract interpolation types with `Css_grammar.Parser.get_interpolation_types`
5. Generate `CSS.make(...)` calls and emit `[@css ...]` attributes

This path still depends on reparsing value strings when interpolation typing or
property validation is needed.

## Direction

The redesign should move the pipeline toward three explicit goals:

1. Keep the lexer small and move syntax meaning into a handwritten parser.
2. Make `component_value_list` the real parser/css-grammar boundary.
3. Co-locate property grammar, typed AST, and printing so parse/print share one
   source of truth.

`documents/current-design.md` remains the descriptive snapshot of the current
pipeline. This document describes the intended direction from that baseline.

## Three-Step Migration Plan

### Step 1 - Replace the parser front-end (Done)

Replace Menhir with a handwritten parser built around a small token stream,
similar in spirit to `query-json`.

- Keep `packages/parser/lib/Lexer.re` as a thin sedlex tokenizer responsible for
  raw tokenization, interpolation scanning, and locations.
- Remove parser meaning from `packages/parser/lib/Lexer.re` and
  `packages/parser/lib/Lexer_context.re`; whitespace handling, selector versus
  declaration disambiguation, and nesting decisions should live in parser code.
- Replace `packages/parser/lib/Parser.mly` and the Menhir-specific parts of
  `packages/parser/lib/driver.re` with handwritten parser entrypoints.
- Preserve the public parser entrypoints and keep `packages/parser/lib/Ast.re`
  mostly stable during this step so the rest of the pipeline can keep working.

The preferred parser model here is a hybrid recursive-descent design: explicit
cursor/lookahead helpers for the general flow, plus specialized helpers for the
few CSS corners that need tighter control.

Completed in the current branch with these concrete outcomes:

- `packages/parser/lib/Parser.mly` has been replaced by a handwritten
  `packages/parser/lib/Parser.ml`.
- `packages/parser/lib/driver.re` no longer depends on Menhir.
- `packages/parser/lib/Lexer_context.re` and the old lexer-state-driven
  classification path have been removed.
- The parser now consumes a raw lexer stream from `packages/parser/lib/Lexer.re`
  and owns selector/declaration disambiguation, descendant whitespace,
  keyframes, at-rules, and implicit nested-block boundaries.
- `Lexer.from_string` now exposes raw lexer output directly; semantic
  classification happens in parser code rather than the lexer layer.

Compatibility note:

- No lexer-context compatibility layer remains in the active parser front-end.

### Step 2 - Make parser AST values the canonical css-grammar input (Done)

Remove the string handoff between `packages/parser` and `packages/css-grammar`.

- Change `packages/css-grammar` rules to consume
  `Styled_ppx_css_parser.Ast.component_value_list` directly.
- Stop rendering declaration values back through
  `Styled_ppx_css_parser.Render.component_value_list` for validation and
  interpolation typing.
- Stop reparsing at-rule preludes from source text when the required structure is
  already available in parser AST form.
- Allow `packages/parser/lib/Ast.re` to evolve where needed, but keep it close to
  CSS Syntax component values and other spec-shaped structures.

By the end of this step, the pipeline should parse once into canonical AST and
then interpret that AST semantically, instead of moving back and forth through
strings.

Completed in the current branch with these concrete outcomes:

- `packages/css-grammar/lib/Rule.re` now consumes parser AST component values
  directly; the token-list parsing substrate and AST-to-token bridge are gone.
- `packages/css-grammar/lib/Css_value_types.re`, `Modifier.re`, and
  `Combinators.re` now run on the AST-native rule substrate.
- `packages/css-grammar/ppx/Generate.re` and generated `[%spec_module]` modules
  now emit AST-native rules and `parse_component_values` entrypoints, while
  keeping `parse` as a compatibility wrapper outside `Rule.re`.
- `packages/css-grammar/lib/Parser.ml` now exposes AST-based entrypoints for
  property validation, interpolation extraction, generic parsing, and at-rule
  prelude parsing.
- PPX type checking in `packages/ppx/src/ppx.re` now validates declarations
  directly from parser AST values.
- cx2 interpolation extraction in `packages/ppx/src/Css_file.re` now reads
  interpolation types directly from `component_value_list`.
- Runtime lowering in `packages/ppx/src/Property_to_runtime.re` now parses typed
  property values from `component_value_list` instead of reparsing declaration
  value strings.
- `@media` and `@container` validation in `packages/ppx/src/Css_to_runtime.re`
  now parses preludes from parser AST values rather than reparsing source text.

Compatibility note:

- String-based css-grammar entrypoints still exist as compatibility wrappers for
  tests and older callers, but they parse to parser AST outside `Rule.re` before
  invoking the grammar.
- Raw source slicing is still used in `Css_to_runtime` when emitting unsafe
  fallback strings and preserving user-authored formatting, but that source is
  now passed explicitly through PPX/runtime call sites rather than coming from a
  global parser buffer. It is no longer the semantic input to css-grammar
  validation or typed runtime lowering.

### Step 3 - Split css-grammar and runtime by property modules

Replace the giant central `packages/css-grammar/lib/Parser.ml` file with a
property-centered module layout.

- Introduce a folder structure where each property or shared value family owns
  its `[%spec_module]`, typed value definition, interpolation extraction, and
  printing logic.
- Keep parsing on native where necessary with `[@platform native]`, while
  allowing printing and shared types to remain available to Melange.
- Reduce `packages/runtime/native/shared/Css_types.ml` from a second giant source
  of truth into a facade, generated layer, or thin public re-export over the new
  property modules.
- Make parse and print operate over the same canonical typed representations.

The end state should be that changing one property mostly touches one local
module, not a giant registry file plus a separate runtime types file.

## Testing And Compatibility Requirements

Testing is a hard requirement for this redesign. The migration is not complete
if it regresses existing behavior.

- `packages/ppx/test/css-support` is a primary compatibility gate and must keep
  passing throughout the migration.
- Parser-facing changes must keep `packages/parser/test` green.
- css-grammar boundary changes must keep `packages/css-grammar/test` green.
- Runtime-facing changes must keep `packages/runtime/test` and relevant PPX
  suites green.
- Snapshot and native PPX coverage should continue to validate generated output,
  not just internal parser behavior.

At minimum, the redesign should preserve the current external behavior covered by
these suites:

- `make test-parser`
- `make test-css-grammar`
- `make test-css-support`
- `make test-ppx-native`
- `make test-ppx-snapshot-reason`
- `make test-runtime`
- `make test-string-interpolation`

When a step changes only one layer, targeted suites are acceptable during local
iteration, but every milestone should re-run the broader pipeline-facing suites.
In particular, `css-support` should be treated as a non-negotiable regression
signal because it exercises the user-visible PPX contract.

Each migration step should therefore include:

1. New regression tests for the behavior being moved.
2. Targeted suite execution for the package being changed.
3. Cross-package verification that parser, css-grammar, PPX, and runtime still
   agree on the same behavior.
