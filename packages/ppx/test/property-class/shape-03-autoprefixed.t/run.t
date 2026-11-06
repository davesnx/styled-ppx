Shape 3: an autoprefixed declaration is one atom. color-adjust and its alias pair stay one atom.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_a3ynR1W4P",
        ["._a3ynR1W4P{-webkit-animation-duration:1s;animation-duration:1s;}"],
        1,
        0,
        1,
        [("value", "nR1W4P", "val\\03y\\0& | \\0animation-duration:1s")],
      ),
      (
        "_a7gCmPFv_",
        ["._a7gCmPFv_{-webkit-print-color-adjust:exact;color-adjust:exact;}"],
        1,
        0,
        1,
        [("value", "CmPFv_", "val\\07g\\0& | \\0color-adjust:exact")],
      ),
      (
        "_aml-wc9hs",
        [
          "._aml-wc9hs{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
        ],
        1,
        0,
        1,
        [("value", "-wc9hs", "val\\0ml\\0& | \\0user-select:none")],
      ),
      (
        "_a99o8062j",
        ["._a99o8062j{cursor:-webkit-grab;cursor:grab;}"],
        1,
        0,
        1,
        [("value", "o8062j", "val\\099\\0& | \\0cursor:grab")],
      ),
      (
        "_iTgfn1WOX",
        [],
        1,
        0,
        0,
        [("id", "_iTgfn1WOX", "bind\\0\\0Input\\0\\0animated\\00")],
      ),
      (
        "_inFnkbouK",
        [],
        1,
        0,
        0,
        [("id", "_inFnkbouK", "bind\\0\\0Input\\0\\0adjust\\00")],
      ),
      (
        "_iM6diS3Al",
        [],
        1,
        0,
        0,
        [("id", "_iM6diS3Al", "bind\\0\\0Input\\0\\0select\\00")],
      ),
      (
        "_i_xYe0uLA",
        [],
        1,
        0,
        0,
        [("id", "_i_xYe0uLA", "bind\\0\\0Input\\0\\0grab\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.animated", "_iTgfn1WOX _a3ynR1W4P", "_iTgfn1WOX"),
      ("Input.adjust", "_inFnkbouK _a7gCmPFv_", "_inFnkbouK"),
      ("Input.select", "_iM6diS3Al _aml-wc9hs", "_iM6diS3Al"),
      ("Input.grab", "_i_xYe0uLA _a99o8062j", "_i_xYe0uLA"),
    ]
  ];
  let animated = CSS.make("cx-animated _iTgfn1WOX _a3ynR1W4P", []);
  let adjust = CSS.make("cx-adjust _inFnkbouK _a7gCmPFv_", []);
  let select = CSS.make("cx-select _iM6diS3Al _aml-wc9hs", []);
  let grab = CSS.make("cx-grab _i_xYe0uLA _a99o8062j", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a3ynR1W4P",
        ["._a3ynR1W4P{-webkit-animation-duration:1s;animation-duration:1s;}"],
        1,
        0,
        1,
        [("value", "nR1W4P", "val\\03y\\0& | \\0animation-duration:1s")],
      ),
      (
        "_a7gCmPFv_",
        ["._a7gCmPFv_{-webkit-print-color-adjust:exact;color-adjust:exact;}"],
        1,
        0,
        1,
        [("value", "CmPFv_", "val\\07g\\0& | \\0color-adjust:exact")],
      ),
      (
        "_aml-wc9hs",
        [
          "._aml-wc9hs{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
        ],
        1,
        0,
        1,
        [("value", "-wc9hs", "val\\0ml\\0& | \\0user-select:none")],
      ),
      (
        "_a99o8062j",
        ["._a99o8062j{cursor:-webkit-grab;cursor:grab;}"],
        1,
        0,
        1,
        [("value", "o8062j", "val\\099\\0& | \\0cursor:grab")],
      ),
      (
        "_iTgfn1WOX",
        [],
        1,
        0,
        0,
        [("id", "_iTgfn1WOX", "bind\\0\\0Input\\0\\0animated\\00")],
      ),
      (
        "_inFnkbouK",
        [],
        1,
        0,
        0,
        [("id", "_inFnkbouK", "bind\\0\\0Input\\0\\0adjust\\00")],
      ),
      (
        "_iM6diS3Al",
        [],
        1,
        0,
        0,
        [("id", "_iM6diS3Al", "bind\\0\\0Input\\0\\0select\\00")],
      ),
      (
        "_i_xYe0uLA",
        [],
        1,
        0,
        0,
        [("id", "_i_xYe0uLA", "bind\\0\\0Input\\0\\0grab\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.animated", "_iTgfn1WOX _a3ynR1W4P", "_iTgfn1WOX"),
      ("Input.adjust", "_inFnkbouK _a7gCmPFv_", "_inFnkbouK"),
      ("Input.select", "_iM6diS3Al _aml-wc9hs", "_iM6diS3Al"),
      ("Input.grab", "_i_xYe0uLA _a99o8062j", "_i_xYe0uLA"),
    ]
  ];
  let animated = CSS.make("_iTgfn1WOX _a3ynR1W4P", []);
  let adjust = CSS.make("_inFnkbouK _a7gCmPFv_", []);
  let select = CSS.make("_iM6diS3Al _aml-wc9hs", []);
  let grab = CSS.make("_i_xYe0uLA _a99o8062j", []);
