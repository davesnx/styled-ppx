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
  [@css ".css-fb4lp{place-content:center;}"];
  [@css ".css-mjd4rc{place-content:start;}"];
  [@css ".css-k85vyz{place-content:end;}"];
  [@css ".css-d8545o{place-content:space-between;}"];
  [@css ".css-iu4rqm{place-content:space-around;}"];
  [@css ".css-1vj8k8g{place-content:space-evenly;}"];
  [@css ".css-1rctlpa{place-content:stretch;}"];
  [@css ".css-h7p1n9{place-content:center start;}"];
  [@css ".css-1r4snyx{place-content:start end;}"];
  [@css ".css-10wivll{place-content:space-between center;}"];
  [@css ".css-tybzy8{place-items:center;}"];
  [@css ".css-1xd62zi{place-items:start;}"];
  [@css ".css-di9n34{place-items:end;}"];
  [@css ".css-uhbgg2{place-items:stretch;}"];
  [@css ".css-6zd4rd{place-items:baseline;}"];
  [@css ".css-ai8dqa{place-items:center start;}"];
  [@css ".css-1oretdc{place-items:start end;}"];
  [@css ".css-1v4jpor{place-self:auto;}"];
  [@css ".css-q1sugd{place-self:center;}"];
  [@css ".css-x9li2w{place-self:start;}"];
  [@css ".css-1llw7xj{place-self:end;}"];
  [@css ".css-143fpgy{place-self:stretch;}"];
  [@css ".css-9urpne{place-self:center start;}"];
  [@css ".css-4dyqhb{place-self:start end;}"];
  [@css ".css-t857gu{accent-color:auto;}"];
  [@css ".css-snefnr{accent-color:red;}"];
  [@css ".css-12uuq8h{accent-color:#ff0000;}"];
  [@css ".css-tq10ge{accent-color:rgb(255, 0, 0);}"];
  [@css ".css-py8wlh{touch-action:auto;}"];
  [@css ".css-ovmsds{touch-action:none;}"];
  [@css ".css-sossz4{touch-action:pan-x;}"];
  [@css ".css-119h34v{touch-action:pan-y;}"];
  [@css ".css-1h8x31p{touch-action:manipulation;}"];
  [@css ".css-4ahy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-s9cgbo{aspect-ratio:auto;}"];
  [@css ".css-13tjzp4{aspect-ratio:1 / 1;}"];
  [@css ".css-7sbi16{aspect-ratio:16 / 9;}"];
  [@css ".css-6qtiqd{aspect-ratio:0.5;}"];
  [@css.classes
    [
      ("css-fb4lp", 0, "", "input.re", 4, 8, 4, 29),
      ("css-mjd4rc", 1, "", "input.re", 5, 8, 5, 28),
      ("css-k85vyz", 2, "", "input.re", 6, 8, 6, 26),
      ("css-d8545o", 3, "", "input.re", 7, 8, 7, 36),
      ("css-iu4rqm", 4, "", "input.re", 8, 8, 8, 35),
      ("css-1vj8k8g", 5, "", "input.re", 9, 8, 9, 35),
      ("css-1rctlpa", 6, "", "input.re", 10, 8, 10, 30),
      ("css-h7p1n9", 7, "", "input.re", 11, 8, 11, 35),
      ("css-1r4snyx", 8, "", "input.re", 12, 8, 12, 32),
      ("css-10wivll", 9, "", "input.re", 13, 8, 13, 43),
      ("css-tybzy8", 10, "", "input.re", 16, 8, 16, 27),
      ("css-1xd62zi", 11, "", "input.re", 17, 8, 17, 26),
      ("css-di9n34", 12, "", "input.re", 18, 8, 18, 24),
      ("css-uhbgg2", 13, "", "input.re", 19, 8, 19, 28),
      ("css-6zd4rd", 14, "", "input.re", 20, 8, 20, 29),
      ("css-ai8dqa", 15, "", "input.re", 21, 8, 21, 33),
      ("css-1oretdc", 16, "", "input.re", 22, 8, 22, 30),
      ("css-1v4jpor", 17, "", "input.re", 25, 8, 25, 24),
      ("css-q1sugd", 18, "", "input.re", 26, 8, 26, 26),
      ("css-x9li2w", 19, "", "input.re", 27, 8, 27, 25),
      ("css-1llw7xj", 20, "", "input.re", 28, 8, 28, 23),
      ("css-143fpgy", 21, "", "input.re", 29, 8, 29, 27),
      ("css-9urpne", 22, "", "input.re", 30, 8, 30, 32),
      ("css-4dyqhb", 23, "", "input.re", 31, 8, 31, 29),
      ("css-t857gu", 24, "", "input.re", 34, 8, 34, 26),
      ("css-snefnr", 25, "", "input.re", 35, 8, 35, 25),
      ("css-12uuq8h", 26, "", "input.re", 36, 8, 36, 29),
      ("css-tq10ge", 27, "", "input.re", 37, 8, 37, 36),
      ("css-py8wlh", 28, "", "input.re", 40, 8, 40, 26),
      ("css-ovmsds", 29, "", "input.re", 41, 8, 41, 26),
      ("css-sossz4", 30, "", "input.re", 42, 8, 42, 27),
      ("css-119h34v", 31, "", "input.re", 43, 8, 43, 27),
      ("css-1h8x31p", 32, "", "input.re", 44, 8, 44, 34),
      ("css-4ahy0g", 33, "", "input.re", 45, 8, 45, 33),
      ("css-s9cgbo", 34, "", "input.re", 48, 8, 48, 26),
      ("css-13tjzp4", 35, "", "input.re", 49, 8, 49, 27),
      ("css-7sbi16", 36, "", "input.re", 50, 8, 50, 28),
      ("css-6qtiqd", 37, "", "input.re", 51, 8, 51, 25),
    ]
  ];
  
  CSS.make("css-fb4lp", []);
  CSS.make("css-mjd4rc", []);
  CSS.make("css-k85vyz", []);
  CSS.make("css-d8545o", []);
  CSS.make("css-iu4rqm", []);
  CSS.make("css-1vj8k8g", []);
  CSS.make("css-1rctlpa", []);
  CSS.make("css-h7p1n9", []);
  CSS.make("css-1r4snyx", []);
  CSS.make("css-10wivll", []);
  
  CSS.make("css-tybzy8", []);
  CSS.make("css-1xd62zi", []);
  CSS.make("css-di9n34", []);
  CSS.make("css-uhbgg2", []);
  CSS.make("css-6zd4rd", []);
  CSS.make("css-ai8dqa", []);
  CSS.make("css-1oretdc", []);
  
  CSS.make("css-1v4jpor", []);
  CSS.make("css-q1sugd", []);
  CSS.make("css-x9li2w", []);
  CSS.make("css-1llw7xj", []);
  CSS.make("css-143fpgy", []);
  CSS.make("css-9urpne", []);
  CSS.make("css-4dyqhb", []);
  
  CSS.make("css-t857gu", []);
  CSS.make("css-snefnr", []);
  CSS.make("css-12uuq8h", []);
  CSS.make("css-tq10ge", []);
  
  CSS.make("css-py8wlh", []);
  CSS.make("css-ovmsds", []);
  CSS.make("css-sossz4", []);
  CSS.make("css-119h34v", []);
  CSS.make("css-1h8x31p", []);
  CSS.make("css-4ahy0g", []);
  
  CSS.make("css-s9cgbo", []);
  CSS.make("css-13tjzp4", []);
  CSS.make("css-7sbi16", []);
  CSS.make("css-6qtiqd", []);
