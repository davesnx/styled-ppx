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
  [@css ".css-1cvidje{quotes:auto;}"];
  [@css ".css-esf2ur{content:\"►\" / \"\";}"];
  [@css ".css-1rzsdc1{content:\"\";}"];
  [@css ".css-8szbnh{content:counter(count, decimal);}"];
  [@css ".css-10h56qq{content:counter(count, decimal) \") \";}"];
  [@css ".css-8wd7tk{content:unset;}"];
  [@css ".css-jvordy{content:normal;}"];
  [@css ".css-71zcbh{content:none;}"];
  [@css ".css-xq1wxf{content:url(\"http://www.example.com/test.png\");}"];
  [@css ".css-leiwy{content:linear-gradient(#e66465, #9198e5);}"];
  [@css
    ".css-1synydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"
  ];
  [@css
    ".css-u6u5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css ".css-1446790{content:\"unparsed text\";}"];
  [@css ".css-1c6n5wz{content:attr(href);}"];
  [@css ".css-1wl2bce{content:attr(data-width px);}"];
  [@css ".css-c4enc9{content:open-quote;}"];
  [@css ".css-1vy0d5m{content:close-quote;}"];
  [@css ".css-1lroxre{content:no-open-quote;}"];
  [@css ".css-m6yzsz{content:no-close-quote;}"];
  [@css
    ".css-10fq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    ".css-nxt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css ".css-19u1hfk{content:inherit;}"];
  [@css ".css-hqslsq{content:initial;}"];
  [@css ".css-1dxltxf{content:revert;}"];
  [@css ".css-kjtvgg{content:revert-layer;}"];
  [@css ".css-1ybks2k{content:\"点\";}"];
  [@css ".css-a9f07t{content:\"lola\";}"];
  [@css ".css-13bvtt9{content:\" \";}"];
  [@css ".css-1f06l48{content:\"'\";}"];
  [@css ".css-129wxr5{content:\"\"\";}"];
  [@css ".css-buwufj{content:attr(data-value);}"];
  [@css ".css-1rln7nw{content:attr(data-value raw-string);}"];
  [@css ".css-1vktxzt{content:attr(data-value em);}"];
  [@css ".css-1piebvu{content:attr(data-value px);}"];
  [@css ".css-1m33vis{content:\"→\";}"];
  [@css ".css-es8i71{content:\"←\";}"];
  [@css ".css-b3jm9f{content:\"↑\";}"];
  [@css ".css-y08ulk{content:\"↓\";}"];
  [@css ".css-15ni5s9{content:\"“\";}"];
  [@css ".css-3tb13f{content:\"‘\";}"];
  [@css ".css-s8n7fj{content:\"’\";}"];
  [@css ".css-1xb5ir8{content:\"—\";}"];
  [@css ".css-hk17ng{content:\"…\";}"];
  [@css ".css-1of8arn{content:\"♥\";}"];
  [@css ".css-j4gzna{content:\"✓\";}"];
  [@css ".css-1yay3yn{content:\"✗\";}"];
  [@css ".css-wlvyh0{content:\"\" attr(data-title) \"”\";}"];
  [@css ".css-h1nazq{content:\"→\" \" Click here\";}"];
  [@css ".css-1j520c{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css ".css-1epe5sp{content:\"💡\";}"];
  [@css ".css-7r561c{content:\"👍\";}"];
  [@css ".css-1d5vc81{content:\"»\";}"];
  [@css ".css-uc3v3e{content:\"§\";}"];
  [@css ".css-wzfv9f{content:\"→ \" attr(href);}"];
  [@css ".css-ru4efr{content:\"• \" counter(item, decimal) \" \";}"];
  
  CSS.make("css-1cvidje", []);
  
  CSS.make("css-esf2ur", []);
  
  CSS.make("css-1rzsdc1", []);
  
  CSS.make("css-8szbnh", []);
  CSS.make("css-10h56qq", []);
  CSS.make("css-8wd7tk", []);
  
  CSS.make("css-jvordy", []);
  CSS.make("css-71zcbh", []);
  
  CSS.make("css-xq1wxf", []);
  CSS.make("css-leiwy", []);
  CSS.make("css-1synydd", []);
  
  CSS.make("css-u6u5b0", []);
  
  CSS.make("css-1446790", []);
  
  CSS.make("css-1c6n5wz", []);
  CSS.make("css-1wl2bce", []);
  
  CSS.make("css-c4enc9", []);
  CSS.make("css-1vy0d5m", []);
  CSS.make("css-1lroxre", []);
  CSS.make("css-m6yzsz", []);
  
  CSS.make("css-10fq46n", []);
  CSS.make("css-nxt6w1", []);
  
  CSS.make("css-19u1hfk", []);
  CSS.make("css-hqslsq", []);
  CSS.make("css-1dxltxf", []);
  CSS.make("css-kjtvgg", []);
  CSS.make("css-8wd7tk", []);
  
  CSS.make("css-1ybks2k", []);
  CSS.make("css-1ybks2k", []);
  CSS.make("css-1ybks2k", []);
  CSS.make("css-a9f07t", []);
  CSS.make("css-a9f07t", []);
  CSS.make("css-1rzsdc1", []);
  CSS.make("css-13bvtt9", []);
  CSS.make("css-13bvtt9", []);
  CSS.make("css-1rzsdc1", []);
  CSS.make("css-1f06l48", []);
  CSS.make("css-129wxr5", []);
  
  CSS.make("css-1c6n5wz", []);
  CSS.make("css-buwufj", []);
  
  CSS.make("css-1rln7nw", []);
  CSS.make("css-1vktxzt", []);
  CSS.make("css-1piebvu", []);
  
  CSS.make("css-1m33vis", []);
  CSS.make("css-es8i71", []);
  CSS.make("css-b3jm9f", []);
  CSS.make("css-y08ulk", []);
  
  CSS.make("css-15ni5s9", []);
  
  CSS.make("css-3tb13f", []);
  CSS.make("css-s8n7fj", []);
  
  CSS.make("css-129wxr5", []);
  CSS.make("css-1xb5ir8", []);
  CSS.make("css-hk17ng", []);
  CSS.make("css-1of8arn", []);
  CSS.make("css-j4gzna", []);
  CSS.make("css-1yay3yn", []);
  CSS.make("css-hk17ng", []);
  
  CSS.make("css-wlvyh0", []);
  CSS.make("css-h1nazq", []);
  CSS.make("css-1j520c", []);
  
  CSS.make("css-1epe5sp", []);
  CSS.make("css-7r561c", []);
  
  CSS.make("css-1d5vc81", []);
  CSS.make("css-uc3v3e", []);
  
  CSS.make("css-1m33vis", []);
  CSS.make("css-13bvtt9", []);
  
  CSS.make("css-1m33vis", []);
  CSS.make("css-129wxr5", []);
  CSS.make("css-1xb5ir8", []);
  CSS.make("css-hk17ng", []);
  CSS.make("css-129wxr5", []);
  CSS.make("css-129wxr5", []);
  CSS.make("css-j4gzna", []);
  CSS.make("css-1of8arn", []);
  CSS.make("css-wzfv9f", []);
  CSS.make("css-ru4efr", []);
