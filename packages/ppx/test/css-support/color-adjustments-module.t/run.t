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
  [@css "._a_4fjsr1{-webkit-print-color-adjust:economy;color-adjust:economy;}"];
  [@css "._a_4fuoce{-webkit-print-color-adjust:exact;color-adjust:exact;}"];
  [@css "._a_6ejaoo{forced-color-adjust:auto;}"];
  [@css "._a_6eg3m8{forced-color-adjust:none;}"];
  [@css "._a_6esf9s{forced-color-adjust:preserve-parent-color;}"];
  [@css "._a_4jmdkq{color-scheme:normal;}"];
  [@css "._a_4j0ddm{color-scheme:light;}"];
  [@css "._a_4j8a77{color-scheme:dark;}"];
  [@css "._a_4jor4h{color-scheme:light dark;}"];
  [@css "._a_4jsghk{color-scheme:dark light;}"];
  [@css "._a_4j6avj{color-scheme:only light;}"];
  [@css "._a_4jbop6{color-scheme:light only;}"];
  [@css "._a_4j24tl{color-scheme:light light;}"];
  [@css "._a_4jd4nr{color-scheme:dark dark;}"];
  [@css "._a_4j2q1k{color-scheme:light purple;}"];
  [@css "._a_4jcn74{color-scheme:purple dark interesting;}"];
  [@css "._a_4jh2ut{color-scheme:none;}"];
  [@css "._a_4j6jec{color-scheme:light none;}"];
  
  CSS.make("_a_4fjsr1", []);
  CSS.make("_a_4fuoce", []);
  CSS.make("_a_6ejaoo", []);
  CSS.make("_a_6eg3m8", []);
  CSS.make("_a_6esf9s", []);
  CSS.make("_a_4jmdkq", []);
  CSS.make("_a_4j0ddm", []);
  CSS.make("_a_4j8a77", []);
  CSS.make("_a_4jor4h", []);
  CSS.make("_a_4jsghk", []);
  CSS.make("_a_4j6avj", []);
  CSS.make("_a_4jbop6", []);
  CSS.make("_a_4j24tl", []);
  CSS.make("_a_4jd4nr", []);
  CSS.make("_a_4j2q1k", []);
  CSS.make("_a_4jcn74", []);
  CSS.make("_a_4jh2ut", []);
  CSS.make("_a_4j6jec", []);
