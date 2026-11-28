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
  [@css ".css-ivpcua3{line-clamp:none;}"];
  [@css ".css-ivpc3d9{line-clamp:1;}"];
  [@css ".css-ivpcesp{max-lines:none;}"];
  [@css ".css-ivpc88m{max-lines:1;}"];
  [@css ".css-ivpc4qp{overflow-x:visible;}"];
  [@css ".css-ivpcnv3{overflow-x:hidden;}"];
  [@css ".css-ivpcgl2{overflow-x:clip;}"];
  [@css ".css-ivpcybg{overflow-x:scroll;}"];
  [@css ".css-ivpcglo{overflow-x:auto;}"];
  [@css ".css-ivpc0ov{overflow-y:visible;}"];
  [@css ".css-ivpcjef{overflow-y:hidden;}"];
  [@css ".css-ivpcijk{overflow-y:clip;}"];
  [@css ".css-ivpcdgp{overflow-y:scroll;}"];
  [@css ".css-ivpcfbq{overflow-y:auto;}"];
  [@css ".css-ivpc4fe{overflow-inline:visible;}"];
  [@css ".css-ivpce0t{overflow-inline:hidden;}"];
  [@css ".css-ivpcfyp{overflow-inline:clip;}"];
  [@css ".css-ivpchxu{overflow-inline:scroll;}"];
  [@css ".css-ivpcian{overflow-inline:auto;}"];
  [@css ".css-ivpcd2n{overflow-block:visible;}"];
  [@css ".css-ivpca4x{overflow-block:hidden;}"];
  [@css ".css-ivpc03u{overflow-block:clip;}"];
  [@css ".css-ivpcqhx{overflow-block:scroll;}"];
  [@css ".css-ivpckq6{overflow-block:auto;}"];
  [@css ".css-ivpcwl1{scrollbar-gutter:auto;}"];
  [@css ".css-ivpcbkp{scrollbar-gutter:stable;}"];
  [@css ".css-ivpcd1x{scrollbar-gutter:both-edges stable;}"];
  [@css ".css-ivpcsqn{scrollbar-gutter:stable both-edges;}"];
  [@css ".css-ivpc8v2{overflow-clip-margin:content-box;}"];
  [@css ".css-ivpci9o{overflow-clip-margin:padding-box;}"];
  [@css ".css-ivpc4xd{overflow-clip-margin:border-box;}"];
  [@css ".css-ivpcp5h{overflow-clip-margin:20px;}"];
  [@css ".css-ivpc1zv{overflow-clip-margin:1em;}"];
  [@css ".css-ivpcjmv{overflow-clip-margin:content-box 5px;}"];
  [@css ".css-ivpcmub{overflow-clip-margin:5px content-box;}"];
  [@css.classes
    [
      ("css-ivpcua3", 0, "", "input.re", 2, 8, 2, 24),
      ("css-ivpc3d9", 1, "", "input.re", 3, 8, 3, 21),
      ("css-ivpcesp", 2, "", "input.re", 6, 8, 6, 23),
      ("css-ivpc88m", 3, "", "input.re", 7, 8, 7, 20),
      ("css-ivpc4qp", 4, "", "input.re", 8, 8, 8, 27),
      ("css-ivpcnv3", 5, "", "input.re", 9, 8, 9, 26),
      ("css-ivpcgl2", 6, "", "input.re", 10, 8, 10, 24),
      ("css-ivpcybg", 7, "", "input.re", 11, 8, 11, 26),
      ("css-ivpcglo", 8, "", "input.re", 12, 8, 12, 24),
      ("css-ivpc0ov", 9, "", "input.re", 13, 8, 13, 27),
      ("css-ivpcjef", 10, "", "input.re", 14, 8, 14, 26),
      ("css-ivpcijk", 11, "", "input.re", 15, 8, 15, 24),
      ("css-ivpcdgp", 12, "", "input.re", 16, 8, 16, 26),
      ("css-ivpcfbq", 13, "", "input.re", 17, 8, 17, 24),
      ("css-ivpc4fe", 14, "", "input.re", 18, 8, 18, 32),
      ("css-ivpce0t", 15, "", "input.re", 19, 8, 19, 31),
      ("css-ivpcfyp", 16, "", "input.re", 20, 8, 20, 29),
      ("css-ivpchxu", 17, "", "input.re", 21, 8, 21, 31),
      ("css-ivpcian", 18, "", "input.re", 22, 8, 22, 29),
      ("css-ivpcd2n", 19, "", "input.re", 23, 8, 23, 31),
      ("css-ivpca4x", 20, "", "input.re", 24, 8, 24, 30),
      ("css-ivpc03u", 21, "", "input.re", 25, 8, 25, 28),
      ("css-ivpcqhx", 22, "", "input.re", 26, 8, 26, 30),
      ("css-ivpckq6", 23, "", "input.re", 27, 8, 27, 28),
      ("css-ivpcwl1", 24, "", "input.re", 28, 8, 28, 30),
      ("css-ivpcbkp", 25, "", "input.re", 29, 8, 29, 32),
      ("css-ivpcd1x", 26, "", "input.re", 30, 8, 30, 43),
      ("css-ivpcsqn", 27, "", "input.re", 31, 8, 31, 43),
      ("css-ivpc8v2", 28, "", "input.re", 32, 8, 32, 41),
      ("css-ivpci9o", 29, "", "input.re", 33, 8, 33, 41),
      ("css-ivpc4xd", 30, "", "input.re", 34, 8, 34, 40),
      ("css-ivpcp5h", 31, "", "input.re", 35, 8, 35, 34),
      ("css-ivpc1zv", 32, "", "input.re", 36, 8, 36, 33),
      ("css-ivpcjmv", 33, "", "input.re", 37, 8, 37, 45),
      ("css-ivpcmub", 34, "", "input.re", 38, 8, 38, 45),
    ]
  ];
  
  CSS.make("css-ivpcua3", []);
  CSS.make("css-ivpc3d9", []);
  
  CSS.make("css-ivpcesp", []);
  CSS.make("css-ivpc88m", []);
  CSS.make("css-ivpc4qp", []);
  CSS.make("css-ivpcnv3", []);
  CSS.make("css-ivpcgl2", []);
  CSS.make("css-ivpcybg", []);
  CSS.make("css-ivpcglo", []);
  CSS.make("css-ivpc0ov", []);
  CSS.make("css-ivpcjef", []);
  CSS.make("css-ivpcijk", []);
  CSS.make("css-ivpcdgp", []);
  CSS.make("css-ivpcfbq", []);
  CSS.make("css-ivpc4fe", []);
  CSS.make("css-ivpce0t", []);
  CSS.make("css-ivpcfyp", []);
  CSS.make("css-ivpchxu", []);
  CSS.make("css-ivpcian", []);
  CSS.make("css-ivpcd2n", []);
  CSS.make("css-ivpca4x", []);
  CSS.make("css-ivpc03u", []);
  CSS.make("css-ivpcqhx", []);
  CSS.make("css-ivpckq6", []);
  CSS.make("css-ivpcwl1", []);
  CSS.make("css-ivpcbkp", []);
  CSS.make("css-ivpcd1x", []);
  CSS.make("css-ivpcsqn", []);
  CSS.make("css-ivpc8v2", []);
  CSS.make("css-ivpci9o", []);
  CSS.make("css-ivpc4xd", []);
  CSS.make("css-ivpcp5h", []);
  CSS.make("css-ivpc1zv", []);
  CSS.make("css-ivpcjmv", []);
  CSS.make("css-ivpcmub", []);
