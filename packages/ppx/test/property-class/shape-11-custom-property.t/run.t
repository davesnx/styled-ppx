Shape 11: a custom property is keyed by its exact name. Names that differ in case are different atoms.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css "@property --x-16k9q85{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_xfZfQvj000000fe6HxY",
        ["._xfZfQvj000000fe6HxY{--Foo:red;}"],
        1,
        0,
        1,
        [
          ("name", "fZfQvj", "name\\0--Foo"),
          ("value", "fe6HxY", "val\\0--Foo\\0& | \\0--Foo:red"),
        ],
      ),
      (
        "_x3UklqK0000004qxP2y",
        ["._x3UklqK0000004qxP2y{--foo:var(--x-16k9q85);--foo:blue;}"],
        1,
        0,
        1,
        [
          ("name", "3UklqK", "name\\0--foo"),
          ("value", "4qxP2y", "val\\0--foo\\0& | \\0--foo:$(x)\\0--foo:blue"),
        ],
      ),
      (
        "_ijYcUjvH7",
        [],
        1,
        0,
        0,
        [("id", "_ijYcUjvH7", "bind\\0\\0Input\\0\\0theme\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input.theme",
        "_ijYcUjvH7 _xfZfQvj000000fe6HxY _x3UklqK0000004qxP2y",
        "_ijYcUjvH7",
      ),
    ]
  ];
  let theme =
    CSS.make(
      "cx-theme _ijYcUjvH7 _xfZfQvj000000fe6HxY _x3UklqK0000004qxP2y",
      [("--x-16k9q85", x)],
    );

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css "@property --x-16k9q85{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_xfZfQvj000000fe6HxY",
        ["._xfZfQvj000000fe6HxY{--Foo:red;}"],
        1,
        0,
        1,
        [
          ("name", "fZfQvj", "name\\0--Foo"),
          ("value", "fe6HxY", "val\\0--Foo\\0& | \\0--Foo:red"),
        ],
      ),
      (
        "_x3UklqK0000004qxP2y",
        ["._x3UklqK0000004qxP2y{--foo:var(--x-16k9q85);--foo:blue;}"],
        1,
        0,
        1,
        [
          ("name", "3UklqK", "name\\0--foo"),
          ("value", "4qxP2y", "val\\0--foo\\0& | \\0--foo:$(x)\\0--foo:blue"),
        ],
      ),
      (
        "_ijYcUjvH7",
        [],
        1,
        0,
        0,
        [("id", "_ijYcUjvH7", "bind\\0\\0Input\\0\\0theme\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input.theme",
        "_ijYcUjvH7 _xfZfQvj000000fe6HxY _x3UklqK0000004qxP2y",
        "_ijYcUjvH7",
      ),
    ]
  ];
  let theme =
    CSS.make(
      "_ijYcUjvH7 _xfZfQvj000000fe6HxY _x3UklqK0000004qxP2y",
      [("--x-16k9q85", x)],
    );
