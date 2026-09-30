Layout/sizing slice of 140 standards-track/preview properties, across
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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_g72k91{max-size:100px;}"];
  [@css "._a_g7o8qx{max-size:100px 50px;}"];
  [@css "._a_g9z1wa{min-size:auto;}"];
  [@css "._a_g92f9q{min-size:10px 20px;}"];
  [@css "._a_g8tgfk{min-intrinsic-sizing:legacy;}"];
  [@css "._a_g86fqb{min-intrinsic-sizing:zero-if-scroll;}"];
  [@css "._a_g8jrij{min-intrinsic-sizing:zero-if-scroll zero-if-extrinsic;}"];
  [@css "._a_gyjxpg{wrap-flow:minimum;}"];
  [@css "._a_h0ahj7{wrap-through:none;}"];
  [@css "._a_g5n5yv{margin-break:keep;}"];
  [@css "._a_f2008myq3{block-step-size:none;}"];
  [@css "._a_f2002gz9k{block-step-insert:content-box;}"];
  [@css "._a_f2001kywn{block-step-align:center;}"];
  [@css "._a_f2004jjp9{block-step-round:nearest;}"];
  [@css "._a_f2stl1{block-step:10px content-box center up;}"];
  [@css "._a_fy64xq{initial-letter-wrap:grid;}"];
  [@css "._a_fzl4el{inline-sizing:stretch;}"];
  [@css "._a_g1x0ci{line-fit-edge:cap alphabetic;}"];
  [@css "._a_g2v01o{line-grid:create;}"];
  [@css "._a_g4l7fm{line-snap:contain;}"];
  [@css "._a_fh23yj{box-snap:last-baseline;}"];
  [@css "._a_f8c3iu{border-boundary:parent;}"];
  [@css "._a_geq7gh{shape-inside:circle() border-box;}"];
  
  CSS.make("_a_g72k91", []);
  CSS.make("_a_g7o8qx", []);
  CSS.make("_a_g9z1wa", []);
  CSS.make("_a_g92f9q", []);
  CSS.make("_a_g8tgfk", []);
  CSS.make("_a_g86fqb", []);
  CSS.make("_a_g8jrij", []);
  
  CSS.make("_a_gyjxpg", []);
  CSS.make("_a_h0ahj7", []);
  
  CSS.make("_a_g5n5yv", []);
  
  CSS.make("_a_f2008myq3", []);
  CSS.make("_a_f2002gz9k", []);
  CSS.make("_a_f2001kywn", []);
  CSS.make("_a_f2004jjp9", []);
  CSS.make("_a_f2stl1", []);
  
  CSS.make("_a_fy64xq", []);
  CSS.make("_a_fzl4el", []);
  CSS.make("_a_g1x0ci", []);
  
  CSS.make("_a_g2v01o", []);
  CSS.make("_a_g4l7fm", []);
  CSS.make("_a_fh23yj", []);
  
  CSS.make("_a_f8c3iu", []);
  CSS.make("_a_geq7gh", []);
