# Keyframe Static Extraction With Interpolation

## Status

- Implemented design for interpolation support in `[%keyframe]`.
- Builds on the current static-extraction model used by `[%css]`.
- Keyframes can reference runtime values through CSS custom properties without
  making `@keyframes` itself dynamic.

## Problem

`[%keyframe]` currently accepts only static keyframe CSS:

```reason
let animation = [%keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];
```

It expands to a static extracted `@keyframes` rule plus an animation-name value:

```ocaml
[@@@css "@keyframes keyframe-c958s{0%{opacity:0 ;}100%{opacity:1 ;}}"]
let animation = CSS.Types.AnimationName.make("keyframe-c958s")
```

This shape cannot support:

```reason
let prev = `px(previousHeight);
let current = `px(currentHeight);

let animation = [%keyframe {|
  0% { height: $(prev) }
  100% { height: $(current) }
|}];
```

CSS itself can express this with custom properties:

```css
@keyframes keyframe-x {
  0% { height: var(--var-prev); }
  100% { height: var(--var-current); }
}
```

The missing piece is not CSS syntax. The missing piece is a typed runtime carrier
that keeps the generated animation name and the custom-property bindings
together until the animation is applied to an element.

## Current Pipeline Findings

### `[%keyframe]`

Files:

- `packages/ppx/src/ppx.re`
- `packages/ppx/src/Css_file.re`

Current flow:

1. `expand_keyframe_expression` accepts a string constant.
2. It parses with `Styled_ppx_css_parser.Driver.parse_keyframes`.
3. `Css_file.push_keyframe` renders the parsed rules.
4. The rendered body is hashed into `keyframe-<hash>`.
5. The static `@keyframes` rule is pushed into `Css_file.Buffer`.
6. The expression returns `CSS.Types.AnimationName.make("keyframe-<hash>")`.

Current limitation:

- `push_keyframe` renders the parsed rules directly.
- It does not call `Css_transform.transform_rule`.
- It returns only `string`, not any `dynamic_vars`.

### `[%css]`

Files:

- `packages/ppx/src/Css_file.re`
- `packages/ppx/src/Css_to_runtime.re`

Current flow:

1. `Css_file.push` calls `Css_transform.transform_rule_list`.
2. `transform_rule` walks declarations.
3. `$(expr)` in declaration values becomes `var(--var-<hash>)` in extracted CSS.
4. The transform accumulates `dynamic_vars` as `(var_name, original_path, var_type)`.
5. `Css_to_runtime.render_make_call` turns those vars into the second argument of
   `CSS.make(className, vars)`.
6. `CSS.make` stores those vars on the React style object, so custom properties
   are scoped to the element.

That element-scoped behavior is exactly what interpolated keyframes need.

## Design Goal

Support this user shape:

```reason
let prev = `px(previousHeight);
let current = `px(currentHeight);

let animation = [%keyframe {|
  0% { height: $(prev) }
  100% { height: $(current) }
|}];

let styles = [%css {|
  animation-name: $(animation);
  animation-duration: 180ms;
|}];
```

Expected static CSS:

```css
@keyframes keyframe-abc {
  0% { height: var(--var-prev); }
  100% { height: var(--var-current); }
}

.css-def {
  animation-name: var(--var-animation);
}
```

Expected runtime style vars on the animated element:

```reason
[
  ("--var-animation", "keyframe-abc"),
  ("--var-prev", CSS.Types.Height.toString(prev)),
  ("--var-current", CSS.Types.Height.toString(current)),
]
```

The key property is locality: keyframe interpolation values must be applied to
the element using the animation, not emitted globally through `:root`.

## Proposed API Shape

Make `CSS.Types.AnimationName.t` carry both the animation name and any CSS custom
properties required by that animation.

Today:

```ocaml
module AnimationName : sig
  type t

  val make : string -> t
  val none : t
  val toString : t -> string
end = struct
  type t = string

  let make x = x
  let none = "none"
  let toString x = x
end
```

Proposed:

```ocaml
module AnimationName : sig
  type t

  val make : ?vars:(string * string) list -> string -> t
  val none : t
  val toString : t -> string
  val vars : t -> (string * string) list
  val toStyleVars : string -> t -> (string * string) list
end = struct
  type t = {
    name : string;
    vars : (string * string) list;
  }

  let make ?(vars = []) name = { name; vars }
  let none = make "none"
  let toString x = x.name
  let vars x = x.vars
  let toStyleVars property_name x = (property_name, toString x) :: vars x
end
```

