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
  [@css ".css-89hc5w{scroll-behavior:auto;}"];
  [@css ".css-pdjuhq{scroll-behavior:smooth;}"];
  [@css ".css-1fsnuue{overflow-anchor:none;}"];
  [@css ".css-elo7gw{overflow-anchor:auto;}"];
  [@css ".css-1n114rl{-moz-appearance:textfield;}"];
  [@css ".css-qzpbln{-webkit-appearance:none;}"];
  [@css ".css-hhodft{-webkit-box-orient:vertical;}"];
  [@css ".css-10cmjql{-webkit-line-clamp:2;}"];
  [@css ".css-1ojwqei{-webkit-overflow-scrolling:touch;}"];
  [@css ".css-150zphb{-webkit-tap-highlight-color:transparent;}"];
  [@css ".css-wigs7p{-webkit-text-fill-color:var(--var-g5egjq);}"];
  [@css ".css-cdkrf0{animation:none;}"];
  [@css ".css-17grcf8{appearance:none;}"];
  [@css ".css-12yqiim{aspect-ratio:21 / 8;}"];
  [@css ".css-1ts9niw{background-color:var(--var-11dnnxw);}"];
  [@css ".css-10ganm4{border:none;}"];
  [@css ".css-19xz56g{border:1px;}"];
  [@css ".css-1leqhxu{border:thin;}"];
  [@css ".css-b7rhyr{border:1px solid;}"];
  [@css ".css-1oar2u1{border:thin dashed;}"];
  [@css ".css-e42auv{border:1px solid black;}"];
  [@css ".css-11wrvox{border:thin dashed red;}"];
  [@css ".css-ojh4t0{border:2px dotted #333;}"];
  [@css ".css-1sfznxf{border:medium double blue;}"];
  [@css ".css-1uo842v{bottom:unset;}"];
  [@css ".css-gokeqi{box-shadow:none;}"];
  [@css ".css-1ybn7nl{break-inside:avoid;}"];
  [@css ".css-4rdnqv{caret-color:#e15a46;}"];
  [@css ".css-q2y3yl{color:inherit;}"];
  [@css ".css-12xc5tt{color:var(--color-link);}"];
  [@css ".css-1ccmo4e{column-width:125px;}"];
  [@css ".css-tt22l4{column-width:auto;}"];
  [@css ".css-wh5by5{counter-increment:ol;}"];
  [@css ".css-1y2or4s{counter-reset:ol;}"];
  [@css ".css-1l2ejxd{display:-webkit-box;}"];
  [@css ".css-1obf64m{display:contents;}"];
  [@css ".css-z920ed{display:table;}"];
  [@css ".css-14lu6n6{fill:var(--var-11dnnxw);}"];
  [@css ".css-kqzqgg{fill:currentColor;}"];
  [@css ".css-lhfv11{gap:4px;}"];
  [@css ".css-14qxyc7{grid-column-end:span 2;}"];
  [@css ".css-93e1eh{grid-column:unset;}"];
  [@css ".css-crrf94{grid-row:unset;}"];
  [@css ".css-1knz6hb{grid-template-columns:max-content max-content;}"];
  [@css ".css-1stwvwy{grid-template-columns:repeat(2, auto);}"];
  [@css ".css-peu6jz{grid-template-columns:repeat(3, auto);}"];
  [@css ".css-1sy0xge{height:fit-content;}"];
  [@css ".css-g27xd1{justify-items:start;}"];
  [@css ".css-1ioybl{justify-self:unset;}"];
  [@css ".css-1h7rhel{left:unset;}"];
  [@css ".css-riaouu{mask-image:var(--var-1few37s);}"];
  [@css ".css-1wjck5z{mask-position:center center;}"];
  [@css ".css-71awfw{mask-repeat:no-repeat;}"];
  [@css ".css-13sc9a0{max-width:max-content;}"];
  [@css ".css-10b12fz{outline:none;}"];
  [@css ".css-8dn4zy{position:unset;}"];
  [@css ".css-5d6l6w{resize:none;}"];
  [@css ".css-1pk6z4{right:calc(50% - 4px);}"];
  [@css ".css-50y1y6{stroke-opacity:0;}"];
  [@css ".css-raxxd{stroke:var(--var-16dsc2j);}"];
  [@css ".css-t83v5j{top:calc(50% - 1px);}"];
  [@css ".css-13m1c45{top:unset;}"];
  [@css ".css-z0sbrd{touch-action:none;}"];
  [@css ".css-11ee94{touch-action:pan-x pan-y;}"];
  [@css ".css-18jf4tj{transform-origin:center bottom;}"];
  [@css ".css-16gmm6s{transform-origin:center left;}"];
  [@css ".css-11nn9hl{transform-origin:center right;}"];
  [@css ".css-ojzv0{transform-origin:2px;}"];
  [@css ".css-1aquei5{transform-origin:bottom;}"];
  [@css ".css-16g79kk{transform-origin:3cm 2px;}"];
  [@css ".css-1spmaf2{transform-origin:left 2px;}"];
  [@css ".css-zo5eih{transform-origin:center top;}"];
  [@css ".css-1l0uucg{transform:none;}"];
  [@css ".css-1gtanqs{width:fit-content;}"];
  [@css ".css-cf3le8{width:max-content;}"];
  [@css ".css-1ssv97v{transition-delay:240ms;}"];
  [@css ".css-vzi4el{animation-duration:150ms;}"];
  [@css ".css-14lslom{border-width:thin;}"];
  [@css ".css-1dmcl79{outline-width:medium;}"];
  [@css ".css-1saehrx{outline:medium solid red;}"];
  [@css ".css-1iid3yo{overflow:var(--var-414vlv);}"];
  [@css ".css-i6bazn{overflow:hidden;}"];
  [@css ".css-az2x0l{overflow-y:var(--var-414vlv);}"];
  [@css ".css-1kzo3b9{overflow-x:hidden;}"];
  [@css ".css-l7i9nl{overflow-block:hidden;}"];
  [@css ".css-workd7{overflow-block:var(--var-7wrrwo);}"];
  [@css ".css-mbl9bh{overflow-inline:var(--var-7wrrwo);}"];
  
  CSS.make("css-89hc5w", []);
  CSS.make("css-pdjuhq", []);
  
  CSS.make("css-1fsnuue", []);
  CSS.make("css-elo7gw", []);
  
  CSS.make("css-1n114rl", []);
  CSS.make("css-qzpbln", []);
  CSS.make("css-hhodft", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("css-10cmjql", []);
  CSS.make("css-1ojwqei", []);
  CSS.make("css-150zphb", []);
  CSS.make(
    "css-wigs7p",
    [
      ("--var-g5egjq", CSS.Types.WebkitTextFillColor.toString(colorTextString)),
    ],
  );
  CSS.make("css-cdkrf0", []);
  CSS.make("css-17grcf8", []);
  CSS.make("css-12yqiim", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("css-1ts9niw", [("--var-11dnnxw", CSS.Types.Color.toString(c))]);
  
  CSS.make("css-10ganm4", []);
  
  CSS.make("css-19xz56g", []);
  CSS.make("css-1leqhxu", []);
  
  CSS.make("css-b7rhyr", []);
  CSS.make("css-1oar2u1", []);
  
  CSS.make("css-e42auv", []);
  CSS.make("css-11wrvox", []);
  CSS.make("css-ojh4t0", []);
  CSS.make("css-1sfznxf", []);
  CSS.make("css-1uo842v", []);
  CSS.make("css-gokeqi", []);
  CSS.make("css-1ybn7nl", []);
  CSS.make("css-4rdnqv", []);
  CSS.make("css-q2y3yl", []);
  CSS.make("css-12xc5tt", []);
  CSS.make("css-1ccmo4e", []);
  CSS.make("css-tt22l4", []);
  CSS.make("css-wh5by5", []);
  CSS.make("css-1y2or4s", []);
  CSS.make("css-1l2ejxd", []);
  CSS.make("css-1obf64m", []);
  CSS.make("css-z920ed", []);
  CSS.make("css-14lu6n6", [("--var-11dnnxw", CSS.Types.Paint.toString(c))]);
  CSS.make("css-kqzqgg", []);
  CSS.make("css-lhfv11", []);
  CSS.make("css-14qxyc7", []);
  CSS.make("css-93e1eh", []);
  CSS.make("css-crrf94", []);
  CSS.make("css-1knz6hb", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `minmax((`pxFloat(10.), `auto)),
      `fitContent(`pxFloat(20.)),
      `fitContent(`pxFloat(20.)),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `minmax((`pxFloat(51.), `auto)),
      `fitContent(`pxFloat(20.)),
      `fitContent(`pxFloat(20.)),
    |]),
  );
  CSS.make("css-1stwvwy", []);
  CSS.make("css-peu6jz", []);
  CSS.make("css-1sy0xge", []);
  CSS.make("css-g27xd1", []);
  CSS.make("css-1ioybl", []);
  CSS.make("css-1h7rhel", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "css-riaouu",
    [("--var-1few37s", CSS.Types.MaskImage.toString(maskedImageUrl))],
  );
  CSS.make("css-1wjck5z", []);
  CSS.make("css-71awfw", []);
  CSS.make("css-13sc9a0", []);
  CSS.make("css-10b12fz", []);
  CSS.make("css-1fsnuue", []);
  CSS.make("css-8dn4zy", []);
  CSS.make("css-5d6l6w", []);
  CSS.make("css-1pk6z4", []);
  CSS.make("css-pdjuhq", []);
  CSS.make("css-50y1y6", []);
  CSS.make(
    "css-raxxd",
    [("--var-16dsc2j", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("css-t83v5j", []);
  CSS.make("css-13m1c45", []);
  CSS.make("css-z0sbrd", []);
  CSS.make("css-11ee94", []);
  CSS.make("css-18jf4tj", []);
  CSS.make("css-16gmm6s", []);
  CSS.make("css-11nn9hl", []);
  CSS.make("css-ojzv0", []);
  CSS.make("css-1aquei5", []);
  CSS.make("css-16g79kk", []);
  CSS.make("css-1spmaf2", []);
  CSS.make("css-zo5eih", []);
  CSS.make("css-1l0uucg", []);
  
  CSS.make("css-1gtanqs", []);
  CSS.make("css-cf3le8", []);
  
  CSS.make("css-1ssv97v", []);
  CSS.make("css-vzi4el", []);
  
  CSS.make("css-14lslom", []);
  CSS.make("css-1dmcl79", []);
  CSS.make("css-1saehrx", []);
  
  let lola = `hidden;
  CSS.make(
    "css-1iid3yo",
    [("--var-414vlv", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("css-i6bazn", []);
  CSS.make(
    "css-az2x0l",
    [("--var-414vlv", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("css-1kzo3b9", []);
  
  let value = `clip;
  CSS.make("css-l7i9nl", []);
  CSS.make(
    "css-workd7",
    [("--var-7wrrwo", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "css-mbl9bh",
    [("--var-7wrrwo", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.style([|
    CSS.backgroundImage(
      `linearGradient((
        Some(`deg(84.)),
        [|
          (Some(`hex({js|F80|js})), Some(`percent(0.))),
          (Some(`rgba((255, 255, 255, `num(0.8)))), Some(`percent(50.))),
          (Some(`hex({js|2A97FF|js})), Some(`percent(100.))),
        |]: CSS.Types.Gradient.color_stop_list,
      )),
    ),
  |]);
  
  CSS.style([|CSS.aspectRatio(`ratio((16, 9)))|]);
  
  CSS.make("css-12xc5tt", []);
  
  let interpolation = `px(10);
  CSS.style([|
    (CSS.right(interpolation): CSS.rule),
    (CSS.bottom(interpolation): CSS.rule),
  |]);

  $ dune build
