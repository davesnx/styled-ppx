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
  [@css "._a_4esyq5{color:hwb(0 0% 0%);}"];
  [@css "._a_4e1qgw{color:hwb(0 0% 0% / 0.5);}"];
  [@css "._a_4ezea3{color:hwb(120 30% 50%);}"];
  [@css "._a_4e3fh9{color:hwb(120 30% 50% / 0.8);}"];
  [@css "._a_4e2e9t{color:lab(0% 0 0);}"];
  [@css "._a_4e3erw{color:lab(0% 0 0 / 0.5);}"];
  [@css "._a_4en9r5{color:lab(50% 20 -30);}"];
  [@css "._a_4e699s{color:lab(50% 20 -30 / 0.8);}"];
  [@css "._a_4e2dh3{color:lch(0% 0 0);}"];
  [@css "._a_4ej1zh{color:lch(0% 0 0 / 0.5);}"];
  [@css "._a_4eaqt7{color:lch(50% 30 120);}"];
  [@css "._a_4ezfou{color:lch(50% 30 120 / 0.8);}"];
  [@css "._a_4enil4{color:oklab(0% 0 0);}"];
  [@css "._a_4e00n7{color:oklab(0% 0 0 / 0.5);}"];
  [@css "._a_4exkis{color:oklab(50% 0.1 -0.1);}"];
  [@css "._a_4em1az{color:oklab(50% 0.1 -0.1 / 0.8);}"];
  [@css "._a_4eqt74{color:oklch(0% 0 0);}"];
  [@css "._a_4es7y3{color:oklch(0% 0 0 / 0.5);}"];
  [@css "._a_4ezyac{color:oklch(50% 0.15 120);}"];
  [@css "._a_4ehrqn{color:oklch(50% 0.15 120 / 0.8);}"];
  [@css "._a_4e9bfd{color:light-dark(white, black);}"];
  [@css "._a_4exrra{color:light-dark(#fff, #000);}"];
  [@css "._a_4ed5hk{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"];
  [@css "._a_3900476db{background-color:light-dark(#f0f0f0, #1a1a1a);}"];
  [@css "._a_4eq67q{color:color(srgb 1 0.5 0);}"];
  [@css "._a_4evn4u{color:color(srgb 1 0.5 0 / 0.5);}"];
  [@css "._a_4e4vx0{color:color(display-p3 1 0.5 0);}"];
  [@css "._a_4eh8l1{color:color(display-p3 1 0.5 0 / 0.5);}"];
  [@css "._a_39004jf25{background-color:hwb(0 0% 0%);}"];
  [@css "._a_390046psj{background-color:lab(50% 20 -30);}"];
  [@css "._a_39004qziw{background-color:lch(50% 30 120);}"];
  [@css "._a_39004l9l2{background-color:oklab(50% 0.1 -0.1);}"];
  [@css "._a_39004ibmj{background-color:oklch(50% 0.15 120);}"];
  
  CSS.make("_a_4esyq5", []);
  CSS.make("_a_4e1qgw", []);
  CSS.make("_a_4ezea3", []);
  CSS.make("_a_4e3fh9", []);
  
  CSS.make("_a_4e2e9t", []);
  CSS.make("_a_4e3erw", []);
  CSS.make("_a_4en9r5", []);
  CSS.make("_a_4e699s", []);
  
  CSS.make("_a_4e2dh3", []);
  CSS.make("_a_4ej1zh", []);
  CSS.make("_a_4eaqt7", []);
  CSS.make("_a_4ezfou", []);
  
  CSS.make("_a_4enil4", []);
  CSS.make("_a_4e00n7", []);
  CSS.make("_a_4exkis", []);
  CSS.make("_a_4em1az", []);
  
  CSS.make("_a_4eqt74", []);
  CSS.make("_a_4es7y3", []);
  CSS.make("_a_4ezyac", []);
  CSS.make("_a_4ehrqn", []);
  
  CSS.make("_a_4e9bfd", []);
  CSS.make("_a_4exrra", []);
  CSS.make("_a_4ed5hk", []);
  CSS.make("_a_3900476db", []);
  
  CSS.make("_a_4eq67q", []);
  CSS.make("_a_4evn4u", []);
  CSS.make("_a_4e4vx0", []);
  CSS.make("_a_4eh8l1", []);
  
  CSS.make("_a_39004jf25", []);
  CSS.make("_a_390046psj", []);
  CSS.make("_a_39004qziw", []);
  CSS.make("_a_39004l9l2", []);
  CSS.make("_a_39004ibmj", []);
