Custom-property names are keyed to atom declaration content (selector context +
property + resolved type), not to the owning [%css] expression. Two atoms
collide or share the same generated var only when their declaration content is
identical; the two atoms below differ in selector context (top-level vs :hover),
so they get distinct var names and equal local interpolation names in separately
merged styles cannot overwrite each other.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --backgroundColor-ov3le6{syntax:\"*\";inherits:false;}"];
  [@css "@property --backgroundColor-1de3e3m{syntax:\"*\";inherits:false;}"];
  [@css ".css-160vrad-common{background-color:var(--backgroundColor-ov3le6)}"];
  [@css
    ".css-6rmg3n-clickable:hover{background-color:var(--backgroundColor-1de3e3m)}"
  ];
  [@css.bindings
    [
      ("Output.common", "css-160vrad-common"),
      ("Output.clickable", "css-6rmg3n-clickable"),
    ]
  ];
  let common = backgroundColor =>
    CSS.make(
      "css-160vrad-common",
      [
        ("--backgroundColor-ov3le6", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "css-6rmg3n-clickable",
      [
        (
          "--backgroundColor-1de3e3m",
          CSS.Types.Color.toString(backgroundColor),
        ),
      ],
    );
