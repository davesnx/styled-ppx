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
  [@css ".a-iscixw{line-clamp:none;}"];
  [@css ".a-10whhy3{line-clamp:1;}"];
  [@css ".a-f8eyiu{max-lines:none;}"];
  [@css ".a-1tdkhmq{max-lines:1;}"];
  [@css ".a-16qbhz6{overflow-x:visible;}"];
  [@css ".a-1kzo3b9{overflow-x:hidden;}"];
  [@css ".a-1th3fel{overflow-x:clip;}"];
  [@css ".a-13ad1he{overflow-x:scroll;}"];
  [@css ".a-ayshjd{overflow-x:auto;}"];
  [@css ".a-ifv34m{overflow-y:visible;}"];
  [@css ".a-144vlu9{overflow-y:hidden;}"];
  [@css ".a-w43dqe{overflow-y:clip;}"];
  [@css ".a-15bvnbz{overflow-y:scroll;}"];
  [@css ".a-13v3rg8{overflow-y:auto;}"];
  [@css ".a-1rb7o30{overflow-inline:visible;}"];
  [@css ".a-7yocar{overflow-inline:hidden;}"];
  [@css ".a-fumbnd{overflow-inline:clip;}"];
  [@css ".a-1n7vnt4{overflow-inline:scroll;}"];
  [@css ".a-1ukl3d7{overflow-inline:auto;}"];
  [@css ".a-9e376w{overflow-block:visible;}"];
  [@css ".a-l7i9nl{overflow-block:hidden;}"];
  [@css ".a-174mqtl{overflow-block:clip;}"];
  [@css ".a-1l7b3k{overflow-block:scroll;}"];
  [@css ".a-gge70x{overflow-block:auto;}"];
  [@css ".a-1piyyg0{scrollbar-gutter:auto;}"];
  [@css ".a-1x6kn4i{scrollbar-gutter:stable;}"];
  [@css ".a-1600g5d{scrollbar-gutter:both-edges stable;}"];
  [@css ".a-btacsl{scrollbar-gutter:stable both-edges;}"];
  [@css ".a-g8w8p9{overflow-clip-margin:content-box;}"];
  [@css ".a-gpc69b{overflow-clip-margin:padding-box;}"];
  [@css ".a-16k4htk{overflow-clip-margin:border-box;}"];
  [@css ".a-olg26a{overflow-clip-margin:20px;}"];
  [@css ".a-1kiluqi{overflow-clip-margin:1em;}"];
  [@css ".a-15fxgse{overflow-clip-margin:content-box 5px;}"];
  [@css ".a-1gl8vwx{overflow-clip-margin:5px content-box;}"];
  
  CSS.make("a-iscixw", []);
  CSS.make("a-10whhy3", []);
  
  CSS.make("a-f8eyiu", []);
  CSS.make("a-1tdkhmq", []);
  CSS.make("a-16qbhz6", []);
  CSS.make("a-1kzo3b9", []);
  CSS.make("a-1th3fel", []);
  CSS.make("a-13ad1he", []);
  CSS.make("a-ayshjd", []);
  CSS.make("a-ifv34m", []);
  CSS.make("a-144vlu9", []);
  CSS.make("a-w43dqe", []);
  CSS.make("a-15bvnbz", []);
  CSS.make("a-13v3rg8", []);
  CSS.make("a-1rb7o30", []);
  CSS.make("a-7yocar", []);
  CSS.make("a-fumbnd", []);
  CSS.make("a-1n7vnt4", []);
  CSS.make("a-1ukl3d7", []);
  CSS.make("a-9e376w", []);
  CSS.make("a-l7i9nl", []);
  CSS.make("a-174mqtl", []);
  CSS.make("a-1l7b3k", []);
  CSS.make("a-gge70x", []);
  CSS.make("a-1piyyg0", []);
  CSS.make("a-1x6kn4i", []);
  CSS.make("a-1600g5d", []);
  CSS.make("a-btacsl", []);
  CSS.make("a-g8w8p9", []);
  CSS.make("a-gpc69b", []);
  CSS.make("a-16k4htk", []);
  CSS.make("a-olg26a", []);
  CSS.make("a-1kiluqi", []);
  CSS.make("a-15fxgse", []);
  CSS.make("a-1gl8vwx", []);
