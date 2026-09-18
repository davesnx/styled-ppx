/* css-counter-styles-3 @counter-style descriptors (issue #584): system,
   symbols, negative, range, pad, fallback, prefix, suffix,
   additive-symbols and speak-as validate at compile time inside
   [%styled.global]; list-style-type accepts the custom ident naming the
   style. */

module Counters = [%styled.global
  {|
  @counter-style thumbs {
    system: cyclic;
    symbols: "+" url(one.svg) alpha;
    negative: "(" ")";
    range: 1 10, 20 infinite;
    pad: 3 "0";
    fallback: lower-alpha;
    prefix: ">";
    suffix: ". ";
    speak-as: bubbles;
  }

  @counter-style dice {
    system: additive;
    additive-symbols: 6 "F", 5 "E", 1 "A";
    system: extends decimal;
  }

  @counter-style fixed-start {
    system: fixed 3;
    symbols: one two three;
    range: auto;
  }
|}
];

let styled = [%css "list-style-type: thumbs"];

let _ = (Counters.make, styled);
