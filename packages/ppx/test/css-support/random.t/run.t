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
  [@css "@property --ivpcys1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcqlt{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcpmt{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcufi{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcm3j{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpckcm{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcgfg{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcr80{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc95h{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcv9v{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcxd9{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpc2jz{scroll-behavior:auto;}"];
  [@css ".css-ivpc4sk{scroll-behavior:smooth;}"];
  [@css ".css-ivpcgtn{overflow-anchor:none;}"];
  [@css ".css-ivpcqrc{overflow-anchor:auto;}"];
  [@css ".css-ivpcvx5{-moz-appearance:textfield;}"];
  [@css ".css-ivpc1mx{-webkit-appearance:none;}"];
  [@css ".css-ivpc5j0{-webkit-box-orient:vertical;}"];
  [@css ".css-ivpccrt{-webkit-line-clamp:2;}"];
  [@css ".css-ivpcior{-webkit-overflow-scrolling:touch;}"];
  [@css ".css-ivpcdil{-webkit-tap-highlight-color:transparent;}"];
  [@css ".css-ivpc9u8{-webkit-text-fill-color:var(--ivpcys1);}"];
  [@css ".css-ivpcetw{-webkit-animation:none;animation:none;}"];
  [@css
    ".css-ivpc653{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".css-ivpc1si{aspect-ratio:21 / 8;}"];
  [@css ".css-ivpcc06{background-color:var(--ivpcqlt);}"];
  [@css ".css-ivpcq5i{border:none;}"];
  [@css ".css-ivpcaa5{border:1px;}"];
  [@css ".css-ivpcl1e{border:thin;}"];
  [@css ".css-ivpcfws{border:1px solid;}"];
  [@css ".css-ivpcqcr{border:thin dashed;}"];
  [@css ".css-ivpczv8{border:1px solid black;}"];
  [@css ".css-ivpc4pf{border:thin dashed red;}"];
  [@css ".css-ivpceoy{border:2px dotted #333;}"];
  [@css ".css-ivpc3t4{border:medium double blue;}"];
  [@css ".css-ivpcvb7{bottom:unset;}"];
  [@css ".css-ivpc71f{box-shadow:none;}"];
  [@css ".css-ivpcoos{break-inside:avoid;}"];
  [@css ".css-ivpcbfh{caret-color:#e15a46;}"];
  [@css ".css-ivpc0f5{color:inherit;}"];
  [@css ".css-ivpcddf{color:var(--color-link);}"];
  [@css ".css-ivpcbnz{-webkit-column-width:125px;column-width:125px;}"];
  [@css ".css-ivpcfge{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".css-ivpc73n{counter-increment:ol;}"];
  [@css ".css-ivpcn40{counter-reset:ol;}"];
  [@css ".css-ivpc5za{display:-webkit-box;}"];
  [@css ".css-ivpcno9{display:contents;}"];
  [@css ".css-ivpc61y{display:table;}"];
  [@css ".css-ivpc5xi{fill:var(--ivpcpmt);}"];
  [@css ".css-ivpcf0f{fill:currentColor;}"];
  [@css ".css-ivpcugo{gap:4px;}"];
  [@css ".css-ivpcn1n{grid-column-end:span 2;}"];
  [@css ".css-ivpcmpm{-ms-grid-column:unset;grid-column:unset;}"];
  [@css ".css-ivpc41h{-ms-grid-row:unset;grid-row:unset;}"];
  [@css ".css-ivpccds{grid-template-columns:max-content max-content;}"];
  [@css
    ".css-ivpcpyl{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css
    ".css-ivpc6y2{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}"
  ];
  [@css ".css-ivpcfgi{grid-template-columns:repeat(2, auto);}"];
  [@css ".css-ivpc2s9{grid-template-columns:repeat(3, auto);}"];
  [@css
    ".css-ivpcb28{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css ".css-ivpca68{justify-items:start;}"];
  [@css ".css-ivpcxh3{justify-self:unset;}"];
  [@css ".css-ivpcit4{left:unset;}"];
  [@css
    ".css-ivpc73h{-webkit-mask-image:var(--ivpcufi);mask-image:var(--ivpcufi);}"
  ];
  [@css
    ".css-ivpcxd6{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".css-ivpcnvx{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".css-ivpc28a{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css ".css-ivpccvk{outline:none;}"];
  [@css ".css-ivpcp8a{position:unset;}"];
  [@css ".css-ivpcgvj{resize:none;}"];
  [@css ".css-ivpcpc8{right:calc(50% - 4px);}"];
  [@css ".css-ivpcm1n{stroke-opacity:0;}"];
  [@css ".css-ivpc5st{stroke:var(--ivpcm3j);}"];
  [@css ".css-ivpcadm{top:calc(50% - 1px);}"];
  [@css ".css-ivpcm4m{top:unset;}"];
  [@css ".css-ivpcsds{touch-action:none;}"];
  [@css ".css-ivpcy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-ivpctd6{transform-origin:center bottom;}"];
  [@css ".css-ivpc8a9{transform-origin:center left;}"];
  [@css ".css-ivpc5y1{transform-origin:center right;}"];
  [@css ".css-ivpc2mm{transform-origin:2px;}"];
  [@css ".css-ivpc0ab{transform-origin:bottom;}"];
  [@css ".css-ivpcfn2{transform-origin:3cm 2px;}"];
  [@css ".css-ivpco2t{transform-origin:left 2px;}"];
  [@css ".css-ivpct6h{transform-origin:center top;}"];
  [@css
    ".css-ivpc3wd{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".css-ivpc7kc{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-ivpc374{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css ".css-ivpct60{transition-delay:240ms;}"];
  [@css
    ".css-ivpctl3{-webkit-animation-duration:150ms;animation-duration:150ms;}"
  ];
  [@css ".css-ivpcuq1{border-width:thin;}"];
  [@css ".css-ivpcs04{outline-width:medium;}"];
  [@css ".css-ivpcqik{outline:medium solid red;}"];
  [@css ".css-ivpc6xw{overflow:var(--ivpckcm);}"];
  [@css ".css-ivpcp31{overflow:hidden;}"];
  [@css ".css-ivpcu0v{overflow-y:var(--ivpcgfg);}"];
  [@css ".css-ivpcnv3{overflow-x:hidden;}"];
  [@css ".css-ivpca4x{overflow-block:hidden;}"];
  [@css ".css-ivpcg75{overflow-block:var(--ivpcr80);}"];
  [@css ".css-ivpc526{overflow-inline:var(--ivpc95h);}"];
  [@css
    ".css-ivpctor{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}"
  ];
  [@css ".css-ivpci16{aspect-ratio:16 / 9;}"];
  [@css ".css-ivpc4nk{right:var(--ivpcv9v);bottom:var(--ivpcxd9);}"];
  [@css.classes
    [
      ("css-ivpc2jz", 11, "", "input.re", 2, 8, 2, 29),
      ("css-ivpc4sk", 12, "", "input.re", 3, 8, 3, 31),
      ("css-ivpcgtn", 13, "", "input.re", 6, 8, 6, 29),
      ("css-ivpcqrc", 14, "", "input.re", 7, 8, 7, 29),
      ("css-ivpcvx5", 15, "", "input.re", 9, 8, 9, 35),
      ("css-ivpc1mx", 16, "", "input.re", 10, 8, 10, 33),
      ("css-ivpc5j0", 17, "", "input.re", 11, 8, 11, 37),
      ("css-ivpccrt", 18, "", "input.re", 23, 8, 23, 30),
      ("css-ivpcior", 19, "", "input.re", 24, 8, 24, 42),
      ("css-ivpcdil", 20, "", "input.re", 25, 8, 25, 49),
      ("css-ivpc9u8", 21, "", "input.re", 26, 8, 26, 52),
      ("css-ivpcetw", 22, "", "input.re", 27, 8, 27, 24),
      ("css-ivpc653", 23, "", "input.re", 28, 8, 28, 25),
      ("css-ivpc1si", 24, "", "input.re", 29, 8, 29, 29),
      ("css-ivpcc06", 25, "", "input.re", 32, 8, 32, 31),
      ("css-ivpcq5i", 26, "", "input.re", 36, 8, 36, 20),
      ("css-ivpcaa5", 27, "", "input.re", 38, 8, 38, 19),
      ("css-ivpcl1e", 28, "", "input.re", 39, 8, 39, 20),
      ("css-ivpcfws", 29, "", "input.re", 41, 8, 41, 25),
      ("css-ivpcqcr", 30, "", "input.re", 42, 8, 42, 27),
      ("css-ivpczv8", 31, "", "input.re", 44, 8, 44, 31),
      ("css-ivpc4pf", 32, "", "input.re", 45, 8, 45, 31),
      ("css-ivpceoy", 33, "", "input.re", 46, 8, 46, 31),
      ("css-ivpc3t4", 34, "", "input.re", 47, 8, 47, 34),
      ("css-ivpcvb7", 35, "", "input.re", 48, 8, 48, 22),
      ("css-ivpc71f", 36, "", "input.re", 49, 8, 49, 25),
      ("css-ivpcoos", 37, "", "input.re", 50, 8, 50, 28),
      ("css-ivpcbfh", 38, "", "input.re", 51, 8, 51, 29),
      ("css-ivpc0f5", 39, "", "input.re", 52, 8, 52, 23),
      ("css-ivpcddf", 40, "", "input.re", 53, 8, 53, 33),
      ("css-ivpcbnz", 41, "", "input.re", 54, 8, 54, 28),
      ("css-ivpcfge", 42, "", "input.re", 55, 8, 55, 27),
      ("css-ivpc73n", 43, "", "input.re", 56, 8, 56, 30),
      ("css-ivpcn40", 44, "", "input.re", 57, 8, 57, 26),
      ("css-ivpc5za", 45, "", "input.re", 58, 8, 58, 29),
      ("css-ivpcno9", 46, "", "input.re", 59, 8, 59, 26),
      ("css-ivpc61y", 47, "", "input.re", 60, 8, 60, 23),
      ("css-ivpc5xi", 48, "", "input.re", 61, 8, 61, 19),
      ("css-ivpcf0f", 49, "", "input.re", 62, 8, 62, 27),
      ("css-ivpcugo", 50, "", "input.re", 63, 8, 63, 17),
      ("css-ivpcn1n", 51, "", "input.re", 64, 8, 64, 32),
      ("css-ivpcmpm", 52, "", "input.re", 65, 8, 65, 27),
      ("css-ivpc41h", 53, "", "input.re", 66, 8, 66, 24),
      ("css-ivpccds", 54, "", "input.re", 67, 8, 67, 55),
      ("css-ivpcpyl", 55, "", "input.re", 69, 4, 69, 82),
      ("css-ivpc6y2", 56, "", "input.re", 72, 4, 72, 82),
      ("css-ivpcfgi", 57, "", "input.re", 74, 8, 74, 47),
      ("css-ivpc2s9", 58, "", "input.re", 75, 8, 75, 47),
      ("css-ivpcb28", 59, "", "input.re", 76, 8, 76, 28),
      ("css-ivpca68", 60, "", "input.re", 77, 8, 77, 29),
      ("css-ivpcxh3", 61, "", "input.re", 78, 8, 78, 28),
      ("css-ivpcit4", 62, "", "input.re", 79, 8, 79, 20),
      ("css-ivpc73h", 63, "", "input.re", 81, 8, 81, 38),
      ("css-ivpcxd6", 64, "", "input.re", 82, 8, 82, 37),
      ("css-ivpcnvx", 65, "", "input.re", 83, 8, 83, 31),
      ("css-ivpc28a", 66, "", "input.re", 84, 8, 84, 31),
      ("css-ivpccvk", 67, "", "input.re", 85, 8, 85, 22),
      ("css-ivpcp8a", 68, "", "input.re", 87, 8, 87, 24),
      ("css-ivpcgvj", 69, "", "input.re", 88, 8, 88, 21),
      ("css-ivpcpc8", 70, "", "input.re", 89, 8, 89, 31),
      ("css-ivpcm1n", 71, "", "input.re", 91, 8, 91, 26),
      ("css-ivpc5st", 72, "", "input.re", 92, 8, 92, 30),
      ("css-ivpcadm", 73, "", "input.re", 93, 8, 93, 29),
      ("css-ivpcm4m", 74, "", "input.re", 94, 8, 94, 19),
      ("css-ivpcsds", 75, "", "input.re", 95, 8, 95, 27),
      ("css-ivpcy0g", 76, "", "input.re", 96, 8, 96, 34),
      ("css-ivpctd6", 77, "", "input.re", 97, 8, 97, 40),
      ("css-ivpc8a9", 78, "", "input.re", 98, 8, 98, 38),
      ("css-ivpc5y1", 79, "", "input.re", 99, 8, 99, 39),
      ("css-ivpc2mm", 80, "", "input.re", 100, 8, 100, 30),
      ("css-ivpc0ab", 81, "", "input.re", 101, 8, 101, 33),
      ("css-ivpcfn2", 82, "", "input.re", 102, 8, 102, 34),
      ("css-ivpco2t", 83, "", "input.re", 103, 8, 103, 35),
      ("css-ivpct6h", 84, "", "input.re", 104, 8, 104, 37),
      ("css-ivpc3wd", 85, "", "input.re", 105, 8, 105, 24),
      ("css-ivpc7kc", 86, "", "input.re", 107, 8, 107, 27),
      ("css-ivpc374", 87, "", "input.re", 108, 8, 108, 27),
      ("css-ivpct60", 88, "", "input.re", 110, 8, 110, 31),
      ("css-ivpctl3", 89, "", "input.re", 111, 8, 111, 33),
      ("css-ivpcuq1", 90, "", "input.re", 115, 8, 115, 26),
      ("css-ivpcs04", 91, "", "input.re", 116, 8, 116, 29),
      ("css-ivpcqik", 92, "", "input.re", 117, 8, 117, 33),
      ("css-ivpc6xw", 93, "", "input.re", 121, 8, 121, 25),
      ("css-ivpcp31", 94, "", "input.re", 122, 8, 122, 24),
      ("css-ivpcu0v", 95, "", "input.re", 123, 8, 123, 27),
      ("css-ivpcnv3", 96, "", "input.re", 124, 8, 124, 26),
      ("css-ivpca4x", 97, "", "input.re", 127, 8, 127, 30),
      ("css-ivpcg75", 98, "", "input.re", 128, 8, 128, 32),
      ("css-ivpc526", 99, "", "input.re", 129, 8, 129, 33),
      ("css-ivpctor", 100, "", "input.re", 133, 4, 134, 2),
      ("css-ivpci16", 101, "", "input.re", 137, 8, 137, 29),
      ("css-ivpc4nk", 102, "", "input.re", 143, 4, 145, 2),
    ]
  ];
  
  CSS.make("css-ivpc2jz", []);
  CSS.make("css-ivpc4sk", []);
  
  CSS.make("css-ivpcgtn", []);
  CSS.make("css-ivpcqrc", []);
  
  CSS.make("css-ivpcvx5", []);
  CSS.make("css-ivpc1mx", []);
  CSS.make("css-ivpc5j0", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("css-ivpccrt", []);
  CSS.make("css-ivpcior", []);
  CSS.make("css-ivpcdil", []);
  CSS.make(
    "css-ivpc9u8",
    [("--ivpcys1", CSS.Types.WebkitTextFillColor.toString(colorTextString))],
  );
  CSS.make("css-ivpcetw", []);
  CSS.make("css-ivpc653", []);
  CSS.make("css-ivpc1si", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("css-ivpcc06", [("--ivpcqlt", CSS.Types.Color.toString(c))]);
  
  CSS.make("css-ivpcq5i", []);
  
  CSS.make("css-ivpcaa5", []);
  CSS.make("css-ivpcl1e", []);
  
  CSS.make("css-ivpcfws", []);
  CSS.make("css-ivpcqcr", []);
  
  CSS.make("css-ivpczv8", []);
  CSS.make("css-ivpc4pf", []);
  CSS.make("css-ivpceoy", []);
  CSS.make("css-ivpc3t4", []);
  CSS.make("css-ivpcvb7", []);
  CSS.make("css-ivpc71f", []);
  CSS.make("css-ivpcoos", []);
  CSS.make("css-ivpcbfh", []);
  CSS.make("css-ivpc0f5", []);
  CSS.make("css-ivpcddf", []);
  CSS.make("css-ivpcbnz", []);
  CSS.make("css-ivpcfge", []);
  CSS.make("css-ivpc73n", []);
  CSS.make("css-ivpcn40", []);
  CSS.make("css-ivpc5za", []);
  CSS.make("css-ivpcno9", []);
  CSS.make("css-ivpc61y", []);
  CSS.make("css-ivpc5xi", [("--ivpcpmt", CSS.Types.Paint.toString(c))]);
  CSS.make("css-ivpcf0f", []);
  CSS.make("css-ivpcugo", []);
  CSS.make("css-ivpcn1n", []);
  CSS.make("css-ivpcmpm", []);
  CSS.make("css-ivpc41h", []);
  CSS.make("css-ivpccds", []);
  CSS.make("css-ivpcpyl", []);
  CSS.make("css-ivpc6y2", []);
  CSS.make("css-ivpcfgi", []);
  CSS.make("css-ivpc2s9", []);
  CSS.make("css-ivpcb28", []);
  CSS.make("css-ivpca68", []);
  CSS.make("css-ivpcxh3", []);
  CSS.make("css-ivpcit4", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "css-ivpc73h",
    [("--ivpcufi", CSS.Types.MaskImage.toString(maskedImageUrl))],
  );
  CSS.make("css-ivpcxd6", []);
  CSS.make("css-ivpcnvx", []);
  CSS.make("css-ivpc28a", []);
  CSS.make("css-ivpccvk", []);
  CSS.make("css-ivpcgtn", []);
  CSS.make("css-ivpcp8a", []);
  CSS.make("css-ivpcgvj", []);
  CSS.make("css-ivpcpc8", []);
  CSS.make("css-ivpc4sk", []);
  CSS.make("css-ivpcm1n", []);
  CSS.make(
    "css-ivpc5st",
    [("--ivpcm3j", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("css-ivpcadm", []);
  CSS.make("css-ivpcm4m", []);
  CSS.make("css-ivpcsds", []);
  CSS.make("css-ivpcy0g", []);
  CSS.make("css-ivpctd6", []);
  CSS.make("css-ivpc8a9", []);
  CSS.make("css-ivpc5y1", []);
  CSS.make("css-ivpc2mm", []);
  CSS.make("css-ivpc0ab", []);
  CSS.make("css-ivpcfn2", []);
  CSS.make("css-ivpco2t", []);
  CSS.make("css-ivpct6h", []);
  CSS.make("css-ivpc3wd", []);
  
  CSS.make("css-ivpc7kc", []);
  CSS.make("css-ivpc374", []);
  
  CSS.make("css-ivpct60", []);
  CSS.make("css-ivpctl3", []);
  
  CSS.make("css-ivpcuq1", []);
  CSS.make("css-ivpcs04", []);
  CSS.make("css-ivpcqik", []);
  
  let lola = `hidden;
  CSS.make(
    "css-ivpc6xw",
    [("--ivpckcm", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("css-ivpcp31", []);
  CSS.make(
    "css-ivpcu0v",
    [("--ivpcgfg", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("css-ivpcnv3", []);
  
  let value = `clip;
  CSS.make("css-ivpca4x", []);
  CSS.make(
    "css-ivpcg75",
    [("--ivpcr80", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "css-ivpc526",
    [("--ivpc95h", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("css-ivpctor", []);
  
  CSS.make("css-ivpci16", []);
  
  CSS.make("css-ivpcddf", []);
  
  let interpolation = `px(10);
  CSS.make(
    "css-ivpc4nk",
    [
      ("--ivpcv9v", CSS.Types.Right.toString(interpolation)),
      ("--ivpcxd9", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
