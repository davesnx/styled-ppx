/* `&` at the top of a top-level at-rule block is equally parentless:
   @media contributes a condition, not a selector. This shape used to
   slip past the top-level-only check and ship literal `&:hover` inside
   the extracted @media block. */

module BrokenInMedia = [%styled.global
  {|
  @media print {
    &:hover {
      color: red;
    }
  }
|}
];
