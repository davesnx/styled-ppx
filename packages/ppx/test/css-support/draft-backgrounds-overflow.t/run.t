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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_ex97cq{background-position-block:center;}"];
  [@css "._a_exfkc3{background-position-block:start 10px;}"];
  [@css "._a_exkn1d{background-position-block:end 10%, center;}"];
  [@css "._a_eyx7rh{background-position-inline:start;}"];
  [@css "._a_ezg63m{background-repeat-block:repeat;}"];
  [@css "._a_ezm66o{background-repeat-block:space, round;}"];
  [@css "._a_f0mlxf{background-repeat-inline:no-repeat;}"];
  [@css "._a_8vfpxw{overflow-clip-margin:5px;}"];
  [@css "._a_8vc69b{overflow-clip-margin:padding-box;}"];
  [@css "._a_8vup3k{overflow-clip-margin:content-box 10px;}"];
  [@css "._a_8v008dgxj{overflow-clip-margin-top:5px;}"];
  [@css "._a_8v004wyzd{overflow-clip-margin-right:border-box 2px;}"];
  [@css "._a_8v0010ibw{overflow-clip-margin-bottom:0px;}"];
  [@css "._a_8v00240bh{overflow-clip-margin-left:padding-box;}"];
  [@css "._a_ga0025an2{overflow-clip-margin-block-start:5px;}"];
  [@css "._a_ga0012eib{overflow-clip-margin-block-end:5px;}"];
  [@css "._a_gb0021f55{overflow-clip-margin-inline-start:5px;}"];
  [@css "._a_gb0013esx{overflow-clip-margin-inline-end:5px;}"];
  [@css "._a_gavvhs{overflow-clip-margin-block:5px;}"];
  [@css "._a_gbd98n{overflow-clip-margin-inline:border-box;}"];
  [@css "._a_f1l93q{block-ellipsis:auto;}"];
  [@css "._a_f16sd1{block-ellipsis:no-ellipsis;}"];
  [@css "._a_f1c6p5{block-ellipsis:\"...\";}"];
  [@css "._a_fiwojc{continue:auto;}"];
  [@css "._a_fiqcek{continue:discard;}"];
  [@css "._a_fi7h91{continue:collapse;}"];
  
  CSS.make("_a_ex97cq", []);
  CSS.make("_a_exfkc3", []);
  CSS.make("_a_exkn1d", []);
  CSS.make("_a_eyx7rh", []);
  CSS.make("_a_ezg63m", []);
  CSS.make("_a_ezm66o", []);
  CSS.make("_a_f0mlxf", []);
  
  CSS.make("_a_8vfpxw", []);
  CSS.make("_a_8vc69b", []);
  CSS.make("_a_8vup3k", []);
  CSS.make("_a_8v008dgxj", []);
  CSS.make("_a_8v004wyzd", []);
  CSS.make("_a_8v0010ibw", []);
  CSS.make("_a_8v00240bh", []);
  CSS.make("_a_ga0025an2", []);
  CSS.make("_a_ga0012eib", []);
  CSS.make("_a_gb0021f55", []);
  CSS.make("_a_gb0013esx", []);
  CSS.make("_a_gavvhs", []);
  CSS.make("_a_gbd98n", []);
  CSS.make("_a_f1l93q", []);
  CSS.make("_a_f16sd1", []);
  CSS.make("_a_f1c6p5", []);
  CSS.make("_a_fiwojc", []);
  CSS.make("_a_fiqcek", []);
  CSS.make("_a_fi7h91", []);
