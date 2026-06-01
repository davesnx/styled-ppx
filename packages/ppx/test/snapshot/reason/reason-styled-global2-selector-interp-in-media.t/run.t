  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-hpgf8j-card{color:black;}"];
  [@css "@media (max-width: 640px) {.css-hpgf8j-card{color:gray;}}"];
  [@css ".css-hpgf8j-card{padding:8px;}"];
  [@css.bindings [("Output.card", "css-hpgf8j-card")]];
  let card = CSS.make("css-hpgf8j-card", []);
  module ResponsiveGlobals = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
