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
  [@css ".css-1wj9eo6{vertical-align:baseline;}"];
  [@css ".css-c6kzuz{vertical-align:sub;}"];
  [@css ".css-9z1ck9{vertical-align:super;}"];
  [@css ".css-1hgawz4{vertical-align:top;}"];
  [@css ".css-ezbbe2{vertical-align:text-top;}"];
  [@css ".css-uk6cul{vertical-align:middle;}"];
  [@css ".css-1170n61{vertical-align:bottom;}"];
  [@css ".css-i6dzq1{vertical-align:text-bottom;}"];
  CSS.make("css-1wj9eo6", []);
  CSS.make("css-c6kzuz", []);
  CSS.make("css-9z1ck9", []);
  CSS.make("css-1hgawz4", []);
  CSS.make("css-ezbbe2", []);
  CSS.make("css-uk6cul", []);
  CSS.make("css-1170n61", []);
  CSS.make("css-i6dzq1", []);
