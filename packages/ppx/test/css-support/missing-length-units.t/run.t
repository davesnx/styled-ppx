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
  [@css ".a-ecuveb{width:1cap;}"];
  [@css ".a-ec6gk5{width:2.5cap;}"];
  [@css ".a-ecf708{width:1ic;}"];
  [@css ".a-ecf374{width:3.5ic;}"];
  [@css ".a-ecwc7t{width:1lh;}"];
  [@css ".a-ecqnkz{width:2lh;}"];
  [@css ".a-ec4gax{width:1rcap;}"];
  [@css ".a-ecnmih{width:1rch;}"];
  [@css ".a-ecy0pg{width:1rex;}"];
  [@css ".a-ecmfob{width:1ric;}"];
  [@css ".a-ecnp92{width:1rlh;}"];
  [@css ".a-ecrh49{width:50vb;}"];
  [@css ".a-ecijca{width:50vi;}"];
  [@css ".a-ec0vtm{width:40Q;}"];
  [@css ".a-6l8f82{height:10lh;}"];
  [@css ".a-7pigma{margin:2cap;}"];
  [@css ".a-94h56p{padding:5ic;}"];
  [@css ".a-6500wsmpm{font-size:1.5lh;}"];
  [@css ".a-658jk3fhm{line-height:2rlh;}"];
  
  CSS.make("a-ecuveb", []);
  CSS.make("a-ec6gk5", []);
  
  CSS.make("a-ecf708", []);
  CSS.make("a-ecf374", []);
  
  CSS.make("a-ecwc7t", []);
  CSS.make("a-ecqnkz", []);
  
  CSS.make("a-ec4gax", []);
  
  CSS.make("a-ecnmih", []);
  
  CSS.make("a-ecy0pg", []);
  
  CSS.make("a-ecmfob", []);
  
  CSS.make("a-ecnp92", []);
  
  CSS.make("a-ecrh49", []);
  
  CSS.make("a-ecijca", []);
  
  CSS.make("a-ec0vtm", []);
  
  CSS.make("a-6l8f82", []);
  CSS.make("a-7pigma", []);
  CSS.make("a-94h56p", []);
  CSS.make("a-6500wsmpm", []);
  CSS.make("a-658jk3fhm", []);
