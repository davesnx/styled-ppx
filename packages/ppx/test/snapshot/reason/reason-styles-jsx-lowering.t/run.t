Default mode expands `styles` on lowercase JSX and leaves other calls alone.
The ppx reads refmt's binary AST, so the locations in [@@@css.classes]
point into input.re: refmt's OCaml printer lays out output.ml differently
on each OCaml version.

  $ refmt --parse re --print binary input.re > input.bin
  $ ../../../standalone.exe --impl input.bin -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-ivpc8ui{margin-top:32px;}"];
  [@css.classes [("css-ivpc8ui", 0, "", "input.re", 21, 47, 21, 65)]];
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
        Cn2.(Css.bodyLg +++ CSS.make("css-ivpc8ui", [])),
      )}
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("css-ivpc8ui", [])))}
    />;
  let _ =
    <div
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
    />;
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;

Native mode keeps the same `styles` expansion contract before native JSX lowering.

  $ refmt --parse re --print binary input.re > input.bin
  $ ../../../standalone.exe --native --impl input.bin -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-ivpc8ui{margin-top:32px;}"];
  [@css.classes [("css-ivpc8ui", 0, "", "input.re", 21, 47, 21, 65)]];
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
        Cn2.(Css.bodyLg +++ CSS.make("css-ivpc8ui", [])),
      )}
      style={CSS.styles(Cn2.(Css.bodyLg +++ CSS.make("css-ivpc8ui", [])))}
    />;
  let _ =
    <div
      className={CSS.className(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, CSS.styles(buttonStyles))}
    />;
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;
