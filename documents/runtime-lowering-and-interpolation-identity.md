# Runtime Lowering And Interpolation Identity

## Status

- Draft
- Companion to `documents/design.md` and `documents/css-extraction.md`
- Covers two deepening opportunities:
  - Shrinking `packages/ppx/src/Property_to_runtime.re`
  - Replacing binding-only static interpolation deduplication with a typed identity model

## Problem

`Property_to_runtime` currently has a small external Interface and a very large
Implementation. That gives callers leverage, but maintainers have poor locality:
property parsing, runtime expression generation, unsupported fallback behavior,
custom property escape handling, and property dispatch all live in one Module.

Static extraction has a related locality problem. `[%css]` and
`[%styled.global]` deduplicate interpolated values by the generated CSS custom
property name. That name is derived from the OCaml expression source, not from the
CSS property context or resolved runtime type. The checked-in regression tests
`reason-cx-cross-property-dedup-regression.t` and
`reason-styled-global2-cross-property-dedup-regression.t` pin the resulting
known-broken behavior: the same OCaml binding can be interpolated into two CSS
properties with different accepted value spaces, and the first property decides
the single `toString` conversion used by both sites.

The same CSS concept therefore leaks across several seams:

- `packages/css-grammar/lib/Properties/*.ml` validates and infers interpolation types.
- `packages/ppx/src/Css_file.re` chooses static custom property names and records dynamic vars.
- `packages/ppx/src/Css_global_to_string.re` emits runtime `toString` calls for `[%styled.global]`.
- `packages/ppx/src/Css_to_runtime.re` emits runtime values for `[%css]`.
- `packages/ppx/src/Property_to_runtime.re` lowers `%css` values to runtime declarations.
- `packages/runtime/native/shared/Css_types.ml` and `Declarations.ml` define the runtime value and declaration surface.

## Direction

Deepen the property family Module. A property family Module should hide more
behavior behind a smaller Interface:

- Grammar rule and validation behavior
- Interpolation type inference
- Runtime value printing
- PPX runtime lowering
- Unsupported fallback decision, when the runtime intentionally lacks a typed declaration
- Static extraction interpolation identity contribution

The external PPX Interface should remain small: callers ask to validate, lower,
or extract. The Implementation should move toward property-centered locality so
that changing one property family mostly touches one Module.

## Runtime Lowering Migration

### Current Shape

`Property_to_runtime.render` is the external Interface for `%css` runtime
lowering. Its Implementation contains:

- Generic expression helpers
- Property-specific lowering helpers
- A central property dispatch table
- Global CSS keyword handling
- Unsupported fallback through `CSS.unsafe`
- Custom property lowering

The deletion test says `Property_to_runtime` is earning its external keep: if it
were deleted, every caller would need to know validation, fallback, `!important`,
and runtime expression details. Internally, though, the Module is too broad for
locality.

### Target Shape

Introduce property family lowering Modules incrementally. Each Module should own
one coherent CSS family and expose a small lowering Interface consumed by the
central dispatch layer.

The first slice is `Custom_property_runtime`, which now owns the runtime lowering
for `--*` declarations. It is intentionally small, but establishes the desired
direction: custom property name detection and runtime declaration rendering live
together instead of being embedded in the central lowering file.

Future slices should move property families out of `Property_to_runtime` by
concept, not by mechanical helper category. Good candidates:

- Box model: `margin`, `padding`, `width`, `height`, min/max variants
- Color and background: `color`, `background`, `background-color`, gradients
- Typography: `font`, `font-size`, `font-weight`, `line-height`
- Layout: `display`, flex, grid, alignment

Each slice should preserve the central `render` Interface until enough property
families have moved to justify changing the external seam.

### Unsupported Fallback

Unsupported fallback should become an explicit property-family decision, not a
side effect of raising `Unsupported_feature` from a giant dispatch function.

The target behavior is:

- A property family Module can say "typed runtime lowering exists".
- A property family Module can say "grammar accepts this, but runtime lowering is intentionally unsafe".
- A property family Module can say "this state is impossible if grammar and lowering agree".

Tests should assert these decisions at the property family Interface. Snapshot
tests should continue to guard generated PPX output, but they should no longer be
the only way to understand whether a property is unsupported by design or by gap.

## Interpolation Identity Migration

### Current Shape

Static extraction turns value interpolation into CSS custom properties:

```reason
color: $(themeColor);
```

becomes a static rule containing `var(--var-<hash>)` plus runtime code that emits
the variable value. Today the hash is based on the OCaml expression source. That
means the identity is effectively "this binding", not "this binding in this CSS
property context with this runtime type".

### Target Shape

Introduce an interpolation identity value that travels through static extraction.
It should include:

- Source expression path, for stable names and repeated-use detection
- Property name, for CSS context
- Resolved runtime module, for the `toString` contract
- Occurrence index, for multiple occurrences in one declaration value
- Source location, for diagnostics

The identity should be computed before dynamic vars are deduplicated. Deduplication
must compare the full identity, not just the generated CSS variable name.

### Naming Strategy

The generated CSS variable name should remain stable for the common case where a
binding is used in one compatible context. When the same binding is used across
different property contexts or runtime modules, the name should diverge.

Acceptable strategies:

- Include the property name in the hash input.
- Include the resolved runtime module in the hash input.
- Include both property name and runtime module in the hash input.

The preferred default is both property name and runtime module. It maximizes
safety and makes the name reflect the real Interface contract: a runtime value is
valid only through the printer selected for that property context.

### Regression Test Migration

The current known-broken snapshots should change from "pins broken behavior" to
"proves separated identities".

For `[%css]`:

- Same binding in `margin-left` and `padding-left` should produce separate CSS custom properties or a shared identity only if the resolved runtime type is proven compatible.
- Generated runtime code should call the correct `toString` for each context.

For `[%styled.global]`:

- Same binding in `background` and `color` should not reuse a single `Background.toString` result for both declarations.
- Generated `to_string` should emit one declaration per distinct interpolation identity.

## Test Strategy

Use layered tests, with the Interface as the test surface:

- Property family tests: validate grammar, interpolation type inference, runtime lowering, and unsupported fallback decisions together.
- Static extraction identity tests: assert identity construction and deduplication without requiring full snapshot output.
- PPX snapshots: keep representative `[%css]`, `[%styled.global]`, and `%css` snapshots for generated code compatibility.
- Aggregator tests: keep protocol and sentinel tests in `packages/generate/test` focused on cross-module resolution, not property typing.

## Non-Goals

- Do not change the public runtime declaration Interface as part of the first migration slice.
- Do not preserve known-broken interpolation deduplication for compatibility.
- Do not introduce a seam with only one adapter unless a second adapter is already visible. Internal seams inside a property family Module are fine when they improve tests, but the external seam should remain earned by actual variation.

## Open Questions

- Should compatible runtime modules deduplicate across properties, or should property context always produce separate identities?
- Should custom property `--*` interpolation remain a string escape hatch, or should `@property` support introduce typed custom property Modules later?
- Should unsupported fallback be represented as data instead of exceptions before or after the first large property family migrates?
