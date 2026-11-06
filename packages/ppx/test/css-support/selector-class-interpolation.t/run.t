Same-module class-name interpolation in [%css] selectors must resolve at
extraction time. No literal `$(name)` should appear in the extracted CSS,
and the runtime `CSS.make` call must carry an empty list (no phantom
`--var-XXX` entries for selector references).

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
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
        "_c7fdO-1AgybFZur",
        ["._c7fdO-1AgybFZur._iBZ5mNPO7{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "dO-1Ag", "ctx\\0&._iBZ5mNPO7 | "),
          ("value", "ybFZur", "val\\07f\\0&._iBZ5mNPO7 | \\0color:blue"),
        ],
      ),
      (
        "_a4sAsdUoO",
        ["._a4sAsdUoO{background-size:1rem 1rem;}"],
        1,
        0,
        1,
        [("value", "AsdUoO", "val\\04s\\0& | \\0background-size:1rem 1rem")],
      ),
      (
        "_a3yJsnQ5K",
        [
          "._a3yJsnQ5K{-webkit-animation-duration:1000ms;animation-duration:1000ms;}",
        ],
        1,
        0,
        1,
        [("value", "JsnQ5K", "val\\03y\\0& | \\0animation-duration:1000ms")],
      ),
      (
        "_a4lL-g7De",
        ["._a4lL-g7De{background-color:blue;}"],
        1,
        0,
        1,
        [("value", "L-g7De", "val\\04l\\0& | \\0background-color:blue")],
      ),
      (
        "_c4lIPzgdEr2ua5Q",
        [
          "._c4lIPzgdEr2ua5Q:disabled:not(._c4lIPzgdEr2ua5Q._iyLizOWmY){background-color:gray;}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "IPzgdE", "ctx\\0&:disabled:not(&._iyLizOWmY) | "),
          (
            "value",
            "r2ua5Q",
            "val\\04l\\0&:disabled:not(&._iyLizOWmY) | \\0background-color:gray",
          ),
        ],
      ),
      (
        "_iBZ5mNPO7",
        [],
        1,
        0,
        0,
        [("id", "_iBZ5mNPO7", "bind\\0\\0Input\\0\\0foo\\00")],
      ),
      (
        "_iBEU_scOh",
        [],
        1,
        0,
        0,
        [("id", "_iBEU_scOh", "bind\\0\\0Input\\0\\0bar\\00")],
      ),
      (
        "_iyLizOWmY",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iyLizOWmY",
            "bind\\0\\0Input\\0\\0buttonLoadingAnimation\\00",
          ),
        ],
      ),
      (
        "_iiNP0E9Ud",
        [],
        1,
        0,
        0,
        [("id", "_iiNP0E9Ud", "bind\\0\\0Input\\0\\0colorAccent\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.foo", "_iBZ5mNPO7 _a7fadbhEW", "_iBZ5mNPO7"),
      ("Input.bar", "_iBEU_scOh _c7fdO-1AgybFZur", "_iBEU_scOh"),
      (
        "Input.buttonLoadingAnimation",
        "_iyLizOWmY _a4sAsdUoO _a3yJsnQ5K",
        "_iyLizOWmY",
      ),
      (
        "Input.colorAccent",
        "_iiNP0E9Ud _a4lL-g7De _c4lIPzgdEr2ua5Q",
        "_iiNP0E9Ud",
      ),
    ]
  ];
  
  let foo = CSS.make("_iBZ5mNPO7 _a7fadbhEW", []);
  
  let bar = CSS.make("_iBEU_scOh _c7fdO-1AgybFZur", []);
  
  let buttonLoadingAnimation = CSS.make("_iyLizOWmY _a4sAsdUoO _a3yJsnQ5K", []);
  
  let colorAccent = CSS.make("_iiNP0E9Ud _a4lL-g7De _c4lIPzgdEr2ua5Q", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
