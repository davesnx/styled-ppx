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
  CSS.backgroundBlendMode(`normal);
  CSS.backgroundBlendMode(`multiply);
  CSS.backgroundBlendMode(`screen);
  CSS.backgroundBlendMode(`overlay);
  CSS.backgroundBlendMode(`darken);
  CSS.backgroundBlendMode(`lighten);
  CSS.backgroundBlendMode(`colorDodge);
  CSS.backgroundBlendMode(`colorBurn);
  CSS.backgroundBlendMode(`hardLight);
  CSS.backgroundBlendMode(`softLight);
  CSS.backgroundBlendMode(`difference);
  CSS.backgroundBlendMode(`exclusion);
  CSS.backgroundBlendMode(`hue);
  CSS.backgroundBlendMode(`saturation);
  CSS.backgroundBlendMode(`color);
  CSS.backgroundBlendMode(`luminosity);
  CSS.backgroundBlendModes([|`normal, `multiply|]);
