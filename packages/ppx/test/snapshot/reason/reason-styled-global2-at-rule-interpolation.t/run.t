  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--var-xec4w7);}"];
  [@css "@media (min-width: 768px) {body{color:var(--var-1st71j9);}}"];
  let mobileColor = CSS.red;
  let desktopColor = CSS.blue;
  module ResponsiveStyles = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--var-xec4w7:")
                ++ CSS.Types.Color.toString(mobileColor)
              )
              ++ ";"
            )
            ++ "--var-1st71j9:"
          )
          ++ CSS.Types.Color.toString(desktopColor)
        )
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    let make = () => CSS.global_style_tag(to_string());
  };
