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

  $ cat >input.re <<EOF
  >  [%cx "display: blocki;"];
  > EOF

  $ dune build
  File "input.re", line 1, characters 16-22:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'ident -moz-inline-box' but instead got 'ident blocki'.
  [1]

  $ cat >input.re <<EOF
  >  [%cx "width: 100%; display: blocki;"];
  > EOF

  $ dune build
  File "input.re", line 1, characters 29-35:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'ident -moz-inline-box' but instead got 'ident blocki'.
  [1]

  $ cat >input.re <<EOF
  >  [%cx "
  >      width: 100%; display: blocki;
  >  "];
  > EOF

  $ dune build
  File "input.re", line 2, characters 27-33:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'ident -moz-inline-box' but instead got 'ident blocki'.
  [1]

  $ cat >input.re <<EOF
  >  [%cx "
  >      width: 100%;
  >      display: blocki;
  >  "];
  > EOF

  $ dune build
  File "input.re", line 3, characters 14-20:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'ident -moz-inline-box' but instead got 'ident blocki'.
  [1]
