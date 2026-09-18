  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body{color:var(--textColor-1vkdku3);width:var(--bodyWidth-e47qay);opacity:var(--mainOpacity-hiaqwu);z-index:var(--layerIndex-1wk33)}"
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
                            (":root{" ++ "--textColor-1vkdku3:")
                            ++ CSS.Types.Color.toString(textColor)
                          )
                          ++ ";"
                        )
                        ++ "--bodyWidth-e47qay:"
                      )
                      ++ CSS.Types.Width.toString(bodyWidth)
                    )
                    ++ ";"
                  )
                  ++ "--mainOpacity-hiaqwu:"
                )
                ++ CSS.Types.Opacity.toString(mainOpacity)
              )
              ++ ";"
            )
            ++ "--layerIndex-1wk33:"
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
