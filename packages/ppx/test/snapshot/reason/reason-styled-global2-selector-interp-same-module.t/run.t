  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._id_wu3nwu{font-weight:bold;}"];
  [@css "._a_4emldq{color:orange;}"];
  [@css.bindings [("Output.highlighted", "_id_wu3nwu", "_a_4emldq")]];
  let highlighted = CSS.make("label:highlighted _id_wu3nwu _a_4emldq", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
