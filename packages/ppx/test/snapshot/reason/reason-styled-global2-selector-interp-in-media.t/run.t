  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".cid-16nw107{color:black;}"];
  [@css "@media (max-width: 640px) {.cid-16nw107{color:gray;}}"];
  [@css ".css-hpgf8j-card{padding:8px;}"];
  [@css.bindings [("Output.card", "cid-16nw107", "css-hpgf8j-card")]];
  let card = CSS.make("cid-16nw107 css-hpgf8j-card", []);
  module ResponsiveGlobals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
