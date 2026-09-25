  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body .id-wbeinp{font-weight:bold;}"];
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-7peacs{margin:10px;}"];
  [@css.bindings
    [("Output.multi", "id-wbeinp", "a-5r08qs a-4ekvmb a-7peacs")]
  ];
  let multi = CSS.make("label:multi id-wbeinp a-5r08qs a-4ekvmb a-7peacs", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
