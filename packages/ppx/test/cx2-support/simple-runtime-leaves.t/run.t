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
    ".css-1ww2ddt{empty-cells:show;}\n.css-2uav7h{empty-cells:hide;}\n.css-1wyzhlp{field-sizing:content;}\n.css-1rpat5c{field-sizing:fixed;}\n.css-1eo7wts{interpolate-size:numeric-only;}\n.css-ja4lek{interpolate-size:allow-keywords;}\n.css-19bo2dy{initial-letter:normal;}\n.css-12uwub8{initial-letter:1.5;}\n.css-1h50l7m{initial-letter:1.5 2;}\n.css-mobm9f{initial-letter-align:auto;}\n.css-1hnpsj{initial-letter-align:alphabetic;}\n.css-1hjwje6{initial-letter-align:hanging;}\n.css-nrtz0y{initial-letter-align:ideographic;}\n.css-5cqonx{image-resolution:from-image;}\n.css-1od4m46{image-resolution:96dpi;}\n.css-m6btb7{image-resolution:2dppx;}\n.css-1g7wnyr{image-resolution:from-image snap;}\n.css-8kehnm{image-resolution:96dpi snap;}\n"
  ];
  
  CSS.make("css-1ww2ddt", []);
  CSS.make("css-2uav7h", []);
  CSS.make("css-1wyzhlp", []);
  CSS.make("css-1rpat5c", []);
  CSS.make("css-1eo7wts", []);
  CSS.make("css-ja4lek", []);
  CSS.make("css-19bo2dy", []);
  CSS.make("css-12uwub8", []);
  CSS.make("css-1h50l7m", []);
  CSS.make("css-mobm9f", []);
  CSS.make("css-1hnpsj", []);
  CSS.make("css-1hjwje6", []);
  CSS.make("css-nrtz0y", []);
  CSS.make("css-5cqonx", []);
  CSS.make("css-1od4m46", []);
  CSS.make("css-m6btb7", []);
  CSS.make("css-1g7wnyr", []);
  CSS.make("css-8kehnm", []);
