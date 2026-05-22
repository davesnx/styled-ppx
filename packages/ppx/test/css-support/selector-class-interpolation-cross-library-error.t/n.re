/* Cross-library reference: `OtherLib.marker` lives in a separate dune
   library that the aggregator never indexed. We expect a clear error. */
let container = [%css {|
  &.$(OtherLib.marker) { color: red; }
|}];
