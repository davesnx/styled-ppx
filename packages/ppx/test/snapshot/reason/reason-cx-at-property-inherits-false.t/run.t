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
  [@css ".css-kusjgz-topLevel{color:var(--color-1a279q8);}"];
  [@css ".css-lfbwy0-hover:hover{color:var(--color-4uzv5u);}"];
  [@css
    "@media (max-width: 768px) {.css-19xpxeg-media{color:var(--color-km0lr0);}}"
  ];
  [@css ".css-1g3cfa1-descendant .child{color:var(--color-ump0qt);}"];
  [@css ".css-1d8si03-bundleSpan{color:var(--color-7srqv7);}"];
  [@css ".css-1d8si03-bundleSpan .child{color:var(--color-7srqv7);}"];
  [@css ".css-1l36lcw-customFeeder{--brand:var(--str-vye19e);}"];
  [@css ".css-1vdqaxy-pseudoElement::placeholder{color:var(--color-12r6fyr);}"];
  [@css ".css-yfluo3-legacyPseudoElement:before{color:var(--color-e7n16g);}"];
  [@css ".css-i81g8d-mixedPseudo{color:var(--color-xrtge);}"];
  [@css ".css-i81g8d-mixedPseudo::before{color:var(--color-xrtge);}"];
  [@css
    ".css-11o9ny0-pseudoClassOnly:focus-visible:not(:disabled){color:var(--color-f5c7x);}"
  ];
  [@css.bindings
    [
      ("Output.topLevel", "css-kusjgz-topLevel"),
      ("Output.hover", "css-lfbwy0-hover"),
      ("Output.media", "css-19xpxeg-media"),
      ("Output.descendant", "css-1g3cfa1-descendant"),
      ("Output.bundleSpan", "css-1d8si03-bundleSpan"),
      ("Output.customFeeder", "css-1l36lcw-customFeeder"),
      ("Output.pseudoElement", "css-1vdqaxy-pseudoElement"),
      ("Output.legacyPseudoElement", "css-yfluo3-legacyPseudoElement"),
      ("Output.mixedPseudo", "css-i81g8d-mixedPseudo"),
      ("Output.pseudoClassOnly", "css-11o9ny0-pseudoClassOnly"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "css-kusjgz-topLevel",
      [("--color-1a279q8", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "css-lfbwy0-hover",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "css-19xpxeg-media",
      [("--color-km0lr0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-1g3cfa1-descendant",
      [("--color-ump0qt", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "css-1d8si03-bundleSpan",
      [("--color-7srqv7", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make("css-1l36lcw-customFeeder", [("--str-vye19e", str)]);
  let pseudoElement =
    CSS.make(
      "css-1vdqaxy-pseudoElement",
      [("--color-12r6fyr", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "css-yfluo3-legacyPseudoElement",
      [("--color-e7n16g", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "css-i81g8d-mixedPseudo",
      [("--color-xrtge", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "css-11o9ny0-pseudoClassOnly",
      [("--color-f5c7x", CSS.Types.Color.toString(color))],
    );
