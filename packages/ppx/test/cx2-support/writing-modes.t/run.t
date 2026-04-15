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
  [@css ".css-sxjqc9{direction:ltr;}"];
  [@css ".css-pu82ql{direction:rtl;}"];
  [@css ".css-1nh14px{unicode-bidi:normal;}"];
  [@css ".css-1dxtajz{unicode-bidi:embed;}"];
  [@css ".css-gthxsn{unicode-bidi:isolate;}"];
  [@css ".css-1f53xur{unicode-bidi:bidi-override;}"];
  [@css ".css-1sv30cq{unicode-bidi:isolate-override;}"];
  [@css ".css-3e7z6r{unicode-bidi:plaintext;}"];
  [@css ".css-1tyni7l{writing-mode:horizontal-tb;}"];
  [@css ".css-zorbdf{writing-mode:vertical-rl;}"];
  [@css ".css-bxuv7p{writing-mode:vertical-lr;}"];
  [@css ".css-1cbc989{text-orientation:mixed;}"];
  [@css ".css-1kcjqux{text-orientation:upright;}"];
  [@css ".css-ajfrh6{text-orientation:sideways;}"];
  [@css ".css-byubm3{text-combine-upright:none;}"];
  [@css ".css-16cjtzu{text-combine-upright:all;}"];
  [@css ".css-mpcjo4{writing-mode:sideways-rl;}"];
  [@css ".css-1tdq5f9{writing-mode:sideways-lr;}"];
  [@css ".css-6ofs5k{text-combine-upright:digits 2;}"];
  
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
