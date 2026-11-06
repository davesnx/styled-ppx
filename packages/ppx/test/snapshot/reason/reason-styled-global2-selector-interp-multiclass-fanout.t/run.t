  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._iaphdRvzy{font-weight:bold;}"];
  [@css.atoms
    [
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_actal1K5c",
        ["._actal1K5c{margin:10px;}"],
        1,
        0,
        4,
        [("value", "al1K5c", "val\\0ct\\0& | \\0margin:10px")],
      ),
      (
        "_iaphdRvzy",
        [],
        1,
        0,
        0,
        [("id", "_iaphdRvzy", "bind\\0\\0Output\\0\\0multi\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Output.multi",
        "_iaphdRvzy _a9fMU0SCS _a7fadbhEW _actal1K5c",
        "_iaphdRvzy",
      ),
    ]
  ];
  let multi = CSS.make("_iaphdRvzy _a9fMU0SCS _a7fadbhEW _actal1K5c", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
