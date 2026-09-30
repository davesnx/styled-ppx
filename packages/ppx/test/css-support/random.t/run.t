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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --colorTextString-1or9u9e{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-17nwon4{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-1729nrm{syntax:\"*\";inherits:false;}"];
  [@css "@property --maskedImageUrl-q8tx22{syntax:\"*\";inherits:false;}"];
  [@css "@property --text-1dckpp2{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-1i7n24a{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-s8vp25{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-d1jms4{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-4g8iss{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-it7nat{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-h66riu{syntax:\"*\";inherits:false;}"];
  [@css "._a_aahc5w{scroll-behavior:auto;}"];
  [@css "._a_aajuhq{scroll-behavior:smooth;}"];
  [@css "._a_8snuue{overflow-anchor:none;}"];
  [@css "._a_8so7gw{overflow-anchor:auto;}"];
  [@css "._a_0114rl{-moz-appearance:textfield;}"];
  [@css "._a_24pbln{-webkit-appearance:none;}"];
  [@css "._a_27odft{-webkit-box-orient:vertical;}"];
  [@css "._a_2emjql{-webkit-line-clamp:2;}"];
  [@css "._a_2hwqei{-webkit-overflow-scrolling:touch;}"];
  [@css "._a_2jzphb{-webkit-tap-highlight-color:transparent;}"];
  [@css "._a_2kgs7p{-webkit-text-fill-color:var(--colorTextString-1or9u9e);}"];
  [@css "._a_2zkrf0{-webkit-animation:none;animation:none;}"];
  [@css
    "._a_33rcf8{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css "._a_35qiim{aspect-ratio:21 / 8;}"];
  [@css "._a_390049niw{background-color:var(--c-17nwon4);}"];
  [@css "._a_3hanm4{border:none;}"];
  [@css "._a_3hz56g{border:1px;}"];
  [@css "._a_3hqhxu{border:thin;}"];
  [@css "._a_3hrhyr{border:1px solid;}"];
  [@css "._a_3hr2u1{border:thin dashed;}"];
  [@css "._a_3h2auv{border:1px solid black;}"];
  [@css "._a_3hrvox{border:thin dashed red;}"];
  [@css "._a_3hh4t0{border:2px dotted #333;}"];
  [@css "._a_3hznxf{border:medium double blue;}"];
  [@css "._a_71001842v{bottom:unset;}"];
  [@css "._a_40keqi{box-shadow:none;}"];
  [@css "._a_44n7nl{break-inside:avoid;}"];
  [@css "._a_48dnqv{caret-color:#e15a46;}"];
  [@css "._a_4ey3yl{color:inherit;}"];
  [@css "._a_4ec5tt{color:var(--color-link);}"];
  [@css "._a_4o004mo4e{-webkit-column-width:125px;column-width:125px;}"];
  [@css "._a_4o00422l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css "._a_5f5by5{counter-increment:ol;}"];
  [@css "._a_5gor4s{counter-reset:ol;}"];
  [@css "._a_5rejxd{display:-webkit-box;}"];
  [@css "._a_5rf64m{display:contents;}"];
  [@css "._a_5r20ed{display:table;}"];
  [@css "._a_5wu6n6{fill:var(--c-1729nrm);}"];
  [@css "._a_5wzqgg{fill:currentColor;}"];
  [@css "._a_6ffv11{gap:4px;}"];
  [@css "._a_6j001xyc7{grid-column-end:span 2;}"];
  [@css "._a_6j003e1eh{-ms-grid-column:unset;grid-column:unset;}"];
  [@css "._a_6j00crf94{-ms-grid-row:unset;grid-row:unset;}"];
  [@css "._a_6i00gz6hb{grid-template-columns:max-content max-content;}"];
  [@css
    "._a_6i00ggo9j{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css
    "._a_6i00gyg51{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css "._a_6i00gwvwy{grid-template-columns:repeat(2, auto);}"];
  [@css "._a_6i00gu6jz{grid-template-columns:repeat(3, auto);}"];
  [@css
    "._a_6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css "._a_9i0027xd1{justify-items:start;}"];
  [@css "._a_9j002oybl{justify-self:unset;}"];
  [@css "._a_71002rhel{left:unset;}"];
  [@css
    "._a_7y074aouu{-webkit-mask-image:var(--maskedImageUrl-q8tx22);mask-image:var(--maskedImageUrl-q8tx22);}"
  ];
  [@css
    "._a_7y1kwck5z{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css "._a_7y35sawfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    "._a_88c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css "._a_8p12fz{outline:none;}"];
  [@css "._a_9ln4zy{position:unset;}"];
  [@css "._a_9y6l6w{resize:none;}"];
  [@css "._a_71004k6z4{right:calc(50% - 4px);}"];
  [@css "._a_c0y1y6{stroke-opacity:0;}"];
  [@css "._a_btaxxd{stroke:var(--text-1dckpp2);}"];
  [@css "._a_710083v5j{top:calc(50% - 1px);}"];
  [@css "._a_710081c45{top:unset;}"];
  [@css "._a_dhsbrd{touch-action:none;}"];
  [@css "._a_dhee94{touch-action:pan-x pan-y;}"];
  [@css "._a_dkf4tj{transform-origin:center bottom;}"];
  [@css "._a_dkmm6s{transform-origin:center left;}"];
  [@css "._a_dkn9hl{transform-origin:center right;}"];
  [@css "._a_dkjzv0{transform-origin:2px;}"];
  [@css "._a_dkuei5{transform-origin:bottom;}"];
  [@css "._a_dk79kk{transform-origin:3cm 2px;}"];
  [@css "._a_dkmaf2{transform-origin:left 2px;}"];
  [@css "._a_dk5eih{transform-origin:center top;}"];
  [@css
    "._a_diuucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    "._a_ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    "._a_ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css "._a_dm002v97v{transition-delay:240ms;}"];
  [@css
    "._a_2z008i4el{-webkit-animation-duration:150ms;animation-duration:150ms;}"
  ];
  [@css "._a_3hlokslom{border-width:thin;}"];
  [@css "._a_8p004cl79{outline-width:medium;}"];
  [@css "._a_8pehrx{outline:medium solid red;}"];
  [@css "._a_8rd3yo{overflow:var(--lola-1i7n24a);}"];
  [@css "._a_8rbazn{overflow:hidden;}"];
  [@css "._a_8r0022x0l{overflow-y:var(--lola-s8vp25);}"];
  [@css "._a_8r001o3b9{overflow-x:hidden;}"];
  [@css "._a_8ti9nl{overflow-block:hidden;}"];
  [@css "._a_8trkd7{overflow-block:var(--value-d1jms4);}"];
  [@css "._a_8wl9bh{overflow-inline:var(--value-4g8iss);}"];
  [@css
    "._a_39008a0mj{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}"
  ];
  [@css "._a_35vr3s{aspect-ratio:16 / 9;}"];
  [@css "._in_1ter7ii{right:var(--interpolation-it7nat);}"];
  [@css "._in_1ter7ii{bottom:var(--interpolation-h66riu);}"];
  
  CSS.make("_a_aahc5w", []);
  CSS.make("_a_aajuhq", []);
  
  CSS.make("_a_8snuue", []);
  CSS.make("_a_8so7gw", []);
  
  CSS.make("_a_0114rl", []);
  CSS.make("_a_24pbln", []);
  CSS.make("_a_27odft", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("_a_2emjql", []);
  CSS.make("_a_2hwqei", []);
  CSS.make("_a_2jzphb", []);
  CSS.make(
    "_a_2kgs7p",
    [
      (
        "--colorTextString-1or9u9e",
        CSS.Types.WebkitTextFillColor.toString(colorTextString),
      ),
    ],
  );
  CSS.make("_a_2zkrf0", []);
  CSS.make("_a_33rcf8", []);
  CSS.make("_a_35qiim", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("_a_390049niw", [("--c-17nwon4", CSS.Types.Color.toString(c))]);
  
  CSS.make("_a_3hanm4", []);
  
  CSS.make("_a_3hz56g", []);
  CSS.make("_a_3hqhxu", []);
  
  CSS.make("_a_3hrhyr", []);
  CSS.make("_a_3hr2u1", []);
  
  CSS.make("_a_3h2auv", []);
  CSS.make("_a_3hrvox", []);
  CSS.make("_a_3hh4t0", []);
  CSS.make("_a_3hznxf", []);
  CSS.make("_a_71001842v", []);
  CSS.make("_a_40keqi", []);
  CSS.make("_a_44n7nl", []);
  CSS.make("_a_48dnqv", []);
  CSS.make("_a_4ey3yl", []);
  CSS.make("_a_4ec5tt", []);
  CSS.make("_a_4o004mo4e", []);
  CSS.make("_a_4o00422l4", []);
  CSS.make("_a_5f5by5", []);
  CSS.make("_a_5gor4s", []);
  CSS.make("_a_5rejxd", []);
  CSS.make("_a_5rf64m", []);
  CSS.make("_a_5r20ed", []);
  CSS.make("_a_5wu6n6", [("--c-1729nrm", CSS.Types.Paint.toString(c))]);
  CSS.make("_a_5wzqgg", []);
  CSS.make("_a_6ffv11", []);
  CSS.make("_a_6j001xyc7", []);
  CSS.make("_a_6j003e1eh", []);
  CSS.make("_a_6j00crf94", []);
  CSS.make("_a_6i00gz6hb", []);
  CSS.make("_a_6i00ggo9j", []);
  CSS.make("_a_6i00gyg51", []);
  CSS.make("_a_6i00gwvwy", []);
  CSS.make("_a_6i00gu6jz", []);
  CSS.make("_a_6l0xge", []);
  CSS.make("_a_9i0027xd1", []);
  CSS.make("_a_9j002oybl", []);
  CSS.make("_a_71002rhel", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "_a_7y074aouu",
    [
      ("--maskedImageUrl-q8tx22", CSS.Types.MaskImage.toString(maskedImageUrl)),
    ],
  );
  CSS.make("_a_7y1kwck5z", []);
  CSS.make("_a_7y35sawfw", []);
  CSS.make("_a_88c9a0", []);
  CSS.make("_a_8p12fz", []);
  CSS.make("_a_8snuue", []);
  CSS.make("_a_9ln4zy", []);
  CSS.make("_a_9y6l6w", []);
  CSS.make("_a_71004k6z4", []);
  CSS.make("_a_aajuhq", []);
  CSS.make("_a_c0y1y6", []);
  CSS.make(
    "_a_btaxxd",
    [("--text-1dckpp2", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("_a_710083v5j", []);
  CSS.make("_a_710081c45", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhee94", []);
  CSS.make("_a_dkf4tj", []);
  CSS.make("_a_dkmm6s", []);
  CSS.make("_a_dkn9hl", []);
  CSS.make("_a_dkjzv0", []);
  CSS.make("_a_dkuei5", []);
  CSS.make("_a_dk79kk", []);
  CSS.make("_a_dkmaf2", []);
  CSS.make("_a_dk5eih", []);
  CSS.make("_a_diuucg", []);
  
  CSS.make("_a_ecanqs", []);
  CSS.make("_a_ec3le8", []);
  
  CSS.make("_a_dm002v97v", []);
  CSS.make("_a_2z008i4el", []);
  
  CSS.make("_a_3hlokslom", []);
  CSS.make("_a_8p004cl79", []);
  CSS.make("_a_8pehrx", []);
  
  let lola = `hidden;
  CSS.make(
    "_a_8rd3yo",
    [("--lola-1i7n24a", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("_a_8rbazn", []);
  CSS.make(
    "_a_8r0022x0l",
    [("--lola-s8vp25", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("_a_8r001o3b9", []);
  
  let value = `clip;
  CSS.make("_a_8ti9nl", []);
  CSS.make(
    "_a_8trkd7",
    [("--value-d1jms4", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "_a_8wl9bh",
    [("--value-4g8iss", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("_a_39008a0mj", []);
  
  CSS.make("_a_35vr3s", []);
  
  CSS.make("_a_4ec5tt", []);
  
  let interpolation = `px(10);
  CSS.make(
    "_in_1ter7ii",
    [
      ("--interpolation-it7nat", CSS.Types.Right.toString(interpolation)),
      ("--interpolation-h66riu", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
