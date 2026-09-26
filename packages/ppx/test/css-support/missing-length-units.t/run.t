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
  [@css "._a_6500wsmpm{font-size:1.5lh;}"];
  [@css "._a_658jk3fhm{line-height:2rlh;}"];
  
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
  CSS.make("_a_6500wsmpm", []);
  CSS.make("_a_658jk3fhm", []);
