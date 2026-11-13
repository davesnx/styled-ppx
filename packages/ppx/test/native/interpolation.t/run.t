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
  [@css "@property --1hz1c5n-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --q0l7lx-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --q0l7lx-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --7bualb-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --kx9a3h-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --4qsc91-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1g0k6ue-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1mgx49-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --186km4s-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --987e1l-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1wtdg4x-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ntongu-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --2t2ysq-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --lk6bnn-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1jekzhu-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ukjsbj-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --peo5os-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --3cd14j-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --efmmw3-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --hma37p-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --hma37p-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --hma37p-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --hma37p-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --d13iep-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r1mm6z-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r1mm6z-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r1mm6z-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r1mm6z-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r1mm6z-4{syntax:\"*\";inherits:false;}"];
  [@css "@property --1gbmc9t-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1gbmc9t-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ystsg7-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1s1ugq4-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1g4auh6-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --11ho36f-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --wndpqe-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --w9rn21-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-1hz1c5n{color:var(--1hz1c5n-0);}"];
  [@css ".css-q0l7lx{margin:var(--q0l7lx-0) var(--q0l7lx-1);}"];
  [@css ".css-7bualb{padding:var(--7bualb-0) 0px;}"];
  [@css ".css-kx9a3h{border:1px solid var(--kx9a3h-0);}"];
  [@css ".css-4qsc91{outline:1px solid var(--4qsc91-0);}"];
  [@css ".css-1g0k6ue{border-bottom:0px solid var(--1g0k6ue-0);}"];
  [@css ".css-1mgx49{width:var(--1mgx49-0);}"];
  [@css ".css-186km4s{max-width:var(--186km4s-0);}"];
  [@css ".css-987e1l{height:var(--987e1l-0);}"];
  [@css ".css-1wtdg4x{border-radius:var(--1wtdg4x-0);}"];
  [@css ".css-ntongu{font-size:var(--ntongu-0);}"];
  [@css ".css-2t2ysq{font-family:var(--2t2ysq-0);}"];
  [@css ".css-lk6bnn{line-height:var(--lk6bnn-0);}"];
  [@css ".css-1jekzhu{z-index:var(--1jekzhu-0);}"];
  [@css ".css-1ukjsbj{left:var(--1ukjsbj-0);}"];
  [@css ".css-peo5os{text-decoration-color:var(--peo5os-0);}"];
  [@css ".css-3cd14j{background-image:var(--3cd14j-0);}"];
  [@css
    ".css-efmmw3{-webkit-mask-image:var(--efmmw3-0);mask-image:var(--efmmw3-0);}"
  ];
  [@css
    ".css-hma37p{text-shadow:var(--hma37p-0) var(--hma37p-1) var(--hma37p-2) var(--hma37p-3);}"
  ];
  [@css ".css-d13iep{color:var(--d13iep-0);}"];
  [@css
    ".css-1r1mm6z{box-shadow:var(--1r1mm6z-0) var(--1r1mm6z-1) var(--1r1mm6z-2) var(--1r1mm6z-3) var(--1r1mm6z-4);}"
  ];
  [@css
    ".css-1gbmc9t{box-shadow:10px 10px 0px var(--1gbmc9t-0) var(--1gbmc9t-1);}"
  ];
  [@css ".css-1ystsg7{box-shadow:var(--1ystsg7-0);}"];
  [@css ".css-hlv71f{box-shadow:none;}"];
  [@css ".css-1s1ugq4{text-overflow:var(--1s1ugq4-0);}"];
  [@css ".css-15jmpnw{transition-duration:500ms;}"];
  [@css ".css-1g4auh6{transition-duration:var(--1g4auh6-0);}"];
  [@css
    ".css-11ho36f{-webkit-animation-play-state:var(--11ho36f-0);animation-play-state:var(--11ho36f-0);}"
  ];
  [@css
    ".css-vaxj99{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-wndpqe{-webkit-column-gap:var(--wndpqe-0);column-gap:var(--wndpqe-0);}"
  ];
  [@css ".css-w9rn21{-webkit-text-fill-color:var(--w9rn21-0);}"];
  [@css.classes
    [
      ("css-1hz1c5n", 37, "", "input.re", 52, 15, 52, 32),
      ("css-q0l7lx", 38, "", "input.re", 53, 15, 53, 48),
      ("css-7bualb", 39, "", "input.re", 55, 15, 55, 41),
      ("css-kx9a3h", 40, "", "input.re", 56, 15, 56, 54),
      ("css-4qsc91", 41, "", "input.re", 57, 15, 57, 55),
      ("css-1g0k6ue", 42, "", "input.re", 58, 15, 58, 61),
      ("css-1mgx49", 43, "", "input.re", 59, 15, 59, 30),
      ("css-186km4s", 44, "", "input.re", 60, 15, 60, 32),
      ("css-987e1l", 45, "", "input.re", 61, 15, 61, 32),
      ("css-1wtdg4x", 46, "", "input.re", 62, 15, 62, 39),
      ("css-ntongu", 47, "", "input.re", 63, 15, 63, 33),
      ("css-2t2ysq", 48, "", "input.re", 64, 15, 64, 35),
      ("css-lk6bnn", 49, "", "input.re", 65, 15, 65, 33),
      ("css-1jekzhu", 50, "", "input.re", 66, 15, 66, 33),
      ("css-1ukjsbj", 51, "", "input.re", 67, 15, 67, 28),
      ("css-peo5os", 52, "", "input.re", 68, 15, 68, 56),
      ("css-3cd14j", 53, "", "input.re", 69, 15, 69, 40),
      ("css-efmmw3", 54, "", "input.re", 70, 15, 70, 47),
      ("css-hma37p", 55, "", "input.re", 71, 15, 71, 54),
      ("css-d13iep", 56, "", "input.re", 72, 15, 72, 35),
      ("css-1r1mm6z", 57, "", "input.re", 73, 15, 73, 63),
      ("css-1gbmc9t", 58, "", "input.re", 74, 15, 74, 59),
      ("css-1ystsg7", 59, "", "input.re", 75, 15, 75, 49),
      ("css-hlv71f", 60, "", "input.re", 76, 15, 76, 31),
      ("css-1s1ugq4", 61, "", "input.re", 77, 15, 77, 37),
      ("css-15jmpnw", 62, "", "input.re", 78, 15, 78, 41),
      ("css-1g4auh6", 63, "", "input.re", 79, 15, 79, 47),
      ("css-11ho36f", 64, "", "input.re", 80, 15, 80, 45),
      ("css-vaxj99", 65, "", "input.re", 81, 15, 81, 43),
      ("css-wndpqe", 66, "", "input.re", 82, 15, 82, 39),
      ("css-w9rn21", 67, "", "input.re", 83, 15, 83, 52),
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
      "css-1hz1c5n",
      [("--1hz1c5n-0", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-q0l7lx",
      [
        ("--q0l7lx-0", CSS.Types.Margin.toString(Size.big)),
        ("--q0l7lx-1", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "css-1hz1c5n",
      [("--1hz1c5n-0", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-7bualb",
      [("--7bualb-0", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "css-kx9a3h",
      [("--kx9a3h-0", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-4qsc91",
      [("--4qsc91-0", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-1g0k6ue",
      [("--1g0k6ue-0", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-1mgx49",
      [("--1mgx49-0", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "css-186km4s",
      [("--186km4s-0", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "css-987e1l",
      [("--987e1l-0", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "css-1wtdg4x",
      [("--1wtdg4x-0", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "css-ntongu",
      [("--ntongu-0", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "css-2t2ysq",
      [("--2t2ysq-0", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "css-lk6bnn",
      [("--lk6bnn-0", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "css-1jekzhu",
      [("--1jekzhu-0", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "css-1ukjsbj",
      [("--1ukjsbj-0", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "css-peo5os",
      [("--peo5os-0", CSS.Types.Color.toString(decorationColor))],
    );
  let _ =
    CSS.make(
      "css-3cd14j",
      [("--3cd14j-0", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "css-efmmw3",
      [("--efmmw3-0", CSS.Types.MaskImage.toString(externalImageUrl))],
    );
  let _ =
    CSS.make(
      "css-hma37p",
      [
        ("--hma37p-0", CSS.Types.Length.toString(h)),
        ("--hma37p-1", CSS.Types.Length.toString(v)),
        ("--hma37p-2", CSS.Types.Length.toString(blur)),
        ("--hma37p-3", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-d13iep",
      [("--d13iep-0", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "css-1r1mm6z",
      [
        ("--1r1mm6z-0", CSS.Types.Length.toString(h)),
        ("--1r1mm6z-1", CSS.Types.Length.toString(v)),
        ("--1r1mm6z-2", CSS.Types.Length.toString(blur)),
        ("--1r1mm6z-3", CSS.Types.Length.toString(spread)),
        ("--1r1mm6z-4", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-1gbmc9t",
      [
        ("--1gbmc9t-0", CSS.Types.Length.toString(spread)),
        ("--1gbmc9t-1", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-1ystsg7",
      [("--1ystsg7-0", CSS.Types.BoxShadows.toString(BoxShadow.elevation))],
    );
  let _ = CSS.make("css-hlv71f", []);
  let _ =
    CSS.make(
      "css-1s1ugq4",
      [("--1s1ugq4-0", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("css-15jmpnw", []);
  let _ =
    CSS.make(
      "css-1g4auh6",
      [("--1g4auh6-0", CSS.Types.TransitionDuration.toString(duration))],
    );
  let _ =
    CSS.make(
      "css-11ho36f",
      [("--11ho36f-0", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("css-vaxj99", []);
  let _ =
    CSS.make(
      "css-wndpqe",
      [("--wndpqe-0", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "css-w9rn21",
      [("--w9rn21-0", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
