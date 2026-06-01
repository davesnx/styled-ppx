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
  [@css ".css-vtnh4f{color:var(--var-1ibwxvp);}"];
  [@css ".css-j1itjj{margin:var(--var-1uc4pi1) var(--var-1hwlc62);}"];
  [@css ".css-pupp3j{padding:var(--var-1hwlc62) 0px;}"];
  [@css ".css-11f97be{border:1px solid var(--var-qtan0a);}"];
  [@css ".css-upyj1z{outline:1px solid var(--var-qtan0a);}"];
  [@css ".css-19ww55u{border-bottom:0px solid var(--var-qtan0a);}"];
  [@css ".css-1dfkyy8{width:var(--var-a9b677);}"];
  [@css ".css-1cgnebp{max-width:var(--var-ro3cva);}"];
  [@css ".css-q0vooa{height:var(--var-1qenvij);}"];
  [@css ".css-cd0d4{border-radius:var(--var-irswps);}"];
  [@css ".css-gdu0qi{font-size:var(--var-1kuyir6);}"];
  [@css ".css-16nszir{font-family:var(--var-le3b27);}"];
  [@css ".css-1vyfd7x{line-height:var(--var-vlrja2);}"];
  [@css ".css-53fgx3{z-index:var(--var-1wl9eok);}"];
  [@css ".css-1jcegw0{left:var(--var-oyh7mz);}"];
  [@css ".css-1p58kmj{text-decoration-color:var(--var-14jv8zo);}"];
  [@css ".css-1t9o5gx{background-image:var(--var-8tg3mw);}"];
  [@css
    ".css-15xnm6u{-webkit-mask-image:var(--var-12k5hq2);mask-image:var(--var-12k5hq2);}"
  ];
  [@css
    ".css-1a150p4{text-shadow:var(--var-1l3744o) var(--var-m61wr8) var(--var-dk37bb) var(--var-sj55zd);}"
  ];
  [@css ".css-pc2giy{color:var(--var-1u3w9n0);}"];
  [@css
    ".css-ixihb6{box-shadow:var(--var-1l3744o) var(--var-m61wr8) var(--var-dk37bb) var(--var-11b5qtb) var(--var-sj55zd);}"
  ];
  [@css
    ".css-13ts4zv{box-shadow:10px 10px 0px var(--var-11b5qtb) var(--var-sj55zd);}"
  ];
  [@css ".css-lxl5g5{box-shadow:var(--var-ica73p);}"];
  [@css ".css-gokeqi{box-shadow:none;}"];
  [@css ".css-l3baal{text-overflow:var(--var-1h84pgu);}"];
  [@css ".css-fv8edy{transition-duration:500ms;}"];
  [@css ".css-s36hu1{transition-duration:var(--var-7p0nz0);}"];
  [@css
    ".css-1bien0s{-webkit-animation-play-state:var(--var-xrc803);animation-play-state:var(--var-xrc803);}"
  ];
  [@css
    ".css-1i5bnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-x7nyl9{-webkit-column-gap:var(--var-1ctyfo8);column-gap:var(--var-1ctyfo8);}"
  ];
  [@css ".css-829yln{-webkit-text-fill-color:var(--var-pbzwpe);}"];
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
      [("--var-1ibwxvp", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-j1itjj",
      [
        ("--var-1uc4pi1", CSS.Types.Margin.toString(Size.big)),
        ("--var-1hwlc62", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "css-vtnh4f",
      [("--var-1ibwxvp", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-pupp3j",
      [("--var-1hwlc62", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "css-11f97be",
      [("--var-qtan0a", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-upyj1z",
      [("--var-qtan0a", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-19ww55u",
      [("--var-qtan0a", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-1dfkyy8",
      [("--var-a9b677", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "css-1cgnebp",
      [("--var-ro3cva", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "css-q0vooa",
      [("--var-1qenvij", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "css-cd0d4",
      [("--var-irswps", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "css-gdu0qi",
      [("--var-1kuyir6", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "css-16nszir",
      [("--var-le3b27", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "css-1vyfd7x",
      [("--var-vlrja2", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "css-53fgx3",
      [("--var-1wl9eok", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "css-1jcegw0",
      [("--var-oyh7mz", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "css-1p58kmj",
      [("--var-14jv8zo", CSS.Types.Color.toString(decorationColor))],
    );
  let _ =
    CSS.make(
      "css-1t9o5gx",
      [("--var-8tg3mw", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "css-15xnm6u",
      [("--var-12k5hq2", CSS.Types.MaskImage.toString(externalImageUrl))],
    );
  let _ =
    CSS.make(
      "css-1a150p4",
      [
        ("--var-1l3744o", CSS.Types.Length.toString(h)),
        ("--var-m61wr8", CSS.Types.Length.toString(v)),
        ("--var-dk37bb", CSS.Types.Length.toString(blur)),
        ("--var-sj55zd", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-pc2giy",
      [("--var-1u3w9n0", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "css-ixihb6",
      [
        ("--var-1l3744o", CSS.Types.Length.toString(h)),
        ("--var-m61wr8", CSS.Types.Length.toString(v)),
        ("--var-dk37bb", CSS.Types.Length.toString(blur)),
        ("--var-11b5qtb", CSS.Types.Length.toString(spread)),
        ("--var-sj55zd", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-13ts4zv",
      [
        ("--var-11b5qtb", CSS.Types.Length.toString(spread)),
        ("--var-sj55zd", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-lxl5g5",
      [("--var-ica73p", CSS.Types.BoxShadows.toString(BoxShadow.elevation))],
    );
  let _ = CSS.make("css-gokeqi", []);
  let _ =
    CSS.make(
      "css-l3baal",
      [("--var-1h84pgu", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("css-fv8edy", []);
  let _ =
    CSS.make(
      "css-s36hu1",
      [("--var-7p0nz0", CSS.Types.TransitionDuration.toString(duration))],
    );
  let _ =
    CSS.make(
      "css-1bien0s",
      [("--var-xrc803", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("css-1i5bnre", []);
  let _ =
    CSS.make(
      "css-x7nyl9",
      [("--var-1ctyfo8", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "css-829yln",
      [("--var-pbzwpe", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
