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
    ".css-1kyxa55 { text-transform: full-width; }\n.css-1powlw1 { text-transform: full-size-kana; }\n.css-1c2ga4q { tab-size: 4; }\n.css-t6wymx { tab-size: 1em; }\n.css-1ysqx33 { line-break: auto; }\n.css-cj6cnr { line-break: loose; }\n.css-vcq219 { line-break: normal; }\n.css-ij2j1f { line-break: strict; }\n.css-wa3pgd { line-break: anywhere; }\n.css-13053g0 { word-break: normal; }\n.css-v8m4ru { word-break: keep-all; }\n.css-1pguclc { word-break: break-all; }\n.css-1ntdv01 { white-space: break-spaces; }\n.css-1bu8yjf { hyphens: auto; }\n.css-18qo54h { hyphens: manual; }\n.css-hf2c6g { hyphens: none; }\n.css-1cdu0ag { overflow-wrap: normal; }\n.css-eiserq { overflow-wrap: break-word; }\n.css-1q5bkcl { overflow-wrap: anywhere; }\n.css-1bs6sst { word-wrap: normal; }\n.css-1yxv93v { word-wrap: break-word; }\n.css-12mg57i { word-wrap: anywhere; }\n.css-151x3ev { text-align: start; }\n.css-x4vrww { text-align: end; }\n.css-yj4gxb { text-align: left; }\n.css-1lsf3ii { text-align: right; }\n.css-w7yhn1 { text-align: center; }\n.css-1l5ld5d { text-align: justify; }\n.css-ll4xdg { text-align: match-parent; }\n.css-xo3im6 { text-align: justify-all; }\n.css-1nwpwql { text-align-all: start; }\n.css-1t70pze { text-align-all: end; }\n.css-1gzay4j { text-align-all: left; }\n.css-14ifgif { text-align-all: right; }\n.css-lr88xj { text-align-all: center; }\n.css-1xm75e2 { text-align-all: justify; }\n.css-zgxyhj { text-align-all: match-parent; }\n.css-orq4k5 { text-align-last: auto; }\n.css-1459ijh { text-align-last: start; }\n.css-91z7c2 { text-align-last: end; }\n.css-ut9sja { text-align-last: left; }\n.css-1yzoncx { text-align-last: right; }\n.css-2j74u { text-align-last: center; }\n.css-1hxh6ir { text-align-last: justify; }\n.css-n81d08 { text-align-last: match-parent; }\n.css-124054q { text-justify: auto; }\n.css-7b8pk2 { text-justify: none; }\n.css-1jm8gez { text-justify: inter-word; }\n.css-o70zsk { text-justify: inter-character; }\n.css-pvlemy { word-spacing: 50%; }\n.css-1u5tllc { text-indent: 1em hanging; }\n.css-ec4e6k { text-indent: 1em each-line; }\n.css-fvj5r0 { text-indent: 1em hanging each-line; }\n.css-tpah4c { hanging-punctuation: none; }\n.css-17fcpln { hanging-punctuation: first; }\n.css-khhrlt { hanging-punctuation: last; }\n.css-1u6stjn { hanging-punctuation: force-end; }\n.css-17f3iyw { hanging-punctuation: allow-end; }\n.css-1q0m69r { hanging-punctuation: first last; }\n.css-1thy6xa { hanging-punctuation: first force-end; }\n.css-sfdne8 { hanging-punctuation: first force-end last; }\n.css-q17srt { hanging-punctuation: first allow-end last; }\n.css-13e7tk3 { text-wrap: wrap; }\n.css-1fnw06h { text-wrap: nowrap; }\n.css-s3jd1f { text-wrap: balance; }\n.css-1vylowt { text-wrap: stable; }\n.css-1lw8zon { text-wrap: pretty; }\n.css-1vsq3a6 { text-wrap-mode: wrap; }\n.css-1qg241 { text-wrap-mode: nowrap; }\n.css-1wo1s7e { text-wrap-style: auto; }\n.css-ijrzhd { text-wrap-style: balance; }\n.css-ay28gq { text-wrap-style: stable; }\n.css-c36vyc { text-wrap-style: pretty; }\n"
  ];
  CSS.make("css-1kyxa55", []);
  CSS.make("css-1powlw1", []);
  
  CSS.make("css-1c2ga4q", []);
  CSS.make("css-t6wymx", []);
  CSS.make("css-1ysqx33", []);
  CSS.make("css-cj6cnr", []);
  CSS.make("css-vcq219", []);
  CSS.make("css-ij2j1f", []);
  CSS.make("css-wa3pgd", []);
  CSS.make("css-13053g0", []);
  CSS.make("css-v8m4ru", []);
  CSS.make("css-1pguclc", []);
  CSS.make("css-1ntdv01", []);
  CSS.make("css-1bu8yjf", []);
  CSS.make("css-18qo54h", []);
  CSS.make("css-hf2c6g", []);
  CSS.make("css-1cdu0ag", []);
  CSS.make("css-eiserq", []);
  CSS.make("css-1q5bkcl", []);
  CSS.make("css-1bs6sst", []);
  CSS.make("css-1yxv93v", []);
  CSS.make("css-12mg57i", []);
  CSS.make("css-151x3ev", []);
  CSS.make("css-x4vrww", []);
  CSS.make("css-yj4gxb", []);
  CSS.make("css-1lsf3ii", []);
  CSS.make("css-w7yhn1", []);
  CSS.make("css-1l5ld5d", []);
  CSS.make("css-ll4xdg", []);
  CSS.make("css-xo3im6", []);
  CSS.make("css-1nwpwql", []);
  CSS.make("css-1t70pze", []);
  CSS.make("css-1gzay4j", []);
  CSS.make("css-14ifgif", []);
  CSS.make("css-lr88xj", []);
  CSS.make("css-1xm75e2", []);
  CSS.make("css-zgxyhj", []);
  CSS.make("css-orq4k5", []);
  CSS.make("css-1459ijh", []);
  CSS.make("css-91z7c2", []);
  CSS.make("css-ut9sja", []);
  CSS.make("css-1yzoncx", []);
  CSS.make("css-2j74u", []);
  CSS.make("css-1hxh6ir", []);
  CSS.make("css-n81d08", []);
  CSS.make("css-124054q", []);
  CSS.make("css-7b8pk2", []);
  CSS.make("css-1jm8gez", []);
  CSS.make("css-o70zsk", []);
  CSS.make("css-pvlemy", []);
  CSS.make("css-1u5tllc", []);
  CSS.make("css-ec4e6k", []);
  CSS.make("css-fvj5r0", []);
  CSS.make("css-tpah4c", []);
  CSS.make("css-17fcpln", []);
  CSS.make("css-khhrlt", []);
  CSS.make("css-1u6stjn", []);
  CSS.make("css-17f3iyw", []);
  CSS.make("css-1q0m69r", []);
  CSS.make("css-1thy6xa", []);
  CSS.make("css-sfdne8", []);
  CSS.make("css-q17srt", []);
  
  CSS.make("css-13e7tk3", []);
  CSS.make("css-1fnw06h", []);
  CSS.make("css-s3jd1f", []);
  CSS.make("css-1vylowt", []);
  CSS.make("css-1lw8zon", []);
  CSS.make("css-1vsq3a6", []);
  CSS.make("css-1qg241", []);
  CSS.make("css-1wo1s7e", []);
  CSS.make("css-ijrzhd", []);
  CSS.make("css-ay28gq", []);
  CSS.make("css-c36vyc", []);
