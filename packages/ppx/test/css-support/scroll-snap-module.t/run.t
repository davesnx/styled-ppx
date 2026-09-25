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
  [@css ".a-acoiv8{scroll-margin:0px;}"];
  [@css ".a-acqcuf{scroll-margin:6px 5px;}"];
  [@css ".a-acxymj{scroll-margin:10px 20px 30px;}"];
  [@css ".a-acu2fa{scroll-margin:10px 20px 30px 40px;}"];
  [@css ".a-ac13tb{scroll-margin:20px 3em 1in 5rem;}"];
  [@css ".a-ac9mki{scroll-margin:calc(2px);}"];
  [@css ".a-ac3nfx{scroll-margin:calc(3 * 25px);}"];
  [@css ".a-ac600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css ".a-adu6my{scroll-margin-block:10px;}"];
  [@css ".a-ad4sq4{scroll-margin-block:10px 10px;}"];
  [@css ".a-ad00115zm{scroll-margin-block-end:10px;}"];
  [@css ".a-ad0024bj5{scroll-margin-block-start:10px;}"];
  [@css ".a-ac001vqxc{scroll-margin-bottom:10px;}"];
  [@css ".a-ae12qs{scroll-margin-inline:10px;}"];
  [@css ".a-aemvdw{scroll-margin-inline:10px 10px;}"];
  [@css ".a-ae002snad{scroll-margin-inline-start:10px;}"];
  [@css ".a-ae0019xfm{scroll-margin-inline-end:10px;}"];
  [@css ".a-ac002fvv1{scroll-margin-left:10px;}"];
  [@css ".a-ac004la2e{scroll-margin-right:10px;}"];
  [@css ".a-ac008aols{scroll-margin-top:10px;}"];
  [@css ".a-ag5nxv{scroll-padding:auto;}"];
  [@css ".a-aghj9v{scroll-padding:0px;}"];
  [@css ".a-ag5af6{scroll-padding:6px 5px;}"];
  [@css ".a-agms3y{scroll-padding:10px 20px 30px;}"];
  [@css ".a-agalk9{scroll-padding:10px 20px 30px 40px;}"];
  [@css ".a-ag7x4v{scroll-padding:10px auto 30px auto;}"];
  [@css ".a-agywb5{scroll-padding:10%;}"];
  [@css ".a-agdoub{scroll-padding:20% 3em 1in 5rem;}"];
  [@css ".a-agicma{scroll-padding:calc(2px);}"];
  [@css ".a-ags866{scroll-padding:calc(50%);}"];
  [@css ".a-ag6ps6{scroll-padding:calc(3 * 25px);}"];
  [@css ".a-agm7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css ".a-ah3npc{scroll-padding-block:10px;}"];
  [@css ".a-ah7n61{scroll-padding-block:50%;}"];
  [@css ".a-ahn72y{scroll-padding-block:10px 50%;}"];
  [@css ".a-ahbmh3{scroll-padding-block:50% 50%;}"];
  [@css ".a-ah001a4an{scroll-padding-block-end:10px;}"];
  [@css ".a-ah001wq8b{scroll-padding-block-end:50%;}"];
  [@css ".a-ah002tyb1{scroll-padding-block-start:10px;}"];
  [@css ".a-ah002kly5{scroll-padding-block-start:50%;}"];
  [@css ".a-ag001568d{scroll-padding-bottom:10px;}"];
  [@css ".a-ag001czmj{scroll-padding-bottom:50%;}"];
  [@css ".a-aihvee{scroll-padding-inline:10px;}"];
  [@css ".a-ai178e{scroll-padding-inline:50%;}"];
  [@css ".a-aifqw4{scroll-padding-inline:10px 50%;}"];
  [@css ".a-aijitd{scroll-padding-inline:50% 50%;}"];
  [@css ".a-ai001xv1o{scroll-padding-inline-end:10px;}"];
  [@css ".a-ai001ybsb{scroll-padding-inline-end:50%;}"];
  [@css ".a-ai00221xl{scroll-padding-inline-start:10px;}"];
  [@css ".a-ai002s74z{scroll-padding-inline-start:50%;}"];
  [@css ".a-ag002mm5y{scroll-padding-left:10px;}"];
  [@css ".a-ag002jsh3{scroll-padding-left:50%;}"];
  [@css ".a-ag0043z1d{scroll-padding-right:10px;}"];
  [@css ".a-ag004pbq8{scroll-padding-right:50%;}"];
  [@css ".a-ag00805tp{scroll-padding-top:10px;}"];
  [@css ".a-ag008o8nm{scroll-padding-top:50%;}"];
  [@css ".a-ajhsyj{scroll-snap-align:none;}"];
  [@css ".a-ajpqsp{scroll-snap-align:start;}"];
  [@css ".a-ajic9p{scroll-snap-align:end;}"];
  [@css ".a-ajf1ss{scroll-snap-align:center;}"];
  [@css ".a-ajkzni{scroll-snap-align:none start;}"];
  [@css ".a-ajvewf{scroll-snap-align:end center;}"];
  [@css ".a-ajgzch{scroll-snap-align:center start;}"];
  [@css ".a-aj5icl{scroll-snap-align:end none;}"];
  [@css ".a-ajkijw{scroll-snap-align:center center;}"];
  [@css ".a-aoahur{scroll-snap-stop:normal;}"];
  [@css ".a-aoqcsf{scroll-snap-stop:always;}"];
  [@css
    ".a-apu1g1{-webkit-scroll-snap-type:none;-ms-scroll-snap-type:none;scroll-snap-type:none;}"
  ];
  [@css
    ".a-apigf3{-webkit-scroll-snap-type:x mandatory;-ms-scroll-snap-type:x mandatory;scroll-snap-type:x mandatory;}"
  ];
  [@css
    ".a-ap8bwf{-webkit-scroll-snap-type:y mandatory;-ms-scroll-snap-type:y mandatory;scroll-snap-type:y mandatory;}"
  ];
  [@css
    ".a-apyx25{-webkit-scroll-snap-type:block mandatory;-ms-scroll-snap-type:block mandatory;scroll-snap-type:block mandatory;}"
  ];
  [@css
    ".a-ape0h2{-webkit-scroll-snap-type:inline mandatory;-ms-scroll-snap-type:inline mandatory;scroll-snap-type:inline mandatory;}"
  ];
  [@css
    ".a-ap2jo5{-webkit-scroll-snap-type:both mandatory;-ms-scroll-snap-type:both mandatory;scroll-snap-type:both mandatory;}"
  ];
  [@css
    ".a-apl9bg{-webkit-scroll-snap-type:x proximity;-ms-scroll-snap-type:x proximity;scroll-snap-type:x proximity;}"
  ];
  [@css
    ".a-api18o{-webkit-scroll-snap-type:y proximity;-ms-scroll-snap-type:y proximity;scroll-snap-type:y proximity;}"
  ];
  [@css
    ".a-apeyk4{-webkit-scroll-snap-type:block proximity;-ms-scroll-snap-type:block proximity;scroll-snap-type:block proximity;}"
  ];
  [@css
    ".a-apr31t{-webkit-scroll-snap-type:inline proximity;-ms-scroll-snap-type:inline proximity;scroll-snap-type:inline proximity;}"
  ];
  [@css
    ".a-apvwfl{-webkit-scroll-snap-type:both proximity;-ms-scroll-snap-type:both proximity;scroll-snap-type:both proximity;}"
  ];
  
  CSS.make("a-acoiv8", []);
  CSS.make("a-acqcuf", []);
  CSS.make("a-acxymj", []);
  CSS.make("a-acu2fa", []);
  CSS.make("a-ac13tb", []);
  CSS.make("a-ac9mki", []);
  CSS.make("a-ac3nfx", []);
  CSS.make("a-ac600i", []);
  CSS.make("a-adu6my", []);
  CSS.make("a-ad4sq4", []);
  CSS.make("a-ad00115zm", []);
  CSS.make("a-ad0024bj5", []);
  CSS.make("a-ac001vqxc", []);
  CSS.make("a-ae12qs", []);
  CSS.make("a-aemvdw", []);
  CSS.make("a-ae002snad", []);
  CSS.make("a-ae0019xfm", []);
  CSS.make("a-ac002fvv1", []);
  CSS.make("a-ac004la2e", []);
  CSS.make("a-ac008aols", []);
  CSS.make("a-ag5nxv", []);
  CSS.make("a-aghj9v", []);
  CSS.make("a-ag5af6", []);
  CSS.make("a-agms3y", []);
  CSS.make("a-agalk9", []);
  CSS.make("a-ag7x4v", []);
  CSS.make("a-agywb5", []);
  CSS.make("a-agdoub", []);
  CSS.make("a-agicma", []);
  CSS.make("a-ags866", []);
  CSS.make("a-ag6ps6", []);
  CSS.make("a-agm7if", []);
  CSS.make("a-ah3npc", []);
  CSS.make("a-ah7n61", []);
  CSS.make("a-ahn72y", []);
  CSS.make("a-ahbmh3", []);
  CSS.make("a-ah001a4an", []);
  CSS.make("a-ah001wq8b", []);
  CSS.make("a-ah002tyb1", []);
  CSS.make("a-ah002kly5", []);
  CSS.make("a-ag001568d", []);
  CSS.make("a-ag001czmj", []);
  CSS.make("a-aihvee", []);
  CSS.make("a-ai178e", []);
  CSS.make("a-aifqw4", []);
  CSS.make("a-aijitd", []);
  CSS.make("a-ai001xv1o", []);
  CSS.make("a-ai001ybsb", []);
  CSS.make("a-ai00221xl", []);
  CSS.make("a-ai002s74z", []);
  CSS.make("a-ag002mm5y", []);
  CSS.make("a-ag002jsh3", []);
  CSS.make("a-ag0043z1d", []);
  CSS.make("a-ag004pbq8", []);
  CSS.make("a-ag00805tp", []);
  CSS.make("a-ag008o8nm", []);
  CSS.make("a-ajhsyj", []);
  CSS.make("a-ajpqsp", []);
  CSS.make("a-ajic9p", []);
  CSS.make("a-ajf1ss", []);
  CSS.make("a-ajkzni", []);
  CSS.make("a-ajvewf", []);
  CSS.make("a-ajgzch", []);
  CSS.make("a-aj5icl", []);
  CSS.make("a-ajkijw", []);
  CSS.make("a-aoahur", []);
  CSS.make("a-aoqcsf", []);
  CSS.make("a-apu1g1", []);
  CSS.make("a-apigf3", []);
  CSS.make("a-ap8bwf", []);
  CSS.make("a-apyx25", []);
  CSS.make("a-ape0h2", []);
  CSS.make("a-ap2jo5", []);
  CSS.make("a-apl9bg", []);
  CSS.make("a-api18o", []);
  CSS.make("a-apeyk4", []);
  CSS.make("a-apr31t", []);
  CSS.make("a-apvwfl", []);
