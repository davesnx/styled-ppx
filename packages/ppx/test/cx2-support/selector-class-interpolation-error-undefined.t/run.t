A selector ref that doesn't resolve to a [%cx2] binding errors clearly.

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
  File "input.re", line 2, characters 6-15:
  Error: [%cx2] selector interpolation `$(undefined)` does not refer to a [%cx2] binding earlier in this module.
  - If `undefined` is bound to a [%cx2] later in the file, reorder the bindings.
  - If `undefined` is a plain string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.

  $ dune build
  File "input.re", line 2, characters 6-15:
  Error: [%cx2] selector interpolation `$(undefined)` does not refer to a [%cx2] binding earlier in this module.
  - If `undefined` is bound to a [%cx2] later in the file, reorder the bindings.
  - If `undefined` is a plain string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
