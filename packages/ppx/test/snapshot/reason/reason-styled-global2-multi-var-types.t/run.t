  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--var-fd4uw2);width:var(--var-14iqkam);opacity:var(--var-i54r13);z-index:var(--var-14m30q4);}"
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
                            (":root{" ++ "--var-fd4uw2:")
                            ++ CSS.Types.Color.toString(textColor)
                          )
                          ++ ";"
                        )
                        ++ "--var-14iqkam:"
                      )
                      ++ CSS.Types.Width.toString(bodyWidth)
                    )
                    ++ ";"
                  )
                  ++ "--var-i54r13:"
                )
                ++ CSS.Types.Opacity.toString(mainOpacity)
              )
              ++ ";"
            )
            ++ "--var-14m30q4:"
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
