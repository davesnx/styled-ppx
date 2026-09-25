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
  [@css ".a-7o0047qfq{list-style-type:disclosure-closed;}"];
  [@css ".a-7o004a7xp{list-style-type:disclosure-open;}"];
  [@css ".a-7o00429pt{list-style-type:hebrew;}"];
  [@css ".a-7o004gvd0{list-style-type:cjk-decimal;}"];
  [@css ".a-7o004cgrv{list-style-type:cjk-ideographic;}"];
  [@css ".a-7o0041x6a{list-style-type:hiragana;}"];
  [@css ".a-7o004g83j{list-style-type:katakana;}"];
  [@css ".a-7o004cvle{list-style-type:hiragana-iroha;}"];
  [@css ".a-7o004x9p6{list-style-type:katakana-iroha;}"];
  [@css ".a-7o0040nt8{list-style-type:japanese-informal;}"];
  [@css ".a-7o0041qzs{list-style-type:japanese-formal;}"];
  [@css ".a-7o0043x3n{list-style-type:korean-hangul-formal;}"];
  [@css ".a-7o004ci9d{list-style-type:korean-hanja-informal;}"];
  [@css ".a-7o004rmxn{list-style-type:korean-hanja-formal;}"];
  [@css ".a-7o004epun{list-style-type:simp-chinese-informal;}"];
  [@css ".a-7o004rzxz{list-style-type:simp-chinese-formal;}"];
  [@css ".a-7o004x53p{list-style-type:trad-chinese-informal;}"];
  [@css ".a-7o0047nk5{list-style-type:trad-chinese-formal;}"];
  [@css ".a-7o004ah5j{list-style-type:cjk-heavenly-stem;}"];
  [@css ".a-7o004k2eu{list-style-type:cjk-earthly-branch;}"];
  [@css ".a-7o004g87t{list-style-type:arabic-indic;}"];
  [@css ".a-7o004q4ct{list-style-type:persian;}"];
  [@css ".a-7o004wplg{list-style-type:urdu;}"];
  [@css ".a-7o004t1xg{list-style-type:devanagari;}"];
  [@css ".a-7o0042uqw{list-style-type:gurmukhi;}"];
  [@css ".a-7o004sykj{list-style-type:gujarati;}"];
  [@css ".a-7o004xd5p{list-style-type:oriya;}"];
  [@css ".a-7o0040osi{list-style-type:kannada;}"];
  [@css ".a-7o0047eay{list-style-type:malayalam;}"];
  [@css ".a-7o0041vws{list-style-type:bengali;}"];
  [@css ".a-7o004niwu{list-style-type:tamil;}"];
  [@css ".a-7o004e5tz{list-style-type:telugu;}"];
  [@css ".a-7o00466xg{list-style-type:thai;}"];
  [@css ".a-7o004d88w{list-style-type:lao;}"];
  [@css ".a-7o004tt7z{list-style-type:myanmar;}"];
  [@css ".a-7o004a9oz{list-style-type:khmer;}"];
  [@css ".a-7o0044hjf{list-style-type:hangul;}"];
  [@css ".a-7o004bwmg{list-style-type:hangul-consonant;}"];
  [@css ".a-7o004vi2g{list-style-type:ethiopic-halehame;}"];
  [@css ".a-7o004bwzk{list-style-type:ethiopic-numeric;}"];
  [@css ".a-7o004y86w{list-style-type:ethiopic-halehame-am;}"];
  [@css ".a-7o004b4u0{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css ".a-7o004ek1d{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css ".a-7o004kulm{list-style-type:other-style;}"];
  [@css ".a-7o0047fla{list-style-type:inside;}"];
  [@css ".a-7o004zn63{list-style-type:outside;}"];
  [@css ".a-7o004pnng{list-style-type:\\32 style;}"];
  [@css ".a-7o004wudt{list-style-type:custom-counter-style;}"];
  [@css ".a-7o004mnj4{list-style-type:\"👍\";}"];
  [@css ".a-7o00401lu{list-style-type:\"-\";}"];
  [@css ".a-5gca5o{counter-reset:foo;}"];
  [@css ".a-5gbp66{counter-reset:foo 1;}"];
  [@css ".a-5g9y6l{counter-reset:foo 1 bar;}"];
  [@css ".a-5g56lo{counter-reset:foo 1 bar 2;}"];
  [@css ".a-5gr1od{counter-reset:none;}"];
  [@css ".a-5huxrl{counter-set:foo;}"];
  [@css ".a-5hmudj{counter-set:foo 1;}"];
  [@css ".a-5h4fvg{counter-set:foo 1 bar;}"];
  [@css ".a-5hq2fl{counter-set:foo 1 bar 2;}"];
  [@css ".a-5hk1na{counter-set:none;}"];
  [@css ".a-5f213t{counter-increment:foo;}"];
  [@css ".a-5f82oh{counter-increment:foo 1;}"];
  [@css ".a-5fxkjf{counter-increment:foo 1 bar;}"];
  [@css ".a-5fuicq{counter-increment:foo 1 bar 2;}"];
  [@css ".a-5f5tkf{counter-increment:none;}"];
  
  CSS.make("a-7o0047qfq", []);
  CSS.make("a-7o004a7xp", []);
  CSS.make("a-7o00429pt", []);
  CSS.make("a-7o004gvd0", []);
  CSS.make("a-7o004cgrv", []);
  CSS.make("a-7o0041x6a", []);
  CSS.make("a-7o004g83j", []);
  CSS.make("a-7o004cvle", []);
  CSS.make("a-7o004x9p6", []);
  CSS.make("a-7o0040nt8", []);
  CSS.make("a-7o0041qzs", []);
  CSS.make("a-7o0043x3n", []);
  CSS.make("a-7o004ci9d", []);
  CSS.make("a-7o004rmxn", []);
  CSS.make("a-7o004epun", []);
  CSS.make("a-7o004rzxz", []);
  CSS.make("a-7o004x53p", []);
  CSS.make("a-7o0047nk5", []);
  CSS.make("a-7o004ah5j", []);
  CSS.make("a-7o004k2eu", []);
  CSS.make("a-7o004x53p", []);
  CSS.make("a-7o0047nk5", []);
  CSS.make("a-7o004epun", []);
  CSS.make("a-7o004rzxz", []);
  CSS.make("a-7o0040nt8", []);
  CSS.make("a-7o0041qzs", []);
  CSS.make("a-7o004g87t", []);
  CSS.make("a-7o004q4ct", []);
  CSS.make("a-7o004wplg", []);
  CSS.make("a-7o004t1xg", []);
  CSS.make("a-7o0042uqw", []);
  CSS.make("a-7o004sykj", []);
  CSS.make("a-7o004xd5p", []);
  CSS.make("a-7o0040osi", []);
  CSS.make("a-7o0047eay", []);
  CSS.make("a-7o0041vws", []);
  CSS.make("a-7o004niwu", []);
  CSS.make("a-7o004e5tz", []);
  CSS.make("a-7o00466xg", []);
  CSS.make("a-7o004d88w", []);
  CSS.make("a-7o004tt7z", []);
  CSS.make("a-7o004a9oz", []);
  CSS.make("a-7o0044hjf", []);
  CSS.make("a-7o004bwmg", []);
  CSS.make("a-7o004vi2g", []);
  CSS.make("a-7o004bwzk", []);
  CSS.make("a-7o004y86w", []);
  CSS.make("a-7o004b4u0", []);
  CSS.make("a-7o004ek1d", []);
  CSS.make("a-7o004kulm", []);
  CSS.make("a-7o0047fla", []);
  CSS.make("a-7o004zn63", []);
  
  CSS.make("a-7o004pnng", []);
  CSS.make("a-7o004wudt", []);
  CSS.make("a-7o004mnj4", []);
  CSS.make("a-7o00401lu", []);
  CSS.make("a-7o00401lu", []);
  
  CSS.make("a-5gca5o", []);
  CSS.make("a-5gbp66", []);
  CSS.make("a-5g9y6l", []);
  CSS.make("a-5g56lo", []);
  CSS.make("a-5gr1od", []);
  CSS.make("a-5huxrl", []);
  CSS.make("a-5hmudj", []);
  CSS.make("a-5h4fvg", []);
  CSS.make("a-5hq2fl", []);
  CSS.make("a-5hk1na", []);
  CSS.make("a-5f213t", []);
  CSS.make("a-5f82oh", []);
  CSS.make("a-5fxkjf", []);
  CSS.make("a-5fuicq", []);
  CSS.make("a-5f5tkf", []);
