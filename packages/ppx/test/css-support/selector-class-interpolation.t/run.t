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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-11o9qin.cid-zec317{color:blue;}"];
  [@css ".css-1vf0mg9{background-size:1rem 1rem;}"];
  [@css
    ".css-rj3gnv{-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css ".css-f9xk9e{background-color:blue;}"];
  [@css
    ".css-1eo9rnb:disabled:not(.css-1eo9rnb.cid-1wqjj7x){background-color:gray;}"
  ];
  [@css.bindings
    [
      ("Input.foo", "cid-zec317", "css-tokvmb"),
      ("Input.bar", "cid-1eelq62", "css-11o9qin"),
      ("Input.buttonLoadingAnimation", "cid-1wqjj7x", "css-1vf0mg9 css-rj3gnv"),
      ("Input.colorAccent", "cid-qhdd42", "css-f9xk9e css-1eo9rnb"),
    ]
  ];
  
  let foo = CSS.make("label:foo cid-zec317 css-tokvmb", []);
  
  let bar = CSS.make("label:bar cid-1eelq62 css-11o9qin", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "label:buttonLoadingAnimation cid-1wqjj7x css-1vf0mg9 css-rj3gnv",
      [],
    );
  
  let colorAccent =
    CSS.make("label:colorAccent cid-qhdd42 css-f9xk9e css-1eo9rnb", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
