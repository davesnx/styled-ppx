  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".cid-16nw107{color:red;}"];
  [@css ".css-nk32ej{padding:10px;}"];
  [@css.bindings [("Output.card", "cid-16nw107", "css-nk32ej")]];
  let card = CSS.make(~label="card", "cid-16nw107 css-nk32ej", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
