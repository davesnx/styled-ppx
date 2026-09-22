Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-qqxh28{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1g10n3y{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-7zzrwb{syntax:\"*\";inherits:false;}"];
  [@css "@property --str-k9lkg9{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-5xa71m{syntax:\"*\";inherits:false;}"];
  [@css ".css-1p250wn{color:var(--color-qqxh28) ;}"];
  [@css ".css-66gnkb:hover{color:var(--color-1g10n3y) ;}"];
  [@css "@media (max-width: 768px) {.css-kesuu8{color:var(--color-7zzrwb) ;}}"];
  [@css ".css-l90awb .child{color:var(--color-1bmfpl7) ;}"];
  [@css ".css-1s0cn0c{color:var(--color-168gc9v);}"];
  [@css ".css-1s0cn0c .child{color:var(--color-168gc9v) ;}"];
  [@css ".css-1s7c43s{--brand:var(--str-k9lkg9) ;}"];
  [@css ".css-1uu31vv::placeholder{color:var(--color-s2338j) ;}"];
  [@css ".css-drvy9e:before{color:var(--color-9jv993) ;}"];
  [@css ".css-1ngjc2o{color:var(--color-1p3gcae);}"];
  [@css ".css-1ngjc2o::before{color:var(--color-1p3gcae) ;}"];
  [@css ".css-r782y4:focus-visible:not(:disabled){color:var(--color-5xa71m) ;}"];
  [@css.bindings
    [
      ("Output.topLevel", "cid-1lkhdb3", "css-1p250wn"),
      ("Output.hover", "cid-ng6izt", "css-66gnkb"),
      ("Output.media", "cid-12d3e0w", "css-kesuu8"),
      ("Output.descendant", "cid-1g3dzrb", "css-l90awb"),
      ("Output.bundleSpan", "cid-ijx48y", "css-1s0cn0c"),
      ("Output.customFeeder", "cid-195hxjc", "css-1s7c43s"),
      ("Output.pseudoElement", "cid-4p9l0t", "css-1uu31vv"),
      ("Output.legacyPseudoElement", "cid-4uo0i7", "css-drvy9e"),
      ("Output.mixedPseudo", "cid-1rr25fw", "css-1ngjc2o"),
      ("Output.pseudoClassOnly", "cid-1f0poos", "css-r782y4"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      ~label="topLevel",
      "cid-1lkhdb3 css-1p250wn",
      [("--color-qqxh28", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      ~label="hover",
      "cid-ng6izt css-66gnkb",
      [("--color-1g10n3y", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      ~label="media",
      "cid-12d3e0w css-kesuu8",
      [("--color-7zzrwb", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      ~label="descendant",
      "cid-1g3dzrb css-l90awb",
      [("--color-1bmfpl7", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      ~label="bundleSpan",
      "cid-ijx48y css-1s0cn0c",
      [("--color-168gc9v", CSS.Types.Color.toString(color))],
    );
  let customFeeder =
    CSS.make(
      ~label="customFeeder",
      "cid-195hxjc css-1s7c43s",
      [("--str-k9lkg9", str)],
    );
  let pseudoElement =
    CSS.make(
      ~label="pseudoElement",
      "cid-4p9l0t css-1uu31vv",
      [("--color-s2338j", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      ~label="legacyPseudoElement",
      "cid-4uo0i7 css-drvy9e",
      [("--color-9jv993", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      ~label="mixedPseudo",
      "cid-1rr25fw css-1ngjc2o",
      [("--color-1p3gcae", CSS.Types.Color.toString(color))],
    );
  let pseudoClassOnly =
    CSS.make(
      ~label="pseudoClassOnly",
      "cid-1f0poos css-r782y4",
      [("--color-5xa71m", CSS.Types.Color.toString(color))],
    );
