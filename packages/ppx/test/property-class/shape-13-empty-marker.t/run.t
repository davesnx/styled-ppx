Shape 13: an empty marker keeps its binding id in development and in production. Bindings with one name in two scopes get two ids.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_iFRKsz1DK",
        [],
        1,
        0,
        0,
        [("id", "_iFRKsz1DK", "bind\\0\\0Input\\0\\0m\\00")],
      ),
      (
        "_i3sua-7yE",
        [],
        1,
        0,
        0,
        [("id", "_i3sua-7yE", "bind\\0\\0Input\\0Inner\\0m\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.m", "_iFRKsz1DK", "_iFRKsz1DK"),
      ("Input.Inner.m", "_i3sua-7yE", "_i3sua-7yE"),
    ]
  ];
  let m = CSS.make("cx-m _iFRKsz1DK", []);
  module Inner = {
    let m = CSS.make("cx-m _i3sua-7yE", []);
  };
  let _ = CSS.make("", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_iFRKsz1DK",
        [],
        1,
        0,
        0,
        [("id", "_iFRKsz1DK", "bind\\0\\0Input\\0\\0m\\00")],
      ),
      (
        "_i3sua-7yE",
        [],
        1,
        0,
        0,
        [("id", "_i3sua-7yE", "bind\\0\\0Input\\0Inner\\0m\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.m", "_iFRKsz1DK", "_iFRKsz1DK"),
      ("Input.Inner.m", "_i3sua-7yE", "_i3sua-7yE"),
    ]
  ];
  let m = CSS.make("_iFRKsz1DK", []);
  module Inner = {
    let m = CSS.make("_i3sua-7yE", []);
  };
  let _ = CSS.make("", []);
