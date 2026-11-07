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
        "_a7f1uACxj",
        ["._a7f1uACxj{color:unset;}"],
        1,
        0,
        1,
        [("value", "1uACxj", "val\\07f\\0& | \\0color:unset")],
      ),
      (
        "_aarAJVKRb",
        ["._aarAJVKRb{font-weight:unset;}"],
        1,
        0,
        1,
        [("value", "AJVKRb", "val\\0ar\\0& | \\0font-weight:unset")],
      ),
      (
        "_a4mK43YTa",
        ["._a4mK43YTa{background-image:unset;}"],
        1,
        0,
        1,
        [("value", "K43YTa", "val\\04m\\0& | \\0background-image:unset")],
      ),
      (
        "_an8bLfdcd",
        ["._an8bLfdcd{width:unset;}"],
        1,
        0,
        1,
        [("value", "bLfdcd", "val\\0n8\\0& | \\0width:unset")],
      ),
    ]
  ];
  
  CSS.make("_a7f1uACxj", []);
  CSS.make("_aarAJVKRb", []);
  CSS.make("_a4mK43YTa", []);
  CSS.make("_an8bLfdcd", []);
