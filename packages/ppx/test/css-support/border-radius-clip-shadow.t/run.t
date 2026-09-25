CSS Borders and Box Decorations L4 (https://drafts.csswg.org/css-borders-4/):
per-side border radius/clip shorthands, border-limit, and the box-shadow-*
longhands (not yet wired as box-shadow's own reset set). input.re carries
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
  File "invalid.re", line 1, characters 22-30:
  1 | [%css {|border-limit: diagonal|}];
                            ^^^^^^^^
  Error: Property 'border-limit' has an invalid value: 'diagonal',
         Expected 'all', 'bottom', 'corners', 'left', 'right', 'sides', or
         'top'.
  [1]
