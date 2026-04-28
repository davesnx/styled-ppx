Cross-module selector interpolation must error with a clear message
pointing at the workaround.

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
  File "input.re", line 2, characters 6-25:
  Error: [%cx2] selector interpolation `$(SomeOtherModule.foo)` references another module.
  Static CSS extraction can only resolve same-module bindings.
  Inline the rules into this [%cx2] block, or use [%cx] for runtime substitution.

  $ dune build
  File "input.re", line 2, characters 6-25:
  Error: [%cx2] selector interpolation `$(SomeOtherModule.foo)` references another module.
  Static CSS extraction can only resolve same-module bindings.
  Inline the rules into this [%cx2] block, or use [%cx] for runtime substitution.
  [1]
