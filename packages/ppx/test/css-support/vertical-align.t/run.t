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
  [@css ".a-dt9eo6{vertical-align:baseline;}"];
  [@css ".a-dtkzuz{vertical-align:sub;}"];
  [@css ".a-dt1ck9{vertical-align:super;}"];
  [@css ".a-dtawz4{vertical-align:top;}"];
  [@css ".a-dtbbe2{vertical-align:text-top;}"];
  [@css ".a-dt6cul{vertical-align:middle;}"];
  [@css ".a-dt0n61{vertical-align:bottom;}"];
  [@css ".a-dtdzq1{vertical-align:text-bottom;}"];
  CSS.make("a-dt9eo6", []);
  CSS.make("a-dtkzuz", []);
  CSS.make("a-dt1ck9", []);
  CSS.make("a-dtawz4", []);
  CSS.make("a-dtbbe2", []);
  CSS.make("a-dt6cul", []);
  CSS.make("a-dt0n61", []);
  CSS.make("a-dtdzq1", []);
