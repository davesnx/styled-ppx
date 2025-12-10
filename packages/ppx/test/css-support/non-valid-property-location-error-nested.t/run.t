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

  $ dune build
  File "input.re", line 5, characters 21-31:
    | .........
    | 
  5 | ..........{
  5 |     colo........
  Error: Unknown property 'colorx'
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  let selectors =
    CSS.style([|
      CSS.label("selectors"),
      CSS.color(CSS.white),
      CSS.selectorMany(
        [|{js|&:hover|js}|],
        [|[%ocaml.error "Unknown property 'colorx'"]|],
      ),
    |]);

[%cx {js|display: blocki;              width: 10px; |js}];
