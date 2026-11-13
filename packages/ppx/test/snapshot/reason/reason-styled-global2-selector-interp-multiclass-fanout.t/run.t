  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .css-go2ynv{font-weight:bold;}"];
  [@css ".css-go2ynv{display:flex;color:red;margin:10px;}"];
  [@css.classes [("css-go2ynv", 1, "Output.multi", "output.ml", 2, 2, 5, 0)]];
  [@css.bindings [("Output.multi", "css-go2ynv")]];
  let multi = CSS.make("css-go2ynv", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
