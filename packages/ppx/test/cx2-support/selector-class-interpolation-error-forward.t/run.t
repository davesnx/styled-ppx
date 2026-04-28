Forward references (referencing a [%cx2] binding declared below the
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
  File "input.re", line 2, characters 6-7:
  Error: [%cx2] selector interpolation `$(b)` does not refer to a [%cx2] binding earlier in this module.
  - If `b` is bound to a [%cx2] later in the file, reorder the bindings.
  - If `b` is a plain string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.

  $ dune build
  File "input.re", line 2, characters 6-7:
  Error: [%cx2] selector interpolation `$(b)` does not refer to a [%cx2] binding earlier in this module.
  - If `b` is bound to a [%cx2] later in the file, reorder the bindings.
  - If `b` is a plain string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
