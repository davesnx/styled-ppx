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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-qyxka4e2bjp.id-zec317{color:blue;}"];
  [@css ".a-390740mg9{background-size:1rem 1rem;}"];
  [@css
    ".a-2z0083gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css ".a-39004xk9e{background-color:blue;}"];
  [@css
    ".a-2m50h390046w9f:disabled:not(.a-2m50h390046w9f.id-1wqjj7x){background-color:gray;}"
  ];
  [@css.bindings
    [
      ("Input.foo", "id-zec317", "a-4ekvmb"),
      ("Input.bar", "id-1eelq62", "a-qyxka4e2bjp"),
      ("Input.buttonLoadingAnimation", "id-1wqjj7x", "a-390740mg9 a-2z0083gnv"),
      ("Input.colorAccent", "id-qhdd42", "a-39004xk9e a-2m50h390046w9f"),
    ]
  ];
  
  let foo = CSS.make("label:foo id-zec317 a-4ekvmb", []);
  
  let bar = CSS.make("label:bar id-1eelq62 a-qyxka4e2bjp", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "label:buttonLoadingAnimation id-1wqjj7x a-390740mg9 a-2z0083gnv",
      [],
    );
  
  let colorAccent =
    CSS.make("label:colorAccent id-qhdd42 a-39004xk9e a-2m50h390046w9f", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
