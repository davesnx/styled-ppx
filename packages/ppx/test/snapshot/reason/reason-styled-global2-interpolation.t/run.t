  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--var-vc3pj1);margin:0;}"];
  let themeColor = CSS.red;
  module ThemeStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-vc3pj1:") ++ CSS.Types.Color.toString(themeColor))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
