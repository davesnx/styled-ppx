This test ensures clamp() and env() are reachable from length and percentage
properties, not just registered as standalone functions.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1b7dwmi{width:clamp(10px, 5vw, 100px);}"];
  [@css ".css-lfnbcb{padding-top:env(safe-area-inset-top);}"];
  [@css ".css-1oletb7{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css ".css-1ez48rc{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css ".css-1ai44vt{max-width:clamp(20%, 50vw, 80%);}"];
  [@css ".css-1wsgyxr{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  [@css.classes
    [
      ("css-1b7dwmi", 0, "", "input.re", 1, 8, 1, 38),
      ("css-lfnbcb", 1, "", "input.re", 2, 8, 2, 45),
      ("css-1oletb7", 2, "", "input.re", 3, 8, 3, 50),
      ("css-1ez48rc", 3, "", "input.re", 4, 8, 4, 43),
      ("css-1ai44vt", 4, "", "input.re", 5, 8, 5, 40),
      ("css-1wsgyxr", 5, "", "input.re", 6, 8, 6, 47),
    ]
  ];
  CSS.make("css-1b7dwmi", []);
  CSS.make("css-lfnbcb", []);
  CSS.make("css-1oletb7", []);
  CSS.make("css-1ez48rc", []);
  CSS.make("css-1ai44vt", []);
  CSS.make("css-1wsgyxr", []);

  $ dune build
