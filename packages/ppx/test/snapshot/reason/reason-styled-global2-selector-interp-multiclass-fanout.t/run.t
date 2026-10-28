  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._id_1c12h1n{font-weight:bold;}"];
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    ("._a_7peacs{margin:10px;}", "_a_7peacs", "0,1,0 own", "277", 15, false)
  ];
  [@css.bindings
    [("Output.multi", "_id_1c12h1n", "_a_5r08qs _a_4ekvmb _a_7peacs")]
  ];
  [@css.blocks [(1, "_id_1c12h1n", [1, 2, 3])]];
  let multi =
    CSS.make("label:multi _id_1c12h1n _a_5r08qs _a_4ekvmb _a_7peacs", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
