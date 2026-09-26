Default mode expands `styles` on lowercase JSX and leaves other calls alone.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._a_7p008fkc8{margin-top:32px;}"];
  let buttonStyles = ("button", ReactDOM.Style.make());
  let bodyLg = ("body-lg", ReactDOM.Style.make());
  let baseStyle = ReactDOM.Style.make();
  let passthrough = (~styles) => styles;
  module Cn2 = {
    let (+++) = ((leftClassName, leftStyle), (rightClassName, rightStyle)) => (
      leftClassName ++ " " ++ rightClassName,
      ReactDOM.Style.combine(leftStyle, rightStyle),
    );
    module Css = {
      let bodyLg = bodyLg;
    };
  };
  let _ = passthrough(~styles=buttonStyles);
  let _ =
    <div
      className={CSS.className(buttonStyles)}
      style={CSS.styles(buttonStyles)}
    />;
  let _ =
    <p
      className={CSS.className(
        Cn2.(Css.bodyLg +++ CSS.make("_a_7p008fkc8", [])),
      )}
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("_a_7p008fkc8", [])))}
    />;
  let _ =
    <div
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
    />;
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;

Native mode keeps the same `styles` expansion contract before native JSX lowering.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._a_7p008fkc8{margin-top:32px;}"];
  let buttonStyles = ("button", ReactDOM.Style.make());
  let bodyLg = ("body-lg", ReactDOM.Style.make());
  let baseStyle = ReactDOM.Style.make();
  let passthrough = (~styles) => styles;
  module Cn2 = {
    let (+++) = ((leftClassName, leftStyle), (rightClassName, rightStyle)) => (
      leftClassName ++ " " ++ rightClassName,
      ReactDOM.Style.combine(leftStyle, rightStyle),
    );
    module Css = {
      let bodyLg = bodyLg;
    };
  };
  let _ = passthrough(~styles=buttonStyles);
  let _ =
    <div
      className={CSS.className(buttonStyles)}
      style={CSS.styles(buttonStyles)}
    />;
  let _ =
    <p
      className={CSS.className(
        Cn2.(Css.bodyLg +++ CSS.make("_a_7p008fkc8", [])),
      )}
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("_a_7p008fkc8", [])))}
    />;
  let _ =
    <div
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
    />;
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;
