# Changes

## 0.62.0

- [FEATURE] Add `--env development|production` to the PPX as a preset over the individual flags: `development` = `--dev` (marker classes + readable label suffixes), `production` = `--minify` (no labels, minified CSS) (@davesnx)
- [BREAKING] [FEATURE] `styled-ppx.generate` no longer takes a mode flag (`--minify` removed): the PPX embeds `[@@@css.config [("env", "production")]]` in production builds and the aggregator minifies its output automatically when every input file declares it, warning on mixed dev/production inputs. The environment is declared once, on the `(pps styled-ppx ...)` stanza (@davesnx)
- [BREAKING] [FEATURE] CSS static extraction and atomization: all extensions (`[%css]`, `[%styled.<tag>]`, `[%styled.global]`, `[%keyframe]`) are now statically extracted at compile time. The PPX emits `[@@@css ...]` attributes that the `styled-ppx.generate` aggregator collects into CSS assets, with declarations atomized into content-addressed classes for zero runtime overhead (#573) (@davesnx)
- [BREAKING] Remove the ReScript runtime (`styled-ppx.rescript`), along with its tests, demo, and VSCode syntax (@davesnx)
- [BREAKING] Remove the `styled-ppx.string-interpolation` library and the dead PPX modules from the pre-extraction runtime path (`Property_to_runtime`, `Property_to_string`, `Custom_property_runtime`) (@davesnx)
- [BREAKING] Internal libraries are no longer exposed publicly: `styled-ppx.css-parser`, `styled-ppx.css-grammar-parser`, `styled-ppx.css-spec-parser`, `styled-ppx.css-extraction` and `styled-ppx.murmur2` are implementation details of the PPX and are now package-private (murmur2 also moved under `packages/ppx/murmur2`). The public surface is `styled-ppx` (the PPX), `styled-ppx.native`, `styled-ppx.melange` and the `styled-ppx.generate` binary (@davesnx)
- [BREAKING] `[%styled.global]` now returns a `React.element` instead of writing to a buffer; `to_buffer` is removed (@davesnx)
- [BREAKING] Remove `cx2` (@davesnx)
- [BREAKING] [FIX] `[%css]` class-name interpolation in selectors (e.g. `&.$(other)`, `:not(&.$(other))`, `:has(.$(other))`) is now resolved at extraction time. Previously the literal `$(name)` text was emitted into the extracted CSS, breaking the selector at runtime, and a phantom `--var-XXX: <className>` was leaked onto every consumer's inline `style=`. Same-module references now substitute the actual class names (chained for multi-declaration source bindings, e.g. `&.cssA.cssB`); cross-module and unresolved references raise a clear PPX error (@davesnx)
- [BREAKING] Sibling selectors with interpolation that escape the component's subtree (e.g. `& + .$(other)`) now raise a PPX error instead of generating broken CSS (@davesnx)
- [FEATURE] Allow any OCaml/Reason expression inside `$(...)` interpolation, not just identifiers and module paths (#572) (@davesnx)
- [FEATURE] Add `CSS.empty`, `CSS.styles` and `CSS.className` (@davesnx)
- [FEATURE] Support `font-family` interpolation with arrays of font families (@davesnx)
- [FEATURE] Add log levels to `styled-ppx.generate` (`--log error|warning|info|debug`, `--debug`), prefixing all diagnostics with `styled-ppx:` (@davesnx)
- [PERF] Register `&`-local interpolation vars with `@property { syntax: "*"; inherits: false }`, so changing an inline custom property invalidates only the element instead of its whole subtree (up to 25x median style-recalc win on token-heavy pages; degrades gracefully on unsupported browsers) (@davesnx)
- [PERF] Bundle a block's interpolating declarations into a single content-addressed atom, so a value shared across base/`:hover`/`@media` mints one var set once inline instead of one per variant (@davesnx)
- [PERF] Fix quadratic CSS rule accumulation in `[%css]` extraction: rule dedup used an O(n) list scan per emitted rule, making files with many `[%css]` blocks superlinearly slow (~43% faster on a file with 1600 declarations, ~12% on realistic heavy files). Now uses O(1) hash-based membership (@davesnx)
- [FIX] Report interpolation, bare-pseudo, and `@media` prelude errors at their exact source location, with the compiler rendering source excerpts and carets on the offending token (@davesnx)
- [FIX] Generate `makeProps` and a public `make` wrapper for native mode components, fixing `Unbound value X.makeProps` with the new server-reason-react JSX transform (@davesnx)
- [FIX] Ensure `[%css]` works inside `include struct ... end` (@davesnx)
- [FIX] Strip CSS-unsafe characters from atomic class labels: binding names ending in a prime (e.g. `inputView'`) produced unmatchable selectors (@davesnx)
- [FIX] Name interpolation custom properties after their source (`Theme.spacing.md` -> `--spacing-md-<hash>`) instead of the opaque `--var-<hash>` (@davesnx)
- [FIX] Hash atomic classes by main module name instead of file path, so class names are stable across build contexts (@davesnx)
- [DOCS] Rework the documentation website for static extraction: new introduction, "How it works", and dune setup guide; reference pages rewritten around `[%css]`/`CSS.styles`; ReScript pages replaced with a deprecation notice; OCaml examples use mlx syntax (@davesnx)

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
