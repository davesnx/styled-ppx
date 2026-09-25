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
  [@css ".a-7lcixw{line-clamp:none;}"];
  [@css ".a-7lhhy3{line-clamp:1;}"];
  [@css ".a-87eyiu{max-lines:none;}"];
  [@css ".a-87khmq{max-lines:1;}"];
  [@css ".a-8r001bhz6{overflow-x:visible;}"];
  [@css ".a-8r001o3b9{overflow-x:hidden;}"];
  [@css ".a-8r0013fel{overflow-x:clip;}"];
  [@css ".a-8r001d1he{overflow-x:scroll;}"];
  [@css ".a-8r001shjd{overflow-x:auto;}"];
  [@css ".a-8r002v34m{overflow-y:visible;}"];
  [@css ".a-8r002vlu9{overflow-y:hidden;}"];
  [@css ".a-8r0023dqe{overflow-y:clip;}"];
  [@css ".a-8r002vnbz{overflow-y:scroll;}"];
  [@css ".a-8r0023rg8{overflow-y:auto;}"];
  [@css ".a-8w7o30{overflow-inline:visible;}"];
  [@css ".a-8wocar{overflow-inline:hidden;}"];
  [@css ".a-8wmbnd{overflow-inline:clip;}"];
  [@css ".a-8wvnt4{overflow-inline:scroll;}"];
  [@css ".a-8wl3d7{overflow-inline:auto;}"];
  [@css ".a-8t376w{overflow-block:visible;}"];
  [@css ".a-8ti9nl{overflow-block:hidden;}"];
  [@css ".a-8tmqtl{overflow-block:clip;}"];
  [@css ".a-8t7b3k{overflow-block:scroll;}"];
  [@css ".a-8te70x{overflow-block:auto;}"];
  [@css ".a-bdyyg0{scrollbar-gutter:auto;}"];
  [@css ".a-bdkn4i{scrollbar-gutter:stable;}"];
  [@css ".a-bd0g5d{scrollbar-gutter:both-edges stable;}"];
  [@css ".a-bdacsl{scrollbar-gutter:stable both-edges;}"];
  [@css ".a-8vw8p9{overflow-clip-margin:content-box;}"];
  [@css ".a-8vc69b{overflow-clip-margin:padding-box;}"];
  [@css ".a-8v4htk{overflow-clip-margin:border-box;}"];
  [@css ".a-8vg26a{overflow-clip-margin:20px;}"];
  [@css ".a-8vluqi{overflow-clip-margin:1em;}"];
  [@css ".a-8vxgse{overflow-clip-margin:content-box 5px;}"];
  [@css ".a-8v8vwx{overflow-clip-margin:5px content-box;}"];
  
  CSS.make("a-7lcixw", []);
  CSS.make("a-7lhhy3", []);
  
  CSS.make("a-87eyiu", []);
  CSS.make("a-87khmq", []);
  CSS.make("a-8r001bhz6", []);
  CSS.make("a-8r001o3b9", []);
  CSS.make("a-8r0013fel", []);
  CSS.make("a-8r001d1he", []);
  CSS.make("a-8r001shjd", []);
  CSS.make("a-8r002v34m", []);
  CSS.make("a-8r002vlu9", []);
  CSS.make("a-8r0023dqe", []);
  CSS.make("a-8r002vnbz", []);
  CSS.make("a-8r0023rg8", []);
  CSS.make("a-8w7o30", []);
  CSS.make("a-8wocar", []);
  CSS.make("a-8wmbnd", []);
  CSS.make("a-8wvnt4", []);
  CSS.make("a-8wl3d7", []);
  CSS.make("a-8t376w", []);
  CSS.make("a-8ti9nl", []);
  CSS.make("a-8tmqtl", []);
  CSS.make("a-8t7b3k", []);
  CSS.make("a-8te70x", []);
  CSS.make("a-bdyyg0", []);
  CSS.make("a-bdkn4i", []);
  CSS.make("a-bd0g5d", []);
  CSS.make("a-bdacsl", []);
  CSS.make("a-8vw8p9", []);
  CSS.make("a-8vc69b", []);
  CSS.make("a-8v4htk", []);
  CSS.make("a-8vg26a", []);
  CSS.make("a-8vluqi", []);
  CSS.make("a-8vxgse", []);
  CSS.make("a-8v8vwx", []);
