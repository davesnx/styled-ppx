Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4uzv5u{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-km0lr0{syntax:\"*\";inherits:false;}"];
  [@css "@property --str-vye19e{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-f5c7x{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._a_4esjgz{color:var(--color-1a279q8);}",
      "_a_4esjgz",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}",
      "_a_qyw7u4ebwy0",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "@media (max-width: 768px) {._a_5eyct4epxeg{color:var(--color-km0lr0);}}",
      "_a_5eyct4epxeg",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_s19nz4ecfa1 .child{color:var(--color-ump0qt);}",
      "_a_s19nz4ecfa1",
      "0,2,0 & .child",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_1d8si03{color:var(--color-7srqv7);}",
      "_in_1d8si03",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_1d8si03 .child{color:var(--color-7srqv7);}",
      "_in_1d8si03",
      "0,2,0 & .child",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_zytoc7ez6lcw{--brand:var(--str-vye19e);}",
      "_a_zytoc7ez6lcw",
      "0,1,0 own",
      "-c1794399371",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_wu9h64eqaxy::placeholder{color:var(--color-12r6fyr);}",
      "_a_wu9h64eqaxy",
      "0,1,1 own::placeholder",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bzw494eluo3:before{color:var(--color-e7n16g);}",
      "_a_bzw494eluo3",
      "0,1,1 own::before",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_i81g8d{color:var(--color-xrtge);}",
      "_in_i81g8d",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_i81g8d::before{color:var(--color-xrtge);}",
      "_in_i81g8d",
      "0,1,1 own::before",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2f3u04e9ny0:focus-visible:not(:disabled){color:var(--color-f5c7x);}",
      "_a_2f3u04e9ny0",
      "0,3,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Output.topLevel", "_id_1irk6xv", "_a_4esjgz"),
      ("Output.hover", "_id_mr18po", "_a_qyw7u4ebwy0"),
      ("Output.media", "_id_uamjpv", "_a_5eyct4epxeg"),
      ("Output.descendant", "_id_1rit82z", "_a_s19nz4ecfa1"),
      ("Output.bundleSpan", "_id_9xjcax", "_in_1d8si03"),
      ("Output.customFeeder", "_id_1d4j48d", "_a_zytoc7ez6lcw"),
      ("Output.pseudoElement", "_id_d6e0cy", "_a_wu9h64eqaxy"),
      ("Output.legacyPseudoElement", "_id_ynlnh2", "_a_bzw494eluo3"),
      ("Output.mixedPseudo", "_id_mkdw82", "_in_i81g8d"),
      ("Output.pseudoClassOnly", "_id_z1a0vh", "_a_2f3u04e9ny0"),
    ]
  ];
  [@css.blocks
    [
      (3, "_id_1irk6xv", [5]),
      (4, "_id_mr18po", [6]),
      (5, "_id_uamjpv", [7]),
      (6, "_id_1rit82z", [8]),
      (7, "_id_9xjcax", [9, 10]),
      (8, "_id_1d4j48d", [11]),
      (9, "_id_d6e0cy", [12]),
      (10, "_id_ynlnh2", [13]),
      (11, "_id_mkdw82", [14, 15]),
      (13, "_id_z1a0vh", [16]),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "label:topLevel _id_1irk6xv _a_4esjgz",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "label:hover _id_mr18po _a_qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "label:media _id_uamjpv _a_5eyct4epxeg",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant _id_1rit82z _a_s19nz4ecfa1",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "label:bundleSpan _id_9xjcax _in_1d8si03",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      "label:customFeeder _id_1d4j48d _a_zytoc7ez6lcw",
      [("--str-vye19e", str)],
    );
  let pseudoElement =
    CSS.make(
      "label:pseudoElement _id_d6e0cy _a_wu9h64eqaxy",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "label:legacyPseudoElement _id_ynlnh2 _a_bzw494eluo3",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "label:mixedPseudo _id_mkdw82 _in_i81g8d",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "label:pseudoClassOnly _id_z1a0vh _a_2f3u04e9ny0",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
