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
  [@css
    ".css-iscixw{line-clamp:none;}\n.css-10whhy3{line-clamp:1;}\n.css-f8eyiu{max-lines:none;}\n.css-1tdkhmq{max-lines:1;}\n.css-16qbhz6{overflow-x:visible;}\n.css-1kzo3b9{overflow-x:hidden;}\n.css-1th3fel{overflow-x:clip;}\n.css-13ad1he{overflow-x:scroll;}\n.css-ayshjd{overflow-x:auto;}\n.css-ifv34m{overflow-y:visible;}\n.css-144vlu9{overflow-y:hidden;}\n.css-w43dqe{overflow-y:clip;}\n.css-15bvnbz{overflow-y:scroll;}\n.css-13v3rg8{overflow-y:auto;}\n.css-1rb7o30{overflow-inline:visible;}\n.css-7yocar{overflow-inline:hidden;}\n.css-fumbnd{overflow-inline:clip;}\n.css-1n7vnt4{overflow-inline:scroll;}\n.css-1ukl3d7{overflow-inline:auto;}\n.css-9e376w{overflow-block:visible;}\n.css-l7i9nl{overflow-block:hidden;}\n.css-174mqtl{overflow-block:clip;}\n.css-1l7b3k{overflow-block:scroll;}\n.css-gge70x{overflow-block:auto;}\n.css-1piyyg0{scrollbar-gutter:auto;}\n.css-1x6kn4i{scrollbar-gutter:stable;}\n.css-1600g5d{scrollbar-gutter:both-edges stable;}\n.css-btacsl{scrollbar-gutter:stable both-edges;}\n.css-g8w8p9{overflow-clip-margin:content-box;}\n.css-gpc69b{overflow-clip-margin:padding-box;}\n.css-16k4htk{overflow-clip-margin:border-box;}\n.css-olg26a{overflow-clip-margin:20px;}\n.css-1kiluqi{overflow-clip-margin:1em;}\n.css-15fxgse{overflow-clip-margin:content-box 5px;}\n.css-1gl8vwx{overflow-clip-margin:5px content-box;}\n"
  ];
  
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
