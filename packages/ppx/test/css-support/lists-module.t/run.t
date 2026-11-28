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
  [@css ".css-ivpc1eh{list-style-type:disclosure-closed;}"];
  [@css ".css-ivpcfhl{list-style-type:disclosure-open;}"];
  [@css ".css-ivpcp8s{list-style-type:hebrew;}"];
  [@css ".css-ivpcljk{list-style-type:cjk-decimal;}"];
  [@css ".css-ivpcyc9{list-style-type:cjk-ideographic;}"];
  [@css ".css-ivpc1m3{list-style-type:hiragana;}"];
  [@css ".css-ivpckj7{list-style-type:katakana;}"];
  [@css ".css-ivpclmo{list-style-type:hiragana-iroha;}"];
  [@css ".css-ivpcy0x{list-style-type:katakana-iroha;}"];
  [@css ".css-ivpcr2q{list-style-type:japanese-informal;}"];
  [@css ".css-ivpc6te{list-style-type:japanese-formal;}"];
  [@css ".css-ivpccch{list-style-type:korean-hangul-formal;}"];
  [@css ".css-ivpcr15{list-style-type:korean-hanja-informal;}"];
  [@css ".css-ivpci67{list-style-type:korean-hanja-formal;}"];
  [@css ".css-ivpcs9j{list-style-type:simp-chinese-informal;}"];
  [@css ".css-ivpctl1{list-style-type:simp-chinese-formal;}"];
  [@css ".css-ivpcjpj{list-style-type:trad-chinese-informal;}"];
  [@css ".css-ivpch73{list-style-type:trad-chinese-formal;}"];
  [@css ".css-ivpctst{list-style-type:cjk-heavenly-stem;}"];
  [@css ".css-ivpcnmh{list-style-type:cjk-earthly-branch;}"];
  [@css ".css-ivpc062{list-style-type:arabic-indic;}"];
  [@css ".css-ivpcuc7{list-style-type:persian;}"];
  [@css ".css-ivpc1yx{list-style-type:urdu;}"];
  [@css ".css-ivpcog8{list-style-type:devanagari;}"];
  [@css ".css-ivpcm0q{list-style-type:gurmukhi;}"];
  [@css ".css-ivpcr4n{list-style-type:gujarati;}"];
  [@css ".css-ivpcgm0{list-style-type:oriya;}"];
  [@css ".css-ivpc0jl{list-style-type:kannada;}"];
  [@css ".css-ivpcld4{list-style-type:malayalam;}"];
  [@css ".css-ivpcwd4{list-style-type:bengali;}"];
  [@css ".css-ivpcvie{list-style-type:tamil;}"];
  [@css ".css-ivpc6b5{list-style-type:telugu;}"];
  [@css ".css-ivpcjer{list-style-type:thai;}"];
  [@css ".css-ivpcmcc{list-style-type:lao;}"];
  [@css ".css-ivpc6mq{list-style-type:myanmar;}"];
  [@css ".css-ivpcm5p{list-style-type:khmer;}"];
  [@css ".css-ivpcsyp{list-style-type:hangul;}"];
  [@css ".css-ivpcow4{list-style-type:hangul-consonant;}"];
  [@css ".css-ivpc1d3{list-style-type:ethiopic-halehame;}"];
  [@css ".css-ivpcqom{list-style-type:ethiopic-numeric;}"];
  [@css ".css-ivpcgd2{list-style-type:ethiopic-halehame-am;}"];
  [@css ".css-ivpc3v1{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css ".css-ivpcpln{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css ".css-ivpcye9{list-style-type:other-style;}"];
  [@css ".css-ivpclav{list-style-type:inside;}"];
  [@css ".css-ivpchex{list-style-type:outside;}"];
  [@css ".css-ivpcqeq{list-style-type:\\32 style;}"];
  [@css ".css-ivpcg2l{list-style-type:custom-counter-style;}"];
  [@css ".css-ivpcbgy{list-style-type:\"👍\";}"];
  [@css ".css-ivpce9k{list-style-type:\"-\";}"];
  [@css ".css-ivpcxr0{counter-reset:foo;}"];
  [@css ".css-ivpcsi6{counter-reset:foo 1;}"];
  [@css ".css-ivpcgw8{counter-reset:foo 1 bar;}"];
  [@css ".css-ivpcn9k{counter-reset:foo 1 bar 2;}"];
  [@css ".css-ivpc3xg{counter-reset:none;}"];
  [@css ".css-ivpc51r{counter-set:foo;}"];
  [@css ".css-ivpc662{counter-set:foo 1;}"];
  [@css ".css-ivpc8t0{counter-set:foo 1 bar;}"];
  [@css ".css-ivpc9t0{counter-set:foo 1 bar 2;}"];
  [@css ".css-ivpcfcc{counter-set:none;}"];
  [@css ".css-ivpcjdg{counter-increment:foo;}"];
  [@css ".css-ivpcr47{counter-increment:foo 1;}"];
  [@css ".css-ivpcnkz{counter-increment:foo 1 bar;}"];
  [@css ".css-ivpct7m{counter-increment:foo 1 bar 2;}"];
  [@css ".css-ivpc4b0{counter-increment:none;}"];
  [@css.classes
    [
      ("css-ivpc1eh", 0, "", "input.re", 2, 8, 2, 42),
      ("css-ivpcfhl", 1, "", "input.re", 3, 8, 3, 40),
      ("css-ivpcp8s", 2, "", "input.re", 4, 8, 4, 31),
      ("css-ivpcljk", 3, "", "input.re", 5, 8, 5, 36),
      ("css-ivpcyc9", 4, "", "input.re", 6, 8, 6, 40),
      ("css-ivpc1m3", 5, "", "input.re", 7, 8, 7, 33),
      ("css-ivpckj7", 6, "", "input.re", 8, 8, 8, 33),
      ("css-ivpclmo", 7, "", "input.re", 9, 8, 9, 39),
      ("css-ivpcy0x", 8, "", "input.re", 10, 8, 10, 39),
      ("css-ivpcr2q", 9, "", "input.re", 11, 8, 11, 42),
      ("css-ivpc6te", 10, "", "input.re", 12, 8, 12, 40),
      ("css-ivpccch", 11, "", "input.re", 13, 8, 13, 45),
      ("css-ivpcr15", 12, "", "input.re", 14, 8, 14, 46),
      ("css-ivpci67", 13, "", "input.re", 15, 8, 15, 44),
      ("css-ivpcs9j", 14, "", "input.re", 16, 8, 16, 46),
      ("css-ivpctl1", 15, "", "input.re", 17, 8, 17, 44),
      ("css-ivpcjpj", 16, "", "input.re", 18, 8, 18, 46),
      ("css-ivpch73", 17, "", "input.re", 19, 8, 19, 44),
      ("css-ivpctst", 18, "", "input.re", 20, 8, 20, 42),
      ("css-ivpcnmh", 19, "", "input.re", 21, 8, 21, 43),
      ("css-ivpc062", 20, "", "input.re", 28, 8, 28, 37),
      ("css-ivpcuc7", 21, "", "input.re", 29, 8, 29, 32),
      ("css-ivpc1yx", 22, "", "input.re", 30, 8, 30, 29),
      ("css-ivpcog8", 23, "", "input.re", 31, 8, 31, 35),
      ("css-ivpcm0q", 24, "", "input.re", 32, 8, 32, 33),
      ("css-ivpcr4n", 25, "", "input.re", 33, 8, 33, 33),
      ("css-ivpcgm0", 26, "", "input.re", 34, 8, 34, 30),
      ("css-ivpc0jl", 27, "", "input.re", 35, 8, 35, 32),
      ("css-ivpcld4", 28, "", "input.re", 36, 8, 36, 34),
      ("css-ivpcwd4", 29, "", "input.re", 37, 8, 37, 32),
      ("css-ivpcvie", 30, "", "input.re", 38, 8, 38, 30),
      ("css-ivpc6b5", 31, "", "input.re", 39, 8, 39, 31),
      ("css-ivpcjer", 32, "", "input.re", 40, 8, 40, 29),
      ("css-ivpcmcc", 33, "", "input.re", 41, 8, 41, 28),
      ("css-ivpc6mq", 34, "", "input.re", 42, 8, 42, 32),
      ("css-ivpcm5p", 35, "", "input.re", 43, 8, 43, 30),
      ("css-ivpcsyp", 36, "", "input.re", 44, 8, 44, 31),
      ("css-ivpcow4", 37, "", "input.re", 45, 8, 45, 41),
      ("css-ivpc1d3", 38, "", "input.re", 46, 8, 46, 42),
      ("css-ivpcqom", 39, "", "input.re", 47, 8, 47, 41),
      ("css-ivpcgd2", 40, "", "input.re", 48, 8, 48, 45),
      ("css-ivpc3v1", 41, "", "input.re", 49, 8, 49, 48),
      ("css-ivpcpln", 42, "", "input.re", 50, 8, 50, 48),
      ("css-ivpcye9", 43, "", "input.re", 51, 8, 51, 36),
      ("css-ivpclav", 44, "", "input.re", 52, 8, 52, 31),
      ("css-ivpchex", 45, "", "input.re", 53, 8, 53, 32),
      ("css-ivpcqeq", 46, "", "input.re", 55, 8, 55, 34),
      ("css-ivpcg2l", 47, "", "input.re", 56, 8, 56, 45),
      ("css-ivpcbgy", 48, "", "input.re", 57, 8, 57, 33),
      ("css-ivpce9k", 49, "", "input.re", 58, 8, 58, 28),
      ("css-ivpcxr0", 50, "", "input.re", 64, 8, 64, 26),
      ("css-ivpcsi6", 51, "", "input.re", 65, 8, 65, 28),
      ("css-ivpcgw8", 52, "", "input.re", 66, 8, 66, 32),
      ("css-ivpcn9k", 53, "", "input.re", 67, 8, 67, 34),
      ("css-ivpc3xg", 54, "", "input.re", 68, 8, 68, 27),
      ("css-ivpc51r", 55, "", "input.re", 69, 8, 69, 24),
      ("css-ivpc662", 56, "", "input.re", 70, 8, 70, 26),
      ("css-ivpc8t0", 57, "", "input.re", 71, 8, 71, 30),
      ("css-ivpc9t0", 58, "", "input.re", 72, 8, 72, 32),
      ("css-ivpcfcc", 59, "", "input.re", 73, 8, 73, 25),
      ("css-ivpcjdg", 60, "", "input.re", 74, 8, 74, 30),
      ("css-ivpcr47", 61, "", "input.re", 75, 8, 75, 32),
      ("css-ivpcnkz", 62, "", "input.re", 76, 8, 76, 36),
      ("css-ivpct7m", 63, "", "input.re", 77, 8, 77, 38),
      ("css-ivpc4b0", 64, "", "input.re", 78, 8, 78, 31),
    ]
  ];
  
  CSS.make("css-ivpc1eh", []);
  CSS.make("css-ivpcfhl", []);
  CSS.make("css-ivpcp8s", []);
  CSS.make("css-ivpcljk", []);
  CSS.make("css-ivpcyc9", []);
  CSS.make("css-ivpc1m3", []);
  CSS.make("css-ivpckj7", []);
  CSS.make("css-ivpclmo", []);
  CSS.make("css-ivpcy0x", []);
  CSS.make("css-ivpcr2q", []);
  CSS.make("css-ivpc6te", []);
  CSS.make("css-ivpccch", []);
  CSS.make("css-ivpcr15", []);
  CSS.make("css-ivpci67", []);
  CSS.make("css-ivpcs9j", []);
  CSS.make("css-ivpctl1", []);
  CSS.make("css-ivpcjpj", []);
  CSS.make("css-ivpch73", []);
  CSS.make("css-ivpctst", []);
  CSS.make("css-ivpcnmh", []);
  CSS.make("css-ivpcjpj", []);
  CSS.make("css-ivpch73", []);
  CSS.make("css-ivpcs9j", []);
  CSS.make("css-ivpctl1", []);
  CSS.make("css-ivpcr2q", []);
  CSS.make("css-ivpc6te", []);
  CSS.make("css-ivpc062", []);
  CSS.make("css-ivpcuc7", []);
  CSS.make("css-ivpc1yx", []);
  CSS.make("css-ivpcog8", []);
  CSS.make("css-ivpcm0q", []);
  CSS.make("css-ivpcr4n", []);
  CSS.make("css-ivpcgm0", []);
  CSS.make("css-ivpc0jl", []);
  CSS.make("css-ivpcld4", []);
  CSS.make("css-ivpcwd4", []);
  CSS.make("css-ivpcvie", []);
  CSS.make("css-ivpc6b5", []);
  CSS.make("css-ivpcjer", []);
  CSS.make("css-ivpcmcc", []);
  CSS.make("css-ivpc6mq", []);
  CSS.make("css-ivpcm5p", []);
  CSS.make("css-ivpcsyp", []);
  CSS.make("css-ivpcow4", []);
  CSS.make("css-ivpc1d3", []);
  CSS.make("css-ivpcqom", []);
  CSS.make("css-ivpcgd2", []);
  CSS.make("css-ivpc3v1", []);
  CSS.make("css-ivpcpln", []);
  CSS.make("css-ivpcye9", []);
  CSS.make("css-ivpclav", []);
  CSS.make("css-ivpchex", []);
  
  CSS.make("css-ivpcqeq", []);
  CSS.make("css-ivpcg2l", []);
  CSS.make("css-ivpcbgy", []);
  CSS.make("css-ivpce9k", []);
  CSS.make("css-ivpce9k", []);
  
  CSS.make("css-ivpcxr0", []);
  CSS.make("css-ivpcsi6", []);
  CSS.make("css-ivpcgw8", []);
  CSS.make("css-ivpcn9k", []);
  CSS.make("css-ivpc3xg", []);
  CSS.make("css-ivpc51r", []);
  CSS.make("css-ivpc662", []);
  CSS.make("css-ivpc8t0", []);
  CSS.make("css-ivpc9t0", []);
  CSS.make("css-ivpcfcc", []);
  CSS.make("css-ivpcjdg", []);
  CSS.make("css-ivpcr47", []);
  CSS.make("css-ivpcnkz", []);
  CSS.make("css-ivpct7m", []);
  CSS.make("css-ivpc4b0", []);
