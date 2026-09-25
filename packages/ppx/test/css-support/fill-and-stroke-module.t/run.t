CSS Fill and Stroke Module Level 3 (https://drafts.csswg.org/fill-stroke/):
the 16 fill- and stroke- properties this pass added. input.re carries valid
declarations for all of them (accepted silently); invalid.re carries
fill-origin's grammar (no view-box, unlike <geometry-box>), whose error
names the property.

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
  File "invalid.re", line 1, characters 21-29:
  1 | [%css {|fill-origin: view-box|}];
                           ^^^^^^^^
  Error: Property 'fill-origin' has an invalid value: 'view-box',
         Expected 'border-box', 'content-box', 'fill-box', 'match-parent',
         'padding-box', or 'stroke-box'. Did you mean 'fill-box'?
  [1]
