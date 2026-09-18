/* system only accepts the css-counter-styles-3 algorithm keywords (with
   optional arguments for fixed/extends): a number must be rejected at
   compile time. */

module Broken = [%styled.global
  {|
  @counter-style broken {
    system: 42;
  }
|}
];
