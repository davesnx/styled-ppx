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
    ".css-cf3le8{width:max-content;}\n.css-17hckkm{width:min-content;}\n.css-muccy6{width:fit-content(10%);}\n.css-106ktvk{min-width:max-content;}\n.css-vlreoz{min-width:min-content;}\n.css-gikswh{min-width:fit-content(10%);}\n.css-13sc9a0{max-width:max-content;}\n.css-1jonlwm{max-width:min-content;}\n.css-gszzeg{max-width:fit-content(10%);}\n.css-14x27ji{height:max-content;}\n.css-uvzl7o{height:min-content;}\n.css-giv2pj{height:fit-content(10%);}\n.css-ezyx8i{min-height:max-content;}\n.css-14fp2tk{min-height:min-content;}\n.css-1iubza9{min-height:fit-content(10%);}\n.css-1smyxes{max-height:max-content;}\n.css-rl4hk2{max-height:min-content;}\n.css-drct3b{max-height:fit-content(10%);}\n.css-1gqcmp3{aspect-ratio:auto;}\n.css-kpqo31{aspect-ratio:2;}\n.css-1amvr3s{aspect-ratio:16 / 9;}\n.css-1gtanqs{width:fit-content;}\n.css-1344rbf{min-width:fit-content;}\n.css-1fuhjh6{max-width:fit-content;}\n.css-1sy0xge{height:fit-content;}\n.css-ewx31z{min-height:fit-content;}\n.css-hse59j{max-height:fit-content;}\n"
  ];
  
  CSS.make("css-cf3le8", []);
  CSS.make("css-17hckkm", []);
  CSS.make("css-muccy6", []);
  CSS.make("css-106ktvk", []);
  CSS.make("css-vlreoz", []);
  CSS.make("css-gikswh", []);
  CSS.make("css-13sc9a0", []);
  CSS.make("css-1jonlwm", []);
  CSS.make("css-gszzeg", []);
  CSS.make("css-14x27ji", []);
  CSS.make("css-uvzl7o", []);
  CSS.make("css-giv2pj", []);
  CSS.make("css-ezyx8i", []);
  CSS.make("css-14fp2tk", []);
  CSS.make("css-1iubza9", []);
  CSS.make("css-1smyxes", []);
  CSS.make("css-rl4hk2", []);
  CSS.make("css-drct3b", []);
  
  CSS.make("css-1gqcmp3", []);
  CSS.make("css-kpqo31", []);
  CSS.make("css-1amvr3s", []);
  
  CSS.make("css-1gtanqs", []);
  
  CSS.make("css-1344rbf", []);
  
  CSS.make("css-1fuhjh6", []);
  
  CSS.make("css-1sy0xge", []);
  
  CSS.make("css-ewx31z", []);
  
  CSS.make("css-hse59j", []);
