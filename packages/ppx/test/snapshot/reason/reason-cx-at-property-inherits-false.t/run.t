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
  [@css ".in-kusjgz{color:var(--color-1a279q8);}"];
  [@css ".in-lfbwy0:hover{color:var(--color-4uzv5u);}"];
  [@css "@media (max-width: 768px) {.in-19xpxeg{color:var(--color-km0lr0);}}"];
  [@css ".in-1g3cfa1 .child{color:var(--color-ump0qt);}"];
  [@css ".in-1d8si03{color:var(--color-7srqv7);}"];
  [@css ".in-1d8si03 .child{color:var(--color-7srqv7);}"];
  [@css ".in-1l36lcw{--brand:var(--str-vye19e);}"];
  [@css ".in-1vdqaxy::placeholder{color:var(--color-12r6fyr);}"];
  [@css ".in-yfluo3:before{color:var(--color-e7n16g);}"];
  [@css ".in-i81g8d{color:var(--color-xrtge);}"];
  [@css ".in-i81g8d::before{color:var(--color-xrtge);}"];
  [@css ".in-11o9ny0:focus-visible:not(:disabled){color:var(--color-f5c7x);}"];
  [@css.bindings
    [
      ("Output.topLevel", "id-1lkhdb3", "in-kusjgz"),
      ("Output.hover", "id-ng6izt", "in-lfbwy0"),
      ("Output.media", "id-12d3e0w", "in-19xpxeg"),
      ("Output.descendant", "id-1g3dzrb", "in-1g3cfa1"),
      ("Output.bundleSpan", "id-ijx48y", "in-1d8si03"),
      ("Output.customFeeder", "id-195hxjc", "in-1l36lcw"),
      ("Output.pseudoElement", "id-4p9l0t", "in-1vdqaxy"),
      ("Output.legacyPseudoElement", "id-4uo0i7", "in-yfluo3"),
      ("Output.mixedPseudo", "id-1rr25fw", "in-i81g8d"),
      ("Output.pseudoClassOnly", "id-1f0poos", "in-11o9ny0"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "label:topLevel id-1lkhdb3 in-kusjgz",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "label:hover id-ng6izt in-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "label:media id-12d3e0w in-19xpxeg",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant id-1g3dzrb in-1g3cfa1",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "label:bundleSpan id-ijx48y in-1d8si03",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      "label:customFeeder id-195hxjc in-1l36lcw",
      [("--str-vye19e", str)],
    );
  let pseudoElement =
    CSS.make(
      "label:pseudoElement id-4p9l0t in-1vdqaxy",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "label:legacyPseudoElement id-4uo0i7 in-yfluo3",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "label:mixedPseudo id-1rr25fw in-i81g8d",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "label:pseudoClassOnly id-1f0poos in-11o9ny0",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
