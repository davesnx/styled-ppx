  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._iEE28JIkS{font-weight:bold;}"];
  [@css.atoms
    [
      (
        "_a7fpoe-bj",
        ["._a7fpoe-bj{color:orange;}"],
        1,
        0,
        1,
        [("value", "poe-bj", "val\\07f\\0& | \\0color:orange")],
      ),
      (
        "_iEE28JIkS",
        [],
        1,
        0,
        0,
        [("id", "_iEE28JIkS", "bind\\0\\0Output\\0\\0highlighted\\00")],
      ),
    ]
  ];
  [@css.bindings
    [("Output.highlighted", "_iEE28JIkS _a7fpoe-bj", "_iEE28JIkS")]
  ];
  let highlighted = CSS.make("_iEE28JIkS _a7fpoe-bj", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
