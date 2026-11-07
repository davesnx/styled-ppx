The marker has zero effect on selector interpolation. Atom hashes,
extracted CSS, and resolved selectors are byte-identical between
--dev and no-flag runs. Only the first argument to CSS.make differs.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --dev)))
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
    ]
  ];
  [@css.bindings
    [
      ("Input.foo", "_iBZ5mNPO7 _a7fadbhEW", "_iBZ5mNPO7"),
      ("Input.bar", "_iBEU_scOh _c7fdO-1AgybFZur", "_iBEU_scOh"),
    ]
  ];
  
  let foo = CSS.make("cx-foo _iBZ5mNPO7 _a7fadbhEW", []);
  
  let bar = CSS.make("cx-bar _iBEU_scOh _c7fdO-1AgybFZur", []);
  
  let _ = (foo, bar);

  $ dune build
