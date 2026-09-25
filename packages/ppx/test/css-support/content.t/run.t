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
  [@css ".a-1cvidje{quotes:auto;}"];
  [@css ".a-esf2ur{content:\"►\" / \"\";}"];
  [@css ".a-1rzsdc1{content:\"\";}"];
  [@css ".a-x7dhko{content:counter(ol);}"];
  [@css ".a-8szbnh{content:counter(count, decimal);}"];
  [@css ".a-10h56qq{content:counter(count, decimal) \") \";}"];
  [@css ".a-8wd7tk{content:unset;}"];
  [@css ".a-jvordy{content:normal;}"];
  [@css ".a-71zcbh{content:none;}"];
  [@css ".a-xq1wxf{content:url(\"http://www.example.com/test.png\");}"];
  [@css ".a-leiwy{content:linear-gradient(#e66465, #9198e5);}"];
  [@css
    ".a-1synydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"
  ];
  [@css
    ".a-u6u5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css ".a-1446790{content:\"unparsed text\";}"];
  [@css ".a-1pr3ui{content:counter(chapter_counter);}"];
  [@css ".a-14exuxw{content:counter(chapter_counter, upper-roman);}"];
  [@css ".a-18nwggo{content:counters(section_counter, \".\");}"];
  [@css
    ".a-1a914i9{content:counters(section_counter, \".\", decimal-leading-zero);}"
  ];
  [@css ".a-1c6n5wz{content:attr(href);}"];
  [@css ".a-1wl2bce{content:attr(data-width px);}"];
  [@css ".a-c4enc9{content:open-quote;}"];
  [@css ".a-1vy0d5m{content:close-quote;}"];
  [@css ".a-1lroxre{content:no-open-quote;}"];
  [@css ".a-m6yzsz{content:no-close-quote;}"];
  [@css
    ".a-10fq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    ".a-nxt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css ".a-36wmef{content:open-quote counter(chapter_counter);}"];
  [@css ".a-19u1hfk{content:inherit;}"];
  [@css ".a-hqslsq{content:initial;}"];
  [@css ".a-1dxltxf{content:revert;}"];
  [@css ".a-kjtvgg{content:revert-layer;}"];
  [@css ".a-1ybks2k{content:\"点\";}"];
  [@css ".a-a9f07t{content:\"lola\";}"];
  [@css ".a-13bvtt9{content:\" \";}"];
  [@css ".a-1f06l48{content:\"'\";}"];
  [@css ".a-64u917{content:\"\\\"\";}"];
  [@css ".a-buwufj{content:attr(data-value);}"];
  [@css ".a-1rln7nw{content:attr(data-value raw-string);}"];
  [@css ".a-1vktxzt{content:attr(data-value em);}"];
  [@css ".a-1piebvu{content:attr(data-value px);}"];
  [@css ".a-1m33vis{content:\"→\";}"];
  [@css ".a-es8i71{content:\"←\";}"];
  [@css ".a-b3jm9f{content:\"↑\";}"];
  [@css ".a-y08ulk{content:\"↓\";}"];
  [@css ".a-15ni5s9{content:\"“\";}"];
  [@css ".a-3tb13f{content:\"‘\";}"];
  [@css ".a-s8n7fj{content:\"’\";}"];
  [@css ".a-129wxr5{content:\"•\";}"];
  [@css ".a-1xb5ir8{content:\"—\";}"];
  [@css ".a-hk17ng{content:\"…\";}"];
  [@css ".a-1of8arn{content:\"♥\";}"];
  [@css ".a-j4gzna{content:\"✓\";}"];
  [@css ".a-1yay3yn{content:\"✗\";}"];
  [@css ".a-wlvyh0{content:\"\" attr(data-title) \"”\";}"];
  [@css ".a-h1nazq{content:\"→\" \" Click here\";}"];
  [@css ".a-1j520c{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css ".a-1epe5sp{content:\"💡\";}"];
  [@css ".a-7r561c{content:\"👍\";}"];
  [@css ".a-1d5vc81{content:\"»\";}"];
  [@css ".a-uc3v3e{content:\"§\";}"];
  [@css ".a-wzfv9f{content:\"→ \" attr(href);}"];
  [@css ".a-ru4efr{content:\"• \" counter(item, decimal) \" \";}"];
  
  CSS.make("a-1cvidje", []);
  
  CSS.make("a-esf2ur", []);
  
  CSS.make("a-1rzsdc1", []);
  
  CSS.make("a-x7dhko", []);
  CSS.make("a-8szbnh", []);
  CSS.make("a-10h56qq", []);
  CSS.make("a-8wd7tk", []);
  
  CSS.make("a-jvordy", []);
  CSS.make("a-71zcbh", []);
  
  CSS.make("a-xq1wxf", []);
  CSS.make("a-leiwy", []);
  CSS.make("a-1synydd", []);
  
  CSS.make("a-u6u5b0", []);
  
  CSS.make("a-1446790", []);
  
  CSS.make("a-1pr3ui", []);
  CSS.make("a-14exuxw", []);
  
  CSS.make("a-18nwggo", []);
  CSS.make("a-1a914i9", []);
  
  CSS.make("a-1c6n5wz", []);
  CSS.make("a-1wl2bce", []);
  
  CSS.make("a-c4enc9", []);
  CSS.make("a-1vy0d5m", []);
  CSS.make("a-1lroxre", []);
  CSS.make("a-m6yzsz", []);
  
  CSS.make("a-10fq46n", []);
  CSS.make("a-nxt6w1", []);
  
  CSS.make("a-36wmef", []);
  
  CSS.make("a-19u1hfk", []);
  CSS.make("a-hqslsq", []);
  CSS.make("a-1dxltxf", []);
  CSS.make("a-kjtvgg", []);
  CSS.make("a-8wd7tk", []);
  
  CSS.make("a-1ybks2k", []);
  CSS.make("a-1ybks2k", []);
  CSS.make("a-1ybks2k", []);
  CSS.make("a-a9f07t", []);
  CSS.make("a-a9f07t", []);
  CSS.make("a-1rzsdc1", []);
  CSS.make("a-13bvtt9", []);
  CSS.make("a-13bvtt9", []);
  CSS.make("a-1rzsdc1", []);
  CSS.make("a-1f06l48", []);
  CSS.make("a-64u917", []);
  
  CSS.make("a-1c6n5wz", []);
  CSS.make("a-buwufj", []);
  
  CSS.make("a-1rln7nw", []);
  CSS.make("a-1vktxzt", []);
  CSS.make("a-1piebvu", []);
  
  CSS.make("a-1m33vis", []);
  CSS.make("a-es8i71", []);
  CSS.make("a-b3jm9f", []);
  CSS.make("a-y08ulk", []);
  
  CSS.make("a-15ni5s9", []);
  
  CSS.make("a-3tb13f", []);
  CSS.make("a-s8n7fj", []);
  
  CSS.make("a-129wxr5", []);
  CSS.make("a-1xb5ir8", []);
  CSS.make("a-hk17ng", []);
  CSS.make("a-1of8arn", []);
  CSS.make("a-j4gzna", []);
  CSS.make("a-1yay3yn", []);
  CSS.make("a-hk17ng", []);
  
  CSS.make("a-wlvyh0", []);
  CSS.make("a-h1nazq", []);
  CSS.make("a-1j520c", []);
  
  CSS.make("a-1epe5sp", []);
  CSS.make("a-7r561c", []);
  
  CSS.make("a-1d5vc81", []);
  CSS.make("a-uc3v3e", []);
  
  CSS.make("a-1m33vis", []);
  CSS.make("a-13bvtt9", []);
  
  CSS.make("a-1m33vis", []);
  CSS.make("a-129wxr5", []);
  CSS.make("a-1xb5ir8", []);
  CSS.make("a-hk17ng", []);
  CSS.make("a-64u917", []);
  CSS.make("a-64u917", []);
  CSS.make("a-j4gzna", []);
  CSS.make("a-1of8arn", []);
  CSS.make("a-wzfv9f", []);
  CSS.make("a-ru4efr", []);
