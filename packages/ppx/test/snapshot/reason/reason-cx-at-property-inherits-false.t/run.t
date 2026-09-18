Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-wnj194{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-17nvovj{syntax:\"*\";inherits:false;}"];
  [@css "@property --str-vye19e{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pjz9m2{syntax:\"*\";inherits:false;}"];
  [@css ".css-kusjgz-topLevel{color:var(--color-1a279q8)}"];
  [@css ".css-19mnjpf-hover:hover{color:var(--color-wnj194)}"];
  [@css
    "@media (max-width:768px){.css-16ctxkj-media{color:var(--color-17nvovj)}}"
  ];
  [@css ".css-15v0hm9-descendant .child{color:var(--color-1ebczi8)}"];
  [@css ".css-75kqy4-bundleSpan{color:var(--color-1g6i34n)}"];
  [@css ".css-75kqy4-bundleSpan .child{color:var(--color-1g6i34n)}"];
  [@css ".css-1l36lcw-customFeeder{--brand:var(--str-vye19e)}"];
  [@css ".css-1ensba3-pseudoElement::placeholder{color:var(--color-1sluqsy)}"];
  [@css ".css-15th41q-legacyPseudoElement:before{color:var(--color-lh7e1z)}"];
  [@css ".css-418h1m-mixedPseudo{color:var(--color-1fytp97)}"];
  [@css ".css-418h1m-mixedPseudo::before{color:var(--color-1fytp97)}"];
  [@css
    ".css-w56qpt-pseudoClassOnly:focus-visible:not(:disabled){color:var(--color-pjz9m2)}"
  ];
  [@css.bindings
    [
      ("Output.topLevel", "css-kusjgz-topLevel"),
      ("Output.hover", "css-19mnjpf-hover"),
      ("Output.media", "css-16ctxkj-media"),
      ("Output.descendant", "css-15v0hm9-descendant"),
      ("Output.bundleSpan", "css-75kqy4-bundleSpan"),
      ("Output.customFeeder", "css-1l36lcw-customFeeder"),
      ("Output.pseudoElement", "css-1ensba3-pseudoElement"),
      ("Output.legacyPseudoElement", "css-15th41q-legacyPseudoElement"),
      ("Output.mixedPseudo", "css-418h1m-mixedPseudo"),
      ("Output.pseudoClassOnly", "css-w56qpt-pseudoClassOnly"),
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
      "css-19mnjpf-hover",
      [("--color-wnj194", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "css-16ctxkj-media",
      [("--color-17nvovj", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-15v0hm9-descendant",
      [("--color-1ebczi8", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "css-75kqy4-bundleSpan",
      [("--color-1g6i34n", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make("css-1l36lcw-customFeeder", [("--str-vye19e", str)]);
  let pseudoElement =
    CSS.make(
      "css-1ensba3-pseudoElement",
      [("--color-1sluqsy", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "css-15th41q-legacyPseudoElement",
      [("--color-lh7e1z", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "css-418h1m-mixedPseudo",
      [("--color-1fytp97", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      "css-w56qpt-pseudoClassOnly",
      [("--color-pjz9m2", CSS.Types.Color.toString(color))],
    );
