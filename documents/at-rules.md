# At-rule support study

Status: study / roadmap. Companion to the generated coverage report
(`packages/css-grammar/data/coverage.md`, `make css-oracle`).

This document goes through every CSS at-rule and decides, case by case,
what supporting it in styled-ppx should mean. The parser and renderer
already round-trip nearly every at-rule (generic prelude/block parsing per
CSS Syntax 3, statement form included). The gate lives in the PPX
semantics (`packages/ppx/src/Css_file.re`) and in descriptor validation
(`packages/css-grammar`).

## Where at-rules are gated today

- `[%css]` / `[%styled.<tag>]` (`Css_file.re`, `atomize_rules`): only
  group rules whose context distributes over the block are accepted: the
  conditional group rules (`@media`, `@supports`, `@container`,
  `@starting-style`) and block-form `@layer name { ... }` (classified
  `Atomized_block_only` in `At_rules.re`; the statement/block split happens
  in `atomize_rules` where the AST shape is visible). Each inner
  declaration is atomized and hashed on its own; the at-rule wrapper,
  including the layer name, is part of the rendered hash input.
  `@keyframes` redirects to `[%keyframe]`; statement-form and anonymous
  `@layer` get dedicated errors; everything else errors with
  "At-rule @x is not supported in styled-ppx".
- `[%styled.global]` (`Css_file.re`, `push_global`): no name filter.
  Statement at-rules (`@import`, `@charset`, `@namespace`, statement
  `@layer`) and descriptor at-rules (`@font-face`, `@property`, `@page`,
  `@counter-style`, `@font-palette-values`, `@font-feature-values`,
  `@keyframes`) pass through verbatim (`Resolve.is_descriptor_at_rule`);
  group rules are flattened. Every inner declaration is still validated
  against the property registry, so a passthrough only works end to end if
  its descriptors have grammars.
- `[%keyframe]`: the model for "named object" at-rules. Content-hash the
  rendered body, mint the name (`keyframe-<hash>`), ship it via the
  extraction buffer, return a typed runtime carrier
  (`CSS.Types.AnimationName`) that referencing properties consume.

Two constraints apply to every tier below:

1. The wire protocol has no rule-kind metadata. Everything ships as
   `[@@@css "<rendered rule>"]` strings; the aggregator
   (`packages/generate/generate.ml`) dedups by exact string and preserves
   file order. Any at-rule with stylesheet-position requirements
   (`@charset` first; `@import`/`@namespace`/statement `@layer` before
   rules) needs either a new attribute kind or aggregator-side sorting.
2. Interpolation lowers to `var(--x)` set inline on `&`. At-rule preludes
   therefore reject `$()`, since custom properties are not valid in media
   query conditions, and any new at-rule design inherits that limit.

## Per at-rule

### Supported today: keep, harden

| At-rule | Notes |
|---|---|
| `@media` | Atomized in `[%css]`, hoisted/merged in global. Preludes now grammar-validated (structure + feature-name inventory). |
| `@supports` | Atomized. Prelude structurally validated. Declaration probes inside the condition are deliberately left unvalidated: probing syntax the compiler doesn't know is the rule's purpose. |
| `@container` | Atomized. Prelude validated (structure + size-feature names). `style()`/`scroll-state()` queries pass as function blocks. |
| `@starting-style` | Atomized (extraction-only superset of the runtime path). |
| `@layer` (block form) | Atomized in `[%css]`; the layer name joins the hash input via the rendered `@layer name{...}` wrapper, so identical declarations in different layers mint different classes. Composes with the other group rules in both nesting directions. Anonymous block form rejected (a hash-minted layer name would be observable in the cascade); statement form is `[%styled.global]`-only (aggregator hoists it). |
| `@keyframes` | First-class via `[%keyframe]`. |

### Tier 1: named objects, where the keyframe model generalizes

A name in (or implied by) the prelude, descriptors in the block, referenced
from a property value. `[%keyframe]` is the template: content-hashed name,
typed runtime carrier, cross-module dedup for free.

- `@property`. A `[%property]` extension defining a typed custom property;
  returns a carrier usable in `var()` interpolation. The pipeline already
  auto-emits `@property{syntax:"*";inherits:false}` for `&`-local
  interpolation vars, and the code anticipates a typed-custom-property
  registry. Descriptors (`syntax`, `inherits`, `initial-value`) are already
  in the grammar registry. Effort: medium.
