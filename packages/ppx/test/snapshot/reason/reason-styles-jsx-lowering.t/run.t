Default mode expands `styles` on lowercase JSX and leaves other calls alone.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@css|passthrough|className|style|Foo'
  [@css ".css-h5fkc8{margin-top:32px;}"];
  let passthrough = (~styles) => styles;
  let _ = passthrough(~styles=buttonStyles);
      className={CSS.className(buttonStyles)}
      style={CSS.styles(buttonStyles)}
      className={CSS.className(
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("css-h5fkc8", [])))}
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;

Native mode keeps the same `styles` expansion contract before native JSX lowering.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@css|passthrough|className|style|Foo'
  [@css ".css-h5fkc8{margin-top:32px;}"];
  let passthrough = (~styles) => styles;
  let _ = passthrough(~styles=buttonStyles);
      className={CSS.className(buttonStyles)}
      style={CSS.styles(buttonStyles)}
      className={CSS.className(
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("css-h5fkc8", [])))}
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;
