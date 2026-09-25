This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".a-cf002tiaf{text-decoration-line:none;}"];
  [@css ".a-cf002jo7l{text-decoration-line:underline;}"];
  [@css ".a-cf0027jjn{text-decoration-line:overline;}"];
  [@css ".a-cf002aj5y{text-decoration-line:line-through;}"];
  [@css ".a-cf0024p93{text-decoration-line:underline overline;}"];
  [@css ".a-cf001lvj2{text-decoration-color:white;}"];
  [@css ".a-cf004de1x{text-decoration-style:solid;}"];
  [@css ".a-cf0043bb0{text-decoration-style:double;}"];
  [@css ".a-cf004u23a{text-decoration-style:dotted;}"];
  [@css ".a-cf00489xg{text-decoration-style:dashed;}"];
  [@css ".a-cf004bza7{text-decoration-style:wavy;}"];
  [@css ".a-d37kvy{text-underline-position:auto;}"];
  [@css ".a-d3hfys{text-underline-position:under;}"];
  [@css ".a-d32wu2{text-underline-position:left;}"];
  [@css ".a-d3dp26{text-underline-position:right;}"];
  [@css ".a-d3s52a{text-underline-position:under left;}"];
  [@css ".a-d3n9dq{text-underline-position:under right;}"];
  [@css ".a-co002iqil{text-emphasis-style:none;}"];
  [@css ".a-co002j2pl{text-emphasis-style:filled;}"];
  [@css ".a-co002g7ob{text-emphasis-style:open;}"];
  [@css ".a-co002eeq5{text-emphasis-style:dot;}"];
  [@css ".a-co0022qxn{text-emphasis-style:circle;}"];
  [@css ".a-co002nz0y{text-emphasis-style:double-circle;}"];
  [@css ".a-co002niuc{text-emphasis-style:triangle;}"];
  [@css ".a-co002243n{text-emphasis-style:sesame;}"];
  [@css ".a-co0023653{text-emphasis-style:open dot;}"];
  [@css ".a-co002i345{text-emphasis-style:\"foo\";}"];
  [@css ".a-co0017yre{text-emphasis-color:green;}"];
  [@css ".a-co1xtr{text-emphasis:open dot green;}"];
  [@css ".a-cp1nl6{text-emphasis-position:over;}"];
  [@css ".a-cpdg2o{text-emphasis-position:under;}"];
  [@css ".a-cpd4dg{text-emphasis-position:over left;}"];
  [@css ".a-cpsz24{text-emphasis-position:over right;}"];
  [@css ".a-cpwejo{text-emphasis-position:under left;}"];
  [@css ".a-cpux8j{text-emphasis-position:left under;}"];
  [@css ".a-cps7qc{text-emphasis-position:under right;}"];
  [@css ".a-cyql9z{text-shadow:none;}"];
  [@css ".a-cyychj{text-shadow:1px 1px;}"];
  [@css ".a-cyo2mi{text-shadow:0 0 black;}"];
  [@css ".a-cyqa7n{text-shadow:1px 2px 3px;}"];
  [@css ".a-cyj1j4{text-shadow:1px 2px 3px black;}"];
  [@css ".a-cybx5y{text-shadow:1px 1px, 2px 2px red;}"];
  [@css ".a-cy7zpt{text-shadow:1px 2px 3px black, 0 0 5px white;}"];
  [@css ".a-chxjle{text-decoration-skip:none;}"];
  [@css ".a-chhh35{text-decoration-skip:objects;}"];
  [@css ".a-chl9gi{text-decoration-skip:objects spaces;}"];
  [@css ".a-chjofb{text-decoration-skip:objects leading-spaces;}"];
  [@css ".a-ch5tpa{text-decoration-skip:objects trailing-spaces;}"];
  [@css
    ".a-chl3dj{text-decoration-skip:objects leading-spaces trailing-spaces;}"
  ];
  [@css
    ".a-chwwzb{text-decoration-skip:objects leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".a-chj747{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".a-chqqvz{text-decoration-skip:objects edges;}"];
  [@css ".a-chjnz3{text-decoration-skip:objects box-decoration;}"];
  [@css ".a-chnj6l{text-decoration-skip:spaces;}"];
  [@css ".a-chlxfd{text-decoration-skip:spaces edges;}"];
  [@css ".a-chealr{text-decoration-skip:spaces edges box-decoration;}"];
  [@css ".a-ch9jre{text-decoration-skip:spaces box-decoration;}"];
  [@css ".a-chf8ym{text-decoration-skip:leading-spaces;}"];
  [@css ".a-chupg8{text-decoration-skip:leading-spaces trailing-spaces edges;}"];
  [@css
    ".a-chs8vu{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".a-chty82{text-decoration-skip:edges;}"];
  [@css ".a-chxscz{text-decoration-skip:edges box-decoration;}"];
  [@css ".a-chedkd{text-decoration-skip:box-decoration;}"];
  [@css ".a-cjq7y7{text-decoration-skip-ink:none;}"];
  [@css ".a-cj1soe{text-decoration-skip-ink:auto;}"];
  [@css ".a-cj2f09{text-decoration-skip-ink:all;}"];
  [@css ".a-cifdf1{text-decoration-skip-box:none;}"];
  [@css ".a-cidjmk{text-decoration-skip-box:all;}"];
  [@css ".a-ck3yi9{text-decoration-skip-inset:none;}"];
  [@css ".a-ck0g23{text-decoration-skip-inset:auto;}"];
  [@css ".a-d2jicj{text-underline-offset:auto;}"];
  [@css ".a-d2lgvj{text-underline-offset:3px;}"];
  [@css ".a-d2n22j{text-underline-offset:10%;}"];
  [@css ".a-cf008ssta{text-decoration-thickness:auto;}"];
  [@css ".a-cf008yh8i{text-decoration-thickness:from-font;}"];
  [@css ".a-cf008jw5c{text-decoration-thickness:3px;}"];
  [@css ".a-cf008vgf0{text-decoration-thickness:10%;}"];
  
  CSS.make("a-cf002tiaf", []);
  CSS.make("a-cf002jo7l", []);
  CSS.make("a-cf0027jjn", []);
  CSS.make("a-cf002aj5y", []);
  CSS.make("a-cf0024p93", []);
  CSS.make("a-cf001lvj2", []);
  CSS.make("a-cf004de1x", []);
  CSS.make("a-cf0043bb0", []);
  CSS.make("a-cf004u23a", []);
  CSS.make("a-cf00489xg", []);
  CSS.make("a-cf004bza7", []);
  CSS.make("a-d37kvy", []);
  CSS.make("a-d3hfys", []);
  CSS.make("a-d32wu2", []);
  CSS.make("a-d3dp26", []);
  CSS.make("a-d3s52a", []);
  CSS.make("a-d3n9dq", []);
  CSS.make("a-co002iqil", []);
  CSS.make("a-co002j2pl", []);
  CSS.make("a-co002g7ob", []);
  CSS.make("a-co002eeq5", []);
  CSS.make("a-co0022qxn", []);
  CSS.make("a-co002nz0y", []);
  CSS.make("a-co002niuc", []);
  CSS.make("a-co002243n", []);
  CSS.make("a-co0023653", []);
  CSS.make("a-co002i345", []);
  CSS.make("a-co0017yre", []);
  CSS.make("a-co1xtr", []);
  
  CSS.make("a-cp1nl6", []);
  CSS.make("a-cpdg2o", []);
  CSS.make("a-cpd4dg", []);
  CSS.make("a-cpsz24", []);
  CSS.make("a-cpwejo", []);
  CSS.make("a-cpux8j", []);
  CSS.make("a-cps7qc", []);
  
  CSS.make("a-cyql9z", []);
  
  CSS.make("a-cyychj", []);
  
  CSS.make("a-cyo2mi", []);
  
  CSS.make("a-cyqa7n", []);
  
  CSS.make("a-cyj1j4", []);
  
  CSS.make("a-cybx5y", []);
  CSS.make("a-cy7zpt", []);
  
  CSS.make("a-chxjle", []);
  CSS.make("a-chhh35", []);
  CSS.make("a-chl9gi", []);
  CSS.make("a-chjofb", []);
  CSS.make("a-ch5tpa", []);
  CSS.make("a-chl3dj", []);
  CSS.make("a-chwwzb", []);
  CSS.make("a-chj747", []);
  CSS.make("a-chqqvz", []);
  CSS.make("a-chjnz3", []);
  CSS.make("a-chnj6l", []);
  CSS.make("a-chlxfd", []);
  CSS.make("a-chealr", []);
  CSS.make("a-ch9jre", []);
  CSS.make("a-chf8ym", []);
  CSS.make("a-chupg8", []);
  CSS.make("a-chs8vu", []);
  CSS.make("a-chty82", []);
  CSS.make("a-chxscz", []);
  CSS.make("a-chedkd", []);
  CSS.make("a-cjq7y7", []);
  CSS.make("a-cj1soe", []);
  CSS.make("a-cj2f09", []);
  CSS.make("a-cifdf1", []);
  CSS.make("a-cidjmk", []);
  CSS.make("a-ck3yi9", []);
  CSS.make("a-ck0g23", []);
  CSS.make("a-d2jicj", []);
  CSS.make("a-d2lgvj", []);
  CSS.make("a-d2n22j", []);
  CSS.make("a-cf008ssta", []);
  CSS.make("a-cf008yh8i", []);
  CSS.make("a-cf008jw5c", []);
  CSS.make("a-cf008vgf0", []);
