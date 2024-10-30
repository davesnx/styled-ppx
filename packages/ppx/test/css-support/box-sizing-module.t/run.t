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
  
  CSS.width(`maxContent);
  CSS.width(`minContent);
  CSS.unsafe({js|width|js}, {js|fit-content(10%)|js});
  CSS.minWidth(`maxContent);
  CSS.minWidth(`minContent);
  CSS.unsafe({js|minWidth|js}, {js|fit-content(10%)|js});
  CSS.maxWidth(`maxContent);
  CSS.maxWidth(`minContent);
  CSS.unsafe({js|maxWidth|js}, {js|fit-content(10%)|js});
  CSS.height(`maxContent);
  CSS.height(`minContent);
  CSS.unsafe({js|height|js}, {js|fit-content(10%)|js});
  CSS.minHeight(`maxContent);
  CSS.minHeight(`minContent);
  CSS.unsafe({js|minHeight|js}, {js|fit-content(10%)|js});
  CSS.maxHeight(`maxContent);
  CSS.maxHeight(`minContent);
  CSS.unsafe({js|maxHeight|js}, {js|fit-content(10%)|js});
  
  CSS.aspectRatio(`auto);
  CSS.aspectRatio(`num(2.));
  CSS.aspectRatio(`ratio((16, 9)));
  
  CSS.unsafe({js|width|js}, {js|fit-content|js});
  
  CSS.unsafe({js|minWidth|js}, {js|fit-content|js});
  
  CSS.unsafe({js|maxWidth|js}, {js|fit-content|js});
  
  CSS.unsafe({js|height|js}, {js|fit-content|js});
  
  CSS.unsafe({js|minHeight|js}, {js|fit-content|js});
  
  CSS.unsafe({js|maxHeight|js}, {js|fit-content|js});
