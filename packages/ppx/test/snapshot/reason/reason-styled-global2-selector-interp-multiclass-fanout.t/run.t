  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .id-wbeinp{font-weight:bold;}"];
  [@css ".a-k008qs{display:flex;}"];
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-eaeacs{margin:10px;}"];
  [@css.bindings
    [("Output.multi", "id-wbeinp", "a-k008qs a-tokvmb a-eaeacs")]
  ];
  let multi = CSS.make("label:multi id-wbeinp a-k008qs a-tokvmb a-eaeacs", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
