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
        "_ai7ZlHGBa",
        ["._ai7ZlHGBa{scroll-behavior:auto;}"],
        1,
        0,
        1,
        [("value", "ZlHGBa", "val\\0i7\\0& | \\0scroll-behavior:auto")],
      ),
      (
        "_ai7KfM3by",
        ["._ai7KfM3by{scroll-behavior:smooth;}"],
        1,
        0,
        1,
        [("value", "KfM3by", "val\\0i7\\0& | \\0scroll-behavior:smooth")],
      ),
    ]
  ];
  
  CSS.make("_ai7ZlHGBa", []);
  CSS.make("_ai7KfM3by", []);
