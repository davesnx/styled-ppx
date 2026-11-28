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
  [@css ".css-ivpc9mg{scroll-margin:0px;}"];
  [@css ".css-ivpc9oa{scroll-margin:6px 5px;}"];
  [@css ".css-ivpcffv{scroll-margin:10px 20px 30px;}"];
  [@css ".css-ivpcy26{scroll-margin:10px 20px 30px 40px;}"];
  [@css ".css-ivpcvrs{scroll-margin:20px 3em 1in 5rem;}"];
  [@css ".css-ivpcyfz{scroll-margin:calc(2px);}"];
  [@css ".css-ivpcnbf{scroll-margin:calc(3 * 25px);}"];
  [@css ".css-ivpcmdm{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css ".css-ivpcsa3{scroll-margin-block:10px;}"];
  [@css ".css-ivpcdmb{scroll-margin-block:10px 10px;}"];
  [@css ".css-ivpcms2{scroll-margin-block-end:10px;}"];
  [@css ".css-ivpcgf9{scroll-margin-block-start:10px;}"];
  [@css ".css-ivpc6f4{scroll-margin-bottom:10px;}"];
  [@css ".css-ivpch1r{scroll-margin-inline:10px;}"];
  [@css ".css-ivpcroy{scroll-margin-inline:10px 10px;}"];
  [@css ".css-ivpckxh{scroll-margin-inline-start:10px;}"];
  [@css ".css-ivpcguf{scroll-margin-inline-end:10px;}"];
  [@css ".css-ivpcmhj{scroll-margin-left:10px;}"];
  [@css ".css-ivpcoo0{scroll-margin-right:10px;}"];
  [@css ".css-ivpcaz8{scroll-margin-top:10px;}"];
  [@css ".css-ivpc4j0{scroll-padding:auto;}"];
  [@css ".css-ivpc89f{scroll-padding:0px;}"];
  [@css ".css-ivpcgcu{scroll-padding:6px 5px;}"];
  [@css ".css-ivpczvm{scroll-padding:10px 20px 30px;}"];
  [@css ".css-ivpc4pk{scroll-padding:10px 20px 30px 40px;}"];
  [@css ".css-ivpctil{scroll-padding:10px auto 30px auto;}"];
  [@css ".css-ivpcuwe{scroll-padding:10%;}"];
  [@css ".css-ivpctvc{scroll-padding:20% 3em 1in 5rem;}"];
  [@css ".css-ivpco6f{scroll-padding:calc(2px);}"];
  [@css ".css-ivpc61i{scroll-padding:calc(50%);}"];
  [@css ".css-ivpcxpo{scroll-padding:calc(3 * 25px);}"];
  [@css ".css-ivpc7dt{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css ".css-ivpcz3i{scroll-padding-block:10px;}"];
  [@css ".css-ivpc3hg{scroll-padding-block:50%;}"];
  [@css ".css-ivpc01g{scroll-padding-block:10px 50%;}"];
  [@css ".css-ivpcuu1{scroll-padding-block:50% 50%;}"];
  [@css ".css-ivpcemf{scroll-padding-block-end:10px;}"];
  [@css ".css-ivpclv5{scroll-padding-block-end:50%;}"];
  [@css ".css-ivpcvf2{scroll-padding-block-start:10px;}"];
  [@css ".css-ivpcron{scroll-padding-block-start:50%;}"];
  [@css ".css-ivpc9pc{scroll-padding-bottom:10px;}"];
  [@css ".css-ivpcowy{scroll-padding-bottom:50%;}"];
  [@css ".css-ivpc231{scroll-padding-inline:10px;}"];
  [@css ".css-ivpcf8x{scroll-padding-inline:50%;}"];
  [@css ".css-ivpcznt{scroll-padding-inline:10px 50%;}"];
  [@css ".css-ivpcfal{scroll-padding-inline:50% 50%;}"];
  [@css ".css-ivpcu8e{scroll-padding-inline-end:10px;}"];
  [@css ".css-ivpcuam{scroll-padding-inline-end:50%;}"];
  [@css ".css-ivpcfg4{scroll-padding-inline-start:10px;}"];
  [@css ".css-ivpc6dz{scroll-padding-inline-start:50%;}"];
  [@css ".css-ivpcw4l{scroll-padding-left:10px;}"];
  [@css ".css-ivpc9kd{scroll-padding-left:50%;}"];
  [@css ".css-ivpcxm3{scroll-padding-right:10px;}"];
  [@css ".css-ivpcrr3{scroll-padding-right:50%;}"];
  [@css ".css-ivpc5yi{scroll-padding-top:10px;}"];
  [@css ".css-ivpc8jd{scroll-padding-top:50%;}"];
  [@css ".css-ivpc6ue{scroll-snap-align:none;}"];
  [@css ".css-ivpchic{scroll-snap-align:start;}"];
  [@css ".css-ivpccfx{scroll-snap-align:end;}"];
  [@css ".css-ivpckow{scroll-snap-align:center;}"];
  [@css ".css-ivpcx87{scroll-snap-align:none start;}"];
  [@css ".css-ivpcx53{scroll-snap-align:end center;}"];
  [@css ".css-ivpc5pc{scroll-snap-align:center start;}"];
  [@css ".css-ivpcw1h{scroll-snap-align:end none;}"];
  [@css ".css-ivpcdps{scroll-snap-align:center center;}"];
  [@css ".css-ivpcbib{scroll-snap-stop:normal;}"];
  [@css ".css-ivpc5g9{scroll-snap-stop:always;}"];
  [@css
    ".css-ivpcs8z{-webkit-scroll-snap-type:none;-ms-scroll-snap-type:none;scroll-snap-type:none;}"
  ];
  [@css
    ".css-ivpc7lr{-webkit-scroll-snap-type:x mandatory;-ms-scroll-snap-type:x mandatory;scroll-snap-type:x mandatory;}"
  ];
  [@css
    ".css-ivpc93a{-webkit-scroll-snap-type:y mandatory;-ms-scroll-snap-type:y mandatory;scroll-snap-type:y mandatory;}"
  ];
  [@css
    ".css-ivpc28z{-webkit-scroll-snap-type:block mandatory;-ms-scroll-snap-type:block mandatory;scroll-snap-type:block mandatory;}"
  ];
  [@css
    ".css-ivpc93f{-webkit-scroll-snap-type:inline mandatory;-ms-scroll-snap-type:inline mandatory;scroll-snap-type:inline mandatory;}"
  ];
  [@css
    ".css-ivpcvly{-webkit-scroll-snap-type:both mandatory;-ms-scroll-snap-type:both mandatory;scroll-snap-type:both mandatory;}"
  ];
  [@css
    ".css-ivpcqql{-webkit-scroll-snap-type:x proximity;-ms-scroll-snap-type:x proximity;scroll-snap-type:x proximity;}"
  ];
  [@css
    ".css-ivpc5oo{-webkit-scroll-snap-type:y proximity;-ms-scroll-snap-type:y proximity;scroll-snap-type:y proximity;}"
  ];
  [@css
    ".css-ivpc587{-webkit-scroll-snap-type:block proximity;-ms-scroll-snap-type:block proximity;scroll-snap-type:block proximity;}"
  ];
  [@css
    ".css-ivpcryf{-webkit-scroll-snap-type:inline proximity;-ms-scroll-snap-type:inline proximity;scroll-snap-type:inline proximity;}"
  ];
  [@css
    ".css-ivpc07g{-webkit-scroll-snap-type:both proximity;-ms-scroll-snap-type:both proximity;scroll-snap-type:both proximity;}"
  ];
  [@css.classes
    [
      ("css-ivpc9mg", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ivpc9oa", 1, "", "input.re", 3, 8, 3, 30),
      ("css-ivpcffv", 2, "", "input.re", 4, 8, 4, 37),
      ("css-ivpcy26", 3, "", "input.re", 5, 8, 5, 42),
      ("css-ivpcvrs", 4, "", "input.re", 6, 8, 6, 40),
      ("css-ivpcyfz", 5, "", "input.re", 7, 8, 7, 32),
      ("css-ivpcnbf", 6, "", "input.re", 8, 8, 8, 37),
      ("css-ivpcmdm", 7, "", "input.re", 9, 8, 9, 62),
      ("css-ivpcsa3", 8, "", "input.re", 10, 8, 10, 33),
      ("css-ivpcdmb", 9, "", "input.re", 11, 8, 11, 38),
      ("css-ivpcms2", 10, "", "input.re", 12, 8, 12, 37),
      ("css-ivpcgf9", 11, "", "input.re", 13, 8, 13, 39),
      ("css-ivpc6f4", 12, "", "input.re", 14, 8, 14, 34),
      ("css-ivpch1r", 13, "", "input.re", 15, 8, 15, 34),
      ("css-ivpcroy", 14, "", "input.re", 16, 8, 16, 39),
      ("css-ivpckxh", 15, "", "input.re", 17, 8, 17, 40),
      ("css-ivpcguf", 16, "", "input.re", 18, 8, 18, 38),
      ("css-ivpcmhj", 17, "", "input.re", 19, 8, 19, 32),
      ("css-ivpcoo0", 18, "", "input.re", 20, 8, 20, 33),
      ("css-ivpcaz8", 19, "", "input.re", 21, 8, 21, 31),
      ("css-ivpc4j0", 20, "", "input.re", 22, 8, 22, 28),
      ("css-ivpc89f", 21, "", "input.re", 23, 8, 23, 27),
      ("css-ivpcgcu", 22, "", "input.re", 24, 8, 24, 31),
      ("css-ivpczvm", 23, "", "input.re", 25, 8, 25, 38),
      ("css-ivpc4pk", 24, "", "input.re", 26, 8, 26, 43),
      ("css-ivpctil", 25, "", "input.re", 27, 8, 27, 43),
      ("css-ivpcuwe", 26, "", "input.re", 28, 8, 28, 27),
      ("css-ivpctvc", 27, "", "input.re", 29, 8, 29, 40),
      ("css-ivpco6f", 28, "", "input.re", 30, 8, 30, 33),
      ("css-ivpc61i", 29, "", "input.re", 31, 8, 31, 33),
      ("css-ivpcxpo", 30, "", "input.re", 32, 8, 32, 38),
      ("css-ivpc7dt", 31, "", "input.re", 33, 8, 33, 62),
      ("css-ivpcz3i", 32, "", "input.re", 34, 8, 34, 34),
      ("css-ivpc3hg", 33, "", "input.re", 35, 8, 35, 33),
      ("css-ivpc01g", 34, "", "input.re", 36, 8, 36, 38),
      ("css-ivpcuu1", 35, "", "input.re", 37, 8, 37, 37),
      ("css-ivpcemf", 36, "", "input.re", 38, 8, 38, 38),
      ("css-ivpclv5", 37, "", "input.re", 39, 8, 39, 37),
      ("css-ivpcvf2", 38, "", "input.re", 40, 8, 40, 40),
      ("css-ivpcron", 39, "", "input.re", 41, 8, 41, 39),
      ("css-ivpc9pc", 40, "", "input.re", 42, 8, 42, 35),
      ("css-ivpcowy", 41, "", "input.re", 43, 8, 43, 34),
      ("css-ivpc231", 42, "", "input.re", 44, 8, 44, 35),
      ("css-ivpcf8x", 43, "", "input.re", 45, 8, 45, 34),
      ("css-ivpcznt", 44, "", "input.re", 46, 8, 46, 39),
      ("css-ivpcfal", 45, "", "input.re", 47, 8, 47, 38),
      ("css-ivpcu8e", 46, "", "input.re", 48, 8, 48, 39),
      ("css-ivpcuam", 47, "", "input.re", 49, 8, 49, 38),
      ("css-ivpcfg4", 48, "", "input.re", 50, 8, 50, 41),
      ("css-ivpc6dz", 49, "", "input.re", 51, 8, 51, 40),
      ("css-ivpcw4l", 50, "", "input.re", 52, 8, 52, 33),
      ("css-ivpc9kd", 51, "", "input.re", 53, 8, 53, 32),
      ("css-ivpcxm3", 52, "", "input.re", 54, 8, 54, 34),
      ("css-ivpcrr3", 53, "", "input.re", 55, 8, 55, 33),
      ("css-ivpc5yi", 54, "", "input.re", 56, 8, 56, 32),
      ("css-ivpc8jd", 55, "", "input.re", 57, 8, 57, 31),
      ("css-ivpc6ue", 56, "", "input.re", 58, 8, 58, 31),
      ("css-ivpchic", 57, "", "input.re", 59, 8, 59, 32),
      ("css-ivpccfx", 58, "", "input.re", 60, 8, 60, 30),
      ("css-ivpckow", 59, "", "input.re", 61, 8, 61, 33),
      ("css-ivpcx87", 60, "", "input.re", 62, 8, 62, 37),
      ("css-ivpcx53", 61, "", "input.re", 63, 8, 63, 37),
      ("css-ivpc5pc", 62, "", "input.re", 64, 8, 64, 39),
      ("css-ivpcw1h", 63, "", "input.re", 65, 8, 65, 35),
      ("css-ivpcdps", 64, "", "input.re", 66, 8, 66, 40),
      ("css-ivpcbib", 65, "", "input.re", 67, 8, 67, 32),
      ("css-ivpc5g9", 66, "", "input.re", 68, 8, 68, 32),
      ("css-ivpcs8z", 67, "", "input.re", 69, 8, 69, 30),
      ("css-ivpc7lr", 68, "", "input.re", 70, 8, 70, 37),
      ("css-ivpc93a", 69, "", "input.re", 71, 8, 71, 37),
      ("css-ivpc28z", 70, "", "input.re", 72, 8, 72, 41),
      ("css-ivpc93f", 71, "", "input.re", 73, 8, 73, 42),
      ("css-ivpcvly", 72, "", "input.re", 74, 8, 74, 40),
      ("css-ivpcqql", 73, "", "input.re", 75, 8, 75, 37),
      ("css-ivpc5oo", 74, "", "input.re", 76, 8, 76, 37),
      ("css-ivpc587", 75, "", "input.re", 77, 8, 77, 41),
      ("css-ivpcryf", 76, "", "input.re", 78, 8, 78, 42),
      ("css-ivpc07g", 77, "", "input.re", 79, 8, 79, 40),
    ]
  ];
  
  CSS.make("css-ivpc9mg", []);
  CSS.make("css-ivpc9oa", []);
  CSS.make("css-ivpcffv", []);
  CSS.make("css-ivpcy26", []);
  CSS.make("css-ivpcvrs", []);
  CSS.make("css-ivpcyfz", []);
  CSS.make("css-ivpcnbf", []);
  CSS.make("css-ivpcmdm", []);
  CSS.make("css-ivpcsa3", []);
  CSS.make("css-ivpcdmb", []);
  CSS.make("css-ivpcms2", []);
  CSS.make("css-ivpcgf9", []);
  CSS.make("css-ivpc6f4", []);
  CSS.make("css-ivpch1r", []);
  CSS.make("css-ivpcroy", []);
  CSS.make("css-ivpckxh", []);
  CSS.make("css-ivpcguf", []);
  CSS.make("css-ivpcmhj", []);
  CSS.make("css-ivpcoo0", []);
  CSS.make("css-ivpcaz8", []);
  CSS.make("css-ivpc4j0", []);
  CSS.make("css-ivpc89f", []);
  CSS.make("css-ivpcgcu", []);
  CSS.make("css-ivpczvm", []);
  CSS.make("css-ivpc4pk", []);
  CSS.make("css-ivpctil", []);
  CSS.make("css-ivpcuwe", []);
  CSS.make("css-ivpctvc", []);
  CSS.make("css-ivpco6f", []);
  CSS.make("css-ivpc61i", []);
  CSS.make("css-ivpcxpo", []);
  CSS.make("css-ivpc7dt", []);
  CSS.make("css-ivpcz3i", []);
  CSS.make("css-ivpc3hg", []);
  CSS.make("css-ivpc01g", []);
  CSS.make("css-ivpcuu1", []);
  CSS.make("css-ivpcemf", []);
  CSS.make("css-ivpclv5", []);
  CSS.make("css-ivpcvf2", []);
  CSS.make("css-ivpcron", []);
  CSS.make("css-ivpc9pc", []);
  CSS.make("css-ivpcowy", []);
  CSS.make("css-ivpc231", []);
  CSS.make("css-ivpcf8x", []);
  CSS.make("css-ivpcznt", []);
  CSS.make("css-ivpcfal", []);
  CSS.make("css-ivpcu8e", []);
  CSS.make("css-ivpcuam", []);
  CSS.make("css-ivpcfg4", []);
  CSS.make("css-ivpc6dz", []);
  CSS.make("css-ivpcw4l", []);
  CSS.make("css-ivpc9kd", []);
  CSS.make("css-ivpcxm3", []);
  CSS.make("css-ivpcrr3", []);
  CSS.make("css-ivpc5yi", []);
  CSS.make("css-ivpc8jd", []);
  CSS.make("css-ivpc6ue", []);
  CSS.make("css-ivpchic", []);
  CSS.make("css-ivpccfx", []);
  CSS.make("css-ivpckow", []);
  CSS.make("css-ivpcx87", []);
  CSS.make("css-ivpcx53", []);
  CSS.make("css-ivpc5pc", []);
  CSS.make("css-ivpcw1h", []);
  CSS.make("css-ivpcdps", []);
  CSS.make("css-ivpcbib", []);
  CSS.make("css-ivpc5g9", []);
  CSS.make("css-ivpcs8z", []);
  CSS.make("css-ivpc7lr", []);
  CSS.make("css-ivpc93a", []);
  CSS.make("css-ivpc28z", []);
  CSS.make("css-ivpc93f", []);
  CSS.make("css-ivpcvly", []);
  CSS.make("css-ivpcqql", []);
  CSS.make("css-ivpc5oo", []);
  CSS.make("css-ivpc587", []);
  CSS.make("css-ivpcryf", []);
  CSS.make("css-ivpc07g", []);
