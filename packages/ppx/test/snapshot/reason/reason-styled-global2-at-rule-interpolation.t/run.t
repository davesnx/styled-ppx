  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--mobileColor-1odltmt);}"];
  [@css "@media (min-width: 768px) {body{color:var(--desktopColor-1kb79vz);}}"];
  let mobileColor = CSS.red;
  let desktopColor = CSS.blue;
  module ResponsiveStyles = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--mobileColor-1odltmt:")
                ++ CSS.Types.Color.toString(mobileColor)
              )
              ++ ";"
            )
            ++ "--desktopColor-1kb79vz:"
          )
          ++ CSS.Types.Color.toString(desktopColor)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
