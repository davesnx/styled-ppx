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
  File "input.re", line 6, characters 10-18:
  Error: Property 'color' has an invalid value: 'cositas',
         Expected 'function color-mix'. Got 'cositas' instead.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  let selectors =
    CSS.style([|
      CSS.label("selectors"),
      CSS.color(CSS.white),
      CSS.selectorMany(
        [|{js|&:hover|js}|],
        [|
          [%ocaml.error
            "Property 'color' has an invalid value: 'cositas',\nExpected 'function color-mix'. Got 'cositas' instead."
          ],
        |],
      ),
    |]);

[%cx {js|display: blocki;              width: 10px; |js}];
