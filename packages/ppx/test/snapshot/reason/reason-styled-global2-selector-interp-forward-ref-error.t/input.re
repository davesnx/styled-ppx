module Globals = [%styled.global2 {|
  .$(later) {
    color: red;
  }
|}];

let later = [%css "padding: 0;"];
