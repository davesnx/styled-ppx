# CSS Parsing Design

This document records the intended architecture for CSS parsing, validation,
code generation, and static extraction in `styled-ppx`.

It consolidates and supersedes the pipeline notes in
`.cursor/rules/cx-pipeline.mdc` and `.cursor/rules/cx2-pipeline.mdc`.

See also:

- `documents/primitives.md` — shared glossary used in this document.
- `documents/css-extraction.md` — wire protocol and aggregator for
  the static-extraction family (`[%css]`, `[%styled.global]`,
  `[%keyframe]`), including cross-module selector resolution
  (sentinel format and aggregator behavior).
- `documents/runtime-lowering-and-interpolation-identity.md` — migration
  design for property-centered runtime lowering and safer static
  interpolation identity.

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

### `[%css]`

`[%css]` shares the same front-end parser path, then diverges into static
extraction:

1. Parse declaration lists with `packages/parser`
2. Type-check declarations against `packages/css-grammar`
3. Atomize declarations in `packages/ppx/src/Css_file.re`
4. Extract interpolation types with `Css_grammar.Parser.get_interpolation_types`
5. Resolve class-name interpolation in selectors against the per-file
   `Local_selector_environment` so `$(name)` is
   replaced with the actual minted class names before the CSS AST is rendered
6. Generate `CSS.make(...)` calls and emit `[@css ...]` attributes

`Local_selector_environment` is populated as each `[%css]` extension expands:
the enclosing `let`-binding name (from `Code_path.enclosing_value`) is mapped to
the list of class names that atomization produced. Later `[%css]` blocks in the
same file resolve `&.$(name)` and similar selector interpolations against that
environment, fanning a multi-declaration source binding into a chained compound
selector (`&.cssA.cssB`). Cross-module and unresolved references raise a clear
PPX error rather than emitting a literal `$(...)` placeholder into the extracted
CSS.

This path still depends on reparsing value strings when interpolation typing or
property validation is needed.

### `[%styled.global]`

Shares the cx2 front-end (parsing + interpolation typing) and reuses
`Css_file.transform_rule` for both value-interpolation and
selector-interpolation walks. Differs from `[%css]` in two ways:

- Registered as a **Module_expr-context** extension (`module Foo =
  [%styled.global ...]`), not Expression. The Expression-context
  registration exists only to fire a migration error for the legacy
  `let () = [%styled.global ...]` shape.
- Splits each interpolated rule into two complementary outputs:
  the static rule with `var(--var-<hash>)` substituted in value
  positions and resolved class chains substituted in selector
  positions (extracted via `Buffer.add_global_rule` like a static
  global) plus a generated module containing
  `to_string`/`to_buffer`/`make` that emit a single
  `:root { --var-<hash>: <value>; ... }` block at runtime to supply
  the values. Selector interpolation has no runtime side; class
  names resolve fully at PPX time (same module) or aggregator time
  (cross-module).

#### What it produces

```reason
let themeColor = CSS.red;

module ThemeStyles = [%styled.global {|
  body {
    color: $(themeColor);
    margin: 0;
  }
|}];
```

Expands to:

```ocaml
[@@@css "body{color:var(--var-nkdt8w);margin:0;}"]
let themeColor = CSS.red
module ThemeStyles = struct
  let to_string () =
    ":root{--var-nkdt8w:" ^ CSS.Types.Color.toString themeColor ^ ";}"
  let to_buffer buf = Buffer.add_string buf (to_string ())
  let make () = CSS.global_style_tag (to_string ())
end
```

The static rule extracts via the existing `[@@@css ...]` channel
(see `css-extraction.md`). The generated `module ThemeStyles` is
the only new artifact.

#### Two halves

| Half    | Shape                                                                                | Where it lives                                                                  |
| ------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| Static  | The user's rule, with `var(--var-<hash>)` in interpolation positions                 | Aggregated `styles.css` via `[@@@css ...]`                                      |
| Dynamic | A single `:root { --var-<hash>: <value>; ... }` block, one declaration per value var | Generated module's `to_string`, mounted via `make` or spliced via `to_buffer`   |

The dynamic side does **not** re-emit the user's selectors or
non-interpolated declarations. Those live in the static stylesheet.
The runtime's only job is to supply values for the custom properties
the static rule references via `var()`.

