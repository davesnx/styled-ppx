This test ensures the ppx reports correct locations for genuine `.ml` input
(as opposed to `.re` input parsed by Reason's lexer): OCaml's lexer sets a
string literal's location differently, so the offset that skips past the
opening delimiter to reach the content must account for that.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Delimited string, error on the string's own (first) line.

  $ cat >input.ml <<'EOF'
  > [%css {|display: blocki;|}]
  > EOF

  $ dune build
  File "input.ml", line 1, characters 17-23:
  1 | [%css {|display: blocki;|}]
                       ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]

Delimited string, error on a later line.

  $ cat >input.ml <<'EOF'
  > [%css {|
  >     width: 100%;
  >     display: blocki;
  > |}]
  > EOF

  $ dune build
  File "input.ml", line 3, characters 13-19:
  3 |     display: blocki;
                   ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]

Plain double-quoted string.

  $ cat >input.ml <<'EOF'
  > [%css "display: blocki;"]
  > EOF

  $ dune build
  File "input.ml", line 1, characters 16-22:
  1 | [%css "display: blocki;"]
                      ^^^^^^
  Error: Property 'display' has an invalid value: 'blocki',
         Expected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid',
         'inline', 'inline-block', etc. Did you mean 'block'?
  [1]
