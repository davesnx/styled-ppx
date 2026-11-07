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
        "_a85ALDs8x",
        ["._a85ALDs8x{-webkit-column-width:10em;column-width:10em;}"],
        1,
        0,
        1,
        [("value", "ALDs8x", "val\\085\\0& | \\0column-width:10em")],
      ),
      (
        "_a85gfZ3hH",
        ["._a85gfZ3hH{-webkit-column-width:auto;column-width:auto;}"],
        1,
        0,
        1,
        [("value", "gfZ3hH", "val\\085\\0& | \\0column-width:auto")],
      ),
      (
        "_a7lEaIJmM",
        ["._a7lEaIJmM{-webkit-column-count:2;column-count:2;}"],
        1,
        0,
        1,
        [("value", "EaIJmM", "val\\07l\\0& | \\0column-count:2")],
      ),
      (
        "_a7lFBnKlM",
        ["._a7lFBnKlM{-webkit-column-count:auto;column-count:auto;}"],
        1,
        0,
        1,
        [("value", "FBnKlM", "val\\07l\\0& | \\0column-count:auto")],
      ),
      (
        "_a87nJjUwT",
        ["._a87nJjUwT{-webkit-columns:100px;columns:100px;}"],
        1,
        0,
        4,
        [("value", "nJjUwT", "val\\087\\0& | \\0columns:100px")],
      ),
      (
        "_a87ssBhWz",
        ["._a87ssBhWz{-webkit-columns:3;columns:3;}"],
        1,
        0,
        4,
        [("value", "ssBhWz", "val\\087\\0& | \\0columns:3")],
      ),
      (
        "_a87fkZCJZ",
        ["._a87fkZCJZ{-webkit-columns:10em 2;columns:10em 2;}"],
        1,
        0,
        4,
        [("value", "fkZCJZ", "val\\087\\0& | \\0columns:10em 2")],
      ),
      (
        "_a872jYHy-",
        ["._a872jYHy-{-webkit-columns:auto auto;columns:auto auto;}"],
        1,
        0,
        4,
        [("value", "2jYHy-", "val\\087\\0& | \\0columns:auto auto")],
      ),
      (
        "_a87THGDba",
        ["._a87THGDba{-webkit-columns:2 10em;columns:2 10em;}"],
        1,
        0,
        4,
        [("value", "THGDba", "val\\087\\0& | \\0columns:2 10em")],
      ),
      (
        "_a87CnhtVf",
        ["._a87CnhtVf{-webkit-columns:auto 10em;columns:auto 10em;}"],
        1,
        0,
        4,
        [("value", "CnhtVf", "val\\087\\0& | \\0columns:auto 10em")],
      ),
      (
        "_a87XvLLOV",
        ["._a87XvLLOV{-webkit-columns:2 auto;columns:2 auto;}"],
        1,
        0,
        4,
        [("value", "XvLLOV", "val\\087\\0& | \\0columns:2 auto")],
      ),
      (
        "_a7rwd-CAJ",
        ["._a7rwd-CAJ{-webkit-column-rule-color:red;column-rule-color:red;}"],
        1,
        0,
        1,
        [("value", "wd-CAJ", "val\\07r\\0& | \\0column-rule-color:red")],
      ),
      (
        "_a81F6YWiM",
        ["._a81F6YWiM{-webkit-column-rule-style:none;column-rule-style:none;}"],
        1,
        0,
        1,
        [("value", "F6YWiM", "val\\081\\0& | \\0column-rule-style:none")],
      ),
      (
        "_a81CypQfg",
        [
          "._a81CypQfg{-webkit-column-rule-style:solid;column-rule-style:solid;}",
        ],
        1,
        0,
        1,
        [("value", "CypQfg", "val\\081\\0& | \\0column-rule-style:solid")],
      ),
      (
        "_a81HNPqMw",
        [
          "._a81HNPqMw{-webkit-column-rule-style:dotted;column-rule-style:dotted;}",
        ],
        1,
        0,
        1,
        [("value", "HNPqMw", "val\\081\\0& | \\0column-rule-style:dotted")],
      ),
      (
        "_a83r7A2GV",
        ["._a83r7A2GV{-webkit-column-rule-width:1px;column-rule-width:1px;}"],
        1,
        0,
        1,
        [("value", "r7A2GV", "val\\083\\0& | \\0column-rule-width:1px")],
      ),
      (
        "_a7p37xgQr",
        [
          "._a7p37xgQr{-webkit-column-rule:transparent;column-rule:transparent;}",
        ],
        1,
        0,
        3,
        [("value", "37xgQr", "val\\07p\\0& | \\0column-rule:transparent")],
      ),
      (
        "_a7pPhznpa",
        [
          "._a7pPhznpa{-webkit-column-rule:1px solid black;column-rule:1px solid black;}",
        ],
        1,
        0,
        3,
        [("value", "Phznpa", "val\\07p\\0& | \\0column-rule:1px solid black")],
      ),
      (
        "_a84C4VUNs",
        ["._a84C4VUNs{-webkit-column-span:none;column-span:none;}"],
        1,
        0,
        1,
        [("value", "C4VUNs", "val\\084\\0& | \\0column-span:none")],
      ),
      (
        "_a84gusTvm",
        ["._a84gusTvm{-webkit-column-span:all;column-span:all;}"],
        1,
        0,
        1,
        [("value", "gusTvm", "val\\084\\0& | \\0column-span:all")],
      ),
      (
        "_a7mhAngF2",
        ["._a7mhAngF2{-webkit-column-fill:auto;column-fill:auto;}"],
        1,
        0,
        1,
        [("value", "hAngF2", "val\\07m\\0& | \\0column-fill:auto")],
      ),
      (
        "_a7mOcvqpK",
        ["._a7mOcvqpK{-webkit-column-fill:balance;column-fill:balance;}"],
        1,
        0,
        1,
        [("value", "OcvqpK", "val\\07m\\0& | \\0column-fill:balance")],
      ),
      (
        "_a7map6dYU",
        [
          "._a7map6dYU{-webkit-column-fill:balance-all;column-fill:balance-all;}",
        ],
        1,
        0,
        1,
        [("value", "ap6dYU", "val\\07m\\0& | \\0column-fill:balance-all")],
      ),
    ]
  ];
  
  CSS.make("_a85ALDs8x", []);
  CSS.make("_a85gfZ3hH", []);
  CSS.make("_a7lEaIJmM", []);
  CSS.make("_a7lFBnKlM", []);
  CSS.make("_a87nJjUwT", []);
  CSS.make("_a87ssBhWz", []);
  CSS.make("_a87fkZCJZ", []);
  
  CSS.make("_a872jYHy-", []);
  CSS.make("_a87THGDba", []);
  CSS.make("_a87CnhtVf", []);
  CSS.make("_a87XvLLOV", []);
  CSS.make("_a7rwd-CAJ", []);
  CSS.make("_a81F6YWiM", []);
  CSS.make("_a81CypQfg", []);
  CSS.make("_a81HNPqMw", []);
  CSS.make("_a83r7A2GV", []);
  CSS.make("_a7p37xgQr", []);
  CSS.make("_a7pPhznpa", []);
  CSS.make("_a84C4VUNs", []);
  CSS.make("_a84gusTvm", []);
  CSS.make("_a7mhAngF2", []);
  CSS.make("_a7mOcvqpK", []);
  CSS.make("_a7map6dYU", []);
