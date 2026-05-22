/* The selector chains a same-module ref `localFlag` and a cross-module ref
   `M.marker`. Same-module refs resolve at PPX time into the rendered CSS
   string; cross-module refs become sentinels that the aggregator
   substitutes at link time. */

let localFlag = [%css {||}];

let container = [%css
  {|
  &.$(localFlag).$(M.marker) {
    color: blue;
  }
|}
];
