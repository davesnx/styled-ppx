  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--var-t4is5w);}"];
  [@css "@media (min-width: 768px) {body{color:var(--var-igf9t7);}}"];
  let mobileColor = CSS.red;
  let desktopColor = CSS.blue;
  module ResponsiveStyles = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--var-t4is5w:")
                ++ CSS.Types.Color.toString(mobileColor)
              )
              ++ ";"
            )
            ++ "--var-igf9t7:"
          )
          ++ CSS.Types.Color.toString(desktopColor)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
