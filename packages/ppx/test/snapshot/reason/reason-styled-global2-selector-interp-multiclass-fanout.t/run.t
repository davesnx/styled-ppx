  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .cid-wbeinp{font-weight:bold;}"];
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-eaeacs{margin:10px;}"];
  [@css.bindings
    [("Output.multi", "cid-wbeinp", "css-k008qs css-tokvmb css-eaeacs")]
  ];
  let multi =
    CSS.make(~label="multi", "cid-wbeinp css-k008qs css-tokvmb css-eaeacs", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
