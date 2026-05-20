/* Selector interpolation inside an @media at-rule.

   The recursive walk in transform_rule must descend into the at-rule
   body and rewrite `.$(card)` to the resolved class chain there too.
   Mirrors `reason-styled-global2-at-rule-interpolation.t` but for
   selector interp instead of value interp. */

let card = [%cx2 "padding: 8px;"];

module ResponsiveGlobals = [%styled.global2 {|
  .$(card) {
    color: black;
  }

  @media (max-width: 640px) {
    .$(card) {
      color: gray;
    }
  }
|}];
