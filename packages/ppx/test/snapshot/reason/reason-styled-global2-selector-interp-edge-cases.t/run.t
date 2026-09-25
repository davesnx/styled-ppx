  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(.id-16nw107){margin:0;}"];
  [@css ".id-16nw107{background:var(--bg-1rdts9a);}"];
  [@css ".id-1iojcla.id-16nw107{color:white;}"];
  [@css ".container .id-16nw107{color:var(--bg-raax3p);}"];
  [@css ".a-nk32ej{padding:10px;}"];
  [@css ".a-b7rhyr{border:1px solid;}"];
  [@css.bindings
    [
      ("Output.card", "id-16nw107", "a-nk32ej"),
      ("Output.active", "id-1iojcla", "a-b7rhyr"),
    ]
  ];
  let card = CSS.make("label:card id-16nw107 a-nk32ej", []);
  let active = CSS.make("label:active id-1iojcla a-b7rhyr", []);
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
