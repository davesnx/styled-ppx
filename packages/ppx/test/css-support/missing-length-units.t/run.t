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
  [@css ".a-6tuveb{width:1cap;}"];
  [@css ".a-xh6gk5{width:2.5cap;}"];
  [@css ".a-1auf708{width:1ic;}"];
  [@css ".a-1muf374{width:3.5ic;}"];
  [@css ".a-1tdwc7t{width:1lh;}"];
  [@css ".a-d4qnkz{width:2lh;}"];
  [@css ".a-1z04gax{width:1rcap;}"];
  [@css ".a-13ynmih{width:1rch;}"];
  [@css ".a-1joy0pg{width:1rex;}"];
  [@css ".a-151mfob{width:1ric;}"];
  [@css ".a-1xmnp92{width:1rlh;}"];
  [@css ".a-16nrh49{width:50vb;}"];
  [@css ".a-cgijca{width:50vi;}"];
  [@css ".a-1ef0vtm{width:40Q;}"];
  [@css ".a-1b38f82{height:10lh;}"];
  [@css ".a-z3igma{margin:2cap;}"];
  [@css ".a-1xmh56p{padding:5ic;}"];
  [@css ".a-1pesmpm{font-size:1.5lh;}"];
  [@css ".a-1nt3fhm{line-height:2rlh;}"];
  
  CSS.make("a-6tuveb", []);
  CSS.make("a-xh6gk5", []);
  
  CSS.make("a-1auf708", []);
  CSS.make("a-1muf374", []);
  
  CSS.make("a-1tdwc7t", []);
  CSS.make("a-d4qnkz", []);
  
  CSS.make("a-1z04gax", []);
  
  CSS.make("a-13ynmih", []);
  
  CSS.make("a-1joy0pg", []);
  
  CSS.make("a-151mfob", []);
  
  CSS.make("a-1xmnp92", []);
  
  CSS.make("a-16nrh49", []);
  
  CSS.make("a-cgijca", []);
  
  CSS.make("a-1ef0vtm", []);
  
  CSS.make("a-1b38f82", []);
  CSS.make("a-z3igma", []);
  CSS.make("a-1xmh56p", []);
  CSS.make("a-1pesmpm", []);
  CSS.make("a-1nt3fhm", []);
