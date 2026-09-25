scroll-axis-lock (css-overflow-5) accepts 'auto' or 'none'. input.re carries
valid declarations (accepted silently); invalid.re carries an out-of-grammar
keyword, whose error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 26-32:
  1 | [%css {|scroll-axis-lock: smooth|}];
                                ^^^^^^
  Error: Property 'scroll-axis-lock' has an invalid value: 'smooth',
         Expected 'auto' or 'none'.
  [1]
