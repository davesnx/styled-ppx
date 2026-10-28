  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(._id_cr5zkq){margin:0;}"];
  [@css "._id_cr5zkq{background:var(--bg-1rdts9a);}"];
  [@css "._id_r2s0n3._id_cr5zkq{color:white;}"];
  [@css ".container ._id_cr5zkq{color:var(--bg-raax3p);}"];
  [@css
    ("._a_9432ej{padding:10px;}", "_a_9432ej", "0,1,0 own", "328", 15, false)
  ];
  [@css
    (
      "._a_3hrhyr{border:1px solid;}",
      "_a_3hrhyr",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css.bindings
    [
      ("Output.card", "_id_cr5zkq", "_a_9432ej"),
      ("Output.active", "_id_r2s0n3", "_a_3hrhyr"),
    ]
  ];
  [@css.blocks [(1, "_id_cr5zkq", [4]), (2, "_id_r2s0n3", [5])]];
  let card = CSS.make("label:card _id_cr5zkq _a_9432ej", []);
  let active = CSS.make("label:active _id_r2s0n3 _a_3hrhyr", []);
  let bg = CSS.red;
  module CardGlobals = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--bg-1rdts9a:")
                ++ CSS.Types.Background.toString(bg)
              )
              ++ ";"
            )
            ++ "--bg-raax3p:"
          )
          ++ CSS.Types.Color.toString(bg)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
