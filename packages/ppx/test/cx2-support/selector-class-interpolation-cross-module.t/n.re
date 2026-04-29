/* Module N references M.marker in a [%cx2] selector. The PPX cannot
   resolve M's class string (M compiles separately), so it embeds a
   sentinel and lets the aggregator substitute the real class. */
let container = [%cx2 {|
  background: red;

  &.$(M.marker) {
    background: blue;
  }
|}];
