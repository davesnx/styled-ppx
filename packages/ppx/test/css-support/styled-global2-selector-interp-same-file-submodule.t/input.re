module Css = {
  let marker = [%css {| color: red; |}];
};

module Globals = [%styled.global
  {|
  body .$(Css.marker) {
    font-weight: bold;
  }
|}
];

let _ = (Css.marker, Globals.to_string, Globals.make);
