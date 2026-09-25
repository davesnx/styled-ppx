  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".id-16nw107{color:black;}"];
  [@css "@media (max-width: 640px) {.id-16nw107{color:gray;}}"];
  [@css ".a-hpgf8j{padding:8px;}"];
  [@css.bindings [("Output.card", "id-16nw107", "a-hpgf8j")]];
  let card = CSS.make("label:card id-16nw107 a-hpgf8j", []);
  module ResponsiveGlobals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
