window-drag (css-ui-4) accepts 'none' or 'move'. input.re carries valid
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
  File "invalid.re", line 1, characters 21-25:
  1 | [%css {|window-drag: grab|}];
                           ^^^^
  Error: Property 'window-drag' has an invalid value: 'grab',
         Expected 'move' or 'none'.
  [1]
