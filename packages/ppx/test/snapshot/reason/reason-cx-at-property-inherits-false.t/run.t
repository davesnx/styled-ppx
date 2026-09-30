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
  [@css ".css-kusjgz{color:var(--color-1a279q8);}"];
  [@css ".css-lfbwy0:hover{color:var(--color-4uzv5u);}"];
  [@css "@media (max-width: 768px) {.css-19xpxeg{color:var(--color-km0lr0);}}"];
  [@css ".css-1g3cfa1 .child{color:var(--color-ump0qt);}"];
  [@css ".css-1d8si03{color:var(--color-7srqv7);}"];
  [@css ".css-1d8si03 .child{color:var(--color-7srqv7);}"];
  [@css ".css-1l36lcw{--brand:var(--str-vye19e);}"];
  [@css ".css-1vdqaxy::placeholder{color:var(--color-12r6fyr);}"];
  [@css ".css-yfluo3:before{color:var(--color-e7n16g);}"];
  [@css ".css-i81g8d{color:var(--color-xrtge);}"];
  [@css ".css-i81g8d::before{color:var(--color-xrtge);}"];
  [@css ".css-11o9ny0:focus-visible:not(:disabled){color:var(--color-f5c7x);}"];
  [@css.bindings
    [
      ("Output.topLevel", "cid-1lkhdb3", "css-kusjgz"),
      ("Output.hover", "cid-ng6izt", "css-lfbwy0"),
      ("Output.media", "cid-12d3e0w", "css-19xpxeg"),
      ("Output.descendant", "cid-1g3dzrb", "css-1g3cfa1"),
      ("Output.bundleSpan", "cid-ijx48y", "css-1d8si03"),
      ("Output.customFeeder", "cid-195hxjc", "css-1l36lcw"),
      ("Output.pseudoElement", "cid-4p9l0t", "css-1vdqaxy"),
      ("Output.legacyPseudoElement", "cid-4uo0i7", "css-yfluo3"),
      ("Output.mixedPseudo", "cid-1rr25fw", "css-i81g8d"),
      ("Output.pseudoClassOnly", "cid-1f0poos", "css-11o9ny0"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "label:topLevel cid-1lkhdb3 css-kusjgz",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "label:hover cid-ng6izt css-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "label:media cid-12d3e0w css-19xpxeg",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant cid-1g3dzrb css-1g3cfa1",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "label:bundleSpan cid-ijx48y css-1d8si03",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      "label:customFeeder cid-195hxjc css-1l36lcw",
      [("--str-vye19e", str)],
    );
  let pseudoElement =
    CSS.make(
      "label:pseudoElement cid-4p9l0t css-1vdqaxy",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "label:legacyPseudoElement cid-4uo0i7 css-yfluo3",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "label:mixedPseudo cid-1rr25fw css-i81g8d",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "label:pseudoClassOnly cid-1f0poos css-11o9ny0",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
