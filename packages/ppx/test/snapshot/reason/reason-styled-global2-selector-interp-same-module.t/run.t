  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .css-1gxp4nc{font-weight:bold;}"];
  [@css ".css-1gxp4nc{color:orange;}"];
  [@css.classes
    [("css-1gxp4nc", 1, "Output.highlighted", "output.ml", 1, 25, 1, 39)]
  ];
  [@css.bindings [("Output.highlighted", "css-1gxp4nc")]];
  let highlighted = CSS.make("css-1gxp4nc", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
