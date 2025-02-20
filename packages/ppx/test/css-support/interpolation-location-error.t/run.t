This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

This test ensures the location of the error is correct
  $ dune build
  File "input.re", line 2, characters 25-32:
  Error: This expression has type [> `gri ]
         but an expression was expected of type Css_types.Display.t
         The second variant type does not allow tag(s) `gri
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  let grid = `gri;
  let a = CSS.style([|CSS.label("a"), (CSS.display(grid): CSS.rule)|]);
