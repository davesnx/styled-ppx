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
  [@css "._a_acoiv8{scroll-margin:0px;}"];
  [@css "._a_acqcuf{scroll-margin:6px 5px;}"];
  [@css "._a_acxymj{scroll-margin:10px 20px 30px;}"];
  [@css "._a_acu2fa{scroll-margin:10px 20px 30px 40px;}"];
  [@css "._a_ac13tb{scroll-margin:20px 3em 1in 5rem;}"];
  [@css "._a_ac9mki{scroll-margin:calc(2px);}"];
  [@css "._a_ac3nfx{scroll-margin:calc(3 * 25px);}"];
  [@css "._a_ac600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css "._a_adu6my{scroll-margin-block:10px;}"];
  [@css "._a_ad4sq4{scroll-margin-block:10px 10px;}"];
  [@css "._a_ad00115zm{scroll-margin-block-end:10px;}"];
  [@css "._a_ad0024bj5{scroll-margin-block-start:10px;}"];
  [@css "._a_ac001vqxc{scroll-margin-bottom:10px;}"];
  [@css "._a_ae12qs{scroll-margin-inline:10px;}"];
  [@css "._a_aemvdw{scroll-margin-inline:10px 10px;}"];
  [@css "._a_ae002snad{scroll-margin-inline-start:10px;}"];
  [@css "._a_ae0019xfm{scroll-margin-inline-end:10px;}"];
  [@css "._a_ac002fvv1{scroll-margin-left:10px;}"];
  [@css "._a_ac004la2e{scroll-margin-right:10px;}"];
  [@css "._a_ac008aols{scroll-margin-top:10px;}"];
  [@css "._a_ag5nxv{scroll-padding:auto;}"];
  [@css "._a_aghj9v{scroll-padding:0px;}"];
  [@css "._a_ag5af6{scroll-padding:6px 5px;}"];
  [@css "._a_agms3y{scroll-padding:10px 20px 30px;}"];
  [@css "._a_agalk9{scroll-padding:10px 20px 30px 40px;}"];
  [@css "._a_ag7x4v{scroll-padding:10px auto 30px auto;}"];
  [@css "._a_agywb5{scroll-padding:10%;}"];
  [@css "._a_agdoub{scroll-padding:20% 3em 1in 5rem;}"];
  [@css "._a_agicma{scroll-padding:calc(2px);}"];
  [@css "._a_ags866{scroll-padding:calc(50%);}"];
  [@css "._a_ag6ps6{scroll-padding:calc(3 * 25px);}"];
  [@css "._a_agm7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css "._a_ah3npc{scroll-padding-block:10px;}"];
  [@css "._a_ah7n61{scroll-padding-block:50%;}"];
  [@css "._a_ahn72y{scroll-padding-block:10px 50%;}"];
  [@css "._a_ahbmh3{scroll-padding-block:50% 50%;}"];
  [@css "._a_ah001a4an{scroll-padding-block-end:10px;}"];
  [@css "._a_ah001wq8b{scroll-padding-block-end:50%;}"];
  [@css "._a_ah002tyb1{scroll-padding-block-start:10px;}"];
  [@css "._a_ah002kly5{scroll-padding-block-start:50%;}"];
  [@css "._a_ag001568d{scroll-padding-bottom:10px;}"];
  [@css "._a_ag001czmj{scroll-padding-bottom:50%;}"];
  [@css "._a_aihvee{scroll-padding-inline:10px;}"];
  [@css "._a_ai178e{scroll-padding-inline:50%;}"];
  [@css "._a_aifqw4{scroll-padding-inline:10px 50%;}"];
  [@css "._a_aijitd{scroll-padding-inline:50% 50%;}"];
  [@css "._a_ai001xv1o{scroll-padding-inline-end:10px;}"];
  [@css "._a_ai001ybsb{scroll-padding-inline-end:50%;}"];
  [@css "._a_ai00221xl{scroll-padding-inline-start:10px;}"];
  [@css "._a_ai002s74z{scroll-padding-inline-start:50%;}"];
  [@css "._a_ag002mm5y{scroll-padding-left:10px;}"];
  [@css "._a_ag002jsh3{scroll-padding-left:50%;}"];
  [@css "._a_ag0043z1d{scroll-padding-right:10px;}"];
  [@css "._a_ag004pbq8{scroll-padding-right:50%;}"];
  [@css "._a_ag00805tp{scroll-padding-top:10px;}"];
  [@css "._a_ag008o8nm{scroll-padding-top:50%;}"];
  [@css "._a_ajhsyj{scroll-snap-align:none;}"];
  [@css "._a_ajpqsp{scroll-snap-align:start;}"];
  [@css "._a_ajic9p{scroll-snap-align:end;}"];
  [@css "._a_ajf1ss{scroll-snap-align:center;}"];
  [@css "._a_ajkzni{scroll-snap-align:none start;}"];
  [@css "._a_ajvewf{scroll-snap-align:end center;}"];
  [@css "._a_ajgzch{scroll-snap-align:center start;}"];
  [@css "._a_aj5icl{scroll-snap-align:end none;}"];
  [@css "._a_ajkijw{scroll-snap-align:center center;}"];
  [@css "._a_aoahur{scroll-snap-stop:normal;}"];
  [@css "._a_aoqcsf{scroll-snap-stop:always;}"];
  [@css
    "._a_apu1g1{-webkit-scroll-snap-type:none;-ms-scroll-snap-type:none;scroll-snap-type:none;}"
  ];
  [@css
    "._a_apigf3{-webkit-scroll-snap-type:x mandatory;-ms-scroll-snap-type:x mandatory;scroll-snap-type:x mandatory;}"
  ];
  [@css
    "._a_ap8bwf{-webkit-scroll-snap-type:y mandatory;-ms-scroll-snap-type:y mandatory;scroll-snap-type:y mandatory;}"
  ];
  [@css
    "._a_apyx25{-webkit-scroll-snap-type:block mandatory;-ms-scroll-snap-type:block mandatory;scroll-snap-type:block mandatory;}"
  ];
  [@css
    "._a_ape0h2{-webkit-scroll-snap-type:inline mandatory;-ms-scroll-snap-type:inline mandatory;scroll-snap-type:inline mandatory;}"
  ];
  [@css
    "._a_ap2jo5{-webkit-scroll-snap-type:both mandatory;-ms-scroll-snap-type:both mandatory;scroll-snap-type:both mandatory;}"
  ];
  [@css
    "._a_apl9bg{-webkit-scroll-snap-type:x proximity;-ms-scroll-snap-type:x proximity;scroll-snap-type:x proximity;}"
  ];
  [@css
    "._a_api18o{-webkit-scroll-snap-type:y proximity;-ms-scroll-snap-type:y proximity;scroll-snap-type:y proximity;}"
  ];
  [@css
    "._a_apeyk4{-webkit-scroll-snap-type:block proximity;-ms-scroll-snap-type:block proximity;scroll-snap-type:block proximity;}"
  ];
  [@css
    "._a_apr31t{-webkit-scroll-snap-type:inline proximity;-ms-scroll-snap-type:inline proximity;scroll-snap-type:inline proximity;}"
  ];
  [@css
    "._a_apvwfl{-webkit-scroll-snap-type:both proximity;-ms-scroll-snap-type:both proximity;scroll-snap-type:both proximity;}"
  ];
  
  CSS.make("_a_acoiv8", []);
  CSS.make("_a_acqcuf", []);
  CSS.make("_a_acxymj", []);
  CSS.make("_a_acu2fa", []);
  CSS.make("_a_ac13tb", []);
  CSS.make("_a_ac9mki", []);
  CSS.make("_a_ac3nfx", []);
  CSS.make("_a_ac600i", []);
  CSS.make("_a_adu6my", []);
  CSS.make("_a_ad4sq4", []);
  CSS.make("_a_ad00115zm", []);
  CSS.make("_a_ad0024bj5", []);
  CSS.make("_a_ac001vqxc", []);
  CSS.make("_a_ae12qs", []);
  CSS.make("_a_aemvdw", []);
  CSS.make("_a_ae002snad", []);
  CSS.make("_a_ae0019xfm", []);
  CSS.make("_a_ac002fvv1", []);
  CSS.make("_a_ac004la2e", []);
  CSS.make("_a_ac008aols", []);
  CSS.make("_a_ag5nxv", []);
  CSS.make("_a_aghj9v", []);
  CSS.make("_a_ag5af6", []);
  CSS.make("_a_agms3y", []);
  CSS.make("_a_agalk9", []);
  CSS.make("_a_ag7x4v", []);
  CSS.make("_a_agywb5", []);
  CSS.make("_a_agdoub", []);
  CSS.make("_a_agicma", []);
  CSS.make("_a_ags866", []);
  CSS.make("_a_ag6ps6", []);
  CSS.make("_a_agm7if", []);
  CSS.make("_a_ah3npc", []);
  CSS.make("_a_ah7n61", []);
  CSS.make("_a_ahn72y", []);
  CSS.make("_a_ahbmh3", []);
  CSS.make("_a_ah001a4an", []);
  CSS.make("_a_ah001wq8b", []);
  CSS.make("_a_ah002tyb1", []);
  CSS.make("_a_ah002kly5", []);
  CSS.make("_a_ag001568d", []);
  CSS.make("_a_ag001czmj", []);
  CSS.make("_a_aihvee", []);
  CSS.make("_a_ai178e", []);
  CSS.make("_a_aifqw4", []);
  CSS.make("_a_aijitd", []);
  CSS.make("_a_ai001xv1o", []);
  CSS.make("_a_ai001ybsb", []);
  CSS.make("_a_ai00221xl", []);
  CSS.make("_a_ai002s74z", []);
  CSS.make("_a_ag002mm5y", []);
  CSS.make("_a_ag002jsh3", []);
  CSS.make("_a_ag0043z1d", []);
  CSS.make("_a_ag004pbq8", []);
  CSS.make("_a_ag00805tp", []);
  CSS.make("_a_ag008o8nm", []);
  CSS.make("_a_ajhsyj", []);
  CSS.make("_a_ajpqsp", []);
  CSS.make("_a_ajic9p", []);
  CSS.make("_a_ajf1ss", []);
  CSS.make("_a_ajkzni", []);
  CSS.make("_a_ajvewf", []);
  CSS.make("_a_ajgzch", []);
  CSS.make("_a_aj5icl", []);
  CSS.make("_a_ajkijw", []);
  CSS.make("_a_aoahur", []);
  CSS.make("_a_aoqcsf", []);
  CSS.make("_a_apu1g1", []);
  CSS.make("_a_apigf3", []);
  CSS.make("_a_ap8bwf", []);
  CSS.make("_a_apyx25", []);
  CSS.make("_a_ape0h2", []);
  CSS.make("_a_ap2jo5", []);
  CSS.make("_a_apl9bg", []);
  CSS.make("_a_api18o", []);
  CSS.make("_a_apeyk4", []);
  CSS.make("_a_apr31t", []);
  CSS.make("_a_apvwfl", []);
