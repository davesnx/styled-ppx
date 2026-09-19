/* A nested rule's prelude starting with a bare combinator (`> .a`) means
   `& > .a` (see the `nested-relative-selectors.t` css-support test). Like a
   literal `&`, that implicit `&` has no parent selector to resolve against
   here: @media contributes a condition, not a selector, and there is no
   enclosing style rule either. This must be rejected the same way a
   parentless `&` is, not shipped as literal unresolved `&` in the extracted
   stylesheet. */

module BrokenInMedia = [%styled.global
  {|
  @media print {
    > .a {
      color: red;
    }
  }
|}
];
