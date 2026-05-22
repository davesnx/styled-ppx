let card = [%css "padding: 10px;"];

module Globals = [%styled.global2 {|
  $(card) {
    color: red;
  }
|}];
