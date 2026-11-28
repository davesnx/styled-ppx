Interpolation native PPX transformations are checked as a cram snapshot.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- -no-merge)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --ivpcipf{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc6rn{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc85e{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcegk{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcxfj{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpctcz{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcawq{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpclur{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpceau{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc4j1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc9qc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcmj7{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcm4m{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcq7c{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpceab{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcr5a{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc4cc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpckm4{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc8es{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcgax{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpccf9{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcqb7{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcvro{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcaet{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcq3e{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpch4h{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc7pw{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc4bc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcy50{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcy7j{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcehe{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcxzg{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcjlo{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcih1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcnw2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcdjr{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpch0q{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcbiv{color:var(--ivpcipf);}"];
  [@css ".css-ivpccz1{margin:var(--ivpc6rn) var(--ivpc85e);}"];
  [@css ".css-ivpchb6{padding:var(--ivpcegk) 0px;}"];
  [@css ".css-ivpcs46{border:1px solid var(--ivpcxfj);}"];
  [@css ".css-ivpcat8{outline:1px solid var(--ivpctcz);}"];
  [@css ".css-ivpc570{border-bottom:0px solid var(--ivpcawq);}"];
  [@css ".css-ivpcc09{width:var(--ivpclur);}"];
  [@css ".css-ivpcnlv{max-width:var(--ivpceau);}"];
  [@css ".css-ivpc0is{height:var(--ivpc4j1);}"];
  [@css ".css-ivpcjog{border-radius:var(--ivpc9qc);}"];
  [@css ".css-ivpcbg8{font-size:var(--ivpcmj7);}"];
  [@css ".css-ivpc7s5{font-family:var(--ivpcm4m);}"];
  [@css ".css-ivpcci4{line-height:var(--ivpcq7c);}"];
  [@css ".css-ivpcirk{z-index:var(--ivpceab);}"];
  [@css ".css-ivpcy8w{left:var(--ivpcr5a);}"];
  [@css ".css-ivpch3p{text-decoration-color:var(--ivpc4cc);}"];
  [@css ".css-ivpc9gr{background-image:var(--ivpckm4);}"];
  [@css
    ".css-ivpcagu{-webkit-mask-image:var(--ivpc8es);mask-image:var(--ivpc8es);}"
  ];
  [@css
    ".css-ivpcgku{text-shadow:var(--ivpcgax) var(--ivpccf9) var(--ivpcqb7) var(--ivpcvro);}"
  ];
  [@css ".css-ivpc7fz{color:var(--ivpcaet);}"];
  [@css
    ".css-ivpcpfc{box-shadow:var(--ivpcq3e) var(--ivpch4h) var(--ivpc7pw) var(--ivpc4bc) var(--ivpcy50);}"
  ];
  [@css ".css-ivpcdvi{box-shadow:10px 10px 0px var(--ivpcy7j) var(--ivpcehe);}"];
  [@css ".css-ivpcrps{box-shadow:var(--ivpcxzg);}"];
  [@css ".css-ivpc71f{box-shadow:none;}"];
  [@css ".css-ivpcsua{text-overflow:var(--ivpcjlo);}"];
  [@css ".css-ivpcpnw{transition-duration:500ms;}"];
  [@css ".css-ivpcdwi{transition-duration:var(--ivpcih1);}"];
  [@css
    ".css-ivpcxsv{-webkit-animation-play-state:var(--ivpcnw2);animation-play-state:var(--ivpcnw2);}"
  ];
  [@css
    ".css-ivpcj99{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-ivpcc4w{-webkit-column-gap:var(--ivpcdjr);column-gap:var(--ivpcdjr);}"
  ];
  [@css ".css-ivpcj93{-webkit-text-fill-color:var(--ivpch0q);}"];
  [@css.classes
    [
      ("css-ivpcbiv", 37, "", "input.re", 52, 15, 52, 32),
      ("css-ivpccz1", 38, "", "input.re", 53, 15, 53, 48),
      ("css-ivpchb6", 39, "", "input.re", 55, 15, 55, 41),
      ("css-ivpcs46", 40, "", "input.re", 56, 15, 56, 54),
      ("css-ivpcat8", 41, "", "input.re", 57, 15, 57, 55),
      ("css-ivpc570", 42, "", "input.re", 58, 15, 58, 61),
      ("css-ivpcc09", 43, "", "input.re", 59, 15, 59, 30),
      ("css-ivpcnlv", 44, "", "input.re", 60, 15, 60, 32),
      ("css-ivpc0is", 45, "", "input.re", 61, 15, 61, 32),
      ("css-ivpcjog", 46, "", "input.re", 62, 15, 62, 39),
      ("css-ivpcbg8", 47, "", "input.re", 63, 15, 63, 33),
      ("css-ivpc7s5", 48, "", "input.re", 64, 15, 64, 35),
      ("css-ivpcci4", 49, "", "input.re", 65, 15, 65, 33),
      ("css-ivpcirk", 50, "", "input.re", 66, 15, 66, 33),
      ("css-ivpcy8w", 51, "", "input.re", 67, 15, 67, 28),
      ("css-ivpch3p", 52, "", "input.re", 68, 15, 68, 56),
      ("css-ivpc9gr", 53, "", "input.re", 69, 15, 69, 40),
      ("css-ivpcagu", 54, "", "input.re", 70, 15, 70, 47),
      ("css-ivpcgku", 55, "", "input.re", 71, 15, 71, 54),
      ("css-ivpc7fz", 56, "", "input.re", 72, 15, 72, 35),
      ("css-ivpcpfc", 57, "", "input.re", 73, 15, 73, 63),
      ("css-ivpcdvi", 58, "", "input.re", 74, 15, 74, 59),
      ("css-ivpcrps", 59, "", "input.re", 75, 15, 75, 49),
      ("css-ivpc71f", 60, "", "input.re", 76, 15, 76, 31),
      ("css-ivpcsua", 61, "", "input.re", 77, 15, 77, 37),
      ("css-ivpcpnw", 62, "", "input.re", 78, 15, 78, 41),
      ("css-ivpcdwi", 63, "", "input.re", 79, 15, 79, 47),
      ("css-ivpcxsv", 64, "", "input.re", 80, 15, 80, 45),
      ("css-ivpcj99", 65, "", "input.re", 81, 15, 81, 43),
      ("css-ivpcc4w", 66, "", "input.re", 82, 15, 82, 39),
      ("css-ivpcj93", 67, "", "input.re", 83, 15, 83, 52),
    ]
  ];
  module Size = {
    let big = `px(24);
    let small = `px(8);
    let px30 = `px(30);
  };
  
  module Color = {
    module Border = {
      let alpha = CSS.rgba(0, 0, 0, `num(0.4));
    };
  
    let red = "red";
  };
  
  module Theme = {
    let blue = CSS.hex("00f");
  };
  
  module BoxShadow = {
    let elevation = [|
      CSS.Shadow.box(~x=`px(1), ~y=`px(2), ~blur=`px(3), CSS.hex("000")),
    |];
  };
  
  let mono100 = CSS.hex("fefefe");
  let width = `px(100);
  let max = `px(200);
  let height = `px(80);
  let border = `px(4);
  let font = `px(16);
  let mono: array(CSS.Types.FontFamilyName.t) = [|`quoted("Mono")|];
  let lh = `abs(1.5);
  let zLevel = `num(10);
  let left = `px(12);
  let decorationColor = CSS.hex("ccc");
  let wat = `url("background.png");
  let externalImageUrl = `url("mask.svg");
  let h = `px(1);
  let v = `px(2);
  let blur = `px(3);
  let spread = `px(4);
  let color = CSS.hex("000");
  let clip = `clip;
  let duration = `ms(200);
  let state = `running;
  
  let _ =
    CSS.make(
      "css-ivpcbiv",
      [("--ivpcipf", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-ivpccz1",
      [
        ("--ivpc6rn", CSS.Types.Margin.toString(Size.big)),
        ("--ivpc85e", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "css-ivpcbiv",
      [("--ivpcipf", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-ivpchb6",
      [("--ivpcegk", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "css-ivpcs46",
      [("--ivpcxfj", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-ivpcat8",
      [("--ivpctcz", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-ivpc570",
      [("--ivpcawq", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-ivpcc09",
      [("--ivpclur", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "css-ivpcnlv",
      [("--ivpceau", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "css-ivpc0is",
      [("--ivpc4j1", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "css-ivpcjog",
      [("--ivpc9qc", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "css-ivpcbg8",
      [("--ivpcmj7", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "css-ivpc7s5",
      [("--ivpcm4m", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "css-ivpcci4",
      [("--ivpcq7c", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "css-ivpcirk",
      [("--ivpceab", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make("css-ivpcy8w", [("--ivpcr5a", CSS.Types.Left.toString(left))]);
  let _ =
    CSS.make(
      "css-ivpch3p",
      [("--ivpc4cc", CSS.Types.Color.toString(decorationColor))],
    );
  let _ =
    CSS.make(
      "css-ivpc9gr",
      [("--ivpckm4", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "css-ivpcagu",
      [("--ivpc8es", CSS.Types.MaskImage.toString(externalImageUrl))],
    );
  let _ =
    CSS.make(
      "css-ivpcgku",
      [
        ("--ivpcgax", CSS.Types.Length.toString(h)),
        ("--ivpccf9", CSS.Types.Length.toString(v)),
        ("--ivpcqb7", CSS.Types.Length.toString(blur)),
        ("--ivpcvro", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-ivpc7fz",
      [("--ivpcaet", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "css-ivpcpfc",
      [
        ("--ivpcq3e", CSS.Types.Length.toString(h)),
        ("--ivpch4h", CSS.Types.Length.toString(v)),
        ("--ivpc7pw", CSS.Types.Length.toString(blur)),
        ("--ivpc4bc", CSS.Types.Length.toString(spread)),
        ("--ivpcy50", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-ivpcdvi",
      [
        ("--ivpcy7j", CSS.Types.Length.toString(spread)),
        ("--ivpcehe", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-ivpcrps",
      [("--ivpcxzg", CSS.Types.BoxShadows.toString(BoxShadow.elevation))],
    );
  let _ = CSS.make("css-ivpc71f", []);
  let _ =
    CSS.make(
      "css-ivpcsua",
      [("--ivpcjlo", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("css-ivpcpnw", []);
  let _ =
    CSS.make(
      "css-ivpcdwi",
      [("--ivpcih1", CSS.Types.TransitionDuration.toString(duration))],
    );
  let _ =
    CSS.make(
      "css-ivpcxsv",
      [("--ivpcnw2", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("css-ivpcj99", []);
  let _ =
    CSS.make(
      "css-ivpcc4w",
      [("--ivpcdjr", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "css-ivpcj93",
      [("--ivpch0q", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
