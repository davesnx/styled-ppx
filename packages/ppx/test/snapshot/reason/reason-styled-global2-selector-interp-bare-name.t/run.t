  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._id_cr5zkq{color:red;}"];
  [@css
    ("._a_9432ej{padding:10px;}", "_a_9432ej", "0,1,0 own", "328", 15, false)
  ];
  [@css.bindings [("Output.card", "_id_cr5zkq", "_a_9432ej")]];
  [@css.blocks [(1, "_id_cr5zkq", [1])]];
  let card = CSS.make("label:card _id_cr5zkq _a_9432ej", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
