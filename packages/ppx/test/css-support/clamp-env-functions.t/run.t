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
  [@css ".css-ivpcwmi{width:clamp(10px, 5vw, 100px);}"];
  [@css ".css-ivpcbcb{padding-top:env(safe-area-inset-top);}"];
  [@css ".css-ivpctb7{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css ".css-ivpc8rc{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css ".css-ivpc4vt{max-width:clamp(20%, 50vw, 80%);}"];
  [@css ".css-ivpcyxr{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  [@css.classes
    [
      ("css-ivpcwmi", 0, "", "input.re", 1, 8, 1, 38),
      ("css-ivpcbcb", 1, "", "input.re", 2, 8, 2, 45),
      ("css-ivpctb7", 2, "", "input.re", 3, 8, 3, 50),
      ("css-ivpc8rc", 3, "", "input.re", 4, 8, 4, 43),
      ("css-ivpc4vt", 4, "", "input.re", 5, 8, 5, 40),
      ("css-ivpcyxr", 5, "", "input.re", 6, 8, 6, 47),
    ]
  ];
  CSS.make("css-ivpcwmi", []);
  CSS.make("css-ivpcbcb", []);
  CSS.make("css-ivpctb7", []);
  CSS.make("css-ivpc8rc", []);
  CSS.make("css-ivpc4vt", []);
  CSS.make("css-ivpcyxr", []);

  $ dune build
