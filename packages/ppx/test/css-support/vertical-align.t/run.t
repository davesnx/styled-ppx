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
  [@css ".a-1wj9eo6{vertical-align:baseline;}"];
  [@css ".a-c6kzuz{vertical-align:sub;}"];
  [@css ".a-9z1ck9{vertical-align:super;}"];
  [@css ".a-1hgawz4{vertical-align:top;}"];
  [@css ".a-ezbbe2{vertical-align:text-top;}"];
  [@css ".a-uk6cul{vertical-align:middle;}"];
  [@css ".a-1170n61{vertical-align:bottom;}"];
  [@css ".a-i6dzq1{vertical-align:text-bottom;}"];
  CSS.make("a-1wj9eo6", []);
  CSS.make("a-c6kzuz", []);
  CSS.make("a-9z1ck9", []);
  CSS.make("a-1hgawz4", []);
  CSS.make("a-ezbbe2", []);
  CSS.make("a-uk6cul", []);
  CSS.make("a-1170n61", []);
  CSS.make("a-i6dzq1", []);
