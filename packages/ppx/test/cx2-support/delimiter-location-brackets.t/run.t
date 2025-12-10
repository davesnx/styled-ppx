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
  >  [%cx {js|display: blocki;|js}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 15-21:
  1 |  [%cx {js|display: blocki;|js}];
                     ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {js|width: 100%; display: blocki;|js}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 28-34:
  1 |  [%cx {js|width: 100%; display: blocki;|js}];
                                  ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {js|
  >      width: 100%; display: blocki;
  >  |js}];
  > EOF

  $ dune build
  File "input.re", line 2, characters 33-39:
  1 | .........
  2 | .......................ay: bl.....
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {js|
  >      width: 100%;
  >      display: blocki;
  >  |js}];
  > EOF

  $ dune build
  File "input.re", line 3, characters 20-26:
  2 | .........
  3 | ..........ay: bl.....
  Error: Property 'display' has an invalid value: 'blocki'
  [1]
