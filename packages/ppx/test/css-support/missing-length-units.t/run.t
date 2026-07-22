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
  [@css ".css-6tuveb{width:1cap}"];
  [@css ".css-xh6gk5{width:2.5cap}"];
  [@css ".css-1auf708{width:1ic}"];
  [@css ".css-1muf374{width:3.5ic}"];
  [@css ".css-1tdwc7t{width:1lh}"];
  [@css ".css-d4qnkz{width:2lh}"];
  [@css ".css-1z04gax{width:1rcap}"];
  [@css ".css-13ynmih{width:1rch}"];
  [@css ".css-1joy0pg{width:1rex}"];
  [@css ".css-151mfob{width:1ric}"];
  [@css ".css-1xmnp92{width:1rlh}"];
  [@css ".css-16nrh49{width:50vb}"];
  [@css ".css-cgijca{width:50vi}"];
  [@css ".css-1ef0vtm{width:40Q}"];
  [@css ".css-1b38f82{height:10lh}"];
  [@css ".css-z3igma{margin:2cap}"];
  [@css ".css-1xmh56p{padding:5ic}"];
  [@css ".css-1pesmpm{font-size:1.5lh}"];
  [@css ".css-1nt3fhm{line-height:2rlh}"];
  
  CSS.make("css-6tuveb", []);
  CSS.make("css-xh6gk5", []);
  
  CSS.make("css-1auf708", []);
  CSS.make("css-1muf374", []);
  
  CSS.make("css-1tdwc7t", []);
  CSS.make("css-d4qnkz", []);
  
  CSS.make("css-1z04gax", []);
  
  CSS.make("css-13ynmih", []);
  
  CSS.make("css-1joy0pg", []);
  
  CSS.make("css-151mfob", []);
  
  CSS.make("css-1xmnp92", []);
  
  CSS.make("css-16nrh49", []);
  
  CSS.make("css-cgijca", []);
  
  CSS.make("css-1ef0vtm", []);
  
  CSS.make("css-1b38f82", []);
  CSS.make("css-z3igma", []);
  CSS.make("css-1xmh56p", []);
  CSS.make("css-1pesmpm", []);
  CSS.make("css-1nt3fhm", []);
