module Globals = [%styled.global2 {|
  .$(later) {
    color: red;
  }
|}];

let later = [%cx2 "padding: 0;"];
