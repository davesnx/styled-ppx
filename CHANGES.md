# Changes

## 0.62.0

- [FEATURE] Add PPX flag `--env development|production`. `development` enables `--dev` marker classes and readable label suffixes. `production` enables `--minify`, removes label suffixes, and minifies CSS (@davesnx)
- [BREAKING] Remove `--minify` from `styled-ppx.generate`. Move the setting to the PPX stanza, for example `(pps styled-ppx --env production ...)`. The PPX records the environment in each compiled file; the generator minifies only when every input declares production and warns when environments are mixed (@davesnx)
- [BREAKING] Statically extract CSS from `[%css]`, `[%styled.<tag>]`, `[%styled.global]`, and `[%keyframe]`, atomizing declarations into content-addressed classes (#573). Add a dune rule that runs `styled-ppx.generate` over post-PPX files and load the generated stylesheet. Runtime stylesheet insertion is removed (@davesnx)
- [BREAKING] Remove the ReScript runtime, `styled-ppx.rescript`, together with its tests, demo, and VSCode syntax (@davesnx)
- [BREAKING] Remove `styled-ppx.string-interpolation` and the obsolete pre-extraction runtime-lowering modules (@davesnx)
- [BREAKING] Make `styled-ppx.css-parser`, `styled-ppx.css-grammar-parser`, `styled-ppx.css-spec-parser`, `styled-ppx.css-extraction`, and `styled-ppx.murmur2` package-private. Supported libraries are `styled-ppx`, `styled-ppx.native`, and `styled-ppx.melange`; `styled-ppx.generate` remains the public generator CLI (@davesnx)
- [BREAKING] `[%styled.global]` now returns a `React.element`. Render that element instead of calling the removed `to_buffer` API (@davesnx)
- [BREAKING] Remove `cx2` (@davesnx)
- [BREAKING] [FIX] Replace `CSS.Types.TextEmphasisPosition.LeftRightAlignment` and `.OverOrUnder` with `CSS.Types.TextEmphasisPosition.t`. It accepts `` `over ``, `` `under ``, `` `overRight ``, `` `overLeft ``, `` `underRight ``, and `` `underLeft `` and provides the `toString` witness required by interpolated `text-emphasis-position`. The build now checks runtime witness paths against `styled-ppx.native` (@davesnx)
- [BREAKING] Reject interpolated declarations under selectors that target outside `&`'s subtree, such as `& + div { color: $(c) }`, because the inline custom property cannot reach the target. Use a literal value, a globally inherited custom property, or target `&` or one of its descendants (@davesnx)
- [FEATURE] Allow any OCaml or Reason expression inside `$(...)`, rather than only identifiers and module paths (#572) (@davesnx)
- [FEATURE] Add `CSS.empty`, `CSS.styles`, and `CSS.className` (@davesnx)
- [FEATURE] Support `font-family` interpolation with arrays of font families (@davesnx)
- [FEATURE] Validate `@media`, `@supports`, and `@container` preludes at compile time, including media-feature values and range syntax (@davesnx)
- [FEATURE] Validate descriptors for `@font-face`, `@font-palette-values`, `@view-transition`, and `@counter-style` (@davesnx)
- [FEATURE] Accept `min-` and `max-` forms of container range features: `width`, `height`, `inline-size`, `block-size`, and `aspect-ratio`. Discrete `orientation` has no prefixed forms (@davesnx)
- [FEATURE] Add `--log error|warning|info|debug` and `--debug` to `styled-ppx.generate`; diagnostics now use the `styled-ppx:` prefix (@davesnx)
- [PERF] Register interpolation variables read only by `&` with `@property { syntax: "*"; inherits: false }`, limiting style invalidation to that element. The targeted benchmark measured up to a 25x median style-recalculation improvement; unsupported browsers retain the previous inherited behavior (@davesnx)
- [PERF] Bundle a block's interpolated declarations into one content-addressed atom, so a value reused by base, `:hover`, or `@media` rules creates one inline variable instead of one per variant (@davesnx)
- [PERF] Replace linear rule-deduplication scans with hash-based membership. This makes extraction about 43% faster for 1,600 declarations and about 12% faster on realistic heavy files (@davesnx)
- [FIX] Stop the opam package from installing repository-only executables: `standalone`, `rewriter`, `ppx-native-test-runner`, `as_standalone`, `ast-renderer`, `lexer-renderer`, `spec-renderer`, and `demo-exe` (@davesnx)
- [FIX] Resolve class interpolation in selectors such as `&.$(other)`, `:not(&.$(other))`, and `:has(.$(other))` to extracted classes instead of emitting literal `$(...)` text and phantom inline variables. References in the same compilation unit resolve in the PPX; cross-module references resolve in `styled-ppx.generate` when their files are included. Missing and cross-library references report located errors. Multi-atom bindings expand to chains such as `.cssA.cssB` (@davesnx)
- [FIX] Fix compiler crashes when parsing legacy `-webkit-gradient(...)` and `-webkit-mask-box-image` values whose internal registry references omitted the leading dash. A registry-closure check now validates grammar lookups with the same key derivation as generated parsers (@davesnx)
- [FIX] Parse `:nth-*()` An+B syntax correctly, including uppercase forms, `n-3`, and `2n- 3`. Invalid units, fractional or oversized coefficients, and malformed payloads now produce located errors instead of truncation or `Failure("int_of_string")` crashes (@davesnx)
- [FIX] Report invalid UTF-8 in CSS payloads at the offending byte instead of crashing with `Sedlexing.MalFormed` (@davesnx)
- [FIX] Hoist statement at-rules such as `@import`, `@namespace`, and statement-form `@layer` before style rules while preserving their relative order (@davesnx)
- [FIX] Point interpolation, bare-pseudo, and `@media` prelude errors at the offending source token, with compiler excerpts and carets (@davesnx)
- [FIX] Generate `makeProps` and a public `make` wrapper for native components, fixing `Unbound value X.makeProps` with the new server-reason-react JSX transform (@davesnx)
- [FIX] Support `[%css]` inside `include struct ... end` (@davesnx)
- [FIX] Remove CSS-unsafe characters from readable atomic-class labels; bindings ending in a prime, such as `inputView'`, now produce valid selectors (@davesnx)
- [FIX] Derive interpolation custom-property names from their source, for example `Theme.spacing.md` becomes `--spacing-md-<hash>`, instead of using `--var-<hash>` (@davesnx)
- [FIX] Hash atomic classes with the main module name rather than the file path, keeping class names stable across build contexts (@davesnx)
- [DOCS] Add an `@webref/css` coverage oracle that checks supported properties, at-rules, media features, and generated conformance tests in CI (@davesnx)
- [DOCS] Rewrite the documentation for static extraction, including the introduction, architecture, dune setup, `[%css]`, and `CSS.styles`; replace ReScript pages with a deprecation notice and use mlx syntax for OCaml examples (@davesnx)

## 0.61.0

- [BREAKING] Update to ppxlib.0.36
- [FIX] Stack overflow by adding upper bound on reason
- [BREAKING] Install reason.3.17.3

## 0.60.0

- [BREAKING] Transition property on `CSS.Transition.shorthand` function is now an optional argument (#499) (@zakybilfagih)
- [BREAKING] `CSS.gridTemplateColumns`, `CSS.gridTemplateRows`, `CSS.gridAutoColumns`, `CSS.gridAutoRows` now accepts `` `value of Track.t array `` (#502) (@zakybilfagih)
- [BREAKING] Rename `Track.t` `` `name `` to `` `lineNames ``  (#502) (@zakybilfagih)
- [FIX] False polar color space toString function (#501) (@zakybilfagih)
- [FIX] Unsupported feature string interpolation not supporting other than single interpolation syntax (#498) (@zakybilfagih)

## 0.59.0

- [BREAKING] Change entry point module `CSS` (from `CssJs`) on `styled-ppx.melange`, `styled-ppx.native` and `styled-ppx.rescript` (#490) (@davesnx)
- [FEATURE] Add support and interpolation for `zoom`, `will-change` and `user-select` properties (#489) (@davesnx)
- [FEATURE] Support content with interpolation #494 (@davesnx)
- [FEATURE] Support define CSS variables in global and use CSS variables in properties #492 (@davesnx)
- [FEATURE] Support overflow with 2 values
- [FEATURE] Make animation-name abstract (@davesnx)
- [FIX] Add 100 unsupported properties, which will render properly (#489) (@davesnx)
- [FIX] Inline all CSS.Var and CSS.Cascading in properties (#495) (@davesnx)
- [FIX] Color with support for rgba/hsla and others with calc/min and max (#495) (@davesnx)
- [FIX] Warning of kebab-case on emotion client side (#493) (@davesnx)

## 0.58.1

- [BREAKING] FontFamilyName.t is now a string (@davesnx)
- [FIX] Make unsafe calls from "Cascading" be camelCase to avoid emotion's warning #488 (@davesnx)
- [FIX] Keep classname when ampersand is at the end of the selector (@davesnx)
- [FIX] Fix fontFace in both melange and native (@davesnx)

## 0.58.0

- [FEATURE] Initial @container support #476 (@zakybilfagih)
- [FIX] Make selector nested maintain other selectors #486 (@davesnx)
- [BREAKING] Remove `Css` module, `styled_label` and friends #487 (@davesnx)
- [BREAKING] Merge styled-ppx.css and styled-ppx.emotion into styled-ppx.melange #487 (@davesnx)
- [BREAKING] Merge styled-ppx.css-native and styled-ppx.emotion-native into styled-ppx.native #487 (@davesnx)
- [BREAKING] Merge styled-ppx.css-native and styled-ppx.emotion-native into styled-ppx.native #487 (@davesnx)
- [BREAKING] Remove PseudoClass and PseudoClassParam #487 (@davesnx)
- Remove functor from Css_Js_Core #487 (@davesnx)
- Remove melange.js and melange.belt from styled-ppx.melange #487 (@davesnx)
- Remove server-reason-react.js and server-reason-react.belt from styled-ppx.native #487 (@davesnx)

## 0.57.1

- Remove public_name from alcotest_extra #484 (@davesnx)
- Fix nesting for selectors (and pseudo) in native #483 (@davesnx)

## 0.57.0

- Improvement for locations in both code-gen and error reporting by @davesnx in https://github.com/davesnx/styled-ppx/pull/456
- Support css min and max functions by @lubegasimon in https://github.com/davesnx/styled-ppx/pull/411
- Update docs by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/457
- update server-reason-react pin to main branch by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/460
- Native support for styled.{{tag}} by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/461
- Fix linear-gradient and radial-gradient  by @davesnx in https://github.com/davesnx/styled-ppx/pull/464
- Add getting started docs by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/459
- escape curly on remote markdown content by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/466
- Add Melange and native instructions by @davesnx in https://github.com/davesnx/styled-ppx/pull/465
- Global styles for native server on emotion by @pedrobslisboa in https://github.com/davesnx/styled-ppx/pull/468
- Style HTML tag by @pedrobslisboa in https://github.com/davesnx/styled-ppx/pull/467
- [emotion native] Fix nested pseudoelements by @davesnx in https://github.com/davesnx/styled-ppx/pull/470
- Transform with variable handle unsafe interpolation by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/471
- Add depext for @emotion/css >= 11.0.0 by @feihong in https://github.com/davesnx/styled-ppx/pull/473
- Add support for transition by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/472
- Fix animation codegen by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/475
- Fix error line number coming from parser by @zakybilfagih in https://github.com/davesnx/styled-ppx/pull/478
- Polish emotion-native by @davesnx in https://github.com/davesnx/styled-ppx/pull/481
- Rename `render_style_tag` to `get_stylesheet` (@davesnx)
- Docs: Explain show server rendered stylesheets work natively by @ManasJayanth in https://github.com/davesnx/styled-ppx/pull/480

## 0.56.0

- Improvement for locations in both code-gen and error reporting (#456) by @davesnx
- Support css min and max functions (#411) by @lubegasimon
- Update docs (#457) by @zakybilfagih
- Native support for styled.{{tag}} (#461) by @zakybilfagih
- background-clip: text support by @davesnx
- Fix linear-gradient and radial-gradient (#464) by @davesnx
- Rename emotion-hash into murmur2 and remove public testing cli by @davesnx
- Use server-reason-react from opam by @davesnx
