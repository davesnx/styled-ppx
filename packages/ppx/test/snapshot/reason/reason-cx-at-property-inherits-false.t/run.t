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
  [@css "._a_4esjgz{color:var(--color-1a279q8);}"];
  [@css "._a_qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}"];
  [@css
    "@media (max-width: 768px) {._a_5eyct4epxeg{color:var(--color-km0lr0);}}"
  ];
  [@css "._a_s19nz4ecfa1 .child{color:var(--color-ump0qt);}"];
  [@css "._in_1d8si03{color:var(--color-7srqv7);}"];
  [@css "._in_1d8si03 .child{color:var(--color-7srqv7);}"];
  [@css "._a_zytoc7ez6lcw{--brand:var(--str-vye19e);}"];
  [@css "._a_wu9h64eqaxy::placeholder{color:var(--color-12r6fyr);}"];
  [@css "._a_bzw494eluo3:before{color:var(--color-e7n16g);}"];
  [@css "._in_i81g8d{color:var(--color-xrtge);}"];
  [@css "._in_i81g8d::before{color:var(--color-xrtge);}"];
  [@css
    "._a_2f3u04e9ny0:focus-visible:not(:disabled){color:var(--color-f5c7x);}"
  ];
  [@css.bindings
    [
      ("Output.topLevel", "_id_1lkhdb3", "_a_4esjgz"),
      ("Output.hover", "_id_ng6izt", "_a_qyw7u4ebwy0"),
      ("Output.media", "_id_12d3e0w", "_a_5eyct4epxeg"),
      ("Output.descendant", "_id_1g3dzrb", "_a_s19nz4ecfa1"),
      ("Output.bundleSpan", "_id_ijx48y", "_in_1d8si03"),
      ("Output.customFeeder", "_id_195hxjc", "_a_zytoc7ez6lcw"),
      ("Output.pseudoElement", "_id_4p9l0t", "_a_wu9h64eqaxy"),
      ("Output.legacyPseudoElement", "_id_4uo0i7", "_a_bzw494eluo3"),
      ("Output.mixedPseudo", "_id_1rr25fw", "_in_i81g8d"),
      ("Output.pseudoClassOnly", "_id_1f0poos", "_a_2f3u04e9ny0"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "label:topLevel _id_1lkhdb3 _a_4esjgz",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "label:hover _id_ng6izt _a_qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "label:media _id_12d3e0w _a_5eyct4epxeg",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant _id_1g3dzrb _a_s19nz4ecfa1",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "label:bundleSpan _id_ijx48y _in_1d8si03",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      "label:customFeeder _id_195hxjc _a_zytoc7ez6lcw",
      [("--str-vye19e", str)],
    );
  let pseudoElement =
    CSS.make(
      "label:pseudoElement _id_4p9l0t _a_wu9h64eqaxy",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "label:legacyPseudoElement _id_4uo0i7 _a_bzw494eluo3",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "label:mixedPseudo _id_1rr25fw _in_i81g8d",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "label:pseudoClassOnly _id_1f0poos _a_2f3u04e9ny0",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
