An empty named `[%css {||}]` binding mints only its identity class - no
atoms, so no `[@@@css ...]` rule is emitted for it (there is nothing to
write). This holds under every mode, including `--minify`.

Before identity classes, an empty binding's class was `css-<hash-of-empty>-<label>`
(`Css_file.mint_empty_class`), and the label was dropped under `--minify`
(`Settings.Get.minify()`), so the mint returned `[]` and a consumer's
`&.$(marker)` had nothing to resolve to - the qualifier silently vanished
from the extracted selector. The identity is independent of `--minify`
(and of the label generally), so this can no longer happen.

  $ refmt --parse re --print ml input.re > input.ml

  $ ../../standalone.exe --impl input.ml -o dev.ml
  $ grep "css" dev.ml
  [@@@css.bindings [("Input.marker", "id-1rctcrz", "")]]

  $ ../../standalone.exe --minify --impl input.ml -o prod.ml
  $ grep "css" prod.ml
  [@@@css.config [("env", "production")]]
  [@@@css.bindings [("Input.marker", "id-1rctcrz", "")]]
