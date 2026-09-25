Layout/sizing slice of task 2's 140 standards-track/preview properties, across
7 small specs (CSS Box Sizing L4, CSS Exclusions L1, CSS Fragmentation L4,
CSS Rhythmic Sizing L1, CSS Inline Layout L3, CSS Line Grid L1, CSS Round
Display L1). input.re carries valid declarations for every property added
(accepted silently); invalid.re carries an out-of-grammar keyword, whose
error names the property.

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
  File "invalid.re", line 1, characters 30-36:
  1 | [%css {|min-intrinsic-sizing: always|}];
                                    ^^^^^^
  Error: Property 'min-intrinsic-sizing' has an invalid value:
         'always',
         Expected 'legacy'.
  [1]
