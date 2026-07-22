  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--themeColor-1gdqp4y);background-color:var(--themeColor-1gdqp4y);border-color:var(--themeColor-1gdqp4y);}"
  ];
  let themeColor = CSS.red;
  module ThemeStyles = {
    let to_string = () =>
      (
        (
          (":root{" ++ "--themeColor-1gdqp4y:")
          ++ CSS.Types.Color.toString(themeColor)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
