# CSS Parsing Design

This document records the intended architecture for CSS parsing, validation,
code generation, and static extraction in `styled-ppx`.

See also:

- `documents/css-extraction.md` — wire protocol and aggregator for
  the static-extraction family (`[%css]`, `[%styled.<tag>]`,
  `[%styled.global]`, `[%keyframe]`), including cross-module selector
  resolution (sentinel format and aggregator behavior).
- `documents/keyframe-static-extraction.md` — `[%keyframe]` extraction
  in depth.
- `documents/runtime-lowering-and-interpolation-identity.md` — migration
  design for property-centered runtime lowering and safer static
  interpolation identity.

## Status

- Working design for the parser/css-grammar integration cleanup
- Migration steps 1 and 2 are complete; step 3 is partially complete
  (see "Three-Step Migration Plan" below)

## Current Pipeline

### Extension surface

The PPX exposes four live extension points, all statically extracting:

| Extension           | Context      | Expansion entrypoint (`packages/ppx/src/ppx.re`) |
| ------------------- | ------------ | ------------------------------------------------ |
| `[%css]`            | expression   | `expand_css_expression`                          |
| `[%keyframe]`       | expression   | `expand_keyframe_expression`                     |
| `[%styled.<tag>]`   | module expr  | `expand_styled_module`                           |
| `[%styled.global]`  | module expr  | `expand_global_module`                           |

There is no `[%cx]` and no separate runtime-only family. Apart from an
error-only `[%styled]` stub registered through ppxlib's rule system,
expansion is driven by the whole-structure `~impl` transformer
(`map_ordered_structure`), which walks the CU in source order so that
`Local_selector_environment` and `Css_bindings` observe bindings in
lexical order.

### Shared front end

Every extension shares one parse-once front end:

1. `Styled_ppx_css_parser.Driver.parse_declaration_list` builds a
   stylesheet AST (`packages/parser/lib/Ast.re`). Declaration values and
   at-rule preludes are represented as `component_value_list` values.
2. `packages/ppx/src/Css_validation.re` type-checks declarations by
   passing the AST value directly to `Css_grammar.validate_property`
   (`packages/css-grammar/lib/Registry.ml`). No string round-trip:
   `Render.component_value_list` is used only to build error messages.
3. Interpolation types are read directly from the AST with
   `Css_grammar.infer_interpolation_types`.
4. Raw source slicing (`source_code_of_loc` in
   `packages/ppx/src/Css_to_runtime.re`) survives only for error
   messages and `unsafe` fallback strings; it is never the semantic
   input to validation or lowering.

### `[%css]`

`[%css]` runs the shared front end, then diverges into static
extraction:

1. Parse declaration lists with `packages/parser`
2. Type-check declarations against `packages/css-grammar`
3. Atomize declarations in `packages/ppx/src/Css_file.re` (`Css_file.push`)
4. Lower value interpolation `$(expr)` to CSS custom properties,
   collecting `dynamic_vars`
5. Resolve class-name interpolation in selectors against the per-file
   `Local_selector_environment` so `$(name)` is
   replaced with the actual minted class names before the CSS AST is rendered
6. Generate `CSS.make(...)` calls (carrying the class names and the
   dynamic vars) and record the extracted rules for the end-of-CU
   `[@@@css ...]` attributes

`Local_selector_environment` is populated as each `[%css]` extension expands:
the enclosing `let`-binding name (recovered by the ordered structure pass in
`ppx.re`, which walks bindings in source order) is mapped to the list of class
names that atomization produced. Later `[%css]` blocks in the same file resolve
`&.$(name)` and similar selector interpolations against that environment,
fanning a multi-declaration source binding into a chained compound selector
(`&.cssA.cssB`). Unresolved local references (undefined or forward) raise a
clear PPX error; cross-module references are recorded in `Cross_module_refs`
and resolved by the aggregator (see `documents/css-extraction.md`).

### `[%styled.<tag>]`

`module Button = [%styled.button "..."]` runs the same extraction path as
`[%css]` (`Css_file.push`, same atomization and interpolation lowering) and
wraps the resulting `CSS.make` call in a generated React component for the
given HTML tag (`Generate.staticComponent`). Function payloads
(`[%styled.div (~color) => "color: $(color)"]`) also extract: the CSS string
body is pushed through `Css_file.push` and the labeled arguments become
component props feeding the dynamic vars
(`Generate.dynamicExtractedComponent`). Non-string function bodies are
rejected with a PPX error.

### `[%styled.global]`

Shares the same front end (parsing + interpolation typing) and reuses
`Css_file.Css_transform.transform_rule` for both value-interpolation and
selector-interpolation walks. Differs from `[%css]` in two ways:

- Expanded in **module-expr position only** (`module Foo =
  [%styled.global ...]`). It is not registered through ppxlib's
  extension rules; the whole-structure `~impl` transformer matches
  `Pmod_extension` nodes named `styled.global` directly
  (`map_ordered_module_expr` in `ppx.re`). Uses in other positions are
  left unexpanded (no dedicated migration diagnostic exists today).
