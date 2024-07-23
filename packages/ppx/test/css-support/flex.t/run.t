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
  
  CSS.flexBasis(`auto);
  CSS.unsafe({js|flex|js}, {js|initial|js});
  CSS.flex1(`none);
  
  CSS.flex1(`num(2.));
  
  CSS.flexBasis(`em(10.));
  CSS.flexBasis(`percent(30.));
  CSS.flexBasis(`minContent);
  
  CSS.flex2(~basis=`pxFloat(30.), 1.);
  
  CSS.flex2(~shrink=2., 2.);
  
  CSS.flex(2., 2., `percent(10.));
  CSS.flex(2., 2., `em(10.));
  CSS.flex(2., 2., `minContent);
