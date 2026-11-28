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
  [@css ".css-ivpc4lp{place-content:center;}"];
  [@css ".css-ivpc4rc{place-content:start;}"];
  [@css ".css-ivpcvyz{place-content:end;}"];
  [@css ".css-ivpc45o{place-content:space-between;}"];
  [@css ".css-ivpcrqm{place-content:space-around;}"];
  [@css ".css-ivpck8g{place-content:space-evenly;}"];
  [@css ".css-ivpclpa{place-content:stretch;}"];
  [@css ".css-ivpc1n9{place-content:center start;}"];
  [@css ".css-ivpcnyx{place-content:start end;}"];
  [@css ".css-ivpcvll{place-content:space-between center;}"];
  [@css ".css-ivpczy8{place-items:center;}"];
  [@css ".css-ivpc2zi{place-items:start;}"];
  [@css ".css-ivpcn34{place-items:end;}"];
  [@css ".css-ivpcgg2{place-items:stretch;}"];
  [@css ".css-ivpc4rd{place-items:baseline;}"];
  [@css ".css-ivpcdqa{place-items:center start;}"];
  [@css ".css-ivpctdc{place-items:start end;}"];
  [@css ".css-ivpcpor{place-self:auto;}"];
  [@css ".css-ivpcugd{place-self:center;}"];
  [@css ".css-ivpci2w{place-self:start;}"];
  [@css ".css-ivpc7xj{place-self:end;}"];
  [@css ".css-ivpcpgy{place-self:stretch;}"];
  [@css ".css-ivpcpne{place-self:center start;}"];
  [@css ".css-ivpcqhb{place-self:start end;}"];
  [@css ".css-ivpc7gu{accent-color:auto;}"];
  [@css ".css-ivpcfnr{accent-color:red;}"];
  [@css ".css-ivpcq8h{accent-color:#ff0000;}"];
  [@css ".css-ivpc0ge{accent-color:rgb(255, 0, 0);}"];
  [@css ".css-ivpcwlh{touch-action:auto;}"];
  [@css ".css-ivpcsds{touch-action:none;}"];
  [@css ".css-ivpcsz4{touch-action:pan-x;}"];
  [@css ".css-ivpc34v{touch-action:pan-y;}"];
  [@css ".css-ivpc31p{touch-action:manipulation;}"];
  [@css ".css-ivpcy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-ivpcgbo{aspect-ratio:auto;}"];
  [@css ".css-ivpczp4{aspect-ratio:1 / 1;}"];
  [@css ".css-ivpci16{aspect-ratio:16 / 9;}"];
  [@css ".css-ivpciqd{aspect-ratio:0.5;}"];
  [@css.classes
    [
      ("css-ivpc4lp", 0, "", "input.re", 4, 8, 4, 29),
      ("css-ivpc4rc", 1, "", "input.re", 5, 8, 5, 28),
      ("css-ivpcvyz", 2, "", "input.re", 6, 8, 6, 26),
      ("css-ivpc45o", 3, "", "input.re", 7, 8, 7, 36),
      ("css-ivpcrqm", 4, "", "input.re", 8, 8, 8, 35),
      ("css-ivpck8g", 5, "", "input.re", 9, 8, 9, 35),
      ("css-ivpclpa", 6, "", "input.re", 10, 8, 10, 30),
      ("css-ivpc1n9", 7, "", "input.re", 11, 8, 11, 35),
      ("css-ivpcnyx", 8, "", "input.re", 12, 8, 12, 32),
      ("css-ivpcvll", 9, "", "input.re", 13, 8, 13, 43),
      ("css-ivpczy8", 10, "", "input.re", 16, 8, 16, 27),
      ("css-ivpc2zi", 11, "", "input.re", 17, 8, 17, 26),
      ("css-ivpcn34", 12, "", "input.re", 18, 8, 18, 24),
      ("css-ivpcgg2", 13, "", "input.re", 19, 8, 19, 28),
      ("css-ivpc4rd", 14, "", "input.re", 20, 8, 20, 29),
      ("css-ivpcdqa", 15, "", "input.re", 21, 8, 21, 33),
      ("css-ivpctdc", 16, "", "input.re", 22, 8, 22, 30),
      ("css-ivpcpor", 17, "", "input.re", 25, 8, 25, 24),
      ("css-ivpcugd", 18, "", "input.re", 26, 8, 26, 26),
      ("css-ivpci2w", 19, "", "input.re", 27, 8, 27, 25),
      ("css-ivpc7xj", 20, "", "input.re", 28, 8, 28, 23),
      ("css-ivpcpgy", 21, "", "input.re", 29, 8, 29, 27),
      ("css-ivpcpne", 22, "", "input.re", 30, 8, 30, 32),
      ("css-ivpcqhb", 23, "", "input.re", 31, 8, 31, 29),
      ("css-ivpc7gu", 24, "", "input.re", 34, 8, 34, 26),
      ("css-ivpcfnr", 25, "", "input.re", 35, 8, 35, 25),
      ("css-ivpcq8h", 26, "", "input.re", 36, 8, 36, 29),
      ("css-ivpc0ge", 27, "", "input.re", 37, 8, 37, 36),
      ("css-ivpcwlh", 28, "", "input.re", 40, 8, 40, 26),
      ("css-ivpcsds", 29, "", "input.re", 41, 8, 41, 26),
      ("css-ivpcsz4", 30, "", "input.re", 42, 8, 42, 27),
      ("css-ivpc34v", 31, "", "input.re", 43, 8, 43, 27),
      ("css-ivpc31p", 32, "", "input.re", 44, 8, 44, 34),
      ("css-ivpcy0g", 33, "", "input.re", 45, 8, 45, 33),
      ("css-ivpcgbo", 34, "", "input.re", 48, 8, 48, 26),
      ("css-ivpczp4", 35, "", "input.re", 49, 8, 49, 27),
      ("css-ivpci16", 36, "", "input.re", 50, 8, 50, 28),
      ("css-ivpciqd", 37, "", "input.re", 51, 8, 51, 25),
    ]
  ];
  
  CSS.make("css-ivpc4lp", []);
  CSS.make("css-ivpc4rc", []);
  CSS.make("css-ivpcvyz", []);
  CSS.make("css-ivpc45o", []);
  CSS.make("css-ivpcrqm", []);
  CSS.make("css-ivpck8g", []);
  CSS.make("css-ivpclpa", []);
  CSS.make("css-ivpc1n9", []);
  CSS.make("css-ivpcnyx", []);
  CSS.make("css-ivpcvll", []);
  
  CSS.make("css-ivpczy8", []);
  CSS.make("css-ivpc2zi", []);
  CSS.make("css-ivpcn34", []);
  CSS.make("css-ivpcgg2", []);
  CSS.make("css-ivpc4rd", []);
  CSS.make("css-ivpcdqa", []);
  CSS.make("css-ivpctdc", []);
  
  CSS.make("css-ivpcpor", []);
  CSS.make("css-ivpcugd", []);
  CSS.make("css-ivpci2w", []);
  CSS.make("css-ivpc7xj", []);
  CSS.make("css-ivpcpgy", []);
  CSS.make("css-ivpcpne", []);
  CSS.make("css-ivpcqhb", []);
  
  CSS.make("css-ivpc7gu", []);
  CSS.make("css-ivpcfnr", []);
  CSS.make("css-ivpcq8h", []);
  CSS.make("css-ivpc0ge", []);
  
  CSS.make("css-ivpcwlh", []);
  CSS.make("css-ivpcsds", []);
  CSS.make("css-ivpcsz4", []);
  CSS.make("css-ivpc34v", []);
  CSS.make("css-ivpc31p", []);
  CSS.make("css-ivpcy0g", []);
  
  CSS.make("css-ivpcgbo", []);
  CSS.make("css-ivpczp4", []);
  CSS.make("css-ivpci16", []);
  CSS.make("css-ivpciqd", []);
