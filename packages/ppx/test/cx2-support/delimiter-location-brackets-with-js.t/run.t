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
  >  [%cx2 {|display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 17-24:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]

  $ cat >input.re <<EOF
  >  [%cx2 {|width: 100%; display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 30-37:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]

  $ cat >input.re <<EOF
  >  [%cx2 {|
  >      width: 100%; display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 2, characters 26-33:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]

  $ cat >input.re <<EOF
  >  [%cx2 {|
  >      width: 100%;
  >      display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 3, characters 13-20:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]
