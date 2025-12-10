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
  
  CSS.mixBlendMode(`normal);
  CSS.mixBlendMode(`multiply);
  CSS.mixBlendMode(`screen);
  CSS.mixBlendMode(`overlay);
  CSS.mixBlendMode(`darken);
  CSS.mixBlendMode(`lighten);
  CSS.mixBlendMode(`colorDodge);
  CSS.mixBlendMode(`colorBurn);
  CSS.mixBlendMode(`hardLight);
  CSS.mixBlendMode(`softLight);
  CSS.mixBlendMode(`difference);
  CSS.mixBlendMode(`exclusion);
  CSS.mixBlendMode(`hue);
  CSS.mixBlendMode(`saturation);
  CSS.mixBlendMode(`color);
  CSS.mixBlendMode(`luminosity);
  CSS.isolation(`auto);
  CSS.isolation(`isolate);
  CSS.unsafe({js|backgroundBlendMode|js}, {js|normal|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|multiply|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|screen|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|overlay|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|darken|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|lighten|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color-dodge|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color-burn|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|hard-light|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|soft-light|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|difference|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|exclusion|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|hue|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|saturation|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|luminosity|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|normal, multiply|js});
