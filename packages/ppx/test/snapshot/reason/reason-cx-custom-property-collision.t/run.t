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
  [@css "._a_390004vrad{background-color:var(--backgroundColor-ov3le6);}"];
  [@css
    "._a_qyw7u3900046meq:hover{background-color:var(--backgroundColor-7yjmr3);}"
  ];
  [@css.bindings
    [
      ("Output.common", "_id_cpi3ld", "_a_390004vrad"),
      ("Output.clickable", "_id_htvdst", "_a_qyw7u3900046meq"),
    ]
  ];
  [@css.blocks
    [(2, "_id_cpi3ld _a_390004vrad"), (6, "_id_htvdst _a_qyw7u3900046meq")]
  ];
  let common = backgroundColor =>
    CSS.make(
      "label:common _id_cpi3ld _a_390004vrad",
      [
        ("--backgroundColor-ov3le6", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "label:clickable _id_htvdst _a_qyw7u3900046meq",
      [
        ("--backgroundColor-7yjmr3", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
