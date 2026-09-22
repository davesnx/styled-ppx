  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .cid-wu3nwu{font-weight:bold;}"];
  [@css ".css-7kmldq{color:orange;}"];
  [@css.bindings [("Output.highlighted", "cid-wu3nwu", "css-7kmldq")]];
  let highlighted = CSS.make(~label="highlighted", "cid-wu3nwu css-7kmldq", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
