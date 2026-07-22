/* Known gap: the calc() grammar has no resolution units, so calc() inside
   <resolution> is rejected by the structural media-query-list grammar
   before feature-value validation. It must error gracefully, not crash. */
let resolution_calc = [%css
  {|
  @media (min-resolution: calc(2 * 1dppx)) {
    color: red;
  }
|}
];
