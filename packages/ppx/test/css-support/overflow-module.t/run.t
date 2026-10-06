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
  [@css "._a_7lcixw{line-clamp:none;}"];
  [@css "._a_7lhhy3{line-clamp:1;}"];
  [@css "._a_87eyiu{max-lines:none;}"];
  [@css "._a_87khmq{max-lines:1;}"];
  [@css "._a_8r001bhz6{overflow-x:visible;}"];
  [@css "._a_8r001o3b9{overflow-x:hidden;}"];
  [@css "._a_8r0013fel{overflow-x:clip;}"];
  [@css "._a_8r001d1he{overflow-x:scroll;}"];
  [@css "._a_8r001shjd{overflow-x:auto;}"];
  [@css "._a_8r002v34m{overflow-y:visible;}"];
  [@css "._a_8r002vlu9{overflow-y:hidden;}"];
  [@css "._a_8r0023dqe{overflow-y:clip;}"];
  [@css "._a_8r002vnbz{overflow-y:scroll;}"];
  [@css "._a_8r0023rg8{overflow-y:auto;}"];
  [@css "._a_8w7o30{overflow-inline:visible;}"];
  [@css "._a_8wocar{overflow-inline:hidden;}"];
  [@css "._a_8wmbnd{overflow-inline:clip;}"];
  [@css "._a_8wvnt4{overflow-inline:scroll;}"];
  [@css "._a_8wl3d7{overflow-inline:auto;}"];
  [@css "._a_8t376w{overflow-block:visible;}"];
  [@css "._a_8ti9nl{overflow-block:hidden;}"];
  [@css "._a_8tmqtl{overflow-block:clip;}"];
  [@css "._a_8t7b3k{overflow-block:scroll;}"];
  [@css "._a_8te70x{overflow-block:auto;}"];
  [@css "._a_bdyyg0{scrollbar-gutter:auto;}"];
  [@css "._a_bdkn4i{scrollbar-gutter:stable;}"];
  [@css "._a_bd0g5d{scrollbar-gutter:both-edges stable;}"];
  [@css "._a_bdacsl{scrollbar-gutter:stable both-edges;}"];
  [@css "._a_8vw8p9{overflow-clip-margin:content-box;}"];
  [@css "._a_8vc69b{overflow-clip-margin:padding-box;}"];
  [@css "._a_8v4htk{overflow-clip-margin:border-box;}"];
  [@css "._a_8vg26a{overflow-clip-margin:20px;}"];
  [@css "._a_8vluqi{overflow-clip-margin:1em;}"];
  [@css "._a_8vxgse{overflow-clip-margin:content-box 5px;}"];
  [@css "._a_8v8vwx{overflow-clip-margin:5px content-box;}"];
  
  CSS.make("_a_7lcixw", []);
  CSS.make("_a_7lhhy3", []);
  
  CSS.make("_a_87eyiu", []);
  CSS.make("_a_87khmq", []);
  CSS.make("_a_8r001bhz6", []);
  CSS.make("_a_8r001o3b9", []);
  CSS.make("_a_8r0013fel", []);
  CSS.make("_a_8r001d1he", []);
  CSS.make("_a_8r001shjd", []);
  CSS.make("_a_8r002v34m", []);
  CSS.make("_a_8r002vlu9", []);
  CSS.make("_a_8r0023dqe", []);
  CSS.make("_a_8r002vnbz", []);
  CSS.make("_a_8r0023rg8", []);
  CSS.make("_a_8w7o30", []);
  CSS.make("_a_8wocar", []);
  CSS.make("_a_8wmbnd", []);
  CSS.make("_a_8wvnt4", []);
  CSS.make("_a_8wl3d7", []);
  CSS.make("_a_8t376w", []);
  CSS.make("_a_8ti9nl", []);
  CSS.make("_a_8tmqtl", []);
  CSS.make("_a_8t7b3k", []);
  CSS.make("_a_8te70x", []);
  CSS.make("_a_bdyyg0", []);
  CSS.make("_a_bdkn4i", []);
  CSS.make("_a_bd0g5d", []);
  CSS.make("_a_bdacsl", []);
  CSS.make("_a_8vw8p9", []);
  CSS.make("_a_8vc69b", []);
  CSS.make("_a_8v4htk", []);
  CSS.make("_a_8vg26a", []);
  CSS.make("_a_8vluqi", []);
  CSS.make("_a_8vxgse", []);
  CSS.make("_a_8v8vwx", []);
