REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --1kscx84-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1kscx84-1{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-1kscx84{margin-left:var(--1kscx84-0);padding-left:var(--1kscx84-1);}"
  ];
  [@css.classes
    [("css-1kscx84", 2, "Output.layout", "output.ml", 4, 2, 6, 0)]
  ];
  [@css.bindings [("Output.layout", "css-1kscx84")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-1kscx84",
      [
        ("--1kscx84-0", CSS.Types.Margin.toString(lengthVar)),
        ("--1kscx84-1", CSS.Types.Length.toString(lengthVar)),
      ],
    );
