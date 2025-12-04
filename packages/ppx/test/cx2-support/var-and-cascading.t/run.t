This test ensures the ppx generates the correct output for CSS var() and cascading keywords
If this test fails, the var() and cascading support is broken

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
  [@css
    ".css-1glxu8s { color: var(--primary-color); }\n.css-1pb584 { background-color: var(--bg-color); }\n.css-1neknja { margin: var(--spacing); }\n.css-lwqh0f { padding: var(--padding); }\n.css-qmb1hb { font-size: var(--font-size); }\n.css-1mb5x5i { width: var(--width); }\n.css-1n0v2cg { height: var(--height); }\n.css-1cxetvo { color: inherit; }\n.css-cntzno { color: initial; }\n.css-1ogrdc { color: unset; }\n.css-zoul7b { color: revert; }\n.css-10n65df { color: revert-layer; }\n.css-1ta3kuu { display: inherit; }\n.css-18cp96a { display: initial; }\n.css-i0ojef { display: unset; }\n.css-24o1lf { display: revert; }\n.css-1e9vot7 { display: revert-layer; }\n.css-2n3q8u { margin: inherit; }\n.css-h9q9wt { margin: initial; }\n.css-16tgoue { margin: unset; }\n.css-f28jop { margin: revert; }\n.css-1h0cs5y { margin: revert-layer; }\n.css-8sazca { flex: inherit; }\n.css-1321jgx { flex: initial; }\n.css-znfx4g { flex: unset; }\n.css-1w4yl1x { flex: revert; }\n.css-1bkvihi { flex: revert-layer; }\n.css-6idvl6 { font-size: inherit; }\n.css-la8nmi { font-size: initial; }\n.css-1ifvob1 { font-size: unset; }\n.css-1t9fouf { font-size: revert; }\n.css-nef5ud { font-size: revert-layer; }\n"
  ];
  CSS.make("css-1glxu8s", []);
  CSS.make("css-1pb584", []);
  CSS.make("css-1neknja", []);
  CSS.make("css-lwqh0f", []);
  CSS.make("css-qmb1hb", []);
  CSS.make("css-1mb5x5i", []);
  CSS.make("css-1n0v2cg", []);
  
  CSS.make("css-1cxetvo", []);
  CSS.make("css-cntzno", []);
  CSS.make("css-1ogrdc", []);
  CSS.make("css-zoul7b", []);
  CSS.make("css-10n65df", []);
  
  CSS.make("css-1ta3kuu", []);
  CSS.make("css-18cp96a", []);
  CSS.make("css-i0ojef", []);
  CSS.make("css-24o1lf", []);
  CSS.make("css-1e9vot7", []);
  
  CSS.make("css-2n3q8u", []);
  CSS.make("css-h9q9wt", []);
  CSS.make("css-16tgoue", []);
  CSS.make("css-f28jop", []);
  CSS.make("css-1h0cs5y", []);
  
  CSS.make("css-8sazca", []);
  CSS.make("css-1321jgx", []);
  CSS.make("css-znfx4g", []);
  CSS.make("css-1w4yl1x", []);
  CSS.make("css-1bkvihi", []);
  
  CSS.make("css-6idvl6", []);
  CSS.make("css-la8nmi", []);
  CSS.make("css-1ifvob1", []);
  CSS.make("css-1t9fouf", []);
  CSS.make("css-nef5ud", []);

