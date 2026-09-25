CSS Spatial Navigation L1 (spatial-navigation-contain/-action/-function),
CSS Form Control Styling L1 (input-security, slider-orientation), CSS Image
Animation L1 (image-animation). input.re carries valid declarations
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
  File "invalid.re", line 1, characters 28-36:
  1 | [%css {|slider-orientation: vertical|}];
                                  ^^^^^^^^
  Error: Property 'slider-orientation' has an invalid value:
         'vertical',
         Expected 'auto', 'bottom-to-top', 'left-to-right', 'right-to-left', or
         'top-to-bottom'.
  [1]
