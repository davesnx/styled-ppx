  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._id_1yd9dp3{font-weight:bold;}"];
  [@css
    ("._a_4emldq{color:orange;}", "_a_4emldq", "0,1,0 own", "158", 1, false)
  ];
  [@css.bindings [("Output.highlighted", "_id_1yd9dp3", "_a_4emldq")]];
  [@css.blocks [(1, "_id_1yd9dp3", [1])]];
  let highlighted = CSS.make("label:highlighted _id_1yd9dp3 _a_4emldq", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
