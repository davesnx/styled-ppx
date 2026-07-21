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
  [@css ".css-tokvmb-foo{color:red}"];
  [@css ".css-nghj5b-bar.css-tokvmb-foo{color:blue}"];
  [@css ".css-1vf0mg9-buttonLoadingAnimation{background-size:1rem 1rem}"];
  [@css
    ".css-rj3gnv-buttonLoadingAnimation{-webkit-animation-duration:1000ms;animation-duration:1000ms}"
  ];
  [@css ".css-f9xk9e-colorAccent{background-color:blue}"];
  [@css
    ".css-1jdvn5g-colorAccent:disabled:not(.css-1jdvn5g-colorAccent.css-1vf0mg9-buttonLoadingAnimation.css-rj3gnv-buttonLoadingAnimation){background-color:gray}"
  ];
  [@css.bindings
    [
      ("Input.foo", "css-tokvmb-foo"),
      ("Input.bar", "css-nghj5b-bar"),
      (
        "Input.buttonLoadingAnimation",
        "css-1vf0mg9-buttonLoadingAnimation css-rj3gnv-buttonLoadingAnimation",
      ),
      ("Input.colorAccent", "css-f9xk9e-colorAccent css-1jdvn5g-colorAccent"),
    ]
  ];
  
  let foo = CSS.make("css-tokvmb-foo", []);
  
  let bar = CSS.make("css-nghj5b-bar", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "css-1vf0mg9-buttonLoadingAnimation css-rj3gnv-buttonLoadingAnimation",
      [],
    );
  
  let colorAccent =
    CSS.make("css-f9xk9e-colorAccent css-1jdvn5g-colorAccent", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
