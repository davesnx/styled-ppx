CSS Page Floats (https://drafts.csswg.org/css-page-floats/): float-reference,
float-defer, float-offset. input.re carries valid declarations (accepted
silently); invalid.re carries an out-of-grammar keyword, whose error names
the property.

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
  File "invalid.re", line 1, characters 25-30:
  1 | [%css {|float-reference: block|}];
                               ^^^^^
  Error: Property 'float-reference' has an invalid value: 'block',
         Expected 'column', 'inline', 'page', or 'region'.
  [1]
