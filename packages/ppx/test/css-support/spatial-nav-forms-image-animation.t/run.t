CSS Spatial Navigation L1 (spatial-navigation-contain/-action/-function),
CSS Form Control Styling L1 (input-security, slider-orientation), CSS Image
Animation L1 (image-animation). input.re carries valid declarations
(accepted silently); invalid.re carries an out-of-grammar keyword, whose
error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 28-36:
  1 | [%css {|slider-orientation: vertical|}];
                                  ^^^^^^^^
  Error: Property 'slider-orientation' has an invalid value:
         'vertical',
         Expected 'auto', 'bottom-to-top', 'left-to-right', 'right-to-left', or
         'top-to-bottom'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_gh0m8o{spatial-navigation-contain:auto;}"];
  [@css "._a_gho0tl{spatial-navigation-contain:contain;}"];
  [@css "._a_ggylya{spatial-navigation-action:auto;}"];
  [@css "._a_ggcs1f{spatial-navigation-action:focus;}"];
  [@css "._a_ggmv9e{spatial-navigation-action:scroll;}"];
  [@css "._a_giw9j7{spatial-navigation-function:normal;}"];
  [@css "._a_gikhle{spatial-navigation-function:grid;}"];
  [@css "._a_g0vsvf{input-security:auto;}"];
  [@css "._a_g0xrmz{input-security:none;}"];
  [@css "._a_gfbked{slider-orientation:auto;}"];
  [@css "._a_gf592w{slider-orientation:left-to-right;}"];
  [@css "._a_gfedm7{slider-orientation:right-to-left;}"];
  [@css "._a_gfopqg{slider-orientation:top-to-bottom;}"];
  [@css "._a_gfp6e5{slider-orientation:bottom-to-top;}"];
  [@css "._a_fxz01g{image-animation:normal;}"];
  [@css "._a_fxruim{image-animation:paused;}"];
  [@css "._a_fxci5z{image-animation:stopped;}"];
  [@css "._a_fx987c{image-animation:running;}"];
  
  CSS.make("_a_gh0m8o", []);
  CSS.make("_a_gho0tl", []);
  CSS.make("_a_ggylya", []);
  CSS.make("_a_ggcs1f", []);
  CSS.make("_a_ggmv9e", []);
  CSS.make("_a_giw9j7", []);
  CSS.make("_a_gikhle", []);
  CSS.make("_a_g0vsvf", []);
  CSS.make("_a_g0xrmz", []);
  CSS.make("_a_gfbked", []);
  CSS.make("_a_gf592w", []);
  CSS.make("_a_gfedm7", []);
  CSS.make("_a_gfopqg", []);
  CSS.make("_a_gfp6e5", []);
  CSS.make("_a_fxz01g", []);
  CSS.make("_a_fxruim", []);
  CSS.make("_a_fxci5z", []);
  CSS.make("_a_fx987c", []);
