The id depends on the module name, not on the file path, the target or
the build. Four builds of one unit give one output.

  $ mkdir one two native
  $ refmt --parse re --print ml m.re > one/m.ml
  $ ../../standalone.exe --env production --impl one/m.ml -o one/m.ml
  $ refmt --parse re --print ml m.re > two/m.ml
  $ ../../standalone.exe --env production --impl two/m.ml -o two/m.ml
  $ refmt --parse re --print ml m.re > native/m.ml
  $ ../../standalone.exe --env production --native --impl native/m.ml -o native/m.ml
  $ diff one/m.ml two/m.ml
  $ diff one/m.ml native/m.ml
  $ refmt --parse ml --print re one/m.ml
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
        "_c7fvjtCjLtm1tZ_",
        ["._c7fvjtCjLtm1tZ_._iKMiiAc13{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "vjtCjL", "ctx\\0&._iKMiiAc13 | "),
          ("value", "tm1tZ_", "val\\07f\\0&._iKMiiAc13 | \\0color:blue"),
        ],
      ),
      (
        "_iKMiiAc13",
        [],
        1,
        0,
        0,
        [("id", "_iKMiiAc13", "bind\\0\\0M\\0\\0m\\00")],
      ),
      (
        "_il-9sFgHR",
        [],
        1,
        0,
        0,
        [("id", "_il-9sFgHR", "bind\\0\\0M\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("M.m", "_iKMiiAc13", "_iKMiiAc13"),
      ("M.card", "_il-9sFgHR _a7fadbhEW _c7fvjtCjLtm1tZ_", "_il-9sFgHR"),
    ]
  ];
  let m = CSS.make("_iKMiiAc13", []);
  let card = CSS.make("_il-9sFgHR _a7fadbhEW _c7fvjtCjLtm1tZ_", []);
