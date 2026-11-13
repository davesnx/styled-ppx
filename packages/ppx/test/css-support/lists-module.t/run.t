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
  [@css ".css-1g0s1eh{list-style-type:disclosure-closed;}"];
  [@css ".css-141zfhl{list-style-type:disclosure-open;}"];
  [@css ".css-1hf1p8s{list-style-type:hebrew;}"];
  [@css ".css-17jljk{list-style-type:cjk-decimal;}"];
  [@css ".css-yafyc9{list-style-type:cjk-ideographic;}"];
  [@css ".css-192h1m3{list-style-type:hiragana;}"];
  [@css ".css-o3tkj7{list-style-type:katakana;}"];
  [@css ".css-1ioolmo{list-style-type:hiragana-iroha;}"];
  [@css ".css-1rlry0x{list-style-type:katakana-iroha;}"];
  [@css ".css-11err2q{list-style-type:japanese-informal;}"];
  [@css ".css-m4m6te{list-style-type:japanese-formal;}"];
  [@css ".css-1keqcch{list-style-type:korean-hangul-formal;}"];
  [@css ".css-1sf9r15{list-style-type:korean-hanja-informal;}"];
  [@css ".css-6g6i67{list-style-type:korean-hanja-formal;}"];
  [@css ".css-1o2ds9j{list-style-type:simp-chinese-informal;}"];
  [@css ".css-1xqztl1{list-style-type:simp-chinese-formal;}"];
  [@css ".css-1i51jpj{list-style-type:trad-chinese-informal;}"];
  [@css ".css-1seph73{list-style-type:trad-chinese-formal;}"];
  [@css ".css-x9ltst{list-style-type:cjk-heavenly-stem;}"];
  [@css ".css-10v4nmh{list-style-type:cjk-earthly-branch;}"];
  [@css ".css-1x5m062{list-style-type:arabic-indic;}"];
  [@css ".css-kxquc7{list-style-type:persian;}"];
  [@css ".css-1xz31yx{list-style-type:urdu;}"];
  [@css ".css-1d2aog8{list-style-type:devanagari;}"];
  [@css ".css-96lm0q{list-style-type:gurmukhi;}"];
  [@css ".css-zajr4n{list-style-type:gujarati;}"];
  [@css ".css-1nflgm0{list-style-type:oriya;}"];
  [@css ".css-1xua0jl{list-style-type:kannada;}"];
  [@css ".css-57rld4{list-style-type:malayalam;}"];
  [@css ".css-yqdwd4{list-style-type:bengali;}"];
  [@css ".css-1kdgvie{list-style-type:tamil;}"];
  [@css ".css-1htp6b5{list-style-type:telugu;}"];
  [@css ".css-vz3jer{list-style-type:thai;}"];
  [@css ".css-6xtmcc{list-style-type:lao;}"];
  [@css ".css-1akh6mq{list-style-type:myanmar;}"];
  [@css ".css-1xrlm5p{list-style-type:khmer;}"];
  [@css ".css-1b9wsyp{list-style-type:hangul;}"];
  [@css ".css-1c86ow4{list-style-type:hangul-consonant;}"];
  [@css ".css-8101d3{list-style-type:ethiopic-halehame;}"];
  [@css ".css-17ybqom{list-style-type:ethiopic-numeric;}"];
  [@css ".css-ssbgd2{list-style-type:ethiopic-halehame-am;}"];
  [@css ".css-3mh3v1{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css ".css-9iwpln{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css ".css-1l6sye9{list-style-type:other-style;}"];
  [@css ".css-1co8lav{list-style-type:inside;}"];
  [@css ".css-9xahex{list-style-type:outside;}"];
  [@css ".css-tvlqeq{list-style-type:\\32 style;}"];
  [@css ".css-jkgg2l{list-style-type:custom-counter-style;}"];
  [@css ".css-zfgbgy{list-style-type:\"👍\";}"];
  [@css ".css-1q6fe9k{list-style-type:\"-\";}"];
  [@css ".css-8guxr0{counter-reset:foo;}"];
  [@css ".css-1ehsi6{counter-reset:foo 1;}"];
  [@css ".css-1xs4gw8{counter-reset:foo 1 bar;}"];
  [@css ".css-1nckn9k{counter-reset:foo 1 bar 2;}"];
  [@css ".css-1tiz3xg{counter-reset:none;}"];
  [@css ".css-1n0p51r{counter-set:foo;}"];
  [@css ".css-fgf662{counter-set:foo 1;}"];
  [@css ".css-1lej8t0{counter-set:foo 1 bar;}"];
  [@css ".css-sdj9t0{counter-set:foo 1 bar 2;}"];
  [@css ".css-1ngifcc{counter-set:none;}"];
  [@css ".css-zlqjdg{counter-increment:foo;}"];
  [@css ".css-18kir47{counter-increment:foo 1;}"];
  [@css ".css-1a8inkz{counter-increment:foo 1 bar;}"];
  [@css ".css-158tt7m{counter-increment:foo 1 bar 2;}"];
  [@css ".css-1aw44b0{counter-increment:none;}"];
  [@css.classes
    [
      ("css-1g0s1eh", 0, "", "input.re", 2, 8, 2, 42),
      ("css-141zfhl", 1, "", "input.re", 3, 8, 3, 40),
      ("css-1hf1p8s", 2, "", "input.re", 4, 8, 4, 31),
      ("css-17jljk", 3, "", "input.re", 5, 8, 5, 36),
      ("css-yafyc9", 4, "", "input.re", 6, 8, 6, 40),
      ("css-192h1m3", 5, "", "input.re", 7, 8, 7, 33),
      ("css-o3tkj7", 6, "", "input.re", 8, 8, 8, 33),
      ("css-1ioolmo", 7, "", "input.re", 9, 8, 9, 39),
      ("css-1rlry0x", 8, "", "input.re", 10, 8, 10, 39),
      ("css-11err2q", 9, "", "input.re", 11, 8, 11, 42),
      ("css-m4m6te", 10, "", "input.re", 12, 8, 12, 40),
      ("css-1keqcch", 11, "", "input.re", 13, 8, 13, 45),
      ("css-1sf9r15", 12, "", "input.re", 14, 8, 14, 46),
      ("css-6g6i67", 13, "", "input.re", 15, 8, 15, 44),
      ("css-1o2ds9j", 14, "", "input.re", 16, 8, 16, 46),
      ("css-1xqztl1", 15, "", "input.re", 17, 8, 17, 44),
      ("css-1i51jpj", 16, "", "input.re", 18, 8, 18, 46),
      ("css-1seph73", 17, "", "input.re", 19, 8, 19, 44),
      ("css-x9ltst", 18, "", "input.re", 20, 8, 20, 42),
      ("css-10v4nmh", 19, "", "input.re", 21, 8, 21, 43),
      ("css-1x5m062", 20, "", "input.re", 28, 8, 28, 37),
      ("css-kxquc7", 21, "", "input.re", 29, 8, 29, 32),
      ("css-1xz31yx", 22, "", "input.re", 30, 8, 30, 29),
      ("css-1d2aog8", 23, "", "input.re", 31, 8, 31, 35),
      ("css-96lm0q", 24, "", "input.re", 32, 8, 32, 33),
      ("css-zajr4n", 25, "", "input.re", 33, 8, 33, 33),
      ("css-1nflgm0", 26, "", "input.re", 34, 8, 34, 30),
      ("css-1xua0jl", 27, "", "input.re", 35, 8, 35, 32),
      ("css-57rld4", 28, "", "input.re", 36, 8, 36, 34),
      ("css-yqdwd4", 29, "", "input.re", 37, 8, 37, 32),
      ("css-1kdgvie", 30, "", "input.re", 38, 8, 38, 30),
      ("css-1htp6b5", 31, "", "input.re", 39, 8, 39, 31),
      ("css-vz3jer", 32, "", "input.re", 40, 8, 40, 29),
      ("css-6xtmcc", 33, "", "input.re", 41, 8, 41, 28),
      ("css-1akh6mq", 34, "", "input.re", 42, 8, 42, 32),
      ("css-1xrlm5p", 35, "", "input.re", 43, 8, 43, 30),
      ("css-1b9wsyp", 36, "", "input.re", 44, 8, 44, 31),
      ("css-1c86ow4", 37, "", "input.re", 45, 8, 45, 41),
      ("css-8101d3", 38, "", "input.re", 46, 8, 46, 42),
      ("css-17ybqom", 39, "", "input.re", 47, 8, 47, 41),
      ("css-ssbgd2", 40, "", "input.re", 48, 8, 48, 45),
      ("css-3mh3v1", 41, "", "input.re", 49, 8, 49, 48),
      ("css-9iwpln", 42, "", "input.re", 50, 8, 50, 48),
      ("css-1l6sye9", 43, "", "input.re", 51, 8, 51, 36),
      ("css-1co8lav", 44, "", "input.re", 52, 8, 52, 31),
      ("css-9xahex", 45, "", "input.re", 53, 8, 53, 32),
      ("css-tvlqeq", 46, "", "input.re", 55, 8, 55, 34),
      ("css-jkgg2l", 47, "", "input.re", 56, 8, 56, 45),
      ("css-zfgbgy", 48, "", "input.re", 57, 8, 57, 33),
      ("css-1q6fe9k", 49, "", "input.re", 58, 8, 58, 28),
      ("css-8guxr0", 50, "", "input.re", 64, 8, 64, 26),
      ("css-1ehsi6", 51, "", "input.re", 65, 8, 65, 28),
      ("css-1xs4gw8", 52, "", "input.re", 66, 8, 66, 32),
      ("css-1nckn9k", 53, "", "input.re", 67, 8, 67, 34),
      ("css-1tiz3xg", 54, "", "input.re", 68, 8, 68, 27),
      ("css-1n0p51r", 55, "", "input.re", 69, 8, 69, 24),
      ("css-fgf662", 56, "", "input.re", 70, 8, 70, 26),
      ("css-1lej8t0", 57, "", "input.re", 71, 8, 71, 30),
      ("css-sdj9t0", 58, "", "input.re", 72, 8, 72, 32),
      ("css-1ngifcc", 59, "", "input.re", 73, 8, 73, 25),
      ("css-zlqjdg", 60, "", "input.re", 74, 8, 74, 30),
      ("css-18kir47", 61, "", "input.re", 75, 8, 75, 32),
      ("css-1a8inkz", 62, "", "input.re", 76, 8, 76, 36),
      ("css-158tt7m", 63, "", "input.re", 77, 8, 77, 38),
      ("css-1aw44b0", 64, "", "input.re", 78, 8, 78, 31),
    ]
  ];
  
  CSS.make("css-1g0s1eh", []);
  CSS.make("css-141zfhl", []);
  CSS.make("css-1hf1p8s", []);
  CSS.make("css-17jljk", []);
  CSS.make("css-yafyc9", []);
  CSS.make("css-192h1m3", []);
  CSS.make("css-o3tkj7", []);
  CSS.make("css-1ioolmo", []);
  CSS.make("css-1rlry0x", []);
  CSS.make("css-11err2q", []);
  CSS.make("css-m4m6te", []);
  CSS.make("css-1keqcch", []);
  CSS.make("css-1sf9r15", []);
  CSS.make("css-6g6i67", []);
  CSS.make("css-1o2ds9j", []);
  CSS.make("css-1xqztl1", []);
  CSS.make("css-1i51jpj", []);
  CSS.make("css-1seph73", []);
  CSS.make("css-x9ltst", []);
  CSS.make("css-10v4nmh", []);
  CSS.make("css-1i51jpj", []);
  CSS.make("css-1seph73", []);
  CSS.make("css-1o2ds9j", []);
  CSS.make("css-1xqztl1", []);
  CSS.make("css-11err2q", []);
  CSS.make("css-m4m6te", []);
  CSS.make("css-1x5m062", []);
  CSS.make("css-kxquc7", []);
  CSS.make("css-1xz31yx", []);
  CSS.make("css-1d2aog8", []);
  CSS.make("css-96lm0q", []);
  CSS.make("css-zajr4n", []);
  CSS.make("css-1nflgm0", []);
  CSS.make("css-1xua0jl", []);
  CSS.make("css-57rld4", []);
  CSS.make("css-yqdwd4", []);
  CSS.make("css-1kdgvie", []);
  CSS.make("css-1htp6b5", []);
  CSS.make("css-vz3jer", []);
  CSS.make("css-6xtmcc", []);
  CSS.make("css-1akh6mq", []);
  CSS.make("css-1xrlm5p", []);
  CSS.make("css-1b9wsyp", []);
  CSS.make("css-1c86ow4", []);
  CSS.make("css-8101d3", []);
  CSS.make("css-17ybqom", []);
  CSS.make("css-ssbgd2", []);
  CSS.make("css-3mh3v1", []);
  CSS.make("css-9iwpln", []);
  CSS.make("css-1l6sye9", []);
  CSS.make("css-1co8lav", []);
  CSS.make("css-9xahex", []);
  
  CSS.make("css-tvlqeq", []);
  CSS.make("css-jkgg2l", []);
  CSS.make("css-zfgbgy", []);
  CSS.make("css-1q6fe9k", []);
  CSS.make("css-1q6fe9k", []);
  
  CSS.make("css-8guxr0", []);
  CSS.make("css-1ehsi6", []);
  CSS.make("css-1xs4gw8", []);
  CSS.make("css-1nckn9k", []);
  CSS.make("css-1tiz3xg", []);
  CSS.make("css-1n0p51r", []);
  CSS.make("css-fgf662", []);
  CSS.make("css-1lej8t0", []);
  CSS.make("css-sdj9t0", []);
  CSS.make("css-1ngifcc", []);
  CSS.make("css-zlqjdg", []);
  CSS.make("css-18kir47", []);
  CSS.make("css-1a8inkz", []);
  CSS.make("css-158tt7m", []);
  CSS.make("css-1aw44b0", []);
