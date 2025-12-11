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
  1 |  [%cx "display: blocki;"];
                      ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx "width: 100%; display: blocki;"];
  > EOF

  $ dune build
  File "input.re", line 1, characters 29-35:
  1 |  [%cx "width: 100%; display: blocki;"];
                                   ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx "
  >      width: 100%; display: blocki;
  >  "];
  > EOF

  $ dune build
  File "input.re", line 2, characters 27-33:
  2 |      width: 100%; display: blocki;
                                 ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx "
  >      width: 100%;
  >      display: blocki;
  >  "];
  > EOF

  $ dune build
  File "input.re", line 3, characters 14-20:
  3 |      display: blocki;
                    ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]
