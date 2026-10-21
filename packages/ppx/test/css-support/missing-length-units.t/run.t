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
  [@css "._a_ecuveb{width:1cap;}"];
  [@css "._a_ec6gk5{width:2.5cap;}"];
  [@css "._a_ecf708{width:1ic;}"];
  [@css "._a_ecf374{width:3.5ic;}"];
  [@css "._a_ecwc7t{width:1lh;}"];
  [@css "._a_ecqnkz{width:2lh;}"];
  [@css "._a_ec4gax{width:1rcap;}"];
  [@css "._a_ecnmih{width:1rch;}"];
  [@css "._a_ecy0pg{width:1rex;}"];
  [@css "._a_ecmfob{width:1ric;}"];
  [@css "._a_ecnp92{width:1rlh;}"];
  [@css "._a_ecrh49{width:50vb;}"];
  [@css "._a_ecijca{width:50vi;}"];
  [@css "._a_ec0vtm{width:40Q;}"];
  [@css "._a_6l8f82{height:10lh;}"];
  [@css "._a_7pigma{margin:2cap;}"];
  [@css "._a_94h56p{padding:5ic;}"];
  [@css "._a_65000wsmpm{font-size:1.5lh;}"];
  [@css "._a_65b8jk3fhm{line-height:2rlh;}"];
  [@css.blocks
    [
      (4, "_a_ecuveb"),
      (5, "_a_ec6gk5"),
      (8, "_a_ecf708"),
      (9, "_a_ecf374"),
      (12, "_a_ecwc7t"),
      (13, "_a_ecqnkz"),
      (16, "_a_ec4gax"),
      (19, "_a_ecnmih"),
      (22, "_a_ecy0pg"),
      (25, "_a_ecmfob"),
      (28, "_a_ecnp92"),
      (31, "_a_ecrh49"),
      (34, "_a_ecijca"),
      (37, "_a_ec0vtm"),
      (40, "_a_6l8f82"),
      (41, "_a_7pigma"),
      (42, "_a_94h56p"),
      (43, "_a_65000wsmpm"),
      (44, "_a_65b8jk3fhm"),
    ]
  ];
  
  CSS.make("_a_ecuveb", []);
  CSS.make("_a_ec6gk5", []);
  
  CSS.make("_a_ecf708", []);
  CSS.make("_a_ecf374", []);
  
  CSS.make("_a_ecwc7t", []);
  CSS.make("_a_ecqnkz", []);
  
  CSS.make("_a_ec4gax", []);
  
  CSS.make("_a_ecnmih", []);
  
  CSS.make("_a_ecy0pg", []);
  
  CSS.make("_a_ecmfob", []);
  
  CSS.make("_a_ecnp92", []);
  
  CSS.make("_a_ecrh49", []);
  
  CSS.make("_a_ecijca", []);
  
  CSS.make("_a_ec0vtm", []);
  
  CSS.make("_a_6l8f82", []);
  CSS.make("_a_7pigma", []);
  CSS.make("_a_94h56p", []);
  CSS.make("_a_65000wsmpm", []);
  CSS.make("_a_65b8jk3fhm", []);
