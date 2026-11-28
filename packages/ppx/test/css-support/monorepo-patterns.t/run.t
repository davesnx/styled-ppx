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
  [@css "@property --ivpcmq8{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpckrm{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcz7s{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcrqa{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcmx2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpceiz{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpctxg{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpclnm{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcyen{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc1rl{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcy75{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcrck{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcaem{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcuw0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcxu5{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcy31{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcbdj{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcl48{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc8c6{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc5mm{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcthc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcoai{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc3eq{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcj6z{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcss5{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcbgj{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc3pw{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpchkf{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcbv0{transition:all 200ms ease 0ms;}"];
  [@css ".css-ivpcvv1{transition:all 300ms ease-in-out 0ms;}"];
  [@css ".css-ivpcyvl{transition:opacity 300ms ease-in-out 0ms;}"];
  [@css ".css-ivpc11c{transition:left 0.15s;}"];
  [@css ".css-ivpcnzl{transition:opacity 0.5s ease-in-out;}"];
  [@css
    ".css-ivpcbuj{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css
    ".css-ivpcrxl{transition:width 200ms ease, height 200ms ease, background-color 200ms ease;}"
  ];
  [@css ".css-ivpcmhb{transition:transform 0.3s;}"];
  [@css ".css-ivpc5ot{box-shadow:inset 0 -1px 0 0 var(--ivpcmq8);}"];
  [@css ".css-ivpcrx5{box-shadow:inset 1px 0 0 0 var(--ivpckrm);}"];
  [@css ".css-ivpcprd{box-shadow:inset 0 0 0 1000px var(--ivpcz7s);}"];
  [@css ".css-ivpc5s8{box-shadow:inset 0 0 0 0.5px var(--ivpcrqa);}"];
  [@css
    ".css-ivpcxmb{box-shadow:0 0 0 1px var(--ivpcmx2), 0 1px 0 0 var(--ivpceiz);}"
  ];
  [@css
    ".css-ivpcyf9{box-shadow:0 0 0 1px var(--ivpctxg), 0 2px 4px 0 var(--ivpclnm);}"
  ];
  [@css
    ".css-ivpckzx{box-shadow:0 0 0 1px var(--ivpcyen), 0 3px 18px 0 var(--ivpc1rl);}"
  ];
  [@css
    ".css-ivpc064{box-shadow:1px 0 0 0 var(--ivpcy75), inset 1px 0 0 0 var(--ivpcrck), inset 0 -1px 0 0 var(--ivpcaem);}"
  ];
  [@css
    ".css-ivpcu3e{box-shadow:inset 0 1px 0 0 var(--ivpcuw0), inset 0 -1px 0 0 var(--ivpcxu5);}"
  ];
  [@css ".css-ivpc3un{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"];
  [@css ".css-ivpclks{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"];
  [@css
    ".css-ivpcenj{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}"
  ];
  [@css
    ".css-ivpcnj6{box-shadow:0 0 0 1px var(--ivpcy31), 0 3px 18px 0 var(--ivpcbdj);}"
  ];
  [@css ".css-ivpcnz3{border:1px solid var(--ivpcl48);}"];
  [@css ".css-ivpcpxx{border:0px none transparent;}"];
  [@css ".css-ivpcgnd{border-top:1px solid var(--ivpc8c6);}"];
  [@css ".css-ivpcotz{border-bottom:1px solid var(--ivpc5mm);}"];
  [@css ".css-ivpc1uc{border-left:1px solid var(--ivpcthc);}"];
  [@css ".css-ivpc78o{border-right:1px solid var(--ivpcoai);}"];
  [@css ".css-ivpccf5{border:1px dashed var(--ivpc3eq);}"];
  [@css ".css-ivpcts7{border:1px none var(--ivpcj6z);}"];
  [@css ".css-ivpcx95{outline:1px solid var(--ivpcss5);}"];
  [@css ".css-ivpc25d{outline:2px solid var(--ivpcbgj);}"];
  [@css
    ".css-ivpc00i{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards;}"
  ];
  [@css
    ".css-ivpcud4{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards;}"
  ];
  [@css
    ".css-ivpcxqb{transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);}"
  ];
  [@css
    ".css-ivpcnco{transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1);}"
  ];
  [@css ".css-ivpc3xi{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css ".css-ivpc0ud{box-shadow:1px 0 0 0 black !important;}"];
  [@css
    ".css-ivpc7wb{box-shadow:1px 0 0 0 var(--ivpc3pw), inset 0 -1px 0 0 var(--ivpchkf) !important;}"
  ];
  [@css ".css-ivpcxeb{transition:transform 0.3s !important;}"];
  [@css.classes
    [
      ("css-ivpcbv0", 28, "", "input.re", 25, 8, 25, 38),
      ("css-ivpcvv1", 29, "", "input.re", 26, 8, 26, 45),
      ("css-ivpcyvl", 30, "", "input.re", 27, 8, 27, 49),
      ("css-ivpc11c", 31, "", "input.re", 30, 8, 30, 30),
      ("css-ivpcnzl", 32, "", "input.re", 31, 8, 31, 44),
      ("css-ivpcbuj", 33, "", "input.re", 32, 8, 32, 73),
      ("css-ivpcrxl", 34, "", "input.re", 33, 8, 33, 84),
      ("css-ivpcmhb", 35, "", "input.re", 34, 8, 34, 34),
      ("css-ivpc5ot", 36, "", "input.re", 41, 8, 41, 62),
      ("css-ivpcrx5", 37, "", "input.re", 42, 8, 42, 56),
      ("css-ivpcprd", 38, "", "input.re", 43, 8, 43, 72),
      ("css-ivpc5s8", 39, "", "input.re", 44, 8, 44, 58),
      ("css-ivpcxmb", 40, "", "input.re", 47, 8, 47, 100),
      ("css-ivpcyf9", 41, "", "input.re", 48, 8, 48, 92),
      ("css-ivpckzx", 42, "", "input.re", 49, 8, 49, 93),
      ("css-ivpc064", 43, "", "input.re", 52, 8, 52, 127),
      ("css-ivpcu3e", 44, "", "input.re", 53, 8, 53, 95),
      ("css-ivpc3un", 45, "", "input.re", 56, 8, 56, 50),
      ("css-ivpclks", 46, "", "input.re", 57, 8, 57, 58),
      ("css-ivpcenj", 47, "", "input.re", 58, 8, 58, 138),
      ("css-ivpcnj6", 48, "", "input.re", 59, 8, 59, 97),
      ("css-ivpcnz3", 49, "", "input.re", 65, 8, 65, 46),
      ("css-ivpcpxx", 50, "", "input.re", 66, 8, 66, 36),
      ("css-ivpcgnd", 51, "", "input.re", 67, 8, 67, 50),
      ("css-ivpcotz", 52, "", "input.re", 68, 8, 68, 53),
      ("css-ivpc1uc", 53, "", "input.re", 69, 8, 69, 51),
      ("css-ivpc78o", 54, "", "input.re", 70, 8, 70, 52),
      ("css-ivpccf5", 55, "", "input.re", 71, 8, 71, 47),
      ("css-ivpcts7", 56, "", "input.re", 72, 8, 72, 45),
      ("css-ivpcx95", 57, "", "input.re", 78, 8, 78, 47),
      ("css-ivpc25d", 58, "", "input.re", 79, 8, 79, 49),
      ("css-ivpc00i", 59, "", "input.re", 85, 8, 85, 60),
      ("css-ivpcud4", 60, "", "input.re", 86, 8, 86, 58),
      ("css-ivpcxqb", 61, "", "input.re", 92, 8, 92, 119),
      ("css-ivpcnco", 62, "", "input.re", 93, 8, 93, 103),
      ("css-ivpc3xi", 63, "", "input.re", 100, 8, 100, 58),
      ("css-ivpc0ud", 64, "", "input.re", 101, 8, 101, 46),
      ("css-ivpc7wb", 65, "", "input.re", 102, 8, 102, 100),
      ("css-ivpcxeb", 66, "", "input.re", 105, 8, 105, 45),
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
  
  CSS.make("css-ivpcbv0", []);
  CSS.make("css-ivpcvv1", []);
  CSS.make("css-ivpcyvl", []);
  
  CSS.make("css-ivpc11c", []);
  CSS.make("css-ivpcnzl", []);
  CSS.make("css-ivpcbuj", []);
  CSS.make("css-ivpcrxl", []);
  CSS.make("css-ivpcmhb", []);
  
  CSS.make(
    "css-ivpc5ot",
    [("--ivpcmq8", CSS.Types.Color.toString(Color.Border.lineAlpha))],
  );
  CSS.make(
    "css-ivpcrx5",
    [("--ivpckrm", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpcprd",
    [("--ivpcz7s", CSS.Types.Color.toString(Color.Background.selectedMuted))],
  );
  CSS.make(
    "css-ivpc5s8",
    [("--ivpcrqa", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "css-ivpcxmb",
    [
      ("--ivpcmx2", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--ivpceiz", CSS.Types.Color.toString(Color.Shadow.elevation1Bottom)),
    ],
  );
  CSS.make(
    "css-ivpcyf9",
    [
      ("--ivpctxg", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--ivpclnm", CSS.Types.Color.toString(Color.Shadow.elevation2)),
    ],
  );
  CSS.make(
    "css-ivpckzx",
    [
      ("--ivpcyen", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--ivpc1rl", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-ivpc064",
    [
      ("--ivpcy75", CSS.Types.Color.toString(Color.Border.line)),
      ("--ivpcrck", CSS.Types.Color.toString(Color.Border.line)),
      ("--ivpcaem", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "css-ivpcu3e",
    [
      ("--ivpcuw0", CSS.Types.Color.toString(Color.Border.line)),
      ("--ivpcxu5", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-ivpc3un", []);
  CSS.make("css-ivpclks", []);
  CSS.make("css-ivpcenj", []);
  CSS.make(
    "css-ivpcnj6",
    [
      ("--ivpcy31", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--ivpcbdj", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-ivpcnz3",
    [("--ivpcl48", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("css-ivpcpxx", []);
  CSS.make(
    "css-ivpcgnd",
    [("--ivpc8c6", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpcotz",
    [("--ivpc5mm", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpc1uc",
    [("--ivpcthc", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpc78o",
    [("--ivpcoai", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpccf5",
    [("--ivpc3eq", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpcts7",
    [("--ivpcj6z", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "css-ivpcx95",
    [("--ivpcss5", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ivpc25d",
    [("--ivpcbgj", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("css-ivpc00i", []);
  CSS.make("css-ivpcud4", []);
  
  CSS.make("css-ivpcxqb", []);
  CSS.make("css-ivpcnco", []);
  
  CSS.make("css-ivpc3xi", []);
  CSS.make("css-ivpc0ud", []);
  CSS.make(
    "css-ivpc7wb",
    [
      ("--ivpc3pw", CSS.Types.Color.toString(Color.Border.line)),
      ("--ivpchkf", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-ivpcxeb", []);
  
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
