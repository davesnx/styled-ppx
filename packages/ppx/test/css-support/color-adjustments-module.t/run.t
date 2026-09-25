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
  [@css ".a-1majsr1{-webkit-print-color-adjust:economy;color-adjust:economy;}"];
  [@css ".a-1i8uoce{-webkit-print-color-adjust:exact;color-adjust:exact;}"];
  [@css ".a-k2jaoo{forced-color-adjust:auto;}"];
  [@css ".a-9og3m8{forced-color-adjust:none;}"];
  [@css ".a-1aesf9s{forced-color-adjust:preserve-parent-color;}"];
  [@css ".a-14rmdkq{color-scheme:normal;}"];
  [@css ".a-1bo0ddm{color-scheme:light;}"];
  [@css ".a-ed8a77{color-scheme:dark;}"];
  [@css ".a-ujor4h{color-scheme:light dark;}"];
  [@css ".a-4hsghk{color-scheme:dark light;}"];
  [@css ".a-1nd6avj{color-scheme:only light;}"];
  [@css ".a-p0bop6{color-scheme:light only;}"];
  [@css ".a-16p24tl{color-scheme:light light;}"];
  [@css ".a-1uyd4nr{color-scheme:dark dark;}"];
  [@css ".a-1y02q1k{color-scheme:light purple;}"];
  [@css ".a-eqcn74{color-scheme:purple dark interesting;}"];
  [@css ".a-5yh2ut{color-scheme:none;}"];
  [@css ".a-1ge6jec{color-scheme:light none;}"];
  
  CSS.make("a-1majsr1", []);
  CSS.make("a-1i8uoce", []);
  CSS.make("a-k2jaoo", []);
  CSS.make("a-9og3m8", []);
  CSS.make("a-1aesf9s", []);
  CSS.make("a-14rmdkq", []);
  CSS.make("a-1bo0ddm", []);
  CSS.make("a-ed8a77", []);
  CSS.make("a-ujor4h", []);
  CSS.make("a-4hsghk", []);
  CSS.make("a-1nd6avj", []);
  CSS.make("a-p0bop6", []);
  CSS.make("a-16p24tl", []);
  CSS.make("a-1uyd4nr", []);
  CSS.make("a-1y02q1k", []);
  CSS.make("a-eqcn74", []);
  CSS.make("a-5yh2ut", []);
  CSS.make("a-1ge6jec", []);
