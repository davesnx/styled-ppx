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
        "_amfzHyxKC",
        ["._amfzHyxKC{transition-timing-function:steps(2, jump-start);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "zHyxKC",
            "val\\0mf\\0& | \\0transition-timing-function:steps(2, jump-start)",
          ),
        ],
      ),
      (
        "_amfV-b2cK",
        ["._amfV-b2cK{transition-timing-function:steps(2, jump-end);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "V-b2cK",
            "val\\0mf\\0& | \\0transition-timing-function:steps(2, jump-end)",
          ),
        ],
      ),
      (
        "_amfmdS38V",
        ["._amfmdS38V{transition-timing-function:steps(1, jump-both);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "mdS38V",
            "val\\0mf\\0& | \\0transition-timing-function:steps(1, jump-both)",
          ),
        ],
      ),
      (
        "_amfQFLcwZ",
        ["._amfQFLcwZ{transition-timing-function:steps(2, jump-none);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QFLcwZ",
            "val\\0mf\\0& | \\0transition-timing-function:steps(2, jump-none)",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_amfzHyxKC", []);
  CSS.make("_amfV-b2cK", []);
  CSS.make("_amfmdS38V", []);
  CSS.make("_amfQFLcwZ", []);
