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
        "_a71MczmmJ",
        ["._a71MczmmJ{box-sizing:border-box;}"],
        1,
        0,
        1,
        [("value", "MczmmJ", "val\\071\\0& | \\0box-sizing:border-box")],
      ),
      (
        "_a71HRuO4b",
        ["._a71HRuO4b{box-sizing:content-box;}"],
        1,
        0,
        1,
        [("value", "HRuO4b", "val\\071\\0& | \\0box-sizing:content-box")],
      ),
      (
        "_affDDbJHJ",
        ["._affDDbJHJ{outline-style:auto;}"],
        1,
        0,
        1,
        [("value", "DDbJHJ", "val\\0ff\\0& | \\0outline-style:auto")],
      ),
      (
        "_affWCiV6e",
        ["._affWCiV6e{outline-style:none;}"],
        1,
        0,
        1,
        [("value", "WCiV6e", "val\\0ff\\0& | \\0outline-style:none")],
      ),
      (
        "_affiV-i1Z",
        ["._affiV-i1Z{outline-style:dotted;}"],
        1,
        0,
        1,
        [("value", "iV-i1Z", "val\\0ff\\0& | \\0outline-style:dotted")],
      ),
      (
        "_affkLNI7R",
        ["._affkLNI7R{outline-style:dashed;}"],
        1,
        0,
        1,
        [("value", "kLNI7R", "val\\0ff\\0& | \\0outline-style:dashed")],
      ),
      (
        "_affhLvibE",
        ["._affhLvibE{outline-style:solid;}"],
        1,
        0,
        1,
        [("value", "hLvibE", "val\\0ff\\0& | \\0outline-style:solid")],
      ),
      (
        "_affgal-VL",
        ["._affgal-VL{outline-style:double;}"],
        1,
        0,
        1,
        [("value", "gal-VL", "val\\0ff\\0& | \\0outline-style:double")],
      ),
      (
        "_affwztVUb",
        ["._affwztVUb{outline-style:groove;}"],
        1,
        0,
        1,
        [("value", "wztVUb", "val\\0ff\\0& | \\0outline-style:groove")],
      ),
      (
        "_affutR0cd",
        ["._affutR0cd{outline-style:ridge;}"],
        1,
        0,
        1,
        [("value", "utR0cd", "val\\0ff\\0& | \\0outline-style:ridge")],
      ),
      (
        "_aff0v8J-O",
        ["._aff0v8J-O{outline-style:inset;}"],
        1,
        0,
        1,
        [("value", "0v8J-O", "val\\0ff\\0& | \\0outline-style:inset")],
      ),
      (
        "_aff0Iu_ox",
        ["._aff0Iu_ox{outline-style:outset;}"],
        1,
        0,
        1,
        [("value", "0Iu_ox", "val\\0ff\\0& | \\0outline-style:outset")],
      ),
      (
        "_afe2o1Yfv",
        ["._afe2o1Yfv{outline-offset:-5px;}"],
        1,
        0,
        1,
        [("value", "2o1Yfv", "val\\0fe\\0& | \\0outline-offset:-5px")],
      ),
      (
        "_afeQYmnbQ",
        ["._afeQYmnbQ{outline-offset:0;}"],
        1,
        0,
        1,
        [("value", "QYmnbQ", "val\\0fe\\0& | \\0outline-offset:0")],
      ),
      (
        "_afeLSzAcT",
        ["._afeLSzAcT{outline-offset:5px;}"],
        1,
        0,
        1,
        [("value", "LSzAcT", "val\\0fe\\0& | \\0outline-offset:5px")],
      ),
      (
        "_ah1yzcR5r",
        ["._ah1yzcR5r{resize:none;}"],
        1,
        0,
        1,
        [("value", "yzcR5r", "val\\0h1\\0& | \\0resize:none")],
      ),
      (
        "_ah1hADiUT",
        ["._ah1hADiUT{resize:both;}"],
        1,
        0,
        1,
        [("value", "hADiUT", "val\\0h1\\0& | \\0resize:both")],
      ),
      (
        "_ah12EAJnT",
        ["._ah12EAJnT{resize:horizontal;}"],
        1,
        0,
        1,
        [("value", "2EAJnT", "val\\0h1\\0& | \\0resize:horizontal")],
      ),
      (
        "_ah1km2LBw",
        ["._ah1km2LBw{resize:vertical;}"],
        1,
        0,
        1,
        [("value", "km2LBw", "val\\0h1\\0& | \\0resize:vertical")],
      ),
      (
        "_aljwQ7Lfn",
        ["._aljwQ7Lfn{text-overflow:clip;}"],
        1,
        0,
        1,
        [("value", "wQ7Lfn", "val\\0lj\\0& | \\0text-overflow:clip")],
      ),
      (
        "_aljsDYldM",
        ["._aljsDYldM{text-overflow:ellipsis;}"],
        1,
        0,
        1,
        [("value", "sDYldM", "val\\0lj\\0& | \\0text-overflow:ellipsis")],
      ),
      (
        "_a99eewubR",
        ["._a99eewubR{cursor:default;}"],
        1,
        0,
        1,
        [("value", "eewubR", "val\\099\\0& | \\0cursor:default")],
      ),
      (
        "_a99UU27lu",
        ["._a99UU27lu{cursor:none;}"],
        1,
        0,
        1,
        [("value", "UU27lu", "val\\099\\0& | \\0cursor:none")],
      ),
      (
        "_a99RKLfU_",
        ["._a99RKLfU_{cursor:context-menu;}"],
        1,
        0,
        1,
        [("value", "RKLfU_", "val\\099\\0& | \\0cursor:context-menu")],
      ),
      (
        "_a99-K8TRF",
        ["._a99-K8TRF{cursor:cell;}"],
        1,
        0,
        1,
        [("value", "-K8TRF", "val\\099\\0& | \\0cursor:cell")],
      ),
      (
        "_a99r_6JKo",
        ["._a99r_6JKo{cursor:vertical-text;}"],
        1,
        0,
        1,
        [("value", "r_6JKo", "val\\099\\0& | \\0cursor:vertical-text")],
      ),
      (
        "_a99h2d70N",
        ["._a99h2d70N{cursor:alias;}"],
        1,
        0,
        1,
        [("value", "h2d70N", "val\\099\\0& | \\0cursor:alias")],
      ),
      (
        "_a991cd1Mz",
        ["._a991cd1Mz{cursor:copy;}"],
        1,
        0,
        1,
        [("value", "1cd1Mz", "val\\099\\0& | \\0cursor:copy")],
      ),
      (
        "_a99Hvw13s",
        ["._a99Hvw13s{cursor:no-drop;}"],
        1,
        0,
        1,
        [("value", "Hvw13s", "val\\099\\0& | \\0cursor:no-drop")],
      ),
      (
        "_a99sFJnRG",
        ["._a99sFJnRG{cursor:not-allowed;}"],
        1,
        0,
        1,
        [("value", "sFJnRG", "val\\099\\0& | \\0cursor:not-allowed")],
      ),
      (
        "_a99o8062j",
        ["._a99o8062j{cursor:-webkit-grab;cursor:grab;}"],
        1,
        0,
        1,
        [("value", "o8062j", "val\\099\\0& | \\0cursor:grab")],
      ),
      (
        "_a99jYzpmF",
        ["._a99jYzpmF{cursor:-webkit-grabbing;cursor:grabbing;}"],
        1,
        0,
        1,
        [("value", "jYzpmF", "val\\099\\0& | \\0cursor:grabbing")],
      ),
      (
        "_a993EsSSc",
        ["._a993EsSSc{cursor:ew-resize;}"],
        1,
        0,
        1,
        [("value", "3EsSSc", "val\\099\\0& | \\0cursor:ew-resize")],
      ),
      (
        "_a996YKXY5",
        ["._a996YKXY5{cursor:ns-resize;}"],
        1,
        0,
        1,
        [("value", "6YKXY5", "val\\099\\0& | \\0cursor:ns-resize")],
      ),
      (
        "_a99fK43nS",
        ["._a99fK43nS{cursor:nesw-resize;}"],
        1,
        0,
        1,
        [("value", "fK43nS", "val\\099\\0& | \\0cursor:nesw-resize")],
      ),
      (
        "_a99b1JO2d",
        ["._a99b1JO2d{cursor:nwse-resize;}"],
        1,
        0,
        1,
        [("value", "b1JO2d", "val\\099\\0& | \\0cursor:nwse-resize")],
      ),
      (
        "_a99rxPtvx",
        ["._a99rxPtvx{cursor:col-resize;}"],
        1,
        0,
        1,
        [("value", "rxPtvx", "val\\099\\0& | \\0cursor:col-resize")],
      ),
      (
        "_a99G7x01M",
        ["._a99G7x01M{cursor:row-resize;}"],
        1,
        0,
        1,
        [("value", "G7x01M", "val\\099\\0& | \\0cursor:row-resize")],
      ),
      (
        "_a99KJXH9S",
        ["._a99KJXH9S{cursor:all-scroll;}"],
        1,
        0,
        1,
        [("value", "KJXH9S", "val\\099\\0& | \\0cursor:all-scroll")],
      ),
      (
        "_a99qwzAeR",
        ["._a99qwzAeR{cursor:zoom-in;}"],
        1,
        0,
        1,
        [("value", "qwzAeR", "val\\099\\0& | \\0cursor:zoom-in")],
      ),
      (
        "_a99yxuomQ",
        ["._a99yxuomQ{cursor:zoom-out;}"],
        1,
        0,
        1,
        [("value", "yxuomQ", "val\\099\\0& | \\0cursor:zoom-out")],
      ),
      (
        "_a795QXIjR",
        ["._a795QXIjR{caret-color:auto;}"],
        1,
        0,
        1,
        [("value", "5QXIjR", "val\\079\\0& | \\0caret-color:auto")],
      ),
      (
        "_a79_sksn9",
        ["._a79_sksn9{caret-color:green;}"],
        1,
        0,
        1,
        [("value", "_sksn9", "val\\079\\0& | \\0caret-color:green")],
      ),
      (
        "_a4a7t1ZbE",
        [
          "._a4a7t1ZbE{-webkit-appearance:auto;-moz-appearance:auto;-ms-appearance:auto;appearance:auto;}",
        ],
        1,
        0,
        1,
        [("value", "7t1ZbE", "val\\04a\\0& | \\0appearance:auto")],
      ),
      (
        "_a4aYLqRod",
        [
          "._a4aYLqRod{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}",
        ],
        1,
        0,
        1,
        [("value", "YLqRod", "val\\04a\\0& | \\0appearance:none")],
      ),
      (
        "_aljYkwgio",
        ["._aljYkwgio{text-overflow:\"foo\";}"],
        1,
        0,
        1,
        [("value", "Ykwgio", "val\\0lj\\0& | \\0text-overflow:\"foo\"")],
      ),
      (
        "_aljtyKuYC",
        ["._aljtyKuYC{text-overflow:clip clip;}"],
        1,
        0,
        1,
        [("value", "tyKuYC", "val\\0lj\\0& | \\0text-overflow:clip clip")],
      ),
      (
        "_aljwT6kEU",
        ["._aljwT6kEU{text-overflow:ellipsis clip;}"],
        1,
        0,
        1,
        [("value", "wT6kEU", "val\\0lj\\0& | \\0text-overflow:ellipsis clip")],
      ),
      (
        "_aljUFL7pX",
        ["._aljUFL7pX{text-overflow:\"foo\" clip;}"],
        1,
        0,
        1,
        [("value", "UFL7pX", "val\\0lj\\0& | \\0text-overflow:\"foo\" clip")],
      ),
      (
        "_aljyiqVCD",
        ["._aljyiqVCD{text-overflow:clip ellipsis;}"],
        1,
        0,
        1,
        [("value", "yiqVCD", "val\\0lj\\0& | \\0text-overflow:clip ellipsis")],
      ),
      (
        "_aljfXLwV9",
        ["._aljfXLwV9{text-overflow:ellipsis ellipsis;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "fXLwV9",
            "val\\0lj\\0& | \\0text-overflow:ellipsis ellipsis",
          ),
        ],
      ),
      (
        "_aljkjGSxL",
        ["._aljkjGSxL{text-overflow:\"foo\" ellipsis;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "kjGSxL",
            "val\\0lj\\0& | \\0text-overflow:\"foo\" ellipsis",
          ),
        ],
      ),
      (
        "_alj1t0Ihz",
        ["._alj1t0Ihz{text-overflow:clip \"foo\";}"],
        1,
        0,
        1,
        [("value", "1t0Ihz", "val\\0lj\\0& | \\0text-overflow:clip \"foo\"")],
      ),
      (
        "_aljIh8kEN",
        ["._aljIh8kEN{text-overflow:ellipsis \"foo\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Ih8kEN",
            "val\\0lj\\0& | \\0text-overflow:ellipsis \"foo\"",
          ),
        ],
      ),
      (
        "_alj5rp-sD",
        ["._alj5rp-sD{text-overflow:\"foo\" \"foo\";}"],
        1,
        0,
        1,
        [
          ("value", "5rp-sD", "val\\0lj\\0& | \\0text-overflow:\"foo\" \"foo\""),
        ],
      ),
      (
        "_amlmIPRV7",
        [
          "._amlmIPRV7{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}",
        ],
        1,
        0,
        1,
        [("value", "mIPRV7", "val\\0ml\\0& | \\0user-select:auto")],
      ),
      (
        "_amlQcBIhJ",
        [
          "._amlQcBIhJ{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}",
        ],
        1,
        0,
        1,
        [("value", "QcBIhJ", "val\\0ml\\0& | \\0user-select:text")],
      ),
      (
        "_aml-wc9hs",
        [
          "._aml-wc9hs{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
        ],
        1,
        0,
        1,
        [("value", "-wc9hs", "val\\0ml\\0& | \\0user-select:none")],
      ),
      (
        "_amlEG8wbT",
        [
          "._amlEG8wbT{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}",
        ],
        1,
        0,
        1,
        [("value", "EG8wbT", "val\\0ml\\0& | \\0user-select:contain")],
      ),
      (
        "_amllLeauN",
        [
          "._amllLeauN{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}",
        ],
        1,
        0,
        1,
        [("value", "lLeauN", "val\\0ml\\0& | \\0user-select:all")],
      ),
    ]
  ];
  
  CSS.make("_a71MczmmJ", []);
  CSS.make("_a71HRuO4b", []);
  CSS.make("_affDDbJHJ", []);
  CSS.make("_affWCiV6e", []);
  CSS.make("_affiV-i1Z", []);
  CSS.make("_affkLNI7R", []);
  CSS.make("_affhLvibE", []);
  CSS.make("_affgal-VL", []);
  CSS.make("_affwztVUb", []);
  CSS.make("_affutR0cd", []);
  CSS.make("_aff0v8J-O", []);
  CSS.make("_aff0Iu_ox", []);
  CSS.make("_afe2o1Yfv", []);
  CSS.make("_afeQYmnbQ", []);
  CSS.make("_afeLSzAcT", []);
  CSS.make("_ah1yzcR5r", []);
  CSS.make("_ah1hADiUT", []);
  CSS.make("_ah12EAJnT", []);
  CSS.make("_ah1km2LBw", []);
  CSS.make("_aljwQ7Lfn", []);
  CSS.make("_aljsDYldM", []);
  
  CSS.make("_a99eewubR", []);
  CSS.make("_a99UU27lu", []);
  CSS.make("_a99RKLfU_", []);
  CSS.make("_a99-K8TRF", []);
  CSS.make("_a99r_6JKo", []);
  CSS.make("_a99h2d70N", []);
  CSS.make("_a991cd1Mz", []);
  CSS.make("_a99Hvw13s", []);
  CSS.make("_a99sFJnRG", []);
  CSS.make("_a99o8062j", []);
  CSS.make("_a99jYzpmF", []);
  CSS.make("_a993EsSSc", []);
  CSS.make("_a996YKXY5", []);
  CSS.make("_a99fK43nS", []);
  CSS.make("_a99b1JO2d", []);
  CSS.make("_a99rxPtvx", []);
  CSS.make("_a99G7x01M", []);
  CSS.make("_a99KJXH9S", []);
  CSS.make("_a99qwzAeR", []);
  CSS.make("_a99yxuomQ", []);
  CSS.make("_a795QXIjR", []);
  CSS.make("_a79_sksn9", []);
  
  CSS.make("_a4a7t1ZbE", []);
  CSS.make("_a4aYLqRod", []);
  
  CSS.make("_aljwQ7Lfn", []);
  CSS.make("_aljsDYldM", []);
  
  CSS.make("_aljYkwgio", []);
  CSS.make("_aljtyKuYC", []);
  CSS.make("_aljwT6kEU", []);
  
  CSS.make("_aljUFL7pX", []);
  CSS.make("_aljyiqVCD", []);
  CSS.make("_aljfXLwV9", []);
  
  CSS.make("_aljkjGSxL", []);
  
  CSS.make("_alj1t0Ihz", []);
  CSS.make("_aljIh8kEN", []);
  
  CSS.make("_alj5rp-sD", []);
  CSS.make("_amlmIPRV7", []);
  CSS.make("_amlQcBIhJ", []);
  CSS.make("_aml-wc9hs", []);
  CSS.make("_amlEG8wbT", []);
  CSS.make("_amllLeauN", []);

  $ dune build
