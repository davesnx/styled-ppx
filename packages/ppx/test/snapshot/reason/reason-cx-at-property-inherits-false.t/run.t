Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --tbo6db-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1nwsrnf-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --t7ir21-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1jq0xkw-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --j23bpj-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-tbo6db{color:var(--tbo6db-0);}"];
  [@css ".css-1nwsrnf:hover{color:var(--1nwsrnf-0);}"];
  [@css "@media (max-width: 768px) {.css-t7ir21{color:var(--t7ir21-0);}}"];
  [@css ".css-ayrq8n .child{color:var(--ayrq8n-0);}"];
  [@css
    ".css-an466{color:var(--an466-0);}.css-an466 .child{color:var(--an466-0);}"
  ];
  [@css ".css-1jq0xkw{--brand:var(--1jq0xkw-0);}"];
  [@css ".css-17egz3b::placeholder{color:var(--17egz3b-0);}"];
  [@css ".css-ankr2b:before{color:var(--ankr2b-0);}"];
  [@css
    ".css-1nz5l2a{color:var(--1nz5l2a-0);}.css-1nz5l2a::before{color:var(--1nz5l2a-0);}"
  ];
  [@css ".css-j23bpj:focus-visible:not(:disabled){color:var(--j23bpj-0);}"];
  [@css.classes
    [
      ("css-tbo6db", 5, "Output.topLevel", "output.ml", 3, 24, 3, 40),
      ("css-1nwsrnf", 6, "Output.hover", "output.ml", 4, 21, 4, 49),
      ("css-t7ir21", 7, "Output.media", "output.ml", 5, 21, 5, 67),
      ("css-ayrq8n", 8, "Output.descendant", "output.ml", 6, 26, 6, 55),
      ("css-an466", 9, "Output.bundleSpan", "output.ml", 7, 26, 7, 72),
      ("css-1jq0xkw", 10, "Output.customFeeder", "output.ml", 8, 28, 8, 44),
      ("css-17egz3b", 11, "Output.pseudoElement", "output.ml", 9, 29, 9, 64),
      (
        "css-ankr2b",
        12,
        "Output.legacyPseudoElement",
        "output.ml",
        10,
        35,
        10,
        64,
      ),
      ("css-1nz5l2a", 13, "Output.mixedPseudo", "output.ml", 11, 27, 11, 74),
      ("css-j23bpj", 14, "Output.pseudoClassOnly", "output.ml", 13, 11, 13, 62),
    ]
  ];
  [@css.bindings
    [
      ("Output.topLevel", "css-tbo6db"),
      ("Output.hover", "css-1nwsrnf"),
      ("Output.media", "css-t7ir21"),
      ("Output.descendant", "css-ayrq8n"),
      ("Output.bundleSpan", "css-an466"),
      ("Output.customFeeder", "css-1jq0xkw"),
      ("Output.pseudoElement", "css-17egz3b"),
      ("Output.legacyPseudoElement", "css-ankr2b"),
      ("Output.mixedPseudo", "css-1nz5l2a"),
      ("Output.pseudoClassOnly", "css-j23bpj"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "css-tbo6db",
      [("--tbo6db-0", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "css-1nwsrnf",
      [("--1nwsrnf-0", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "css-t7ir21",
      [("--t7ir21-0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-ayrq8n",
      [("--ayrq8n-0", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make("css-an466", [("--an466-0", CSS.Types.Color.toString(color))]);
  let customFeeder = CSS.make("css-1jq0xkw", [("--1jq0xkw-0", str)]);
  let pseudoElement =
    CSS.make(
      "css-17egz3b",
      [("--17egz3b-0", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "css-ankr2b",
      [("--ankr2b-0", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "css-1nz5l2a",
      [("--1nz5l2a-0", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "css-j23bpj",
      [("--j23bpj-0", CSS.Types.Color.toString(color))],
    );
