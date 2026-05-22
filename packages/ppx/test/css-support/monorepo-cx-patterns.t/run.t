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
  File "input.re", line 4, characters 2-9:
  Error: Bare leading pseudo selector `:hover` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> :hover`), which matches descendants rather than the element itself. Write `&:hover` for compound (`<parent>:hover`, the usual intent), or `& :hover` to opt into the explicit descendant form.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  File "input.re", line 4, characters 2-9:
  Error: Bare leading pseudo selector `:hover` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> :hover`), which matches descendants rather than the element itself. Write `&:hover` for compound (`<parent>:hover`, the usual intent), or `& :hover` to opt into the explicit descendant form.
