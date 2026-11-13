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
  [@css "@property --ll9dvv-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --l7z91r-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --16uona1-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --l0mgzi-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --xdvtjz-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1s96ekl-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1uhsydc-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1avczxy-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --19zd77s-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1yxuwfq-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1yxuwfq-1{syntax:\"*\";inherits:false;}"];
  [@css ".css-dbq2jz{scroll-behavior:auto;}"];
  [@css ".css-zz14sk{scroll-behavior:smooth;}"];
  [@css ".css-em2gtn{overflow-anchor:none;}"];
  [@css ".css-164rqrc{overflow-anchor:auto;}"];
  [@css ".css-ansvx5{-moz-appearance:textfield;}"];
  [@css ".css-1dk21mx{-webkit-appearance:none;}"];
  [@css ".css-1g1h5j0{-webkit-box-orient:vertical;}"];
  [@css ".css-7lncrt{-webkit-line-clamp:2;}"];
  [@css ".css-1k09ior{-webkit-overflow-scrolling:touch;}"];
  [@css ".css-1hujdil{-webkit-tap-highlight-color:transparent;}"];
  [@css ".css-ll9dvv{-webkit-text-fill-color:var(--ll9dvv-0);}"];
  [@css ".css-1646etw{-webkit-animation:none;animation:none;}"];
  [@css
    ".css-224653{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".css-a7n1si{aspect-ratio:21 / 8;}"];
  [@css ".css-l7z91r{background-color:var(--l7z91r-0);}"];
  [@css ".css-53rq5i{border:none;}"];
  [@css ".css-nsjaa5{border:1px;}"];
  [@css ".css-z9tl1e{border:thin;}"];
  [@css ".css-1c52fws{border:1px solid;}"];
  [@css ".css-djxqcr{border:thin dashed;}"];
  [@css ".css-1yk2zv8{border:1px solid black;}"];
  [@css ".css-1f9l4pf{border:thin dashed red;}"];
  [@css ".css-twweoy{border:2px dotted #333;}"];
  [@css ".css-6ro3t4{border:medium double blue;}"];
  [@css ".css-u7vvb7{bottom:unset;}"];
  [@css ".css-hlv71f{box-shadow:none;}"];
  [@css ".css-1wzeoos{break-inside:avoid;}"];
  [@css ".css-lywbfh{caret-color:#e15a46;}"];
  [@css ".css-1a660f5{color:inherit;}"];
  [@css ".css-ci5ddf{color:var(--color-link);}"];
  [@css ".css-1teubnz{-webkit-column-width:125px;column-width:125px;}"];
  [@css ".css-1qb1fge{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".css-1dcm73n{counter-increment:ol;}"];
  [@css ".css-fyqn40{counter-reset:ol;}"];
  [@css ".css-1hb35za{display:-webkit-box;}"];
  [@css ".css-1x6lno9{display:contents;}"];
  [@css ".css-kzx61y{display:table;}"];
  [@css ".css-16uona1{fill:var(--16uona1-0);}"];
  [@css ".css-peqf0f{fill:currentColor;}"];
  [@css ".css-1axvugo{gap:4px;}"];
  [@css ".css-ixen1n{grid-column-end:span 2;}"];
  [@css ".css-1kywmpm{-ms-grid-column:unset;grid-column:unset;}"];
  [@css ".css-1mu741h{-ms-grid-row:unset;grid-row:unset;}"];
  [@css ".css-kfvcds{grid-template-columns:max-content max-content;}"];
  [@css
    ".css-ocmpyl{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css
    ".css-1lcr6y2{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css ".css-m0dfgi{grid-template-columns:repeat(2, auto);}"];
  [@css ".css-1br12s9{grid-template-columns:repeat(3, auto);}"];
  [@css
    ".css-10w0b28{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css ".css-ve4a68{justify-items:start;}"];
  [@css ".css-1aehxh3{justify-self:unset;}"];
  [@css ".css-1dsfit4{left:unset;}"];
  [@css
    ".css-l0mgzi{-webkit-mask-image:var(--l0mgzi-0);mask-image:var(--l0mgzi-0);}"
  ];
  [@css
    ".css-1q6sxd6{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".css-11xtnvx{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".css-wri28a{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css ".css-eigcvk{outline:none;}"];
  [@css ".css-1q2np8a{position:unset;}"];
  [@css ".css-19sgvj{resize:none;}"];
  [@css ".css-pfspc8{right:calc(50% - 4px);}"];
  [@css ".css-15n2m1n{stroke-opacity:0;}"];
  [@css ".css-xdvtjz{stroke:var(--xdvtjz-0);}"];
  [@css ".css-1qrsadm{top:calc(50% - 1px);}"];
  [@css ".css-1pr1m4m{top:unset;}"];
  [@css ".css-ovmsds{touch-action:none;}"];
  [@css ".css-4ahy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-1q4ytd6{transform-origin:center bottom;}"];
  [@css ".css-xgm8a9{transform-origin:center left;}"];
  [@css ".css-p825y1{transform-origin:center right;}"];
  [@css ".css-3el2mm{transform-origin:2px;}"];
  [@css ".css-ydo0ab{transform-origin:bottom;}"];
  [@css ".css-1fbnfn2{transform-origin:3cm 2px;}"];
  [@css ".css-i0yo2t{transform-origin:left 2px;}"];
  [@css ".css-4oat6h{transform-origin:center top;}"];
  [@css
    ".css-1dol3wd{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".css-ns27kc{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-11ss374{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css ".css-lkzt60{transition-delay:240ms;}"];
  [@css
    ".css-1k2stl3{-webkit-animation-duration:150ms;animation-duration:150ms;}"
  ];
  [@css ".css-10a5uq1{border-width:thin;}"];
  [@css ".css-1v4cs04{outline-width:medium;}"];
  [@css ".css-kblqik{outline:medium solid red;}"];
  [@css ".css-1s96ekl{overflow:var(--1s96ekl-0);}"];
  [@css ".css-cd2p31{overflow:hidden;}"];
  [@css ".css-1uhsydc{overflow-y:var(--1uhsydc-0);}"];
  [@css ".css-1qcwnv3{overflow-x:hidden;}"];
  [@css ".css-1a5za4x{overflow-block:hidden;}"];
  [@css ".css-1avczxy{overflow-block:var(--1avczxy-0);}"];
  [@css ".css-19zd77s{overflow-inline:var(--19zd77s-0);}"];
  [@css
    ".css-17artor{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}"
  ];
  [@css ".css-7sbi16{aspect-ratio:16 / 9;}"];
  [@css ".css-1yxuwfq{right:var(--1yxuwfq-0);bottom:var(--1yxuwfq-1);}"];
  [@css.classes
    [
      ("css-dbq2jz", 11, "", "input.re", 2, 8, 2, 29),
      ("css-zz14sk", 12, "", "input.re", 3, 8, 3, 31),
      ("css-em2gtn", 13, "", "input.re", 6, 8, 6, 29),
      ("css-164rqrc", 14, "", "input.re", 7, 8, 7, 29),
      ("css-ansvx5", 15, "", "input.re", 9, 8, 9, 35),
      ("css-1dk21mx", 16, "", "input.re", 10, 8, 10, 33),
      ("css-1g1h5j0", 17, "", "input.re", 11, 8, 11, 37),
      ("css-7lncrt", 18, "", "input.re", 23, 8, 23, 30),
      ("css-1k09ior", 19, "", "input.re", 24, 8, 24, 42),
      ("css-1hujdil", 20, "", "input.re", 25, 8, 25, 49),
      ("css-ll9dvv", 21, "", "input.re", 26, 8, 26, 52),
      ("css-1646etw", 22, "", "input.re", 27, 8, 27, 24),
      ("css-224653", 23, "", "input.re", 28, 8, 28, 25),
      ("css-a7n1si", 24, "", "input.re", 29, 8, 29, 29),
      ("css-l7z91r", 25, "", "input.re", 32, 8, 32, 31),
      ("css-53rq5i", 26, "", "input.re", 36, 8, 36, 20),
      ("css-nsjaa5", 27, "", "input.re", 38, 8, 38, 19),
      ("css-z9tl1e", 28, "", "input.re", 39, 8, 39, 20),
      ("css-1c52fws", 29, "", "input.re", 41, 8, 41, 25),
      ("css-djxqcr", 30, "", "input.re", 42, 8, 42, 27),
      ("css-1yk2zv8", 31, "", "input.re", 44, 8, 44, 31),
      ("css-1f9l4pf", 32, "", "input.re", 45, 8, 45, 31),
      ("css-twweoy", 33, "", "input.re", 46, 8, 46, 31),
      ("css-6ro3t4", 34, "", "input.re", 47, 8, 47, 34),
      ("css-u7vvb7", 35, "", "input.re", 48, 8, 48, 22),
      ("css-hlv71f", 36, "", "input.re", 49, 8, 49, 25),
      ("css-1wzeoos", 37, "", "input.re", 50, 8, 50, 28),
      ("css-lywbfh", 38, "", "input.re", 51, 8, 51, 29),
      ("css-1a660f5", 39, "", "input.re", 52, 8, 52, 23),
      ("css-ci5ddf", 40, "", "input.re", 53, 8, 53, 33),
      ("css-1teubnz", 41, "", "input.re", 54, 8, 54, 28),
      ("css-1qb1fge", 42, "", "input.re", 55, 8, 55, 27),
      ("css-1dcm73n", 43, "", "input.re", 56, 8, 56, 30),
      ("css-fyqn40", 44, "", "input.re", 57, 8, 57, 26),
      ("css-1hb35za", 45, "", "input.re", 58, 8, 58, 29),
      ("css-1x6lno9", 46, "", "input.re", 59, 8, 59, 26),
      ("css-kzx61y", 47, "", "input.re", 60, 8, 60, 23),
      ("css-16uona1", 48, "", "input.re", 61, 8, 61, 19),
      ("css-peqf0f", 49, "", "input.re", 62, 8, 62, 27),
      ("css-1axvugo", 50, "", "input.re", 63, 8, 63, 17),
      ("css-ixen1n", 51, "", "input.re", 64, 8, 64, 32),
      ("css-1kywmpm", 52, "", "input.re", 65, 8, 65, 27),
      ("css-1mu741h", 53, "", "input.re", 66, 8, 66, 24),
      ("css-kfvcds", 54, "", "input.re", 67, 8, 67, 55),
      ("css-ocmpyl", 55, "", "input.re", 69, 4, 69, 82),
      ("css-1lcr6y2", 56, "", "input.re", 72, 4, 72, 82),
      ("css-m0dfgi", 57, "", "input.re", 74, 8, 74, 47),
      ("css-1br12s9", 58, "", "input.re", 75, 8, 75, 47),
      ("css-10w0b28", 59, "", "input.re", 76, 8, 76, 28),
      ("css-ve4a68", 60, "", "input.re", 77, 8, 77, 29),
      ("css-1aehxh3", 61, "", "input.re", 78, 8, 78, 28),
      ("css-1dsfit4", 62, "", "input.re", 79, 8, 79, 20),
      ("css-l0mgzi", 63, "", "input.re", 81, 8, 81, 38),
      ("css-1q6sxd6", 64, "", "input.re", 82, 8, 82, 37),
      ("css-11xtnvx", 65, "", "input.re", 83, 8, 83, 31),
      ("css-wri28a", 66, "", "input.re", 84, 8, 84, 31),
      ("css-eigcvk", 67, "", "input.re", 85, 8, 85, 22),
      ("css-1q2np8a", 68, "", "input.re", 87, 8, 87, 24),
      ("css-19sgvj", 69, "", "input.re", 88, 8, 88, 21),
      ("css-pfspc8", 70, "", "input.re", 89, 8, 89, 31),
      ("css-15n2m1n", 71, "", "input.re", 91, 8, 91, 26),
      ("css-xdvtjz", 72, "", "input.re", 92, 8, 92, 30),
      ("css-1qrsadm", 73, "", "input.re", 93, 8, 93, 29),
      ("css-1pr1m4m", 74, "", "input.re", 94, 8, 94, 19),
      ("css-ovmsds", 75, "", "input.re", 95, 8, 95, 27),
      ("css-4ahy0g", 76, "", "input.re", 96, 8, 96, 34),
      ("css-1q4ytd6", 77, "", "input.re", 97, 8, 97, 40),
      ("css-xgm8a9", 78, "", "input.re", 98, 8, 98, 38),
      ("css-p825y1", 79, "", "input.re", 99, 8, 99, 39),
      ("css-3el2mm", 80, "", "input.re", 100, 8, 100, 30),
      ("css-ydo0ab", 81, "", "input.re", 101, 8, 101, 33),
      ("css-1fbnfn2", 82, "", "input.re", 102, 8, 102, 34),
      ("css-i0yo2t", 83, "", "input.re", 103, 8, 103, 35),
      ("css-4oat6h", 84, "", "input.re", 104, 8, 104, 37),
      ("css-1dol3wd", 85, "", "input.re", 105, 8, 105, 24),
      ("css-ns27kc", 86, "", "input.re", 107, 8, 107, 27),
      ("css-11ss374", 87, "", "input.re", 108, 8, 108, 27),
      ("css-lkzt60", 88, "", "input.re", 110, 8, 110, 31),
      ("css-1k2stl3", 89, "", "input.re", 111, 8, 111, 33),
      ("css-10a5uq1", 90, "", "input.re", 115, 8, 115, 26),
      ("css-1v4cs04", 91, "", "input.re", 116, 8, 116, 29),
      ("css-kblqik", 92, "", "input.re", 117, 8, 117, 33),
      ("css-1s96ekl", 93, "", "input.re", 121, 8, 121, 25),
      ("css-cd2p31", 94, "", "input.re", 122, 8, 122, 24),
      ("css-1uhsydc", 95, "", "input.re", 123, 8, 123, 27),
      ("css-1qcwnv3", 96, "", "input.re", 124, 8, 124, 26),
      ("css-1a5za4x", 97, "", "input.re", 127, 8, 127, 30),
      ("css-1avczxy", 98, "", "input.re", 128, 8, 128, 32),
      ("css-19zd77s", 99, "", "input.re", 129, 8, 129, 33),
      ("css-17artor", 100, "", "input.re", 133, 4, 134, 2),
      ("css-7sbi16", 101, "", "input.re", 137, 8, 137, 29),
      ("css-1yxuwfq", 102, "", "input.re", 143, 4, 145, 2),
    ]
  ];
  
  CSS.make("css-dbq2jz", []);
  CSS.make("css-zz14sk", []);
  
  CSS.make("css-em2gtn", []);
  CSS.make("css-164rqrc", []);
  
  CSS.make("css-ansvx5", []);
  CSS.make("css-1dk21mx", []);
  CSS.make("css-1g1h5j0", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("css-7lncrt", []);
  CSS.make("css-1k09ior", []);
  CSS.make("css-1hujdil", []);
  CSS.make(
    "css-ll9dvv",
    [("--ll9dvv-0", CSS.Types.WebkitTextFillColor.toString(colorTextString))],
  );
  CSS.make("css-1646etw", []);
  CSS.make("css-224653", []);
  CSS.make("css-a7n1si", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("css-l7z91r", [("--l7z91r-0", CSS.Types.Color.toString(c))]);
  
  CSS.make("css-53rq5i", []);
  
  CSS.make("css-nsjaa5", []);
  CSS.make("css-z9tl1e", []);
  
  CSS.make("css-1c52fws", []);
  CSS.make("css-djxqcr", []);
  
  CSS.make("css-1yk2zv8", []);
  CSS.make("css-1f9l4pf", []);
  CSS.make("css-twweoy", []);
  CSS.make("css-6ro3t4", []);
  CSS.make("css-u7vvb7", []);
  CSS.make("css-hlv71f", []);
  CSS.make("css-1wzeoos", []);
  CSS.make("css-lywbfh", []);
  CSS.make("css-1a660f5", []);
  CSS.make("css-ci5ddf", []);
  CSS.make("css-1teubnz", []);
  CSS.make("css-1qb1fge", []);
  CSS.make("css-1dcm73n", []);
  CSS.make("css-fyqn40", []);
  CSS.make("css-1hb35za", []);
  CSS.make("css-1x6lno9", []);
  CSS.make("css-kzx61y", []);
  CSS.make("css-16uona1", [("--16uona1-0", CSS.Types.Paint.toString(c))]);
  CSS.make("css-peqf0f", []);
  CSS.make("css-1axvugo", []);
  CSS.make("css-ixen1n", []);
  CSS.make("css-1kywmpm", []);
  CSS.make("css-1mu741h", []);
  CSS.make("css-kfvcds", []);
  CSS.make("css-ocmpyl", []);
  CSS.make("css-1lcr6y2", []);
  CSS.make("css-m0dfgi", []);
  CSS.make("css-1br12s9", []);
  CSS.make("css-10w0b28", []);
  CSS.make("css-ve4a68", []);
  CSS.make("css-1aehxh3", []);
  CSS.make("css-1dsfit4", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "css-l0mgzi",
    [("--l0mgzi-0", CSS.Types.MaskImage.toString(maskedImageUrl))],
  );
  CSS.make("css-1q6sxd6", []);
  CSS.make("css-11xtnvx", []);
  CSS.make("css-wri28a", []);
  CSS.make("css-eigcvk", []);
  CSS.make("css-em2gtn", []);
  CSS.make("css-1q2np8a", []);
  CSS.make("css-19sgvj", []);
  CSS.make("css-pfspc8", []);
  CSS.make("css-zz14sk", []);
  CSS.make("css-15n2m1n", []);
  CSS.make(
    "css-xdvtjz",
    [("--xdvtjz-0", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("css-1qrsadm", []);
  CSS.make("css-1pr1m4m", []);
  CSS.make("css-ovmsds", []);
  CSS.make("css-4ahy0g", []);
  CSS.make("css-1q4ytd6", []);
  CSS.make("css-xgm8a9", []);
  CSS.make("css-p825y1", []);
  CSS.make("css-3el2mm", []);
  CSS.make("css-ydo0ab", []);
  CSS.make("css-1fbnfn2", []);
  CSS.make("css-i0yo2t", []);
  CSS.make("css-4oat6h", []);
  CSS.make("css-1dol3wd", []);
  
  CSS.make("css-ns27kc", []);
  CSS.make("css-11ss374", []);
  
  CSS.make("css-lkzt60", []);
  CSS.make("css-1k2stl3", []);
  
  CSS.make("css-10a5uq1", []);
  CSS.make("css-1v4cs04", []);
  CSS.make("css-kblqik", []);
  
  let lola = `hidden;
  CSS.make(
    "css-1s96ekl",
    [("--1s96ekl-0", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("css-cd2p31", []);
  CSS.make(
    "css-1uhsydc",
    [("--1uhsydc-0", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("css-1qcwnv3", []);
  
  let value = `clip;
  CSS.make("css-1a5za4x", []);
  CSS.make(
    "css-1avczxy",
    [("--1avczxy-0", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "css-19zd77s",
    [("--19zd77s-0", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("css-17artor", []);
  
  CSS.make("css-7sbi16", []);
  
  CSS.make("css-ci5ddf", []);
  
  let interpolation = `px(10);
  CSS.make(
    "css-1yxuwfq",
    [
      ("--1yxuwfq-0", CSS.Types.Right.toString(interpolation)),
      ("--1yxuwfq-1", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
