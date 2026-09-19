  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(.cid-16nw107){margin:0;}"];
  [@css ".cid-16nw107{background:var(--bg-1rdts9a);}"];
  [@css ".cid-1iojcla.cid-16nw107{color:white;}"];
  [@css ".container .cid-16nw107{color:var(--bg-raax3p);}"];
  [@css ".css-nk32ej{padding:10px;}"];
  [@css ".css-b7rhyr{border:1px solid;}"];
  [@css.bindings
    [
      ("Output.card", "cid-16nw107", "css-nk32ej"),
      ("Output.active", "cid-1iojcla", "css-b7rhyr"),
    ]
  ];
  let card = CSS.make("cx-card cid-16nw107 css-nk32ej", []);
  let active = CSS.make("cx-active cid-1iojcla css-b7rhyr", []);
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