When `<ThemeStyles />` mounts, the browser sees the static rule loaded
first and the `<style>{:root{...}}</style>` from `make` second. The
cascade resolves the custom properties; multiple mounts update them
and every `var()` reference re-resolves.

For static-only blocks, `to_string` returns `""` and `make` produces
an empty `<style>`. All CSS lives in the static stylesheet.

#### Pipeline

```
module Foo = [%styled.global {| ... |}]
  │
  ▼
Css_file.push_global ~file rule_list:
  for each Style_rule / At_rule:
    transform_rule ($(path) → var(--var-<hash>); collect dynamic_vars)
    render and push to Buffer.add_global_rule
  return dynamic_vars
  │
  ▼
build module structure (in ppx.re):
  to_string  = Css_global_to_string.render_root_block(dynamic_vars)
               (emits ":root{--var-h:<call expr>;...}" or "" if no vars)
  to_buffer  = buf => Buffer.add_string(buf, to_string())
  make       = () => CSS.global_style_tag(to_string())
  │
  ▼
return Pmod_structure([to_string; to_buffer; make])
```

The end-of-CU impl transformer is unchanged; the aggregator gains no
new responsibilities.

#### Generated module

Three items, always in this order:

- **`to_string : unit -> string`** — `""` for static-only blocks; otherwise
  `":root{" ^ "--<var>:" ^ CSS.Types.<Mod>.toString <expr> ^ ";" ^ ... ^ "}"`.
  One `:root` block per call regardless of how many source rules; one
  declaration per `dynamic_vars` entry. Module name from
  `Property_to_types.resolve_module_name`; call from
  `Property_to_types.make_to_string_call`.
- **`to_buffer : Buffer.t -> unit`** — always
  `buf => Buffer.add_string(buf, to_string())`.
- **`make : unit -> React.element`** — always
  `() => CSS.global_style_tag(to_string())`.

All three take `unit` and capture interpolated bindings from the
surrounding lexical scope at call time, exactly like `[%css]`. No
synthesized labeled arguments. **Trade-off:** per-request SSR themes
need a user-defined wrapping function or a switch back to
`[%styled.global]`.

`make` returns a `<style dangerouslySetInnerHTML>` element via
`CSS.global_style_tag : string -> React.element`, provided by both
native (`server-reason-react`) and Melange (`reason-react`) runtimes.
The helper has no side effects and does not touch the runtime
stylesheet. `dangerouslySetInnerHTML` is safe by construction: the
PPX controls the entire CSS string and only typed CSS values from
typed OCaml expressions are interpolated.

#### Hashing

`var-<murmur2(path_str)>`, inherited from `[%css]`. Keyed on the
OCaml expression source. Same expression across blocks shares a var
(harmless: same value either way).

#### Selector interpolation

`[%styled.global]` reuses `Css_transform.transform_rule` from
`[%css]`, so every selector form `[%css]` supports works inside a
global block too:

```reason
let card = [%css "padding: 10px;"];
let active = [%css "border: 1px solid;"];

module Theme = [%styled.global {|
  /* Bare $(name) - resolves to a class type-selector */
  body $(card) { line-height: 1.5; }

  /* .$(name) - class-position; multi-decl bindings fan out into a
     compound chain (.atom1.atom2). */
  .$(card).$(active) { color: white; }

  /* Combinators, pseudo, attribute selectors, comma lists, nesting,
     :not(.$(card)) etc. all work via the recursive walk. */
  body:not(.$(card)) { margin: 0; }

  /* Cross-module $(M.binding) emits a NUL-delimited sentinel that
     the post-build aggregator (styled-ppx.generate) substitutes
     using the index it harvests from M's post-PPX file. */
  body .$(OtherModule.marker) { background: red; }

  /* Selector interp inside @media / @supports works the same way -
     the recursive walk descends into at-rule bodies. */
  @media (max-width: 640px) {
    .$(card) { font-size: 14px; }
  }
|}];
```

Resolution rules (identical to `[%css]`):

- Same-module `$(name)` looks up `Local_selector_environment`. Dotted
  same-file refs such as `$(Css.marker)` search from the current
  submodule scope outward before falling back to cross-module handling.
  Same-file aliases, opens, includes, and earlier string literals are
  resolved by the ordered structure pass. If the binding hasn't been
  seen yet (forward ref) or doesn't exist in a known local selector
  path, the PPX raises a clear diagnostic at the interpolation's source
  location.
