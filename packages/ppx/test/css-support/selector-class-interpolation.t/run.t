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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_y2fu14etqme._id_eealdg{color:blue;}"];
  [@css "._a_3900740mg9{background-size:1rem 1rem;}"];
  [@css
    "._a_2z00083gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css "._a_390004xk9e{background-color:blue;}"];
  [@css
    "._a_rj4gd390004z2n1:disabled:not(._a_rj4gd390004z2n1._id_1v23wvr){background-color:gray;}"
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
      (7, "_id_eealdg _a_4ekvmb"),
      (9, "_id_1wtvg3d _a_y2fu14etqme"),
      (15, "_id_1v23wvr _a_3900740mg9 _a_2z00083gnv"),
      (22, "_id_1ljmqgf _a_390004xk9e _a_rj4gd390004z2n1"),
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
