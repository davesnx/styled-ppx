Two units that bind the same name get different ids, because the module
name is part of the id.

  $ refmt --parse re --print ml a.re > a.ml
  $ ../../standalone.exe --env production --impl a.ml -o a.ml
  $ refmt --parse re --print ml b.re > b.ml
  $ ../../standalone.exe --env production --impl b.ml -o b.ml
  $ refmt --parse ml --print re a.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_igysSAdl6",
        [],
        1,
        0,
        0,
        [("id", "_igysSAdl6", "bind\\0\\0A\\0\\0card\\00")],
      ),
      (
        "_iLU_l-r4e",
        [],
        1,
        0,
        0,
        [("id", "_iLU_l-r4e", "bind\\0\\0A\\0\\0marker\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("A.card", "_igysSAdl6 _a7fadbhEW", "_igysSAdl6"),
      ("A.marker", "_iLU_l-r4e", "_iLU_l-r4e"),
    ]
  ];
  let card = CSS.make("_igysSAdl6 _a7fadbhEW", []);
  let marker = CSS.make("_iLU_l-r4e", []);
  $ refmt --parse ml --print re b.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_i3ePpy6ZJ",
        [],
        1,
        0,
        0,
        [("id", "_i3ePpy6ZJ", "bind\\0\\0B\\0\\0card\\00")],
      ),
      (
        "_iqOMHnUj8",
        [],
        1,
        0,
        0,
        [("id", "_iqOMHnUj8", "bind\\0\\0B\\0\\0marker\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("B.card", "_i3ePpy6ZJ _a7fadbhEW", "_i3ePpy6ZJ"),
      ("B.marker", "_iqOMHnUj8", "_iqOMHnUj8"),
    ]
  ];
  let card = CSS.make("_i3ePpy6ZJ _a7fadbhEW", []);
  let marker = CSS.make("_iqOMHnUj8", []);
