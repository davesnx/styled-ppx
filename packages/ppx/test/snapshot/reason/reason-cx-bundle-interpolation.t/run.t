Plan 3b: a block's interpolating declarations share one bundle class and one
var per (source-path, runtime-type) across base / :hover / @media variants.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-3f9mj1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-13vjntp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1v9ua{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-c62vcf{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4uzv5u{syntax:\"*\";inherits:false;}"];
  [@css ".css-1kbzua4-multiVariant{color:var(--color-3f9mj1);}"];
  [@css ".css-1kbzua4-multiVariant:hover{color:var(--color-3f9mj1);}"];
  [@css
    "@media (max-width: 768px) {.css-1kbzua4-multiVariant{color:var(--color-3f9mj1);}}"
  ];
  [@css ".css-k008qs-mixed{display:flex;}"];
  [@css ".css-1upqar2-mixed{color:var(--color-13vjntp);}"];
  [@css ".css-1upqar2-mixed:hover{color:var(--color-13vjntp);}"];
  [@css ".css-e286e6-twoTypes{width:var(--width-1v9ua);}"];
  [@css ".css-e286e6-twoTypes:hover{height:var(--width-c62vcf);}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-lfbwy0:hover{color:var(--color-4uzv5u);}"];
  [@css ".css-k008qs{display:flex;}"];
  [@css.bindings
    [
      ("Output.multiVariant", "css-1kbzua4-multiVariant"),
      ("Output.mixed", "css-k008qs-mixed css-1upqar2-mixed"),
      ("Output.twoTypes", "css-e286e6-twoTypes"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make_labeled(
      "multiVariant",
      "css-1kbzua4-multiVariant",
      [("--color-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make_labeled(
      "mixed",
      "css-k008qs-mixed css-1upqar2-mixed",
      [("--color-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make_labeled(
      "twoTypes",
      "css-e286e6-twoTypes",
      [
        ("--width-1v9ua", CSS.Types.Width.toString(width)),
        ("--width-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-tokvmb css-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-k008qs css-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
