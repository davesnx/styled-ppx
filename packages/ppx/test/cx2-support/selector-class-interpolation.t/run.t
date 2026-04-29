Same-module class-name interpolation in [%cx2] selectors must resolve at
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
  [@css ".css-tokvmb-foo{color:red;}"];
  [@css ".css-11o9qin-bar.css-tokvmb-foo{color:blue;}"];
  [@css ".css-1vf0mg9-buttonLoadingAnimation{background-size:1rem 1rem;}"];
  [@css ".css-rj3gnv-buttonLoadingAnimation{animation-duration:1000ms;}"];
  [@css ".css-f9xk9e-colorAccent{background-color:blue;}"];
  [@css
    ".css-1eo9rnb-colorAccent:disabled:not(.css-1eo9rnb-colorAccent.css-1vf0mg9-buttonLoadingAnimation.css-rj3gnv-buttonLoadingAnimation){background-color:gray;}"
  ];
  [@css.bindings
    [
      ("Input.foo", "css-tokvmb-foo"),
      ("Input.bar", "css-11o9qin-bar"),
      (
        "Input.buttonLoadingAnimation",
        "css-1vf0mg9-buttonLoadingAnimation css-rj3gnv-buttonLoadingAnimation",
      ),
      ("Input.colorAccent", "css-f9xk9e-colorAccent css-1eo9rnb-colorAccent"),
    ]
  ];
  
  let foo = CSS.make("css-tokvmb-foo", []);
  
  let bar = CSS.make("css-11o9qin-bar", []);
  
  let buttonLoadingAnimation =
    CSS.make(
      "css-1vf0mg9-buttonLoadingAnimation css-rj3gnv-buttonLoadingAnimation",
      [],
    );
  
  let colorAccent =
    CSS.make("css-f9xk9e-colorAccent css-1eo9rnb-colorAccent", []);
  
  let _ = (foo, bar, buttonLoadingAnimation, colorAccent);

  $ dune build
