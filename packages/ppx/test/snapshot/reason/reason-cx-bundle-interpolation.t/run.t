Plan 3b: a block's interpolating declarations share one bundle class and one
var per (source-path, runtime-type) across base / :hover / @media variants.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-gwnaj{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-ba7dyf{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1oc5omt{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-18jvvwa{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-wnj194{syntax:\"*\";inherits:false;}"];
  [@css ".css-14gjr2l-multiVariant{color:var(--color-gwnaj)}"];
  [@css ".css-14gjr2l-multiVariant:hover{color:var(--color-gwnaj)}"];
  [@css
    "@media (max-width:768px){.css-14gjr2l-multiVariant{color:var(--color-gwnaj)}}"
  ];
  [@css ".css-k008qs-mixed{display:flex}"];
  [@css ".css-x2ktuf-mixed{color:var(--color-ba7dyf)}"];
  [@css ".css-x2ktuf-mixed:hover{color:var(--color-ba7dyf)}"];
  [@css ".css-1j0zn1e-twoTypes{width:var(--width-1oc5omt)}"];
  [@css ".css-1j0zn1e-twoTypes:hover{height:var(--width-18jvvwa)}"];
  [@css ".css-tokvmb{color:red}"];
  [@css ".css-19mnjpf:hover{color:var(--color-wnj194)}"];
  [@css ".css-k008qs{display:flex}"];
  [@css.bindings
    [
      ("Output.multiVariant", "css-14gjr2l-multiVariant"),
      ("Output.mixed", "css-k008qs-mixed css-x2ktuf-mixed"),
      ("Output.twoTypes", "css-1j0zn1e-twoTypes"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "css-14gjr2l-multiVariant",
      [("--color-gwnaj", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "css-k008qs-mixed css-x2ktuf-mixed",
      [("--color-ba7dyf", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "css-1j0zn1e-twoTypes",
      [
        ("--width-1oc5omt", CSS.Types.Width.toString(width)),
        ("--width-18jvvwa", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-tokvmb css-19mnjpf",
      [("--color-wnj194", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-k008qs css-19mnjpf",
      [("--color-wnj194", CSS.Types.Color.toString(color))],
    );
