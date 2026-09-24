# Changes

## 0.62.0

- [FIX] Hoist `@import` rules, then `@namespace` rules, to the front of `styled-ppx.generate`'s output, regardless of which module or library emitted them, since a browser only honors these rules when they precede every other rule, dependency order routinely places one after plain style rules, and CSS Cascade 5 requires every `@import` to precede every `@namespace`. Statement-form `@layer a, b;` is left where it falls: CSS allows it anywhere in a stylesheet, and hoisting it would change layer order (layer order is first occurrence). Classify by the rendered rule's text (`@import`/`@namespace` prefix, `;` suffix) instead of by the presence of a `{`, since an `@import` URL can itself contain `{`. Drop `@charset` instead, with a warning naming the input file: the generated file always opens with its own leading comment, so `@charset` can never be the literal first bytes of the stylesheet, and the output is UTF-8 regardless (#581) (@davesnx)
- [FEATURE] Mint a build-independent **identity class** (`cid-<hash>`) for every named `[%css]` binding and `[%styled.<tag>]` component, derived from the dune library name (the `library-name` cookie), the module, submodule scope, and binding name (never a physical path), plus an occurrence index when a name repeats within one compilation unit, so same-named modules and bindings in different libraries never share an identity. A `let` named with a `__` prefix, such as the `__incoming` temporary server-reason-react's `styles=` expansion introduces, is not a binding for this purpose: the `[%css]` under it takes the enclosing user binding's name for its label, dev marker and identity. Add PPX flag `--namespace <string>` to override the library-name default, for a native library and its melange twin that build the same sources under different names; the aggregator reports an identity collision, naming both input files, the longident, and the identity, when two different bindings share an identity but not their CSS (@davesnx)
- [BREAKING] `$(binding)` and `&.$(binding)` selector references now resolve to the referenced binding's identity class, one class regardless of how many atoms (or none) it minted, instead of a dot-chain of its atomized classes such as `.cssA.cssB`. A referenced multi-atom binding drops from `(0,N,0)` to `(0,1,0)` specificity inside the compound selector. An empty named binding (`let m = [%css {||}]`) now keeps its identity under `--minify` too, fixing a bug where `&.$(m)` silently lost its qualifier in production (@davesnx)
- [BREAKING] Class names are `css-<hash(content)>` in every mode; the binding's `let` name no longer appears in the class name, so two bindings with byte-identical declarations now mint the same class and dedup to one rule. `--minify` only strips CSS whitespace and no longer affects class names. Dev-mode `label:<binding>` marker classes are now on by default, for `[%css]` bindings and `[%styled.<tag>]` components alike (keyed off the component's module name); `--minify` and `--env production` turn them off, and `--dev` forces them back on regardless (@davesnx)
- [FEATURE] Add PPX flag `--env development|production`. `development` enables `--dev` marker classes; `production` enables `--minify` and disables markers (@davesnx)
- [FIX] Parse the Selectors Level 4 `An+B of S` form of `:nth-child()`/`:nth-last-child()` (`:nth-child(2n+1 of .x)`), and functional pseudo-elements such as `::part(foo)` and `::slotted(.bar)`. The lexer only special-cased `nth-*` names for An+B payloads and gave every other identifier followed by `(` a generic function token that `::`-parsing never handled, so both forms hit a raw parse error; the renderer already had support for the "of S" AST shape, just not a parser path to it (@davesnx)
- [FIX] Accept CSS Nesting's relative-selector shorthand in a nested rule's prelude: `.parent { > .child {} }`, `+ .sib {}` and `~ .sib {}` resolve exactly like `& > .child`. The root of `[%css]`, `[%styled.global]` and a raw stylesheet still rejects a leading combinator, and `[%styled.global]` now also rejects one inside an at-rule block with no enclosing style rule (`@media print { > .a {} }`), the same way it rejects a parentless `&`, instead of shipping unresolved `&` (@davesnx)
- [FIX] Report correct error locations for `[%css]`, `[%styled.*]`, `[%styled.global]` and `[%keyframe]` strings in `.ml` files. The ppx always skipped the opening quote or `{id|` to find the string's content, but OCaml's lexer (unlike Reason's) already starts the string's location at the content, so every location in a `.ml` file was shifted right by the delimiter's width: one column for `"..."`, two for `{|...|}`. For example, `[%css "@import 'x.css';"]` pointed past the `@` (@davesnx)
- [FIX] Stop a style rule's selector location from including the whitespace between the selector and what follows it (`{`, `,`, or end of prelude). `&:hover { color: red; }`'s error location for `&:hover` covered `&:hover ` with the trailing space, one character wider than the selector itself (@davesnx)
- [FEATURE] Register the css-fonts-5 metric-override descriptors `ascent-override`, `descent-override`, `line-gap-override` (each `normal | <percentage>`), and `size-adjust` (`<percentage>`), so a valid `@font-face` block declaring them compiles instead of failing with an unknown-descriptor error (#580) (@davesnx)
- [FIX] Reject the `@font-face`-only descriptors (`src`, `unicode-range`, `font-display`, `ascent-override`, `descent-override`, `line-gap-override`, `size-adjust`) in any declaration outside an `@font-face` block. `.title { ascent-override: 90%; }` previously compiled and emitted a descriptor browsers ignore; it now fails with `Descriptor 'ascent-override' is only valid inside @font-face`. The reverse holds too: an `@font-face` body accepts descriptors only, so `@font-face { color: red; }` fails with `Property 'color' is not a @font-face descriptor` (@davesnx)
- [FIX] Lex an escaped identifier into its canonical CSS spelling instead of the decoded text. The lexer decoded `\31 a` to `1a` and dropped the escape, so `.\31 a { color: red; }` (class `1a`) rendered as the invalid `.1a{...}`, and `.a\.b { color: red; }` (one class named `a.b`) rendered as `.a.b{...}` — two classes, changing what the selector matches with no error at all. Every identifier token (class, id, type selector, attribute, pseudo-class, custom property name, custom ident, dimension unit) now re-escapes per CSSOM `serialize an identifier` as it is lexed; a hash that does not start an identifier (`#123456`) is a color and keeps its decoded text (@davesnx)
- [FIX] Parse statement at-rules by what follows their prelude instead of a fixed name list, so `@layer a, b;` and any future statement at-rule work in `[%styled.global]`; the one-token `AT_RULE_STATEMENT` is gone. Trailing whitespace in a statement prelude is trimmed, so `@import "x.css" ;` renders as `@import "x.css";` (@davesnx)
- [FIX] Make `clamp()` and `env()` reachable from `<length>` and `<percentage>` values (`width: clamp(10px, 5vw, 100px)`, `padding-top: env(safe-area-inset-top)`), not just registered as standalone functions. `Extended_length`/`Extended_percentage` enumerated `calc()`/`min()`/`max()` but omitted their peers, rejecting every property built on them; extend `Extended_angle`, `Extended_time`, `Extended_time_no_interp`, and `Extended_frequency` with `clamp()` too for the same reason. Also fix `env()`'s own grammar, which required a literal `,` even with no fallback value, rejecting the common `env(name)` form used by every real safe-area-inset call (@davesnx)
- [FIX] Accept `var(--x,)` and `var(--x, )`, an explicitly empty fallback, which css-variables-1 defines as a valid, meaningful zero-length value distinct from omitting the fallback entirely (`var(--x)`). `var()`'s fallback grammar wrapped the comma and `<declaration-value>` in one optional group, and `<declaration-value>` itself requires at least one token, so an empty fallback made the whole group's atomic match fail and left the comma unconsumed, rejecting the value outright; a fallback with a comma inside it (`var(--x, a, b)`) was unaffected. The comma is now its own required token once a fallback is present, wrapping only `<declaration-value>` as independently optional, so an empty fallback renders back out with the comma preserved (@davesnx)
- [FIX] Lex a signed number whose sign is directly followed by a decimal point, with no leading digit (`-.5px`, `+.5s`), instead of crashing the whole PPX with an uncaught `Failure("float_of_string")`. `consume_number` only matched a sign together with at least one following digit, so it consumed nothing for this spelling and produced an empty number representation (@davesnx)
- [FIX] The parser drops leading and trailing whitespace from a declaration's value, so the renderer, the autoprefixer and the validator all see the same value. A declaration terminated by `}` or end of input with a source-level space before the terminator (`{ display: flex }`) now renders and hashes identically to the same declaration terminated by `;` (`{ display: flex; }`); previously the two rendered as `display:flex;` and `display:flex ;`, minting distinct classes for byte-identical CSS. The autoprefixer no longer skips the `-webkit-grab` / `fit-content` prefixes for such a value, and a css-wide keyword no longer bypasses the property-name check (`colr:inherit;` is now an error) (@davesnx)
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
- [FEATURE] Order `styled-ppx.generate`'s output by module dependency by default: a module's rules now come after the rules of every module it depends on, instead of by input file order alone, so a consumer's rule reliably beats its dependency's rule regardless of file naming. Add `--order dependency|source` (default `dependency`; `source` restores the previous file-order behavior). `--log info` prints the resolved module order and `--log debug` the dependency edges (@davesnx)
- [FEATURE] Add a library level to `styled-ppx.generate`'s default `--order dependency`: a library's rules now come after the rules of every library it depends on (grouped by the `library` key dune's `library-name` cookie records in `[@@@css.config]`, or by directory when that key is absent), with PR 1's module order applying unchanged inside each library. `--log info` prints the resolved library order and each library's module order; `--log debug` additionally prints the library-level dependency edges (@davesnx)
- [FEATURE] Add `--layers` to `styled-ppx.generate` (default off; requires `--order dependency`): wraps each library's rules in a named `@layer`, in the same dependency order as the default output, so the same precedence survives when a page links several aggregator outputs. `@property` and `@keyframes` rules stay outside every layer as global registrations, and a group with no rule left to wrap (a module without `[%css]`, a registration-only library) gets no layer. Off by default because an unlayered rule always beats a layered one, so a consumer must layer its own hand-written CSS first (@davesnx)
- [PERF] Register interpolation variables read only by `&` with `@property { syntax: "*"; inherits: false }`, limiting style invalidation to that element. The targeted benchmark measured up to a 25x median style-recalculation improvement; unsupported browsers retain the previous inherited behavior (@davesnx)
- [PERF] Bundle a block's interpolated declarations into one content-addressed atom, so a value reused by base, `:hover`, or `@media` rules creates one inline variable instead of one per variant (@davesnx)
- [PERF] Replace linear rule-deduplication scans with hash-based membership. This makes extraction about 43% faster for 1,600 declarations and about 12% faster on realistic heavy files (@davesnx)
- [FIX] Stop the opam package from installing repository-only executables: `standalone`, `rewriter`, `ppx-native-test-runner`, `as_standalone`, `ast-renderer`, `lexer-renderer`, `spec-renderer`, and `demo-exe` (@davesnx)
- [FIX] Resolve class interpolation in selectors such as `&.$(other)`, `:not(&.$(other))`, and `:has(.$(other))` to extracted classes instead of emitting literal `$(...)` text and phantom inline variables. References in the same compilation unit resolve in the PPX; cross-module references resolve in `styled-ppx.generate` when their files are included. Missing and cross-library references report located errors (@davesnx)
- [FIX] Fix compiler crashes when parsing legacy `-webkit-gradient(...)` and `-webkit-mask-box-image` values whose internal registry references omitted the leading dash. A registry-closure check now validates grammar lookups with the same key derivation as generated parsers (@davesnx)
- [FIX] Parse `:nth-*()` An+B syntax correctly, including uppercase forms, `n-3`, and `2n- 3`. Invalid units, fractional or oversized coefficients, and malformed payloads now produce located errors instead of truncation or `Failure("int_of_string")` crashes (@davesnx)
- [FIX] Report invalid UTF-8 in CSS payloads at the offending byte instead of crashing with `Sedlexing.MalFormed` (@davesnx)
- [FIX] Hoist `@import` then `@namespace` statement at-rules before style rules while preserving each kind's relative order; statement-form `@layer` is left in place instead, since CSS allows it anywhere and hoisting it would change layer order (@davesnx)
- [FIX] Point interpolation, bare-pseudo, and `@media` prelude errors at the offending source token, with compiler excerpts and carets (@davesnx)
- [FIX] Generate `makeProps` and a public `make` wrapper for native components, fixing `Unbound value X.makeProps` with the new server-reason-react JSX transform (@davesnx)
- [FIX] Pin server-reason-react to 82c52e8a so `styles=` on an element that already has an optional `?className` or `?style` type-checks and merges the classes (@davesnx)
- [FIX] Support `[%css]` inside `include struct ... end` (@davesnx)
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
