let buttonStyles = ("button", ReactDOM.Style.make());
let bodyLg = ("body-lg", ReactDOM.Style.make());
let baseStyle = ReactDOM.Style.make();

let passthrough = (~styles) => styles;

module Cn2 = {
  let (+++) = ((leftClassName, leftStyle), (rightClassName, rightStyle)) =>
    (
      leftClassName ++ " " ++ rightClassName,
      ReactDOM.Style.combine(leftStyle, rightStyle),
    );

  module Css = {
    let bodyLg = bodyLg;
  };
};

let _ = passthrough(~styles=buttonStyles);
let _ = <div styles=buttonStyles />;
let _ = <p styles=Cn2.(Css.bodyLg +++ [%css {| margin-top: 32px; |}]) />;
let _ = <div className="base" style=baseStyle styles=buttonStyles />;
let _ = <Foo styles=buttonStyles />;
let _ = <Foo.Bar styles=buttonStyles />;
