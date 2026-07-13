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
  [@css "@property --mono100-mn2jt5{syntax:\"*\";inherits:false;}"];
  [@css "@property --big-1c1caa8{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-1tsw5sh{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-1d5k27v{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-vlpuld{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-1ftvcb4{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-1y5ijmp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-18c1xss{syntax:\"*\";inherits:false;}"];
  [@css "@property --max-1yrxnfd{syntax:\"*\";inherits:false;}"];
  [@css "@property --height-1n9troi{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-8yt3ey{syntax:\"*\";inherits:false;}"];
  [@css "@property --font-10lt5gt{syntax:\"*\";inherits:false;}"];
  [@css "@property --mono-e5legw{syntax:\"*\";inherits:false;}"];
  [@css "@property --lh-uai7u3{syntax:\"*\";inherits:false;}"];
  [@css "@property --zLevel-vut76j{syntax:\"*\";inherits:false;}"];
  [@css "@property --left-1s2hr3z{syntax:\"*\";inherits:false;}"];
  [@css "@property --decorationColor-seqvqc{syntax:\"*\";inherits:false;}"];
  [@css "@property --wat-tevp0f{syntax:\"*\";inherits:false;}"];
  [@css "@property --externalImageUrl-75mq6y{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-ulszyz{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-1rucg2y{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-n5ddfa{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1jwocqc{syntax:\"*\";inherits:false;}"];
  [@css "@property --blue-uz6p3q{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-1cxj5q6{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-1p9ysn0{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-1rsz8mu{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-1icix4c{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1eos5hw{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-wd13u2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-3xubcm{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation-jhhehb{syntax:\"*\";inherits:false;}"];
  [@css "@property --clip-1go0jdu{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-i5tvzn{syntax:\"*\";inherits:false;}"];
  [@css "@property --state-1yj1w6c{syntax:\"*\";inherits:false;}"];
  [@css "@property --px30-cc29mn{syntax:\"*\";inherits:false;}"];
  [@css "@property --red-w69rb9{syntax:\"*\";inherits:false;}"];
  [@css ".css-vtnh4f{color:var(--mono100-mn2jt5);}"];
  [@css ".css-j1itjj{margin:var(--big-1c1caa8) var(--small-1tsw5sh);}"];
  [@css ".css-pupp3j{padding:var(--small-1d5k27v) 0px;}"];
  [@css ".css-11f97be{border:1px solid var(--alpha-vlpuld);}"];
  [@css ".css-upyj1z{outline:1px solid var(--alpha-1ftvcb4);}"];
  [@css ".css-19ww55u{border-bottom:0px solid var(--alpha-1y5ijmp);}"];
  [@css ".css-1dfkyy8{width:var(--width-18c1xss);}"];
  [@css ".css-1cgnebp{max-width:var(--max-1yrxnfd);}"];
  [@css ".css-q0vooa{height:var(--height-1n9troi);}"];
  [@css ".css-cd0d4{border-radius:var(--border-8yt3ey);}"];
  [@css ".css-gdu0qi{font-size:var(--font-10lt5gt);}"];
  [@css ".css-16nszir{font-family:var(--mono-e5legw);}"];
  [@css ".css-1vyfd7x{line-height:var(--lh-uai7u3);}"];
  [@css ".css-53fgx3{z-index:var(--zLevel-vut76j);}"];
  [@css ".css-1jcegw0{left:var(--left-1s2hr3z);}"];
  [@css ".css-1p58kmj{text-decoration-color:var(--decorationColor-seqvqc);}"];
  [@css ".css-1t9o5gx{background-image:var(--wat-tevp0f);}"];
  [@css
    ".css-15xnm6u{-webkit-mask-image:var(--externalImageUrl-75mq6y);mask-image:var(--externalImageUrl-75mq6y);}"
  ];
  [@css
    ".css-1a150p4{text-shadow:var(--h-ulszyz) var(--v-1rucg2y) var(--blur-n5ddfa) var(--color-1jwocqc);}"
  ];
  [@css ".css-pc2giy{color:var(--blue-uz6p3q);}"];
  [@css
    ".css-ixihb6{box-shadow:var(--h-1cxj5q6) var(--v-1p9ysn0) var(--blur-1rsz8mu) var(--spread-1icix4c) var(--color-1eos5hw);}"
  ];
  [@css
    ".css-13ts4zv{box-shadow:10px 10px 0px var(--spread-wd13u2) var(--color-3xubcm);}"
  ];
  [@css ".css-lxl5g5{box-shadow:var(--elevation-jhhehb);}"];
  [@css ".css-gokeqi{box-shadow:none;}"];
  [@css ".css-l3baal{text-overflow:var(--clip-1go0jdu);}"];
  [@css ".css-fv8edy{transition-duration:500ms;}"];
  [@css ".css-s36hu1{transition-duration:var(--duration-i5tvzn);}"];
  [@css
    ".css-1bien0s{-webkit-animation-play-state:var(--state-1yj1w6c);animation-play-state:var(--state-1yj1w6c);}"
  ];
  [@css
    ".css-1i5bnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-x7nyl9{-webkit-column-gap:var(--px30-cc29mn);column-gap:var(--px30-cc29mn);}"
  ];
  [@css ".css-829yln{-webkit-text-fill-color:var(--red-w69rb9);}"];
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
      "css-vtnh4f",
      [("--mono100-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-j1itjj",
      [
        ("--big-1c1caa8", CSS.Types.Margin.toString(Size.big)),
        ("--small-1tsw5sh", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "css-vtnh4f",
      [("--mono100-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-pupp3j",
      [("--small-1d5k27v", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "css-11f97be",
      [("--alpha-vlpuld", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-upyj1z",
      [("--alpha-1ftvcb4", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-19ww55u",
      [("--alpha-1y5ijmp", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-1dfkyy8",
      [("--width-18c1xss", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "css-1cgnebp",
      [("--max-1yrxnfd", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "css-q0vooa",
      [("--height-1n9troi", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "css-cd0d4",
      [("--border-8yt3ey", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "css-gdu0qi",
      [("--font-10lt5gt", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "css-16nszir",
      [("--mono-e5legw", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "css-1vyfd7x",
      [("--lh-uai7u3", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "css-53fgx3",
      [("--zLevel-vut76j", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "css-1jcegw0",
      [("--left-1s2hr3z", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "css-1p58kmj",
      [
        ("--decorationColor-seqvqc", CSS.Types.Color.toString(decorationColor)),
      ],
    );
  let _ =
    CSS.make(
      "css-1t9o5gx",
      [("--wat-tevp0f", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "css-15xnm6u",
      [
        (
          "--externalImageUrl-75mq6y",
          CSS.Types.MaskImage.toString(externalImageUrl),
        ),
      ],
    );
  let _ =
    CSS.make(
      "css-1a150p4",
      [
        ("--h-ulszyz", CSS.Types.Length.toString(h)),
        ("--v-1rucg2y", CSS.Types.Length.toString(v)),
        ("--blur-n5ddfa", CSS.Types.Length.toString(blur)),
        ("--color-1jwocqc", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-pc2giy",
      [("--blue-uz6p3q", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "css-ixihb6",
      [
        ("--h-1cxj5q6", CSS.Types.Length.toString(h)),
        ("--v-1p9ysn0", CSS.Types.Length.toString(v)),
        ("--blur-1rsz8mu", CSS.Types.Length.toString(blur)),
        ("--spread-1icix4c", CSS.Types.Length.toString(spread)),
        ("--color-1eos5hw", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-13ts4zv",
      [
        ("--spread-wd13u2", CSS.Types.Length.toString(spread)),
        ("--color-3xubcm", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-lxl5g5",
      [
        (
          "--elevation-jhhehb",
          CSS.Types.BoxShadows.toString(BoxShadow.elevation),
        ),
      ],
    );
  let _ = CSS.make("css-gokeqi", []);
  let _ =
    CSS.make(
      "css-l3baal",
      [("--clip-1go0jdu", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("css-fv8edy", []);
  let _ =
    CSS.make(
      "css-s36hu1",
      [
        ("--duration-i5tvzn", CSS.Types.TransitionDuration.toString(duration)),
      ],
    );
  let _ =
    CSS.make(
      "css-1bien0s",
      [("--state-1yj1w6c", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("css-1i5bnre", []);
  let _ =
    CSS.make(
      "css-x7nyl9",
      [("--px30-cc29mn", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "css-829yln",
      [("--red-w69rb9", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
