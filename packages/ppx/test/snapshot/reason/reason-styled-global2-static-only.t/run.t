  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "html{box-sizing:border-box;}"];
  [@css "body{margin:0;font-family:system-ui, sans-serif;}"];
  [@css "*{box-sizing:inherit;}"];
  [@css "*::before{box-sizing:inherit;}"];
  [@css "*::after{box-sizing:inherit;}"];
  module ResetStyles = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
