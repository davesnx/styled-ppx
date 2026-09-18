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
  [@css ".css-11usyq5{color:hwb(0 0% 0%)}"];
  [@css ".css-1gt1qgw{color:hwb(0 0% 0% / 0.5)}"];
  [@css ".css-1vzzea3{color:hwb(120 30% 50%)}"];
  [@css ".css-10x3fh9{color:hwb(120 30% 50% / 0.8)}"];
  [@css ".css-14i2e9t{color:lab(0% 0 0)}"];
  [@css ".css-1jn3erw{color:lab(0% 0 0 / 0.5)}"];
  [@css ".css-103n9r5{color:lab(50% 20 -30)}"];
  [@css ".css-1l0699s{color:lab(50% 20 -30 / 0.8)}"];
  [@css ".css-mw2dh3{color:lch(0% 0 0)}"];
  [@css ".css-84j1zh{color:lch(0% 0 0 / 0.5)}"];
  [@css ".css-1v1aqt7{color:lch(50% 30 120)}"];
  [@css ".css-j9zfou{color:lch(50% 30 120 / 0.8)}"];
  [@css ".css-195nil4{color:oklab(0% 0 0)}"];
  [@css ".css-17r00n7{color:oklab(0% 0 0 / 0.5)}"];
  [@css ".css-1pwxkis{color:oklab(50% 0.1 -0.1)}"];
  [@css ".css-1kvm1az{color:oklab(50% 0.1 -0.1 / 0.8)}"];
  [@css ".css-17sqt74{color:oklch(0% 0 0)}"];
  [@css ".css-12as7y3{color:oklch(0% 0 0 / 0.5)}"];
  [@css ".css-171zyac{color:oklch(50% 0.15 120)}"];
  [@css ".css-1s6hrqn{color:oklch(50% 0.15 120 / 0.8)}"];
  [@css ".css-t7xlcd{color:light-dark(white,black)}"];
  [@css ".css-1xd1wdb{color:light-dark(#fff,#000)}"];
  [@css ".css-1kwkpfc{color:light-dark(rgb(255,255,255),rgb(0,0,0))}"];
  [@css ".css-1hs57a2{background-color:light-dark(#f0f0f0,#1a1a1a)}"];
  [@css ".css-o4q67q{color:color(srgb 1 0.5 0)}"];
  [@css ".css-1exvn4u{color:color(srgb 1 0.5 0 / 0.5)}"];
  [@css ".css-rj4vx0{color:color(display-p3 1 0.5 0)}"];
  [@css ".css-q4h8l1{color:color(display-p3 1 0.5 0 / 0.5)}"];
  [@css ".css-p2jf25{background-color:hwb(0 0% 0%)}"];
  [@css ".css-1pp6psj{background-color:lab(50% 20 -30)}"];
  [@css ".css-46qziw{background-color:lch(50% 30 120)}"];
  [@css ".css-iml9l2{background-color:oklab(50% 0.1 -0.1)}"];
  [@css ".css-l7ibmj{background-color:oklch(50% 0.15 120)}"];
  
  CSS.make("css-11usyq5", []);
  CSS.make("css-1gt1qgw", []);
  CSS.make("css-1vzzea3", []);
  CSS.make("css-10x3fh9", []);
  
  CSS.make("css-14i2e9t", []);
  CSS.make("css-1jn3erw", []);
  CSS.make("css-103n9r5", []);
  CSS.make("css-1l0699s", []);
  
  CSS.make("css-mw2dh3", []);
  CSS.make("css-84j1zh", []);
  CSS.make("css-1v1aqt7", []);
  CSS.make("css-j9zfou", []);
  
  CSS.make("css-195nil4", []);
  CSS.make("css-17r00n7", []);
  CSS.make("css-1pwxkis", []);
  CSS.make("css-1kvm1az", []);
  
  CSS.make("css-17sqt74", []);
  CSS.make("css-12as7y3", []);
  CSS.make("css-171zyac", []);
  CSS.make("css-1s6hrqn", []);
  
  CSS.make("css-t7xlcd", []);
  CSS.make("css-1xd1wdb", []);
  CSS.make("css-1kwkpfc", []);
  CSS.make("css-1hs57a2", []);
  
  CSS.make("css-o4q67q", []);
  CSS.make("css-1exvn4u", []);
  CSS.make("css-rj4vx0", []);
  CSS.make("css-q4h8l1", []);
  
  CSS.make("css-p2jf25", []);
  CSS.make("css-1pp6psj", []);
  CSS.make("css-46qziw", []);
  CSS.make("css-iml9l2", []);
  CSS.make("css-l7ibmj", []);
