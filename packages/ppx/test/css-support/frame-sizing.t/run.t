frame-sizing (css-sizing-4) accepts 'auto', 'content-width', 'content-height',
'content-block-size', or 'content-inline-size'. input.re carries valid
declarations (accepted silently); invalid.re carries an out-of-grammar
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
  File "invalid.re", line 1, characters 22-27:
  1 | [%css {|frame-sizing: cover|}];
                            ^^^^^
  Error: Property 'frame-sizing' has an invalid value: 'cover',
         Expected 'auto', 'content-block-size', 'content-height',
         'content-inline-size', or 'content-width'.
  [1]
