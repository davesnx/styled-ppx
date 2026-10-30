  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._id_cr5zkq{color:black;}"];
  [@css "@media (max-width: 640px) {._id_cr5zkq{color:gray;}}"];
  [@css
    ("._a_94gf8j{padding:8px;}", "_a_94gf8j", "0,1,0 own", "328", 15, false)
  ];
  [@css.bindings [("Output.card", "_id_cr5zkq", "_a_94gf8j")]];
  [@css.blocks [(1, "_id_cr5zkq", [2])]];
  let card = CSS.make("label:card _id_cr5zkq _a_94gf8j", []);
  module ResponsiveGlobals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
