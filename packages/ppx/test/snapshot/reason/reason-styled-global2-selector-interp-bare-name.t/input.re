let card = [%cx2 "padding: 10px;"];

module Globals = [%styled.global2 {|
  $(card) {
    color: red;
  }
|}];
