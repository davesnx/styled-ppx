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
  [@css "._a_8s8tj4em6j7._id_zec317{color:blue;}"];
  [@css "._a_390740mg9{background-size:1rem 1rem;}"];
  [@css
    "._a_2z0083gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css "._a_39004xk9e{background-color:blue;}"];
  [@css
    "._a_we4a139004apm0:disabled:not(._a_we4a139004apm0._id_1wqjj7x){background-color:gray;}"
  ];
  [@css.bindings
    [
      ("Input.foo", "_id_zec317", "_a_4ekvmb"),
      ("Input.bar", "_id_1eelq62", "_a_8s8tj4em6j7"),
      (
        "Input.buttonLoadingAnimation",
        "_id_1wqjj7x",
        "_a_390740mg9 _a_2z0083gnv",
      ),
      ("Input.colorAccent", "_id_qhdd42", "_a_39004xk9e _a_we4a139004apm0"),
    ]
  ];
  
  let foo = CSS.make("label:foo _id_zec317 _a_4ekvmb", []);
  
  let bar = CSS.make("label:bar _id_1eelq62 _a_8s8tj4em6j7", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "label:buttonLoadingAnimation _id_1wqjj7x _a_390740mg9 _a_2z0083gnv",
      [],
    );
  
  let colorAccent =
    CSS.make("label:colorAccent _id_qhdd42 _a_39004xk9e _a_we4a139004apm0", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
