module Css = {
  let marker = [%cx2 {| color: red; |}];
};

module Globals = [%styled.global2 {|
  body .$(Css.marker) {
    font-weight: bold;
  }
|}];

let _ = (Css.marker, Globals.to_string, Globals.to_buffer, Globals.make);
