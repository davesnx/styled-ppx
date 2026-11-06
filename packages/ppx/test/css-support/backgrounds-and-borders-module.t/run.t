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
  [@css "@property --elevation1-1rnnems_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-1rnnems_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-1rnnems_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-35oif8_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-35oif8_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-35oif8_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1dnob2v_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1dnob2v_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1dnob2v_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1dnob2v_4{syntax:\"*\";inherits:false;}"];
  [@css "@property --boxDark-iyil7j{syntax:\"*\";inherits:false;}"];
  [@css
    "@keyframes keyframe-1b5h4ts{0%{background-position:0 0;}100%{background-position:1rem 0;}}"
  ];
  [@css.atoms
    [
      (
        "_a4r9TQgHG",
        ["._a4r9TQgHG{background-repeat:space;}"],
        1,
        0,
        1,
        [("value", "9TQgHG", "val\\04r\\0& | \\0background-repeat:space")],
      ),
      (
        "_a4rM-BGyr",
        ["._a4rM-BGyr{background-repeat:round;}"],
        1,
        0,
        1,
        [("value", "M-BGyr", "val\\04r\\0& | \\0background-repeat:round")],
      ),
      (
        "_a4r3kikJy",
        ["._a4r3kikJy{background-repeat:repeat repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "3kikJy",
            "val\\04r\\0& | \\0background-repeat:repeat repeat",
          ),
        ],
      ),
      (
        "_a4rsRD5TI",
        ["._a4rsRD5TI{background-repeat:space repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sRD5TI",
            "val\\04r\\0& | \\0background-repeat:space repeat",
          ),
        ],
      ),
      (
        "_a4raEKn2Z",
        ["._a4raEKn2Z{background-repeat:round repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "aEKn2Z",
            "val\\04r\\0& | \\0background-repeat:round repeat",
          ),
        ],
      ),
      (
        "_a4rnpeO0_",
        ["._a4rnpeO0_{background-repeat:no-repeat repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "npeO0_",
            "val\\04r\\0& | \\0background-repeat:no-repeat repeat",
          ),
        ],
      ),
      (
        "_a4rEWCJ7c",
        ["._a4rEWCJ7c{background-repeat:repeat space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EWCJ7c",
            "val\\04r\\0& | \\0background-repeat:repeat space",
          ),
        ],
      ),
      (
        "_a4rruU4lq",
        ["._a4rruU4lq{background-repeat:space space;}"],
        1,
        0,
        1,
        [
          ("value", "ruU4lq", "val\\04r\\0& | \\0background-repeat:space space"),
        ],
      ),
      (
        "_a4rH6HyZI",
        ["._a4rH6HyZI{background-repeat:round space;}"],
        1,
        0,
        1,
        [
          ("value", "H6HyZI", "val\\04r\\0& | \\0background-repeat:round space"),
        ],
      ),
      (
        "_a4rtfyAHS",
        ["._a4rtfyAHS{background-repeat:no-repeat space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "tfyAHS",
            "val\\04r\\0& | \\0background-repeat:no-repeat space",
          ),
        ],
      ),
      (
        "_a4r5DnUgY",
        ["._a4r5DnUgY{background-repeat:repeat round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "5DnUgY",
            "val\\04r\\0& | \\0background-repeat:repeat round",
          ),
        ],
      ),
      (
        "_a4rce1Ewr",
        ["._a4rce1Ewr{background-repeat:space round;}"],
        1,
        0,
        1,
        [
          ("value", "ce1Ewr", "val\\04r\\0& | \\0background-repeat:space round"),
        ],
      ),
      (
        "_a4rHu8ddp",
        ["._a4rHu8ddp{background-repeat:round round;}"],
        1,
        0,
        1,
        [
          ("value", "Hu8ddp", "val\\04r\\0& | \\0background-repeat:round round"),
        ],
      ),
      (
        "_a4rQEPEa8",
        ["._a4rQEPEa8{background-repeat:no-repeat round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QEPEa8",
            "val\\04r\\0& | \\0background-repeat:no-repeat round",
          ),
        ],
      ),
      (
        "_a4r5Z2dz5",
        ["._a4r5Z2dz5{background-repeat:repeat no-repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "5Z2dz5",
            "val\\04r\\0& | \\0background-repeat:repeat no-repeat",
          ),
        ],
      ),
      (
        "_a4rUb1lIb",
        ["._a4rUb1lIb{background-repeat:space no-repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Ub1lIb",
            "val\\04r\\0& | \\0background-repeat:space no-repeat",
          ),
        ],
      ),
      (
        "_a4ryjz0XB",
        ["._a4ryjz0XB{background-repeat:round no-repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yjz0XB",
            "val\\04r\\0& | \\0background-repeat:round no-repeat",
          ),
        ],
      ),
      (
        "_a4rEAbgE7",
        ["._a4rEAbgE7{background-repeat:no-repeat no-repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EAbgE7",
            "val\\04r\\0& | \\0background-repeat:no-repeat no-repeat",
          ),
        ],
      ),
      (
        "_a4rBe2z1g",
        ["._a4rBe2z1g{background-repeat:repeat-x, repeat-y;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Be2z1g",
            "val\\04r\\0& | \\0background-repeat:repeat-x, repeat-y",
          ),
        ],
      ),
      (
        "_a4iKFSzKl",
        ["._a4iKFSzKl{background-attachment:local;}"],
        1,
        0,
        1,
        [("value", "KFSzKl", "val\\04i\\0& | \\0background-attachment:local")],
      ),
      (
        "_a4k_xMCic",
        [
          "._a4k_xMCic{-webkit-background-clip:border-box;background-clip:border-box;}",
        ],
        1,
        0,
        1,
        [("value", "_xMCic", "val\\04k\\0& | \\0background-clip:border-box")],
      ),
      (
        "_a4kp10t94",
        [
          "._a4kp10t94{-webkit-background-clip:padding-box;background-clip:padding-box;}",
        ],
        1,
        0,
        1,
        [("value", "p10t94", "val\\04k\\0& | \\0background-clip:padding-box")],
      ),
      (
        "_a4kaSOGAV",
        [
          "._a4kaSOGAV{-webkit-background-clip:content-box;background-clip:content-box;}",
        ],
        1,
        0,
        1,
        [("value", "aSOGAV", "val\\04k\\0& | \\0background-clip:content-box")],
      ),
      (
        "_a4kmU-v31",
        ["._a4kmU-v31{-webkit-background-clip:text;background-clip:text;}"],
        1,
        0,
        1,
        [("value", "mU-v31", "val\\04k\\0& | \\0background-clip:text")],
      ),
      (
        "_a4kfdNguz",
        [
          "._a4kfdNguz{-webkit-background-clip:border-area;background-clip:border-area;}",
        ],
        1,
        0,
        1,
        [("value", "fdNguz", "val\\04k\\0& | \\0background-clip:border-area")],
      ),
      (
        "_a4kaiqIbH",
        [
          "._a4kaiqIbH{-webkit-background-clip:text, border-area;background-clip:text, border-area;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "aiqIbH",
            "val\\04k\\0& | \\0background-clip:text, border-area",
          ),
        ],
      ),
      (
        "_a4nNhFd6l",
        ["._a4nNhFd6l{background-origin:border-box;}"],
        1,
        0,
        1,
        [
          ("value", "NhFd6l", "val\\04n\\0& | \\0background-origin:border-box"),
        ],
      ),
      (
        "_a4n8KBVbw",
        ["._a4n8KBVbw{background-origin:padding-box;}"],
        1,
        0,
        1,
        [
          ("value", "8KBVbw", "val\\04n\\0& | \\0background-origin:padding-box"),
        ],
      ),
      (
        "_a4nXljOaq",
        ["._a4nXljOaq{background-origin:content-box;}"],
        1,
        0,
        1,
        [
          ("value", "XljOaq", "val\\04n\\0& | \\0background-origin:content-box"),
        ],
      ),
      (
        "_a4sWHT964",
        ["._a4sWHT964{background-size:auto;}"],
        1,
        0,
        1,
        [("value", "WHT964", "val\\04s\\0& | \\0background-size:auto")],
      ),
      (
        "_a4sSc3gpg",
        ["._a4sSc3gpg{background-size:cover;}"],
        1,
        0,
        1,
        [("value", "Sc3gpg", "val\\04s\\0& | \\0background-size:cover")],
      ),
      (
        "_a4sR2sUjG",
        ["._a4sR2sUjG{background-size:contain;}"],
        1,
        0,
        1,
        [("value", "R2sUjG", "val\\04s\\0& | \\0background-size:contain")],
      ),
      (
        "_a4sig__4d",
        ["._a4sig__4d{background-size:10px;}"],
        1,
        0,
        1,
        [("value", "ig__4d", "val\\04s\\0& | \\0background-size:10px")],
      ),
      (
        "_a4sxCZjmr",
        ["._a4sxCZjmr{background-size:50%;}"],
        1,
        0,
        1,
        [("value", "xCZjmr", "val\\04s\\0& | \\0background-size:50%")],
      ),
      (
        "_a4sUaogsb",
        ["._a4sUaogsb{background-size:10px auto;}"],
        1,
        0,
        1,
        [("value", "Uaogsb", "val\\04s\\0& | \\0background-size:10px auto")],
      ),
      (
        "_a4sgLy343",
        ["._a4sgLy343{background-size:auto 10%;}"],
        1,
        0,
        1,
        [("value", "gLy343", "val\\04s\\0& | \\0background-size:auto 10%")],
      ),
      (
        "_a4s-k5N6G",
        ["._a4s-k5N6G{background-size:50em 50%;}"],
        1,
        0,
        1,
        [("value", "-k5N6G", "val\\04s\\0& | \\0background-size:50em 50%")],
      ),
      (
        "_a4siuVi2F",
        ["._a4siuVi2F{background-size:20px 20px;}"],
        1,
        0,
        1,
        [("value", "iuVi2F", "val\\04s\\0& | \\0background-size:20px 20px")],
      ),
      (
        "_a4habN55z",
        ["._a4habN55z{background:top left / 50% 60%;}"],
        1,
        0,
        9,
        [
          ("value", "abN55z", "val\\04h\\0& | \\0background:top left / 50% 60%"),
        ],
      ),
      (
        "_a4hEWfKba",
        ["._a4hEWfKba{background:border-box;}"],
        1,
        0,
        9,
        [("value", "EWfKba", "val\\04h\\0& | \\0background:border-box")],
      ),
      (
        "_a4hLxyY_r",
        ["._a4hLxyY_r{background:blue;}"],
        1,
        0,
        9,
        [("value", "LxyY_r", "val\\04h\\0& | \\0background:blue")],
      ),
      (
        "_a4hrJE_4c",
        ["._a4hrJE_4c{background:border-box red;}"],
        1,
        0,
        9,
        [("value", "rJE_4c", "val\\04h\\0& | \\0background:border-box red")],
      ),
      (
        "_a4hLKjuY_",
        ["._a4hLKjuY_{background:border-box padding-box;}"],
        1,
        0,
        9,
        [
          (
            "value",
            "LKjuY_",
            "val\\04h\\0& | \\0background:border-box padding-box",
          ),
        ],
      ),
      (
        "_a4hpnyoza",
        [
          "._a4hpnyoza{background:url(\"foo.png\") bottom right / cover padding-box content-box;}",
        ],
        1,
        0,
        9,
        [
          (
            "value",
            "pnyoza",
            "val\\04h\\0& | \\0background:url(\"foo.png\") bottom right / cover padding-box content-box",
          ),
        ],
      ),
      (
        "_a6lb3Tsjq",
        ["._a6lb3Tsjq{border-top-left-radius:0;}"],
        1,
        0,
        1,
        [("value", "b3Tsjq", "val\\06l\\0& | \\0border-top-left-radius:0")],
      ),
      (
        "_a6lXHavJQ",
        ["._a6lXHavJQ{border-top-left-radius:50%;}"],
        1,
        0,
        1,
        [("value", "XHavJQ", "val\\06l\\0& | \\0border-top-left-radius:50%")],
      ),
      (
        "_a6ljNdziH",
        ["._a6ljNdziH{border-top-left-radius:250px 100px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "jNdziH",
            "val\\06l\\0& | \\0border-top-left-radius:250px 100px",
          ),
        ],
      ),
      (
        "_a6mrv4Ay2",
        ["._a6mrv4Ay2{border-top-right-radius:0;}"],
        1,
        0,
        1,
        [("value", "rv4Ay2", "val\\06m\\0& | \\0border-top-right-radius:0")],
      ),
      (
        "_a6mGNdTlC",
        ["._a6mGNdTlC{border-top-right-radius:50%;}"],
        1,
        0,
        1,
        [("value", "GNdTlC", "val\\06m\\0& | \\0border-top-right-radius:50%")],
      ),
      (
        "_a6mQgL8to",
        ["._a6mQgL8to{border-top-right-radius:250px 100px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QgL8to",
            "val\\06m\\0& | \\0border-top-right-radius:250px 100px",
          ),
        ],
      ),
      (
        "_a5goZESV-",
        ["._a5goZESV-{border-bottom-right-radius:0;}"],
        1,
        0,
        1,
        [
          ("value", "oZESV-", "val\\05g\\0& | \\0border-bottom-right-radius:0"),
        ],
      ),
      (
        "_a5gbSUrYa",
        ["._a5gbSUrYa{border-bottom-right-radius:50%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bSUrYa",
            "val\\05g\\0& | \\0border-bottom-right-radius:50%",
          ),
        ],
      ),
      (
        "_a5gIVpO7D",
        ["._a5gIVpO7D{border-bottom-right-radius:250px 100px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "IVpO7D",
            "val\\05g\\0& | \\0border-bottom-right-radius:250px 100px",
          ),
        ],
      ),
      (
        "_a5fNypWk2",
        ["._a5fNypWk2{border-bottom-left-radius:0;}"],
        1,
        0,
        1,
        [("value", "NypWk2", "val\\05f\\0& | \\0border-bottom-left-radius:0")],
      ),
      (
        "_a5fgghv2X",
        ["._a5fgghv2X{border-bottom-left-radius:50%;}"],
        1,
        0,
        1,
        [
          ("value", "gghv2X", "val\\05f\\0& | \\0border-bottom-left-radius:50%"),
        ],
      ),
      (
        "_a5fyPHLOD",
        ["._a5fyPHLOD{border-bottom-left-radius:250px 100px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yPHLOD",
            "val\\05f\\0& | \\0border-bottom-left-radius:250px 100px",
          ),
        ],
      ),
      (
        "_a69UtuHuu",
        ["._a69UtuHuu{border-radius:10px;}"],
        1,
        0,
        4,
        [("value", "UtuHuu", "val\\069\\0& | \\0border-radius:10px")],
      ),
      (
        "_a69_agmvD",
        ["._a69_agmvD{border-radius:50%;}"],
        1,
        0,
        4,
        [("value", "_agmvD", "val\\069\\0& | \\0border-radius:50%")],
      ),
      (
        "_a69L-cF4Z",
        ["._a69L-cF4Z{border-radius:2px 4px;}"],
        1,
        0,
        4,
        [("value", "L-cF4Z", "val\\069\\0& | \\0border-radius:2px 4px")],
      ),
      (
        "_a69gZNIKm",
        ["._a69gZNIKm{border-radius:2px 4px 8px;}"],
        1,
        0,
        4,
        [("value", "gZNIKm", "val\\069\\0& | \\0border-radius:2px 4px 8px")],
      ),
      (
        "_a69CJ13ZD",
        ["._a69CJ13ZD{border-radius:2px 4px 8px 16px;}"],
        1,
        0,
        4,
        [
          (
            "value",
            "CJ13ZD",
            "val\\069\\0& | \\0border-radius:2px 4px 8px 16px",
          ),
        ],
      ),
      (
        "_a69aqQmVk",
        ["._a69aqQmVk{border-radius:10px / 20px;}"],
        1,
        0,
        4,
        [("value", "aqQmVk", "val\\069\\0& | \\0border-radius:10px / 20px")],
      ),
      (
        "_a69vEtbY8",
        ["._a69vEtbY8{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"],
        1,
        0,
        4,
        [
          (
            "value",
            "vEtbY8",
            "val\\069\\0& | \\0border-radius:2px 4px 8px 16px / 2px 4px 8px 16px",
          ),
        ],
      ),
      (
        "_a5rkRETOD",
        ["._a5rkRETOD{border-image-source:none;}"],
        1,
        0,
        1,
        [("value", "kRETOD", "val\\05r\\0& | \\0border-image-source:none")],
      ),
      (
        "_a5r3Zfda7",
        ["._a5r3Zfda7{border-image-source:url(\"foo.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "3Zfda7",
            "val\\05r\\0& | \\0border-image-source:url(\"foo.png\")",
          ),
        ],
      ),
      (
        "_a5qEJpRwm",
        ["._a5qEJpRwm{border-image-slice:10;}"],
        1,
        0,
        1,
        [("value", "EJpRwm", "val\\05q\\0& | \\0border-image-slice:10")],
      ),
      (
        "_a5qpjZrD-",
        ["._a5qpjZrD-{border-image-slice:30%;}"],
        1,
        0,
        1,
        [("value", "pjZrD-", "val\\05q\\0& | \\0border-image-slice:30%")],
      ),
      (
        "_a5qTWuzuG",
        ["._a5qTWuzuG{border-image-slice:10 10;}"],
        1,
        0,
        1,
        [("value", "TWuzuG", "val\\05q\\0& | \\0border-image-slice:10 10")],
      ),
      (
        "_a5qDGqFND",
        ["._a5qDGqFND{border-image-slice:30% 10;}"],
        1,
        0,
        1,
        [("value", "DGqFND", "val\\05q\\0& | \\0border-image-slice:30% 10")],
      ),
      (
        "_a5qqi4RgL",
        ["._a5qqi4RgL{border-image-slice:10 30%;}"],
        1,
        0,
        1,
        [("value", "qi4RgL", "val\\05q\\0& | \\0border-image-slice:10 30%")],
      ),
      (
        "_a5qRQi9iW",
        ["._a5qRQi9iW{border-image-slice:30% 30%;}"],
        1,
        0,
        1,
        [("value", "RQi9iW", "val\\05q\\0& | \\0border-image-slice:30% 30%")],
      ),
      (
        "_a5qUNFxHg",
        ["._a5qUNFxHg{border-image-slice:10 10 10;}"],
        1,
        0,
        1,
        [("value", "UNFxHg", "val\\05q\\0& | \\0border-image-slice:10 10 10")],
      ),
      (
        "_a5qkaLNkv",
        ["._a5qkaLNkv{border-image-slice:30% 10 10;}"],
        1,
        0,
        1,
        [
          ("value", "kaLNkv", "val\\05q\\0& | \\0border-image-slice:30% 10 10"),
        ],
      ),
      (
        "_a5q5uWSAJ",
        ["._a5q5uWSAJ{border-image-slice:10 30% 10;}"],
        1,
        0,
        1,
        [
          ("value", "5uWSAJ", "val\\05q\\0& | \\0border-image-slice:10 30% 10"),
        ],
      ),
      (
        "_a5qlEXSl_",
        ["._a5qlEXSl_{border-image-slice:30% 30% 10;}"],
        1,
        0,
        1,
        [
          ("value", "lEXSl_", "val\\05q\\0& | \\0border-image-slice:30% 30% 10"),
        ],
      ),
      (
        "_a5qNLmUnZ",
        ["._a5qNLmUnZ{border-image-slice:10 10 30%;}"],
        1,
        0,
        1,
        [
          ("value", "NLmUnZ", "val\\05q\\0& | \\0border-image-slice:10 10 30%"),
        ],
      ),
      (
        "_a5qVWxJYZ",
        ["._a5qVWxJYZ{border-image-slice:30% 10 30%;}"],
        1,
        0,
        1,
        [
          ("value", "VWxJYZ", "val\\05q\\0& | \\0border-image-slice:30% 10 30%"),
        ],
      ),
      (
        "_a5qkhjAC5",
        ["._a5qkhjAC5{border-image-slice:10 30% 30%;}"],
        1,
        0,
        1,
        [
          ("value", "khjAC5", "val\\05q\\0& | \\0border-image-slice:10 30% 30%"),
        ],
      ),
      (
        "_a5qZjhGNd",
        ["._a5qZjhGNd{border-image-slice:30% 30% 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ZjhGNd",
            "val\\05q\\0& | \\0border-image-slice:30% 30% 30%",
          ),
        ],
      ),
      (
        "_a5qwwV6Vh",
        ["._a5qwwV6Vh{border-image-slice:10 10 10 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "wwV6Vh",
            "val\\05q\\0& | \\0border-image-slice:10 10 10 10",
          ),
        ],
      ),
      (
        "_a5qfTvj8f",
        ["._a5qfTvj8f{border-image-slice:30% 10 10 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "fTvj8f",
            "val\\05q\\0& | \\0border-image-slice:30% 10 10 10",
          ),
        ],
      ),
      (
        "_a5qC3IOuK",
        ["._a5qC3IOuK{border-image-slice:10 30% 10 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "C3IOuK",
            "val\\05q\\0& | \\0border-image-slice:10 30% 10 10",
          ),
        ],
      ),
      (
        "_a5qQxBGf3",
        ["._a5qQxBGf3{border-image-slice:30% 30% 10 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QxBGf3",
            "val\\05q\\0& | \\0border-image-slice:30% 30% 10 10",
          ),
        ],
      ),
      (
        "_a5q2FVOfa",
        ["._a5q2FVOfa{border-image-slice:10 10 30% 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2FVOfa",
            "val\\05q\\0& | \\0border-image-slice:10 10 30% 10",
          ),
        ],
      ),
      (
        "_a5qiWLXZy",
        ["._a5qiWLXZy{border-image-slice:30% 10 30% 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iWLXZy",
            "val\\05q\\0& | \\0border-image-slice:30% 10 30% 10",
          ),
        ],
      ),
      (
        "_a5qCbiH64",
        ["._a5qCbiH64{border-image-slice:10 30% 30% 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CbiH64",
            "val\\05q\\0& | \\0border-image-slice:10 30% 30% 10",
          ),
        ],
      ),
      (
        "_a5qG6-RB_",
        ["._a5qG6-RB_{border-image-slice:30% 30% 30% 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "G6-RB_",
            "val\\05q\\0& | \\0border-image-slice:30% 30% 30% 10",
          ),
        ],
      ),
      (
        "_a5ql0bqe4",
        ["._a5ql0bqe4{border-image-slice:10 10 10 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l0bqe4",
            "val\\05q\\0& | \\0border-image-slice:10 10 10 30%",
          ),
        ],
      ),
      (
        "_a5qej0MBN",
        ["._a5qej0MBN{border-image-slice:30% 10 10 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ej0MBN",
            "val\\05q\\0& | \\0border-image-slice:30% 10 10 30%",
          ),
        ],
      ),
      (
        "_a5qiTEL3H",
        ["._a5qiTEL3H{border-image-slice:10 30% 10 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iTEL3H",
            "val\\05q\\0& | \\0border-image-slice:10 30% 10 30%",
          ),
        ],
      ),
      (
        "_a5qy9LIHm",
        ["._a5qy9LIHm{border-image-slice:30% 30% 10 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "y9LIHm",
            "val\\05q\\0& | \\0border-image-slice:30% 30% 10 30%",
          ),
        ],
      ),
      (
        "_a5qoqu5o8",
        ["._a5qoqu5o8{border-image-slice:10 10 30% 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "oqu5o8",
            "val\\05q\\0& | \\0border-image-slice:10 10 30% 30%",
          ),
        ],
      ),
      (
        "_a5qrcrEN_",
        ["._a5qrcrEN_{border-image-slice:30% 10 30% 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "rcrEN_",
            "val\\05q\\0& | \\0border-image-slice:30% 10 30% 30%",
          ),
        ],
      ),
      (
        "_a5qF6pjFU",
        ["._a5qF6pjFU{border-image-slice:10 30% 30% 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "F6pjFU",
            "val\\05q\\0& | \\0border-image-slice:10 30% 30% 30%",
          ),
        ],
      ),
      (
        "_a5q3xdXup",
        ["._a5q3xdXup{border-image-slice:30% 30% 30% 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "3xdXup",
            "val\\05q\\0& | \\0border-image-slice:30% 30% 30% 30%",
          ),
        ],
      ),
      (
        "_a5qCzbo_-",
        ["._a5qCzbo_-{border-image-slice:fill 30%;}"],
        1,
        0,
        1,
        [("value", "Czbo_-", "val\\05q\\0& | \\0border-image-slice:fill 30%")],
      ),
      (
        "_a5q86pYzH",
        ["._a5q86pYzH{border-image-slice:fill 10;}"],
        1,
        0,
        1,
        [("value", "86pYzH", "val\\05q\\0& | \\0border-image-slice:fill 10")],
      ),
      (
        "_a5q0RKZLg",
        ["._a5q0RKZLg{border-image-slice:fill 2 4 8% 16%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0RKZLg",
            "val\\05q\\0& | \\0border-image-slice:fill 2 4 8% 16%",
          ),
        ],
      ),
      (
        "_a5qUV4apX",
        ["._a5qUV4apX{border-image-slice:30% fill;}"],
        1,
        0,
        1,
        [("value", "UV4apX", "val\\05q\\0& | \\0border-image-slice:30% fill")],
      ),
      (
        "_a5qzCtoUa",
        ["._a5qzCtoUa{border-image-slice:10 fill;}"],
        1,
        0,
        1,
        [("value", "zCtoUa", "val\\05q\\0& | \\0border-image-slice:10 fill")],
      ),
      (
        "_a5qppvRHF",
        ["._a5qppvRHF{border-image-slice:2 4 8% 16% fill;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ppvRHF",
            "val\\05q\\0& | \\0border-image-slice:2 4 8% 16% fill",
          ),
        ],
      ),
      (
        "_a5sXbE6aa",
        ["._a5sXbE6aa{border-image-width:10px;}"],
        1,
        0,
        1,
        [("value", "XbE6aa", "val\\05s\\0& | \\0border-image-width:10px")],
      ),
      (
        "_a5s7xdJ_g",
        ["._a5s7xdJ_g{border-image-width:5%;}"],
        1,
        0,
        1,
        [("value", "7xdJ_g", "val\\05s\\0& | \\0border-image-width:5%")],
      ),
      (
        "_a5seDf_vY",
        ["._a5seDf_vY{border-image-width:28;}"],
        1,
        0,
        1,
        [("value", "eDf_vY", "val\\05s\\0& | \\0border-image-width:28")],
      ),
      (
        "_a5sNAfHUT",
        ["._a5sNAfHUT{border-image-width:auto;}"],
        1,
        0,
        1,
        [("value", "NAfHUT", "val\\05s\\0& | \\0border-image-width:auto")],
      ),
      (
        "_a5s9Xb3UF",
        ["._a5s9Xb3UF{border-image-width:10px 10px;}"],
        1,
        0,
        1,
        [
          ("value", "9Xb3UF", "val\\05s\\0& | \\0border-image-width:10px 10px"),
        ],
      ),
      (
        "_a5sl_mC5M",
        ["._a5sl_mC5M{border-image-width:5% 10px;}"],
        1,
        0,
        1,
        [("value", "l_mC5M", "val\\05s\\0& | \\0border-image-width:5% 10px")],
      ),
      (
        "_a5sZe3llY",
        ["._a5sZe3llY{border-image-width:28 10px;}"],
        1,
        0,
        1,
        [("value", "Ze3llY", "val\\05s\\0& | \\0border-image-width:28 10px")],
      ),
      (
        "_a5s7tstpc",
        ["._a5s7tstpc{border-image-width:auto 10px;}"],
        1,
        0,
        1,
        [
          ("value", "7tstpc", "val\\05s\\0& | \\0border-image-width:auto 10px"),
        ],
      ),
      (
        "_a5sCakF15",
        ["._a5sCakF15{border-image-width:10px 5%;}"],
        1,
        0,
        1,
        [("value", "CakF15", "val\\05s\\0& | \\0border-image-width:10px 5%")],
      ),
      (
        "_a5s5OFPxU",
        ["._a5s5OFPxU{border-image-width:5% 5%;}"],
        1,
        0,
        1,
        [("value", "5OFPxU", "val\\05s\\0& | \\0border-image-width:5% 5%")],
      ),
      (
        "_a5s4i3DAC",
        ["._a5s4i3DAC{border-image-width:28 5%;}"],
        1,
        0,
        1,
        [("value", "4i3DAC", "val\\05s\\0& | \\0border-image-width:28 5%")],
      ),
      (
        "_a5sPuCrgv",
        ["._a5sPuCrgv{border-image-width:auto 5%;}"],
        1,
        0,
        1,
        [("value", "PuCrgv", "val\\05s\\0& | \\0border-image-width:auto 5%")],
      ),
      (
        "_a5s4l211K",
        ["._a5s4l211K{border-image-width:10px 28;}"],
        1,
        0,
        1,
        [("value", "4l211K", "val\\05s\\0& | \\0border-image-width:10px 28")],
      ),
      (
        "_a5sJJFGEE",
        ["._a5sJJFGEE{border-image-width:5% 28;}"],
        1,
        0,
        1,
        [("value", "JJFGEE", "val\\05s\\0& | \\0border-image-width:5% 28")],
      ),
      (
        "_a5syV3R8S",
        ["._a5syV3R8S{border-image-width:28 28;}"],
        1,
        0,
        1,
        [("value", "yV3R8S", "val\\05s\\0& | \\0border-image-width:28 28")],
      ),
      (
        "_a5s7znno6",
        ["._a5s7znno6{border-image-width:auto 28;}"],
        1,
        0,
        1,
        [("value", "7znno6", "val\\05s\\0& | \\0border-image-width:auto 28")],
      ),
      (
        "_a5s4lpFHl",
        ["._a5s4lpFHl{border-image-width:10px auto;}"],
        1,
        0,
        1,
        [
          ("value", "4lpFHl", "val\\05s\\0& | \\0border-image-width:10px auto"),
        ],
      ),
      (
        "_a5sSDBdSf",
        ["._a5sSDBdSf{border-image-width:5% auto;}"],
        1,
        0,
        1,
        [("value", "SDBdSf", "val\\05s\\0& | \\0border-image-width:5% auto")],
      ),
      (
        "_a5sUI5CWh",
        ["._a5sUI5CWh{border-image-width:28 auto;}"],
        1,
        0,
        1,
        [("value", "UI5CWh", "val\\05s\\0& | \\0border-image-width:28 auto")],
      ),
      (
        "_a5sN7ebze",
        ["._a5sN7ebze{border-image-width:auto auto;}"],
        1,
        0,
        1,
        [
          ("value", "N7ebze", "val\\05s\\0& | \\0border-image-width:auto auto"),
        ],
      ),
      (
        "_a5scz-4LD",
        ["._a5scz-4LD{border-image-width:10px 10% 10;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cz-4LD",
            "val\\05s\\0& | \\0border-image-width:10px 10% 10",
          ),
        ],
      ),
      (
        "_a5sCOZbs6",
        ["._a5sCOZbs6{border-image-width:5% 10px 20 auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "COZbs6",
            "val\\05s\\0& | \\0border-image-width:5% 10px 20 auto",
          ),
        ],
      ),
      (
        "_a5oqol8EF",
        ["._a5oqol8EF{border-image-outset:10px;}"],
        1,
        0,
        1,
        [("value", "qol8EF", "val\\05o\\0& | \\0border-image-outset:10px")],
      ),
      (
        "_a5o-rnkwh",
        ["._a5o-rnkwh{border-image-outset:20;}"],
        1,
        0,
        1,
        [("value", "-rnkwh", "val\\05o\\0& | \\0border-image-outset:20")],
      ),
      (
        "_a5omWZ9wx",
        ["._a5omWZ9wx{border-image-outset:10px 20;}"],
        1,
        0,
        1,
        [("value", "mWZ9wx", "val\\05o\\0& | \\0border-image-outset:10px 20")],
      ),
      (
        "_a5ojKLwas",
        ["._a5ojKLwas{border-image-outset:10px 20px;}"],
        1,
        0,
        1,
        [
          ("value", "jKLwas", "val\\05o\\0& | \\0border-image-outset:10px 20px"),
        ],
      ),
      (
        "_a5oSM-OX3",
        ["._a5oSM-OX3{border-image-outset:20 30;}"],
        1,
        0,
        1,
        [("value", "SM-OX3", "val\\05o\\0& | \\0border-image-outset:20 30")],
      ),
      (
        "_a5o9n0CfT",
        ["._a5o9n0CfT{border-image-outset:2px 3px 4;}"],
        1,
        0,
        1,
        [
          ("value", "9n0CfT", "val\\05o\\0& | \\0border-image-outset:2px 3px 4"),
        ],
      ),
      (
        "_a5opWahZQ",
        ["._a5opWahZQ{border-image-outset:1 2px 3px 4;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pWahZQ",
            "val\\05o\\0& | \\0border-image-outset:1 2px 3px 4",
          ),
        ],
      ),
      (
        "_a5pweWKZI",
        ["._a5pweWKZI{border-image-repeat:stretch;}"],
        1,
        0,
        1,
        [("value", "weWKZI", "val\\05p\\0& | \\0border-image-repeat:stretch")],
      ),
      (
        "_a5poKr8PO",
        ["._a5poKr8PO{border-image-repeat:repeat;}"],
        1,
        0,
        1,
        [("value", "oKr8PO", "val\\05p\\0& | \\0border-image-repeat:repeat")],
      ),
      (
        "_a5pKiKz4p",
        ["._a5pKiKz4p{border-image-repeat:round;}"],
        1,
        0,
        1,
        [("value", "KiKz4p", "val\\05p\\0& | \\0border-image-repeat:round")],
      ),
      (
        "_a5pNn7Wa2",
        ["._a5pNn7Wa2{border-image-repeat:space;}"],
        1,
        0,
        1,
        [("value", "Nn7Wa2", "val\\05p\\0& | \\0border-image-repeat:space")],
      ),
      (
        "_a5pVu_mqE",
        ["._a5pVu_mqE{border-image-repeat:stretch stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Vu_mqE",
            "val\\05p\\0& | \\0border-image-repeat:stretch stretch",
          ),
        ],
      ),
      (
        "_a5pOvLbqJ",
        ["._a5pOvLbqJ{border-image-repeat:repeat stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "OvLbqJ",
            "val\\05p\\0& | \\0border-image-repeat:repeat stretch",
          ),
        ],
      ),
      (
        "_a5pb9IMEB",
        ["._a5pb9IMEB{border-image-repeat:round stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "b9IMEB",
            "val\\05p\\0& | \\0border-image-repeat:round stretch",
          ),
        ],
      ),
      (
        "_a5pmgC6r3",
        ["._a5pmgC6r3{border-image-repeat:space stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "mgC6r3",
            "val\\05p\\0& | \\0border-image-repeat:space stretch",
          ),
        ],
      ),
      (
        "_a5pbnJzpu",
        ["._a5pbnJzpu{border-image-repeat:stretch repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bnJzpu",
            "val\\05p\\0& | \\0border-image-repeat:stretch repeat",
          ),
        ],
      ),
      (
        "_a5pslgd21",
        ["._a5pslgd21{border-image-repeat:repeat repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "slgd21",
            "val\\05p\\0& | \\0border-image-repeat:repeat repeat",
          ),
        ],
      ),
      (
        "_a5pbdgRLS",
        ["._a5pbdgRLS{border-image-repeat:round repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bdgRLS",
            "val\\05p\\0& | \\0border-image-repeat:round repeat",
          ),
        ],
      ),
      (
        "_a5pRkH4rl",
        ["._a5pRkH4rl{border-image-repeat:space repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RkH4rl",
            "val\\05p\\0& | \\0border-image-repeat:space repeat",
          ),
        ],
      ),
      (
        "_a5pcG64ML",
        ["._a5pcG64ML{border-image-repeat:stretch round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cG64ML",
            "val\\05p\\0& | \\0border-image-repeat:stretch round",
          ),
        ],
      ),
      (
        "_a5pGh6k-Y",
        ["._a5pGh6k-Y{border-image-repeat:repeat round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Gh6k-Y",
            "val\\05p\\0& | \\0border-image-repeat:repeat round",
          ),
        ],
      ),
      (
        "_a5pTZx1Nb",
        ["._a5pTZx1Nb{border-image-repeat:round round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "TZx1Nb",
            "val\\05p\\0& | \\0border-image-repeat:round round",
          ),
        ],
      ),
      (
        "_a5p7ZzjYG",
        ["._a5p7ZzjYG{border-image-repeat:space round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "7ZzjYG",
            "val\\05p\\0& | \\0border-image-repeat:space round",
          ),
        ],
      ),
      (
        "_a5p-DBkTa",
        ["._a5p-DBkTa{border-image-repeat:stretch space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "-DBkTa",
            "val\\05p\\0& | \\0border-image-repeat:stretch space",
          ),
        ],
      ),
      (
        "_a5pqvQPP7",
        ["._a5pqvQPP7{border-image-repeat:repeat space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "qvQPP7",
            "val\\05p\\0& | \\0border-image-repeat:repeat space",
          ),
        ],
      ),
      (
        "_a5pQv4GmJ",
        ["._a5pQv4GmJ{border-image-repeat:round space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Qv4GmJ",
            "val\\05p\\0& | \\0border-image-repeat:round space",
          ),
        ],
      ),
      (
        "_a5pMMvkCd",
        ["._a5pMMvkCd{border-image-repeat:space space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MMvkCd",
            "val\\05p\\0& | \\0border-image-repeat:space space",
          ),
        ],
      ),
      (
        "_a5nXpue2C",
        ["._a5nXpue2C{border-image:url(\"foo.png\") 10;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "Xpue2C",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10",
          ),
        ],
      ),
      (
        "_a5nuhJ_4w",
        ["._a5nuhJ_4w{border-image:url(\"foo.png\") 10%;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "uhJ_4w",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10%",
          ),
        ],
      ),
      (
        "_a5npB5tn6",
        ["._a5npB5tn6{border-image:url(\"foo.png\") 10% fill;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "pB5tn6",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10% fill",
          ),
        ],
      ),
      (
        "_a5nZtO765",
        ["._a5nZtO765{border-image:url(\"foo.png\") 10 round;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "ZtO765",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10 round",
          ),
        ],
      ),
      (
        "_a5nULRXCD",
        ["._a5nULRXCD{border-image:url(\"foo.png\") 10 stretch repeat;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "ULRXCD",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10 stretch repeat",
          ),
        ],
      ),
      (
        "_a5nsy7wtp",
        ["._a5nsy7wtp{border-image:url(\"foo.png\") 10 / 10px;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "sy7wtp",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10 / 10px",
          ),
        ],
      ),
      (
        "_a5nI3Y6XI",
        ["._a5nI3Y6XI{border-image:url(\"foo.png\") 10 / 10% / 10px;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "I3Y6XI",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") 10 / 10% / 10px",
          ),
        ],
      ),
      (
        "_a5nH5L8Uz",
        ["._a5nH5L8Uz{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "H5L8Uz",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") fill 10 / 10% / 10px",
          ),
        ],
      ),
      (
        "_a5n3DdiHT",
        [
          "._a5n3DdiHT{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "3DdiHT",
            "val\\05n\\0& | \\0border-image:url(\"foo.png\") fill 10 / 10% / 10px space",
          ),
        ],
      ),
      (
        "_a70rDIiHK",
        ["._a70rDIiHK{box-shadow:none;}"],
        1,
        0,
        1,
        [("value", "rDIiHK", "val\\070\\0& | \\0box-shadow:none")],
      ),
      (
        "_a70kUmtNo",
        ["._a70kUmtNo{box-shadow:1px 1px;}"],
        1,
        0,
        1,
        [("value", "kUmtNo", "val\\070\\0& | \\0box-shadow:1px 1px")],
      ),
      (
        "_a70j16w-T",
        ["._a70j16w-T{box-shadow:0 0 black;}"],
        1,
        0,
        1,
        [("value", "j16w-T", "val\\070\\0& | \\0box-shadow:0 0 black")],
      ),
      (
        "_a70k83GM5",
        ["._a70k83GM5{box-shadow:1px 2px 3px;}"],
        1,
        0,
        1,
        [("value", "k83GM5", "val\\070\\0& | \\0box-shadow:1px 2px 3px")],
      ),
      (
        "_a70r2eCps",
        ["._a70r2eCps{box-shadow:1px 2px 3px black;}"],
        1,
        0,
        1,
        [
          ("value", "r2eCps", "val\\070\\0& | \\0box-shadow:1px 2px 3px black"),
        ],
      ),
      (
        "_a70Gfs7RI",
        ["._a70Gfs7RI{box-shadow:1px 2px 3px 4px;}"],
        1,
        0,
        1,
        [("value", "Gfs7RI", "val\\070\\0& | \\0box-shadow:1px 2px 3px 4px")],
      ),
      (
        "_a70kAhYcP",
        ["._a70kAhYcP{box-shadow:1px 2px 3px 4px black;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "kAhYcP",
            "val\\070\\0& | \\0box-shadow:1px 2px 3px 4px black",
          ),
        ],
      ),
      (
        "_a70a7DK-5",
        ["._a70a7DK-5{box-shadow:inset 1px 1px;}"],
        1,
        0,
        1,
        [("value", "a7DK-5", "val\\070\\0& | \\0box-shadow:inset 1px 1px")],
      ),
      (
        "_a70nEZeHE",
        ["._a70nEZeHE{box-shadow:inset 0 0 black;}"],
        1,
        0,
        1,
        [("value", "nEZeHE", "val\\070\\0& | \\0box-shadow:inset 0 0 black")],
      ),
      (
        "_a70qRInuj",
        ["._a70qRInuj{box-shadow:inset 1px 2px 3px;}"],
        1,
        0,
        1,
        [
          ("value", "qRInuj", "val\\070\\0& | \\0box-shadow:inset 1px 2px 3px"),
        ],
      ),
      (
        "_a706fD4CG",
        ["._a706fD4CG{box-shadow:inset 1px 2px 3px black;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6fD4CG",
            "val\\070\\0& | \\0box-shadow:inset 1px 2px 3px black",
          ),
        ],
      ),
      (
        "_a70aRsv_J",
        ["._a70aRsv_J{box-shadow:inset 1px 2px 3px 4px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "aRsv_J",
            "val\\070\\0& | \\0box-shadow:inset 1px 2px 3px 4px",
          ),
        ],
      ),
      (
        "_a70l97Vo2",
        ["._a70l97Vo2{box-shadow:inset 1px 2px 3px 4px black;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l97Vo2",
            "val\\070\\0& | \\0box-shadow:inset 1px 2px 3px 4px black",
          ),
        ],
      ),
      (
        "_a708lbK30",
        [
          "._a708lbK30{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "8lbK30",
            "val\\070\\0& | \\0box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black",
          ),
        ],
      ),
      (
        "_a70AoHgCR",
        ["._a70AoHgCR{box-shadow:1px 1px, inset 2px 2px red;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "AoHgCR",
            "val\\070\\0& | \\0box-shadow:1px 1px, inset 2px 2px red",
          ),
        ],
      ),
      (
        "_a70s25ruW",
        ["._a70s25ruW{box-shadow:0 0 5px, inset 0 0 10px black;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "s25ruW",
            "val\\070\\0& | \\0box-shadow:0 0 5px, inset 0 0 10px black",
          ),
        ],
      ),
      (
        "_a70M_XZqN",
        [
          "._a70M_XZqN{box-shadow:-1px 1px 0px 0px var(--elevation1-1rnnems_1), 1px 1px 0px 0px var(--elevation1-1rnnems_2), 0px -1px 0px 0px var(--elevation1-1rnnems_3);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "M_XZqN",
            "val\\070\\0& | \\0box-shadow:-1px 1px 0px 0px $(Color.Shadow.elevation1), 1px 1px 0px 0px $(Color.Shadow.elevation1), 0px -1px 0px 0px $(Color.Shadow.elevation1)",
          ),
        ],
      ),
      (
        "_a4p3yeYeI",
        ["._a4p3yeYeI{background-position-x:right;}"],
        1,
        0,
        1,
        [("value", "3yeYeI", "val\\04p\\0& | \\0background-position-x:right")],
      ),
      (
        "_a4pC2iv8w",
        ["._a4pC2iv8w{background-position-x:center;}"],
        1,
        0,
        1,
        [
          ("value", "C2iv8w", "val\\04p\\0& | \\0background-position-x:center"),
        ],
      ),
      (
        "_a4pSYWI4D",
        ["._a4pSYWI4D{background-position-x:50%;}"],
        1,
        0,
        1,
        [("value", "SYWI4D", "val\\04p\\0& | \\0background-position-x:50%")],
      ),
      (
        "_a4pBlQEbB",
        ["._a4pBlQEbB{background-position-x:left, left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "BlQEbB",
            "val\\04p\\0& | \\0background-position-x:left, left",
          ),
        ],
      ),
      (
        "_a4pNS_MDP",
        ["._a4pNS_MDP{background-position-x:left, right;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "NS_MDP",
            "val\\04p\\0& | \\0background-position-x:left, right",
          ),
        ],
      ),
      (
        "_a4pPJsEkP",
        ["._a4pPJsEkP{background-position-x:right, left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "PJsEkP",
            "val\\04p\\0& | \\0background-position-x:right, left",
          ),
        ],
      ),
      (
        "_a4paFmD-L",
        ["._a4paFmD-L{background-position-x:left, 0%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "aFmD-L",
            "val\\04p\\0& | \\0background-position-x:left, 0%",
          ),
        ],
      ),
      (
        "_a4pLpaRIc",
        ["._a4pLpaRIc{background-position-x:10%, 20%, 40%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "LpaRIc",
            "val\\04p\\0& | \\0background-position-x:10%, 20%, 40%",
          ),
        ],
      ),
      (
        "_a4pE6RdaX",
        ["._a4pE6RdaX{background-position-x:0px;}"],
        1,
        0,
        1,
        [("value", "E6RdaX", "val\\04p\\0& | \\0background-position-x:0px")],
      ),
      (
        "_a4pdRYrP-",
        ["._a4pdRYrP-{background-position-x:30px;}"],
        1,
        0,
        1,
        [("value", "dRYrP-", "val\\04p\\0& | \\0background-position-x:30px")],
      ),
      (
        "_a4poHUjX0",
        ["._a4poHUjX0{background-position-x:0%, 10%, 20%, 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "oHUjX0",
            "val\\04p\\0& | \\0background-position-x:0%, 10%, 20%, 30%",
          ),
        ],
      ),
      (
        "_a4p1ejCyW",
        ["._a4p1ejCyW{background-position-x:left, left, left, left, left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1ejCyW",
            "val\\04p\\0& | \\0background-position-x:left, left, left, left, left",
          ),
        ],
      ),
      (
        "_a4pH2H39u",
        ["._a4pH2H39u{background-position-x:calc(20px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "H2H39u",
            "val\\04p\\0& | \\0background-position-x:calc(20px)",
          ),
        ],
      ),
      (
        "_a4pKguRFW",
        ["._a4pKguRFW{background-position-x:calc(20px + 1em);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "KguRFW",
            "val\\04p\\0& | \\0background-position-x:calc(20px + 1em)",
          ),
        ],
      ),
      (
        "_a4pXybPKZ",
        ["._a4pXybPKZ{background-position-x:calc(20px / 2);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XybPKZ",
            "val\\04p\\0& | \\0background-position-x:calc(20px / 2)",
          ),
        ],
      ),
      (
        "_a4pL5l1MO",
        ["._a4pL5l1MO{background-position-x:calc(20px + 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "L5l1MO",
            "val\\04p\\0& | \\0background-position-x:calc(20px + 50%)",
          ),
        ],
      ),
      (
        "_a4p8Bqk-7",
        ["._a4p8Bqk-7{background-position-x:calc(50% - 10px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8Bqk-7",
            "val\\04p\\0& | \\0background-position-x:calc(50% - 10px)",
          ),
        ],
      ),
      (
        "_a4pwQtgsg",
        ["._a4pwQtgsg{background-position-x:calc(-20px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "wQtgsg",
            "val\\04p\\0& | \\0background-position-x:calc(-20px)",
          ),
        ],
      ),
      (
        "_a4pr9s41Z",
        ["._a4pr9s41Z{background-position-x:calc(-50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "r9s41Z",
            "val\\04p\\0& | \\0background-position-x:calc(-50%)",
          ),
        ],
      ),
      (
        "_a4pMdd2qI",
        ["._a4pMdd2qI{background-position-x:calc(-20%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Mdd2qI",
            "val\\04p\\0& | \\0background-position-x:calc(-20%)",
          ),
        ],
      ),
      (
        "_a4piJrdoy",
        ["._a4piJrdoy{background-position-x:right 20px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iJrdoy",
            "val\\04p\\0& | \\0background-position-x:right 20px",
          ),
        ],
      ),
      (
        "_a4pKlxX99",
        ["._a4pKlxX99{background-position-x:left 20px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "KlxX99",
            "val\\04p\\0& | \\0background-position-x:left 20px",
          ),
        ],
      ),
      (
        "_a4pOEkj0X",
        ["._a4pOEkj0X{background-position-x:right -50px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "OEkj0X",
            "val\\04p\\0& | \\0background-position-x:right -50px",
          ),
        ],
      ),
      (
        "_a4pu9ETa8",
        ["._a4pu9ETa8{background-position-x:left -50px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "u9ETa8",
            "val\\04p\\0& | \\0background-position-x:left -50px",
          ),
        ],
      ),
      (
        "_a4qFBraPY",
        ["._a4qFBraPY{background-position-y:bottom;}"],
        1,
        0,
        1,
        [
          ("value", "FBraPY", "val\\04q\\0& | \\0background-position-y:bottom"),
        ],
      ),
      (
        "_a4qABtS_A",
        ["._a4qABtS_A{background-position-y:center;}"],
        1,
        0,
        1,
        [
          ("value", "ABtS_A", "val\\04q\\0& | \\0background-position-y:center"),
        ],
      ),
      (
        "_a4qTzYAhy",
        ["._a4qTzYAhy{background-position-y:50%;}"],
        1,
        0,
        1,
        [("value", "TzYAhy", "val\\04q\\0& | \\0background-position-y:50%")],
      ),
      (
        "_a4qVj8ARr",
        ["._a4qVj8ARr{background-position-y:top, top;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Vj8ARr",
            "val\\04q\\0& | \\0background-position-y:top, top",
          ),
        ],
      ),
      (
        "_a4qDzB8Ul",
        ["._a4qDzB8Ul{background-position-y:top, bottom;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DzB8Ul",
            "val\\04q\\0& | \\0background-position-y:top, bottom",
          ),
        ],
      ),
      (
        "_a4qc4Etlp",
        ["._a4qc4Etlp{background-position-y:bottom, top;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "c4Etlp",
            "val\\04q\\0& | \\0background-position-y:bottom, top",
          ),
        ],
      ),
      (
        "_a4qNkB_Lv",
        ["._a4qNkB_Lv{background-position-y:top, 0%;}"],
        1,
        0,
        1,
        [
          ("value", "NkB_Lv", "val\\04q\\0& | \\0background-position-y:top, 0%"),
        ],
      ),
      (
        "_a4qwh-mEB",
        ["._a4qwh-mEB{background-position-y:10%, 20%, 40%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "wh-mEB",
            "val\\04q\\0& | \\0background-position-y:10%, 20%, 40%",
          ),
        ],
      ),
      (
        "_a4qajoP_Y",
        ["._a4qajoP_Y{background-position-y:0px;}"],
        1,
        0,
        1,
        [("value", "ajoP_Y", "val\\04q\\0& | \\0background-position-y:0px")],
      ),
      (
        "_a4qbW8KwE",
        ["._a4qbW8KwE{background-position-y:30px;}"],
        1,
        0,
        1,
        [("value", "bW8KwE", "val\\04q\\0& | \\0background-position-y:30px")],
      ),
      (
        "_a4qYGClhB",
        ["._a4qYGClhB{background-position-y:0%, 10%, 20%, 30%;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YGClhB",
            "val\\04q\\0& | \\0background-position-y:0%, 10%, 20%, 30%",
          ),
        ],
      ),
      (
        "_a4qnfAID_",
        ["._a4qnfAID_{background-position-y:top, top, top, top, top;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nfAID_",
            "val\\04q\\0& | \\0background-position-y:top, top, top, top, top",
          ),
        ],
      ),
      (
        "_a4qmiQKrt",
        ["._a4qmiQKrt{background-position-y:calc(20px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "miQKrt",
            "val\\04q\\0& | \\0background-position-y:calc(20px)",
          ),
        ],
      ),
      (
        "_a4qtshWj4",
        ["._a4qtshWj4{background-position-y:calc(20px + 1em);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "tshWj4",
            "val\\04q\\0& | \\0background-position-y:calc(20px + 1em)",
          ),
        ],
      ),
      (
        "_a4qpvRc1-",
        ["._a4qpvRc1-{background-position-y:calc(20px / 2);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pvRc1-",
            "val\\04q\\0& | \\0background-position-y:calc(20px / 2)",
          ),
        ],
      ),
      (
        "_a4qBo-Ur8",
        ["._a4qBo-Ur8{background-position-y:calc(20px + 50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Bo-Ur8",
            "val\\04q\\0& | \\0background-position-y:calc(20px + 50%)",
          ),
        ],
      ),
      (
        "_a4qdfrg1p",
        ["._a4qdfrg1p{background-position-y:calc(50% - 10px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "dfrg1p",
            "val\\04q\\0& | \\0background-position-y:calc(50% - 10px)",
          ),
        ],
      ),
      (
        "_a4qojwPLx",
        ["._a4qojwPLx{background-position-y:calc(-20px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ojwPLx",
            "val\\04q\\0& | \\0background-position-y:calc(-20px)",
          ),
        ],
      ),
      (
        "_a4qEA9n9p",
        ["._a4qEA9n9p{background-position-y:calc(-50%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EA9n9p",
            "val\\04q\\0& | \\0background-position-y:calc(-50%)",
          ),
        ],
      ),
      (
        "_a4qBEaiDj",
        ["._a4qBEaiDj{background-position-y:calc(-20%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "BEaiDj",
            "val\\04q\\0& | \\0background-position-y:calc(-20%)",
          ),
        ],
      ),
      (
        "_a4qF6sRol",
        ["._a4qF6sRol{background-position-y:bottom 20px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "F6sRol",
            "val\\04q\\0& | \\0background-position-y:bottom 20px",
          ),
        ],
      ),
      (
        "_a4qvx3qLc",
        ["._a4qvx3qLc{background-position-y:top 20px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "vx3qLc",
            "val\\04q\\0& | \\0background-position-y:top 20px",
          ),
        ],
      ),
      (
        "_a4qwlIl6K",
        ["._a4qwlIl6K{background-position-y:bottom -50px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "wlIl6K",
            "val\\04q\\0& | \\0background-position-y:bottom -50px",
          ),
        ],
      ),
      (
        "_a4qDcGfnO",
        ["._a4qDcGfnO{background-position-y:top -50px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DcGfnO",
            "val\\04q\\0& | \\0background-position-y:top -50px",
          ),
        ],
      ),
      (
        "_a4mCgBwcp",
        ["._a4mCgBwcp{background-image:linear-gradient(45deg, blue, red);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CgBwcp",
            "val\\04m\\0& | \\0background-image:linear-gradient(45deg, blue, red)",
          ),
        ],
      ),
      (
        "_a4mYgd48d",
        [
          "._a4mYgd48d{background-image:linear-gradient(90deg, blue 10%, red 20%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Ygd48d",
            "val\\04m\\0& | \\0background-image:linear-gradient(90deg, blue 10%, red 20%)",
          ),
        ],
      ),
      (
        "_a4m6fm4mB",
        [
          "._a4m6fm4mB{background-image:linear-gradient(90deg, blue 10%, red);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "6fm4mB",
            "val\\04m\\0& | \\0background-image:linear-gradient(90deg, blue 10%, red)",
          ),
        ],
      ),
      (
        "_a4mZcHXIH",
        [
          "._a4mZcHXIH{background-image:linear-gradient(90deg, blue, 10%, red);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZcHXIH",
            "val\\04m\\0& | \\0background-image:linear-gradient(90deg, blue, 10%, red)",
          ),
        ],
      ),
      (
        "_a4mg0AwAm",
        ["._a4mg0AwAm{background-image:linear-gradient(white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "g0AwAm",
            "val\\04m\\0& | \\0background-image:linear-gradient(white, black)",
          ),
        ],
      ),
      (
        "_a4mFsRJQb",
        [
          "._a4mFsRJQb{background-image:linear-gradient(to right, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "FsRJQb",
            "val\\04m\\0& | \\0background-image:linear-gradient(to right, white, black)",
          ),
        ],
      ),
      (
        "_a4mFlvrGM",
        ["._a4mFlvrGM{background-image:linear-gradient(45deg, white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FlvrGM",
            "val\\04m\\0& | \\0background-image:linear-gradient(45deg, white, black)",
          ),
        ],
      ),
      (
        "_a4mR1I1nJ",
        ["._a4mR1I1nJ{background-image:linear-gradient(white 50%, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "R1I1nJ",
            "val\\04m\\0& | \\0background-image:linear-gradient(white 50%, black)",
          ),
        ],
      ),
      (
        "_a4mn1pEmt",
        ["._a4mn1pEmt{background-image:linear-gradient(white, #f06, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "n1pEmt",
            "val\\04m\\0& | \\0background-image:linear-gradient(white, #f06, black)",
          ),
        ],
      ),
      (
        "_a4m9bMQOd",
        [
          "._a4m9bMQOd{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "9bMQOd",
            "val\\04m\\0& | \\0background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%)",
          ),
        ],
      ),
      (
        "_a4mjrb5Fq",
        [
          "._a4mjrb5Fq{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "jrb5Fq",
            "val\\04m\\0& | \\0background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red)",
          ),
        ],
      ),
      (
        "_a4mJYve7R",
        [
          "._a4mJYve7R{background-image:linear-gradient(45deg, var(--color-35oif8_1) 25%, transparent 0%, transparent 50%, var(--color-35oif8_2) 0%, var(--color-35oif8_3) 75%, transparent 0%, transparent 100% );}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "JYve7R",
            "val\\04m\\0& | \\0background-image:linear-gradient(45deg, $(color) 25%, transparent 0%, transparent 50%, $(color) 0%, $(color) 75%, transparent 0%, transparent 100% )",
          ),
        ],
      ),
      (
        "_a4miBHoaY",
        [
          "._a4miBHoaY{background-image:repeating-linear-gradient( 45deg, var(--color-1dnob2v_1) 0px, var(--color-1dnob2v_2) 4px, var(--color-1dnob2v_3) 5px, var(--color-1dnob2v_4) 9px );}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "iBHoaY",
            "val\\04m\\0& | \\0background-image:repeating-linear-gradient( 45deg, $(color) 0px, $(color) 4px, $(color) 5px, $(color) 9px )",
          ),
        ],
      ),
      (
        "_a4mfgDMxK",
        [
          "._a4mfgDMxK{background-image:linear-gradient(45deg, var(--boxDark-iyil7j) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "fgDMxK",
            "val\\04m\\0& | \\0background-image:linear-gradient(45deg, $(Color.Background.boxDark) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red)",
          ),
        ],
      ),
      (
        "_a4mgnmVmY",
        ["._a4mgnmVmY{background-image:radial-gradient(white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "gnmVmY",
            "val\\04m\\0& | \\0background-image:radial-gradient(white, black)",
          ),
        ],
      ),
      (
        "_a4mQvq9vZ",
        [
          "._a4mQvq9vZ{background-image:radial-gradient(circle, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Qvq9vZ",
            "val\\04m\\0& | \\0background-image:radial-gradient(circle, white, black)",
          ),
        ],
      ),
      (
        "_a4mB8_KJz",
        [
          "._a4mB8_KJz{background-image:radial-gradient(ellipse, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "B8_KJz",
            "val\\04m\\0& | \\0background-image:radial-gradient(ellipse, white, black)",
          ),
        ],
      ),
      (
        "_a4mEd-JpN",
        [
          "._a4mEd-JpN{background-image:radial-gradient(circle closest-corner, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Ed-JpN",
            "val\\04m\\0& | \\0background-image:radial-gradient(circle closest-corner, white, black)",
          ),
        ],
      ),
      (
        "_a4muBx_po",
        [
          "._a4muBx_po{background-image:radial-gradient(farthest-side, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uBx_po",
            "val\\04m\\0& | \\0background-image:radial-gradient(farthest-side, white, black)",
          ),
        ],
      ),
      (
        "_a4mEN_wS8",
        [
          "._a4mEN_wS8{background-image:radial-gradient(circle farthest-side, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "EN_wS8",
            "val\\04m\\0& | \\0background-image:radial-gradient(circle farthest-side, white, black)",
          ),
        ],
      ),
      (
        "_a4mGLm5MR",
        ["._a4mGLm5MR{background-image:radial-gradient(50%, white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "GLm5MR",
            "val\\04m\\0& | \\0background-image:radial-gradient(50%, white, black)",
          ),
        ],
      ),
      (
        "_a4mcwJTyD",
        [
          "._a4mcwJTyD{background-image:radial-gradient(60% 60%, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "cwJTyD",
            "val\\04m\\0& | \\0background-image:radial-gradient(60% 60%, white, black)",
          ),
        ],
      ),
      (
        "_acqeWTArg",
        ["._acqeWTArg{list-style-image:linear-gradient(white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "eWTArg",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(white, black)",
          ),
        ],
      ),
      (
        "_acqgr8A7h",
        [
          "._acqgr8A7h{list-style-image:linear-gradient(to right, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "gr8A7h",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(to right, white, black)",
          ),
        ],
      ),
      (
        "_acq8ftO_F",
        ["._acq8ftO_F{list-style-image:linear-gradient(45deg, white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8ftO_F",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(45deg, white, black)",
          ),
        ],
      ),
      (
        "_acqkLLqy_",
        ["._acqkLLqy_{list-style-image:linear-gradient(white 50%, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "kLLqy_",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(white 50%, black)",
          ),
        ],
      ),
      (
        "_acqGyGVcZ",
        ["._acqGyGVcZ{list-style-image:linear-gradient(white 5px, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "GyGVcZ",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(white 5px, black)",
          ),
        ],
      ),
      (
        "_acqiz4T8H",
        ["._acqiz4T8H{list-style-image:linear-gradient(white, #f06, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iz4T8H",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(white, #f06, black)",
          ),
        ],
      ),
      (
        "_acqmXZ6m4",
        ["._acqmXZ6m4{list-style-image:linear-gradient(currentColor, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "mXZ6m4",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(currentColor, black)",
          ),
        ],
      ),
      (
        "_acqf3BL-f",
        [
          "._acqf3BL-f{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "f3BL-f",
            "val\\0cq\\0& | \\0list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%)",
          ),
        ],
      ),
      (
        "_acqiioe_M",
        ["._acqiioe_M{list-style-image:radial-gradient(white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iioe_M",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(white, black)",
          ),
        ],
      ),
      (
        "_acqRDNiWI",
        [
          "._acqRDNiWI{list-style-image:radial-gradient(circle, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "RDNiWI",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(circle, white, black)",
          ),
        ],
      ),
      (
        "_acqEn8euc",
        [
          "._acqEn8euc{list-style-image:radial-gradient(ellipse, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "En8euc",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(ellipse, white, black)",
          ),
        ],
      ),
      (
        "_acq0rrHas",
        [
          "._acq0rrHas{list-style-image:radial-gradient(closest-corner, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "0rrHas",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(closest-corner, white, black)",
          ),
        ],
      ),
      (
        "_acqNdOW65",
        [
          "._acqNdOW65{list-style-image:radial-gradient(circle closest-corner, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "NdOW65",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(circle closest-corner, white, black)",
          ),
        ],
      ),
      (
        "_acqhCz-rb",
        [
          "._acqhCz-rb{list-style-image:radial-gradient(farthest-side, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "hCz-rb",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(farthest-side, white, black)",
          ),
        ],
      ),
      (
        "_acqqhZ_sp",
        [
          "._acqqhZ_sp{list-style-image:radial-gradient(circle farthest-side, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "qhZ_sp",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(circle farthest-side, white, black)",
          ),
        ],
      ),
      (
        "_acqCVoUKz",
        ["._acqCVoUKz{list-style-image:radial-gradient(50%, white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CVoUKz",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(50%, white, black)",
          ),
        ],
      ),
      (
        "_acquQrxPk",
        [
          "._acquQrxPk{list-style-image:radial-gradient(60% 60%, white, black);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uQrxPk",
            "val\\0cq\\0& | \\0list-style-image:radial-gradient(60% 60%, white, black)",
          ),
        ],
      ),
      (
        "_ablemaR7h",
        ["._ablemaR7h{image-rendering:auto;}"],
        1,
        0,
        1,
        [("value", "emaR7h", "val\\0bl\\0& | \\0image-rendering:auto")],
      ),
      (
        "_abl7oZ6qm",
        ["._abl7oZ6qm{image-rendering:smooth;}"],
        1,
        0,
        1,
        [("value", "7oZ6qm", "val\\0bl\\0& | \\0image-rendering:smooth")],
      ),
      (
        "_ablSNUYd7",
        ["._ablSNUYd7{image-rendering:high-quality;}"],
        1,
        0,
        1,
        [
          ("value", "SNUYd7", "val\\0bl\\0& | \\0image-rendering:high-quality"),
        ],
      ),
      (
        "_ablC-eDY6",
        ["._ablC-eDY6{image-rendering:pixelated;}"],
        1,
        0,
        1,
        [("value", "C-eDY6", "val\\0bl\\0& | \\0image-rendering:pixelated")],
      ),
      (
        "_ably8MMkG",
        ["._ably8MMkG{image-rendering:crisp-edges;}"],
        1,
        0,
        1,
        [("value", "y8MMkG", "val\\0bl\\0& | \\0image-rendering:crisp-edges")],
      ),
      (
        "_a4oo35s_D",
        ["._a4oo35s_D{background-position:bottom;}"],
        1,
        0,
        2,
        [("value", "o35s_D", "val\\04o\\0& | \\0background-position:bottom")],
      ),
      (
        "_a4qlbfuJa",
        ["._a4qlbfuJa{background-position-y:0;}"],
        1,
        0,
        1,
        [("value", "lbfuJa", "val\\04q\\0& | \\0background-position-y:0")],
      ),
      (
        "_a4od2487y",
        ["._a4od2487y{background-position:0 0;}"],
        1,
        0,
        2,
        [("value", "d2487y", "val\\04o\\0& | \\0background-position:0 0")],
      ),
      (
        "_a4oS7b2w6",
        ["._a4oS7b2w6{background-position:1rem 0;}"],
        1,
        0,
        2,
        [("value", "S7b2w6", "val\\04o\\0& | \\0background-position:1rem 0")],
      ),
      (
        "_a4oP6L_iH",
        ["._a4oP6L_iH{background-position:bottom 10px right;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "P6L_iH",
            "val\\04o\\0& | \\0background-position:bottom 10px right",
          ),
        ],
      ),
      (
        "_a4oORObMa",
        ["._a4oORObMa{background-position:bottom 10px right 20px;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "ORObMa",
            "val\\04o\\0& | \\0background-position:bottom 10px right 20px",
          ),
        ],
      ),
      (
        "_a4oNnRjsu",
        ["._a4oNnRjsu{background-position:0 0, center;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "NnRjsu",
            "val\\04o\\0& | \\0background-position:0 0, center",
          ),
        ],
      ),
      (
        "_af1Uuqqu5",
        ["._af1Uuqqu5{object-position:top;}"],
        1,
        0,
        1,
        [("value", "Uuqqu5", "val\\0f1\\0& | \\0object-position:top")],
      ),
      (
        "_af1mACV93",
        ["._af1mACV93{object-position:bottom;}"],
        1,
        0,
        1,
        [("value", "mACV93", "val\\0f1\\0& | \\0object-position:bottom")],
      ),
      (
        "_af1bIQtFP",
        ["._af1bIQtFP{object-position:left;}"],
        1,
        0,
        1,
        [("value", "bIQtFP", "val\\0f1\\0& | \\0object-position:left")],
      ),
      (
        "_af11FHeIR",
        ["._af11FHeIR{object-position:right;}"],
        1,
        0,
        1,
        [("value", "1FHeIR", "val\\0f1\\0& | \\0object-position:right")],
      ),
      (
        "_af1h4hN27",
        ["._af1h4hN27{object-position:center;}"],
        1,
        0,
        1,
        [("value", "h4hN27", "val\\0f1\\0& | \\0object-position:center")],
      ),
      (
        "_af1L2ZrPR",
        ["._af1L2ZrPR{object-position:25% 75%;}"],
        1,
        0,
        1,
        [("value", "L2ZrPR", "val\\0f1\\0& | \\0object-position:25% 75%")],
      ),
      (
        "_af1OaTKWc",
        ["._af1OaTKWc{object-position:25%;}"],
        1,
        0,
        1,
        [("value", "OaTKWc", "val\\0f1\\0& | \\0object-position:25%")],
      ),
      (
        "_af1J1zQnG",
        ["._af1J1zQnG{object-position:0 0;}"],
        1,
        0,
        1,
        [("value", "J1zQnG", "val\\0f1\\0& | \\0object-position:0 0")],
      ),
      (
        "_af1R04FUa",
        ["._af1R04FUa{object-position:1cm 2cm;}"],
        1,
        0,
        1,
        [("value", "R04FUa", "val\\0f1\\0& | \\0object-position:1cm 2cm")],
      ),
      (
        "_af16Dxxbf",
        ["._af16Dxxbf{object-position:10ch 8em;}"],
        1,
        0,
        1,
        [("value", "6Dxxbf", "val\\0f1\\0& | \\0object-position:10ch 8em")],
      ),
      (
        "_af1ViTN8v",
        ["._af1ViTN8v{object-position:bottom 10px right 20px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ViTN8v",
            "val\\0f1\\0& | \\0object-position:bottom 10px right 20px",
          ),
        ],
      ),
      (
        "_af1YXaASz",
        ["._af1YXaASz{object-position:right 3em bottom 10px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YXaASz",
            "val\\0f1\\0& | \\0object-position:right 3em bottom 10px",
          ),
        ],
      ),
      (
        "_af1aSbOGe",
        ["._af1aSbOGe{object-position:top 0 right 10px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "aSbOGe",
            "val\\0f1\\0& | \\0object-position:top 0 right 10px",
          ),
        ],
      ),
      (
        "_af1VoHDLi",
        ["._af1VoHDLi{object-position:inherit;}"],
        1,
        0,
        1,
        [("value", "VoHDLi", "val\\0f1\\0& | \\0object-position:inherit")],
      ),
      (
        "_af1hYdret",
        ["._af1hYdret{object-position:initial;}"],
        1,
        0,
        1,
        [("value", "hYdret", "val\\0f1\\0& | \\0object-position:initial")],
      ),
      (
        "_af1mQdbcB",
        ["._af1mQdbcB{object-position:revert;}"],
        1,
        0,
        1,
        [("value", "mQdbcB", "val\\0f1\\0& | \\0object-position:revert")],
      ),
      (
        "_af1R5XI3Z",
        ["._af1R5XI3Z{object-position:revert-layer;}"],
        1,
        0,
        1,
        [
          ("value", "R5XI3Z", "val\\0f1\\0& | \\0object-position:revert-layer"),
        ],
      ),
      (
        "_af1jpLNEP",
        ["._af1jpLNEP{object-position:unset;}"],
        1,
        0,
        1,
        [("value", "jpLNEP", "val\\0f1\\0& | \\0object-position:unset")],
      ),
    ]
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("_a4r9TQgHG", []);
  CSS.make("_a4rM-BGyr", []);
  CSS.make("_a4r3kikJy", []);
  CSS.make("_a4rsRD5TI", []);
  CSS.make("_a4raEKn2Z", []);
  CSS.make("_a4rnpeO0_", []);
  CSS.make("_a4rEWCJ7c", []);
  CSS.make("_a4rruU4lq", []);
  CSS.make("_a4rH6HyZI", []);
  CSS.make("_a4rtfyAHS", []);
  CSS.make("_a4r5DnUgY", []);
  CSS.make("_a4rce1Ewr", []);
  CSS.make("_a4rHu8ddp", []);
  CSS.make("_a4rQEPEa8", []);
  CSS.make("_a4r5Z2dz5", []);
  CSS.make("_a4rUb1lIb", []);
  CSS.make("_a4ryjz0XB", []);
  CSS.make("_a4rEAbgE7", []);
  CSS.make("_a4rBe2z1g", []);
  CSS.make("_a4iKFSzKl", []);
  CSS.make("_a4k_xMCic", []);
  CSS.make("_a4kp10t94", []);
  CSS.make("_a4kaSOGAV", []);
  CSS.make("_a4kmU-v31", []);
  CSS.make("_a4kfdNguz", []);
  CSS.make("_a4kaiqIbH", []);
  CSS.make("_a4nNhFd6l", []);
  CSS.make("_a4n8KBVbw", []);
  CSS.make("_a4nXljOaq", []);
  CSS.make("_a4sWHT964", []);
  CSS.make("_a4sSc3gpg", []);
  CSS.make("_a4sR2sUjG", []);
  CSS.make("_a4sig__4d", []);
  CSS.make("_a4sxCZjmr", []);
  CSS.make("_a4sUaogsb", []);
  CSS.make("_a4sgLy343", []);
  CSS.make("_a4s-k5N6G", []);
  CSS.make("_a4siuVi2F", []);
  
  CSS.make("_a4habN55z", []);
  CSS.make("_a4hEWfKba", []);
  CSS.make("_a4hLxyY_r", []);
  CSS.make("_a4hrJE_4c", []);
  
  CSS.make("_a4hLKjuY_", []);
  CSS.make("_a4hpnyoza", []);
  CSS.make("_a6lb3Tsjq", []);
  CSS.make("_a6lXHavJQ", []);
  CSS.make("_a6ljNdziH", []);
  CSS.make("_a6mrv4Ay2", []);
  CSS.make("_a6mGNdTlC", []);
  CSS.make("_a6mQgL8to", []);
  CSS.make("_a5goZESV-", []);
  CSS.make("_a5gbSUrYa", []);
  CSS.make("_a5gIVpO7D", []);
  CSS.make("_a5fNypWk2", []);
  CSS.make("_a5fgghv2X", []);
  CSS.make("_a5fyPHLOD", []);
  CSS.make("_a69UtuHuu", []);
  CSS.make("_a69_agmvD", []);
  CSS.make("_a69L-cF4Z", []);
  CSS.make("_a69gZNIKm", []);
  CSS.make("_a69CJ13ZD", []);
  CSS.make("_a69aqQmVk", []);
  CSS.make("_a69vEtbY8", []);
  CSS.make("_a5rkRETOD", []);
  CSS.make("_a5r3Zfda7", []);
  CSS.make("_a5qEJpRwm", []);
  CSS.make("_a5qpjZrD-", []);
  CSS.make("_a5qTWuzuG", []);
  CSS.make("_a5qDGqFND", []);
  CSS.make("_a5qqi4RgL", []);
  CSS.make("_a5qRQi9iW", []);
  CSS.make("_a5qUNFxHg", []);
  CSS.make("_a5qkaLNkv", []);
  CSS.make("_a5q5uWSAJ", []);
  CSS.make("_a5qlEXSl_", []);
  CSS.make("_a5qNLmUnZ", []);
  CSS.make("_a5qVWxJYZ", []);
  CSS.make("_a5qkhjAC5", []);
  CSS.make("_a5qZjhGNd", []);
  CSS.make("_a5qwwV6Vh", []);
  CSS.make("_a5qfTvj8f", []);
  CSS.make("_a5qC3IOuK", []);
  CSS.make("_a5qQxBGf3", []);
  CSS.make("_a5q2FVOfa", []);
  CSS.make("_a5qiWLXZy", []);
  CSS.make("_a5qCbiH64", []);
  CSS.make("_a5qG6-RB_", []);
  CSS.make("_a5ql0bqe4", []);
  CSS.make("_a5qej0MBN", []);
  CSS.make("_a5qiTEL3H", []);
  CSS.make("_a5qy9LIHm", []);
  CSS.make("_a5qoqu5o8", []);
  CSS.make("_a5qrcrEN_", []);
  CSS.make("_a5qF6pjFU", []);
  CSS.make("_a5q3xdXup", []);
  CSS.make("_a5qCzbo_-", []);
  CSS.make("_a5q86pYzH", []);
  CSS.make("_a5q0RKZLg", []);
  CSS.make("_a5qUV4apX", []);
  CSS.make("_a5qzCtoUa", []);
  CSS.make("_a5qppvRHF", []);
  CSS.make("_a5sXbE6aa", []);
  CSS.make("_a5s7xdJ_g", []);
  CSS.make("_a5seDf_vY", []);
  CSS.make("_a5sNAfHUT", []);
  CSS.make("_a5s9Xb3UF", []);
  CSS.make("_a5sl_mC5M", []);
  CSS.make("_a5sZe3llY", []);
  CSS.make("_a5s7tstpc", []);
  CSS.make("_a5sCakF15", []);
  CSS.make("_a5s5OFPxU", []);
  CSS.make("_a5s4i3DAC", []);
  CSS.make("_a5sPuCrgv", []);
  CSS.make("_a5s4l211K", []);
  CSS.make("_a5sJJFGEE", []);
  CSS.make("_a5syV3R8S", []);
  CSS.make("_a5s7znno6", []);
  CSS.make("_a5s4lpFHl", []);
  CSS.make("_a5sSDBdSf", []);
  CSS.make("_a5sUI5CWh", []);
  CSS.make("_a5sN7ebze", []);
  CSS.make("_a5scz-4LD", []);
  CSS.make("_a5sCOZbs6", []);
  CSS.make("_a5oqol8EF", []);
  CSS.make("_a5o-rnkwh", []);
  CSS.make("_a5omWZ9wx", []);
  CSS.make("_a5ojKLwas", []);
  CSS.make("_a5oSM-OX3", []);
  CSS.make("_a5o9n0CfT", []);
  CSS.make("_a5opWahZQ", []);
  CSS.make("_a5pweWKZI", []);
  CSS.make("_a5poKr8PO", []);
  CSS.make("_a5pKiKz4p", []);
  CSS.make("_a5pNn7Wa2", []);
  CSS.make("_a5pVu_mqE", []);
  CSS.make("_a5pOvLbqJ", []);
  CSS.make("_a5pb9IMEB", []);
  CSS.make("_a5pmgC6r3", []);
  CSS.make("_a5pbnJzpu", []);
  CSS.make("_a5pslgd21", []);
  CSS.make("_a5pbdgRLS", []);
  CSS.make("_a5pRkH4rl", []);
  CSS.make("_a5pcG64ML", []);
  CSS.make("_a5pGh6k-Y", []);
  CSS.make("_a5pTZx1Nb", []);
  CSS.make("_a5p7ZzjYG", []);
  CSS.make("_a5p-DBkTa", []);
  CSS.make("_a5pqvQPP7", []);
  CSS.make("_a5pQv4GmJ", []);
  CSS.make("_a5pMMvkCd", []);
  CSS.make("_a5nXpue2C", []);
  CSS.make("_a5nuhJ_4w", []);
  CSS.make("_a5npB5tn6", []);
  CSS.make("_a5nZtO765", []);
  CSS.make("_a5nULRXCD", []);
  CSS.make("_a5nsy7wtp", []);
  CSS.make("_a5nI3Y6XI", []);
  CSS.make("_a5nH5L8Uz", []);
  CSS.make("_a5n3DdiHT", []);
  
  CSS.make("_a70rDIiHK", []);
  
  CSS.make("_a70kUmtNo", []);
  
  CSS.make("_a70j16w-T", []);
  
  CSS.make("_a70k83GM5", []);
  
  CSS.make("_a70r2eCps", []);
  
  CSS.make("_a70Gfs7RI", []);
  
  CSS.make("_a70kAhYcP", []);
  
  CSS.make("_a70a7DK-5", []);
  
  CSS.make("_a70nEZeHE", []);
  
  CSS.make("_a70qRInuj", []);
  
  CSS.make("_a706fD4CG", []);
  
  CSS.make("_a70aRsv_J", []);
  
  CSS.make("_a70l97Vo2", []);
  
  CSS.make("_a708lbK30", []);
  CSS.make("_a70AoHgCR", []);
  CSS.make("_a70s25ruW", []);
  CSS.make(
    "_a70M_XZqN",
    [
      (
        "--elevation1-1rnnems_1",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-1rnnems_2",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-1rnnems_3",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
    ],
  );
  
  CSS.make("_a4p3yeYeI", []);
  CSS.make("_a4pC2iv8w", []);
  CSS.make("_a4pSYWI4D", []);
  CSS.make("_a4pBlQEbB", []);
  CSS.make("_a4pNS_MDP", []);
  CSS.make("_a4pPJsEkP", []);
  CSS.make("_a4paFmD-L", []);
  CSS.make("_a4pLpaRIc", []);
  CSS.make("_a4pE6RdaX", []);
  CSS.make("_a4pdRYrP-", []);
  CSS.make("_a4poHUjX0", []);
  CSS.make("_a4p1ejCyW", []);
  CSS.make("_a4pH2H39u", []);
  CSS.make("_a4pKguRFW", []);
  CSS.make("_a4pXybPKZ", []);
  CSS.make("_a4pL5l1MO", []);
  CSS.make("_a4p8Bqk-7", []);
  CSS.make("_a4pwQtgsg", []);
  CSS.make("_a4pr9s41Z", []);
  CSS.make("_a4pMdd2qI", []);
  CSS.make("_a4piJrdoy", []);
  CSS.make("_a4pKlxX99", []);
  CSS.make("_a4pOEkj0X", []);
  CSS.make("_a4pu9ETa8", []);
  CSS.make("_a4piJrdoy", []);
  CSS.make("_a4qFBraPY", []);
  CSS.make("_a4qABtS_A", []);
  CSS.make("_a4qTzYAhy", []);
  CSS.make("_a4qVj8ARr", []);
  CSS.make("_a4qDzB8Ul", []);
  CSS.make("_a4qc4Etlp", []);
  CSS.make("_a4qNkB_Lv", []);
  CSS.make("_a4qwh-mEB", []);
  CSS.make("_a4qajoP_Y", []);
  CSS.make("_a4qbW8KwE", []);
  CSS.make("_a4qYGClhB", []);
  CSS.make("_a4qnfAID_", []);
  CSS.make("_a4qmiQKrt", []);
  CSS.make("_a4qtshWj4", []);
  CSS.make("_a4qpvRc1-", []);
  CSS.make("_a4qBo-Ur8", []);
  CSS.make("_a4qdfrg1p", []);
  CSS.make("_a4qojwPLx", []);
  CSS.make("_a4qEA9n9p", []);
  CSS.make("_a4qBEaiDj", []);
  CSS.make("_a4qF6sRol", []);
  CSS.make("_a4qvx3qLc", []);
  CSS.make("_a4qwlIl6K", []);
  CSS.make("_a4qDcGfnO", []);
  CSS.make("_a4qF6sRol", []);
  
  CSS.make("_a4mCgBwcp", []);
  CSS.make("_a4mYgd48d", []);
  CSS.make("_a4m6fm4mB", []);
  CSS.make("_a4mZcHXIH", []);
  CSS.make("_a4mg0AwAm", []);
  CSS.make("_a4mFsRJQb", []);
  CSS.make("_a4mFlvrGM", []);
  CSS.make("_a4mR1I1nJ", []);
  CSS.make("_a4mn1pEmt", []);
  CSS.make("_a4m9bMQOd", []);
  CSS.make("_a4mjrb5Fq", []);
  let color = `hex("333");
  CSS.make(
    "_a4mJYve7R",
    [
      ("--color-35oif8_1", CSS.Types.Color.toString(color)),
      ("--color-35oif8_2", CSS.Types.Color.toString(color)),
      ("--color-35oif8_3", CSS.Types.Color.toString(color)),
    ],
  );
  CSS.make(
    "_a4miBHoaY",
    [
      ("--color-1dnob2v_1", CSS.Types.Color.toString(color)),
      ("--color-1dnob2v_2", CSS.Types.Color.toString(color)),
      ("--color-1dnob2v_3", CSS.Types.Color.toString(color)),
      ("--color-1dnob2v_4", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make(
    "_a4mfgDMxK",
    [
      ("--boxDark-iyil7j", CSS.Types.Color.toString(Color.Background.boxDark)),
    ],
  );
  
  CSS.make("_a4mgnmVmY", []);
  CSS.make("_a4mQvq9vZ", []);
  CSS.make("_a4mB8_KJz", []);
  CSS.make("_a4mEd-JpN", []);
  CSS.make("_a4muBx_po", []);
  CSS.make("_a4mEN_wS8", []);
  CSS.make("_a4mGLm5MR", []);
  CSS.make("_a4mcwJTyD", []);
  
  CSS.make("_acqeWTArg", []);
  CSS.make("_acqgr8A7h", []);
  CSS.make("_acq8ftO_F", []);
  CSS.make("_acqkLLqy_", []);
  CSS.make("_acqGyGVcZ", []);
  CSS.make("_acqiz4T8H", []);
  CSS.make("_acqmXZ6m4", []);
  CSS.make("_acqf3BL-f", []);
  CSS.make("_acqiioe_M", []);
  CSS.make("_acqRDNiWI", []);
  CSS.make("_acqEn8euc", []);
  CSS.make("_acq0rrHas", []);
  CSS.make("_acqNdOW65", []);
  CSS.make("_acqhCz-rb", []);
  CSS.make("_acqqhZ_sp", []);
  CSS.make("_acqCVoUKz", []);
  CSS.make("_acquQrxPk", []);
  
  CSS.make("_ablemaR7h", []);
  CSS.make("_abl7oZ6qm", []);
  CSS.make("_ablSNUYd7", []);
  CSS.make("_ablC-eDY6", []);
  CSS.make("_ably8MMkG", []);
  
  CSS.make("_a4oo35s_D", []);
  CSS.make("_a4pSYWI4D", []);
  CSS.make("_a4qlbfuJa", []);
  CSS.make("_a4od2487y", []);
  CSS.make("_a4oS7b2w6", []);
  CSS.make("_a4oP6L_iH", []);
  CSS.make("_a4oORObMa", []);
  CSS.make("_a4oNnRjsu", []);
  
  CSS.make("_af1Uuqqu5", []);
  CSS.make("_af1mACV93", []);
  CSS.make("_af1bIQtFP", []);
  CSS.make("_af11FHeIR", []);
  CSS.make("_af1h4hN27", []);
  
  CSS.make("_af1L2ZrPR", []);
  CSS.make("_af1OaTKWc", []);
  
  CSS.make("_af1J1zQnG", []);
  CSS.make("_af1R04FUa", []);
  CSS.make("_af16Dxxbf", []);
  
  CSS.make("_af1ViTN8v", []);
  CSS.make("_af1YXaASz", []);
  CSS.make("_af1aSbOGe", []);
  
  CSS.make("_af1VoHDLi", []);
  CSS.make("_af1hYdret", []);
  CSS.make("_af1mQdbcB", []);
  CSS.make("_af1R5XI3Z", []);
  CSS.make("_af1jpLNEP", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("keyframe-1b5h4ts");
