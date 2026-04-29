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
  [@css ".css-1av7qfq{list-style-type:disclosure-closed;}"];
  [@css ".css-1tva7xp{list-style-type:disclosure-open;}"];
  [@css ".css-fu29pt{list-style-type:hebrew;}"];
  [@css ".css-ytgvd0{list-style-type:cjk-decimal;}"];
  [@css ".css-19lcgrv{list-style-type:cjk-ideographic;}"];
  [@css ".css-8v1x6a{list-style-type:hiragana;}"];
  [@css ".css-2wg83j{list-style-type:katakana;}"];
  [@css ".css-71cvle{list-style-type:hiragana-iroha;}"];
  [@css ".css-nex9p6{list-style-type:katakana-iroha;}"];
  [@css ".css-750nt8{list-style-type:japanese-informal;}"];
  [@css ".css-en1qzs{list-style-type:japanese-formal;}"];
  [@css ".css-1b3x3n{list-style-type:korean-hangul-formal;}"];
  [@css ".css-1dhci9d{list-style-type:korean-hanja-informal;}"];
  [@css ".css-1ysrmxn{list-style-type:korean-hanja-formal;}"];
  [@css ".css-rgepun{list-style-type:simp-chinese-informal;}"];
  [@css ".css-nqrzxz{list-style-type:simp-chinese-formal;}"];
  [@css ".css-bqx53p{list-style-type:trad-chinese-informal;}"];
  [@css ".css-rg7nk5{list-style-type:trad-chinese-formal;}"];
  [@css ".css-xhah5j{list-style-type:cjk-heavenly-stem;}"];
  [@css ".css-1wlk2eu{list-style-type:cjk-earthly-branch;}"];
  [@css ".css-f6g87t{list-style-type:arabic-indic;}"];
  [@css ".css-16oq4ct{list-style-type:persian;}"];
  [@css ".css-1jrwplg{list-style-type:urdu;}"];
  [@css ".css-1pyt1xg{list-style-type:devanagari;}"];
  [@css ".css-1r92uqw{list-style-type:gurmukhi;}"];
  [@css ".css-1j8sykj{list-style-type:gujarati;}"];
  [@css ".css-1d6xd5p{list-style-type:oriya;}"];
  [@css ".css-1vp0osi{list-style-type:kannada;}"];
  [@css ".css-z17eay{list-style-type:malayalam;}"];
  [@css ".css-vv1vws{list-style-type:bengali;}"];
  [@css ".css-atniwu{list-style-type:tamil;}"];
  [@css ".css-8ae5tz{list-style-type:telugu;}"];
  [@css ".css-n66xg{list-style-type:thai;}"];
  [@css ".css-ocd88w{list-style-type:lao;}"];
  [@css ".css-1wztt7z{list-style-type:myanmar;}"];
  [@css ".css-pda9oz{list-style-type:khmer;}"];
  [@css ".css-1w04hjf{list-style-type:hangul;}"];
  [@css ".css-wbwmg{list-style-type:hangul-consonant;}"];
  [@css ".css-173vi2g{list-style-type:ethiopic-halehame;}"];
  [@css ".css-qgbwzk{list-style-type:ethiopic-numeric;}"];
  [@css ".css-1s1y86w{list-style-type:ethiopic-halehame-am;}"];
  [@css ".css-l4b4u0{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css ".css-11dek1d{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css ".css-1vskulm{list-style-type:other-style;}"];
  [@css ".css-fh7fla{list-style-type:inside;}"];
  [@css ".css-1p3zn63{list-style-type:outside;}"];
  [@css ".css-usotag{list-style-type:2style;}"];
  [@css ".css-uhwudt{list-style-type:custom-counter-style;}"];
  [@css ".css-1e8mnj4{list-style-type:\"👍\";}"];
  [@css ".css-1f501lu{list-style-type:\"-\";}"];
  [@css ".css-ewca5o{counter-reset:foo;}"];
  [@css ".css-14fbp66{counter-reset:foo 1;}"];
  [@css ".css-my9y6l{counter-reset:foo 1 bar;}"];
  [@css ".css-hu56lo{counter-reset:foo 1 bar 2;}"];
  [@css ".css-113r1od{counter-reset:none;}"];
  [@css ".css-1n5uxrl{counter-set:foo;}"];
  [@css ".css-lxmudj{counter-set:foo 1;}"];
  [@css ".css-1yt4fvg{counter-set:foo 1 bar;}"];
  [@css ".css-jrq2fl{counter-set:foo 1 bar 2;}"];
  [@css ".css-rnk1na{counter-set:none;}"];
  [@css ".css-rt213t{counter-increment:foo;}"];
  [@css ".css-y82oh{counter-increment:foo 1;}"];
  [@css ".css-11ixkjf{counter-increment:foo 1 bar;}"];
  [@css ".css-17luicq{counter-increment:foo 1 bar 2;}"];
  [@css ".css-b65tkf{counter-increment:none;}"];
  
  CSS.make("css-1av7qfq", []);
  CSS.make("css-1tva7xp", []);
  CSS.make("css-fu29pt", []);
  CSS.make("css-ytgvd0", []);
  CSS.make("css-19lcgrv", []);
  CSS.make("css-8v1x6a", []);
  CSS.make("css-2wg83j", []);
  CSS.make("css-71cvle", []);
  CSS.make("css-nex9p6", []);
  CSS.make("css-750nt8", []);
  CSS.make("css-en1qzs", []);
  CSS.make("css-1b3x3n", []);
  CSS.make("css-1dhci9d", []);
  CSS.make("css-1ysrmxn", []);
  CSS.make("css-rgepun", []);
  CSS.make("css-nqrzxz", []);
  CSS.make("css-bqx53p", []);
  CSS.make("css-rg7nk5", []);
  CSS.make("css-xhah5j", []);
  CSS.make("css-1wlk2eu", []);
  CSS.make("css-bqx53p", []);
  CSS.make("css-rg7nk5", []);
  CSS.make("css-rgepun", []);
  CSS.make("css-nqrzxz", []);
  CSS.make("css-750nt8", []);
  CSS.make("css-en1qzs", []);
  CSS.make("css-f6g87t", []);
  CSS.make("css-16oq4ct", []);
  CSS.make("css-1jrwplg", []);
  CSS.make("css-1pyt1xg", []);
  CSS.make("css-1r92uqw", []);
  CSS.make("css-1j8sykj", []);
  CSS.make("css-1d6xd5p", []);
  CSS.make("css-1vp0osi", []);
  CSS.make("css-z17eay", []);
  CSS.make("css-vv1vws", []);
  CSS.make("css-atniwu", []);
  CSS.make("css-8ae5tz", []);
  CSS.make("css-n66xg", []);
  CSS.make("css-ocd88w", []);
  CSS.make("css-1wztt7z", []);
  CSS.make("css-pda9oz", []);
  CSS.make("css-1w04hjf", []);
  CSS.make("css-wbwmg", []);
  CSS.make("css-173vi2g", []);
  CSS.make("css-qgbwzk", []);
  CSS.make("css-1s1y86w", []);
  CSS.make("css-l4b4u0", []);
  CSS.make("css-11dek1d", []);
  CSS.make("css-1vskulm", []);
  CSS.make("css-fh7fla", []);
  CSS.make("css-1p3zn63", []);
  
  CSS.make("css-usotag", []);
  CSS.make("css-uhwudt", []);
  CSS.make("css-1e8mnj4", []);
  CSS.make("css-1f501lu", []);
  CSS.make("css-1f501lu", []);
  
  CSS.make("css-ewca5o", []);
  CSS.make("css-14fbp66", []);
  CSS.make("css-my9y6l", []);
  CSS.make("css-hu56lo", []);
  CSS.make("css-113r1od", []);
  CSS.make("css-1n5uxrl", []);
  CSS.make("css-lxmudj", []);
  CSS.make("css-1yt4fvg", []);
  CSS.make("css-jrq2fl", []);
  CSS.make("css-rnk1na", []);
  CSS.make("css-rt213t", []);
  CSS.make("css-y82oh", []);
  CSS.make("css-11ixkjf", []);
  CSS.make("css-17luicq", []);
  CSS.make("css-b65tkf", []);
