  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--var-1genhr4);background-color:var(--var-1genhr4);border-color:var(--var-1genhr4);}"
  ];
  let themeColor = CSS.red;
  module ThemeStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-1genhr4:") ++ CSS.Types.Color.toString(themeColor))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
