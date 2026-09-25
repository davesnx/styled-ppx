flow-tolerance (css-grid-3) accepts 'normal', a <length-percentage>, or
'infinite'. input.re carries valid declarations (accepted silently);
invalid.re carries a bare number, whose error names the property.

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
  File "invalid.re", line 1, characters 24-25:
  1 | [%css {|flow-tolerance: 5|}];
                              ^
  Error: Property 'flow-tolerance' has an invalid value: '5',
         Expected 'length', 'percentage', 'calc()', 'clamp()', 'env()',
         'max()', 'min()', 'infinite', etc.
  [1]
