Non-conditional at-rules under [%css] error instead of extracting broken CSS.

Only conditional group rules (@media, @supports, @container,
@starting-style) can be atomized: their condition distributes over the
block's rules. Everything else used to be torn apart per-declaration:
@font-face split into fragments each missing required descriptors,
@keyframes split into same-name rules where the last clobbered the rest,
@property descriptors got wrapped in a class selector, and blockless
at-rules (@import) vanished silently. These now raise the same errors as
the runtime path (Css_to_runtime.render_at_rule).

  $ standalone --impl input_keyframes.ml -o output.ml
  File "input_keyframes.ml", line 4, characters 17-27:
  Error: @keyframes should be defined with %keyframe(...)
  [1]
  $ standalone --impl input_fontface.ml -o output.ml
  File "input_fontface.ml", line 4, characters 17-27:
  Error: At-rule @font-face is not supported in styled-ppx
  [1]
  $ standalone --impl input_property.ml -o output.ml
  File "input_property.ml", line 3, characters 19-28:
  Error: At-rule @property is not supported in styled-ppx
  [1]
  $ standalone --impl input_import.ml -o output.ml
  File "input_import.ml", line 4, characters 16-23:
  Error: At-rule @import is not supported in styled-ppx
  [1]
