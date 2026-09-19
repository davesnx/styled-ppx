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
  [@css "@property --backgroundColor-7yjmr3{syntax:\"*\";inherits:false;}"];
  [@css ".css-160vrad{background-color:var(--backgroundColor-ov3le6);}"];
  [@css ".css-10a6meq:hover{background-color:var(--backgroundColor-7yjmr3);}"];
  [@css.bindings
    [
      ("Output.common", "cid-45bzlz", "css-160vrad"),
      ("Output.clickable", "cid-1d9eonh", "css-10a6meq"),
    ]
  ];
  let common = backgroundColor =>
    CSS.make(
      "cx-common cid-45bzlz css-160vrad",
      [
        ("--backgroundColor-ov3le6", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "cx-clickable cid-1d9eonh css-10a6meq",
      [
        ("--backgroundColor-7yjmr3", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
