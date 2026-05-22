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
  [@css ".css-iscixw{line-clamp:none;}"];
  [@css ".css-10whhy3{line-clamp:1;}"];
  [@css ".css-f8eyiu{max-lines:none;}"];
  [@css ".css-1tdkhmq{max-lines:1;}"];
  [@css ".css-16qbhz6{overflow-x:visible;}"];
  [@css ".css-1kzo3b9{overflow-x:hidden;}"];
  [@css ".css-1th3fel{overflow-x:clip;}"];
  [@css ".css-13ad1he{overflow-x:scroll;}"];
  [@css ".css-ayshjd{overflow-x:auto;}"];
  [@css ".css-ifv34m{overflow-y:visible;}"];
  [@css ".css-144vlu9{overflow-y:hidden;}"];
  [@css ".css-w43dqe{overflow-y:clip;}"];
  [@css ".css-15bvnbz{overflow-y:scroll;}"];
  [@css ".css-13v3rg8{overflow-y:auto;}"];
  [@css ".css-1rb7o30{overflow-inline:visible;}"];
  [@css ".css-7yocar{overflow-inline:hidden;}"];
  [@css ".css-fumbnd{overflow-inline:clip;}"];
  [@css ".css-1n7vnt4{overflow-inline:scroll;}"];
  [@css ".css-1ukl3d7{overflow-inline:auto;}"];
  [@css ".css-9e376w{overflow-block:visible;}"];
  [@css ".css-l7i9nl{overflow-block:hidden;}"];
  [@css ".css-174mqtl{overflow-block:clip;}"];
  [@css ".css-1l7b3k{overflow-block:scroll;}"];
  [@css ".css-gge70x{overflow-block:auto;}"];
  [@css ".css-1piyyg0{scrollbar-gutter:auto;}"];
  [@css ".css-1x6kn4i{scrollbar-gutter:stable;}"];
  [@css ".css-1600g5d{scrollbar-gutter:both-edges stable;}"];
  [@css ".css-btacsl{scrollbar-gutter:stable both-edges;}"];
  [@css ".css-g8w8p9{overflow-clip-margin:content-box;}"];
  [@css ".css-gpc69b{overflow-clip-margin:padding-box;}"];
  [@css ".css-16k4htk{overflow-clip-margin:border-box;}"];
  [@css ".css-olg26a{overflow-clip-margin:20px;}"];
  [@css ".css-1kiluqi{overflow-clip-margin:1em;}"];
  [@css ".css-15fxgse{overflow-clip-margin:content-box 5px;}"];
  [@css ".css-1gl8vwx{overflow-clip-margin:5px content-box;}"];
  
  CSS.make("css-iscixw", []);
  CSS.make("css-10whhy3", []);
  
  CSS.make("css-f8eyiu", []);
  CSS.make("css-1tdkhmq", []);
  CSS.make("css-16qbhz6", []);
  CSS.make("css-1kzo3b9", []);
  CSS.make("css-1th3fel", []);
  CSS.make("css-13ad1he", []);
  CSS.make("css-ayshjd", []);
  CSS.make("css-ifv34m", []);
  CSS.make("css-144vlu9", []);
  CSS.make("css-w43dqe", []);
  CSS.make("css-15bvnbz", []);
  CSS.make("css-13v3rg8", []);
  CSS.make("css-1rb7o30", []);
  CSS.make("css-7yocar", []);
  CSS.make("css-fumbnd", []);
  CSS.make("css-1n7vnt4", []);
  CSS.make("css-1ukl3d7", []);
  CSS.make("css-9e376w", []);
  CSS.make("css-l7i9nl", []);
  CSS.make("css-174mqtl", []);
  CSS.make("css-1l7b3k", []);
  CSS.make("css-gge70x", []);
  CSS.make("css-1piyyg0", []);
  CSS.make("css-1x6kn4i", []);
  CSS.make("css-1600g5d", []);
  CSS.make("css-btacsl", []);
  CSS.make("css-g8w8p9", []);
  CSS.make("css-gpc69b", []);
  CSS.make("css-16k4htk", []);
  CSS.make("css-olg26a", []);
  CSS.make("css-1kiluqi", []);
  CSS.make("css-15fxgse", []);
  CSS.make("css-1gl8vwx", []);
