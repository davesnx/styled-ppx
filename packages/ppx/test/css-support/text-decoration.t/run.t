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
  [@css ".a-1hstiaf{text-decoration-line:none;}"];
  [@css ".a-h5jo7l{text-decoration-line:underline;}"];
  [@css ".a-ai7jjn{text-decoration-line:overline;}"];
  [@css ".a-c3aj5y{text-decoration-line:line-through;}"];
  [@css ".a-b04p93{text-decoration-line:underline overline;}"];
  [@css ".a-volvj2{text-decoration-color:white;}"];
  [@css ".a-17nde1x{text-decoration-style:solid;}"];
  [@css ".a-i63bb0{text-decoration-style:double;}"];
  [@css ".a-gzu23a{text-decoration-style:dotted;}"];
  [@css ".a-11w89xg{text-decoration-style:dashed;}"];
  [@css ".a-zebza7{text-decoration-style:wavy;}"];
  [@css ".a-fr7kvy{text-underline-position:auto;}"];
  [@css ".a-fjhfys{text-underline-position:under;}"];
  [@css ".a-ns2wu2{text-underline-position:left;}"];
  [@css ".a-1hhdp26{text-underline-position:right;}"];
  [@css ".a-1mis52a{text-underline-position:under left;}"];
  [@css ".a-7in9dq{text-underline-position:under right;}"];
  [@css ".a-oviqil{text-emphasis-style:none;}"];
  [@css ".a-1kyj2pl{text-emphasis-style:filled;}"];
  [@css ".a-dlg7ob{text-emphasis-style:open;}"];
  [@css ".a-1kyeeq5{text-emphasis-style:dot;}"];
  [@css ".a-rg2qxn{text-emphasis-style:circle;}"];
  [@css ".a-8rnz0y{text-emphasis-style:double-circle;}"];
  [@css ".a-1funiuc{text-emphasis-style:triangle;}"];
  [@css ".a-9243n{text-emphasis-style:sesame;}"];
  [@css ".a-1wr3653{text-emphasis-style:open dot;}"];
  [@css ".a-uii345{text-emphasis-style:\"foo\";}"];
  [@css ".a-1ps7yre{text-emphasis-color:green;}"];
  [@css ".a-1gm1xtr{text-emphasis:open dot green;}"];
  [@css ".a-1r11nl6{text-emphasis-position:over;}"];
  [@css ".a-x7dg2o{text-emphasis-position:under;}"];
  [@css ".a-ohd4dg{text-emphasis-position:over left;}"];
  [@css ".a-15nsz24{text-emphasis-position:over right;}"];
  [@css ".a-eywejo{text-emphasis-position:under left;}"];
  [@css ".a-e1ux8j{text-emphasis-position:left under;}"];
  [@css ".a-9is7qc{text-emphasis-position:under right;}"];
  [@css ".a-1f9ql9z{text-shadow:none;}"];
  [@css ".a-18sychj{text-shadow:1px 1px;}"];
  [@css ".a-sho2mi{text-shadow:0 0 black;}"];
  [@css ".a-14uqa7n{text-shadow:1px 2px 3px;}"];
  [@css ".a-qlj1j4{text-shadow:1px 2px 3px black;}"];
  [@css ".a-180bx5y{text-shadow:1px 1px, 2px 2px red;}"];
  [@css ".a-jw7zpt{text-shadow:1px 2px 3px black, 0 0 5px white;}"];
  [@css ".a-83xjle{text-decoration-skip:none;}"];
  [@css ".a-h2hh35{text-decoration-skip:objects;}"];
  [@css ".a-uql9gi{text-decoration-skip:objects spaces;}"];
  [@css ".a-k2jofb{text-decoration-skip:objects leading-spaces;}"];
  [@css ".a-1ya5tpa{text-decoration-skip:objects trailing-spaces;}"];
  [@css
    ".a-1itl3dj{text-decoration-skip:objects leading-spaces trailing-spaces;}"
  ];
  [@css
    ".a-1j6wwzb{text-decoration-skip:objects leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".a-81j747{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".a-jdqqvz{text-decoration-skip:objects edges;}"];
  [@css ".a-163jnz3{text-decoration-skip:objects box-decoration;}"];
  [@css ".a-dpnj6l{text-decoration-skip:spaces;}"];
  [@css ".a-1kylxfd{text-decoration-skip:spaces edges;}"];
  [@css ".a-vkealr{text-decoration-skip:spaces edges box-decoration;}"];
  [@css ".a-1549jre{text-decoration-skip:spaces box-decoration;}"];
  [@css ".a-dtf8ym{text-decoration-skip:leading-spaces;}"];
  [@css
    ".a-18cupg8{text-decoration-skip:leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".a-ebs8vu{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".a-1cyty82{text-decoration-skip:edges;}"];
  [@css ".a-r6xscz{text-decoration-skip:edges box-decoration;}"];
  [@css ".a-1xkedkd{text-decoration-skip:box-decoration;}"];
  [@css ".a-1ctq7y7{text-decoration-skip-ink:none;}"];
  [@css ".a-1191soe{text-decoration-skip-ink:auto;}"];
  [@css ".a-1eh2f09{text-decoration-skip-ink:all;}"];
  [@css ".a-113fdf1{text-decoration-skip-box:none;}"];
  [@css ".a-1o4djmk{text-decoration-skip-box:all;}"];
  [@css ".a-pp3yi9{text-decoration-skip-inset:none;}"];
  [@css ".a-jl0g23{text-decoration-skip-inset:auto;}"];
  [@css ".a-1s8jicj{text-underline-offset:auto;}"];
  [@css ".a-1kxlgvj{text-underline-offset:3px;}"];
  [@css ".a-len22j{text-underline-offset:10%;}"];
  [@css ".a-hjssta{text-decoration-thickness:auto;}"];
  [@css ".a-1vyyh8i{text-decoration-thickness:from-font;}"];
  [@css ".a-1f5jw5c{text-decoration-thickness:3px;}"];
  [@css ".a-1novgf0{text-decoration-thickness:10%;}"];
  
  CSS.make("a-1hstiaf", []);
  CSS.make("a-h5jo7l", []);
  CSS.make("a-ai7jjn", []);
  CSS.make("a-c3aj5y", []);
  CSS.make("a-b04p93", []);
  CSS.make("a-volvj2", []);
  CSS.make("a-17nde1x", []);
  CSS.make("a-i63bb0", []);
  CSS.make("a-gzu23a", []);
  CSS.make("a-11w89xg", []);
  CSS.make("a-zebza7", []);
  CSS.make("a-fr7kvy", []);
  CSS.make("a-fjhfys", []);
  CSS.make("a-ns2wu2", []);
  CSS.make("a-1hhdp26", []);
  CSS.make("a-1mis52a", []);
  CSS.make("a-7in9dq", []);
  CSS.make("a-oviqil", []);
  CSS.make("a-1kyj2pl", []);
  CSS.make("a-dlg7ob", []);
  CSS.make("a-1kyeeq5", []);
  CSS.make("a-rg2qxn", []);
  CSS.make("a-8rnz0y", []);
  CSS.make("a-1funiuc", []);
  CSS.make("a-9243n", []);
  CSS.make("a-1wr3653", []);
  CSS.make("a-uii345", []);
  CSS.make("a-1ps7yre", []);
  CSS.make("a-1gm1xtr", []);
  
  CSS.make("a-1r11nl6", []);
  CSS.make("a-x7dg2o", []);
  CSS.make("a-ohd4dg", []);
  CSS.make("a-15nsz24", []);
  CSS.make("a-eywejo", []);
  CSS.make("a-e1ux8j", []);
  CSS.make("a-9is7qc", []);
  
  CSS.make("a-1f9ql9z", []);
  
  CSS.make("a-18sychj", []);
  
  CSS.make("a-sho2mi", []);
  
  CSS.make("a-14uqa7n", []);
  
  CSS.make("a-qlj1j4", []);
  
  CSS.make("a-180bx5y", []);
  CSS.make("a-jw7zpt", []);
  
  CSS.make("a-83xjle", []);
  CSS.make("a-h2hh35", []);
  CSS.make("a-uql9gi", []);
  CSS.make("a-k2jofb", []);
  CSS.make("a-1ya5tpa", []);
  CSS.make("a-1itl3dj", []);
  CSS.make("a-1j6wwzb", []);
  CSS.make("a-81j747", []);
  CSS.make("a-jdqqvz", []);
  CSS.make("a-163jnz3", []);
  CSS.make("a-dpnj6l", []);
  CSS.make("a-1kylxfd", []);
  CSS.make("a-vkealr", []);
  CSS.make("a-1549jre", []);
  CSS.make("a-dtf8ym", []);
  CSS.make("a-18cupg8", []);
  CSS.make("a-ebs8vu", []);
  CSS.make("a-1cyty82", []);
  CSS.make("a-r6xscz", []);
  CSS.make("a-1xkedkd", []);
  CSS.make("a-1ctq7y7", []);
  CSS.make("a-1191soe", []);
  CSS.make("a-1eh2f09", []);
  CSS.make("a-113fdf1", []);
  CSS.make("a-1o4djmk", []);
  CSS.make("a-pp3yi9", []);
  CSS.make("a-jl0g23", []);
  CSS.make("a-1s8jicj", []);
  CSS.make("a-1kxlgvj", []);
  CSS.make("a-len22j", []);
  CSS.make("a-hjssta", []);
  CSS.make("a-1vyyh8i", []);
  CSS.make("a-1f5jw5c", []);
  CSS.make("a-1novgf0", []);
