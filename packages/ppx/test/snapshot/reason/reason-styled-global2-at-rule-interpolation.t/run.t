  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--mobileColor-hxwrco)}"];
  [@css "@media (min-width:768px){body{color:var(--desktopColor-1clh3sq)}}"];
  let mobileColor = CSS.red;
  let desktopColor = CSS.blue;
  module ResponsiveStyles = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--mobileColor-hxwrco:")
                ++ CSS.Types.Color.toString(mobileColor)
              )
              ++ ";"
            )
            ++ "--desktopColor-1clh3sq:"
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
