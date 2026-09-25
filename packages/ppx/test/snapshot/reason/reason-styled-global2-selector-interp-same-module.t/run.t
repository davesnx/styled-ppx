  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .id-wu3nwu{font-weight:bold;}"];
  [@css ".a-4emldq{color:orange;}"];
  [@css.bindings [("Output.highlighted", "id-wu3nwu", "a-4emldq")]];
  let highlighted = CSS.make("label:highlighted id-wu3nwu a-4emldq", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
