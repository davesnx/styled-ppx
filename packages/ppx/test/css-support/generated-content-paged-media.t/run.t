CSS Generated Content L3 (bookmark-label, bookmark-level, bookmark-state,
string-set) and CSS Generated Content for Paged Media (running,
footnote-display, footnote-policy). input.re carries valid declarations
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
  File "invalid.re", line 1, characters 24-30:
  1 | [%css {|bookmark-state: hidden|}];
                              ^^^^^^
  Error: Property 'bookmark-state' has an invalid value: 'hidden',
         Expected 'closed' or 'open'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_f3iw93{bookmark-label:\"Chapter\";}"];
  [@css "._a_f31cv3{bookmark-label:counter(chapter);}"];
  [@css "._a_f4gtar{bookmark-level:none;}"];
  [@css "._a_f43uz1{bookmark-level:2;}"];
  [@css "._a_f5gcl2{bookmark-state:open;}"];
  [@css "._a_f5tdnk{bookmark-state:closed;}"];
  [@css "._a_gjnekd{string-set:none;}"];
  [@css "._a_gjkcpd{string-set:header \"Chapter One\";}"];
  [@css "._a_gj4i6x{string-set:header \"Chapter One\", footer \"Page\";}"];
  [@css "._a_gd5t9y{running:none;}"];
  [@css "._a_gdmemd{running:myHeader;}"];
  [@css "._a_fvhh3d{footnote-display:block;}"];
  [@css "._a_fvt121{footnote-display:inline;}"];
  [@css "._a_fvqnac{footnote-display:compact;}"];
  [@css "._a_fwgn0m{footnote-policy:auto;}"];
  [@css "._a_fwpoa2{footnote-policy:line;}"];
  [@css "._a_fw06l6{footnote-policy:block;}"];
  
  CSS.make("_a_f3iw93", []);
  CSS.make("_a_f31cv3", []);
  CSS.make("_a_f4gtar", []);
  CSS.make("_a_f43uz1", []);
  CSS.make("_a_f5gcl2", []);
  CSS.make("_a_f5tdnk", []);
  CSS.make("_a_gjnekd", []);
  CSS.make("_a_gjkcpd", []);
  CSS.make("_a_gj4i6x", []);
  CSS.make("_a_gd5t9y", []);
  CSS.make("_a_gdmemd", []);
  CSS.make("_a_fvhh3d", []);
  CSS.make("_a_fvt121", []);
  CSS.make("_a_fvqnac", []);
  CSS.make("_a_fwgn0m", []);
  CSS.make("_a_fwpoa2", []);
  CSS.make("_a_fw06l6", []);
