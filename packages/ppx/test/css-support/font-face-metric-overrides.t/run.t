@font-face metric-override descriptors (ascent-override, descent-override,
line-gap-override, size-adjust) are validated the same way as every other
css-fonts-5 descriptor. input.re carries a valid block (accepted silently);
invalid.re carries an out-of-grammar value, whose error names the descriptor.
outside_global.re and outside_css.re use a descriptor in a regular style rule
and in a [%css] block: descriptors are only valid inside @font-face. inside.re
puts an ordinary property in an @font-face body, which takes descriptors only.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid outside_global outside_css inside)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build ./input.exe ./invalid.exe
  File "invalid.re", line 8, characters 20-25:
  8 |     ascent-override: 12px;
                          ^^^^^
  Error: Property 'ascent-override' has an invalid value: '12px',
         Expected 'percentage' or 'normal'.
  [1]

  $ dune build ./outside_global.exe
  File "outside_global.re", line 7, characters 4-19:
  7 |     ascent-override: 90%;
          ^^^^^^^^^^^^^^^
  Error: Descriptor 'ascent-override' is only valid inside @font-face
  [1]

  $ dune build ./outside_css.exe
  File "outside_css.re", line 6, characters 2-13:
  6 |   size-adjust: 100%;
        ^^^^^^^^^^^
  Error: Descriptor 'size-adjust' is only valid inside @font-face
  [1]

  $ dune build ./inside.exe
  File "inside.re", line 8, characters 4-9:
  8 |     color: red;
          ^^^^^
  Error: Property 'color' is not a @font-face descriptor
  [1]
