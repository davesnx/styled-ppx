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
    ".css-1cvidje{quotes:auto;}\n.css-esf2ur{content:\"►\" / \"\";}\n.css-1rzsdc1{content:\"\";}\n.css-8szbnh{content:counter(count, decimal);}\n.css-10h56qq{content:counter(count, decimal) \") \";}\n.css-8wd7tk{content:unset;}\n.css-jvordy{content:normal;}\n.css-71zcbh{content:none;}\n.css-xq1wxf{content:url(\"http://www.example.com/test.png\");}\n.css-leiwy{content:linear-gradient(#e66465, #9198e5);}\n.css-1synydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}\n.css-u6u5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}\n.css-1446790{content:\"unparsed text\";}\n.css-1c6n5wz{content:attr(href);}\n.css-1wl2bce{content:attr(data-width px);}\n.css-c4enc9{content:open-quote;}\n.css-1vy0d5m{content:close-quote;}\n.css-1lroxre{content:no-open-quote;}\n.css-m6yzsz{content:no-close-quote;}\n.css-10fq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}\n.css-nxt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}\n.css-19u1hfk{content:inherit;}\n.css-hqslsq{content:initial;}\n.css-1dxltxf{content:revert;}\n.css-kjtvgg{content:revert-layer;}\n.css-10w9q04{content:\"ç¹\";}\n.css-a9f07t{content:\"lola\";}\n.css-13bvtt9{content:\" \";}\n.css-1f06l48{content:\"'\";}\n.css-129wxr5{content:\"\"\";}\n.css-buwufj{content:attr(data-value);}\n.css-1rln7nw{content:attr(data-value raw-string);}\n.css-1vktxzt{content:attr(data-value em);}\n.css-1piebvu{content:attr(data-value px);}\n.css-1m33vis{content:\"→\";}\n.css-es8i71{content:\"←\";}\n.css-b3jm9f{content:\"↑\";}\n.css-y08ulk{content:\"↓\";}\n.css-15ni5s9{content:\"“\";}\n.css-3tb13f{content:\"‘\";}\n.css-s8n7fj{content:\"’\";}\n.css-1xb5ir8{content:\"—\";}\n.css-hk17ng{content:\"…\";}\n.css-1of8arn{content:\"♥\";}\n.css-j4gzna{content:\"✓\";}\n.css-1yay3yn{content:\"✗\";}\n.css-wlvyh0{content:\"\" attr(data-title) \"”\";}\n.css-h1nazq{content:\"→\" \" Click here\";}\n.css-1j520c{content:\"Step \" counter(step, decimal) \": \";}\n.css-1epe5sp{content:\"💡\";}\n.css-7r561c{content:\"👍\";}\n.css-1d5vc81{content:\"»\";}\n.css-uc3v3e{content:\"§\";}\n.css-131ui7f{content:\"â\";}\n.css-1pi2ahe{content:\"â¢\";}\n.css-1cn5rt7{content:\"â\";}\n.css-1ekzqlk{content:\"â¦\";}\n.css-1t7q745{content:\"â\";}\n.css-18ka1q1{content:\"â¥\";}\n.css-fjyadu{content:\"â \" attr(href);}\n.css-87rbvc{content:\"â¢ \" counter(item, decimal) \" \";}\n"
  ];
  
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
  
  CSS.make("css-10w9q04", []);
  CSS.make("css-10w9q04", []);
  CSS.make("css-10w9q04", []);
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
  
  CSS.make("css-131ui7f", []);
  CSS.make("css-1pi2ahe", []);
  CSS.make("css-1cn5rt7", []);
  CSS.make("css-1ekzqlk", []);
  CSS.make("css-129wxr5", []);
  CSS.make("css-129wxr5", []);
  CSS.make("css-1t7q745", []);
  CSS.make("css-18ka1q1", []);
  CSS.make("css-fjyadu", []);
  CSS.make("css-87rbvc", []);
