  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(._iKmFQmZ3g){margin:0;}"];
  [@css "._iKmFQmZ3g{background:var(--bg-1rdts9a);}"];
  [@css "._ip1OvzyTB._iKmFQmZ3g{color:white;}"];
  [@css ".container ._iKmFQmZ3g{color:var(--bg-raax3p);}"];
  [@css.atoms
    [
      (
        "_afywyM-xx",
        ["._afywyM-xx{padding:10px;}"],
        1,
        0,
        4,
        [("value", "wyM-xx", "val\\0fy\\0& | \\0padding:10px")],
      ),
      (
        "_a50xl-Gj4",
        ["._a50xl-Gj4{border:1px solid;}"],
        1,
        0,
        17,
        [("value", "xl-Gj4", "val\\050\\0& | \\0border:1px solid")],
      ),
      (
        "_iKmFQmZ3g",
        [],
        1,
        0,
        0,
        [("id", "_iKmFQmZ3g", "bind\\0\\0Output\\0\\0card\\00")],
      ),
      (
        "_ip1OvzyTB",
        [],
        1,
        0,
        0,
        [("id", "_ip1OvzyTB", "bind\\0\\0Output\\0\\0active\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.card", "_iKmFQmZ3g _afywyM-xx", "_iKmFQmZ3g"),
      ("Output.active", "_ip1OvzyTB _a50xl-Gj4", "_ip1OvzyTB"),
    ]
  ];
  let card = CSS.make("_iKmFQmZ3g _afywyM-xx", []);
  let active = CSS.make("_ip1OvzyTB _a50xl-Gj4", []);
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
