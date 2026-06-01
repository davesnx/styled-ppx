  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--var-nkdt8w);margin:0;}"];
  let themeColor = CSS.red;
  module ThemeStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-nkdt8w:") ++ CSS.Types.Color.toString(themeColor))
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
