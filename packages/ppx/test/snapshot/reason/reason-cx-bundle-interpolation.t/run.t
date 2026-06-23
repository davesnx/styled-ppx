Plan 3b: a block's interpolating declarations share one bundle class and one
var per (source-path, runtime-type) across base / :hover / @media variants.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-1kbzua4-multiVariant{color:var(--var-3f9mj1);}"];
  [@css ".css-1kbzua4-multiVariant:hover{color:var(--var-3f9mj1);}"];
  [@css
    "@media (max-width: 768px) {.css-1kbzua4-multiVariant{color:var(--var-3f9mj1);}}"
  ];
  [@css ".css-k008qs-mixed{display:flex;}"];
  [@css ".css-1upqar2-mixed{color:var(--var-13vjntp);}"];
  [@css ".css-1upqar2-mixed:hover{color:var(--var-13vjntp);}"];
  [@css ".css-e286e6-twoTypes{width:var(--var-1v9ua);}"];
  [@css ".css-e286e6-twoTypes:hover{height:var(--var-c62vcf);}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-lfbwy0:hover{color:var(--var-4uzv5u);}"];
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
    CSS.make(
      "css-1kbzua4-multiVariant",
      [("--var-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "css-k008qs-mixed css-1upqar2-mixed",
      [("--var-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "css-e286e6-twoTypes",
      [
        ("--var-1v9ua", CSS.Types.Width.toString(width)),
        ("--var-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-tokvmb css-lfbwy0",
      [("--var-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-k008qs css-lfbwy0",
      [("--var-4uzv5u", CSS.Types.Color.toString(color))],
    );
