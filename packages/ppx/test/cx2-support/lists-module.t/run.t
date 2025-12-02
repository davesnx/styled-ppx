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
    ".css-5a9vyu { list-style-type: disclosure-closed; }\n.css-c1003r { list-style-type: disclosure-open; }\n.css-1w46ffj { list-style-type: hebrew; }\n.css-1dmna59 { list-style-type: cjk-decimal; }\n.css-18lv0hf { list-style-type: cjk-ideographic; }\n.css-1t0hr9g { list-style-type: hiragana; }\n.css-1uzg3mr { list-style-type: katakana; }\n.css-i704vy { list-style-type: hiragana-iroha; }\n.css-1cbp92k { list-style-type: katakana-iroha; }\n.css-d5x19b { list-style-type: japanese-informal; }\n.css-1oltvvu { list-style-type: japanese-formal; }\n.css-uy0vxz { list-style-type: korean-hangul-formal; }\n.css-gbbmvq { list-style-type: korean-hanja-informal; }\n.css-fk9j3i { list-style-type: korean-hanja-formal; }\n.css-1h1ugzk { list-style-type: simp-chinese-informal; }\n.css-14gm3jf { list-style-type: simp-chinese-formal; }\n.css-mi3re7 { list-style-type: trad-chinese-informal; }\n.css-a95a75 { list-style-type: trad-chinese-formal; }\n.css-15altl4 { list-style-type: cjk-heavenly-stem; }\n.css-5x7ng6 { list-style-type: cjk-earthly-branch; }\n.css-md6uc3 { list-style-type: arabic-indic; }\n.css-1by1xvx { list-style-type: persian; }\n.css-shziju { list-style-type: urdu; }\n.css-27v0qe { list-style-type: devanagari; }\n.css-1guizgl { list-style-type: gurmukhi; }\n.css-1p2msvx { list-style-type: gujarati; }\n.css-1a93lpw { list-style-type: oriya; }\n.css-hcg4em { list-style-type: kannada; }\n.css-h9y3bw { list-style-type: malayalam; }\n.css-1ecy2di { list-style-type: bengali; }\n.css-bumc7u { list-style-type: tamil; }\n.css-130rtjn { list-style-type: telugu; }\n.css-t3ks86 { list-style-type: thai; }\n.css-1rxfl8u { list-style-type: lao; }\n.css-1faadl9 { list-style-type: myanmar; }\n.css-1uhqza5 { list-style-type: khmer; }\n.css-12lm46k { list-style-type: hangul; }\n.css-9mg8db { list-style-type: hangul-consonant; }\n.css-gvu16t { list-style-type: ethiopic-halehame; }\n.css-1w4sxnb { list-style-type: ethiopic-numeric; }\n.css-33f8uc { list-style-type: ethiopic-halehame-am; }\n.css-17vjll0 { list-style-type: ethiopic-halehame-ti-er; }\n.css-1ezyy68 { list-style-type: ethiopic-halehame-ti-et; }\n.css-1g11ygw { list-style-type: other-style; }\n.css-uzsdtm { list-style-type: inside; }\n.css-1caivmr { list-style-type: outside; }\n.css-2k6bhv { list-style-type: \\32 style; }\n.css-z2l7c4 { list-style-type: custom-counter-style; }\n.css-1ev3ddi { list-style-type: \"-\"; }\n.css-1iby8ns { counter-reset: foo; }\n.css-svt67b { counter-reset: foo 1; }\n.css-10qb5l4 { counter-reset: foo 1 bar; }\n.css-10yajno { counter-reset: foo 1 bar 2; }\n.css-a0b9cd { counter-reset: none; }\n.css-1d7l2k7 { counter-set: foo; }\n.css-c67b2u { counter-set: foo 1; }\n.css-e09x7l { counter-set: foo 1 bar; }\n.css-10r83or { counter-set: foo 1 bar 2; }\n.css-yvxtsd { counter-set: none; }\n.css-1i1bwho { counter-increment: foo; }\n.css-uyj488 { counter-increment: foo 1; }\n.css-i8ch11 { counter-increment: foo 1 bar; }\n.css-ud458x { counter-increment: foo 1 bar 2; }\n.css-1jtmoiv { counter-increment: none; }\n"
  ];
  CSS.make("css-5a9vyu", []);
  CSS.make("css-c1003r", []);
  CSS.make("css-1w46ffj", []);
  CSS.make("css-1dmna59", []);
  CSS.make("css-18lv0hf", []);
  CSS.make("css-1t0hr9g", []);
  CSS.make("css-1uzg3mr", []);
  CSS.make("css-i704vy", []);
  CSS.make("css-1cbp92k", []);
  CSS.make("css-d5x19b", []);
  CSS.make("css-1oltvvu", []);
  CSS.make("css-uy0vxz", []);
  CSS.make("css-gbbmvq", []);
  CSS.make("css-fk9j3i", []);
  CSS.make("css-1h1ugzk", []);
  CSS.make("css-14gm3jf", []);
  CSS.make("css-mi3re7", []);
  CSS.make("css-a95a75", []);
  CSS.make("css-15altl4", []);
  CSS.make("css-5x7ng6", []);
  CSS.make("css-mi3re7", []);
  CSS.make("css-a95a75", []);
  CSS.make("css-1h1ugzk", []);
  CSS.make("css-14gm3jf", []);
  CSS.make("css-d5x19b", []);
  CSS.make("css-1oltvvu", []);
  CSS.make("css-md6uc3", []);
  CSS.make("css-1by1xvx", []);
  CSS.make("css-shziju", []);
  CSS.make("css-27v0qe", []);
  CSS.make("css-1guizgl", []);
  CSS.make("css-1p2msvx", []);
  CSS.make("css-1a93lpw", []);
  CSS.make("css-hcg4em", []);
  CSS.make("css-h9y3bw", []);
  CSS.make("css-1ecy2di", []);
  CSS.make("css-bumc7u", []);
  CSS.make("css-130rtjn", []);
  CSS.make("css-t3ks86", []);
  CSS.make("css-1rxfl8u", []);
  CSS.make("css-1faadl9", []);
  CSS.make("css-1uhqza5", []);
  CSS.make("css-12lm46k", []);
  CSS.make("css-9mg8db", []);
  CSS.make("css-gvu16t", []);
  CSS.make("css-1w4sxnb", []);
  CSS.make("css-33f8uc", []);
  CSS.make("css-17vjll0", []);
  CSS.make("css-1ezyy68", []);
  CSS.make("css-1g11ygw", []);
  CSS.make("css-uzsdtm", []);
  CSS.make("css-1caivmr", []);
  
  CSS.make("css-2k6bhv", []);
  CSS.make("css-z2l7c4", []);
  CSS.make("css-1ev3ddi", []);
  CSS.make("css-1ev3ddi", []);
  
  CSS.make("css-1iby8ns", []);
  CSS.make("css-svt67b", []);
  CSS.make("css-10qb5l4", []);
  CSS.make("css-10yajno", []);
  CSS.make("css-a0b9cd", []);
  CSS.make("css-1d7l2k7", []);
  CSS.make("css-c67b2u", []);
  CSS.make("css-e09x7l", []);
  CSS.make("css-10r83or", []);
  CSS.make("css-yvxtsd", []);
  CSS.make("css-1i1bwho", []);
  CSS.make("css-uyj488", []);
  CSS.make("css-i8ch11", []);
  CSS.make("css-ud458x", []);
  CSS.make("css-1jtmoiv", []);
