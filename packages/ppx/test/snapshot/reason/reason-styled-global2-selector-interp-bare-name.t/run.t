  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._iKmFQmZ3g{color:red;}"];
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
        "_iKmFQmZ3g",
        [],
        1,
        0,
        0,
        [("id", "_iKmFQmZ3g", "bind\\0\\0Output\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings [("Output.card", "_iKmFQmZ3g _afywyM-xx", "_iKmFQmZ3g")]];
  let card = CSS.make("_iKmFQmZ3g _afywyM-xx", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
