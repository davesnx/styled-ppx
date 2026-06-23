Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-qqxh28{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1g10n3y{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-7zzrwb{syntax:\"*\";inherits:false;}"];
  [@css "@property --str-k9lkg9{syntax:\"*\";inherits:false;}"];
  [@css ".css-1p250wn-topLevel{color:var(--color-qqxh28) ;}"];
  [@css ".css-66gnkb-hover:hover{color:var(--color-1g10n3y) ;}"];
  [@css
    "@media (max-width: 768px) {.css-kesuu8-media{color:var(--color-7zzrwb) ;}}"
  ];
  [@css ".css-l90awb-descendant .child{color:var(--color-1bmfpl7) ;}"];
  [@css ".css-1s0cn0c-bundleSpan{color:var(--color-168gc9v);}"];
  [@css ".css-1s0cn0c-bundleSpan .child{color:var(--color-168gc9v) ;}"];
  [@css ".css-1s7c43s-customFeeder{--brand:var(--str-k9lkg9) ;}"];
  [@css.bindings
    [
      ("Output.topLevel", "css-1p250wn-topLevel"),
      ("Output.hover", "css-66gnkb-hover"),
      ("Output.media", "css-kesuu8-media"),
      ("Output.descendant", "css-l90awb-descendant"),
      ("Output.bundleSpan", "css-1s0cn0c-bundleSpan"),
      ("Output.customFeeder", "css-1s7c43s-customFeeder"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "css-1p250wn-topLevel",
      [("--color-qqxh28", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "css-66gnkb-hover",
      [("--color-1g10n3y", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "css-kesuu8-media",
      [("--color-7zzrwb", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-l90awb-descendant",
      [("--color-1bmfpl7", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "css-1s0cn0c-bundleSpan",
      [("--color-168gc9v", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make("css-1s7c43s-customFeeder", [("--str-k9lkg9", str)]);
