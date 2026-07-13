Forward references (referencing a [%css] binding declared below the
current site) error cleanly. Users can fix by reordering bindings.

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
  File "input.re", line 8, characters 6-7:
  8 |   &.$(b) { color: red; }
            ^
  Error: Selector interpolation `$(b)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `b` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `b` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.

  $ dune build
  File "input.re", line 8, characters 6-7:
  8 |   &.$(b) { color: red; }
            ^
  Error: Selector interpolation `$(b)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `b` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `b` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
