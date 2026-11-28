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
  [@css ".css-ivpcv01{color:red;}"];
  [@css ".css-ivpcutd.css-ivpcv01{color:blue;}"];
  [@css
    ".css-ivpciaf{background-size:1rem 1rem;-webkit-animation-duration:1000ms;animation-duration:1000ms;}"
  ];
  [@css
    ".css-ivpcq9y{background-color:blue;}.css-ivpcq9y:disabled:not(.css-ivpcq9y.css-ivpciaf){background-color:gray;}"
  ];
  [@css.classes
    [
      ("css-ivpcv01", 0, "Input.foo", "input.re", 7, 19, 7, 31),
      ("css-ivpcutd", 1, "Input.bar", "input.re", 10, 2, 11, 0),
      (
        "css-ivpciaf",
        2,
        "Input.buttonLoadingAnimation",
        "input.re",
        16,
        2,
        18,
        0,
      ),
      ("css-ivpcq9y", 3, "Input.colorAccent", "input.re", 23, 2, 28, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input.foo", "css-ivpcv01"),
      ("Input.bar", "css-ivpcutd"),
      ("Input.buttonLoadingAnimation", "css-ivpciaf"),
      ("Input.colorAccent", "css-ivpcq9y"),
    ]
  ];
  
  let foo = CSS.make("css-ivpcv01", []);
  
  let bar = CSS.make("css-ivpcutd", []);
  
  let buttonLoadingAnimation = CSS.make("css-ivpciaf", []);
  
  let colorAccent = CSS.make("css-ivpcq9y", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
