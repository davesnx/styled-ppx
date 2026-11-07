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
  [@css.atoms
    [
      (
        "_a7fakDml3",
        ["._a7fakDml3{color:rgba(0,0,0,0.5);}"],
        1,
        0,
        1,
        [("value", "akDml3", "val\\07f\\0& | \\0color:rgba(0,0,0,0.5)")],
      ),
      (
        "_a7fRUmiry",
        ["._a7fRUmiry{color:#F06;}"],
        1,
        0,
        1,
        [("value", "RUmiry", "val\\07f\\0& | \\0color:#F06")],
      ),
      (
        "_a7fUJ_N9A",
        ["._a7fUJ_N9A{color:#FF0066;}"],
        1,
        0,
        1,
        [("value", "UJ_N9A", "val\\07f\\0& | \\0color:#FF0066")],
      ),
      (
        "_a7fUa9GTV",
        ["._a7fUa9GTV{color:hsl(0,0%,0%);}"],
        1,
        0,
        1,
        [("value", "Ua9GTV", "val\\07f\\0& | \\0color:hsl(0,0%,0%)")],
      ),
      (
        "_a7fwFsXzL",
        ["._a7fwFsXzL{color:hsl(0,0%,0%,0.5);}"],
        1,
        0,
        1,
        [("value", "wFsXzL", "val\\07f\\0& | \\0color:hsl(0,0%,0%,0.5)")],
      ),
      (
        "_a7fYZ-FVs",
        ["._a7fYZ-FVs{color:transparent;}"],
        1,
        0,
        1,
        [("value", "YZ-FVs", "val\\07f\\0& | \\0color:transparent")],
      ),
      (
        "_a7fVCl-Y6",
        ["._a7fVCl-Y6{color:currentColor;}"],
        1,
        0,
        1,
        [("value", "VCl-Y6", "val\\07f\\0& | \\0color:currentColor")],
      ),
      (
        "_a4le1hSbX",
        ["._a4le1hSbX{background-color:rgba(0,0,0,0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "e1hSbX",
            "val\\04l\\0& | \\0background-color:rgba(0,0,0,0.5)",
          ),
        ],
      ),
      (
        "_a4lFk9YMx",
        ["._a4lFk9YMx{background-color:#F06;}"],
        1,
        0,
        1,
        [("value", "Fk9YMx", "val\\04l\\0& | \\0background-color:#F06")],
      ),
      (
        "_a4l28gWki",
        ["._a4l28gWki{background-color:#FF0066;}"],
        1,
        0,
        1,
        [("value", "28gWki", "val\\04l\\0& | \\0background-color:#FF0066")],
      ),
      (
        "_a4lhYsYWN",
        ["._a4lhYsYWN{background-color:hsl(0,0%,0%);}"],
        1,
        0,
        1,
        [
          ("value", "hYsYWN", "val\\04l\\0& | \\0background-color:hsl(0,0%,0%)"),
        ],
      ),
      (
        "_a4lXlB75-",
        ["._a4lXlB75-{background-color:hsl(0,0%,0%,0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XlB75-",
            "val\\04l\\0& | \\0background-color:hsl(0,0%,0%,0.5)",
          ),
        ],
      ),
      (
        "_a4lKIA7tC",
        ["._a4lKIA7tC{background-color:transparent;}"],
        1,
        0,
        1,
        [
          ("value", "KIA7tC", "val\\04l\\0& | \\0background-color:transparent"),
        ],
      ),
      (
        "_a4l4WG0U7",
        ["._a4l4WG0U7{background-color:currentColor;}"],
        1,
        0,
        1,
        [
          ("value", "4WG0U7", "val\\04l\\0& | \\0background-color:currentColor"),
        ],
      ),
      (
        "_a5k7Z8onv",
        ["._a5k7Z8onv{border-color:rgba(0,0,0,0.5);}"],
        1,
        0,
        4,
        [
          ("value", "7Z8onv", "val\\05k\\0& | \\0border-color:rgba(0,0,0,0.5)"),
        ],
      ),
      (
        "_a5k3wNszX",
        ["._a5k3wNszX{border-color:#F06;}"],
        1,
        0,
        4,
        [("value", "3wNszX", "val\\05k\\0& | \\0border-color:#F06")],
      ),
      (
        "_a5kma_Cyt",
        ["._a5kma_Cyt{border-color:#FF0066;}"],
        1,
        0,
        4,
        [("value", "ma_Cyt", "val\\05k\\0& | \\0border-color:#FF0066")],
      ),
      (
        "_a5k5-kNj2",
        ["._a5k5-kNj2{border-color:hsl(0,0%,0%);}"],
        1,
        0,
        4,
        [("value", "5-kNj2", "val\\05k\\0& | \\0border-color:hsl(0,0%,0%)")],
      ),
      (
        "_a5krA8H3N",
        ["._a5krA8H3N{border-color:hsl(0,0%,0%,0.5);}"],
        1,
        0,
        4,
        [
          ("value", "rA8H3N", "val\\05k\\0& | \\0border-color:hsl(0,0%,0%,0.5)"),
        ],
      ),
      (
        "_a5k6qVB1H",
        ["._a5k6qVB1H{border-color:transparent;}"],
        1,
        0,
        4,
        [("value", "6qVB1H", "val\\05k\\0& | \\0border-color:transparent")],
      ),
      (
        "_a5kYg2rW_",
        ["._a5kYg2rW_{border-color:currentColor;}"],
        1,
        0,
        4,
        [("value", "Yg2rW_", "val\\05k\\0& | \\0border-color:currentColor")],
      ),
      (
        "_akwQ1tbpO",
        ["._akwQ1tbpO{text-decoration-color:rgba(0,0,0,0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Q1tbpO",
            "val\\0kw\\0& | \\0text-decoration-color:rgba(0,0,0,0.5)",
          ),
        ],
      ),
      (
        "_akwLE6cPG",
        ["._akwLE6cPG{text-decoration-color:#F06;}"],
        1,
        0,
        1,
        [("value", "LE6cPG", "val\\0kw\\0& | \\0text-decoration-color:#F06")],
      ),
      (
        "_akwzdtpMx",
        ["._akwzdtpMx{text-decoration-color:#FF0066;}"],
        1,
        0,
        1,
        [
          ("value", "zdtpMx", "val\\0kw\\0& | \\0text-decoration-color:#FF0066"),
        ],
      ),
      (
        "_akw6wxaWo",
        ["._akw6wxaWo{text-decoration-color:hsl(0,0%,0%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6wxaWo",
            "val\\0kw\\0& | \\0text-decoration-color:hsl(0,0%,0%)",
          ),
        ],
      ),
      (
        "_akw2n-Fqa",
        ["._akw2n-Fqa{text-decoration-color:hsl(0,0%,0%,0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2n-Fqa",
            "val\\0kw\\0& | \\0text-decoration-color:hsl(0,0%,0%,0.5)",
          ),
        ],
      ),
      (
        "_akwAIQb7G",
        ["._akwAIQb7G{text-decoration-color:transparent;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "AIQb7G",
            "val\\0kw\\0& | \\0text-decoration-color:transparent",
          ),
        ],
      ),
      (
        "_akwRaYk5d",
        ["._akwRaYk5d{text-decoration-color:currentColor;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RaYk5d",
            "val\\0kw\\0& | \\0text-decoration-color:currentColor",
          ),
        ],
      ),
      (
        "_a7rb7DGLp",
        [
          "._a7rb7DGLp{-webkit-column-rule-color:rgba(0,0,0,0.5);column-rule-color:rgba(0,0,0,0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "b7DGLp",
            "val\\07r\\0& | \\0column-rule-color:rgba(0,0,0,0.5)",
          ),
        ],
      ),
      (
        "_a7r0YRAJZ",
        ["._a7r0YRAJZ{-webkit-column-rule-color:#F06;column-rule-color:#F06;}"],
        1,
        0,
        1,
        [("value", "0YRAJZ", "val\\07r\\0& | \\0column-rule-color:#F06")],
      ),
      (
        "_a7rMFZzAF",
        [
          "._a7rMFZzAF{-webkit-column-rule-color:#FF0066;column-rule-color:#FF0066;}",
        ],
        1,
        0,
        1,
        [("value", "MFZzAF", "val\\07r\\0& | \\0column-rule-color:#FF0066")],
      ),
      (
        "_a7rtG4IF1",
        [
          "._a7rtG4IF1{-webkit-column-rule-color:hsl(0,0%,0%);column-rule-color:hsl(0,0%,0%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "tG4IF1",
            "val\\07r\\0& | \\0column-rule-color:hsl(0,0%,0%)",
          ),
        ],
      ),
      (
        "_a7rgRc2bu",
        [
          "._a7rgRc2bu{-webkit-column-rule-color:hsl(0,0%,0%,0.5);column-rule-color:hsl(0,0%,0%,0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "gRc2bu",
            "val\\07r\\0& | \\0column-rule-color:hsl(0,0%,0%,0.5)",
          ),
        ],
      ),
      (
        "_a7ruGKvi_",
        [
          "._a7ruGKvi_{-webkit-column-rule-color:transparent;column-rule-color:transparent;}",
        ],
        1,
        0,
        1,
        [
          ("value", "uGKvi_", "val\\07r\\0& | \\0column-rule-color:transparent"),
        ],
      ),
      (
        "_a7rahZdYJ",
        [
          "._a7rahZdYJ{-webkit-column-rule-color:currentColor;column-rule-color:currentColor;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ahZdYJ",
            "val\\07r\\0& | \\0column-rule-color:currentColor",
          ),
        ],
      ),
      (
        "_a7fWIoAun",
        ["._a7fWIoAun{color:rgb(0% 20% 70%);}"],
        1,
        0,
        1,
        [("value", "WIoAun", "val\\07f\\0& | \\0color:rgb(0% 20% 70%)")],
      ),
      (
        "_a7fhFNMgE",
        ["._a7fhFNMgE{color:rgb(0 64 185);}"],
        1,
        0,
        1,
        [("value", "hFNMgE", "val\\07f\\0& | \\0color:rgb(0 64 185)")],
      ),
      (
        "_a7fb_iyDX",
        ["._a7fb_iyDX{color:hsl(0 0% 0%);}"],
        1,
        0,
        1,
        [("value", "b_iyDX", "val\\07f\\0& | \\0color:hsl(0 0% 0%)")],
      ),
      (
        "_a7fy8M8WR",
        ["._a7fy8M8WR{color:rgba(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [
          ("value", "y8M8WR", "val\\07f\\0& | \\0color:rgba(0% 20% 70% / 50%)"),
        ],
      ),
      (
        "_a7ftqu5pw",
        ["._a7ftqu5pw{color:rgba(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [
          ("value", "tqu5pw", "val\\07f\\0& | \\0color:rgba(0% 20% 70% / 0.5)"),
        ],
      ),
      (
        "_a7fBuzJu9",
        ["._a7fBuzJu9{color:rgba(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [("value", "BuzJu9", "val\\07f\\0& | \\0color:rgba(0 64 185 / 50%)")],
      ),
      (
        "_a7fOpl3n_",
        ["._a7fOpl3n_{color:rgba(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [("value", "Opl3n_", "val\\07f\\0& | \\0color:rgba(0 64 185 / 0.5)")],
      ),
      (
        "_a7fslpEW5",
        ["._a7fslpEW5{color:hsla(0 0% 0% /0.5);}"],
        1,
        0,
        1,
        [("value", "slpEW5", "val\\07f\\0& | \\0color:hsla(0 0% 0% /0.5)")],
      ),
      (
        "_a7fpn8ePK",
        ["._a7fpn8ePK{color:rgb(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [("value", "pn8ePK", "val\\07f\\0& | \\0color:rgb(0% 20% 70% / 50%)")],
      ),
      (
        "_a7fyKZGb8",
        ["._a7fyKZGb8{color:rgb(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [("value", "yKZGb8", "val\\07f\\0& | \\0color:rgb(0% 20% 70% / 0.5)")],
      ),
      (
        "_a7fjsRp8r",
        ["._a7fjsRp8r{color:rgb(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [("value", "jsRp8r", "val\\07f\\0& | \\0color:rgb(0 64 185 / 50%)")],
      ),
      (
        "_a7fcbYERc",
        ["._a7fcbYERc{color:rgb(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [("value", "cbYERc", "val\\07f\\0& | \\0color:rgb(0 64 185 / 0.5)")],
      ),
      (
        "_a7f7WrbkJ",
        ["._a7f7WrbkJ{color:hsl(0 0% 0% / 0.5);}"],
        1,
        0,
        1,
        [("value", "7WrbkJ", "val\\07f\\0& | \\0color:hsl(0 0% 0% / 0.5)")],
      ),
      (
        "_a7fWus3NA",
        ["._a7fWus3NA{color:#000F;}"],
        1,
        0,
        1,
        [("value", "Wus3NA", "val\\07f\\0& | \\0color:#000F")],
      ),
      (
        "_a7f-VkUwE",
        ["._a7f-VkUwE{color:#000000FF;}"],
        1,
        0,
        1,
        [("value", "-VkUwE", "val\\07f\\0& | \\0color:#000000FF")],
      ),
      (
        "_a7fmnr4PH",
        ["._a7fmnr4PH{color:rebeccapurple;}"],
        1,
        0,
        1,
        [("value", "mnr4PH", "val\\07f\\0& | \\0color:rebeccapurple")],
      ),
      (
        "_a4lW_WNMJ",
        ["._a4lW_WNMJ{background-color:rgb(0% 20% 70%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "W_WNMJ",
            "val\\04l\\0& | \\0background-color:rgb(0% 20% 70%)",
          ),
        ],
      ),
      (
        "_a4lGKBFZu",
        ["._a4lGKBFZu{background-color:rgb(0 64 185);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "GKBFZu",
            "val\\04l\\0& | \\0background-color:rgb(0 64 185)",
          ),
        ],
      ),
      (
        "_a4lKRqtg9",
        ["._a4lKRqtg9{background-color:hsl(0 0% 0%);}"],
        1,
        0,
        1,
        [
          ("value", "KRqtg9", "val\\04l\\0& | \\0background-color:hsl(0 0% 0%)"),
        ],
      ),
      (
        "_a4lopcLiG",
        ["._a4lopcLiG{background-color:rgba(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "opcLiG",
            "val\\04l\\0& | \\0background-color:rgba(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a4lEkmMxp",
        ["._a4lEkmMxp{background-color:rgba(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EkmMxp",
            "val\\04l\\0& | \\0background-color:rgba(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a4lb08Zdf",
        ["._a4lb08Zdf{background-color:rgba(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "b08Zdf",
            "val\\04l\\0& | \\0background-color:rgba(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a4ljfe9Xy",
        ["._a4ljfe9Xy{background-color:rgba(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "jfe9Xy",
            "val\\04l\\0& | \\0background-color:rgba(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a4liL1aez",
        ["._a4liL1aez{background-color:hsla(0 0% 0% /0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iL1aez",
            "val\\04l\\0& | \\0background-color:hsla(0 0% 0% /0.5)",
          ),
        ],
      ),
      (
        "_a4lFYnTRe",
        ["._a4lFYnTRe{background-color:rgb(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FYnTRe",
            "val\\04l\\0& | \\0background-color:rgb(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a4lEGNXRS",
        ["._a4lEGNXRS{background-color:rgb(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EGNXRS",
            "val\\04l\\0& | \\0background-color:rgb(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a4lMhGG74",
        ["._a4lMhGG74{background-color:rgb(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MhGG74",
            "val\\04l\\0& | \\0background-color:rgb(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a4lw19ajb",
        ["._a4lw19ajb{background-color:rgb(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "w19ajb",
            "val\\04l\\0& | \\0background-color:rgb(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a4lWj6pc2",
        ["._a4lWj6pc2{background-color:hsl(0 0% 0% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Wj6pc2",
            "val\\04l\\0& | \\0background-color:hsl(0 0% 0% / 0.5)",
          ),
        ],
      ),
      (
        "_a4lPearSv",
        ["._a4lPearSv{background-color:#000F;}"],
        1,
        0,
        1,
        [("value", "PearSv", "val\\04l\\0& | \\0background-color:#000F")],
      ),
      (
        "_a4lyrkR6v",
        ["._a4lyrkR6v{background-color:#000000FF;}"],
        1,
        0,
        1,
        [("value", "yrkR6v", "val\\04l\\0& | \\0background-color:#000000FF")],
      ),
      (
        "_a4lQMq4D1",
        ["._a4lQMq4D1{background-color:rebeccapurple;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QMq4D1",
            "val\\04l\\0& | \\0background-color:rebeccapurple",
          ),
        ],
      ),
      (
        "_a5kGu7UUp",
        ["._a5kGu7UUp{border-color:rgb(0% 20% 70%);}"],
        1,
        0,
        4,
        [
          ("value", "Gu7UUp", "val\\05k\\0& | \\0border-color:rgb(0% 20% 70%)"),
        ],
      ),
      (
        "_a5ka3-bDQ",
        ["._a5ka3-bDQ{border-color:rgb(0 64 185);}"],
        1,
        0,
        4,
        [("value", "a3-bDQ", "val\\05k\\0& | \\0border-color:rgb(0 64 185)")],
      ),
      (
        "_a5kaW77XE",
        ["._a5kaW77XE{border-color:hsl(0 0% 0%);}"],
        1,
        0,
        4,
        [("value", "aW77XE", "val\\05k\\0& | \\0border-color:hsl(0 0% 0%)")],
      ),
      (
        "_a5kfgQ3e2",
        ["._a5kfgQ3e2{border-color:rgba(0% 20% 70% / 50%);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "fgQ3e2",
            "val\\05k\\0& | \\0border-color:rgba(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a5kw-iU23",
        ["._a5kw-iU23{border-color:rgba(0% 20% 70% / 0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "w-iU23",
            "val\\05k\\0& | \\0border-color:rgba(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a5kVrPSVJ",
        ["._a5kVrPSVJ{border-color:rgba(0 64 185 / 50%);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "VrPSVJ",
            "val\\05k\\0& | \\0border-color:rgba(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a5kAdNETy",
        ["._a5kAdNETy{border-color:rgba(0 64 185 / 0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "AdNETy",
            "val\\05k\\0& | \\0border-color:rgba(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a5kMQmLWc",
        ["._a5kMQmLWc{border-color:hsla(0 0% 0% /0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "MQmLWc",
            "val\\05k\\0& | \\0border-color:hsla(0 0% 0% /0.5)",
          ),
        ],
      ),
      (
        "_a5kZYj4_Z",
        ["._a5kZYj4_Z{border-color:rgb(0% 20% 70% / 50%);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "ZYj4_Z",
            "val\\05k\\0& | \\0border-color:rgb(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a5keR7epM",
        ["._a5keR7epM{border-color:rgb(0% 20% 70% / 0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "eR7epM",
            "val\\05k\\0& | \\0border-color:rgb(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a5k6CW6MV",
        ["._a5k6CW6MV{border-color:rgb(0 64 185 / 50%);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "6CW6MV",
            "val\\05k\\0& | \\0border-color:rgb(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a5kz2GlqB",
        ["._a5kz2GlqB{border-color:rgb(0 64 185 / 0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "z2GlqB",
            "val\\05k\\0& | \\0border-color:rgb(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a5kS_xib0",
        ["._a5kS_xib0{border-color:hsl(0 0% 0% / 0.5);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "S_xib0",
            "val\\05k\\0& | \\0border-color:hsl(0 0% 0% / 0.5)",
          ),
        ],
      ),
      (
        "_a5kp3xQwf",
        ["._a5kp3xQwf{border-color:#000F;}"],
        1,
        0,
        4,
        [("value", "p3xQwf", "val\\05k\\0& | \\0border-color:#000F")],
      ),
      (
        "_a5keL5Zfc",
        ["._a5keL5Zfc{border-color:#000000FF;}"],
        1,
        0,
        4,
        [("value", "eL5Zfc", "val\\05k\\0& | \\0border-color:#000000FF")],
      ),
      (
        "_a5ksmZbkw",
        ["._a5ksmZbkw{border-color:rebeccapurple;}"],
        1,
        0,
        4,
        [("value", "smZbkw", "val\\05k\\0& | \\0border-color:rebeccapurple")],
      ),
      (
        "_akwgs12ta",
        ["._akwgs12ta{text-decoration-color:rgb(0% 20% 70%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "gs12ta",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0% 20% 70%)",
          ),
        ],
      ),
      (
        "_akwKC5GyV",
        ["._akwKC5GyV{text-decoration-color:rgb(0 64 185);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "KC5GyV",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0 64 185)",
          ),
        ],
      ),
      (
        "_akwrXJDLv",
        ["._akwrXJDLv{text-decoration-color:hsl(0 0% 0%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "rXJDLv",
            "val\\0kw\\0& | \\0text-decoration-color:hsl(0 0% 0%)",
          ),
        ],
      ),
      (
        "_akws4kqXV",
        ["._akws4kqXV{text-decoration-color:rgba(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "s4kqXV",
            "val\\0kw\\0& | \\0text-decoration-color:rgba(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_akwmmPMk-",
        ["._akwmmPMk-{text-decoration-color:rgba(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "mmPMk-",
            "val\\0kw\\0& | \\0text-decoration-color:rgba(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_akwWE8foQ",
        ["._akwWE8foQ{text-decoration-color:rgba(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "WE8foQ",
            "val\\0kw\\0& | \\0text-decoration-color:rgba(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_akwzvhn5v",
        ["._akwzvhn5v{text-decoration-color:rgba(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "zvhn5v",
            "val\\0kw\\0& | \\0text-decoration-color:rgba(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_akwV5yH3E",
        ["._akwV5yH3E{text-decoration-color:hsla(0 0% 0% /0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "V5yH3E",
            "val\\0kw\\0& | \\0text-decoration-color:hsla(0 0% 0% /0.5)",
          ),
        ],
      ),
      (
        "_akwfqdkJP",
        ["._akwfqdkJP{text-decoration-color:rgb(0% 20% 70% / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "fqdkJP",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_akw_BuR0C",
        ["._akw_BuR0C{text-decoration-color:rgb(0% 20% 70% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "_BuR0C",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_akwXgQo1K",
        ["._akwXgQo1K{text-decoration-color:rgb(0 64 185 / 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XgQo1K",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_akw1VSA1t",
        ["._akw1VSA1t{text-decoration-color:rgb(0 64 185 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1VSA1t",
            "val\\0kw\\0& | \\0text-decoration-color:rgb(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_akwP_N4ty",
        ["._akwP_N4ty{text-decoration-color:hsl(0 0% 0% / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "P_N4ty",
            "val\\0kw\\0& | \\0text-decoration-color:hsl(0 0% 0% / 0.5)",
          ),
        ],
      ),
      (
        "_akwM-8Xyj",
        ["._akwM-8Xyj{text-decoration-color:#000F;}"],
        1,
        0,
        1,
        [("value", "M-8Xyj", "val\\0kw\\0& | \\0text-decoration-color:#000F")],
      ),
      (
        "_akwpFRNep",
        ["._akwpFRNep{text-decoration-color:#000000FF;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pFRNep",
            "val\\0kw\\0& | \\0text-decoration-color:#000000FF",
          ),
        ],
      ),
      (
        "_akwgLIpa5",
        ["._akwgLIpa5{text-decoration-color:rebeccapurple;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "gLIpa5",
            "val\\0kw\\0& | \\0text-decoration-color:rebeccapurple",
          ),
        ],
      ),
      (
        "_a7rnByip_",
        [
          "._a7rnByip_{-webkit-column-rule-color:rgb(0% 20% 70%);column-rule-color:rgb(0% 20% 70%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "nByip_",
            "val\\07r\\0& | \\0column-rule-color:rgb(0% 20% 70%)",
          ),
        ],
      ),
      (
        "_a7rbMTjtz",
        [
          "._a7rbMTjtz{-webkit-column-rule-color:rgb(0 64 185);column-rule-color:rgb(0 64 185);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "bMTjtz",
            "val\\07r\\0& | \\0column-rule-color:rgb(0 64 185)",
          ),
        ],
      ),
      (
        "_a7r6mCg8e",
        [
          "._a7r6mCg8e{-webkit-column-rule-color:hsl(0 0% 0%);column-rule-color:hsl(0 0% 0%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "6mCg8e",
            "val\\07r\\0& | \\0column-rule-color:hsl(0 0% 0%)",
          ),
        ],
      ),
      (
        "_a7rjnynWB",
        [
          "._a7rjnynWB{-webkit-column-rule-color:rgba(0% 20% 70% / 50%);column-rule-color:rgba(0% 20% 70% / 50%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "jnynWB",
            "val\\07r\\0& | \\0column-rule-color:rgba(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a7rtChgse",
        [
          "._a7rtChgse{-webkit-column-rule-color:rgba(0% 20% 70% / 0.5);column-rule-color:rgba(0% 20% 70% / 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "tChgse",
            "val\\07r\\0& | \\0column-rule-color:rgba(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a7rZfZBsH",
        [
          "._a7rZfZBsH{-webkit-column-rule-color:rgba(0 64 185 / 50%);column-rule-color:rgba(0 64 185 / 50%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZfZBsH",
            "val\\07r\\0& | \\0column-rule-color:rgba(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a7rTAq9GZ",
        [
          "._a7rTAq9GZ{-webkit-column-rule-color:rgba(0 64 185 / 0.5);column-rule-color:rgba(0 64 185 / 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "TAq9GZ",
            "val\\07r\\0& | \\0column-rule-color:rgba(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a7raH7i1l",
        [
          "._a7raH7i1l{-webkit-column-rule-color:hsla(0 0% 0% /0.5);column-rule-color:hsla(0 0% 0% /0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "aH7i1l",
            "val\\07r\\0& | \\0column-rule-color:hsla(0 0% 0% /0.5)",
          ),
        ],
      ),
      (
        "_a7rgdV7J9",
        [
          "._a7rgdV7J9{-webkit-column-rule-color:rgb(0% 20% 70% / 50%);column-rule-color:rgb(0% 20% 70% / 50%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "gdV7J9",
            "val\\07r\\0& | \\0column-rule-color:rgb(0% 20% 70% / 50%)",
          ),
        ],
      ),
      (
        "_a7rlhhWSV",
        [
          "._a7rlhhWSV{-webkit-column-rule-color:rgb(0% 20% 70% / 0.5);column-rule-color:rgb(0% 20% 70% / 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "lhhWSV",
            "val\\07r\\0& | \\0column-rule-color:rgb(0% 20% 70% / 0.5)",
          ),
        ],
      ),
      (
        "_a7r9YZOMR",
        [
          "._a7r9YZOMR{-webkit-column-rule-color:rgb(0 64 185 / 50%);column-rule-color:rgb(0 64 185 / 50%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "9YZOMR",
            "val\\07r\\0& | \\0column-rule-color:rgb(0 64 185 / 50%)",
          ),
        ],
      ),
      (
        "_a7rrXsN-9",
        [
          "._a7rrXsN-9{-webkit-column-rule-color:rgb(0 64 185 / 0.5);column-rule-color:rgb(0 64 185 / 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "rXsN-9",
            "val\\07r\\0& | \\0column-rule-color:rgb(0 64 185 / 0.5)",
          ),
        ],
      ),
      (
        "_a7rsFCyih",
        [
          "._a7rsFCyih{-webkit-column-rule-color:hsl(0 0% 0% / 0.5);column-rule-color:hsl(0 0% 0% / 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "sFCyih",
            "val\\07r\\0& | \\0column-rule-color:hsl(0 0% 0% / 0.5)",
          ),
        ],
      ),
      (
        "_a7r-OH1mU",
        [
          "._a7r-OH1mU{-webkit-column-rule-color:#000F;column-rule-color:#000F;}",
        ],
        1,
        0,
        1,
        [("value", "-OH1mU", "val\\07r\\0& | \\0column-rule-color:#000F")],
      ),
      (
        "_a7rmq6NMT",
        [
          "._a7rmq6NMT{-webkit-column-rule-color:#000000FF;column-rule-color:#000000FF;}",
        ],
        1,
        0,
        1,
        [("value", "mq6NMT", "val\\07r\\0& | \\0column-rule-color:#000000FF")],
      ),
      (
        "_a7rNb2yQS",
        [
          "._a7rNb2yQS{-webkit-column-rule-color:rebeccapurple;column-rule-color:rebeccapurple;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Nb2yQS",
            "val\\07r\\0& | \\0column-rule-color:rebeccapurple",
          ),
        ],
      ),
      (
        "_a7fcriddF",
        ["._a7fcriddF{color:color-mix(in srgb, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "criddF",
            "val\\07f\\0& | \\0color:color-mix(in srgb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fzqpKAt",
        [
          "._a7fzqpKAt{color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "zqpKAt",
            "val\\07f\\0& | \\0color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive)",
          ),
        ],
      ),
      (
        "_a7feCDaSW",
        [
          "._a7feCDaSW{color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "eCDaSW",
            "val\\07f\\0& | \\0color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a7fXdrzUD",
        [
          "._a7fXdrzUD{color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "XdrzUD",
            "val\\07f\\0& | \\0color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a7fe4Kq9x",
        ["._a7fe4Kq9x{color:color-mix(in lch, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "e4Kq9x",
            "val\\07f\\0& | \\0color:color-mix(in lch, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fsxilFT",
        ["._a7fsxilFT{color:color-mix(in hsl, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sxilFT",
            "val\\07f\\0& | \\0color:color-mix(in hsl, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7faGgzjS",
        ["._a7faGgzjS{color:color-mix(in hwb, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "aGgzjS",
            "val\\07f\\0& | \\0color:color-mix(in hwb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fLrQ4h0",
        ["._a7fLrQ4h0{color:color-mix(in xyz, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "LrQ4h0",
            "val\\07f\\0& | \\0color:color-mix(in xyz, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fERznft",
        ["._a7fERznft{color:color-mix(in lab, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ERznft",
            "val\\07f\\0& | \\0color:color-mix(in lab, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fHQxEMv",
        [
          "._a7fHQxEMv{color:color-mix(in lch longer hue, hsl(200deg 50% 80%), coral);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "HQxEMv",
            "val\\07f\\0& | \\0color:color-mix(in lch longer hue, hsl(200deg 50% 80%), coral)",
          ),
        ],
      ),
      (
        "_a4lahWqD7",
        ["._a4lahWqD7{background-color:color-mix(in srgb, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ahWqD7",
            "val\\04l\\0& | \\0background-color:color-mix(in srgb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a4lCW6Sly",
        [
          "._a4lCW6Sly{background-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "CW6Sly",
            "val\\04l\\0& | \\0background-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive)",
          ),
        ],
      ),
      (
        "_a4lo-bSdH",
        [
          "._a4lo-bSdH{background-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "o-bSdH",
            "val\\04l\\0& | \\0background-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a4l5ia2CA",
        [
          "._a4l5ia2CA{background-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "5ia2CA",
            "val\\04l\\0& | \\0background-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a4lcNgfhh",
        ["._a4lcNgfhh{background-color:color-mix(in lch, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cNgfhh",
            "val\\04l\\0& | \\0background-color:color-mix(in lch, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a4lsCLYno",
        ["._a4lsCLYno{background-color:color-mix(in hsl, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sCLYno",
            "val\\04l\\0& | \\0background-color:color-mix(in hsl, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a4ln4zdGJ",
        ["._a4ln4zdGJ{background-color:color-mix(in hwb, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "n4zdGJ",
            "val\\04l\\0& | \\0background-color:color-mix(in hwb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a4lU1UGMO",
        ["._a4lU1UGMO{background-color:color-mix(in xyz, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "U1UGMO",
            "val\\04l\\0& | \\0background-color:color-mix(in xyz, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a4lnT_5Y4",
        ["._a4lnT_5Y4{background-color:color-mix(in lab, teal 65%, olive);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nT_5Y4",
            "val\\04l\\0& | \\0background-color:color-mix(in lab, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5k-Mcp1w",
        ["._a5k-Mcp1w{border-color:color-mix(in srgb, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "-Mcp1w",
            "val\\05k\\0& | \\0border-color:color-mix(in srgb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5kvkV-AG",
        [
          "._a5kvkV-AG{border-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}",
        ],
        1,
        0,
        4,
        [
          (
            "value",
            "vkV-AG",
            "val\\05k\\0& | \\0border-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive)",
          ),
        ],
      ),
      (
        "_a5kxrgqMc",
        [
          "._a5kxrgqMc{border-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        4,
        [
          (
            "value",
            "xrgqMc",
            "val\\05k\\0& | \\0border-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a5kz0Rl4W",
        [
          "._a5kz0Rl4W{border-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        4,
        [
          (
            "value",
            "z0Rl4W",
            "val\\05k\\0& | \\0border-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a5kIIQ3Ex",
        ["._a5kIIQ3Ex{border-color:color-mix(in lch, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "IIQ3Ex",
            "val\\05k\\0& | \\0border-color:color-mix(in lch, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5khZC8H2",
        ["._a5khZC8H2{border-color:color-mix(in hsl, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "hZC8H2",
            "val\\05k\\0& | \\0border-color:color-mix(in hsl, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5kdBRtHt",
        ["._a5kdBRtHt{border-color:color-mix(in hwb, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "dBRtHt",
            "val\\05k\\0& | \\0border-color:color-mix(in hwb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5kT7ocAx",
        ["._a5kT7ocAx{border-color:color-mix(in xyz, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "T7ocAx",
            "val\\05k\\0& | \\0border-color:color-mix(in xyz, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a5kejC5dN",
        ["._a5kejC5dN{border-color:color-mix(in lab, teal 65%, olive);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "ejC5dN",
            "val\\05k\\0& | \\0border-color:color-mix(in lab, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akwIn36oR",
        [
          "._akwIn36oR{text-decoration-color:color-mix(in srgb, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "In36oR",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in srgb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akwy3kesq",
        [
          "._akwy3kesq{text-decoration-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "y3kesq",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive)",
          ),
        ],
      ),
      (
        "_akwKZG0RX",
        [
          "._akwKZG0RX{text-decoration-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "KZG0RX",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_akwmMC3xa",
        [
          "._akwmMC3xa{text-decoration-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "mMC3xa",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_akwczfB50",
        [
          "._akwczfB50{text-decoration-color:color-mix(in lch, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "czfB50",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in lch, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akwuLgMpp",
        [
          "._akwuLgMpp{text-decoration-color:color-mix(in hsl, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uLgMpp",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in hsl, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akwTvJeJF",
        [
          "._akwTvJeJF{text-decoration-color:color-mix(in hwb, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "TvJeJF",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in hwb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akw41jUN1",
        [
          "._akw41jUN1{text-decoration-color:color-mix(in xyz, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "41jUN1",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in xyz, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_akwSWJ3dj",
        [
          "._akwSWJ3dj{text-decoration-color:color-mix(in lab, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "SWJ3dj",
            "val\\0kw\\0& | \\0text-decoration-color:color-mix(in lab, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7rjTLGBb",
        [
          "._a7rjTLGBb{-webkit-column-rule-color:color-mix(in srgb, teal 65%, olive);column-rule-color:color-mix(in srgb, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "jTLGBb",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in srgb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7ryBdDFU",
        [
          "._a7ryBdDFU{-webkit-column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "yBdDFU",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive)",
          ),
        ],
      ),
      (
        "_a7rwcnrgn",
        [
          "._a7rwcnrgn{-webkit-column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "wcnrgn",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a7r9KF3lm",
        [
          "._a7r9KF3lm{-webkit-column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "9KF3lm",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%)",
          ),
        ],
      ),
      (
        "_a7rZLRc_5",
        [
          "._a7rZLRc_5{-webkit-column-rule-color:color-mix(in lch, teal 65%, olive);column-rule-color:color-mix(in lch, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZLRc_5",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in lch, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7rUeMvoV",
        [
          "._a7rUeMvoV{-webkit-column-rule-color:color-mix(in hsl, teal 65%, olive);column-rule-color:color-mix(in hsl, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "UeMvoV",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in hsl, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7rdDlS_o",
        [
          "._a7rdDlS_o{-webkit-column-rule-color:color-mix(in hwb, teal 65%, olive);column-rule-color:color-mix(in hwb, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "dDlS_o",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in hwb, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7ru5Qpl2",
        [
          "._a7ru5Qpl2{-webkit-column-rule-color:color-mix(in xyz, teal 65%, olive);column-rule-color:color-mix(in xyz, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "u5Qpl2",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in xyz, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7rTr2PpR",
        [
          "._a7rTr2PpR{-webkit-column-rule-color:color-mix(in lab, teal 65%, olive);column-rule-color:color-mix(in lab, teal 65%, olive);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Tr2PpR",
            "val\\07r\\0& | \\0column-rule-color:color-mix(in lab, teal 65%, olive)",
          ),
        ],
      ),
      (
        "_a7fWT0OP-",
        ["._a7fWT0OP-{color:rgba(0, 0, 0, calc(1));}"],
        1,
        0,
        1,
        [
          ("value", "WT0OP-", "val\\07f\\0& | \\0color:rgba(0, 0, 0, calc(1))"),
        ],
      ),
      (
        "_a7fwWai1P",
        ["._a7fwWai1P{color:rgba(0, 0, 0, calc(10 - 1));}"],
        1,
        0,
        1,
        [
          (
            "value",
            "wWai1P",
            "val\\07f\\0& | \\0color:rgba(0, 0, 0, calc(10 - 1))",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_a7fakDml3", []);
  CSS.make("_a7fRUmiry", []);
  CSS.make("_a7fUJ_N9A", []);
  CSS.make("_a7fUa9GTV", []);
  CSS.make("_a7fwFsXzL", []);
  CSS.make("_a7fYZ-FVs", []);
  CSS.make("_a7fVCl-Y6", []);
  CSS.make("_a4le1hSbX", []);
  CSS.make("_a4lFk9YMx", []);
  CSS.make("_a4l28gWki", []);
  CSS.make("_a4lhYsYWN", []);
  CSS.make("_a4lXlB75-", []);
  CSS.make("_a4lKIA7tC", []);
  CSS.make("_a4l4WG0U7", []);
  CSS.make("_a5k7Z8onv", []);
  CSS.make("_a5k3wNszX", []);
  CSS.make("_a5kma_Cyt", []);
  CSS.make("_a5k5-kNj2", []);
  CSS.make("_a5krA8H3N", []);
  CSS.make("_a5k6qVB1H", []);
  CSS.make("_a5kYg2rW_", []);
  CSS.make("_akwQ1tbpO", []);
  CSS.make("_akwLE6cPG", []);
  CSS.make("_akwzdtpMx", []);
  CSS.make("_akw6wxaWo", []);
  CSS.make("_akw2n-Fqa", []);
  CSS.make("_akwAIQb7G", []);
  CSS.make("_akwRaYk5d", []);
  CSS.make("_a7rb7DGLp", []);
  CSS.make("_a7r0YRAJZ", []);
  CSS.make("_a7rMFZzAF", []);
  CSS.make("_a7rtG4IF1", []);
  CSS.make("_a7rgRc2bu", []);
  CSS.make("_a7ruGKvi_", []);
  CSS.make("_a7rahZdYJ", []);
  
  CSS.make("_a7fWIoAun", []);
  CSS.make("_a7fhFNMgE", []);
  CSS.make("_a7fb_iyDX", []);
  CSS.make("_a7fy8M8WR", []);
  CSS.make("_a7ftqu5pw", []);
  CSS.make("_a7fBuzJu9", []);
  CSS.make("_a7fOpl3n_", []);
  CSS.make("_a7fslpEW5", []);
  CSS.make("_a7fpn8ePK", []);
  CSS.make("_a7fyKZGb8", []);
  CSS.make("_a7fjsRp8r", []);
  CSS.make("_a7fcbYERc", []);
  CSS.make("_a7f7WrbkJ", []);
  CSS.make("_a7fWus3NA", []);
  CSS.make("_a7f-VkUwE", []);
  CSS.make("_a7fmnr4PH", []);
  
  CSS.make("_a4lW_WNMJ", []);
  CSS.make("_a4lGKBFZu", []);
  CSS.make("_a4lKRqtg9", []);
  CSS.make("_a4lopcLiG", []);
  CSS.make("_a4lEkmMxp", []);
  CSS.make("_a4lb08Zdf", []);
  CSS.make("_a4ljfe9Xy", []);
  CSS.make("_a4liL1aez", []);
  CSS.make("_a4lFYnTRe", []);
  CSS.make("_a4lEGNXRS", []);
  CSS.make("_a4lMhGG74", []);
  CSS.make("_a4lw19ajb", []);
  CSS.make("_a4lWj6pc2", []);
  CSS.make("_a4lPearSv", []);
  CSS.make("_a4lyrkR6v", []);
  CSS.make("_a4lQMq4D1", []);
  CSS.make("_a5kGu7UUp", []);
  CSS.make("_a5ka3-bDQ", []);
  CSS.make("_a5kaW77XE", []);
  CSS.make("_a5kfgQ3e2", []);
  CSS.make("_a5kw-iU23", []);
  CSS.make("_a5kVrPSVJ", []);
  CSS.make("_a5kAdNETy", []);
  CSS.make("_a5kMQmLWc", []);
  CSS.make("_a5kZYj4_Z", []);
  CSS.make("_a5keR7epM", []);
  CSS.make("_a5k6CW6MV", []);
  CSS.make("_a5kz2GlqB", []);
  CSS.make("_a5kS_xib0", []);
  CSS.make("_a5kp3xQwf", []);
  CSS.make("_a5keL5Zfc", []);
  CSS.make("_a5ksmZbkw", []);
  CSS.make("_akwgs12ta", []);
  CSS.make("_akwKC5GyV", []);
  CSS.make("_akwrXJDLv", []);
  CSS.make("_akws4kqXV", []);
  CSS.make("_akwmmPMk-", []);
  CSS.make("_akwWE8foQ", []);
  CSS.make("_akwzvhn5v", []);
  CSS.make("_akwV5yH3E", []);
  CSS.make("_akwfqdkJP", []);
  CSS.make("_akw_BuR0C", []);
  CSS.make("_akwXgQo1K", []);
  CSS.make("_akw1VSA1t", []);
  CSS.make("_akwP_N4ty", []);
  CSS.make("_akwM-8Xyj", []);
  CSS.make("_akwpFRNep", []);
  CSS.make("_akwgLIpa5", []);
  CSS.make("_a7rnByip_", []);
  CSS.make("_a7rbMTjtz", []);
  CSS.make("_a7r6mCg8e", []);
  CSS.make("_a7rjnynWB", []);
  CSS.make("_a7rtChgse", []);
  CSS.make("_a7rZfZBsH", []);
  CSS.make("_a7rTAq9GZ", []);
  CSS.make("_a7raH7i1l", []);
  CSS.make("_a7rgdV7J9", []);
  CSS.make("_a7rlhhWSV", []);
  CSS.make("_a7r9YZOMR", []);
  CSS.make("_a7rrXsN-9", []);
  CSS.make("_a7rsFCyih", []);
  CSS.make("_a7r-OH1mU", []);
  CSS.make("_a7rmq6NMT", []);
  CSS.make("_a7rNb2yQS", []);
  
  CSS.make("_a7fcriddF", []);
  CSS.make("_a7fzqpKAt", []);
  CSS.make("_a7feCDaSW", []);
  CSS.make("_a7fXdrzUD", []);
  CSS.make("_a7fe4Kq9x", []);
  CSS.make("_a7fsxilFT", []);
  CSS.make("_a7faGgzjS", []);
  CSS.make("_a7fLrQ4h0", []);
  CSS.make("_a7fERznft", []);
  CSS.make("_a7fHQxEMv", []);
  
  CSS.make("_a4lahWqD7", []);
  CSS.make("_a4lCW6Sly", []);
  CSS.make("_a4lo-bSdH", []);
  CSS.make("_a4l5ia2CA", []);
  CSS.make("_a4lcNgfhh", []);
  CSS.make("_a4lsCLYno", []);
  CSS.make("_a4ln4zdGJ", []);
  CSS.make("_a4lU1UGMO", []);
  CSS.make("_a4lnT_5Y4", []);
  
  CSS.make("_a5k-Mcp1w", []);
  CSS.make("_a5kvkV-AG", []);
  CSS.make("_a5kxrgqMc", []);
  CSS.make("_a5kz0Rl4W", []);
  CSS.make("_a5kIIQ3Ex", []);
  CSS.make("_a5khZC8H2", []);
  CSS.make("_a5kdBRtHt", []);
  CSS.make("_a5kT7ocAx", []);
  CSS.make("_a5kejC5dN", []);
  
  CSS.make("_akwIn36oR", []);
  CSS.make("_akwy3kesq", []);
  CSS.make("_akwKZG0RX", []);
  CSS.make("_akwmMC3xa", []);
  CSS.make("_akwczfB50", []);
  CSS.make("_akwuLgMpp", []);
  CSS.make("_akwTvJeJF", []);
  CSS.make("_akw41jUN1", []);
  CSS.make("_akwSWJ3dj", []);
  
  CSS.make("_a7rjTLGBb", []);
  CSS.make("_a7ryBdDFU", []);
  CSS.make("_a7rwcnrgn", []);
  CSS.make("_a7r9KF3lm", []);
  CSS.make("_a7rZLRc_5", []);
  CSS.make("_a7rUeMvoV", []);
  CSS.make("_a7rdDlS_o", []);
  CSS.make("_a7ru5Qpl2", []);
  CSS.make("_a7rTr2PpR", []);
  
  CSS.make("_a7fWT0OP-", []);
  CSS.make("_a7fwWai1P", []);
