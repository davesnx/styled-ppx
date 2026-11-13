  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-cq28w1{color:red;}"];
  [@css ".css-cq28w1{padding:10px;}"];
  [@css.classes [("css-cq28w1", 1, "Output.card", "output.ml", 1, 18, 1, 32)]];
  [@css.bindings [("Output.card", "css-cq28w1")]];
  let card = CSS.make("css-cq28w1", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
