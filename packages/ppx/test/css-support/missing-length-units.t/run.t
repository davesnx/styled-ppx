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
  [@css ".css-ivpc8bb{width:1cap;}"];
  [@css ".css-ivpcuao{width:2.5cap;}"];
  [@css ".css-ivpcfzm{width:1ic;}"];
  [@css ".css-ivpcf7v{width:3.5ic;}"];
  [@css ".css-ivpcgnj{width:1lh;}"];
  [@css ".css-ivpc4t4{width:2lh;}"];
  [@css ".css-ivpc3l9{width:1rcap;}"];
  [@css ".css-ivpcq6x{width:1rch;}"];
  [@css ".css-ivpceuu{width:1rex;}"];
  [@css ".css-ivpck9b{width:1ric;}"];
  [@css ".css-ivpco57{width:1rlh;}"];
  [@css ".css-ivpcfzv{width:50vb;}"];
  [@css ".css-ivpc00f{width:50vi;}"];
  [@css ".css-ivpc7a0{width:40Q;}"];
  [@css ".css-ivpcd8k{height:10lh;}"];
  [@css ".css-ivpcx4a{margin:2cap;}"];
  [@css ".css-ivpci1e{padding:5ic;}"];
  [@css ".css-ivpco1h{font-size:1.5lh;}"];
  [@css ".css-ivpcm03{line-height:2rlh;}"];
  [@css.classes
    [
      ("css-ivpc8bb", 0, "", "input.re", 4, 8, 4, 19),
      ("css-ivpcuao", 1, "", "input.re", 5, 8, 5, 21),
      ("css-ivpcfzm", 2, "", "input.re", 8, 8, 8, 18),
      ("css-ivpcf7v", 3, "", "input.re", 9, 8, 9, 20),
      ("css-ivpcgnj", 4, "", "input.re", 12, 8, 12, 18),
      ("css-ivpc4t4", 5, "", "input.re", 13, 8, 13, 18),
      ("css-ivpc3l9", 6, "", "input.re", 16, 8, 16, 20),
      ("css-ivpcq6x", 7, "", "input.re", 19, 8, 19, 19),
      ("css-ivpceuu", 8, "", "input.re", 22, 8, 22, 19),
      ("css-ivpck9b", 9, "", "input.re", 25, 8, 25, 19),
      ("css-ivpco57", 10, "", "input.re", 28, 8, 28, 19),
      ("css-ivpcfzv", 11, "", "input.re", 31, 8, 31, 19),
      ("css-ivpc00f", 12, "", "input.re", 34, 8, 34, 19),
      ("css-ivpc7a0", 13, "", "input.re", 37, 8, 37, 18),
      ("css-ivpcd8k", 14, "", "input.re", 40, 8, 40, 20),
      ("css-ivpcx4a", 15, "", "input.re", 41, 8, 41, 20),
      ("css-ivpci1e", 16, "", "input.re", 42, 8, 42, 20),
      ("css-ivpco1h", 17, "", "input.re", 43, 8, 43, 24),
      ("css-ivpcm03", 18, "", "input.re", 44, 8, 44, 25),
    ]
  ];
  
  CSS.make("css-ivpc8bb", []);
  CSS.make("css-ivpcuao", []);
  
  CSS.make("css-ivpcfzm", []);
  CSS.make("css-ivpcf7v", []);
  
  CSS.make("css-ivpcgnj", []);
  CSS.make("css-ivpc4t4", []);
  
  CSS.make("css-ivpc3l9", []);
  
  CSS.make("css-ivpcq6x", []);
  
  CSS.make("css-ivpceuu", []);
  
  CSS.make("css-ivpck9b", []);
  
  CSS.make("css-ivpco57", []);
  
  CSS.make("css-ivpcfzv", []);
  
  CSS.make("css-ivpc00f", []);
  
  CSS.make("css-ivpc7a0", []);
  
  CSS.make("css-ivpcd8k", []);
  CSS.make("css-ivpcx4a", []);
  CSS.make("css-ivpci1e", []);
  CSS.make("css-ivpco1h", []);
  CSS.make("css-ivpcm03", []);
