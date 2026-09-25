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
  [@css ".a-1av7qfq{list-style-type:disclosure-closed;}"];
  [@css ".a-1tva7xp{list-style-type:disclosure-open;}"];
  [@css ".a-fu29pt{list-style-type:hebrew;}"];
  [@css ".a-ytgvd0{list-style-type:cjk-decimal;}"];
  [@css ".a-19lcgrv{list-style-type:cjk-ideographic;}"];
  [@css ".a-8v1x6a{list-style-type:hiragana;}"];
  [@css ".a-2wg83j{list-style-type:katakana;}"];
  [@css ".a-71cvle{list-style-type:hiragana-iroha;}"];
  [@css ".a-nex9p6{list-style-type:katakana-iroha;}"];
  [@css ".a-750nt8{list-style-type:japanese-informal;}"];
  [@css ".a-en1qzs{list-style-type:japanese-formal;}"];
  [@css ".a-1b3x3n{list-style-type:korean-hangul-formal;}"];
  [@css ".a-1dhci9d{list-style-type:korean-hanja-informal;}"];
  [@css ".a-1ysrmxn{list-style-type:korean-hanja-formal;}"];
  [@css ".a-rgepun{list-style-type:simp-chinese-informal;}"];
  [@css ".a-nqrzxz{list-style-type:simp-chinese-formal;}"];
  [@css ".a-bqx53p{list-style-type:trad-chinese-informal;}"];
  [@css ".a-rg7nk5{list-style-type:trad-chinese-formal;}"];
  [@css ".a-xhah5j{list-style-type:cjk-heavenly-stem;}"];
  [@css ".a-1wlk2eu{list-style-type:cjk-earthly-branch;}"];
  [@css ".a-f6g87t{list-style-type:arabic-indic;}"];
  [@css ".a-16oq4ct{list-style-type:persian;}"];
  [@css ".a-1jrwplg{list-style-type:urdu;}"];
  [@css ".a-1pyt1xg{list-style-type:devanagari;}"];
  [@css ".a-1r92uqw{list-style-type:gurmukhi;}"];
  [@css ".a-1j8sykj{list-style-type:gujarati;}"];
  [@css ".a-1d6xd5p{list-style-type:oriya;}"];
  [@css ".a-1vp0osi{list-style-type:kannada;}"];
  [@css ".a-z17eay{list-style-type:malayalam;}"];
  [@css ".a-vv1vws{list-style-type:bengali;}"];
  [@css ".a-atniwu{list-style-type:tamil;}"];
  [@css ".a-8ae5tz{list-style-type:telugu;}"];
  [@css ".a-n66xg{list-style-type:thai;}"];
  [@css ".a-ocd88w{list-style-type:lao;}"];
  [@css ".a-1wztt7z{list-style-type:myanmar;}"];
  [@css ".a-pda9oz{list-style-type:khmer;}"];
  [@css ".a-1w04hjf{list-style-type:hangul;}"];
  [@css ".a-wbwmg{list-style-type:hangul-consonant;}"];
  [@css ".a-173vi2g{list-style-type:ethiopic-halehame;}"];
  [@css ".a-qgbwzk{list-style-type:ethiopic-numeric;}"];
  [@css ".a-1s1y86w{list-style-type:ethiopic-halehame-am;}"];
  [@css ".a-l4b4u0{list-style-type:ethiopic-halehame-ti-er;}"];
  [@css ".a-11dek1d{list-style-type:ethiopic-halehame-ti-et;}"];
  [@css ".a-1vskulm{list-style-type:other-style;}"];
  [@css ".a-fh7fla{list-style-type:inside;}"];
  [@css ".a-1p3zn63{list-style-type:outside;}"];
  [@css ".a-18kpnng{list-style-type:\\32 style;}"];
  [@css ".a-uhwudt{list-style-type:custom-counter-style;}"];
  [@css ".a-1e8mnj4{list-style-type:\"👍\";}"];
  [@css ".a-1f501lu{list-style-type:\"-\";}"];
  [@css ".a-ewca5o{counter-reset:foo;}"];
  [@css ".a-14fbp66{counter-reset:foo 1;}"];
  [@css ".a-my9y6l{counter-reset:foo 1 bar;}"];
  [@css ".a-hu56lo{counter-reset:foo 1 bar 2;}"];
  [@css ".a-113r1od{counter-reset:none;}"];
  [@css ".a-1n5uxrl{counter-set:foo;}"];
  [@css ".a-lxmudj{counter-set:foo 1;}"];
  [@css ".a-1yt4fvg{counter-set:foo 1 bar;}"];
  [@css ".a-jrq2fl{counter-set:foo 1 bar 2;}"];
  [@css ".a-rnk1na{counter-set:none;}"];
  [@css ".a-rt213t{counter-increment:foo;}"];
  [@css ".a-y82oh{counter-increment:foo 1;}"];
  [@css ".a-11ixkjf{counter-increment:foo 1 bar;}"];
  [@css ".a-17luicq{counter-increment:foo 1 bar 2;}"];
  [@css ".a-b65tkf{counter-increment:none;}"];
  
  CSS.make("a-1av7qfq", []);
  CSS.make("a-1tva7xp", []);
  CSS.make("a-fu29pt", []);
  CSS.make("a-ytgvd0", []);
  CSS.make("a-19lcgrv", []);
  CSS.make("a-8v1x6a", []);
  CSS.make("a-2wg83j", []);
  CSS.make("a-71cvle", []);
  CSS.make("a-nex9p6", []);
  CSS.make("a-750nt8", []);
  CSS.make("a-en1qzs", []);
  CSS.make("a-1b3x3n", []);
  CSS.make("a-1dhci9d", []);
  CSS.make("a-1ysrmxn", []);
  CSS.make("a-rgepun", []);
  CSS.make("a-nqrzxz", []);
  CSS.make("a-bqx53p", []);
  CSS.make("a-rg7nk5", []);
  CSS.make("a-xhah5j", []);
  CSS.make("a-1wlk2eu", []);
  CSS.make("a-bqx53p", []);
  CSS.make("a-rg7nk5", []);
  CSS.make("a-rgepun", []);
  CSS.make("a-nqrzxz", []);
  CSS.make("a-750nt8", []);
  CSS.make("a-en1qzs", []);
  CSS.make("a-f6g87t", []);
  CSS.make("a-16oq4ct", []);
  CSS.make("a-1jrwplg", []);
  CSS.make("a-1pyt1xg", []);
  CSS.make("a-1r92uqw", []);
  CSS.make("a-1j8sykj", []);
  CSS.make("a-1d6xd5p", []);
  CSS.make("a-1vp0osi", []);
  CSS.make("a-z17eay", []);
  CSS.make("a-vv1vws", []);
  CSS.make("a-atniwu", []);
  CSS.make("a-8ae5tz", []);
  CSS.make("a-n66xg", []);
  CSS.make("a-ocd88w", []);
  CSS.make("a-1wztt7z", []);
  CSS.make("a-pda9oz", []);
  CSS.make("a-1w04hjf", []);
  CSS.make("a-wbwmg", []);
  CSS.make("a-173vi2g", []);
  CSS.make("a-qgbwzk", []);
  CSS.make("a-1s1y86w", []);
  CSS.make("a-l4b4u0", []);
  CSS.make("a-11dek1d", []);
  CSS.make("a-1vskulm", []);
  CSS.make("a-fh7fla", []);
  CSS.make("a-1p3zn63", []);
  
  CSS.make("a-18kpnng", []);
  CSS.make("a-uhwudt", []);
  CSS.make("a-1e8mnj4", []);
  CSS.make("a-1f501lu", []);
  CSS.make("a-1f501lu", []);
  
  CSS.make("a-ewca5o", []);
  CSS.make("a-14fbp66", []);
  CSS.make("a-my9y6l", []);
  CSS.make("a-hu56lo", []);
  CSS.make("a-113r1od", []);
  CSS.make("a-1n5uxrl", []);
  CSS.make("a-lxmudj", []);
  CSS.make("a-1yt4fvg", []);
  CSS.make("a-jrq2fl", []);
  CSS.make("a-rnk1na", []);
  CSS.make("a-rt213t", []);
  CSS.make("a-y82oh", []);
  CSS.make("a-11ixkjf", []);
  CSS.make("a-17luicq", []);
  CSS.make("a-b65tkf", []);
