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
  
  CSS.unsafe({js|width|js}, {js|1cap|js});
  CSS.unsafe({js|width|js}, {js|2.5cap|js});
  
  CSS.unsafe({js|width|js}, {js|1ic|js});
  CSS.unsafe({js|width|js}, {js|3.5ic|js});
  
  CSS.unsafe({js|width|js}, {js|1lh|js});
  CSS.unsafe({js|width|js}, {js|2lh|js});
  
  CSS.unsafe({js|width|js}, {js|1rcap|js});
  
  CSS.unsafe({js|width|js}, {js|1rch|js});
  
  CSS.unsafe({js|width|js}, {js|1rex|js});
  
  CSS.unsafe({js|width|js}, {js|1ric|js});
  
  CSS.unsafe({js|width|js}, {js|1rlh|js});
  
  CSS.unsafe({js|width|js}, {js|50vb|js});
  
  CSS.unsafe({js|width|js}, {js|50vi|js});
  
  CSS.unsafe({js|width|js}, {js|40Q|js});
  
  CSS.unsafe({js|height|js}, {js|10lh|js});
  CSS.unsafe({js|margin|js}, {js|2cap|js});
  CSS.unsafe({js|padding|js}, {js|5ic|js});
  CSS.unsafe({js|fontSize|js}, {js|1.5lh|js});
  CSS.unsafe({js|lineHeight|js}, {js|2rlh|js});
