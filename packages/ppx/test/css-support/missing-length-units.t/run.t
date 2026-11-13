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
  [@css ".css-hxk8bb{width:1cap;}"];
  [@css ".css-uveuao{width:2.5cap;}"];
  [@css ".css-zuffzm{width:1ic;}"];
  [@css ".css-3ggf7v{width:3.5ic;}"];
  [@css ".css-13pkgnj{width:1lh;}"];
  [@css ".css-eyi4t4{width:2lh;}"];
  [@css ".css-tr43l9{width:1rcap;}"];
  [@css ".css-jn3q6x{width:1rch;}"];
  [@css ".css-1h7deuu{width:1rex;}"];
  [@css ".css-189ok9b{width:1ric;}"];
  [@css ".css-t69o57{width:1rlh;}"];
  [@css ".css-emfzv{width:50vb;}"];
  [@css ".css-pbs00f{width:50vi;}"];
  [@css ".css-5gt7a0{width:40Q;}"];
  [@css ".css-1odqd8k{height:10lh;}"];
  [@css ".css-yp8x4a{margin:2cap;}"];
  [@css ".css-aw6i1e{padding:5ic;}"];
  [@css ".css-dxho1h{font-size:1.5lh;}"];
  [@css ".css-vaum03{line-height:2rlh;}"];
  [@css.classes
    [
      ("css-hxk8bb", 0, "", "input.re", 4, 8, 4, 19),
      ("css-uveuao", 1, "", "input.re", 5, 8, 5, 21),
      ("css-zuffzm", 2, "", "input.re", 8, 8, 8, 18),
      ("css-3ggf7v", 3, "", "input.re", 9, 8, 9, 20),
      ("css-13pkgnj", 4, "", "input.re", 12, 8, 12, 18),
      ("css-eyi4t4", 5, "", "input.re", 13, 8, 13, 18),
      ("css-tr43l9", 6, "", "input.re", 16, 8, 16, 20),
      ("css-jn3q6x", 7, "", "input.re", 19, 8, 19, 19),
      ("css-1h7deuu", 8, "", "input.re", 22, 8, 22, 19),
      ("css-189ok9b", 9, "", "input.re", 25, 8, 25, 19),
      ("css-t69o57", 10, "", "input.re", 28, 8, 28, 19),
      ("css-emfzv", 11, "", "input.re", 31, 8, 31, 19),
      ("css-pbs00f", 12, "", "input.re", 34, 8, 34, 19),
      ("css-5gt7a0", 13, "", "input.re", 37, 8, 37, 18),
      ("css-1odqd8k", 14, "", "input.re", 40, 8, 40, 20),
      ("css-yp8x4a", 15, "", "input.re", 41, 8, 41, 20),
      ("css-aw6i1e", 16, "", "input.re", 42, 8, 42, 20),
      ("css-dxho1h", 17, "", "input.re", 43, 8, 43, 24),
      ("css-vaum03", 18, "", "input.re", 44, 8, 44, 25),
    ]
  ];
  
  CSS.make("css-hxk8bb", []);
  CSS.make("css-uveuao", []);
  
  CSS.make("css-zuffzm", []);
  CSS.make("css-3ggf7v", []);
  
  CSS.make("css-13pkgnj", []);
  CSS.make("css-eyi4t4", []);
  
  CSS.make("css-tr43l9", []);
  
  CSS.make("css-jn3q6x", []);
  
  CSS.make("css-1h7deuu", []);
  
  CSS.make("css-189ok9b", []);
  
  CSS.make("css-t69o57", []);
  
  CSS.make("css-emfzv", []);
  
  CSS.make("css-pbs00f", []);
  
  CSS.make("css-5gt7a0", []);
  
  CSS.make("css-1odqd8k", []);
  CSS.make("css-yp8x4a", []);
  CSS.make("css-aw6i1e", []);
  CSS.make("css-dxho1h", []);
  CSS.make("css-vaum03", []);
