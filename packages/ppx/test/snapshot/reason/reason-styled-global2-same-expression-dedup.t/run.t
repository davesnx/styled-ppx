  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--var-1gdqp4y);background-color:var(--var-1gdqp4y);border-color:var(--var-1gdqp4y);}"
  ];
  let themeColor = CSS.red;
  module ThemeStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-1gdqp4y:") ++ CSS.Types.Color.toString(themeColor))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
