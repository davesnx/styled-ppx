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
  [@css "@property --elevation1-e14iwu{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1Bottom-p0fi15{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-1ay7772{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation2-87fmuj{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-1ytjbex{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-1h0xx09{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-gau1ff_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-gau1ff_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-gau1ff_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1s3q6bg_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1s3q6bg_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-clddp6{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-hlqmnb{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-10u4hbk{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-17j5in5{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-jfym6t{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-2dnuub{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-doha9t{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-uf1ggy{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1i61so0{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-18cgk19{syntax:\"*\";inherits:false;}"];
  [@css "@property --accent-1w0inj7{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-k71me3_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-k71me3_2{syntax:\"*\";inherits:false;}"];
  [@css ".css-tjsoaq{transition:all 200ms ease 0ms}"];
  [@css ".css-9an52v{transition:all 300ms ease-in-out 0ms}"];
  [@css ".css-9gb0kb{transition:opacity 300ms ease-in-out 0ms}"];
  [@css ".css-1d2ga4{transition:left 0.15s}"];
  [@css ".css-9lk53a{transition:opacity 0.5s ease-in-out}"];
  [@css
    ".css-23e693{transition:opacity 0.2s ease-in-out,visibility 0.2s ease-in-out}"
  ];
  [@css
    ".css-glrh9f{transition:width 200ms ease,height 200ms ease,background-color 200ms ease}"
  ];
  [@css ".css-2jhocq{transition:transform 0.3s}"];
  [@css ".css-z1xaab{box-shadow:inset 0 -1px 0 0 var(--lineAlpha-14x2350)}"];
  [@css ".css-k42oj0{box-shadow:inset 1px 0 0 0 var(--line-16iaxxw)}"];
  [@css
    ".css-jfxwmt{box-shadow:inset 0 0 0 1000px var(--selectedMuted-coapl4)}"
  ];
  [@css ".css-lirt76{box-shadow:inset 0 0 0 0.5px var(--flag-r97mq)}"];
  [@css
    ".css-1ubuobr{box-shadow:0 0 0 1px var(--elevation1-e14iwu),0 1px 0 0 var(--elevation1Bottom-p0fi15)}"
  ];
  [@css
    ".css-wby94f{box-shadow:0 0 0 1px var(--border-1ay7772),0 2px 4px 0 var(--elevation2-87fmuj)}"
  ];
  [@css
    ".css-z27hzh{box-shadow:0 0 0 1px var(--border-1ytjbex),0 3px 18px 0 var(--elevation3-1h0xx09)}"
  ];
  [@css
    ".css-1l1hnh4{box-shadow:1px 0 0 0 var(--line-gau1ff_1),inset 1px 0 0 0 var(--line-gau1ff_2),inset 0 -1px 0 0 var(--line-gau1ff_3)}"
  ];
  [@css
    ".css-18f4ma7{box-shadow:inset 0 1px 0 0 var(--line-1s3q6bg_1),inset 0 -1px 0 0 var(--line-1s3q6bg_2)}"
  ];
  [@css ".css-1gk5tvq{box-shadow:0 1px 3px 0 rgba(0,0,0,0.1)}"];
  [@css ".css-lmfvxb{box-shadow:0px 0px 1px 0 rgba(255,255,255,0.5)}"];
  [@css
    ".css-ampzek{box-shadow:0px 1px 1px 0px rgba(49,46,29,0.06),0px 2px 2px 0px rgba(49,46,29,0.04),0px 4px 3px 0px rgba(49,46,29,0.02)}"
  ];
  [@css
    ".css-10ubr3p{box-shadow:0 0 0 1px var(--elevation1-clddp6),0 3px 18px 0 var(--elevation3-hlqmnb)}"
  ];
  [@css ".css-1q2o3yi{border:1px solid var(--line-10u4hbk)}"];
  [@css ".css-192yc9x{border:0px none transparent}"];
  [@css ".css-11h9vd4{border-top:1px solid var(--line-17j5in5)}"];
  [@css ".css-pkcjyn{border-bottom:1px solid var(--line-jfym6t)}"];
  [@css ".css-1ry65jw{border-left:1px solid var(--line-2dnuub)}"];
  [@css ".css-ypjvaq{border-right:1px solid var(--line-doha9t)}"];
  [@css ".css-1ismcmj{border:1px dashed var(--line-uf1ggy)}"];
  [@css ".css-150towz{border:1px none var(--line-1i61so0)}"];
  [@css ".css-188ct1l{outline:1px solid var(--line-18cgk19)}"];
  [@css ".css-1xnyi32{outline:2px solid var(--accent-1w0inj7)}"];
  [@css
    ".css-w1ep28{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards}"
  ];
  [@css
    ".css-d9hwlt{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards}"
  ];
  [@css
    ".css-1qtqgil{transition:height 0.5s cubic-bezier(0.25,0.46,0.45,0.94),opacity 0.5s cubic-bezier(0.25,0.46,0.45,0.94)}"
  ];
  [@css
    ".css-1bp63cu{transition:height 0.6s cubic-bezier(0.4,0,0.2,1),opacity 0.6s cubic-bezier(0.4,0,0.2,1)}"
  ];
  [@css ".css-1imssjd{box-shadow:inset 1px 0 0 0 transparent!important}"];
  [@css ".css-mqj167{box-shadow:1px 0 0 0 black!important}"];
  [@css
    ".css-cyxgg6{box-shadow:1px 0 0 0 var(--line-k71me3_1),inset 0 -1px 0 0 var(--line-k71me3_2)!important}"
  ];
  [@css ".css-7e6ar4{transition:transform 0.3s!important}"];
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
  
  CSS.make("css-tjsoaq", []);
  CSS.make("css-9an52v", []);
  CSS.make("css-9gb0kb", []);
  
  CSS.make("css-1d2ga4", []);
  CSS.make("css-9lk53a", []);
  CSS.make("css-23e693", []);
  CSS.make("css-glrh9f", []);
  CSS.make("css-2jhocq", []);
  
  CSS.make(
    "css-z1xaab",
    [
      ("--lineAlpha-14x2350", CSS.Types.Color.toString(Color.Border.lineAlpha)),
    ],
  );
  CSS.make(
    "css-k42oj0",
    [("--line-16iaxxw", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-jfxwmt",
    [
      (
        "--selectedMuted-coapl4",
        CSS.Types.Color.toString(Color.Background.selectedMuted),
      ),
    ],
  );
  CSS.make(
    "css-lirt76",
    [("--flag-r97mq", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "css-1ubuobr",
    [
      (
        "--elevation1-e14iwu",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1Bottom-p0fi15",
        CSS.Types.Color.toString(Color.Shadow.elevation1Bottom),
      ),
    ],
  );
  CSS.make(
    "css-wby94f",
    [
      ("--border-1ay7772", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation2-87fmuj",
        CSS.Types.Color.toString(Color.Shadow.elevation2),
      ),
    ],
  );
  CSS.make(
    "css-z27hzh",
    [
      ("--border-1ytjbex", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation3-1h0xx09",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "css-1l1hnh4",
    [
      ("--line-gau1ff_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-gau1ff_2", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-gau1ff_3", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "css-18f4ma7",
    [
      ("--line-1s3q6bg_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1s3q6bg_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-1gk5tvq", []);
  CSS.make("css-lmfvxb", []);
  CSS.make("css-ampzek", []);
  CSS.make(
    "css-10ubr3p",
    [
      (
        "--elevation1-clddp6",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation3-hlqmnb",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "css-1q2o3yi",
    [("--line-10u4hbk", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("css-192yc9x", []);
  CSS.make(
    "css-11h9vd4",
    [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-pkcjyn",
    [("--line-jfym6t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ry65jw",
    [("--line-2dnuub", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ypjvaq",
    [("--line-doha9t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ismcmj",
    [("--line-uf1ggy", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-150towz",
    [("--line-1i61so0", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "css-188ct1l",
    [("--line-18cgk19", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1xnyi32",
    [("--accent-1w0inj7", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("css-w1ep28", []);
  CSS.make("css-d9hwlt", []);
  
  CSS.make("css-1qtqgil", []);
  CSS.make("css-1bp63cu", []);
  
  CSS.make("css-1imssjd", []);
  CSS.make("css-mqj167", []);
  CSS.make(
    "css-cyxgg6",
    [
      ("--line-k71me3_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-k71me3_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-7e6ar4", []);
  
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
