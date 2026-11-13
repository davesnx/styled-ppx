  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--1ltpo4o);width:var(--xjb6x5);opacity:var(--tdbeio);z-index:var(--vll3e5);}"
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
                            (":root{" ++ "--1ltpo4o:")
                            ++ CSS.Types.Color.toString(textColor)
                          )
                          ++ ";"
                        )
                        ++ "--xjb6x5:"
                      )
                      ++ CSS.Types.Width.toString(bodyWidth)
                    )
                    ++ ";"
                  )
                  ++ "--tdbeio:"
                )
                ++ CSS.Types.Opacity.toString(mainOpacity)
              )
              ++ ";"
            )
            ++ "--vll3e5:"
          )
          ++ CSS.Types.ZIndex.toString(layerIndex)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
