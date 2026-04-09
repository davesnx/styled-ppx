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
  [@css ".css-1majsr1{color-adjust:economy;}"];
  [@css ".css-1i8uoce{color-adjust:exact;}"];
  [@css ".css-k2jaoo{forced-color-adjust:auto;}"];
  [@css ".css-9og3m8{forced-color-adjust:none;}"];
  [@css ".css-1aesf9s{forced-color-adjust:preserve-parent-color;}"];
  [@css ".css-14rmdkq{color-scheme:normal;}"];
  [@css ".css-1bo0ddm{color-scheme:light;}"];
  [@css ".css-ed8a77{color-scheme:dark;}"];
  [@css ".css-ujor4h{color-scheme:light dark;}"];
  [@css ".css-4hsghk{color-scheme:dark light;}"];
  [@css ".css-1nd6avj{color-scheme:only light;}"];
  [@css ".css-p0bop6{color-scheme:light only;}"];
  [@css ".css-16p24tl{color-scheme:light light;}"];
  [@css ".css-1uyd4nr{color-scheme:dark dark;}"];
  [@css ".css-1y02q1k{color-scheme:light purple;}"];
  [@css ".css-eqcn74{color-scheme:purple dark interesting;}"];
  [@css ".css-5yh2ut{color-scheme:none;}"];
  [@css ".css-1ge6jec{color-scheme:light none;}"];
  
  CSS.make("css-1majsr1", []);
  CSS.make("css-1i8uoce", []);
  CSS.make("css-k2jaoo", []);
  CSS.make("css-9og3m8", []);
  CSS.make("css-1aesf9s", []);
  CSS.make("css-14rmdkq", []);
  CSS.make("css-1bo0ddm", []);
  CSS.make("css-ed8a77", []);
  CSS.make("css-ujor4h", []);
  CSS.make("css-4hsghk", []);
  CSS.make("css-1nd6avj", []);
  CSS.make("css-p0bop6", []);
  CSS.make("css-16p24tl", []);
  CSS.make("css-1uyd4nr", []);
  CSS.make("css-1y02q1k", []);
  CSS.make("css-eqcn74", []);
  CSS.make("css-5yh2ut", []);
  CSS.make("css-1ge6jec", []);
