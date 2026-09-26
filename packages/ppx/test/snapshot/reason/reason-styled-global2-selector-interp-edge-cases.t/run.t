  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(._id_16nw107){margin:0;}"];
  [@css "._id_16nw107{background:var(--bg-1rdts9a);}"];
  [@css "._id_1iojcla._id_16nw107{color:white;}"];
  [@css ".container ._id_16nw107{color:var(--bg-raax3p);}"];
  [@css "._a_9432ej{padding:10px;}"];
  [@css "._a_3hrhyr{border:1px solid;}"];
  [@css.bindings
    [
      ("Output.card", "_id_16nw107", "_a_9432ej"),
      ("Output.active", "_id_1iojcla", "_a_3hrhyr"),
    ]
  ];
  let card = CSS.make("label:card _id_16nw107 _a_9432ej", []);
  let active = CSS.make("label:active _id_1iojcla _a_3hrhyr", []);
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
