Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --1aa3iyr-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --g56kfp-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --g56kfp-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --jgpspn-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-1aa3iyr{--color-link:var(--1aa3iyr-0);}"];
  [@css ".css-g56kfp{--color-link:var(--g56kfp-0);--spacing:var(--g56kfp-1);}"];
  [@css ".css-jgpspn{--token:var(--jgpspn-0);}"];
  [@css.classes
    [
      ("css-1aa3iyr", 4, "Output.row", "output.ml", 4, 2, 5, 0),
      ("css-g56kfp", 5, "Output.theme", "output.ml", 8, 2, 10, 0),
      ("css-jgpspn", 6, "Output.dyn", "output.ml", 12, 2, 13, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.row", "css-1aa3iyr"),
      ("Output.theme", "css-g56kfp"),
      ("Output.dyn", ""),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row = CSS.make("css-1aa3iyr", [("--1aa3iyr-0", colorStr)]);
  let theme =
    CSS.make(
      "css-g56kfp",
      [("--g56kfp-0", colorStr), ("--g56kfp-1", plainStr)],
    );
  let dyn = value => CSS.make("css-jgpspn", [("--jgpspn-0", value)]);
