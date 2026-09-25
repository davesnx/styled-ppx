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
  [@css ".a-4fjsr1{-webkit-print-color-adjust:economy;color-adjust:economy;}"];
  [@css ".a-4fuoce{-webkit-print-color-adjust:exact;color-adjust:exact;}"];
  [@css ".a-6ejaoo{forced-color-adjust:auto;}"];
  [@css ".a-6eg3m8{forced-color-adjust:none;}"];
  [@css ".a-6esf9s{forced-color-adjust:preserve-parent-color;}"];
  [@css ".a-4jmdkq{color-scheme:normal;}"];
  [@css ".a-4j0ddm{color-scheme:light;}"];
  [@css ".a-4j8a77{color-scheme:dark;}"];
  [@css ".a-4jor4h{color-scheme:light dark;}"];
  [@css ".a-4jsghk{color-scheme:dark light;}"];
  [@css ".a-4j6avj{color-scheme:only light;}"];
  [@css ".a-4jbop6{color-scheme:light only;}"];
  [@css ".a-4j24tl{color-scheme:light light;}"];
  [@css ".a-4jd4nr{color-scheme:dark dark;}"];
  [@css ".a-4j2q1k{color-scheme:light purple;}"];
  [@css ".a-4jcn74{color-scheme:purple dark interesting;}"];
  [@css ".a-4jh2ut{color-scheme:none;}"];
  [@css ".a-4j6jec{color-scheme:light none;}"];
  
  CSS.make("a-4fjsr1", []);
  CSS.make("a-4fuoce", []);
  CSS.make("a-6ejaoo", []);
  CSS.make("a-6eg3m8", []);
  CSS.make("a-6esf9s", []);
  CSS.make("a-4jmdkq", []);
  CSS.make("a-4j0ddm", []);
  CSS.make("a-4j8a77", []);
  CSS.make("a-4jor4h", []);
  CSS.make("a-4jsghk", []);
  CSS.make("a-4j6avj", []);
  CSS.make("a-4jbop6", []);
  CSS.make("a-4j24tl", []);
  CSS.make("a-4jd4nr", []);
  CSS.make("a-4j2q1k", []);
  CSS.make("a-4jcn74", []);
  CSS.make("a-4jh2ut", []);
  CSS.make("a-4j6jec", []);
