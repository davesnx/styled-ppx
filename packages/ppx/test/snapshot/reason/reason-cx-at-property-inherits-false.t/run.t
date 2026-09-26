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
  [@css ".a-4esjgz{color:var(--color-1a279q8);}"];
  [@css ".a-qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}"];
  [@css
    "@media (max-width: 768px) {.a-5eyct4epxeg{color:var(--color-km0lr0);}}"
  ];
  [@css ".a-s19nz4ecfa1 .child{color:var(--color-ump0qt);}"];
  [@css ".in-1d8si03{color:var(--color-7srqv7);}"];
  [@css ".in-1d8si03 .child{color:var(--color-7srqv7);}"];
  [@css ".a-zytoc7ez6lcw{--brand:var(--str-vye19e);}"];
  [@css ".a-wu9h64eqaxy::placeholder{color:var(--color-12r6fyr);}"];
  [@css ".a-bzw494eluo3:before{color:var(--color-e7n16g);}"];
  [@css ".in-i81g8d{color:var(--color-xrtge);}"];
  [@css ".in-i81g8d::before{color:var(--color-xrtge);}"];
  [@css
    ".a-2f3u04e9ny0:focus-visible:not(:disabled){color:var(--color-f5c7x);}"
  ];
  [@css.bindings
    [
      ("Output.topLevel", "id-1lkhdb3", "a-4esjgz"),
      ("Output.hover", "id-ng6izt", "a-qyw7u4ebwy0"),
      ("Output.media", "id-12d3e0w", "a-5eyct4epxeg"),
      ("Output.descendant", "id-1g3dzrb", "a-s19nz4ecfa1"),
      ("Output.bundleSpan", "id-ijx48y", "in-1d8si03"),
      ("Output.customFeeder", "id-195hxjc", "a-zytoc7ez6lcw"),
      ("Output.pseudoElement", "id-4p9l0t", "a-wu9h64eqaxy"),
      ("Output.legacyPseudoElement", "id-4uo0i7", "a-bzw494eluo3"),
      ("Output.mixedPseudo", "id-1rr25fw", "in-i81g8d"),
      ("Output.pseudoClassOnly", "id-1f0poos", "a-2f3u04e9ny0"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "label:topLevel id-1lkhdb3 a-4esjgz",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "label:hover id-ng6izt a-qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "label:media id-12d3e0w a-5eyct4epxeg",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant id-1g3dzrb a-s19nz4ecfa1",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "label:bundleSpan id-ijx48y in-1d8si03",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      "label:customFeeder id-195hxjc a-zytoc7ez6lcw",
      [("--str-vye19e", str)],
    );
  let pseudoElement =
    CSS.make(
      "label:pseudoElement id-4p9l0t a-wu9h64eqaxy",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "label:legacyPseudoElement id-4uo0i7 a-bzw494eluo3",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "label:mixedPseudo id-1rr25fw in-i81g8d",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "label:pseudoClassOnly id-1f0poos a-2f3u04e9ny0",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
