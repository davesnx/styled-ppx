  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--var-1ltpo4o);width:var(--var-xjb6x5);opacity:var(--var-tdbeio);z-index:var(--var-vll3e5);}"
  ];
  let textColor = CSS.red;
  let bodyWidth = CSS.px(960);
  let mainOpacity = 0.95;
  let layerIndex = 10;
  module ThemeStyles = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (
                  (
                    (
                      (
                        (
                          (
                            (":root{" ++ "--var-1ltpo4o:")
                            ++ CSS.Types.Color.toString(textColor)
                          )
                          ++ ";"
                        )
                        ++ "--var-xjb6x5:"
                      )
                      ++ CSS.Types.Width.toString(bodyWidth)
                    )
                    ++ ";"
                  )
                  ++ "--var-tdbeio:"
                )
                ++ CSS.Types.Opacity.toString(mainOpacity)
              )
              ++ ";"
            )
            ++ "--var-vll3e5:"
          )
          ++ CSS.Types.ZIndex.toString(layerIndex)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
