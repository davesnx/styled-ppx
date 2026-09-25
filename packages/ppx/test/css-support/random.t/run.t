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
  [@css ".a-89hc5w{scroll-behavior:auto;}"];
  [@css ".a-pdjuhq{scroll-behavior:smooth;}"];
  [@css ".a-1fsnuue{overflow-anchor:none;}"];
  [@css ".a-elo7gw{overflow-anchor:auto;}"];
  [@css ".a-1n114rl{-moz-appearance:textfield;}"];
  [@css ".a-qzpbln{-webkit-appearance:none;}"];
  [@css ".a-hhodft{-webkit-box-orient:vertical;}"];
  [@css ".a-10cmjql{-webkit-line-clamp:2;}"];
  [@css ".a-1ojwqei{-webkit-overflow-scrolling:touch;}"];
  [@css ".a-150zphb{-webkit-tap-highlight-color:transparent;}"];
  [@css ".in-wigs7p{-webkit-text-fill-color:var(--colorTextString-1or9u9e);}"];
  [@css ".a-cdkrf0{-webkit-animation:none;animation:none;}"];
  [@css
    ".a-17grcf8{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".a-12yqiim{aspect-ratio:21 / 8;}"];
  [@css ".in-1ts9niw{background-color:var(--c-17nwon4);}"];
  [@css ".a-10ganm4{border:none;}"];
  [@css ".a-19xz56g{border:1px;}"];
  [@css ".a-1leqhxu{border:thin;}"];
  [@css ".a-b7rhyr{border:1px solid;}"];
  [@css ".a-1oar2u1{border:thin dashed;}"];
  [@css ".a-e42auv{border:1px solid black;}"];
  [@css ".a-11wrvox{border:thin dashed red;}"];
  [@css ".a-ojh4t0{border:2px dotted #333;}"];
  [@css ".a-1sfznxf{border:medium double blue;}"];
  [@css ".a-1uo842v{bottom:unset;}"];
  [@css ".a-gokeqi{box-shadow:none;}"];
  [@css ".a-1ybn7nl{break-inside:avoid;}"];
  [@css ".a-4rdnqv{caret-color:#e15a46;}"];
  [@css ".a-q2y3yl{color:inherit;}"];
  [@css ".a-12xc5tt{color:var(--color-link);}"];
  [@css ".a-1ccmo4e{-webkit-column-width:125px;column-width:125px;}"];
  [@css ".a-tt22l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".a-wh5by5{counter-increment:ol;}"];
  [@css ".a-1y2or4s{counter-reset:ol;}"];
  [@css ".a-1l2ejxd{display:-webkit-box;}"];
  [@css ".a-1obf64m{display:contents;}"];
  [@css ".a-z920ed{display:table;}"];
  [@css ".in-14lu6n6{fill:var(--c-1729nrm);}"];
  [@css ".a-kqzqgg{fill:currentColor;}"];
  [@css ".a-lhfv11{gap:4px;}"];
  [@css ".a-14qxyc7{grid-column-end:span 2;}"];
  [@css ".a-93e1eh{-ms-grid-column:unset;grid-column:unset;}"];
  [@css ".a-crrf94{-ms-grid-row:unset;grid-row:unset;}"];
  [@css ".a-1knz6hb{grid-template-columns:max-content max-content;}"];
  [@css
    ".a-1bqgo9j{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css
    ".a-mwyg51{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css ".a-1stwvwy{grid-template-columns:repeat(2, auto);}"];
  [@css ".a-peu6jz{grid-template-columns:repeat(3, auto);}"];
  [@css
    ".a-1sy0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css ".a-g27xd1{justify-items:start;}"];
  [@css ".a-1ioybl{justify-self:unset;}"];
  [@css ".a-1h7rhel{left:unset;}"];
  [@css
    ".in-riaouu{-webkit-mask-image:var(--maskedImageUrl-q8tx22);mask-image:var(--maskedImageUrl-q8tx22);}"
  ];
  [@css
    ".a-1wjck5z{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".a-71awfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".a-13sc9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css ".a-10b12fz{outline:none;}"];
  [@css ".a-8dn4zy{position:unset;}"];
  [@css ".a-5d6l6w{resize:none;}"];
  [@css ".a-1pk6z4{right:calc(50% - 4px);}"];
  [@css ".a-50y1y6{stroke-opacity:0;}"];
  [@css ".in-raxxd{stroke:var(--text-1dckpp2);}"];
  [@css ".a-t83v5j{top:calc(50% - 1px);}"];
  [@css ".a-13m1c45{top:unset;}"];
  [@css ".a-z0sbrd{touch-action:none;}"];
  [@css ".a-11ee94{touch-action:pan-x pan-y;}"];
  [@css ".a-18jf4tj{transform-origin:center bottom;}"];
  [@css ".a-16gmm6s{transform-origin:center left;}"];
  [@css ".a-11nn9hl{transform-origin:center right;}"];
  [@css ".a-ojzv0{transform-origin:2px;}"];
  [@css ".a-1aquei5{transform-origin:bottom;}"];
  [@css ".a-16g79kk{transform-origin:3cm 2px;}"];
  [@css ".a-1spmaf2{transform-origin:left 2px;}"];
  [@css ".a-zo5eih{transform-origin:center top;}"];
  [@css
    ".a-1l0uucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".a-1gtanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".a-cf3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css ".a-1ssv97v{transition-delay:240ms;}"];
  [@css ".a-vzi4el{-webkit-animation-duration:150ms;animation-duration:150ms;}"];
  [@css ".a-14lslom{border-width:thin;}"];
  [@css ".a-1dmcl79{outline-width:medium;}"];
  [@css ".a-1saehrx{outline:medium solid red;}"];
  [@css ".in-1iid3yo{overflow:var(--lola-1i7n24a);}"];
  [@css ".a-i6bazn{overflow:hidden;}"];
  [@css ".in-az2x0l{overflow-y:var(--lola-s8vp25);}"];
  [@css ".a-1kzo3b9{overflow-x:hidden;}"];
  [@css ".a-l7i9nl{overflow-block:hidden;}"];
  [@css ".in-workd7{overflow-block:var(--value-d1jms4);}"];
  [@css ".in-mbl9bh{overflow-inline:var(--value-4g8iss);}"];
  [@css
    ".a-p2a0mj{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}"
  ];
  [@css ".a-1amvr3s{aspect-ratio:16 / 9;}"];
  [@css ".in-1ter7ii{right:var(--interpolation-it7nat);}"];
  [@css ".in-1ter7ii{bottom:var(--interpolation-h66riu);}"];
  
  CSS.make("a-89hc5w", []);
  CSS.make("a-pdjuhq", []);
  
  CSS.make("a-1fsnuue", []);
  CSS.make("a-elo7gw", []);
  
  CSS.make("a-1n114rl", []);
  CSS.make("a-qzpbln", []);
  CSS.make("a-hhodft", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("a-10cmjql", []);
  CSS.make("a-1ojwqei", []);
  CSS.make("a-150zphb", []);
  CSS.make(
    "in-wigs7p",
    [
      (
        "--colorTextString-1or9u9e",
        CSS.Types.WebkitTextFillColor.toString(colorTextString),
      ),
    ],
  );
  CSS.make("a-cdkrf0", []);
  CSS.make("a-17grcf8", []);
  CSS.make("a-12yqiim", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("in-1ts9niw", [("--c-17nwon4", CSS.Types.Color.toString(c))]);
  
  CSS.make("a-10ganm4", []);
  
  CSS.make("a-19xz56g", []);
  CSS.make("a-1leqhxu", []);
  
  CSS.make("a-b7rhyr", []);
  CSS.make("a-1oar2u1", []);
  
  CSS.make("a-e42auv", []);
  CSS.make("a-11wrvox", []);
  CSS.make("a-ojh4t0", []);
  CSS.make("a-1sfznxf", []);
  CSS.make("a-1uo842v", []);
  CSS.make("a-gokeqi", []);
  CSS.make("a-1ybn7nl", []);
  CSS.make("a-4rdnqv", []);
  CSS.make("a-q2y3yl", []);
  CSS.make("a-12xc5tt", []);
  CSS.make("a-1ccmo4e", []);
  CSS.make("a-tt22l4", []);
  CSS.make("a-wh5by5", []);
  CSS.make("a-1y2or4s", []);
  CSS.make("a-1l2ejxd", []);
  CSS.make("a-1obf64m", []);
  CSS.make("a-z920ed", []);
  CSS.make("in-14lu6n6", [("--c-1729nrm", CSS.Types.Paint.toString(c))]);
  CSS.make("a-kqzqgg", []);
  CSS.make("a-lhfv11", []);
  CSS.make("a-14qxyc7", []);
  CSS.make("a-93e1eh", []);
  CSS.make("a-crrf94", []);
  CSS.make("a-1knz6hb", []);
  CSS.make("a-1bqgo9j", []);
  CSS.make("a-mwyg51", []);
  CSS.make("a-1stwvwy", []);
  CSS.make("a-peu6jz", []);
  CSS.make("a-1sy0xge", []);
  CSS.make("a-g27xd1", []);
  CSS.make("a-1ioybl", []);
  CSS.make("a-1h7rhel", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "in-riaouu",
    [
      ("--maskedImageUrl-q8tx22", CSS.Types.MaskImage.toString(maskedImageUrl)),
    ],
  );
  CSS.make("a-1wjck5z", []);
  CSS.make("a-71awfw", []);
  CSS.make("a-13sc9a0", []);
  CSS.make("a-10b12fz", []);
  CSS.make("a-1fsnuue", []);
  CSS.make("a-8dn4zy", []);
  CSS.make("a-5d6l6w", []);
  CSS.make("a-1pk6z4", []);
  CSS.make("a-pdjuhq", []);
  CSS.make("a-50y1y6", []);
  CSS.make(
    "in-raxxd",
    [("--text-1dckpp2", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("a-t83v5j", []);
  CSS.make("a-13m1c45", []);
  CSS.make("a-z0sbrd", []);
  CSS.make("a-11ee94", []);
  CSS.make("a-18jf4tj", []);
  CSS.make("a-16gmm6s", []);
  CSS.make("a-11nn9hl", []);
  CSS.make("a-ojzv0", []);
  CSS.make("a-1aquei5", []);
  CSS.make("a-16g79kk", []);
  CSS.make("a-1spmaf2", []);
  CSS.make("a-zo5eih", []);
  CSS.make("a-1l0uucg", []);
  
  CSS.make("a-1gtanqs", []);
  CSS.make("a-cf3le8", []);
  
  CSS.make("a-1ssv97v", []);
  CSS.make("a-vzi4el", []);
  
  CSS.make("a-14lslom", []);
  CSS.make("a-1dmcl79", []);
  CSS.make("a-1saehrx", []);
  
  let lola = `hidden;
  CSS.make(
    "in-1iid3yo",
    [("--lola-1i7n24a", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("a-i6bazn", []);
  CSS.make(
    "in-az2x0l",
    [("--lola-s8vp25", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("a-1kzo3b9", []);
  
  let value = `clip;
  CSS.make("a-l7i9nl", []);
  CSS.make(
    "in-workd7",
    [("--value-d1jms4", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "in-mbl9bh",
    [("--value-4g8iss", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("a-p2a0mj", []);
  
  CSS.make("a-1amvr3s", []);
  
  CSS.make("a-12xc5tt", []);
  
  let interpolation = `px(10);
  CSS.make(
    "in-1ter7ii",
    [
      ("--interpolation-it7nat", CSS.Types.Right.toString(interpolation)),
      ("--interpolation-h66riu", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
