  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .css-vdivynv{font-weight:bold;}"];
  [@css ".css-vdivynv{display:flex;color:red;margin:10px;}"];
  [@css.classes [("css-vdivynv", 1, "Output.multi", "output.ml", 2, 2, 5, 0)]];
  [@css.bindings [("Output.multi", "css-vdivynv")]];
  let multi = CSS.make("css-vdivynv", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