- `@position-try`. Dashed-ident-named fallback for anchor positioning,
  referenced from `position-try-fallbacks`. Exactly the keyframe shape.
  Needs descriptor grammars and an `AnimationName`-style carrier alias.
  Effort: medium, gated on anchor-positioning property support.
- `@counter-style`. Ident-named, referenced from `list-style-type` and
  `counter()`. Needs descriptor grammars (`system`, `symbols`, `negative`,
  `range`, `pad`, `fallback`, `prefix`, `suffix`, `additive-symbols` are
  all missing today) plus a carrier. Effort: medium.
- `@font-palette-values`. Dashed-ident-named, referenced from
  `font-palette`. Missing descriptor grammars: `base-palette`,
  `override-colors`. Effort: medium.
- `@view-transition`. Descriptor block (`navigation`, `types`), no name.
  Global-passthrough once descriptors are registered; the
  `ViewTransitionName` carrier already exists for the property side.
  Effort: small.

The awkward one is `@font-face`: its "name" is the `font-family` descriptor
inside the block, and users want a chosen name, not a hash. It already
works end to end in `[%styled.global]`, which the extraction docs call its
home. What remains is registering the metric-override descriptors
(`ascent-override`, `descent-override`, `line-gap-override`,
`size-adjust`) so those blocks validate. Effort: small.

### Tier 2: group rules that could atomize, pending a design decision

- `@scope`. Distributes like a group rule, but its `(root) to (limit)`
  prelude interacts with `&` resolution (the parser already handles
  `@scope (&) to (...)`). Needs a nesting-semantics design pass before
  `[%css]` can enable it. Currently passes through `[%styled.global]`
  flattened. Effort: medium-large.

### Tier 3: document-level statements (aggregator work, not PPX work)

`@import`, `@charset`, `@namespace`, statement `@layer`. All parse, render
and pass through `[%styled.global]` today, but the aggregator gives no
position guarantees: an `@import` from a later module lands mid-stylesheet
and browsers ignore it. Supporting these honestly means teaching the
aggregator to classify and sort statement at-rules to the top (`@charset`
first, then `@import`/`@namespace`/`@layer` statements, then rules),
either by parsing the rule strings it already receives or via a new
attribute kind. `@charset` is arguably moot, since the generated asset is
UTF-8; dropping it with a warning would also be defensible. Effort:
small-medium, all in `packages/generate`.

### Tier 4: niche / print

- `@page` and its margin at-rules (`@top-left` etc.). `@page` passes
  through `[%styled.global]` with core descriptors registered; margin
  at-rules go unparsed inside `@page` today and would need nested at-rule
  handling in the descriptor passthrough path. Effort: medium, low demand.
- `@font-feature-values` with its inner `@styleset`, `@swash`, etc. Same
  nested-at-rule problem, plus missing descriptor grammars. Effort:
  medium, low demand.
- `@color-profile`. Named-object shape (dashed-ident), referenced from
  `color()`. Same model as Tier 1, low demand.

### Drafts: watch, don't build

- `@custom-media` would solve exactly the pain our "no interpolation in
  media preludes" error describes, and a compile-time expansion (the PPX
  inlining the named query at use sites) needs no browser support at all.
  This fits styled-ppx unusually well. Worth prototyping when Media
  Queries 5 stabilizes; it could even ship earlier as styled-ppx-specific
  sugar.
- `@custom-selector`: styled-ppx already has a stronger mechanism
  (compile-time `.$(binding)` selector references, cross-module via
  sentinels). No need.
- `@function` / `@mixin`, `@when` / `@else`: too early, specs in flux.

## Suggested order of work

1. `@font-face` metric-override descriptors (small, unblocks real usage).
2. Aggregator position sorting for statement at-rules (fixes a real
   correctness hole in `[%styled.global]` today).
3. `@property` as `[%property]` (best value for the effort, and it builds
   the typed custom-property registry the code already anticipates).
4. ~~`@layer` block form in `[%css]`.~~ Done (issue #589): atomized, layer
   name in the hash input, statement/anonymous forms rejected with
   dedicated errors.
5. `@counter-style` / `@font-palette-values` / `@view-transition`
   descriptors and carriers.
6. `@scope` design pass.
