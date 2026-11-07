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
        "_ajmyI8KHN",
        ["._ajmyI8KHN{scrollbar-color:auto;}"],
        1,
        0,
        1,
        [("value", "yI8KHN", "val\\0jm\\0& | \\0scrollbar-color:auto")],
      ),
      (
        "_ajmErp0vz",
        ["._ajmErp0vz{scrollbar-color:red blue;}"],
        1,
        0,
        1,
        [("value", "Erp0vz", "val\\0jm\\0& | \\0scrollbar-color:red blue")],
      ),
      (
        "_ajuloHo31",
        ["._ajuloHo31{scrollbar-width:auto;}"],
        1,
        0,
        1,
        [("value", "loHo31", "val\\0ju\\0& | \\0scrollbar-width:auto")],
      ),
      (
        "_aju-4wQmT",
        ["._aju-4wQmT{scrollbar-width:thin;}"],
        1,
        0,
        1,
        [("value", "-4wQmT", "val\\0ju\\0& | \\0scrollbar-width:thin")],
      ),
      (
        "_ajuBrB5_I",
        ["._ajuBrB5_I{scrollbar-width:none;}"],
        1,
        0,
        1,
        [("value", "BrB5_I", "val\\0ju\\0& | \\0scrollbar-width:none")],
      ),
    ]
  ];
  
  CSS.make("_ajmyI8KHN", []);
  CSS.make("_ajmErp0vz", []);
  CSS.make("_ajuloHo31", []);
  CSS.make("_aju-4wQmT", []);
  CSS.make("_ajuBrB5_I", []);
