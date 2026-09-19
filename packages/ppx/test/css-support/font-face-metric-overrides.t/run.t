@font-face metric-override descriptors (ascent-override, descent-override,
line-gap-override, size-adjust) are validated the same way as every other
css-fonts-5 descriptor. input.re carries a valid block (accepted silently);
invalid.re carries an out-of-grammar value, whose error names the descriptor.

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
  File "invalid.re", line 8, characters 20-25:
  8 |     ascent-override: 12px;
                          ^^^^^
  Error: Property 'ascent-override' has an invalid value: '12px',
         Expected 'percentage' or 'normal'.
  [1]
