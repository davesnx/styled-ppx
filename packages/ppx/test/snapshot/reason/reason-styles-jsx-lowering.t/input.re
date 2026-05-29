let buttonStyles = ("button", ReactDOM.Style.make());
let baseStyle = ReactDOM.Style.make();

let passthrough = (~styles) => styles;

let _ = passthrough(~styles=buttonStyles);
let _ = <div styles=buttonStyles />;
let _ = <div className="base" style=baseStyle styles=buttonStyles />;
let _ = <Foo styles=buttonStyles />;
let _ = <Foo.Bar styles=buttonStyles />;
