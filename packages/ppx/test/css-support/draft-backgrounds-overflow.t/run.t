CSS Backgrounds Module Level 4 and CSS Overflow Module Level 4 draft
properties (https://drafts.csswg.org/css-backgrounds-4/,
https://drafts.csswg.org/css-overflow-4/). input.re carries valid
declarations for every property this slice added (accepted silently);
invalid.re carries an out-of-grammar value, whose error names the property.

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
  File "invalid.re", line 1, characters 34-39:
  1 | [%css {|overflow-clip-margin-top: solid|}];
                                        ^^^^^
  Error: Property 'overflow-clip-margin-top' has an invalid value:
         'solid',
         Expected a valid value.
  [1]
