  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-nk32ej-card{color:red;}"];
  [@css ".css-nk32ej-card{padding:10px;}"];
  [@css.bindings [("Output.card", "css-nk32ej-card")]];
  let card = CSS.make("css-nk32ej-card", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
