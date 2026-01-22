# Changes

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
