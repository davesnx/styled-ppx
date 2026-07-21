Non-conditional at-rules under [%css] error instead of extracting broken CSS.

Only conditional group rules (@media, @supports, @container,
@starting-style) can be atomized: their condition distributes over the
block's rules. Everything else used to be torn apart per-declaration:
@font-face split into fragments each missing required descriptors,
@keyframes split into same-name rules where the last clobbered the rest,
@property descriptors got wrapped in a class selector, and blockless
at-rules (@import) vanished silently. These now raise errors instead.

  $ ../../../standalone.exe --impl input_keyframes.ml -o output.ml
  File "input_keyframes.ml", line 4, characters 17-27:
  4 | let kf = [%css "@keyframes spin { from { opacity: 0; } to { opacity: 1; } }"]
                       ^^^^^^^^^^
  Error: @keyframes has a dedicated extension. Define the animation separately with `let spin = [%keyframe {|from { } to { }|}]` and reference it with `animation-name: $(spin)`.
  [1]
  $ ../../../standalone.exe --impl input_fontface.ml -o output.ml
  File "input_fontface.ml", line 4, characters 17-27:
  4 | let ff = [%css "@font-face { font-family: Foo; src: url(/foo.woff2); }"]
                       ^^^^^^^^^^
  Error: @font-face defines descriptors, not styles for this class, so it cannot live inside [%css]. Move it to a [%styled.global] block, where it passes through with its descriptors validated.
  [1]
  $ ../../../standalone.exe --impl input_property.ml -o output.ml
  File "input_property.ml", line 3, characters 19-28:
  3 | let prop = [%css "@property --my-color { syntax: '<color>'; inherits: false; }"]
                         ^^^^^^^^^
  Error: @property defines descriptors, not styles for this class, so it cannot live inside [%css]. Move it to a [%styled.global] block, where it passes through with its descriptors validated.
  [1]
  $ ../../../standalone.exe --impl input_import.ml -o output.ml
  File "input_import.ml", line 4, characters 16-23:
  4 | let x = [%css "@import 'x.css';"]
                      ^^^^^^^
  Error: @import is a stylesheet-level statement, not styles for this class, so it cannot live inside [%css]. Move it to a [%styled.global] block; the aggregator hoists it to the top of the generated stylesheet.
  [1]
  $ ../../../standalone.exe --impl input_typo.ml -o output.ml
  File "input_typo.ml", line 3, characters 16-22:
  3 | let x = [%css "@meida (min-width: 600px) { color: red; }"]
                      ^^^^^^
  Error: At-rule @meida is not supported inside [%css]. Did you mean `@media`? Supported here: @media, @supports, @container, @starting-style, and block-form @layer. Descriptor and stylesheet-level at-rules belong in [%styled.global].
  [1]