Why this is the cleanest carrier:

- Existing static keyframes still return `AnimationName.t`.
- Existing non-keyframe animation names created with `AnimationName.make` keep
  working and simply carry no vars.
- `animation-name: $(animation)` stays the user-facing syntax.
- The PPX can merge nested animation vars when it sees an interpolation typed as
  `AnimationName`.
- No global `:root` emission is needed.
- No separate environment is needed to remember which local let-bindings came
  from `[%keyframe]`.

## Alternatives Considered

### PPX-side keyframe binding registry

Track local `let animation = [%keyframe ...]` bindings in a new PPX environment,
then teach `animation-name: $(animation)` to look up extra vars for that binding.

Trade-offs:

- Works for simple named local bindings.
- Does not work for arbitrary expressions returning animation names.
- Requires another lexical environment parallel to selector interpolation.
- Makes behavior depend on whether the PPX can resolve the source expression as
  a binding name.

Rejected because keyframe vars should travel with the value, not with a best-effort
source-code lookup.

### Emit keyframe interpolation vars globally

Transform keyframes to `var(--...)` and emit the dynamic values through a global
`:root` block, like `[%styled.global]`.

Trade-offs:

- Simple to generate.
- Incorrect for per-element animations.
- Multiple component instances would overwrite each other.
- SSR/request-local values would leak into process/global CSS unless carefully
  isolated.

Rejected because keyframe interpolation values must be scoped to the element that
uses the animation.

### Return a new keyframe-specific record type

Make `[%keyframe]` return a new type, for example `CSS.Keyframe.t`, containing
`name` and `vars`.

Trade-offs:

- Explicit and locally clear.
- Forces `animation-name` interpolation to accept both `AnimationName.t` and the
  new keyframe type.
- Requires either new grammar typing for keyframe carriers or special-case PPX
  handling at each animation-name interpolation site.

Rejected because `AnimationName.t` is already the domain value users pass into
`animation-name`, and it is abstract enough to carry the extra data directly.

## PPX Design

### Transform keyframe bodies

Add a new keyframe push path in `Css_file.re`:

```reason
let push_keyframe = (~file, ~scope, ~opens, keyframe_rules) => {
  let dynamic_vars = ref([]);
  let transformed_rules =
    rules
    |> List.map(rule =>
         Css_transform.transform_rule(~file, ~scope, ~opens, rule, dynamic_vars)
       );

  let rendered_body = transformed_rules |> List.map(render_rule) |> String.concat(" ");
  let keyframe_name = Printf.sprintf("keyframe-%s", Murmur2.default(rendered_body));
  Buffer.add_rule(keyframe_name, rendered_keyframe);
  (keyframe_name, List.rev(dynamic_vars^));
};
```

Notes:

- `parse_keyframes` represents each keyframe step as a `Style_rule`, with
  keyframe selectors like `from`, `to`, or `0%` encoded in the selector prelude.
- `transform_rule` already recurses into declaration values and nested blocks.
- Interpolation in keyframe selectors should remain unsupported because CSS
  variables are not valid keyframe selector syntax.
- Interpolation in nested at-rule preludes remains rejected by existing
  `transform_at_rule` behavior.

### Return `AnimationName.make`

Update `expand_keyframe_expression` in `ppx.re`:

```ocaml
CSS.Types.AnimationName.make
  ~vars:[ ("--var-prev", CSS.Types.Height.toString prev)
        ; ("--var-current", CSS.Types.Height.toString current)
        ]
  "keyframe-abc"
```

This needs a small helper parallel to the var-list construction in
`Css_to_runtime.render_make_call`, so keyframe expansion and `CSS.make` use the
same conversion rules for `CustomProperty` and `RuntimeModule(module_name)`.

Recommended implementation detail:

- Extract dynamic-var expression rendering from `Css_to_runtime.render_make_call`
  into a reusable helper, for example:

```reason
let render_dynamic_var_tuple = (~loc, (var_name, original_path, var_type)) => ...;
let render_dynamic_var_list = (~loc, dynamic_vars) => ...;
```

### Merge keyframe vars into `CSS.make`

When a declaration interpolation is typed as `AnimationName`, `CSS.make` must
receive both:

- the var for the `animation-name` property itself
- the vars required by the interpolated keyframe body

