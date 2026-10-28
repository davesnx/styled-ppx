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
    (
      "._a_4ccpnl{-webkit-clip-path:url(\"#clip\");clip-path:url(\"#clip\");}",
      "_a_4ccpnl",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4cdshe{-webkit-clip-path:inset(50%);clip-path:inset(50%);}",
      "_a_4cdshe",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4clbca{-webkit-clip-path:path(\"M 20 20 H 80 V 30\");clip-path:path(\"M 20 20 H 80 V 30\");}",
      "_a_4clbca",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4c8b54{-webkit-clip-path:polygon(50% 100%, 0 0, 100% 0);clip-path:polygon(50% 100%, 0 0, 100% 0);}",
      "_a_4c8b54",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4cyasd{-webkit-clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}",
      "_a_4cyasd",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4cz3kz{-webkit-clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}",
      "_a_4cz3kz",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4cq8iu{-webkit-clip-path:border-box;clip-path:border-box;}",
      "_a_4cq8iu",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4civbf{-webkit-clip-path:padding-box;clip-path:padding-box;}",
      "_a_4civbf",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4c4dpx{-webkit-clip-path:content-box;clip-path:content-box;}",
      "_a_4c4dpx",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4c8q0p{-webkit-clip-path:margin-box;clip-path:margin-box;}",
      "_a_4c8q0p",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4c3bw4{-webkit-clip-path:fill-box;clip-path:fill-box;}",
      "_a_4c3bw4",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4cww8a{-webkit-clip-path:stroke-box;clip-path:stroke-box;}",
      "_a_4cww8a",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4civni{-webkit-clip-path:view-box;clip-path:view-box;}",
      "_a_4civni",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4caqcy{-webkit-clip-path:none;clip-path:none;}",
      "_a_4caqcy",
      "0,1,0 own",
      "156",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4dszcd{clip-rule:nonzero;}",
      "_a_4dszcd",
      "0,1,0 own",
      "157",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4d6lnx{clip-rule:evenodd;}",
      "_a_4d6lnx",
      "0,1,0 own",
      "157",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7y0074lv46{-webkit-mask-image:none;mask-image:none;}",
      "_a_7y0074lv46",
      "0,1,0 own",
      "286",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_7y0074xpd6{-webkit-mask-image:linear-gradient(45deg, #333, #000);mask-image:linear-gradient(45deg, #333, #000);}",
      "_a_7y0074xpd6",
      "0,1,0 own",
      "286",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_7y0074laft{-webkit-mask-image:url(\"image.png\");mask-image:url(\"image.png\");}",
      "_a_7y0074laft",
      "0,1,0 own",
      "286",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_7y00e8dp5t{mask-mode:alpha;}",
      "_a_7y00e8dp5t",
      "0,1,0 own",
      "286",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_7y00e8htsi{mask-mode:luminance;}",
      "_a_7y00e8htsi",
      "0,1,0 own",
      "286",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_7y00e8qdqk{mask-mode:match-source;}",
      "_a_7y00e8qdqk",
      "0,1,0 own",
      "286",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_7y035skdr1{-webkit-mask-repeat:repeat-x;mask-repeat:repeat-x;}",
      "_a_7y035skdr1",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s0g9h{-webkit-mask-repeat:repeat-y;mask-repeat:repeat-y;}",
      "_a_7y035s0g9h",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s0wgz{-webkit-mask-repeat:repeat;mask-repeat:repeat;}",
      "_a_7y035s0wgz",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sbi8s{-webkit-mask-repeat:space;mask-repeat:space;}",
      "_a_7y035sbi8s",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s20fn{-webkit-mask-repeat:round;mask-repeat:round;}",
      "_a_7y035s20fn",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sawfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}",
      "_a_7y035sawfw",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035ssx21{-webkit-mask-repeat:repeat repeat;mask-repeat:repeat repeat;}",
      "_a_7y035ssx21",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s0fa9{-webkit-mask-repeat:space repeat;mask-repeat:space repeat;}",
      "_a_7y035s0fa9",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sjxaa{-webkit-mask-repeat:round repeat;mask-repeat:round repeat;}",
      "_a_7y035sjxaa",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s3pxt{-webkit-mask-repeat:no-repeat repeat;mask-repeat:no-repeat repeat;}",
      "_a_7y035s3pxt",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sn6bx{-webkit-mask-repeat:repeat space;mask-repeat:repeat space;}",
      "_a_7y035sn6bx",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sudfe{-webkit-mask-repeat:space space;mask-repeat:space space;}",
      "_a_7y035sudfe",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s6z3w{-webkit-mask-repeat:round space;mask-repeat:round space;}",
      "_a_7y035s6z3w",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035spthf{-webkit-mask-repeat:no-repeat space;mask-repeat:no-repeat space;}",
      "_a_7y035spthf",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s8b1s{-webkit-mask-repeat:repeat round;mask-repeat:repeat round;}",
      "_a_7y035s8b1s",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s6dy3{-webkit-mask-repeat:space round;mask-repeat:space round;}",
      "_a_7y035s6dy3",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s035m{-webkit-mask-repeat:round round;mask-repeat:round round;}",
      "_a_7y035s035m",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035s1vap{-webkit-mask-repeat:no-repeat round;mask-repeat:no-repeat round;}",
      "_a_7y035s1vap",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035spu1u{-webkit-mask-repeat:repeat no-repeat;mask-repeat:repeat no-repeat;}",
      "_a_7y035spu1u",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sa087{-webkit-mask-repeat:space no-repeat;mask-repeat:space no-repeat;}",
      "_a_7y035sa087",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035st6kf{-webkit-mask-repeat:round no-repeat;mask-repeat:round no-repeat;}",
      "_a_7y035st6kf",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sbql5{-webkit-mask-repeat:no-repeat no-repeat;mask-repeat:no-repeat no-repeat;}",
      "_a_7y035sbql5",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kw9y42{-webkit-mask-position:center;mask-position:center;}",
      "_a_7y01kw9y42",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kwck5z{-webkit-mask-position:center center;mask-position:center center;}",
      "_a_7y01kwck5z",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kwqk76{-webkit-mask-position:left 50%;mask-position:left 50%;}",
      "_a_7y01kwqk76",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kwm1vo{-webkit-mask-position:bottom 10px right 20px;mask-position:bottom 10px right 20px;}",
      "_a_7y01kwm1vo",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kw2gp6{-webkit-mask-position:1rem 1rem, center;mask-position:1rem 1rem, center;}",
      "_a_7y01kw2gp6",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y001sj5or{-webkit-mask-clip:border-box;mask-clip:border-box;}",
      "_a_7y001sj5or",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001s1q3a{-webkit-mask-clip:padding-box;mask-clip:padding-box;}",
      "_a_7y001s1q3a",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001sv6ku{-webkit-mask-clip:content-box;mask-clip:content-box;}",
      "_a_7y001sv6ku",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001s597p{-webkit-mask-clip:margin-box;mask-clip:margin-box;}",
      "_a_7y001s597p",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001say14{-webkit-mask-clip:fill-box;mask-clip:fill-box;}",
      "_a_7y001say14",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001sj1e5{-webkit-mask-clip:stroke-box;mask-clip:stroke-box;}",
      "_a_7y001sj1e5",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001siy1a{-webkit-mask-clip:view-box;mask-clip:view-box;}",
      "_a_7y001siy1a",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y001sc5vo{-webkit-mask-clip:no-clip;mask-clip:no-clip;}",
      "_a_7y001sc5vo",
      "0,1,0 own",
      "286",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sgjmd7{-webkit-mask-origin:border-box;mask-origin:border-box;}",
      "_a_7y00sgjmd7",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sg0f4k{-webkit-mask-origin:padding-box;mask-origin:padding-box;}",
      "_a_7y00sg0f4k",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sgh4gk{-webkit-mask-origin:content-box;mask-origin:content-box;}",
      "_a_7y00sgh4gk",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sg7k5t{-webkit-mask-origin:margin-box;mask-origin:margin-box;}",
      "_a_7y00sg7k5t",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sge45n{-webkit-mask-origin:fill-box;mask-origin:fill-box;}",
      "_a_7y00sge45n",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sg6p58{-webkit-mask-origin:stroke-box;mask-origin:stroke-box;}",
      "_a_7y00sg6p58",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y00sg3jkb{-webkit-mask-origin:view-box;mask-origin:view-box;}",
      "_a_7y00sg3jkb",
      "0,1,0 own",
      "286",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bkqgoj{-webkit-mask-size:auto;mask-size:auto;}",
      "_a_7y06bkqgoj",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bkahf4{-webkit-mask-size:10px;mask-size:10px;}",
      "_a_7y06bkahf4",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bkhzm2{-webkit-mask-size:cover;mask-size:cover;}",
      "_a_7y06bkhzm2",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bknp7r{-webkit-mask-size:contain;mask-size:contain;}",
      "_a_7y06bknp7r",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bk0jbb{-webkit-mask-size:50%;mask-size:50%;}",
      "_a_7y06bk0jbb",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bk3cq7{-webkit-mask-size:10px auto;mask-size:10px auto;}",
      "_a_7y06bk3cq7",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bkieio{-webkit-mask-size:auto 10%;mask-size:auto 10%;}",
      "_a_7y06bkieio",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y06bk41vb{-webkit-mask-size:50em 50%;mask-size:50em 50%;}",
      "_a_7y06bk41vb",
      "0,1,0 own",
      "286",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_7y003ktv7g{mask-composite:add;}",
      "_a_7y003ktv7g",
      "0,1,0 own",
      "286",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_7y003k75he{mask-composite:subtract;}",
      "_a_7y003k75he",
      "0,1,0 own",
      "286",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_7y003khvhq{mask-composite:intersect;}",
      "_a_7y003khvhq",
      "0,1,0 own",
      "286",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_7y003k57xj{mask-composite:exclude;}",
      "_a_7y003k57xj",
      "0,1,0 own",
      "286",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_7yf6ef{-webkit-mask:top;mask:top;}",
      "_a_7yf6ef",
      "0,1,0 own",
      "286",
      16383,
      false,
    )
  ];
  [@css
    (
      "._a_7yyoaq{-webkit-mask:space;mask:space;}",
      "_a_7yyoaq",
      "0,1,0 own",
      "286",
      16383,
      false,
    )
  ];
  [@css
    (
      "._a_7yk999{-webkit-mask:url(\"image.png\");mask:url(\"image.png\");}",
      "_a_7yk999",
      "0,1,0 own",
      "286",
      16383,
      false,
    )
  ];
  [@css
    (
      "._a_7y1dmg{-webkit-mask:url(\"image.png\") luminance;mask:url(\"image.png\") luminance;}",
      "_a_7y1dmg",
      "0,1,0 own",
      "286",
      16383,
      false,
    )
  ];
  [@css
    (
      "._a_7y80ky{-webkit-mask:url(\"image.png\") luminance top space;mask:url(\"image.png\") luminance top space;}",
      "_a_7y80ky",
      "0,1,0 own",
      "286",
      16383,
      false,
    )
  ];
  [@css
    (
      "._a_7y000gi8us{mask-border-source:none;}",
      "_a_7y000gi8us",
      "0,1,0 own",
      "286",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_7y000g7msv{mask-border-source:url(\"image.png\");}",
      "_a_7y000g7msv",
      "0,1,0 own",
      "286",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_7y00088jwz{mask-border-slice:0 fill;}",
      "_a_7y00088jwz",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y00083qse{mask-border-slice:50% fill;}",
      "_a_7y00083qse",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y0008wqe0{mask-border-slice:1.1 fill;}",
      "_a_7y0008wqe0",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y0008tc58{mask-border-slice:0 1 fill;}",
      "_a_7y0008tc58",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y0008t8yr{mask-border-slice:0 1 2 fill;}",
      "_a_7y0008t8yr",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y0008rxuj{mask-border-slice:0 1 2 3 fill;}",
      "_a_7y0008rxuj",
      "0,1,0 own",
      "286",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y000wnwbq{mask-border-width:auto;}",
      "_a_7y000wnwbq",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000wnkum{mask-border-width:10px;}",
      "_a_7y000wnkum",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000w340c{mask-border-width:50%;}",
      "_a_7y000w340c",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000wquap{mask-border-width:1;}",
      "_a_7y000wquap",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000wwtrw{mask-border-width:auto 1;}",
      "_a_7y000wwtrw",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000w4i71{mask-border-width:auto 1 50%;}",
      "_a_7y000w4i71",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y000ww63w{mask-border-width:auto 1 50% 1.1;}",
      "_a_7y000ww63w",
      "0,1,0 own",
      "286",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_7y0002btf2{mask-border-outset:0;}",
      "_a_7y0002btf2",
      "0,1,0 own",
      "286",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0002fzm0{mask-border-outset:1.1;}",
      "_a_7y0002fzm0",
      "0,1,0 own",
      "286",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0002h5pa{mask-border-outset:0 1;}",
      "_a_7y0002h5pa",
      "0,1,0 own",
      "286",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0002badx{mask-border-outset:0 1 2;}",
      "_a_7y0002badx",
      "0,1,0 own",
      "286",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0002vur3{mask-border-outset:0 1 2 3;}",
      "_a_7y0002vur3",
      "0,1,0 own",
      "286",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004vgr1{mask-border-repeat:stretch;}",
      "_a_7y0004vgr1",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004j3or{mask-border-repeat:repeat;}",
      "_a_7y0004j3or",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y000417r4{mask-border-repeat:round;}",
      "_a_7y000417r4",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004chn8{mask-border-repeat:space;}",
      "_a_7y0004chn8",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004aifj{mask-border-repeat:stretch stretch;}",
      "_a_7y0004aifj",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004iybl{mask-border-repeat:repeat stretch;}",
      "_a_7y0004iybl",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004wbwc{mask-border-repeat:round stretch;}",
      "_a_7y0004wbwc",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004x2ld{mask-border-repeat:space stretch;}",
      "_a_7y0004x2ld",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004sdt0{mask-border-repeat:stretch repeat;}",
      "_a_7y0004sdt0",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004vjb8{mask-border-repeat:repeat repeat;}",
      "_a_7y0004vjb8",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004o22d{mask-border-repeat:round repeat;}",
      "_a_7y0004o22d",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004qntc{mask-border-repeat:space repeat;}",
      "_a_7y0004qntc",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004j4vd{mask-border-repeat:stretch round;}",
      "_a_7y0004j4vd",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004az9g{mask-border-repeat:repeat round;}",
      "_a_7y0004az9g",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004m5lc{mask-border-repeat:round round;}",
      "_a_7y0004m5lc",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004zmh8{mask-border-repeat:space round;}",
      "_a_7y0004zmh8",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004fg8f{mask-border-repeat:stretch space;}",
      "_a_7y0004fg8f",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y00048ni5{mask-border-repeat:repeat space;}",
      "_a_7y00048ni5",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004fmsi{mask-border-repeat:round space;}",
      "_a_7y0004fmsi",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y0004i2sh{mask-border-repeat:space space;}",
      "_a_7y0004i2sh",
      "0,1,0 own",
      "286",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7y001r0miw{mask-border:url(\"image.png\");}",
      "_a_7y001r0miw",
      "0,1,0 own",
      "286",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_7zfx9l{mask-type:luminance;}",
      "_a_7zfx9l",
      "0,1,0 own",
      "287",
      1,
      false,
    )
  ];
  [@css
    ("._a_7z6il5{mask-type:alpha;}", "_a_7z6il5", "0,1,0 own", "287", 1, false)
  ];
  [@css.blocks
    [
      (1, "", [0]),
      (2, "", [1]),
      (3, "", [2]),
      (4, "", [3]),
      (5, "", [4]),
      (6, "", [5]),
      (7, "", [6]),
      (8, "", [7]),
      (9, "", [8]),
      (10, "", [9]),
      (11, "", [10]),
      (12, "", [11]),
      (13, "", [12]),
      (14, "", [13]),
      (15, "", [14]),
      (16, "", [15]),
      (17, "", [16]),
      (18, "", [17]),
      (19, "", [18]),
      (20, "", [19]),
      (21, "", [20]),
      (22, "", [21]),
      (23, "", [22]),
      (24, "", [23]),
      (25, "", [24]),
      (26, "", [25]),
      (27, "", [26]),
      (28, "", [27]),
      (29, "", [28]),
      (30, "", [29]),
      (31, "", [30]),
      (32, "", [31]),
      (33, "", [32]),
      (34, "", [33]),
      (35, "", [34]),
      (36, "", [35]),
      (37, "", [36]),
      (38, "", [37]),
      (39, "", [38]),
      (40, "", [39]),
      (41, "", [40]),
      (42, "", [41]),
      (43, "", [42]),
      (44, "", [43]),
      (45, "", [44]),
      (46, "", [45]),
      (47, "", [46]),
      (48, "", [47]),
      (49, "", [48]),
      (50, "", [49]),
      (51, "", [50]),
      (52, "", [51]),
      (53, "", [52]),
      (54, "", [53]),
      (55, "", [54]),
      (56, "", [55]),
      (57, "", [56]),
      (58, "", [57]),
      (59, "", [58]),
      (60, "", [59]),
      (61, "", [60]),
      (62, "", [61]),
      (63, "", [62]),
      (64, "", [63]),
      (65, "", [64]),
      (66, "", [65]),
      (67, "", [66]),
      (68, "", [67]),
      (69, "", [65]),
      (70, "", [68]),
      (71, "", [69]),
      (72, "", [70]),
      (73, "", [71]),
      (74, "", [72]),
      (75, "", [73]),
      (76, "", [74]),
      (77, "", [75]),
      (78, "", [76]),
      (79, "", [77]),
      (80, "", [78]),
      (81, "", [79]),
      (82, "", [80]),
      (83, "", [81]),
      (84, "", [82]),
      (85, "", [83]),
      (86, "", [84]),
      (87, "", [85]),
      (88, "", [86]),
      (89, "", [87]),
      (90, "", [88]),
      (91, "", [89]),
      (92, "", [90]),
      (93, "", [91]),
      (94, "", [92]),
      (95, "", [92]),
      (96, "", [93]),
      (97, "", [94]),
      (98, "", [95]),
      (99, "", [96]),
      (100, "", [97]),
      (101, "", [98]),
      (102, "", [99]),
      (103, "", [100]),
      (104, "", [101]),
      (105, "", [102]),
      (106, "", [103]),
      (107, "", [104]),
      (108, "", [105]),
      (109, "", [106]),
      (110, "", [107]),
      (111, "", [108]),
      (112, "", [109]),
      (113, "", [110]),
      (114, "", [111]),
      (115, "", [112]),
      (116, "", [113]),
      (117, "", [114]),
      (118, "", [115]),
      (119, "", [116]),
      (120, "", [117]),
      (121, "", [118]),
      (122, "", [119]),
      (123, "", [120]),
      (124, "", [121]),
      (125, "", [122]),
      (126, "", [123]),
    ]
  ];
  CSS.make("_a_4ccpnl", []);
  CSS.make("_a_4cdshe", []);
  CSS.make("_a_4clbca", []);
  CSS.make("_a_4c8b54", []);
  CSS.make("_a_4cyasd", []);
  CSS.make("_a_4cz3kz", []);
  CSS.make("_a_4cq8iu", []);
  CSS.make("_a_4civbf", []);
  CSS.make("_a_4c4dpx", []);
  CSS.make("_a_4c8q0p", []);
  CSS.make("_a_4c3bw4", []);
  CSS.make("_a_4cww8a", []);
  CSS.make("_a_4civni", []);
  CSS.make("_a_4caqcy", []);
  CSS.make("_a_4dszcd", []);
  CSS.make("_a_4d6lnx", []);
  CSS.make("_a_7y0074lv46", []);
  CSS.make("_a_7y0074xpd6", []);
  CSS.make("_a_7y0074laft", []);
  CSS.make("_a_7y00e8dp5t", []);
  CSS.make("_a_7y00e8htsi", []);
  CSS.make("_a_7y00e8qdqk", []);
  CSS.make("_a_7y035skdr1", []);
  CSS.make("_a_7y035s0g9h", []);
  CSS.make("_a_7y035s0wgz", []);
  CSS.make("_a_7y035sbi8s", []);
  CSS.make("_a_7y035s20fn", []);
  CSS.make("_a_7y035sawfw", []);
  CSS.make("_a_7y035ssx21", []);
  CSS.make("_a_7y035s0fa9", []);
  CSS.make("_a_7y035sjxaa", []);
  CSS.make("_a_7y035s3pxt", []);
  CSS.make("_a_7y035sn6bx", []);
  CSS.make("_a_7y035sudfe", []);
  CSS.make("_a_7y035s6z3w", []);
  CSS.make("_a_7y035spthf", []);
  CSS.make("_a_7y035s8b1s", []);
  CSS.make("_a_7y035s6dy3", []);
  CSS.make("_a_7y035s035m", []);
  CSS.make("_a_7y035s1vap", []);
  CSS.make("_a_7y035spu1u", []);
  CSS.make("_a_7y035sa087", []);
  CSS.make("_a_7y035st6kf", []);
  CSS.make("_a_7y035sbql5", []);
  CSS.make("_a_7y01kw9y42", []);
  CSS.make("_a_7y01kwck5z", []);
  CSS.make("_a_7y01kwqk76", []);
  CSS.make("_a_7y01kwm1vo", []);
  CSS.make("_a_7y01kw2gp6", []);
  CSS.make("_a_7y001sj5or", []);
  CSS.make("_a_7y001s1q3a", []);
  CSS.make("_a_7y001sv6ku", []);
  CSS.make("_a_7y001s597p", []);
  CSS.make("_a_7y001say14", []);
  CSS.make("_a_7y001sj1e5", []);
  CSS.make("_a_7y001siy1a", []);
  CSS.make("_a_7y001sc5vo", []);
  CSS.make("_a_7y00sgjmd7", []);
  CSS.make("_a_7y00sg0f4k", []);
  CSS.make("_a_7y00sgh4gk", []);
  CSS.make("_a_7y00sg7k5t", []);
  CSS.make("_a_7y00sge45n", []);
  CSS.make("_a_7y00sg6p58", []);
  CSS.make("_a_7y00sg3jkb", []);
  CSS.make("_a_7y06bkqgoj", []);
  CSS.make("_a_7y06bkahf4", []);
  CSS.make("_a_7y06bkhzm2", []);
  CSS.make("_a_7y06bknp7r", []);
  CSS.make("_a_7y06bkahf4", []);
  CSS.make("_a_7y06bk0jbb", []);
  CSS.make("_a_7y06bk3cq7", []);
  CSS.make("_a_7y06bkieio", []);
  CSS.make("_a_7y06bk41vb", []);
  CSS.make("_a_7y003ktv7g", []);
  CSS.make("_a_7y003k75he", []);
  CSS.make("_a_7y003khvhq", []);
  CSS.make("_a_7y003k57xj", []);
  CSS.make("_a_7yf6ef", []);
  CSS.make("_a_7yyoaq", []);
  CSS.make("_a_7yk999", []);
  CSS.make("_a_7y1dmg", []);
  CSS.make("_a_7y80ky", []);
  CSS.make("_a_7y000gi8us", []);
  CSS.make("_a_7y000g7msv", []);
  CSS.make("_a_7y00088jwz", []);
  CSS.make("_a_7y00083qse", []);
  CSS.make("_a_7y0008wqe0", []);
  CSS.make("_a_7y0008tc58", []);
  CSS.make("_a_7y0008t8yr", []);
  CSS.make("_a_7y0008rxuj", []);
  CSS.make("_a_7y000wnwbq", []);
  CSS.make("_a_7y000wnkum", []);
  CSS.make("_a_7y000w340c", []);
  CSS.make("_a_7y000wquap", []);
  CSS.make("_a_7y000wquap", []);
  CSS.make("_a_7y000wwtrw", []);
  CSS.make("_a_7y000w4i71", []);
  CSS.make("_a_7y000ww63w", []);
  CSS.make("_a_7y0002btf2", []);
  CSS.make("_a_7y0002fzm0", []);
  CSS.make("_a_7y0002h5pa", []);
  CSS.make("_a_7y0002badx", []);
  CSS.make("_a_7y0002vur3", []);
  CSS.make("_a_7y0004vgr1", []);
  CSS.make("_a_7y0004j3or", []);
  CSS.make("_a_7y000417r4", []);
  CSS.make("_a_7y0004chn8", []);
  CSS.make("_a_7y0004aifj", []);
  CSS.make("_a_7y0004iybl", []);
  CSS.make("_a_7y0004wbwc", []);
  CSS.make("_a_7y0004x2ld", []);
  CSS.make("_a_7y0004sdt0", []);
  CSS.make("_a_7y0004vjb8", []);
  CSS.make("_a_7y0004o22d", []);
  CSS.make("_a_7y0004qntc", []);
  CSS.make("_a_7y0004j4vd", []);
  CSS.make("_a_7y0004az9g", []);
  CSS.make("_a_7y0004m5lc", []);
  CSS.make("_a_7y0004zmh8", []);
  CSS.make("_a_7y0004fg8f", []);
  CSS.make("_a_7y00048ni5", []);
  CSS.make("_a_7y0004fmsi", []);
  CSS.make("_a_7y0004i2sh", []);
  CSS.make("_a_7y001r0miw", []);
  CSS.make("_a_7zfx9l", []);
  CSS.make("_a_7z6il5", []);
