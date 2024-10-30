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
  
  CSS.unsafe({js|contain|js}, {js|none|js});
  CSS.unsafe({js|contain|js}, {js|strict|js});
  CSS.unsafe({js|contain|js}, {js|content|js});
  CSS.unsafe({js|contain|js}, {js|size|js});
  CSS.unsafe({js|contain|js}, {js|layout|js});
  CSS.unsafe({js|contain|js}, {js|paint|js});
  CSS.unsafe({js|contain|js}, {js|size layout|js});
  CSS.unsafe({js|contain|js}, {js|size paint|js});
  CSS.unsafe({js|contain|js}, {js|size layout paint|js});
  
  CSS.style([|CSS.width(`cqw(5.))|]);
  CSS.style([|CSS.width(`cqh(5.))|]);
  CSS.style([|CSS.width(`cqi(5.))|]);
  CSS.style([|CSS.width(`cqb(5.))|]);
  CSS.style([|CSS.width(`cqmin(5.))|]);
  CSS.style([|CSS.width(`cqmax(5.))|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|normal|js})|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|size|js})|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|inline-size|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|none|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|x|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|x y|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|none|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / normal|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / size|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / inline-size|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x y / size|js})|]);
