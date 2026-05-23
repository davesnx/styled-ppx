let card = [%css "padding: 10px;"];

module Globals = [%styled.global {|
  $(card) {
    color: red;
  }
|}];
