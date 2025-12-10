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
    ".css-1f08hwc { mix-blend-mode: normal; }\n.css-1bqzsig { mix-blend-mode: multiply; }\n.css-1xoua8d { mix-blend-mode: screen; }\n.css-nfx10y { mix-blend-mode: overlay; }\n.css-1ugf1mo { mix-blend-mode: darken; }\n.css-yiw63e { mix-blend-mode: lighten; }\n.css-c4662h { mix-blend-mode: color-dodge; }\n.css-1fquo4x { mix-blend-mode: color-burn; }\n.css-1vckznj { mix-blend-mode: hard-light; }\n.css-1jp3lqa { mix-blend-mode: soft-light; }\n.css-kyac9 { mix-blend-mode: difference; }\n.css-o5a7cg { mix-blend-mode: exclusion; }\n.css-1umyc8i { mix-blend-mode: hue; }\n.css-153un0 { mix-blend-mode: saturation; }\n.css-1180rsk { mix-blend-mode: color; }\n.css-ucer2v { mix-blend-mode: luminosity; }\n.css-175qyic { isolation: auto; }\n.css-1ggjbdj { isolation: isolate; }\n.css-v9v1g { background-blend-mode: normal; }\n.css-65v9p9 { background-blend-mode: multiply; }\n.css-2uki1k { background-blend-mode: screen; }\n.css-9t3kj1 { background-blend-mode: overlay; }\n.css-177oose { background-blend-mode: darken; }\n.css-8bscwo { background-blend-mode: lighten; }\n.css-jekbvv { background-blend-mode: color-dodge; }\n.css-iq6c5b { background-blend-mode: color-burn; }\n.css-aqf7i1 { background-blend-mode: hard-light; }\n.css-77cc3f { background-blend-mode: soft-light; }\n.css-1u6dv7n { background-blend-mode: difference; }\n.css-veh317 { background-blend-mode: exclusion; }\n.css-bwikuz { background-blend-mode: hue; }\n.css-1wuqo13 { background-blend-mode: saturation; }\n.css-189ngoc { background-blend-mode: color; }\n.css-1imqr8v { background-blend-mode: luminosity; }\n.css-8bpnru { background-blend-mode: normal, multiply; }\n"
  ];
  CSS.make("css-1f08hwc", []);
  CSS.make("css-1bqzsig", []);
  CSS.make("css-1xoua8d", []);
  CSS.make("css-nfx10y", []);
  CSS.make("css-1ugf1mo", []);
  CSS.make("css-yiw63e", []);
  CSS.make("css-c4662h", []);
  CSS.make("css-1fquo4x", []);
  CSS.make("css-1vckznj", []);
  CSS.make("css-1jp3lqa", []);
  CSS.make("css-kyac9", []);
  CSS.make("css-o5a7cg", []);
  CSS.make("css-1umyc8i", []);
  CSS.make("css-153un0", []);
  CSS.make("css-1180rsk", []);
  CSS.make("css-ucer2v", []);
  CSS.make("css-175qyic", []);
  CSS.make("css-1ggjbdj", []);
  CSS.make("css-v9v1g", []);
  CSS.make("css-65v9p9", []);
  CSS.make("css-2uki1k", []);
  CSS.make("css-9t3kj1", []);
  CSS.make("css-177oose", []);
  CSS.make("css-8bscwo", []);
  CSS.make("css-jekbvv", []);
  CSS.make("css-iq6c5b", []);
  CSS.make("css-aqf7i1", []);
  CSS.make("css-77cc3f", []);
  CSS.make("css-1u6dv7n", []);
  CSS.make("css-veh317", []);
  CSS.make("css-bwikuz", []);
  CSS.make("css-1wuqo13", []);
  CSS.make("css-189ngoc", []);
  CSS.make("css-1imqr8v", []);
  CSS.make("css-8bpnru", []);
