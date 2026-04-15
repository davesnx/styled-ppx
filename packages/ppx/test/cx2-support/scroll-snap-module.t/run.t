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
  [@css ".css-1dmoiv8{scroll-margin:0px;}"];
  [@css ".css-37qcuf{scroll-margin:6px 5px;}"];
  [@css ".css-1gcxymj{scroll-margin:10px 20px 30px;}"];
  [@css ".css-1uau2fa{scroll-margin:10px 20px 30px 40px;}"];
  [@css ".css-14b13tb{scroll-margin:20px 3em 1in 5rem;}"];
  [@css ".css-1l59mki{scroll-margin:calc(2px);}"];
  [@css ".css-sz3nfx{scroll-margin:calc(3 * 25px);}"];
  [@css ".css-s1600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css ".css-lbu6my{scroll-margin-block:10px;}"];
  [@css ".css-ej4sq4{scroll-margin-block:10px 10px;}"];
  [@css ".css-1n715zm{scroll-margin-block-end:10px;}"];
  [@css ".css-1x04bj5{scroll-margin-block-start:10px;}"];
  [@css ".css-jgvqxc{scroll-margin-bottom:10px;}"];
  [@css ".css-1y612qs{scroll-margin-inline:10px;}"];
  [@css ".css-1l5mvdw{scroll-margin-inline:10px 10px;}"];
  [@css ".css-14fsnad{scroll-margin-inline-start:10px;}"];
  [@css ".css-789xfm{scroll-margin-inline-end:10px;}"];
  [@css ".css-17lfvv1{scroll-margin-left:10px;}"];
  [@css ".css-osla2e{scroll-margin-right:10px;}"];
  [@css ".css-1c0aols{scroll-margin-top:10px;}"];
  [@css ".css-825nxv{scroll-padding:auto;}"];
  [@css ".css-mjhj9v{scroll-padding:0px;}"];
  [@css ".css-15b5af6{scroll-padding:6px 5px;}"];
  [@css ".css-h1ms3y{scroll-padding:10px 20px 30px;}"];
  [@css ".css-a8alk9{scroll-padding:10px 20px 30px 40px;}"];
  [@css ".css-1gl7x4v{scroll-padding:10px auto 30px auto;}"];
  [@css ".css-odywb5{scroll-padding:10%;}"];
  [@css ".css-1a3doub{scroll-padding:20% 3em 1in 5rem;}"];
  [@css ".css-1jaicma{scroll-padding:calc(2px);}"];
  [@css ".css-mps866{scroll-padding:calc(50%);}"];
  [@css ".css-in6ps6{scroll-padding:calc(3 * 25px);}"];
  [@css ".css-1g6m7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css ".css-1d13npc{scroll-padding-block:10px;}"];
  [@css ".css-13l7n61{scroll-padding-block:50%;}"];
  [@css ".css-1cvn72y{scroll-padding-block:10px 50%;}"];
  [@css ".css-1aibmh3{scroll-padding-block:50% 50%;}"];
  [@css ".css-4na4an{scroll-padding-block-end:10px;}"];
  [@css ".css-1i4wq8b{scroll-padding-block-end:50%;}"];
  [@css ".css-ihtyb1{scroll-padding-block-start:10px;}"];
  [@css ".css-vrkly5{scroll-padding-block-start:50%;}"];
  [@css ".css-qh568d{scroll-padding-bottom:10px;}"];
  [@css ".css-tsczmj{scroll-padding-bottom:50%;}"];
  [@css ".css-7dhvee{scroll-padding-inline:10px;}"];
  [@css ".css-196178e{scroll-padding-inline:50%;}"];
  [@css ".css-4qfqw4{scroll-padding-inline:10px 50%;}"];
  [@css ".css-84jitd{scroll-padding-inline:50% 50%;}"];
  [@css ".css-1txxv1o{scroll-padding-inline-end:10px;}"];
  [@css ".css-p4ybsb{scroll-padding-inline-end:50%;}"];
  [@css ".css-17p21xl{scroll-padding-inline-start:10px;}"];
  [@css ".css-1mws74z{scroll-padding-inline-start:50%;}"];
  [@css ".css-1d2mm5y{scroll-padding-left:10px;}"];
  [@css ".css-b6jsh3{scroll-padding-left:50%;}"];
  [@css ".css-c83z1d{scroll-padding-right:10px;}"];
  [@css ".css-1p9pbq8{scroll-padding-right:50%;}"];
  [@css ".css-1ri05tp{scroll-padding-top:10px;}"];
  [@css ".css-1njo8nm{scroll-padding-top:50%;}"];
  [@css ".css-6xhsyj{scroll-snap-align:none;}"];
  [@css ".css-1pgpqsp{scroll-snap-align:start;}"];
  [@css ".css-niic9p{scroll-snap-align:end;}"];
  [@css ".css-alf1ss{scroll-snap-align:center;}"];
  [@css ".css-e0kzni{scroll-snap-align:none start;}"];
  [@css ".css-zivewf{scroll-snap-align:end center;}"];
  [@css ".css-xwgzch{scroll-snap-align:center start;}"];
  [@css ".css-zo5icl{scroll-snap-align:end none;}"];
  [@css ".css-1pbkijw{scroll-snap-align:center center;}"];
  [@css ".css-1ljahur{scroll-snap-stop:normal;}"];
  [@css ".css-tvqcsf{scroll-snap-stop:always;}"];
  [@css ".css-17nu1g1{scroll-snap-type:none;}"];
  [@css ".css-1i6igf3{scroll-snap-type:x mandatory;}"];
  [@css ".css-sj8bwf{scroll-snap-type:y mandatory;}"];
  [@css ".css-b4yx25{scroll-snap-type:block mandatory;}"];
  [@css ".css-vwe0h2{scroll-snap-type:inline mandatory;}"];
  [@css ".css-1262jo5{scroll-snap-type:both mandatory;}"];
  [@css ".css-bsl9bg{scroll-snap-type:x proximity;}"];
  [@css ".css-yei18o{scroll-snap-type:y proximity;}"];
  [@css ".css-vjeyk4{scroll-snap-type:block proximity;}"];
  [@css ".css-xxr31t{scroll-snap-type:inline proximity;}"];
  [@css ".css-sfvwfl{scroll-snap-type:both proximity;}"];
  
  CSS.make("css-1dmoiv8", []);
  CSS.make("css-37qcuf", []);
  CSS.make("css-1gcxymj", []);
  CSS.make("css-1uau2fa", []);
  CSS.make("css-14b13tb", []);
  CSS.make("css-1l59mki", []);
  CSS.make("css-sz3nfx", []);
  CSS.make("css-s1600i", []);
  CSS.make("css-lbu6my", []);
  CSS.make("css-ej4sq4", []);
  CSS.make("css-1n715zm", []);
  CSS.make("css-1x04bj5", []);
  CSS.make("css-jgvqxc", []);
  CSS.make("css-1y612qs", []);
  CSS.make("css-1l5mvdw", []);
  CSS.make("css-14fsnad", []);
  CSS.make("css-789xfm", []);
  CSS.make("css-17lfvv1", []);
  CSS.make("css-osla2e", []);
  CSS.make("css-1c0aols", []);
  CSS.make("css-825nxv", []);
  CSS.make("css-mjhj9v", []);
  CSS.make("css-15b5af6", []);
  CSS.make("css-h1ms3y", []);
  CSS.make("css-a8alk9", []);
  CSS.make("css-1gl7x4v", []);
  CSS.make("css-odywb5", []);
  CSS.make("css-1a3doub", []);
  CSS.make("css-1jaicma", []);
  CSS.make("css-mps866", []);
  CSS.make("css-in6ps6", []);
  CSS.make("css-1g6m7if", []);
  CSS.make("css-1d13npc", []);
  CSS.make("css-13l7n61", []);
  CSS.make("css-1cvn72y", []);
  CSS.make("css-1aibmh3", []);
  CSS.make("css-4na4an", []);
  CSS.make("css-1i4wq8b", []);
  CSS.make("css-ihtyb1", []);
  CSS.make("css-vrkly5", []);
  CSS.make("css-qh568d", []);
  CSS.make("css-tsczmj", []);
  CSS.make("css-7dhvee", []);
  CSS.make("css-196178e", []);
  CSS.make("css-4qfqw4", []);
  CSS.make("css-84jitd", []);
  CSS.make("css-1txxv1o", []);
  CSS.make("css-p4ybsb", []);
  CSS.make("css-17p21xl", []);
  CSS.make("css-1mws74z", []);
  CSS.make("css-1d2mm5y", []);
  CSS.make("css-b6jsh3", []);
  CSS.make("css-c83z1d", []);
  CSS.make("css-1p9pbq8", []);
  CSS.make("css-1ri05tp", []);
  CSS.make("css-1njo8nm", []);
  CSS.make("css-6xhsyj", []);
  CSS.make("css-1pgpqsp", []);
  CSS.make("css-niic9p", []);
  CSS.make("css-alf1ss", []);
  CSS.make("css-e0kzni", []);
  CSS.make("css-zivewf", []);
  CSS.make("css-xwgzch", []);
  CSS.make("css-zo5icl", []);
  CSS.make("css-1pbkijw", []);
  CSS.make("css-1ljahur", []);
  CSS.make("css-tvqcsf", []);
  CSS.make("css-17nu1g1", []);
  CSS.make("css-1i6igf3", []);
  CSS.make("css-sj8bwf", []);
  CSS.make("css-b4yx25", []);
  CSS.make("css-vwe0h2", []);
  CSS.make("css-1262jo5", []);
  CSS.make("css-bsl9bg", []);
  CSS.make("css-yei18o", []);
  CSS.make("css-vjeyk4", []);
  CSS.make("css-xxr31t", []);
  CSS.make("css-sfvwfl", []);
