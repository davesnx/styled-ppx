/* Probe: edge cases of selector interpolation in styled.global.
      - Bare $(name) (no leading dot) in type selector position
      - Class interp inside :not(...)
      - Two references in one compound (.$(a).$(b))
      - Combined with value interpolation
      - Nested style rules with interpolated selector
   */

let card = [%css "padding: 10px;"];
let active = [%css "border: 1px solid;"];
let bg = CSS.red;

module CardGlobals = [%styled.global
  {|
  /* Inside :not */
  body:not(.$(card)) {
    margin: 0;
  }

  /* Combined: selector interp + value interp */
  .$(card) {
    background: $(bg);
  }

  /* Two references in one compound: both classes on one element */
  .$(active).$(card) {
    color: white;
  }

  /* Nested rule, selector has interp, value too */
  .container {
    .$(card) {
      color: $(bg);
    }
  }
|}
];
