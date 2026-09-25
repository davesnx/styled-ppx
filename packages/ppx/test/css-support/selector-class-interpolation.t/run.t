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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-11o9qin.id-zec317{color:blue;}"];
  [@css ".a-1vf0mg9{background-size:1rem 1rem;}"];
  [@css
    ".a-rj3gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css ".a-f9xk9e{background-color:blue;}"];
  [@css
    ".a-1eo9rnb:disabled:not(.a-1eo9rnb.id-1wqjj7x){background-color:gray;}"
  ];
  [@css.bindings
    [
      ("Input.foo", "id-zec317", "a-tokvmb"),
      ("Input.bar", "id-1eelq62", "a-11o9qin"),
      ("Input.buttonLoadingAnimation", "id-1wqjj7x", "a-1vf0mg9 a-rj3gnv"),
      ("Input.colorAccent", "id-qhdd42", "a-f9xk9e a-1eo9rnb"),
    ]
  ];
  
  let foo = CSS.make("label:foo id-zec317 a-tokvmb", []);
  
  let bar = CSS.make("label:bar id-1eelq62 a-11o9qin", []);
  
  let buttonLoadingAnimation =
    CSS.make("label:buttonLoadingAnimation id-1wqjj7x a-1vf0mg9 a-rj3gnv", []);
  
  let colorAccent =
    CSS.make("label:colorAccent id-qhdd42 a-f9xk9e a-1eo9rnb", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
