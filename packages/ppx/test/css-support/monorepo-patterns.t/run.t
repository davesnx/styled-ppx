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
  [@css "@property --uica4c-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --jluou8-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --wwjpxu-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --s8dxzr-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --8w0zh0-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --8w0zh0-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --5h8jh-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --5h8jh-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --u922lg-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --u922lg-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --7wyye5-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --7wyye5-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --7wyye5-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --k59ppk-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --k59ppk-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1vrxg7l-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1vrxg7l-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ltpt76-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --zd61mf-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --2jtlaq-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --bx9pfk-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1d3i25h-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --oizo2r-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ji8tss-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --8xvgse-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --wk1gs0-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --2lhzsu-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --2lhzsu-1{syntax:\"*\";inherits:false;}"];
  [@css ".css-181dbv0{transition:all 200ms ease 0ms;}"];
  [@css ".css-spmvv1{transition:all 300ms ease-in-out 0ms;}"];
  [@css ".css-glyyvl{transition:opacity 300ms ease-in-out 0ms;}"];
  [@css ".css-1y8p11c{transition:left 0.15s;}"];
  [@css ".css-eclnzl{transition:opacity 0.5s ease-in-out;}"];
  [@css
    ".css-g2abuj{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css
    ".css-gq5rxl{transition:width 200ms ease, height 200ms ease, background-color 200ms ease;}"
  ];
  [@css ".css-13lumhb{transition:transform 0.3s;}"];
  [@css ".css-uica4c{box-shadow:inset 0 -1px 0 0 var(--uica4c-0);}"];
  [@css ".css-jluou8{box-shadow:inset 1px 0 0 0 var(--jluou8-0);}"];
  [@css ".css-wwjpxu{box-shadow:inset 0 0 0 1000px var(--wwjpxu-0);}"];
  [@css ".css-s8dxzr{box-shadow:inset 0 0 0 0.5px var(--s8dxzr-0);}"];
  [@css
    ".css-8w0zh0{box-shadow:0 0 0 1px var(--8w0zh0-0), 0 1px 0 0 var(--8w0zh0-1);}"
  ];
  [@css
    ".css-5h8jh{box-shadow:0 0 0 1px var(--5h8jh-0), 0 2px 4px 0 var(--5h8jh-1);}"
  ];
  [@css
    ".css-u922lg{box-shadow:0 0 0 1px var(--u922lg-0), 0 3px 18px 0 var(--u922lg-1);}"
  ];
  [@css
    ".css-7wyye5{box-shadow:1px 0 0 0 var(--7wyye5-0), inset 1px 0 0 0 var(--7wyye5-1), inset 0 -1px 0 0 var(--7wyye5-2);}"
  ];
  [@css
    ".css-k59ppk{box-shadow:inset 0 1px 0 0 var(--k59ppk-0), inset 0 -1px 0 0 var(--k59ppk-1);}"
  ];
  [@css ".css-yry3un{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"];
  [@css ".css-1tmalks{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"];
  [@css
    ".css-1vg3enj{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}"
  ];
  [@css
    ".css-1vrxg7l{box-shadow:0 0 0 1px var(--1vrxg7l-0), 0 3px 18px 0 var(--1vrxg7l-1);}"
  ];
  [@css ".css-1ltpt76{border:1px solid var(--1ltpt76-0);}"];
  [@css ".css-1iuwpxx{border:0px none transparent;}"];
  [@css ".css-zd61mf{border-top:1px solid var(--zd61mf-0);}"];
  [@css ".css-2jtlaq{border-bottom:1px solid var(--2jtlaq-0);}"];
  [@css ".css-bx9pfk{border-left:1px solid var(--bx9pfk-0);}"];
  [@css ".css-1d3i25h{border-right:1px solid var(--1d3i25h-0);}"];
  [@css ".css-oizo2r{border:1px dashed var(--oizo2r-0);}"];
  [@css ".css-1ji8tss{border:1px none var(--1ji8tss-0);}"];
  [@css ".css-8xvgse{outline:1px solid var(--8xvgse-0);}"];
  [@css ".css-wk1gs0{outline:2px solid var(--wk1gs0-0);}"];
  [@css
    ".css-1lj800i{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards;}"
  ];
  [@css
    ".css-ka4ud4{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards;}"
  ];
  [@css
    ".css-lsuxqb{transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);}"
  ];
  [@css
    ".css-1iyhnco{transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1);}"
  ];
  [@css ".css-1qeh3xi{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css ".css-8ql0ud{box-shadow:1px 0 0 0 black !important;}"];
  [@css
    ".css-2lhzsu{box-shadow:1px 0 0 0 var(--2lhzsu-0), inset 0 -1px 0 0 var(--2lhzsu-1) !important;}"
  ];
  [@css ".css-1eszxeb{transition:transform 0.3s !important;}"];
  [@css.classes
    [
      ("css-181dbv0", 28, "", "input.re", 25, 8, 25, 38),
      ("css-spmvv1", 29, "", "input.re", 26, 8, 26, 45),
      ("css-glyyvl", 30, "", "input.re", 27, 8, 27, 49),
      ("css-1y8p11c", 31, "", "input.re", 30, 8, 30, 30),
      ("css-eclnzl", 32, "", "input.re", 31, 8, 31, 44),
      ("css-g2abuj", 33, "", "input.re", 32, 8, 32, 73),
      ("css-gq5rxl", 34, "", "input.re", 33, 8, 33, 84),
      ("css-13lumhb", 35, "", "input.re", 34, 8, 34, 34),
      ("css-uica4c", 36, "", "input.re", 41, 8, 41, 62),
      ("css-jluou8", 37, "", "input.re", 42, 8, 42, 56),
      ("css-wwjpxu", 38, "", "input.re", 43, 8, 43, 72),
      ("css-s8dxzr", 39, "", "input.re", 44, 8, 44, 58),
      ("css-8w0zh0", 40, "", "input.re", 47, 8, 47, 100),
      ("css-5h8jh", 41, "", "input.re", 48, 8, 48, 92),
      ("css-u922lg", 42, "", "input.re", 49, 8, 49, 93),
      ("css-7wyye5", 43, "", "input.re", 52, 8, 52, 127),
      ("css-k59ppk", 44, "", "input.re", 53, 8, 53, 95),
      ("css-yry3un", 45, "", "input.re", 56, 8, 56, 50),
      ("css-1tmalks", 46, "", "input.re", 57, 8, 57, 58),
      ("css-1vg3enj", 47, "", "input.re", 58, 8, 58, 138),
      ("css-1vrxg7l", 48, "", "input.re", 59, 8, 59, 97),
      ("css-1ltpt76", 49, "", "input.re", 65, 8, 65, 46),
      ("css-1iuwpxx", 50, "", "input.re", 66, 8, 66, 36),
      ("css-zd61mf", 51, "", "input.re", 67, 8, 67, 50),
      ("css-2jtlaq", 52, "", "input.re", 68, 8, 68, 53),
      ("css-bx9pfk", 53, "", "input.re", 69, 8, 69, 51),
      ("css-1d3i25h", 54, "", "input.re", 70, 8, 70, 52),
      ("css-oizo2r", 55, "", "input.re", 71, 8, 71, 47),
      ("css-1ji8tss", 56, "", "input.re", 72, 8, 72, 45),
      ("css-8xvgse", 57, "", "input.re", 78, 8, 78, 47),
      ("css-wk1gs0", 58, "", "input.re", 79, 8, 79, 49),
      ("css-1lj800i", 59, "", "input.re", 85, 8, 85, 60),
      ("css-ka4ud4", 60, "", "input.re", 86, 8, 86, 58),
      ("css-lsuxqb", 61, "", "input.re", 92, 8, 92, 119),
      ("css-1iyhnco", 62, "", "input.re", 93, 8, 93, 103),
      ("css-1qeh3xi", 63, "", "input.re", 100, 8, 100, 58),
      ("css-8ql0ud", 64, "", "input.re", 101, 8, 101, 46),
      ("css-2lhzsu", 65, "", "input.re", 102, 8, 102, 100),
      ("css-1eszxeb", 66, "", "input.re", 105, 8, 105, 45),
    ]
  ];
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
  
  CSS.make("css-181dbv0", []);
  CSS.make("css-spmvv1", []);
  CSS.make("css-glyyvl", []);
  
  CSS.make("css-1y8p11c", []);
  CSS.make("css-eclnzl", []);
  CSS.make("css-g2abuj", []);
  CSS.make("css-gq5rxl", []);
  CSS.make("css-13lumhb", []);
  
  CSS.make(
    "css-uica4c",
    [("--uica4c-0", CSS.Types.Color.toString(Color.Border.lineAlpha))],
  );
  CSS.make(
    "css-jluou8",
    [("--jluou8-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-wwjpxu",
    [
      ("--wwjpxu-0", CSS.Types.Color.toString(Color.Background.selectedMuted)),
    ],
  );
  CSS.make(
    "css-s8dxzr",
    [("--s8dxzr-0", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "css-8w0zh0",
    [
      ("--8w0zh0-0", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--8w0zh0-1", CSS.Types.Color.toString(Color.Shadow.elevation1Bottom)),
    ],
  );
  CSS.make(
    "css-5h8jh",
    [
      ("--5h8jh-0", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--5h8jh-1", CSS.Types.Color.toString(Color.Shadow.elevation2)),
    ],
  );
  CSS.make(
    "css-u922lg",
    [
      ("--u922lg-0", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--u922lg-1", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-7wyye5",
    [
      ("--7wyye5-0", CSS.Types.Color.toString(Color.Border.line)),
      ("--7wyye5-1", CSS.Types.Color.toString(Color.Border.line)),
      ("--7wyye5-2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "css-k59ppk",
    [
      ("--k59ppk-0", CSS.Types.Color.toString(Color.Border.line)),
      ("--k59ppk-1", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-yry3un", []);
  CSS.make("css-1tmalks", []);
  CSS.make("css-1vg3enj", []);
  CSS.make(
    "css-1vrxg7l",
    [
      ("--1vrxg7l-0", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--1vrxg7l-1", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-1ltpt76",
    [("--1ltpt76-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("css-1iuwpxx", []);
  CSS.make(
    "css-zd61mf",
    [("--zd61mf-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-2jtlaq",
    [("--2jtlaq-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-bx9pfk",
    [("--bx9pfk-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1d3i25h",
    [("--1d3i25h-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-oizo2r",
    [("--oizo2r-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ji8tss",
    [("--1ji8tss-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "css-8xvgse",
    [("--8xvgse-0", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-wk1gs0",
    [("--wk1gs0-0", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("css-1lj800i", []);
  CSS.make("css-ka4ud4", []);
  
  CSS.make("css-lsuxqb", []);
  CSS.make("css-1iyhnco", []);
  
  CSS.make("css-1qeh3xi", []);
  CSS.make("css-8ql0ud", []);
  CSS.make(
    "css-2lhzsu",
    [
      ("--2lhzsu-0", CSS.Types.Color.toString(Color.Border.line)),
      ("--2lhzsu-1", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-1eszxeb", []);
  
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
