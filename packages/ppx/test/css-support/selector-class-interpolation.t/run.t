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
  [@css ".css-13dtv01{color:red;}"];
  [@css ".css-123fdlm.css-13dtv01{color:blue;}"];
  [@css
    ".css-czniaf{background-size:1rem 1rem;-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css
    ".css-gte91w{background-color:blue;}.css-gte91w:disabled:not(.css-gte91w.css-czniaf){background-color:gray;}"
  ];
  [@css.classes
    [
      ("css-13dtv01", 0, "Input.foo", "input.re", 7, 19, 7, 31),
      ("css-123fdlm", 1, "Input.bar", "input.re", 10, 2, 11, 0),
      (
        "css-czniaf",
        2,
        "Input.buttonLoadingAnimation",
        "input.re",
        16,
        2,
        18,
        0,
      ),
      ("css-gte91w", 3, "Input.colorAccent", "input.re", 23, 2, 28, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input.foo", "css-13dtv01"),
      ("Input.bar", "css-123fdlm"),
      ("Input.buttonLoadingAnimation", "css-czniaf"),
      ("Input.colorAccent", "css-gte91w"),
    ]
  ];
  
  let foo = CSS.make("css-13dtv01", []);
  
  let bar = CSS.make("css-123fdlm", []);
  
  let buttonLoadingAnimation = CSS.make("css-czniaf", []);
  
  let colorAccent = CSS.make("css-gte91w", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
