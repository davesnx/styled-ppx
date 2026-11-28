  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-vdiv0s5{color:black;}"];
  [@css "@media (max-width: 640px) {.css-vdiv0s5{color:gray;}}"];
  [@css ".css-vdiv0s5{padding:8px;}"];
  [@css.classes
    [("css-vdiv0s5", 2, "Output.card", "output.ml", 1, 18, 1, 31)]
  ];
  [@css.bindings [("Output.card", "css-vdiv0s5")]];
  let card = CSS.make("css-vdiv0s5", []);
  module ResponsiveGlobals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
