  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".id-16nw107{color:red;}"];
  [@css ".a-nk32ej{padding:10px;}"];
  [@css.bindings [("Output.card", "id-16nw107", "a-nk32ej")]];
  let card = CSS.make("label:card id-16nw107 a-nk32ej", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
