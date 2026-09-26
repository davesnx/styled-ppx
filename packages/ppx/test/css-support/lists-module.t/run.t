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
  [@css "._a_7o0047qfq{list-style-type:disclosure-closed;}"];
  [@css "._a_7o004a7xp{list-style-type:disclosure-open;}"];
  [@css "._a_7o00429pt{list-style-type:hebrew;}"];
  [@css "._a_7o004gvd0{list-style-type:cjk-decimal;}"];
  [@css "._a_7o004cgrv{list-style-type:cjk-ideographic;}"];
  [@css "._a_7o0041x6a{list-style-type:hiragana;}"];
  [@css "._a_7o004g83j{list-style-type:katakana;}"];
  [@css "._a_7o004cvle{list-style-type:hiragana-iroha;}"];
  [@css "._a_7o004x9p6{list-style-type:katakana-iroha;}"];
  [@css "._a_7o0040nt8{list-style-type:japanese-informal;}"];
  [@css "._a_7o0041qzs{list-style-type:japanese-formal;}"];
  [@css "._a_7o0043x3n{list-style-type:korean-hangul-formal;}"];
  [@css "._a_7o004ci9d{list-style-type:korean-hanja-informal;}"];
  [@css "._a_7o004rmxn{list-style-type:korean-hanja-formal;}"];
  [@css "._a_7o004epun{list-style-type:simp-chinese-informal;}"];
  [@css "._a_7o004rzxz{list-style-type:simp-chinese-formal;}"];
  [@css "._a_7o004x53p{list-style-type:trad-chinese-informal;}"];
  [@css "._a_7o0047nk5{list-style-type:trad-chinese-formal;}"];
  [@css "._a_7o004ah5j{list-style-type:cjk-heavenly-stem;}"];
  [@css "._a_7o004k2eu{list-style-type:cjk-earthly-branch;}"];
  [@css "._a_7o004g87t{list-style-type:arabic-indic;}"];
  [@css "._a_7o004q4ct{list-style-type:persian;}"];
  [@css "._a_7o004wplg{list-style-type:urdu;}"];
  [@css "._a_7o004t1xg{list-style-type:devanagari;}"];
  [@css "._a_7o0042uqw{list-style-type:gurmukhi;}"];
  [@css "._a_7o004sykj{list-style-type:gujarati;}"];
  [@css "._a_7o004xd5p{list-style-type:oriya;}"];
  [@css "._a_7o0040osi{list-style-type:kannada;}"];
  [@css "._a_7o0047eay{list-style-type:malayalam;}"];
  [@css "._a_7o0041vws{list-style-type:bengali;}"];
  [@css "._a_7o004niwu{list-style-type:tamil;}"];
  [@css "._a_7o004e5tz{list-style-type:telugu;}"];
  [@css "._a_7o00466xg{list-style-type:thai;}"];
  [@css "._a_7o004d88w{list-style-type:lao;}"];
  [@css "._a_7o004tt7z{list-style-type:myanmar;}"];
  [@css "._a_7o004a9oz{list-style-type:khmer;}"];
  [@css "._a_7o0044hjf{list-style-type:hangul;}"];
  [@css "._a_7o004bwmg{list-style-type:hangul-consonant;}"];
  [@css "._a_7o004vi2g{list-style-type:ethiopic-halehame;}"];
  [@css "._a_7o004bwzk{list-style-type:ethiopic-numeric;}"];
  [@css "._a_7o004y86w{list-style-type:ethiopic-halehame-am;}"];
  [@css "._a_7o004b4u0{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css "._a_7o004ek1d{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css "._a_7o004kulm{list-style-type:other-style;}"];
  [@css "._a_7o0047fla{list-style-type:inside;}"];
  [@css "._a_7o004zn63{list-style-type:outside;}"];
  [@css "._a_7o004pnng{list-style-type:\\32 style;}"];
  [@css "._a_7o004wudt{list-style-type:custom-counter-style;}"];
  [@css "._a_7o004mnj4{list-style-type:\"👍\";}"];
  [@css "._a_7o00401lu{list-style-type:\"-\";}"];
  [@css "._a_5gca5o{counter-reset:foo;}"];
  [@css "._a_5gbp66{counter-reset:foo 1;}"];
  [@css "._a_5g9y6l{counter-reset:foo 1 bar;}"];
  [@css "._a_5g56lo{counter-reset:foo 1 bar 2;}"];
  [@css "._a_5gr1od{counter-reset:none;}"];
  [@css "._a_5huxrl{counter-set:foo;}"];
  [@css "._a_5hmudj{counter-set:foo 1;}"];
  [@css "._a_5h4fvg{counter-set:foo 1 bar;}"];
  [@css "._a_5hq2fl{counter-set:foo 1 bar 2;}"];
  [@css "._a_5hk1na{counter-set:none;}"];
  [@css "._a_5f213t{counter-increment:foo;}"];
  [@css "._a_5f82oh{counter-increment:foo 1;}"];
  [@css "._a_5fxkjf{counter-increment:foo 1 bar;}"];
  [@css "._a_5fuicq{counter-increment:foo 1 bar 2;}"];
  [@css "._a_5f5tkf{counter-increment:none;}"];
  
  CSS.make("_a_7o0047qfq", []);
  CSS.make("_a_7o004a7xp", []);
  CSS.make("_a_7o00429pt", []);
  CSS.make("_a_7o004gvd0", []);
  CSS.make("_a_7o004cgrv", []);
  CSS.make("_a_7o0041x6a", []);
  CSS.make("_a_7o004g83j", []);
  CSS.make("_a_7o004cvle", []);
  CSS.make("_a_7o004x9p6", []);
  CSS.make("_a_7o0040nt8", []);
  CSS.make("_a_7o0041qzs", []);
  CSS.make("_a_7o0043x3n", []);
  CSS.make("_a_7o004ci9d", []);
  CSS.make("_a_7o004rmxn", []);
  CSS.make("_a_7o004epun", []);
  CSS.make("_a_7o004rzxz", []);
  CSS.make("_a_7o004x53p", []);
  CSS.make("_a_7o0047nk5", []);
  CSS.make("_a_7o004ah5j", []);
  CSS.make("_a_7o004k2eu", []);
  CSS.make("_a_7o004x53p", []);
  CSS.make("_a_7o0047nk5", []);
  CSS.make("_a_7o004epun", []);
  CSS.make("_a_7o004rzxz", []);
  CSS.make("_a_7o0040nt8", []);
  CSS.make("_a_7o0041qzs", []);
  CSS.make("_a_7o004g87t", []);
  CSS.make("_a_7o004q4ct", []);
  CSS.make("_a_7o004wplg", []);
  CSS.make("_a_7o004t1xg", []);
  CSS.make("_a_7o0042uqw", []);
  CSS.make("_a_7o004sykj", []);
  CSS.make("_a_7o004xd5p", []);
  CSS.make("_a_7o0040osi", []);
  CSS.make("_a_7o0047eay", []);
  CSS.make("_a_7o0041vws", []);
  CSS.make("_a_7o004niwu", []);
  CSS.make("_a_7o004e5tz", []);
  CSS.make("_a_7o00466xg", []);
  CSS.make("_a_7o004d88w", []);
  CSS.make("_a_7o004tt7z", []);
  CSS.make("_a_7o004a9oz", []);
  CSS.make("_a_7o0044hjf", []);
  CSS.make("_a_7o004bwmg", []);
  CSS.make("_a_7o004vi2g", []);
  CSS.make("_a_7o004bwzk", []);
  CSS.make("_a_7o004y86w", []);
  CSS.make("_a_7o004b4u0", []);
  CSS.make("_a_7o004ek1d", []);
  CSS.make("_a_7o004kulm", []);
  CSS.make("_a_7o0047fla", []);
  CSS.make("_a_7o004zn63", []);
  
  CSS.make("_a_7o004pnng", []);
  CSS.make("_a_7o004wudt", []);
  CSS.make("_a_7o004mnj4", []);
  CSS.make("_a_7o00401lu", []);
  CSS.make("_a_7o00401lu", []);
  
  CSS.make("_a_5gca5o", []);
  CSS.make("_a_5gbp66", []);
  CSS.make("_a_5g9y6l", []);
  CSS.make("_a_5g56lo", []);
  CSS.make("_a_5gr1od", []);
  CSS.make("_a_5huxrl", []);
  CSS.make("_a_5hmudj", []);
  CSS.make("_a_5h4fvg", []);
  CSS.make("_a_5hq2fl", []);
  CSS.make("_a_5hk1na", []);
  CSS.make("_a_5f213t", []);
  CSS.make("_a_5f82oh", []);
  CSS.make("_a_5fxkjf", []);
  CSS.make("_a_5fuicq", []);
  CSS.make("_a_5f5tkf", []);
