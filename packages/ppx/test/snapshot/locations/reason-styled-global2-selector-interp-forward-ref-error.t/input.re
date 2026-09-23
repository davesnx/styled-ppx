module Globals = [%styled.global {|
  .$(later) {
    color: red;
  }
|}];

let later = [%css "padding: 0;"];
