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

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --lineAlpha-14x2350{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-16iaxxw{syntax:\"*\";inherits:false;}"];
  [@css "@property --selectedMuted-coapl4{syntax:\"*\";inherits:false;}"];
  [@css "@property --flag-r97mq{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-10w4q1l{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1Bottom-1jgyvpw{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-16e6nb4{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation2-a9z6ve{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-1pvcfai{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-u89uz4{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1fm6v6v_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1fm6v6v_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1fm6v6v_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-110y8m6_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-110y8m6_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-s7j1om{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-1tt1uog{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-10u4hbk{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-17j5in5{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-jfym6t{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-2dnuub{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-doha9t{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-uf1ggy{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1i61so0{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-18cgk19{syntax:\"*\";inherits:false;}"];
  [@css "@property --accent-1w0inj7{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-9kmuhm_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-9kmuhm_2{syntax:\"*\";inherits:false;}"];
  [@css ".a-dmsoaq{transition:all 200ms ease 0ms;}"];
  [@css ".a-dmn52v{transition:all 300ms ease-in-out 0ms;}"];
  [@css ".a-dmb0kb{transition:opacity 300ms ease-in-out 0ms;}"];
  [@css ".a-dm2ga4{transition:left 0.15s;}"];
  [@css ".a-dmk53a{transition:opacity 0.5s ease-in-out;}"];
  [@css
    ".a-dmm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css
    ".a-dmmtix{transition:width 200ms ease, height 200ms ease, background-color 200ms ease;}"
  ];
  [@css ".a-dmhocq{transition:transform 0.3s;}"];
  [@css ".in-z1xaab{box-shadow:inset 0 -1px 0 0 var(--lineAlpha-14x2350);}"];
  [@css ".in-k42oj0{box-shadow:inset 1px 0 0 0 var(--line-16iaxxw);}"];
  [@css
    ".in-jfxwmt{box-shadow:inset 0 0 0 1000px var(--selectedMuted-coapl4);}"
  ];
  [@css ".in-lirt76{box-shadow:inset 0 0 0 0.5px var(--flag-r97mq);}"];
  [@css
    ".in-1iayzvr{box-shadow:0 0 0 1px var(--elevation1-10w4q1l), 0 1px 0 0 var(--elevation1Bottom-1jgyvpw);}"
  ];
  [@css
    ".in-13ydyrw{box-shadow:0 0 0 1px var(--border-16e6nb4), 0 2px 4px 0 var(--elevation2-a9z6ve);}"
  ];
  [@css
    ".in-1ga3v0v{box-shadow:0 0 0 1px var(--border-1pvcfai), 0 3px 18px 0 var(--elevation3-u89uz4);}"
  ];
  [@css
    ".in-w2f2bw{box-shadow:1px 0 0 0 var(--line-1fm6v6v_1), inset 1px 0 0 0 var(--line-1fm6v6v_2), inset 0 -1px 0 0 var(--line-1fm6v6v_3);}"
  ];
  [@css
    ".in-uatfq{box-shadow:inset 0 1px 0 0 var(--line-110y8m6_1), inset 0 -1px 0 0 var(--line-110y8m6_2);}"
  ];
  [@css ".a-40sr4i{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"];
  [@css ".a-40ptrw{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"];
  [@css
    ".a-40knjr{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}"
  ];
  [@css
    ".in-x09jpc{box-shadow:0 0 0 1px var(--elevation1-s7j1om), 0 3px 18px 0 var(--elevation3-1tt1uog);}"
  ];
  [@css ".in-1q2o3yi{border:1px solid var(--line-10u4hbk);}"];
  [@css ".a-3hyc9x{border:0px none transparent;}"];
  [@css ".in-11h9vd4{border-top:1px solid var(--line-17j5in5);}"];
  [@css ".in-pkcjyn{border-bottom:1px solid var(--line-jfym6t);}"];
  [@css ".in-1ry65jw{border-left:1px solid var(--line-2dnuub);}"];
  [@css ".in-ypjvaq{border-right:1px solid var(--line-doha9t);}"];
  [@css ".in-1ismcmj{border:1px dashed var(--line-uf1ggy);}"];
  [@css ".in-150towz{border:1px none var(--line-1i61so0);}"];
  [@css ".in-188ct1l{outline:1px solid var(--line-18cgk19);}"];
  [@css ".in-1xnyi32{outline:2px solid var(--accent-1w0inj7);}"];
  [@css
    ".a-2zep28{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards;}"
  ];
  [@css
    ".a-2zhwlt{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards;}"
  ];
  [@css
    ".a-dm9788{transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);}"
  ];
  [@css
    ".a-dmdrfx{transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1);}"
  ];
  [@css ".a-oe8sa40slgw{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css ".a-oe8sa40e9zy{box-shadow:1px 0 0 0 black !important;}"];
  [@css
    ".in-1rh80o9{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}"
  ];
  [@css ".a-oe8sadmq5th{transition:transform 0.3s !important;}"];
  module Color = {
    module Border = {
      let line = `rgba((0, 0, 0, `num(0.1)));
      let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
      let accent = `rgba((0, 0, 255, `num(0.5)));
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
      let elevation1Bottom = `rgba((0, 0, 0, `num(0.06)));
      let elevation2 = `rgba((0, 0, 0, `num(0.1)));
      let border = `rgba((0, 0, 0, `num(0.08)));
      let elevation3 = `rgba((0, 0, 0, `num(0.15)));
      let flag = `rgba((0, 0, 0, `num(0.2)));
    };
    module Background = {
      let selectedMuted = `hex("f5f5f5");
    };
  };
  
  CSS.make("a-dmsoaq", []);
  CSS.make("a-dmn52v", []);
  CSS.make("a-dmb0kb", []);
  
  CSS.make("a-dm2ga4", []);
  CSS.make("a-dmk53a", []);
  CSS.make("a-dmm8mm", []);
  CSS.make("a-dmmtix", []);
  CSS.make("a-dmhocq", []);
  
  CSS.make(
    "in-z1xaab",
    [
      ("--lineAlpha-14x2350", CSS.Types.Color.toString(Color.Border.lineAlpha)),
    ],
  );
  CSS.make(
    "in-k42oj0",
    [("--line-16iaxxw", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-jfxwmt",
    [
      (
        "--selectedMuted-coapl4",
        CSS.Types.Color.toString(Color.Background.selectedMuted),
      ),
    ],
  );
  CSS.make(
    "in-lirt76",
    [("--flag-r97mq", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "in-1iayzvr",
    [
      (
        "--elevation1-10w4q1l",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1Bottom-1jgyvpw",
        CSS.Types.Color.toString(Color.Shadow.elevation1Bottom),
      ),
    ],
  );
  CSS.make(
    "in-13ydyrw",
    [
      ("--border-16e6nb4", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation2-a9z6ve",
        CSS.Types.Color.toString(Color.Shadow.elevation2),
      ),
    ],
  );
  CSS.make(
    "in-1ga3v0v",
    [
      ("--border-1pvcfai", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation3-u89uz4",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "in-w2f2bw",
    [
      ("--line-1fm6v6v_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1fm6v6v_2", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1fm6v6v_3", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "in-uatfq",
    [
      ("--line-110y8m6_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-110y8m6_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("a-40sr4i", []);
  CSS.make("a-40ptrw", []);
  CSS.make("a-40knjr", []);
  CSS.make(
    "in-x09jpc",
    [
      (
        "--elevation1-s7j1om",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation3-1tt1uog",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "in-1q2o3yi",
    [("--line-10u4hbk", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("a-3hyc9x", []);
  CSS.make(
    "in-11h9vd4",
    [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-pkcjyn",
    [("--line-jfym6t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-1ry65jw",
    [("--line-2dnuub", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-ypjvaq",
    [("--line-doha9t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-1ismcmj",
    [("--line-uf1ggy", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-150towz",
    [("--line-1i61so0", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "in-188ct1l",
    [("--line-18cgk19", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "in-1xnyi32",
    [("--accent-1w0inj7", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("a-2zep28", []);
  CSS.make("a-2zhwlt", []);
  
  CSS.make("a-dm9788", []);
  CSS.make("a-dmdrfx", []);
  
  CSS.make("a-oe8sa40slgw", []);
  CSS.make("a-oe8sa40e9zy", []);
  CSS.make(
    "in-1rh80o9",
    [
      ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("a-oe8sadmq5th", []);
  
  let _shadow1: CSS.Shadow.box =
    CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
  let _shadow2: array(CSS.Shadow.box) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`px(4),
      `rgba((0, 0, 0, `num(0.1))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(6),
      ~blur=`px(15),
      `rgba((0, 0, 0, `num(0.2))),
    ),
  |];
