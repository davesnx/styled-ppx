  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(.css-cq28w1){margin:0;}"];
  [@css ".css-cq28w1{background:var(--1rdts9a);}"];
  [@css ".css-1v2z76b.css-cq28w1{color:white;}"];
  [@css ".container .css-cq28w1{color:var(--raax3p);}"];
  [@css ".css-cq28w1{padding:10px;}"];
  [@css ".css-1v2z76b{border:1px solid;}"];
  [@css.classes
    [
      ("css-cq28w1", 4, "Output.card", "output.ml", 1, 18, 1, 32),
      ("css-1v2z76b", 5, "Output.active", "output.ml", 2, 20, 2, 38),
    ]
  ];
  [@css.bindings
    [("Output.card", "css-cq28w1"), ("Output.active", "css-1v2z76b")]
  ];
  let card = CSS.make("css-cq28w1", []);
  let active = CSS.make("css-1v2z76b", []);
  let bg = CSS.red;
  module CardGlobals = {
    let to_string = () =>
      (
        (
          (
            (
              ((":root{" ++ "--1rdts9a:") ++ CSS.Types.Background.toString(bg))
              ++ ";"
            )
            ++ "--raax3p:"
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
