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
  [@css ".a-1dmoiv8{scroll-margin:0px;}"];
  [@css ".a-37qcuf{scroll-margin:6px 5px;}"];
  [@css ".a-1gcxymj{scroll-margin:10px 20px 30px;}"];
  [@css ".a-1uau2fa{scroll-margin:10px 20px 30px 40px;}"];
  [@css ".a-14b13tb{scroll-margin:20px 3em 1in 5rem;}"];
  [@css ".a-1l59mki{scroll-margin:calc(2px);}"];
  [@css ".a-sz3nfx{scroll-margin:calc(3 * 25px);}"];
  [@css ".a-s1600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css ".a-lbu6my{scroll-margin-block:10px;}"];
  [@css ".a-ej4sq4{scroll-margin-block:10px 10px;}"];
  [@css ".a-1n715zm{scroll-margin-block-end:10px;}"];
  [@css ".a-1x04bj5{scroll-margin-block-start:10px;}"];
  [@css ".a-jgvqxc{scroll-margin-bottom:10px;}"];
  [@css ".a-1y612qs{scroll-margin-inline:10px;}"];
  [@css ".a-1l5mvdw{scroll-margin-inline:10px 10px;}"];
  [@css ".a-14fsnad{scroll-margin-inline-start:10px;}"];
  [@css ".a-789xfm{scroll-margin-inline-end:10px;}"];
  [@css ".a-17lfvv1{scroll-margin-left:10px;}"];
  [@css ".a-osla2e{scroll-margin-right:10px;}"];
  [@css ".a-1c0aols{scroll-margin-top:10px;}"];
  [@css ".a-825nxv{scroll-padding:auto;}"];
  [@css ".a-mjhj9v{scroll-padding:0px;}"];
  [@css ".a-15b5af6{scroll-padding:6px 5px;}"];
  [@css ".a-h1ms3y{scroll-padding:10px 20px 30px;}"];
  [@css ".a-a8alk9{scroll-padding:10px 20px 30px 40px;}"];
  [@css ".a-1gl7x4v{scroll-padding:10px auto 30px auto;}"];
  [@css ".a-odywb5{scroll-padding:10%;}"];
  [@css ".a-1a3doub{scroll-padding:20% 3em 1in 5rem;}"];
  [@css ".a-1jaicma{scroll-padding:calc(2px);}"];
  [@css ".a-mps866{scroll-padding:calc(50%);}"];
  [@css ".a-in6ps6{scroll-padding:calc(3 * 25px);}"];
  [@css ".a-1g6m7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css ".a-1d13npc{scroll-padding-block:10px;}"];
  [@css ".a-13l7n61{scroll-padding-block:50%;}"];
  [@css ".a-1cvn72y{scroll-padding-block:10px 50%;}"];
  [@css ".a-1aibmh3{scroll-padding-block:50% 50%;}"];
  [@css ".a-4na4an{scroll-padding-block-end:10px;}"];
  [@css ".a-1i4wq8b{scroll-padding-block-end:50%;}"];
  [@css ".a-ihtyb1{scroll-padding-block-start:10px;}"];
  [@css ".a-vrkly5{scroll-padding-block-start:50%;}"];
  [@css ".a-qh568d{scroll-padding-bottom:10px;}"];
  [@css ".a-tsczmj{scroll-padding-bottom:50%;}"];
  [@css ".a-7dhvee{scroll-padding-inline:10px;}"];
  [@css ".a-196178e{scroll-padding-inline:50%;}"];
  [@css ".a-4qfqw4{scroll-padding-inline:10px 50%;}"];
  [@css ".a-84jitd{scroll-padding-inline:50% 50%;}"];
  [@css ".a-1txxv1o{scroll-padding-inline-end:10px;}"];
  [@css ".a-p4ybsb{scroll-padding-inline-end:50%;}"];
  [@css ".a-17p21xl{scroll-padding-inline-start:10px;}"];
  [@css ".a-1mws74z{scroll-padding-inline-start:50%;}"];
  [@css ".a-1d2mm5y{scroll-padding-left:10px;}"];
  [@css ".a-b6jsh3{scroll-padding-left:50%;}"];
  [@css ".a-c83z1d{scroll-padding-right:10px;}"];
  [@css ".a-1p9pbq8{scroll-padding-right:50%;}"];
  [@css ".a-1ri05tp{scroll-padding-top:10px;}"];
  [@css ".a-1njo8nm{scroll-padding-top:50%;}"];
  [@css ".a-6xhsyj{scroll-snap-align:none;}"];
  [@css ".a-1pgpqsp{scroll-snap-align:start;}"];
  [@css ".a-niic9p{scroll-snap-align:end;}"];
  [@css ".a-alf1ss{scroll-snap-align:center;}"];
  [@css ".a-e0kzni{scroll-snap-align:none start;}"];
  [@css ".a-zivewf{scroll-snap-align:end center;}"];
  [@css ".a-xwgzch{scroll-snap-align:center start;}"];
  [@css ".a-zo5icl{scroll-snap-align:end none;}"];
  [@css ".a-1pbkijw{scroll-snap-align:center center;}"];
  [@css ".a-1ljahur{scroll-snap-stop:normal;}"];
  [@css ".a-tvqcsf{scroll-snap-stop:always;}"];
  [@css
    ".a-17nu1g1{-webkit-scroll-snap-type:none;-ms-scroll-snap-type:none;scroll-snap-type:none;}"
  ];
  [@css
    ".a-1i6igf3{-webkit-scroll-snap-type:x mandatory;-ms-scroll-snap-type:x mandatory;scroll-snap-type:x mandatory;}"
  ];
  [@css
    ".a-sj8bwf{-webkit-scroll-snap-type:y mandatory;-ms-scroll-snap-type:y mandatory;scroll-snap-type:y mandatory;}"
  ];
  [@css
    ".a-b4yx25{-webkit-scroll-snap-type:block mandatory;-ms-scroll-snap-type:block mandatory;scroll-snap-type:block mandatory;}"
  ];
  [@css
    ".a-vwe0h2{-webkit-scroll-snap-type:inline mandatory;-ms-scroll-snap-type:inline mandatory;scroll-snap-type:inline mandatory;}"
  ];
  [@css
    ".a-1262jo5{-webkit-scroll-snap-type:both mandatory;-ms-scroll-snap-type:both mandatory;scroll-snap-type:both mandatory;}"
  ];
  [@css
    ".a-bsl9bg{-webkit-scroll-snap-type:x proximity;-ms-scroll-snap-type:x proximity;scroll-snap-type:x proximity;}"
  ];
  [@css
    ".a-yei18o{-webkit-scroll-snap-type:y proximity;-ms-scroll-snap-type:y proximity;scroll-snap-type:y proximity;}"
  ];
  [@css
    ".a-vjeyk4{-webkit-scroll-snap-type:block proximity;-ms-scroll-snap-type:block proximity;scroll-snap-type:block proximity;}"
  ];
  [@css
    ".a-xxr31t{-webkit-scroll-snap-type:inline proximity;-ms-scroll-snap-type:inline proximity;scroll-snap-type:inline proximity;}"
  ];
  [@css
    ".a-sfvwfl{-webkit-scroll-snap-type:both proximity;-ms-scroll-snap-type:both proximity;scroll-snap-type:both proximity;}"
  ];
  
  CSS.make("a-1dmoiv8", []);
  CSS.make("a-37qcuf", []);
  CSS.make("a-1gcxymj", []);
  CSS.make("a-1uau2fa", []);
  CSS.make("a-14b13tb", []);
  CSS.make("a-1l59mki", []);
  CSS.make("a-sz3nfx", []);
  CSS.make("a-s1600i", []);
  CSS.make("a-lbu6my", []);
  CSS.make("a-ej4sq4", []);
  CSS.make("a-1n715zm", []);
  CSS.make("a-1x04bj5", []);
  CSS.make("a-jgvqxc", []);
  CSS.make("a-1y612qs", []);
  CSS.make("a-1l5mvdw", []);
  CSS.make("a-14fsnad", []);
  CSS.make("a-789xfm", []);
  CSS.make("a-17lfvv1", []);
  CSS.make("a-osla2e", []);
  CSS.make("a-1c0aols", []);
  CSS.make("a-825nxv", []);
  CSS.make("a-mjhj9v", []);
  CSS.make("a-15b5af6", []);
  CSS.make("a-h1ms3y", []);
  CSS.make("a-a8alk9", []);
  CSS.make("a-1gl7x4v", []);
  CSS.make("a-odywb5", []);
  CSS.make("a-1a3doub", []);
  CSS.make("a-1jaicma", []);
  CSS.make("a-mps866", []);
  CSS.make("a-in6ps6", []);
  CSS.make("a-1g6m7if", []);
  CSS.make("a-1d13npc", []);
  CSS.make("a-13l7n61", []);
  CSS.make("a-1cvn72y", []);
  CSS.make("a-1aibmh3", []);
  CSS.make("a-4na4an", []);
  CSS.make("a-1i4wq8b", []);
  CSS.make("a-ihtyb1", []);
  CSS.make("a-vrkly5", []);
  CSS.make("a-qh568d", []);
  CSS.make("a-tsczmj", []);
  CSS.make("a-7dhvee", []);
  CSS.make("a-196178e", []);
  CSS.make("a-4qfqw4", []);
  CSS.make("a-84jitd", []);
  CSS.make("a-1txxv1o", []);
  CSS.make("a-p4ybsb", []);
  CSS.make("a-17p21xl", []);
  CSS.make("a-1mws74z", []);
  CSS.make("a-1d2mm5y", []);
  CSS.make("a-b6jsh3", []);
  CSS.make("a-c83z1d", []);
  CSS.make("a-1p9pbq8", []);
  CSS.make("a-1ri05tp", []);
  CSS.make("a-1njo8nm", []);
  CSS.make("a-6xhsyj", []);
  CSS.make("a-1pgpqsp", []);
  CSS.make("a-niic9p", []);
  CSS.make("a-alf1ss", []);
  CSS.make("a-e0kzni", []);
  CSS.make("a-zivewf", []);
  CSS.make("a-xwgzch", []);
  CSS.make("a-zo5icl", []);
  CSS.make("a-1pbkijw", []);
  CSS.make("a-1ljahur", []);
  CSS.make("a-tvqcsf", []);
  CSS.make("a-17nu1g1", []);
  CSS.make("a-1i6igf3", []);
  CSS.make("a-sj8bwf", []);
  CSS.make("a-b4yx25", []);
  CSS.make("a-vwe0h2", []);
  CSS.make("a-1262jo5", []);
  CSS.make("a-bsl9bg", []);
  CSS.make("a-yei18o", []);
  CSS.make("a-vjeyk4", []);
  CSS.make("a-xxr31t", []);
  CSS.make("a-sfvwfl", []);
