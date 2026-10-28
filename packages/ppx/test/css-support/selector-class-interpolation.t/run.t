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
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_y2fu14etqme._id_eealdg{color:blue;}",
      "_a_y2fu14etqme",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3900740mg9{background-size:1rem 1rem;}",
      "_a_3900740mg9",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_2z00083gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}",
      "_a_2z00083gnv",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390004xk9e{background-color:blue;}",
      "_a_390004xk9e",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_rj4gd390004z2n1:disabled:not(._a_rj4gd390004z2n1._id_1v23wvr){background-color:gray;}",
      "_a_rj4gd390004z2n1",
      "0,4,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input.foo", "_id_eealdg", "_a_4ekvmb"),
      ("Input.bar", "_id_1wtvg3d", "_a_y2fu14etqme"),
      (
        "Input.buttonLoadingAnimation",
        "_id_1v23wvr",
        "_a_3900740mg9 _a_2z00083gnv",
      ),
      ("Input.colorAccent", "_id_1ljmqgf", "_a_390004xk9e _a_rj4gd390004z2n1"),
    ]
  ];
  [@css.blocks
    [
      (7, "_id_eealdg", [0]),
      (9, "_id_1wtvg3d", [1]),
      (15, "_id_1v23wvr", [2, 3]),
      (22, "_id_1ljmqgf", [4, 5]),
    ]
  ];
  
  let foo = CSS.make("label:foo _id_eealdg _a_4ekvmb", []);
  
  let bar = CSS.make("label:bar _id_1wtvg3d _a_y2fu14etqme", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "label:buttonLoadingAnimation _id_1v23wvr _a_3900740mg9 _a_2z00083gnv",
      [],
    );
  
  let colorAccent =
    CSS.make(
      "label:colorAccent _id_1ljmqgf _a_390004xk9e _a_rj4gd390004z2n1",
      [],
    );
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
