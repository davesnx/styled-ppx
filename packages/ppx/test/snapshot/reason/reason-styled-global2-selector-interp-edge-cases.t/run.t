  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(.css-vdiv8w1){margin:0;}"];
  [@css ".css-vdiv8w1{background:var(--bg-1rdts9a);}"];
  [@css ".css-vdiv76b.css-vdiv8w1{color:white;}"];
  [@css ".container .css-vdiv8w1{color:var(--bg-raax3p);}"];
  [@css ".css-vdiv8w1{padding:10px;}"];
  [@css ".css-vdiv76b{border:1px solid;}"];
  [@css.classes
    [
      ("css-vdiv8w1", 4, "Output.card", "output.ml", 1, 18, 1, 32),
      ("css-vdiv76b", 5, "Output.active", "output.ml", 2, 20, 2, 38),
    ]
  ];
  [@css.bindings
    [("Output.card", "css-vdiv8w1"), ("Output.active", "css-vdiv76b")]
  ];
  let card = CSS.make("css-vdiv8w1", []);
  let active = CSS.make("css-vdiv76b", []);
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
