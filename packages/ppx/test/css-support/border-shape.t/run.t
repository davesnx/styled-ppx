border-shape (css-borders-4) accepts 'none' or one or two <basic-shape>
[<geometry-box>]? groups. input.re carries a valid declaration (accepted
silently); invalid.re carries an out-of-grammar value, whose error names
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
  File "invalid.re", line 1, characters 22-26:
  1 | [%css {|border-shape: 12px|}];
                            ^^^^
  Error: Property 'border-shape' has an invalid value: '12px',
         Expected 'circle()', 'ellipse()', 'inset()', 'path()', 'polygon()', or
         'none'.
  [1]
