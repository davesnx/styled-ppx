  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .css-7kmldq-highlighted{font-weight:bold;}"];
  [@css ".css-7kmldq-highlighted{color:orange;}"];
  [@css.bindings [("Output.highlighted", "css-7kmldq-highlighted")]];
  let highlighted =
    CSS.make_labeled("highlighted", "css-7kmldq-highlighted", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