For:

```reason
[%css {| animation-name: $(animation); |}]
```

Generate conceptually:

```ocaml
let animation_value = animation in
CSS.make
  "css-def"
  ([ ("--var-animation", CSS.Types.AnimationName.toString animation_value) ]
   @ CSS.Types.AnimationName.vars animation_value)
```

Avoid evaluating interpolation expressions twice. If the original interpolation
is not a plain identifier, generated code should bind it once before calling
both `toString` and `vars`.

The implementation point is `Css_to_runtime.render_make_call`:

- It already sees `var_type = RuntimeModule(module_name)`.
- Detect `module_name` for `AnimationName`.
- For AnimationName vars, emit a list expression that concatenates the base
  custom-property assignment with `CSS.Types.AnimationName.vars value`.
- For all other modules, keep the current single-tuple behavior.

The final `vars` argument may need to become a concatenated list expression
rather than a plain literal list.

### Expansion shapes

Use one runtime helper on `AnimationName` to avoid evaluating interpolated
animation expressions twice:

```ocaml
val toStyleVars : string -> t -> (string * string) list

let toStyleVars custom_property_name animation =
  (custom_property_name, toString animation) :: vars animation
```

Then generated CSS/runtime output can treat every interpolated animation name as
one list-producing chunk.

For longhand `animation-name`:

```reason
[%css {| animation-name: $(fade); |}]
```

Static CSS:

```css
.css-x { animation-name: var(--var-fade); }
```

Runtime vars:

```ocaml
CSS.make
  "css-x"
  (CSS.Types.AnimationName.toStyleVars "--var-fade" fade)
```

For multiple longhand names:

```reason
[%css {| animation-name: $(fade), $(slide); |}]
```

Static CSS:

```css
.css-x { animation-name: var(--var-fade), var(--var-slide); }
```

Runtime vars:

```ocaml
CSS.make
  "css-x"
  (CSS.Types.AnimationName.toStyleVars "--var-fade" fade
   @ CSS.Types.AnimationName.toStyleVars "--var-slide" slide)
```

For shorthand `animation` when the interpolation is the animation-name component:

```reason
[%css {| animation: $(fade) 180ms ease-out both; |}]
```

Static CSS:

```css
.css-x { animation: var(--var-fade) 180ms ease-out both; }
```

Runtime vars:

```ocaml
CSS.make
  "css-x"
  (CSS.Types.AnimationName.toStyleVars "--var-fade" fade)
```

For multiple shorthand animations:

```reason
[%css {|
  animation: $(fade) 180ms ease-out both, $(slide) 240ms linear both;
|}]
```

Static CSS:

```css
.css-x {
  animation: var(--var-fade) 180ms ease-out both,
             var(--var-slide) 240ms linear both;
}
```

Runtime vars:

```ocaml
CSS.make
  "css-x"
  (CSS.Types.AnimationName.toStyleVars "--var-fade" fade
   @ CSS.Types.AnimationName.toStyleVars "--var-slide" slide)
```

This is different from whole-shorthand interpolation:

```reason
[%css {| animation: $(full_animation); |}]
```

That interpolation is typed as the whole `Animation` value, so the static CSS is
only:

```css
.css-x { animation: var(--var-full-animation); }
```

It cannot automatically discover nested `AnimationName.vars` unless the runtime
`Animation.t` also becomes a structured carrier. That is a separate design. The
first implementation should support the name-as-component case and keep the
current “whole animation shorthand” behavior unchanged.

Current grammar note: `animation-name` already types interpolation as
`AnimationName`. The shorthand `animation` path must ensure an interpolation in
the `<keyframes-name>` slot is typed as `AnimationName`, not as the whole
`Animation` property. If the existing generated grammar cannot express that for
all CSS-valid orders, the first slice can support the explicit leading-name form
`animation: $(name) ...` and reject or defer other orders until shorthand parsing
tracks component-level interpolation types.

## Files To Change

### PPX

- `packages/ppx/src/ppx.re`
  - Pass `~file`, `~scope`, and `~opens` into `Css_file.push_keyframe`.
  - Expand keyframes with interpolation to
    `CSS.Types.AnimationName.make(~vars, name)`.
  - Keep static keyframes valid with `make(name)`.

- `packages/ppx/src/Css_file.re`
  - Change `push_keyframe` to call `Css_transform.transform_rule` on the parsed
    keyframe rules.
  - Return `(keyframe_name, dynamic_vars)` instead of only `keyframe_name`.
  - Hash the transformed keyframe body so identical static CSS deduplicates.

