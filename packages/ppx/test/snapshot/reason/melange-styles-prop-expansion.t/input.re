let woo = [%cx2 "display: flex;"];

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

let maybe_css = Some([%cx2 {|
  display: flex;
|}]);

let _ = <div styles={css(CSS.red)} />;
let _ = <div styles=?maybe_css />;
let _ = <div className="extra-classname" styles={css(CSS.red)} />;
let _ = <div className="extra-classname" styles=?maybe_css />;
let _ = <div
  style={ReactDOM.Style.make(~display="flex", ())}
  styles={css(CSS.red)}
/>;
let _ = <div
  style={ReactDOM.Style.make(~display="flex", ())}
  styles=?maybe_css
/>;
let _ = <div
  className="extra-classname"
  style={ReactDOM.Style.make(~display="flex", ())}
  styles={css(CSS.red)}
/>;
let _ = <div
  className="extra-classname"
  style={ReactDOM.Style.make(~display="flex", ())}
  styles=?maybe_css
/>;
