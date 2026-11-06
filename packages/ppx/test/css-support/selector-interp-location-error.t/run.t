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
  File "input.re", line 8, characters 20-21:
  8 |   .lolaso :nth-chil(2) {
                          ^
  Error: Parse error while reading token '2'
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_c7fGwfMTaoDDk77",
        ["._c7fGwfMTaoDDk77 .lolaso :nth-child(2n){color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "GwfMTa", "ctx\\0& .lolaso :nth-child(2n) | "),
          (
            "value",
            "oDDk77",
            "val\\07f\\0& .lolaso :nth-child(2n) | \\0color:red",
          ),
        ],
      ),
      (
        "_i1g5OUSB_",
        [],
        1,
        0,
        0,
        [("id", "_i1g5OUSB_", "bind\\0\\0Input\\0\\0_className\\00")],
      ),
      (
        "_i3MedpYGS",
        [],
        1,
        0,
        0,
        [("id", "_i3MedpYGS", "bind\\0\\0Input\\0\\0_className\\01")],
      ),
    ]
  ];
  [@css.bindings
    [("Input._className", "_i1g5OUSB_ _c7fGwfMTaoDDk77", "_i1g5OUSB_")]
  ];
  let _className = CSS.make("_i1g5OUSB_ _c7fGwfMTaoDDk77", []);
  
  let _className = [%ocaml.error "Parse error while reading token '2'"];
