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
    ".css-sxjqc9{direction:ltr;}\n.css-pu82ql{direction:rtl;}\n.css-1nh14px{unicode-bidi:normal;}\n.css-1dxtajz{unicode-bidi:embed;}\n.css-gthxsn{unicode-bidi:isolate;}\n.css-1f53xur{unicode-bidi:bidi-override;}\n.css-1sv30cq{unicode-bidi:isolate-override;}\n.css-3e7z6r{unicode-bidi:plaintext;}\n.css-1tyni7l{writing-mode:horizontal-tb;}\n.css-zorbdf{writing-mode:vertical-rl;}\n.css-bxuv7p{writing-mode:vertical-lr;}\n.css-1cbc989{text-orientation:mixed;}\n.css-1kcjqux{text-orientation:upright;}\n.css-ajfrh6{text-orientation:sideways;}\n.css-byubm3{text-combine-upright:none;}\n.css-16cjtzu{text-combine-upright:all;}\n.css-mpcjo4{writing-mode:sideways-rl;}\n.css-1tdq5f9{writing-mode:sideways-lr;}\n.css-6ofs5k{text-combine-upright:digits 2;}\n"
  ];
  
  CSS.make("css-sxjqc9", []);
  CSS.make("css-pu82ql", []);
  CSS.make("css-1nh14px", []);
  CSS.make("css-1dxtajz", []);
  CSS.make("css-gthxsn", []);
  CSS.make("css-1f53xur", []);
  CSS.make("css-1sv30cq", []);
  CSS.make("css-3e7z6r", []);
  CSS.make("css-1tyni7l", []);
  CSS.make("css-zorbdf", []);
  CSS.make("css-bxuv7p", []);
  CSS.make("css-1cbc989", []);
  CSS.make("css-1kcjqux", []);
  CSS.make("css-ajfrh6", []);
  CSS.make("css-byubm3", []);
  CSS.make("css-16cjtzu", []);
  
  CSS.make("css-mpcjo4", []);
  CSS.make("css-1tdq5f9", []);
  CSS.make("css-6ofs5k", []);
