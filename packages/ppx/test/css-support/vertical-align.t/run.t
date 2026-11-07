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
  [@css.atoms
    [
      (
        "_amnD6ttRX",
        ["._amnD6ttRX{vertical-align:baseline;}"],
        1,
        0,
        1,
        [("value", "D6ttRX", "val\\0mn\\0& | \\0vertical-align:baseline")],
      ),
      (
        "_amnFJVvVm",
        ["._amnFJVvVm{vertical-align:sub;}"],
        1,
        0,
        1,
        [("value", "FJVvVm", "val\\0mn\\0& | \\0vertical-align:sub")],
      ),
      (
        "_amnYGRDw7",
        ["._amnYGRDw7{vertical-align:super;}"],
        1,
        0,
        1,
        [("value", "YGRDw7", "val\\0mn\\0& | \\0vertical-align:super")],
      ),
      (
        "_amnHcrflz",
        ["._amnHcrflz{vertical-align:top;}"],
        1,
        0,
        1,
        [("value", "Hcrflz", "val\\0mn\\0& | \\0vertical-align:top")],
      ),
      (
        "_amnNnlIhV",
        ["._amnNnlIhV{vertical-align:text-top;}"],
        1,
        0,
        1,
        [("value", "NnlIhV", "val\\0mn\\0& | \\0vertical-align:text-top")],
      ),
      (
        "_amnjMTvWq",
        ["._amnjMTvWq{vertical-align:middle;}"],
        1,
        0,
        1,
        [("value", "jMTvWq", "val\\0mn\\0& | \\0vertical-align:middle")],
      ),
      (
        "_amnQsRMIa",
        ["._amnQsRMIa{vertical-align:bottom;}"],
        1,
        0,
        1,
        [("value", "QsRMIa", "val\\0mn\\0& | \\0vertical-align:bottom")],
      ),
      (
        "_amnYzltok",
        ["._amnYzltok{vertical-align:text-bottom;}"],
        1,
        0,
        1,
        [("value", "Yzltok", "val\\0mn\\0& | \\0vertical-align:text-bottom")],
      ),
    ]
  ];
  CSS.make("_amnD6ttRX", []);
  CSS.make("_amnFJVvVm", []);
  CSS.make("_amnYGRDw7", []);
  CSS.make("_amnHcrflz", []);
  CSS.make("_amnNnlIhV", []);
  CSS.make("_amnjMTvWq", []);
  CSS.make("_amnQsRMIa", []);
  CSS.make("_amnYzltok", []);
