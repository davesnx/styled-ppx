This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

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
    ".css-10dryv9 { direction: ltr; }\n.css-1t6mbq0 { direction: rtl; }\n.css-1e2a1aq { unicode-bidi: normal; }\n.css-pyfek0 { unicode-bidi: embed; }\n.css-14qtkiq { unicode-bidi: isolate; }\n.css-1f0d99h { unicode-bidi: bidi-override; }\n.css-gtyopt { unicode-bidi: isolate-override; }\n.css-eqte9c { unicode-bidi: plaintext; }\n.css-1q8b0qf { writing-mode: horizontal-tb; }\n.css-1ko2hai { writing-mode: vertical-rl; }\n.css-11ecu7g { writing-mode: vertical-lr; }\n.css-1871fyv { text-orientation: mixed; }\n.css-ahqekl { text-orientation: upright; }\n.css-1n65wl2 { text-orientation: sideways; }\n.css-95w3en { text-combine-upright: none; }\n.css-yhddnv { text-combine-upright: all; }\n.css-1ucgjin { writing-mode: sideways-rl; }\n.css-1eo241w { writing-mode: sideways-lr; }\n.css-1vx8f33 { text-combine-upright: digits 2; }\n"
  ];
  CSS.make("css-10dryv9", []);
  CSS.make("css-1t6mbq0", []);
  CSS.make("css-1e2a1aq", []);
  CSS.make("css-pyfek0", []);
  CSS.make("css-14qtkiq", []);
  CSS.make("css-1f0d99h", []);
  CSS.make("css-gtyopt", []);
  CSS.make("css-eqte9c", []);
  CSS.make("css-1q8b0qf", []);
  CSS.make("css-1ko2hai", []);
  CSS.make("css-11ecu7g", []);
  CSS.make("css-1871fyv", []);
  CSS.make("css-ahqekl", []);
  CSS.make("css-1n65wl2", []);
  CSS.make("css-95w3en", []);
  CSS.make("css-yhddnv", []);
  
  CSS.make("css-1ucgjin", []);
  CSS.make("css-1eo241w", []);
  CSS.make("css-1vx8f33", []);
