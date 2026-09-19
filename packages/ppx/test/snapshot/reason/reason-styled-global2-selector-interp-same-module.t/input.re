/* Probe: selector interpolation in styled.global.

   Same-module: $(local) where local is bound to a [%css] earlier
   in the file. Should resolve to local's identity class. */

let highlighted = [%css "color: orange;"];

module Globals = [%styled.global
  {|
  body .$(highlighted) {
    font-weight: bold;
  }
|}
];
