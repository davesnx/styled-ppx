Cross-module reference whose target binding exists but is not a [%cx2]
expression — here, a plain string. The synthetic `let _ = M.marker` line
type-checks (the value exists), but the aggregator's index only collects
`CSS.make` calls, so the resolution fails with the same shape as a
missing binding.

  $ refmt --parse re --print ml m.re > m.ml
  $ standalone --impl m.ml -o m.ml
  $ refmt --parse re --print ml n.re > n.ml
  $ standalone --impl n.ml -o n.ml

  $ styled-ppx.generate m.ml n.ml
  File "n.ml", line 2, characters 6-14:
  Error: cross-library [%cx2] selector references are not supported.
  The reference `M.marker` resolves to module `M` which is not part of the
  current library. Move the [%cx2] binding into the current library, or
  inline the class chain literally.
  [1]