- Cross-module `$(M.binding)` is recorded in `Cross_module_refs` and
  embedded as a sentinel string; the aggregator resolves it at link
  time. If `M.binding` isn't a `[%css]` binding the aggregator fails
  with `Unbound module` / `Unbound value` at the original source
  location (via the synthetic `let _ = M.binding` line the PPX emits
  alongside `[@@@css.refs ...]`).
- Bare `$(name)` (no leading dot) in selector position resolves the
  binding and emits a `.classname` type-selector. Multi-class bindings
  are rejected here (use `.$(name)` for the chain instead).

Selector interpolation has no effect on the generated module's
`to_string`: `dynamic_vars` only collects value-position
interpolations. `to_string` is empty when a global block uses only
selector interpolation.

#### Custom-property typing limitation

`Property_to_types.resolve_module_name` falls back to `"Cascading"`
for unknown properties. `--my-prop: $(value)` therefore fails to
type-check because `Cascading.toString` only handles
`inherit`/`initial`/`unset`. **Pre-existing in `[%css]`**, out of scope
here.

Workaround:

```reason
let primaryStr = CSS.Types.Color.toString(CSS.red);
module ThemeStyles = [%styled.global {|
  :root { --primary: $(primaryStr); }
|}];
```

#### Failure modes

| Input                                                                     | Reaction                                                                                                                                  |
| ------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Top-level `Declaration` (e.g. `margin: 0` outside a selector)             | `Pmod_extension` with the universal-selector hint.                                                                                        |
| Parse error from `Driver.parse_declaration_list`                          | `Pmod_extension` carrying the parser's location and message.                                                                              |
| Non-string payload                                                        | `Pmod_extension` pointing at the payload, with the correct-form example.                                                                  |
| Legacy `let () =` shape                                                   | `Error.expr` diagnostic from the Expression-context extension.                                                                            |
| Selector interp `$(name)` references undefined or forward local binding   | `raise_errorf` from `Local_selector_environment.resolve_selector_class_ref` pointing at the interpolation.                                                  |
| Bare `$(name)` (no `.` prefix) resolves to multiple classes               | `raise_errorf` instructing the user to switch to `.$(name)` for chain semantics.                                                          |
| Cross-module `$(M.x)` where `M.x` doesn't exist at link time              | `Unbound module` / `Unbound value` from OCaml typechecker via the synthetic `let _ = M.x`; aggregator also reports a missing-binding error using the location stored in `[@@@css.refs ...]`. |

#### Code map

| File                                            | Role                                                                                                                                                                                                                                |
| ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `packages/ppx/src/ppx.re`                       | Two extensions: Module_expr-context (does the work) and Expression-context (migration error).                                                                                                                                       |
| `packages/ppx/src/Css_file.re`                  | `push_global ~file rule_list` returns the list of `dynamic_vars` collected across all rules; pushes the static rules (with `var(--var-<hash>)` already substituted) into the global buffer.                                         |
| `packages/ppx/src/Local_selector_environment.re` | Per-CU selector environment used by `[%css]` and `[%styled.global]` for same-file selector interpolation, module aliases, opens/includes, and cross-module fallback.                                                               |
| `packages/ppx/src/Css_global_to_string.re`      | `render_root_block ~loc dynamic_vars` builds the `to_string` body: a single `:root { ... }` rule with one declaration per entry, or `""` when `dynamic_vars` is empty.                                                              |
| `packages/runtime/{native,melange}/CSS.ml`      | `CSS.global_style_tag : string -> React.element`.                                                                                                                                                                                   |

#### Intentionally not done

- **No new wire-protocol attribute.** The static side is a finished
  CSS rule already; the aggregator needs nothing else.
- **No target branching in the PPX.** Same module on every target;
  both runtimes provide `CSS.global_style_tag`.
- **No backward-compat for the legacy shape.** Hard error on
  `let () = [%styled.global ...]`.
- **No labeled-arg synthesis on `make`.** In-scope capture matches
  `[%css]`.
- **No `--*` typing fix.** Pre-existing gap, separate change.
- **No `CSS.global` from inside `make`.** That would route through
  the runtime stylesheet, defeating the `*2` family's contract.

### `[%keyframe]`

Shares the cx2 front-end and extracts `@keyframes` blocks named by
content hash. No interpolation support today. Covered briefly in
`documents/css-extraction.md`.

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
