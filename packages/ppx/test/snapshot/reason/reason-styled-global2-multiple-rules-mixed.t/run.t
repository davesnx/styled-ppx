  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "html{box-sizing:border-box;}"];
  [@css "body{margin:0;color:var(--primary-1e1sh1z);}"];
  [@css "a{-webkit-text-decoration:none;text-decoration:none;}"];
  let primary = CSS.red;
  module MixedStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--primary-1e1sh1z:") ++ CSS.Types.Color.toString(primary))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
