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
  [@css ".css-83i9mg{scroll-margin:0px;}"];
  [@css ".css-1voi9oa{scroll-margin:6px 5px;}"];
  [@css ".css-1s9yffv{scroll-margin:10px 20px 30px;}"];
  [@css ".css-6bcy26{scroll-margin:10px 20px 30px 40px;}"];
  [@css ".css-bi9vrs{scroll-margin:20px 3em 1in 5rem;}"];
  [@css ".css-hzgyfz{scroll-margin:calc(2px);}"];
  [@css ".css-1q1nbf{scroll-margin:calc(3 * 25px);}"];
  [@css ".css-8qpmdm{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css ".css-vufsa3{scroll-margin-block:10px;}"];
  [@css ".css-188wdmb{scroll-margin-block:10px 10px;}"];
  [@css ".css-u5lms2{scroll-margin-block-end:10px;}"];
  [@css ".css-mzcgf9{scroll-margin-block-start:10px;}"];
  [@css ".css-xvm6f4{scroll-margin-bottom:10px;}"];
  [@css ".css-1vw5h1r{scroll-margin-inline:10px;}"];
  [@css ".css-1esaroy{scroll-margin-inline:10px 10px;}"];
  [@css ".css-1l0wkxh{scroll-margin-inline-start:10px;}"];
  [@css ".css-wsdguf{scroll-margin-inline-end:10px;}"];
  [@css ".css-z2dmhj{scroll-margin-left:10px;}"];
  [@css ".css-1nunoo0{scroll-margin-right:10px;}"];
  [@css ".css-1nt4az8{scroll-margin-top:10px;}"];
  [@css ".css-l4z4j0{scroll-padding:auto;}"];
  [@css ".css-1i6n89f{scroll-padding:0px;}"];
  [@css ".css-1ucfgcu{scroll-padding:6px 5px;}"];
  [@css ".css-1jlgzvm{scroll-padding:10px 20px 30px;}"];
  [@css ".css-ems4pk{scroll-padding:10px 20px 30px 40px;}"];
  [@css ".css-wiktil{scroll-padding:10px auto 30px auto;}"];
  [@css ".css-becuwe{scroll-padding:10%;}"];
  [@css ".css-73htvc{scroll-padding:20% 3em 1in 5rem;}"];
  [@css ".css-a9no6f{scroll-padding:calc(2px);}"];
  [@css ".css-137761i{scroll-padding:calc(50%);}"];
  [@css ".css-1chfxpo{scroll-padding:calc(3 * 25px);}"];
  [@css ".css-1av47dt{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css ".css-92qz3i{scroll-padding-block:10px;}"];
  [@css ".css-lyk3hg{scroll-padding-block:50%;}"];
  [@css ".css-151y01g{scroll-padding-block:10px 50%;}"];
  [@css ".css-1hdduu1{scroll-padding-block:50% 50%;}"];
  [@css ".css-xpkemf{scroll-padding-block-end:10px;}"];
  [@css ".css-1rqplv5{scroll-padding-block-end:50%;}"];
  [@css ".css-108gvf2{scroll-padding-block-start:10px;}"];
  [@css ".css-nogron{scroll-padding-block-start:50%;}"];
  [@css ".css-db09pc{scroll-padding-bottom:10px;}"];
  [@css ".css-1aw7owy{scroll-padding-bottom:50%;}"];
  [@css ".css-98n231{scroll-padding-inline:10px;}"];
  [@css ".css-wjwf8x{scroll-padding-inline:50%;}"];
  [@css ".css-jjuznt{scroll-padding-inline:10px 50%;}"];
  [@css ".css-1iu6fal{scroll-padding-inline:50% 50%;}"];
  [@css ".css-iexu8e{scroll-padding-inline-end:10px;}"];
  [@css ".css-x2wuam{scroll-padding-inline-end:50%;}"];
  [@css ".css-b1lfg4{scroll-padding-inline-start:10px;}"];
  [@css ".css-1q66dz{scroll-padding-inline-start:50%;}"];
  [@css ".css-1b00w4l{scroll-padding-left:10px;}"];
  [@css ".css-14z39kd{scroll-padding-left:50%;}"];
  [@css ".css-14jjxm3{scroll-padding-right:10px;}"];
  [@css ".css-t7krr3{scroll-padding-right:50%;}"];
  [@css ".css-wpk5yi{scroll-padding-top:10px;}"];
  [@css ".css-jen8jd{scroll-padding-top:50%;}"];
  [@css ".css-qpx6ue{scroll-snap-align:none;}"];
  [@css ".css-1si7hic{scroll-snap-align:start;}"];
  [@css ".css-1odlcfx{scroll-snap-align:end;}"];
  [@css ".css-s6zkow{scroll-snap-align:center;}"];
  [@css ".css-1mjmx87{scroll-snap-align:none start;}"];
  [@css ".css-10mnx53{scroll-snap-align:end center;}"];
  [@css ".css-t5c5pc{scroll-snap-align:center start;}"];
  [@css ".css-ekkw1h{scroll-snap-align:end none;}"];
  [@css ".css-g20dps{scroll-snap-align:center center;}"];
  [@css ".css-1f56bib{scroll-snap-stop:normal;}"];
  [@css ".css-10xo5g9{scroll-snap-stop:always;}"];
  [@css
    ".css-p02s8z{-webkit-scroll-snap-type:none;-ms-scroll-snap-type:none;scroll-snap-type:none;}"
  ];
  [@css
    ".css-5nn7lr{-webkit-scroll-snap-type:x mandatory;-ms-scroll-snap-type:x mandatory;scroll-snap-type:x mandatory;}"
  ];
  [@css
    ".css-kkx93a{-webkit-scroll-snap-type:y mandatory;-ms-scroll-snap-type:y mandatory;scroll-snap-type:y mandatory;}"
  ];
  [@css
    ".css-1v6428z{-webkit-scroll-snap-type:block mandatory;-ms-scroll-snap-type:block mandatory;scroll-snap-type:block mandatory;}"
  ];
  [@css
    ".css-46d93f{-webkit-scroll-snap-type:inline mandatory;-ms-scroll-snap-type:inline mandatory;scroll-snap-type:inline mandatory;}"
  ];
  [@css
    ".css-1wyyvly{-webkit-scroll-snap-type:both mandatory;-ms-scroll-snap-type:both mandatory;scroll-snap-type:both mandatory;}"
  ];
  [@css
    ".css-s04qql{-webkit-scroll-snap-type:x proximity;-ms-scroll-snap-type:x proximity;scroll-snap-type:x proximity;}"
  ];
  [@css
    ".css-1o2v5oo{-webkit-scroll-snap-type:y proximity;-ms-scroll-snap-type:y proximity;scroll-snap-type:y proximity;}"
  ];
  [@css
    ".css-yqk587{-webkit-scroll-snap-type:block proximity;-ms-scroll-snap-type:block proximity;scroll-snap-type:block proximity;}"
  ];
  [@css
    ".css-c4yryf{-webkit-scroll-snap-type:inline proximity;-ms-scroll-snap-type:inline proximity;scroll-snap-type:inline proximity;}"
  ];
  [@css
    ".css-nib07g{-webkit-scroll-snap-type:both proximity;-ms-scroll-snap-type:both proximity;scroll-snap-type:both proximity;}"
  ];
  [@css.classes
    [
      ("css-83i9mg", 0, "", "input.re", 2, 8, 2, 26),
      ("css-1voi9oa", 1, "", "input.re", 3, 8, 3, 30),
      ("css-1s9yffv", 2, "", "input.re", 4, 8, 4, 37),
      ("css-6bcy26", 3, "", "input.re", 5, 8, 5, 42),
      ("css-bi9vrs", 4, "", "input.re", 6, 8, 6, 40),
      ("css-hzgyfz", 5, "", "input.re", 7, 8, 7, 32),
      ("css-1q1nbf", 6, "", "input.re", 8, 8, 8, 37),
      ("css-8qpmdm", 7, "", "input.re", 9, 8, 9, 62),
      ("css-vufsa3", 8, "", "input.re", 10, 8, 10, 33),
      ("css-188wdmb", 9, "", "input.re", 11, 8, 11, 38),
      ("css-u5lms2", 10, "", "input.re", 12, 8, 12, 37),
      ("css-mzcgf9", 11, "", "input.re", 13, 8, 13, 39),
      ("css-xvm6f4", 12, "", "input.re", 14, 8, 14, 34),
      ("css-1vw5h1r", 13, "", "input.re", 15, 8, 15, 34),
      ("css-1esaroy", 14, "", "input.re", 16, 8, 16, 39),
      ("css-1l0wkxh", 15, "", "input.re", 17, 8, 17, 40),
      ("css-wsdguf", 16, "", "input.re", 18, 8, 18, 38),
      ("css-z2dmhj", 17, "", "input.re", 19, 8, 19, 32),
      ("css-1nunoo0", 18, "", "input.re", 20, 8, 20, 33),
      ("css-1nt4az8", 19, "", "input.re", 21, 8, 21, 31),
      ("css-l4z4j0", 20, "", "input.re", 22, 8, 22, 28),
      ("css-1i6n89f", 21, "", "input.re", 23, 8, 23, 27),
      ("css-1ucfgcu", 22, "", "input.re", 24, 8, 24, 31),
      ("css-1jlgzvm", 23, "", "input.re", 25, 8, 25, 38),
      ("css-ems4pk", 24, "", "input.re", 26, 8, 26, 43),
      ("css-wiktil", 25, "", "input.re", 27, 8, 27, 43),
      ("css-becuwe", 26, "", "input.re", 28, 8, 28, 27),
      ("css-73htvc", 27, "", "input.re", 29, 8, 29, 40),
      ("css-a9no6f", 28, "", "input.re", 30, 8, 30, 33),
      ("css-137761i", 29, "", "input.re", 31, 8, 31, 33),
      ("css-1chfxpo", 30, "", "input.re", 32, 8, 32, 38),
      ("css-1av47dt", 31, "", "input.re", 33, 8, 33, 62),
      ("css-92qz3i", 32, "", "input.re", 34, 8, 34, 34),
      ("css-lyk3hg", 33, "", "input.re", 35, 8, 35, 33),
      ("css-151y01g", 34, "", "input.re", 36, 8, 36, 38),
      ("css-1hdduu1", 35, "", "input.re", 37, 8, 37, 37),
      ("css-xpkemf", 36, "", "input.re", 38, 8, 38, 38),
      ("css-1rqplv5", 37, "", "input.re", 39, 8, 39, 37),
      ("css-108gvf2", 38, "", "input.re", 40, 8, 40, 40),
      ("css-nogron", 39, "", "input.re", 41, 8, 41, 39),
      ("css-db09pc", 40, "", "input.re", 42, 8, 42, 35),
      ("css-1aw7owy", 41, "", "input.re", 43, 8, 43, 34),
      ("css-98n231", 42, "", "input.re", 44, 8, 44, 35),
      ("css-wjwf8x", 43, "", "input.re", 45, 8, 45, 34),
      ("css-jjuznt", 44, "", "input.re", 46, 8, 46, 39),
      ("css-1iu6fal", 45, "", "input.re", 47, 8, 47, 38),
      ("css-iexu8e", 46, "", "input.re", 48, 8, 48, 39),
      ("css-x2wuam", 47, "", "input.re", 49, 8, 49, 38),
      ("css-b1lfg4", 48, "", "input.re", 50, 8, 50, 41),
      ("css-1q66dz", 49, "", "input.re", 51, 8, 51, 40),
      ("css-1b00w4l", 50, "", "input.re", 52, 8, 52, 33),
      ("css-14z39kd", 51, "", "input.re", 53, 8, 53, 32),
      ("css-14jjxm3", 52, "", "input.re", 54, 8, 54, 34),
      ("css-t7krr3", 53, "", "input.re", 55, 8, 55, 33),
      ("css-wpk5yi", 54, "", "input.re", 56, 8, 56, 32),
      ("css-jen8jd", 55, "", "input.re", 57, 8, 57, 31),
      ("css-qpx6ue", 56, "", "input.re", 58, 8, 58, 31),
      ("css-1si7hic", 57, "", "input.re", 59, 8, 59, 32),
      ("css-1odlcfx", 58, "", "input.re", 60, 8, 60, 30),
      ("css-s6zkow", 59, "", "input.re", 61, 8, 61, 33),
      ("css-1mjmx87", 60, "", "input.re", 62, 8, 62, 37),
      ("css-10mnx53", 61, "", "input.re", 63, 8, 63, 37),
      ("css-t5c5pc", 62, "", "input.re", 64, 8, 64, 39),
      ("css-ekkw1h", 63, "", "input.re", 65, 8, 65, 35),
      ("css-g20dps", 64, "", "input.re", 66, 8, 66, 40),
      ("css-1f56bib", 65, "", "input.re", 67, 8, 67, 32),
      ("css-10xo5g9", 66, "", "input.re", 68, 8, 68, 32),
      ("css-p02s8z", 67, "", "input.re", 69, 8, 69, 30),
      ("css-5nn7lr", 68, "", "input.re", 70, 8, 70, 37),
      ("css-kkx93a", 69, "", "input.re", 71, 8, 71, 37),
      ("css-1v6428z", 70, "", "input.re", 72, 8, 72, 41),
      ("css-46d93f", 71, "", "input.re", 73, 8, 73, 42),
      ("css-1wyyvly", 72, "", "input.re", 74, 8, 74, 40),
      ("css-s04qql", 73, "", "input.re", 75, 8, 75, 37),
      ("css-1o2v5oo", 74, "", "input.re", 76, 8, 76, 37),
      ("css-yqk587", 75, "", "input.re", 77, 8, 77, 41),
      ("css-c4yryf", 76, "", "input.re", 78, 8, 78, 42),
      ("css-nib07g", 77, "", "input.re", 79, 8, 79, 40),
    ]
  ];
  
  CSS.make("css-83i9mg", []);
  CSS.make("css-1voi9oa", []);
  CSS.make("css-1s9yffv", []);
  CSS.make("css-6bcy26", []);
  CSS.make("css-bi9vrs", []);
  CSS.make("css-hzgyfz", []);
  CSS.make("css-1q1nbf", []);
  CSS.make("css-8qpmdm", []);
  CSS.make("css-vufsa3", []);
  CSS.make("css-188wdmb", []);
  CSS.make("css-u5lms2", []);
  CSS.make("css-mzcgf9", []);
  CSS.make("css-xvm6f4", []);
  CSS.make("css-1vw5h1r", []);
  CSS.make("css-1esaroy", []);
  CSS.make("css-1l0wkxh", []);
  CSS.make("css-wsdguf", []);
  CSS.make("css-z2dmhj", []);
  CSS.make("css-1nunoo0", []);
  CSS.make("css-1nt4az8", []);
  CSS.make("css-l4z4j0", []);
  CSS.make("css-1i6n89f", []);
  CSS.make("css-1ucfgcu", []);
  CSS.make("css-1jlgzvm", []);
  CSS.make("css-ems4pk", []);
  CSS.make("css-wiktil", []);
  CSS.make("css-becuwe", []);
  CSS.make("css-73htvc", []);
  CSS.make("css-a9no6f", []);
  CSS.make("css-137761i", []);
  CSS.make("css-1chfxpo", []);
  CSS.make("css-1av47dt", []);
  CSS.make("css-92qz3i", []);
  CSS.make("css-lyk3hg", []);
  CSS.make("css-151y01g", []);
  CSS.make("css-1hdduu1", []);
  CSS.make("css-xpkemf", []);
  CSS.make("css-1rqplv5", []);
  CSS.make("css-108gvf2", []);
  CSS.make("css-nogron", []);
  CSS.make("css-db09pc", []);
  CSS.make("css-1aw7owy", []);
  CSS.make("css-98n231", []);
  CSS.make("css-wjwf8x", []);
  CSS.make("css-jjuznt", []);
  CSS.make("css-1iu6fal", []);
  CSS.make("css-iexu8e", []);
  CSS.make("css-x2wuam", []);
  CSS.make("css-b1lfg4", []);
  CSS.make("css-1q66dz", []);
  CSS.make("css-1b00w4l", []);
  CSS.make("css-14z39kd", []);
  CSS.make("css-14jjxm3", []);
  CSS.make("css-t7krr3", []);
  CSS.make("css-wpk5yi", []);
  CSS.make("css-jen8jd", []);
  CSS.make("css-qpx6ue", []);
  CSS.make("css-1si7hic", []);
  CSS.make("css-1odlcfx", []);
  CSS.make("css-s6zkow", []);
  CSS.make("css-1mjmx87", []);
  CSS.make("css-10mnx53", []);
  CSS.make("css-t5c5pc", []);
  CSS.make("css-ekkw1h", []);
  CSS.make("css-g20dps", []);
  CSS.make("css-1f56bib", []);
  CSS.make("css-10xo5g9", []);
  CSS.make("css-p02s8z", []);
  CSS.make("css-5nn7lr", []);
  CSS.make("css-kkx93a", []);
  CSS.make("css-1v6428z", []);
  CSS.make("css-46d93f", []);
  CSS.make("css-1wyyvly", []);
  CSS.make("css-s04qql", []);
  CSS.make("css-1o2v5oo", []);
  CSS.make("css-yqk587", []);
  CSS.make("css-c4yryf", []);
  CSS.make("css-nib07g", []);
