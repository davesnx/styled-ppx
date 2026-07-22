  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@import \"theme.css\";"];
  [@css "@media print {body{color:red;}}"];
  [@css "body{color:blue;}"];
  [@css ".card{color:green;}"];
  [@css "@media print {.card{color:black;}}"];
  [@css ".card{color:gray;}"];
  [@css "@media print {.link:hover{color:purple;}}"];
  module Ordered = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
