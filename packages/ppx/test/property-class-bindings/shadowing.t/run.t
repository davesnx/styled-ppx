A name bound twice in one scope gets one id per binding site, so the
second `m` does not share the id of the first. A submodule has its own
scope. `$(m)` selects the id of the binding in force at that point.

  $ refmt --parse re --print ml m.re > m.ml
  $ ../../standalone.exe --env production --impl m.ml -o m.ml
  $ refmt --parse ml --print re m.ml
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
        "_a7fCPHFf-",
        ["._a7fCPHFf-{color:blue;}"],
        1,
        0,
        1,
        [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")],
      ),
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_a7fn70fsU",
        ["._a7fn70fsU{color:black;}"],
        1,
        0,
        1,
        [("value", "n70fsU", "val\\07f\\0& | \\0color:black")],
      ),
      (
        "_c7f7BbO64BT4oa4",
        ["._c7f7BbO64BT4oa4._iGT3WW03w{color:purple;}"],
        2,
        1,
        1,
        [
          ("ctx", "7BbO64", "ctx\\0&._iGT3WW03w | "),
          ("value", "BT4oa4", "val\\07f\\0&._iGT3WW03w | \\0color:purple"),
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
        "_iFq5Tgf2S",
        [],
        1,
        0,
        0,
        [("id", "_iFq5Tgf2S", "bind\\0\\0M\\0\\0m\\01")],
      ),
      (
        "_iGT3WW03w",
        [],
        1,
        0,
        0,
        [("id", "_iGT3WW03w", "bind\\0\\0M\\0\\0m\\02")],
      ),
      (
        "_injs_hdOK",
        [],
        1,
        0,
        0,
        [("id", "_injs_hdOK", "bind\\0\\0M\\0Inner\\0m\\00")],
      ),
      (
        "_inoiI2ThF",
        [],
        1,
        0,
        0,
        [("id", "_inoiI2ThF", "bind\\0\\0M\\0Inner\\0m\\01")],
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
      ("M.m", "_iGT3WW03w _a7fCPHFf-", "_iGT3WW03w"),
      ("M.Inner.m", "_inoiI2ThF _a7fBq58Im", "_inoiI2ThF"),
      ("M.card", "_il-9sFgHR _a7fn70fsU _c7f7BbO64BT4oa4", "_il-9sFgHR"),
    ]
  ];
  let m = CSS.make("_iKMiiAc13", []);
  let m = CSS.make("_iFq5Tgf2S _a7fadbhEW", []);
  let m = CSS.make("_iGT3WW03w _a7fCPHFf-", []);
  module Inner = {
    let m = CSS.make("_injs_hdOK", []);
    let m = CSS.make("_inoiI2ThF _a7fBq58Im", []);
  };
  let card = CSS.make("_il-9sFgHR _a7fn70fsU _c7f7BbO64BT4oa4", []);
