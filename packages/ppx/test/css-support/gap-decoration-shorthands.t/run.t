CSS Gaps Module Level 1 (https://drafts.csswg.org/css-gaps-1/): row-rule,
column-rule additions, and rule. input.re carries valid declarations for
every property this pass added (accepted silently); invalid.re carries an
out-of-grammar value inside a repeat() list, whose error names the property.

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
  File "invalid.re", line 6, characters 27-42:
  6 | [%css {|column-rule-color: repeat(2, 10px)|}];
                                 ^^^^^^^^^^^^^^^
  Error: Property 'column-rule-color' has an invalid value: 'repeat(2,
         10px)',
         Expected 'hex-color', 'color()', 'color-mix()', 'hsl()', 'hsla()',
         'hwb()', 'lab()', 'lch()', etc.
  [1]
