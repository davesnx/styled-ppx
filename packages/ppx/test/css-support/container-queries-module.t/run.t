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
  
  CSS.unsafe({js|containerType|js}, {js|normal|js});
  CSS.unsafe({js|containerType|js}, {js|size|js});
  CSS.unsafe({js|containerType|js}, {js|inline-size|js});
  CSS.unsafe({js|containerName|js}, {js|none|js});
  CSS.unsafe({js|containerName|js}, {js|sidebar|js});
  CSS.unsafe({js|containerName|js}, {js|sidebar main|js});
  CSS.unsafe({js|container|js}, {js|sidebar / inline-size|js});
  CSS.unsafe({js|container|js}, {js|sidebar / size|js});
  CSS.unsafe({js|container|js}, {js|none|js});
