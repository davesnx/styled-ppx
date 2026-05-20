Only literal strings are valid static selector refs. Computed strings are not
registered because their value is not known at PPX time.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  File "input.re", line 2, characters 6-12:
  Error: Selector interpolation `$(marker)` does not refer to a [%cx2] binding or string literal earlier in this module.
  - If `marker` is bound to a [%cx2] or string literal later in the file, reorder the bindings.
  - If `marker` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.

  $ dune build
  File "input.re", line 2, characters 6-12:
  Error: Selector interpolation `$(marker)` does not refer to a [%cx2] binding or string literal earlier in this module.
  - If `marker` is bound to a [%cx2] or string literal later in the file, reorder the bindings.
  - If `marker` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
