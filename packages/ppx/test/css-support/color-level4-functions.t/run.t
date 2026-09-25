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
  [@css ".a-4esyq5{color:hwb(0 0% 0%);}"];
  [@css ".a-4e1qgw{color:hwb(0 0% 0% / 0.5);}"];
  [@css ".a-4ezea3{color:hwb(120 30% 50%);}"];
  [@css ".a-4e3fh9{color:hwb(120 30% 50% / 0.8);}"];
  [@css ".a-4e2e9t{color:lab(0% 0 0);}"];
  [@css ".a-4e3erw{color:lab(0% 0 0 / 0.5);}"];
  [@css ".a-4en9r5{color:lab(50% 20 -30);}"];
  [@css ".a-4e699s{color:lab(50% 20 -30 / 0.8);}"];
  [@css ".a-4e2dh3{color:lch(0% 0 0);}"];
  [@css ".a-4ej1zh{color:lch(0% 0 0 / 0.5);}"];
  [@css ".a-4eaqt7{color:lch(50% 30 120);}"];
  [@css ".a-4ezfou{color:lch(50% 30 120 / 0.8);}"];
  [@css ".a-4enil4{color:oklab(0% 0 0);}"];
  [@css ".a-4e00n7{color:oklab(0% 0 0 / 0.5);}"];
  [@css ".a-4exkis{color:oklab(50% 0.1 -0.1);}"];
  [@css ".a-4em1az{color:oklab(50% 0.1 -0.1 / 0.8);}"];
  [@css ".a-4eqt74{color:oklch(0% 0 0);}"];
  [@css ".a-4es7y3{color:oklch(0% 0 0 / 0.5);}"];
  [@css ".a-4ezyac{color:oklch(50% 0.15 120);}"];
  [@css ".a-4ehrqn{color:oklch(50% 0.15 120 / 0.8);}"];
  [@css ".a-4e9bfd{color:light-dark(white, black);}"];
  [@css ".a-4exrra{color:light-dark(#fff, #000);}"];
  [@css ".a-4ed5hk{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"];
  [@css ".a-3900476db{background-color:light-dark(#f0f0f0, #1a1a1a);}"];
  [@css ".a-4eq67q{color:color(srgb 1 0.5 0);}"];
  [@css ".a-4evn4u{color:color(srgb 1 0.5 0 / 0.5);}"];
  [@css ".a-4e4vx0{color:color(display-p3 1 0.5 0);}"];
  [@css ".a-4eh8l1{color:color(display-p3 1 0.5 0 / 0.5);}"];
  [@css ".a-39004jf25{background-color:hwb(0 0% 0%);}"];
  [@css ".a-390046psj{background-color:lab(50% 20 -30);}"];
  [@css ".a-39004qziw{background-color:lch(50% 30 120);}"];
  [@css ".a-39004l9l2{background-color:oklab(50% 0.1 -0.1);}"];
  [@css ".a-39004ibmj{background-color:oklch(50% 0.15 120);}"];
  
  CSS.make("a-4esyq5", []);
  CSS.make("a-4e1qgw", []);
  CSS.make("a-4ezea3", []);
  CSS.make("a-4e3fh9", []);
  
  CSS.make("a-4e2e9t", []);
  CSS.make("a-4e3erw", []);
  CSS.make("a-4en9r5", []);
  CSS.make("a-4e699s", []);
  
  CSS.make("a-4e2dh3", []);
  CSS.make("a-4ej1zh", []);
  CSS.make("a-4eaqt7", []);
  CSS.make("a-4ezfou", []);
  
  CSS.make("a-4enil4", []);
  CSS.make("a-4e00n7", []);
  CSS.make("a-4exkis", []);
  CSS.make("a-4em1az", []);
  
  CSS.make("a-4eqt74", []);
  CSS.make("a-4es7y3", []);
  CSS.make("a-4ezyac", []);
  CSS.make("a-4ehrqn", []);
  
  CSS.make("a-4e9bfd", []);
  CSS.make("a-4exrra", []);
  CSS.make("a-4ed5hk", []);
  CSS.make("a-3900476db", []);
  
  CSS.make("a-4eq67q", []);
  CSS.make("a-4evn4u", []);
  CSS.make("a-4e4vx0", []);
  CSS.make("a-4eh8l1", []);
  
  CSS.make("a-39004jf25", []);
  CSS.make("a-390046psj", []);
  CSS.make("a-39004qziw", []);
  CSS.make("a-39004l9l2", []);
  CSS.make("a-39004ibmj", []);
