/* Probe: selector interpolation in styled.global2.

   Same-module: $(local) where local is bound to a [%css] earlier
   in the file. Should resolve to the actual class chain. */

let highlighted = [%css "color: orange;"];

module Globals = [%styled.global2
  {|
  body .$(highlighted) {
    font-weight: bold;
  }
|}
];
