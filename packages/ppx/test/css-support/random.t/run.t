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
  [@css ".a-aahc5w{scroll-behavior:auto;}"];
  [@css ".a-aajuhq{scroll-behavior:smooth;}"];
  [@css ".a-8snuue{overflow-anchor:none;}"];
  [@css ".a-8so7gw{overflow-anchor:auto;}"];
  [@css ".a-0114rl{-moz-appearance:textfield;}"];
  [@css ".a-24pbln{-webkit-appearance:none;}"];
  [@css ".a-27odft{-webkit-box-orient:vertical;}"];
  [@css ".a-2emjql{-webkit-line-clamp:2;}"];
  [@css ".a-2hwqei{-webkit-overflow-scrolling:touch;}"];
  [@css ".a-2jzphb{-webkit-tap-highlight-color:transparent;}"];
  [@css ".a-2kgs7p{-webkit-text-fill-color:var(--colorTextString-1or9u9e);}"];
  [@css ".a-2zkrf0{-webkit-animation:none;animation:none;}"];
  [@css
    ".a-33rcf8{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".a-35qiim{aspect-ratio:21 / 8;}"];
  [@css ".a-390049niw{background-color:var(--c-17nwon4);}"];
  [@css ".a-3hanm4{border:none;}"];
  [@css ".a-3hz56g{border:1px;}"];
  [@css ".a-3hqhxu{border:thin;}"];
  [@css ".a-3hrhyr{border:1px solid;}"];
  [@css ".a-3hr2u1{border:thin dashed;}"];
  [@css ".a-3h2auv{border:1px solid black;}"];
  [@css ".a-3hrvox{border:thin dashed red;}"];
  [@css ".a-3hh4t0{border:2px dotted #333;}"];
  [@css ".a-3hznxf{border:medium double blue;}"];
  [@css ".a-71001842v{bottom:unset;}"];
  [@css ".a-40keqi{box-shadow:none;}"];
  [@css ".a-44n7nl{break-inside:avoid;}"];
  [@css ".a-48dnqv{caret-color:#e15a46;}"];
  [@css ".a-4ey3yl{color:inherit;}"];
  [@css ".a-4ec5tt{color:var(--color-link);}"];
  [@css ".a-4o004mo4e{-webkit-column-width:125px;column-width:125px;}"];
  [@css ".a-4o00422l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".a-5f5by5{counter-increment:ol;}"];
  [@css ".a-5gor4s{counter-reset:ol;}"];
  [@css ".a-5rejxd{display:-webkit-box;}"];
  [@css ".a-5rf64m{display:contents;}"];
  [@css ".a-5r20ed{display:table;}"];
  [@css ".a-5wu6n6{fill:var(--c-1729nrm);}"];
  [@css ".a-5wzqgg{fill:currentColor;}"];
  [@css ".a-6ffv11{gap:4px;}"];
  [@css ".a-6j001xyc7{grid-column-end:span 2;}"];
  [@css ".a-6j003e1eh{-ms-grid-column:unset;grid-column:unset;}"];
  [@css ".a-6j00crf94{-ms-grid-row:unset;grid-row:unset;}"];
  [@css ".a-6i00gz6hb{grid-template-columns:max-content max-content;}"];
  [@css
    ".a-6i00ggo9j{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css
    ".a-6i00gyg51{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css ".a-6i00gwvwy{grid-template-columns:repeat(2, auto);}"];
  [@css ".a-6i00gu6jz{grid-template-columns:repeat(3, auto);}"];
  [@css
    ".a-6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css ".a-9i0027xd1{justify-items:start;}"];
  [@css ".a-9j002oybl{justify-self:unset;}"];
  [@css ".a-71002rhel{left:unset;}"];
  [@css
    ".a-7y074aouu{-webkit-mask-image:var(--maskedImageUrl-q8tx22);mask-image:var(--maskedImageUrl-q8tx22);}"
  ];
  [@css
    ".a-7y1kwck5z{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".a-7y35sawfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".a-88c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css ".a-8p12fz{outline:none;}"];
  [@css ".a-9ln4zy{position:unset;}"];
  [@css ".a-9y6l6w{resize:none;}"];
  [@css ".a-71004k6z4{right:calc(50% - 4px);}"];
  [@css ".a-c0y1y6{stroke-opacity:0;}"];
  [@css ".a-btaxxd{stroke:var(--text-1dckpp2);}"];
  [@css ".a-710083v5j{top:calc(50% - 1px);}"];
  [@css ".a-710081c45{top:unset;}"];
  [@css ".a-dhsbrd{touch-action:none;}"];
  [@css ".a-dhee94{touch-action:pan-x pan-y;}"];
  [@css ".a-dkf4tj{transform-origin:center bottom;}"];
  [@css ".a-dkmm6s{transform-origin:center left;}"];
  [@css ".a-dkn9hl{transform-origin:center right;}"];
  [@css ".a-dkjzv0{transform-origin:2px;}"];
  [@css ".a-dkuei5{transform-origin:bottom;}"];
  [@css ".a-dk79kk{transform-origin:3cm 2px;}"];
  [@css ".a-dkmaf2{transform-origin:left 2px;}"];
  [@css ".a-dk5eih{transform-origin:center top;}"];
  [@css
    ".a-diuucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".a-ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".a-ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css ".a-dm002v97v{transition-delay:240ms;}"];
  [@css
    ".a-2z008i4el{-webkit-animation-duration:150ms;animation-duration:150ms;}"
  ];
  [@css ".a-3hlokslom{border-width:thin;}"];
  [@css ".a-8p004cl79{outline-width:medium;}"];
  [@css ".a-8pehrx{outline:medium solid red;}"];
  [@css ".a-8rd3yo{overflow:var(--lola-1i7n24a);}"];
  [@css ".a-8rbazn{overflow:hidden;}"];
  [@css ".a-8r0022x0l{overflow-y:var(--lola-s8vp25);}"];
  [@css ".a-8r001o3b9{overflow-x:hidden;}"];
  [@css ".a-8ti9nl{overflow-block:hidden;}"];
  [@css ".a-8trkd7{overflow-block:var(--value-d1jms4);}"];
  [@css ".a-8wl9bh{overflow-inline:var(--value-4g8iss);}"];
  [@css
    ".a-39008a0mj{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}"
  ];
  [@css ".a-35vr3s{aspect-ratio:16 / 9;}"];
  [@css ".in-1ter7ii{right:var(--interpolation-it7nat);}"];
  [@css ".in-1ter7ii{bottom:var(--interpolation-h66riu);}"];
  
  CSS.make("a-aahc5w", []);
  CSS.make("a-aajuhq", []);
  
  CSS.make("a-8snuue", []);
  CSS.make("a-8so7gw", []);
  
  CSS.make("a-0114rl", []);
  CSS.make("a-24pbln", []);
  CSS.make("a-27odft", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("a-2emjql", []);
  CSS.make("a-2hwqei", []);
  CSS.make("a-2jzphb", []);
  CSS.make(
    "a-2kgs7p",
    [
      (
        "--colorTextString-1or9u9e",
        CSS.Types.WebkitTextFillColor.toString(colorTextString),
      ),
    ],
  );
  CSS.make("a-2zkrf0", []);
  CSS.make("a-33rcf8", []);
  CSS.make("a-35qiim", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("a-390049niw", [("--c-17nwon4", CSS.Types.Color.toString(c))]);
  
  CSS.make("a-3hanm4", []);
  
  CSS.make("a-3hz56g", []);
  CSS.make("a-3hqhxu", []);
  
  CSS.make("a-3hrhyr", []);
  CSS.make("a-3hr2u1", []);
  
  CSS.make("a-3h2auv", []);
  CSS.make("a-3hrvox", []);
  CSS.make("a-3hh4t0", []);
  CSS.make("a-3hznxf", []);
  CSS.make("a-71001842v", []);
  CSS.make("a-40keqi", []);
  CSS.make("a-44n7nl", []);
  CSS.make("a-48dnqv", []);
  CSS.make("a-4ey3yl", []);
  CSS.make("a-4ec5tt", []);
  CSS.make("a-4o004mo4e", []);
  CSS.make("a-4o00422l4", []);
  CSS.make("a-5f5by5", []);
  CSS.make("a-5gor4s", []);
  CSS.make("a-5rejxd", []);
  CSS.make("a-5rf64m", []);
  CSS.make("a-5r20ed", []);
  CSS.make("a-5wu6n6", [("--c-1729nrm", CSS.Types.Paint.toString(c))]);
  CSS.make("a-5wzqgg", []);
  CSS.make("a-6ffv11", []);
  CSS.make("a-6j001xyc7", []);
  CSS.make("a-6j003e1eh", []);
  CSS.make("a-6j00crf94", []);
  CSS.make("a-6i00gz6hb", []);
  CSS.make("a-6i00ggo9j", []);
  CSS.make("a-6i00gyg51", []);
  CSS.make("a-6i00gwvwy", []);
  CSS.make("a-6i00gu6jz", []);
  CSS.make("a-6l0xge", []);
  CSS.make("a-9i0027xd1", []);
  CSS.make("a-9j002oybl", []);
  CSS.make("a-71002rhel", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "a-7y074aouu",
    [
      ("--maskedImageUrl-q8tx22", CSS.Types.MaskImage.toString(maskedImageUrl)),
    ],
  );
  CSS.make("a-7y1kwck5z", []);
  CSS.make("a-7y35sawfw", []);
  CSS.make("a-88c9a0", []);
  CSS.make("a-8p12fz", []);
  CSS.make("a-8snuue", []);
  CSS.make("a-9ln4zy", []);
  CSS.make("a-9y6l6w", []);
  CSS.make("a-71004k6z4", []);
  CSS.make("a-aajuhq", []);
  CSS.make("a-c0y1y6", []);
  CSS.make(
    "a-btaxxd",
    [("--text-1dckpp2", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("a-710083v5j", []);
  CSS.make("a-710081c45", []);
  CSS.make("a-dhsbrd", []);
  CSS.make("a-dhee94", []);
  CSS.make("a-dkf4tj", []);
  CSS.make("a-dkmm6s", []);
  CSS.make("a-dkn9hl", []);
  CSS.make("a-dkjzv0", []);
  CSS.make("a-dkuei5", []);
  CSS.make("a-dk79kk", []);
  CSS.make("a-dkmaf2", []);
  CSS.make("a-dk5eih", []);
  CSS.make("a-diuucg", []);
  
  CSS.make("a-ecanqs", []);
  CSS.make("a-ec3le8", []);
  
  CSS.make("a-dm002v97v", []);
  CSS.make("a-2z008i4el", []);
  
  CSS.make("a-3hlokslom", []);
  CSS.make("a-8p004cl79", []);
  CSS.make("a-8pehrx", []);
  
  let lola = `hidden;
  CSS.make(
    "a-8rd3yo",
    [("--lola-1i7n24a", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("a-8rbazn", []);
  CSS.make(
    "a-8r0022x0l",
    [("--lola-s8vp25", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("a-8r001o3b9", []);
  
  let value = `clip;
  CSS.make("a-8ti9nl", []);
  CSS.make(
    "a-8trkd7",
    [("--value-d1jms4", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "a-8wl9bh",
    [("--value-4g8iss", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("a-39008a0mj", []);
  
  CSS.make("a-35vr3s", []);
  
  CSS.make("a-4ec5tt", []);
  
  let interpolation = `px(10);
  CSS.make(
    "in-1ter7ii",
    [
      ("--interpolation-it7nat", CSS.Types.Right.toString(interpolation)),
      ("--interpolation-h66riu", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