- `packages/ppx/src/Css_to_runtime.re`
  - Extract reusable dynamic-var rendering helpers.
  - Support `AnimationName` nested vars in `render_make_call`.
  - Avoid double evaluation for AnimationName interpolation expressions.

### Runtime

- `packages/runtime/native/shared/Css_types.ml`
  - Change `AnimationName.t` from string-backed to a record-backed abstract
    value carrying `name` and `vars`.
  - Add optional `~vars` to `make`, plus `vars` and `toStyleVars`.

- `packages/runtime/melange/shared` or generated/shared equivalent if present
  - Keep the Melange runtime API identical to native. In this repo, both
    `packages/runtime/native/CSS.ml` and `packages/runtime/melange/CSS.ml` use
    the shared `Css_types` module shape, but verify generated/package wiring.

### Documentation

- `documents/design.md`
  - Replace “No interpolation support today” under `[%keyframe]` with the new
    carrier-based design summary once implemented.

- `documents/css-extraction.md`
  - Update the `[%keyframe]` section to mention static keyframes with runtime
    element-scoped custom properties.

## Tests To Add Or Update

### Snapshot tests

- `packages/ppx/test/snapshot/reason/reason-keyframes.t/input.re`
  - Add an interpolated keyframe used through `animation-name`.
  - Assert generated output contains:
    - extracted `@keyframes` with `var(--...)`
    - `AnimationName.make(~vars=..., ...)`
    - `CSS.make(..., vars)` including both the animation-name var and keyframe
      body vars

- `packages/ppx/test/snapshot/reason/reason-cx-full-integration.t/run.t`
  - Update only if existing snapshots change from the new `AnimationName.t`
    representation.

### CSS support tests

- `packages/ppx/test/css-support/animations.t/input.re`
  - Add `[%keyframe]` interpolation with `height`, `opacity`, or another typed
    property.
  - Add `[%css {| animation-name: $(interpolatedKeyframe) |}]`.
  - Keep the current note that animation shorthand interpolation is unsupported.

- Expected output should prove:
  - static keyframes without interpolation are unchanged semantically
  - duplicate interpolated keyframe bodies deduplicate by transformed CSS
  - `animation-name: $(foo), $(bar)` merges vars from both animation names

### Error tests

- Add or extend a PPX error test for unsupported interpolation positions:
  - keyframe selector interpolation, if the parser can represent it
  - nested at-rule prelude interpolation inside keyframes, for example an
    unsupported `@media (min-width: $(bp))` shape if accepted by the parser
  - `url($(asset))` inside a keyframe declaration should reuse the existing
    clear `url(...)` interpolation error

### Runtime tests

- `packages/runtime/test/test_styles.ml`
  - Add coverage for `AnimationName.make(~vars=...)` and `AnimationName.vars`.
  - Assert `AnimationName.toString` returns only the name.
  - Assert `CSS.make` still accepts the combined var list and writes custom
    properties to the style object.

## Compatibility Notes

`CSS.Types.AnimationName.t` is abstract in the runtime signature, so changing the
implementation from `string` to a record should not break normal users. Existing
code using `AnimationName.make`, `AnimationName.none`, and `AnimationName.toString`
keeps the same source-level API.

This does not make `@keyframes` dynamic. The extracted rule remains static and
content-addressed. Only the custom-property values used by that static rule are
dynamic and element-scoped.

## Open Questions

1. Should `AnimationName.vars` be public for debugging/composition, or treated as
   internal API?
2. Should duplicate vars from `animation-name: $(foo), $(foo)` be deduplicated at
   runtime, or is preserving the existing `dynamic_vars` behavior enough?

## Recommended First Implementation Slice

1. Add optional `~vars` to `AnimationName.make`, plus `AnimationName.vars` and
   `AnimationName.toStyleVars`.
2. Extract dynamic-var rendering helpers from `Css_to_runtime.re`.
3. Change `push_keyframe` to transform rules and return `dynamic_vars`.
4. Generate `make(~vars, name)` from `[%keyframe]` when `dynamic_vars` is non-empty.
5. Teach `render_make_call` to append `AnimationName.vars` for AnimationName
   interpolations.
6. Add one focused snapshot test for interpolated height keyframes before
   broadening coverage.
