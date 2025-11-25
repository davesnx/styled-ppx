let woo = [%cx2 "display: flex;"];

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div styles={css(CSS.red)} />;

let maybe_css = Some([%cx2 {|
  display: flex;
|}]);

<div styles=?maybe_css />;
<div className="extra-classname" styles={css(CSS.red)} />;
<div className="extra-classname" styles=?maybe_css />;
<div
  style={ReactDOM.Style.make([|("display", "flex")|])}
  styles={css(CSS.red)}
/>;
<div
  style={ReactDOM.Style.make([|("display", "flex")|])}
  styles=?maybe_css
/>;
<div
  className="extra-classname"
  style={ReactDOM.Style.make([|("display", "flex")|])}
  styles={css(CSS.red)}
/>;
<div
  className="extra-classname"
  style={ReactDOM.Style.make([|("display", "flex")|])}
  styles=?maybe_css
/>;
