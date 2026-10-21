line-padding, text-group-align, white-space-trim, wrap-before, wrap-after,
wrap-inside, text-emphasis-skip, and marker-side - 9 standards-track,
unimplemented properties (css-text-4, css-text-decor-4, css-lists-3).
input.re carries valid declarations for all of them (accepted silently);
invalid.re carries an out-of-grammar keyword, whose error names the
property.

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
  1 | [%css {|text-group-align: middle|}];
                                ^^^^^^
  Error: Property 'text-group-align' has an invalid value: 'middle',
         Expected 'center', 'end', 'left', 'none', 'right', or 'start'.
  [1]