- Splits each interpolated rule into two complementary outputs:
  the static rule with `var(--<prefix>-<hash>)` substituted in value
  positions and resolved class chains substituted in selector
  positions (extracted via `Buffer.add_global_rule` like a static
  global) plus a generated module containing
  `to_string`/`makeProps`/`make` that emit a single
  `:root { --<prefix>-<hash>: <value>; ... }` block at runtime to supply
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
[@@@css "body{color:var(--themeColor-1ppd0ds);margin:0;}"]
let themeColor = CSS.red
module ThemeStyles = struct
  let to_string () =
    ":root{--themeColor-1ppd0ds:" ^ CSS.Types.Color.toString themeColor ^ ";}"
  let makeProps ?key () = Js.Obj.empty ()
  let make _props = CSS.global_style_tag (to_string ())
end
```

(Snapshot: `packages/ppx/test/snapshot/reason/reason-styled-global2-interpolation.t`.)

The static rule extracts via the existing `[@@@css ...]` channel
(see `css-extraction.md`). The generated `module ThemeStyles` is
the only new artifact.

#### Two halves

| Half    | Shape                                                                                | Where it lives                                                                  |
| ------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| Static  | The user's rule, with `var(--<prefix>-<hash>)` in interpolation positions            | Aggregated `styles.css` via `[@@@css ...]`                                      |
| Dynamic | A single `:root { --<prefix>-<hash>: <value>; ... }` block, one declaration per value var | Generated module's `to_string`, mounted via `make`                              |

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
  reject parentless `&`; flatten nesting (Resolve.resolve_selectors)
  for each Style_rule / At_rule:
    Css_transform.transform_rule ($(path) → var(--<prefix>-<hash>); collect dynamic_vars)
    render and push to Buffer.add_global_rule
  return dynamic_vars
  │
  ▼
build module structure (in ppx.re):
  to_string  = Css_global_to_string.render_root_block(dynamic_vars)
               (emits ":root{--<prefix>-<hash>:<call expr>;...}" or "" if no vars)
  makeProps  = (~key=?, ()) => Js.Obj.empty()
  make       = _props => CSS.global_style_tag(to_string())
  │
  ▼
return Pmod_structure([to_string; makeProps; make])
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
- **`makeProps`** — `(~key=?, ()) => Js.Obj.empty()`, generated for JSX
  component compatibility.
- **`make : unit -> React.element`** — always
  `_props => CSS.global_style_tag(to_string())`.

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

Custom-property names are `--<prefix>-<hash>` (e.g.
`--themeColor-1ppd0ds`), minted in `packages/ppx/src/Hash_class.ml`.
The prefix is a readable, CSS-identifier-safe rendering of the
interpolation's source path (falling back to `var` when nothing
identifier-like survives); it is purely cosmetic. The murmur2 hash owns
uniqueness and covers the scoped namespace
(`Hash_class.scoped_namespace`: kind, module name, submodule scope,
rendered rules), the expression path, and the resolved runtime type, so
the same expression interpolated at two different target types gets two
distinct variables. Names derive only from source, so dev and prod
builds agree.

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
| Interpolation inside `url(...)`                                           | `raise_errorf`: browsers don't substitute `var()` inside `url()`.                                                                          |
| Interpolation in an at-rule prelude (e.g. `@media (max-width: $(bp))`)   | `raise_errorf` pointing at the interpolation.                                                                                             |
| Parentless `&` (top level, or under an at-rule with no style rule above)  | `raise_errorf`: `&` has no parent selector to resolve against.                                                                            |
| Selector interp `$(name)` references undefined or forward local binding   | `raise_errorf` from `Local_selector_environment.resolve_selector_class_ref` pointing at the interpolation.                                                  |
| Bare `$(name)` (no `.` prefix) resolves to multiple classes               | `raise_errorf` instructing the user to switch to `.$(name)` for chain semantics.                                                          |
| Cross-module `$(M.x)` where `M.x` doesn't exist at link time              | `Unbound module` / `Unbound value` from OCaml typechecker via the synthetic `let _ = M.x`; aggregator also reports a missing-binding error using the location stored in `[@@@css.refs ...]`. |

#### Code map

| File                                            | Role                                                                                                                                                                                                                                |
| ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `packages/ppx/src/ppx.re`                       | `map_ordered_module_expr` matches `Pmod_extension` nodes named `styled.global`; `expand_global_module` does the work.                                                                                                              |
| `packages/ppx/src/Css_file.re`                  | `push_global ~file rule_list` returns the list of `dynamic_vars` collected across all rules; pushes the static rules (with `var(--<prefix>-<hash>)` already substituted) into the global buffer. Also hosts the `Css_transform` submodule doing the interpolation walks. |
| `packages/ppx/src/Local_selector_environment.re` | Per-CU selector environment used by `[%css]` and `[%styled.global]` for same-file selector interpolation, module aliases, opens/includes, and cross-module fallback.                                                               |
| `packages/ppx/src/Css_global_to_string.re`      | `render_root_block ~loc dynamic_vars` builds the `to_string` body: a single `:root { ... }` rule with one declaration per entry, or `""` when `dynamic_vars` is empty.                                                              |
| `packages/runtime/{native,melange}/CSS.ml`      | `CSS.global_style_tag : string -> React.element`.                                                                                                                                                                                   |

#### Intentionally not done

- **No new wire-protocol attribute.** The static side is a finished
  CSS rule already; the aggregator needs nothing else.
- **No target branching in the PPX.** Same module on every target;
  both runtimes provide `CSS.global_style_tag`.
- **No expression-context registration.** `[%styled.global]` only means
  something as a module expression; other positions are left
  unexpanded rather than given a dedicated migration diagnostic.
- **No labeled-arg synthesis on `make`.** In-scope capture matches
  `[%css]`.
- **No `--*` typing fix.** Pre-existing gap, separate change.
- **No `CSS.global` from inside `make`.** That would route through
  the runtime stylesheet, defeating the static-extraction contract.

### `[%keyframe]`

Shares the same front end and extracts `@keyframes` blocks named by
content hash (`keyframe-<murmur2(body)>`, via `Css_file.push_keyframe`).
Value interpolation in keyframe declarations is lowered to
CSS custom properties in the extracted `@keyframes` rule, while the generated
`AnimationName.t` carries the runtime custom-property bindings that
`animation-name` and supported leading-name `animation` shorthand interpolation
merge into the consuming element's `CSS.make` vars. Covered briefly in
`documents/css-extraction.md` and in more detail in
`documents/keyframe-static-extraction.md`.

## Direction

The redesign should move the pipeline toward three explicit goals:

1. Keep the lexer small and move syntax meaning into a handwritten parser.
2. Make `component_value_list` the real parser/css-grammar boundary.
3. Co-locate property grammar, typed AST, and printing so parse/print share one
   source of truth.

The "Current Pipeline" section above is the descriptive snapshot of the
current pipeline. The rest of this document describes the intended direction
from that baseline.

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
  now emit AST-native rules with `type_check`, `infer_interpolation_types`
  (plus `_with_context`), and `runtime_module_path` entrypoints.
- The old central `packages/css-grammar/lib/Parser.ml` has been dissolved;
  `packages/css-grammar/lib/Registry.ml` now exposes the AST-based
  entrypoints (`validate_property`, `infer_interpolation_types`,
  `type_check`), re-exported through the `Css_grammar.re` facade.
- PPX type checking (`packages/ppx/src/Css_validation.re`, called from
  `ppx.re`) now validates declarations directly from parser AST values.
- Interpolation extraction in `packages/ppx/src/Css_file.re` now reads
  interpolation types directly from `component_value_list`.
- Runtime lowering parses typed property values from `component_value_list`
  instead of reparsing declaration value strings. (The historical
  `Property_to_runtime.re` module that pioneered this has since been removed;
  `Css_to_runtime.re` owns runtime emission now.)
- `@media` and `@container` validation in `packages/ppx/src/Css_to_runtime.re`
  now parses preludes from parser AST values rather than reparsing source text.

Compatibility note:

- No string-based entrypoints remain in the css-grammar library; test suites
  that want to feed strings parse to parser AST themselves via the parser
  Driver before invoking the grammar.
- Raw source slicing is still used in `Css_to_runtime` when emitting unsafe
  fallback strings and preserving user-authored formatting, but that source is
  now passed explicitly through PPX/runtime call sites rather than coming from a
  global parser buffer. It is no longer the semantic input to css-grammar
  validation or typed runtime lowering.

### Step 3 - Split css-grammar and runtime by property modules (Partially done)

Replace the giant central css-grammar parser file with a property-centered
module layout.

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

Status:

- **Done:** the css-grammar side of the split. The central parser file is
  gone; `packages/css-grammar/lib/Properties/` holds ~163 per-property
  modules, each owning its `[%spec_module]` declarations, with
  `Registry.ml` as the dispatch layer and `Css_grammar.re` as the facade.
  (Caveat: `Types.ml` and `Shared.ml` inside css-grammar are still large
  shared files.)
- **Not done:** the runtime side. `packages/runtime/native/shared/Css_types.ml`
  is still a single ~10k-line source of truth that the property modules
  reference into (`(module Css_types.Color)`), the reverse of the facade
  direction proposed above.

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

When a step changes only one layer, targeted suites are acceptable during local
iteration, but every milestone should re-run the broader pipeline-facing suites.
In particular, `css-support` should be treated as a non-negotiable regression
signal because it exercises the user-visible PPX contract.

Each migration step should therefore include:

1. New regression tests for the behavior being moved.
2. Targeted suite execution for the package being changed.
3. Cross-package verification that parser, css-grammar, PPX, and runtime still
   agree on the same behavior.
