  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body ._id_wbeinp{font-weight:bold;}"];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_7peacs{margin:10px;}"];
  [@css.bindings
    [("Output.multi", "_id_wbeinp", "_a_5r08qs _a_4ekvmb _a_7peacs")]
  ];
  let multi =
    CSS.make("label:multi _id_wbeinp _a_5r08qs _a_4ekvmb _a_7peacs", []);
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
