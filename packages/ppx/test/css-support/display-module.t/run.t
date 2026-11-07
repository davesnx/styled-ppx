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
        "_a9fXTSzld",
        ["._a9fXTSzld{display:run-in;}"],
        1,
        0,
        1,
        [("value", "XTSzld", "val\\09f\\0& | \\0display:run-in")],
      ),
      (
        "_a9fDK0rS_",
        ["._a9fDK0rS_{display:flow;}"],
        1,
        0,
        1,
        [("value", "DK0rS_", "val\\09f\\0& | \\0display:flow")],
      ),
      (
        "_a9fN33yZ8",
        ["._a9fN33yZ8{display:flow-root;}"],
        1,
        0,
        1,
        [("value", "N33yZ8", "val\\09f\\0& | \\0display:flow-root")],
      ),
    ]
  ];
  
  CSS.make("_a9fXTSzld", []);
  CSS.make("_a9fDK0rS_", []);
  CSS.make("_a9fN33yZ8", []);
