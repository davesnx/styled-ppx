Shape 7: an ancestor scope keeps the element as the subject and is tier 2.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_c7fpUJUrAr7jyja",
        ["#ah_p ._c7fpUJUrAr7jyja{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "pUJUrA", "ctx\\0#ah_p & | "),
          ("value", "r7jyja", "val\\07f\\0#ah_p & | \\0color:red"),
        ],
      ),
      (
        "_c7f_2Gv9JrpQi5_",
        [".dark ._c7f_2Gv9JrpQi5_{color:white;}"],
        2,
        1,
        1,
        [
          ("ctx", "_2Gv9J", "ctx\\0.dark & | "),
          ("value", "rpQi5_", "val\\07f\\0.dark & | \\0color:white"),
        ],
      ),
      (
        "_iYTD4us-h",
        [],
        1,
        0,
        0,
        [("id", "_iYTD4us-h", "bind\\0\\0Input\\0\\0page\\00")],
      ),
      (
        "_iFflfkxYm",
        [],
        1,
        0,
        0,
        [("id", "_iFflfkxYm", "bind\\0\\0Input\\0\\0dark\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.page", "_iYTD4us-h _c7fpUJUrAr7jyja", "_iYTD4us-h"),
      ("Input.dark", "_iFflfkxYm _c7f_2Gv9JrpQi5_", "_iFflfkxYm"),
    ]
  ];
  let page = CSS.make("cx-page _iYTD4us-h _c7fpUJUrAr7jyja", []);
  let dark = CSS.make("cx-dark _iFflfkxYm _c7f_2Gv9JrpQi5_", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7fpUJUrAr7jyja",
        ["#ah_p ._c7fpUJUrAr7jyja{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "pUJUrA", "ctx\\0#ah_p & | "),
          ("value", "r7jyja", "val\\07f\\0#ah_p & | \\0color:red"),
        ],
      ),
      (
        "_c7f_2Gv9JrpQi5_",
        [".dark ._c7f_2Gv9JrpQi5_{color:white;}"],
        2,
        1,
        1,
        [
          ("ctx", "_2Gv9J", "ctx\\0.dark & | "),
          ("value", "rpQi5_", "val\\07f\\0.dark & | \\0color:white"),
        ],
      ),
      (
        "_iYTD4us-h",
        [],
        1,
        0,
        0,
        [("id", "_iYTD4us-h", "bind\\0\\0Input\\0\\0page\\00")],
      ),
      (
        "_iFflfkxYm",
        [],
        1,
        0,
        0,
        [("id", "_iFflfkxYm", "bind\\0\\0Input\\0\\0dark\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.page", "_iYTD4us-h _c7fpUJUrAr7jyja", "_iYTD4us-h"),
      ("Input.dark", "_iFflfkxYm _c7f_2Gv9JrpQi5_", "_iFflfkxYm"),
    ]
  ];
  let page = CSS.make("_iYTD4us-h _c7fpUJUrAr7jyja", []);
  let dark = CSS.make("_iFflfkxYm _c7f_2Gv9JrpQi5_", []);
