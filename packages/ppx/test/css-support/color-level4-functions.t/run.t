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
  
  CSS.color(`hwb((`deg(0.), `percent(0.), `percent(0.))));
  CSS.color(`hwba((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
  CSS.color(`hwb((`deg(120.), `percent(30.), `percent(50.))));
  CSS.color(`hwba((`deg(120.), `percent(30.), `percent(50.), `num(0.8))));
  
  CSS.color(`lab((`percent(0.), `num(0.), `num(0.))));
  CSS.color(`laba((`percent(0.), `num(0.), `num(0.), `num(0.5))));
  CSS.color(`lab((`percent(50.), `num(20.), `num(-30.))));
  CSS.color(`laba((`percent(50.), `num(20.), `num(-30.), `num(0.8))));
  
  CSS.color(`lch((`percent(0.), `num(0.), `deg(0.))));
  CSS.color(`lcha((`percent(0.), `num(0.), `deg(0.), `num(0.5))));
  CSS.color(`lch((`percent(50.), `num(30.), `deg(120.))));
  CSS.color(`lcha((`percent(50.), `num(30.), `deg(120.), `num(0.8))));
  
  CSS.color(`oklab((`percent(0.), `num(0.), `num(0.))));
  CSS.color(`oklaba((`percent(0.), `num(0.), `num(0.), `num(0.5))));
  CSS.color(`oklab((`percent(50.), `num(0.1), `num(-0.1))));
  CSS.color(`oklaba((`percent(50.), `num(0.1), `num(-0.1), `num(0.8))));
  
  CSS.color(`oklch((`percent(0.), `num(0.), `deg(0.))));
  CSS.color(`oklcha((`percent(0.), `num(0.), `deg(0.), `num(0.5))));
  CSS.color(`oklch((`percent(50.), `num(0.15), `deg(120.))));
  CSS.color(`oklcha((`percent(50.), `num(0.15), `deg(120.), `num(0.8))));
  
  CSS.color(`lightDark((CSS.white, CSS.black)));
  CSS.color(`lightDark((`hex({js|fff|js}), `hex({js|000|js}))));
  CSS.color(`lightDark((`rgb((255, 255, 255)), `rgb((0, 0, 0)))));
  CSS.backgroundColor(
    `lightDark((`hex({js|f0f0f0|js}), `hex({js|1a1a1a|js}))),
  );
  
  CSS.color(`color((`srgb, `num(1.), `num(0.5), `num(0.))));
  CSS.color(`colora((`srgb, `num(1.), `num(0.5), `num(0.), `num(0.5))));
  CSS.color(`color((`displayP3, `num(1.), `num(0.5), `num(0.))));
  CSS.color(
    `colora((`displayP3, `num(1.), `num(0.5), `num(0.), `num(0.5))),
  );
  
  CSS.backgroundColor(`hwb((`deg(0.), `percent(0.), `percent(0.))));
  CSS.backgroundColor(`lab((`percent(50.), `num(20.), `num(-30.))));
  CSS.backgroundColor(`lch((`percent(50.), `num(30.), `deg(120.))));
  CSS.backgroundColor(`oklab((`percent(50.), `num(0.1), `num(-0.1))));
  CSS.backgroundColor(`oklch((`percent(50.), `num(0.15), `deg(120.))));
