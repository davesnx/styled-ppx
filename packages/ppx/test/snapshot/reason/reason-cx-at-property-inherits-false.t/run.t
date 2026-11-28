Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdiv5yh{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivxz4{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivuab{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivwoc{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivik3{syntax:\"*\";inherits:false;}"];
  [@css ".css-vdiv5va{color:var(--vdiv5yh);}"];
  [@css ".css-vdiv1m4:hover{color:var(--vdivxz4);}"];
  [@css "@media (max-width: 768px) {.css-vdiv8qx{color:var(--vdivuab);}}"];
  [@css ".css-vdiv0ye .child{color:var(--vdiv4aa);}"];
  [@css
    ".css-vdivorz{color:var(--vdivdce);}.css-vdivorz .child{color:var(--vdivdce);}"
  ];
  [@css ".css-vdivnay{--brand:var(--vdivwoc);}"];
  [@css ".css-vdiv1ea::placeholder{color:var(--vdivdpb);}"];
  [@css ".css-vdivprh:before{color:var(--vdivbcs);}"];
  [@css
    ".css-vdiv24y{color:var(--vdiv3g0);}.css-vdiv24y::before{color:var(--vdiv3g0);}"
  ];
  [@css ".css-vdiv5cb:focus-visible:not(:disabled){color:var(--vdivik3);}"];
  [@css.classes
    [
      ("css-vdiv5va", 5, "Output.topLevel", "output.ml", 3, 24, 3, 40),
      ("css-vdiv1m4", 6, "Output.hover", "output.ml", 4, 21, 4, 49),
      ("css-vdiv8qx", 7, "Output.media", "output.ml", 5, 21, 5, 67),
      ("css-vdiv0ye", 8, "Output.descendant", "output.ml", 6, 26, 6, 55),
      ("css-vdivorz", 9, "Output.bundleSpan", "output.ml", 7, 26, 7, 72),
      ("css-vdivnay", 10, "Output.customFeeder", "output.ml", 8, 28, 8, 44),
      ("css-vdiv1ea", 11, "Output.pseudoElement", "output.ml", 9, 29, 9, 64),
      (
        "css-vdivprh",
        12,
        "Output.legacyPseudoElement",
        "output.ml",
        10,
        35,
        10,
        64,
      ),
      ("css-vdiv24y", 13, "Output.mixedPseudo", "output.ml", 11, 27, 11, 74),
      (
        "css-vdiv5cb",
        14,
        "Output.pseudoClassOnly",
        "output.ml",
        13,
        11,
        13,
        62,
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.topLevel", "css-vdiv5va"),
      ("Output.hover", "css-vdiv1m4"),
      ("Output.media", "css-vdiv8qx"),
      ("Output.descendant", "css-vdiv0ye"),
      ("Output.bundleSpan", "css-vdivorz"),
      ("Output.customFeeder", "css-vdivnay"),
      ("Output.pseudoElement", "css-vdiv1ea"),
      ("Output.legacyPseudoElement", "css-vdivprh"),
      ("Output.mixedPseudo", "css-vdiv24y"),
      ("Output.pseudoClassOnly", "css-vdiv5cb"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "css-vdiv5va",
      [("--vdiv5yh", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "css-vdiv1m4",
      [("--vdivxz4", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "css-vdiv8qx",
      [("--vdivuab", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-vdiv0ye",
      [("--vdiv4aa", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "css-vdivorz",
      [("--vdivdce", CSS.Types.Color.toString(color))],
    );
  let customFeeder = CSS.make("css-vdivnay", [("--vdivwoc", str)]);
  let pseudoElement =
    CSS.make(
      "css-vdiv1ea",
      [("--vdivdpb", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "css-vdivprh",
      [("--vdivbcs", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "css-vdiv24y",
      [("--vdiv3g0", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "css-vdiv5cb",
      [("--vdivik3", CSS.Types.Color.toString(color))],
    );
