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
  [@css ".a-11usyq5{color:hwb(0 0% 0%);}"];
  [@css ".a-1gt1qgw{color:hwb(0 0% 0% / 0.5);}"];
  [@css ".a-1vzzea3{color:hwb(120 30% 50%);}"];
  [@css ".a-10x3fh9{color:hwb(120 30% 50% / 0.8);}"];
  [@css ".a-14i2e9t{color:lab(0% 0 0);}"];
  [@css ".a-1jn3erw{color:lab(0% 0 0 / 0.5);}"];
  [@css ".a-103n9r5{color:lab(50% 20 -30);}"];
  [@css ".a-1l0699s{color:lab(50% 20 -30 / 0.8);}"];
  [@css ".a-mw2dh3{color:lch(0% 0 0);}"];
  [@css ".a-84j1zh{color:lch(0% 0 0 / 0.5);}"];
  [@css ".a-1v1aqt7{color:lch(50% 30 120);}"];
  [@css ".a-j9zfou{color:lch(50% 30 120 / 0.8);}"];
  [@css ".a-195nil4{color:oklab(0% 0 0);}"];
  [@css ".a-17r00n7{color:oklab(0% 0 0 / 0.5);}"];
  [@css ".a-1pwxkis{color:oklab(50% 0.1 -0.1);}"];
  [@css ".a-1kvm1az{color:oklab(50% 0.1 -0.1 / 0.8);}"];
  [@css ".a-17sqt74{color:oklch(0% 0 0);}"];
  [@css ".a-12as7y3{color:oklch(0% 0 0 / 0.5);}"];
  [@css ".a-171zyac{color:oklch(50% 0.15 120);}"];
  [@css ".a-1s6hrqn{color:oklch(50% 0.15 120 / 0.8);}"];
  [@css ".a-1cj9bfd{color:light-dark(white, black);}"];
  [@css ".a-mnxrra{color:light-dark(#fff, #000);}"];
  [@css ".a-kjd5hk{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"];
  [@css ".a-1h376db{background-color:light-dark(#f0f0f0, #1a1a1a);}"];
  [@css ".a-o4q67q{color:color(srgb 1 0.5 0);}"];
  [@css ".a-1exvn4u{color:color(srgb 1 0.5 0 / 0.5);}"];
  [@css ".a-rj4vx0{color:color(display-p3 1 0.5 0);}"];
  [@css ".a-q4h8l1{color:color(display-p3 1 0.5 0 / 0.5);}"];
  [@css ".a-p2jf25{background-color:hwb(0 0% 0%);}"];
  [@css ".a-1pp6psj{background-color:lab(50% 20 -30);}"];
  [@css ".a-46qziw{background-color:lch(50% 30 120);}"];
  [@css ".a-iml9l2{background-color:oklab(50% 0.1 -0.1);}"];
  [@css ".a-l7ibmj{background-color:oklch(50% 0.15 120);}"];
  
  CSS.make("a-11usyq5", []);
  CSS.make("a-1gt1qgw", []);
  CSS.make("a-1vzzea3", []);
  CSS.make("a-10x3fh9", []);
  
  CSS.make("a-14i2e9t", []);
  CSS.make("a-1jn3erw", []);
  CSS.make("a-103n9r5", []);
  CSS.make("a-1l0699s", []);
  
  CSS.make("a-mw2dh3", []);
  CSS.make("a-84j1zh", []);
  CSS.make("a-1v1aqt7", []);
  CSS.make("a-j9zfou", []);
  
  CSS.make("a-195nil4", []);
  CSS.make("a-17r00n7", []);
  CSS.make("a-1pwxkis", []);
  CSS.make("a-1kvm1az", []);
  
  CSS.make("a-17sqt74", []);
  CSS.make("a-12as7y3", []);
  CSS.make("a-171zyac", []);
  CSS.make("a-1s6hrqn", []);
  
  CSS.make("a-1cj9bfd", []);
  CSS.make("a-mnxrra", []);
  CSS.make("a-kjd5hk", []);
  CSS.make("a-1h376db", []);
  
  CSS.make("a-o4q67q", []);
  CSS.make("a-1exvn4u", []);
  CSS.make("a-rj4vx0", []);
  CSS.make("a-q4h8l1", []);
  
  CSS.make("a-p2jf25", []);
  CSS.make("a-1pp6psj", []);
  CSS.make("a-46qziw", []);
  CSS.make("a-iml9l2", []);
  CSS.make("a-l7ibmj", []);
