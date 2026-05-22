/* Same-module class-name interpolation in [%css] selectors must resolve to
   the actual minted class names at extraction time. No literal `$(name)`
   text should appear in the extracted CSS, and the runtime `CSS.make` call
   should not carry a phantom `--var-XXX: <className>` entry for the
   selector reference. */

let foo = [%css {| color: red; |}];

let bar = [%css {|
  &.$(foo) { color: blue; }
|}];

/* Bug-report repro: `:not(&.$(other))` exception clauses must resolve. */
let buttonLoadingAnimation = [%css
  {|
  background-size: 1rem 1rem;
  animation-duration: 1000ms;
|}
];

let colorAccent = [%css
  {|
  background-color: blue;

  &:disabled:not(&.$(buttonLoadingAnimation)) {
    background-color: gray;
  }
|}
];

let _ = (foo, bar, buttonLoadingAnimation, colorAccent);
