  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._id_16nw107{color:red;}"];
  [@css "._a_9432ej{padding:10px;}"];
  [@css.bindings [("Output.card", "_id_16nw107", "_a_9432ej")]];
  let card = CSS.make("label:card _id_16nw107 _a_9432ej", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
